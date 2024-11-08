namespace Entangled.Daemon.Syncthing {
    public class RestClient : Object {
        public interface ConnectionData : Object {
            public const string PROTOCOL = "http";
            public const string REST_API_BASE = "rest";

            internal abstract string address { get; set; }
            internal abstract int port { get; set; }
            internal abstract string api_key { get; set; }

            internal string rest_api_base() {
                return PROTOCOL + "://" + address + ":" + port.to_string() + "/" + REST_API_BASE;
            }
        }

        public const string PROTOCOL = "http";

        public ConnectionData connection_data;
        protected Soup.Session http_session;

        public RestClient(ConnectionData connection_data, string user_agent) {
            this.connection_data = connection_data;

            http_session = new Soup.Session();
            http_session.user_agent = user_agent;
        }

        public string url(string[] parts) {
            string url = connection_data.rest_api_base();
            foreach (string part in parts) {
                if (url != null && url != "") {
                    url += "/" + part;
                }
            }

            return url;
        }

        public string system_url(string endpoint) {
            return url({"system", endpoint});
        }

        public string events_url(string endpoint) {
            return url({"events", endpoint});
        }

        public string db_url(string endpoint) {
            return url({"db", endpoint});
        }

        public string noauth_url(string endpoint) {
            return url({"noauth", endpoint});
        }

        public Soup.Message msg_get(string url) {
            return new Soup.Message("GET", url);
        }

        private string fmt_err(Error err) {
            return err.domain.to_string() + " " + err.code.to_string();
        }

        public T send_and_parse<T>(Soup.Message message) throws RestError {
            string? response_text = null;

            try {
                Bytes response_bytes = http_session.send_and_read(message);
                response_text = (string)response_bytes.get_data();
            } catch (Error err) {
                throw new RestError.OTHER("Could not get response bytes or text: " + fmt_err(err));
            }

            if (response_text == null) {
                throw new RestError.OTHER("Response text was null");
            }

            return json_parse(response_text);
        }

        public T json_parse<T>(string text) throws RestError {
            try {
                return (T)Json.gobject_from_data(typeof(T), text);
            } catch (Error err) {
                throw new RestError.INVALID_RESPONSE("Malformed JSON: " + fmt_err(err));
            }
        }

        public sealed class HealthCheckResponse : Object {
            public string status { get; }
        }

        // TODO check correctness + improve error handling
        public bool health_check() throws RestError {
            var msg = msg_get(noauth_url("health"));
            var response = send_and_parse<HealthCheckResponse>(msg);

            return response.status == "OK";
        }
    }

    public errordomain RestError {
        INVALID_RESPONSE,
        MSG_ERR,
        OTHER
    }
}
