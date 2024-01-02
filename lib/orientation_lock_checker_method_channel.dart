import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'orientation_lock_checker_platform_interface.dart';

/// An implementation of [OrientationLockCheckerPlatform] that uses method channels.
class MethodChannelOrientationLockChecker
    extends OrientationLockCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('orientation_lock_checker');

  @override
  Future<bool> isDeviceOrientationLocked() async {
    final bool? value =
        await methodChannel.invokeMethod<bool>('isDeviceOrientationLocked');
    return value ?? false;
  }
}
