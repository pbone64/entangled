namespace Entangled {
    [GtkTemplate(ui = "/io/github/pbone64/Entangled/App/ui/main-window.ui")]
    public class MainWindow : Adw.ApplicationWindow {
        public MainWindow(Gtk.Application app) {
            Object(application: app);
        }

        static construct {
            typeof(Entangled.Devices.Page).ensure();
            typeof(Entangled.Folders.Page).ensure();
        }
    }
}

