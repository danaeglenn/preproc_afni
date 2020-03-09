#!/bin/tcsh
cd $SUBJECTS_DIR/adult_scream
set subjects = (`cat subjList_rerun.txt`)
foreach subj ($subjects)
#skull strip and calculate warp to a reference template/standard space
@SSwarper -input ${subj}/anat/${subj}_anat+orig \
	-subid ${subj} \
	-odir  ${subj}/anat_warped \
	-base MNI152_2009_template_SSW.nii.gz
end
