mongoClient = require('mongodb').MongoClient
format = require('util').format

exports.init = (cb) ->
  mongoClient.connect 'mongodb://127.0.0.1:27017/test', (err, db) ->
    if err
      throw err
    exports.db = db
    cb(db)
    return

exports.query = (cb) ->
  mongoClient.connect 'mongodb://127.0.0.1:27017/test', (err,db) ->
    if err
      throw err

    collection = db.collection 'test_insert'
    collection.insert
      a:2,
      (err, docs) ->
        collection.count (err, count) ->
          console.log "count = #{count}"

        collection.find().toArray (err, results) ->
          cb results
          db.close()
