import 'Article_model.dart';

class News {
  String? status;
  int? totalResults;
  List<Article>? articles;

  News({this.status, this.totalResults, this.articles});

  News.fromJson(Map<String, dynamic> json) {
    List<Article> a =[];
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles =  a;
      json['articles'].forEach((v) {
        articles!.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}