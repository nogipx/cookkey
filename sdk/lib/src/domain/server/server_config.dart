import 'dart:io';

class ServerConfig {
  String _host;
  String get host => _host;

  final String domain;
  final int port;
  final String protocol;
  final bool useIp;

  ServerConfig({
    String host = '',
    this.domain = '',
    this.port,
    this.protocol,
    this.useIp = false,
  }) : assert(domain.isNotEmpty || host.isNotEmpty, "Host or Domain must be specified") {
    if (host.isEmpty) {
      print("[ServerConfig] Host not specified. "
          "You might call discoverDomain() to use properly.");
    } else {
      _host = host;
    }
  }

  Future<void> discoverDomain() async {
    try {
      if (domain != null && host == null) {
        final records = await InternetAddress.lookup(
          domain,
          type: InternetAddressType.IPv4,
        );
        if (records != null && records.isNotEmpty) {
          _host = records[0].address;
        }
        return this;
      }
    } catch (e) {
      print('[discoverDomain] $e');
    }
  }

  Uri get origin => Uri.parse('$protocol://${useIp ? host : domain}:$port');
}
