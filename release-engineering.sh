#! /bin/bash

VERSION=$1

# commit & push

FILE=`pwd`/`git rev-parse --show-cdup`/noahstrap
sed -i "" "s/our \$VERSION.*/our \$VERSION = \"$VERSION\";/" $FILE

git add $FILE

while true; do
    read -p "commit and push? (type 'd' to show the changes) [y/n/d]" answer
    case $answer in
        "y") break;;
        "n") exit 1;;
        "d") git diff --cached
    esac
done

git commit -m "version $VERSION"
git push origin master

git tag $VERSION
git push origin --tags

echo successfully pushed noahstrap $VERSION

# publish homebrew

URL=https://github.com/linux-noah/noahstrap/archive/$VERSION.tar.gz

echo url: $URL

curl -LO $URL
SHA256=`shasum -a 256 $VERSION.tar.gz | cut -d ' ' -f 1`
rm $VERSION.tar.gz

echo sha256: $SHA256

if [[ -d homebrew-noah ]]; then
    cd homebrew-noah
    git reset --hard
    git pull
else
    git clone git@github.com:linux-noah/homebrew-noah.git
    cd homebrew-noah
fi

sed -i "" -e "8 s@.*@  url \"$URL\"@g" noahstrap.rb
sed -i "" -e "9 s@.*@  version \"$VERSION\"@g" noahstrap.rb
sed -i "" -e "10 s@.*@  sha256 \"$SHA256\"@g" noahstrap.rb

git add noahstrap.rb
git commit -m "noahstrap $VERSION"
git push origin master

cd ..
rm -rf homebrew-noah

echo successfully published noahstrap $VERSION

while true; do
    read -p "upgrade noahstrap on your system? [y/n]" answer
    case $answer in
        "y") break;;
        "n") exit 0;;
    esac
done

brew update
brew upgrade noahstrap

echo successfully upgraded noahstrap on your system
