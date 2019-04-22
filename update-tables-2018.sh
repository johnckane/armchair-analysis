#!/bin/bash

# show commands being executed, per debug
set -x 

# define database connectivity

_db='armchair_analysis'
_db_user='root'
echo "Enter your password"
read _db_password


mysql -u $_db_user -p$_db_password $_db <<EOF

# These all ran the first time...don't run again.

ALTER TABLE play
ADD COLUMN tck bool,
ADD COLUMN sk bool,
ADD COLUMN pen bool,
ADD COLUMN ints bool,
ADD COLUMN fum bool,
ADD COLUMN saf bool,
ADD COLUMN blk bool;

ALTER TABLE defense
ADD COLUMN nflid int;

ALTER TABLE offense
ADD COLUMN nflid int;

ALTER TABLE block
ADD COLUMN type varchar(4);



CREATE TABLE IF NOT EXISTS injury(
   uid int
,   gid int
,   player varchar(7)
,   team varchar(3)
,   details varchar(16)
,   pstat varchar(64)
,   gstat varchar(16)
,   primary key (uid)
);


DELETE FROM player;

ALTER TABLE player
ADD COLUMN nflid int,
CHANGE yob dob date;


ALTER TABLE team
ADD COLUMN saf int,
ADD COLUMN blk int,
ADD COLUMN fp int;


CREATE TABLE IF NOT EXISTS intercpt(
   pid int
,   psr varchar(7)
,   ints varchar(7)
,   iry int
,   primary key (pid) 
);


CREATE TABLE IF NOT EXISTS schedule(
    gid int
,   seas int 
,   wk int
,   day varchar(3)
,   date date
,   v varchar(3)
,   h varchar(3)
,   stad varchar(32)
,   surf varchar(16)
,   primary key (gid)
);

CREATE TABLE IF NOT EXISTS pbp(
    gid int
,   pid int
,   detail varchar(512)
,   off varchar(3)
,   def varchar(3)
,   type varchar(8)
,   dseq int
,   len int
,   qtr int
,   min int
,   sec int
,   ptso int
,   ptsd int
,   timo int
,   timd int
,   dwn int
,   ytg int
,   yfog int
,   zone int
,   yds int
,   succ varchar(1)
,   fd varchar(1)
,   sg varchar(1)
,   nh varchar(1)
,   pts int
,   bc varchar(7)
,   kne varchar(1)
,   dir varchar(8)
,   rtck1 varchar(7)
,   rtck2 varchar(7)
,   psr varchar(7)
,   comp varchar(1)
,   spk varchar(1)
,   loc varchar(3)
,   trg varchar(7)
,   dfb varchar(7)
,   ptck1 varchar(7)
,   ptck2 varchar(7)
,   sk1 varchar(7)
,   sk2 varchar(7)
,   ptm1 varchar(3)
,   pen1 varchar(7)
,   desc1 varchar(64)
,   cat1 int
,   pey1 int
,   act1 varchar(1)
,   ptm2 varchar(3)
,   pen2 varchar(7)
,   desc2 varchar(64)
,   cat2 int
,   pey2 int
,   act2 varchar(1)
,   ptm3 varchar(3)
,   pen3 varchar(7)
,   desc3 varchar(64)
,   cat3 int
,   pey3 int
,   act3 varchar(1)
,   ints varchar(7)
,   iry int
,   fum varchar(7)
,   frcv varchar(7)
,   fry int
,   forc varchar(7)
,   saf varchar(7)
,   blk varchar(7)
,   brcv varchar(7)
,   fgxp varchar(2)
,   fkicker varchar(7)
,   dist int
,   good bool
,   punter varchar(7)
,   pgro int
,   pnet int
,   ptb bool
,   pr varchar(7)
,   pry int
,   pfc bool
,   kicker varchar(7)
,   kgro int
,   knet int
,   ktb bool
,   kr varchar(7)
,   kry int);
EOF

 

# define directory containing csv files
_csv_directory="/home/john/armchair_analysis/nfl_00-17"

# rename all files to lowercase
find $_csv_directory -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;


# go into directory
cd $_csv_directory

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
    
mysql -u$_db_user -p$_db_password $_db <<EOF
delete from $_csv_file_extensionless;
#EOF
     
#mysql -u$_db_user -p$_db_password $_db <<EOF
LOAD DATA LOCAL INFILE '$_csv_file' 
INTO TABLE $_csv_file_extensionless 
FIELDS TERMINATED BY ','
IGNORE 1 LINES ;
EOF
done


# define user defined date directory and rename to lower case

_udd_csv_directory="/home/john/armchair_analysis/udd-format-00_17"

find $_udd_csv_directory -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;

# go into directory
cd $_udd_csv_directory

# load player

mysql -u$_db_user -p$_db_password $_db <<EOF
delete from player;
EOF
     
mysql -u$_db_user -p$_db_password $_db <<EOF
LOAD DATA LOCAL INFILE 'player.csv' 
INTO TABLE player
FIELDS TERMINATED BY ','
IGNORE 1 LINES 
( player 
,   fname
,   lname
,   pname 
,   pos1 
,   pos2 
,   height 
,   weight 
,   @dob
,   forty 
,   bench 
,   vertical 
,   broad 
,   shuttle 
,   cone 
,   arm 
,   hand 
,   dpos 
,   col 
,   dv 
,   start 
,   cteam 
,   posd 
,   jnum 
,   dcp
,   nflid )
set dob = STR_TO_DATE(@dob, '%m/%d/%Y');
EOF

# load schedule

mysql -u$_db_user -p$_db_password $_db <<EOF
delete from schedule;
EOF

mysql -u$_db_user -p$_db_password $_db <<EOF
LOAD DATA LOCAL INFILE 'schedule.csv' 
INTO TABLE schedule
FIELDS TERMINATED BY ','
IGNORE 1 LINES 
(   gid 
,   seas  
,   wk 
,   day 
,   @date 
,   v 
,   h 
,   stad 
,   surf)
set date = STR_TO_DATE(@date, '%m/%d/%Y')
EOF
exit
