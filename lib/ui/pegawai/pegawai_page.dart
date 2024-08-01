import 'package:flutter/material.dart';
import 'package:klinik_app/ui/pegawai/pegawai_form.dart';
import '../../model/pegawai.dart';
import 'pegawai_item.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});
  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pegawai"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PegawaiForm()));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          PegawaiItem(
              pegawai: Pegawai(
                  nip: "12220551",
                  nama: "Miftah Fadilah",
                  tanggalLahir: "27 - 11 - 2004",
                  nomorTelepon: "12220551",
                  email: "miftahfadilah71@gmail.com",
                  password: "password")),
          PegawaiItem(
              pegawai: Pegawai(
                  nip: "12220551",
                  nama: "Gadis Syalwa",
                  tanggalLahir: "27 - 11 - 2004",
                  nomorTelepon: "12220551",
                  email: "gadisyalwa@gmail.com",
                  password: "password")),
          PegawaiItem(
              pegawai: Pegawai(
                  nip: "12220551",
                  nama: "Rana Nurfatin",
                  tanggalLahir: "27 - 11 - 2004",
                  nomorTelepon: "12220551",
                  email: "rana@gmail.com",
                  password: "password")),
          PegawaiItem(
              pegawai: Pegawai(
                  nip: "12220551",
                  nama: "Alfath",
                  tanggalLahir: "27 - 11 - 2004",
                  nomorTelepon: "12220551",
                  email: "alfath@gmail.com",
                  password: "password")),
          PegawaiItem(
              pegawai: Pegawai(
                  nip: "12220551",
                  nama: "Hanif Faturahman",
                  tanggalLahir: "27 - 11 - 2004",
                  nomorTelepon: "12220551",
                  email: "hanif@gmail.com",
                  password: "password")),
        ],
      ),
    );
  }
}
