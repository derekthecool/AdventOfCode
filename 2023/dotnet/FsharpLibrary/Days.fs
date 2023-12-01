namespace Days

open Helpers.AdventDataFetcher

module Answers =
    let Day1 =
        let tracer = (getFunctionInfo()).get()
        printfn "tracer: %A" tracer
        let input = getInputData tracer |> Seq.iter(fun line -> printfn "%A" line)
        ()

    let Day2 =
        let tracer = (getFunctionInfo()).get()
        printfn "tracer: %A" tracer
