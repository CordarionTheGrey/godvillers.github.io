module Editor.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Editor.Model exposing (..)
import Editor.Controller exposing (Msg(..))


view: Model -> Html Msg
view model =
    div [class "body"] [
        div [ ] [button [onClick Inc] [text "Inc"]],
        div [ ] [text <| toString model.i]
    ]
