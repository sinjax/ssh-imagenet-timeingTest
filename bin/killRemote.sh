MACHINES=("memling" "dali" "banksy")
nmachines=${#MACHINES[@]}
for (( i = 0; i < $nmachines; i++ )); do
	# ssh ${MACHINES[$i]} "echo kill -9 `ps aux | grep launchLocal.sh | grep -v grep | cut -d\" \" -f 8`"
	TOKILL=`ssh ${MACHINES[$i]} "ps aux | grep launchLocal.sh | grep -v grep | cut -d\" \" -f 8"`
	if [[ -n $TOKILL ]]; then
		ssh ${MACHINES[$i]} "kill -9 $TOKILL"
	fi
done
