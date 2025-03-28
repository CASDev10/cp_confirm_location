import 'package:cp_confirm_location/modules/dashboard/models/order_detail_response.dart';
import 'package:dio/dio.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';
import '../models/base_response.dart';

class DashboardRepository {
  final DioClient _dioClient;

  final _log = logger(DashboardRepository);

  DashboardRepository({required DioClient dioClient}) : _dioClient = dioClient;

  Future<OrderDetailResponse> fetchOrderDetail(int orderNo) async {
    try {
      var response = await _dioClient.get(
        Endpoints.orderDetails,
        queryParameters: {"InvoiceNo": orderNo},
      );
      return OrderDetailResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> updateLocation(
    int orderNo,
    double lat,
    double lng,
  ) async {
    try {
      var response = await _dioClient.post(
        Endpoints.updateLocation,
        queryParameters: {"InvoiceNo": orderNo, "LAT": lat, "LONG": lng},
      );
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}
