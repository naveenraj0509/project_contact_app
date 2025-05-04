import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_contact_app/contact_details_page.dart';
import 'package:project_contact_app/contact_page.dart';
import 'package:project_contact_app/widgets/build_add_contact_appbar_widget.dart';
import 'package:project_contact_app/widgets/build_text_field_widget.dart';
import 'package:project_contact_app/widgets/build_user_contact_tile_widget.dart';
import 'models/contact_hive_model.dart';

class AddContactPage extends StatefulWidget {
  final ContactHiveModel? contact;
  final bool isEdit;

  const AddContactPage({
    super.key,
    this.contact,
    required this.isEdit,
  });

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  late Box<ContactHiveModel> contactBox;

  @override
  void initState() {
    contactBox = Hive.box<ContactHiveModel>('contacts');

    if (widget.isEdit == true) {
      nameController.text = widget.contact?.name ?? "";
      numberController.text = widget.contact?.number ?? "";
      // TODO: implement initState
    }
    super.initState();
  }

  void saveContact() async{
    final newContact = ContactHiveModel(
      widget.isEdit ? widget.contact!.id : DateTime.now().toString(),
      nameController.text,
      numberController.text,
    );
    if (widget.isEdit && widget.contact!.id!= null) {
      // update contact
    await  contactBox.put(widget.contact!.id, newContact);
    Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => ContactDetailsPage(contact: newContact),
        ),
      );
    } else {
      contactBox.put(newContact.id, newContact);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => ContactPage(),
        ),
      );
    }
    // Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              BuildAddContactAppbarWidget(
                  actionText: widget.isEdit ? "Update" : "Save",
                  centerText: widget.isEdit ? "Edit Contact" : "New Contact",
                  leadText: "Cancel",
                  onActionPressed: () {
                    saveContact();
                  }),
              SizedBox(
                height: 25,
              ),
              CircleAvatar(
                radius: 79,
                backgroundImage: AssetImage("assets/images/person avatar.webp"),
              ),
              Text(
                'Add Photo',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: BuildTextFieldWidget(
                  hintText: 'Full name',
                  textEditingController: nameController,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              BuildTextFieldWidget(
                hintText: 'Last name',
              ),
              SizedBox(
                height: 1,
              ),
              BuildTextFieldWidget(
                hintText: 'Company',
              ),
              SizedBox(
                height: 45,
              ),
              BuildTextFieldWidget(
                iconWidget: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          CupertinoIcons.minus_circle_fill,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'mobile',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white54,
                        size: 18,
                      )
                    ],
                  ),
                ),
                hintText: 'Phone',
                textEditingController: numberController,
              ),
              SizedBox(
                width: 1,
              ),
              Container(
                color: Colors.white10,
                child: BuildUserContactTileWidget(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: 26,
                  ),
                  text: 'add phone',
                  fontSize: 18,
                  textColor: Colors.white,
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
