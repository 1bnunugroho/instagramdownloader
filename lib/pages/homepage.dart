import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:instagramdownloader/style/theme.dart';
import 'package:instagramdownloader/common/common.dart';
import 'package:instagramdownloader/models/iGResponse_model.dart';
import 'package:instagramdownloader/models/mediaItem_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  String _shared = '';
  String _errMsg = "Instagram url is not valid";
  IGResponseModel igResponseModel;
  List<MediaItemModel> mediaItemList = List();
  final GlobalKey<FormState> _formIG = GlobalKey<FormState>();

  final FocusNode focuseNodeSearhField = FocusNode();
  TextEditingController searchUrlController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: GlobalTheme.renderBackground(),
        child: Column(
          children: <Widget>[
            _buildFormIG(),
            _buildResult(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormIG() {
    return Form(
      key: _formIG,
      child: Card(
        margin: EdgeInsets.only(bottom: 30),
        elevation: 2.0,
        color: Colors.white,
        child: Container(
          child: Column(children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: GlobalTheme.defaultInputPadding(),
              child: _buildSearchField(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25, left: 25.0, right: 25.0),
              child: _buildSeachButton(),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildResult() {
    if (isLoading) {
      return SpinKitRotatingCircle(
        color: Colors.blue,
        size: 60.0,
      );
    }
    if (mediaItemList.length > 0) {
      return Expanded(
        child: _buildNotificationPanel(mediaItemList),
      );
    } else {
      return Container();
    }
  }

  Widget _buildNotificationPanel(List<MediaItemModel> model) {
    final resultsBody = <Widget>[];
    resultsBody.add(_buildBodyCardTitle(title: "Results"));
    resultsBody.add(Divider(
      height: 3,
      color: Colors.black87,
    ));
    for (var i = 0; i < model.length; i++) {
      resultsBody.add(_buildResultItem(model: model[i]));
      resultsBody.add(Divider(
        height: 3,
        color: Colors.black87,
      ));
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Material(
            elevation: 1,
            color: Colors.white,
            child: Column(children: resultsBody),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildBodyCardTitle({String title}) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Color(0xff06866C),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "View All",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem({@required MediaItemModel model}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 7.0, // has the effect of softening the shadow
                    spreadRadius: 3.0, // has the effect of extending the shadow
                    offset: Offset(
                      2.0, // horizontal, move right 10
                      2.0, // vertical, move down 10
                    ),
                  )
                ],
                color: Colors.white,
                border: new Border.all(width: 1.0, color: Colors.white),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10.0)),
              ),
              margin: EdgeInsets.only(top:10, bottom: 10, right: 10),
              width: (MediaQuery.of(context).size.width - 100),
              height: 150.0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10.0)),
                child: Image.network(
                  model.photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.grey[200],
                    onPressed: () {},
                    heroTag: 'image0',
                    tooltip: 'View',
                    child: const Icon(Icons.photo_library),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: FloatingActionButton(
                    backgroundColor: Colors.grey[300],
                      onPressed: () {},
                      heroTag: 'image1',
                      tooltip: 'Download',
                      child: const Icon(Icons.file_download),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      focusNode: focuseNodeSearhField,
      controller: searchUrlController,
      validator: (String value) {
        if (value.isEmpty || value.length < 17) {
          CommonFunction.showInfoDialog(context, "alert", _errMsg);
          return _errMsg;
        }
      },
      style: TextStyle(fontSize: 16.0, color: Colors.black),
      decoration: InputDecoration(
          labelText: "Instagram Url",
          icon: Icon(
            FontAwesomeIcons.instagram,
            size: 22.0,
            color: Colors.pink,
          ),
          hintText: "https://instagram.com/p/XXX_xxxX",
          hintStyle: TextStyle(fontSize: 17.0)),
    );
  }

  Widget _buildSeachButton() {
    return ButtonTheme(
      minWidth: double.infinity,
      child: RaisedButton(
        onPressed: () {
          _submitSearchIGForm();
        },
        child: Text("Process"),
      ),
    );
  }

  Future<List<MediaItemModel>> _getGraphQLFromUrl() async {
    setState(() {
      isLoading = true;
    });
    final urlResponse = await http.get(_shared);
    if (urlResponse.statusCode == 200) {
      igResponseModel = IGResponseModel.fromJson(jsonDecode(urlResponse.body));
      setState(() {
        mediaItemList = igResponseModel.mediaList;
        isLoading = false;
      });
      for (MediaItemModel mediaItem in mediaItemList) {
        print(mediaItem.toMap().toString());
      }
    } else {
      setState(() {
        isLoading = false;
      });
      CommonFunction.showInfoDialog(
          context, "alert", "Owner of photo(s) has disabled sharing!");
      print(urlResponse.statusCode);
    }
    return mediaItemList;
  }

  _checkUrl(String value) {
    try {
      var url = Uri.parse(value);
      if (url.host == "www.instagram.com") {
        _shared = url.replace(queryParameters: {"__a": "1"}).toString();
        _getGraphQLFromUrl();
      } else {
        CommonFunction.showInfoDialog(context, "alert", _errMsg);
      }
    } catch (e) {
      CommonFunction.showInfoDialog(context, "alert", _errMsg);
    }
  }

  void _submitSearchIGForm() {
    if (!_formIG.currentState.validate()) {
      return;
    }
    _formIG.currentState.save();
    _checkUrl(searchUrlController.text);
  }
}
