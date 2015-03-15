pg = require "pg"

settings =
  user: ""
  password: ""
  host: "localhost"
  database: ""

connect = (stngs) ->
  # Create a client connection to postgresql server with settings
  client = new pg.Client(if stngs? then stngs else settings);

  # Connect and return client
  client.connect()
  return client

exports.settings = settings;
exports.connect = connect