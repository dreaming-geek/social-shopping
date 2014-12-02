models = require '../models'
Comment = models.Comment

module.exports =
  getCommentAll: (request, reply) ->
    Comment.find (err, comments) ->
      if err
        reply "There was an error with this request. Please try again."
        console.log "Error: #{err}"
      reply comments: comments

  getComment: (request, reply) ->
    commentId = encodeURI request.params.commentId
    Comment.findById commentId, (err, comment) ->
      if err
        reply "Could not find the comment. Please try again."
        console.log "Error #{err}"
      reply comment: comment

  createComment: (request, reply) ->
    rp = request.payload
    newComment = new Comment()
    newComment.module = rp.module
    newComment.userId = rp.userId
    newComment.comment = rp.comment
    newComment.save (err) ->
      if err
        reply "Could not save the comment. Please try again."
        console.log "Error: #{err}"
      reply comment: newComment

  updateComment: (request, reply) ->
    rp = request.payload
    commentId = encodeURI request.params.commentId
    Comment.findById commentId, (err, comment) ->
      if err
        reply "Could not find the comment. Please try again."
        console.log "Error: #{err}"
      else
        comment.deleted = rp.deleted or comment.deleted
        comment.disabled = rp.disabled or comment.disabled
        comment.lastModified = Date.now()
        comment.module = rp.module or comment.module
        comment.comment = rp.comment or comment.comment
        comment.save (err) ->
          if err
            reply "Could not save the comment. Please try again."
            console.log "Error: #{err}"
          else
            reply comment: comment

  deleteComment: (request, reply) ->
    commentId = encodeURI request.params.commentId
    Comment.findById commentId, (err, comment) ->
      if err
        reply "Could not find the comment. Please try again."
        console.log "Error: #{err}"
      else
        comment.deleted = true
        comment.save (err) ->
          if err
            reply "Could not delete the comment. Please try again."
            console.log "Error: #{err}"
          else
            reply "The comment has been deleted." 