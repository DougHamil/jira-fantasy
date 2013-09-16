mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name: String
  media:
    img: String       # path to image for this hero class
    taunts: [String]  # paths to taunt audios
  abilities: [
    level: Number
    name: String
  ]

HeroClass = mongoose.model('HeroClass', schema)

HeroClass.build = ->
  classes = [
    {
      name:'Mage'
      media:
        img:'/media/img/heroes/mage.png'
        taunts:[]
      abilities: [
        { level: 0, name: 'fireball'}
        { level:1, name:'frost'}
      ]
    }
    {
      name: 'Knight',
      media:
        img:'/media/img/heroes/knight.png'
        taunts:[]
      abilities:[]
    }
  ]

  logErr = (name)->
    return (err) ->
      if err?
        console.log "Error inserting hero class #{name}"
        return
      else
        console.log "Created #{name} hero class."
        return

  HeroClass.update({name: clazz.name}, clazz, {upsert:true}, logErr(clazz.name)) for clazz in classes

console.log "Building hero classes..."
do HeroClass.build
module.exports = HeroClass
