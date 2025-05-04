import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_contact_app/contact_details_page.dart';
import 'package:project_contact_app/add_contact_page.dart';
import 'package:project_contact_app/widgets/build_user_contact_tile_widget.dart';
import 'models/contact_hive_model.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}
class _ContactPageState extends State<ContactPage> {
  late Box<ContactHiveModel> contactBox;
  List<ContactHiveModel> contacts = [];
  List<ContactHiveModel> filteredContacts = [];

 void loadContact(){
    contactBox = Hive.box<ContactHiveModel>('contacts');
    contacts = contactBox.values.toList();
    filteredContacts = List.from(contacts);  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContact();
     filteredContacts.sort((a, b) => a.name.compareTo(b.name),);
  }
  void searchContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredContacts = contacts;
      } else {
        filteredContacts = contacts
            .where((contact) =>
            contact.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(right: 100, top: 50),
          child: Text(
            'Contacts',
            style: TextStyle(
                color: Colors.white, fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 35,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddContactPage(
                      isEdit: false,
                    ),
                  ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                // height: 45,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: searchContacts,
                  // controller: searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white10,
                    filled: true,
                    prefixIcon: Icon(
                      size: 30,
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/images/itachi.jpg"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Naveen raj',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 500,
              child: ListView.separated(
                itemCount: filteredContacts.length,
                itemBuilder: (context, index) {
                  ContactHiveModel contact = filteredContacts[index];
                  //ContactHiveModel contact = contactBox.getAt(index)!;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ContactDetailsPage(contact:contact),
                          ));
                    },
                    child: BuildUserContactTileWidget(
                      text: contact.name,
                      textColor: Colors.white,
                      fontSize: 20,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 0.5,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
