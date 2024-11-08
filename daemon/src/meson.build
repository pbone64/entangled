entangled_daemon_sources = [
  'main.vala',
  'application.vala',

  'bus/config.vala',
  'bus/web_api.vala',

  'syncthing/rest_client.vala',
]

entangled_daemon_deps = [
  dependency('gio-2.0'),
  dependency('libportal'),
  dependency('libsoup-3.0'),
  dependency('json-glib-1.0'),
]

entangled_daemon_includes = include_directories('.')

executable('entangled_daemon',
  entangled_daemon_sources,
  dependencies: entangled_daemon_deps,
  include_directories: entangled_daemon_includes,
  install: true,
)

