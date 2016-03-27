Package.describe({
  name: 'meteor-mongo-collection',
  version: '0.9.0',
  summary: 'Meteor collections with easy-to-use class functions and collection hooks.',
});

Package.on_use(function (api) {
  api.versionsFrom("METEOR@1.2");

  api.use([
    'underscore',
    'coffeescript',
    'mikowals:batch-insert',
    'momentjs:moment',
    'mrt:moment-timezone'
  ], ['client', 'server']);

  api.addFiles([
    'lib/mongo_collection.coffee'
  ], ['client', 'server']);
});
