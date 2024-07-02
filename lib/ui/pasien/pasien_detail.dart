import 'package:flutter/material.dart';
import '../../service/pasien_service.dart';
import 'pasien_page.dart';
import 'pasien_update_form.dart';
import '../../model/pasien.dart';

class PasienDetail extends StatefulWidget {
  final Pasien pasien;

  const PasienDetail({Key? key, required this.pasien}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _PasienDetailState createState() => _PasienDetailState();
}

class _PasienDetailState extends State<PasienDetail> {
  Stream<Pasien> getData() async* {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pasien")),
      body: StreamBuilder(
        stream: getData(),
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
            return const Text('Data Tidak Ditemukan');
          }
          return Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Nomor RM : ${snapshot.data.nomorRm}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nama : ${snapshot.data.nama}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Tanggal Lahir : ${snapshot.data.tanggalLahir}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nomor Telepon : ${snapshot.data.nomorTelepon}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Alamat : ${snapshot.data.alamat}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_tombolUbah(), _tombolHapus()],
              )
            ],
          );
        },
      ),
    );
  }

  _tombolUbah() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PasienUpdateForm(pasien: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Ubah")));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Yakin ingin menghapus data ini?"),
            actions: [
              StreamBuilder(
                  stream: getData(),
                  builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                        onPressed: () async {
                          await PasienService()
                              .hapus(snapshot.data)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PasienPage()));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("YA"),
                      )),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Tidak"),
              )
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }
}
