postgres = require "./database"
fs = require "fs"
path = require "path"

postgres.settings.username = "postgres"
postgres.settings.database = "cat"

client = postgres.connect()

fn =
  sub: (line) ->
    splt = line.split " "
    number = splt[1]
    name = splt[0]
    client.query "INSERT INTO subscribers (number, name)
                  VALUES (#{number}, #{name})", (err, results) ->
                    if err
                      console.log err

  fact: (line) ->
    fct = line
    client.query "INSERT INTO facts (fact)
                  VALUES (#{fct})", (err, results) ->
                    if err
                      console.log err

  question: (line) ->
    splt = line.split "|"
    question = splt[0]
    answer = splt[1]
    client.query "INSERT INTO questions (question, answer)
                  VALUES (#{question}, #{awnser})", (err, results) ->
                    if err
                      console.log err


args = process.argv
if args.length > 3:
  args = args[2..]
  fp = path.join __dirname, args[1]
  func = fn[args[0]]
  fs.readFile fp, (err, data) ->
    func line for line in data.split "\n"