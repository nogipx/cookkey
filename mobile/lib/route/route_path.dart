import 'package:equatable/equatable.dart';
import 'package:uri/uri.dart';

// ignore: must_be_immutable
class AppRoute extends Equatable {
  final String template;

  UriTemplate _uriTemplate;
  UriTemplate get uriTemplate => _uriTemplate;

  final Uri actualUri;

  AppRoute(this.template, {this.actualUri}) {
    _uriTemplate = UriTemplate(template);
  }

  AppRoute copyWith({Uri actualUri}) {
    return AppRoute(template, actualUri: actualUri ?? this.actualUri);
  }

  Uri fill(Map<String, dynamic> data) => UriParser(uriTemplate).expand(data);

  @override
  List<Object> get props => [template];
}
