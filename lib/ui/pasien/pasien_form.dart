import 'package:flutter/material.dart';
import 'package:klinik_app/model/pasien.dart';
import 'package:klinik_app/service/pasien_service.dart';
import '../../model/poli.dart';
import '../../service/poli_service.dart';
import 'pasien_detail.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _PasienFormState createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomorRmCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNomorRm(),
              _fieldNamaCtrl(),
              _fieldTanggalLahir(),
              _fieldNomorTelepon(),
              _fieldAlamat(),
              const SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNomorRm() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor RM"),
      controller: _nomorRmCtrl,
    );
  }

  _fieldNamaCtrl() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama"),
      controller: _namaCtrl,
    );
  }

  _fieldTanggalLahir() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir"),
      controller: _tanggalLahirCtrl,
    );
  }

  _fieldNomorTelepon() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _nomorTeleponCtrl,
    );
  }

  _fieldAlamat() {
    return TextField(
      decoration: const InputDecoration(labelText: "Alamat"),
      controller: _alamatCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pasien pasien = Pasien(
              nomorRm: _nomorRmCtrl.text,
              nama: _namaCtrl.text,
              tanggalLahir: _tanggalLahirCtrl.text,
              nomorTelepon: _nomorTeleponCtrl.text,
              alamat: _alamatCtrl.text);

          await PasienService().simpan(pasien).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PasienDetail(pasien: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
