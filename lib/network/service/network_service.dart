import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/static_configs.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: EstateConfigs.baseUrl)
abstract class NetworkClient {
  factory NetworkClient(Dio dio) = _NetworkClient;

  @GET("/api/auth/me")
  Future<dynamic> getUserProfile();

  @GET("/api/utils/home-contents")
  Future<dynamic> getHomeContent();

  @GET("/api/utils/analytics")
  Future<dynamic> getAnalytics();

  @GET("/api/properties/{id}")
  Future<dynamic> getPublicProperty(@Path("id") String id);

  @GET("/api/properties/{id}/related-properties")
  Future<dynamic> getRelatedProperties(
    @Path("id") String id, {
    @Query("limit") int limit = 4,
  });

  @GET("/api/property-categories")
  Future<dynamic> getPropertyCategories(@Queries() Map<String, dynamic> query);

  @GET("/api/properties")
  Future<dynamic> getManagedProperties(@Queries() Map<String, dynamic> query);

  @GET("/api/properties/saved-properties")
  Future<dynamic> getSavedProperties(@Queries() Map<String, dynamic> query);

  @GET("/api/properties/search")
  Future<dynamic> searchPublicProperties(@Queries() Map<String, dynamic> query);

  @POST("/api/auth/user/sign-in")
  Future<dynamic> login(@Body() Map<String, dynamic> body);

  @POST("/api/auth/user/sign-up")
  Future<dynamic> signUp(@Body() Map<String, dynamic> body);

  @POST("/api/auth/user/forgot-password")
  Future<dynamic> requestForgotPasswordOtp(@Body() Map<String, dynamic> body);

  @POST("/api/auth/user/reset-password")
  Future<dynamic> resetPassword(@Body() Map<String, dynamic> body);

  @POST("/api/properties/{id}/report")
  Future<dynamic> reportProperty(
    @Path("id") String id,
    @Body() Map<String, dynamic> body,
  );

  @POST("/api/properties")
  @MultiPart()
  Future<dynamic> createProperty(@Body() FormData body);

  @POST("/api/properties/{id}/save")
  Future<dynamic> saveProperty(@Path("id") String id);

  @POST("/api/property-categories")
  @MultiPart()
  Future<dynamic> createPropertyCategory(@Body() FormData body);

  @POST("/api/auth/me/kyc")
  @MultiPart()
  Future<dynamic> submitKyc(@Body() FormData body);

  @POST("/api/utils/fingerprint")
  Future<dynamic> registerFingerprint(@Body() Map<String, dynamic> body);

  @PUT("/api/auth/me")
  @MultiPart()
  Future<dynamic> updateProfile(@Body() FormData body);

  @PUT("/api/properties/{id}")
  @MultiPart()
  Future<dynamic> updateProperty(@Path("id") String id, @Body() FormData body);

  @PUT("/api/property-categories/{id}")
  @MultiPart()
  Future<dynamic> updatePropertyCategory(
    @Path("id") String id,
    @Body() FormData body,
  );

  @PUT("/api/auth/me/kyc/{id}")
  @MultiPart()
  Future<dynamic> updateKyc(@Path("id") String id, @Body() FormData body);

  @DELETE("/api/auth/me")
  Future<dynamic> deleteAccount();

  @DELETE("/api/auth/me/kyc/{id}")
  Future<dynamic> deleteKyc(@Path("id") String id);

  @DELETE("/api/properties/{id}")
  Future<dynamic> deleteProperty(@Path("id") String id);

  @DELETE("/api/properties/saved-properties/{id}")
  Future<dynamic> unsaveProperty(@Path("id") String id);

  @DELETE("/api/property-categories/{id}")
  Future<dynamic> deletePropertyCategory(@Path("id") String id);
}
