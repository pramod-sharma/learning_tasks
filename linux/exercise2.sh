tar -cv $1 > backup.tar
gzip -c backup.tar > backup_$(date +%d_%m_%y_%H%M).tar.gz