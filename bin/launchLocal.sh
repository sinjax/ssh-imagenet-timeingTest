DATA="/data/ssh-imagenet-timingTest/data"
IMAGES="$DATA/image-net-1000000.seq"
FEATURES="$DATA/features.image-net-1000000.seq"
JAVA_JAR="bin/LocalFeaturesTool.jar"
JAVA="java -jar $JAVA_JAR -m SIFT -rm"

echo "MACHINE RUNNING FROM $1 to $2"
for (( i = $1; i < $2; i++ )); do
	$JAVA -i $IMAGES/$i -i $FEATURES/$i
	# touch $FEATURES/$i
done