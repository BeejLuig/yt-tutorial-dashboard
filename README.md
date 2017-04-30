# YT Tutorial Dashboard - API App

This application is a back-end demo using React/Redux. It works locally in conjunction with the [React YT Tutorial Dashboard Client](https://github.com/BeejLuig/react-yt-tutorial-dashboard). 

This app was created as a project for the Flatiron School's Fullstack Web Development Program. 

In order to use this application, you will need a [YouTube API key](https://developers.google.com/youtube/v3/getting-started). 

## Installation

This project uses the [Yarn package manager](https://yarnpkg.com/en/). You can also use npm. 

- Fork and clone this repository
- Fork and clone the [React YT Tutorial Dashboard Client](https://github.com/BeejLuig/react-yt-tutorial-dashboard) repository.
- Rename the client repository's root directory to "client"
- Replace the "client/" directory in this project with this your new 'client'.
- Run `bundle install`. 
- cd into `client` and run `yarn install` or `npm install`

## Setup and running the App

This project uses [PostgreSQL](https://www.postgresql.org/) for a database. If you prefer sqlite, remove `pg` from the Gemfile and replace it with `sqlite3`, then run `bundle install`. 

This project uses the [JWT gem](https://github.com/jwt/ruby-jwt) for user authentication. Use the docs to choose your JWT secret and algorithm. 

- A .env.sample file is provided. Put your JWT secret and algorithm into  this file and rename it to '.env'
- To enable the database, cd into the root directory and run `rake db:create && rake db:migrate`.
- To start the servers, run `rake start`.


--- 
