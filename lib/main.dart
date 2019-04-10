import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final Future<Post> post=null;
//var post;
//fetch json data
Future<Post> fetchPost() async {
  final response =
  await http.get('http://panel.agritw.com/api/user/to_login_with_email?email=jackpark@gmail.com&password=jackpark');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  //final String res;
  final String syscode;
  final String sysnum;
  final String sysmsg;

  Post({this.syscode, this.sysnum, this.sysmsg});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      //res: json['res'],
      syscode: json['sys_code'],
      sysnum: json['sys_num'],
      sysmsg: json['sys_msg'],
    );
  }
}

//var username=' ';
//final String url_api1 = 'http://uatpanel.agritrustworthy.com/api/user/exist';
//List data;
//runApp(MyApp(post: fetchPost()));

void main() {
  runApp(MainScreen(post: fetchPost(),
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => MainScreen(),
      // When we navigate to the "/second" route, build the SecondScreen Widget
      '/second': (context) => LoginScreen(),
      '/third': (context) => RegisteredScreen(),
    },
  ));

}

class MainScreen extends StatelessWidget {
  final Future<Post> post;
  MainScreen({Key key, this.post, String title, String initialRoute, 
    Map<String, StatelessWidget Function(context)> routes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy farm'),
      ),
      body: Center(
        child : Column
          (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Text('會員登入'),
                // #28b7b8
                color: Color(0xff28a2c5),
                textColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },
                child: Text('會員註冊'),
                // #28b7b8
                color: Color(0xff28a2c5),
                textColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: FlatButton(
                onPressed: () {
                  // OnboardTipPage()
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      //builder: (BuildContext context) => OnboardTipPage(),
                    ),
                  );
                },
                child: Text('服務介紹'),
                // #28b7b8
                color: Color(0xff28a2c5),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class context {
}


void login() {

  //login check
  //var post;
  FutureBuilder<Post>(
    future: post,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text(snapshot.data.sysmsg);
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }

      // By default, show a loading spinner
      return CircularProgressIndicator();
    },
  );


}


class LoginScreen extends StatelessWidget {
  //0408getJson
  //final String url = 'https://swapi.co/api/abc';
  //List data;

  @override
  void initState(){
    //super.initState();
    //this.getJsonData();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: new Container(
        child: new ListView(
            children: <Widget>[
              new Container(
                child: new Text(
                    "會員登入",
                    style: new TextStyle(fontSize: 38.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto")
                ),
              ),
              SizedBox(height: 50.0),
              new TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(height: 10.0),
              new TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "密碼",
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(height: 80.0),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(key: null,
                        color: const Color(0xFFe0e0e0),
                        onPressed: login,
                        child:
                        new Text(
                          "登入",
                          style: new TextStyle(fontSize: 12.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),

                        )
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    new RaisedButton(key: null,
                        color: const Color(0xFFe0e0e0),
                        child:
                        new Text(
                          "取消",
                          style: new TextStyle(fontSize: 12.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        )
                    )
                  ]

              ),

              /*new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            //Navigator.of(context).pushNamed(HomePage.tag);
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white,)),
        ),*/

              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "或者",
                      style: new TextStyle(fontSize: 28.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )
                  ]

              ),
              SizedBox(height: 20.0),
              Container(
                width: 280.0,
                height: 50.0,
                color: Color(0xffffff),
                child:
                new RaisedButton(key: null,
                  child: Image.asset('images/google.jpg',
                    width: 280.0,
                    height: 50.0,),
                  onPressed: login,
                ),
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    /*new Text(
          'G Google帳號快速登入 $username',
          style: new TextStyle(
              fontSize: 20.0,
              color: new Color(0xFF8B1122),
      ),
    ),*/
                  ]

              ),
            ]
        ),
      ),
    );
  }
}


class RegisteredScreen extends StatelessWidget {
  var isChecked = false;

//getJson
  //final String url = 'https://swapi.co/api/abc';
  //List data;

  @override
  void initState(){
    //super.initState();
    //this.getJsonData();

  }

  void onChanged(bool value){
    setState()
    {
      isChecked = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: new Container(
        child: new ListView(
            children: <Widget>[
              new Container(
                child: new Text(
                    "會員註冊",
                    style: new TextStyle(fontSize: 38.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto")
                ),
              ),
              SizedBox(height: 50.0),
              new TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "姓名",
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(height: 10.0),
              new TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(height: 10.0),
              new TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "密碼",
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(height: 10.0),
              new TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "重複密碼",
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(height: 10.0),
              /*new Checkbox(value:  isChecked, onChanged: (bool value),
                  {onChanged(value)}},*/
              new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Checkbox(key:null, onChanged: onChanged, value:true),
                    //new CheckBox(value: true, onChanged: (bool value){onChanged(value);}),
                    new Text(
                      "我已明確瞭解網站服務條款及隱私權保護政策",
                      style: new TextStyle(fontSize:16.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )
                  ]

              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(key: null,
                        color: const Color(0xFFe0e0e0),
                        onPressed: login,
                        child:
                        new Text(
                          "會員註冊",
                          style: new TextStyle(fontSize: 12.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),

                        )
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    new RaisedButton(key: null,
                        color: const Color(0xFFe0e0e0),
                        child:
                        new Text(
                          "取消",
                          style: new TextStyle(fontSize: 12.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        )
                    )
                  ]

              ),

              /*new RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  //Navigator.of(context).pushNamed(HomePage.tag);
                },
                padding: EdgeInsets.all(12),
                color: Colors.lightBlueAccent,
                child: Text('Log In', style: TextStyle(color: Colors.white,)),
              ),*/

              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "或者",
                      style: new TextStyle(fontSize: 28.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )
                  ]

              ),
              Container(
                width: 280.0,
                height: 50.0,
                color: Color(0x66FFFF),
                child:
                new RaisedButton(key: null,
                  child: Image.asset('images/google.jpg',
                    width: 280.0,
                    height: 50.0,),
                  onPressed: login,
                ),
              ),
              /*new RaisedButton(key: null,
                  color: Colors.white,
                  child: Image.asset('images/google.jpg',
                    width: 280.0,

                  )
              ),*/

            ]
        ),
      ),
    );
  }
}