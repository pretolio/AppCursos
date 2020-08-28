import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_animated/auto_animated.dart';
import 'package:cursostreinamentos/helper/api.dart';
import 'package:cursostreinamentos/model/model-cursos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'curso-detalhes.dart';
import 'menu.dart';

List<ModelCursos> listaCursos = List<ModelCursos>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  ScrollController _scrollController;

  _consultarCursos() async {
    Map listatemp = await Api().getcursos();
    if(this.mounted){
      setState(() {
        listaCursos = listatemp["Cursos"].map<ModelCursos>(
                (map) => ModelCursos.fromMap(map)
        ).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _consultarCursos();
  }

  @override
  Widget build(BuildContext context) {
    double alt = MediaQuery.of(context).size.height;

    return Scaffold(backgroundColor: Colors.white,
      endDrawer: Menu(),
      body: Container(height: alt, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]),
              color: Colors.grey[100]
          ),
          child: CustomScrollView(controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(floating: false, pinned: true, snap: false,
                    leading: Container(),
                    actionsIconTheme: IconThemeData(color: Colors.deepOrange),
                    backgroundColor: Colors.grey[100],
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Container(alignment: Alignment.center, child: Container(height: 110, alignment: Alignment.bottomCenter,
                        child: Text("CURSOS E TREINAMENTOS", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepOrange),),
                      ),),
                      centerTitle: true,
                      background: Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.hardLight ),
                              fit: BoxFit.cover,
                              image: AssetImage("img/cursos.jpg")
                          )
                      ),
                        child: Container(alignment: Alignment.bottomCenter, padding: EdgeInsets.only(bottom: 40),
                          child: Text("Selecione o curso ou treinamento que desejar", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.white),),
                        ),
                      ),
                    )
                ),

                LiveSliverList(
                  controller: _scrollController,
                  itemCount: listaCursos.length,
                  showItemInterval: Duration(milliseconds: 180),
                  showItemDuration: Duration(milliseconds: 180),
                  itemBuilder: (BuildContext context, int indice, animation) {
                    Uint8List bytes;
                    BoxDecoration box = BoxDecoration();
                    if(listaCursos[indice].imgtitulo != "" ){
                      box = BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: MemoryImage(bytes = base64Decode( listaCursos[indice].imgtitulo) )
                          )
                      );
                    }
                    return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(animation),
                            child: Padding(padding: EdgeInsets.only(bottom: 2,left: 25, right: 25,),
                              child: Container(padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 15,
                                      spreadRadius: 0.5,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: ListTile(
                                  title: Text( listaCursos[indice].titulo ),
                                  trailing: Container(width: 60.0,
                                      decoration: box
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => DetelhesCurso(
                                          listaCursos[indice].titulo, listaCursos[indice].descricao,
                                          listaCursos[indice].imgtitulo, listaCursos[indice].imgdetalhes,
                                          listaCursos[indice].secimgdetalhes,
                                        )
                                    ));
                                  },
                                ),
                              ),
                            )
                        )
                    );
                  },
                )
              ]
          )
      )
    );
  }
}
