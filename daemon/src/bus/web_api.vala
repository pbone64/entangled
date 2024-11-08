namespace Entangled.Daemon.Bus {
    [DBus(name = "io.github.pbone64.Entangled.Daemon")]
    public sealed class WebAPIBus : Object, Syncthing.RestClient.ConnectionData {
        public const string OBJECT_PATH = "/io/github/pbone64/Entangled/Daemon/STWebAPI";

        private Syncthing.RestClient st_client;

        public int syncthing_port { get; set; }
        public string syncthing_api_key { get; internal set; }

        public string[] LocalFolderIDs { get; }
        public string[] IncomingFolderIDs { get; }

        internal string address { get; set; }
        internal int port { get; set; }

        // TODO REMOVEME!!
        internal string api_key { internal get; set; default = "ndxndwcxdjTsDWy7dLKKL4F5PCcXqiWX"; }

        // prop - incoming_devices
        // prop - outgoing_devices?
        // prop - incoming_folders
        // get api key

        construct {
            st_client = new Syncthing.RestClient(this, "io.github.pbone64.Entangled");
        }

        /*public void syncthing_open_webui() throws GLib.Error {
            // TODO syncthing --browser-only
        }*/

        public bool is_okay() throws GLib.Error {
            return st_client.health_check();
        }

        public string get_folder_name(string id) throws GLib.Error {
            return "Folder Name - NYI";
        }
    }
}

