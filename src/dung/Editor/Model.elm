module Editor.Model exposing (Strength(..), Cell(..), Model, model)

import List exposing (..)


type Strength = One | Two | Three


type Cell
    = Unknown
    | Empty
    | Wall
    | Entry
    | Treasure
    | Trap
    | Mark
    | Warning
    | Portal { once: Bool }
    | Boss { alive: Bool, strength: Maybe Strength }


type alias Field = List (List Cell)


type alias Model = {
    initial: Bool,
    field: Field,
    brush: Maybe Cell
}


model: Model
model =
    {
        initial = True,
        field = repeat 16 (repeat 16 Unknown),
        brush = Nothing
    }
