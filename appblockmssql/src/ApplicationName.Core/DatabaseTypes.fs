module DatabaseTypes
open FSharp.Data

[<Literal>]
let connectionStringForCompileTime = @"Data Source=(localdb)\MSSQLLocalDB;AttachDbFilename=" + __SOURCE_DIRECTORY__ + @"\tools\Database1.mdf;Integrated Security=True;Connect Timeout=10"

type EmployeesQuery = SqlCommandProvider<"SELECT * FROM Employees", connectionStringForCompileTime>

let myResults = (new EmployeesQuery("Use your Runtime connectionString here")).Execute()

