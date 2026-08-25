import 'dart:io';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class DeviceInfoBody {
  static Future<Map<String, dynamic>> build() async {
    final deviceInfo = DeviceInfoPlugin();
    final timezone = await FlutterTimezone.getLocalTimezone();
    final dispatcher = ui.PlatformDispatcher.instance;

    final screenSize = dispatcher.views.first.physicalSize;
    final pixelRatio = dispatcher.views.first.devicePixelRatio;
    final logicalWidth = (screenSize.width / pixelRatio).round();
    final logicalHeight = (screenSize.height / pixelRatio).round();
    final locale = dispatcher.locale.toLanguageTag();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      return {
        "userAgent": _androidUserAgent(android),
        "language": locale,
        "timezone": timezone.identifier,
        "screen": {"height": logicalHeight, "width": logicalWidth},
        "device": {
          "name": android.model,
          "brand": android.brand,
          "manufacturer": android.manufacturer,
          "platform": "Android",
          "osVersion": android.version.release,
          "sdkVersion": android.version.sdkInt,
          "isPhysicalDevice": android.isPhysicalDevice,
        },
      };
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      return {
        "userAgent": _iosUserAgent(ios),
        "language": locale,
        "timezone": timezone,
        "screen": {"height": logicalHeight, "width": logicalWidth},
        "device": {
          "name": ios.name,
          "model": ios.model,
          "localizedModel": ios.localizedModel,
          "platform": "iOS",
          "osVersion": ios.systemVersion,
          "isPhysicalDevice": ios.isPhysicalDevice,
        },
      };
    }

    // Fallback — should never hit in a mobile-only app
    return {
      "language": locale,
      "timezone": timezone,
      "screen": {"height": logicalHeight, "width": logicalWidth},
    };
  }

  /// UA is partially dynamic: OS version and device model are pulled from
  /// the device at runtime. Chrome/WebView version is pinned since retrieving
  /// the real installed WebView version requires a native MethodChannel.
  /// For session logging this is acceptable — OS + model are the meaningful parts.
  static String _androidUserAgent(AndroidDeviceInfo i) {
    return "Mozilla/5.0 "
        "(Linux; Android ${i.version.release}; ${i.model}) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/124.0.0.0 Mobile Safari/537.36";
  }

  /// iOS UA follows the standard Mobile Safari format.
  /// OS version dots are replaced with underscores per convention.
  static String _iosUserAgent(IosDeviceInfo i) {
    final osVersion = i.systemVersion.replaceAll('.', '_');
    return "Mozilla/5.0 "
        "(${i.utsname.machine}; CPU iPhone OS $osVersion like Mac OS X) "
        "AppleWebKit/605.1.15 (KHTML, like Gecko) "
        "Version/17.0 Mobile/15E148 Safari/604.1";
  }
}
