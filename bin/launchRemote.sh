LOCALRUN="`pwd`/bin/launchLocal.sh"
MACHINES=("memling" "dali" "banksy")
nmachines=${#MACHINES[@]}

nimages=1000000
imagespermachine=$(($nimages/$nmachines))

# for (( i = 0; i < $nimages-1; i+=$imagespermachine )); do
for (( i = 0; i < $nmachines; i++ )); do
	# ssh remoteshot '/tmp/script.sh </dev/null >nohup.out 2>&1 &'
	echo ssh ${MACHINES[$i]} \"nohup $LOCALRUN $(($i * $imagespermachine)) $((($i+1)*$imagespermachine)) </dev/null >nohup.out 2>&1 &\"
done
	
# done