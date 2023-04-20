
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gspresence/theme/theme.dart';
import 'package:gspresence/utils/my_firebase.dart';
import 'package:iconly/iconly.dart';


class AddPoste extends StatefulWidget {
  const AddPoste({Key? key}) : super(key: key);

  @override
  State<AddPoste> createState() => _AddPosteState();
}

class _AddPosteState extends State<AddPoste> {
   final _formKey = GlobalKey<FormState>();
   final nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  } 

void addContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        await MyFirebase2.contactsCollection.add({
          'name': nameController.text.trim(),
        });
        Navigator.pop(context);
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to add poste'),
            backgroundColor: Colors.red[300],
          ),
        );
      }
    } else {
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all the fields'),
          backgroundColor: Colors.red[300],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un Poste"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                // input nom
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Veillez entrer un champs";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "entrer un poste",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 20), 
                // pour le boutton ajouter
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton.icon(
                      onPressed: addContact,
                      icon: const Icon(IconlyBroken.add_user),
                      label: const Text("Sauvegarder")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}