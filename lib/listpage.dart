
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myanmar_emergency/detail.dart';
import 'package:myanmar_emergency/sub_category.dart';
import 'package:myanmar_emergency/sub_category_dao.dart';
import 'package:path_provider/path_provider.dart';

import 'detail_dao.dart';
import 'detailpage.dart';
import 'info.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key, required this.catId, required this.title, required this.subCategoryDao, required this.detailDao}) : super(key: key);
  final catId;
  final String title;
  final SubCategoryDao subCategoryDao;
  final DetailDao detailDao;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
      final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.blue,
      title: Text(widget.title),
    );

      ListTile makeListTile(Info info, SubCategory subcatobj) => ListTile(
        onTap: () {
          var imagePath = "";
          widget.detailDao.getDetail(subcatobj.catId+subcatobj.id).then((detailValue) =>

          getExternalStorageDirectory().then((dir) =>
          {

            if (detailValue?.image.isNotEmpty??false) {
              imagePath = (dir?.path??"") + Platform.pathSeparator+"cache"+Platform.pathSeparator+(detailValue?.image??""),
              print(imagePath)
              },

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(detail:detailValue ?? Detail("", "", "", ""), title: subcatobj.name, imagePath: imagePath)))
          })

          );

        },
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child:Column(mainAxisAlignment: MainAxisAlignment.center, children:[SizedBox( width: 35, height: 35, child: ((subcatobj.icon).length > 0)? CachedNetworkImage(imageUrl: subcatobj.icon)  : Container())]),
        ),
        title: Text(
          subcatobj.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

     /*   subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(" Intermediate", style: TextStyle(color: Colors.white))
          ],
        ),*/
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
         Card makeCard(Info info, SubCategory subcatobj) => Card(
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: makeListTile(info, subcatobj),
      ),
    );

       Container makeBody(Info info) => Container(
      child: StreamBuilder<List<SubCategory>> (
        stream: widget.subCategoryDao.getSubCategoriesAsStream(widget.catId),
          builder: (_, snapshot) {
       if (!snapshot.hasData) return Container();

       final data = snapshot.requireData;
       return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(info, data[index]);
        },
      );}),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar,
      body: makeBody(getInfo()),
    );
  }

   Info getInfo() {
  return Info(pictureUrl: "https://lh6.googleusercontent.com/QxwaCGQnXzyFe3W8axkXBLD467LmEHnPUNYR1rZFOeQJOwRqkFRVrlSX_DdgZjW5ZsuoVRi2gfYl5sZckNj6VthKyZHTouITIZvuZcY5",
      title: "CPR ပြုလုပ်နည်း",
      notes: getNotes()
    );
  }
  List<String> getNotes() {
    return [
      "လူနာကို ဘေးကင်းရာ မာသော ကြမ်းပြင် တွင် ပက်လက် ထားပါ။",
      "လူနာဘေးတွင် ဒူးထောက်ထိုင်ချပြီး မိမိ​၏ လက်ဖနှောင့်ကို လူနာ၏ ရင်ဘက် အလယ်ခေါင် ပေါ်သို့ တင်ပါ။",
      "ပထမ လက်ပေါ်သို့ နောက်လက်တဖက် တင်လိုက်ပြီး လက်ချောင်းများ ယှက်ထားပါ လက်မောင်းကို ဆန့်နေအောင် ထားရမည်။ ကလေးငယ် ဖြစ်ပါက လက်ချောင်းနှစ်ချောင်းသာ အသုံးပြုပါ။",
      "မိမိ​၏ ခန္ဓာကိုယ်ကို ရှေ့သို့ကိုင်းချ လိုက်ပါ။ မိမိ​၏ တကိုယ်လုံးအားကို အသုံးပြု၍ လူနာ့ရင်ဘက်ကို ၂ လက်မ ထိနိမ့်ဝင်သွားစေရန် ဖိချရမည်။"

    ];
  }

}

