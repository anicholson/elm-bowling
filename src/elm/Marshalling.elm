module Marshalling (scorecardToJson) where

{-|
@docs scorecardToJson
-}

import Bowling exposing (..)
import Json.Encode exposing (..)

gutterValue = string "-"
spareValue  = string "/"
strikeValue = string "X"

pinValue : Int -> Value
pinValue p =
  case p of
  0         -> gutterValue
  otherwise -> string <| toString p

frameToJson : Frame -> Value
frameToJson frame =
  list <| case frame of
            Strike              -> [ strikeValue            ]
            Spare           f   -> [ pinValue f, spareValue ]
            Complete        f s -> [ pinValue f, pinValue s ]
            IncompleteFrame f   -> [ pinValue f ]
            otherwise           -> [  ]


gameToJson : Game -> Value
gameToJson game =
  let
    frameScores = List.map int (gameScore game.frames)
  in
    let
      finalScore = List.reverse frameScores |> List.head
    in
      case finalScore of
        Just finalScore' ->
          object
            [ ("player", string game.player)
            , ("frames", list <| List.map frameToJson game.frames)
            , ("runningScores", list <| frameScores)
            , ("score",  finalScore')
            ]
        otherwise -> Debug.crash "There really should be some scores here!"

{-|

maps a Scorecard into a JSON object.

-}

scorecardToJson : Scorecard -> Value
scorecardToJson scorecard =
  list <| List.map gameToJson scorecard
