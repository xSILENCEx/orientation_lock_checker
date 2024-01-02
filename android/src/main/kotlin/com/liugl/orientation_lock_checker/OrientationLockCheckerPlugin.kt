package com.liugl.orientation_lock_checker


import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import android.provider.Settings

/** OrientationLockCheckerPlugin */
class OrientationLockCheckerPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var context: Context

  private fun getScreenOrientationLockStatus(): Boolean {
    try {
      val orientationLock = Settings.System.getInt(context.contentResolver,Settings.System.ACCELEROMETER_ROTATION)
      return orientationLock == 0
    } catch (e: Settings.SettingNotFoundException) {
      e.printStackTrace()
    }

    return false
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "orientation_lock_checker")
    channel.setMethodCallHandler(this)

    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "isDeviceOrientationLocked") {
      result.success(getScreenOrientationLockStatus())
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
