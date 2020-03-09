#!/bin/tcsh

set age = adult
set censorLimit = 1
set suffix = Feb2020_UV_${censorLimit}mmOutlierCensored

cd $SUBJECTS_DIR/${age}_bells

set subjects=(`cat subjList_test.txt`)

foreach subj ($subjects)
cd ${subj}/afni
afni_proc.py   -subj_id ${subj} \
	-dsets OutBrick_r?+orig.HEAD \
	-anat_has_skull no \
	-scr_overwrite \
	-radial_correlate_blocks tcat volreg \
	-copy_anat ../anat/${subj}_anat+orig \
	-tcat_remove_first_trs 4   \
	-do_block align tlrc \
	-align_opts_aea -giant_move -cost lpc+ZZ -AddEdge \
	-tlrc_base MNI152_2009_template_SSW.nii.gz \
	-tlrc_NL_warp \
        -tlrc_NL_warped_dsets ../anat/anatQQ.${subj}.nii \
         	../anat/anatQQ.${subj}.aff12.1D \
               	../anat/anatQQ.${subj}_WARP.nii \
	-volreg_align_to MIN_OUTLIER \
	-volreg_align_e2a \
	-volreg_tlrc_warp \
	-blur_size 6 \
	-out_dir ${subj}.results.$suffix \
	-script ${subj}.script.$suffix \
    -regress_stim_times ../behav_data/${subj}_bells_extrecall2_allruns_* \
	-regress_basis 'BLOCK(4,1)' \
        -regress_stim_labels ACSplus0 ACSplus20 ACSplus40 ACSplus60 ACSplus80 ACSplus100 RCSplus0 RCSplus20 RCSplus40 RCSplus60 RCSplus80 RCSplus100 \
	-regress_opts_3dD \
     	-gltsym 'SYM: +ACSplus100 -ACSplus0' -glt_label 1 Afraid_CSPlusvCSMinus \
     	-gltsym 'SYM: +RCSplus100 -RCSplus0' -glt_label 2 Rang_CSPlusvCSMinus  \
        -gltsym 'SYM: +ACSplus100 +ACSplus80 +ACSplus60 -ACSplus40 -ACSplus20 -ACSplus0' -glt_label 3 Afraid_CSPlusvCSMinus_all  \
        -gltsym 'SYM: +RCSplus100 +RCSplus80 +RCSplus60 -RCSplus40 -RCSplus20 -RCSplus0' -glt_label 4 Rang_CSPlusvCSMinus_all \
     	-gltsym 'SYM: +ACSplus0 +ACSplus20 +ACSplus40 +ACSplus60 +ACSplus80  +ACSplus100 +RCSplus0 +RCSplus20 +RCSplus40 +RCSplus60 +RCSplus80 +RCSplus100' -glt_label 5 BellvFix \
        -cbucket cbucket.stats.${subj} \
        -xsave  \
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
