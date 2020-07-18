module Components exposing (layout)

import Browser exposing (Document)
import FeatherIcons as FI
import Generated.Route as Route exposing (Route)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)


layout : { page : Document msg } -> Document msg
layout { page } =
    { title = page.title
    , body =
        [ div [ class "" ]
            [ navbar
            , div [] page.body
            ]
        ]
    }


navbar : Html msg
navbar =
    header [ class "p-4 flex justify-between" ]
        [ div [ class "flex" ]
            [ div [ class "w-6" ] [ img [ src "/logo.png" ] [] ]
            ]
        , div [ class "grid grid-cols-4 gap-4" ]
            [ div [ class "w-6 text-gray-500" ] [ FI.mail |> FI.toHtml [] ]
            , div [ class "w-6 text-gray-500" ] [ FI.moreVertical |> FI.toHtml [] ]
            , div [ class "w-6 text-gray-500" ] [ FI.plus |> FI.toHtml [] ]
            , div [ class "w-6 text-gray-500" ] [ FI.settings |> FI.toHtml [] ]
            ]
        ]
