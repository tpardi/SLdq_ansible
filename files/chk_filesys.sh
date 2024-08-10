#!/usr/bin/ksh

## 3/20/24 TJP - changed lspath test
##df -g |egrep "9[4-7]%|100%"
export PATH=$PATH:/SYSADM/scripts
## Missing Filesystems ##
#for FSYS in $(/SYSADM/scripts/dba/check_mount.sh $i `lsfs -c $i |grep -v '#' |awk -F: {'print $3'}`|grep CRITICAL)
rm `hostname`.filesystems
## Get filesystems from /etc/filesystems eg /opt/IBM/JazzSM
for i in $(lsfs -c|awk -F: {'print $1'}|grep -v '#')
do
DSKSPC=`df -gc $i |egrep "9[2-9]%|100%" |awk -F: {'print $7" is "$4" Full with only "$3"GB left, increase "$1'}`
                if [[ $DSKSPC != '' ]]
                then
		echo "Checking diskspace ...\n" >>`hostname`.filesystems
                echo "**** WARNING CHECK DISK SPACE $i !! *****\n" >>`hostname`.filesystems
                echo $DSKSPC"\n" >>`hostname`.filesystems
                fi

FSTYP=`lsfs -c $i |grep -v '#' |awk -F: {'print $3'}`
STRING=`check_mount.sh $i $FSTYP`

        if [[ "$STRING" = *+(CRITICAL)* ]]
           then
	   echo "Checking mount points ...\n" >>`hostname`.filesystems
           echo $STRING"\n" >>`hostname`.filesystems
	fi
done

## Enable paths
#lspath | awk '{print "chpath -s enable -l " $2 " -p " $3 }' | ksh
PSTAT=$(lspath |grep -e Failed -e Miss |wc -l)
if [[ $PSTAT -ne 0 ]]
then
echo "Fixing paths!!" >>/SYSADM/scripts/`hostname`.filesystems.pathlog
lspath | awk '{print "chpath -s enable -l " $2 " -p " $3 }' | ksh
else
echo "We all good ;-)"
fi

if [ -s `hostname`.filesystems  ]
then
cat `hostname`.filesystems |mailx -s "`hostname`.filesystems" -r NIXadmin@DQ.ad DL-UnixAdmin@greatdentalplans.com DL-OracleAdmin@greatdentalplans.com
fi
