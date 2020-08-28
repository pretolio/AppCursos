import 'dart:typed_data';
import 'package:cursostreinamentos/telas/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'curso-detalhes.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool ismenu = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(width: double.infinity, color: Colors.black, alignment: Alignment.center,
            child: Padding(padding: EdgeInsets.only(top: 30, bottom: 20),
          child: Text('MENU', style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 30, color: Colors.white),),
        )),

        ListTile(title: Text("HOME", style: TextStyle(fontSize: 20, color: Colors.black),),
          trailing: Icon(Icons.home, color: Colors.black,),
          onTap: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
          },
        ),

        ListTile(title: Text("CURSOS", style: TextStyle(fontSize: 20, color: Colors.black),),
          trailing: ismenu ? Icon(Icons.arrow_upward, color: Colors.black,): Icon(Icons.arrow_downward, color: Colors.black,),
          onTap: (){
            setState(() {
              ismenu = !ismenu;
            });
          },
        ),

        ismenu ?  Container(height: MediaQuery.of(context).size.height - 210,
              child: AnimatedList(
                initialItemCount: listaCursos.length,
                padding:  EdgeInsets.zero,
                itemBuilder: (contex, indice, animation){
                  Uint8List bytes;
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                      position: Tween<Offset>(
                      begin: Offset(0, 0.3),
                      end: Offset.zero,
                  ).animate(animation),
                  child:  Card(child: GestureDetector(
                      child: Padding(padding: EdgeInsets.only(left: 40, bottom: 10, top: 10),
                          child: Text(listaCursos[indice].titulo, style: TextStyle(fontSize: 20, color: Colors.black54),)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DetelhesCurso(
                              listaCursos[indice].titulo, listaCursos[indice].descricao,
                              listaCursos[indice].imgtitulo, listaCursos[indice].imgdetalhes,
                              listaCursos[indice].secimgdetalhes,
                            )
                        ));
                      },
                    ) ,
                  )
                ),
              );
            }
          )
        ): Container()
      ])
    );
  }
}
