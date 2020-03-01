export age=youth
export task=bells

cd /Volumes/UCR-KINDLab/danag/OngoingAnalyses/Bells_Scream/${age}_${task}
SUBJECTS_DIR=pwd

for sub in `cat subjList.txt`; do

# orient freesufer output to experiment space – real orig space
@SUMA_Make_Spec_FS -NIFTI -fspath ${sub} -sid ${sub} -fs_setup


done
