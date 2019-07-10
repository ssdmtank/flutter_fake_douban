import 'package:flutter/material.dart';
import 'package:flutter_fake_douban/pages/movie/book_audio_video_page.dart';

///这个页面是作为整个APP的最外层的容器，以Tab为基础控制每个item的显示与隐藏
class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContainerPageState();
  }
}

//底部菜单对象
class _Item {
  String name, activeIcon, normalIcon;
  _Item(this.name, this.activeIcon, this.normalIcon);
}

class _ContainerPageState extends State<ContainerPage> {
  List<Widget> pages;

  final itemNames = [
    _Item('首页', 'assets/images/ic_tab_home_active.png',
        'assets/images/ic_tab_home_normal.png'),
    _Item('书影音', 'assets/images/ic_tab_subject_active.png',
        'assets/images/ic_tab_subject_normal.png'),
    _Item('小组', 'assets/images/ic_tab_group_active.png',
        'assets/images/ic_tab_group_normal.png'),
    _Item('市集', 'assets/images/ic_tab_shiji_active.png',
        'assets/images/ic_tab_shiji_normal.png'),
    _Item('我的', 'assets/images/ic_tab_profile_active.png',
        'assets/images/ic_tab_profile_normal.png')
  ];
  List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    super.initState();
    if (pages == null) {
      pages = [
//        HomePage(),
        BookAudioVideoPage(),
        BookAudioVideoPage(),
        BookAudioVideoPage(),
        BookAudioVideoPage(),
        BookAudioVideoPage(),
//        GroupPage(),
//        shopPageWidget,
//        PersonCenterPage()
      ];
      if (itemList == null) {
        //绘制底部样式
        itemList = itemNames
            .map((item) => BottomNavigationBarItem(
                icon: Image.asset(
                  item.normalIcon,
                  width: 30.0,
                  height: 30.0,
                ),
                title: Text(
                  item.name,
                  style: TextStyle(fontSize: 10.0),
                ),
                activeIcon: Image.asset(
                  item.activeIcon,
                  width: 30.0,
                  height: 30.0,
                )))
            .toList();
      }
    }
  }

  int _selectIndex = 0;
  //Stack（层叠布局）+Offstage组合,解决状态被重置的问题
  //Stack + OffStage + TickerMode 堆叠
  //TODO https://www.jianshu.com/p/86d29a939624
  //根据底部菜单调整页面
  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[0],
      ),
    );
  }

  @override
  void didUpdateWidget(ContainerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
          _getPagesWidget(4),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          //根据index 显示隐藏
          setState(() {
            _selectIndex = index;
            //这个是用来控制比较特别的shopPage中WebView不能动态隐藏的问题
//           shopPageWidget.setShowState(pages.indexOf(shopPageWidget) == _selectIndex);
          });
        },
        iconSize: 24,//图标大小
        currentIndex: _selectIndex,
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
