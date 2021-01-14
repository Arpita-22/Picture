# README

This README would normally document whatever steps are necessary to get the
application up and running.

This Application lets a user upload pictures ,give the picture a title and a tag.The user would be able to see their uploaded picture with the provided title without having to refresh the page. User can search a picture using any or all constraints and the picture having the said feature would upload in the same page. User can click on the `show all images` button to load all the images back in the page. The user would only be able to see the images they loaded and not other users images.

Things you may want to cover:

* Ruby version
`Ruby version 2.6.1` is used for this application.

* System dependencies
`gem 'bcrypt'` for authentication and `gem 'cloudinary'` for using cloudinary API to upload photos.


* Configuration

* Database creation

 This application uses a postgres database. `rails new app -T --database=postgresql` the -T is for not generating any tests.
 After that the tables, models controllers and views were created using `rails g resource TableName column1:datatype column2:datatype column3:belongs_to`(for creating relationships between the tables).For each table this command was used. After creating the models,controllers and views the associations were created in the models and then rails db:create to create the database, rails db:migrate for migration and schema generation and then to test out the relationships some seeds were created in the seed.rb file and then rails db:seed.

* Database initialization

* How to run the test suite

 To run the test suite first cd into picture and then run rails s to start the rails server.To run the application go to http://localhost:3000/users/new  on your browser and this url would take you to a page with a create new user with a login and sign up button at the top left side. After signup go to login and this would take you to a login page and after the user is logged in they are taken to a page where the user can upload images and search images.

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
