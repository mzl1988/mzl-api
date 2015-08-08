module.exports = (req, res, next, Wechat) ->
  {WechatId} = req.params

  Wechat.findByIdAndRemove WechatId
  .execAsync()
  .then (wechat) ->
    res.end()
  .catch next