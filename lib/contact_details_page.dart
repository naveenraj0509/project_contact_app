import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_contact_app/add_contact_page.dart';
import 'package:project_contact_app/contact_page.dart';
import 'models/contact_hive_model.dart';

class ContactDetailsPage extends StatefulWidget {
  final ContactHiveModel contact;
  const ContactDetailsPage({super.key, required this.contact});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late Box<ContactHiveModel> contactBox;

  @override
  void initState() {
    super.initState();
    contactBox = Hive.box<ContactHiveModel>('contacts');
  }

  void deleteContact() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Contact"),
        content: Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              contactBox.delete(widget.contact.id);
              Navigator.pop(context);
              // Navigator.pop(context, true);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ContactPage(),
                ),
              );
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333333),
      appBar: AppBar(
        backgroundColor: Color(0xFF333333),
        leading: TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => ContactPage(),
            ),
          ),
          child: Text(
            "Contacts",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
        ),
        leadingWidth: 120,
        title: TextButton(
            onPressed: deleteContact,
            child: Text(
              "Delete Contact",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            )),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddContactPage(
                    contact: widget.contact,
                    // id: widget.,
                    isEdit: true,
                  ),
                )),
            child: Text(
              "Edit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage("assets/images/person avatar.webp"),
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.contact.name,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              Text(
                widget.contact.number,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 80,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    List<IconData> icons = [
                      Icons.call,
                      Icons.message,
                      Icons.video_call,
                      Icons.mail,
                    ];
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF444444),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          icons[index],
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
