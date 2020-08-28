import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'menu.dart';

class DetelhesCurso extends StatefulWidget {
  String titulo;
  String descricao;
  String img;
  String imgdetalhes;
  String secimgdetalhes;

  DetelhesCurso(this.titulo, this.descricao, this.img, this.imgdetalhes,
      this.secimgdetalhes);

  @override
  _DetelhesCursoState createState() => _DetelhesCursoState();
}

class _DetelhesCursoState extends State<DetelhesCurso> {
  Uint8List bytes;
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    double alt = MediaQuery.of(context).size.height;
    double larg = MediaQuery.of(context).size.width;

    return Container(color: Colors.white,
      child: Container(height: alt, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]),
            color: Colors.grey[100]
        ),
        child: Scaffold(backgroundColor: Colors.transparent,
            endDrawer: Menu(),
            appBar: PreferredSize(preferredSize: Size.fromHeight(180), child:
            AppBar(backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
              leading: Center(),
              actionsIconTheme: IconThemeData(color: Colors.deepOrange),
              title: GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                },
                child: Center(child: Container(margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                  child: Icon(Icons.keyboard_arrow_left, color: Colors.white,),),),
              ),
              flexibleSpace: Container(height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken ),
                      fit: BoxFit.cover,
                      image: MemoryImage(bytes = base64Decode( widget.img) ),
                    )
                ),
                child: Container(alignment: Alignment.center, padding: EdgeInsets.only(top: 50),
                  child: Text(widget.titulo, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepOrange,
                  shadows: [BoxShadow(color: Colors.black, blurRadius: 20, spreadRadius: 10, offset: Offset(1, 1))])),
                ),
              ),
            )),
            body:  SingleChildScrollView(
              child: Container( margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(0, 6.5),
                    )
                  ],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Padding(padding: EdgeInsets.all(20),
                    child: Text(widget.descricao),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      Image.memory(bytes = base64Decode( widget.imgdetalhes),
                        width: larg/3, height: 150, fit: BoxFit.cover,
                      ),
                      Image.memory(bytes = base64Decode( widget.secimgdetalhes),
                        width: larg/3, height: 150, fit: BoxFit.cover,
                      ),
                    ],),
                  )
                ],),
              )
            )
        ),
      ),
    );
  }
}
