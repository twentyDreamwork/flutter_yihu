import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yihu/config/color.dart';
import 'package:yihu/config/string.dart';
import 'package:yihu/service/http_service.dart';

//软件界面
class GamePage extends StatefulWidget {
  @override
  _GamePage createState() {
    return _GamePage();
  }
}

class _GamePage extends State<GamePage> with AutomaticKeepAliveClientMixin {
  //仿止刷新处理 保持当前状态
  @override
  bool get wantKeepAlive => true;

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();

  //下载列表数据
  List<Map> downloadList = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    _getDownloadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        body: EasyRefresh(
            refreshHeader: ClassicsHeader(
                key: _headerKey,
                refreshText: "下拉加载",
                refreshReadyText: "加载中",
                refreshedText: "加载完成",
                bgColor: Colors.white,
                textColor: KColor.refreshTextColor,
                moreInfoColor: KColor.refreshTextColor,
                showMore: true,
                moreInfo: KString.loading,
                refreshingText: "刷新中"
                //加载中...
                ),
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              bgColor: Colors.white,
              textColor: KColor.refreshTextColor,
              moreInfoColor: KColor.refreshTextColor,
              showMore: true,
              noMoreText: '',
              moreInfo: KString.loading,
              loadText: "上啦加载",
              loadingText: "加载完成",
              loadedText: "loaded",
              loadReadyText: KString.loadReadyText,
            ),
            child: ListView(
              children: <Widget>[
                _viewList(),
              ],
            ),
            loadMore: () async {
              print('开始加载更多');
              _getDownloadList();
            },
            onRefresh: () async {
              print("上拉刷新了");
              page = 1;
              downloadList = [];
              _getDownloadList();
            }));
  }

  Widget _viewList() {
    return Wrap(
        spacing: 5.0, //两个widget之间横向的间隔
        direction: Axis.horizontal, //方向
        alignment: WrapAlignment.start, //内容排序方式
        children: List<Widget>.generate(downloadList.length, (int index) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: downloadList[index]['img'],
                  errorWidget: new Center(child: new Icon(Icons.error)),
                  width: ScreenUtil().setWidth(105),
                  fit: BoxFit.cover,
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                downloadList[index]['channelName'],
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                      new Container(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                downloadList[index]['channelDescribe'],
                                style: new TextStyle(
                                  color: Colors.grey[500],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )),
                      new Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: const EdgeInsets.only(left: 5.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.red, width: 1), //边框
                            borderRadius: BorderRadius.all(
                              //圆角
                              Radius.circular(10.0),
                            ),
                          ),
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                '${downloadList[index]['channelOnepoint']}积分',
                                style: new TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                new MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: new Text('点击下载'),
                  onPressed: () {
                    // downloadFile(
                    //     'https://b6.market.xiaomi.com/download/AppStore/0950964cfb0ea4d0d14def8aa108c8556aa88ba6d/com.x15010480559.oec.apk');
                    print("点击下载");
                  },
                )
              ],
            ),
          );
        }));
  }

  void _getDownloadList() {
    var formPage = "?page=${page}&limit=10&channelType=1&channelPlatform=1";
    getRequest('downloadlist', formPage).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['result']['list'] as List).cast();
      setState(() {
        downloadList.addAll(newGoodsList);
        page++;
      });
    });
  }
}
