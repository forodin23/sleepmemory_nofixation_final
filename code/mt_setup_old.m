function dirRoot = mt_setup(user)
% ** function mt_setup(user) 
% This script allows to adjust the most important parameters for the memory
% task. Define the variables here before you run mt_run.m.
% 
% IMPORTANT:    Do not change the order in which the variables are defined.
%               Some variables have mutual dependencies.
%
% >>> INPUT VARIABLES >>>
% NAME              TYPE        DESCRIPTION
% user              char       	pre-defined user name (see mt_loadUser.m)

% <<< OUTPUT VARIABLES <<<
% NAME              TYPE        DESCRIPTION
% dirRoot           char        path to root working directory
%
% 
% AUTHOR:   Marco R�th, contact@marcorueth.com
%           Jens Klinzing, jens.klinzing@uni-tuebingen.de

%% ============================== BASICS ================================ %
% IMPORTANT: add your user profile in mt_loadUser
[dirRoot, dirPTB]   = mt_profile(user);

% Expermimental Details
experimentName      = 'Sleep Connectivity'; % name of your study
nLearningSess       = 3; % number of learning runs for learning
nInterferenceSess   = 3; % number of learning runs for interference
nMinRecall          = 1; % minimum runs for immediate recall (with feedback)
nMaxRecall          = 1; % maximum runs for immediate recall (to exclude if too poor performance)
nFinalRecall        = 1; % number of runs for final recall (incl. one last session w/o feedback)
RecallThreshold     = 40;% miniumum correct answers in recall (in percent)

% System
% screenNumber    = 2; % select specific screen
priority_level        = 0; % 'max' or number, put 0 if you don't have privileged rights

triggerOdorOn       = {0, 1, 16}; % trigger for MEG, SL3, SL4
triggerPlaceboOn    = {0, 2, 32}; % trigger for MEG, SL3, SL4
EEGtrigger          = 0;

%% ======================== IMAGE CONFIGURATION ========================= %

% Use file names without file extension
imageConfiguration = {
  {{ % imagesA 	LEARNING
  'ant',            'whale',        'ray',          	'hippopotamus',     'fly'           'crocodile';
  'wasp',           'toucan',       'lobster',          'raven',            'giraffe',      'cow';
  'starfish',       'rooster',      'praying_mantis',   'lioness',          'grasshopper',  'cat';
  'armadillo',      'pigeon',       'penguin',          'hummingbird',      'goose',        'barn_owl';
  'scorpion',       'oyster',       'ostrich',          'horse',            'dromedary',    'dragonfly'
  }
  { % imagesA 	INTERFERENCE
  'goose',       	'barn_owl', 	'cat',              'starfish',			'rooster', 		'pigeon';
  'dromedary',      'dragonfly',   	'armadillo',        'ostrich',      	'horse',    	'penguin';
  'hummingbird',	'scorpion',  	'whale',            'ray',      		'ant',  		'oyster';
  'grasshopper', 	'wasp',   		'cow',              'fly',              'crocodile',	'praying_mantis';
  'lioness',		'raven',        'giraffe',          'lobster',        	'hippopotamus', 'toucan'
  }}
  {{ % imagesB 	LEARNING
  'sparrow',    'tiger',        'seagull',	'turtle',       'partridge',    'cheetah';
  'zebra',      'termite',      'dolphin',	'mussel',       'manatee'       'butterfly';
  'owl',        'ladybird',     'rhino',	'mosquito',     'tapir',        'beetle';
  'elephant',   'platypus',     'pomfret',	'kiwi',         'crab',         'bee';
  'pelican',   	'hen',          'kangaroo',	'killer_whale', 'duck',         'bat'
  }
  { % imagesB 	INTERFERENCE
  'rhino',		'killer_whale',	'duck',     'kangaroo',     'pomfret',		'zebra';
  'beetle',		'crab',			'bat',      'platypus',     'ladybird'      'seagull';
  'manatee',	'butterfly',	'bee',      'sparrow',      'hen',          'termite';
  'dolphin',	'mussel', 		'cheetah',  'tiger',        'pelican',      'turtle';
  'kiwi',       'tapir',        'partridge','elephant',     'owl',          'mosquito'
  }}
};


%% =========================== IMAGE SEQUENCE =========================== %

% Define in which order cards are flipped
% Special feature for you: 2D Table-view
% You can run the section 'IMAGE CONFIGURATION' above and then look at the
% tables 'imagesATable' and 'imagesBTable' for 2D coordinates below
[imagesATable, imagesBTable] = mt_imageTable(imageConfiguration);

% Create temporal sequence for learning and interference
% Image Sequences for Image Set A
% Sequence A: Learning
imageSequenceMainLearningA = {
    'penguin', 'crocodile', 'raven', 'armadillo', 'fly', 'oyster', ...
	'starfish', 'dragonfly', 'rooster', 'cow', 'goose', 'giraffe', ...
	'barn_owl', 'lobster', 'pigeon', 'ant', 'horse', 'ray', ...
	'cat', 'hummingbird', 'hippopotamus', 'praying_mantis', 'ostrich', 'dromedary', ...
	'scorpion', 'toucan', 'grasshopper', 'whale', 'lioness', 'wasp';
    
    'whale', 'fly', 'barn_owl', 'wasp', 'lioness', 'scorpion', ...
    'horse', 'ant', 'rooster', 'grasshopper', 'toucan', 'starfish', ...
    'lobster', 'penguin', 'dromedary', 'praying_mantis', 'goose', 'cow', ...
    'oyster', 'raven', 'cat', 'ostrich', 'armadillo', 'crocodile', ...
    'dragonfly', 'ray', 'giraffe', 'pigeon', 'hippopotamus', 'hummingbird';

    'starfish', 'lioness', 'toucan', 'ant', 'raven', 'hummingbird', ...
    'cat', 'scorpion', 'hippopotamus', 'ostrich', 'praying_mantis', 'oyster', ...
    'barn_owl', 'giraffe', 'wasp', 'goose',	'armadillo', 'crocodile', ...
    'whale', 'horse', 'grasshopper', 'penguin', 'dragonfly', 'ray', ...
    'cow', 'pigeon', 'lobster', 'dromedary', 'rooster', 'fly'
   };

% Sequence A: Interference
imageSequenceInterferenceLearningA = imageSequenceMainLearningA;

% Sequence A: Recall
imageSequenceimmediateRecallA = {
    'rooster', 'giraffe', 'hummingbird', 'lobster', 'cat', 'ray', ...
    'dromedary', 'crocodile', 'armadillo', 'toucan', 'ostrich', 'wasp', ...
	'penguin', 'starfish', 'dragonfly', 'ant', 'lioness', 'scorpion', ...
	'praying_mantis', 'goose', 'cow', 'pigeon', 'hippopotamus', 'grasshopper', ...
    'oyster', 'raven', 'whale', 'horse', 'fly', 'barn_owl'
    };
imageSequenceInterferenceRecallA = imageSequenceimmediateRecallA;
imageSequenceMainRecallA = imageSequenceimmediateRecallA;

% Image Sequence for Image Set B
% Sequence B: Learning
imageSequenceMainLearningB = {
    'owl', 'kangaroo', 'sparrow', 'turtle', 'pomfret', 'cheetah', ...
	'killer_whale', 'tiger', 'duck', 'mosquito', 'bat', 'butterfly' ...
	'seagull', 'crab', 'dolphin', 'bee', 'zebra', 'tapir', ...
	'hen', 'rhino', 'elephant', 'termite', 'kiwi', 'ladybird', ...
    'mussel', 'platypus', 'manatee', 'pelican', 'beetle', 'partridge';
    
    'bee', 'turtle', 'ladybird', 'manatee', 'hen', 'cheetah', ...
    'owl', 'platypus', 'crab', 'butterfly'	'seagull', 'mussel', ...
    'partridge', 'bat', 'beetle', 'tiger', 'rhino', 'termite', ...
    'sparrow', 'killer_whale', 'tapir', 'zebra', 'pelican', 'pomfret', ...
    'duck', 'kangaroo', 'elephant', 'kiwi', 'dolphin', 'mosquito';
					
    'duck', 'platypus', 'bat', 'crab', 'seagull', 'bee', ...
    'rhino', 'termite', 'turtle', 'owl', 'beetle', 'zebra', ...
    'butterfly', 'kangaroo', 'kiwi', 'manatee', 'sparrow', 'partridge', ...
    'killer_whale', 'pelican', 'mosquito', 'tiger', 'dolphin', 'hen', ...
    'cheetah', 'ladybird', 'tapir', 'mussel', 'pomfret', 'elephant'
    };

% Sequence B: Interference
imageSequenceInterferenceLearningB = imageSequenceMainLearningB;

% Sequence B: Recall
imageSequenceimmediateRecallB = {
    'pomfret', 'beetle', 'termite', 'partridge', 'zebra', 'kiwi',  ...
    'butterfly', 'mosquito', 'duck', 'mussel', 'platypus', 'tapir', ...
    'pelican', 'crab', 'sparrow', 'turtle', 'kangaroo', 'owl', ...
    'seagull', 'elephant', 'bat', 'rhino', 'cheetah', 'hen', ...
    'dolphin', 'bee', 'killer_whale', 'tiger', 'manatee', 'ladybird' 
    };
imageSequenceInterferenceRecallB = imageSequenceimmediateRecallB;
imageSequenceMainRecallB = imageSequenceimmediateRecallB;


%% ================================ TEXT ================================ %
% Text strings used during the program

textFixation = { ...
    ''
    ''
    ''
    'Es erscheint nun ein Punkt in der Mitte'
    'des Bildschirms. Bitte schauen Sie auf diesen'
    'Punkt, solange er angezeigt wird.'
    ''
    'Dies wird etwa 6 Minuten dauern.'
};
textFixation2 = { ...
    ''
    ''
    ''
    'Legen Sie Ihre H�nde bitte locker in den Scho�.'
    ''
    ''
    'Haben Sie noch Fragen zum Ablauf?'
};

textControl = { ...
    'Z�hlaufgabe'
    ''
    'Im Folgenden sehen Sie ein Feld voller kleiner hellgrauer'
    'Karten. Dar�ber befindet sich eine gro�e Karte.'
    'Zun�chst wird die obere Karte ein Bild voller Farbsplitter'
    'anzeigen, dann wird das gleiche Bild irgendwo im unteren Feld'
    'angezeigt. '
    'Zusammen z�hlt dies als ein Durchgang.'
    ''
    'Bitte z�hlen Sie die Anzahl dieser Durchg�nge.'
    ''
};
textControl2 = { ...
    ''
    'Jedes Mal, wenn eine der kleinen Karten ein Bild anzeigt,'
    'erscheint auf ihr ein kleiner Punkt. Bitte schauen Sie'
    'entspannt direkt auf diesen Punkt sobald Sie ihn sehen und'
    'bewegen Sie Ihre Augen dann w�hrend des Durchgangs nicht mehr.'
    ''
    'Bitte blinzeln sie m�glichst nicht w�hrend der Durchg�nge.'
    ''
    'Zwischen den Durchg�ngen haben Sie 3 Sekunden Zeit zu blinzeln'
    'und die Augen zu entspannen.'
    ''
};
textControl3 = { ...
    ''
    'Nicht vergessen:'
    ''
    'Z�hlen Sie die Durchg�nge und schauen Sie immer direkt auf'
    'den Punkt auf der kleinen Karte, sobald dieser erscheint.'
    ''
    'Haben Sie noch Fragen zum Ablauf?'
    ''
};

textLearningIntro = {
    { ...
    ''
    'Willkommen!'
    ''
    'Im Folgenden sehen Sie eine gro�e graue Karte, darunter ein'
    'Feld voller kleiner hellgrauer Karten. Im unteren'
    'Feld befindet sich hinter jeder Karte ein Bild.'
    ''
    'In jedem Durchlauf wird zun�chst oben ein Bild angezeigt, dann'
    'wird darunter die dazu passende Karte aufgedeckt.'
    ''
    'Bitte merken Sie sich hinter welcher der kleinen Karten sich'
    'welches Bild befindet. Sie werden anschlie�end dazu abgefragt.'
    ''
    'Die Aufgabe wird schwer. Sie m�ssen sich also konzentrieren.'
    }
    {
    ''
    ''
    'Wird oben das Bild gezeigt, k�nnen Sie es sich genau anschauen'
    'und einpr�gen. Wird anschlie�end darunter die passende kleine'
    'Karte angezeigt, sehen Sie auf dieser einen kleinen Punkt.'
    'Bitte schauen Sie ab dann nur noch direkt auf diesen Punkt.'
    ''
    'Bewegen Sie dann die Augen nicht mehr und blinzeln Sie wenn '
    'm�glich nicht. Sie k�nnen Ihre Augen in den Pausen zwischen'
    'den Durchl�ufen entspannen (etwa 3 Sekunden).'
    ''
    'Legen Sie bitte w�hrend der Aufgabe die H�nde locker in den Scho�.'
    }
};
textPracticeLearn = { ...
    ''
    ''
    'Zun�chst ein �bungsdurchgang.'
    ''
    ''
    'Merken Sie sich die Position der Karte im unteren Feld..' 
};
textPracticeRecall = { ...
    ''
    ''
    'Nun kommt die Abfrage unseres �bungsdurchgangs.'
    ''
    'Oben erscheint nun erneut jeweils eines der Bilder..'
    ''
    'Klicken Sie bitte auf die kleine Karte, hinter der sich'
    'das jeweilige Bild befindet.'
};
textLearning2 = { ...
    ''
    ''
    'Jetzt geht es wirklich los!'
    ''
    'Wir haben insgesamt 30 Bilder f�r Sie. Diese werden Ihnen alle'
    'insgesamt 3 Mal gezeigt. Die Reihenfolge wird jedes mal anders sein.'
    ''
    'Nach dem Lernen werden alle Karten ein Mal abgefragt. Sie sollten'
    'dabei mindestens 40% richtig haben.'
    ''
    'Am Ende wird angezeigt, wie viel Prozent Sie richtig hatten.'
    ''
    };
textLearning2Next = { ...
    ''
    ''
    'Jetzt k�nnen Sie sich kurz entspannen.'
    ''
    'Es folgt der XXX. Lerndurchgang'
    ''
    'Denken Sie bitte weiterhin daran, immer direkt auf kleinen '
    'Punkt zu schauen und Ihre Augen ab dann nicht mehr zu bewegen.'
    ''
    'Legen Sie Ihre H�nde bitte locker in den Scho�.'
    };

textLearningInterference = { ...
    ''
    ''
    'Nun lernen wir eine neue Version des Memorys.'
    ''
    'Die Karten haben die gleichen Motive wie vor dem Schlafengehen.'
    'Allerdings befinden Sie sich nun an anderen Positionen.'
    ''
    'Am Ende wird es wieder eine Abfrage geben. Sie bekommen'
    'wieder keine R�ckmeldung (blauer Punkt). Sie erfahren jedoch am'
    'Ende, wie gut Sie waren.'
    ''
};
textOutro = { ...
    ''
    ''
    ''
    'Ende'
    ''
    'Vielen Dank!'
    ''
};
textQuestion = { ...
    ''
    ''
    'Merken Sie sich die Positionen der Karten im unteren Feld.'
    'Vergessen Sie nicht, immer direkt auf den Punkt zu schauen'
    'und blinzeln Sie bitte nur in den Pausen.'
    ''
    'Bitte legen Sie ihre H�nde locker in den Scho� und bewegen'
    'Sie sie dann m�glichst nicht mehr.'
    ''
    'Haben Sie noch Fragen zum Ablauf?'

};
textRecall = { ...
    ''
    ''
    'Nun m�chten wir von Ihnen wissen, wo die Bilder waren,'
    'die Sie VOR dem Schlafengehen gelernt haben.'
    ''
    'Oben erscheint nun erneut jeweils eines der Bilder.'
    'Klicken Sie bitte auf die kleine Karte, unter der sich'
    'das jeweilige Bild befindet.'
    ''
    'Sie k�nnen sich bei der Abfrage ganz normal bewegen und'
    'hinschauen, wo Sie m�chten.'
    ''
};
textRecall2 = { ...
    ''
    ''
    'Sie werden nun abgefragt.'
    ''
    'Sie erfahren ganz am Ende, wie gut Sie waren.'
    ''
    'Haben Sie noch Fragen zum Ablauf?'
    ''
};
textRecallAgain = { ...
    ''
    ''
    'Sie hatten XXX Prozent richtig.'
    ''
    'Die Abfrage wird wiederholt.'
    ''
};
textRecallDone = { ...
    ''
    ''
    'Gl�ckwunsch!'
    ''
    'Sie hatten XXX Prozent richtig.'
    'Jetzt nur noch ein Durchlauf!'
    ''
};
textRecallImmediate = { ...
    ''
    ''
    'Nun werden die Karten abgefragt. Sie k�nnen sich jetzt wieder'
    'ganz normal bewegen und hinschauen, wo Sie m�chten.'
    ''
    'Oben erscheint erneut jeweils eines der Bilder.'
    'Klicken Sie bitte auf die kleine Karte, unter der sich das'
    'jeweilige Bild befindet.'
    ''
    'Sie werden nur ein mal abefragt und sollten dabei mindestens.'
    '40% richtig haben.'
    ''
    'Sie erfahren ganz am Ende, wie gut Sie waren.'
};
textRecallInterference = { ...
    ''
    ''
    'Nun werden die Karten abgefragt. Sie k�nnen sich jetzt wieder'
    'ganz normal bewegen und hinschauen, wo Sie m�chten.'
    ''
    'Oben erscheint nun erneut jeweils eines der Bilder.'
    'Klicken Sie bitte auf die kleine Karte, unter der sich das'
    'jeweilige Bild befindet.'
    ''
    'Sie erfahren am Ende, wie gut Sie waren.'
};
textRecallNoFeedback = { ...
    ''
    'Die Abfrage wird noch einmal wiederholt. Diesmal wird'
    'nicht mehr angezeigt, ob Sie richtig gelegen haben.'
    ''
    'Es erscheint lediglich ein blauer Punkt auf der'
    'geklickten Karte.'
};
textRecallPerformance = { ...
    ''
    ''
    ''
    'Sie hatten XXX Prozent richtig.'
    ''
};
textSession = {
    'Konzentration'    % Control Task  
    'Lernen'           % Main Learning
    'Lernen'           % Interference Learning
    'Abfrage'          % Interference Recall
    'Abfrage'          % Immediate Recall & Main Recall 
    'Konzentration'    % Gray Mode
};

% Text Properties
textDefSize     = 25;           % default Text Size
textDefFont     = 'Arial';      % default Text Font
textDefColor    = [0 0 0];      % default Text Color
textSx          = 'center';     % default Text x-position
textSy          = 10;           % default Text y-position
textVSpacing    = 2;            % default Text vertical line spacing


%% =========================== IMAGE FOLDERS ============================ %
% Card images
stimulusFolder  = 'stimuli';
imageFolder     = {'imagesA', 'imagesB', 'imagesPractice'};
controlFolder   = {'controlImagesA', 'controlImagesB'};    
imageFileExt    = '.png';		% image file types

% Feedback images
feedbackFolder  = 'imagesFeedback';
imagesFeedback  = {'correct.png', 'incorrect.png', 'nofeedback.png'};
feedbackMargin  = 10;       	% #pixels the images are smaller than the cards

imagesFixation  = {'dot.png', 'dot.png'};

%% ========================== CARD PROPERTIES =========================== %
% Number of cards
ncards_x            = 6;
ncards_y            = 5;

% Top Card Properties
topCardHeigth       = 200;          % Size of the top Card
topCardColor        = [.7; .7; .7]; % Color of the top Card

% Memory Cards
cardColors          = [.7; .7; .7]; % Color of cards
cardMargin          = 5;            % Margin between cards
frameWidth          = 2;            % Frame/border around cards
frameColor          = cardColors;   % Frame color

% Control Task Card Properties
cardColorControl        = 0.5;          % color of highlighted card
textColorCorrect        = [0.2 1 0.2];  % text color for correct response
textColorIncorrect      = [1 0.2 0.2];  % text color for incorrect response
controlTextMargin       = 200;          % distance in x from text to card
controlFeedbackDisplay  = 2;            % feedback display duration

%% ============================== OPTIONAL ============================== %
% Change Cursor Type
CursorType          = 'Arrow';

% Set Display properties
% Define which window size is used as reference to display the cards
windowSize          = get(0, 'MonitorPositions'); % [1024 768];
windowSize          = [(4/3 * windowSize(end)) windowSize(end)];
screenBgColor       = [1 1 1]*0.9; % greyish background
textBgColor         = [1 1 1]*0.9; % greyish background

% Define which display window is used (put a number)
% Note: by default external screens are automatically used if connected 
% window              = ;

% Set Timing (seconds) FIXME: DELETE ALL DOTS AND /2 !!!
topCardDisplay      = 3;       % Duration image is shown on top Card
topCardGreyDisplay  = 1;       % Duration top Card is shown in grey
cardDisplay         = 4;       % Duration memory cards are shown
cardRecallDisplay   = 1;       % Duration memory cards are shown
feedbackDisplay     = 1;       % Duration feedback is shown
whiteScreenDisplay  = 1;       % Delay after text screen
responseTime        = 15;      % Duration allowed to respond (click)
interTrialInterval  = 2;

% Fixation Task (mt_fixationTask)
fixationDisplay     = (6 * 60);     % Duration of fixation task


%% ======================= DO NOT CHANGE FROM HERE ====================== %
% Unless you know what you are doing...
% !!!!! Changes need further adjustments in other files and scripts !!!!! %

% Folder for configurations
setupdir            = fullfile(dirRoot, 'setup');
if ~exist(setupdir, 'dir')
    mkdir(setupdir) % create folder in first run
end

dirData = dirRoot;
dirSplit = strsplit(dirRoot,'\');
if strcmp(dirSplit(end), '')
    dirData = dirRoot(1:end-1);
    dirData = strrep(dirData, dirSplit(end-1), '');
else
    dirData = strrep(dirData, dirSplit(end), '');
end
dirData = dirData{:};
% Folder for data
if ~exist(fullfile(dirData, 'DATA'), 'dir')
    mkdir(fullfile(dirData, 'DATA')) % create folder in first run
    mkdir(fullfile(dirData, 'BACKUP'))
end

odorTable = load(fullfile(setupdir, 'mt_odor_rand'));
odorTable = odorTable.odor_rand;
maxSubjectNr = size(odorTable, 1);

% Changing the accepted cases also requires to change mt_dialogues.m
cfg_cases.subjects  = 0:maxSubjectNr;                   % 0 is debug
cfg_cases.nights    = {'1', '2'};                       % Night 1 or 2
cfg_cases.memvers   = {'A', 'B'};                       % Memory version
cfg_cases.sesstype  = {'C', 'L', 'I', 'R', 'F'};        % Session Type
cfg_cases.lab       = {'MEG', 'SL3', 'SL4', 'local'};   % Lab/Location
cfg_cases.odor      = {'0', '1'}; 
cfg_cases.sessNames = {'Control', 'Learning', 'Interference', ...
    'Recall', 'Recall', 'Fixation'};

% image folder
imgfolderA        	= fullfile(dirRoot, stimulusFolder, imageFolder{1});
imgfolderB      	= fullfile(dirRoot, stimulusFolder, imageFolder{2});

% control image folder
controlFolderA      = fullfile(dirRoot, stimulusFolder, controlFolder{1});
controlFolderB      = fullfile(dirRoot, stimulusFolder, controlFolder{2});

% Read in feedback images
imgfolderFeedback           = fullfile(dirRoot, stimulusFolder, feedbackFolder);
[imgCorrect, ~, alpha]      = imread(fullfile(imgfolderFeedback, imagesFeedback{1}));
imgCorrect(:,:,4)           = alpha;
[imgIncorrect, ~, alpha]    = imread(fullfile(imgfolderFeedback, imagesFeedback{2}));
imgIncorrect(:,:,4)         = alpha;
[imgNoFeedback, ~, alpha]   = imread(fullfile(imgfolderFeedback, imagesFeedback{3}));
imgNoFeedback(:,:,4)        = alpha;

% Read in fixation images
[imgDot, ~, alpha]          = imread(fullfile(imgfolderFeedback, imagesFixation{1}));
imgDot(:,:,4)               = alpha;
[imgDotSmall, ~, alpha]     = imread(fullfile(imgfolderFeedback, imagesFixation{2}));
imgDotSmall(:,:,4)          = alpha;

% Size of Memory Cards
topCardWidth        = topCardHeigth * (4/3);
cardHeigth          = round((windowSize(2)-topCardHeigth)/ncards_y);
cardWidth           = round(windowSize(1)/ncards_x);
cardSize            = [0 0 cardWidth cardHeigth]; % size to fill screen
cardSize(3:4)       = cardSize(end-1:end)-cardMargin;
ncards              = ncards_x * ncards_y;

% Size of elements shown on the card
crossSize               = [0 0 30 30];
circleSize              = [0 0 50 50];
dotFactor               = 0.08; % percent of card height
topCardDotSize          = [0 0 dotFactor*topCardHeigth dotFactor*topCardHeigth];
dotSize                 = [0 0 dotFactor*cardHeigth dotFactor*cardHeigth];
fixDotSize              = topCardDotSize;


% Size of images hidden under the cards
imagesSize          = [0 0 cardHeigth*(4/3) cardHeigth]; % assure 4:3
imagesSize(3:4)     = imagesSize(3:4)-cardMargin;

% Generate file names of images
imageFilesA         = {
    cellfun(@(x) strcat(x, imageFileExt), imageConfiguration{1}{1}', 'UniformOutput', false)
    cellfun(@(x) strcat(x, imageFileExt), imageConfiguration{1}{2}', 'UniformOutput', false)
    };
imageFilesB         = {
    cellfun(@(x) strcat(x, imageFileExt), imageConfiguration{2}{1}', 'UniformOutput', false)
    cellfun(@(x) strcat(x, imageFileExt), imageConfiguration{2}{2}', 'UniformOutput', false)
    };

% Practice set settings
imageFilesP             = {'teapot.png', 'guitar.png', 'jacket.png'};
imageSequencePractice   = [4, 9, 2];
imgfolderP              = fullfile(dirRoot, stimulusFolder, imageFolder{3});


% Convert image sequences for further processing
imageSequenceMainLearningCoordsA            = zeros(size(imageSequenceMainLearningA));
imageSequenceInterferenceLearningCoordsA    = zeros(size(imageSequenceInterferenceLearningA));
imageSequenceInterferenceRecallCoordsA      = zeros(size(imageSequenceInterferenceRecallA));
imageSequenceMainRecallCoordsA              = zeros(size(imageSequenceMainRecallA));

imageSequenceMainLearningCoordsB            = zeros(size(imageSequenceMainLearningB));
imageSequenceInterferenceLearningCoordsB    = zeros(size(imageSequenceInterferenceLearningB));
imageSequenceInterferenceRecallCoordsB      = zeros(size(imageSequenceInterferenceRecallB));
imageSequenceMainRecallCoordsB              = zeros(size(imageSequenceMainRecallB));

for i = 1:size(imageSequenceMainLearningA, 2)
    % for each learning sequence (might be let's say 3)
    for j = 1:size(imageSequenceMainLearningA, 1)
        imageSequenceMainLearningCoordsA(j,i)         = find(cellfun(@(x) strcmp(x, imageSequenceMainLearningA{j,i}), imageConfiguration{1}{1}'));
    end
    for j = 1:size(imageSequenceInterferenceLearningA, 1)
        imageSequenceInterferenceLearningCoordsA(j,i) = find(cellfun(@(x) strcmp(x, imageSequenceInterferenceLearningA{j,i}), imageConfiguration{1}{2}'));
    end
    for j = 1:size(imageSequenceMainLearningB, 1)
        imageSequenceMainLearningCoordsB(j,i)         = find(cellfun(@(x) strcmp(x, imageSequenceMainLearningB{j,i}), imageConfiguration{2}{1}'));
    end
    for j = 1:size(imageSequenceInterferenceLearningB, 1)
        imageSequenceInterferenceLearningCoordsB(j,i) = find(cellfun(@(x) strcmp(x, imageSequenceInterferenceLearningB{j,i}), imageConfiguration{2}{2}'));
    end
    
    % for each recall sequence (might be let's say 1) - this code expects
    % the number of recall sessions for interference and main memory to be
    % the same. This can be changed by also having 4 for-loops as above
    for j = 1:size(imageSequenceMainRecallA, 1)
        imageSequenceInterferenceRecallCoordsA(j,i)   = find(cellfun(@(x) strcmp(x, imageSequenceInterferenceRecallA{j,i}), imageConfiguration{1}{2}'));
        imageSequenceMainRecallCoordsA(j,i)           = find(cellfun(@(x) strcmp(x, imageSequenceMainRecallA{j,i}), imageConfiguration{1}{1}'));
        
        imageSequenceInterferenceRecallCoordsB(j,i)   = find(cellfun(@(x) strcmp(x, imageSequenceInterferenceRecallB{j,i}), imageConfiguration{2}{2}'));
        imageSequenceMainRecallCoordsB(j,i)           = find(cellfun(@(x) strcmp(x, imageSequenceMainRecallB{j,i}), imageConfiguration{2}{1}'));
    end
end

% Check if every image were used exactly once -- I think this tests whether
% every photo was used, but not if exactly once
if  ~isempty(setdiff(imageConfiguration{1}{1}', imageSequenceMainLearningA)) ...
        || ~isempty(setdiff(imageConfiguration{1}{2}', imageSequenceInterferenceLearningA)) ...
        || ~isempty(setdiff(imageConfiguration{1}{2}', imageSequenceInterferenceRecallA)) ...
        || ~isempty(setdiff(imageConfiguration{1}{1}', imageSequenceMainRecallA)) ... 
        || ~isempty(setdiff(imageConfiguration{2}{1}', imageSequenceMainLearningB)) ...
        || ~isempty(setdiff(imageConfiguration{2}{2}', imageSequenceInterferenceLearningB)) ...
        || ~isempty(setdiff(imageConfiguration{2}{2}', imageSequenceInterferenceRecallB)) ...
        || ~isempty(setdiff(imageConfiguration{2}{1}', imageSequenceMainRecallB)) 
    error('Every image has to be used exactly once')
end

% Load sequence for controlList
try
    controlSequence = load(fullfile(dirRoot, 'code/help_functions/controlSequence.mat'));
    controlList     = controlSequence.controlList;
    controlSequence = controlSequence.controlSequence;
catch
    fprintf('Control Lists missing: run mt_controlList.m\n')
    error(ME.message)
end

% Store 2D coordinates for cards to be flipped
cardSequence 	= {...
    { % Memory version A
    % Sequence for Control
    controlSequence; % identical across subjects
    % Sequence for Learning
    imageSequenceMainLearningCoordsA; ...
    % Sequence for Interference Learning
    imageSequenceInterferenceLearningCoordsA; ...
    % Sequence for Interference Recall
    imageSequenceInterferenceRecallCoordsA; ...
    % Sequence for Immediate Recall & Retrieval
    imageSequenceMainRecallCoordsA; ...
    % Sequence for Gray Mode
    controlSequence ...
    }
    { % Memory version B
    % Sequence for Control
    controlSequence; % identical across subjects
    % Sequence for Learning
    imageSequenceMainLearningCoordsB; ...
    % Sequence for Interference Learning
    imageSequenceInterferenceLearningCoordsB; ...
    % Sequence for Interference Recall
    imageSequenceInterferenceRecallCoordsB; ...
    % Sequence for Immediate Recall & Retrieval
    imageSequenceMainRecallCoordsB; ...
    % Sequence for Gray Mode
    controlSequence ...
    }
}; 

% % Transform intuitive 2D coordinates into 1D coordinates used for iteration
% cardSequence        = cell(size(imageSequence2D));
% for r = 1: size(cardSequence, 2)
%     cardSequence{r} = cellfun(@(x) mt_cards2Dto1D(x, ncards_x, ncards_y), imageSequence2D{r});
% end


% Save configuration in workdir
cd(dirRoot)
save(fullfile(setupdir, 'mt_params.mat'))
end