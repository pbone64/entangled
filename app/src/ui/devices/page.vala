namespace Entangled.Devices {
    [GtkTemplate(ui = "/io/github/pbone64/Entangled/App/ui/devices/page.ui")]
    public class Page : Adw.PreferencesPage {
        [GtkChild] public unowned Gtk.Button connect_new_device_button;

        [GtkCallback]
        protected void on_connect_new_device() {
            var dialog = new Entangled.Devices.DialogAddDevice();

            dialog.present(this);
        }
    }
}

