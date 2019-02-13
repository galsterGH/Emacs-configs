echo "downloading platinum search"
wget https://github.com/monochromegane/the_platinum_searcher/releases/download/v2.1.5/pt_linux_386.tar.gz
tar xf pt_linux_386.tar.gz
mv pt_linux_386/pt /usr/local/bin
echo $(which pt)
rm -rf pt_linux_386
rm -rf  pt_linux_386.tar.gz
