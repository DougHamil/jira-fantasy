UserController = require './user'
Hero           = require '../models/hero'
HeroValidator  = require '../validators/hero'
fs             = require 'fs'

exports.init = (app) ->

  app.post 'api/hero/:id/save', (req, res) ->
    hero = new Hero(req.body)

    if not HeroValidator.isValid(req.user, hero)
      return

    if req.params.id == 'new'
      hero.save (err, hero) ->
        if err?
          console.log "Error saving hero: "+hero
        else
          user.heroes.push(hero.id)
          user.save (err) ->
            if err?
              console.log "Error saving user: "+user
            else
              user.addHero(hero.id)
              console.log "Saved hero "+hero.id
    else
      Hero.update {_id:req.params.id}, req.body, (err) ->
        if err?
          console.log "Failed to update hero: "+hero
        else
          console.log "Successfully updated hero "+req.params.id

  app.get 'api/hero/:id', (req, res) ->
    user = req.user

    if not user.hasHero req.params.id
      res.send 'Invalid hero ID: '+req.params.id
    else
      Hero.findOne {_id:req.params.id}, (err, hero) ->
        if err?
          return UserController
        return hero

  # Returns meta-data about hero types
  app.get 'api/meta/hero', (req, res) ->
    fs.readdir '../../game/heroes', (err, files) ->
      if err?
        return
      else
        metadatas = []
        for file in files
          metadatas.push(require(file).GetMetaData())


  console.log 'Initialized hero controller.'
