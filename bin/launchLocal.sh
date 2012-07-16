ROOT="/data/ssh-imagenet-timingTest"
BIN="$ROOT/bin"
DATA="$ROOT/data"
RUNNING="$ROOT/running"
IMAGES="$DATA/image-net-1000000.seq"
FEATURES="$DATA/features.image-net-1000000.seq"
# JAVA_JAR="$BIN/LocalFeaturesTool.jar"
# JAVA="java -Xmx2G -jar $JAVA_JAR -m SIFT"
JAVA_BIN="$BIN"
TOOL_NAME="$JAVA_BIN/LocalFeaturesTool.jar"
PARA_NAME="$JAVA_BIN/GlobalFeaturesTool.jar"
PARA_IN_NAME="$IMAGES"
PARA_OUT_NAME="$FEATURES"

JAVA_BIT="java -Xmx8g -cp $TOOL_NAME:$PARA_NAME org.openimaj.tools.globalfeature.ParallelExecutor"
PARA_BIT="-c org.openimaj.tools.localfeature.LocalFeaturesTool -j 16 -e .sift -f -a"
TOOL_BIT="-i __IN__ -o __OUT__"


echo "MACHINE RUNNING FROM $1 to $2"
echo "running" > $RUNNING/`hostname`
for (( i = $1; i < $2; i++ )); do
	# echo $JAVA -i $IMAGES/$i -o $FEATURES/$i > $DATA/`hostname`.lastcmd
	# $JAVA -i $IMAGES/$i -o $FEATURES/$i
	$JAVA_BIT $PARA_BIT "$TOOL_BIT" -i $IMAGES -o $FEATURES
	echo $JAVA_BIT $PARA_BIT \"$TOOL_BIT\" -i $IMAGES -o $FEATURES > $DATA/`hostname`.lastcmd
	# touch $FEATURES/$i
done
rm -rf $RUNNING/`hostname`