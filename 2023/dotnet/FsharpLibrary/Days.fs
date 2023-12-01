namespace Days

open Helpers.AdventDataFetcher

module Answers =
    let Day1 =
        let tracer = (getFunctionInfo()).get()
        printfn "tracer: %A" tracer
        // let downloadPath = calculateDownloadPath tracer
        // printfn "downloadPath: %A" downloadPath
        let input = getInputData tracer

    let Day2 =
        let tracer = (getFunctionInfo()).get()
        printfn "tracer: %A" tracer
