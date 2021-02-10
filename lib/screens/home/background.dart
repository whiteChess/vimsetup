import 'package:flutter/material.dart';
import 'package:prayer_times/screens/home/sky_painter.dart';

class Background extends StatefulWidget {
  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>
    with SingleTickerProviderStateMixin {
  int currentTimeInSeconds = 0;
  String nextPrayerName = "Fajer";
  String remainingTime = "";
  AnimationController animationController;
  Animation animation;
  SkyBuilder skyBuilder;

  String getNextPrayerName(int currentTimeInSeconds) {
    List<int> prayerTimesInSeconds = SkyBuilder.prayerTimesInSeconds;
    if (currentTimeInSeconds < prayerTimesInSeconds[2]) {
      return "Fajr";
    } else if (currentTimeInSeconds < prayerTimesInSeconds[3]) {
      return "Duhr";
    } else if (currentTimeInSeconds < prayerTimesInSeconds[4]) {
      return "Aser";
    } else if (currentTimeInSeconds < prayerTimesInSeconds[5]) {
      return "Maghrib";
    } else if (currentTimeInSeconds < prayerTimesInSeconds[6]) {
      return "Isha";
    } else {
      return "Fajr";
    }
  }

  String getNextPrayerRemainingTime(int currentTimeInSeconds) {
    List<int> prayerTimesInSeconds = SkyBuilder.prayerTimesInSeconds;
    if (currentTimeInSeconds < prayerTimesInSeconds[2]) {
      return getTimeFromDuration(
          Duration(seconds: prayerTimesInSeconds[2] - currentTimeInSeconds));
    } else if (currentTimeInSeconds < prayerTimesInSeconds[3]) {
      return getTimeFromDuration(
          Duration(seconds: prayerTimesInSeconds[3] - currentTimeInSeconds));
    } else if (currentTimeInSeconds < prayerTimesInSeconds[4]) {
      return getTimeFromDuration(
          Duration(seconds: prayerTimesInSeconds[4] - currentTimeInSeconds));
    } else if (currentTimeInSeconds < prayerTimesInSeconds[5]) {
      return getTimeFromDuration(
          Duration(seconds: prayerTimesInSeconds[5] - currentTimeInSeconds));
    } else if (currentTimeInSeconds < prayerTimesInSeconds[6]) {
      return getTimeFromDuration(
          Duration(seconds: prayerTimesInSeconds[6] - currentTimeInSeconds));
    } else {
      return getTimeFromDuration(Duration(
          seconds: prayerTimesInSeconds[1] +
              (prayerTimesInSeconds[7] - currentTimeInSeconds)));
    }
  }

  String getTimeFromDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String getNextPrayerTime(int currentTimeInSeconds) {
    List<int> prayerTimesInSeconds = SkyBuilder.prayerTimesInSeconds;
    if (currentTimeInSeconds < prayerTimesInSeconds[2]) {
      return getTimeFromDuration(Duration(seconds: prayerTimesInSeconds[2]));
    } else if (currentTimeInSeconds < prayerTimesInSeconds[3]) {
      return getTimeFromDuration(Duration(seconds: prayerTimesInSeconds[3]));
    } else if (currentTimeInSeconds < prayerTimesInSeconds[4]) {
      return getTimeFromDuration(Duration(seconds: prayerTimesInSeconds[4]));
    } else if (currentTimeInSeconds < prayerTimesInSeconds[5]) {
      return getTimeFromDuration(Duration(seconds: prayerTimesInSeconds[5]));
    } else if (currentTimeInSeconds < prayerTimesInSeconds[6]) {
      return getTimeFromDuration(Duration(seconds: prayerTimesInSeconds[6]));
    } else {
      return getTimeFromDuration(Duration(seconds: prayerTimesInSeconds[2]));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 24 * 60 * 60.0)
        .animate(animationController);
    animation.addListener(() {
      setState(() {
        currentTimeInSeconds = (animation.value as double).toInt();
        nextPrayerName = getNextPrayerName(currentTimeInSeconds);
        remainingTime = getNextPrayerRemainingTime(currentTimeInSeconds);
      });
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();

    skyBuilder = new SkyBuilder();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double skyWidth = width;
    double skyHeight = height * 0.48;
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
          ),
          skyBuilder.build(skyWidth, skyHeight, currentTimeInSeconds),
          // child: Image.asset(
          //   "assets/images/sun.png",
          //   width: 100,
          //   height: 100,
          //   fit: BoxFit.fitWidth,
          // ),
          Container(
            alignment: Alignment.bottomCenter,
            constraints: BoxConstraints.expand(),
            child: Image.asset("assets/images/road_mountain.png"),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            constraints: BoxConstraints.expand(),
            // child: Slider(
            //   value: currentTimeInSeconds,
            //   min: 0,
            //   max: 24 * 60 * 60.0,
            //   onChanged: (value) {
            //     setState(() {
            //       currentTimeInSeconds = value;
            //     });
            //   },
            // ),
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          nextPrayerName,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      Text(
                        getNextPrayerTime(currentTimeInSeconds),
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                    child: Text(
                      remainingTime,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
