#
# 全局變量
#

path = require 'path'

global.__base = path.normalize __dirname + '/..'

global.Error400 = class Error400 extends Error
  constructor: (@message) ->
    @name = "Error400"
    Error.captureStackTrace(this, Error400)
