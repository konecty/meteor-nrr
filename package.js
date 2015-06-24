Package.describe({
  name: 'konecty:nrr',
  summary: 'Non-Reactive render',
  version: '2.0.0',
  git: 'https://github.com/Konecty/meteor-nrr'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.3.1');

  api.use('coffeescript');
  api.use("templating", "client", {weak: true});

  api.addFiles('konecty:nrr.coffee');
});