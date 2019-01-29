module ExerciseRunner exposing
    ( Example
    , fontStyles
    , functionExample1
    , functionExample2
    , functionExample3
    , viewExampleSection
    )

--
-- There's no need to look in this file (unless you are curious).
-- All the work you need to do will be done in Main.elm
--

import Debug
import Html exposing (Html)
import Html.Attributes
import String
import Style exposing (..)


outputLabel : String -> Html msg
outputLabel label =
    Html.div
        [ Html.Attributes.style "font-size" "12px"
        , Html.Attributes.style "opacity" "0.4"
        ]
        [ Html.text label ]


fontStyles : Html msg
fontStyles =
    Html.div []
        [ Html.node "link"
            [ Html.Attributes.href "http://fonts.googleapis.com/css?family=Lobster"
            , Html.Attributes.rel "stylesheet"
            , Html.Attributes.type_ "text/css"
            ]
            []
        , Html.node "link"
            [ Html.Attributes.href "http://fonts.googleapis.com/css?family=Cabin"
            , Html.Attributes.rel "stylesheet"
            , Html.Attributes.type_ "text/css"
            ]
            []
        , Html.node "style"
            []
            [ Html.text """
h1, h2, .title-font { font-family: 'Lobster', Georgia, Times, serif; }
h1 { font-size: 90px; line-height: 100px; border-bottom: 3px solid black; }
h2 { font-size: 70px; line-height: 100px; }

body {
font-family: 'Cabin', Helvetica, Arial, sans-serif;
font-size: 15px;
line-height: 25px;
}
"""
            ]
        ]


viewAssertion : Bool -> String -> String -> String -> Html Never
viewAssertion isCorrect call actual expected =
    if isCorrect then
        Html.div
            [ Html.Attributes.style "margin-left" "32px"
            , Html.Attributes.style "background-color" successColor
            ]
            [ Html.span
                [ Html.Attributes.style "padding" "4px"
                , Html.Attributes.style "margin" "8px"
                ]
                [ Html.text successEmoji ]
            , inlineCode call
            , Html.text " == "
            , Html.text actual
            ]

    else
        Html.div
            [ Html.Attributes.style "margin-left" "32px"
            ]
            [ outputLabel "Your implementation:"
            , Html.div
                [ Html.Attributes.style "background-color" keepWorkingColor
                ]
                [ Html.span
                    [ Html.Attributes.style "padding" "4px"
                    , Html.Attributes.style "margin" "8px"
                    ]
                    [ Html.text keepWorkingEmoji ]
                , inlineCode call
                , Html.text " == "
                , Html.text actual
                ]
            , outputLabel "Expected:"
            , Html.div
                [ Html.Attributes.style "background-color" Style.expectedColor
                ]
                [ Html.span
                    [ Html.Attributes.style "padding" "4px"
                    , Html.Attributes.style "margin" "8px"
                    , Html.Attributes.style "opacity" "0"
                    ]
                    [ Html.text keepWorkingEmoji ]
                , inlineCode call
                , Html.text " == "
                , Html.text expected
                ]
            ]


inlineCode : String -> Html msg
inlineCode code =
    Html.div
        [ Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "background-color" "rgba(238, 238, 238, 0.7)"
        , Html.Attributes.style "padding" "4px"
        , Html.Attributes.style "margin" "0"
        , Html.Attributes.style "font-family" "monospace"
        , Html.Attributes.style "whitespace" "pre"
        ]
        [ Html.text code ]


type TestCase
    = TestCase String Bool String String


type alias Example =
    { name : String
    , testCases : List TestCase
    }


isFinished : Example -> Bool
isFinished example =
    List.all (\(TestCase _ isCorrect _ _) -> isCorrect) example.testCases


viewExample : Example -> Html Never
viewExample { name, testCases } =
    let
        showTestCase (TestCase code isCorrect actual expected) =
            Html.div []
                [ viewAssertion isCorrect code actual expected ]

        showTestCases results remainingTestCases =
            case remainingTestCases of
                [] ->
                    List.reverse results

                (TestCase code isCorrect actual expected) :: rest ->
                    showTestCases (showTestCase (TestCase code isCorrect actual expected) :: results)
                        (if isCorrect then
                            rest

                         else
                            []
                        )
    in
    Html.div []
        [ goalHeading name
        , Html.div [] (showTestCases [] testCases)
        ]


goalHeading : String -> Html msg
goalHeading name =
    Html.h3 []
        [ Html.text "Goal: implement the "
        , inlineCode name
        , Html.text " function so that the following tests pass:"
        ]


functionExampleN : (a -> String) -> String -> (a -> value) -> List ( a, value ) -> Example
functionExampleN argsToString name function testCases =
    { name = name
    , testCases =
        List.map
            (\( arg1, expected ) ->
                TestCase
                    (name ++ " " ++ argsToString arg1)
                    (function arg1 == expected)
                    (Debug.toString <| function arg1)
                    (Debug.toString expected)
            )
            testCases
    }


functionExample1 : String -> (a -> value) -> List ( a, value ) -> Example
functionExample1 =
    functionExampleN Debug.toString


functionExample2 : String -> (a -> b -> value) -> List ( ( a, b ), value ) -> Example
functionExample2 name function testCases =
    functionExampleN
        (\( a, b ) -> Debug.toString a ++ " " ++ Debug.toString b)
        name
        (\( a, b ) -> function a b)
        testCases


functionExample3 : String -> (a -> b -> c -> value) -> List ( ( a, b, c ), value ) -> Example
functionExample3 name function testCases =
    functionExampleN
        (\( a, b, c ) -> Debug.toString a ++ " " ++ Debug.toString b ++ " " ++ Debug.toString c)
        name
        (\( a, b, c ) -> function a b c)
        testCases


viewSection : (a -> Html msg) -> String -> List a -> Html msg
viewSection view title content =
    Html.div []
        [ Html.h2 [] [ Html.text title ]
        , content
            |> List.map view
            |> Html.div []
        ]


viewExampleSection : String -> List Example -> Html Never
viewExampleSection title examples =
    if List.all isFinished examples then
        Html.span
            [ Html.Attributes.class "title-font"
            , Html.Attributes.style "background-color" Style.successColor
            , Html.Attributes.style "padding" "4px"
            , Html.Attributes.style "margin" "4px"
            ]
            [ Html.text successEmoji
            , Html.text " "
            , Html.text title
            ]

    else
        viewSection viewExample title examples
