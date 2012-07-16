MACHINES=("memling" "dali" "banksy")
ROOT="/data/ssh-imagenet-timingTest"
BIN="$ROOT/bin"
DATA="$ROOT/data"
RUNNING="$ROOT/running"
IMAGES="$DATA/image-net-1000000.seq"
FEATURES="$DATA/features.image-net-1000000.seq"
LOCALRUN="$BIN/launchLocal.sh"

ssh seurat "rm -rf $FEATURES"
ssh seurat "mkdir -p $FEATURES"
ssh seurat "mkdir -p $RUNNING"
echo "cleaned up, launching jobs"
nmachines=${#MACHINES[@]}

nimages=1000000
imagespermachine=$(($nimages/$nmachines))

# for (( i = 0; i < $nimages-1; i+=$imagespermachine )); do
for (( i = 0; i < $nmachines; i++ )); do
	# ssh remoteshot '/tmp/script.sh </dev/null >nohup.out 2>&1 &'
	# echo "ssh ${MACHINES[$i]} \"nohup $LOCALRUN $(($i * $imagespermachine)) $((($i+1)*$imagespermachine)) </dev/null >nohup.out 2>&1 &\""
	ssh ${MACHINES[$i]} "nohup $LOCALRUN $(($i * $imagespermachine)) $((($i+1)*$imagespermachine)) </dev/null >nohup.out 2>&1 &"
done

echo "Launched! timing completetion!"
PID=()
for (( i = 0; i < $nmachines; i++ )); do
	# ssh ${MACHINES[$i]} "echo kill -9 `ps aux | grep launchLocal.sh | grep -v grep | cut -d\" \" -f 8`"
	PID[$i]=`ssh ${MACHINES[$i]} "ps -ef | grep launchLocal.sh | grep -v grep" | awk '{print $2}'`
done
# done