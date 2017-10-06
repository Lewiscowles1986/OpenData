
/*
 * Names
 */
CREATE TABLE IF NOT EXISTS company_names (Number VARCHAR(40), Name VARCHAR(200), Retired DATE);
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_1.CompanyName`, 
    SUBSTR(`PreviousName_1.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_1.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_1.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_1.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_2.CompanyName`, 
    SUBSTR(` PreviousName_2.CONDATE`, 7) || "-" || SUBSTR(` PreviousName_2.CONDATE`, 4, 2) || "-" || SUBSTR(` PreviousName_2.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(` PreviousName_2.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`,
    ` PreviousName_3.CompanyName`,
    SUBSTR(`PreviousName_3.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_3.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_3.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_3.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_4.CompanyName`, 
    SUBSTR(`PreviousName_4.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_4.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_4.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_4.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_5.CompanyName`, 
    SUBSTR(`PreviousName_5.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_5.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_5.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_5.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_6.CompanyName`, 
    SUBSTR(`PreviousName_6.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_6.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_6.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_6.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_7.CompanyName`, 
    SUBSTR(`PreviousName_7.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_7.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_7.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_7.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_8.CompanyName`, 
    SUBSTR(`PreviousName_8.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_8.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_8.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_8.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_9.CompanyName`, 
    SUBSTR(`PreviousName_9.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_9.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_9.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_9.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    ` PreviousName_10.CompanyName`, 
    SUBSTR(`PreviousName_10.CONDATE`, 7) || "-" || SUBSTR(`PreviousName_10.CONDATE`, 4, 2) || "-" || SUBSTR(`PreviousName_10.CONDATE`, 1, 2) 
FROM companies_raw 
    WHERE LENGTH(`PreviousName_10.CONDATE`) == 10;
INSERT INTO company_names 
SELECT 
    ` CompanyNumber`, 
    `CompanyName`, 
    NULL 
FROM companies_raw;

/*
 * SicText
 */
CREATE TABLE IF NOT EXISTS siccodes (Number VARCHAR(10), Name TEXT);
INSERT INTO siccodes 
SELECT DISTINCT 
    substr(`SICCode.SicText_1`, 1, instr(`SICCode.SicText_1`, ' - ')-1), substr(`SICCode.SicText_1`, instr(`SICCode.SicText_1`, ' - ')+3) 
FROM companies_raw 
    WHERE instr(`SICCode.SicText_1`,' - ')-1 > 0
UNION
SELECT DISTINCT 
    substr(`SICCode.SicText_2`, 1, instr(`SICCode.SicText_2`, ' - ')-1), substr(`SICCode.SicText_2`, instr(`SICCode.SicText_2`, ' - ')+3) 
FROM companies_raw 
    WHERE instr(`SICCode.SicText_2`,' - ')-1 > 0
UNION
SELECT DISTINCT 
    substr(`SICCode.SicText_3`, 1, instr(`SICCode.SicText_3`, ' - ')-1), substr(`SICCode.SicText_3`, instr(`SICCode.SicText_3`, ' - ')+3) 
FROM companies_raw 
    WHERE instr(`SICCode.SicText_3`,' - ')-1 > 0
UNION
SELECT DISTINCT 
    substr(`SICCode.SicText_4`, 1, instr(`SICCode.SicText_4`, ' - ')-1), substr(`SICCode.SicText_4`, instr(`SICCode.SicText_4`, ' - ')+3) 
FROM companies_raw 
    WHERE instr(`SICCode.SicText_4`,' - ')-1 > 0;

/*
 * Categories
 */
CREATE TABLE IF NOT EXISTS categories (ID INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT);
INSERT INTO categories (Name) 
SELECT DISTINCT `CompanyCategory` 
FROM companies_raw;

/*
 * Statuses
 */
CREATE TABLE IF NOT EXISTS statuses (ID INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT);
INSERT INTO statuses (Name) 
SELECT DISTINCT `CompanyStatus` 
FROM companies_raw;

/*
 * Addresses
 */
CREATE TABLE IF NOT EXISTS addresses (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Address TEXT,
    County VARCHAR(100),
    Postcode VARCHAR(10),
    Country VARCHAR(100)
);

/* C/O with POBox Separate fields */
INSERT INTO addresses (Address, County, Postcode, Country)
SELECT DISTINCT 
    `RegAddress.AddressLine1` || x'0a' || ` RegAddress.AddressLine2` || x'0a' || `RegAddress.PostTown`, 
    `RegAddress.County`, 
    `RegAddress.PostCode`, 
    `RegAddress.Country`
FROM companies_raw;

/*
 * Accounts Data
 */
CREATE TABLE IF NOT EXISTS account_categories (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(40)
);
INSERT INTO account_categories (Name) 
SELECT DISTINCT `Accounts.AccountCategory` FROM companies_raw;

CREATE TABLE IF NOT EXISTS accounts (
    Number VARCHAR(40),
    Category INTEGER,
    AccountsNextDue DATE,
    AccountsLastMadeUp DATE,
    ReturnsNextDue DATE,
    ReturnsLastMadeUp DATE,
    NumberOfMortgageCharges INTEGER,
    NumberOfMortgageOutstanding INTEGER,
    NumberOfMortgagePartSatisfied INTEGER,
    NumberOfMortgageSatisfied INTEGER,
    StmtNextDue DATE,
    StmtLastMadeUp DATE,
    FOREIGN KEY (Category) REFERENCES account_categories (ID)
);
INSERT INTO accounts (`Number`, Category, AccountsNextDue, AccountsLastMadeUp, ReturnsNextDue, ReturnsLastMadeUp, NumberOfMortgageCharges, NumberOfMortgageOutstanding, NumberOfMortgagePartSatisfied, NumberOfMortgageSatisfied, StmtNextDue, StmtLastMadeUp)
SELECT 
    CR.` CompanyNumber`,
    ACAT.ID,
    SUBSTR(CR.`Accounts.NextDueDate`, 7) || "-" || SUBSTR(CR.`Accounts.NextDueDate`, 4, 2) || "-" || SUBSTR(CR.`Accounts.NextDueDate`, 1, 2),
    SUBSTR(CR.`Accounts.LastMadeUpDate`, 7) || "-" || SUBSTR(CR.`Accounts.LastMadeUpDate`, 4, 2) || "-" || SUBSTR(CR.`Accounts.LastMadeUpDate`, 1, 2),
    SUBSTR(CR.`Returns.NextDueDate`, 7) || "-" || SUBSTR(CR.`Returns.NextDueDate`, 4, 2) || "-" || SUBSTR(CR.`Returns.NextDueDate`, 1, 2),
    SUBSTR(CR.`Returns.LastMadeUpDate`, 7) || "-" || SUBSTR(CR.`Returns.LastMadeUpDate`, 4, 2) || "-" || SUBSTR(CR.`Returns.LastMadeUpDate`, 1, 2),
    CR.`Mortgages.NumMortCharges`,
    CR.`Mortgages.NumMortOutstanding`,
    CR.`Mortgages.NumMortPartSatisfied`,
    CR.`Mortgages.NumMortSatisfied`,
    SUBSTR(CR.`ConfStmtNextDueDate`, 7) || "-" || SUBSTR(CR.`ConfStmtNextDueDate`, 4, 2) || "-" || SUBSTR(CR.`ConfStmtNextDueDate`, 1, 2),
    SUBSTR(CR.` ConfStmtLastMadeUpDate`, 7) || "-" || SUBSTR(CR.` ConfStmtLastMadeUpDate`, 4, 2) || "-" || SUBSTR(CR.` ConfStmtLastMadeUpDate`, 1, 2)
FROM companies_raw CR
    INNER JOIN account_categories ACAT ON CR.`Accounts.AccountCategory` = ACAT.Name
;

/*
 * Main Company Data
 */
CREATE TABLE IF NOT EXISTS companies (
    Number VARCHAR(40),
    URL TEXT,
    category INTEGER,
    Incorporation DATE,
    Dissolution DATE,
    status INTEGER,
    FOREIGN KEY (category) REFERENCES categories (ID),
    FOREIGN KEY (status) REFERENCES statuses (ID)
);
INSERT INTO companies 
SELECT 
    CR.` CompanyNumber`, 
    CR.`URI`, 
    C.ID,
    SUBSTR(CR.`IncorporationDate`, 7) || "-" || SUBSTR(CR.`IncorporationDate`, 4, 2) || "-" || SUBSTR(CR.`IncorporationDate`, 1, 2),
    SUBSTR(CR.`DissolutionDate`, 7) || "-" || SUBSTR(CR.`DissolutionDate`, 4, 2) || "-" || SUBSTR(CR.`DissolutionDate`, 1, 2), 
    S.ID 
FROM companies_raw CR
    INNER JOIN categories C ON C.Name = CR.`CompanyCategory`
    INNER JOIN statuses S ON S.Name = CR.`CompanyStatus`
;
UPDATE companies SET Dissolution = NULL WHERE Dissolution = '--';
UPDATE companies SET Incorporation = NULL WHERE Incorporation = '--';

/*
 * Company Addresses One-Many Join Table
 */
CREATE TABLE IF NOT EXISTS company_addresses (
    Number VARCHAR(40),
    Address INTEGER,
    POBox VARCHAR(100),
    CO VARCHAR(100),
    Type UNSIGNED INTEGER,
    FOREIGN KEY (Number) REFERENCES companies (Number),
    FOREIGN KEY (Address) REFERENCES addresses (ID)
);
INSERT INTO company_addresses
SELECT 
    C.Number, 
    A.ID,
    replace(replace(`RegAddress.CareOf`, "C/O", ""), "  ", " "),
    replace(replace(`RegAddress.POBox`, "PO BOX", ""), "  ", " "),
    2 /* Bit Flag, 2 will be the registered address bit-flag */ 
FROM companies_raw CR
    INNER JOIN companies C ON C.Number = CR.` CompanyNumber`
    INNER JOIN addresses A ON A.Address = CR.`RegAddress.AddressLine1` || x'0a' || CR.` RegAddress.AddressLine2` || x'0a' || CR.`RegAddress.PostTown`
        AND A.Postcode = CR.`RegAddress.PostCode`
        AND A.County = CR.`RegAddress.County`
        AND A.Country = CR.`RegAddress.Country`
;
UPDATE company_addresses SET CO = NULL WHERE CO IN(
    SELECT `RegAddress.PostCode` FROM companies_raw
) OR CO IN(
    "NO",
    "N/A",
    ".",
    "-",
    '`',
    " ",
    ""
);
UPDATE company_addresses SET POBox = NULL WHERE POBox IN(
    SELECT `RegAddress.PostCode` FROM companies_raw
) OR POBox IN(
    "NO",
    "N/A",
    ".",
    "-",
    '`',
    " ",
    ""
);   

/*
 * Siccode Many-Many Join Table
 */
CREATE TABLE IF NOT EXISTS company_siccodes (
    Number VARCHAR(40),
    SicCode VARCHAR(10),
    FOREIGN KEY (Number) REFERENCES companies (Number),
    FOREIGN KEY (SicCode) REFERENCES siccodes (Number)
);
INSERT INTO company_siccodes
SELECT C.Number, SC.Number AS `SicCode` 
FROM companies_raw CR
    INNER JOIN companies C ON CR.` CompanyNumber` = C.Number
    INNER JOIN siccodes SC ON CR.`SICCode.SicText_1` = SC.Number || ' - ' || SC.Name
;
INSERT INTO company_siccodes
SELECT C.Number, SC.Number AS `SicCode` 
FROM companies_raw CR
    INNER JOIN companies C ON CR.` CompanyNumber` = C.Number
    INNER JOIN siccodes SC ON CR.`SICCode.SicText_2` = SC.Number || ' - ' || SC.Name
;
INSERT INTO company_siccodes
SELECT C.Number, SC.Number AS `SicCode` 
FROM companies_raw CR
    INNER JOIN companies C ON CR.` CompanyNumber` = C.Number
    INNER JOIN siccodes SC ON CR.`SICCode.SicText_3` = SC.Number || ' - ' || SC.Name
;
INSERT INTO company_siccodes
SELECT C.Number, SC.Number AS `SicCode` 
FROM companies_raw CR
    INNER JOIN companies C ON CR.` CompanyNumber` = C.Number
    INNER JOIN siccodes SC ON CR.`SICCode.SicText_4` = SC.Number || ' - ' || SC.Name
;
