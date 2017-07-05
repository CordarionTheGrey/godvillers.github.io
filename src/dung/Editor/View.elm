module Editor.View exposing (view)

import Char as C
import List as L

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Editor.Model exposing (..)
import Editor.Controller exposing (Msg(..))


u: C.KeyCode -> String
u = String.fromChar << C.fromCode


showCell: Cell -> String
showCell cell =
    case cell of
    Unknown  -> "?"
    Empty    -> u 0xA0 -- Non-breaking space.
    Wall     -> "#"
    Entry    -> "🚪"
    Treasure -> "@"
    Trap     -> "🕳"
    Mark     -> "!"
    Warning  -> "⚠"
    Portal {once} ->
        if once then "~1" else "~"
    Boss {alive, strength} ->
        let a = if alive then "⚠" else "💀" ++ u 0x2060 -- Word joiner.
            s = case strength of
                Nothing    -> "?"
                Just One   -> "1"
                Just Two   -> "2"
                Just Three -> "3"
        in  a ++ s


genPalette: Maybe Cell -> List (Attribute Msg) -> List Cell -> List (Html Msg)
genPalette activeBrush attrs =
    let f cell =
        let thisIsActive = Just cell == activeBrush
            styling = classList [("pushed", thisIsActive)]
            newBrush = if thisIsActive then Nothing else Just cell
        in  button (onClick (ChangeBrush newBrush) :: styling :: attrs) [text <| showCell cell]
    in  L.map f


genNavigation: List (Attribute Msg) -> List (Html Msg) -> Html Msg
genNavigation attrs contents =
    let empty = td [ ] [ ]
        arrow t msg = td [ ] [button [onClick msg, class "palette"] [text t]]
    in  table [ ] [
        tr [ ] [empty, arrow "↑" ScrollUp, empty],
        tr [ ] [arrow "←" ScrollLeft, td attrs contents, arrow "→" ScrollRight],
        tr [ ] [empty, arrow "↓" ScrollDown, empty]
    ]


genCell: List (Attribute Msg) -> Cell -> Html Msg
genCell attrs cell =
    let classes = classList [
        ("dmc", True),
        ("dmw", cell == Wall)
    ]
    in  div (classes :: attrs) [text <| showCell cell]


genRow: Int -> List Cell -> Html Msg
genRow i =
    let genCell2 j =
        genCell [onClick (ChangeCell i j), style [("left", toString (j * 21) ++ "px")]]
    in  div [class "dml"] << L.indexedMap genCell2


view: Model -> Html Msg
view model =
    div [ ] [
        div [ ] [text "Вставьте сюда код страницы хроники (не адрес):"],
        div [ ] [textarea [ ] [ ]],
        div [ ] [button [onClick ParseMap] [text "Сгенерировать"]],
        br [ ] [ ],
        div [ ] <| genPalette model.brush [class "palette"] [
            Unknown,
            Empty,
            Wall,
            Entry,
            Treasure,
            Trap,
            Mark,
            Warning,
            Portal { once = True },
            Portal { once = False },
            Boss { alive = True,  strength = Nothing },
            Boss { alive = True,  strength = Just One },
            Boss { alive = True,  strength = Just Two },
            Boss { alive = True,  strength = Just Three },
            Boss { alive = False, strength = Nothing },
            Boss { alive = False, strength = Just One },
            Boss { alive = False, strength = Just Two },
            Boss { alive = False, strength = Just Three }
        ],
        genNavigation [class "box"] [
            div [class "block_h"] [text "Карта"],
            div [class "new_line em_font"] (L.indexedMap genRow model.field)
        ]
    ]
