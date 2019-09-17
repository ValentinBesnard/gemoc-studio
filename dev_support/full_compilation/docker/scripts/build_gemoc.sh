#!/bin/bash

echo arguments seen: $1

Xvfb :99 &
export DISPLAY=:99

#$HOME/.vnc/xstartup.sh

cd $HOME/src/gemoc-studio

pwd

if [ -z "$1" ]
then
	echo "---------- compile full gemoc studio (clean verify) -----------"
	mvn -f $HOME/src/gemoc-studio/dev_support/full_compilation/pom.xml clean verify --errors  --show-version
else
	case $1 in
	"full") 
		echo "-------- compile full gemoc studio (and install in .m2) --------"
		mvn -f $HOME/src/gemoc-studio/dev_support/full_compilation/pom.xml clean install --errors  --show-version;;
	"linux") 
		echo "-------- compile gemoc studio for linux only in online (install in .m2) --------"
		mvn -P test_linux -f $HOME/src/gemoc-studio/dev_support/full_compilation/pom.xml clean install --errors  --show-version;;
	"linux_offline") 
		echo "-------- compile gemoc studio for linux only (offline) (install in .m2) --------"
		mvn -o -P test_linux -f $HOME/src/gemoc-studio/dev_support/full_compilation/pom.xml clean install --errors  --show-version;;
	"system_test_only") 
		echo "-------- running system tests only ------------"
		mvn -f $HOME/src/gemoc-studio/gemoc_studio/tests/org.eclipse.gemoc.studio.tests.system.lwb/ clean verify --errors  --show-version
		mvn -f $HOME/src/gemoc-studio/gemoc_studio/tests/org.eclipse.gemoc.studio.tests.system.mwb/ clean verify --errors  --show-version;;
	*)		
		echo "command $1 not recognized, possible arguments: system_test_only, full, linux_offline" ;;
	esac
fi
# set owner to default system user
#chown 1000:1000 -R /root/src/gemoc-studio
#chown 1000:1000 -R /root/src/gemoc-studio-execution-ale
#chown 1000:1000 -R /root/src/gemoc-studio-execution-moccml
#chown 1000:1000 -R /root/src/gemoc-studio-moccml
#chown 1000:1000 -R /root/src/gemoc-studio-modeldebugging
