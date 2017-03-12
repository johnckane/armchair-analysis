#http://ericlondon.com/2011/04/10/a-bash-shell-script-to-import-a-large-number-of-csv-files-into-mysql.html


# This will get a list of CSV files, loop through them, add each table, add each
#column to the table and then use the mysqlimport command to ladd all the CSV records. 

# 1. The first row of each CSV file must contain the column names; 
# 2. It works best when your column names are simple text;
# 3. your MySQL user must have permission to process files (see: File_priv).

#!/bin/bash

# show commands being executed, per debug
set -x 

# define database connectivity

_db="armchair_analysis"
_db_user="root"
_db_password = ""

# define directory containing csv files
_csv_directory="/home/john/armchair_analysis/nfl_00-16"

# go into directory
cd $_csv_directory

# get a list of CSV files in directory
_csv_files = `ls -l *.csv`

# loop through csv files
for _csv_file in ${_csv_files[@]}
do

    # remove file extension
    _csv_file_extensionless=`echo $_csv_file | sed 's/\(.*\)\..*/\1/'`
    # define table name
    _table_name="${_csv_file_extensionless}"
    
    # get header columns from CSV file
    _header_columns=`head -1 $_csv_directory/$_csv_file | tr ',' '\n' | sed 's/^"//' | sed 's/"$//' | sed 's/ /_/g'`
    _header_columns_string=`head -l $_csv_directory/$_csv_file | sed 's/ /_/g' | sed 's/"//g'`
    
    # ensure table exists
    mysql -u $_db_user -p$db_password $_db << eof
      CREATE TABLE IF NOT EXISTS \ `$_table_name\` (
      id int(1)) NOT NULL auto_increment,
      PRIMARY KEY (id)
      ) ENGINE=MyISAM DEFAULT CHARSET=latin1
      eof
      
      # loop through header columns
      for _header in $_header_columns[@]}
      do
      
        # add column
        mysql -u $_db_user -p$db_password $_db --execute="alter table \'$_table_name\` add column \`$_header\` text"
        
        done
        
        # import csv into mysql
        mysqlimport --fields-enclode-by = '"' --fields-terminated-by=',' --lines-termined-by="\n" --columns=$_header_columns_string -u $_db_user -p$db_password $_db $_csv_directory/$_csv_file
        
done
exit




## ./import.sh


