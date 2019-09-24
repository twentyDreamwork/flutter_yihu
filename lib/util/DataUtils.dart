import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yihu/config/http_conf.dart';
import 'dart:async';
import '../model/UserInfo.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:dio/dio.dart';
import 'package:device_info/device_info.dart';

class DataUtils {
  static const String SP_AC_TOKEN = "accessToken";
  static const String SP_RE_TOKEN = "refreshToken";
  static const String OPEN_ID = "openid";
  static const String SP_UID = "uid";
  static const String SP_IS_LOGIN = "isLogin";
  static const String SP_EXPIRES_IN = "expiresIn";
  static const String SP_TOKEN_TYPE = "tokenType";

  static const String SP_USER_NICK_NAME = "nickname";
  static const String SP_USER_UNIONID = "unionid";
  static const String SP_USER_HEADIMGURL = "headimgurl";
  static const String SP_USER_PHONE = "phone";

  static const String APPID = "wx2c8beb0c8c6d5aec";
  static const String SERCRET = "76564b2acc0f7e49999df72d18d977dc";

  static const String SP_COLOR_THEME_INDEX = "colorThemeIndex";

  // 保存用户登录信息，data中包含了token等信息
  static saveLoginInfo(Map data) async {
    if (data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String accessToken = data['access_token'];
      await sp.setString(SP_AC_TOKEN, accessToken);
      String refreshToken = data['refresh_token'];
      await sp.setString(SP_RE_TOKEN, refreshToken);
      num uid = data['uid'];
      await sp.setInt(SP_UID, uid);
      String tokenType = data['tokenType'];
      await sp.setString(SP_TOKEN_TYPE, tokenType);
      num expiresIn = data['expires_in'];
      await sp.setInt(SP_EXPIRES_IN, expiresIn);

      await sp.setBool(SP_IS_LOGIN, true);
    }
  }

  // 清除登录信息
  static clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.setString(SP_USER_NICK_NAME, "");
    await sp.setString(SP_USER_UNIONID, "");
    await sp.setString(SP_USER_HEADIMGURL, "");
    await sp.setString(SP_TOKEN_TYPE, "");
    await sp.setInt(SP_EXPIRES_IN, -1);
    await sp.setBool(SP_IS_LOGIN, false);
  }

  // 保存用户个人信息
  static Future<UserInfo> saveUserInfo(Map data) async {
    if (data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String nickname = data['nickname'];
      String unionid = data['unionid'];
      String headimgurl = data['headimgurl'];

      await sp.setString(SP_USER_NICK_NAME, nickname);
      await sp.setString(SP_USER_UNIONID, unionid);
      await sp.setString(SP_USER_HEADIMGURL, headimgurl);

      UserInfo userInfo = UserInfo(
          nickname: nickname, unionid: unionid, headimgurl: headimgurl);
      return userInfo;
    }
    return null;
  }

  // 获取用户信息
  static Future<UserInfo> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    if (isLogin == null || !isLogin) {
      return null;
    }
    UserInfo userInfo = UserInfo();
    userInfo.unionid = sp.getString(SP_USER_UNIONID);
    userInfo.nickname = sp.getString(SP_USER_NICK_NAME);
    userInfo.headimgurl = sp.getString(SP_USER_HEADIMGURL);
    userInfo.phone = sp.getString(SP_USER_PHONE);

    return userInfo;
  }

  // 是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(SP_IS_LOGIN);
    return b != null && b;
  }

//请求微信登录用户信息
  static Future<String> login() async {
    if (isLogin() != null) {
      // fluwx.sendAuth(scope: "snsapi_userinfo", state: "wechar_sdk_demo_test");
      // fluwx.responseFromAuth.listen((data) async {
      //   print(servicePath['getWeixinInfo'] +
      //       "?appid=" +
      //       APPID +
      //       "&secret=" +
      //       SERCRET +
      //       "&code=${data.code}&platforms=1");
      //   final response = await new Dio().get(servicePath['getWeixinInfo'] +
      //       "?appid=" +
      //       APPID +
      //       "&secret=" +
      //       SERCRET +
      //       "&code=${data.code}&platforms=1");
      //   Map user = json.decode(response.toString());
      //   print(user['result']['nickname']);
      //   SharedPreferences sp = await SharedPreferences.getInstance();
      //   await sp.setString(SP_USER_NICK_NAME, user['result']['nickname']);
      //   await sp.setString(SP_USER_UNIONID, user['result']['unionid']);
      //   await sp.setString(SP_USER_HEADIMGURL, user['result']['headimgurl']);
      //   await sp.setBool(SP_IS_LOGIN, true);
      // });
    }

    return "success";
  }
}
