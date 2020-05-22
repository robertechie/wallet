import 'package:flutter/material.dart';

class Preload extends StatefulWidget {
 

  @override
  _PreloadState createState() => _PreloadState();
}

class _PreloadState extends State<Preload> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   SizedBox(
                              
                              child: Image.asset(
                                "assets/micbak.gif",
                                fit: BoxFit.contain,
                              ),
                            ),
      
           ]
            ,),
          ),
        );
   
  }
}