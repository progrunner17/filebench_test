#!/bin/bash
set -eu -o pipefail

bench_list=$(echo workloads/singlestream{read,write}{,direct}.f workloads/random{rw,read,write}.f)
# bench_list=$(find $PWD/workloads -name "*.f" | grep -v "micro" | sort)

# if !(mount | grep $PWD/mnt > /dev/null ); then
# sudo mount /dev/sda $PWD/mnt
# fi
sudo chmod 777 $PWD/mnt

# pref=log-$(date "+%Y-%m-%d-%H-%M-%S")
pref=log-$(date "+%s")
mkdir $pref

for bench in $bench_list
do
  sudo rm -rf $PWD/mnt/*
  # /set/s@nthreads=.*$/nthreads=4/;
  sed -E '/set.*/s@dir=.*@dir='"$PWD"'/mnt@;  /^(usage|echo)/d' $bench > tmp.f
#   sed -i -E '/set/s@iosize=.*$@iosize=10m@' tmp.f
  echo "run 10" >> tmp.f
  bench=$(basename ${bench%%f}log)
  echo ${bench%%.log}
   for i in $(seq 10)
   do
     echo ${bench%%.log} $i
     sudo filebench -f tmp.f > tmp.log
     cat tmp.log >> $pref/${bench}
   done
done

# if !(mount | grep $PWD/mnt > /dev/null ); then
# sudo umount $PWD/mnt
# fi
