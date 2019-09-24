import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import '../config/index.dart';

Future request(url, {formData}) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/json');
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常,请检查测试代码和服务器运行情况...');
    }
  } catch (e) {
    return print('error:::${e}');
  }
}

Future getRequest(url, data) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/json');
    print(servicePath[url] + data);
    if (data == null) {
      print(servicePath[url]);
      response = await dio.get(servicePath[url]);
    } else {
      print(servicePath[url] + data);
      response = await dio.get(servicePath[url] + data);
    }
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常,请检查测试代码和服务器运行情况...');
    }
  } catch (e) {
    return print('error:::${e}');
  }
}

/*
   * 下载文件
   */
Future downloadFile(urlPath) async {
  final directory = await getExternalStorageDirectory();
  var _localPath = directory.path + '/Download';
  final savedDir = Directory(_localPath);
  // 判断下载路径是否存在
  bool hasExisted = await savedDir.exists();
  // 不存在就新建路径
  if (!hasExisted) {
    savedDir.create();
  }
  Response response;
  Dio dio = new Dio();
  try {
    response = await dio.download(urlPath, _localPath,
        onReceiveProgress: (int count, int total) {
      //进度
      print("$count $total");
    });
    print('downloadFile success---------${response.data}');
  } on DioError catch (e) {
    print('downloadFile error---------$e');
  }
  return response.data;
}
