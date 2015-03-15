

module.exports = (config) ->
  setInterval () ->
    # Get a fact you not yet have seen
    config.client.query 'SELECT facts.id, facts.fact, subscribers.number,
                          subscribers.id
                  FROM facts, subscribers
                  WHERE facts.id NOT IN (
                                      SELECT fact_id FROM fact_check
                                      WHERE subscribers.id = fact_check.sub_id
                                    )
                  GROUP BY subscribers.id', (err, results) ->
      if err
        console.log err
      else
        for row in results.rows

          # Send fact to number
          config.sms.send(row.fact, row.number)

          # Set so you have seen fact
          config.client.query "INSERT INTO fact_check (sub_id, fact_id)
                                VALUES (#{row.sub_id}, #{row.fact_id})",
                                (err, results) ->
            if err
              console.log err

  ,
    (config.time)
