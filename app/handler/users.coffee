models = require '../models'
User = models.User

module.exports =

  createUser: (request, reply) ->
    rp = request.payload
    newUser = new User()
    newUser.screenName = rp.screenName
    newUser.firstName = rp.firstName
    newUser.emailAddress = rp.emailAddress
    newUser.birthday = new Date rp.birthday #yyyy, mm, dd
    newUser.bio = rp.bio
    newUser.gender = rp.gender
    newUser.source = rp.source
    newUser.settings.gps = rp.gps # true/false
    if rp.newAddress # true/false
      newUser.addresses = [
        type: rp.addressType
        streetAddress: rp.streetAddress
        extStreetAddress: rp.extStreetAddress
        locality: rp.locality
        region: rp.region
        postCode: rp.postCode
        country: rp.country
        primary: rp.primaryAddress
      ]
    if rp.newPhone
      newUser.phoneNumbers = [
        type: rp.phoneType
        phoneNumber: rp.phoneNumber
        primary: rp.primaryPhoneNumber # true/false
      ]
    newUser.save (err) ->
      reply err
    reply user: newUser

  updateUser: (request, reply) ->
    userId = encodeURI request.params.userId
    rp = request.payload
    User.findById userId, (err, user) ->
      if err
        reply "Could not find user! Please try again."
        console.log "Error: #{err}"
      else
        user.deleted = rp.deleted or user.deleted
        user.disabled = rp.disabled or user.disabled
        user.lastModified = Date.now()
        user.lastLogin = rp.lastLogin or user.lastLogin
        user.screenName = rp.screenName or user.screenName
        user.firstName = rp.firstName or user.firstName
        user.emailAddress = rp.emailAddress or user.emailAddress
        user.birthday = new Date rp.birthday or user.birthday
        user.bio = rp.bio or user.bio
        user.gender = rp.gender or user.gender
        user.avatar = rp.avatar or user.avatar
        user.source = rp.source or user.source
        user.settings.publicProfile = rp.publicProfile or user.settings.publicProfile
        user.settings.pushNotifications = rp.pushNotifications or user.settings.publicProfile
        user.settings.gps = rp.gps or user.settings.gps
        if rp.newNotification # new notification
          user.settings.whichNotifications.push
            name: rp.notificationName
            enabled: rp.noticationEnabled
        if rp.newAddress # new address
          user.addresses.push
            type: rp.addressType
            streetAddress: rp.streetAddress
            extStreetAddress: rp.extStreetAddress
            locality: rp.locality
            region: rp.region
            postCode: rp.postCode
            country: rp.country
            primary: rp.primaryAddress
        if rp.newPhone
          user.phoneNumbers.push
            type: rp.phoneType
            phoneNumber: rp.phoneNumber
            primary: rp.phonePrimary

        user.save (err) ->
          if err
            reply "Error occured while trying to save. Please try again."
            console.log "Error: #{err}"
          reply user: user


  getUsers: (request, reply) ->
    User.find (err, users) ->
      if err
        reply err
      reply
        users: users

  getUser: (request, reply) ->
    userId = encodeURI request.params.userId
    User.findById userId, (err, user) ->
      if err
        reply err
      reply user

  deleteUser: (request, reply) ->
    userId = encodeURI request.params.userId
    User.findById userId, (err, user) ->
      if err
        reply "Could not find user! Please try again."
        console.log "Error: #{err}"
      else
        user.deleted = true
        user.save (err) ->
          if err
            reply "Error occured while trying to delete. Please try again."
            console.log "Error: #{err}"
          reply "User: #{user.screenName} has been deleted."

  updateUserAddress: (request, reply) ->
    rp = request.payload
    userId = encodeURI request.params.userId
    addressId = rp.addressId
    User.findById userId, (err, user) ->
      if err
        reply "Could not find the user specified. Please try again."
        console.log "Error: #{err}"
      address = user.addresses.id addressId
      address.type = rp.addressType or address.type
      address.streetAddress = rp.streetAddress or address.streetAddress
      address.extStreetAddress = rp.extStreetAddress or address.extStreetAddress
      address.locality = rp.locality or address.locality
      address.region = rp.region or address.region
      address.postCode = rp.postCode or address.postCode
      address.country = rp.country or address.country
      address.primary = rp.primaryAddress or address.primary
      user.save (err) ->
        if err
          reply "There was an error when saving the address."
          console.log "Error: #{err}"
        reply address: address

  updateUserPhone: (request, reply) ->
    rp = request.payload
    userId = encodeURI request.params.userId
    phoneId = rp.phoneId
    console.log phoneId
    User.findById userId, (err, user) ->
      if err
        reply err
      if not phoneId
        reply "Please select a phone number."
      else
        phone = user.phoneNumbers.id phoneId
        phone.type = rp.phoneType or phone.type
        phone.phoneNumber = rp.phoneNumber or phone.phoneNumber
        phone.primary = rp.primaryPhone or phone.primary
        user.save (err) ->
          if err
            reply "There was an error when saving the phone number."
            console.log "Error: #{err}"
          reply phone: phone




