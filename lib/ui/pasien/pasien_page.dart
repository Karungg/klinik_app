import 'package:flutter/material.dart';
import '../../model/pasien.dart';
import '../../service/pasien_service.dart';
import 'pasien_form.dart';
import 'pasien_item.dart';
import '../../widget/sidebar.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _PasienPageState createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  Stream<List<Pasien>> getList() async* {
    List<Pasien> data = await PasienService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Data Pasien"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PasienForm()));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: getList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return PasienItem(pasien: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
