import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yihu/config/color.dart';
import 'package:yihu/config/string.dart';
import 'package:yihu/service/http_service.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePage createState() => _GamePage();
}

class _GamePage extends State<GamePage> {
  //下载列表数据
  List<Map> dowmloadList = [];

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
  }

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
