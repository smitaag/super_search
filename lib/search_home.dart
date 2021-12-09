import 'package:flutter/material.dart';

import 'theme.dart';

class SearchHome extends StatefulWidget {
  const SearchHome({Key? key}) : super(key: key);

  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  String? _portal;
  String? _keyword;
  bool refreshUI = false;
  List<String> _searchResults = [];
  Widget updateResults() {
    return FutureBuilder(
      builder: (context, searchSnap) {
        if (searchSnap.connectionState == ConnectionState.none &&
            searchSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: searchSnap.data?.length,
          itemBuilder: (context, index) {
            ProjectModel project = projectSnap.data[index];
            return Column(
              children: <Widget>[
                // Widget to display the list of project
              ],
            );
          },
        );
      },
      future: getProjectDetails(),
    );
  }

  Future<void> showSearchResults() async {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * .85,
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * .05,
                MediaQuery.of(context).size.width * .04,
                MediaQuery.of(context).size.width * .05,
                MediaQuery.of(context).size.width * .04),
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Text(
                      'Experience new way of looking for best candidates/jobs',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontFamily: 'AkkuratPro',
                          fontSize: 17.0),
                    ),
                    Container(
                        padding: const EdgeInsets.all(0),
                        height: MediaQuery.of(context).size.height * .2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                TextFormField(
                                  obscureText: false,
                                  maxLines: 1,
                                  minLines: 1,
                                  style: lightInputTextStyle,
                                  keyboardType: TextInputType.phone,
                                  onSaved: (value) => _portal = value,
                                  onChanged: (value) {
                                    setState(() {
                                      _portal = value;
                                    });
                                  },
                                ),
                                TextFormField(
                                  obscureText: false,
                                  maxLines: 1,
                                  minLines: 1,
                                  style: lightInputTextStyle,
                                  keyboardType: TextInputType.phone,
                                  onSaved: (value) => _keyword = value,
                                  onChanged: (value) {
                                    setState(() {
                                      _keyword = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            MaterialButton(
                              child: Text("Show Results"),
                              onPressed: () {
                                setState(() {
                                  refreshUI = true;
                                });
                              },
                            ),
                            (refreshUI) ? showSearchResults() : Container(),
                          ],
                        )),
                  ]),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(
      //   barIndex: 0,
      // ),

      onWillPop: () async {
        return false;
      },
    );
  }
}
