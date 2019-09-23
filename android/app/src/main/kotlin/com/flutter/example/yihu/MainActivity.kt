package com.flutter.example.yihu

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import io.flutter.plugin.common.MethodChannel
import android.net.Uri
import android.content.pm.PackageManager
import android.content.pm.PackageInfo
import android.app.Activity
import java.net.HttpURLConnection
import java.net.URL






class MainActivity: FlutterActivity() {
  private val OPENTAOBAO = "samples.flutter.io/taobao"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, OPENTAOBAO).setMethodCallHandler { call, result ->
      if (call.method == "openTaobao") {
        if (isPkgInstalled(this, "com.taobao.taobao")) {
          val text = call.argument<String>("url");
          val intent = Intent()
          intent.action = "Android.intent.action.VIEW"
          val uri = Uri.parse(text.toString()) // 商品地址
          intent.data = uri
          intent.setClassName("com.taobao.taobao", "com.taobao.tao.detail.activity.DetailActivity")
          intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK  //不设置新任务将不会跳转淘宝，直接在本APP内打开商品链接
          startActivity(intent)

        } else {
          ToastUtil.showShort(this,"您还没有安装淘宝客户端！");
        }
      } else {
        result.notImplemented()
      }
    }
  }




  /**
   * 检查手机上是否安装了指定的软件
   *
   * @param context context
   * @param pkgName 应用包名
   * @return true:已安装；false：未安装
   */
  fun isPkgInstalled(context: Context, pkgName: String): Boolean {
    var packageInfo: PackageInfo?
    try {
      packageInfo = context.packageManager.getPackageInfo(pkgName, 0)
    } catch (e: PackageManager.NameNotFoundException) {
      packageInfo = null
      e.printStackTrace()
    }

    return packageInfo != null
  }



}
