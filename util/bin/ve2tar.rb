#!/usr/bin/ruby

require 'rubygems'
require 'keystone'

include Keystone::Batch::Base

####################################################################
VEIDS = ["170161"]
PRIVATE_DIR = "/vz/private"
BACKUP_DIR = "/cluster/dsk0/backup/vz"
# replace string __VEID__
EXCLUDES = ["/vz/private/__VEID__/usr/local/rails/tubebox/shared/movie"] 
# replace string __VEID__
TAR_FILE_NAME = "__VEID__-#{Time.now.strftime("%Y%m%d")}.tar.gz"
####################################################################

execute do
  raise "PRIVATE_DIR not set" if PRIVATE_DIR.blank?
  raise "BACKUP_DIR not set" if BACKUP_DIR.blank?

  VEIDS.each do |veid|
    vedir = "#{PRIVATE_DIR}/#{veid}"
    backupdir = "#{BACKUP_DIR}/#{veid}/"
    backupfile = "#{BACKUP_DIR}/#{veid}/#{TAR_FILE_NAME}".gsub(/__VEID__/,veid)
    FileUtils.mkdir_p(backupdir)
    (error "#{backupdir} not found";next) unless File.directory?(backupdir)
    (error "veid #{veid} not found";next) unless File.exists?("#{PRIVATE_DIR}/#{veid}")
    #(error "veid #{veid} still running";next) if ` /usr/sbin/vzlist #{veid}|/bin/grep running -c`.strip != "1"

    exclude = ""
    EXCLUDES.each{|exc| exclude += " --exclude=#{exc.gsub(/__VEID__/,veid)} "}
    
    cmds = ["/usr/sbin/vzctl stop #{veid}",
      "/bin/tar #{exclude} -cvzf #{backupfile} #{vedir} /etc/vz/conf/#{veid}.conf",
      "/usr/sbin/vzctl start #{veid}"]

    cmds.each do |cmd| 
      puts cmd
      `#{cmd}` unless $DEBUG
    end
  end
end

__END__

original

VEID=$1
VEPRIVATEDIR=$2
TARFILENAME=$3

if [ "${VEID}" = "" ]; then
    echo "usage: $0 <VEID> <VEPRIVATEDIR> <TAR FILE NAME>"
    exit
fi
if [ "${VEPRIVATEDIR}" = "" ]; then
  echo "usage: $0 <VEID> <VEPRIVATEDIR> <TAR FILE NAME>"
    exit
fi
if [ "${TARFILENAME}" = "" ]; then
  echo "usage: $0 <VEID> <VEPRIVATEDIR> <TAR FILE NAME>"
    exit
fi

if [ ! -d ${VEPRIVATEDIR}/${VEID} ]; then
    echo "error: VEID is not exist"
    exit
fi

if [ ` /usr/sbin/vzlist ${VEID}|/bin/grep running -c` -gt 0  ]; then
        echo "you must stop ve "
        echo `/usr/sbin/vzlist ${VEID}|/bin/grep running`
        exit
fi

#/bin/tar --ignore-failed-read --exclude=./mnt --exclude=./u01/mydata                   --exclude=./u01/mytmp --exclude=./u01/myarclog --exclude=./u01/mybackup                   --exclude=./u02/mydata  --exclude=./u02/mytmp --exclude=./u02/myarclog                   --exclude=./u02/mybackup --exclude=./d01 --exclude=./var/spool/upgrade                   --exclude=./proc --exclude=./lost+found --exclude=./sys                   --exclude=./usr/local/vlmail/logs/history                   -cvzf ${TARFILENAME}  /cluster/dsk0/vz/private/${VEID}  /etc/vz/conf/${VEID}.conf
/bin/tar -cvzf ${TARFILENAME} ${VEPRIVATEDIR}/${VEID}  /etc/vz/conf/${VEID}.conf

exit