# MJShopCar_Swift
## 效果图
![image](https://github.com/linmaojia/TalkDemo/blob/master/raw/2017-05-22%2010.53.01.gif)
## 项目搭建框架:
这是一个比较常规的购物车模型 一共包含五个模块：

* `JVShopcartViewController`: 购物车控制器 负责协调 `Model` 和 `View` 只有100多行代码
* `JVShopcartFormat`: 负责网络请求与逻辑处理
* `JVShopcartTableViewProxy`: 作为控制器里边 `TableView` 的代理
* `View`: 包括`Cell`、`HeaderView`、`CountView`(改变商品数的视图)、`BottomView`(控制器底部包含结算按钮的视图)
* `Model`: 包含 `BrandModel` 和 `ProductModel` 两层

## 使用说明:
首先将工程里边的JVShopcart文件夹拖入你的项目 然后就是开源库`ThirdParty(第三方控件)`文件夹根据需求处理 Model是一定会改的 但是购物车的Model大同小异 其他的改动不会太大 ,`SupportingFile`包含桥接文件 `Brigding-Header.h` 和 数据源 `shopcart.plist`，而 `Extension` 包含是 UILabel 的拓展文件 `UILabelExtension.swift `类似 OC 里面的 分类 `Category`

## 需要注意：

* `BrandModel`里边有两个成员变量是手动添加进去的：` isSelected` 和 `selectedArray `前者是为了记录某个品牌或者说某个 `section` 是否被选中 后者是结算的时候记录选中的商品
* `ProductModel`里边的`isSelected`也是手动添加的 也是为了记录某个商品或者说某个`row`是否被选中
* `ThirdParty`文件夹里边是一些开源库 布局依赖 `SnapKit`  图片异步加载依赖 `SDWebImage` 键盘的管理依赖 `IQKeyboardManager` 当然你也可以自己处理， 等待框 `SVProgressHUD`
* `View`里边的回调都是用的`Block`  `JVShopcartFormat`里边的回调都是用的 `delegate` 你也可以根据需求自行选择具体的回调方式
* 虽然购物车大同小异 但是总有些奇葩的需求需要自己去处理 肯定是要根据我的注释去做一些修改的

## 欢迎右上角 star
