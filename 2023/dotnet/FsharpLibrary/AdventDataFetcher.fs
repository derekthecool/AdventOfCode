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
    open System.Text.RegularExpressions

    (*
    1. Get year from filename, repo name is AdventOfCode and then this code will be in the 2023 directory
    2. Get the advent of code cookie from environment variable and exit program if not found
    3. Flow for getting input data:
        first check to see if a file exists in the repo root/input_data/year(2023)/day/day(1)
            if it does not exist then download it and store in similar path
            if it does exist then read the file and be done
    *)


    /// <summary>
    /// This is a fancy function to get the name and path of the calling
    /// function.
    /// Example output:
    /// ("Day1", "D:\Programming\AdventOfCode\2023\dotnet\FsharpLibrary\Days.fs")
    ///
    /// Use like this: let tracer = (Tracer()).DoTrace()
    /// </summary>
    type getFunctionInfo() =
        member _.get
            (
                [<CallerMemberName; Optional; DefaultParameterValue("")>] memberName: string,
                [<CallerFilePath; Optional; DefaultParameterValue("")>] path: string
            ) =
            memberName, path

    // // This version uses a callstack approach and it does not always work
    // let getCallingFunctionPath callingFunctionName =
    //     printfn "callingFunctionName: %s" callingFunctionName
    //     let stackFrames = new StackTrace() |> fun stackTrace -> stackTrace.GetFrames()
    //
    //     match stackFrames with
    //     | null
    //     | [||] -> None
    //     | _ ->
    //         let callingFrame =
    //             stackFrames
    //             |> Seq.skipWhile (fun frame -> frame.GetMethod().Name = "getCallingFunctionPath")
    //             |> Seq.tryHead
    //         // 0 is the current frame (aka this function)
    //         // 1 is something ....
    //         // 2 is the calling function from some other place (aka consumer of this library)
    //         // This one is needed to get the method name when is expected to include [Dd]ay1 etc.
    //         stackFrames
    //         |> Seq.iter (fun word -> printfn "stack frame: %A" (word.GetMethod()))
    //
    //         match callingFrame with
    //         | Some frame ->
    //             let method = frame.GetMethod()
    //             Some(method.DeclaringType.Assembly.Location, method.Name)
    //         | None -> None

    let getDayNumber dayString =
        let dayCapture = Regex.Match(dayString, @"[Dd]ay(\d{1,2})")

        match dayCapture.Success with
        | true -> dayCapture.Groups[1].Value |> int
        | false -> 0

    let getYearNumber yearString =
        let yearCapture = Regex.Match(yearString, @"AdventOfCode[/\\](\d{4})")

        match yearCapture.Success with
        | true -> yearCapture.Groups[1].Value |> int
        | false -> 0

    let calculateDownloadPath functionInformation =

        let dayNumber = getDayNumber (fst functionInformation)

        if dayNumber = 0 then
            raise (System.Exception($"Capturing the day number from the string: {(fst functionInformation)} failed"))

        let yearNumber = getYearNumber (snd functionInformation)

        if yearNumber = 0 then
            raise (System.Exception($"Capturing the year number from the string: {(snd functionInformation)} failed"))

        let downloadPath =
            sprintf "https://adventofcode.com/%d/day/%d/input" yearNumber dayNumber

        let downloadPathCheck = Uri.IsWellFormedUriString(downloadPath, UriKind.Absolute)

        if not downloadPathCheck then
            raise (System.Exception($"The download path {downloadPath} could not be parsed as I URI correctly"))

        printfn
            "dayNumber: %A, yearNumber: %A, downloadPath: %A, downloadPathCheck: %A"
            dayNumber
            yearNumber
            downloadPath
            downloadPathCheck

        downloadPath, dayNumber, yearNumber

    let calculateLocalPath libraryPathBase year day =
        // https://adventofcode.com/2023/day/1/input" converts to [repo root] -> AdventOfCode/inputs/2023/1.txt
        let filename = $"{day}.txt"
        let fullFilename = Path.Join([ "inputs"; $"{year}"; filename ] |> List.toArray)
        Regex.Replace(libraryPathBase, @"(?<=AdventOfCode[/\\]).*", fullFilename)

    let downloadAdventOfCodeInput (url: string) (outputPath: string) =
        async {
            let cookieFromEnvironmentVariable =
                Environment.GetEnvironmentVariable("AdventOfCodeCookie")

            if cookieFromEnvironmentVariable = null then
                raise (System.Exception("cookieFromEnvironmentVariable is null, cannot proceed"))

            printfn "environment variable: %s" cookieFromEnvironmentVariable

            // Create an HttpClient with a handler that uses the provided CookieContainer
            let handler = new HttpClientHandler()
            let cookieContainer = new CookieContainer()
            cookieContainer.Add(new Uri(url), new Cookie("session", cookieFromEnvironmentVariable))

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

    let getInputData (functionInformation: string * string) =
        let (downloadPath, day, year) = calculateDownloadPath functionInformation
        let (functionName, callingFunctionPath) = functionInformation

        let localFile = calculateLocalPath callingFunctionPath year day
        let fileExists = File.Exists(localFile)
        let directory = Path.GetDirectoryName(localFile).ToString()
        let directoryExists = Directory.Exists(directory)

        if not directoryExists then
            printfn "Creating new directory: %A" directory
            Directory.CreateDirectory(directory) |> ignore

        printfn
            "downloadPath: %A, localFile: %A, fileExists: %A, directoryExists: %A"
            downloadPath
            localFile
            fileExists
            directoryExists

        if fileExists then
            File.ReadLines(localFile)
        else
            printfn "Download file: %A to %A" downloadPath localFile
            downloadAdventOfCodeInput downloadPath localFile |> Async.RunSynchronously

            try
                File.ReadLines(localFile)
            with ex ->
                printfn "Caught an unexpected exception: %s" ex.Message
                raise ex // Rethrow the exception if it's not a DivideByZeroException
