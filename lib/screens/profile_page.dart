import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cos/constants/size.dart';
import 'package:instagram_cos/data/provider/my_user_data.dart';
import 'package:instagram_cos/utils/profile_img_path.dart';
import 'package:instagram_cos/widgets/profile_side_menu.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _menuOpened = false;
  double menuWidth;
  int duration = 300;
  int location = 0;
  int count = 2;
  int _tabIconGridSelected = 0;
  double _gridMargin = 0;
  double _myImgGridMargin = size.width;


  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: duration));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    menuWidth = size.width * (2 / 3); // 전체화면의 3분의 2
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _profile(),
          _sideMenu(),
        ],
      ),
    );
  }

  Widget _sideMenu() {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      color: Colors.grey[200],
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(_menuOpened ? size.width - menuWidth : size.width, 0, 0),
      child: SafeArea(
        child: ProfileSideMenu(),
      ),
    );
  }

  Widget _profile() {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      color: Colors.transparent,
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(_menuOpened ? -menuWidth : 0, 0, 0),
      // -는 왼쪽, +는 오른쪽
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _usernameIconButton(),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _getProfileHeader,
                      _username(),
                      _userBio(),
                      _editProfileBtn(),
                      _getTabIconButtons,
                      _getAnimatedSelectedBar(location, count),
                    ]),
                  ),
                  _getImageGrid(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setTab(int location) {
    setState(() {
      this.location = location;
      _tabIconGridSelected = location;

      if (location == 0) {
        this._gridMargin = 0;
        this._myImgGridMargin = size.width;
      } else {
        this._gridMargin = -size.width;
        this._myImgGridMargin = 0;
      }
    });
  }

  SliverToBoxAdapter _getImageGrid(BuildContext context) => SliverToBoxAdapter(
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              transform: Matrix4.translationValues(_gridMargin, 0, 0),
              duration: Duration(milliseconds: duration),
              curve: Curves.easeInOut,
              child: _imageGrid,
            ),
            AnimatedContainer(
              transform: Matrix4.translationValues(_myImgGridMargin, 0, 0),
              duration: Duration(milliseconds: duration),
              curve: Curves.easeInOut,
              child: _imageGrid,
            )
          ],
        ),
      );

  GridView get _imageGrid => GridView.count(
        physics: NeverScrollableScrollPhysics(), // grid_view의 스크롤을 비활성화 하기
        shrinkWrap: true, // 화면 높이 자동으로 맞추기
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: List.generate(1, (index) => _gridImgItem(index)),
      );

  CachedNetworkImage _gridImgItem(int index) => CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: "https://picsum.photos/id/$index/100/100",
      );

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      child: SizedBox(
        height: 24.0,
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0), side: BorderSide(color: Colors.black45)),
          child: Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Padding _userBio() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        'Bio from User. So Say something.',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  // Consumer와 Provider.of의 차이
  // Provider.of는 context를 잘 전달해야 하지만, Consumer는 알아서 context를 찾아서 제공해준다.
  // Provider.of는 listen을 신경써야 한다. 데이터 변경시 아래 위젯의 모든 부분이 rebuild가 되기 때문에
  // rebuild가 필요없으면 listen:false를 줘야 한다.
  // Consumer를 쓰면 그 부분만 rebuild가 된다.
  Padding _username() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Consumer<MyUserData>(
        builder: (context, myUserData, child){
          return Text(
              myUserData.data.username,
            style: TextStyle(fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }

  Row get _getProfileHeader => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(
                      getProfileImgPath('codingspecialist'),
                    ))
              ],
            ),
          ),
          Expanded(
            child: Table(children: [
              TableRow(children: [
                _getStatusValueWidget('10'),
                _getStatusValueWidget('50'),
                _getStatusValueWidget('13'),
              ]),
              TableRow(children: [
                _getStatusLableWidget('Posts'),
                _getStatusLableWidget('Followers'),
                _getStatusLableWidget('Following'),
              ]),
            ]),
          ),
        ],
      );

  Widget _getStatusValueWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  Widget _getStatusLableWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );

  Row _usernameIconButton() {
    var myUserData = Provider.of<MyUserData>(context);
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: common_gap),
          child: Text(
            myUserData.data.username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        )),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
          ),
          onPressed: () {
            _menuOpened ? _animationController.reverse() : _animationController.forward();
            setState(() {
              _menuOpened = !_menuOpened; // Dart toggle 문법
            });
          },
        ),
      ],
    );
  }

  Widget get _getTabIconButtons => Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: ImageIcon(
                AssetImage("assets/grid.png"),
                color: _tabIconGridSelected == 0 ? Colors.black : Colors.black26,
              ),
              onPressed: () {
                _setTab(0);
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: ImageIcon(
                AssetImage("assets/saved.png"),
                color: _tabIconGridSelected == 1 ? Colors.black : Colors.black26,
              ),
              onPressed: () {
                _setTab(1);
              },
            ),
          )
        ],
      );

  Widget _getAnimatedSelectedBar(int location, int count) => AnimatedContainer(
      alignment: Alignment.centerLeft,
      transform: Matrix4.translationValues(size.width * (location / count), 0, 0),
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
      color: Colors.transparent,
      child: Container(
        height: 1,
        width: size.width * (1 / count),
        color: Colors.black87,
      ));
}
