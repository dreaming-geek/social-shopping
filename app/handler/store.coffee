models = require '../models'
Store = models.Store

module.exports =
  getStoresAll: (request, reply) ->
    Store.find (err, stores) ->
      if err
        reply "There was an error with the request."
        console.log "Error: #{err}"
      reply stores: stores

  getStore: (request, reply) ->
    storeId = encodeURI request.params.storeId
    Store.findById storeId, (err, store) ->
      if err
        reply "Could not find the store. Please try again."
        console.log "Error #{err}"
      reply store: store

  createStore: (request, reply) ->
    rp = request.payload
    newStore = new Store()
    newStore.name = rp.name
    newStore.storeId = rp.storeId
    if rp.newStoreAddress #true/false
      newStore.addresses = [
        type: rp.storeType
        streetAddress: rp.streetAddress
        locality: rp.locality
        region: rp.region
        postCode: rp.postCode
        country: rp.country
        primary: rp.primaryAddress #true/false
        locationLng: rp.longitude
        locationLat: rp.latitude
      ]
    if rp.newStorePhone #true/false
      newStore.phoneNumbers = [
        type: rp.phoneType
        phoneNumber: rp.phoneNumber
        primary: rp.primaryPhone #true/false
      ]
    newStore.save (err) ->
      if err
        reply "Could not save the store. Please try again."
        console.log "Error: #{err}"
      reply store: newStore

  updateStore: (request, reply) ->
    rp = request.payload
    storeId = encodeURI request.params.storeId
    Store.findById storeId, (err, store) ->
      if err
        reply "Could not find the store. Please try again."
        console.log "Error: #{err}"
      else
        store.deleted = rp.deleted or store.deleted
        store.disabled = rp.disabled or store.disabled
        store.lastModified = Date.now()
        store.name = rp.name or store.name
        store.storeId = rp.storeId or store.storeId
        if rp.newStoreAddress
          store.addresses.push
            type: rp.storeType
            streetAddress: rp.streetAddress
            locality: rp.locality
            region: rp.region
            postCode: rp.postCode
            country: rp.country
            primary: rp.primaryAddress #true/false
            locationLng: rp.longitude
            locationLat: rp.latitude
        if rp.newStorePhone
          store.phoneNumbers.push
            type: rp.phoneType
            phoneNumber: rp.phoneNumber
            primary: rp.primaryPhone #true/false
        store.save (err) ->
          if err
            reply "Could not save the store. Please try again."
            console.log "Error: #{err}"
          else
            reply store: store

  updateStoreAddress: (request, reply) ->
    rp = request.payload
    storeId = encodeURI request.params.feedbackId
    addressId = rp.addressId #required
    if not addressId
      reply "Please select an address to modify."
    else
      Store.findById storeId, (err, store) ->
        if err
          reply "Could not find the feedback specified. Please try again."
          console.log "Error: #{err}"
        else
          address = store.addresses.id addressId
          address.type = rp.addressType or address.type
          address.streetAddress = rp.streetAddress or address.streetAddress
          address.locality = rp.locality or address.locality
          address.region = rp.region or address.region
          address.postCode = rp.postCode or address.postCode
          address.country = rp.country or address.country
          address.primary = rp.primaryAddress or address.primary
          store.save (err) ->
            if err
              reply "Could not save the choices. Please try again."
            else
              reply address: address

  updateStorePhone: (request, reply) ->
    rp = request.payload
    storeId = encodeURI request.params.feedbackId
    phoneId = rp.phoneId #required
    if not phoneId
      reply "Please select a phone number to modify."
    else
      Store.findById storeId, (err, store) ->
        if err
          reply "Could not find the feedback specified. Please try again."
          console.log "Error: #{err}"
        else
          phone = store.phoneNumbers.id phoneId
          phone.type = rp.phoneType or phone.type
          phone.phoneNumber = rp.phoneNumber or phone.phoneNumber
          phone.primary = rp.primaryPhone or phone.primary
          store.save (err) ->
            if err
              reply "Could not save the phone number. Please try again."
            else
              reply phone: phone

  deleteStore: (request, reply) ->
    storeId = encodeURI request.params.storeId
    Store.findById storeId, (err, store) ->
      if err
        reply "Could not find the store. Please try again."
        console.log "Error: #{err}"
      else
        store.deleted = true
        store.save (err) ->
          if err
            reply "Could not delete the store. Please try again."
            console.log "Error: #{err}"
          else
            reply "The store has been deleted."

 