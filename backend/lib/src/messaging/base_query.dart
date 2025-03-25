import 'base_query_response.dart';

abstract class BaseQuery {
  String userId;
  String token;
  String type;

  BaseQuery(this.userId, this.token, this.type);
}
