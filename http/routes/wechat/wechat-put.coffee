module.exports = (req, res, next, Wechat) ->
  {wechatId} = req.params
  
  unless wechatId
    return next new Error400 'wechatId required'

  Wechat
  .findByIdAndUpdate wechatId, req.body
  .execAsync()
  .then ->
    res.send 'ok'
  .catch next