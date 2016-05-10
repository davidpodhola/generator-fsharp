namespace System
open System.Reflection

[<assembly: AssemblyTitleAttribute("ApplicationName.Core")>]
[<assembly: AssemblyProductAttribute("ApplicationName.Core")>]
do ()

module internal AssemblyVersionInformation =
    let [<Literal>] Version = "LocalBuild"
    let [<Literal>] InformationalVersion = "LocalBuild"
