import 'package:flutter/material.dart';
import 'package:instagramdownloader/style/theme.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formIG = GlobalKey<FormState>();
  final FocusNode focuseNodeSearhField = FocusNode();

  TextEditingController searchUrlController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: GlobalTheme.renderBackground(),
        child: Column(
          children: <Widget>[
            _buildFormIG(),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
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

  Widget _buildSearchField() {
    return TextFormField(
      focusNode: focuseNodeSearhField,
      controller: searchUrlController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Instagram url is not valid';
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
        onPressed: () {_submitSearchIGForm();},
        child: Text("Process"),
      ),
    );
  }

  
  void _submitSearchIGForm() {
    if (!_formIG.currentState.validate()) {
      return;
    }
    _formIG.currentState.save();
  }
}
