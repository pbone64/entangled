namespace Entangled {
    public class Application : Adw.Application {
        public const string APPSTREAM_RES_PATH = "/io/github/pbone64/Entangled/App/data/io.github.pbone64.Entangled.metainfo.xml";

        public Application() {
            Object(
                application_id: "io.github.pbone64.Entangled.App",
                flags: ApplicationFlags.DEFAULT_FLAGS
            );
        }

        protected Xdp.Portal portal;

        construct {
            portal = new Xdp.Portal();

            ActionEntry[] action_entries = {
                { "about", this.on_about_action },
                { "preferences", this.on_preferences_action },
                { "quit", this.quit },
            };

            this.add_action_entries(action_entries, this);
            this.set_accels_for_action("app.quit", { "<primary>q" });
        }

        public override void activate() {
            base.activate();

            var win = this.active_window ?? new Entangled.MainWindow(this);
            win.present();
        }

        private void on_about_action() {
            var about = new Adw.AboutDialog.from_appdata(APPSTREAM_RES_PATH, null) {
                debug_info = "Syncthing Version: " + get_syncthing_version(),

                developers = {
                    "pbone",
                    _("Syncthing Contributors") + "https://github.com/syncthing/syncthing/graphs/contributors"
                },
                license_type = Gtk.License.GPL_3_0
            };

            about.add_link(_("Syncthing's homepage"), "https://syncthing.net/");

            about.add_legal_section("Syncthing", null, Gtk.License.MPL_2_0, null);

            about.present(this.active_window);
        }

        private void on_preferences_action() {
            var preferences = new Entangled.Preferences.Window();

            preferences.present(this.active_window);
        }

        private string get_syncthing_version() {
            string output = "Unknown";

            try {
                string cmd_output;
                GLib.Process.spawn_command_line_sync("syncthing --version", out cmd_output);
                if (cmd_output != null) {
                    output = cmd_output;
                }
            } catch (Error e) {
                output += "(" + e.domain.to_string() + " " + e.code.to_string() + ")";
            }

            output = output.strip();

            return output;
        }
    }
}


