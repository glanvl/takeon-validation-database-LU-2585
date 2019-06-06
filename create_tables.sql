\c es_results_db;

SET search_path TO es_db_test,public;

Create schema es_db_test;

Create table es_db_test.Contributor
(
    RURef                        varchar(11) Primary Key,
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
    Telephone                    varchar(25)
);


Create table es_db_test.Survey_Enrolment
(
    RURef                                             varchar(11) references es_db_test.Contributor(RURef),
    SurveyOutputCode                                  varchar(25) primary key,
    NoOfCurrentConsecutivePeriodsOfNonResponse        smallint,
    NoOfPeriodsWithOutstandingQueries                 smallint,
    PeriodOfEnrolment                                 varchar(10) Not Null

);


Create table es_db_test.Contributor_Survey_Period
(
    SurveyPeriodId                                    varchar(8) primary key,
    RURef                                             varchar(8) Not Null references es_db_test.Contributor(RURef),
    SurveyOutputCode                                  varchar(25) Not Null references es_db_test.Survey_Enrolment(SurveyOutputCode),
    SurveyPeriod                                      varchar(6) Not Null,
    AdditionalComments                                text,
    ContributorComments                               text,
    LastUpdated                                       date,
    NoOfActiveQueriesInPeriod                         smallint,
    NoOfContributorInteractionsInPeriod               smallint,
    PeriodActive                                      boolean,
    PriorityResponseList                              varchar(255),
    ResponseStatus                                    varchar(255),
    ShortDescription                                  varchar(255),
    WhenStatusLastChanged                             date

);


Create table es_db_test.Survey_Contact
(
    ContactReference               varchar(25) primary key,
    RURef                          varchar(8) references es_db_test.Contributor(RURef),
    SurveyOutputCode               varchar(25) references es_db_test.Survey_Enrolment(SurveyOutputCode),
    EffectiveEndDate               date,
    EffectiveStartDate             date

);

Create table es_db_test.Contact
(
    ContactId                     varchar(8) primary key,
    ContactReference              Varchar(25) references es_db_test.Survey_Contact(ContactReference),
    ContactAddress                text,
    ContactConstraints            text,
    ContactEmail                  varchar(255),
    ContactFax                    varchar(25),
    ContactName                   varchar(255),
    ContactOrganisation           varchar(255),
    ContactPreferences            text,
    ContactTelephone              varchar(25)

);


Create table es_db_test.Query
(
    QueryReference         varchar(25) primary key,
    RuRef                  varchar(11) references es_db_test.Contributor(RuRef),
    SurveyOutputCode       varchar(25) references es_db_test.Survey_Enrolment(SurveyOutputCode),
    PeriodQueryRelates     varchar(25) Not Null,
    CurrentPeriod          varchar(6) Not Null,
    DateTimeRaised         date,
    GeneralSpecificFlag    boolean,
    IndustryGroup          varchar(255),
    LastQueryUpdate        date,
    QueryActive            boolean,
    QueryDescription       text,
    QueryStatus            varchar(255),
    RaisedBy               varchar(255),
    ResultsState           varchar(255),
    TargetResolutionDate   date

);

Create table es_db_test.QueryTask
(
    TaskSeqNo             int Primary Key,
    QueryReference        varchar(25) references es_db_test.Query(QueryReference),
    ResponseRequiredBy    date,
    TaskDescription       text,
    TaskResponsibility    varchar(255),
    TaskStatus            varchar(255)

);

Create table es_db_test.QueryTaskUpdate
(
    TaskSeqNo                  int Primary Key,
    QueryReference             varchar(25) references es_db_test.Query(QueryReference),
    Updated                    date,
    NextPlannedUpdate          date,
    TaskUpdateDescription      varchar(255),
    UpdatedBy                  int

);














