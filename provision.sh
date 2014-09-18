#!/bin/bash


#######################
# Set local variables #
#######################

ProvisionStateFile=/home/vagrant/provisionstate.txt
SharedFolder=/vagrant


########################################################################
# Read current provisioning state from file and set variable to result #
########################################################################

if [ -f $ProvisionStateFile ]
then
	ProvisionState=`cat $ProvisionStateFile`
else
	ProvisionState=0000
	echo "$ProvisionState" > "$ProvisionStateFile"
fi


####################
# Export variables #
####################

#export ProvisionState

echo "Last state: $ProvisionState"


################################
# Execute provisioning scripts #
################################

set -e # break on errors!

for f in $SharedFolder/vagrant/provision.d/*.sh
do
	ScriptFile=$f
	CurrentProvisionState=`basename $ScriptFile .sh`
	if [ "$ProvisionState" \< "$CurrentProvisionState" ];
	then
	    echo "######## provision.sh EXECUTE: $f ########"
		$f
		ProvisionState=$CurrentProvisionState
		echo "$ProvisionState" > "$ProvisionStateFile"
	fi
done

ProvisionState=`cat $ProvisionStateFile`

echo "### Provisioning finished successfully. ### New state: $ProvisionState"
