import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './preload.dart';
 void main() {
    WidgetsFlutterBinding.ensureInitialized();   
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
     
   });
 } 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    //bool tresbie=false;
    return MaterialApp(
      title: 'Microsoft-Wallet',
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final flutterWebViewPlugin = FlutterWebviewPlugin();
  bool checkstatus =true;
  bool connectivitystatus =true;
  @override
  void dispose() {
    // TODO: implement dispose
    //flutterWebViewPlugin.dispose();
    super.dispose();
  }

@override
 void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
   // flutterWebViewPlugin.dispose();
  flutterWebViewPlugin.onHttpError.listen((event) {
    setState(() {
      checkstatus=false;
    });
  });
  
    getData();
   
    flutterWebViewPlugin.onStateChanged.listen((event) {
      
      getData();
      print("state just changed boy");
       
    });
  

    //checkup();
    //mata();
    _initializeTimer2();
   // _initializeTimer();
   
  }

  //   @override
  // void dispose() {
  //   // flutterWebViewPlugin.dispose();
  //   // super.dispose();
  // }
//in variables 
  
   Future getData() async {
     try {
   //    start check for network
      await  http.get('https://google.com').timeout(
  Duration(seconds: 10),
  onTimeout: () {
    // time has run out, do what you wanted to do
               setState(() {
          // flutterWebViewPlugin.dispose();
           checkstatus=false;
           flutterWebViewPlugin.close();
           
        });
        return null;
  },
);
//ens for network
        http.Response response =
        await http.get("https://google.com");
        print(response.statusCode);
    if (response.statusCode == HttpStatus.ok ) {
      //var result = jsonDecode(response.body);
      print("there is connection");
               setState(() {
           checkstatus=true;
          
           
          
        });
      //return result;
    }else{
               setState(() {
           checkstatus=false;
          // flutterWebViewPlugin.close();

        });
      print("there is  no connection");
    }
     } on TimeoutException catch (_) {
       setState(() {
           checkstatus=false;
         //  flutterWebViewPlugin.close();

        });
        print("there is  no connection");
  // A timeout occurred.
} on SocketException catch (_) {
  // Other exception
   setState(() {
           checkstatus=false;
         //  flutterWebViewPlugin.close();

        });
   print("there is  no connection");
}
   
  }

  timeou() async {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile) {
          setState(() {
            connectivitystatus =true;
          });
        //want to check if there is network
        return WebviewScaffold(url: null);
} else if (connectivityResult == ConnectivityResult.wifi) {
  //anactio();
       setState(() {
        connectivitystatus =true;

        });
      } else {
         setState(() {
           connectivitystatus =false;
        });
      }
  }

  //end this place
//    mata() async {
//       final connectivityResult = await Connectivity().checkConnectivity();
//       if (connectivityResult == ConnectivityResult.mobile) {
//        // anactio();
          
//             //checkstatus =true;
//             getData();
//             //anactio();
          
          
//         //want to check if there is network
       
// } else if (connectivityResult == ConnectivityResult.wifi) {
//   //anactio();
//        setState(() {
//           // checkstatus=true;
//            //anactio();
//            getData();
//         });
//       } else {
//          setState(() {
//            checkstatus=false;
          
//         });
//       }
//   }
//an action
//  anactio() async {
//             try {
//             final result = await InternetAddress.lookup('google.com');
//             if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//               print('connected');
//                  setState(() {
//             checkstatus =true;
//           });
//             }else{
//               _initializeTimer();
//               checkstatus =false;
//             }
//           } on SocketException catch (_) {
            
//             print('not connected');
//                        setState(() {
//             checkstatus =false;
//           });
//           }
//  }

//  checkup() async {
//             try {
// http.get('https://google.com').timeout(
//   Duration(seconds: 5),
//   onTimeout: () {
//     // time has run out, do what you wanted to do
//               setState(() {
//            checkstatus=false;
//         });
//         return null;

//   },
// );
//       checkstatus=true;
        
//           } catch (error) {

//           }
//  }
// Timer timer;
// void _initializeTimer() {
//     timer = Timer.periodic(const Duration(seconds:20), (__) {
//    checkup();
//     });

//   }

 Timer timer2;
void _initializeTimer2() {
    timer2 = Timer.periodic(const Duration(milliseconds: 150), (__) {
      timeou();
    });

  }
  
//InAppWebViewController webView;
  @override
  Widget build(BuildContext context) {
    return checkstatus && connectivitystatus ? 
    WebviewScaffold(url:"https://trade.max-crypto.com/appi.php",
    appBar: AppBar(
         backgroundColor: Hexcolor("#0c1577"),
         title: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:<Widget>[
                            SizedBox(
                              height:MediaQuery.of(context).size.height/100*10,
                              width:MediaQuery.of(context).size.height/100*4,
                              child: Image.asset(
                                "assets/holy.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                             SizedBox(width:10),
                   Center(child: Text('Microsoft Wallet')),
                  
                   
                ]
              ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.verified_user), onPressed: (){
              flutterWebViewPlugin.reload();
            })
          ],
      ),
withJavascript: true ,
appCacheEnabled: true,
clearCache: false,
resizeToAvoidBottomInset: true,
hidden: false,
withZoom: true,
initialChild:Preload(),
ignoreSSLErrors: true,)
// initialChild: Container(
//         child: const Center(
//           child: CircularProgressIndicator(),
//         )
//     ))
    :
    Scaffold(appBar: AppBar(
         backgroundColor: Hexcolor("#0c1577"),
         title: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:<Widget>[
                            SizedBox(
                              height:MediaQuery.of(context).size.height/100*10,
                              width:MediaQuery.of(context).size.height/100*4,
                              child: Image.asset(
                                "assets/holy.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                             SizedBox(width:10),
                   Center(child: Text('Microsoft Wallet')),
                ]
              ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.sync), onPressed: (){
              flutterWebViewPlugin.reload();
            })
          ],
      ),
      body:Stack(
        children: <Widget>[
                           new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage("assets/walletbackground.png"), fit: BoxFit.cover,),
          ),
        ),
    Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   SizedBox(
                              
                              child: Image.asset(
                                "assets/holy.png",
                                fit: BoxFit.contain,
                              ),
                            ),
 Text("No internect connection detected",style:TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            ),)
                            ,
                            SizedBox(height: 10,),
                  SizedBox(
                          child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Retry",
                      style: TextStyle(color: Colors.white),
                      ),
                      onPressed:(){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage()));
                      }),
            ),
           ]
            ,),
          ),
        )
        ],
               
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:()=> exit(0),
        tooltip: 'I',
        child: Icon(Icons.close),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  // 
  }
}
