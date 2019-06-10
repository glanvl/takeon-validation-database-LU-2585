\c es_results_db;

SET search_path TO es_db_test,public;

Create table es_db_test.Contributor
(
    ParentRUReference            varchar (11) not null,   /* Enterprise reference? */
    RUReference                  varchar(11) not null,
    Address                      varchar(255) Not Null,
    BirthDate                    date Not Null,
    BusinessProfilingTeamCase    boolean Not Null,
    Contact                      varchar(255) Not Null,
    DeathDate                    date,
    EnforcementFlag              boolean,
    EnforcementStatus            varchar(255),
    Fax                          varchar(25),
    ContributorName              varchar (255),
    ProfileInformation           text,
    SIC2003                      int,
    SIC2007                      int,
    Telephone                    varchar(25),

    primary key (RUReference)
);

create table es_db_test.Survey
(
    SurveyOutputCode                                 varchar(25) not null unique,
    SurveyName                                       varchar(30) not null,

    primary key (SurveyOutputCode)
);

Create table es_db_test.Survey_Period
(
    SurveyPeriod                                      varchar(6) not null,
    SurveyOutputCode                                  varchar(25) not null,
    ActivePeriod                                      boolean not null,
    NoOfResponses                                     smallint,
    NumberCleared                                     smallint,
    SampleSize                                        smallint,

    primary key(SurveyPeriod, SurveyOutputCode),
    foreign key (SurveyOutputCode) references es_db_test.Survey(SurveyOutputCode)
);


Create table es_db_test.Survey_Enrolment
(
    RUReference                                       varchar(11) not null,
    SurveyOutputCode                                  varchar(25) not null,
    NoOfCurrentConsecutivePeriodsOfNonResponse        smallint,
    NoOfPeriodsWithOutstandingQueries                 smallint,
    PeriodOfEnrolment                                 varchar(10) Not Null,

    primary key (RUReference, SurveyOutputCode),
    foreign key (RUReference) references es_db_test.Contributor(RUReference),
    foreign key (SurveyOutputCode) references es_db_test.Survey(SurveyOutputCode)

);


Create table es_db_test.Contributor_Survey_Period
(
    RUReference                                       varchar(8) Not Null,
    SurveyOutputCode                                  varchar(25) Not Null,
    SurveyPeriod                                      varchar(6) Not Null,
    RunReference                                      int not null,
    AdditionalComments                                text,
    ContributorComments                               text,
    LastUpdated                                       date,
    NoOfActiveQueriesInPeriod                         smallint,
    NoOfContributorInteractionsInPeriod               smallint,
    PeriodActive                                      boolean,
    PriorityResponseList                              varchar(255),
    ResponseStatus                                    varchar(255),
    ShortDescription                                  varchar(255),
    WhenStatusLastChanged                             date,


    primary key (RUReference,SurveyOutputCode,SurveyPeriod,RunReference),
    foreign key(RUReference,SurveyOutputCode) references es_db_test.Survey_Enrolment(RUReference, SurveyOutputCode),
    foreign key (SurveyOutputCode, SurveyPeriod) references es_db_test.Survey_Period(SurveyOutputCode, SurveyPeriod)
);

Create table es_db_test.Contact
(
    ContactReference              Varchar(25) primary key,
    ContactAddress                text,
    ContactConstraints            text,
    ContactEmail                  varchar(255),
    ContactFax                    varchar(25),
    ContactName                   varchar(255),
    ContactOrganisation           varchar(255),
    ContactPreferences            text,
    ContactTelephone              varchar(25)

);

Create table es_db_test.Survey_Contact
(
    ContactReference               varchar(25) not null,
    RUReference                    varchar(8)not null,
    SurveyOutputCode               varchar(25)not null,
    EffectiveEndDate               date,
    EffectiveStartDate             date,

    primary key (ContactReference, RUReference, SurveyOutputCode),
    foreign key (ContactReference) references es_db_test.Contact(ContactReference),
    foreign key (RUReference, SurveyOutputCode) references es_db_test.Survey_Enrolment(RUReference, SurveyOutputCode)

);

Create table es_db_test.Query_Type
(
    QueryType           varchar(11) primary key,
    Description         varchar(255)
);

Create table es_db_test.Query
(
    QueryReference         varchar(25)not null,
    QueryType              varchar (11)not null,
    RUReference            varchar(11)not null,
    SurveyOutputCode       varchar(25)not null,
    PeriodQueryRelates     varchar(25) not null,
    CurrentPeriod          varchar(6) Not Null,
    RunReference           int,
    DateTimeRaised         date,
    GeneralSpecificFlag    boolean,
    IndustryGroup          varchar(255),
    LastQueryUpdate        date,
    QueryActive            boolean,
    QueryDescription       text,
    QueryStatus            varchar(255),
    RaisedBy               varchar(255),
    ResultsState           varchar(255),
    TargetResolutionDate   date,

    primary key (QueryReference),
    foreign key (QueryType) references es_db_test.Query_Type(QueryType),
    foreign key(PeriodQueryRelates, RUReference, SurveyOutputCode, RunReference) references es_db_test.Contributor_Survey_Period(SurveyPeriod,RUReference,SurveyOutputCode, RunReference)

);

Create Table Link_Query
(
    LinkQueryReference      varchar (25) not null,
    QueryReference          varchar (25) not null,
    Association             varchar (25) not null,

    primary key (LinkQueryReference, QueryReference),
    foreign key (QueryReference) references es_db_test.Query(QueryReference),
    foreign key (LinkQueryReference) references es_db_test.Query(QueryReference)

);

Create table es_db_test.Query_Task
(
    TaskSeqNo             int not null,
    QueryReference        varchar(25),
    ResponseRequiredBy    date,
    TaskDescription       text,
    TaskResponsibility    varchar(255),
    TaskStatus            varchar(255),

    primary key(TaskSeqNo, QueryReference),
    foreign key (QueryReference) references es_db_test.Query(QueryReference)

);

Create table es_db_test.QueryTaskUpdate
(
    TaskSeqNo                  int,
    QueryReference             varchar(25),
    LastUpdated                date,
    TaskUpdateDescription      varchar(255),
    UpdatedBy                  int,

    primary key (TaskSeqNo,QueryReference,LastUpdated),
    foreign key (TaskSeqNo, QueryReference) references es_db_test.Query_Task(TaskSeqNo,QueryReference)

);

Create table es_db_test.Step_Exception
(
    QueryReference             varchar(25) not null,
    SurveyPeriod               varchar(6) not null,
    RunReference               int not null,
    RUReference                varchar(11)not null,
    Step                       varchar(11)not null,
    SurveyOutputCode           varchar(25)not null,
    ErrorCode                  varchar(25)not null,
    ErrorDescription           varchar (255)not null,

    primary key (SurveyPeriod, RunReference, RUReference,Step,SurveyOutputCode),
    foreign key (QueryReference) references es_db_test.Query(QueryReference),
    foreign key (SurveyPeriod, RunReference, RUReference,SurveyOutputCode) references es_db_test.Contributor_Survey_Period(SurveyPeriod, RunReference, RUReference,SurveyOutputCode)

);

create table es_db_test.VET
(
    VET                        int not null,
    Description                varchar(255) not null,
    primary key (VET)
);

create table es_db_test.Question_Anomaly
(
    SurveyPeriod               varchar(6) not null,
    QuestionNo                 int not null,
    RunReference               int not null,
    RUReference                varchar(11)not null,
    Step                       varchar(11)not null,
    SurveyOutputCode           varchar(25)not null,
    Description                varchar(255) not null,
    primary key (SurveyPeriod, QuestionNo, RunReference, RUReference, Step, SurveyOutputCode),
    foreign key (SurveyPeriod, RunReference, RUReference, Step, SurveyOutputCode) references es_db_test.Step_Exception(SurveyPeriod, RunReference, RUReference, Step, SurveyOutputCode)
);

create table es_db_test.Failed_VET
(
  FailedVET                    int not null,
  SurveyPeriod                 varchar(6) not null,
  QuestionNo                   int not null,
  RunReference                 int not null,
  RUReference                  varchar(11) not null,
  Step                         varchar(11) not null,
  SurveyOutputCode             varchar(25) not null,
  primary key (FailedVET,SurveyPeriod,QuestionNo,RunReference,RUReference,Step,SurveyOutputCode),
  foreign key (FailedVET) references es_db_test.VET(VET),
  foreign key (SurveyPeriod,QuestionNo,RunReference,RUReference,Step,SurveyOutputCode) references es_db_test.Question_Anomaly(SurveyPeriod,QuestionNo,RunReference,RUReference,Step,SurveyOutputCode)
);