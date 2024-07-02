import 'package:flutter/material.dart';
import '../../model/pasien.dart';
import '../../service/pasien_service.dart';
import 'pasien_detail.dart';

class PasienUpdateForm extends StatefulWidget {
  final Pasien pasien;

  const PasienUpdateForm({Key? key, required this.pasien}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _PasienUpdateFormState createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<PasienUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomorRmCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  Future<Pasien> getData() async {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    setState(() {
      _nomorRmCtrl.text = data.nomorRm;
    });
    setState(() {
      _namaCtrl.text = data.nama;
    });
    setState(() {
      _tanggalLahirCtrl.text = data.tanggalLahir;
    });
    setState(() {
      _nomorTeleponCtrl.text = data.nomorTelepon;
    });
    setState(() {
      _alamatCtrl.text = data.alamat;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pasien")),
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
          String id = widget.pasien.id.toString();
          await PasienService().ubah(pasien, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PasienDetail(pasien: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
