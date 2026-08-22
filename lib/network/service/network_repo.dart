import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/analytics.dart';
import '../../models/kyc_document.dart';
import '../../models/property.dart';
import '../../models/property_category.dart';
import '../../models/property_search_response.dart';
import '../../models/saved_property.dart';
import '../../models/user_profile.dart';
import '../model/base_api_response.dart';
import 'network_service.dart';

class NetworkRepo {
  final NetworkClient _client;
  final Dio _dio;

  NetworkRepo(this._client, this._dio);

  Future<BaseResponse<UserProfile>> login(Map<String, dynamic> body) async {
    final response = await _client.login(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<UserProfile>(response);
  }

  Future<BaseResponse<UserProfile>> getUserProfile() async {
    final response = await _client.getUserProfile() as Map<String, dynamic>;
    return BaseResponse.fromMap<UserProfile>(response);
  }

  Future<BaseResponse<UserProfile>> updateProfile({
    File? photo,
    String? name,
    String? phone,
    String? email,
    String? password,
    String? oldPassword,
  }) async {
    final body = {
      if (photo != null)
        "photo": await MultipartFile.fromFile(
          photo.path,
          filename: photo.path.split('/').last,
        ),
      if (name != null) "name": name,
      if (phone != null) "phone": phone,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (oldPassword != null) "oldPassword": oldPassword,
    };

    final response =
        await _client.updateProfile(FormData.fromMap(body))
            as Map<String, dynamic>;
    return BaseResponse.fromMap<UserProfile>(response);
  }

  Future<BaseResponse<dynamic>> getHomeContent() async {
    final response = await _client.getHomeContent() as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<Analytics>> getAnalytics() async {
    final response = await _client.getAnalytics() as Map<String, dynamic>;
    return BaseResponse.fromMap<Analytics>(response);
  }

  Future<BaseResponse<Property>> getPublicProperty(String propertyId) async {
    final response =
        await _client.getPublicProperty(propertyId) as Map<String, dynamic>;
    return BaseResponse.fromMap<Property>(response);
  }

  Future<BaseResponse<List<Property>>> getRelatedProperties(
    String propertyId, {
    int limit = 4,
  }) async {
    final response =
        await _client.getRelatedProperties(propertyId, limit: limit)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<List<Property>>(response);
  }

  Future<PropertySearchResponse> searchPublicProperties({
    String? purpose,
    String? categories,
    String? title,
    String? location,
    String? price,
    String? sort,
    int page = 1,
    int pageSize = 20,
    Map<String, dynamic>? amenityFilters,
  }) async {
    final query = {
      "page": page,
      "pageSize": pageSize,
      if (purpose != null) "purpose": purpose,
      if (categories != null) "categories": categories,
      if (title != null) "title": title,
      if (location != null) "location": location,
      if (price != null) "price": price,
      if (sort != null) "sort": sort,
      if (amenityFilters != null) ...amenityFilters,
    };

    final response =
        await _client.searchPublicProperties(query) as Map<String, dynamic>;
    return PropertySearchResponse.fromMap(response);
  }

  Future<BaseResponse<List<Property>>> getManagedProperties({
    int page = 1,
    int pageSize = 20,
    String? title,
    String? user,
    String? status,
  }) async {
    final query = {
      "page": page,
      "pageSize": pageSize,
      if (title != null) "title": title,
      if (user != null) "user": user,
      if (status != null) "status": status,
    };

    final response =
        await _client.getManagedProperties(query) as Map<String, dynamic>;
    return BaseResponse.fromMap<List<Property>>(response);
  }

  Future<BaseResponse<List<SavedProperty>>> getSavedProperties({
    int page = 1,
    int pageSize = 20,
  }) async {
    final query = {"page": page, "pageSize": pageSize};

    final response =
        await _client.getSavedProperties(query) as Map<String, dynamic>;
    return BaseResponse.fromMap<List<SavedProperty>>(response);
  }

  Future<BaseResponse<void>> saveProperty(String propertyId) async {
    final response =
        await _client.saveProperty(propertyId) as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<BaseResponse<void>> unsaveProperty(String savedPropertyId) async {
    final response =
        await _client.unsaveProperty(savedPropertyId) as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<BaseResponse<void>> reportProperty(
    String propertyId, {
    required String subject,
    required String content,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
  }) async {
    final body = {
      "subject": subject,
      "content": content,
      "contactInfo": {
        if (contactName != null) "name": contactName,
        if (contactEmail != null) "email": contactEmail,
        if (contactPhone != null) "phone": contactPhone,
      },
    };

    final response =
        await _client.reportProperty(propertyId, body)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<BaseResponse<List<PropertyCategory>>> getPropertyCategories({
    int page = 1,
    int pageSize = 100,
    String? title,
    String? id,
  }) async {
    final query = {
      "page": page,
      "pageSize": pageSize,
      if (title != null) "title": title,
      if (id != null) "_id": id,
    };

    final response =
        await _client.getPropertyCategories(query) as Map<String, dynamic>;
    return BaseResponse.fromMap<List<PropertyCategory>>(response);
  }

  Future<BaseResponse<PropertyCategory>> createPropertyCategory({
    required String title,
    required File image,
    String? pageTitle,
    String? description,
    String? article,
    String? parentCategoryId,
  }) async {
    final body = await _buildPropertyCategoryFormMap(
      title: title,
      image: image,
      pageTitle: pageTitle,
      description: description,
      article: article,
      parentCategoryId: parentCategoryId,
    );

    final response =
        await _client.createPropertyCategory(FormData.fromMap(body))
            as Map<String, dynamic>;
    return BaseResponse.fromMap<PropertyCategory>(response);
  }

  Future<BaseResponse<PropertyCategory>> updatePropertyCategory(
    String categoryId, {
    required String title,
    required File image,
    String? pageTitle,
    String? description,
    String? article,
    String? parentCategoryId,
  }) async {
    final body = await _buildPropertyCategoryFormMap(
      title: title,
      image: image,
      pageTitle: pageTitle,
      description: description,
      article: article,
      parentCategoryId: parentCategoryId,
    );

    final response =
        await _client.updatePropertyCategory(categoryId, FormData.fromMap(body))
            as Map<String, dynamic>;
    return BaseResponse.fromMap<PropertyCategory>(response);
  }

  Future<BaseResponse<void>> deletePropertyCategory(String categoryId) async {
    final response =
        await _client.deletePropertyCategory(categoryId)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<Map<String, dynamic>> _buildPropertyCategoryFormMap({
    required String title,
    required File image,
    String? pageTitle,
    String? description,
    String? article,
    String? parentCategoryId,
  }) async {
    return {
      "title": title,
      "image": await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
      if (pageTitle != null) "pageTitle": pageTitle,
      if (description != null) "description": description,
      if (article != null) "article": article,
      if (parentCategoryId != null) "category": parentCategoryId,
    };
  }

  Future<BaseResponse<Property>> createProperty({
    required String title,
    required String description,
    required List<String> categoryIds,
    required PropertyAddress address,
    required String status,
    required bool forSale,
    required bool forRent,
    required List<File> media,
    String visibility = "public",
    num? salePrice,
    num? rentPrice,
    Map<String, dynamic>? amenities,
    List<String>? tags,
    String? userId,
  }) async {
    final body = await _buildPropertyFormData(
      title: title,
      description: description,
      categoryIds: categoryIds,
      address: address,
      status: status,
      visibility: visibility,
      forSale: forSale,
      forRent: forRent,
      media: media,
      salePrice: salePrice,
      rentPrice: rentPrice,
      amenities: amenities,
      tags: tags,
      userId: userId,
    );

    final response =
        await _client.createProperty(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<Property>(response);
  }

  Future<BaseResponse<Property>> updateProperty(
    String propertyId, {
    required String title,
    required String description,
    required List<String> categoryIds,
    required PropertyAddress address,
    required String status,
    required bool forSale,
    required bool forRent,
    required List<File> media,
    String visibility = "public",
    num? salePrice,
    num? rentPrice,
    Map<String, dynamic>? amenities,
    List<String>? tags,
    String? userId,
  }) async {
    final body = await _buildPropertyFormData(
      title: title,
      description: description,
      categoryIds: categoryIds,
      address: address,
      status: status,
      visibility: visibility,
      forSale: forSale,
      forRent: forRent,
      media: media,
      salePrice: salePrice,
      rentPrice: rentPrice,
      amenities: amenities,
      tags: tags,
      userId: userId,
    );

    final response =
        await _client.updateProperty(propertyId, body)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<Property>(response);
  }

  Future<BaseResponse<void>> deleteProperty(String propertyId) async {
    final response =
        await _client.deleteProperty(propertyId) as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<FormData> _buildPropertyFormData({
    required String title,
    required String description,
    required List<String> categoryIds,
    required PropertyAddress address,
    required String status,
    required String visibility,
    required bool forSale,
    required bool forRent,
    required List<File> media,
    num? salePrice,
    num? rentPrice,
    Map<String, dynamic>? amenities,
    List<String>? tags,
    String? userId,
  }) async {
    final map = {
      "title": title,
      "description": description,
      "categories": jsonEncode(categoryIds),
      "address": jsonEncode(address.toRequestMap()),
      "status": status,
      "visibility": visibility,
      "forSale": forSale,
      "forRent": forRent,
      if (salePrice != null) "salePrice": salePrice,
      if (rentPrice != null) "rentPrice": rentPrice,
      if (amenities != null) "amenities": jsonEncode(amenities),
      if (tags != null) "tags": jsonEncode(tags),
      if (userId != null) "user": userId,
      "media": [
        for (final file in media)
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
      ],
    };

    return FormData.fromMap(map);
  }

  Future<BaseResponse<KycDocument>> submitKyc({
    required String type,
    String? content,
    File? file,
  }) async {
    final body = {
      "type": type,
      if (content != null) "content": content,
      if (file != null)
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
    };

    final response =
        await _client.submitKyc(FormData.fromMap(body))
            as Map<String, dynamic>;
    return BaseResponse.fromMap<KycDocument>(response);
  }

  Future<BaseResponse<KycDocument>> updateKyc(
    String kycId, {
    String? type,
    String? content,
    File? file,
  }) async {
    final body = {
      if (type != null) "type": type,
      if (content != null) "content": content,
      if (file != null)
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
    };

    final response =
        await _client.updateKyc(kycId, FormData.fromMap(body))
            as Map<String, dynamic>;
    return BaseResponse.fromMap<KycDocument>(response);
  }

  Future<BaseResponse<void>> deleteKyc(String kycId) async {
    final response =
        await _client.deleteKyc(kycId) as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }
}
