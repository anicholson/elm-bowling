import String
import Task

import Console
import ElmTest exposing (..)

import Bowling exposing(Frame(Empty, IncompleteFrame, Complete, Spare, Strike), gameScore, Scorecard)
import Marshalling
import Json.Encode exposing (list, object, string)

frameScoreTests : Test
frameScoreTests =
    suite "frameScore"
        [
            test "No pins scores 0" (assertEqual (Bowling.frameScore Empty Empty Empty False) 0)
            , suite "Normal frames add up the pins" [
                test "Incomplete" (assertEqual 4 (Bowling.frameScore (IncompleteFrame 4) Empty Empty False))
              , test "Complete" (assertEqual 6 (Bowling.frameScore (Complete 4 2) Empty Empty False)) ]
            , suite "Spares get a bonus from the next bowl" [
                  test "Gutter" (assertEqual 10 (Bowling.frameScore (Spare 1) (IncompleteFrame 0) Empty False))
                , test "Incomplete" (assertEqual 13 (Bowling.frameScore (Spare 1) (IncompleteFrame 3) Empty False))
                , test "Complete" (assertEqual 13 (Bowling.frameScore (Spare 1) (Complete 3 5) Empty False))
                , test "Spare" (assertEqual 13 (Bowling.frameScore (Spare 1) (Spare 3) Empty False))
                , test "Strike" (assertEqual 20 (Bowling.frameScore (Spare 1) Strike Empty False)) ]
            , suite "Strikes get a bonus from the next two bowls" [
                  test "Gutter" (assertEqual 10 (Bowling.frameScore Strike Empty Empty False))
                , test "Incomplete" (assertEqual 11 (Bowling.frameScore Strike (IncompleteFrame 1) Empty False))
                , test "Complete" (assertEqual 12 (Bowling.frameScore Strike (Complete 1 1) Empty False))
                , test "Spare" (assertEqual 20 (Bowling.frameScore Strike (Spare 1) Empty False))
                , test "Spare" (assertEqual 20 (Bowling.frameScore Strike (Spare 0) Empty False))
                , test "Strike" (assertEqual 20 (Bowling.frameScore Strike Strike Empty False))
                , test "Strike" (assertEqual 30 (Bowling.frameScore Strike Strike Strike  False))
            ]
        ]

gameScoreTests : Test
gameScoreTests =
  suite "gameScore"
    [
        test "All gutters" (assertEqual 0 (gameScore [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]))
      , test "All single pins" (assertEqual 20 (gameScore [(Complete 1 1), (Complete 1 1), (Complete 1 1), (Complete 1 1), (Complete 1 1), (Complete 1 1), (Complete 1 1), (Complete 1 1), (Complete 1 1), (Complete 1 1)]))
      , test "All single pins" (assertEqual 111 (gameScore [(Spare 1), (Spare 1), (Spare 1), (Spare 1), (Spare 1), (Spare 1), (Spare 1), (Spare 1), (Spare 1), (Spare 1), (IncompleteFrame 1)]))
      , test "Strike Gutter Spare" (assertEqual 210 (gameScore [Strike, (Spare 0), Strike, (Spare 0), Strike, (Spare 0), Strike, (Spare 0), Strike, (Spare 0), Strike]))
      , test "Perfect game" (assertEqual 300 (gameScore [Strike, Strike, Strike, Strike, Strike, Strike, Strike, Strike, Strike, Strike, Strike, Strike]))
      , test "Turkey + gutters" (assertEqual 60 (gameScore [Strike, Strike, Strike, Empty, Empty]))
    ]

newGame : Scorecard
newGame = [  { player = "Fred", frames = [] } ]

newGame' = Json.Encode.list <| [Json.Encode.object [("player", string "Fred"), ("frames", list [] )]]



twoPlayers : Scorecard
twoPlayers = [
    { player = "Fred", frames = [] }
  , { player = "Barney", frames = [ Strike, Strike, Strike, Strike ] } ]

twoPlayers' = Json.Encode.list <| [
    Json.Encode.object [("player", string "Fred"), ("frames", list [] )]
  , Json.Encode.object [("player", string "Barney"), ("frames", list [] )] ]


marshallingTests : Test
marshallingTests =
  suite "scorecardToJson"
    [
        test "new game with one player" (assertEqual newGame' <| Marshalling.scorecardToJson newGame)
      , test "partially-complete game with two players" (assertEqual twoPlayers' <| Marshalling.scorecardToJson twoPlayers)
    ]


tests : Test
tests =
    suite "Bowling" [ frameScoreTests, gameScoreTests, marshallingTests]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
