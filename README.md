
# Setup

Ruby - `3.4.2`
Postgresql
run `bundle install` , `rails db:create`, `rails db:migrate`, `rails s` to setup and start the server

> For local development the ENV variables shouldn't be important, the defaults in development should make everything work but the only importants
but I had 2 in my local setup like: 
```
HOST="localhost"
DEVISE_JWT_SECRET_KEY="secretkey"
```

# Overall Arquitecture

The project just follows the standard organization for an API developed in Ruby On Rails.
This project was created with `rails new` and rails 8 with api only flag. Some boilerplate remains.
Database chosen was Postgresql and it's setup is all done through Rails migrations and configs.
 - 2 tables only: user and todo, schema can be checked on schema.rb and its pretty straightforward. A User can have many todos, a todo only belongs to 1 user
> I chose to use `in_progress` instead `in progress` because it made more sense for me, I did not add anything to make `in progress` valid when using the api

All endpoints are under `/api/v1/`. Including devise, which is used for authentication together with jwt tokens.
Users can register through the api but only as regular users, admin flag is not editable. Users need to be created as admins through the console.

# Challenges

While the code was developed with the challenges in mind, it seemed overkill to implement or setup most of those common solutions for such a simple initial setup. As such I will opt to write soem of the reasonings in here:


 - Rails can be easily integrated with a load balancer to deploy multiple instances (managed by kubernets or something similar)
 - Database optimizations like caching, pagination or replications could be used. But for a todo application normally horizontal scalling would be the only problem unless we are processing a lot of metrics
 - I have also not added any kind of rates or limits to the api, but in an example like this application it would mosltly be to protec for misuse or attacks
 - Indexing and Serializers should be used as application grow but for this scale I only added some things in that regard as examples
 - I setup lograge but any other kind of monitor should be setup like NewRelic or Rollbar for erros to handle production
 - In terms of security. Devise,jwt and Active Record and it's proper use block most things. 
 - Project code was done in a proper clean and organized way using a simple rubocop setup for linting. A proper Test Suit and CI should be setup to ensure project continous upkeep

# API ROUTES

Normally I would use rwag to automatically generate documention for API from the tests.
Here is a quick rundown of the routes and examples of body for each type of body needed, though it's probably self explanatory

## User Authentication (Devise):

 - POST `/api/v1/users/signup` – Register a new user (regular user only)
 - POST `/api/v1/users/login` – Log in and receive a JWT token
 - DELETE `/api/v1/users/logout` – Log out (JWT token revocation)

## Todo Endpoints:

 - GET `/api/v1/todos` – List todos (admins see all; regular users see only their own)
 - GET `/api/v1/todos/:id` – Show details of a specific todo
 - POST `/api/v1/todos` – Create a new todo
 - PUT `/api/v1/todos/:id` – Update a todo
 - DELETE `/api/v1/todos/:id` – Delete a todo

### User JSON body example
```
{
  "user": {
    "email": "user@example.com",
    "password": "your_password"
  }
}
```
### Todo JSON body example
 ```
 {
  "todo": {
    "title": "Buy groceries",
    "description": "Milk, eggs, bread",
    "status": "in_progress",
    "due_date": "2025-03-15T00:00:00Z"
  }
}
 ```