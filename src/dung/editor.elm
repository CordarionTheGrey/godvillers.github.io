module Editor exposing (main)

import Html exposing (..)

import Editor.Model exposing (..)
import Editor.View exposing (..)
import Editor.Controller exposing (..)


main: Program Never Model Msg
main =
    beginnerProgram { model = model, view = view, update = update }
