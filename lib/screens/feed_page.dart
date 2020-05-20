import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cos/constants/size.dart';
import 'package:instagram_cos/firebase/firestore_provider.dart';
import 'package:instagram_cos/utils/profile_img_path.dart';
import 'package:instagram_cos/widgets/comment.dart';
import 'package:instagram_cos/widgets/my_progress_indicator.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: ImageIcon(
            AssetImage('assets/actionbar_camera.png'),
            color: Colors.black,
            size: 28.0,
          ),
          onPressed: () {
//            firestoreProvider.sendData().then((_){
//              print('data sent to firestore!');
//            });
          },
        ),
        title: Image.asset(
          'assets/insta_text_logo.png',
          height: 33.0,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/actionbar_igtv.png'),
              color: Colors.black,
              size: 28.0,
            ),
            onPressed: () {
              //firestoreProvider.getData();
            },
          ),
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/direct_message.png'),
              color: Colors.black,
              size: 28.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return _postItem(index, context);
          }),
    );
  }

  Column _postItem(int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // 칼럼은 모든 아이템을 기본적으로 가운데로 오게 해둠.
      children: <Widget>[
        _postHeader('username $index'),
        _postImage(index),
        _postActions(),
        _postLikes(),
        _postCaption(context, index),
        _allComments(),
      ],
    );
  }

  Padding _allComments() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: GestureDetector(
        onTap: null,
        child: Text(
          'show all 18 comments',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }

  Padding _postCaption(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxxs_gap),
      child: Comment(
        //showProfile: true,
        username: 'username $index',
        caption: 'I love summer soooooooooooooooo much~~~~~~~~~~!!',
        //dateTime: DateTime.now(),
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '80 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postHeader(String username) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_gap),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              getProfileImgPath(username),
            ),
            radius: profile_radius,
          ),
        ),
        Expanded(
            child: Text(
          username,
        )),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
          onPressed: null,
        )
      ],
    );
  }

  CachedNetworkImage _postImage(int index) {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return MyProgressIndicator(
          containerSize: size.width,
          progressSize: 100,
        );
      },
      imageUrl: 'https://picsum.photos/id/${10 + index}/200/200',
      imageBuilder: (BuildContext context, ImageProvider imageProvider) => AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          decoration:
              BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/bookmark.png'),
            color: Colors.black87,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/comment.png'),
            color: Colors.black87,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/direct_message.png'),
            color: Colors.black87,
          ),
          onPressed: null,
        ),
        Spacer(), // 남은 공간 차지하게 하기
        //Expanded(child: SizedBox()),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/heart_selected.png'),
            color: Colors.redAccent,
          ),
          onPressed: null,
        ),
      ],
    );
  }
}
