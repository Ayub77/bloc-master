// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc/model/post_model.dart';
import 'package:bloc/services/http_service.dart';
import 'package:flutter/material.dart';

class UpdateAndAdd extends StatefulWidget {
  const UpdateAndAdd(
      {Key? key, required this.title, required this.id, this.post})
      : super(key: key);
  final String title;
  final String id;
  final dynamic post;
  @override
  State<UpdateAndAdd> createState() => _UpdateAndAddState();
}

class _UpdateAndAddState extends State<UpdateAndAdd> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final userIdController = TextEditingController();
  final idController = TextEditingController();

  _apiPostAdd() async {
    if (widget.title == "Add") {
     Post post = Post(
          id: int.parse(idController.text.trim()),
          title: titleController.text.trim(),
          body: bodyController.text.trim(),
          userId: int.parse(userIdController.text.trim()));

      var respons = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
      if (respons != null) {
        Navigator.pop(context, true);
      }
    } else {
      Post post = Post(
          id: int.parse(idController.text.trim()),
          title: titleController.text.trim(),
          body: bodyController.text.trim(),
          userId: int.parse(userIdController.text.trim()));

      var respons = await Network.PUT(Network.API_UPDATE + widget.id, Network.paramsUpdate(post));
      if (respons != null) {
        Navigator.pop(context, true);
      }
    }
  }

  choose() {
    if (widget.title == "Update") {
      titleController.text = widget.post.title;
      bodyController.text = widget.post.body;
      userIdController.text = widget.post.userId.toString();
      idController.text = widget.post.id.toString();
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  labelText: "title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green, width: 1))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  labelText: "body",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green, width: 1))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: userIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  labelText: "userId",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green, width: 1))),
            ),
            widget.title != "Add"
                ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: idController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: "id",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 1))),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {
                _apiPostAdd();
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
