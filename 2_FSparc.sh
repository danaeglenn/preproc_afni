

cd $SUBJECTS_DIR/FS
export age=adult
export task=bells

ls ../${age}_${task}| grep ^s > subjList.txt

for sub in `cat subjList.txt`; do
3dAFNItoNIFTI ${sub}/anat/${sub}_anat+orig 
cp ${sub}_anat.nii ../FS_${age}_${task}
mv ${sub}_anat.nii ${sub}/anat
done

ls *.nii | parallel --jobs 8 recon-all -s {.} -i {} -all -qcache

