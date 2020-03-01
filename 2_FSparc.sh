

cd $SUBJECTS_DIR/FS

ls ../adult_bells| grep ^s > subjList.txt

for sub in `cat subjList.txt`; do
3dAFNItoNIFTI ${sub}/anat/${sub}_anat+orig 
cp ${sub}_anat.nii ../FS_youth_bells
mv ${sub}_anat.nii ${sub}/anat
done

ls *.nii | parallel --jobs 8 recon-all -s {.} -i {} -all -qcache

#rm *.nii

#for sub in `cat subjList.txt`; do
#mv ${sub}_anat.nii ${sub}
#done
