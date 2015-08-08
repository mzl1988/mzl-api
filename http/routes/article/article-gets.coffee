#
# wechat文章列表
#

Promise = require 'bluebird'
_ = require 'underscore'
moment = require 'moment'

module.exports = (req, res, next, Article) ->
  {wechat_id, wechat_name, datetime, limit, offset} = req.query

  promise = Promise.resolve()
 
  promise.then ->

    query = Article.find()
    .lean()
    .limit limit or 20
    .skip offset or 0
    .sort '-datetime'

    if wechat_name
      query.where('wechat_name').equals new RegExp wechat_name, 'i'
    if wechat_id
      query.where('wechat_id').equals new RegExp wechat_id, 'i'

    if datetime
      query.where('datetime').gte datetime.format 'YYYY-MM-DD 00:00:00'
      query.where('datetime').lt datetime.add(1, 'd').format 'YYYY-MM-DD 00:00:00'

    Promise.all [
      query.execAsync()
      query.countAsync()
    ]
    .spread (data, count) ->
      res.send
        data: data
        count: count
  .catch next
