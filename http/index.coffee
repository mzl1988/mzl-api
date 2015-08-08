#
# express app對象
#

require '../init'

express = require 'express'
bodyParser = require 'body-parser'
multer = require 'multer'
moment = require 'moment'
cors = require 'cors'

# 創建express對象
app = module.exports = express()

# 註冊model到express-di
require __base + '/common/models'

# 中間件
app.use cors()
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true
app.use multer()

# 掛載路由
app.use require './routes/router'

# Error handler
app.use (err, req, res, next) ->
  if err instanceof Error400
    return res.status(400).send error: err.message

  console.error ''
  console.error "[ERROR] #{moment().format('YYYY-MM-DD HH:mm:ss')} Handled error"
  console.error err.stack

  res.status(500).send error: err.message

# Process error handler
process.on 'uncaughtException', (err) ->
  console.error ''
  console.error "[ERROR] #{moment().format('YYYY-MM-DD HH:mm:ss')} Uncaught exception"
  console.error err.stack

  process.exit()
