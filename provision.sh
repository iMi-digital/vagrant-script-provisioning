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
	ProvisionState=000
	echo "$ProvisionState" > "$ProvisionStateFile"
fi


####################
# Export variables #
####################

#export ProvisionState


################################
# Execute provisioning scripts #
################################

for f in $SharedFolder/scripts.d/*.sh
do
	ScriptFile=$f
	CurrentProvisionState=`basename $ScriptFile .sh`
	if [ $ProvisionState -lt $CurrentProvisionState ];
	then
		$f
		ProvisionState=$CurrentProvisionState
		echo "$ProvisionState" > "$ProvisionStateFile"
	fi
done