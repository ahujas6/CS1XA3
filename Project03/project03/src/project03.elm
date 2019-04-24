import Browser
import Browser.Navigation exposing (Key(..))
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Url
import Html.Events exposing (..)
import Http exposing (..)
import Random exposing (generate)
import Basics exposing (..)


type State = Home | Bubble | Overbub 


type alias Model =
    { gamestate : State
    , points : Float
    , positionx : Int
    , positiony : Int
    , timer : Int
    , sizep : Int
    , fun : Float
   
    ,pointm : Int

    }

init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
     ({gamestate = Home
     , points=0.0
     , positionx=0
     ,positiony =0 
     ,sizep = 2
     , timer = 0
     , fun =-100.0
    
     , pointm =0
     }, Cmd.none)

type Msg
    = Tick Float GetKeyState
    | Randomx Int
    | Randomy Int
    | MakeRequest Browser.UrlRequest
    | UrlChange Url.Url
    | Click
    | Opt
    | Randoms Int
  




main : AppWithTick () Model Msg
main =
    appWithTick Tick
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = MakeRequest
        , onUrlChange = UrlChange
        }

random_xgen = Random.int -140 140
ranx= Random.generate Randomx random_xgen
random_ygen = Random.int -140 140
rany =Random.generate Randomy random_xgen

random_sgen = Random.int 5 10
rans =Random.generate Randoms random_sgen



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case model.gamestate of
        Home ->
            case msg of
                MakeRequest req ->
                    ( model, Cmd.none ) 

                UrlChange url ->
                    ( model, Cmd.none ) 

                Tick time getKeyState ->
                    if model.fun ==200 || model.fun == -200 then ( {model | timer=0, fun = -model.fun+1  }, Cmd.none ) else
                    ( {model | timer=0, fun = model.fun+1  }, Cmd.none )
            
                Randomx _ -> 
                    ( model, Cmd.none )

                Randomy _ -> 
                    ( model, Cmd.none )
                Randoms _ -> 
                    ( model, Cmd.none )
                Click -> (model , Cmd.none)
                Opt -> ({ model | gamestate = Bubble } , Cmd.none )
    
        Overbub ->
            case msg of
                MakeRequest req ->
                    ( model, Cmd.none ) 

                UrlChange url ->
                    ( model, Cmd.none ) 

                Tick time getKeyState ->
                    ( {model | timer =0}, Cmd.none )
            
                Randomx _ -> 
                    ( model, Cmd.none )

                Randomy _ -> 
                    ( model, Cmd.none )
                Randoms _ -> 
                    ( model, Cmd.none )
                Click -> (model , Cmd.none)
                Opt -> ({ model | gamestate = Home } , Cmd.none )

  
    
        Bubble ->
            case msg of
                MakeRequest req ->
                    ( model, Cmd.none ) 

                UrlChange url ->
                    ( model, Cmd.none ) 

                Tick time getKeyState -> 
                   if    (modBy 34 model.timer  == 0)  then if model.timer>3000 then ({ model | gamestate = Overbub}, Cmd.none) else
                        ( { model |  timer = model.timer +1} , ranx) 
                   else if model.timer>3000 then ({ model | gamestate = Overbub}, Cmd.none) else  ({ model |  timer = model.timer +1}, Cmd.none)
            
                Randomx rx -> 
                    ( {model | positionx = rx }, rany )

                Randomy ry -> 
                    ( {model | positiony = ry },  rans)
                Randoms  rs-> 
                    ( {model | sizep = rs }, Cmd.none )
                Click -> ({ model | points= model.points + (10/(toFloat  model.sizep)) } , Cmd.none)
                Opt -> ({ model | gamestate = Home } , Cmd.none )
            
    





view : Model -> { title : String, body : Collage Msg }
view model = 
    case model.gamestate of
        Home -> 
            let bodymain = Collage 500 500 [ group [ text "GameHub" |> size 40 |> filled black |> move (0,70) 
                              , notifyTap Opt (square 80   |> filled blue |> addOutline (solid 2) red |> rotate model.fun |> move  (-80, 30))
                              ,text "bubble pop" |> size 16 |> filled black |> move (-110,27)
                              , text "point " |> size 16 |> filled blue |> move (170,130)
                              , text (String.fromFloat  model.points) |> size 14 |> filled darkBlue |> move (180,150)   
                           
                              , circle 50  |> filled yellow |> addOutline (solid 2) black |> move (model.fun,-100 + 30*sin(0.27*model.fun) )  
                              , text  "welcome" |> size 16  |> filled darkRed  |> move (model.fun-20,-100 + 30*sin(0.27*model.fun))                  ]]
            in { title = "main", body = bodymain }
            

        Overbub -> 
            let bodymain = Collage 500 500 [ group [ text "GameHub" |> size 40 |> filled black |> move (0,70)

                              , notifyTap Opt (circle 50  |> filled blue |> addOutline (solid 2) black |> move (-80, 30))
                              , text "Game over" |> size 30 |> filled red |> move (0,30)
                              ,text "home" |> size 10 |> filled black |> move (-100,30)
                              , text "point " |> size 16 |> filled blue |> move (170,130)
                              , text (String.fromFloat  model.points) |> size 14 |> filled darkBlue |> move (170,150)                               ]]
            in { title = "main", body = bodymain }

        Bubble ->
            let
                bodygame = Collage 500 500 [group [ text "GameHub" |> size 20 |> filled black |> move (0,190) 
                              , (rect 300 300 |> filled white |> addOutline (solid 2) black)
                              , notifyTap Opt (circle 5  |> filled red |> addOutline (solid 2) black |> move (170,190))
                              , text "point " |> size 16 |> filled blue |> move (170,130)
                              , text (String.fromFloat  model.points) |> size 14 |> filled darkBlue |> move (170,150)
                              , text (String.fromFloat (toFloat model.timer)) |> size 14 |> filled darkBlue |> move (-100,190)                              
                              , notifyEnter Click (circle (toFloat  model.sizep)  |> filled green  |> move (toFloat  model.positionx, toFloat model.positiony)) ]]
            in { title = "game", body = bodygame }
            
            

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none