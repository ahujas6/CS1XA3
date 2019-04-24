import Browser
import Browser.Navigation exposing (Key(..))
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Url
import Html.Events exposing (..)
import Http exposing (..)
import Random exposing (generate)
import Basics exposing (..)


type State = Home | Bubble | Overbub  --states of game


type alias Model =
    { gamestate : State                              --model
    , points : Float
    , positionx : Int
    , positiony : Int
    , timer : Int
    , sizep : Int
    , fun : Float
    , positionx2 : Int
    , positiony2 : Int  
   
    ,pointm : Int

    }

init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
     ({gamestate = Home
     , points=0.0
     , positionx=0
     ,positiony =0 
     ,sizep = 2
     , timer = 0                                       -- initial value of model variables
     , fun =-100.0
     , positionx2=0
     ,positiony2 =0 
     , pointm =0
    
     }, Cmd.none)

type Msg                                             -- funtions 
    = Tick Float GetKeyState
    | Randomx Int
    | Randomy Int
    | MakeRequest Browser.UrlRequest
    | UrlChange Url.Url
    | Click
    | Opt
    | Randoms Int
    | Randomx2 Int
    | Randomy2 Int





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

random_xgen = Random.int -140 140                               -- random x value  for ball 1
ranx= Random.generate Randomx random_xgen                 

random_ygen = Random.int -140 140                                -- random y value for ball 1
rany =Random.generate Randomy random_xgen

random_sgen = Random.int 5 10                                    -- random size value maker
rans =Random.generate Randoms random_sgen

random_xhgen = Random.int -140 140                               -- random x value for ball 2
ranxh= Random.generate Randomx2 random_xhgen

random_yhgen = Random.int -140 140                                      -- random y value for ball y
ranyh =Random.generate Randomy2 random_yhgen



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case model.gamestate of
        Home ->                                               -- home state
            case msg of
                MakeRequest req ->
                    ( model, Cmd.none ) 

                UrlChange url ->
                    ( model, Cmd.none ) 

                Tick time getKeyState ->    
                    if model.fun ==180 || model.fun == -180 then ( {model | timer=0, fun = -model.fun+1  }, Cmd.none ) else
                    ( {model | timer=0, fun = model.fun+1  }, ranx )                                                             -- changes a variable to move yellow balls
            
                Randomx rx ->                                            -- gives positionx random value
                    ( {model | positionx = rx }, rany )
                Randomy ry -> 
                    ( {model | positiony = ry }, Cmd.none )                        -- gives positiony random value

                Randomy2 _ -> 
                    ( model, Cmd.none )
                Randomx2 _ -> 
                    ( model, Cmd.none )
      
                Randoms _ -> 
                    ( model, Cmd.none )
                Click -> (model , Cmd.none)
                
                Opt -> ({ model | gamestate = Bubble , points =0 } , Cmd.none )            -- change gamestate to bubble to play
    
        Overbub ->                                                 -- game over state
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
                Randomy2 _ -> 
                    ( model, Cmd.none )
                Randomx2 _ -> 
                    ( model, Cmd.none )

                Click -> (model , Cmd.none)
                
                Opt -> ({ model | gamestate = Home } , Cmd.none )             -- a back button that takes back to home

  
    
        Bubble ->                   -- play game state
            case msg of
                MakeRequest req ->
                    ( model, Cmd.none ) 

                UrlChange url ->
                    ( model, Cmd.none ) 

                Tick time getKeyState ->                                             --increase value of timer and ends game if it reaches 3000
                   if    (modBy 34 model.timer  == 0)  then if model.timer>3000 then ({ model | gamestate = Overbub }, Cmd.none) else
                        ( { model |  timer = model.timer +1} , ranx) 
                   else if model.timer>3000 then ({ model | gamestate = Overbub}, Cmd.none) else  ({ model |  timer = model.timer +1}, Cmd.none)
            
                Randomx rx ->                               --gives random x values to ball 1
                    ( {model | positionx = rx }, rany )

                Randomy ry ->                                     --gives random x values to ball 1
                    ( {model | positiony = ry },  rans)
                Randoms  rs->                                             --gives random size values to balls
                    ( {model | sizep = rs }, ranxh )
                Randomx2 x2 ->                                               --gives random x values to ball 2
                    ( {model | positionx2 = x2 }, ranyh )
                Randomy2 y2 ->                                                    --gives random y values to ball 1
                    ( {model | positiony2 = y2 }, Cmd.none)
       

                Click -> ({ model | points= model.points + (10/(toFloat  model.sizep)) } , Cmd.none)
                
                Opt -> ({ model | gamestate = Home } , Cmd.none )
            
    





view : Model -> { title : String, body : Collage Msg }
view model = 
    case model.gamestate of                  
        Home ->                                            -- home screen
            let bodymain = Collage 500 500 [ group [ text "GameHub" |> size 40 |> filled black |> move (0,210) 
                            , circle 7 |> filled red |> move (-10,215)
                            , circle 10 |> filled yellow |> move (-35,215)
                            , circle 13 |> filled lightBlue |> move (-69,215)
                            , circle 16 |> filled orange |> move (-106,217)
                            ,roundedRect 450 400 3 |> filled white |> addOutline (solid 2) black                          
                              , notifyTap Opt (circle 50   |> filled blue |> addOutline (solid 2) red |> rotate 60 |> move  (0, 30))        -- game start button
                              
                              ,text " Click me!!" |> size 16 |> filled white |> move (-34,27)
                              , text "point " |> size 16 |> filled blue |> move (160,130)
                              , text (String.fromFloat  model.points) |> size 14 |> filled darkBlue |> move (170,150)   
                              , circle 7 |>  filled blue |> move (toFloat  model.positionx, toFloat  model.positiony)
                              , circle 20  |> filled yellow |> addOutline (solid 2) black |> move (-150+ 30*sin(0.27*model.fun),model.fun)
                              , circle 20  |> filled yellow |> addOutline (solid 2) black |> move (model.fun,-100 + 30*sin(0.27*model.fun) )  
                                          ]]
            in { title = "main", body = bodymain }
            

        Overbub ->     -- game over screen
            let bodymain = Collage 500 500 [ group [ text "GameHub" |> size 40 |> filled black |> move (0,210)
            
                              , circle 7 |> filled red |> move (-10,215)
                              , circle 10 |> filled yellow |> move (-35,215)
                              , circle 13 |> filled lightBlue |> move (-69,215)
                              , circle 16 |> filled orange |> move (-106,217)
                              ,roundedRect 450 400 3 |> filled white |> addOutline (solid 2) black  
                              , notifyTap Opt (circle 50  |> filled blue |> addOutline (solid 2) black |> move (-80, 30))     --takes back to home screen
                              , text "Game over" |> size 30 |> filled red |> move (0,30)
                              ,text "home" |> size 20 |> filled white |> move (-100,30)
                              , text "point " |> size 16 |> filled blue |> move (170,130)
                              , text (String.fromFloat  model.points) |> size 14 |> filled darkBlue |> move (170,150)  
                                                         ]]
            in { title = "main", body = bodymain }

        Bubble ->                       -- game play screen
            let
                bodygame = Collage 500 500 [group [ text "GameHub" |> size 20 |> filled black |> move (0,190) 
                              , (rect 300 300 |> filled white |> addOutline (solid 2) black)
                              , notifyTap Opt (circle 5  |> filled red |> addOutline (solid 2) black |> move (170,190))      -- takes back to home
                              , text "point " |> size 16 |> filled blue |> move (170,130)
                              , text (String.fromFloat  model.points) |> size 14 |> filled darkBlue |> move (170,150)
                              , text (String.fromFloat (toFloat model.timer)) |> size 14 |> filled darkBlue |> move (-100,190) 
                              
                              , notifyEnter Click (circle (toFloat  model.sizep)  |> filled darkOrange  |> move (toFloat  model.positionx2, toFloat model.positiony2))             -- gives points when someone enters orange ball

                              , notifyEnter Click (circle (toFloat  model.sizep)  |> filled green  |> move (toFloat  model.positionx, toFloat model.positiony)) ]]                       -- gives points when someone enters green ball
            in { title = "game", body = bodygame }
            
            

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
