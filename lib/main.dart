import 'package:aplikasicatatan/catatan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController judulCtrl = TextEditingController();
  TextEditingController isiCtrl = TextEditingController();
  List<Catatan> listCatatan = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Catatan Pagi"),
        centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: judulCtrl,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Judul catatan")),
              const SizedBox(height: 10),
              TextField(
                controller: isiCtrl,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Isi catatan")),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(onPressed: () {
                    judulCtrl.clear();
                    isiCtrl.clear();
                  }, child: Text("Clear")),
                  ElevatedButton(onPressed: () {
                    setState(() {
                    listCatatan.add(
                      Catatan(judul: judulCtrl.text, isi: isiCtrl.text)
                    );
                    judulCtrl.clear();
                    isiCtrl.clear();
                    });
                    
                  }, child: Text("Submit")),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listCatatan.length,
                  itemBuilder: (context, index){
                return ListTile(
                  leading: Icon(Icons.note_rounded),
                  title: Text(listCatatan[index].judul, style: TextStyle(fontWeight: FontWeight.bold),), subtitle: Text(listCatatan[index].isi));
              }))
            ],
          ),
        )
      ),
    );
  }
}
