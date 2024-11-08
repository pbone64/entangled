namespace Syncthing {
    public class EventHeader : Object {
        public int id { get; }
        public int global_id { get; }
        public string event_type { get; }
        public DateTime time { get; }
    }

    public class Event<T> : Object {
        public int id { get; }
        public int global_id { get; }
        public string event_type { get; }
        public DateTime time { get; }

        public T data { get; }
    }
}

