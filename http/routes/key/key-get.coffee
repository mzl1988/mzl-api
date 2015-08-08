module.exports = (req, res, next, Key) ->
  Key.findOne()
  .lean()
  .sort '-created_at'
  .execAsync()
  .then (key) ->
    res.send key
  .catch next