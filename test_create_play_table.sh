# show commands being executed, per debug
set -x 

# define database connectivity

_db='armchair_analysis'
_db_user='root'
echo "Enter your password"
read _db_password



# define directory containing csv files
_csv_directory='/home/john/armchair_analysis/nfl_00-16'

# go into directory
cd $_csv_directory

mysql -u $_db_user -p$_db_password $_db <<eof
CREATE TABLE IF NOT EXISTS play (      
    gid int 
,   pid int
,   off varchar(3)
,   def varchar(3)
,   type varchar(4) 
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
,   fd bool
,   sg bool
,   nh bool
,   pts int
,   primary key (pid)
,   foreign key (gid) REFERENCES parent(pid)  
 ) ENGINE=MyISAM DEFAULT CHARSET=latin1
eof
