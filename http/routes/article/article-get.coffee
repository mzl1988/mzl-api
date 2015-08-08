#
# 公眾號文章
#

module.exports = (req, res, next, Article) ->
  {articleId} = req.params

  Article.findById articleId
  .execAsync()
  .then (article) ->
    res.send article
  .catch next