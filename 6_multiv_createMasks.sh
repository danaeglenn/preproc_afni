export age=adult
export task=bells

cd $SUBJECTS_DIR/${age}_${task}
SUBJECTS_DIR=pwd

#for sub in `cat subjList.txt`; do

cd ${sub}
mkdir masks

3dcopy SUMA/aparc.a2009s+aseg_REN_all.nii.gz SUMA/aparc.a2009s+aseg_REN_all    

3dcopy SUMA/aparc+aseg_REN_all.nii.gz SUMA/aparc+aseg_REN_all  

# Make masks
#IT
3dcalc -a SUMA/aparc+aseg_REN_all+orig -expr 'equals(a,89) + equals(a,54)' -prefix masks/${sub}_bil_IT_aseg_REN

#Amyg
3dcalc -a SUMA/aparc+aseg_REN_all+orig -expr 'equals(a,32) + equals(a,15)' -prefix masks/${sub}_bil_amygdala_aseg_REN

#mOFC
3dcalc -a SUMA/aparc+aseg_REN_all+orig -expr 'equals(a,59) + equals(a,94)' -prefix masks/${sub}_bil_mOFC_aseg_REN

#AI
3dcalc -a SUMA/aparc.a2009s+aseg_REN_all+orig -expr 'equals(a,170) + equals(a,95)' -prefix masks/${sub}_bil_AI_a2009s_REN

#dmPFC
3dcalc -a SUMA/aparc+aseg_REN_all+orig -expr 'equals(a,73) + equals(a,108)' -prefix masks/${sub}_bil_dmPFC_aseg_REN

#dACC
3dcalc -a SUMA/aparc+aseg_REN_all+orig -expr 'equals(a,48) + equals(a,83)' -prefix masks/${sub}_bil_dACC_aseg_REN



#Resample
ROIs="AI, amygdala, dACC, dmPFC, IT, mOFC"
for ROI in $ROIs
do
# Changes the grid spacing of the mask to match the epi file
3dresample -master afni/${sub}.results*/stats/stats.${sub}+orig -rmode NN -input masks/${sub}_bil_${ROI}* -prefix masks/${sub}_${ROI}_resam
done 
