
delete from es_db_test.QueryTaskUpdate;
delete from es_db_test.QueryTask;
delete from es_db_test.Query;
delete from es_db_test.Contact;
delete from es_db_test.Survey_Contact;
delete from es_db_test.Contributor_Survey_Period;
delete from es_db_test.Survey_Enrolment;
delete from es_db_test.Contributor;


Insert Into es_db_test.Contributor
(
    RURef,
    Address,
    BirthDate,
    BusinessProfilingTeamCase,
    Contact,
    DeathDate,
    EnforcementFlag,
    EnforcementStatus,
    Fax,
    ContributorName,
    ProfileInformation,
    SIC2003,
    SIC2007,
    Telephone
)
Values
    ('ABC00001','999 Letsby Avenue, Metropolis, MP01 11AB', '1982-09-17', true, 'Officer Dibble', null,false,'Active',
                '01336 216999', 'Police Academy', 'This is some comments about the business', 200301,200701, '01336 216999'),
    ('ABC00002','18 Slingsby Road, Pontypool, NP4 6AD', '1999-01-01', true, 'King Mike', '2019-03-20', true,'De-active',
                '01662 123989', 'Alice Cooper', 'This is me making some random comments', 200302,200702, '01662 123987'),
    ('ABC00003','22 Avenue Road, Trowbridge, BA22 1ST', '1997-02-24',false, 'Lord Luke', null, true,'Active',
                '07462 456239', 'Bon Scott', 'Im on a highway to hell', 200303,200703, '03647 345987'),
    ('ABC00004','88 Gurner Terrice, Melksham, SW4 6LP', '1994-08-21',false, 'Duke David', null, true,'Active',
                '01234 654321', 'Jimmi Page', 'Its been a long time since I Rock and Roll', 200304,200704, '01422 456757'),
    ('ABC00005','4 Pete Place, Petersfield, GU32 1RT', '2001-11-3', true, 'Baron Binay', null,false,'Active',
                '01999 987990', 'Paul Simon', 'You can call me Betty Betty when you call me Al', 200305,200705, '03665 083727');



Insert Into es_db_test.Survey_Enrolment
(
    RURef,
    SurveyOutputCode,
    NoOfCurrentConsecutivePeriodsOfNonResponse,
    NoOfPeriodsWithOutstandingQueries,
    PeriodOfEnrolment
)
Values
    ('ABC00001','ZYX0000000000000000012345',0,0,'1900-03-21'),
    ('ABC00002','ZYX0000000000000000023451',3,1,'1900-03-12'),
    ('ABC00003','ZYX0000000000000000034512',1,1,'1900-03-05'),
    ('ABC00004','ZYX0000000000000000045123',1,1,'1900-03-01'),
    ('ABC00005','ZYX0000000000000000051234',0,0,'1900-03-30');



Insert Into es_db_test.Contributor_Survey_Period
(
    SurveyPeriodId,
    RURef,
    SurveyOutputCode,
    SurveyPeriod,
    AdditionalComments,
    ContributorComments,
    LastUpdated,
    NoOfActiveQueriesInPeriod,
    NoOfContributorInteractionsInPeriod,
    PeriodActive,
    PriorityResponseList,
    ResponseStatus,
    ShortDescription,
    WhenStatusLastChanged
)
Values
    ('001','ABC00001','ZYX0000000000000000012345','201701','We like this guy','we are nice honest','2015-04-18',2,5,
                true,'this then this','Active','this is a description of us','2018-03-12' ),
    ('002','ABC00002','ZYX0000000000000000023451','201801','We dont like this guy','we are nice maybe','2017-03-15',1,2,
                true,'this then that','Sleeping','this is to explain what we are','2019-02-25' ),
    ('003','ABC00003','ZYX0000000000000000034512','201803','We think there maybe a problem','we have issues','2016-09-10',0,1,
                false,'that then this','Deactive','WHO are you','2019-01-03'),
    ('004','ABC00004','ZYX0000000000000000045123','201309','We think this could work','we are just a business','2019-05-02',0,0,
                true,'a then b then c','Active','we arent very good at explaining','2018-02-08'),
    ('005','ABC00005','ZYX0000000000000000051234','201701','This is my business now Dave','I do not think so','2015-04-18',2,5,
                true,'to take over you will first need to...','Active','We are evil','2018-06-11');


Insert Into es_db_test.Survey_Contact
(
    ContactReference,
    RURef,
    SurveyOutputCode,
    EffectiveEndDate,
    EffectiveStartDate

)
Values
    ('001','ABC00001','ZYX0000000000000000012345',null,'1999-03-09'),
    ('002','ABC00002','ZYX0000000000000000023451',null,'1999-03-09'),
    ('003','ABC00003','ZYX0000000000000000034512',null,'1999-03-09'),
    ('004','ABC00004','ZYX0000000000000000045123',null,'1999-03-09'),
    ('005','ABC00005','ZYX0000000000000000051234',null,'1999-03-09');


Insert Into es_db_test.Contact
(
    ContactId,
    ContactReference,
    ContactAddress,
    ContactConstraints,
    ContactEmail,
    ContactFax,
    ContactName,
    ContactOrganisation,
    ContactPreferences,
    ContactTelephone
)
Values
    ('001','001','999 Letsby Avenue, Metropolis, MP01 11AB','Tied up','dibble@topcat.com','01179 087654',
                'Officer Dibble', 'This one','doesnt like to be called between 1 and 12','01179 087655'),
    ('002','002','18 Slingsby Road, Pontypool, NP4 6AD','Locked up','king@mike.com','01234 045658',
                'King Mike', 'Many different secret ones','Should only be called King Mike','01234 045657'),
    ('003','003','22 Avenue Road, Trowbridge, BA22 1ST','Fed up','lord@luke.com','07462 456239',
                'Lord Luke', 'Lord of all','not telephone or fax or eamil or sms or post','07462 456238'),
    ('004','004','88 Gurner Terrice, Melksham, SW4 6LP','available','duke@david.com','07658 823671',
                'Duke David', 'MI5','Please call me any time and all the time','07658 823672'),
    ('005','005', '4 Pete Place, Petersfield, GU32 1RT','unavailable','baron@binay.com','01579 082664',
                'Baron Binay', 'All of them','Must be really polite or else','01579 082665');


Insert Into es_db_test.Query
(
    QueryReference,
    RuRef,
    SurveyOutputCode,
    PeriodQueryRelates,
    CurrentPeriod,
    DateTimeRaised,
    GeneralSpecificFlag,
    IndustryGroup,
    LastQueryUpdate,
    QueryActive,
    QueryDescription,
    QueryStatus,
    RaisedBy,
    ResultsState,
    TargetResolutionDate
)

Values
    ('12300000000000000617','ABC00001','ZYX0000000000000000012345','Relates To Period 198301','201906','2019-06-05',true,'Manual Labour.',
                '2019-02-19',false,'Bone.','Incomplete.','Hercules Morse','Constipated.','2019-06-12'),
    ('12300000000000000202','ABC00002','ZYX0000000000000000023451','Relates To Period 198305','201906','2019-06-05',true,'Dairy.',
                '2019-01-02',false,'Caterwaul Caper','Inelegant.','Hercules Morse','Contrived.','2019-07-09'),
    ('11200000000000000223','ABC00003','ZYX0000000000000000034512','Relates To Period 198304','201906','2019-06-05',false,'Dairy.',
                '2018-05-08',false,'Zachary Quack.','Intelligent.','Hercules Morse','Consulted.','2019-08-01'),
    ('11100000000000000262','ABC00004','ZYX0000000000000000045123','Relates To Period 198303','201906','2019-06-05',false,'Agriculture.',
                '2019-02-02',true,'Hat Tricks','Inediable.','Hercules Morse','Confused','2019-08-11'),
    ('17100000000000000282','ABC00005','ZYX0000000000000000051234','Relates To Period 198302','201906','2019-06-05',true,'Agriculture.',
                '2019-03-30',false,'Minimonster.','Inconceivable.','Hercules Morse','Complete.','2019-07-13');


Insert Into es_db_test.QueryTask
(
    TaskSeqNo,
    QueryReference,
    ResponseRequiredBy,
    TaskDescription,
    TaskResponsibility,
    TaskStatus

)
Values
    (1,'12300000000000000617','2019-07-09','With A Very Low Tum.','Schnitzel von Krumm.','Finished.'),
    (2,'12300000000000000202','2019-07-09','From Donaldsons Dairy.','Hairy Maclary.','Benched Beacuse Lacking Money.'),
    (3,'11200000000000000223','2019-07-09','Covered In Spots.','Bottemley Potts.','Shelved Due To Bordom.'),
    (4,'11100000000000000262','2019-07-09','Like A Bundle Of Hay.','Muffin McLay.','On Hold Due To Lack Of Planning.'),
    (5,'17100000000000000282','2019-07-09','All Skinny And Boney.','Bitzer Maloney.','Parked Because We Lack People.');


Insert Into es_db_test.QueryTaskUpdate
(
    TaskSeqNo,
    QueryReference,
    Updated,
    NextPlannedUpdate,
    TaskUpdateDescription,
    UpdatedBy
)
Values
    (1,'12300000000000000617','2019-09-08',null,'Nothing To See Here. Move Along.',123),
    (2,'12300000000000000202','2019-08-11',null,'Stop Right There. You Saw Too Much.',321),
    (3,'11200000000000000223','2019-07-22',null,'This Is Not The Update You Are Looking For.',132),
    (4,'11100000000000000262','2018-12-12',null,'Why Should I Tell You.',312),
    (5,'17100000000000000282','2019-08-13',null,'Pay Me And Then Ill Tell You.',213);

