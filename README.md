# Comics

#### Extra gems used and why
- __rspec__ - make Ruby testing productive and fun.

  I'm used to rspec and last time I used minitest I was caught switching the parameters too many times.
- __vcr__ - Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.

  I want to test quicker and source api is really slow when requesting several records.
  
- __StimulusJs__ - A modest JavaScript framework for the HTML you already have

  Frontend new kid on the block, I have been using lately and enjoying a lot. This time I had the opportunity to use one of the new features of the recently released version 2.0, so I took it.
  
- __redis__ - A Ruby client that tries to match Redis' API one-to-one, while still providing an idiomatic interface.

  I used redis for caching. It's crazy fast and powerful.


#### The work

I started by building a class to abstract all requests I was needing during the challenge. Then I descended other classes that could easily connect and retrieve data from the source API.

Quickly I could create classes for comic collection, comics and characters.

I could now start to build the view and took my time with plain css. I regret not using bootstrap, but I wanted to try flexbox layout and I enjoy that part :), I suffer with plain css though.

Then I built the pagination and search box and moved to allowing users to vote up, or mark their favorite comics. I wrote some StimulusJS to accomplish that which felt really good again. (Please check the code here if you don't know Stimulus yet)

Last part was getting rid of those 20 seconds to render 25 comic cover pages from Marvel API, and implement a cache system with redis.

#### Run
1. Build it locally
  - git clone this repo
  - Copy master.key sent by email to /config 
  - run `bundle install`
  - run `yarn install`
  - run `rails s`
  
  P.S. If you don't have the master.key just delete `credentials.yml.enc`, create a new one with `EDITOR=vim rails credentials:edit` and add marvel API credentials to it.

2. See it on heroku
  https://marvel-chalenge.herokuapp.com

#### Conclusion
I think this work suits the purpose of this challenge. 
Doing something that I could show to my kids and keep their attention for a while. Seeing them navigating through it and enjoying the cover was quite cool.
