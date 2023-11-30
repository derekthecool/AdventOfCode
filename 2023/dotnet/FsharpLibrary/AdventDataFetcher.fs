namespace Helpers

module AdventDataFetcher =
    open System.Diagnostics
    open System.Net.Http
    open System.Net
    open System
    open System.IO
    open System.Diagnostics
    open System.Runtime.CompilerServices
    open System.Runtime.InteropServices

    (*
    1. Get year from filename, repo name is AdventOfCode and then this code will be in the 2023 directory
    2. Get the advent of code cookie from environment variable and exit program if not found
    3. Flow for getting input data:
        first check to see if a file exists in the repo root/input_data/year(2023)/day/day(1)
            if it does not exist then download it and store in similar path
            if it does exist then read the file and be done
    *)
    let doTrace ([<CallerMemberName>] memberName: string, [<CallerFilePath>] path: string) =
        printfn "in do trace"
        printfn " member: %A, path: %A" memberName path
        memberName, path
    // sprintf "memberName: %A, path: %A" memberName path
    type Tracer() =
        member _.DoTrace
            (
                [<CallerMemberName; Optional; DefaultParameterValue("")>] memberName: string,
                [<CallerFilePath; Optional; DefaultParameterValue("")>] path: string,
                [<CallerLineNumber; Optional; DefaultParameterValue(0)>] line: int
            ) =
            // Console.WriteLine(sprintf $"Message: {message}")
            // Console.WriteLine(sprintf $"Member name: {memberName}")
            // Console.WriteLine(sprintf $"Source file path: {path}")
            // Console.WriteLine(sprintf $"Source line number: {line}")
            printfn "Test output: %A" memberName
            memberName, path

    let getCallingFunctionPath callingFunctionName =
        printfn "callingFunctionName: %s" callingFunctionName
        let stackFrames = new StackTrace() |> fun stackTrace -> stackTrace.GetFrames()

        match stackFrames with
        | null
        | [||] -> None
        | _ ->
            let callingFrame =
                stackFrames
                |> Seq.skipWhile (fun frame -> frame.GetMethod().Name = "getCallingFunctionPath")
                |> Seq.tryHead
            // 0 is the current frame (aka this function)
            // 1 is something ....
            // 2 is the calling function from some other place (aka consumer of this library)
            // This one is needed to get the method name when is expected to include [Dd]ay1 etc.
            // let callingFrame = stackFrames.[2]
            stackFrames
            |> Seq.iter (fun word -> printfn "stack frame: %A" (word.GetMethod()))

            // let method = callingFrame.GetMethod()

            match callingFrame with
            | Some frame ->
                let method = frame.GetMethod()
                Some(method.DeclaringType.Assembly.Location, method.Name)
            | None -> None

    // Some(method.DeclaringType.Assembly.Location, method.Name)

    let getAdventYearFromCallingFunction =
        printfn "test"
        let stackTrace = new StackTrace()
        let stackFrame = stackTrace.GetFrame(2).GetMethod().Name
        let path = getCallingFunctionPath
        printfn "answer: %d, %A, %A" 5 stackFrame path



    let downloadAdventOfCodeInput (url: string) (outputPath: string) =
        async {
            // Create an HttpClient with a handler that uses the provided CookieContainer
            let handler = new HttpClientHandler()
            let cookieContainer = new CookieContainer()

            let cookieFromEnvironmentVariable =
                Environment.GetEnvironmentVariable("AdventOfCodeCookie")

            if cookieFromEnvironmentVariable = null then
                raise (System.Exception("cookieFromEnvironmentVariable is null, cannot proceed"))

            printfn "environment variable: %s" cookieFromEnvironmentVariable

            cookieContainer.Add(
                new Uri("https://adventofcode.com/2022/day/1/input"),
                new Cookie("session", cookieFromEnvironmentVariable)
            )

            handler.CookieContainer <- cookieContainer
            let httpClient = new HttpClient(handler)

            try
                // Make an HTTP GET request to the specified URL
                let! response = httpClient.GetAsync(url) |> Async.AwaitTask

                // Check if the request was successful (status code 200)
                if response.IsSuccessStatusCode then
                    // Get the content stream
                    let! contentStream = response.Content.ReadAsStreamAsync() |> Async.AwaitTask

                    // Create a FileStream to write the content to a file
                    use fileStream = File.Create(outputPath)

                    // Copy the content stream to the file stream
                    contentStream.CopyTo(fileStream)
                    printfn "File downloaded successfully to: %s" outputPath
                else
                    printfn "Failed to download file. Status code: %s" (response.StatusCode.ToString())

            finally
                // Dispose of the HttpClient to release resources
                httpClient.Dispose()
        }
