namespace Entangled.Devices {
    [GtkTemplate(ui = "/io/github/pbone64/Entangled/App/ui/devices/dialog_add_device.ui")]
    public class DialogAddDevice : Adw.Dialog {
        [GtkChild] public unowned Adw.EntryRow device_name_entry;
        [GtkChild] public unowned Adw.EntryRow device_id_entry;
        [GtkChild] public unowned Gtk.Revealer device_name_feedback_label_revealer;
        [GtkChild] public unowned Gtk.Revealer device_id_feedback_label_revealer;

        public string device_name_text { get; protected set; default = ""; }
        public string device_id_text { get; protected set; default = ""; }

        public bool has_device_name { get; protected set; default = false; }
        public bool valid_device_id { get; protected set; default = false; }

        public bool all_entries_valid { get; protected set; default = false; }

        [GtkCallback]
        protected void check_device_name_text() {
            has_device_name = device_name_text.length > 0;
            update_common_validity_flags();

            if (!has_device_name) {
                device_name_feedback_label_revealer.reveal_child = true;
                device_name_entry.add_css_class("warning");
            } else {
                device_name_feedback_label_revealer.reveal_child = false;
                device_name_entry.remove_css_class("warning");
            }
        }

        [GtkCallback]
        protected void check_device_id_text() {
            // TODO better checks
            valid_device_id = device_id_text.length > 0;
            update_common_validity_flags();

            if (!valid_device_id) {
                device_id_feedback_label_revealer.reveal_child = true;
                device_id_entry.add_css_class("warning");
            } else {
                device_id_feedback_label_revealer.reveal_child = false;
                device_id_entry.remove_css_class("warning");
            }
        }

        protected void update_common_validity_flags() {
            all_entries_valid = has_device_name && valid_device_id;
        }

        [GtkCallback]
        protected void on_confirm_clicked() {
            // TODO
            print("name: " + device_name_text + "\n");
            print("device_id: " + device_id_text + "\n");
        }
    }
}

