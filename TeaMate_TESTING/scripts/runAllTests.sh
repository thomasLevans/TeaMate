#!/bin/bash
####################################################################################
# FILENAME: runAllTests.sh                                                         #
# PROGRAMMER: Tom Evans                                                            #
# DESCRIPTION: This script will run all tests found in the testCases directory.    #
# Refer to README in docs directory on formatting your own testCases.  The script  #
# compiles all results in a .html file located in the reports directory.  When all #
# tests found are completed the report will be opened in the browser               #
# TO DO:                                                                           #
# eliminate the need for an array of testCase file names                           #
# address handling of absence of testCase files/driver not found/oracles           #
# start using the reportTemplate created in docs for generating the html document  #
####################################################################################


# clean temp directory and reports directory
echo "clearing old files..."
# echo "dirname $BASH_SOURCE"
rm -f -r ./temp/*.txt
rm -f -r ./reports/testReport.html

# get all the testCases file names as an array
files=(./testCases/*.txt)
echo "reading testCase Files..."

# for every testCase file in the array process the file
for file in "${files[@]}"; do
	index=0
	declare -a testDat
	# reads in lines from the testCase file
	# and stores each line in the array
	while read LINE
	do
		testDat[index]=$LINE
		let "index+=1"
	done < "$file"
	let "index+=1"

	javac -cp .:./project/martus-${testDat[2]}/bin/ -d ./project/martus-${testDat[2]}/bin/org/martus/${testDat[2]}/ ./project/martus-${testDat[2]}/source/org/martus/${testDat[2]}/${testDat[3]}.java
	javac -cp .:./project/martus-${testDat[2]}/bin/ ./testCasesExecutables/${testDat[5]}.java

	echo "running test ${testDat[0]}"
	tempOutput="$(java -cp .:./project/martus-${testDat[2]}/bin/:./testCasesExecutables/ ${testDat[5]} ${testDat[6]})"
	echo $tempOutput > ./temp/tempResults${testDat[0]}.txt

	if diff ./oracles/testOracle${testDat[0]}.txt ./temp/tempResults${testDat[0]}.txt; then
		testDat[index]="PASS"
	else
		testDat[index]="FAIL"
	fi
	testDat[7]=$tempOutput
	echo "creating tempResults${testDat[0]}.txt..."
	rm -f -r ./temp/tempResults${testDat[0]}.txt
	for elem in "${testDat[@]}"; do
		echo $elem >> ./temp/tempResults${testDat[0]}.txt
	done
done

echo "creating reportFile.html..."
files=(./temp/*.txt)
echo "<html><head><title>Test Report</title><h1>Test Report</h1><hr></head><body><table>" >> ./reports/testReport.html
echo "<tr><th>Test #</th><th>Requirement</th><th>Package</th><th>Class</th><th>Method</th><th>Driver</th><th>Input</th><th>Output</th><th>Result</th></tr>" >> ./reports/testReport.html
for file in "${files[@]}"; do
	echo "<tr>" >> ./reports/testReport.html
	while read line; do
		echo "<td align="right">$line</td>" >> ./reports/testReport.html
	done < "$file"
	echo "</tr>" >> ./reports/testReport.html
done
echo "</table></body></html>" >> ./reports/testReport.html
echo "opening reportFile.html..."
xdg-open ./reports/testReport.html
