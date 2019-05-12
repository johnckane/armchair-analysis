#!bin/bash

set -x

_db="armchair_analysis"
_db_user="john"

_csv_directory="/home/john/projects/armchair-analysis/nfl_00-18/more-formatting-needed"
cd $_csv_directory

mysql -u$_db_user $_db <<EOF
DELETE FROM player;

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
exit