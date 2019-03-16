
import Browser
import Html exposing (..)
import Http
import Html.Attributes exposing (..)
import String
import Html.Events exposing (onClick , onInput)

main =
 Browser.element
     { init = init
     , update = update
     , subscriptions = subscriptions
     , view = view
     }

type alias Model =
    { response : String , name : String ,  password : String }

type Msg
     = GotText (Result Http.Error String)
     | Name String
     | Password  String
     | Match 


post : Model -> Cmd Msg
post model =
  Http.post
    { url = "https://mac1xa3.ca/e/ahujas6/lab7/"
    , body = Http.stringBody "application/x-www-form-urlencoded"("name=" ++ model.name ++ "&password=" ++ model.password)
    , expect = Http.expectString GotText
    }
init : () -> ( Model, Cmd Msg )
init _ =
 ( Model "" "" "" , Cmd.none )


view : Model -> Html Msg
view model =
    div [] [ text model.response , div [] [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password, button [onClick Match] [ text "submit"] ]]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Name name -> ({ model | name = name}, Cmd.none)
        Password password -> ({ model | password = password},Cmd.none)

        Match -> (model ,post model)
        GotText result ->
            case result of
                Ok val ->
                    ( { model | response = val }, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )

handleError model error =
    case error of
        Http.BadUrl url ->
            { model | response = "bad url: " ++ url }
        Http.Timeout ->
            { model | response = "timeout" }
        Http.NetworkError ->
            { model | response = "network error" }
        Http.BadStatus i ->
            { model | response = "bad status " ++ String.fromInt i }
        Http.BadBody body ->
            { model | response = "bad body " ++ body }



viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
