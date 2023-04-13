// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:gspresence/theme/theme.dart';
import 'package:gspresence/utils/my_firebase.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({
    Key? key,
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.poste,
    required this.salaire,
  }) : super(key: key);
  final String id;
  final String name;
  final String phone;
  final String email;
  final String poste;
  final String salaire;



  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController posteController;
  late final TextEditingController salaireController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
    posteController = TextEditingController(text: widget.poste);
    salaireController = TextEditingController(text: widget.salaire);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    posteController.dispose();
    salaireController.dispose();
  }
// fonction pour modifier
  void editContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        await MyFirebase.contactsCollection.doc(widget.id).update({
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'email': emailController.text.trim(),
          'poste': posteController.text.trim(),
          'salaire': salaireController.text.trim(),
        });
        Navigator.pop(context);
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to edit contact'),
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
        title: const Text("Modifier employe"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          // afficher un avatar
          Center(
            child: Hero(
              tag: widget.id,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  "https://avatars.dicebear.com/api/avataaars/${widget.name}.png",
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
//verrifiacation du formulaire  pour la modification
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a phone number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Phone",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 40),
                //button d edition

                 const SizedBox(height: 20),
                TextFormField(
                  controller: posteController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: "Poste",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 40),
                //button d edition

                 const SizedBox(height: 20),
                TextFormField(
                  controller: salaireController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: "Salaire",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 40),
                //button d edition
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton.icon(
                      onPressed: editContact,
                      icon: const Icon(IconlyBroken.edit),
                      label: const Text("Modifier employe")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
