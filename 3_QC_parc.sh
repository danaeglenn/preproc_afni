export SUBJECTS_DIR=/Volumes/UCR-KINDLab/danag/OngoingAnalyses/Bells_Scream/youth_scream

#need to change the folder manually


freeview -v \
$SUBJECTS_DIR/$1/mri/T1.mgz \
$SUBJECTS_DIR/$1/mri/wm.mgz \
$SUBJECTS_DIR/$1/mri/brainmask.mgz \
$SUBJECTS_DIR/$1/mri/aseg.mgz:colormap=lut:opacity=0.2 \
$SUBJECTS_DIR/$1/mri/aparc+aseg.mgz:colormap=lut:opacity=0.2 \
$SUBJECTS_DIR/$1/mri/aparc.a2009s+aseg.mgz:colormap=lut:opacity=0.2 \
-f $SUBJECTS_DIR/$1/surf/lh.white:edgecolor=blue \
$SUBJECTS_DIR/$1/surf/lh.pial:edgecolor=red \
$SUBJECTS_DIR/$1/surf/rh.white:edgecolor=blue \
$SUBJECTS_DIR/$1/surf/rh.pial:edgecolor=red