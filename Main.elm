module Main exposing (..)

import Color exposing (Color)
import Html exposing (Html)
import Html.Attributes
import String


--
-- Customize your emoji and colors
--


successEmoji =
    "💖"


successColor =
    Color.green


keepWorkingEmoji =
    "🚧"


keepWorkingColor =
    Color.yellow



--
-- Now the work begins:
--


stringExample1 =
    ""


stringExample2 friendsName =
    -- TODO: say hello to the friend
    ""


mathExample1 =
    -- TODO: calculate the square root of 20.25
    0


reverseTheList inputList =
    -- TODO: return the reversed inputList
    -- HINT: look at http://package.elm-lang.org/packages/elm-lang/core/latest/List for useful functions
    []


addOne inputList =
    -- TODO: add one to every item in the list
    []


removeOs inputList =
    -- TODO: remove all entries that start with "O"
    []



--
-- No need to look below this line (unless you are curious)
--


main : Html Never
main =
    Html.div [ Html.Attributes.style [ ( "padding", "20px" ) ] ]
        [ Html.h2 [] [ Html.text "Strings and Numbers" ]
        , viewTypedExample "stringExample1" stringExample1 "Hello World"
        , viewFunctionExample1 "stringExample2"
            stringExample2
            [ ( "Jasmine", "Hello, Jasmine" )
            , ( "Jean", "Hello, Jean" )
            ]
        , Html.h2 [] [ Html.text "Math" ]
        , viewTypedExample "mathExample1" mathExample1 4.5
        , Html.h2 [] [ Html.text "Functions" ]
        , Html.h2 [] [ Html.text "Lists" ]
        , viewFunctionExample1 "reverseTheList"
            reverseTheList
            [ ( [ 7, 0, 1, 4, 9 ], [ 9, 4, 1, 0, 7 ] )
            , ( [ 99, -1 ], [ -1, 99 ] )
            ]
        , viewFunctionExample1 "addOne"
            addOne
            [ ( [ 7, 0, 1, 4, 9 ], [ 8, 1, 2, 5, 10 ] )
            , ( [ 99, -1 ], [ 100, 0 ] )
            ]
        , viewFunctionExample1 "removeOs"
            removeOs
            [ ( [ "Jessie", "Anibus", "Osirus" ], [ "Jessie", "Anibus" ] )
            , ( [ "Apple", "Banana" ], [ "Apple", "Banana" ] )
            , ( [ "Octothorpe", "Octohash" ], [] )
            ]
        , Html.h2 [] [ Html.text "Records" ]
        , Html.h2 [] [ Html.text "Tuples" ]
        , Html.h2 [] [ Html.text "Case statements" ]
        , Html.h2 [] [ Html.text "HTML" ]
        , Html.h1 [] [ Html.text "Bonus" ]
        , Html.h2 [] [ Html.text "Union types" ]
        , Html.h2 [] [ Html.text "Maybes" ]
        , Html.h2 [] [ Html.text "Complex case statements" ]
        , Html.h2 [] [ Html.text "Dictionaries" ]
        ]


viewUntypedExample : String -> value -> String -> Html Never
viewUntypedExample name actual expected =
    viewTypedExample name (toString actual) expected


viewTypedExample : String -> value -> value -> Html Never
viewTypedExample name actual expected =
    Html.div []
        [ Html.em [] [ Html.text name ]
        , Html.text " : "
        , viewAssertion actual expected
        ]


viewAssertion : a -> a -> Html Never
viewAssertion actual expected =
    let
        isCorrect =
            (actual == expected)
    in
        Html.span []
            [ Html.span
                [ Html.Attributes.style
                    [ ( "padding", "6px" )
                    ]
                ]
                [ Html.text "Expected: "
                , Html.text (toString expected)
                ]
            , Html.span
                [ Html.Attributes.style
                    [ ( "background-color"
                      , if isCorrect then
                            colorToCssString successColor
                        else
                            colorToCssString keepWorkingColor
                      )
                    , ( "padding", "6px" )
                    ]
                ]
                [ Html.text "Your result: "
                , Html.text (toString actual)
                , Html.text " "
                , if isCorrect then
                    Html.text successEmoji
                  else
                    Html.text keepWorkingEmoji
                ]
            ]


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


viewFunctionExample1 : String -> (a -> value) -> List ( a, value ) -> Html Never
viewFunctionExample1 name function testCases =
    let
        showTestCase ( arg1, expected ) =
            Html.div [] [ viewAssertion (function arg1) expected ]

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
            [ Html.em [] [ Html.text name ]
            , Html.text " : "
            , Html.div [] (showTestCases [] testCases)
            ]
