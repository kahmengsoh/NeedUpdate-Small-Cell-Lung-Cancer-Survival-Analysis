libname data 'C:\Users\ksoh\Desktop';

ODS GRAPHICS ON;

PROC phreg DATA=data.ncdb_puf_adjusted_filtered;
class Sex_Gender Insurance_Status_Categorized Surgery_Type_Classified treatment (ref='SequentialOrConcurrent');
model DX_LASTCONTACT_DEATH_DAYS_Add150*PUF_VITAL_STATUS(1) = treatment Sex_Gender age Insurance_Status_Categorized Surgery_Type_Classified/RL;
assess var=(age) ph / resample;
RUN;

ODS GRAPHICS OFF;

