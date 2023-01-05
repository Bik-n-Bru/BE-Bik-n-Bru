# README

<h1 align="center">Bīk-n-Brü API</h1>

<br>
 
This repo is the Back End portion of the Bīk-n-Brü project built by Mod 3 students at [Turing School of Software and Design](https://turing.edu/). 

The purpose of this app is to encourage people to ride their bikes to bars to decrease their carbon footprint by gamifying the exercise/bar experience

Visit our Front End Site!
  - *[Bīk-n-Brü](https://fe-bik-n-bru.herokuapp.com/)*.
<br>

# Table of Contents
- [Setup](#setup)
- [Built With](#built-with)
- [Endpoints](#endpoints)

## Setup
  If you would like to demo this API on your local machine:
<ol>
  <li> Ensure you have the prerequisites or equivelent </li>
  <li> Clone this repo and navigate to the root folder <code>cd BE-Bik-n-Bru</code></li>
  <li> Run <code>bundle install</code> </li>
  <li> Run <code>rails db:{drop,create,migrate,seed}</code> </li>
  <li> (Optional) To run the test suite, run <code>bundle exec rspec spec</code> </li>
  <li> Run <code>rails s</code> </li>
</ol>
You should now be able to hit the API endpoints using Postman or a similar tool.<br>
Default host is <code>http://localhost:3000</code>

## Built With:
  - ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) **2.7.4**
  - ![Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) **5.2.8.1**
  - <img src="app/images/rspec_badge.png" alt="RSpec" height="30"> **3.12.0**
  - ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
  - ![Heroku](https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white)


  <!-- A user signs in using their [Strava](https://www.strava.com/) authentication. If they don't currently have a Strava Login there will be a link to take them to the Strava 
  website and create a login there.

  Upon logging in, the user will see
  The theoretical money that the user saves in gas costs by riding their bike is calculated when a bar trip is logged. That sum can then be used to 
  "purchase" drinks at the brewery they attended.
  The user will also be able to find breweries near their location, log their riding activy to a bar and earn badges for certain accomplishments (number of breweries
  visited, amount of CO2 they have offset by riding their bike vs driving and the chance to be on the app leader board based on miles ridden).  -->
 
## Endpoints

Strava:<br>
This endpoint is used to our OAuth and to collect user data that can be used for other queries

- Find User by Strava athlete_id
  - GET "/api/v1/users/{athlete_id}?q=athlete_id"
  - ***RESPONSE***

- Find User by Bīk-n-Brü id
  - GET "/api/v1/users/#{id}
  - <code>{
      "data": {
          "id": "2",
          "type": "user",
          "attributes": {
              "username": "testcase",
              "token": "12345abcde",
              "athlete_id": "12345",
              "city": "Not a city",
              "state": "Not a state"
              }
          }
      }</code>

- Find User by


