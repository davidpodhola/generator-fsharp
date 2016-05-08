IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'AllDataTypes'
  )
BEGIN
--  Create table 'AllDataTypes'
CREATE TABLE [AllDataTypes] (
   [DataTypeID] int IDENTITY (1,1) NOT NULL
  ,[DataTypeName] nvarchar(15) NOT NULL
  ,[DtBigint] bigint NOT NULL CONSTRAINT DF_AllDataTypes_DtBigint DEFAULT (1)
  ,[DtNumeric] numeric NOT NULL CONSTRAINT DF_AllDataTypes_DtNumeric DEFAULT (2.2)
  ,[DtNumeric_8_2] numeric(8, 2) NOT NULL CONSTRAINT DF_AllDataTypes_DtNumeric_8_2 DEFAULT (3.3)
  ,[Dtbit] bit NOT NULL CONSTRAINT DF_AllDataTypes_Dtbit DEFAULT (0)
  ,[DtSmallint] smallint NOT NULL CONSTRAINT DF_AllDataTypes_DtSmallint DEFAULT (5)
  ,[DtDecimal] decimal NOT NULL CONSTRAINT DF_AllDataTypes_DtDecimal DEFAULT (6.6)
  ,[DtDecimal_10_2] decimal(10, 2) NOT NULL CONSTRAINT DF_AllDataTypes_DtDecimal_10_2 DEFAULT (7.7)
  ,[DtSmallMoney] smallmoney NOT NULL CONSTRAINT DF_AllDataTypes_DtSmallMoney DEFAULT (8.8)
  ,[DtInt] int NOT NULL CONSTRAINT DF_AllDataTypes_DtInt DEFAULT (9)
  ,[DtTinyInt] tinyint NOT NULL
  ,[DtMoney] money NOT NULL
  ,[DtFloat] float NOT NULL
  ,[DtReal] real NOT NULL
  ,[DtDate] date NOT NULL
  ,[DtDatetimeOffset] datetimeoffset NOT NULL
  ,[DtDatetime2] datetime2 NOT NULL
  ,[DtSmallDatetime] smalldatetime NOT NULL
  ,[DtDatetime] datetime NOT NULL
  ,[DtTime] time NOT NULL
  ,[DtChar] char(255) NULL
  ,[DtVarchar] varchar(255) NOT NULL CONSTRAINT DF_AllDataTypes_DtVarchar DEFAULT ('')
  ,[DtVarcharMax] varchar(max) NOT NULL CONSTRAINT DF_AllDataTypes_DtVarcharMax DEFAULT ('')
  ,[DtNchar] nchar(255) NULL
  ,[DtNvarchar] nvarchar(255) NOT NULL CONSTRAINT DF_AllDataTypes_DtNvarchar DEFAULT ('A')
  ,[DtNvarcharMax] nvarchar(max) NOT NULL CONSTRAINT DF_AllDataTypes_DtNvarcharMax DEFAULT ('B')
  ,[DtBinary] binary(8) NULL
  ,[DtVarbinary] varbinary(1000) NULL
  ,[DtVarbinaryMax] varbinary(max) NULL
  ,[DtTimestamp] timestamp NOT NULL
  ,[DtHierarchyid] hierarchyid NOT NULL
  ,[DtUniqueIdentifier] uniqueidentifier NOT NULL CONSTRAINT DF_AllDataTypes_DtUniqueIdentifier DEFAULT (newid())
  ,[DtSqlVariant] sql_variant NULL
  ,[DtXml] xml NULL
  ,[DtGeography] geography NULL
  ,[DtGeometry] geometry NULL
  ,CONSTRAINT PK_AllDataTypes PRIMARY KEY NONCLUSTERED (DataTypeID)
  ,CONSTRAINT IK_AllDataTypes_DataTypeName UNIQUE CLUSTERED (DataTypeName)
)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'Departments'
  )
BEGIN
--  Create table 'Departments'
CREATE TABLE [Departments] (
   [DepartmentID] int IDENTITY (1,1) NOT NULL
  ,[DepartmentName] nvarchar(50) NOT NULL
  ,[ParentID] int NULL
  ,[ManagerID] int NULL
  ,CONSTRAINT PK_Departments PRIMARY KEY CLUSTERED (DepartmentID)
)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'Employees'
  )
BEGIN
--  Create table 'Employees'
CREATE TABLE [Employees] (
   [EmployeeID] int IDENTITY (1,1) NOT NULL
  ,[LastName] nvarchar(50) NOT NULL
  ,[FirstName] nvarchar(50) NOT NULL
  ,[DepartmentID] int NOT NULL
  ,CONSTRAINT PK_Employees PRIMARY KEY NONCLUSTERED (EmployeeID)
)
CREATE CLUSTERED INDEX IK_Employees_FirstName_LastName ON [Employees] (FirstName, LastName)
CREATE INDEX IK_Employees_LastName ON [Employees] (LastName)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'ItemBranches'
  )
BEGIN
--  Create table 'ItemBranches'
CREATE TABLE [ItemBranches] (
   [ItemID] int NOT NULL
  ,[SubItemID] int NOT NULL
  ,[BranchID] int NOT NULL
  ,[ItemValue] nvarchar(255) NOT NULL
  ,CONSTRAINT PK_ItemBranches PRIMARY KEY NONCLUSTERED (ItemID, SubItemID, BranchID)
)
CREATE INDEX IK_ItemBranches_ItemID_SubItemID ON [ItemBranches] (ItemID, SubItemID)
CREATE INDEX IK_ItemBranches_SubItemID_ItemID ON [ItemBranches] (SubItemID, ItemID)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'Items'
  )
BEGIN
--  Create table 'Items'
CREATE TABLE [Items] (
   [ItemID] int NOT NULL
  ,[SubItemID] int NOT NULL
  ,[ItemName] nvarchar(255) NOT NULL
  ,CONSTRAINT PK_Items PRIMARY KEY CLUSTERED (ItemID, SubItemID)
)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'TestForeignKeyOptions'
  )
BEGIN
--  Create table 'TestForeignKeyOptions'
CREATE TABLE [TestForeignKeyOptions] (
   [DepartmentID] int NOT NULL
  ,[Memo] nvarchar(50) NOT NULL
  ,CONSTRAINT PK_TestForeignKeyOptions PRIMARY KEY CLUSTERED (DepartmentID)
)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'TestForeignKeyOptions2'
  )
BEGIN
--  Create table 'TestForeignKeyOptions2'
CREATE TABLE [TestForeignKeyOptions2] (
   [OptionID] int IDENTITY (1,1) NOT NULL
  ,[DepartmentID] int NULL
  ,[Memo] nvarchar(50) NOT NULL
  ,CONSTRAINT PK_TestForeignKeyOptions2 PRIMARY KEY CLUSTERED (OptionID)
)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'TestForeignKeyOptions3'
  )
BEGIN
--  Create table 'TestForeignKeyOptions3'
CREATE TABLE [TestForeignKeyOptions3] (
   [OptionID] int IDENTITY (1,1) NOT NULL
  ,[DepartmentID] int NULL
  ,[Memo] nvarchar(50) NOT NULL
  ,CONSTRAINT PK_TestForeignKeyOptions3 PRIMARY KEY CLUSTERED (OptionID)
)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'TestForeignKeyOptions4'
  )
BEGIN
--  Create table 'TestForeignKeyOptions4'
CREATE TABLE [TestForeignKeyOptions4] (
   [OptionID] int IDENTITY (1,1) NOT NULL
  ,[DepartmentID] int NULL
  ,[Memo] nvarchar(50) NOT NULL
  ,CONSTRAINT PK_TestForeignKeyOptions4 PRIMARY KEY CLUSTERED (OptionID)
)
END
;

IF NOT EXISTS (
  SELECT *
    FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
     AND TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME = 'ZipCodes'
  )
BEGIN
--  Create table 'ZipCodes'
CREATE TABLE [ZipCodes] (
   [ZipCode] varchar(8) NOT NULL
  ,[Address1] nvarchar(255) NOT NULL
  ,[Address2] nvarchar(255) NOT NULL CONSTRAINT DF_ZipCodes_Address2 DEFAULT ('')
  ,[Address3] nvarchar(255) NOT NULL CONSTRAINT DF_ZipCodes_Address3 DEFAULT ('')
)
CREATE CLUSTERED INDEX IK_ZipCodes_ZipCode ON [ZipCodes] (ZipCode)
END
;


-- Foreign keys for table 'Departments'
ALTER TABLE [Departments] ADD
  CONSTRAINT FK_Departments_ParentID
  FOREIGN KEY (ParentID)
  REFERENCES Departments(DepartmentID)
, CONSTRAINT FK_Departments_ManagerID
  FOREIGN KEY (ManagerID)
  REFERENCES Employees(EmployeeID)
;

-- Foreign keys for table 'Employees'
ALTER TABLE [Employees] ADD
  CONSTRAINT FK_Employees_DepartmentID
  FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID)
;

-- Foreign keys for table 'ItemBranches'
ALTER TABLE [ItemBranches] ADD
  CONSTRAINT FK_ItemBranches_ItemID_SubItemID
  FOREIGN KEY (ItemID,SubItemID)
  REFERENCES Items(ItemID,SubItemID) ON DELETE CASCADE
;

-- Foreign keys for table 'TestForeignKeyOptions'
ALTER TABLE [TestForeignKeyOptions] ADD
  CONSTRAINT FK_TestForeignKeyOptions_DepartmentID
  FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID)
;

-- Foreign keys for table 'TestForeignKeyOptions2'
ALTER TABLE [TestForeignKeyOptions2] ADD
  CONSTRAINT FK_TestForeignKeyOptions2_DepartmentID
  FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID) ON DELETE CASCADE ON UPDATE SET NULL
;

-- Foreign keys for table 'TestForeignKeyOptions3'
ALTER TABLE [TestForeignKeyOptions3] ADD
  CONSTRAINT FK_TestForeignKeyOptions3_DepartmentID
  FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID) ON DELETE SET NULL ON UPDATE SET DEFAULT
;

-- Foreign keys for table 'TestForeignKeyOptions4'
ALTER TABLE [TestForeignKeyOptions4] ADD
  CONSTRAINT FK_TestForeignKeyOptions4_DepartmentID
  FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID) ON DELETE SET DEFAULT ON UPDATE CASCADE
;

