#!/bin/bash
# Want to build something that will take the colnames of each file in a folder, and compare to last year's version

thisyear_path='/home/john/projects/armchair-analysis/nfl_00-19/'
lastyear_path='/home/john/projects/armchair-analysis/nfl_00-18/'


cd $thisyear_path
for i in $( ls | grep [A-Z] ); do mv -i $i `echo $i | tr 'A-Z' 'a-z'`; done
# get a list of CSV files in directory
_csv_files=`ls *.csv`

# loop through csv files

for _csv_file in ${_csv_files}
do  
    # remove file extension
    _csv_file_extensionless=`echo $_csv_file | sed 's/\(.*\)\..*/\1/'`
    # define table name
    _table_name="${_csv_file_extensionless}"
    
    # get header columns from CSV file
    _header_columns_new=`head -1 $_csv_file | tr ',' '\n' | sed 's/^"//' | sed 's/"$//' | sed 's/ /_/g'`
    #_header_columns_new_string=`head -1 $_csv_file | sed 's/ /_/g' | sed 's/"//g'`
    #echo $_header_columns_new_string
    # get header columns from last year's directory
    #cd $lastyear_path
    _header_columns_old=`head -1 $_csv_file | tr ',' '\n' | sed 's/^"//' | sed 's/"$//' | sed 's/ /_/g'`
    #_header_columns_old_string=`head -1 $_csv_file | sed 's/ /_/g' | sed 's/"//g'`

    if [ "${_header_columns_new}" = "${_header_columns_old}" ]; 
    then
        echo "$_csv_file the same"
    else
        echo "$_csv_file different"
    fi
done
exit