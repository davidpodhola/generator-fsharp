namespace ApplicationName

module Actors=
  open Orleankka
  open Orleankka.FSharp
  open Orleankka.Playground
  open ApplicationName.Core
  open System

#if DEMO
  type Greeter() = 
      inherit Actor<HelloMessage>()

      override this.Receive message = task {
          match message with
          | Greet who ->               
              return response(sprintf "Hello %s %s %i" who.FirstName who.LastName (Library.hello (who.GetHashCode())))
          | Hi -> 
              return response("Hello from F#!")
      }
#endif