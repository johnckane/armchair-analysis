#!/bin/bash

# This code used the following as a guide
# http://ericlondon.com/2011/04/10/a-bash-shell-script-to-import-a-large-number-of-csv-files-into-mysql.html



# show commands being executed, per debug
set -x 


# define database connectivity

_db="armchair_analysis"
_db_user="john"

# define directory containing csv files
_csv_directory="/home/john/projects/armchair-analysis/nfl_00-19"

# go into directory
cd $_csv_directory

# rename files to lowercase
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
    _header_columns=`head -1 $_csv_directory/$_csv_file | tr ',' '\n' | sed 's/^"//' | sed 's/"$//' | sed 's/ /_/g'`
    _header_columns_string=`head -1 $_csv_directory/$_csv_file | sed 's/ /_/g' | sed 's/"//g'`
    
    
    #If you need to delete all rows from all tables...
    
    mysql -u$_db_user $_db <<EOF
    delete from $_csv_file_extensionless;

    LOAD DATA LOCAL INFILE '$_csv_file' 
    INTO TABLE $_csv_file_extensionless 
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES ;
EOF

done
exit




## ./import.sh


