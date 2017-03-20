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
CREATE TABLE IF NOT EXISTS conv (
    pid int
,   type varchar(4)
,   bc varchar(7)
,   psr varchar(7)
,   trg varchar(7)
,   conv bool
,   primary key (pid) 
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1


CREATE TABLE IF NOT EXISTS td (
    pid int
,   qtr int
,   min int
,   sec int
,   dwn int
,   yds int
,   pts int
,   player varchar(7)
,   type varchar(4)
,   primary key (pid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1
 
 CREATE TABLE IF NOT EXISTS koff (
    pid int
 ,  kicker varchar(7)
 ,  kgro int
 ,  knet int
 ,  ktb bool
 ,  kr varchar(7)
 ,  kry
 ,  primary key (pid) 
 ,  foreign key (pid)
 ) ENGINE=MyISAM DEFAULT CHARSET=latin1
 


CREATE TABLE IF NOT EXISTS block (
    pid int
,   blk varchar(7)
,   brcv varchar(7)
,   primary key (pid) 
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1



CREATE TABLE IF NOT EXISTS fgxp (
    pid int
,   fgxp varchar(2)
,   fkicker varchar(7)
,   dist int
,   good bool
,   primary key (pid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1
 
CREATE TABLE IF NOT EXISTS fumble (
    pid int
,   fum varchar(7)
,   frcv varchar(7)
,   fry int
,   forc varchar(7)
,   primary key (pid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS injury (
    gid int
,   player varchar(7)
,   team varchar(3)
,   details varchar(20)
,   pstat varchar(40)
,   gstat varchar(12)
,   primary key (pid)
,   foreign key (pid) 
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS pass (
    pid int
,   psr varchar(7)
,   trg varchar(7)
,   loc varchar(2)
,   yds int
,   comp bool
,   succ bool
,   spk bool
,   dfb varchar(7)
,   primary key (pid)
,   foreign key (pid) 
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS penalty (
    uid int
,   pid int
,   ptm varchar(3)
,   pen varchar(7)
,   desc varchar(40)
,   cat int
,   pey int
,   act varchar(1)
,   primary key (uid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS safety (
    pid int
,   saf varchar(7)
,   primary key (pid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS kicker (
    uid int
,   gid int
,   player varchar(7)
,   pat int
,   fgs int
,   fgm int
,   fgl int
,   fp int
,   game int
,   seas int
,   year int
,   team varchar(3)
,   primary key (uid)
,   foreign key (gid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS tackle (
    uid int
,   pid int
,   tck varchar(7)
,   value double
,   primary key (uid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS sack (
    uid int
,   pid int
,   qb varchar(7)
,   sk varchar(7)
,   value double
,   ydsl int
,   primary key (uid)
,   foreign key (pid) 
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS snap (
    uid int
,   gid int
,   tname varchar(3)
,   player varchar(7)
,   pos varchar(4)
,   snp int
,   primary key (uid)
,   foreign key (gid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS intercpt (
    pid int
,   psr varchar(7)
,   ints varchar(7)
,   iry int
,   primary key (pid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS punt (
    pid int
,   punter varchar(7)
,   pgro int
,   pnet int
,   ptb bool
,   pr varchar(7)
,   pry int
,   pfc bool
,   primary key (pid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS rush (
    pid int
,   bc varchar(7)
,   dir varchar(2)
,   yds int
,   succ bool
,   kne bool
,   primary key (pid)
,   foreign key (pid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS redzone (
    uid int
,   gid int
,   player varchar(7)
,   pa int
,   pc int
,   py int
,   ints int
,   ra int
,   sra int
,   ry int
,   trg int
,   rec int
,   recy int
,   fuml int
,   peny int
,   primary key (uid)
,   foreign key(gid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS defense (
    uid int
,   gid int
,   player varchar(7)
,   solo int
,   comb int
,   sck int
,   saf int
,   blk int
,   ints int
,   pdef int
,   frcv int
,   forc int
,   tdd int
,   rety int
,   tdret int
,   peny int
,   snp int
,   fp double
,   fp2 double
,   game int
,   seas int
,   year int
,   team varchar(3)
,   posd varchar(4)
,   jnum int
,   dcp int
,   primary key (uid)
,   foreign key (gid) 
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS offense (
    uid int
,   gid int
,   player varchar(7)
,   pa int
,   pc int
,   py int 
,   ints int
,   tdp int
,   ra int
,   sra int
,   ry int
,   tdr int
,   trg int
,   rec int
,   recy int
,   tdrec int
,   ret int
,   rety int
,   tdret int
,   fuml int
,   peny int
,   conv int
,   snp int
,   fp double
,   fp2 double
,   fp3 double
,   game int
,   seas int
,   year int
,   team varchar(3)
,   posd varchar(4)
,   jnum int
,   dcp int
,   primary key (uid)
,   foreign key (gid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS drive (
    uid int
,   gid int
,   fpid int
,   tname varchar(3)
,   drvn int
,   obt varchar(4)
,   qtr int
,   min int
,   sec int
,   yfog int
,   plays int
,   succ int 
,   rfd int
,   pfd int
,   ofd int
,   ry int
,   ra int
,   py int
,   pa int
,   pc int
,   peyf int
,   peya int
,   net int
,   res varchar(4)
,   primary key (uid)
,   foreign key (gid)
,   foreign key (fpid) 
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS player (
    player varchar(7)
,   fname varchar(32)
,   lname varchar(32)
,   pname varchar(32)
,   pos1 varchar(4)
,   pos2 varchar(4)
,   height int
,   weight int
,   yob int
,   forty double
,   bench int
,   vertical double
,   broad int
,   shuttle double
,   cone double
,   arm double
,   hand double
,   dpos int
,   col varchar(40)
,   dv varchar(40)
,   start int
,   cteam varchar(3)
,   posd varchar(4)
,   jnum int
,   dcp int
,   primary key (player) 
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS game (
    gid int
,   seas int
,   wk int
,   day varchar(3)
,   v varchar(3)
,   h varchar(3)
,   stad varchar(32)
,   temp int
,   humd int
,   wspd int
,   wdir varchar(4)
,   cond varchar(4)
,   surf varchar(9)
,   ou double
,   sprv double
,   ptsv int
,   ptsh int
,   primary key (gid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS chart (
    pid int
,   rb int
,   te int
,   drp int
,   mbt int
,   yac int
,   primary key (pid)
 
) ENGINE=MyISAM DEFAULT CHARSET=latin1

CREATE TABLE IF NOT EXISTS team (
    tid int
,   gid int
,   tname varchar(3)
,   pts int
,   q1p int
,   q2p int
,   q3p int
,   q4p int
,   rfd int
,   pfd int
,   ifd int
,   ry int
,   ra int
,   py int
,   pa int
,   pc int
,   sk int
,   ints int
,   fum int
,   pu int
,   gpy int
,   pr int
,   pry int
,   kr int
,   kry int
,   ir int
,   iry int
,   pen int
,   top double
,   td int
,   tdr int
,   tdp int
,   tdt int
,   fgm int
,   fgat int
,   fgy int
,   rza int
,   rzc int
,   bry int
,   bpy int
,   srp int
,   s1rp int
,   s2rp int
,   s3rp int
,   spp int
,   s1pp int
,   s2pp int
,   s3pp int
,   lea int
,   ley int
,   lta int
,   lty int
,   lga int
,   lgy int
,   mda int
,   mdy int
,   rga int
,   rgy int
,   rta int
,   rty int
,   rea int
,   rey int
,   r1a int
,   r1y int
,   r2a int
,   r2y int
,   r3a int
,   r3y int
,   qba int
,   qby int
,   sla int
,   sly int
,   sma int
,   smy int
,   sra int
,   sry int
,   dla int
,   dly int
,   dma int
,   dmy int
,   dra int
,   dry int
,   wr1a int
,   wr1y int
,   wr3a int
,   wr3y int
,   tea int
,   tey int
,   rba int
,   rby int
,   sga int
,   sgy int
,   p1a int
,   p1y int
,   p2a int
,   p2y int
,   p3a int
,   p3y int
,   spc int
,   mpc int
,   lpc int
,   q1ra int
,   q1ry int
,   q1pa int
,   q1py int
,   lcra int
,   lcry int
,   lcpa int
,   lcpy int
,   rzra int
,   rzry int
,   rzpa int
,   rzpy int
,   sky int
,   lbs double
,   dbs double
,   sfpy int
,   drv int
,   npy int
,   tb  int
,   i20 int
,   rtd int
,   lnr double
,   lnp double
,   lbr double
,   lbp double
,   dbr double
,   dbp double
,   nha int
,   s3a int
,   s3c int
,   l3a int
,   l3c int
,   stf int
,   dp int
,   fsp int
,   ohp int
,   pbep int
,   dlp int
,   dsp int
,   dum int
,   pfn int
,   snpo int
,   snpd int
,   primary key (tid)
,   primary key (gid) 
) ENGINE=MyISAM DEFAULT CHARSET=latin1
eof
