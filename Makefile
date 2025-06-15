push:
	rclone sync -v --exclude *.swp /home/mischia/googledrive/txt_documents google_drive:txt_documents 

pull:
	rclone sync -v --exclude *.swp google_drive:txt_documents /home/mischia/googledrive/txt_documents 

safepush:
	rclone sync -v --exclude *.swp /home/mischia/googledrive/txt_documents google_drive:txt_documents --backup-dir=google_drive:/.backup/`date +%Y%m%d.%I%M%S`

safepull:
	rclone sync -v --exclude *.swp google_drive:txt_documents /home/mischia/googledrive/txt_documents --backup-dir=/home/mischia/.googledrivebackup/`date +%Y%m%d.%I%M%S`

drypush:
	rclone sync --exclude *.swp -n . google_drive:

drypull:
	rclone sync --exclude *.swp -n google_drive: .

