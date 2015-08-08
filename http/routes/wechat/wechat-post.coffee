module.exports = (req, res, next, Wechat) ->
  {wechat} = req.body

  unless wechat
    return next new Error400 'wechat required'

  Wechat
  .createAsync wechat 
  .then (wechat) ->
    res.send 'ok'
  .catch next