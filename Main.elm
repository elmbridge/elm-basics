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


formatPhoneNumber : String -> String -> String -> String
formatPhoneNumber areaCode exchange local =
    "(" ++ areaCode ++ ") " ++ exchange ++ "-" ++ local


initials : String -> String -> String
initials firstName lastName =
    (String.left 1 firstName) ++ (String.left 1 lastName)


pigLatin : String -> String
pigLatin word =
    (String.toUpper <| String.slice 1 2 word)
        ++ (String.dropLeft 2 word)
        ++ "-"
        ++ (String.toLower <| String.left 1 word)
        ++ "ay"


mathExample1 =
    -- TODO: calculate the square root of 20.25
    0



--
-- Lists
--


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
-- Records
--


createPoint x y =
    { x = x, y = y }


grandmotherNames person =
    [ person.father.mother.name
    , person.mother.mother.name
    ]


tradePlaces a b =
    ( { a | location = b.location }
    , { b | location = a.location }
    )



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
        , viewFunctionExample3 "formatPhoneNumber"
            formatPhoneNumber
            [ ( ( "347", "489", "4608" ), "(347) 489-4608" )
            , ( ( "800", "555", "2368" ), "(800) 555-2368" )
            ]
        , viewFunctionExample2 "initials"
            initials
            [ ( ( "Ada", "Lovelace" ), "AL" )
            , ( ( "Kimberlé", "Crenshaw" ), "KC" )
            , ( ( "Grace", "Hopper" ), "GH" )
            ]
        , viewFunctionExample1 "pigLatin"
            pigLatin
            [ ( "Pig", "Ig-pay" )
            , ( "Latin", "Atin-lay" )
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
        , viewUntypedExample "createPoint"
            (createPoint 4 2)
            "{ x = 4, y = 2 }"
        , viewUntypedExample "grandmotherNames"
            (grandmotherNames
                { name = "Lisa Simpson"
                , mother =
                    { name = "Marge Bouvier Simpson"
                    , mother = { name = "Jackie Gurney Bouvier" }
                    , father = { name = "Clancy Bouvier" }
                    }
                , father =
                    { name = "Homer Simpson"
                    , mother = { name = "Mona Olsen" }
                    , father = { name = "Abraham Simpson" }
                    }
                }
            )
            (toString [ "Mona Olsen", "Jackie Gurney Bouvier" ])
        , viewUntypedExample "tradePlaces"
            (tradePlaces
                { description = "clean towels"
                , location = "Laundry room"
                }
                { description = "dirty towels"
                , location = "Kitchen"
                }
            )
            (toString
                ( { description = "clean towels"
                  , location = "Kitchen"
                  }
                , { description = "dirty towels"
                  , location = "Laundry room"
                  }
                )
            )
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
    Html.div []
        [ Html.em [] [ Html.text name ]
        , Html.text " : "
        , viewAssertion ((toString actual) == expected)
            (toString actual)
            expected
        ]


viewTypedExample : String -> value -> value -> Html Never
viewTypedExample name actual expected =
    Html.div []
        [ Html.em [] [ Html.text name ]
        , Html.text " : "
        , viewAssertion (actual == expected)
            (toString actual)
            (toString expected)
        ]


viewAssertion : Bool -> String -> String -> Html Never
viewAssertion isCorrect actual expected =
    Html.span []
        [ Html.span
            [ Html.Attributes.style
                [ ( "padding", "6px" )
                ]
            ]
            [ Html.text "Expected: "
            , Html.text expected
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
            , Html.text actual
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
            let
                actual =
                    (function arg1)
            in
                Html.div []
                    [ viewAssertion (actual == expected)
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
            [ Html.em [] [ Html.text name ]
            , Html.text " : "
            , Html.div [] (showTestCases [] testCases)
            ]


viewFunctionExample2 : String -> (a -> b -> value) -> List ( ( a, b ), value ) -> Html Never
viewFunctionExample2 name function testCases =
    viewFunctionExample1 name (\( a, b ) -> function a b) testCases


viewFunctionExample3 : String -> (a -> b -> c -> value) -> List ( ( a, b, c ), value ) -> Html Never
viewFunctionExample3 name function testCases =
    viewFunctionExample1 name (\( a, b, c ) -> function a b c) testCases
