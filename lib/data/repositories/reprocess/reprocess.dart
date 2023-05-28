import 'package:dio/dio.dart';
import 'package:reconciliation/constants/env_variable.dart';

class ReprocessRepository {
  Future<Response> reprocess({
    required int reconciliationReferenceId,
  }) async {
    final Response response = await Dio().post(
      '$API_URL/enquiry/reprocess',
      data: {"ReconciliationReferenceId": reconciliationReferenceId},
    );
    return response;
  }
}
