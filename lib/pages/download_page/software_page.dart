import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yihu/config/color.dart';
import 'package:yihu/config/string.dart';
import 'package:yihu/service/http_service.dart';
import 'dart:io';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:toast/toast.dart';

class SoftwarePage extends StatefulWidget {
  @override
  _SoftwarePage createState() => _SoftwarePage();
}

class _SoftwarePage extends State<SoftwarePage> {
  //下载列表数据
  List<Map> dowmloadList = [];

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
    // 初始化进度条
    // ProgressDialog pr =
    //     new ProgressDialog(context, ProgressDialogType.Download);
    // pr.setMessage('下载中…');
    // // 设置下载回调
    // FlutterDownloader.registerCallback((id, status, progress) {
    //   // 打印输出下载信息
    //   print(
    //       'Download task ($id) is in status ($status) and process ($progress)');
    //   if (!pr.isShowing()) {
    //     pr.show();
    //   }
    //   if (status == DownloadTaskStatus.running) {
    //     pr.update(progress: progress.toDouble(), message: "下载中，请稍后…");
    //   }
    //   if (status == DownloadTaskStatus.failed) {
    //     showToast("下载异常，请稍后重试");
    //     if (pr.isShowing()) {
    //       pr.hide();
    //     }
    //   }

    //   if (status == DownloadTaskStatus.complete) {
    //     print("下载完成");
    //     print(pr.isShowing());
    //     if (pr.isShowing()) {
    //       pr.hide();
    //     }
    //     // 显示是否打开的对话框
    //     showDialog(
    //         // 设置点击 dialog 外部不取消 dialog，默认能够取消
    //         barrierDismissible: false,
    //         context: context,
    //         builder: (context) => AlertDialog(
    //               title: Text('提示'),
    //               // 标题文字样式
    //               content: Text('文件下载完成，是否打开？'),
    //               // 内容文字样式
    //               backgroundColor: CupertinoColors.white,
    //               elevation: 8.0,
    //               // 投影的阴影高度
    //               semanticLabel: 'Label',
    //               // 这个用于无障碍下弹出 dialog 的提示
    //               shape: Border.all(),
    //               // dialog 的操作按钮，actions 的个数尽量控制不要过多，否则会溢出 `Overflow`
    //               actions: <Widget>[
    //                 // 点击取消按钮
    //                 FlatButton(
    //                     onPressed: () => Navigator.pop(context),
    //                     child: Text('取消')),
    //                 // 点击打开按钮
    //                 FlatButton(
    //                     onPressed: () {
    //                       Navigator.pop(context);
    //                       // 打开文件
    //                       _openDownloadedFile(id).then((success) {
    //                         if (!success) {
    //                           Scaffold.of(context).showSnackBar(SnackBar(
    //                               content: Text('Cannot open this file')));
    //                         }
    //                       });
    //                     },
    //                     child: Text('打开')),
    //               ],
    //             ));
    //   }
    // });
  }

//   @override
//   void dispose() {
//     FlutterDownloader.registerCallback(null);
//     super.dispose();
//   }

//   // 执行下载文件的操作
//   _doDownloadOperation(downloadUrl) async {
//     /**
//      * 下载文件的步骤：
//      * 1. 获取权限：网络权限、存储权限
//      * 2. 获取下载路径
//      * 3. 设置下载回调
//      */

//     // 获取权限
//     var isPermissionReady = await _checkPermission();
//     if (isPermissionReady) {
//       // 获取存储路径
//       var _localPath = (await _findLocalPath()) + '/Download';

//       final savedDir = Directory(_localPath);
//       // 判断下载路径是否存在
//       bool hasExisted = await savedDir.exists();
//       // 不存在就新建路径
//       if (!hasExisted) {
//         savedDir.create();
//       }

//       // 下载
//       _downloadFile(downloadUrl, _localPath);
//     } else {
//       showToast("您还没有获取权限");
//     }
//   }

// // 申请权限
//   Future<bool> _checkPermission() async {
//     // 先对所在平台进行判断
//     if (Theme.of(context).platform == TargetPlatform.android) {
//       PermissionStatus permission = await PermissionHandler()
//           .checkPermissionStatus(PermissionGroup.storage);
//       if (permission != PermissionStatus.granted) {
//         Map<PermissionGroup, PermissionStatus> permissions =
//             await PermissionHandler()
//                 .requestPermissions([PermissionGroup.storage]);
//         if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
//           return true;
//         }
//       } else {
//         return true;
//       }
//     } else {
//       return true;
//     }
//     return false;
//   }

// // 获取存储路径
//   Future<String> _findLocalPath() async {
//     final directory = await getExternalStorageDirectory();
//     return directory.path;
//   }

//   // 根据 downloadUrl 和 savePath 下载文件
//   _downloadFile(downloadUrl, savePath) async {
//     await FlutterDownloader.enqueue(
//       url: downloadUrl,
//       savedDir: savePath,
//       showNotification: true,
//       // show download progress in status bar (for Android)
//       openFileFromNotification:
//           true, // click on notification to open downloaded file (for Android)
//     );
//   }

//   // 根据taskId打开下载文件
//   Future<bool> _openDownloadedFile(taskId) {
//     return FlutterDownloader.open(taskId: taskId);
//   }

//   // 弹出toast
//   void showToast(String msg, {int duration, int gravity}) {
//     Toast.show(msg, context, duration: duration, gravity: gravity);
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      body: FutureBuilder(
        future:
            request('downloadlist', formData: {"pageno": "1", "platform": "1"}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            dowmloadList = (data['resultList'] as List).cast(); //下载列表
            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: KColor.refreshTextColor,
                moreInfoColor: KColor.refreshTextColor,
                showMore: true,
                noMoreText: '',
                moreInfo: KString.loading,
                //加载中...
                loadReadyText: KString.loadReadyText,
              ),
              child: ListView(
                children: <Widget>[
                  _downLoadContent(),
                ],
              ),
              loadMore: () async {
                print('开始加载更多');
                _downLoadContent();
              },
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

  Widget _wrapList() {
    if (dowmloadList.length != 0) {
      List<Widget> listWidget = dowmloadList.map((val) {
        return new Container(
          padding: const EdgeInsets.all(5.0),
          child: new Row(
            children: [
              Image.network(
                val['icon'],
                width: ScreenUtil().setWidth(250),
                fit: BoxFit.cover,
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        val['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    new Text(
                      val['remark'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              new MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: new Text('点击下载'),
                onPressed: () {
                  // _doDownloadOperation('https://ytools.xyz/0039MnYb0qxYhV.mp3');
                  print('点击了下载');
                },
              )
            ],
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  //火爆专区组合
  Widget _downLoadContent() {
    return Container(
      child: Column(
        children: <Widget>[
          _wrapList(),
        ],
      ),
    );
  }
}
