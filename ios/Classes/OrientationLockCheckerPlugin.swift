import Flutter
import UIKit

public class OrientationLockCheckerPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "orientation_lock_checker", binaryMessenger: registrar.messenger())
        let instance = OrientationLockCheckerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isDeviceOrientationLocked":
            result(getScreenOrientationLockStatus())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func getScreenOrientationLockStatus() -> Bool {
        let device = UIDevice.current
        return device.orientation.isPortrait
    }
}
