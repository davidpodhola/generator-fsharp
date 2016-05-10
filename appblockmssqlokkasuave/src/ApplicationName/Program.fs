namespace ApplicationName

module Program =

  open System

  open Suave                 
  open Suave.Web
  open Suave.Http
  open Suave.Utils

  open Orleankka
  open Orleankka.Http
  open Orleankka.Playground

  open System.Reflection            
  open Newtonsoft.Json

  open ApplicationName.Core

  [<EntryPoint>]
  let main argv = 
  
    printfn "Running demo. Booting cluster might take some time ...\n"

    let assemblies:Assembly [] = [| Assembly.GetExecutingAssembly();(typeof<HelloMessage>).Assembly |]

    // configure actor system
    use system = ActorSystem.Configure()
                            .Playground()
                            .Register(assemblies)
                            .Done()
  
    let testActor = system.ActorOf<Actors.Greeter>("http_test")
    printfn "Actor path %A" testActor.Path

    // configure actor routing
    let router = [(MessageType.DU(typeof<HelloMessage>), testActor.Path)]
                  |> Seq.collect HttpRoute.create
                  |> ActorRouter.create JsonConvert.DeserializeObject


    let hasContentType (ctx:HttpContext) = async {
      match ctx.request.header "content-type" with         
      | Choice1Of2 v when v = ContentType.Orleankka -> 
             return Some ctx
      | _ -> return None
    }    

    // sends msg to actor 
    let sendMsg actorPath (ctx:HttpContext) = async {    
    
      let msgBody = ctx.request.rawForm |> UTF8.toString
        
      match router.Dispatch(actorPath, msgBody) with
      | Some t -> let! result = Async.AwaitTask t
                  return! OK (result.ToString()) ctx
      | None   -> return! BAD_REQUEST "actor has not found, or message has invalid format" ctx  
    }  

    // configure Suave routing
    let app = POST >>= hasContentType >>= pathScan "/api/%s" (fun path -> request (fun req ctx -> sendMsg path ctx))  

    printfn "Finished booting cluster...\n"

    startWebServer defaultConfig app
    0 
