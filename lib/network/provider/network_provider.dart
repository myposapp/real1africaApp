import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path/path.dart' as path;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:estate_ease/data/static_configs.dart';
import 'package:estate_ease/network/service/network_service.dart';
import 'package:estate_ease/network/service/network_repo.dart';

// This class can be used to provide the NetworkClient instance to the rest of the app.
class NetworkProvider {
  NetworkProvider() {
    _initialize();
  }

  late final NetworkRepo _networkRepo;
  late final PersistCookieJar _cookieJar;

  NetworkRepo get networkRepo => _networkRepo;

  void clearCookies() {
    _cookieJar.deleteAll();
  }

  void _initialize() async {
    final directory = await getApplicationSupportDirectory();

    _cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(path.join(directory.path, ".cookies/")),
    );

    final dio = Dio(BaseOptions(validateStatus: (_) => true));
    dio.interceptors.add(CookieManager(_cookieJar, ignoreInvalidCookies: true));

    _networkRepo = NetworkRepo(NetworkClient(dio), dio);
    _registerFingerprint();
  }

  // Future<void> recheckAuth() => _checkAuth();

  Future<void> _registerFingerprint() async {
    try {
      final cookies = await _cookieJar.loadForRequest(
        Uri.parse(EstateConfigs.baseUrl),
      );

      debugPrint(
        'fffffffffffffffffff ${cookies.any((c) => c.name == 'guest_fingerprint').toString()}',
      );

      if (!cookies.any((c) => c.name == 'guest_fingerprint')) {
        await _networkRepo.registerFingerprint();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
