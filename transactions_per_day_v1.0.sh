#!/bin/bash
export LC_ALL=C;

declare pattern;

if (( $2==1 ));then { pattern='[0-9]{2}/[A-Za-z]{3}/[0-9]{4}'; } fi
#pattern='[0-9]{2}/[A-Za-z]{3}/[0-9]{4}'; # 22/Sep/2022
echo $pattern;
declare -i total;

cat $1/* > tmp_raw.txt;

total=$( wc -l tmp_raw.txt | cut -d ' ' -f 1);

echo -e "\n";
echo -e "Total Line Count : ${total}\n";

echo "******************Group by Method*****************"
declare -i postVal getVal optionVal headVal etcVa methodTotalVall getpostVal;

getVal=$(grep -a  'GET ' tmp_raw.txt | wc -l | cut -d ' ' -f 1);
postVal=$(grep -a 'POST ' tmp_raw.txt | wc -l | cut -d ' ' -f 1);
optionVal=$(grep -a 'OPTIONS ' tmp_raw.txt | wc -l | cut -d ' ' -f 1);
headVal=$(grep -a 'HEAD ' tmp_raw.txt | wc -l | cut -d ' ' -f 1);
etcVal=$(grep -va 'GET ' tmp_raw.txt | grep -va 'POST ' | grep -va 'OPTIONS '| grep -va 'HEAD ' | wc -l | cut -d ' ' -f 1);
methodTotalVal=$(( getVal + postVal + optionVal + headVal + etcVal ));
getpostVal=$(( getVal + postVal ));

echo -e "GET Methon Count : ${getVal}\n";
echo -e "POST Method Count : ${postVal}\n";
echo -e "OPTION Method Count : ${optionVal}\n";
echo -e "HEAD Method Count : ${headVal}\n";
echo -e "ETC Count : ${etcVal}\n";
echo -e "Method Total Count : ${methodTotalVal}\n";
echo -e "GET AND POST Method to Test Count : ${getpostVal}\n";

grep -ae 'GET' -ae 'POST' tmp_raw.txt > tmp_getpost.txt;

if (( total==methodTotalVal ));then echo "OK"; else echo "Not Mached"; fi

echo "**********Group by Dynamic & Statuc***************";
declare -i dynamicVal staticVal allticVal;

staticVal=$(cat tmp_getpost.txt | grep -ae '\.png' -ae '\.js' -ae '\.jpg' -ae '\.css' | wc -l | cut -d ' ' -f 1);
dynamicVal=$(cat tmp_getpost.txt | grep -va '\.png' | grep -va '\.js' | grep -va '\.jpg' | grep -va '\.css' | wc -l | cut -d ' ' -f 1);
allticVal=$(( dynamicVal + staticVal ));
echo -e "Static pages in GETPOST Count : ${staticVal}\n";
echo -e "Dynamic pages in GETPOST Count : ${dynamicVal}\n";

cat tmp_getpost.txt | grep -va '\.png' | grep -va '\.js' | grep -va '\.jpg' | grep -va '\.css'  >  tmp_getpost_dynamic.txt;

if (( $getpostVal == $allticVal ));then echo "OK"; else echo "Not Mached"; fi

echo "*********transaction count per day****************";
declare -i sumVal;

echo "Dynamic pages in GET AND POST";

cat tmp_getpost_dynamic.txt | awk -v pattern="$pattern" 'BEGIN{} { match($0,pattern) } {timeVal[substr($0,RSTART,11)]++;} END {for (key in timeVal) printf("%s : %d\n", key, timeVal[key]);}' | sort -k1 -t" " > tmp_TPH.txt

cat tmp_TPH.txt

sumVal=$(awk 'BEGIN{FS=" ";}{ sum += $3 } END { print sum }' tmp_TPH.txt);
echo -e "SUM : $sumVal\n";

if (( dynamicVal==sumVal ));then echo "OK"; else echo "Not Mached"; fi

#rm tmp_getpost.txt tmp_getpost_dynamic.txt tmp_TPH.txt;

