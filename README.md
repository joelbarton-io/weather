## a simple weather webapp

>> purpose: practice html/css, use `Net::Http` to fetch info from a weather api, general sinatra practice


- useful coordinate gem: [geocoder](https://github.com/alexreisner/geocoder) from: alexreisner
- ruby library used to issue http request: `require 'net/http'`
- all weather info is sourced from [openweathermap.org](https://openweathermap.org/current) with a free tier subscription; currently limited to info on the weather RIGHT NOW, no forecasting unfortunately
- had a lot of fun with this very simple app; will probably later on expand functionality
- hosted on heroku [here](https://frozen-plains-92875.herokuapp.com)
![screenshot](./public/app_ss.png)