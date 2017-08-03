DIR="$HOME/work"
echo "Start generating ctags"
cd $DIR
rm -rf $DIR/tags
/usr/local/bin/ctags --languages=perl  --exclude=*.pl --exclude=*.log -f $DIR/tags.new -R $DIR/main/lib
/usr/local/bin/ctags --languages=perl  --exclude=*.pl --exclude=*.log -f $DIR/tags.new -R $DIR/main/apps/bookings2
mv $DIR/tags.new $DIR/tags
