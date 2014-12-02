module.exports =
  pageIndex: (request, reply) ->
    reply.file 'index.html'

  handler: (request, reply) ->
    reply('The page was now found').code 404