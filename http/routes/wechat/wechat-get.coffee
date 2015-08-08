module.exports = (req, res, next, Wechat) ->
  {wechatId} = req.params

  Wechat.findById wechatId
  .execAsync()
  .then (wechat) ->
    res.send wechat
  .catch next