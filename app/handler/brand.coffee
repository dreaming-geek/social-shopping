models = require '../models'
Brand = models.Brand

module.exports =
  getBrandAll: (request, reply) ->
    Brand.find (err, brands) ->
      if err
        reply "There was an error with this request. Please try again."
        console.log "Error: #{err}"
      reply brands: brands

  getBrand: (request, reply) ->
    brandId = encodeURI request.params.brandId
    Brand.findById brandId, (err, brand) ->
      if err
        reply "Could not find the brand. Please try again later."
        console.log "Error #{err}"
      reply brand: brand

  createBrand: (request, reply) ->
    rp = request.payload
    newBrand = new Brand()
    newBrand.name = rp.name
    if rp.newAddress
      newBrand.addresses = [
        type: rp.addressType
        streetAddress: rp.streetAddress
        extStreetAddress: rp.extStreetAddress
        locality: rp.locality
        region: rp.region
        postCode: rp.postCode
        country: rp.country
        primary: rp.primaryAddress #true/false
      ]
    if rp.newPhone
      newBrand.phoneNumbers = [
        type: rp.phoneType
        phoneNumber: rp.phoneNumber
        primary: rp.primaryPhone #true/false
      ]
    if rp.newRegion
      newBrand.brandRegion = [
        brand: rp.regionName
        regions: [
          region: rp.regionRegion
        ]
      ]
    if rp.newRank
      newBrand.ranks = [
        name: rp.rankName
        pointMin: rp.rankMin
        pointMax: rp.rankMax
      ]
    if rp.newPointValuation
      newBrand.pointValuations = [
        module: rp.valuationModule
        action: rp.valuationAction
        points: rp.valuationPoints #number
      ]
    if rp.newBadge
      newBrand.badges = [
        module: rp.badgeModule
        action: rp.badgeAction
        threshold: rp.badgeThreshold
        name: rp.badgeName
        asset: rp.badgeAsset
      ]
    newBrand.save (err) ->
      if err
        reply "Could not save brand. Please try again."
        console.log "Error: #{err}"
      else
        reply brand: newBrand

  updateBrand: (request, reply) ->
    brandId = encodeURI request.params.brandId
    rp = request.payload
    Brand.findById brandId, (err, brand) ->
      if err
        reply "Could not find brand! Please try again."
        console.log "Error: #{err}"
      else
        brand.deleted = rp.deleted or brand.deleted
        brand.disabled = rp.disabled or brand.disabled
        brand.lastModified = Date.now()
        brand.name = rp.name or brand.name
        if rp.newAddress
          brand.addresses.push
            type: rp.addressType
            streetAddress: rp.streetAddress
            extStreetAddress: rp.extStreetAddress
            locality: rp.locality
            region: rp.region
            postCode: rp.postCode
            country: rp.country
            primary: rp.primaryAddress #true/false
        if rp.newPhone
          brand.phoneNumbers.push
            type: rp.phoneType
            phoneNumber: rp.phoneNumber
            primary: rp.primaryPhone #true/false
        # modules are true/false
        brand.modules.feedback = rp.moduleFeedback or brand.modules.feedback
        brand.modules.deals = rp.moduleDeals or brand.modules.deals
        brand.modules.gallery = rp.moduleGallery or brand.modules.gallery
        brand.modules.events = rp.moduleEvents or brand.modules.events
        if rp.newRegion
          brand.brandRegion.push
            brand: rp.regionName
            regions: rp.regionRegion #array
        if rp.newRank
          brand.ranks.push
            name: rp.rankName
            pointMin: rp.rankMinimum
            pointMax: rp.rankMaximum
        if rp.newPointValuation
          brand.pointValuations.push
            module: rp.valuationModule
            action: rp.valuationAction
            points: rp.valuationPoints #number
        if rp.newBadge
          brand.badges.push
            module: rp.badgeModule
            action: rp.badgeAction
            threshold: rp.badgeThreshold
            name: rp.badgeName
            asset: rp.badgeAsset
        brand.save (err) ->
          if err
            reply "Error occured while trying to save. Please try again."
            console.log "Error: #{err}"
          reply brand: brand

  deleteBrand: (request, reply) ->
    _id = encodeURI request.params._id
    Brand.findById _id, (err, brand) ->
      if err
        reply "Could not find Brand."
        console.log "Error: #{err}"
      else
        brand.deleted = true
        brand.save (err) ->
          if err
            reply "Error occured while trying to delete. Please try again."
            console.log "Error: #{err}"
          reply "#{brand.name} has been deleted."

  updateBrandAddress: (request, reply) ->
    rp = request.payload
    brandId = encodeURI request.params.brandId
    addressId = rp.addressId
    if not addressId
      reply "Please select an address."
    Brand.findOne brandId, (err, brand) ->
      if err
        reply "Could not find the brand specified. Please try again."
        console.log "Error #{err}"
      address = brand.addresses.id addressId
      address.type = rp.addressType or address.type
      address.streetAddress = rp.streetAddress or address.streetAddress
      address.extStreetAddress = rp.streetAddress or address.extStreetAddress
      address.locality = rp.locality or address.locality
      address.region = rp.region or address.region
      address.postCode = rp.postCode or address.postCode
      address.country = rp.country or address.country
      address.primary = rp.primaryAddress or address.primary
      brand.save (err) ->
        if err
          reply "There was an error when saving the address."
          console.log "Error: #{err}"
        reply address: address

  updateBrandPhone: (request, reply) ->
    rp = request.payload
    brandId = encodeURI request.params.brandId
    phoneId = rp.phoneId
    if not phoneId
      reply "Please select a phone number."
    else
      Brand.findOne brandId, (err, brand) ->
        if err
          reply "Could not find the brand specified. Please try again."
          console.log "Error #{err}"
        phone = brand.phoneNumbers.id phoneId
        phone.type = rp.phoneType or phone.type
        phone.phoneNumber = rp.phoneNumber or phone.phoneNumber
        phone.primary = rp.primaryPhone or phone.primary
        brand.save (err) ->
          if err
            reply "There was an error when saving the phone number."
            console.log "Error: #{err}"
          reply phone: phone

  updateBrandRegion: (request, reply) ->
    rp = request.payload
    brandId = encodeURI request.params.brandId
    regionId = rp.regionId
    if not regionId
      reply "Please select a brand region."
    else
      Brand.findOne brandId, (err, brand) ->
        if err
          reply "Could not find the brand specified. Please try again."
          console.log "Error #{err}"
        brandRegion = brand.brandRegion.id regionId
        brandRegion.deleted = rp.deleted or brandRegion.deleted
        brandRegion.disabled = rp.disabled or brandRegion.disabled
        brandRegion.lastModified = Date.now()
        brandRegion.brand = rp.regionName or brandRegion.brand
        brandRegion.regions[0].region = rp.regionRegion or brandRegion.regions[0].region
        brand.save (err) ->
          if err
            reply "There was an error when saving the region information."
            console.log "Error: #{err}"
          reply region: brandRegion

  updateBrandRank: (request, reply) ->
    rp = request.payload
    brandId = encodeURI request.params.brandId
    rankId = rp.rankId
    if not rankId
      reply "Please select a rank."
    else
      Brand.findOne brandId, (err, brand) ->
        if err
          reply "Could not find the brand specified. Please try again."
          console.log "Error #{err}"
        rank = brand.ranks.id rankId
        rank.deleted = rp.deleted or rank.deleted
        rank.disabled = rp.disabled or rank.disabled
        rank.lastModified = Date.now()
        rank.name = rp.rankName or rank.name
        rank.pointMin = rp.pointMin ? rank.pointMin #number
        rank.pointMax = rp.pointMax ? rank.pointMax #number
        brand.save (err) ->
          if err
            reply "There was an error when saving the rank information."
            console.log "Error: #{err}"
          reply rank: rank

  updateBrandValuation: (request, reply) ->
    rp = request.payload
    brandId = encodeURI request.params.brandId
    valId = rp.valId
    if not valId
      reply "Please select a valuation."
    else
      Brand.findOne brandId, (err, brand) ->
        if err
          reply "Could not find the brand specified. Please try again."
          console.log "Error #{err}"
        valuation = brand.pointValuations.id valId
        valuation.deleted = rp.deleted or valuation.deleted
        valuation.disabled = rp.disabled or valuation.disabled
        valuation.lastModified = Date.now()
        valuation.module = rp.valuationModule or valuation.module
        valuation.action = rp.valuationAction or valuation.action
        valuation.points = rp.valuationPoints or valuation.points #number
        brand.save (err) ->
          if err
            reply "There was an error when saving the point valuation information."
            console.log "Error: #{err}"
          reply pointValue: valuation

  updateBrandBadge: (request, reply) ->
    rp = request.payload
    brandId = encodeURI request.params.brandId
    badgeId = rp.badgeId
    if not badgeId
      reply "Please select a badge."
    else
      Brand.findOne brandId, (err, brand) ->
        if err
          reply "Could not find the brand specified. Please try again."
          console.log "Error #{err}"
        badge = brand.badges.id badgeId
        badge.deleted = rp.deleted or badge.deleted
        badge.disabled = rp.disabled or badge.disabled
        badge.lastModified = Date.now()
        badge.module = rp.module or badge.module
        badge.action = rp.action or badge.action
        badge.threshold = rp.threshold or badge.threshold
        badge.name = rp.name or badge.name
        badge.asset = rp.asset or badge.asset
        brand.save (err) ->
          if err
            reply "There was an error when saving the badge information."
            console.log "Error: #{err}"
          reply badge: badge