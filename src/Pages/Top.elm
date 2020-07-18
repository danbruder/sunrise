module Pages.Top exposing (Flags, Model, Msg, page)

import Date exposing (Date, Interval(..), Unit(..))
import Global
import Html exposing (..)
import Html.Attributes exposing (..)
import Page exposing (Document, Page)


type alias Flags =
    ()


type alias Model =
    {}


type Msg
    = NoOp


page : Page Flags Model Msg
page =
    Page.component
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : Global.Model -> Flags -> ( Model, Cmd Msg, Cmd Global.Msg )
init global flags =
    ( {}, Cmd.none, Cmd.none )


update : Global.Model -> Msg -> Model -> ( Model, Cmd Msg, Cmd Global.Msg )
update global msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none, Cmd.none )


subscriptions : Global.Model -> Model -> Sub Msg
subscriptions global model =
    Sub.none


view : Global.Model -> Model -> Document Msg
view global model =
    { title = "Top"
    , body =
        [ case global.today of
            Just day ->
                calendar day

            Nothing ->
                span [] []
        ]
    }


calendar today =
    let
        dayHeaders =
            [ "S", "M", "T", "W", "T", "F", "S" ]

        viewDayHeader day =
            div [ class "text-gray-400 text-center" ] [ text day ]

        viewDay day =
            div [ class "text-gray-400 flex justify-center " ]
                [ div
                    [ class "p-1 px-2"
                    , classList
                        [ ( "bg-blue-500 text-white rounded-full ", today == day )
                        ]
                    ]
                    [ text (Date.format "d" day)
                    ]
                ]

        startOfThisWeek =
            today
                |> Date.floor Week

        thisWeekDayNumbers =
            List.range -1 5
                |> List.map (\index -> Date.add Days index startOfThisWeek)

        nextWeekNumbers =
            List.range 6 12
                |> List.map (\index -> Date.add Days index startOfThisWeek)
    in
    div [ class "py-4" ]
        [ div [ class "text-xs grid grid-cols-7 border-b border-gray-200 py-2" ] <| List.map viewDayHeader dayHeaders
        , div [ class "text-xs grid grid-cols-7 border-b border-gray-200 py-2" ] <| List.map viewDay thisWeekDayNumbers
        , div [ class "text-xs grid grid-cols-7 border-b border-gray-200 py-2" ] <| List.map viewDay nextWeekNumbers
        ]
