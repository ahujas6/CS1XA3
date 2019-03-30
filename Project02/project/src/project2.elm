import Browser
import Html exposing (Html, Attribute, div, input, text, button, h1)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput,onClick)
import Basics exposing (..)
import Array exposing (..)
import Random.List exposing (shuffle)
import List exposing (..)
import Tuple exposing (..)
import Dict exposing (Dict)


main=Browser.sandbox
     {init=init 
     , update =update 
     
     , view = view
     }

chemlist =[["One of the essential minerals in the human body is salt. How much salt (NaCl) is in the average adult human body?","250g","1kg","100g","750g"],["If you fill a glass to the brim with ice water and the ice melts, what will happen?","The water level will drop slightly as the ice melts.","The glass will over flow as the ice turns to water","The level of water in the glass will remain unchanged as the ice melts","I'll never find out because I'll drink the water or walk away before anything happens."],[" The symbol Sb stands for stibnum or stibnite. What is the modern name of this element?","Antimony","Tin","Arsenic","Samarium"],[" DNA codes for proteins, which are the building blocks of organisms. What is the most abundant protein in the human body?","Collagen","Keratin","Tubulin","Albumin"],["Noble gases are inert because they have completed outer electron shells. Which of these elements isn't a noble gas?","Chlorine","Helium","Argon","Krypton"],["What is the most common isotope of hydrogen?","Protium","Deuterium","Tritum","Hydrogen only has one isotope!"],[" You can't live without water! What is its chemical formula?","H2O","O2","H2","H2O2"],[" Who is credited with the invention of the modern periodic table?","Mendeleev","Nobel","Lavoisier","Mendel"],[" Which of these elements is a nonmetal?","Sulfur","Manganese","Aluminum","Beryllium"],["  The symbol Ag stands for which element?","Silver","Gallium","Magnesium","Gold"]]


plist=[["which is the 1st marvel movie?","Ironman","Thor","Hulk","Captain America : First Avenger"],["who said? -I have lived most of my life surrounded by my enemies. I would be grateful to die surrounded by my friends.","GAMORA","DRAX","BLACK WIDOW","LOKI"],["who said? -Do not mistake my appetite for apathy!","VOLSTAGG","LOKI","DARCY LEWIS","BLACK WIDOW"],["What kind of food does Tony Stark suggest the Avengers eat after saving New York in 'The Avengers'?","SHAWARMA","PIZZA","BURRITO","FONDUE"],["What did Peggy Carter promise to Steve Rogers (Captain America) before he crashed Red Skull's bomber?","A DANCE","FONDUE","A KISS","A MISSION"],["The world will be his. The universe yours. And the humans, what can they do but burn?","THE OTHER","ALGRIM","NEBULA","THE OTHER","LOKI"],["What was Red Skull's real name?","JOHANN SCHMIDT","JOSEPH GOEBBELS","ARNIM ZOLA","JOHANNES WAGNER"],["WHO SAID? -As far as I'm concerned, that man's whole body is property of the U.S. army.","GENERAL 'THUNDERBOLT' ROSS","JAMES 'RHODEY' RHODES","SENATOR STERN","GENERAL 'THUNDERBOLT' ROSS","COLONEL PHILLIPS"],["Which two actors have played Howard Stark (Tony Stark's dad) in the Marvel Cinematic Universe?","JOHN SLATTERY & DOMINIC COOPER","DOMINIC COOPER & JEFF BRIDGES","SEBASTIAN STAN & DOMINIC COOPER","JOHN SLATTERY & SEBASTIAN STAN"],["What does Rhomann Dey call Star-Lord when he arrests him?","STAR-PRINCE","STAR-MAN","STAR-PRINCE","STAR-LORD","ASSHOLE"],["WHO SAID? -You know, for a crazy homeless person... he's pretty cut.","DARCY LEWIS","AGENT COULSON","DARCY LEWIS","JANE FOSTER","HAPPY HOGAN"],["WHO SAID? -You've been asleep, Cap. For almost 70 years","NICK FURY","MARIA HILL","PEGGY CARTER","AGENT COULSON"]]


complist=[["Which nail grows fastest?","middle","pinky","index","thumb"],["What temperature does water boil at?","100","75","105","99","100"],["When did the First World War start?","1914","1902","1916","1914","1918"],["What did Joseph Priesley discover in 1774?","oxygen","nitrogen","printer","typewriter"],["Where is the smallest bone in the body?","ear","thumb","nose","finger"],["What does the roman numeral C represent?","100","50","1000","500"],["How many dots are there on two dice","42","32","50","42","54"],["Who starts first in chess?","white","black","who challenges","who is challenged"],["What money do they use in Japan?","yen","rupee","japanese dollar","ryan"],["What year did Elvis Presley die?","1977","1978","1980","1968"],["What is the first letter on a typewriter?","Q","A","Z","Q","S"]]



mathlist=[["what is calue of sin(pi)","0","1","1/2","-1"],["what is 5th term of pi?","5","4","1","9"],["What is the ratio of the rate at which the volume of a spherical bubble of radius r increases to the rate its radius increases?","4*pi*r^2:1","2*pi :1","4*pi*(r^3)/3 :1","pir^2 :1","4*pi*r^2:1"],["If this follows 1,3,7,13,21,? What is missing?","31","27","29","33"],["whats the next number 1 1 2 3 5 8 13 ","21","19","17","20"],["whats next number 1 2 6 24 ","120","75","48","30"],["what is 1010 in decimal","10","5","11","9"],["if 4 6 = -210 , 5 4 = 19 , what does 7 9 =","-216","34","530","-532"],["whats the next number 1 4 27 ?","256","53","256","124","236"],["if 99 =0 , 79= -32 63 =27 then 42","12","30","20","6"]]


type State = Active | Home | Over

type alias Model =
  { gamestate : State
  
  
  , count : Int
  , score : Int
  , var1 :String
  , var2 :String
  , var3 :String
  , var4 :String
  , queslist : List (List String)
  ,question :String
  , answer : String
  }

init : Model
init =   { 
    gamestate = Home
  , score = 0
  , var1 =""
  , var2 =""
  , var3 =""
  , var4 =""
  , queslist =[[""]]
  ,question =""
  ,count=0
  ,answer =""

  }


type Msg =  Click1
          | Click2
          | Click3
          | Click4


update : Msg -> Model -> ( Model )
update msg model =

    case model.gamestate of
        Active ->
            case msg of
                Click1 ->
                    if (model.var1 == model.answer) && (model.count < 10) then 
                        let
                            newlist= Maybe.withDefault [] (get model.count (fromList  model.queslist))
                            newquestion= Maybe.withDefault "Error" (get 0 (fromList newlist))
                            newopt= (take 4 (reverse newlist ))
                            nvar1=Maybe.withDefault "var1" (get 0 (fromList newopt))
                            nvar2= Maybe.withDefault "var2" (get 1 (fromList newopt))
                            nvar3= Maybe.withDefault "var3" (get 2 (fromList newopt))
                            nvar4= Maybe.withDefault "var4" (get 3 (fromList newopt)) 
                            newans = Maybe.withDefault "Error" (get 1 (fromList newlist))
                            
                        in ({model |  var1 =nvar1 , var2 =nvar2 , var3 =nvar3, var4=nvar4, question=newquestion , count = model.count +1, answer =newans , score= model.score +1})
                   
                    else ({model | gamestate = Over})

                Click2 ->
                    if (model.var2 == model.answer) && (model.count< 10) then 
                        let
                            newlist= Maybe.withDefault [] (get model.count (fromList  model.queslist))
                            newquestion= Maybe.withDefault "Error" (get 0 (fromList newlist))
                            newopt= (take 4 (reverse newlist ))
                            nvar1=Maybe.withDefault "var1" (get 0 (fromList newopt))
                            nvar2= Maybe.withDefault "var2" (get 1 (fromList newopt))
                            nvar3= Maybe.withDefault "var3" (get 2 (fromList newopt))
                            nvar4= Maybe.withDefault "var4" (get 3 (fromList newopt)) 
                            newans = Maybe.withDefault "Error" (get 1 (fromList newlist))
                            
                        in ({model |  var1 =nvar1 , var2 =nvar2 , var3 =nvar3, var4=nvar4, question=newquestion , count = model.count +1, answer =newans , score= model.score +1})
                   
                    else ({model | gamestate = Over})

                Click3 -> 
                    if (model.var3 == model.answer) && (model.count< 10) then 
                        let
                            newlist= Maybe.withDefault [] (get model.count (fromList model.queslist))
                            newquestion= Maybe.withDefault "Error" (get 0 (fromList newlist))
                            newopt= (take 4 (reverse newlist ))
                            nvar1=Maybe.withDefault "var1" (get 0 (fromList newopt))
                            nvar2= Maybe.withDefault "var2" (get 1 (fromList newopt))
                            nvar3= Maybe.withDefault "var3" (get 2 (fromList newopt))
                            nvar4= Maybe.withDefault "var4" (get 3 (fromList newopt)) 
                            newans = Maybe.withDefault "Error" (get 1 (fromList newlist))
                            
                        in ({model |  var1 =nvar1 , var2 =nvar2 , var3 =nvar3, var4=nvar4, question=newquestion , count = model.count +1, answer =newans , score= model.score +1})
                   
                    else ({model | gamestate = Over})

                Click4 -> 
                    if (model.var4 == model.answer) && (model.count< 10) then 
                        let
                            newlist= Maybe.withDefault [] (get model.count (fromList  model.queslist))
                            newquestion= Maybe.withDefault "Error" (get 0 (fromList newlist))
                            newopt= (take 4 (reverse newlist ))
                            nvar1=Maybe.withDefault "var1" (get 0 (fromList newopt))
                            nvar2= Maybe.withDefault "var2" (get 1 (fromList newopt))
                            nvar3= Maybe.withDefault "var3" (get 2 (fromList newopt))
                            nvar4= Maybe.withDefault "var4" (get 3 (fromList newopt)) 
                            newans = Maybe.withDefault "Error" (get 1 (fromList newlist))
                            
                        in ({model |  var1 =nvar1 , var2 =nvar2 , var3 =nvar3, var4=nvar4, question=newquestion , count = model.count +1, answer =newans , score= model.score +10})
                   
                    else ({model | gamestate = Over})

                
        
        Home ->
            case msg of
                Click1 ->
                    let
                        newlist= Maybe.withDefault [] (get model.count (fromList chemlist))
                        newquestion= Maybe.withDefault "Error" (get 0 (fromList newlist))
                        newopt= (take 4 (reverse newlist ))
                        nvar1=Maybe.withDefault "var1" (get 0 (fromList newopt))
                        nvar2= Maybe.withDefault "var2" (get 1 (fromList newopt))
                        nvar3= Maybe.withDefault "var3" (get 2 (fromList newopt))
                        nvar4= Maybe.withDefault "var4" (get 3 (fromList newopt))
                        newans = Maybe.withDefault "Error" (get 1 (fromList newlist))
                    in ({model | queslist =chemlist , gamestate = Active , var1 =nvar1 , var2 =nvar2 , var3 =nvar3, var4=nvar4, question=newquestion , count = model.count +1, answer =newans })
                
                Click2 -> 
                    let 
                        newlist= Maybe.withDefault [] (get model.count (fromList plist))
                        newquestion= Maybe.withDefault "Error" (get 0 (fromList newlist))
                        newopt=  (take 4 (reverse newlist ))
                        nvar1=Maybe.withDefault "var1" (get 0 (fromList newopt))
                        nvar2= Maybe.withDefault "var2" (get 1 (fromList newopt))
                        nvar3= Maybe.withDefault "var3" (get 2 (fromList newopt))
                        nvar4= Maybe.withDefault "var4" (get 3 (fromList newopt))
                        newans = Maybe.withDefault "Error" (get 1 (fromList newlist))
                    in ({model | queslist =plist , gamestate = Active , var1 =nvar1 , var2 =nvar2 , var3 =nvar3, var4=nvar4, question=newquestion , count = model.count +1, answer =newans })
                Click3 -> 
                    let
                        newlist= Maybe.withDefault [] (get model.count (fromList complist))
                        newquestion= Maybe.withDefault "Error" (get 0 (fromList newlist))
                        newopt=  (take 4 (reverse newlist ))
                        nvar1=Maybe.withDefault "var1" (get 0 (fromList newopt))
                        nvar2= Maybe.withDefault "var2" (get 1 (fromList newopt))
                        nvar3= Maybe.withDefault "var3" (get 2 (fromList newopt))
                        nvar4= Maybe.withDefault "var4" (get 3 (fromList newopt))
                        newans = Maybe.withDefault "Error" (get 1 (fromList newlist))
                    in ({model | queslist =complist , gamestate = Active , var1 =nvar1 , var2 =nvar2 , var3 =nvar3, var4=nvar4, question=newquestion , count = model.count +1, answer =newans })
                Click4 -> 
                    let
                        newlist= Maybe.withDefault [] (get model.count (fromList mathlist))
                        newquestion= Maybe.withDefault "Error" (get 0 (fromList newlist))
                        newopt=  (take 4 (reverse newlist ))
                        nvar1=Maybe.withDefault "var1" (get 0 (fromList newopt))
                        nvar2= Maybe.withDefault "var2" (get 1 (fromList newopt))
                        nvar3= Maybe.withDefault "var3" (get 2 (fromList newopt))
                        nvar4= Maybe.withDefault "var4" (get 3 (fromList newopt))
                        newans = Maybe.withDefault "Error" (get 1 (fromList newlist))
                    in ({model | queslist =mathlist , gamestate = Active , var1 =nvar1 , var2 =nvar2 , var3 =nvar3, var4=nvar4, question=newquestion , count = model.count +1, answer =newans })
        Over->
            case msg of
                Click1 -> (model )
                Click2 -> (model )
                Click3 -> (model )
                Click4 -> (model )               




view : Model -> Html Msg
view model =
    case model.gamestate of 
    Active ->
      div [] [ div [] [ text model.question]
      ,div [] [ button [ onClick Click1 ] [ text model.var1 ] , text "   " ,button [onClick Click2 ] [ text model.var2 ] ] 
      ,div [] [button [ onClick Click3] [ text model.var3 ] , text "   " , button [onClick Click4] [ text model.var4 ]]]

    Home ->

      div [] [ div [] [div [] [text "Choose topic" ]]
      ,div [] [ button [onClick Click1 ] [ text "chemistry" ] ,  text "   " ,button [onClick Click2 ] [ text "MARVEL" ] ] 
      ,div [] [button [ onClick Click3 ] [ text "Genral knowledge" ] ,  text "   " , button [ onClick Click4] [ text "math" ]]]
    
    Over ->
      div [] [ div [] [text "GAME OVER !!!"]
      ,div [] [text "your final score"]
      ,div [] [ text  (String.fromInt (model.score +1)) ]]


    

