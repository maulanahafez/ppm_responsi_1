import 'package:flutter/material.dart';
import 'package:ppm_responsi_1/bloc/ikan_bloc.dart';
import 'package:ppm_responsi_1/model/ikan.dart';
import 'package:ppm_responsi_1/ui/ikan_form.dart';
import 'package:ppm_responsi_1/ui/ikan_page.dart';
import 'package:ppm_responsi_1/widget/warning_dialog.dart';

class IkanDetail extends StatefulWidget {
  Ikan? ikan;

  IkanDetail({Key? key, this.ikan}) : super(key: key);

  @override
  _IkanDetailState createState() => _IkanDetailState();
}

class _IkanDetailState extends State<IkanDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Ikan'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "ID : ${widget.ikan!.id}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.ikan!.nama}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Jenis : ${widget.ikan!.jenis}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Warna : ${widget.ikan!.warna}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Habitat : ${widget.ikan!.habitat}",
              style: const TextStyle(fontSize: 20.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IkanForm(
                  ikan: widget.ikan!,
                ),
              ),
            );
          },
        ),
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            IkanBloc.deleteIkan(widget.ikan!.id).then((value) {
              if (value) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const IkanPage(),
                ));
              } else {
                showDialog(
                  context: context,
                  builder: (context) => const WarningDialog(
                    description: "Gagal menghapus data. Silakan coba lagi.",
                  ),
                );
              }
            }).catchError((error) {});

            Navigator.pop(context);
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
