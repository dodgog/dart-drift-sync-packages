import 'base_query.dart';

abstract class QueryResponse<T extends BaseQuery>{
  String type;

  QueryResponse(this.type);
}
