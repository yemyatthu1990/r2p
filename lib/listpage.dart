import 'package:flutter/material.dart';

import 'detailpage.dart';
import 'info.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
      final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.red,
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

      ListTile makeListTile(Info info) => ListTile(
        onTap: () {
           Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(info: info)));
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.add_moderator, color: Colors.white),
        ),
        title: Text(
          info.title,
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
         Card makeCard(Info info) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: makeListTile(info),
      ),
    );

       Container makeBody(Info info) => Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(info);
        },
      ),
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

