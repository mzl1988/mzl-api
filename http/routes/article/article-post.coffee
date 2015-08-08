_ = require 'underscore'
_.str = require 'underscore.string'
es = require __base + '/common/connections/es'
moment = require 'moment'

est = es.index('wechat').type('articles')

exports.index = (req, res, next) ->
  search req.query, (err, results) ->
    return res.json 500, err if err
    data = _.pluck results, '_source'
    res.send
      count: results.total
      data: data
     


exports.search = (req, res, Article, next) ->
  search req.body, (err, results) ->
    return res.json 500, err if err
    data = _.pluck results, '_source'
    res.send
      count: results.total
      data: data
      
   


search = (options, fn) ->
  {q, wechat_name, wechat_id, start_date, end_date, offset, limit} = options

  q = _.str.trim(q) or '*'
  q = "(#{q})"
  console.log q

  if wechat_name
    q += " AND wechat_name: (#{wechat_name})"
  if wechat_id
    q += " AND wechat_id: (#{wechat_id})"

  est.find
    query:
      query_string:
        default_operator: 'AND'
        fields: ['title', 'digest', 'content_text', 'content']
        query: q
    # _source: ['_id']
    filter:
      range:
        datetime:
          from: moment(start_date or '2012-12-30').toISOString()
          to: moment(end_date or undefined).toISOString()
    sort: [
      datetime:
        order: 'desc'
    ]
    from: offset or 0
    size: limit or 20
  ,
    fn
