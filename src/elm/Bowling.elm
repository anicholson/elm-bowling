module Bowling (frameScore, gameScore, Frame(..), Scorecard, Game) where

{-| # A bowling game.
@docs Frame, frameScore, gameScore, Scorecard, Game
-}

import Graphics.Element exposing (..)

{-|  A model for the kinds of bowling frame there are. -}
type Frame =
   IncompleteFrame Int
 | Complete Int Int
 | Strike
 | Spare Int
 | Empty

type alias Player = String

{-| A game consists of a Player, and a List of Frames -}

type alias Game = {
    player: Player
  , frames: List Frame
}

{-| A list of Games.

@docs Game

-}

type alias Scorecard = List Game

firstScore : Frame -> Int
firstScore frame =
  case frame of
    IncompleteFrame f -> f
    Complete f s -> f
    Strike -> 10
    Spare f -> f
    otherwise -> 0

secondScore : Frame -> Int
secondScore frame =
  case frame of
    Complete f s -> s
    otherwise -> 0

{-| How to determine the score of a frame, based on it + the next two -}
frameScore : Frame -> Frame -> Frame -> Bool -> Int
frameScore  frame next nextnext bonusFrame =
  case frame of
    IncompleteFrame s -> s
    Complete first second -> first + second
    Strike ->
      if bonusFrame then 10 else
        case next of
          Spare f   -> 20
          Strike    -> 20 + firstScore nextnext
          otherwise -> 10 + frameScore next Empty Empty False
    Spare first -> 10 + firstScore next
    otherwise -> 0

gameScoreInternal : Int -> Int -> List Frame -> Int
gameScoreInternal accumulator previousFrames framesRemaining =
  let
   framesUnderConsideration = List.take 3 framesRemaining
   finalFrame = (previousFrames == 9)
   nextFrame' = if finalFrame then previousFrames else previousFrames + 1
   extractFrame = \listwithoneframe -> case listwithoneframe of
                                        Just f -> case List.head f of
                                                    Just f' -> f'
                                                    Nothing -> Empty
                                        Nothing -> Empty
   ensuredFramesRemaining =  case List.tail framesRemaining of
                                        Just frames' -> frames'
                                        Nothing -> []
  in
    case List.length framesUnderConsideration of
    0 -> accumulator
    otherwise -> let
            frames'  = List.drop 1 framesUnderConsideration
            this     = extractFrame <| Just framesUnderConsideration
            next     = extractFrame <| Just frames'
            nextnext = extractFrame <| List.tail <| frames'

            scoreForThisFrame = frameScore this next nextnext finalFrame
         in
            gameScoreInternal (accumulator + scoreForThisFrame) nextFrame' <| ensuredFramesRemaining

{-| The score for a player, given a list of Frames -}
gameScore : List Frame -> Int
gameScore frames = gameScoreInternal 0 0 frames
