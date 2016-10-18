module ExerciseRunner exposing (..)

--
-- There's no need to look in this file (unless you are curious).
-- All the work you need to do will be done in Main.elm
--

import Color exposing (Color)
import Html exposing (Html)
import Html.Attributes
import String
import Style exposing (..)


outputLabel : String -> Html msg
outputLabel label =
    Html.div
        [ Html.Attributes.style
            [ ( "font-size", "12px" )
            , ( "opacity", "0.4" )
            ]
        ]
        [ Html.text label ]


fontStyles : Html msg
fontStyles =
    Html.div []
        [ Html.node "link"
            [ Html.Attributes.href "http://fonts.googleapis.com/css?family=Lobster"
            , Html.Attributes.rel "stylesheet"
            , Html.Attributes.type' "text/css"
            ]
            []
        , Html.node "link"
            [ Html.Attributes.href "http://fonts.googleapis.com/css?family=Cabin"
            , Html.Attributes.rel "stylesheet"
            , Html.Attributes.type' "text/css"
            ]
            []
        , Html.node "style" [] [ Html.text """
h1, h2 { font-family: 'Lobster', Georgia, Times, serif; }
h1 { font-size: 90px; line-height: 100px; border-bottom: 3px solid black; }
h2 { font-size: 70px; line-height: 100px; }

body {
font-family: 'Cabin', Helvetica, Arial, sans-serif;
font-size: 15px;
line-height: 25px;
}
""" ]
        ]


viewAssertion : Bool -> String -> String -> String -> Html Never
viewAssertion isCorrect call actual expected =
    if isCorrect then
        Html.div
            [ Html.Attributes.style
                [ ( "margin-left", "32px" )
                , ( "background-color", colorToCssString successColor )
                ]
            ]
            [ Html.span
                [ Html.Attributes.style
                    [ ( "padding", "4px" )
                    , ( "margin", "8px" )
                    ]
                ]
                [ Html.text successEmoji ]
            , inlineCode call
            , Html.text " == "
            , Html.text actual
            ]
    else
        Html.div
            [ Html.Attributes.style
                [ ( "margin-left", "32px" )
                ]
            ]
            [ outputLabel "Your implementation:"
            , Html.div
                [ Html.Attributes.style
                    [ ( "background-color", colorToCssString keepWorkingColor )
                    ]
                ]
                [ Html.span
                    [ Html.Attributes.style
                        [ ( "padding", "4px" )
                        , ( "margin", "8px" )
                        ]
                    ]
                    [ Html.text keepWorkingEmoji ]
                , inlineCode call
                , Html.text " == "
                , Html.text actual
                ]
            , outputLabel "Expected:"
            , Html.div
                [ Html.Attributes.style
                    [ ( "background-color", colorToCssString Color.gray )
                    ]
                ]
                [ Html.span
                    [ Html.Attributes.style
                        [ ( "padding", "4px" )
                        , ( "margin", "8px" )
                        , ( "opacity", "0" )
                        ]
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
        [ Html.Attributes.style
            [ ( "display", "inline-block" )
            , ( "background-color", "rgba(238, 238, 238, 0.7)" )
            , ( "padding", "4px" )
            , ( "margin", "0" )
            , ( "font-family", "monospace" )
            , ( "whitespace", "pre" )
            ]
        ]
        [ Html.text code ]


colorToCssString : Color -> String
colorToCssString color =
    let
        components =
            Color.toRgb color
    in
        String.concat
            [ "rgb("
            , toString components.red
            , ","
            , toString components.green
            , ","
            , toString components.blue
            , ")"
            ]


viewFunctionExampleN : (a -> String) -> String -> (a -> value) -> List ( a, value ) -> Html Never
viewFunctionExampleN argsToString name function testCases =
    let
        showTestCase ( arg1, expected ) =
            let
                actual =
                    (function arg1)
            in
                Html.div []
                    [ viewAssertion (actual == expected)
                        (name ++ " " ++ argsToString arg1)
                        (toString actual)
                        (toString expected)
                    ]

        showTestCases results remainingTestCases =
            case remainingTestCases of
                [] ->
                    List.reverse results

                ( arg1, expected ) :: rest ->
                    let
                        showMore =
                            (function arg1 == expected)
                    in
                        showTestCases (showTestCase ( arg1, expected ) :: results)
                            (if showMore then
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


viewFunctionExample1 : String -> (a -> value) -> List ( a, value ) -> Html Never
viewFunctionExample1 =
    viewFunctionExampleN toString


viewFunctionExample2 : String -> (a -> b -> value) -> List ( ( a, b ), value ) -> Html Never
viewFunctionExample2 name function testCases =
    viewFunctionExampleN
        (\( a, b ) -> toString a ++ " " ++ toString b)
        name
        (\( a, b ) -> function a b)
        testCases


viewUntypedFunctionExample2 : String -> (a -> b -> value) -> List ( ( a, b ), String ) -> Html Never
viewUntypedFunctionExample2 name function testCases =
    viewFunctionExampleN
        (\( a, b ) -> toString a ++ " " ++ toString b)
        name
        (\( a, b ) -> toString (function a b))
        testCases


viewFunctionExample3 : String -> (a -> b -> c -> value) -> List ( ( a, b, c ), value ) -> Html Never
viewFunctionExample3 name function testCases =
    viewFunctionExampleN
        (\( a, b, c ) -> toString a ++ " " ++ toString b ++ " " ++ toString c)
        name
        (\( a, b, c ) -> function a b c)
        testCases
