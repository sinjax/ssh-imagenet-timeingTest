MACHINES=("memling" "dali" "banksy")
ROOT="/data/ssh-imagenet-timingTest"
BIN="$ROOT/bin"
DATA="$ROOT/data"
nmachines=${#MACHINES[@]}
for (( i = 0; i < $nmachines; i++ )); do
	# ssh ${MACHINES[$i]} "echo kill -9 `ps aux | grep launchLocal.sh | grep -v grep | cut -d\" \" -f 8`"
	TOKILL=`ssh ${MACHINES[$i]} "ps -ef | grep launchLocal.sh | grep -v grep" | awk '{print $2}'`
	if [[ -n $TOKILL ]]; then
		echo $TOKILL
		ssh ${MACHINES[$i]} "kill -9 $TOKILL"
		ssh ${MACHINES[$i]} "rm -rf $DATA/running/${MACHINES[$i]}*"
	fi
done
