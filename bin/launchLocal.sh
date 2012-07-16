DATA="/data/ssh-imagenet-timingTest/data"
IMAGES="$DATA/image-net-1000000.seq"
FEATURES="$DATA/features.image-net-1000000.seq"
JAVA_JAR="bin/LocalFeaturesTool.jar"
JAVA="java -Xmx2G -jar $JAVA_JAR -m SIFT"

echo "MACHINE RUNNING FROM $1 to $2"
for (( i = $1; i < $2; i++ )); do
	echo $JAVA -i $IMAGES/$i -o $FEATURES/$i > $DATA/`hostname`.lastcmd
	# touch $FEATURES/$i
done