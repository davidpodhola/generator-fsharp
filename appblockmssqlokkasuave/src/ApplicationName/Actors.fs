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
              printfn "Hello %A %i" who (Library.hello (who.GetHashCode()))
              return response()
          | Hi -> 
              printfn "Hello from F#!"
              return response()
      }
#endif