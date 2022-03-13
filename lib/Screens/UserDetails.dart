import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:github_api_integration/Models/Repos.dart';
import 'package:github_api_integration/Screens/SearchScreen.dart';
import 'package:github_api_integration/Services/RepoList.dart';
import 'package:github_api_integration/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_api_integration/Models/Users.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatefulWidget {
  final User selectedUser;

  UserDetails({required this.selectedUser});

  @override
  State<StatefulWidget> createState() {
    return _UserDetailsState(selectedUser);
  }
}

class _UserDetailsState extends State<UserDetails> {
  final User user;

  _UserDetailsState(this.user);
  List<Repo> ulist = [];
  List<Repo> userLists = [];
  int selectedIndex = 0;
  List<Widget> listWidgets = [
    SearchScreen(),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<List<Repo>> getAllRepoList() async {
     checkConnectivity1();
    try {
      final response = await http.get(Uri.parse(user.repos_url));
      if (response.statusCode == 200) {
        // print(response.body);
        List<Repo> list = parseAgents(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getAllRepoList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var num = userLists.length.toString();
    return Scaffold(
        bottomNavigationBar: ConvexAppBar(
          color: Colors.black, activeColor: Colors.black,
          backgroundColor: Colors.white,
          items: [
            TabItem(
              icon: Icons.home,
            ),
            TabItem(icon: Icons.app_registration),
          ],
          initialActiveIndex: 0, //optional, default as 0
          onTap: onItemTapped,
        ),
        appBar: AppBar(
          title: Text(user.login),
        ),
        //  body: listWidgets[selectedIndex],
        body: Builder(
          builder: (context) => Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (selectedIndex == 0)
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(user.avatar_url),
                                    fit: BoxFit.cover)),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              child: Container(
                                alignment: Alignment(0.0, 2.5),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user.avatar_url),
                                  radius: 60.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                            user.login,
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.blueGrey,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            user.type,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black45,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              elevation: 2.0,
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "No Of Repositories",
                                          style: TextStyle(
                                              letterSpacing: 2.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          num,
                                          style: TextStyle(
                                              letterSpacing: 2.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Followings",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          "15",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Followers",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          "2000",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                if (selectedIndex == 1)
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.all(5),
                      itemCount: userLists.length,
                      itemBuilder: (BuildContext context, int index) {
                        final users = userLists.length;

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        userLists[index].name,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    userLists[index].full_name,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onTap: () async {
                                   
                                    String url =
                                        'https://github.com/'+ userLists[index].full_name;

                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
  _launchURL() async {
  const url = 'https://github.com/mojombo/30daysoflaptops.github.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}
