models = require '../models'
Like = models.Like

module.exports =
  getLikeAll: (request, reply) ->
    Like.find (err, likes) ->
      if err
        reply "There was an error with this request. Please try again."
        console.log "Error: #{err}"
      reply likes: likes

  getLike: (request, reply) ->
    likeId = encodeURI request.params.likeId
    Like.findById likeId, (err, like) ->
      if err
        reply "Could not find the like. Please try again."
        console.log "Error #{err}"
      reply like: like

  createLike: (request, reply) ->
    rp = request.payload
    newLike = new Like()
    newLike.module = rp.module
    newLike.userId = rp.userId
    newLike.save (err) ->
      if err
        reply "Could not save the like. Please try again."
        console.log "Error: #{err}"
      reply like: newLike

  updateLike: (request, reply) ->
    rp = request.payload
    likeId = encodeURI request.params.likeId
    Like.findById likeId, (err, like) ->
      if err
        reply "Could not find the like. Please try again."
        console.log "Error: #{err}"
      else
        like.deleted = rp.deleted or like.deleted
        like.disabled = rp.disabled or like.disabled
        like.lastModified = Date.now()
        like.module = rp.module or like.module
        like.save (err) ->
          if err
            reply "Could not save the like. Please try again."
            console.log "Error: #{err}"
          else
            reply like: like

  deleteLike: (request, reply) ->
    likeId = encodeURI request.params.likeId
    Like.findById likeId, (err, like) ->
      if err
        reply "Could not find the like. Please try again."
        console.log "Error: #{err}"
      else
        like.deleted = true
        like.save (err) ->
          if err
            reply "Could not delete the like. Please try again."
            console.log "Error: #{err}"
          else
            reply "The like has been deleted." 