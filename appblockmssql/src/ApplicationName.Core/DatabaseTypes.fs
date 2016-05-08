module DatabaseTypes

[<Literal>]
let connectionStringForCompileTime = @"Data Source=(localdb)\MSSQLLocalDB;AttachDbFilename=" + __SOURCE_DIRECTORY__ + @"\tools\Database1.mdf;Integrated Security=True;Connect Timeout=10"

type Foo = SqlCommandProvider<"SELECT * FROM Foo", connectionStringForCompileTime>

let myResults = (new Foo("Use your Runtime connectionString here")).Execute()
