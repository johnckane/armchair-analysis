#!/bin/bash

# show commands being executed, per debug
set -x 

# define database connectivity

_db='armchair_analysis'
_db_user='john'

# define directory containing csv files
_csv_directory='/home/john/projects/armchair-analysis/nfl_00-19'

# go into directory
cd $_csv_directory

mysql -u $_db_user $_db <<EOF
CREATE TABLE IF NOT EXISTS block(
    pid int
,   blk varchar(7)
,   brcv varchar(7)
,   type varchar(4)
,   primary key (pid) 
);
CREATE TABLE IF NOT EXISTS conv (
    pid int
,   type varchar(4)
,   bc varchar(7)
,   psr varchar(7)
,   trg varchar(7)
,   conv bool
,   primary key (pid) 
);
CREATE TABLE IF NOT EXISTS defense(
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
,   nflid int
,   primary key (uid)
);
CREATE TABLE IF NOT EXISTS drive(
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
);
CREATE TABLE IF NOT EXISTS fgxp(
    pid int
,   fgxp varchar(2)
,   fkicker varchar(7)
,   dist int
,   good bool
,   primary key (pid)
); 
CREATE TABLE IF NOT EXISTS fumble(
    pid int
,   fum varchar(7)
,   frcv varchar(7)
,   fry int
,   forc varchar(7)
,   primary key (pid)
);
CREATE TABLE IF NOT EXISTS game(
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
);
CREATE TABLE IF NOT EXISTS injury(
    gid int
,   player varchar(7)
,   team varchar(3)
,   details varchar(20)
,   pstat varchar(40)
,   gstat varchar(12)
,   primary key (gid)
);
CREATE TABLE IF NOT EXISTS intercpt(
    pid int
,   psr varchar(7)
,   ints varchar(7)
,   iry int
,   primary key (pid)
);
CREATE TABLE IF NOT EXISTS kicker(
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
);
CREATE TABLE IF NOT EXISTS koff(
    pid int
 ,  kicker varchar(7)
 ,  kgro int
 ,  knet int
 ,  ktb bool
 ,  kr varchar(7)
 ,  kry int
 ,  primary key (pid) 
);
CREATE TABLE IF NOT EXISTS offense(
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
,   nflid int
,   primary key (uid)
);
CREATE TABLE IF NOT EXISTS pass(
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
CREATE TABLE IF NOT EXISTS penalty(
    uid int
,   pid int
,   ptm varchar(3)
,   pen varchar(7)
,   descr varchar(40)
,   cat int
,   pey int
,   act varchar(1)
,   primary key (uid)
);
CREATE TABLE IF NOT EXISTS play(      
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
,   tck bool
,   sk bool
,   pen bool
,   ints bool
,   fum bool
,   saf bool
,   blk bool
,   primary key (pid)
 );
 CREATE TABLE IF NOT EXISTS player(
    player varchar(7)
,   fname varchar(32)
,   lname varchar(32)
,   pname varchar(32)
,   pos1 varchar(4)
,   pos2 varchar(4)
,   height int
,   weight int
,   dob date
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
,   nflid int
,   primary key (player) 
);
CREATE TABLE IF NOT EXISTS punt(
    pid int
,   punter varchar(7)
,   pgro int
,   pnet int
,   ptb bool
,   pr varchar(7)
,   pry int
,   pfc bool
,   primary key (pid)
);
CREATE TABLE IF NOT EXISTS redzone(
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
);
CREATE TABLE IF NOT EXISTS rush(
    pid int
,   bc varchar(7)
,   dir varchar(2)
,   yds int
,   succ bool
,   kne bool
,   primary key (pid)
);
CREATE TABLE IF NOT EXISTS sack(
    uid int
,   pid int
,   qb varchar(7)
,   sk varchar(7)
,   value double
,   ydsl int
,   primary key (uid)
);
CREATE TABLE IF NOT EXISTS safety(
    pid int
,   saf varchar(7)
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
CREATE TABLE IF NOT EXISTS snap(
    uid int
,   gid int
,   tname varchar(3)
,   player varchar(7)
,   posd varchar(4)
,   poss varchar(4)
,   snp int
,   primary key (uid)
);
CREATE TABLE IF NOT EXISTS tackle(
    uid int
,   pid int
,   tck varchar(7)
,   value double
,   primary key (uid)
);
CREATE TABLE IF NOT EXISTS td(
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
);
CREATE TABLE IF NOT EXISTS team(
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
,   saf int
,   blk int
,   fp int
,   box double(20,2)
,   avt double(20,2)
,   pru double(20,2)
,   box4 int
,   box4sp int
,   box4y int
,   box5 int
,   box5sp int
,   box5y int
,   box6 int
,   box6sp int
,   box6y int
,   box7 int
,   box7sp int
,   box7y int
,   box8 int
,   box8sp int
,   box8y int
,   avt1 int
,   avt1sp int
,   avt1y int
,   avt2 int
,   avt2sp int
,   avt2y int
,   avt3 int
,   avt3sp int
,   avt3y int
,   avt4 int
,   avt4sp int
,   avt4y int
,   avt5 int
,   avt5sp int
,   avt5y int
,   pru3 int
,   pru3sp int
,   pru3y int
,   pru4 int
,   pru4sp int
,   pru4y int
,   pru5 int
,   pru5sp int
,   pru5y int
,   scrm int
,   scrmsp int
,   scrmy int
,   nblz int
,   nblzsp int
,   nblzy int
,   blz1 int
,   blz1sp int
,   blz1y int
,   blz2 int
,   blz2sp int
,   blz2y int
,   pap int
,   papsp int
,   papy int
,   scr int
,   scrsp int
,   scry int
,   npr int
,   nprsp int
,   npry int
,   qbp int
,   qbpsp int
,   qbpy int
,   qbhi int
,   qbhisp int
,   qbhiy int
,   qbhu int
,   qbhusp int
,   qbhuy int
,   ytg1 int
,   ytg2 int
,   ytg3 int
,   tay1 int
,   tay2 int
,   tay3 int
,   dot1 int
,   dot2 int
,   dot3 int
,   yac1 int
,   yac2 int
,   yac3 int
,   crr int
,   cnb int
,   cnbc int
,   drp int
,   qbta int
,   bap int
,   intw int
,   inti int
,   primary key (tid,gid)
);
EOF
exit
