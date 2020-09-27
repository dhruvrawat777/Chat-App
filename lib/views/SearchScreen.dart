import 'package:Chat_App/services/database.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchItem = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Widget getList() {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height - 200,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'name',
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
            ),
          );
        },
        itemCount: 15,
      ),
    );
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
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 6),
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
                GestureDetector(
                  onTap: () {
                    databaseMethods
                        .getUserByUsername(_searchItem.text)
                        .then((val) {
                      print(val.toString());
                    });
                  },
                  child: Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
              ],
            ),
            getList(),
          ],
        ),
      ),
    );
  }
}
