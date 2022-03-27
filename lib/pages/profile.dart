import 'package:lancer/Animation/FadeAnimation.dart';
import 'package:lancer/pages/settings.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> posts = [
    'https://cdn.dribbble.com/users/14268/screenshots/16985493/media/23018c5dd230f8636d9462e680bfa539.png?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/4835348/screenshots/16984401/media/d27a430e91d8c160a53d22fc6fde17df.png?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/339280/screenshots/16985647/media/a4151855c591adceb279c73c4bd505db.png?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/2651968/screenshots/16984625/media/5efbb07fecac0d7f78cdead7f8a9b004.jpg?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/44324/screenshots/16984016/media/081940bb686e36183cd7314ee2ba9023.jpg?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/59947/screenshots/16983392/media/7511d297a8c16e76755f7f80b04524d5.jpg?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/59947/screenshots/14342742/media/53271a0ee52073de5af499a11e9d81c5.jpg?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/59947/screenshots/16559680/media/dfbcda2312bcd46538b2cbb4a59ef3bd.jpg?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/185738/screenshots/16979436/media/5a75c0d594ad5145c6a13fdb44b26984.png?compress=1&resize=1200x900',
    'https://cdn.dribbble.com/users/185738/screenshots/16579305/media/f3e500bb6aae17751c67983ebb324f36.png?compress=1&resize=1200x900'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.brown.shade200,
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0, 0.7],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.black,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ))
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.2,
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 5)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                    'https://randomuser.me/api/portraits/men/18.jpg'),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.3,
                          Text(
                            "Ken adams",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          1.2,
                          Text(
                            "cupertino, California",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          )),
                      SizedBox(height: 40),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FadeAnimation(
                                    1.2,
                                    Column(
                                      children: [
                                        Text(
                                          "100",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Following",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )),
                                FadeAnimation(
                                    1.5,
                                    Column(
                                      children: [
                                        Text(
                                          "923",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Followers",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )),
                                FadeAnimation(
                                    1.6,
                                    Column(
                                      children: [
                                        Text(
                                          "6k",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Likes",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )),
                              ])),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: DefaultTabController(
            length: 2,
            child: Column(children: [
              FadeAnimation(
                  2.2,
                  Container(
                      child: TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey.shade600,
                          indicatorColor: Colors.black,
                          tabs: [
                        Tab(
                          icon: Icon(
                            Icons.list,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.grid_view,
                          ),
                        ),
                      ]))),
              Expanded(
                  child: FadeAnimation(
                      2.2,
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TabBarView(children: [
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  return post(
                                      (1.0 + index) / 4, posts[index], 'list');
                                }),
                            GridView.builder(
                                itemCount: posts.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.2),
                                itemBuilder: (context, index) {
                                  return post(
                                      (1.0 + index) / 4, posts[index], 'grid');
                                })
                          ]))))
            ]),
          ),
        ),
      ),
    );
  }

  post(delay, image, type) {
    return FadeAnimation(
        delay,
        Container(
          margin: type == 'grid' ? EdgeInsets.all(0) : EdgeInsets.only(top: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(image),
          ),
        ));
  }
}
