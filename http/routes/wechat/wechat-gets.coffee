Promise = require 'bluebird'

module.exports = (req, res, next, Wechat) ->
  {wechat_name, wechat_id, authenticate, limit, offset} = req.query

  query = Wechat.find()
  .lean()
  .limit limit or 10
  .skip offset or 0
  .sort 'created_at'

  if wechat_name
    query.where('wechat_name').equals new RegExp wechat_name, 'i'
  if wechat_id
    query.where('wechat_id').equals new RegExp wechat_id, 'i'
  if authenticate
    query.where('authenticate').equals new RegExp authenticate, 'i'

  Promise.all [
    query.execAsync()
    query.countAsync()
  ]
  .spread (data, count) ->
    res.send
      data: data
      count: count
  .catch next
