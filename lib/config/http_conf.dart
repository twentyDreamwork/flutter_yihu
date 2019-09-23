// const base_url = 'http://192.168.3.4:3000/';
const base_url = "http://39.108.143.92:8081/";
// const base_url = "http://192.168.1.2:8081/";

const servicePath = {
  'getWeixinInfo': base_url + 'api/getWeixinInfo', //微信登录信息
  'queryrecommendGoods':
      base_url + 'app/goodsInfo/recommendGoodsInfoList', //获取推荐产品
  'queryAllCarousel': base_url + 'app/carouselInfo/carouselInfoList', //获取轮播图
  'queryAllClassify': base_url + 'app/goodsInfo/goodsClassifyTree', //获取产品类别
  'getHotGoods': base_url + 'app/goodsInfo/hotGoodsInfoList', //热门专区
  'queryAllClassifyByParentId':
      base_url + 'app/goodsInfo/classifyGoodsInfoList', //商品分类别的商品列表
  'queryClassifyGoods': base_url + 'app/goodsInfo/queryByGoodsId', //根据分类获取商品
  'downloadlist': base_url + 'api/downloadlist', //获取下载列表
  'integralGoods': base_url + 'app/itemPoint/itemPointList', //获取积分商品
};
