express = require('express')
socket = require('socket.io')
jade = require('jade')
app = express()
app.set('port', (process.env.PORT || 5000));
http = require('http').Server(app)
io = socket(http);
views = []
views['index'] = jade.compileFile(__dirname + "/view/index.jade");

app.get '/', (req, res) ->
  res.send(views['index']())

app.use('/static', express["static"](__dirname + "/public"));
app.use('/test', express["static"](__dirname + "/public-test"));

server = app.listen app.get('port'), ->
  host = server.address().address
  port = server.address().port
  console.log 'Example app listening at http://%s:%s', host, port



