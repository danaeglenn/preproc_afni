cd $SUBJECTS_DIR

for sub in `cat subjList.txt`; do

check_dset_for_fs.py -input ${sub}/anat/${sub}_anat+orig -verb > ${sub}/anat/dset_safe4FS.txt

done
