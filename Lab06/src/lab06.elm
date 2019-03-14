import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { left : String,
     right : String
  }


init : Model
init =
  { left = "" ,
   right = ""}



-- UPDATE


type Msg
  = Left String
  | Right String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Left newLeft ->
      { model | left = newLeft}
    Right newLeft ->
      { model | right = newLeft}



-- VIEW


view : Model -> Html Msg
view model =
  div [] [
  input [ placeholder "left text" , value model.left , onInput Left][]

  ,input [ placeholder "right text" , value model.right, onInput Right] []
  , div[] [text  model.left, text "\t\t\t : \t\t\t",
  text model.right]
    ]
    
