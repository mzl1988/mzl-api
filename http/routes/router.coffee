#
# 註冊路由
#

express = require 'express'

app = module.exports = express.Router()

# wechat
wechatGet = require './wechat/wechat-get'

app.route '/wechats'
.get require './wechat/wechat-gets'
.post require('./wechat/wechat-post')

app.route '/wechats/:wechatId'
.get wechatGet
.put require('./wechat/wechat-put')
.delete require './wechat/wechat-delete'

#key
app.route '/keys'
.get require './key/key-get'
.post require('./key/key-post')


# 公眾號文章es
articlePost = require './article/article-post'
app.get '/articles/es/posts', articlePost.index
app.post '/articles/es/posts', articlePost.search

# 公眾號文章
app.get '/articles', require './article/article-gets'
app.get '/articles/:articleId', require './article/article-get'