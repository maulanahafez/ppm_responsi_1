import 'package:flutter/material.dart';
import 'package:ppm_responsi_1/bloc/ikan_bloc.dart';
import 'package:ppm_responsi_1/model/ikan.dart';
import 'package:ppm_responsi_1/ui/ikan_page.dart';
import 'package:ppm_responsi_1/widget/warning_dialog.dart';

class IkanForm extends StatefulWidget {
  Ikan? ikan;

  IkanForm({Key? key, this.ikan}) : super(key: key);

  @override
  _IkanFormState createState() => _IkanFormState();
}

class _IkanFormState extends State<IkanForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Ikan";
  String tombolSubmit = "SIMPAN";

  final _namaIkanTextboxController = TextEditingController();
  final _jenisIkanTextboxController = TextEditingController();
  final _warnaIkanTextboxController = TextEditingController();
  final _habitatIkanTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.ikan != null) {
      setState(() {
        judul = "Ubah Ikan";
        tombolSubmit = "UBAH";
        _namaIkanTextboxController.text = widget.ikan!.nama!;
        _jenisIkanTextboxController.text = widget.ikan!.jenis!;
        _warnaIkanTextboxController.text = widget.ikan!.warna!;
        _habitatIkanTextboxController.text = widget.ikan!.habitat!;
      });
    } else {
      judul = "Tambah Ikan";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaIkanTextField(),
                _jenisIkanTextField(),
                _warnaIkanTextField(),
                _habitatIkanTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaIkanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Ikan"),
      keyboardType: TextInputType.text,
      controller: _namaIkanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jenisIkanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jenis Ikan"),
      keyboardType: TextInputType.text,
      controller: _jenisIkanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jenis Ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _warnaIkanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Warna Ikan"),
      keyboardType: TextInputType.text,
      controller: _warnaIkanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Warna Ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _habitatIkanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Habitat Ikan"),
      keyboardType: TextInputType.text,
      controller: _habitatIkanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Habitat Ikan harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.ikan != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Ikan createIkan = Ikan(id: null);
    createIkan.nama = _namaIkanTextboxController.text;
    createIkan.jenis = _jenisIkanTextboxController.text;
    createIkan.warna = _warnaIkanTextboxController.text;
    createIkan.habitat = _habitatIkanTextboxController.text;
    IkanBloc.addIkan(ikan: createIkan).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const IkanPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Ikan updateIkan = Ikan(id: null);
    updateIkan.id = widget.ikan!.id!;
    updateIkan.nama = _namaIkanTextboxController.text;
    updateIkan.jenis = _jenisIkanTextboxController.text;
    updateIkan.warna = _warnaIkanTextboxController.text;
    updateIkan.habitat = _habitatIkanTextboxController.text;
    IkanBloc.updateIkan(ikan: updateIkan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const IkanPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
