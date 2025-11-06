import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  // Auth endpoints
  Future<Response> login(Map<String, dynamic> data) {
    return _dio.post('/auth/login', data: data);
  }

  Future<Response> register(Map<String, dynamic> data) {
    return _dio.post('/auth/register', data: data);
  }

  // Properties endpoints
  Future<Response> getProperties() {
    return _dio.get('/properties');
  }

  Future<Response> getPropertyById(String id) {
    return _dio.get('/properties/$id');
  }

  Future<Response> createProperty(Map<String, dynamic> data) {
    return _dio.post('/properties', data: data);
  }

  Future<Response> updateProperty(String id, Map<String, dynamic> data) {
    return _dio.patch('/properties/$id', data: data);
  }

  Future<Response> deleteProperty(String id) {
    return _dio.delete('/properties/$id');
  }

  // Contracts endpoints
  Future<Response> getContracts() {
    return _dio.get('/contracts');
  }

  Future<Response> getContractById(String id) {
    return _dio.get('/contracts/$id');
  }

  Future<Response> createContract(Map<String, dynamic> data) {
    return _dio.post('/contracts', data: data);
  }

  // Revenues endpoints
  Future<Response> getRevenues() {
    return _dio.get('/revenues');
  }

  Future<Response> getRevenuesByOwner(String ownerId) {
    return _dio.get('/revenues/owner/$ownerId');
  }

  Future<Response> createRevenue(Map<String, dynamic> data) {
    return _dio.post('/revenues', data: data);
  }

  // Payments endpoints
  Future<Response> getPayments() {
    return _dio.get('/payments');
  }

  Future<Response> getPaymentsByUser(String userId) {
    return _dio.get('/payments/user/$userId');
  }

  Future<Response> createPayment(Map<String, dynamic> data) {
    return _dio.post('/payments', data: data);
  }

  // Notifications endpoints
  Future<Response> getNotificationsByUser(String userId) {
    return _dio.get('/notifications/user/$userId');
  }

  Future<Response> markNotificationAsRead(String id) {
    return _dio.patch('/notifications/$id/read');
  }
}
