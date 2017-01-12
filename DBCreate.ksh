#!/bin/ksh
##
##  script to create the database and tables for the performance data
##

##  initialize stuff

MyEMail="doug.greenwald@gmail.com"

PATH="${PATH}:."

ProgPrefix="/Volumes/External300/DBProgs/RacePics"

. ./SetDBCase.ksh

WorkDir=`pwd`
InsertFile="${WorkDir}/Inserts.sql"
UpdateFile="${WorkDir}/Updates.sql"

make >/dev/null 2>&1

echo
echo
echo "`basename $0` Working from:"
echo "  $DBLocation"
echo

##
##  create the performance database
##

echo "Creating the Performance tables..."

$MYSQL <<EOF

use fsr;

drop table if exists nicstat;
drop table if exists vmstat;
drop table if exists iostat;
drop table if exists iostat58;
drop table if exists iostaterrs;
drop table if exists iostat58errs;
drop table if exists vxstat;
drop table if exists netstat;
drop table if exists colldate;
drop table if exists aiostat;
drop table if exists aiodetail;
drop table if exists aiosyscall;
drop table if exists aioveritas;
drop table if exists vmemfail;
drop table if exists mpstat;
drop table if exists linux_mpstat;
drop table if exists procbymem;
drop table if exists procbycpu;
drop table if exists vxfsstat;
drop table if exists throttle;
drop table if exists vxcache;

drop table if exists linux_iostat;
drop table if exists linux_iostat58;
drop table if exists linux_netstat;
drop table if exists linux_vmstat;

drop table if exists iocalc;
drop table if exists iocalc_tape;
drop table if exists iocalc_acfs;
drop table if exists iocalcnfs;

drop table if exists vxcalc;
drop table if exists vxcalc_dm;

create table nicstat (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

nsintf       varchar(11) not null,
nsrkb        float not null,
nswkb        float not null,
nsrpk        float not null,
nswpk        float not null,
nsutil       float not null,
nssat        float not null,
nsierr       float not null,
nsoerr       float not null,
nscoll       float not null,
nsnocp       float not null,
nsdefer      float not null,


primary key (pkey),

index i_interface (nsintf),
index i_util (nsutil)

)
engine = MyISAM
${DBdirClause}
;



create table vxcache (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

VXfilesystem varchar(50) not null default 'undefined',

##  Dmaxentries  int unsigned not null default 0,
##  Dtotlookups  int unsigned not null default 0,
Dmaxentries  bigint not null default 0,
Dtotlookups  bigint not null default 0,
Dfstlookups  float not null default 0.0,
##  Dtotdlookup  int unsigned not null default 0,
Dtotdlookup  bigint not null default 0,
Ddnlchitrat  float not null default 0.0,
##  Dtotenter    int unsigned not null default 0,
Dtotenter    bigint not null default 0,
Dhitperenter float not null default 0.0,
##  Dtotdirsetup int unsigned not null default 0,
Dtotdirsetup bigint not null default 0,
Dcallssetup  float not null default 0.0,
##  Dtotdirscan  int unsigned not null default 0,
Dtotdirscan  bigint not null default 0,
Dfastdirscan float not null default 0.0,

##  Inodescurr   int unsigned not null default 0,
##  Ipeak        int unsigned not null default 0,
##  Imaximum     int unsigned not null default 0,
##  Ilookups     int unsigned not null default 0,
Inodescurr   bigint not null default 0,
Ipeak        bigint not null default 0,
Imaximum     bigint not null default 0,
Ilookups     bigint not null default 0,
Ihitrate     float not null default 0.0,
##  Ialloced     int unsigned not null default 0,
##  Ifreed       int unsigned not null default 0,
##  Irecage      int unsigned not null default 0,
##  Ifreeage     int unsigned not null default 0,
Ialloced     bigint not null default 0,
Ifreed       bigint not null default 0,
Irecage      bigint not null default 0,
Ifreeage     bigint not null default 0,

##  Bkcurrent    int unsigned not null default 0,
##  Bmaximum     int unsigned not null default 0,
##  Blookups     int unsigned not null default 0,
Bkcurrent    bigint not null default 0,
Bmaximum     bigint not null default 0,
Blookups     bigint not null default 0,
Bhitrate     float not null default 0.0,
##  Brecage      int unsigned not null default 0,
Brecage      bigint not null default 0,

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_Dtotlookups (Dtotlookups),
index i_Dfstlookups (Dfstlookups),
index i_Dtotdlookup (Dtotdlookup),
index i_Ddnlchitrat (Ddnlchitrat),
index i_Ilookups (Ilookups),
index i_Ihitrate (Ihitrate),
index i_Blookups (Blookups),
index i_Bhitrate (Bhitrate),
index i_Dtotdirsetup (Dtotdirsetup),
index i_Dcallssetup (Dcallssetup)
)
engine = MyISAM
${DBdirClause}
;

create table procbymem (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

pmOS         varchar(10) default 'NULL',
pmOSVer      varchar(10) default 'NULL',
pmPID        int unsigned not null default 0,
pmMemSize    bigint unsigned not null default 0,
pmPctMem     float not null default 0.0,
pmPctCPU     float not null default 0.0,
pmNlwp       int unsigned not null default 0,
pmProject    varchar(20) default 'NULL',
pmCommand    varchar(90) default 'NULL',

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_PID (pmPID),
index i_MemSize (pmMemSize),
index i_PctMem (pmPctMem),
index i_pctCPU (pmPctCPU),
index i_Command (pmCommand)
)
engine = MyISAM
${DBdirClause}
;


create table procbycpu (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

pmOS         varchar(10) default 'NULL',
pmOSVer      varchar(10) default 'NULL',
pmPID        int unsigned not null default 0,
pmMemSize    bigint unsigned not null default 0,
pmPctMem     float not null default 0.0,
pmPctCPU     float not null default 0.0,
pmNlwp       int unsigned not null default 0,
pmProject    varchar(20) default 'NULL',
pmCommand    blob(2048),

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_PID (pmPID),
index i_MemSize (pmMemSize),
index i_PctMem (pmPctMem),
index i_pctCPU (pmPctCPU)
##  index i_Command (pmCommand)
)
engine = MyISAM
${DBdirClause}
;


create table linux_mpstat (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

cpu          int unsigned,
usr          float,
nice         float,
sys          float,
iowait       float,
irq          float,
soft         float,
steal        float,
guest        float,
idle         float,

primary key (pkey),

index i_cpu (cpu),
index i_usr (usr),
index i_nice (nice),
index i_sys (sys),
index i_iowait (iowait),
index i_irq (irq),
index i_soft (soft),
index i_steal (steal),
index i_guest (guest),
index i_idle (idle)

)
engine = MyISAM
${DBdirClause}
;


create table mpstat (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

cpu          int unsigned,
minf         int unsigned,
mjf          int unsigned,
xcal         int unsigned,
intr         int unsigned,
ithr         int unsigned,
csw          int unsigned,
icsw         int unsigned,
migr         int unsigned,
smtx         int unsigned,
srw          int unsigned,
syscl        int unsigned,
usr          int unsigned,
sys          int unsigned,
wt           int unsigned,
idl          int unsigned,

primary key (pkey),

index i_serverid (serverid),
index i_servcpuest (serverid, cpu, esttime),
index i_esttime (esttime),
index i_estmigr (esttime, migr),
index i_cpu (cpu),
index i_cpuserv (cpu, serverid),
index i_minf (minf),
index i_mjf (mjf),
index i_xcal (xcal),
index i_intr (intr),
index i_ithr (ithr),
index i_csw (csw),
index i_icsw (icsw),
index i_migr (migr),
index i_smtx (smtx),
index i_srw (srw),
index i_syscl (syscl),
index i_usr (usr),
index i_sys (sys),
index i_wt (wt),
index i_idl (idl)
)
engine = MyISAM
${DBdirClause}
;



create table vmemfail (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

module       varchar(10),
instance     int unsigned,
name         varchar(25),
class        varchar(25),
commit_fail  int unsigned default 0,
reserve_fail int unsigned default 0,
alloc_fail   int unsigned default 0,
fail         int unsigned default 0,
populate_fail int unsigned default 0,

primary key (pkey),
index i_serverid (serverid),
index i_datestr (datestr),
index i_esttime (esttime),
index i_module (module),
index i_instance (instance),
index i_name (name),
index i_class (class),
index i_comfail (commit_fail),
index i_resfail (reserve_fail),
index i_allocfail (alloc_fail),
index i_fail (fail),
index i_popfail (populate_fail)
)
engine = MyISAM
${DBdirClause}
;


create table aiodetail (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

aioread      int unsigned,
aiowrite     int unsigned,
aioasync     int unsigned,
aerror       int unsigned,
await        int unsigned,
asusp        int unsigned,
acanc        int unsigned,

primary key (pkey),

index i_serverid (serverid),
index i_datestr (datestr),
index i_esttime (esttime),
index i_aioread (aioread),
index i_aiowrite (aiowrite),
index i_aioasync (aioasync),
index i_aerror (aerror),
index i_await (await),
index i_asusp (asusp),
index i_acanc (acanc)
)
engine = MyISAM
${DBdirClause}
;

create table aiosyscall (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

daioread     int unsigned not null default 0,
daiowrite    int unsigned not null default 0,
adone        int unsigned not null default 0,
await        int unsigned not null default 0,
acanc        int unsigned not null default 0,
aerror       int unsigned not null default 0,
asusp        int unsigned not null default 0,

primary key (pkey),

index i_daioread (daioread),
index i_daiowrite (daiowrite),
index i_adone (adone),
index i_await (await),
index i_acanc (acanc),
index i_aerror (aerror),
index i_asusp (asusp)
)
engine = MyISAM
${DBdirClause}
;

create table aioveritas (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

dmp_aread    int unsigned not null default 0,
dmp_awrite   int unsigned not null default 0,
volaread     int unsigned not null default 0,
volawrite    int unsigned not null default 0,
vx_aioq_init int unsigned not null default 0,
vx_aioctl    int unsigned not null default 0,
vx_aioq_drain int unsigned not null default 0,
vx_aio_iodone int unsigned not null default 0,
vx_aio_done  int unsigned not null default 0,

primary key (pkey),

index i_dmp_aread (dmp_aread),
index i_dmp_awrite (dmp_awrite),
index i_volaread (volaread),
index i_volawrite (volawrite),
index i_vx_aioq_init (vx_aioq_init),
index i_vx_aioctl (vx_aioctl),
index i_vx_aioq_drain (vx_aioq_drain),
index i_vx_aio_iodone (vx_aio_iodone),
index i_vx_aio_done (vx_aio_done)
)
engine = MyISAM
${DBdirClause}
;

create table linux_vmstat (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
esttime  int unsigned not null default 0,

##  the vmstat data
r        int unsigned not null default 0,
b        int unsigned not null default 0,
swpd     int unsigned not null default 0,
free     int unsigned not null default 0,
inact    int unsigned not null default 0,
active   int unsigned not null default 0,
si       int unsigned not null default 0,
so       int unsigned not null default 0,
bi       int unsigned not null default 0,
bo       int unsigned not null default 0,
iin      int unsigned not null default 0,
cs       int unsigned not null default 0,
us       int unsigned not null default 0,
sy       int unsigned not null default 0,
id       int unsigned not null default 0,
wa       int unsigned not null default 0,
st       int unsigned not null default 0,

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_servdate (serverid, datestr),

index i_r (r),
index i_b (b),
index i_swpd (swpd),
index i_free (free),
index i_iin (iin),
index i_cs (cs),
index i_us (us),
index i_sy (sy),
index i_wa (wa)

)
engine = MyISAM
${DBdirClause}
;


create table vmstat (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
vmtype   char(1) default 'Z',

##  calculated time expressed in seconds from epoch
esttime  int unsigned not null default 0,

##
##  the actual vmstat values from -S
##

rq       int unsigned not null default 0,
bq       int unsigned not null default 0,
wq       int unsigned not null default 0,
swap     int unsigned not null default 0,
free     int unsigned not null default 0,
si       int unsigned not null default 0,
so       int unsigned not null default 0,
pi       int unsigned not null default 0,
po       int unsigned not null default 0,
fr       int unsigned not null default 0,
de       int unsigned not null default 0,
sr       int unsigned not null default 0,
s0       int unsigned not null default 0,
s1       int unsigned not null default 0,
s2       int unsigned not null default 0,
sd       int unsigned not null default 0,
iin      int unsigned not null default 0,
sy       int unsigned not null default 0,
cs       int unsigned not null default 0,
us       int unsigned not null default 0,
sys      int unsigned not null default 0,
id       int unsigned not null default 0,

##  totcpu   int unsigned not null default 0,  ##  sum of us and sys

##
##  the actual values from -p
##

pswap    int unsigned not null default 0,
pfree    int unsigned not null default 0,
pre      int unsigned not null default 0,
pmf      int unsigned not null default 0,
pfr      int unsigned not null default 0,
pde      int unsigned not null default 0,
psr      int unsigned not null default 0,
pepi     int unsigned not null default 0,
pepo     int unsigned not null default 0,
pepf     int unsigned not null default 0,
papi     int unsigned not null default 0,
papo     int unsigned not null default 0,
papf     int unsigned not null default 0,
pfpi     int unsigned not null default 0,
pfpo     int unsigned not null default 0,
pfpf     int unsigned not null default 0,


primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_type (vmtype),
index i_servdate (serverid, datestr),
index i_servdatetype (serverid, datestr, vmtype),
index i_estservdatetype (esttime, serverid, datestr, vmtype)

)
engine = MyISAM
${DBdirClause}
;

create table iostaterrs (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime      int unsigned not null default 0,

device       varchar(75),                  ##  the device
sw           int unsigned not null default 0,
hw           int unsigned not null default 0,
trn          int unsigned not null default 0,
tot          int unsigned not null default 0,

devtype      int default -1,

primary key (pkey),

index i_serverid (serverid),
index i_datestr (datestr),
index i_esttime (esttime),
index i_device (device),
index i_sw (sw),
index i_hw (hw),
index i_trn (trn),
index i_tot (tot),
index i_devtype (devtype)

)
engine = MyISAM
${DBdirClause}
;

create table iostat58errs (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime      int unsigned not null default 0,

device       varchar(75),                  ##  the device
sw           int unsigned not null default 0,
hw           int unsigned not null default 0,
trn          int unsigned not null default 0,
tot          int unsigned not null default 0,

devtype      int default -1,

primary key (pkey),

index i_serverid (serverid),
index i_datestr (datestr),
index i_esttime (esttime),
index i_device (device),
index i_sw (sw),
index i_hw (hw),
index i_trn (trn),
index i_tot (tot),
index i_devtype (devtype)

)
engine = MyISAM
${DBdirClause}
;

create table iostat (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime  int unsigned not null default 0,

##
##  actual values from iostat -xn
##

rs       float not null default 0.0,   ##  read ops
ws       float not null default 0.0,   ##  write ops
krs      float not null default 0.0,   ##  kbytes read per second
kws      float not null default 0.0,   ##  kbytes written per second
wait     float not null default 0.0,   ##  avg num transactions waiting (q len)
actv     float not null default 0.0,   ##  avg num transactions being serviced
wsvct    float not null default 0.0,   ##  avg time spent in queue (wait)
asvct    float not null default 0.0,   ##  avg actual service time
pctw     int unsigned not null default 0,  ##  % of time queue non-empty
pctb     int unsigned not null default 0,  ##  % of time disk is busy processing
device   varchar(75),                  ##  the device

##  derived values

avgread  float not null default 0.0,   ##  avg read i/o size
avgwrit  float not null default 0.0,   ##  avg write i/o size

devtype  int default -1,               ##  0 - controller
                                       ##  1 - internal disk
                                       ##  2 - SAN
                                       ##  3 - tape
                                       ##  4 - NFS
                                       ##  5 - mapper (linux)
                                       ##  6 - veritas (linux)
                                       ##  7 - ACFS

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_rs (rs),
index i_ws (ws),
index i_krs (krs),
index i_kws (kws),
index i_wait (wait),
index i_actv (actv),
index i_wsvct (wsvct),
index i_asvct (asvct),
index i_pctb (pctb),
index i_device (device),
index i_devtype (devtype),

index i_estwsvct (esttime, wsvct),
index i_estasvct (esttime, asvct),
index i_servestwsvct (serverid, esttime, wsvct),
index i_servestasvct (serverid, esttime, asvct),

index i_servdate (serverid, datestr),
index i_servest (serverid, esttime)

#index i_servasvct (serverid, asvct),
#index i_servdatedev(serverid, datestr, device),
#index i_servdateest (serverid, datestr, esttime),
#index i_servdevest (serverid, device, esttime),
#index i_dateservdevasvct (datestr, serverid, device, asvct),
#index i_dateservdevasvctest (datestr, serverid, device, asvct, esttime)


)
engine = MyISAM
${DBdirClause}
;

create table iostat58 (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime  int unsigned not null default 0,

##
##  actual values from iostat -xn
##

rs       float not null default 0.0,   ##  read ops
ws       float not null default 0.0,   ##  write ops
krs      float not null default 0.0,   ##  kbytes read per second
kws      float not null default 0.0,   ##  kbytes written per second
wait     float not null default 0.0,   ##  avg num transactions waiting (q len)
actv     float not null default 0.0,   ##  avg num transactions being serviced
wsvct    float not null default 0.0,   ##  avg time spent in queue (wait)
asvct    float not null default 0.0,   ##  avg actual service time
pctw     int unsigned not null default 0,       ##  % of time queue non-empty
pctb     int unsigned not null default 0,       ##  % of time disk is busy processing
device   varchar(75),                  ##  the device
avgread  float not null default 0.0,   ##  avg read i/o size
avgwrit  float not null default 0.0,   ##  avg write i/o size

devtype  int default -1,               ##  0 - controller
                                       ##  1 - internal disk
                                       ##  2 - SAN
                                       ##  3 - tape
                                       ##  4 - NFS

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_wait (wait),
index i_actv (actv),
index i_wsvct (wsvct),
index i_asvct (asvct),
index i_device (device),
index i_devtype (devtype),

index i_estwsvct (esttime, wsvct),
index i_estasvct (esttime, asvct),
index i_estserv (esttime, serverid),
index i_servdate (serverid, datestr),

index i_servestwsvct (serverid, esttime, wsvct),
index i_servestasvct (serverid, esttime, asvct)

##index i_rs (rs),
##index i_ws (ws),
##index i_krs (krs),
##index i_kws (kws),
##index i_pctb (pctb),
##index i_servest (serverid, esttime)
##index i_servasvct (serverid, asvct),
##index i_servdatedev(serverid, datestr, device),
##index i_servdateest (serverid, datestr, esttime),
##index i_servdevest (serverid, device, esttime),
##index i_dateservdevasvct (datestr, serverid, device, asvct),
##index i_dateservdevasvctest (datestr, serverid, device, asvct, esttime)

)
engine = MyISAM
${DBdirClause}
;

##  linux iostat tables

create table linux_iostat (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime  int unsigned not null default 0,

##
##  actual values from iostat -xn
##

device   varchar(75),                  ##  the device
rrqms    float not null default 0.0,   ##  read requests merged
wrqms    float not null default 0.0,   ##  write requests merged
rs       float not null default 0.0,   ##  read ops
ws       float not null default 0.0,   ##  write ops
krs      float not null default 0.0,   ##  kbytes read per second
kws      float not null default 0.0,   ##  kbytes written per second
avgrqsz  float not null default 0.0,   ##  avg size of requests
avgqusz  float not null default 0.0,   ##  avg queue length
await    float not null default 0.0,   ##  avg wait time
svctm    float not null default 0.0,   ##  avg service time
util     float not null default 0.0,   ##  % of cpu time while requests issued

##  derived values

avgread  float not null default 0.0,   ##  avg read i/o size
avgwrit  float not null default 0.0,   ##  avg write i/o size

devtype  int default -1,               ##  0 - controller
                                       ##  1 - internal disk
                                       ##  2 - SAN
                                       ##  3 - tape
                                       ##  4 - NFS
                                       ##  5 - mapper (linux)
                                       ##  6 - veritas (linux)

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_rs (rs),
index i_ws (ws),
index i_krs (krs),
index i_kws (kws),
index i_rrqms (rrqms),
index i_wrqms (wrqms),
index i_avgrqsz (avgrqsz),
index i_avgqusz (avgqusz),
index i_await (await),
index i_svctm (svctm),
index i_util (util),

index i_device (device),
index i_devtype (devtype),

##  index i_estwsvct (esttime, wsvct),
##  index i_estasvct (esttime, asvct),
##  index i_servestwsvct (serverid, esttime, wsvct),
##  index i_servestasvct (serverid, esttime, asvct),

index i_servdate (serverid, datestr),
index i_servest (serverid, esttime)

##  index i_servasvct (serverid, asvct),
##  index i_servdatedev(serverid, datestr, device),
##  index i_servdateest (serverid, datestr, esttime),
##  index i_servdevest (serverid, device, esttime),
##  index i_dateservdevasvct (datestr, serverid, device, asvct),
##  index i_dateservdevasvctest (datestr, serverid, device, asvct, esttime)

)
engine = MyISAM
${DBdirClause}
;

create table linux_iostat58 (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime  int unsigned not null default 0,

##
##  actual values from iostat -xn
##

device   varchar(75),                  ##  the device
rrqms    float not null default 0.0,   ##  
wrqms    float not null default 0.0,   ##  
rs       float not null default 0.0,   ##  read ops
ws       float not null default 0.0,   ##  write ops
krs      float not null default 0.0,   ##  kbytes read per second
kws      float not null default 0.0,   ##  kbytes written per second
avgrqsz  float not null default 0.0,   ##  
avgqusz  float not null default 0.0,   ##  
await    float not null default 0.0,   ##  
svctm    float not null default 0.0,   ##  
util     float not null default 0.0,   ##  

##  derived values

avgread  float not null default 0.0,   ##  avg read i/o size
avgwrit  float not null default 0.0,   ##  avg write i/o size

devtype  int default -1,               ##  0 - controller
                                       ##  1 - internal disk
                                       ##  2 - SAN
                                       ##  3 - tape
                                       ##  4 - NFS

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_rs (rs),
index i_ws (ws),
index i_krs (krs),
index i_kws (kws),
index i_rrqms (rrqms),
index i_wrqms (wrqms),
index i_avgrqsz (avgrqsz),
index i_avgqusz (avgqusz),
index i_await (await),
index i_svctm (svctm),
index i_util (util),

index i_device (device),
index i_devtype (devtype),

##  index i_estwsvct (esttime, wsvct),
##  index i_estasvct (esttime, asvct),
##  index i_servestwsvct (serverid, esttime, wsvct),
##  index i_servestasvct (serverid, esttime, asvct),

index i_servdate (serverid, datestr),
index i_servest (serverid, esttime)

##  index i_servasvct (serverid, asvct),
##  index i_servdatedev(serverid, datestr, device),
##  index i_servdateest (serverid, datestr, esttime),
##  index i_servdevest (serverid, device, esttime),
##  index i_dateservdevasvct (datestr, serverid, device, asvct),
##  index i_dateservdevasvctest (datestr, serverid, device, asvct, esttime)

)
engine = MyISAM
${DBdirClause}
;


create table vxstat (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime  int unsigned not null default 0,

##  the disk group

dgroup   varchar(50) default 'NULL',

##
## actual values from vxstat -d
##

vxtype   varchar(5) default 'NULL',
objname  varchar(100) default 'NULL',
readops  int unsigned not null default 0,
writops  int unsigned not null default 0,
readblk  bigint unsigned not null default 0,
writblk  bigint unsigned not null default 0,
readms   float not null default 0.0,
writms   float not null default 0.0,

## rwms     float not null default 0.0,  ##  sum of readms and writems

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_objname (objname),
index i_type (vxtype),
index i_readms (readms),
index i_writms (writms),
index i_readops (readops),
index i_writops (writops),
index i_readblk (readblk),
index i_writblk (writblk),
##  index i_typereadms (vxtype, readms),
##  index i_objreadms (objname, readms),
index i_servdate (serverid, datestr),
index i_servtype (serverid, vxtype),
index i_esttype (esttime, vxtype)
##  index i_servdatetype (serverid, datestr, vxtype),
##  index i_servesttype (serverid, esttime, vxtype)
##  index i_servobjdate (serverid, objname, datestr),
##  index i_servobjdateest (serverid, objname, datestr, esttime),
##  index i_servobjdatetype (serverid, objname, datestr, vxtype),
##  index i_servdateesttype (serverid, datestr, esttime, vxtype)


)
engine = MyISAM
${DBdirClause}
;

create table linux_netstat (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime  int unsigned not null default 0,

##  values from netstat -I

intf         varchar(10) default 'NULL',
ipack        decimal(25) not null default 0,
ierrs        decimal(25) not null default 0,
idrop        decimal(25) not null default 0,
iovr         decimal(25) not null default 0,
opack        decimal(25) not null default 0,
oerrs        decimal(25) not null default 0,
odrop        decimal(25) not null default 0,
oovr         decimal(25) not null default 0,

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_servdate (serverid, datestr),
index i_servestdate (serverid, esttime, datestr),
index i_servintestdate (serverid, intf, esttime, datestr),
index i_ipack (ipack),
index i_ierrs (ierrs),
index i_idrop (idrop),
index i_iovr (iovr),
index i_opack (opack),
index i_oerrs (oerrs),
index i_odrop (odrop),
index i_oovr (oovr)

)
engine = MyISAM
${DBdirClause}
;


create table netstat (
pkey     int not null auto_increment,
serverid int unsigned not null,
datestr  char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime  int unsigned not null default 0,

##
## actual values from netstat -i
##

intf     varchar(10) default 'NULL',
#ipack    bigint unsigned not null default 0,
ipack    decimal(25) not null default 0,
ierrs    decimal(25) not null default 0,
opack    decimal(25) not null default 0,
oerrs    decimal(25) not null default 0,
ocoll    decimal(25) not null default 0,
pctipack float not null default 0.0,
pctierr  float not null default 0.0,
pctopack float not null default 0.0,
pctoerr  float not null default 0.0,
pctocoll float not null default 0.0,

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_servdate (serverid, datestr),
index i_servestdate (serverid, esttime, datestr),
index i_servintestdate (serverid, intf, esttime, datestr),
index i_ipack (ipack),
index i_ierrs (ierrs),
index i_opack (opack),
index i_oerrs (oerrs),
index i_ocoll (ocoll)


)
engine = MyISAM
${DBdirClause}
;

create table colldate (
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
ebegin       int unsigned not null default 0,
eend         int unsigned not null default 0,

primary key (serverid,datestr)
)
engine = MyISAM
${DBdirClause}
;

create table vxfsstat (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
##  calculated time expressed in seconds from epoch
esttime      int unsigned not null default 0,

##
##  from the vxfsstat_filesystem file
##

##  DIRmaxentries    bigint unsigned not null default 0,
##  DIRtotlookups    bigint unsigned not null default 0,
DIRmaxentries    bigint not null default 0,
DIRtotlookups    bigint not null default 0,
DIRfastlookpct   float not null default 0.0,
##  DIRtotdnlc       bigint unsigned not null default 0,
DIRtotdnlc       bigint not null default 0,
DIRdnlchit       float not null default 0.0,
##  DIRtotenter      bigint unsigned not null default 0,
DIRtotenter      bigint not null default 0,
DIRenterhit      float not null default 0.0,
##  DIRtotdircsetup  bigint unsigned not null default 0,
DIRtotdircsetup  bigint not null default 0,
DIRcallspsetup   float not null default 0.0,
##  DIRtotdirscan    bigint unsigned not null default 0,
DIRtotdirscan    bigint not null default 0,
DIRfastdirpct    float not null default 0.0,

##  INODEcurrent     bigint unsigned not null default 0,
##  INODEpeak        bigint unsigned not null default 0,
##  INODEmax         bigint unsigned not null default 0,
##  INODElookups     bigint unsigned not null default 0,
INODEcurrent     bigint not null default 0,
INODEpeak        bigint not null default 0,
INODEmax         bigint not null default 0,
INODElookups     bigint not null default 0,
INODEhitrate     float not null default 0.0,
##  INODEalloced     bigint unsigned not null default 0,
##  INODEfreed       bigint unsigned not null default 0,
##  INODErecage      bigint unsigned not null default 0,
##  INODEfreeage     bigint unsigned not null default 0,
INODEalloced     bigint not null default 0,
INODEfreed       bigint not null default 0,
INODErecage      bigint not null default 0,
INODEfreeage     bigint not null default 0,

##  BUFcurrent       bigint unsigned not null default 0,
##  BUFmax           bigint unsigned not null default 0,
##  BUFlookups       bigint unsigned not null default 0,

BUFcurrent       bigint not null default 0,
BUFmax           bigint not null default 0,
BUFlookups       bigint not null default 0,
BUFhitrate       float not null default 0.0,
##  BUGrecage        bigint unsigned not null default 0,
BUGrecage        bigint not null default 0,

primary key (pkey),

index i_DIRfastlookpct (DIRfastlookpct),
index i_DIRdnlchit (DIRdnlchit),
index i_DIRenterhit (DIRenterhit),
index i_DIRfastdirpct (DIRfastdirpct),
index i_INODEhitrate (INODEhitrate),
index i_BUFhitrate (BUFhitrate),

index i_INODEcurrent (INODEcurrent),
index i_INODEpeak (INODEpeak),
index i_INODElookups (INODElookups)

)
engine = MyISAM
${DBdirClause}
;

create table throttle (
pkey          int not null auto_increment,
serverid      int unsigned not null,
datestr       char(15) default 'NULL',
esttime       int unsigned not null default 0,

##  dtrace probe detail

provider      varchar(15),
module        varchar(15),
function      varchar(30),
name          varchar(15),

##  function detail - all

devicename    varchar(15),     ##  ssdXXX

##  function detail - (s)sd_reduce_throttle and (s)sd_restore_throttle

adaptthrottle int unsigned not null default 0,
cmdsdriver    int unsigned not null default 0,
cmdsxport     int unsigned not null default 0,
currthrottle  int unsigned not null default 0,
savethrottle  int unsigned not null default 0,
busythrottle  int unsigned not null default 0,
minthrottle   int unsigned not null default 0,
throttletype  int unsigned not null default 0,

primary key (pkey),

index i_esttime (esttime),
index i_function (function),
index i_throttletype (throttletype)
)
engine = MyISAM
${DBdirClause}
;



##
##  stored procs
##

##  source P-DMCalc.sql;
##  source P-IOCalc.sql;
##  source P-IOErrsCalc.sql;
##  source P-PathCalc.sql;
##  source P-VXCalc.sql;
##  source P-VXCalc-dm.sql;
##  source P-VolCalc.sql;

EOF

##
##  create the disk "calculated" tables
##

echo
echo "Creating calculated tables..."

echo "  dm  vxcalc..."

./CreateVXCalcD -c

echo "  vol vxcalc..."

./CreateVXCalcV -c

echo "  SAN  iocalc..."

./CreateIOCalc -c

echo "  NFS  iocalc..."

./CreateIOCalc-NFS -c

echo "  ACFS iocalc..."

./CreateIOCalc-ACFS -c

echo "  linux iocalc..."

./CreateLinuxIOCalc -c
