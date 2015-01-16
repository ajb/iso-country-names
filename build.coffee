fs = require 'fs'
http = require 'http'

http.get "http://data.okfn.org/data/core/country-list/r/data.json", (res) ->
  data = ''

  res.on 'data', (chunk) ->
    data += chunk

  res.on 'end', ->
    out = 'var ISOCountryNames = {\n'

    for country in JSON.parse(data)
      out += "  \"#{country.Code}\": \"#{country.Name}\",\n"

    out += '};'

    fs.writeFileSync('index.js', out)
