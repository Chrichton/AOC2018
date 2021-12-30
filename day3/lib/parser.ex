defmodule Parser do
  import NimbleParsec

  # #1 @ 100,366: 24x27

  defparsec(
    :claim,
    ignore(string("#"))
    |> integer(min: 1)
    |> ignore(string(" @ "))
    |> integer(min: 1)
    |> ignore(string(","))
    |> integer(min: 1)
    |> ignore(string(": "))
    |> integer(min: 1)
    |> ignore(string("x"))
    |> integer(min: 1)
  )
end
