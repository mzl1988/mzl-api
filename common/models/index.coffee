#
# 載入所有模型，用于註冊express dependency injection
#

_ = require 'underscore'
_s = require 'underscore.string'

models = require('require-dir')()

app = require __base + '/http'

_.each models, (Model, name) ->
  app.factory _s.classify(name), (req, res, next) ->
    next null, Model
