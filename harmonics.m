%% frequency harmonic test
addpath('N:\\ANAP\\02_home\\AnnikaZ\\002Experiments\\eeglab\\eeglab\\')
Channel_Locations = 'N:\\ANAP\\02_home\\AnnikaZ\\002Experiments\\eeglab\\eeglab\\sample_locs\\ElectrodeLocations64.elp'; %electrode position file
Remove_Channels = {'EXG1' 'EXG2' 'EXG3' 'EXG4' 'EXG5' 'EXG6' 'EXG7' 'EXG8' 'GSR1' 'GSR2' 'Erg1' 'Erg2' 'Resp' 'Plet' 'Temp'}; %external channels to be removed from the datasets
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
subjectpath = 'N:\\ANAP\\01_data\\Xmodal_Annika\\Learn\\EEG\\data2analyze\\'
subj = '03'
eegdata = sprintf('%s%s.bdf',subjectpath,subj);
EEG = pop_biosig(eegdata);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',sprintf('%s_raw.set',subj),'savenew',sprintf('%s%s_raw.set',subjectpath,subj),'gui','off'); 
%% 
% Version 1: 1. load data, 2. remove unnecessary channels, 3. add channel
% locations, 4. rereference (average), 5. resample from 512 to 500 hz 
EEG = pop_loadset('filename',sprintf('%s_raw.set',subj),'filepath','N:\\ANAP\\01_data\\Xmodal_Annika\\Learn\\EEG\\data2analyze\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',sprintf('%s_version1.set',subj),'savenew',sprintf('%s%s_version1.set',subjectpath,subj),'gui','off'); 
EEG = pop_select( EEG, 'nochannel',{'EXG1' 'EXG2' 'EXG3' 'EXG4' 'EXG5' 'EXG6' 'EXG7' 'EXG8' 'GSR1' 'GSR2' 'Erg1' 'Erg2' 'Resp' 'Plet' 'Temp'});
%add channel locations
EEG = pop_chanedit(EEG, 'load',{Channel_Locations 'filetype' 'besa'});
%rereference data <- average reference
EEG = pop_reref( EEG, []);
%resample data from 512 to 500
EEG = pop_resample( EEG, 500);
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [], 'EEG' , 'percent', 15, 'freq', [12 24 36 48], 'freqrange',[2 80],'electrodes','off');

%%
% Version 2: 1. load data, 2. remove unnecessary channels, 3. add channel
% locations, 4. rereference (average), 5. remove baseline (DC correct) 6. resample from 512 to 500 hz 
EEG = pop_loadset('filename',sprintf('%s_raw.set',subj),'filepath','N:\\ANAP\\01_data\\Xmodal_Annika\\Learn\\EEG\\data2analyze\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',sprintf('%s_version2.set',subj),'savenew',sprintf('%s%s_version2.set',subjectpath,subj),'gui','off'); 
EEG = pop_select( EEG, 'nochannel',{'EXG1' 'EXG2' 'EXG3' 'EXG4' 'EXG5' 'EXG6' 'EXG7' 'EXG8' 'GSR1' 'GSR2' 'Erg1' 'Erg2' 'Resp' 'Plet' 'Temp'});
%add channel locations
EEG = pop_chanedit(EEG, 'load',{Channel_Locations 'filetype' 'besa'});
%rereference data <- average reference
EEG = pop_reref( EEG, []);
%remove baseline
EEG = pop_rmbase( EEG, [],[]);
%resample data from 512 to 500
EEG = pop_resample( EEG, 500);
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [], 'EEG' , 'percent', 15, 'freq', [12 24 36 48], 'freqrange',[2 80],'electrodes','off');


%%
% Version 3: 1. load data, 2. remove unnecessary channels, 3. add channel
% locations, 4. rereference (average), 5. High-pass filter 0.1 Hz 6. resample from 512 to 500 hz 

EEG = pop_loadset('filename',sprintf('%s_raw.set',subj),'filepath','N:\\ANAP\\01_data\\Xmodal_Annika\\Learn\\EEG\\data2analyze\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',sprintf('%s_version3.set',subj),'savenew',sprintf('%s%s_version3.set',subjectpath,subj),'gui','off'); 
EEG = pop_select( EEG, 'nochannel',{'EXG1' 'EXG2' 'EXG3' 'EXG4' 'EXG5' 'EXG6' 'EXG7' 'EXG8' 'GSR1' 'GSR2' 'Erg1' 'Erg2' 'Resp' 'Plet' 'Temp'});
%add channel locations
EEG = pop_chanedit(EEG, 'load',{Channel_Locations 'filetype' 'besa'});
%rereference data <- average reference
EEG = pop_reref( EEG, []);
%highpass
eeglab redraw
EEG = pop_eegfiltnew(EEG, [],0.05,33792,1,[],1);
%resample data from 512 to 500
EEG = pop_resample( EEG, 500);
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [], 'EEG' , 'percent', 15, 'freq', [12 24 36 48], 'freqrange',[2 80],'electrodes','off');
