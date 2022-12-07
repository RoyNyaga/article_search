# README
#### You can access the live code by clicking on this [link](https://safe-woodland-17111.herokuapp.com/)

<img src="https://res.cloudinary.com/it-s-tech/image/upload/v1670415331/Screenshot_2022-12-07_at_13.14.10_vx7x4f.png">

### About this app
This app has the following functionalities:
- Authentication
- Create articles.
- Live search of articles.
- Saving of searches made by users.

### Dependencies
- Ruby 3.0.0
- PostgreSQL
- Rails 6.1.5
- Node
- Yarn
- Bootstrap
- jQuery
- Heroku

### Setting up the environment
Please make sure that you have installed the above dependencies.
- Clone the project using the command `git@github.com:RoyNyaga/article_search.git`
- Open the root directory in your terminal.
- Install gems by using the command `bundle install`.
- install javascript packages using `yarn install`
- Create your development database using `rails db:create`
- Run your migrations using `rails db:migrate`
- Seed your database using `rails db:seed`
- Run your development server with `rails s`

### Testing
You need to have firefox installed to run the feature test.
Run the command `rspec` or `bundle exec rspec` in the root of the project to run all test cases.
For specific test cases, you can add the specific folder after calling `rspec`. For example
`rspec spec/features` or `bundle exec rspec spec/features`

### Todos
- Add pagination to the articles index page.
- make the saved search div scrollable.
- Add a feature that will display the search results of a saved search when clicking on a saved search.