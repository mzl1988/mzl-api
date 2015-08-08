//
// 運行服務
//

require('./init');

var time = process.hrtime()

var config = require('config');
var moment = require('moment');

var app = require('./http');

app.listen(config.http.port, function() {
  time = process.hrtime(time);
  console.log("%s http service is listening on port %d in %s mode used %d.%d seconds",
    moment().format('YYYY-MM-DD HH:mm:ss'), config.http.port, process.env.NODE_ENV, time[0], time[1]);
});
