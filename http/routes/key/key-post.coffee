module.exports = (req, res, next, Key) ->
  {uin, pass_ticket, key} = req.body

  if !uin or !pass_ticket or !key
    return next new Error400 '参数有误！'
    
  Key
  .createAsync {uin: uin, pass_ticket: pass_ticket, key: key} 
  .then (key) ->
    res.send 'ok'
  .catch next