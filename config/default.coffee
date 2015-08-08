#
# 配置文件
#

path = require 'path'

module.exports =

  http:
    port: process.env.PORT or 3000

  mongo:
    uri: null
    host: 'localhost'
    port: 27017
    database: 'example'
    user: null
    password: null

  
