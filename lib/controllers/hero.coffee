UserController = require './user'
Hero           = require '../models/hero'
HeroClass      = require '../models/hero.class'
HeroValidator  = require '../validators/hero'
User           = require '../models/user'
fs             = require 'fs'

exports.init = (app) ->

  # TEST ONLY
  app.get '/api/test/hero', (req,res) ->
    UserController.getUserModel req.user, (userModel) ->
      req.session.user = userModel
      user = req.session.user
      HeroClass.findOne {name:'Mage'}, (err, heroClass) ->
        if not err?
          hero = new Hero({name:"Doug's Hero", class:heroClass.id})
          hero.save (err) ->
            if not err?
              user.heroes.push hero.id
              user.save (err) ->
                if not err?
                  res.send 200, "Hero and user saved"
                else
                  console.log err
                  res.send 500, "Error saving user"
            else
              res.send 500, 'Error saving hero'

  app.post '/api/hero/:id/save', (req, res) ->
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

  app.get '/api/hero', (req, res) ->
    user = req.user

    if user.heroes.length > 0
      Hero.find({ '_id': { $in: user.heroes } })
        .populate('class')
        .exec (err, heroes) ->
          if err?
            res.send 400, 'Unable to find heroes'
          else
            res.json heroes
    else
      res.json []

  app.get '/api/hero/:id', (req, res) ->
    user = req.user

    if not user.hasHero req.params.id
      res.send 'Invalid hero ID: '+req.params.id
    else
      Hero.findOne {_id:req.params.id}, (err, hero) ->
        if err?
          return UserController
        return hero

  # Returns meta-data about hero types
  app.get '/api/meta/hero', (req, res) ->
    fs.readdir __dirname+'/../../game/heroes', (err, files) ->
      if err?
        res.send 500, err
      else
        metadatas = []
        for file in files
          try
            metadatas.push(require('../../game/heroes/'+file).GetMetaData())
          catch error
            console.log 'error getting metadata for '+file
            console.log 'error: '+error
        res.json(metadatas)


  console.log 'Initialized hero controller.'
