module Editor.Controller exposing (Msg(..), update)

import Editor.Model exposing (..)


type Msg = NoOp | Inc


update: Msg -> Model -> Model
update msg model =
    case msg of
    NoOp -> model
    Inc -> { model | i = model.i + 1 }
