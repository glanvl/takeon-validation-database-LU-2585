\c validationdb;
SET search_path TO dev01,public;

Drop table dev01.ValidationRule CASCADE;
Drop table dev01.ValidationPeriod CASCADE;
Drop table dev01.ValidationParameter CASCADE;
Drop table dev01.ValidationOutput CASCADE;
Drop table dev01.ValidationForm CASCADE;
Drop table dev01.ValidationAttribute CASCADE;
Drop table dev01.Survey CASCADE;
Drop table dev01.Response CASCADE;
Drop table dev01.Question CASCADE;
Drop table dev01.FormDefinition CASCADE;
Drop table dev01.Form CASCADE;
Drop table dev01.Contributor CASCADE;