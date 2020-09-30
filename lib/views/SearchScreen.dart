import 'package:Chat_App/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchItem = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot searchSnapshot;
  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Result(
                searchSnapshot.docs[index].data()['name'],
                searchSnapshot.docs[index].data()['email'],
              );
            },
            itemCount: searchSnapshot.docs.length,
          )
        : Center(
            child: Text('Not found'),
          );
  }

  @override
  void initState() {
    super.initState();
  }

  initiateSearch() {
    databaseMethods.getUserByUsername(_searchItem.text).then((val) {
      //print(val.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          height: MediaQuery.of(context).size.height - 500,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 20, 0, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.black),
                    ),
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextField(
                      controller: _searchItem,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        hintText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 34,
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                      onPressed: () {
                        print('clicked');
                        initiateSearch();
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200,
                child: searchList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
//}

/* class Result extends StatelessWidget {
  final String username;
  final String email;
  Result({this.username, this.email}); */

  Chatroom() {}

  Widget Result(String username, String email) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 230,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.lightBlue,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              username,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image(
                image: NetworkImage(
                    'https://www.vippng.com/png/detail/356-3563531_transparent-human-icon-png.png'),
              ),
            ),
          ),
          Container(
            width: 250,
            height: 50,
            margin: EdgeInsets.all(50),
            child: FlatButton(
              onPressed: () {},
              child: Text('Message'),
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
      /* Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            username,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: RaisedButton(
              color: Colors.lightBlue,
              onPressed: () {
                print('hi');
              },
              child: Text('Message'),
            ),
          )
        ],
      ), */
    );
  }
}
