
##
##  functions for Graph-SingServ-Overview.ksh
##

Make_Data_local()
{

  echo
  echo "Creating data files..."

  #############################################
  ##
  ##  ping times
  ##
  #############################################

  echo "  Ping Times   - $ServerName ($ServerID) as source - $StartEpoch $EndEpoch"

  for DESTServerID in `${ProgPrefix}/NewQuery fsr "select distinct destserverid from pingtime where srcserverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
  do

    echo "    Generating ping data to "`${ProgPrefix}/NewQuery fsr "select name from server where id = ${DESTServerID}"`"..."

    ${ProgPrefix}/NewQuery fsr "select esttime, ptxmit, ptrcv, ptmin, ptavg, ptmax, ptstd from pingtime where srcserverid = ${ServerID} and destserverid = ${DESTServerID} and esttime between ${StartEpoch} and ${EndEpoch}" > ${PlotDataDir}/pingtime-${ServerName}_2_${DESTServerName}-${StartTime}_${EndTime}.dat

  done  ##  for each ping detination server


  #############################################
  ##
  ##  solaris
  ##
  #############################################

  if [ "${ServerOS}" = "SunOS" ]
  then
    echo "  Solaris Data - $ServerName ($ServerID) $StartEpoch $EndEpoch"

    ${ProgPrefix}/NewQuery fsr "select esttime, swap from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, free from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, psr from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_sr-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, pfpi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, pfpo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, pfpf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, pepi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, pepo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, pepf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, papi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, papo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, papf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, us from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_user-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ( us + sys ) from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_system-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, rq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, bq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat


    ${ProgPrefix}/NewQuery fsr "select esttime, iin from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_intr-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sy from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_syscall-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cs from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_cswitch-${ServerName}-${StartTime}_${EndTime}.dat

    for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
    do
      VXfsnoslash=`echo $VXfilesystem | tr \/ \_`
      ## echo "    $VXfilesystem --> $VXfsnoslash"
      ${ProgPrefix}/NewQuery fsr "select esttime, Dtotlookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_totlookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, Dfstlookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_fstlookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

      ${ProgPrefix}/NewQuery fsr "select esttime, Dtotdlookup from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_totdlookup-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, Ddnlchitrat from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_dnlchitrat-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

      ${ProgPrefix}/NewQuery fsr "select esttime, ialloced from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ialloced-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, ifreed from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ifreed-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

      ${ProgPrefix}/NewQuery fsr "select esttime, ilookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ilookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, ihitrate from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ihitrate-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

    done  ##  for each veritas filesystem

    ##
    ##  iocalc SAN device types
    ##

    ${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_Wops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, (ws_sum + rs_sum) from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg_a from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg_a from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgread_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgwrit_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, adevices from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat

    ##
    ##  iocalc ACFS mounts
    ##

    ${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_Wops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, (ws_sum + rs_sum) from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_readk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_writek-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg_a from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg_a from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgread_avg from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgwrit_avg from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, adevices from iocalc_acfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcacfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat

    ##
    ##  iocalc NFS mounts
    ##

    ${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_Wops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, (ws_sum + rs_sum) from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_readk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_writek-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg_a from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg_a from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgread_avg from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgwrit_avg from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, adevices from iocalcnfs where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalcnfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat


    ##  veritas calc data files

    ${ProgPrefix}/NewQuery fsr "select esttime, readops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readops_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writops_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writblk_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readblk_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, servtime from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, servtime from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_avg from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_max from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_avg from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_max from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_avg from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_max from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_avg from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_max from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, adevices from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, adevices from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat

    for Interface in `${ProgPrefix}/NewQuery fsr "select distinct intf from netstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by intf"`
    do
      echo "    NETstat - $ServerName - $Interface"
      ${ProgPrefix}/NewQuery fsr "select esttime, ipack, ierrs from netstat where serverid = ${ServerID} and intf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, opack, oerrs, ocoll from netstat where serverid = ${ServerID} and intf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
      echo "    NICstat - $ServerName - $Interface"
      ${ProgPrefix}/NewQuery fsr "select esttime, nsrkb, ( nsrkb / 1024.0 ), nsutil  from nicstat where serverid = ${ServerID} and nsintf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, nswkb, ( nswkb / 1024.0 ) from nicstat where serverid = ${ServerID} and nsintf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, ( nsrkb / 1024.0 + nswkb / 1024.0 ), ( nsrkb + nswkb ), ( nsrpk + nswpk) from nicstat where serverid = ${ServerID} and nsintf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat

    done  ##  for each interface

    ##
    ##  the raw disk times charts are better WITHOUT being correctly time aligned
    ##

    ${ProgPrefix}/NewQuery fsr "select (readms + writms) from vxstat where vxtype = 'dm' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, (readms + writms) from vxstat where vxtype = 'dm' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_disk_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select (readms + writms) from vxstat where vxtype = 'vol' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, (readms + writms) from vxstat where vxtype = 'vol' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_vol_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat


    ##  get number of CPUs for this server and get data per CPU

    CPUs=`${ProgPrefix}/SVSQuery fsr "select distinct cpu from mpstat where serverid = ${ServerID}"`

    echo "    Creating per cpu data..."

    for CPU in $CPUs
    do
      ## echo $CPU
      ${ProgPrefix}/NewQuery fsr "select esttime, usr from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_usr-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, sys from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_sys-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, wt from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ##  ${ProgPrefix}/NewQuery fsr "select esttime, wt from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ##  ${ProgPrefix}/NewQuery fsr "select esttime, wt from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ##  ${ProgPrefix}/NewQuery fsr "select esttime, wt from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, smtx from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_smtx-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, srw from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_srw-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, migr from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_migrate-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, intr from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_intr-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, syscl from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_syscall-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, csw, icsw from mpstat where serverid = ${ServerID} and cpu = ${CPU} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat
    done  ##  for each CPU

    if [ $TESTMODE = 0 ]
    then
      echo "    Generating RAW iostat data..."

      ##
      ##  SAN device type stats
      ##

      echo "      SAN devices"

      ${ProgPrefix}/NewQuery fsr "select asvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select wsvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and wsvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, wsvct" > ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select actv from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select avgread from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgread != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgread" > ${PlotDataDir}/iostat_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select avgwrit from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgwrit != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgwrit" > ${PlotDataDir}/iostat_writkperop-${ServerName}-${StartTime}_${EndTime}.dat

      ##  with timestamps for combined charts

      ${ProgPrefix}/NewQuery fsr "select esttime, asvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, wsvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and wsvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, wsvct" > ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, actv from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostat_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, avgread from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgread != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgread" > ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, avgwrit from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgwrit != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgwrit" > ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat

      ##
      ##  ACFS mount stats
      ##

      echo "      ACFS mounts"

      ${ProgPrefix}/NewQuery fsr "select asvct from iostat where serverid = ${ServerID} and devtype = 7 and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostatacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select wsvct from iostat where serverid = ${ServerID} and devtype = 7 and wsvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, wsvct" > ${PlotDataDir}/iostatacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select actv from iostat where serverid = ${ServerID} and devtype = 7 and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostatacfs_actv-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select avgread from iostat where serverid = ${ServerID} and devtype = 7 and avgread != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgread" > ${PlotDataDir}/iostatacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select avgwrit from iostat where serverid = ${ServerID} and devtype = 7 and avgwrit != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgwrit" > ${PlotDataDir}/iostatacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat

      ##  with timestamps for combined charts

      ${ProgPrefix}/NewQuery fsr "select esttime, asvct from iostat where serverid = ${ServerID} and devtype = 7 and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostatacfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, wsvct from iostat where serverid = ${ServerID} and devtype = 7 and wsvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, wsvct" > ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, actv from iostat where serverid = ${ServerID} and devtype = 7 and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostatacfs_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, avgread from iostat where serverid = ${ServerID} and devtype = 7 and avgread != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgread" > ${PlotDataDir}/iostatacfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, avgwrit from iostat where serverid = ${ServerID} and devtype = 7 and avgwrit != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgwrit" > ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat

      ##
      ##  NFS mount stats
      ##

      echo "      NFS mounts"

      ${ProgPrefix}/NewQuery fsr "select asvct from iostat where serverid = ${ServerID} and devtype = 4 and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostatnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select wsvct from iostat where serverid = ${ServerID} and devtype = 4 and wsvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, wsvct" > ${PlotDataDir}/iostatnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select actv from iostat where serverid = ${ServerID} and devtype = 4 and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostatnfs_actv-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select avgread from iostat where serverid = ${ServerID} and devtype = 4 and avgread != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgread" > ${PlotDataDir}/iostatnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select avgwrit from iostat where serverid = ${ServerID} and devtype = 4 and avgwrit != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgwrit" > ${PlotDataDir}/iostatnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat

      ##  with timestamps for combined charts

      ${ProgPrefix}/NewQuery fsr "select esttime, asvct from iostat where serverid = ${ServerID} and devtype = 4 and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostatnfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, wsvct from iostat where serverid = ${ServerID} and devtype = 4 and wsvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, wsvct" > ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, actv from iostat where serverid = ${ServerID} and devtype = 4 and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostatnfs_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, avgread from iostat where serverid = ${ServerID} and devtype = 4 and avgread != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgread" > ${PlotDataDir}/iostatnfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, avgwrit from iostat where serverid = ${ServerID} and devtype = 4 and avgwrit != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgwrit" > ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat



      if [ $NBServer = 1 ]
      then
        echo "    Generating RAW iostat TAPE data..."

	${ProgPrefix}/NewQuery fsr "select asvct from iostat where serverid = ${ServerID} and devtype = 3 and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_asvct_tape-${ServerName}-${StartTime}_${EndTime}.dat
	${ProgPrefix}/NewQuery fsr "select actv from iostat where serverid = ${ServerID} and devtype = 3 and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostat_actv_tape-${ServerName}-${StartTime}_${EndTime}.dat

      fi  ##  if generate tape data

    fi  ##  if generate raw iostat data

    if [ $NBServer = 1 ]
    then
      echo "    Generating TAPE iocalc data..."
      ${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_Rops-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_Wops-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, (ws_sum + rs_sum) from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_readk-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_writek-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_asvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg_a from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_weighted-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, adevices from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_numdev-${ServerName}-${StartTime}_${EndTime}.dat
    fi  ##  if generate tape i/o stats

  fi  ##  if solaris

  #############################################
  ##
  ##  linux
  ##
  #############################################

  if [ "${ServerOS}" = "Linux" ]
  then

    echo "  Linux Data   - $ServerName ($ServerID) $StartEpoch $EndEpoch"

    ${ProgPrefix}/NewQuery fsr "select esttime, r from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_r-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, b from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_b-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, swpd from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_swpd-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, free from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, ( free + swpd ) from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, inact from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_inact-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, active from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_active-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, si from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_si-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, so from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_so-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, bi from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_bi-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, bo from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_bo-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, iin from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_iin-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cs from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_cs-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, us from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_us-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sy from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_sy-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, id from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_id-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wa from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_wa-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, st from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_st-${ServerName}-${StartTime}_${EndTime}.dat


    for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
    do
      VXfsnoslash=`echo $VXfilesystem | tr \/ \_`
      ## echo "    $VXfilesystem --> $VXfsnoslash"
      ${ProgPrefix}/NewQuery fsr "select esttime, Dtotlookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_totlookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, Dfstlookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_fstlookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

      ${ProgPrefix}/NewQuery fsr "select esttime, Dtotdlookup from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_totdlookup-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, Ddnlchitrat from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_dnlchitrat-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

      ${ProgPrefix}/NewQuery fsr "select esttime, ialloced from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ialloced-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, ifreed from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ifreed-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

      ${ProgPrefix}/NewQuery fsr "select esttime, ilookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ilookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, ihitrate from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ihitrate-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

    done  ##  for each veritas filesystem

    ##
    ##  need to create the iocalc for linux and then export the data
    ##

    ${ProgPrefix}/NewQuery fsr "select esttime, rrqms_sum from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_rrqmssum-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wrqms_sum from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_wrqmssum-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_rssum-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_wssum-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_krssum-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_kwssum-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgrqsz_avg from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_avgrqszavg-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgqusz_avg from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_avgquszavg-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, await_avg from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_awaiavg-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, svctm_avg from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_svctmavg-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, await_avg_a from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_awaiavga-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, svctm_avg_a from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_svctmavga-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, util_avg from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_utilavg-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgread_avg from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_avgreadavg-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, avgwrit_avg from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_avgwritavg-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, adevices from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_adevices-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wkperop from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_wkperop-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, rkperop from linux_iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/liocalc_rkperop-${ServerName}-${StartTime}_${EndTime}.dat



    ##
    ##  need to create the vxcalc for linux and then export the data
    ##

    ##  ${ProgPrefix}/NewQuery fsr "select esttime, readops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, writops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, readops_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, writops_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, readblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, writblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, writblk_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, readblk_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, servtime from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, servtime from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, readms_avg from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, readms_max from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, readms_avg from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, readms_max from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, writms_avg from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, writms_max from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, writms_avg from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, writms_max from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, adevices from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, adevices from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat

    for Interface in `${ProgPrefix}/NewQuery fsr "select distinct intf from linux_netstat where serverid = ${ServerID}"`
    do
      ## echo "    $ServerName - $Interface"
      ${ProgPrefix}/NewQuery fsr "select esttime, ipack, ierrs, idrop, iovr from linux_netstat where serverid = ${ServerID} and intf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, opack, oerrs, oerrs, odrop, oovr from linux_netstat where serverid = ${ServerID} and intf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
    done

    ##
    ##  the raw disk times charts are better WITHOUT being correctly time aligned
    ##

    ${ProgPrefix}/NewQuery fsr "select (readms + writms) from vxstat where vxtype = 'dm' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select (readms + writms) from vxstat where vxtype = 'vol' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat


    if [ $TESTMODE = 0 ]
    then
      echo "  Generating RAW iostat data..."
      ${ProgPrefix}/NewQuery fsr "select svctm from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and svctm != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, svctm" > ${PlotDataDir}/iostat_svctm-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select await from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and await != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, await" > ${PlotDataDir}/iostat_await-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select avgqusz from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgqusz != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgqusz" > ${PlotDataDir}/iostat_avgqusz-${ServerName}-${StartTime}_${EndTime}.dat

      ${ProgPrefix}/NewQuery fsr "select avgread from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgread != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgread" > ${PlotDataDir}/iostat_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select avgwrit from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgwrit != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgwrit" > ${PlotDataDir}/iostat_writkperop-${ServerName}-${StartTime}_${EndTime}.dat

      ##  with timestamps for combined charts

      ${ProgPrefix}/NewQuery fsr "select esttime, svctm from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and svctm != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, svctm" > ${PlotDataDir}/iostat_timesvctm-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, await from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and await != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, await" > ${PlotDataDir}/iostat_timeawait-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, avgqusz from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgqusz != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgqusz" > ${PlotDataDir}/iostat_timeavgqusz-${ServerName}-${StartTime}_${EndTime}.dat

      ${ProgPrefix}/NewQuery fsr "select esttime, avgread from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgread != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgread" > ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, avgwrit from linux_iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgwrit != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, avgwrit" > ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat

      if [ $NBServer = 1 ]
      then
        echo "    Generating RAW iostat TAPE data..."

	${ProgPrefix}/NewQuery fsr "select asvct from iostat where serverid = ${ServerID} and devtype = 3 and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_asvct_tape-${ServerName}-${StartTime}_${EndTime}.dat
	${ProgPrefix}/NewQuery fsr "select actv from iostat where serverid = ${ServerID} and devtype = 3 and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostat_actv_tape-${ServerName}-${StartTime}_${EndTime}.dat

      fi  ##  if generate tape data

    fi  ##  if generate raw iostat data

    if [ $NBServer = 1 ]
    then
      echo "    Generating TAPE iocalc data..."
      ${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_Rops-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_Wops-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, (ws_sum + rs_sum) from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_readk-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_writek-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_asvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg_a from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_weighted-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, adevices from iocalc_tape where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_tape_numdev-${ServerName}-${StartTime}_${EndTime}.dat
    fi  ##  if generate tape i/o stats
  fi  ##  if linux

  echo

}  ##  end of Make_Data_local

##
##

Make_Data_local_ll()
{

  echo
  echo "Creating data files..."

  echo "  $ServerName ($ServerID) $StartEpoch $EndEpoch"

  ##  without timestamps for curve fits

  ${ProgPrefix}/NewQuery fsr "select swap from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_statsswap-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select free from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_statsfree-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select us from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_statsuser-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select ( us + sys ) from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_statssystem-${ServerName}-${StartTime}_${EndTime}.dat

  ##  with timestamps for plotting

  ${ProgPrefix}/NewQuery fsr "select esttime, swap from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, free from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, psr from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_sr-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, pfpi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, pfpo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, pfpf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, pepi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, pepo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, pepf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, papi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, papo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, papf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, us from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_user-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, ( us + sys ) from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_system-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, rq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, bq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, wq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat

  ${ProgPrefix}/NewQuery fsr "select esttime, iin from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_intr-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, sy from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_syscall-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, cs from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_cswitch-${ServerName}-${StartTime}_${EndTime}.dat

  VeritasP=0
  for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
  do
    VeritasP=1
    VXfsnoslash=`echo $VXfilesystem | tr \/ \_`
    ## echo "    $VXfilesystem --> $VXfsnoslash"
    ${ProgPrefix}/NewQuery fsr "select esttime, Dtotlookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_totlookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, Dfstlookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_fstlookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, Dtotdlookup from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_totdlookup-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, Ddnlchitrat from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_dnlchitrat-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, ialloced from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ialloced-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ifreed from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ifreed-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, ilookups from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ilookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ihitrate from vxcache where serverid = ${ServerID} and vxfilesystem = '${VXfilesystem}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcache_ihitrate-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat

  done

  ${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_Wops-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, (ws_sum + rs_sum) from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg_a from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg_a from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat

  ##  without timestamps for curve fits

  ${ProgPrefix}/NewQuery fsr "select asvct_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_statsasvct-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select asvct_avg_a from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_statsweighted-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select wsvct_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_statswsvct-${ServerName}-${StartTime}_${EndTime}.dat
  ${ProgPrefix}/NewQuery fsr "select wsvct_avg_a from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_statswsvct_a-${ServerName}-${StartTime}_${EndTime}.dat

  ${ProgPrefix}/NewQuery fsr "select esttime, adevices from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat

  if [ "${VeritasP}" = "1" ]
  then
    ${ProgPrefix}/NewQuery fsr "select esttime, readops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readops_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writops_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writblk_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readblk_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, servtime from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, servtime from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_avg from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_max from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_avg from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_max from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_avg from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_max from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_avg from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_max from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, adevices from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, adevices from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat
    
    ##
    ##  the raw disk times charts are better WITHOUT being correctly time aligned
    ##

    ${ProgPrefix}/NewQuery fsr "select (readms + writms) from vxstat where vxtype = 'dm' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select (readms + writms) from vxstat where vxtype = 'vol' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat

  fi  ##  if veritas

  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct intf from netstat where serverid = ${ServerID}"`
  do
    ## echo "    $ServerName - $Interface"
    ${ProgPrefix}/NewQuery fsr "select esttime, ipack, ierrs from netstat where serverid = ${ServerID} and intf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, opack, oerrs, ocoll from netstat where serverid = ${ServerID} and intf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat

  done  ##  for each network interface

  if [ $TESTMODE = 0 ]
  then
    echo "  Generating RAW iostat data..."
    ${ProgPrefix}/NewQuery fsr "select asvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select wsvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and wsvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, wsvct" > ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select actv from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat
    
    ##  with timestamps for combined charts

    ${ProgPrefix}/NewQuery fsr "select esttime, asvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and wsvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, wsvct" > ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime actv from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and actv != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, actv" > ${PlotDataDir}/iostat_timeactv-${ServerName}-${StartTime}_${EndTime}.dat

  fi  ##  if generate raw iostat data

  echo

}

##
##

Mkplot_cpu_migrations_local()
{
  echo "Creating cpu migrations plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_migrate-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_migrate-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_migrate-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_migrate-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of migrations of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_migrate"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_migrate-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Migrations for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Migrations for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of migrations for each CPU
  ##

  echo "<li>Migration Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_migrate${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_migrate-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Migrations for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'Migrations' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_cpu_migrations_local



##
##

Mkplot_context_switches_local()
{

  echo  "Creating context switch plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinCSW=`cat ${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxCSW=`cat ${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`
  MinICSW=`cat ${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -n | head -1`
  MaxICSW=`cat ${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -n | tail -1`

  ## echo "    $MinX to $MaxX"
  ## echo "    $MinCSW to $MaxCSW"
  ## echo "    $MinICSW to $MaxICSW"

  ##
  ##  generate a single plot of CSW of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_context"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinCSW}:${MaxCSW}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Context Switches for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Context Switches for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinCSW to $MaxCSW" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate a single plot of ICSW of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_icontext"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinICSW}:${MaxICSW}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:3 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Involuntary Context Switches for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Involuntary Context Switches for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinICSW to $MaxICSW" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of CSW and ICSW for each CPU
  ##

  echo "<li>Context Switch Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_switches${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_switches-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    legendY=`expr $legendY - $legincY`
    echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Context Switches for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinCSW}:${MaxCSW}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'Context Swithes' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    plotIndex=`expr $plotIndex + 1`
    echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_context_switches_local

##
##

Mkplot_mpstat_intr()
{
  echo  "Creating cpu interrupt plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_intr-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_intr-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_intr-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_intr-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of interrupts of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_intr"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_intr-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Interrupts for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Interrupts for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of interrupts for each CPU
  ##

  echo "<li>Interrupt Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_intr${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_intr-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Interrupts for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'Interrupts' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_intr

##
##

Mkplot_mpstat_syscall()
{
  echo  "Creating cpu syscall plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_syscall-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_syscall-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_syscall-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_syscall-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of system calls of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_syscall"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_syscall-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - System Calls for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">System Calls for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of syscalls for each CPU
  ##

  echo "<li>System Call Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_syscall${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_syscall-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - System Calls for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'System Calls' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_syscall

##
##

Mkplot_mpstat_CPUusr()
{
  echo  "Creating cpu user cpu plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_usr-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_usr-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_usr-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_usr-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of user cpu of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_usr"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_usr-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - User CPU for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">User CPU for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of user cpu for each CPU
  ##

  echo "<li>User CPU Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_usr${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_usr-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - User CPU for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'User CPU' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_CPUusr

##
##

Mkplot_mpstat_CPUsys()
{
  echo  "Creating cpu sys cpu plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_sys-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_sys-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_sys-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_sys-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of system cpu of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_sys"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_sys-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - System CPU for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">System CPU for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of system cpu for each CPU
  ##

  echo "<li>System CPU Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_sys${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_sys-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - System CPU for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'System CPU' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_CPUsys

##
##

Mkplot_mpstat_CPUwait()
{
  echo  "Creating cpu wait cpu plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  if [ $MaxMIG = 0 ]
  then
    MaxMIG=0.1
  fi

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of wait cpu of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_wait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait CPU for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait CPU for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of wait cpu for each CPU
  ##

  echo "<li>Wait CPU Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_wait${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait CPU for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'Wait CPU' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_CPUwait

##
##

Mkplot_mpstat_CPUwait()
{
  echo  "Creating cpu wait cpu plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  if [ $MaxMIG = 0 ]
  then
    MaxMIG=0.1
  fi

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of wait cpu of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_wait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait CPU for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait CPU for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of wait cpu for each CPU
  ##

  echo "<li>Wait CPU Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_wait${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait CPU for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'Wait CPU' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_CPUwait

##
##

Mkplot_mpstat_CPUwait()
{
  echo  "Creating cpu wait cpu plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  if [ $MaxMIG = 0 ]
  then
    MaxMIG=0.1
  fi

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of wait cpu of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_wait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait CPU for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait CPU for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of wait cpu for each CPU
  ##

  echo "<li>Wait CPU Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_wait${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait CPU for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'Wait CPU' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_CPUwait

##
##

Mkplot_mpstat_CPUwait()
{
  echo  "Creating cpu wait cpu plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  if [ $MaxMIG = 0 ]
  then
    MaxMIG=0.1
  fi

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of wait cpu of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_wait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait CPU for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait CPU for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of wait cpu for each CPU
  ##

  echo "<li>Wait CPU Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_wait${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_wait-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait CPU for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'Wait CPU' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_CPUwait

##
##

Mkplot_mpstat_SPINmutex()
{
  echo  "Creating cpu spin mutex plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_smtx-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_smtx-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_smtx-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_smtx-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  if [ $MaxMIG = 0 ]
  then
    MaxMIG=0.1
  fi

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of mutex spin of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_smtx"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_smtx-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Mutex Spin for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Mutex Spin for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of mutex spin for each CPU
  ##

  echo "<li>Mutex Spin Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_smtx${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_smtx-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Mutex Spin for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'Mutex Spin' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_SPINmutex

##
##

Mkplot_mpstat_SPINrwlock()
{
  echo  "Creating cpu spin RWlock plot scripts..."

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/mpstat_srw-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/mpstat_srw-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`
  MinMIG=`cat ${PlotDataDir}/mpstat_srw-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxMIG=`cat ${PlotDataDir}/mpstat_srw-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`

  if [ $MaxMIG = 0 ]
  then
    MaxMIG=0.1
  fi

  ## echo "MinX:    $MinX"
  ## echo "MaxX:    $MaxX"
  ## echo "MinMIG:  $MinMIG"
  ## echo "MaxMIG:  $MaxMIG"

  ##
  ##  generate a single plot of RWlock spin of all CPUs
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_srw"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for CPU in $CPUs
  do

    DataFilePath=${PlotDataDir}/mpstat_srw-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`
    LegendText=CPU${CPU}
    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each CPU

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - RW Lock Spin for all CPUs'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">RW Lock Spin for all CPUs</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinMIG to $MaxMIG" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


  ##
  ##  generate plots of rwlock spin for each CPU
  ##

  echo "<li>RW Lock Spin Graphs of individual CPUs:" >> ${WebDir}/index.html
  echo "<blockquote>" >> ${WebDir}/index.html
  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html

  for CPU in $CPUs
  do

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_srw${CPU}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    DataFilePath=${PlotDataDir}/mpstat_srw-${ServerName}-${StartTime}_${EndTime}-${CPU}.dat 
    DataFile=`basename $DataFilePath`

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  plotting from $DataFile"

    ##  set the legend text

    echo "set label \"Migrations\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ## legendY=`expr $legendY - $legincY`
    ## echo "set label \"Inv Context Switches\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - RW Lock Spin for CPU ${CPU}'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${MinMIG}:${MaxMIG}]" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries for context switches

    echo "plot \"${DataFilePath}\" using 1:2 title 'RW Lock Spin' with linespoints linestyle 1" >> ${WorkDir}/${PlotScript}
    ## plotIndex=`expr $plotIndex + 1`
    ## echo "plot \"${DataFilePath}\" using 1:3 title 'Inv Context Swithes' with linespoints linestyle 2" >> ${WorkDir}/${PlotScript}

    ##  add entry to web page

    echo -n " <a href=\"${GFileBase}-${resX}x${resY}.png\">${CPU}</a> " >> ${WebDir}/index.html

  done  ##  for each CPU

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_mpstat_SPINrwlock

##
##


Mkplot_CPUxRQ_local()
{

  echo  "Creating CPU vs run queue plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_vmstatCPUxRQ"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  CPUminY=0
  CPUmaxY=100

  CPUDataFilePath=${PlotDataDir}/vmstat_system-${ServerName}-${StartTime}_${EndTime}.dat
  CPUDataFile=`basename $CPUDataFilePath`
  CPULegendText=`echo $CPUDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`

  RQDataFilePath=${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat
  RQminY=`cat ${RQDataFilePath} | awk '{ print $2 }' | sort -un | head -1`
  RQmaxY=`cat ${RQDataFilePath} | awk '{ print $2 }' | sort -un | tail -1`
  if [ $RQmaxY = 0 ]
  then
    RQmaxY=1
  fi
  minX=`cat ${RQDataFilePath} | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${RQDataFilePath} | awk '{ print $1 }' | sort -un | tail -1`

  LegendText="$ServerName - $StartTime to $EndTime - CPU Usage vs. Run Queue"

  ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
  ## echo "  x:  $minX to $maxX"
  ## echo "  RQ: $RQminY to $RQmaxY"
  ## echo "  CPU: $CPUminY to $CPUmaxY"
  ## echo "  CPUDataFile       $CPUDataFile"
  ## echo "  CPUDataFilePath:  $CPUDataFilePath"
  ## echo "  RQDataFilePath:   $RQDataFilePath"
  ## echo

  ##  create the gnuplot script header

  echo "set label \"CPU\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  legendY=`expr $legendY - $legincY`
  echo "set label \"run queue\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo "set multiplot title '${LegendText} - CPU vs run queue'" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${CPUminY}:${CPUmaxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${RQminY}:${RQmaxY}]" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
  echo "plot \"${CPUDataFilePath}\" using 1:2 title 'CPU' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
  ## echo "set yrange [${RQminY}:${RQmaxY}]" >> ${WorkDir}/${PlotScript}
  echo "plot \"${RQDataFilePath}\" using 1:2 title 'run queue' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  ## plotIndex=`expr $plotIndex + 1`

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">CPU vs Run Queue</a>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_CPUxRQ_local


##
##

Mkplot_server_syscalls()
{

  echo "Creating server-wide syscalls plot scripts..."

  ##
  ##  interrupts
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_vmstatintr"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_intr-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_intr-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_intr-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_intr-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_intr-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Server-Wide Interrupts'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Server-Wide Interrupts</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY<br>" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  system calls
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_vmstatsyscalls"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_syscall-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_syscall-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_syscall-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_syscall-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_syscall-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Server-Wide System Calls'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Server-Wide System Calls</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY<br>" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  context switches
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1150_vmstatcswitch"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_cswitch-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_cswitch-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_cswitch-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_cswitch-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_cswitch-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Server-Wide Context Switches'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Server-Wide Context Switches</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY<br>" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_server_syscalls

##
##

Mkplot_procbymem_local()
{

  echo "Creating Process by Memory data files..."

  rm -f ${PlotDataDir}/ProcMemMap-${ServerName}-${StartTime}_${EndTime}.dat
  rm -f ${PlotDataDir}/procmem_pctmem-${ServerName}-${StartTime}_${EndTime}-*.dat

  for PID in `${ProgPrefix}/NewQuery fsr "select distinct pmPID from procbymem where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by pmPID"`
  do
    ## echo "  PID $PID"
    CommandIndex=0
    ${ProgPrefix}/NewQuery fsr "select distinct pmCommand from procbymem where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and pmPID = ${PID} order by pmCommand" > tmp_graphSS_combypid
    exec 4<tmp_graphSS_combypid
    while read -u4 Command
    do
      ## echo "  $PID - $CommandIndex - $Command"

      ##  generate the data files for pic/command and measurement

      ${ProgPrefix}/NewQuery fsr "select esttime, pmpctmem from procbymem where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} and pmPID = ${PID} and pmCommand = '${Command}' and pmpctmem > 0.0 order by esttime" > ${PlotDataDir}/procmem_pctmem-${ServerName}-${StartTime}_${EndTime}-${PID}_${CommandIndex}.dat
      ${ProgPrefix}/NewQuery fsr "select esttime, pmMemSize from procbymem where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} and pmPID = ${PID} and pmCommand = '${Command}' and pmMemSize > 0.0 order by esttime" > ${PlotDataDir}/procmem_memsize-${ServerName}-${StartTime}_${EndTime}-${PID}_${CommandIndex}.dat

      echo "${PID}_${CommandIndex}: ${Command}" >> ${PlotDataDir}/ProcMemMap-${ServerName}-${StartTime}_${EndTime}.dat

      ##  increment stuff and loop again
      CommandIndex=`expr $CommandIndex + 1`
    done  ##  for each command matching PID
    exec 4<&-
  done  ##  for each PID in range

  ##
  ##  produce the individual graphs for the specific measurements
  ##

  ##  determine overall time range

  ProcMemStartEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from procbymem where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch}"`
  ProcMemEndEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from procbymem where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch}"`
  ## echo "  From `./FromEpoch $ProcMemStartEpoch` to `./FromEpoch $ProcMemEndEpoch`"
  ## minX=$ProcMemStartEpoch
  ## maxX=$ProcMemEndEpoch

  minX=$ProcMemStartEpoch
  maxX=$ProcMemEndEpoch

  ##  process percent memory used

  echo "  Generating percent memory used plot script..."

  minY=`cat ${PlotDataDir}/procmem_pctmem-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -nu | head -1`
  maxY=`cat ${PlotDataDir}/procmem_pctmem-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -nu | tail -1`

  ## echo "    Y from $minY to $maxY"

  if [ $minY = $maxY -a $minY = 0.1 ]
  then
    minY=0.0
    ## echo "      Y from $minY to $maxY - ADJUSTED"
  fi

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2000_procmempmem"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for DataFilePath in ${PlotDataDir}/procmem_pctmem-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ## echo "      $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\. '{ print $1 }' | awk -F\- '{ print $NF }'`
    ## echo "        $LegendText"

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each pctmem file

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Percent of Memory Allocated by Process'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Percent of Memory Used by Processes</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##  process memory size

  echo "  Generating memory size plot script..."

  minY=`cat ${PlotDataDir}/procmem_memsize-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -nu | head -1`
  maxY=`cat ${PlotDataDir}/procmem_memsize-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -nu | tail -1`

  if [ $minY -eq $maxY ]
  then
    ## maxY=`expr $minY * 0.5 + $minY`
    maxY=`expr $minY / 4 + $minY`
  fi

  ## echo "    Y from $minY to $maxY"

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2010_procmemsize"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for DataFilePath in ${PlotDataDir}/procmem_memsize-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ## echo "      $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\. '{ print $1 }' | awk -F\- '{ print $NF }'`
    ## echo "        $LegendText"

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each memsize file

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Amount of Memory Used by Process (Bytes)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Amount of Memory Used by Processes</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_procbymem_local

##
##

Mkplot_procbycpu_local()
{

  echo "Creating Process by CPU data files..."

  rm -f ${PlotDataDir}/ProcCPUMap-${ServerName}-${StartTime}_${EndTime}.dat

  minY=0
  maxY=0

  for PID in `${ProgPrefix}/NewQuery fsr "select distinct pmPID from procbycpu where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and pmpctcpu > 0.0 order by pmPID"`
  do
    ## echo "  PID $PID"
    CommandIndex=0
    ${ProgPrefix}/NewQuery fsr "select distinct pmCommand from procbycpu where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and pmPID = ${PID} and pmpctcpu > 0.0 order by pmCommand" > tmp_graphSS_combypid
    exec 4<tmp_graphSS_combypid
    while read -u4 Command
    do
      ## echo "  $PID - $CommandIndex - $Command"

      ##  generate the data files for pic/command and measurement

      ${ProgPrefix}/NewQuery fsr "select esttime, pmpctcpu from procbycpu where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} and pmPID = ${PID} and pmCommand = '${Command}' and pmpctcpu > 0.0 order by esttime" > ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-${PID}_${CommandIndex}.dat

      fileminY=`cat ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-${PID}_${CommandIndex}.dat | awk '{ print $2 }' | sort -nu | head -1`
      filemaxY=`cat ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-${PID}_${CommandIndex}.dat | awk '{ print $2 }' | sort -nu | tail -1`

      if [ $fileminY -lt $minY ]
      then
	minY=$fileminY
      fi

      if [ $filemaxY -gt $maxY ]
      then
	maxY=$filemaxY
      fi

      echo "${PID}_${CommandIndex}: ${Command}" >> ${PlotDataDir}/ProcCPUMap-${ServerName}-${StartTime}_${EndTime}.dat

      ##  increment stuff and loop again
      CommandIndex=`expr $CommandIndex + 1`
    done  ##  for each command matching PID
    exec 4<&-
  done  ##  for each PID in range

  ##
  ##  produce the individual graphs for the specific measurements
  ##

  ##  determine overall time range

  ProcCPUStartEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from procbycpu where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} and pmpctcpu > 0.0"`
  ProcCPUEndEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from procbycpu where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} and pmpctcpu > 0.0"`

  ## echo
  ## echo "  `/bin/pwd`"
  ## echo "  From $ProcCPUStartEpoch to $ProcCPUEndEpoch"
  ## echo "  From `./FromEpoch $ProcCPUStartEpoch` to `./FromEpoch $ProcCPUEndEpoch`"
  
  minX=$ProcCPUStartEpoch
  maxX=$ProcCPUEndEpoch

  minX=$StartEpoch
  maxX=$EndEpoch

  ##  process percent CPU used

  echo "  Generating percent CPU used plot script..."

  ## minY=`cat ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -nu | head -1`
  ## maxY=`cat ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -nu | tail -1`

  ## echo "    Y from $minY to $maxY"
  ## echo

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2020_proccpupcpu"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for DataFilePath in ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ## echo "      $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\. '{ print $1 }' | awk -F\- '{ print $NF }'`
    ## echo "        $LegendText"

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each pctcpu file

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Percent of CPU Used by Process'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Percent of CPU Used by Process</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_procbycpu_local

##
##

Mkplot_netinput_local()
{

  echo "Creating network input plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_netstatInput"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | tail -1`

  minIpack=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxIpack=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  minIerrs=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | head -1`
  maxIerrs=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | tail -1`

  InputErrorsText="$minIerrs to $maxIerrs"

  if [ $maxIpack = 0 ]
  then
    maxIpack=1
  fi

  if [ $maxIerrs = 0 ]
  then
    maxIerrs=1
  fi

  if [ $maxIpack -gt $maxIerrs ]
  then
    maxY=$maxIpack
  else
    maxY=$maxIerrs
  fi

  if [ $minIpack -lt $minIerrs ]
  then
    minY=$minIpack
  else
    minY=$minIerrs
  fi

  ## echo "  X from $minX to $maxX"
  ## echo "  Y from $minY to $maxY"
  ## echo "  Ipack from $minIpack to $maxIpack"
  ## echo "  ierrs from $minIerrs to $maxIerrs"

  for DataFilePath in ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ## echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    ## echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText} Packets\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    ##  input packets

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  input errors

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:3 title '${LegendText}' with linespoints linestyle `expr ${plotIndex} + 1`" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY - $legincY`
    plotIndex=`expr $plotIndex + 2`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Network Input Statistics (Count)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Input Packets and Errors</a>: ALL" >> ${WebDir}/index.html
  ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ##  echo "Input packets from $minIpack to $maxIpack <br>" >> ${WebDir}/index.html
  ##  echo "Input errors from $InputErrorsText" >> ${WebDir}/index.html
  ##  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  now for each individual interface...
  ##

  echo "<blockquote>" >> ${WebDir}/index.html
  echo "<table cellpadding=3 cellspacing=5>" >> ${WebDir}/index.html
  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct intf from netstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by intf"`
  do
    echo "  $Interface"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_${Interface}_1100_netstatInput"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  find the ranges

    minX=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $1 }' | sort -un | tail -1`

    minIpack=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxIpack=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minIerrs=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $3 }' | sort -un | head -1`
    maxIerrs=`cat ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $3 }' | sort -un | tail -1`

    InputErrorsText="$minIerrs to $maxIerrs"

    if [ $maxIpack = 0 ]
    then
	maxIpack=1
    fi

    if [ $maxIerrs = 0 ]
    then
	maxIerrs=1
    fi

    if [ $maxIpack -gt $maxIerrs ]
    then
	maxY=$maxIpack
    else
	maxY=$maxIerrs
    fi

    if [ $minIpack -lt $minIerrs ]
    then
	minY=$minIpack
    else
	minY=$minIerrs
    fi

    ## echo "  X from $minX to $maxX"
    ## echo "  Y from $minY to $maxY"
    ## echo "  Ipack from $minIpack to $maxIpack"
    ## echo "  ierrs from $minIerrs to $maxIerrs"

    for DataFilePath in ${PlotDataDir}/netstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
    do
      ## echo "    $DataFilePath"
      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
      ## echo "      $DataFile - $LegendText"

      ##  set the legend text

      echo "set label \"${LegendText} Packets\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
      nextLegend=`expr $legendY - $legincY`
      echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    ##  input packets

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  input errors

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:3 title '${LegendText}' with linespoints linestyle `expr ${plotIndex} + 1`" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY - $legincY`
    plotIndex=`expr $plotIndex + 2`

    done  ##  for each data file for this interface

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Network Input Statistics (Count)'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<tr><td><a href=\"${GFileBase}-${resX}x${resY}.png\">${Interface}</a>:</td>" >> ${WebDir}/index.html
    echo "<td class=\"summary\">Input packets from $minIpack to $maxIpack</td>" >> ${WebDir}/index.html
    echo "<td class=\"summary\">- Input errors from $InputErrorsText</td></tr>" >> ${WebDir}/index.html

  done  ##  for each interface with netstat stats
  echo "</table>" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end Mkplot_netinput_local

##
##

Mkplot_netoutput_local()
{

  echo "Creating network output plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_netstatOutput"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | tail -1`

  minOpack=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxOpack=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  minOerrs=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | head -1`
  maxOerrs=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | tail -1`

  minOcoll=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -un | head -1`
  maxOcoll=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -un | tail -1`

  OutputErrorsText="$minOerrs to $maxOerrs"

  if [ $maxOpack = 0 ]
  then
    maxOpack=1
  fi

  if [ $maxOerrs = 0 ]
  then
    maxOerrs=1
  fi

  if [ $maxOpack -gt $maxOerrs ]
  then
    maxY=$maxOpack
  else
    maxY=$maxOerrs
  fi

  if [ $minOpack -lt $minOerrs ]
  then
    minY=$minOpack
  else
    minY=$minOerrs
  fi

  ## echo "  X from $minX to $maxX"
  ## echo "  Y from $minY to $maxY"
  ## echo "  Opack from $minOpack to $maxOpack"
  ## echo "  Oerrs from $minOerrs to $maxOerrs"
  ## echo "  Ocoll from $minOcoll to $maxOcoll"

  for DataFilePath in ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ## echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    ## echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText} Packets\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY - $legincY`
    echo "set label \"${LegendText} Coll\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 2` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    ##  output packets

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  output errors

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:3 title '${LegendText}' with linespoints linestyle `expr ${plotIndex} + 1`" >> ${WorkDir}/${PlotScript}.$$

    ##  output collisions

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle `expr ${plotIndex} + 2`" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY - $legincY - $legincY`
    plotIndex=`expr $plotIndex + 3`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Network Output Statistics (Count)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Output Packets, Errors and Collisions</a>: ALL" >> ${WebDir}/index.html
  ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ##  echo "Out packets from $minOpack to $maxOpack<br>" >> ${WebDir}/index.html
  ##  echo "Output errors from $OutputErrorsText<br>" >> ${WebDir}/index.html
  ##  echo "Out collisions from $minOcoll to $maxOcoll" >> ${WebDir}/index.html
  ##  echo "</blockquote>" >> ${WebDir}/index.html


  echo "<blockquote>" >> ${WebDir}/index.html
  echo "<table cellpadding=3 cellspacing=5>" >> ${WebDir}/index.html
  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct intf from netstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by intf"`
  do
    echo "  ${Interface}"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_${Interface}_1100_netstatOutput"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  find the ranges

    minX=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $1 }' | sort -un | tail -1`

    minOpack=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxOpack=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minOerrs=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $3 }' | sort -un | head -1`
    maxOerrs=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $3 }' | sort -un | tail -1`

    minOcoll=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $4 }' | sort -un | head -1`
    maxOcoll=`cat ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $4 }' | sort -un | tail -1`

    OutputErrorsText="$minOerrs to $maxOerrs"

    if [ $maxOpack = 0 ]
    then
	maxOpack=1
    fi

    if [ $maxOerrs = 0 ]
    then
	maxOerrs=1
    fi

    if [ $maxOpack -gt $maxOerrs ]
    then
	maxY=$maxOpack
    else
	maxY=$maxOerrs
    fi

    if [ $minOpack -lt $minOerrs ]
    then
	minY=$minOpack
    else
	minY=$minOerrs
    fi

    ## echo "  X from $minX to $maxX"
    ## echo "  Y from $minY to $maxY"
    ## echo "  Opack from $minOpack to $maxOpack"
    ## echo "  Oerrs from $minOerrs to $maxOerrs"
    ## echo "  Ocoll from $minOcoll to $maxOcoll"

    for DataFilePath in ${PlotDataDir}/netstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
    do
      ## echo "    $DataFilePath"
      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
      ## echo "      $DataFile - $LegendText"

      ##  set the legend text

      echo "set label \"${LegendText} Packets\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
      nextLegend=`expr $legendY - $legincY`
      echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
      nextLegend=`expr $legendY - $legincY - $legincY`
      echo "set label \"${LegendText} Coll\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 2` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entries to a temp file

      ##  output packets

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
      echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

      ##  output errors

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
      echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:3 title '${LegendText}' with linespoints linestyle `expr ${plotIndex} + 1`" >> ${WorkDir}/${PlotScript}.$$

      ##  output collisions

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
      echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle `expr ${plotIndex} + 2`" >> ${WorkDir}/${PlotScript}.$$


      ##  increment stuff and loop again
      legendY=`expr $legendY - $legincY - $legincY - $legincY`
      plotIndex=`expr $plotIndex + 3`
    done  ##  for each DataFilePath for this interface

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Network Output Statistics (Count)'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<tr><td><a href=\"${GFileBase}-${resX}x${resY}.png\">${Interface}</a>:</td>" >> ${WebDir}/index.html
    echo "<td class=\"summary\">Out packets from $minOpack to $maxOpack</td>" >> ${WebDir}/index.html
    echo "<td class=\"summary\">- Output errors from $OutputErrorsText</td>" >> ${WebDir}/index.html
    echo "<td class=\"summary\">- Out collisions from $minOcoll to ${maxOcoll}</td></tr>" >> ${WebDir}/index.html

  done  ##  for each interface with netstat data
  echo "</table>" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end Mkplot_netoutput_local

##
##

Mkplot_swap_free_linux()
{
  echo "Creating Linux swap + free plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatSwapFree"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_swpd-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_swpd-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_swpd-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_swpd-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  echo "  X:  $minX to $maxX"
  echo "  Y:  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_swpd-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Virtual Memory used and Free Memory (KBytes)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  minSwap=`cat ${PlotDataDir}/vmstat_swpd-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxSwap=`cat ${PlotDataDir}/vmstat_swpd-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  echo "  minSwap: $minSwap"
  echo "  maxSwap: $maxSwap"

  EpochMinSwap=`${ProgPrefix}/NewQuery fsr "select esttime from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and swpd = ${minSwap} order by esttime" | head -1`
  EpochMaxSwap=`${ProgPrefix}/NewQuery fsr "select esttime from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and swpd = ${maxSwap} order by esttime" | head -1`

  echo "  EpochMinSwap:  $EpochMinSwap"
  echo "  EpochMaxSwap:  $EpochMaxSwap"

  TimeMinSwap=`FromEpoch $EpochMinSwap`
  TimeMaxSwap=`FromEpoch $EpochMaxSwap`

  minFree=`cat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxFree=`cat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  echo "  minFree:  $minFree"
  echo "  maxFree:  $maxFree"

  EpochMinFree=`${ProgPrefix}/NewQuery fsr "select esttime from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and free = ${minFree} order by esttime"`
  EpochMaxFree=`${ProgPrefix}/NewQuery fsr "select esttime from linux_vmstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and free = ${maxFree} order by esttime"`

  echo "  EpochMinFree:  $EpochMinFree"
  echo "  EpochMaxFree:  $EpochMaxFree"

  TimeMinFree=`FromEpoch $EpochMinFree`
  TimeMaxFree=`FromEpoch $EpochMaxFree`

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Used Virtual Memory and Free Memory</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Allocated Virtual Memory from $minSwap to $maxSwap kbytes<br>" >> ${WebDir}/index.html
  echo "Available Free memory from $minFree to $maxFree kbytes" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  add trend code here
  ##

  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "<p>Swap from $minSwap kbytes at $TimeMinSwap to $maxSwap kbytes at $TimeMaxSwap" >> ${WebDir}/index.html
  echo "<p>Swap from $minSwap to $maxSwap kbytes" >> ${WebDir}/index.html
  echo "<br>Free from $minFree kbytes at $TimeMinFree to $maxFree kbytes at $TimeMaxFree</p>" >> ${WebDir}/index.html
  echo "<br>Free from $minFree to $maxFree kbytes</p>" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


}

##
##

Mkplot_swap_free_local()
{

  echo "Creating swap + free plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatSwapFree"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Free Swap and Memory (KBytes)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  minSwap=`cat ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxSwap=`cat ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  EpochMinSwap=`${ProgPrefix}/NewQuery fsr "select esttime from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} and swap = ${minSwap} order by esttime"`
  EpochMaxSwap=`${ProgPrefix}/NewQuery fsr "select esttime from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} and swap = ${maxSwap} order by esttime"`

  TimeMinSwap=`FromEpoch $EpochMinSwap`
  TimeMaxSwap=`FromEpoch $EpochMaxSwap`

  minFree=`cat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxFree=`cat ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  EpochMinFree=`${ProgPrefix}/NewQuery fsr "select esttime from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} and free = ${minFree} order by esttime"`
  EpochMaxFree=`${ProgPrefix}/NewQuery fsr "select esttime from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} and free = ${maxFree} order by esttime"`

  TimeMinFree=`FromEpoch $EpochMinFree`
  TimeMaxFree=`FromEpoch $EpochMaxFree`

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Swap and Free Memory</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Available Swap from $minSwap to $maxSwap kbytes<br>" >> ${WebDir}/index.html

  ##
  ##  add trend code here
  ##

  echo "Available Free memory from $minFree to $maxFree kbytes" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  add trend code here
  ##

  ## echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ## echo "<p>Swap from $minSwap kbytes at $TimeMinSwap to $maxSwap kbytes at $TimeMaxSwap" >> ${WebDir}/index.html
  ## echo "<p>Swap from $minSwap to $maxSwap kbytes" >> ${WebDir}/index.html
  ## echo "<br>Free from $minFree kbytes at $TimeMinFree to $maxFree kbytes at $TimeMaxFree</p>" >> ${WebDir}/index.html
  ## echo "<br>Free from $minFree to $maxFree kbytes</p>" >> ${WebDir}/index.html
  ## echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_swap_free_local

Mkplot_sr_local()
{

  echo "Creating SR plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1110_vmstatSR"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_sr-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_sr-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_sr-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_sr-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  SRRangeWording="From $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_sr-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Scan Rate'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Scan Rate</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "$SRRangeWording" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_sr_local

##
##

Mkplot_epaging_local()
{

  echo "Creating executable paging plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1120_vmstatepage"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  EPFminY=`cat ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  EPIminY=`cat ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  EPOminY=`cat ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`

  EPFmaxY=`cat ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPImaxY=`cat ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOmaxY=`cat ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`


  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_epi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epo-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_epf-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Executable Paging Rates'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Executable Paging Rates</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Page Ins from $EPIminY to $EPImaxY<br>" >> ${WebDir}/index.html
  echo "Page Outs from $EPOminY to $EPOmaxY<br>" >> ${WebDir}/index.html
  echo "Page Faults from $EPFminY to $EPFmaxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_epaging_local

##
##

Mkplot_apaging_local()
{

  echo "Creating anonymous paging plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1121_vmstatapage"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  APFminY=`cat ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  APIminY=`cat ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  APOminY=`cat ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`

  APFmaxY=`cat ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  APImaxY=`cat ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  APOmaxY=`cat ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_api-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_apo-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_apf-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Data Paging Rates'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Data Paging Rates</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Page Ins from $APIminY to $APImaxY<br>" >> ${WebDir}/index.html
  echo "Page Outs from $APOminY to $APOmaxY<br>" >> ${WebDir}/index.html
  echo "Page Faults from $APFminY to $APFmaxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_apaging_local

##
##

Mkplot_fpaging_local()
{

  echo "Creating file paging plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1122_vmstatfpage"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  FPFminY=`cat ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  FPIminY=`cat ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  FPOminY=`cat ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`

  FPFmaxY=`cat ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  FPImaxY=`cat ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  FPOmaxY=`cat ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_fpi-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpo-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_fpf-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - File Paging Rates'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">File Paging Rates</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Page Ins from $FPIminY to $FPImaxY<br>" >> ${WebDir}/index.html
  echo "Page Outs from $FPOminY to $FPOmaxY<br>" >> ${WebDir}/index.html
  echo "Page Faults from $FPFminY to $FPFmaxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_fpaging_local

##
##

Mkplot_cpu_local()
{

  echo "Creating CPU usage plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1130_vmstatcpu"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  define the function to compute/plot the trendline

  ##  echo "y(x) = m*x+c" >> ${WorkDir}/${PlotScript}  ##  linear regression
  ##  echo "y(x) = m*x**c" >> ${WorkDir}/${PlotScript}  ##  
  ##  echo "y(x) = m*exp(-x*c)" >> ${WorkDir}/${PlotScript}  ##  

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_system-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_system-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  CPUminY=`cat ${PlotDataDir}/vmstat_system-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  CPUmaxY=`cat ${PlotDataDir}/vmstat_system-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minY=0
  maxY=100

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"
  ## echo "  $CPUminY to $CPUmaxY"

  for DataFilePath in ${PlotDataDir}/vmstat_user-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_system-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font '${legfontName},$legfontSize'" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  echo "fit y(x) '${DataFilePath}' using 1:2 via m, c" >> ${WorkDir}/${PlotScript}.$$
    ##  echo "plot y(x) title '${LegendText} trend' linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - CPU Usage (Percent - Stacked)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">CPU Usage</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $CPUminY to $CPUmaxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_cpu_local

##
##

Mkplot_kqueues_local()
{

  echo "Creating kernel queues plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1140_vmstatqueues"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  RUNminY=`cat ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  BLOCKminY=`cat ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  WAITminY=`cat ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`

  RUNmaxY=`cat ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  BLOCKmaxY=`cat ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  WAITmaxY=`cat ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`


  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_rqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_bqueue-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vmstat_wqueue-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Kernel Thread Counts'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Kernel Thread Counts</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Run queue from $RUNminY to $RUNmaxY" >> ${WebDir}/index.html
  echo "<br>Blocked queue from $BLOCKminY to  $BLOCKmaxY" >> ${WebDir}/index.html
  echo "<br>Wait queue from $WAITminY to $WAITmaxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_kqueues_local

##
##

Mkplot_iorwops_local()
{

  echo "Creating iocalc read + write ops plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_iocalcrwops"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges


  ## minY=`cat ${PlotDataDir}/iocalc_rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wops-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/iocalc_rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wops-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  minX=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadOps=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadOps=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteOps=`cat ${PlotDataDir}/iocalc_Wops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteOps=`cat ${PlotDataDir}/iocalc_Wops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Averaged Read and Write Operations (stacked)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Averaged R/W Ops</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read ops from $minReadOps to $maxReadOps" >> ${WebDir}/index.html
  echo "<br>Write ops from $minWriteOps to $maxWriteOps" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iorwops_local

##
##

Mkplot_iorwk_local()
{

  echo "Creating iocalc read + write K plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1220_iocalcrwk"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteK=`cat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Averaged Read and Write KBytes'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Averaged R/W KBytes</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read Kbytes from $minReadK to $maxReadK" >> ${WebDir}/index.html
  echo "<br>Write Kbytes rom $minWriteK to $maxWriteK" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "Creating iocalc read + write K per op plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1225_iocalckperop"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteK=`cat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Averaged Read and Write KBytes per operation'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Averaged R/W KBytes per Operation</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read Kbytes from $minReadK to $maxReadK" >> ${WebDir}/index.html
  echo "<br>Write Kbytes rom $minWriteK to $maxWriteK" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iorwk_local

##
##

Mkplot_ioawtrans_local()
{

  echo "Creating iocalc active + wait transactions plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1230_iocalcawtrans"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Averaged Active and Wait Transaction Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Averaged Disk Transactions</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Wait transactions from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Active transactions from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_ioawtrans_local

##
##

Mkplot_iodevcount_local()
{

  echo "Creating iocalc devcount plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1250_iocalcdevcount"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Device Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Path Count</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iodevcount_local

##
##

Mkplot_ioaasvct_local()
{

  echo "Creating iocalc service time weighted average plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1240_iocalcaasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWAsvct=`cat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWAsvct=`cat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minAsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Weighted Average Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  ##
  ##  create the index.html entry
  ##

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Average Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average service time from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  echo "<br>Weighted average service time from $minWAsvct to $maxWAsvct" >> ${WebDir}/index.html

  ##
  ##  create the trend plot - use weighted service times
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1242_iocalctrendasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iocalc_statsweighted-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Weighted Average Service Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ## echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average Weighted Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ## echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_ioaasvct_local

##
##

Mkplot_iowasvct_local()
{

  echo "Creating iocalc wait time weighted average plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1240_iocalcwasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWWsvct=`cat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWWsvct=`cat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minWsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Weighted Average Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Average Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average wait time from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Weighted average wait time from $minWWsvct to $maxWWsvct" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1242_iocalctrendwasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iocalc_statswsvct_a-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Weighted Average Wait Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iowasvct_local

##
##

Mkplot_iolundata_local()
{

  echo "Creating iostat individual LUN data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatlundata"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minY=`cat ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##  create the frequencey distribution plot script
  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatlunhist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1
  ##  create the gnuplot script header
  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Service Time Histogram (ms)'" >> ${WorkDir}/${PlotScript}

  echo "n=20 #number of intervals" >> ${WorkDir}/${PlotScript}
  echo "max=$maxY #max value" >> ${WorkDir}/${PlotScript}
  echo "min=$minY #min value" >> ${WorkDir}/${PlotScript}
  echo "width=(max-min)/n #interval width" >> ${WorkDir}/${PlotScript}
  echo "#function used to map a value to the intervals" >> ${WorkDir}/${PlotScript}
  echo "hist(x,width)=width*floor(x/width)+width/2.0" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [min:max]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [min:]" >> ${WorkDir}/${PlotScript}
  if [ $maxY -gt 1000 ]
  then
    echo "set yrange [0:1000]" >> ${WorkDir}/${PlotScript}
  else
    echo "set yrange [0:$maxY]" >> ${WorkDir}/${PlotScript}
  fi
  echo "#to put an empty boundary around the" >> ${WorkDir}/${PlotScript}
  echo "#data inside an autoscaled graph." >> ${WorkDir}/${PlotScript}
  echo "set size 0.99,0.97"  >> ${WorkDir}/${PlotScript}
  echo "set xtics min,(max-min)/5,max" >> ${WorkDir}/${PlotScript}
  echo "set boxwidth width*0.9" >> ${WorkDir}/${PlotScript}
  echo "set style fill solid 0.75 #fillstyle" >> ${WorkDir}/${PlotScript}
  echo "set tics out nomirror" >> ${WorkDir}/${PlotScript}
  echo "set xlabel \"x\"" >> ${WorkDir}/${PlotScript}
  echo "set ylabel \"Frequency\"" >> ${WorkDir}/${PlotScript}
  echo "#count and plot" >> ${WorkDir}/${PlotScript}
  echo "plot \"${DataFilePath}\" u (hist(\$1,width)):(1.0) smooth freq w boxes lc rgb \"red\" notitle" >> ${WorkDir}/${PlotScript}
  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Service Time Histogram</a>" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1262_iostattrendlunhist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Service Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolundata_local

##
##

Mkplot_iolunwait_local()
{

  echo "Creating iostat individual LUN wait plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatlunwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minY=`cat ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##  create the frequencey distribution plot script
  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatwaithist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1
  ##  create the gnuplot script header
  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Wait Time Histogram (ms)'" >> ${WorkDir}/${PlotScript}

  echo "n=20 #number of intervals" >> ${WorkDir}/${PlotScript}
  echo "max=$maxY #max value" >> ${WorkDir}/${PlotScript}
  echo "min=$minY #min value" >> ${WorkDir}/${PlotScript}
  echo "width=(max-min)/n #interval width" >> ${WorkDir}/${PlotScript}
  echo "#function used to map a value to the intervals" >> ${WorkDir}/${PlotScript}
  echo "hist(x,width)=width*floor(x/width)+width/2.0" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [min:max]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [min:]" >> ${WorkDir}/${PlotScript}
  if [ $maxY -gt 1000 ]
  then
    echo "set yrange [0:1000]" >> ${WorkDir}/${PlotScript}
  else
    echo "set yrange [0:$maxY]" >> ${WorkDir}/${PlotScript}
  fi
  echo "#to put an empty boundary around the" >> ${WorkDir}/${PlotScript}
  echo "#data inside an autoscaled graph." >> ${WorkDir}/${PlotScript}
  echo "set size 0.99,0.97"  >> ${WorkDir}/${PlotScript}
  echo "set xtics min,(max-min)/5,max" >> ${WorkDir}/${PlotScript}
  echo "set boxwidth width*0.9" >> ${WorkDir}/${PlotScript}
  echo "set style fill solid 0.75 #fillstyle" >> ${WorkDir}/${PlotScript}
  echo "set tics out nomirror" >> ${WorkDir}/${PlotScript}
  echo "set xlabel \"x\"" >> ${WorkDir}/${PlotScript}
  echo "set ylabel \"Frequency\"" >> ${WorkDir}/${PlotScript}
  echo "#count and plot" >> ${WorkDir}/${PlotScript}
  echo "plot \"${DataFilePath}\" u (hist(\$1,width)):(1.0) smooth freq w boxes lc rgb \"red\" notitle" >> ${WorkDir}/${PlotScript}
  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait Time Histogram</a>" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1262_iostattrendwaithist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Raw LUN Wait Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html


  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolunwait_local

##
##

Mkplot_iolunactv_local()
{

  echo "Creating iostat individual LUN trans count data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatlunactv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  ## minY=`cat ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_tottrans-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_tottrans-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat # ${PlotDataDir}/iostat_tottrans-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Active Transaction Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris:  Raw LUN Active Transactions</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostattrendlunactv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Raw LUN Transaction Count"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html


  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_iolunactv_local

##
##

Mkplot_vxops_local()
{

  echo "Creating Veritas vol and disk ops plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1300_vxops"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolRops=`cat ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolRops=`cat ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolWops=`cat ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolWops=`cat ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskRops=`cat ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskRops=`cat ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskWops=`cat ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskWops=`cat ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxvol_volrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwops-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Volume and Disk Read and Write Operations'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Averaged R/W Ops</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Volume read ops from $minVolRops to $maxVolRops" >> ${WebDir}/index.html
  echo "<br>Volume write ops from $minVolWops to $maxVolWops" >> ${WebDir}/index.html
  echo "<br>Disk read ops from $minDiskRops to $maxDiskRops" >> ${WebDir}/index.html
  echo "<br>Disk write ops from $minDiskWops to $maxDiskWops" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_vxops_local

##
##

Mkplot_vxblk_local()
{

  echo "Creating Veritas vol and disk blocks plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1310_vxblk"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolRblock=`cat ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolRblock=`cat ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolWblock=`cat ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolWblock=`cat  ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskRblock=`cat ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskRblock=`cat ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskWblock=`cat ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskWblock=`cat ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volwblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskrblk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwblk-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Volume and Disk Read and Write Blocks'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Averaged R/W Blocks</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Volume read blocks from $minVolRblock to $maxVolRblock" >> ${WebDir}/index.html
  echo "<br>Volume write blocks from $minVolWblock to $maxVolWblock" >> ${WebDir}/index.html
  echo "<br>Disk read blocks from $minDiskRblock to $maxDiskRblock" >> ${WebDir}/index.html
  echo "<br>Disk write blocks from $minDiskWblock to $maxDiskWblock" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_vxblk_local

##
##

Mkplot_vxserv_local()
{

  echo "Creating Veritas vol and disk service time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1320_vxserv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolServ=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolServ=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskServ=`cat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskServ=`cat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi
  if [ $minY = 0 ]
  then
    minY=0.001
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minVolServ -ne 0 ]
  then
    if [ $minDiskServ -ne 0 ]
    then
      echo "set logscale y" >> ${WorkDir}/${PlotScript}
    fi
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Volume and Disk Average Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Average Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Volume average service time from $minVolServ to $maxVolServ" >> ${WebDir}/index.html
  echo "<br>Disk average service time from $minDiskServ to $maxDiskServ" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_vxserv_local

##
##

Mkplot_vxreadavgmax_local()
{

  echo "Creating Veritas vol and disk avg/max read time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1330_vxreadavgmax"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolReadAvg=`cat ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolReadAvg=`cat ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolReadMax=`cat ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolReadMax=`cat ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskReadAvg=`cat ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskReadAvg=`cat ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskReadMax=`cat ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskReadMax=`cat ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  if [ $minY = 0 ]
  then
    minY=0.001
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minVolReadAvg -ne 0 ]
  then
    if [ $minVolReadMax -ne 0 ]
    then
      if [ $minDiskReadAvg -ne 0 ]
      then
	if [ $minDiskReadMax -ne 0 ]
	then
	  echo "set logscale y" >> ${WorkDir}/${PlotScript}
	fi
      fi
    fi
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxvol_volreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskreadms-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxreadms-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Volume and Disk Average and Max Read Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Average/Max Read Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Volume average read service time from $minVolReadAvg to $maxVolReadAvg" >> ${WebDir}/index.html
  echo "<br>Volume max read service time from $minVolReadMax to $maxVolReadMax" >> ${WebDir}/index.html
  echo "<br>Disk average read service time from $minDiskReadAvg to $maxDiskReadAvg" >> ${WebDir}/index.html
  echo "<br>Disk max read service time from $minDiskReadMax to $maxDiskReadMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_vxreadavgmax_local

##
##

Mkplot_vxwriteavgmax_local()
{

  echo "Creating Veritas vol and disk avg/max write time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1340_vxwriteavgmax"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolWriteAvg=`cat ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolWriteAvg=`cat ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolWriteMax=`cat ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolWriteMax=`cat  ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskWriteAvg=`cat ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskWriteAvg=`cat ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskWriteMax=`cat ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskWriteMax=`cat ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi
  if [ $minY = 0 ]
  then
    minY=0.001
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minVolWriteAvg -ne 0 ]
  then
    if [ $minVolWriteMax -ne 0 ]
    then
      if [ $minDiskWriteAvg -ne 0 ]
      then
	if [ $minDiskWriteMax -ne 0 ]
	then
	  echo "set logscale y" >> ${WorkDir}/${PlotScript}
	fi
      fi
    fi
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxvol_volwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxvol_volmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskwritems-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_diskmaxwritems-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Volume and Disk Average and Max Write Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Average/Max Write Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Volume average write time from $minVolWriteAvg to $maxVolWriteAvg" >> ${WebDir}/index.html
  echo "<br>Volume max write time from $minVolWriteMax to $maxVolWriteMax" >> ${WebDir}/index.html
  echo "<br>Disk average write time from $minDiskWriteAvg to $maxDiskWriteAvg" >> ${WebDir}/index.html
  echo "<br>Disk max write time from $minDiskWriteMax to $maxDiskWriteMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_vxwriteavgmax_local

##
##

Mkplot_vxnumdevs_local()
{

  echo "Creating Veritas numdevs plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1350_vxnumdevs"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolCount=`cat ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolCount=`cat ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskCount=`cat ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskCount=`cat ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxvol_numvols-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_numdisks-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Active Volume and Disk Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Volume and Device Count</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Volume count from $minVolCount to $maxVolCount" >> ${WebDir}/index.html
  echo "<br>Disk count from $minDiskCount to $maxDiskCount" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_vxnumdevs_local

##
##

Mkplot_vxrawdata_local()
{

  echo "Creating Veritas disk/volume raw service time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1360_vxrawdata"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  ##
  ##  the raw disk times charts are better WITHOUT being correctly time aligned
  ##

  ## minX=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $1 }' | sort -un | head -1`
  ## maxX=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $1 }' | sort -un | tail -1`
  ## minY=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | tail -1`
  ## minVolRawTime=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | head -1`
  ## maxVolRawTime=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | tail -1`
  ## minDiskRawTime=`cat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | head -1`
  ## maxDiskRawTime=`cat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | tail -1`

  minX=0

  minY=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | sort -un | tail -1`

  minVolRawTime=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | sort -un | head -1`
  maxVolRawTime=`cat ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | sort -un | tail -1`

  minDiskRawTime=`cat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | sort -un | head -1`
  maxDiskRawTime=`cat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minVolRawTime -ne 0 ]
  then
    if [ $minDiskRawTime -ne 0 ]
    then
      echo "set logscale y" >> ${WorkDir}/${PlotScript}
    fi
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxstat_vol_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Volume and Disk Raw Services Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Volume/Disk Raw Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Volume raw service times from $minVolRawTime to $maxVolRawTime" >> ${WebDir}/index.html
  echo "<br>Disk raw service times from $minDiskRawTime to $maxDiskRawTime" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_vxrawdata_local

##
##

Mkplot_servXwait_local()
{

  echo "Creating iocalc combined average service and wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1250_iocalcwaitXserv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  ## minX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  ## maxX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ## minWWsvct=`cat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  ## maxWWsvct=`cat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  asvct from $minAsvct to $maxAsvct"
  ## echo "  wsvct from $minWsvct to $maxWsvct"
  ## echo "  Y from $minY to $maxY"

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minWsvct -ne 0  -a  $minAsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ## ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents
  NumThrottleEvents=`${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'"`

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Average Service and Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Average Wait Times and Service times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average wait time from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Average service time from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_servXwait_local

##
##

Mkplot_iolunservXwait_local()
{

  echo "Creating iostat individual LUN service X wait plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatservXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minServ=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxServ=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Service from $minServ to $maxServ"
  ##  echo "  Wait    from $minWait to $maxWait"
  ##  echo "  Y       from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Service versus Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Service versus Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Service times from $minServ to $maxServ" >> ${WebDir}/index.html
  echo "<br>Wait times from $minWait to $maxWait" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolunservXwait_local

##
##

Mkplot_iolunperops_local()
{

  echo "Creating iostat individual LUN read/write K per op plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatrwperop"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minRperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxRperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Read K per op from $minRperop to $maxRperop"
  ##  echo "  Writ K per op from $minWperop to $maxWperop"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Read and Write K per Operation'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Read and Write K per Operation</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read K per Op from $minRperop to $maxRperop" >> ${WebDir}/index.html
  echo "<br>Write K per Op from $minWperop to $maxWperop" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  plot raw wait time vs raw write size
  ##

  echo "Creating iostat individual LUN write K per op vs. wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1267_iostatwkXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`


  minY=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Writ K per op from $minWperop to $maxWperop"
  ##  echo "  Wait time from $minWait to $maxWait"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ##  setup the individual plots

  echo "set label 'WriteK/op' at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  legendY=`expr $legendY - $legincY`

  echo "set label 'Wait Time' at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  combine into a single plot

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Write K per Operation versus Wait Time (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  ##  echo "set ytics" >> ${WorkDir}/${PlotScript}
  ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
  echo "unset ytics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minWperop}:${maxWperop}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minWait}:${maxWait}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Write K per Operation versus Wait Time</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Write K per Op from $minWperop to $maxWperop" >> ${WebDir}/index.html
  echo "<br>Wait time from $minWait to $maxWait ms" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


##
##  dougee
##

  ##
  ##  plot raw wait time vs raw read size
  ##

  echo "Creating iostat individual LUN read K per op vs. wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1267_iostatrkXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minWperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`


  minY=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Read K per op from $minWperop to $maxWperop"
  ##  echo "  Wait time from $minWait to $maxWait"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ##  setup the individual plots

  echo "set label 'ReadK/op' at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  legendY=`expr $legendY - $legincY`

  echo "set label 'Wait Time' at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  combine into a single plot

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Read K per Operation versus Wait Time (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  ##  echo "set ytics" >> ${WorkDir}/${PlotScript}
  ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
  echo "unset ytics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minWperop}:${maxWperop}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minWait}:${maxWait}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Read K per Operation versus Wait Time</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read K per Op from $minWperop to $maxWperop" >> ${WebDir}/index.html
  echo "<br>Wait time from $minWait to $maxWait ms" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_iolunperops_local

##
##

Mkplot_vxcache_totXfast()
{

  echo  "Creating VX filesystem Total Lookups vs Fast Lookup plot scripts..."

  ## echo "  Finding active filesystems..."

  ## for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
  for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by vxfilesystem" | egrep 'oracle|fstapp|syb' | tail -1`
  do
    VXfsnoslash=`echo $VXfilesystem | tr \/ \_`
    echo "  $VXfilesystem --> $VXfsnoslash"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1400_vxfsTOTxFST${VXfsnoslash}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  find the ranges

    FSTDataFilePath=${PlotDataDir}/vxcache_fstlookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    FSTminY=0
    FSTmaxY=100

    TOTDataFilePath=${PlotDataDir}/vxcache_totlookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    TOTDataFile=`basename $TOTDataFilePath`
    TOTLegendText=`echo $TOTDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
    TOTminY=`cat ${TOTDataFilePath} | awk '{ print $2 }' | sort -un | head -1`
    TOTmaxY=`cat ${TOTDataFilePath} | awk '{ print $2 }' | sort -un | tail -1`

    minX=`cat ${TOTDataFilePath} ${FSTDataFilePath} | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${TOTDataFilePath} ${FSTDataFilePath} | awk '{ print $1 }' | sort -un | tail -1`

    ## LegendText="$ServerName - $StartTime to $EndTime - $VXfilesystem - Total Lookups vs. Fast Lookup Percent"
    LegendText="$ServerName - $StartTime to $EndTime - Total Lookups vs. Fast Lookup Percent"

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  x:  $minX to $maxX"
    ## echo "  TOT: $TOTminY to $TOTmaxY"
    ## echo "  FST: $FSTminY to $FSTmaxY"
    ## echo "  TOTDataFile       $TOTDataFile"
    ## echo "  TOTDataFilePath:  $TOTDataFilePath"
    ## echo "  FSTDataFilePath:   $FSTDataFilePath"
    ## echo

    ##  create the gnuplot script header

    echo "set label \"Total\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    legendY=`expr $legendY - $legincY`
    echo "set label \"Fast Pct\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo "set multiplot title '${LegendText} - Total vs Fast Pct'" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${TOTminY}:${TOTmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "set y2range [${FSTminY}:${FSTmaxY}]" >> ${WorkDir}/${PlotScript}


    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${TOTDataFilePath}\" using 1:2 title 'Total' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    ## echo "set yrange [${RQminY}:${RQmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${FSTDataFilePath}\" using 1:2 title 'Fast Pct' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    ## plotIndex=`expr $plotIndex + 1`

    ## echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${VXfilesystem} - Total Lookups vs Fast Lookup Percentage</a>" >> ${WebDir}/index.html
    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Total Lookups vs Fast Lookup Percentage</a>" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Total Lookups from $TOTminY to $TOTmaxY" >> ${WebDir}/index.html
    echo "<br>Fast Looks Percent from $FSTminY to $FSTmaxY" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html
  

  done  ##  for each active filesystem

}  ##  end of Mkplot_vxcache_totXfast

Mkplot_vxcache_totXdcache()
{

  echo  "Creating VX filesystem Total DNLC Lookups vs DNCL Cache plot scripts..."

  ## echo "  Finding active filesystems..."

  ## for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
  for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by vxfilesystem" | egrep 'oracle|fstapp|syb' | tail -1`
  do
    VXfsnoslash=`echo $VXfilesystem | tr \/ \_`
    echo "  $VXfilesystem --> $VXfsnoslash"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1410_vxfsTOTxICACHE${VXfsnoslash}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  find the ranges

    DCACHEDataFilePath=${PlotDataDir}/vxcache_dnlchitrat-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    DCACHEminY=0
    DCACHEmaxY=100

    TOTDataFilePath=${PlotDataDir}/vxcache_totdlookup-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    TOTDataFile=`basename $TOTDataFilePath`
    TOTLegendText=`echo $TOTDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
    TOTminY=`cat ${TOTDataFilePath} | awk '{ print $2 }' | sort -un | head -1`
    TOTmaxY=`cat ${TOTDataFilePath} | awk '{ print $2 }' | sort -un | tail -1`

    minX=`cat ${TOTDataFilePath} ${DCACHEDataFilePath} | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${TOTDataFilePath} ${DCACHEDataFilePath} | awk '{ print $1 }' | sort -un | tail -1`

    ## LegendText="$ServerName - $StartTime to $EndTime - $VXfilesystem - DNLC Lookups vs. DNLC Cache Hit Percent"
    LegendText="$ServerName - $StartTime to $EndTime - DNLC Lookups vs. DNLC Cache Hit Percent"

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  x:  $minX to $maxX"
    ## echo "  TOT: $TOTminY to $TOTmaxY"
    ## echo "  DCACHE: $DCACHEminY to $DCACHEmaxY"
    ## echo "  TOTDataFile       $TOTDataFile"
    ## echo "  TOTDataFilePath:  $TOTDataFilePath"
    ## echo "  DCACHEDataFilePath:   $DCACHEDataFilePath"
    ## echo

    ##  create the gnuplot script header

    echo "set label \"Total\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    legendY=`expr $legendY - $legincY`
    echo "set label \"DNLC Cache\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo "set multiplot title '${LegendText} - Total vs DNLC Cache'" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${TOTminY}:${TOTmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "set y2range [${DCACHEminY}:${DCACHEmaxY}]" >> ${WorkDir}/${PlotScript}


    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${TOTDataFilePath}\" using 1:2 title 'Total' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    ## echo "set yrange [${RQminY}:${RQmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${DCACHEDataFilePath}\" using 1:2 title 'DNLC Cache' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    ## plotIndex=`expr $plotIndex + 1`

    ## echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${VXfilesystem} - DNLC Lookups vs DNLC Cache Percentage</a>" >> ${WebDir}/index.html
    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">DNLC Lookups vs DNLC Cache Percentage</a>" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Total Lookups from $TOTminY to $TOTmaxY" >> ${WebDir}/index.html
    echo "<br>DNLC Cache Hit Percent from $DCACHEminY to $DCACHEmaxY" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html
  

  done  ##  for each active filesystem

}  ##  end of Mkplot_vxcache_totXdcache

Mkplot_vxcache_iaXif()
{

  echo  "Creating VX filesystem inode allocate vs inode freed plot scripts..."

  ## echo "  Finding active filesystems..."

  ## for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
  for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by vxfilesystem" | egrep 'oracle|fstapp|syb' | tail -1`
  do
    VXfsnoslash=`echo $VXfilesystem | tr \/ \_`
    echo "  $VXfilesystem --> $VXfsnoslash"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1420_vxfsIAxIF${VXfsnoslash}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  find the ranges

    IADataFilePath=${PlotDataDir}/vxcache_ialloced-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    IADataFile=`basename $IADataFilePath`
    IALegendText=`echo $IADataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
    IAminY=`cat ${IADataFilePath} | awk '{ print $2 }' | sort -un | head -1`
    IAmaxY=`cat ${IADataFilePath} | awk '{ print $2 }' | sort -un | tail -1`

    IFDataFilePath=${PlotDataDir}/vxcache_ifreed-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    IFDataFile=`basename $IFDataFilePath`
    IFLegendText=`echo $IFDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
    IFminY=`cat ${IFDataFilePath} | awk '{ print $2 }' | sort -un | head -1`
    IFmaxY=`cat ${IFDataFilePath} | awk '{ print $2 }' | sort -un | tail -1`

    minX=`cat ${IFDataFilePath} ${IADataFilePath} | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${IFDataFilePath} ${IADataFilePath} | awk '{ print $1 }' | sort -un | tail -1`

    ## LegendText="$ServerName - $StartTime to $EndTime - $VXfilesystem - Inodes Allocated vs. Inodes Freed"
    LegendText="$ServerName - $StartTime to $EndTime - Inodes Allocated vs. Inodes Freed"

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  x:  $minX to $maxX"
    ## echo "  IF: $IFminY to $IFmaxY"
    ## echo "  IA: $IAminY to $IAmaxY"
    ## echo "  IFDataFile       $IFDataFile"
    ## echo "  IFDataFilePath:  $IFDataFilePath"
    ## echo "  IADataFilePath:   $IADataFilePath"
    ## echo

    ##  create the gnuplot script header

    echo "set label \"Freed\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    legendY=`expr $legendY - $legincY`
    echo "set label \"Allocated\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo "set multiplot title '${LegendText} - Inodes Allocated vs Inodes Freed'" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${IFminY}:${IFmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "set y2range [${IAminY}:${IAmaxY}]" >> ${WorkDir}/${PlotScript}


    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${IFDataFilePath}\" using 1:2 title 'Freed' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    ## echo "set yrange [${RQminY}:${RQmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${IADataFilePath}\" using 1:2 title 'Allocated' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    ## plotIndex=`expr $plotIndex + 1`

    ## echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${VXfilesystem} - Inodes Allocated vs Inodes Freed</a>" >> ${WebDir}/index.html
    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Inodes Allocated vs Inodes Freed</a>" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Inodes Freed from $IFminY to $IFmaxY" >> ${WebDir}/index.html
    echo "<br>Inodes allocated from $IAminY to $IAmaxY" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html
  

  done  ##  for each active filesystem

}  ##  end of Mkplot_vxcache_iaXif

Mkplot_vxcache_ilookXicache()
{

  echo  "Creating VX filesystem Inode Lookups vs Inode Cache plot scripts..."

  ## echo "  Finding active filesystems..."

  ## for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
  for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by vxfilesystem" | egrep 'oracle|fstapp|syb' | tail -1`
  do
    VXfsnoslash=`echo $VXfilesystem | tr \/ \_`
    echo "  $VXfilesystem --> $VXfsnoslash"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1430_vxfsILOOKxICACHE${VXfsnoslash}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  find the ranges

    ICACHEDataFilePath=${PlotDataDir}/vxcache_ihitrate-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    ICACHEminY=0
    ICACHEmaxY=100

    TOTDataFilePath=${PlotDataDir}/vxcache_ilookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    TOTDataFile=`basename $TOTDataFilePath`
    TOTLegendText=`echo $TOTDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
    TOTminY=`cat ${TOTDataFilePath} | awk '{ print $2 }' | sort -un | head -1`
    TOTmaxY=`cat ${TOTDataFilePath} | awk '{ print $2 }' | sort -un | tail -1`

    minX=`cat ${TOTDataFilePath} ${ICACHEDataFilePath} | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${TOTDataFilePath} ${ICACHEDataFilePath} | awk '{ print $1 }' | sort -un | tail -1`

    ## LegendText="$ServerName - $StartTime to $EndTime - $VXfilesystem - DNLC Lookups vs. DNLC Cache Hit Percent"
    LegendText="$ServerName - $StartTime to $EndTime - DNLC Lookups vs. DNLC Cache Hit Percent"

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  x:  $minX to $maxX"
    ## echo "  TOT: $TOTminY to $TOTmaxY"
    ## echo "  ICACHE: $ICACHEminY to $ICACHEmaxY"
    ## echo "  TOTDataFile       $TOTDataFile"
    ## echo "  TOTDataFilePath:  $TOTDataFilePath"
    ## echo "  ICACHEDataFilePath:   $ICACHEDataFilePath"
    ## echo

    ##  create the gnuplot script header

    echo "set label \"Total\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    legendY=`expr $legendY - $legincY`
    echo "set label \"Inode Cache\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo "set multiplot title '${LegendText} - Total vs Inode Cache'" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${TOTminY}:${TOTmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "set y2range [${ICACHEminY}:${ICACHEmaxY}]" >> ${WorkDir}/${PlotScript}


    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${TOTDataFilePath}\" using 1:2 title 'Total' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    ## echo "set yrange [${RQminY}:${RQmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${ICACHEDataFilePath}\" using 1:2 title 'Inode Cache' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    ## plotIndex=`expr $plotIndex + 1`

    ## echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${VXfilesystem} - Inode Lookups vs Inode Cache Percentage</a>" >> ${WebDir}/index.html
    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Inode Lookups vs Inode Cache Percentage</a>" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Total Inode Lookups from $TOTminY to $TOTmaxY" >> ${WebDir}/index.html
    echo "<br>Inode Cache Hit Percent from $ICACHEminY to $ICACHEmaxY" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html
  

  done  ##  for each active filesystem

}  ##  end of Mkplot_vxcache_ilookXicache

Mkplot_vxcache_blookXbcache()
{

  echo  "Creating VX filesystem Buffer Lookups vs Buffer Cache plot scripts..."

  ## echo "  Finding active filesystems..."

  ## for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}"`
  for VXfilesystem in `${ProgPrefix}/NewQuery fsr "select distinct vxfilesystem from vxcache where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by vxfilesystem" | egrep 'oracle|fstapp|syb' | tail -1`
  do
    VXfsnoslash=`echo $VXfilesystem | tr \/ \_`
    echo "  $VXfilesystem --> $VXfsnoslash"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_1440_vxfsBLOOKxBCACHE${VXfsnoslash}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  find the ranges

    BCACHEDataFilePath=${PlotDataDir}/vxcache_ihitrate-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    BCACHEminY=0
    BCACHEmaxY=100

    TOTDataFilePath=${PlotDataDir}/vxcache_ilookups-${ServerName}-${StartTime}_${EndTime}${VXfsnoslash}.dat
    TOTDataFile=`basename $TOTDataFilePath`
    TOTLegendText=`echo $TOTDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
    TOTminY=`cat ${TOTDataFilePath} | awk '{ print $2 }' | sort -un | head -1`
    TOTmaxY=`cat ${TOTDataFilePath} | awk '{ print $2 }' | sort -un | tail -1`

    minX=`cat ${TOTDataFilePath} ${BCACHEDataFilePath} | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${TOTDataFilePath} ${BCACHEDataFilePath} | awk '{ print $1 }' | sort -un | tail -1`

    ## LegendText="$ServerName - $StartTime to $EndTime - $VXfilesystem - DNLC Lookups vs. DNLC Cache Hit Percent"
    LegendText="$ServerName - $StartTime to $EndTime - DNLC Lookups vs. DNLC Cache Hit Percent"

    ## echo "  $plotIndex $LegendText at ${legendX},${legendY}"
    ## echo "  x:  $minX to $maxX"
    ## echo "  TOT: $TOTminY to $TOTmaxY"
    ## echo "  BCACHE: $BCACHEminY to $BCACHEmaxY"
    ## echo "  TOTDataFile       $TOTDataFile"
    ## echo "  TOTDataFilePath:  $TOTDataFilePath"
    ## echo "  BCACHEDataFilePath:   $BCACHEDataFilePath"
    ## echo

    ##  create the gnuplot script header

    echo "set label \"Total\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    legendY=`expr $legendY - $legincY`
    echo "set label \"Buffer Cache\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo "set multiplot title '${LegendText} - Total vs Buffer Cache'" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
    echo "set yrange [${TOTminY}:${TOTmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "set y2range [${BCACHEminY}:${BCACHEmaxY}]" >> ${WorkDir}/${PlotScript}


    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${TOTDataFilePath}\" using 1:2 title 'Total' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}
    ## echo "set yrange [${RQminY}:${RQmaxY}]" >> ${WorkDir}/${PlotScript}
    echo "plot \"${BCACHEDataFilePath}\" using 1:2 title 'Buffer Cache' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    ## plotIndex=`expr $plotIndex + 1`

    ## echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${VXfilesystem} - Buffer Lookups vs Buffer Cache Percentage</a>" >> ${WebDir}/index.html
    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Buffer Lookups vs Buffer Cache Percentage</a>" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Total Buffer Lookups from $TOTminY to $TOTmaxY" >> ${WebDir}/index.html
    echo "<br>Buffer Cache Hit Percent from $BCACHEminY to $BCACHEmaxY" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html
  

  done  ##  for each active filesystem

}  ##  end of Mkplot_vxcache_blookXbcache


Mkplot_vxo_avgservtime() 
{

  echo "Creating Veritas vs Solaris avg service time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1500_vxo_aservtime"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minVolServ=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolServ=`cat ${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskServ=`cat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskServ=`cat ${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minSolServ=`cat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxSolServ=`cat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi
  if [ $minY = 0 ]
  then
    minY=0.001
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minVolServ -ne 0 ]
  then
    if [ $minDiskServ -ne 0 ]
    then
      if [ $minSolServ -ne 0 ]
      then
        echo "set logscale y" >> ${WorkDir}/${PlotScript}
      fi
    fi
  fi

  ##
  ##  plot the iostat weighted average data
  ##

  DataFilePath=${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  DataFile=`basename $DataFilePath`
  ##  LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
  LegendText="Raw LUN"
  ## echo "    $DataFile - $LegendText"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

  ##  increment stuff
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`

  ##
  ##  plot the veritas disk service time data
  ##

  DataFilePath=${PlotDataDir}/vxdisk_disktime-${ServerName}-${StartTime}_${EndTime}.dat
  DataFile=`basename $DataFilePath`
  ##  LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
  LegendText="Ver Disk"
  ## echo "    $DataFile - $LegendText"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

  ##  increment stuff
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`

  ##
  ##  plot the veritas volume service time data
  ##

  DataFilePath=${PlotDataDir}/vxvol_voltime-${ServerName}-${StartTime}_${EndTime}.dat
  DataFile=`basename $DataFilePath`
  ##  LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
  LegendText="Ver Vol"
  ## echo "    $DataFile - $LegendText"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

  ##  increment stuff
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`

  ##
  ##  finish the plot script
  ##

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris LUN vs Veritas Disk and Volume Average Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris vs Veritas: Average Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Solaris average service time from $minSolServ to $maxSolServ" >> ${WebDir}/index.html
  echo "<br>Volume average service time from $minVolServ to $maxVolServ" >> ${WebDir}/index.html
  echo "<br>Disk average service time from $minDiskServ to $maxDiskServ" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}

Mkplot_vxo_rawservtime() 
{
  echo "Creating Veritas vs Solaris RAW service time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1510_vxo_rservtime"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxstat_vol_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxstat_vol_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/vxstat_disk_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`


  minVolRawTime=`cat ${PlotDataDir}/vxstat_vol_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | head -1`
  maxVolRawTime=`cat ${PlotDataDir}/vxstat_vol_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | tail -1`

  minDiskRawTime=`cat ${PlotDataDir}/vxstat_disk_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | head -1`
  maxDiskRawTime=`cat ${PlotDataDir}/vxstat_disk_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $2 }' | sort -un | tail -1`

  minSolRawTime=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxSolRawTime=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##    echo "  minY          :  $minY"
  ##    echo "  maxY          :  $maxY"
  ##    echo "  minVolRawTime :  $minVolRawTime"
  ##    echo "  maxVolRawTime :  $maxVolRawTime"
  ##    echo "  minDiskRawTime:  $minDiskRawTime"
  ##    echo "  maxDiskRawTime:  $maxDiskRawTime"
  ##    echo "  minSolRawTime :  $minSolRawTime"
  ##    echo "  maxSolRawTime :  $maxSolRawTime"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi
  if [ $minY = 0 ]
  then
    minY=0.001
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minVolRawTime -ne 0 ]
  then
    if [ $minDiskRawTime -ne 0 ]
    then
      if [ $minSolRawTime -ne 0 ]
      then
        echo "set logscale y" >> ${WorkDir}/${PlotScript}
      fi
    fi
  fi

  ##
  ##  plot the iostat raw lun data
  ##

  DataFilePath=${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFile=`basename $DataFilePath`
  ##  LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
  LegendText="Raw LUN"
  ## echo "    $DataFile - $LegendText"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

  ##  increment stuff
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`

  ##
  ##  plot the veritas disk raw service time data
  ##

  DataFilePath=${PlotDataDir}/vxstat_disk_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
  DataFile=`basename $DataFilePath`
  ##  LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
  LegendText="Ver Disk"
  ## echo "    $DataFile - $LegendText"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

  ##  increment stuff
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`

  ##
  ##  plot the veritas volume raw service time data
  ##

  DataFilePath=${PlotDataDir}/vxstat_vol_timeasvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
  DataFile=`basename $DataFilePath`
  ##  LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
  LegendText="Ver Vol"
  ## echo "    $DataFile - $LegendText"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

  ##  increment stuff
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`

  ##
  ##  finish the plot script
  ##

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris LUN vs Veritas Disk and Volume RAW Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris vs Veritas: RAW Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Solaris average service time from $minSolRawTime to $maxSolRawTime" >> ${WebDir}/index.html
  echo "<br>Volume average service time from $minVolRawTime to $maxVolRawTime" >> ${WebDir}/index.html
  echo "<br>Disk average service time from $minDiskRawTime to $maxDiskRawTime" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_vxo_rawservtime

##
##

Mkplot_nicinput_local()
{

  echo "Creating nicstat ReadK plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_nicstatReadK"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadM=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | head -1`
  maxReadM=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | tail -1`

  minUtil=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -un | head -1`
  maxUtil=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -un | tail -1`

  if [ $maxReadK = 0 ]
  then
    maxReadK=1
  fi

  if [ $maxReadM = 0 ]
  then
    maxReadM=1
  fi

  if [ $maxUtil = 0 ]
  then
    maxUtil=1
  fi

  maxY=$maxReadK
  minY=$minReadM

  echo "  X from $minX to $maxX"
  echo "  Y from $minY to $maxY"
  echo "  ReadK from $minReadK to $maxReadK"
  echo "  ReadM from $minReadM to $maxReadM"
  echo "  Util  from $minUtil to $maxUtil"

  for DataFilePath in ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ##  echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    ##  echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText} ReadK\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ##  nextLegend=`expr $legendY - $legincY`
    ##  echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minReadK}:${maxReadK}]" >> ${WorkDir}/${PlotScript}.$$
    ##  echo "set y2range [${minUtil}:${maxUtil}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY - $legincY`
    plotIndex=`expr $plotIndex + 2`
  done  ##  for each data file for all interfaces

  ##  echo "set label \"${LegendText} Util\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  ##  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$


  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - NIC Read KBytes/sec'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">NIC Read KBytes</a>: ALL" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read KBytes from $minReadK to $maxReadK" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  create the read mbytes plot
  ##

  echo "Creating nicstat ReadM plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_nicstatReadM"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for DataFilePath in ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ##  echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    ##  echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText} ReadM\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ##  nextLegend=`expr $legendY - $legincY`
    ##  echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minReadM}:${maxReadM}]" >> ${WorkDir}/${PlotScript}.$$
    ##  echo "set y2range [${minUtil}:${maxUtil}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:3 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY - $legincY`
    plotIndex=`expr $plotIndex + 2`
  done  ##  for each data file for all interfaces

  ##  echo "set label \"${LegendText} Util\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  ##  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$


  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - NIC Read MBytes/sec'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">NIC Read MBytes</a>: ALL" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read M from $minReadM to $maxReadM" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  create the total util plot
  ##

  echo "Creating nicstat utilization plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_nicstatUtil"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for DataFilePath in ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ##  echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText} Util\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ##  nextLegend=`expr $legendY - $legincY`
    ##  echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [0:100]" >> ${WorkDir}/${PlotScript}.$$
    ##  echo "set y2range [${minUtil}:${maxUtil}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY - $legincY`
    plotIndex=`expr $plotIndex + 2`
  done  ##  for each data file for all interfaces

  ##  echo "set label \"${LegendText} Util\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  ##  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  ##  echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$


  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - NIC Utilization (percent)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">NIC Utilization</a>: ALL" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "NIC Utilization from $minUtil to $maxUtil" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html




}  ##  end of function Mkplot_nicinput_local

##
##

Mkplot_nicoutput_local()
{

  echo "Creating nicstat WriteK plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_nicstatWriteK"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | tail -1`

  minWriteK=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteM=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | head -1`
  maxWriteM=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | tail -1`

  if [ $maxWriteK = 0 ]
  then
    maxWriteK=1
  fi

  if [ $maxWriteM = 0 ]
  then
    maxWriteM=1
  fi

  maxY=$maxWriteK
  minY=$minWriteM

  echo "  X from $minX to $maxX"
  echo "  Y from $minY to $maxY"
  echo "  WriteK from $minWriteK to $maxWriteK"
  echo "  WriteM from $minWriteM to $maxWriteM"

  for DataFilePath in ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ##  echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    ##  echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText} WriteK\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ##  nextLegend=`expr $legendY - $legincY`
    ##  echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minWriteK}:${maxWriteK}]" >> ${WorkDir}/${PlotScript}.$$
    ##  echo "set y2range [${minUtil}:${maxUtil}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY - $legincY`
    plotIndex=`expr $plotIndex + 2`
  done  ##  for each data file for all interfaces

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - NIC Write KBytes/sec'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">NIC Write KBytes</a>: ALL" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read KBytes from $minWriteK to $maxWriteK" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  create the write mbytes plot
  ##

  echo "Creating nicstat WriteM plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_nicstatWriteM"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for DataFilePath in ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ##  echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    ##  echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText} WriteM\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    ##  nextLegend=`expr $legendY - $legincY`
    ##  echo "set label \"${LegendText} Errors\" at screen 0.${legendX},0.${nextLegend} front textcolor linestyle `expr ${plotIndex} + 1` font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minWriteM}:${maxWriteM}]" >> ${WorkDir}/${PlotScript}.$$
    ##  echo "set y2range [${minUtil}:${maxUtil}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:3 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY - $legincY`
    plotIndex=`expr $plotIndex + 2`
  done  ##  for each data file for all interfaces

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - NIC Write MBytes/sec'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">NIC Write MBytes</a>: ALL" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read M from $minWriteM to $maxWriteM" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of function Mkplot_nicoutput_local

##
##

Mkplot_nicutil_local()
{

  echo "Creating nicstat utilization plot scripts..."

  ##  find the ranges

  minXin=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | head -1`
  maxXin=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | tail -1`

  minUtil=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -un | head -1`
  maxUtil=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -un | tail -1`

  minXout=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | head -1`
  maxXout=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteK=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadM=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | head -1`
  maxReadM=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | tail -1`

  minWriteM=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | head -1`
  maxWriteM=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | tail -1`

  if [ $maxReadK = 0 ]
  then
    maxReadK=1
  fi

  if [ $maxReadM = 0 ]
  then
    maxReadM=1
  fi

  if [ $maxUtil = 0 ]
  then
    maxUtil=1
  fi

  if [ $maxWriteK = 0 ]
  then
    maxWriteK=1
  fi

  if [ $maxWriteM = 0 ]
  then
    maxWriteM=1
  fi

  maxYin=$maxReadK
  minYin=$minReadM

  maxYout=$maxWriteK
  minYout=$minWriteM

  if [ $maxYin -gt $maxYout ]
  then
    maxY=$maxYin
  else
    maxY=$maxYout
  fi

  if [ $minYin -lt $minYout ]
  then
    minY=$minYin
  else
    minY=$minYout
  fi

  if [ $maxXin -gt $maxXout ]
  then
    maxX=$maxXin
  else
    maxX=$maxXout
  fi

  if [ $minXin -lt $minXout ]
  then
    minX=$minXin
  else
    minX=$minXout
  fi

  ##  echo "  X      from $minX to $maxX"
  ##  echo "  Xin    from $minXin to $maxXin"
  ##  echo "  Xout   from $minXout to $maxXout"
  ##  echo "  Y      from $minY to $maxY"
  ##  echo "  Yin    from $minYin to $maxYin"
  ##  echo "  Yout   from $minYout to $maxYout"
  ##  echo "  Util   from $minUtil to $maxUtil"
  ##  echo "  ReadK  from $minReadK to $maxReadK"
  ##  echo "  ReadM  from $minReadM to $maxReadM"
  ##  echo "  WriteK from $minWriteK to $maxWriteK"
  ##  echo "  WriteM from $minWriteM to $maxWriteM"

  ##
  ##  create the total util plot
  ##

  echo "  all"

  GFileBase="${ServerName}_${StartTime}-${EndTime}_nicstatUtil"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for DataFilePath in ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ##  echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    ##  echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText} Util\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [0:100]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 2`
  done  ##  for each data file for all interfaces

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - NIC Utilization (percent)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">NIC Percent Utilization</a>: ALL" >> ${WebDir}/index.html

  ##
  ##  create the per interface KBytes vs. Util plot scripts
  ##

  echo "<blockquote>" >> ${WebDir}/index.html
  echo "<table cellpadding=3 cellspacing=5>" >> ${WebDir}/index.html
  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct nsintf from nicstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by nsintf"`
  do
    echo "  ${Interface}"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_${Interface}_nicstatUtil01"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  get this interface's min/max values

    minUtilThis=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $4 }' | sort -un | head -1`
    maxUtilThis=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat | awk '{ print $4 }' | sort -un | tail -1`

    for DataFilePath in ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
    do
      ##  echo "    $DataFilePath"
      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
      ##  echo "        $DataFile - $LegendText"

      ##  set the legend text

      echo "set label \"${LegendText} Util\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entries to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "unset xtics" >> ${WorkDir}/${PlotScript}
      echo "unset x2tics" >> ${WorkDir}/${PlotScript}
      echo >> ${WorkDir}/${PlotScript}
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
      echo "set yrange [0:100]" >> ${WorkDir}/${PlotScript}.$$

      echo >> ${WorkDir}/${PlotScript}
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


      ##  increment stuff and loop again
      legendY=`expr $legendY - $legincY - $legincY`
      plotIndex=`expr $plotIndex + 2`
    done  ##  for each data file for all interfaces

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Utilization (percent)'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<tr><td><a href=\"${GFileBase}-${resX}x${resY}.png\">${Interface}</a>:</td>" >> ${WebDir}/index.html
    echo "<td class=\"summary\">NIC Utilization from $minUtilThis to $maxUtilThis</td>" >> ${WebDir}/index.html
    echo "</tr>" >> ${WebDir}/index.html


  done  ##  for each interface with nic util
  echo "</table>" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html




}  ##  end of function Mkplot_nicutil_local

##

Mkplot_nicthru_local()
{

  echo "Creating nicstat throughput plot scripts..."

  echo "  all"

  minXin=`cat ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | head -1`
  maxXin=`cat ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -un | tail -1`

  minTOTmb=`cat ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxTOTmb=`cat ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  minTOTkb=`cat ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | head -1`
  maxTOTkb=`cat ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -un | tail -1`

  minTOTpac=`cat ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -un | head -1`
  maxTOTpac=`cat ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -un | tail -1`


  if [ $maxTOTmb = 0 ]
  then
    maxTOTmb=1
  fi

  if [ $maxTOTkb = 0 ]
  then
    maxTOTkb=1
  fi

  if [ $maxTOTpac = 0 ]
  then
    maxTOTpac=1
  fi

  ##  echo "    X       from $minX to $maxX"
  ##  echo "    MB/sec  from $minTOTmb to $maxTOTmb"
  ##  echo "    KB/sec  from $minTOTkb to $maxTOTkb"
  ##  echo "    Packets from $minTOTpac to $maxTOTpac"

  ##
  ##  do the MB/second plot
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_ALL_nicstatThruMB"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  for DataFilePath in ${PlotDataDir}/nicstat_totalpac-${ServerName}-${StartTime}_${EndTime}-*.dat
  do
    ##  echo "    $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $4 }' | awk -F\. '{ print $1 }'`
    ##  echo "      $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minTOTmb}:${maxTOTmb}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 2`
  done  ##  for each data file for all interfaces

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - NIC MB/second'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">NIC MB/second</a>: ALL" >> ${WebDir}/index.html

  ##
  ##  cretae the per interface MB/second plot scripts
  ##

  echo "<blockquote>" >> ${WebDir}/index.html
  echo "<table cellpadding=3 cellspacing=5>" >> ${WebDir}/index.html
  echo "<tr><td class=\"summary\"><b>Interface</b></td><td align=\"center\" class=\"summary\"><b>Input MB/second</b></td><td align=\"center\" class=\"summary\"><b>Output MB/second</b></td></tr>" >> ${WebDir}/index.html

  for ThisInterface in `${ProgPrefix}/NewQuery fsr "select distinct nsintf from nicstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by nsintf"`
  do

    echo "  $ThisInterface"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_${ThisInterface}_nicstatThruMB"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    minRMB=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${ThisInterface}.dat | awk '{ print $3 }' | sort -un | head -1`
    maxRMB=`cat ${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${ThisInterface}.dat | awk '{ print $3 }' | sort -un | tail -1`

    minWMB=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${ThisInterface}.dat | awk '{ print $3 }' | sort -un | head -1`
    maxWMB=`cat ${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${ThisInterface}.dat | awk '{ print $3 }' | sort -un | tail -1`

    if [ $maxRMB = 0 ]
    then
	maxRMB=1
    fi

    if [ $maxWMB = 0 ]
    then
	maxWMB=1
    fi

    if [ $maxRMB -gt $maxWMB ]
    then
	maxY=$maxRMB
    else
	maxY=$maxWMB
    fi

    if [ $minRMB -lt $minWMB ]
    then
	minY=$minRMB
    else
	minY=$minWMB
    fi

    ##  echo "    ${ServerName} (${ThisInterface}) from ${StartTime} to ${EndTime}"
    ##  echo "      Rmb min   : $minRMB"
    ##  echo "      Rmb max   : $maxRMB"
    ##  echo "      Wmb min   : $minWMB"
    ##  echo "      Wmb max   : $maxWMB"
    ##  echo "      Y min     : $minY"
    ##  echo "      Y max     : $maxY"

    ##  add the input mb/sec to the graph (y1)

    DataFile=${PlotDataDir}/nicstat_inputstats-${ServerName}-${StartTime}_${EndTime}-${ThisInterface}.dat
    LegendText="Input"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entries to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:3 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend
    nextPlotIndex=`expr $plotIndex + 1`
    plotIndex=$nextPlotIndex

    ##  add the output mb/sec to the graph (y1)

    DataFile=${PlotDataDir}/nicstat_outputstats-${ServerName}-${StartTime}_${EndTime}-${ThisInterface}.dat
    LegendText="Output"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:3 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    nextPlotIndex=`expr $plotIndex + 1`
    plotIndex=$nextPlotIndex

    ##  finish the plot file

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${ThisInterface} MB/second'" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<tr><td><a href=\"${GFileBase}-${resX}x${resY}.png\">${ThisInterface}</a>:</td>" >> ${WebDir}/index.html
    echo "<td class=\"summary\">$minRMB to $maxRMB</td>" >> ${WebDir}/index.html
    echo "<td class=\"summary\">$minWMB to $maxWMB</td>" >> ${WebDir}/index.html
    echo "</tr>" >> ${WebDir}/index.html

  done  ##  for each interface on this server
  echo "</table>" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_nicthru_local

##
##

Mkplot_iorwopsnfs_local()
{

  echo "Creating iocalcnfs read + write ops plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_iocalcnfsrwops"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges


  ## minY=`cat ${PlotDataDir}/iocalcnfs_rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wops-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/iocalcnfs_rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wops-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  minX=`cat ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadOps=`cat ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadOps=`cat ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteOps=`cat ${PlotDataDir}/iocalcnfs_Wops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteOps=`cat ${PlotDataDir}/iocalcnfs_Wops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minX to $maxX"
  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Averaged Read and Write Operations (stacked)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris NFS: Averaged R/W Ops</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read ops from $minReadOps to $maxReadOps" >> ${WebDir}/index.html
  echo "<br>Write ops from $minWriteOps to $maxWriteOps" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iorwopsnfs_local

##
##

Mkplot_iorwknfs_local()
{

  echo "Creating iocalcnfs read + write K plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1220_iocalcnfsrwk"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcnfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcnfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcnfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/iocalcnfs_readk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/iocalcnfs_readk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteK=`cat ${PlotDataDir}/iocalcnfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/iocalcnfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minX to $maxX"
  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcnfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writek-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Averaged Read and Write KBytes'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris NFS: Averaged R/W KBytes</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read Kbytes from $minReadK to $maxReadK" >> ${WebDir}/index.html
  echo "<br>Write Kbytes rom $minWriteK to $maxWriteK" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "Creating iocalcnfs read + write K per op plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1225_iocalcnfskperop"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/iocalcnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/iocalcnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteK=`cat ${PlotDataDir}/iocalcnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/iocalcnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minX to $maxX"
  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Averaged Read and Write KBytes per operation'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris NFS: Averaged R/W KBytes per Operation</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read Kbytes from $minReadK to $maxReadK" >> ${WebDir}/index.html
  echo "<br>Write Kbytes rom $minWriteK to $maxWriteK" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iorwknfs_local

##
##

Mkplot_ioawtransnfs_local()
{

  echo "Creating iocalcnfs active + wait transactions plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1230_iocalcnfsawtrans"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minX to $maxX"
  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Averaged Active and Wait Transaction Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris NFS: Averaged Disk Transactions</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Wait transactions from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Active transactions from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_ioawtransnfs_local

##
##

Mkplot_iodevcountnfs_local()
{

  echo "Creating iocalcnfs devcount plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1250_iocalcnfsdevcount"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalcnfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcnfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minX to $maxX"
  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcnfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Active Filesystem Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris NFS: Active Filesystem Count</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iodevcountnfs_local

##
##

Mkplot_ioaasvctnfs_local()
{

  echo "Creating iocalcnfs service time weighted average plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1240_iocalcnfsaasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWAsvct=`cat ${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWAsvct=`cat ${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minAsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ##  echo "  $minX to $maxX"
  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Weighted Average Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  ##
  ##  create the index.html entry
  ##

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris NFS: Average Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average service time from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  echo "<br>Weighted average service time from $minWAsvct to $maxWAsvct" >> ${WebDir}/index.html

  ##
  ##  create the trend plot - use weighted service times
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1242_iocalcnfstrendasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iocalcnfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iocalcnfs_statsweighted-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Weighted Average Service Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ## echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average Weighted Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ## echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_ioaasvctnfs_local

##
##

Mkplot_iowasvctnfs_local()
{

  echo "Creating iocalcnfs wait time weighted average plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1240_iocalcnfswasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minWsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ##  echo "  $minX to $maxX"
  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Weighted Average Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris NFS: Average Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average wait time from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Weighted average wait time from $minWWsvct to $maxWWsvct" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1242_iocalcnfstrendwasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iocalcnfs_statswsvct_a-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Weighted Average Wait Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iowasvctnfs_local

##
##

Mkplot_servXwaitnfs_local()
{

  echo "Creating iocalcnfs combined average service and wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1250_iocalcnfswaitXserv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  ## minX=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  ## maxX=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ## minWWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  ## maxWWsvct=`cat ${PlotDataDir}/iocalcnfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  asvct from $minAsvct to $maxAsvct"
  ##  echo "  wsvct from $minWsvct to $maxWsvct"
  ##  echo "  Y from $minY to $maxY"

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minWsvct -ne 0  -a  $minAsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iocalcnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ## ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents
  NumThrottleEvents=`${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'"`

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris NFS Average Service and Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris NFS: Average Wait Times and Service times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average wait time from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Average service time from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_servXwaitnfs_local

##
##

Mkplot_iolundatanfs_local()
{

  echo "Creating iostatnfs individual LUN data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatnfslundata"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minY=`cat ${PlotDataDir}/iostatnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostatnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filessytem Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw NFS filesystem Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##  create the frequencey distribution plot script
  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatnfslunhist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1
  ##  create the gnuplot script header
  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filesystem Service Time Histogram (ms)'" >> ${WorkDir}/${PlotScript}

  echo "n=20 #number of intervals" >> ${WorkDir}/${PlotScript}
  echo "max=$maxY #max value" >> ${WorkDir}/${PlotScript}
  echo "min=$minY #min value" >> ${WorkDir}/${PlotScript}
  echo "width=(max-min)/n #interval width" >> ${WorkDir}/${PlotScript}
  echo "#function used to map a value to the intervals" >> ${WorkDir}/${PlotScript}
  echo "hist(x,width)=width*floor(x/width)+width/2.0" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [min:max]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [min:]" >> ${WorkDir}/${PlotScript}
  if [ $maxY -gt 1000 ]
  then
    echo "set yrange [0:1000]" >> ${WorkDir}/${PlotScript}
  else
    echo "set yrange [0:$maxY]" >> ${WorkDir}/${PlotScript}
  fi
  echo "#to put an empty boundary around the" >> ${WorkDir}/${PlotScript}
  echo "#data inside an autoscaled graph." >> ${WorkDir}/${PlotScript}
  echo "set size 0.99,0.97"  >> ${WorkDir}/${PlotScript}
  echo "set xtics min,(max-min)/5,max" >> ${WorkDir}/${PlotScript}
  echo "set boxwidth width*0.9" >> ${WorkDir}/${PlotScript}
  echo "set style fill solid 0.75 #fillstyle" >> ${WorkDir}/${PlotScript}
  echo "set tics out nomirror" >> ${WorkDir}/${PlotScript}
  echo "set xlabel \"x\"" >> ${WorkDir}/${PlotScript}
  echo "set ylabel \"Frequency\"" >> ${WorkDir}/${PlotScript}
  echo "#count and plot" >> ${WorkDir}/${PlotScript}
  echo "plot \"${DataFilePath}\" u (hist(\$1,width)):(1.0) smooth freq w boxes lc rgb \"red\" notitle" >> ${WorkDir}/${PlotScript}
  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Service Time Histogram</a>" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1262_iostatnfstrendlunhist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostatnfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostatnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filesystem Service Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolundatanfs_local

##
##

Mkplot_iolunactvnfs_local()
{

  echo "Creating iostatnfs individual LUN trans count data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatnfslunactv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  ## minY=`cat ${PlotDataDir}/iostatnfs_actv-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_tottrans-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/iostatnfs_actv-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_tottrans-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostatnfs_actv-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatnfs_actv-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostatnfs_actv-${ServerName}-${StartTime}_${EndTime}.dat # ${PlotDataDir}/iostatnfs_tottrans-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filesystem Active Transaction Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris:  Raw NFS filesystem Active Transactions</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatnfstrendlunactv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostatnfs_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostatnfs_actv-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Raw NFS filesystem Transaction Count"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html


  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_iolunactvnfs_local

##
##

Mkplot_iolunwaitnfs_local()
{

  echo "Creating iostatnfs individual LUN wait plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatnfslunwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minY=`cat ${PlotDataDir}/iostatnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostatnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filesystem Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw NFS filesystem Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##  create the frequencey distribution plot script
  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatnfswaithist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1
  ##  create the gnuplot script header
  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filesystem Wait Time Histogram (ms)'" >> ${WorkDir}/${PlotScript}

  echo "n=20 #number of intervals" >> ${WorkDir}/${PlotScript}
  echo "max=$maxY #max value" >> ${WorkDir}/${PlotScript}
  echo "min=$minY #min value" >> ${WorkDir}/${PlotScript}
  echo "width=(max-min)/n #interval width" >> ${WorkDir}/${PlotScript}
  echo "#function used to map a value to the intervals" >> ${WorkDir}/${PlotScript}
  echo "hist(x,width)=width*floor(x/width)+width/2.0" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [min:max]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [min:]" >> ${WorkDir}/${PlotScript}
  if [ $maxY -gt 1000 ]
  then
    echo "set yrange [0:1000]" >> ${WorkDir}/${PlotScript}
  else
    echo "set yrange [0:$maxY]" >> ${WorkDir}/${PlotScript}
  fi
  echo "#to put an empty boundary around the" >> ${WorkDir}/${PlotScript}
  echo "#data inside an autoscaled graph." >> ${WorkDir}/${PlotScript}
  echo "set size 0.99,0.97"  >> ${WorkDir}/${PlotScript}
  echo "set xtics min,(max-min)/5,max" >> ${WorkDir}/${PlotScript}
  echo "set boxwidth width*0.9" >> ${WorkDir}/${PlotScript}
  echo "set style fill solid 0.75 #fillstyle" >> ${WorkDir}/${PlotScript}
  echo "set tics out nomirror" >> ${WorkDir}/${PlotScript}
  echo "set xlabel \"x\"" >> ${WorkDir}/${PlotScript}
  echo "set ylabel \"Frequency\"" >> ${WorkDir}/${PlotScript}
  echo "#count and plot" >> ${WorkDir}/${PlotScript}
  echo "plot \"${DataFilePath}\" u (hist(\$1,width)):(1.0) smooth freq w boxes lc rgb \"red\" notitle" >> ${WorkDir}/${PlotScript}
  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait Time Histogram</a>" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1262_iostatnfstrendwaithist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostatnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Raw NFS filesystem Wait Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html


  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolunwaitnfs_local

##
##

Mkplot_iolunservXwaitnfs_local()
{

  echo "Creating iostatnfs individual LUN service X wait plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatnfsservXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minServ=`cat ${PlotDataDir}/iostatnfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxServ=`cat ${PlotDataDir}/iostatnfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWait=`cat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostatnfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatnfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Service from $minServ to $maxServ"
  ##  echo "  Wait    from $minWait to $maxWait"
  ##  echo "  Y       from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iostatnfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filesystem Service versus Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw NFS filesystem Service versus Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Service times from $minServ to $maxServ" >> ${WebDir}/index.html
  echo "<br>Wait times from $minWait to $maxWait" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolunservXwaitnfs_local

##
##

Mkplot_iolunperopsnfs_local()
{

  echo "Creating iostatnfs individual LUN read/write K per op plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatnfsrwperop"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minRperop=`cat ${PlotDataDir}/iostatnfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxRperop=`cat ${PlotDataDir}/iostatnfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWperop=`cat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostatnfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatnfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Read K per op from $minRperop to $maxRperop"
  ##  echo "  Writ K per op from $minWperop to $maxWperop"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iostatnfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filesystem Read and Write K per Operation'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw NFS filesystem Read and Write K per Operation</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read K per Op from $minRperop to $maxRperop" >> ${WebDir}/index.html
  echo "<br>Write K per Op from $minWperop to $maxWperop" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  plot raw wait time vs raw write size
  ##

  echo "Creating iostatnfs individual LUN write K per op vs. wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1267_iostatnfswkXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minWperop=`cat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWait=`cat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`


  minY=`cat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Writ K per op from $minWperop to $maxWperop"
  ##  echo "  Wait time from $minWait to $maxWait"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ##  setup the individual plots

  echo "set label 'WriteK/op' at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  legendY=`expr $legendY - $legincY`

  echo "set label 'Wait Time' at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  combine into a single plot

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual NFS filesystem Write K per Operation versus Wait Time (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  ##  echo "set ytics" >> ${WorkDir}/${PlotScript}
  ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
  echo "unset ytics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minWperop}:${maxWperop}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minWait}:${maxWait}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw NFS filesystem Write K per Operation versus Wait Time</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Write K per Op from $minWperop to $maxWperop" >> ${WebDir}/index.html
  echo "<br>Wait time from $minWait to $maxWait ms" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_iolunperopsnfs_local

##
##

Mkplot_iorwopsacfs_local()
{

  echo "Creating ACFS iocalc read + write ops plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_iocalcacfsrwops"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges


  ## minY=`cat ${PlotDataDir}/iocalcacfs_rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wops-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/iocalcacfs_rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wops-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  minX=`cat ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadOps=`cat ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadOps=`cat ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteOps=`cat ${PlotDataDir}/iocalcacfs_Wops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteOps=`cat ${PlotDataDir}/iocalcacfs_Wops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Averaged Read and Write Operations (stacked)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Averaged R/W Ops</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read ops from $minReadOps to $maxReadOps" >> ${WebDir}/index.html
  echo "<br>Write ops from $minWriteOps to $maxWriteOps" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iorwopsacfs_local

##
##

Mkplot_iorwkacfs_local()
{

  echo "Creating ACFS iocalc read + write K plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1220_iocalcacfsrwk"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcacfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcacfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcacfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/iocalcacfs_readk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/iocalcacfs_readk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteK=`cat ${PlotDataDir}/iocalcacfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/iocalcacfs_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcacfs_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writek-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Averaged Read and Write KBytes'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Averaged R/W KBytes</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read Kbytes from $minReadK to $maxReadK" >> ${WebDir}/index.html
  echo "<br>Write Kbytes rom $minWriteK to $maxWriteK" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "Creating ACFS iocalc read + write K per op plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1225_iocalcacfskperop"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/iocalcacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/iocalcacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWriteK=`cat ${PlotDataDir}/iocalcacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/iocalcacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Averaged Read and Write KBytes per operation'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Averaged R/W KBytes per Operation</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read Kbytes from $minReadK to $maxReadK" >> ${WebDir}/index.html
  echo "<br>Write Kbytes rom $minWriteK to $maxWriteK" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iorwkacfs_local

##
##

Mkplot_ioawtransacfs_local()
{

  echo "Creating ACFS iocalc active + wait transactions plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1230_iocalcacfsawtrans"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Averaged Active and Wait Transaction Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Averaged Disk Transactions</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Wait transactions from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Active transactions from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_ioawtransacfs_local

##
##

Mkplot_iodevcountacfs_local()
{

  echo "Creating ACFS iocalc devcount plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1250_iocalcacfsdevcount"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalcacfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcacfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcacfs_numdev-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Device Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Path Count</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iodevcountacfs_local

##
##

Mkplot_ioaasvctacfs_local()
{

  echo "Creating ACFS iocalc service time weighted average plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1240_iocalcacfsaasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWAsvct=`cat ${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWAsvct=`cat ${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minAsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Weighted Average Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  ##
  ##  create the index.html entry
  ##

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Average Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average service time from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  echo "<br>Weighted average service time from $minWAsvct to $maxWAsvct" >> ${WebDir}/index.html

  ##
  ##  create the trend plot - use weighted service times
  ##

  echo "  Creating ACFS trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1242_iocalcacfstrendasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iocalcacfs_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iocalcacfs_statsweighted-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - ACFS Weighted Average Service Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ## echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average Weighted Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ## echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_ioaasvctacfs_local

##
##

Mkplot_iowasvctacfs_local()
{

  echo "Creating ACFS iocalc wait time weighted average plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1240_iocalcacfswasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minWsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Weighted Average Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Average Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average wait time from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Weighted average wait time from $minWWsvct to $maxWWsvct" >> ${WebDir}/index.html

  echo "  Creating ACFS trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1242_iocalcacfstrendwasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iocalcacfs_statswsvct_a-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - ACFS Weighted Average Wait Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iowasvctacfs_local

##
##

Mkplot_servXwaitacfs_local()
{

  echo "Creating ACFS iocalc combined average service and wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1250_iocalcacfswaitXserv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  ## minX=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  ## maxX=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ## minWWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  ## maxWWsvct=`cat ${PlotDataDir}/iocalcacfs_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  asvct from $minAsvct to $maxAsvct"
  ## echo "  wsvct from $minWsvct to $maxWsvct"
  ## echo "  Y from $minY to $maxY"

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minWsvct -ne 0  -a  $minAsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iocalcacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalcacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ## ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents
  NumThrottleEvents=`${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'"`

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating ACFS throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Average Service and Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Average Wait Times and Service times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average wait time from $minWsvct to $maxWsvct" >> ${WebDir}/index.html
  echo "<br>Average service time from $minAsvct to $maxAsvct" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_servXwaitacfs_local

##
##

Mkplot_iolundataacfs_local()
{

  echo "Creating ACFS iostat individual LUN data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatacfslundata"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minY=`cat ${PlotDataDir}/iostatacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostatacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Raw LUN Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##  create the frequencey distribution plot script
  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatacfslunhist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1
  ##  create the gnuplot script header
  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Service Time Histogram (ms)'" >> ${WorkDir}/${PlotScript}

  echo "n=20 #number of intervals" >> ${WorkDir}/${PlotScript}
  echo "max=$maxY #max value" >> ${WorkDir}/${PlotScript}
  echo "min=$minY #min value" >> ${WorkDir}/${PlotScript}
  echo "width=(max-min)/n #interval width" >> ${WorkDir}/${PlotScript}
  echo "#function used to map a value to the intervals" >> ${WorkDir}/${PlotScript}
  echo "hist(x,width)=width*floor(x/width)+width/2.0" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [min:max]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [min:]" >> ${WorkDir}/${PlotScript}
  if [ $maxY -gt 1000 ]
  then
    echo "set yrange [0:1000]" >> ${WorkDir}/${PlotScript}
  else
    echo "set yrange [0:$maxY]" >> ${WorkDir}/${PlotScript}
  fi
  echo "#to put an empty boundary around the" >> ${WorkDir}/${PlotScript}
  echo "#data inside an autoscaled graph." >> ${WorkDir}/${PlotScript}
  echo "set size 0.99,0.97"  >> ${WorkDir}/${PlotScript}
  echo "set xtics min,(max-min)/5,max" >> ${WorkDir}/${PlotScript}
  echo "set boxwidth width*0.9" >> ${WorkDir}/${PlotScript}
  echo "set style fill solid 0.75 #fillstyle" >> ${WorkDir}/${PlotScript}
  echo "set tics out nomirror" >> ${WorkDir}/${PlotScript}
  echo "set xlabel \"x\"" >> ${WorkDir}/${PlotScript}
  echo "set ylabel \"Frequency\"" >> ${WorkDir}/${PlotScript}
  echo "#count and plot" >> ${WorkDir}/${PlotScript}
  echo "plot \"${DataFilePath}\" u (hist(\$1,width)):(1.0) smooth freq w boxes lc rgb \"red\" notitle" >> ${WorkDir}/${PlotScript}
  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Service Time Histogram</a>" >> ${WebDir}/index.html

  echo "  Creating ACFS trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1262_iostatacfstrendlunhist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostatacfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostatacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Service Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolundataacfs_local

##
##

Mkplot_iolunactvacfs_local()
{

  echo "Creating ACFS iostat individual LUN trans count data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatacfslunactv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  ## minY=`cat ${PlotDataDir}/iostatacfs_actv-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_tottrans-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/iostatacfs_actv-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_tottrans-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostatacfs_actv-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatacfs_actv-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostatacfs_actv-${ServerName}-${StartTime}_${EndTime}.dat # ${PlotDataDir}/iostatacfs_tottrans-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Active Transaction Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS:  Raw LUN Active Transactions</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  echo "  Creating ACFS trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatacfstrendlunactv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostatacfs_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostatacfs_actv-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - ACFS Raw LUN Transaction Count"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html


  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_iolunactvacfs_local

##
##

Mkplot_iolunwaitacfs_local()
{

  echo "Creating ACFS iostat individual LUN wait plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatacfslunwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minY=`cat ${PlotDataDir}/iostatacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostatacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Raw LUN Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##  create the frequencey distribution plot script
  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatacfswaithist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1
  ##  create the gnuplot script header
  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Wait Time Histogram (ms)'" >> ${WorkDir}/${PlotScript}

  echo "n=20 #number of intervals" >> ${WorkDir}/${PlotScript}
  echo "max=$maxY #max value" >> ${WorkDir}/${PlotScript}
  echo "min=$minY #min value" >> ${WorkDir}/${PlotScript}
  echo "width=(max-min)/n #interval width" >> ${WorkDir}/${PlotScript}
  echo "#function used to map a value to the intervals" >> ${WorkDir}/${PlotScript}
  echo "hist(x,width)=width*floor(x/width)+width/2.0" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [min:max]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [min:]" >> ${WorkDir}/${PlotScript}
  if [ $maxY -gt 1000 ]
  then
    echo "set yrange [0:1000]" >> ${WorkDir}/${PlotScript}
  else
    echo "set yrange [0:$maxY]" >> ${WorkDir}/${PlotScript}
  fi
  echo "#to put an empty boundary around the" >> ${WorkDir}/${PlotScript}
  echo "#data inside an autoscaled graph." >> ${WorkDir}/${PlotScript}
  echo "set size 0.99,0.97"  >> ${WorkDir}/${PlotScript}
  echo "set xtics min,(max-min)/5,max" >> ${WorkDir}/${PlotScript}
  echo "set boxwidth width*0.9" >> ${WorkDir}/${PlotScript}
  echo "set style fill solid 0.75 #fillstyle" >> ${WorkDir}/${PlotScript}
  echo "set tics out nomirror" >> ${WorkDir}/${PlotScript}
  echo "set xlabel \"x\"" >> ${WorkDir}/${PlotScript}
  echo "set ylabel \"Frequency\"" >> ${WorkDir}/${PlotScript}
  echo "#count and plot" >> ${WorkDir}/${PlotScript}
  echo "plot \"${DataFilePath}\" u (hist(\$1,width)):(1.0) smooth freq w boxes lc rgb \"red\" notitle" >> ${WorkDir}/${PlotScript}
  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait Time Histogram</a>" >> ${WebDir}/index.html

  echo "  Creating ACFS trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1262_iostatacfstrendwaithist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostatacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - ACFS Raw LUN Wait Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html


  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolunwaitacfs_local

##
##

Mkplot_iolunservXwaitacfs_local()
{

  echo "Creating ACFS iostat individual LUN service X wait plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatacfsservXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minServ=`cat ${PlotDataDir}/iostatacfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxServ=`cat ${PlotDataDir}/iostatacfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWait=`cat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostatacfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatacfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Service from $minServ to $maxServ"
  ##  echo "  Wait    from $minWait to $maxWait"
  ##  echo "  Y       from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iostatacfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating ACFS throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Service versus Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Raw LUN Service versus Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Service times from $minServ to $maxServ" >> ${WebDir}/index.html
  echo "<br>Wait times from $minWait to $maxWait" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolunservXwaitacfs_local

##
##

Mkplot_iolunperopsacfs_local()
{

  echo "Creating ACFS iostat individual LUN read/write K per op plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatacfsrwperop"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minRperop=`cat ${PlotDataDir}/iostatacfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxRperop=`cat ${PlotDataDir}/iostatacfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWperop=`cat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostatacfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatacfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Read K per op from $minRperop to $maxRperop"
  ##  echo "  Writ K per op from $minWperop to $maxWperop"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iostatacfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating ACFS throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Read and Write K per Operation'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Raw LUN Read and Write K per Operation</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read K per Op from $minRperop to $maxRperop" >> ${WebDir}/index.html
  echo "<br>Write K per Op from $minWperop to $maxWperop" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  plot raw wait time vs raw write size
  ##

  echo "Creating ACFS iostat individual LUN write K per op vs. wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1267_iostatacfswkXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minWperop=`cat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWait=`cat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`


  minY=`cat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Writ K per op from $minWperop to $maxWperop"
  ##  echo "  Wait time from $minWait to $maxWait"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ##  setup the individual plots

  echo "set label 'WriteK/op' at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  legendY=`expr $legendY - $legincY`

  echo "set label 'Wait Time' at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  combine into a single plot

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ACFS Individual LUN Write K per Operation versus Wait Time (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  ##  echo "set ytics" >> ${WorkDir}/${PlotScript}
  ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
  echo "unset ytics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minWperop}:${maxWperop}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minWait}:${maxWait}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">ACFS: Raw LUN Write K per Operation versus Wait Time</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Write K per Op from $minWperop to $maxWperop" >> ${WebDir}/index.html
  echo "<br>Wait time from $minWait to $maxWait ms" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_iolunperopsacfs_local

##
##
