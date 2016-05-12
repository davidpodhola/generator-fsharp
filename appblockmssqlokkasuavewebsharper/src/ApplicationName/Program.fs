namespace ApplicationName

module Program =

  open System
  open System.Net

  open Suave                 
  open Suave.Web
  open Suave.Http
  open Suave.Successful
  open Suave.RequestErrors
  open Suave.Utils
  open Suave.Filters
  open Suave.Operators
  open Suave.Files
  
  open Orleankka
  open Orleankka.Http
  open Orleankka.Playground

  open System.Reflection            
  open Newtonsoft.Json

  open ApplicationName.Core
  open Suave.Writers

  [<EntryPoint>]
  let main argv = 
  
    printfn "Running demo. Booting cluster might take some time ...\n"

    let assemblies:Assembly [] = 
      [| Assembly.GetExecutingAssembly();
#if DEMO
      (typeof<HelloMessage>).Assembly 
#endif
      |]

    // configure actor system
    use system = ActorSystem.Configure()
                            .Playground()
                            .Register(assemblies)
                            .Done()
  
#if DEMO
    let testActor = system.ActorOf<Actors.Greeter>("http_test")
#endif
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

    let setCORSHeaders = 
        setHeader  "Access-Control-Allow-Origin" "*" 
        >=>  setHeader "Access-Control-Allow-Headers" "content-type"

    // sends msg to actor 
    let sendMsg actorPath (ctx:HttpContext) = async {    
    
      let msgBody = ctx.request.rawForm |> UTF8.toString
        
      match router.Dispatch(actorPath, msgBody) with
      | Some t -> let! result = Async.AwaitTask t
                  return! ctx |> ( setCORSHeaders >=> OK (result.ToString()) )
      | None   -> return! BAD_REQUEST "actor has not found, or message has invalid format" ctx  
    }  

    let allow_cors : WebPart =
            choose [
                OPTIONS >=> 
                    fun context -> 
                        context |> ( 
                            setCORSHeaders
                            >=>  OK "CORS approved")
        ]

    // configure Suave routing
    let app = 
      choose [
        allow_cors
        POST >=> hasContentType >=> pathScan "/api/%s" (fun path -> request (fun req ctx -> sendMsg path ctx))  
      ]

    printfn "Finished booting cluster...\n"

    startWebServer { defaultConfig with bindings = [ HttpBinding.mkSimple Protocol.HTTP "127.0.0.1" 8080 ]  } app
    0 
