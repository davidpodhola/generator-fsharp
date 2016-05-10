namespace ApplicationName.Core

#if DEMO
  [<CLIMutable>]
  type Person = {
      FirstName:string
      LastName:string
  }

  type HelloMessage = 
    | Greet of Person
    | Hi
#endif
