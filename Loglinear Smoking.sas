proc surveyselect data = sashelp.BWeight method = SRS rep = 1 
  sampsize = 5000 seed = 767 out = birthwtsamp;
  id _all_; run;
PROC FREQ data=birthwtsamp;
     tables MomSmoke*Visit*MomEdLevel/out = birthwtfreq nocol nopercent relrisk;
 RUN;
proc format;
   value vfmt 0 = 'No Visit'       1 = 'Second Trimester'
              2 = 'Last Trimester' 3 = 'First Trimester';
   value efmt 0 = 'High School'    1 = 'Some College'
              2 = 'College'        3 = 'Less Than High School';
run;
proc catmod data = birthwtfreq;
	format Visit vfmt. MomEdLevel efmt.;
	title 'proc catmod for 2X4X4 tables';
	weight Count;
	model MomSmoke*Visit*MomEdLevel =_response_ / noresponse noiter;
	loglin MomSmoke|Visit|MomEdLevel;
run;
proc catmod data = birthwtfreq;
	format Visit vfmt. MomEdLevel efmt.;
	title 'reduced model w/o 3 way interaction';
	weight Count;
	model MomSmoke*Visit*MomEdLevel =_response_ / noresponse noiter;
	loglin MomSmoke|Visit MomSmoke|MomEdLevel Visit*MomEdLevel;
run;
proc catmod data = birthwtfreq;
	format Visit vfmt. MomEdLevel efmt.;
	title '2 way interaction w/o Visit|MomEdLevel';
	weight Count;
	model MomSmoke*Visit*MomEdLevel =_response_ / noresponse noiter;
	loglin MomSmoke|Visit MomSmoke|MomEdLevel;
run;
proc catmod data = birthwtfreq;
	format Visit vfmt. MomEdLevel efmt.;
	title '2 way interaction w/o MomSmoke|MomEdLevel';
	weight Count;
	model MomSmoke*Visit*MomEdLevel =_response_ / noresponse noiter;
	loglin MomSmoke|Visit Visit|MomEdLevel ;
run;
proc catmod data = birthwtfreq;
	format Visit vfmt. MomEdLevel efmt.;
	title '2 way interaction w/o MomSmoke|Visit';
	weight Count;
	model MomSmoke*Visit*MomEdLevel =_response_ / noresponse noiter;
	loglin MomSmoke|MomEdLevel Visit|MomEdLevel ;
run;

