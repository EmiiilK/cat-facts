twilio = require "twilio"

Sms = (number, sid, token) ->
  this.client = twilio sid, token
  this.number = number

Sms.prototype =
  # Send a specific message to 1 or more numbers
  send: (message, numbers...) ->
    for number in numbers
      this.client.messages.create
        body: message
        to: number
        from: this.number
      ,
        (err, message) ->
          console.log "Error: " + message

  # Reply to an sms
  reply: (app, message) ->
    app.set "Content-Type", "text/xml"
    app.send "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
              <Response><Message>#{message}</Message></Response>"

module.exports = Sms