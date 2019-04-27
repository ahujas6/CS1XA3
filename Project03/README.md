# Project 3
#### Macid: ahujas6
#### name : Shubham Ahuja

### The project with only client side is available at https://mac1xa3.ca/u/ahujas6/project3.html

My project is a game which uses Elm for Client side, I have named it GameHub .
The objective of the game is to increase your focus and reaction time. The game feature 2 balls depending on game mode you either need to pass through it or avoid it, the balls appear at totally random places and in random sizes,
The points are provided for passing through the required ball depending on mode , and points are inversely proportional to size of ball.
#### It features 2 modes 

:star::yin_yang: ZEN Mode : In this mode player has to move over the circles appearing randomly on the screen at a fast speed.:baseball:

:star::classical_building: Classic Mode : In this mode player needs to pass through randomly appearing balls :8ball: but at same time avoid a randomly appearing red ball :red_circle: 

:star:The game also features a how to play button :star:

#### Client Side Functionality:
The game uses various functionalities taught in  course , Some are listed below: <br>
:snowflake:  random                :fire: multiple shapes<br>
:snowflake:  move                  :fire: round <br>
:snowflake:  rotate                    :fire: tick <br>
:snowflake:  notifyTap                  :fire: Collage <br>
:snowflake:  notifyEnter                :fire: etc.<br>

Instructions on How to Run this Project with server side

ssh into the server with the following command:

ssh ahujas6@mac1xa3.ca

cd into ~/CS1XA3, and activate the python virtual environment by typing the following commands:
cd python_env
source bin/activate

cd into ~/CS1XA3/Project03

cd into ~/CS1XA3/Project03/django_project

start the server with the follwing command:
python manage.py runserver localhost:10002

turn on elm reactor on some local host using the command:
 elm reactor 
 and open reg.html
 
Note:

If you are running this on your local machine by cloning the repo, install the required python packages in requirements.txt located in ~/CS1XA3/Project03 by typing the following command:
pip install -r requirements.txt
