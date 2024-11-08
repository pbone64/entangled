namespace Entangled.Daemon {
    public sealed class Application : GLib.Application {
        public static void launch_background(Xdp.Portal portal, Xdp.Parent parent) {
            var command_line = new GenericArray<unowned string>(1);
            command_line.add("entangled-daemon");
            portal.request_background.begin(
                parent,
                "Synchronize files",
                command_line,
                Xdp.BackgroundFlags.AUTOSTART,
                null
            );
        }

        public Application() {
            Object(
                application_id: "io.github.pbone64.Entangled.Daemon",
                flags: ApplicationFlags.IS_SERVICE
            );
        }

        public override bool dbus_register(DBusConnection connection, string object_path) throws Error {
            connection.register_object(object_path, new Entangled.Daemon.Bus.WebAPIBus());

            return base.dbus_register(connection, object_path);
        }
    }
}

