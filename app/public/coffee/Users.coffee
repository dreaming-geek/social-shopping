App.UsersRoute = Ember.Route.extend
  model: ->
    this.store.find('user')

# breaks the model into submodels
App.UserSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    addresses: embedded: 'always'
    phoneNumbers: embedded: 'always'

App.UserAddress = DS.Model.extend
  user: DS.belongsTo 'user'
  type: DS.attr 'string'
  streetAddress: DS.attr 'string'
  extStreetAddress: DS.attr 'string'
  primary: DS.attr 'boolean'

App.UserPhone = DS.Model.extend
  user: DS.belongsTo 'user'
  type: DS.attr 'string'
  phoneNumber: DS.attr 'string'
  primary: DS.attr 'string'

# User model
App.User = DS.Model.extend
  firstName: DS.attr 'string'
  emailAddress: DS.attr 'string'
  screenName: DS.attr 'string'
  joinDate: DS.attr 'string'
  lastLogin: DS.attr 'string'
  lastModified: DS.attr 'string'
  birthday: DS.attr 'string'
  bio: DS.attr 'string'
  gender: DS.attr 'string'
  source: DS.attr 'string'
  gps: DS.attr 'boolean'
  newAddress: DS.attr 'boolean'
  newPhone: DS.attr 'boolean'
  addresses: DS.hasMany 'userAddress'
  phoneNumbers: DS.hasMany 'userPhone'