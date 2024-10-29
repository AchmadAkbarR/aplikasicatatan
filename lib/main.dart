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
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Judul catatan")),
              const SizedBox(height: 10),
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Isi catatan")),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Clear")),
                  ElevatedButton(onPressed: () {}, child: Text("Submit")),
                ],
              ),
              Expanded(child: ListView.builder(itemBuilder: (context, index){
                return ListTile(
                  leading: Icon(Icons.note_rounded),
                  title: Text("Judul Catatan"), subtitle: Text("Isi catatan panjang"));
              }))
            ],
          ),
        )
      ),
    );
  }
}
