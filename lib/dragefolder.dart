import 'package:flutter/material.dart';

class dragefolder extends StatefulWidget{
  @override
  State<dragefolder> createState() => _dragefolderState();
}

class _dragefolderState extends State<dragefolder> {
  int accepdraggable =0;

  int accepttarget=0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
       accepdraggable==0?   Draggable(
            data: Colors.green,
            child: Container(
              width: 40,
              height: 40,
              color: Colors.red,
            ), feedback: Container(
              width: 40,
              height: 40,
              color: Colors.pink,
            ),
            childWhenDragging: Container(
              width: 40,
              height: 40,
              color: Colors.grey,
            ),
            ):  Container(
              width: 40,
              height: 40,
              color: Colors.black,
            ),
          accepttarget==0?  DragTarget(
              onWillAccept: (data) {
              return  data!=Colors.black;
              
              },
              onAccept: (data) {
              
                setState(() {
                  accepdraggable=1;
                   accepttarget=1;
                });
              },
              onLeave: (data) {
                
              },
              builder:(context, candidateData, rejectedData) {
                return candidateData.length>0?Container(
              width: 40,
              height: 40,
              color: Colors.yellow,
            ):Container(
              width: 40,
              height: 40,
              color: Colors.white30,
            );
              },):Container(
              width: 40,
              height: 40,
              color: Colors.blueAccent,
            )
        ],
      ),
    );
  }
}