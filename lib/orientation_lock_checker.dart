import 'orientation_lock_checker_platform_interface.dart';

/// Checks if the device orientation is locked.
class OrientationLockChecker {
  /// Returns true if the device orientation is locked.
  Future<bool> isDeviceOrientationLocked() {
    return OrientationLockCheckerPlatform.instance.isDeviceOrientationLocked();
  }
}
