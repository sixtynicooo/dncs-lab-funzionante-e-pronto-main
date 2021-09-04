#!/bin/bash -x

# -This script checks if network components are connected
# - Turn on the machines
# - Test reachability
# - Check the availability of the web server


BOLD=$(tput bold)
NORMAL=$(tput sgr0)

#Echo the command, then run it
exe() { echo "\$$BOLD $@ $NORMAL" ; "$@" ; }


echo "--------- Start (or provision) the machines"
exe vagrant up

echo "--------- Testing if they are all running"

if [ `vagrant status |grep running |wc -l` -ne 6 ]; then
   echo "At least one machine is not running! " 1>&2
   echo "Exiting" 1>&2
   exit 1
fi

echo "All the machines are up !"

echo "--------- Test reachability between all hosts"

ping_test()
{
   exe vagrant ssh $1 -c "ping $3 -c 1" | tee test.out
   grep " 0% packet loss" test.out > /dev/null
   if [ $? -eq 0 ]; then
     echo ">>>>>>>>> $BOLD $1 $2  -> OK $NORMAL"
   else
     echo ">>>>>>>>> $BOLD $1 $2  -> ERROR  $NORMAL"
   fi
}

ping_test "host-a" "host-b" "12.0.1.2"
ping_test "host-a" "host-c" "13.0.1.34"
ping_test "host-b" "host-a" "11.1.0.2"
ping_test "host-b" "host-c" "13.0.1.34"
ping_test "host-c" "host-a" "11.1.0.2"
ping_test "host-c" "host-b" "12.0.1.2"

echo "--------- Test webserver availability"

web_test()
{
  exe vagrant ssh $1 -c "curl 13.0.1.34" |tee test.out
  grep "page open" test.out > /dev/null
  if [ $? -eq 0 ]; then
    echo ">>>>>>>>> $BOLD $1 -> OK $NORMAL"
  else
    echo ">>>>>>>>> $BOLD $1 -> ERROR  $NORMAL"
  fi
}

web_test "host-a"
web_test "host-b"
web_test "host-c"

rm test.out

echo "--------- End script"