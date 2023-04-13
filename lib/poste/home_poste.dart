import 'package:flutter/material.dart';
import 'package:gspresence/poste/add_poste.dart';
import 'package:gspresence/poste/edit_poste.dart';
import 'package:gspresence/utils/my_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconly/iconly.dart';

class Homeposte extends StatefulWidget {
  const Homeposte({Key? key}) : super(key: key);

  @override
  State<Homeposte> createState() => _HomeposteState();
}

class _HomeposteState extends State<Homeposte> {
  final postesSnapshot = MyFirebase2.contactsCollection.snapshots();
void deleteContact(String id) async {
    await MyFirebase2.contactsCollection.doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Gestion Poste'),
        backgroundColor: Colors.red[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text("Liste Postes"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: postesSnapshot,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              if (documents.isEmpty) {
                return Center(
                  child: Text(
                    "Pas de poste",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
              }
              return ListView.builder(
                itemCount: documents.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final contactId = documents[index].id;
                  final poste =
                      documents[index].data() as Map<String, dynamic>;
                  final String name = poste['poste'];
                  final String avatar =
                      "https://avatars.dicebear.com/api/avataaars/$name.png";
                  return ListTile(
                    onTap: () {},
                    leading: Hero(
                      tag: contactId,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          avatar,
                        ),
                      ),
                    ),
                    title: Text(name),
                    subtitle: Text("$name"),
                    isThreeLine: true,
                    // bouton d'edition
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPoste(
                                  //id: contactId,
                                  //name: name,
                                ),
                              ),
                            ); 
                          },
                          splashRadius: 24,
                          icon: const Icon(IconlyBroken.edit, color: Colors.green,),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteContact(contactId);
                          },
                          splashRadius: 24,
                          icon: const Icon(IconlyBroken.delete,color: Colors.red,),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("An Error Occured"),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }),
          //button d'ajout flottant
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPoste(),
            ),
          );
        },
        label: const Text("Ajouter un Poste"),
        icon: const Icon(IconlyBroken.document),
      ),
    );
  }
}