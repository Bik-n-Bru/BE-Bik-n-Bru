# README

<h1 align="center">Bīk-n-Brü API</h1>

<br>
 
This repo is the Back End portion of the Bīk-n-Brü project built by Mod 3 students at [Turing School of Software and Design](https://turing.edu/). 

The purpose of this app is to encourage people to ride their bikes to bars to decrease their carbon footprint by gamifying the exercise/bar experience!

Visit our Front End Site!
   *[Bīk-n-Brü](https://fe-bik-n-bru.herokuapp.com/)*
<br>

# Table of Contents
- [Setup](#setup)
- [Tech & Tools Used](#tech-and-tools)
- [Endpoints](#endpoints)


## Tech and Tools
  - ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) **2.7.4**
  - ![Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) **5.2.8.1**
  - <img src="app/images/rspec_badge.png" alt="RSpec" height="30"> **3.12.0**
  - ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
  - ![Heroku](https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white)
  - <img src="app/images/CircleCi_logo.png" alt="Circle Ci" height="30">

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
- Sign in using Strava Oauth

  - GET "/api/v3/oauth/token" 
  ```
        client_id = ENV['strava_client_id'] 
        client_secret = ENV['strava_client_secret']   
        code = ReplaceWithCode 
        grant_type = authorization_code
  ```

Back-End Service Api calls 
  - Base URL https://be-bik-n-bru.herokuapp.com

- Find User by Bīk-n-Brü id
  - GET "/api/v1/users/#{id}
    ```
    {
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
            }
      ```

- Find Users with information for leaderboard
  - GET "/api/v1/leaderboard"
  ```
    {
            data: [
              {
                attributes: {
                  username: 'Lance',
                  miles: '12897',
                  beers: '527',
                  co2_saved: '61'
                }
              }
            ]
          },
  ```

- Update a User's Information
  - PATCH "/api/v1/users/#{user_id}"
  ```
  {
          :data=> {
              :id=>"5",
              :type=>"user",
              :attributes=>{
                  :username=>"testcase",
                  :token=>"12345abcde",
                  :athlete_id=>"12345",
                  :city=>"Eugene",
                  :state=>"Oregon"
                  }, 
                    :relationships=>
                      {:activities=>{
                        :data=>[]}}}}'
  ```


- Find Breweries by city and state
  - GET "/api/v1/breweries/#{user.id}"
  ```
  {
          :data=>[
            {
            :id=>"10-56-brewing-company-knox",
            :type=>"brewery",
            :attributes=>{
                  :name=>"10-56 Brewing Company",
                  :street_address=>"400 Brown Cir",
                  :city=>"Knox",
                  state=>"Indiana",
                  :zipcode=>"46534",
                  :phone=>"6308165790",
                  :website_url=>nil
                  }
            },
  ```


# Contributors

### Project Team:
<table>
  <tr>
    <td><img src="https://avatars.githubusercontent.com/u/101589894?v=4" width=auto height=110px></td>
    <td><img src="https://avatars.githubusercontent.com/u/108035840?v=4" width=auto height=110px></td>
    <td><img src="https://avatars.githubusercontent.com/u/108554663?v=4" width=auto height=110px></td>
    <td><img src="https://avatars.githubusercontent.com/u/108249540?v=4" width=auto height=110px></td>
    <td><img src="https://avatars.githubusercontent.com/u/102780642?s=400&u=caf69a9ee867dd111a5c160cf96d6a8ca33add7c&v=4" width=auto height=110px></td>
  </tr>
  <tr>
    <td><strong>Amanda Ross</strong></td>
    <td><strong>Yuji Kosakowski</strong></td>
    <td><strong>Rich Kaht</strong></td>
    <td><strong>Gabe Nuñez</strong></td>
    <td><strong>Annie Pulzone</strong></td>
  </tr>
  <tr>
    <td>
      <div align="center"><a href="https://github.com/amikaross">GitHub</a><br>
      <a href="https://www.linkedin.com/in/amanda-ross-2a62093a/">LinkedIn</a></div>
    </td>
    <td>
      <div align="center"><a href="https://github.com/Yuji3000">GitHub</a><br>
      <a href="https://www.linkedin.com/in/yujikosa/">LinkedIn</a></div>
    </td>
    <td>
      <div align="center"><a href="https://github.com/Freeing3092">GitHub</a></div>
    </td>
    <td>
      <div align="center"><a href="https://github.com/MisterJackpots">GitHub</a><br>
      <a href="https://www.linkedin.com/in/gabriel-c-nunez/">LinkedIn</a></div>
    </td>
    <td>
      <div align="center"><a href="https://github.com/ajpulzone">GitHub </a><br>
      <a href="https://www.linkedin.com/in/annie-pulzone/">LinkedIn</a></div>
    </td>
  </tr>
</table>

### Project Manager:
<table>
  <tr>
    <td><img src="https://avatars.githubusercontent.com/u/3011748?v=4" width=110px height=auto></td>
  </tr>
  <tr>
    <td><strong>Mike Dao</strong></td>
  </tr>
  <tr>
    <td>
      <div align="center"><a href="https://https://github.com/mikedao">GitHub</a><br>
      <a href="https://www.linkedin.com/in/michaeldao/">LinkedIn</a></div>
    </td>
  </tr>
</table>



