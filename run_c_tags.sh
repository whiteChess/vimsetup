DIR="$HOME/git_tree"
echo "Start generating ctags"
cd $DIR
rm -rf $DIR/tags
/usr/local/bin/ctags --languages=perl  --extra=+q --exclude=*.pl --exclude=*.log -f $DIR/tags.new -R  $DIR/main/lib $DIR/main/webservice/bpayprocessor
mv $DIR/tags.new $DIR/tags
