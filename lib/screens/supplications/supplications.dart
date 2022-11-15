import 'package:flutter/material.dart';

class Supplications extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return SupplicationsState();
  }
}

class SupplicationsState extends State<Supplications>{
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Supplications',style: TextStyle(color: Colors.red,fontSize: 25),),);
  }
}