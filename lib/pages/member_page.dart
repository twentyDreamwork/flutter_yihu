import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yihu/pages/integralGoods_page.dart';
import 'package:yihu/util/DataUtils.dart';
import '../config/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MemberPageState();
  }
}

class MemberPageState extends State<MemberPage> {
  var unionid;
  var userName;
  var headimgurl;
  @override
  void initState() {
    // _getUserInfo();
    super.initState();
  }

  // 获取用户信息
  _getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      unionid = sp.get(DataUtils.SP_USER_UNIONID);
      headimgurl = sp.get(DataUtils.SP_USER_HEADIMGURL);
      userName = sp.get(DataUtils.SP_USER_NICK_NAME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.memberTitle), //会员中心
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      ),
    );
  }

  //头像区域
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: KColor.primaryColor,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.network(
                  headimgurl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              userName,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //我的订单标题
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: KColor.defaultBorderColor),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  //我的订单类型
  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.payment,
                  size: 30,
                ),
                Text(KString.pendingPayText), //'待付款'
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text(KString.toBeSendText), //'待发货'
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text(KString.toBeReceivedText), //'待收货'
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.message,
                  size: 30,
                ),
                Text(KString.evaluateText), //'待评价'
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _myListTile(String title) {
    return InkWell(
        onTap: () {
          if (title == '积分记录') {
            print("11");
          } else if (title == '积分商城') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => IntegralGoodsPage()));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: KColor.defaultBorderColor),
            ),
          ),
          child: ListTile(
            leading: Icon(Icons.blur_circular),
            title: Text(title),
            trailing: Icon(Icons.arrow_right),
          ),
        ));
  }

  //其它操作列表
  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile('积分详情'),
          _myListTile('积分商城'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }
}
