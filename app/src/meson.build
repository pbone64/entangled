# inputs
entangled_app_sources = [
  'main.vala',
  'application.vala',

  'ui/main-window.vala',

  'ui/devices/page.vala',
  'ui/devices/dialog_add_device.vala',

  'ui/folders/page.vala',

  'ui/preferences/window.vala',
]

entangled_app_blueprints = files(
  'ui/help-overlay.blp',
  'ui/main-window.blp',

  'ui/devices/page.blp',
  'ui/devices/dialog_add_device.blp',

  'ui/folders/page.blp',

  'ui/preferences/window.blp',
)

entangled_app_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
  dependency('libportal'),
  dependency('libportal-gtk4'),
]

# gettext
configure_file(
  input: 'config.h.in',
  output: 'config.h',
  configuration: {
    'GETTEXT_PACKAGE': 'entangled',
  },
)

# blueprints & gresources
entangled_app_blueprints = custom_target('blueprints',
  input: entangled_app_blueprints,
  output: '.',
  command: [
    find_program('blueprint-compiler'),
    'batch-compile',
    '@OUTPUT@',
    '@CURRENT_SOURCE_DIR@',
    '@INPUT@',
  ],
)

entangled_app_sources += gnome.compile_resources(
  'entangled-resources',
  'entangled.gresource.xml',
  c_name: 'entangled',
  dependencies: entangled_app_blueprints,
)

# outputs
executable('entangled',
  entangled_app_sources,
  vala_args: [
    '--gresourcesdir=app/src',
  ],
  c_args: [
    '-DGETTEXT_PACKAGE="io.github.pbone64.Entangled"',
  ],
  dependencies: entangled_app_deps,
  install: true,
)

