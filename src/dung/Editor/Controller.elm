module Editor.Controller exposing (Msg(..), update)

import List exposing (..)

import Editor.Model exposing (..)


type Msg
    = ParseMap
    | ChangeBrush (Maybe Cell)
    | ChangeCell Int Int
    | ScrollUp
    | ScrollDown
    | ScrollLeft
    | ScrollRight


modify: Int -> (a -> a) -> List a -> List a
modify i f ls =
    case ls of
    [ ] -> ls
    hd :: tl ->
        if i == 0 then
            f hd :: tl
        else
            hd :: modify (i - 1) f tl


update: Msg -> Model -> Model
update msg model =
    case msg of
    ParseMap -> { model | initial = False } -- TODO: Ask for confirmation if initial == False.
    ChangeBrush brush -> { model | brush = brush }
    ChangeCell i j ->
        case model.brush of
        Nothing -> model
        Just brush ->
            { model | initial = False, field = modify i (modify j (always brush)) model.field }
    ScrollUp    -> { model | field = drop 1 model.field ++ [repeat 16 Unknown] }
    ScrollDown  -> { model | field = repeat 16 Unknown :: take 15 model.field }
    ScrollLeft  -> { model | field = map (\row -> drop 1 row ++ [Unknown]) model.field }
    ScrollRight -> { model | field = map ((::) Unknown << take 15) model.field }
