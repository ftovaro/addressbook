[ ![Codeship Status for ftovaro/addressbook](https://app.codeship.com/projects/4541c4a0-41b6-0135-20c9-76e56c030005/status?branch=master)](https://app.codeship.com/projects/230119)

## AddressBook ##
**AddressBook** is an API that let you create **organizations** where you can store **contacts**, this way you can easily connect with any client (e.g mobile app or front-end app) using this API and start managing your contacts the way God meant to be.

You can also have **users** that controls your **contacts**, this way, not only the admin can manage contacts but only he can control organizations.

## Installation ##

First of all, this app was created with **Ruby 2.4.0** and **Rails 5.0**. We use **Postgresql** as DB so get that ready before anything. 

After you have cloned the project, go inside the folder a run `bundle install`, then `rails db:create db:migrate db:seed` as a single command to create the DB, run migrations and create an admin user, regular user and an organization to start with.

Once done, you can start the server with `rails s`

## App diagram ##

One of the most cool features this API has is that we have two databases, one is **Postgres** where we store Organizations and Users, and we also have a dynamic database in **Firebase** where only contacts are stored.

The reason behind this is that **contact** is the entity that will require more storage space, so this way we delegate that responsibility to Firebase where we can manipulate better with the database.

![diagram](https://github.com/ftovaro/addressbook/blob/master/doc/diagram_1.png)

## Testing ##

This project uses **Rspec** for testing, we have models, requests and routing tests, don't forget to check them out!.

To run the test just get inside the project folder and run `rspec`

## Deployment ##

This API is currently online and deployed in **Heroku** and can be used by anybody. 

URL: `https://addressbook-strv.herokuapp.com/`

## Wiki ##

Find more about this cool API and its endpoints [here](https://github.com/ftovaro/addressbook/wiki)
