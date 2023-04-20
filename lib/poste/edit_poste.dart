import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:gspresence/theme/theme.dart';
import 'package:gspresence/utils/my_firebase.dart';

class EditPoste extends StatefulWidget {
  const EditPoste({
    Key? key,
    required this.id,
    required this.name,


  }) : super(key: key);
  final String id;
  final String name;

  @override
  State<EditPoste> createState() => _EditPosteState();
}

class _EditPosteState extends State<EditPoste> {
final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  
  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    super.initState();
  }
@override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }
  // fonction pour modifier
  void editPoste() async {
    if (_formKey.currentState!.validate()) {
      try {
        await MyFirebase2.contactsCollection.doc(widget.id).update({
          'name': nameController.text.trim(),
        });
        Navigator.pop(context);
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Erreur poste'),
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
        title: const Text("Modifier Poste"),
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
                    hintText: "entrer la poste",
                    contentPadding: inputPadding,
                  ),
                ),             
                
                const SizedBox(height: 40),
                //button d edition
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton.icon(
                      onPressed: editPoste,
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