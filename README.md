# README

Project created for Cloud Application Development in Final Year Computing module.

Crown Games is designed to allow users to review video games and share feedback on current their favourite (or least favourite) video games.

* Developed in Ruby v2.7
* Developed in Ruby on Rails v5.2
* Hosted on Heroku @ https://intense-beyond-53421.herokuapp.com/

# Local Deployment

To deploy locally on your machine visit your command line and use the following commands

* git clone git@github.com:WayneHartigan/CrownGames.git
* cd CrownGames/
* rails s
* On your browser visit the URL provided in the previous output e.g http://localhost:3000/

To edit the database 

* cd CrownGames/
* rails c

To edit the list of genres (genre list is empty by default)

* cd CrownGames/
* rails c
* Category.connection
* @cat = Category.create(:name => "Example")
* Repeat last command as many times as you wish to add different genres

Grant a user admin access

* Create a user (http://localhost:3000/users/sign_up)
* now return to your console
* cd CrownGames/
* rails c
* User.connection
* @user = User.last
* @user.update_attribute(:admin, true)
* User will now have admin access and can add games
