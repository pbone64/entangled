using GLib;

// TODO maybe delete
namespace Entangled {
    public class AppSettings {
        public const string ID = "io.github.pbone64.Entangled";
        private static Settings settings = new Settings(ID);

        public const string KEY_SYNCTHING_PORT = "syncthing-port";
        public static int syncthing_port { get; set; }

        static construct {
            settings.bind(KEY_SYNCTHING_PORT, "syncthing_port");
        }
    }
}
