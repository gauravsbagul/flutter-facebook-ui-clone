import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../data/data.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import '../config/palette.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              _HomeScreenMobile(scrollCOntroller: _trackingScrollController),
          desktop:
              _HomeScreenDesktop(scrollCOntroller: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollCOntroller;

  const _HomeScreenMobile({
    Key key,
    @required this.scrollCOntroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollCOntroller,
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'facebook',
            style: const TextStyle(
              color: Palette.facebookBlue,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          centerTitle: false,
          floating: true,
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => print('search'),
            ),
            CircleButton(
              icon: MdiIcons.facebookMessenger,
              iconSize: 30.0,
              onPressed: () => print('facebookMessenger'),
            )
          ],
        ),
        SliverToBoxAdapter(
          child: CreatePostContainer(currentUser: currentUser),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Rooms(onlineUsers: onlineUsers),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Stories(
              currentUser: currentUser,
              stories: stories,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Post post = posts[index];
              return PostConatiner(post: post);
            },
            childCount: posts.length,
          ),
        )
      ],
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollCOntroller;

  const _HomeScreenDesktop({
    Key key,
    @required this.scrollCOntroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: MoreOptionList(currentUser: currentUser),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: 600,
            child: CustomScrollView(
              controller: scrollCOntroller,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Stories(
                      currentUser: currentUser,
                      stories: stories,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CreatePostContainer(currentUser: currentUser),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(
                    child: Rooms(onlineUsers: onlineUsers),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Post post = posts[index];
                      return PostConatiner(post: post);
                    },
                    childCount: posts.length,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ContactList(users: onlineUsers),
              ),
            ),
          )
        ],
      ),
    );
  }
}
