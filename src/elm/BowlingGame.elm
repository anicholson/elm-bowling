module BowlingGame where

{-|

Runs a game of 10-pin bowling, and interacts with the player via ports.

@docs main

# Interfaces

@docs scorecard

-}

import Bowling exposing (..)
import Marshalling exposing (scorecardToJson)
import Json.Encode
import Json.Decode

import Graphics.Element exposing (show)

games' = [
           { player = "Fred",   frames = [Strike, Strike, Strike, Complete 3 3]}
         , { player = "Barney", frames = [Strike, Spare 3, Strike, Spare 7 ] } ]


newModel : String -> Scorecard
newModel s = games'

{-| The scorecard for the current game, in JSON format -}
port scorecard : Signal Json.Encode.Value
port scorecard = Signal.map scorecardToJson gameSignal

port trigger : Signal String

gameSignal = Signal.map newModel trigger


{-| Kick off the game -}
main = show "LOL"
