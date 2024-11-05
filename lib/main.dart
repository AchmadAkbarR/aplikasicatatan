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
  List<Map<String, dynamic>> items = [
    {"nama": "Laptop", "harga": 25000000, "jumlah": 0},
    {"nama": "Mouse", "harga": 1250000, "jumlah": 0},
    {"nama": "Keyboard", "harga": 1500000, "jumlah": 0},
    {"nama": "Monitor", "harga": 5000000, "jumlah": 0},
    {"nama": "Printer", "harga": 2200000, "jumlah": 0},
  ];

  bool showReceipt = false; // Untuk kontrol tampilan struk
  int displayedTotal = 0;   // Total yang ditampilkan, hanya diperbarui ketika tombol cetak ditekan

  void reset() {
    setState(() {
      for (var item in items) {
        item["jumlah"] = 0;
      }
      showReceipt = false;
      displayedTotal = 0; // Reset total yang ditampilkan
    });
  }

  int calculateTotal() {
    return items.fold<int>(0, (sum, item) => sum + (item["harga"] as int) * (item["jumlah"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Toko Komputer"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  TextEditingController jumlahCtrl = TextEditingController(
                      text: items[index]["jumlah"].toString());

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    title: Text(items[index]["nama"]),
                    subtitle: Text("Rp ${items[index]["harga"].toString()}"),
                    trailing: SizedBox(
                      width: 60,
                      child: TextField(
                        controller: jumlahCtrl,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            items[index]["jumlah"] = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: reset,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showReceipt = true;
                      displayedTotal = calculateTotal(); // Perbarui total saat tombol cetak ditekan
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Cetak Struk"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (showReceipt)
              Expanded(
                child: ListView(
                  children: [
                    for (var item in items)
                      if (item["jumlah"] > 0)
                        ListTile(
                          leading: const Icon(Icons.receipt),
                          title: Text("${item["nama"]} x ${item["jumlah"]}"),
                          trailing: Text(
                            (item["harga"] * item["jumlah"]).toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Rp $displayedTotal", // Tampilkan total yang hanya diperbarui saat tombol cetak ditekan
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
