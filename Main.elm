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
--
-- Strings and Numbers
--


sayHello : String -> String
sayHello friendsName =
    "TODO: implement me"


formatPhoneNumber : String -> String -> String -> String
formatPhoneNumber areaCode exchange local =
    "TODO: implement me"


initials : String -> String -> String
initials firstName lastName =
    -- HINT: look at http://package.elm-lang.org/packages/elm-lang/core/latest/String for useful functions
    "TODO: implement me"


pigLatin : String -> String
pigLatin word =
    "TODO: implement me"



--
-- If Statements
--


isGreaterThanTen : Int -> Bool
isGreaterThanTen x =
    -- TODO: implement me
    False


howHotIsThePepper : Float -> String
howHotIsThePepper heatUnits =
    "TODO: implement me"



--
-- Lists
--


reverseTheList : List a -> List a
reverseTheList inputList =
    -- TODO: return the reversed inputList
    -- HINT: look at http://package.elm-lang.org/packages/elm-lang/core/latest/List for useful functions
    []


addOne : List Int -> List Int
addOne inputList =
    -- TODO: add one to every item in the list
    []


removeOs : List String -> List String
removeOs inputList =
    -- TODO: remove all entries that start with "O"
    []



--
-- Records
--


createPoint x y =
    "TODO: implement me"


grandmotherNames person =
    -- "Hint: take a stab in the dark and see what the error message can tell you"
    "TODO: implement me"


tradePlaces a b =
    "TODO: implement me"



--
-- Tuples
--


signAndMagnitude : Int -> ( String, Int )
signAndMagnitude x =
    -- TODO: implement me
    ( "TODO", 0 )



--
-- No need to look below this line (unless you are curious)
--


main : Html Never
main =
    Html.div [ Html.Attributes.style [ ( "padding", "20px" ) ] ]
        [ fontStyles
        , Html.h2 [] [ Html.text "Strings and Numbers" ]
        , viewFunctionExample1 "sayHello"
            sayHello
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
            [ ( ( "Ada", "Yonath" ), "AY" )
            , ( ( "Kimberlé", "Crenshaw" ), "KC" )
            , ( ( "Dorothy", "Hodgkin" ), "DH" )
            ]
        , viewFunctionExample1 "pigLatin"
            pigLatin
            [ ( "Pig", "Ig-pay" )
            , ( "Latin", "Atin-lay" )
            ]
        , Html.h2 [] [ Html.text "If Statements" ]
        , viewFunctionExample1 "isGreaterThanTen"
            isGreaterThanTen
            [ ( 13, True )
            , ( 3, False )
            , ( 10, False )
            ]
        , viewFunctionExample1 "howHotIsThePepper"
            howHotIsThePepper
            [ ( 2, "not hot" )
            , ( 100, "mild" )
            , ( 3000, "medium" )
            , ( 50000, "hot" )
            ]
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
        , viewFunctionExample1 "signAndMagnitude"
            signAndMagnitude
            [ ( -7, ( "-", 7 ) )
            , ( 3, ( "+", 3 ) )
            , ( 10, ( "+", 10 ) )
            , ( -44, ( "-", 44 ) )
            ]
        , Html.h2 [] [ Html.text "Case statements" ]
        , Html.h2 [] [ Html.text "HTML" ]
        , Html.h1 [] [ Html.text "Bonus" ]
        , Html.h2 [] [ Html.text "Union types" ]
        , Html.h2 [] [ Html.text "Maybes" ]
        , Html.h2 [] [ Html.text "Complex case statements" ]
        , Html.h2 [] [ Html.text "Dictionaries" ]
        ]


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
h2 {
font-family: 'Lobster', Georgia, Times, serif;
font-size: 70px;
line-height: 100px;
}

body {
font-family: 'Cabin', Helvetica, Arial, sans-serif;
font-size: 15px;
line-height: 25px;
}
""" ]
        ]


viewUntypedExample : String -> value -> String -> Html Never
viewUntypedExample name actual expected =
    Html.div []
        [ goalHeading name
        , viewAssertion ((toString actual) == expected)
            (name)
            (toString actual)
            expected
        ]


viewTypedExample : String -> value -> value -> Html Never
viewTypedExample name actual expected =
    Html.div []
        [ goalHeading name
        , viewAssertion (actual == expected)
            (name)
            (toString actual)
            (toString expected)
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
    Html.pre
        [ Html.Attributes.style
            [ ( "display", "inline-block" )
            , ( "background-color", "rgba(238, 238, 238, 0.7)" )
            , ( "padding", "4px" )
            , ( "margin", "0" )
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


viewFunctionExample1 : String -> (a -> value) -> List ( a, value ) -> Html Never
viewFunctionExample1 =
    viewFunctionExampleN toString


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


viewFunctionExample2 : String -> (a -> b -> value) -> List ( ( a, b ), value ) -> Html Never
viewFunctionExample2 name function testCases =
    viewFunctionExampleN
        (\( a, b ) -> toString a ++ " " ++ toString b)
        name
        (\( a, b ) -> function a b)
        testCases


viewFunctionExample3 : String -> (a -> b -> c -> value) -> List ( ( a, b, c ), value ) -> Html Never
viewFunctionExample3 name function testCases =
    viewFunctionExampleN
        (\( a, b, c ) -> toString a ++ " " ++ toString b ++ " " ++ toString c)
        name
        (\( a, b, c ) -> function a b c)
        testCases
