# typeform-hackathon
Typeform hackathon app.

Release for the hackathon: https://github.com/sharnik/typeform-hackathon/releases/tag/hackaton

## Demo

http://typeform-dgt.herokuapp.com/

## Installation

```
$ bundle
$ rake db:create
$ rake db:schema:load

# create a .env file like:

  API_KEY:                  foo # typeform api key
  CLOUDINARY_URL:           cloudinary://foobar  # cloudinary has a free plan
  HOST:                     http://ngrok.io/bar # public url for the webhooks



$ rails server
```

## Public URL in development

I recommend use https://ngrok.com/ to try the webhooks in dev.
