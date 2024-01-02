import 'orientation_lock_checker_platform_interface.dart';

class OrientationLockChecker {
  Future<bool> isDeviceOrientationLocked() {
    return OrientationLockCheckerPlatform.instance.isDeviceOrientationLocked();
  }
}
