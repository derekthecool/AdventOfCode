module Day1

open System.Diagnostics
open System.Net
open System.Net.Http
open System.IO
open System


(*
1. Get year from filename, repo name is AdventOfCode and then this code will be in the 2023 directory
2. Get the advent of code cookie from environment variable and exit program if not found
3. Flow for getting input data:
    first check to see if a file exists in the repo root/input_data/year(2023)/day/day(1)
        if it does not exist then download it and store in similar path
        if it does exist then read the file and be done
*)

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

let answer =
    let stackTrace = new StackTrace()
    let stackFrame = stackTrace.GetFrame(1).GetMethod().Name

    printfn "Day1 answer: %d, %A" 5 stackFrame
