const String defaultHost = "api.pusherapp.com";
const int defaultHttpsPort = 443;
const int defaultHttpPort = 80;

/// Options to be set on the [Pusher] instance.
class PusherOptions {
  /// Defines a value indicating whether call to the API are over HTTP or HTTPS.
  bool _encrypted;

  int _port = defaultHttpPort;

  String _cluster;

  String _host;

  PusherOptions({bool encrypted: false, int port, String cluster, String host}) {
    this._encrypted = encrypted;

    if (port != null) this._port = port;

    if (cluster != null) this._cluster = cluster;

    if (encrypted && port == null) this._port = defaultHttpsPort;

    _host = host == null ? !hasCluster ? defaultHost : "api-${_cluster}.pusher.com": host;
  }

  /// Indicates whether calls to the Pusher REST API are over HTTP or HTTPS.
  bool get encrypted => _encrypted;

  /// port that the HTTP calls will be made to.
  int get port => _port;

  String get cluster => _cluster;

  bool get hasCluster => _cluster != null;

  String get host =>!hasCluster ? defaultHost : "api-${_cluster}.pusher.com";

  String getBaseUrl() {
    String schema = encrypted ? 'https' : 'http';
    String port = _port == 80 ? '' : ":${_port}";
    return "$schema://$_host$port";
  }
}
