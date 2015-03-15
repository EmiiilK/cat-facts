express = require "express"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"
fs = require "fs"

postgres = require "./database"
Sms = require "./sms"
interval = require "./interval"

# Initialize express app
app = express()
app.use bodyParser.json()
app.use cookieParser()

# Initialize sms client
sms = new Sms fs.readFileSync "number.txt", fs.readFileSync "sid.txt"
              fs.readFileSync "token.txt"

# Set server port
app.set "port", 4411

# Setup database connection
postgres.settings.database = "cat"
postgres.settings.username = "postgres"
app.database = postgres.connect()

# When someone send an sms
app.post "/", (req, res) ->
  from = req.body.From
  content = req.body.Body

  res.send "lol"

# Start http server to listen of specific port
app.listen app.get "port", () ->
  console.log "Server started at port " + app.get "port"

# Start sms interval of 12 hours when to send new fact
interval
  sms: sms
  time: (1000*60*60*12)
  client: app.database