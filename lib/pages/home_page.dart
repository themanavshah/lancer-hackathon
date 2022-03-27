import 'package:flutter/material.dart';
import 'package:lancer/Animation/FadeAnimation.dart';
import 'package:lancer/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [
    'Design',
    'Programming',
    'Photography',
    'Content writing',
    'Video editor',
  ];

  int activeTab = 0;
  bool run = true;

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
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                        'https://randomuser.me/api/portraits/men/18.jpg'),
                  )),
            )
          ],
          title: Container(
            height: 45,
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                filled: true,
                fillColor: Colors.grey.shade200,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintText: "Search for skills",
                hintStyle: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeAnimation(
                          1,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Today\'s popular',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Designer',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ],
                          )),
                      FadeAnimation(
                          1,
                          Container(
                            width: 220,
                            child: Image.asset("assets/blogging.png"),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeAnimation(
                    1.2,
                    Container(
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: activeTab == index
                                        ? Colors.blue
                                        : Colors.grey.shade200),
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                      color: activeTab == index
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            );
                          }),
                    )),
                SizedBox(
                  height: 30,
                ),
                post(1.2,
                    'https://cdn.dribbble.com/users/185738/screenshots/16579305/media/f3e500bb6aae17751c67983ebb324f36.png?compress=1&resize=1200x900'),
                post(1.3,
                    'https://cdn.dribbble.com/users/185738/screenshots/16979436/media/5a75c0d594ad5145c6a13fdb44b26984.png?compress=1&resize=1200x900'),
                post(1.4,
                    'https://cdn.dribbble.com/users/59947/screenshots/16559680/media/dfbcda2312bcd46538b2cbb4a59ef3bd.jpg?compress=1&resize=1200x900'),
                post(1.5,
                    'https://cdn.dribbble.com/users/59947/screenshots/14342742/media/53271a0ee52073de5af499a11e9d81c5.jpg?compress=1&resize=1200x900'),
                post(1.6,
                    'https://cdn.dribbble.com/users/59947/screenshots/16983392/media/7511d297a8c16e76755f7f80b04524d5.jpg?compress=1&resize=1200x900')
              ],
            ),
          ),
        ),
      ),
    );
  }

  post(delay, image) {
    return FadeAnimation(
        delay,
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(image),
          ),
        ));
  }
}
