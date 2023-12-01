namespace Days

open Helpers.AdventDataFetcher

module Answers =
    open System.Text.RegularExpressions

    let calibrationRecovery input =
        Regex.Matches(input, @"\d")
        |> Seq.toArray
        |> fun numbers -> ($"{numbers[0]}{numbers[numbers.Length - 1]}" |> int)


    let Day1 =
        let tracer = (getFunctionInfo ()).get ()
        printfn "tracer: %A" tracer
        let output = getInputData tracer |> Seq.map calibrationRecovery |> Seq.sum
        printfn "Output: %A" output
        output

    let Day2 =
        let tracer = (getFunctionInfo ()).get ()
        printfn "tracer: %A" tracer
