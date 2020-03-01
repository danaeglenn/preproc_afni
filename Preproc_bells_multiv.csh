#!/bin/tcsh

set age = adult
set group = bells
set censorLimit = 1
set suffix = Feb2020_MV_${censorLimit}mmOutlierCensored

cd $SUBJECTS_DIR/${age}_${group}

set subjects=(`cat subjList_test.txt`)

foreach subj ($subjects)
cd ${subj}/afni
afni_proc.py   -subj_id ${subj} \
	-dsets OutBrick_r?+orig.HEAD \
	-scr_overwrite \
	-radial_correlate_blocks tcat volreg \
	-copy_anat ../anat/${subj}_anat+orig \
	-tcat_remove_first_trs 4   \
	-do_block align \
	-align_opts_aea -giant_move -cost lpc+ZZ -AddEdge \
	-volreg_align_to MIN_OUTLIER \
	-volreg_align_e2a \
	-blur_size 1 \
	-out_dir ${subj}.results.$suffix \
	-script ${subj}.script.$suffix \
    -regress_stim_times ../behav_data/${subj}_${group}_extrecall2_allruns_* \
	-regress_basis 'BLOCK(4,1)' \
        -regress_stim_labels ACSplus0 ACSplus20 ACSplus40 ACSplus60 ACSplus80 ACSplus100 RCSplus0 RCSplus20 RCSplus40 RCSplus60 RCSplus80 RCSplus100 \
    -regress_make_ideal_sum sum_ideal.1D \
    -regress_est_blur_epits \
    -regress_est_blur_errts \
	-regress_reml_exec \
    -regress_censor_outliers 0.1 \
	-regress_censor_motion $censorLimit

chmod 775 ${subj}.script.$suffix
tcsh -xef ${subj}.script.$suffix |& tee output.${subj}.script.$suffix

cd ../scripts
@ line_no++
end
 
else
echo " need subject list"
exit
endif
