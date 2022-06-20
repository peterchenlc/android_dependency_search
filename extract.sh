start=$(date +%s)

workingDir=dependencyLibraryFiles

#delete old directory
echo "deleting old working directory..."
rm -rf $workingDir

#make new working directory
mkdir $workingDir

#enter working directory
cd $workingDir

#find all jar files and aar files in path: ~/.gradle/caches/modules-2/files-2.1, and extract all files
echo "extracting files..."
gradlePath=~/.gradle/caches/modules-2/files-2.1
i=1
for k in $(find $gradlePath -type f \( -name "*.jar" -o -name "*.aar" \))
do
	mkdir $i
	cd $i
	if [[ $k == *.jar ]]; then
		jar xfv $k
	elif [[ $k == *.aar ]]; then
		unzip $k
		jar xfv classes.jar
	fi
	((i++))
	cd ..
done

time=$(date +%s) - $start
if [[ $time -gt 60 ]]; then
	echo "It takes $(($time / 60)) minutes $(($time % 60)) seconds to extract all files."
else
	echo "It takes $time seconds to extract all files."
fi
