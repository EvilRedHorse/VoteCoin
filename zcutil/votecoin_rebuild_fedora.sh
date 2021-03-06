#!/usr/bin/bash --posix

### function to print multiple blank lines
function lines { yes '' | sed ${1}q ; }

cd "$(dirname "$(readlink -f "$0")")"    #'"%#@!

lines 1
printf "git pull started..."
lines 1
cd ../
git pull
printf "git pull complete."
cd zcutil
lines 2

./build.sh --disable-tests -j$(nproc)

cd ../src/
strip --strip-unneeded zcash-cli
strip --strip-unneeded zcash-tx
strip --strip-unneeded zcashd

cp -f zcash-cli votecoin-cli
cp -f zcash-tx votecoin-tx
cp -f zcashd votecoind

lines 1
printf "Compilation rebuild complete. Now you can run ../src/votecoind to start the daemon."
lines 1
printf "It will use configuration file from ~/.votecoin/votecoin.conf"
lines 2
