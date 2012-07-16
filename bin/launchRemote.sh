MACHINES=("memling" "dali" "banksy")
ROOT="/data/ssh-imagenet-timingTest"
BIN="$ROOT/bin"
DATA="$ROOT/data"
RUNNING="$ROOT/running"
IMAGES="$DATA/image-net-1000000.seq"
FEATURES="$DATA/features.image-net-1000000.seq"
LOCALRUN="$BIN/launchLocal.sh"

git commit -a -m "running remote commands"
git push origin master

ssh seurat "cd $ROOT && git pull origin master"
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
while [[ "$(ssh seurat ls $RUNNING)" ]]; do
	echo "Not completed!"
done

echo "done!"


# done