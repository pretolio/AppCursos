
class ModelCursos {
  String titulo;
  String descricao;
  String imgtitulo;
  String imgdetalhes;
  String secimgdetalhes;

  ModelCursos(this.titulo, this.descricao, this.imgtitulo, this.imgdetalhes, this.secimgdetalhes);

  ModelCursos.fromMap(Map map){
    this.titulo = map["titulo"];
    this.descricao = map["descricao"];
    this.imgtitulo = map["imgtitulo"];
    this.imgdetalhes = map["imgdetalhes"];
    this.secimgdetalhes = map["imgdetalhes2"];
  }
}