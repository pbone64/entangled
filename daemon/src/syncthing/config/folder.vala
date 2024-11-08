namespace Entangled.Daemon.Syncthing.Config {
    public class Folder : Object {
        [Flags]
        public enum Type {
            SEND, RECEIVE;

            public static Type from_str(string str) {
                Type type = Type.Send | Type.Receive;
            }
        }

        public string id { get; }
        public string label { get; }
        public string path { get; }
        public Type type { get; }
    }
}
