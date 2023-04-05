import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import 'widgets.dart';

class SubmitVideo extends StatefulWidget {
  const SubmitVideo({
    super.key,
  });

  @override
  State<SubmitVideo> createState() => _SubmitVideoState();
}

class _SubmitVideoState extends State<SubmitVideo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? title;
  String? description;
  String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Container(
          height: 300,
          width: 500,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTexField(
                  hint: "Nombre",
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      title = value;
                      return null;
                    }
                    return "Campo vacio";
                  },
                ),
                CustomTexField(
                  hint: "Descripción",
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      description = value;
                      return null;
                    }
                    return "Campo vacio";
                  },
                ),
                CustomTexField(
                  hint: "URL",
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.contains("https://www.youtube.com")) {
                      url = value;
                      return null;
                    }
                    return "URL no válida";
                  },
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.save();

                        if (_formKey.currentState?.validate() ?? false) {
                          Video video = Video.empty();
                          Navigator.pop(context, video.copyWith(title: title, description: description, url: url));
                        }
                      },
                      child: const Text("Subir video")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
