using GLib;

namespace Entangled.Preferences {
    [GtkTemplate(ui = "/io/github/pbone64/Entangled/App/ui/preferences/window.ui")]
    public class Window : Adw.PreferencesDialog {
        public const string SCHEMA_ID = "io.github.pbone64.Entangled";
        public const string KEY_SYNCTHING_PORT = "syncthing-port";

        public Settings settings { get; default = new Settings(SCHEMA_ID); }

        public int syncthing_port { get; set; }

        construct {
            settings.bind(KEY_SYNCTHING_PORT, this, "syncthing_port", SettingsBindFlags.DEFAULT);
        }
    }
}

