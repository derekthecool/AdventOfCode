open Day1
open System.IO
open System

printfn "Hello from F#"

Day1.answer


let result =
    Async.RunSynchronously(downloadAdventOfCodeInput "https://adventofcode.com/2022/day/1/input" "day1_input.txt")
