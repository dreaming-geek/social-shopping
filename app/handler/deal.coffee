models = require '../models'
Deal = models.Deal

module.exports =
  getDealAll: (request, reply) ->
    Deal.find (err, deal) ->
      if err
        reply "There was an error with this request. Please try again."
        console.log "Error: #{err}"
      reply deals: deal

  getDeal: (request, reply) ->
    dealId = encodeURI request.params.dealId
    Deal.findById dealId, (err, deal) ->
      if err
        reply "Could not find the deal. Please try again."
        console.log "Error #{err}"
      reply deal: deal

  createDeal: (request, reply) ->
    rp = request.payload
    newDeal = new Deal()
    newDeal.owner = rp.owner
    newDeal.ownerId = rp.ownerId
    newDeal.status = rp.status
    newDeal.source = rp.source
    newDeal.title = rp.title
    newDeal.product = rp.product
    newDeal.startDate = new Date rp.startDate
    newDeal.endDate = new Date rp.endDate
    newDeal.backgroundImage = rp.backgroundImage
    newDeal.image = rp.image
    newDeal.video = rp.video
    newDeal.barCode = rp.barCode
    newDeal.availableOnline = rp.availableOnline #true/false
    newDeal.availableInStores = rp.availableInStores #true/false
    newDeal.url = rp.url
    newDeal.locationType = rp.locationType
    newDeal.locationStreetAddress = rp.locationStreetAddress
    newDeal.locationExtstreetAddress = rp.locationExtStreetAddress
    newDeal.locationLocality = rp.locationLocality
    newDeal.locationRegion = rp.locationRegion
    newDeal.locationPostCode = rp.locationPostCode
    newDeal.locationCountry = rp.locationCounty
    newDeal.locationPrimary = rp.locationPrimary
    newDeal.locationLng = rp.locationLng
    newDeal.locationLat = rp.locationLat
    newDeal.description = rp.description
    if rp.newSize #true/false
      newDeal.sizes = [
        label: rp.sizeLabel
      ]
    if rp.newColors #true/false
      newDeal.colors = [
        label: rp.colorLabel
      ]
    newDeal.discountType = rp.discountType
    newDeal.discountAmount = rp.discountAmount
    newDeal.price = rp.price
    if rp.newTags #true/false
      newDeal.tags = [
        label: rp.tagLabel
      ]
    newDeal.save (err) ->
      if err
        reply "Could not save the deal. Please try again."
        console.log "Error: #{err}"
      reply deal: newDeal

  updateDeal: (request, reply) ->
    rp = request.payload
    dealId = encodeURI request.params.dealId
    Deal.findById dealId, (err, deal) ->
      if err
        reply "Could not find the deal. Please try again."
        console.log "Error: #{err}"
      else
        deal.deleted = rp.deleted or deal.deleted
        deal.disabled = rp.disabled or deal.disabled
        deal.lastModified = Date.now()
        deal.owner = rp.owner or deal.owner
        deal.ownerId = rp.ownerId or deal.ownerId
        deal.status = rp.status or deal.status
        deal.source = rp.source or deal.source
        deal.title = rp.title or deal.title
        deal.product = rp.product or deal.product
        deal.backgroundImage = rp.backgroundImage or deal.backgroundImage
        deal.image = rp.image or deal.image
        deal.video = rp.video or deal.video
        deal.barCode = rp.barCode or deal.barCode
        deal.availableOnline = rp.availableOnline or deal.availableOnline #true/false
        deal.availableInStores = rp.availableInStores or deal.availableInStores #true/false
        deal.url = rp.url or deal.url
        deal.locationType = rp.locationType or deal.locationType
        deal.locationStreetAddress = rp.locStreetAddress or deal.locationStreetAddress
        deal.locationExtstreetAddress = rp.locExtStreetAddress or deal.locationExtstreetAddress
        deal.locationLocality = rp.locLocality or deal.locationLocality
        deal.locationRegion = rp.locRegion or deal.locationRegion
        deal.locationPostCode = rp.locPostCode or deal.locationPostCode
        deal.locationCountry = rp.locCounty or deal.locationCountry
        deal.locationPrimary = rp.locPrimary or deal.locationPrimary
        deal.locationLng = rp.locLng or deal.locationLng
        deal.locationLat = rp.locLat or deal.locationLat
        deal.description = rp.description or deal.description
        if rp.newSize #true/false
          deal.sizes.push
            label: rp.sizeLabel
        if rp.newColor #true/false
          deal.colors.push
            label: rp.colorLabel
        deal.discountType = rp.discountType or deal.discountType
        deal.discountAmount = rp.discountAmount or deal.discountAmount
        deal.price = rp.price or deal.price
        if rp.newTags #true/false
          deal.tags.push
            label: rp.tagLabel
        deal.save (err) ->
          if err
            reply "Could not save the deal. Please try again."
            console.log "Error: #{err}"
          else
            reply deal: deal

  updateDealSize: (request, reply) ->
    rp = request.payload
    dealId = encodeURI request.params.dealId
    sizeId = rp.sizeId #required
    if not sizeId
      reply "Please select a size to modify."
    else
      Deal.findById dealId, (err, deal) ->
        if err
          reply "Could not find the deal specified. Please try again."
          console.log "Error: #{err}"
        else
          size = deal.sizes.id sizeId
          size.deleted = rp.deleted or size.deleted
          size.disabled = rp.disabled or size.disabled
          size.lastModified = Date.now()
          size.label = rp.sizeLabel or size.label
          deal.save (err) ->
            if err
              reply "Could not save the size. Please try again."
            else
              reply size: size

  updateDealColor: (request, reply) ->
    rp = request.payload
    dealId = encodeURI request.params.dealId
    colorId = rp.colorId #required
    if not colorId
      reply "Please select a color to modify."
    else
      Deal.findById dealId, (err, deal) ->
        if err
          reply "Could not find the deal specified. Please try again."
          console.log "Error: #{err}"
        else
          color = deal.colors.id colorId
          color.deleted = rp.deleted or color.deleted
          color.disabled = rp.disabled or color.disabled
          color.lastModified = Date.now()
          color.label = rp.colorLabel or color.label
          deal.save (err) ->
            if err
              reply "Could not save the color. Please try again."
            else
              reply color: color

  updateDealTag: (request, reply) ->
    rp = request.payload
    dealId = encodeURI request.params.dealId
    tagId = rp.tagId #required
    if not tagId
      reply "Please select a tag to modify."
    else
      Deal.findById dealId, (err, deal) ->
        if err
          reply "Could not find the deal specified. Please try again."
          console.log "Error: #{err}"
        else
          tag = deal.tags.id tagId
          tag.deleted = rp.deleted or tag.deleted
          tag.disabled = rp.disabled or tag.disabled
          tag.lastModified = Date.now()
          tag.label = rp.tagLabel or tag.label
          deal.save (err) ->
            if err
              reply "Could not save the color. Please try again."
            else
              reply tag: tag

  deleteDeal: (request, reply) ->
    dealId = encodeURI request.params.dealId
    Deal.findById dealId, (err, deal) ->
      if err
        reply "Could not find the deal. Please try again."
        console.log "Error: #{err}"
      else
        deal.deleted = true
        deal.save (err) ->
          if err
            reply "Could not delete the deal. Please try again."
            console.log "Error: #{err}"
          else
            reply "The deal has been deleted." 