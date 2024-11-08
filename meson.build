project('entangled', ['c', 'vala'],
  version: '0.1.0',
  meson_version: '>= 1.1.0',
  default_options: [ 'warning_level=2', 'werror=false', ],
)

i18n = import('i18n')
gnome = import('gnome')

subdir('app')
subdir('daemon')

gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)

