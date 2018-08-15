import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';

class VerseCategoryAddPage extends StatefulWidget {
  VerseCategoryAddPage({Key key}) : super(key: key);

  @override
  _VerseCategoryAddPageState createState() => new _VerseCategoryAddPageState();
}

class _VerseCategoryAddPageState extends State<VerseCategoryAddPage> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Add Category'),),
      body: Text('Add category'),
    );
  }
}


class CategoryAddContent extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final VerseCategory editedCategory;
  final Function(VerseCategory) addVerseCategory;
  
  CategoryAddContent(this.addVerseCategory, {this.editedCategory});
  
  @override
  Widget build(BuildContext context) {
  
  final TextEditingController _nameController = TextEditingController(text: editedCategory.name);
  final TextEditingController _descriptionController = TextEditingController(text: editedCategory.description);

    return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new TextFormField(
              decoration: InputDecoration(hintText: 'name',labelText: 'Name'),
              controller: _nameController,
              validator: (String val){
               if(val.trim().isEmpty){
                 return 'Please Input a valid name';
               }
              },
            
            ),
            new TextFormField(
                decoration: InputDecoration(hintText: 'less than 250 characters', labelText: 'Description'),
                controller: _descriptionController,
                validator: (String val){
                    if(val.length > 250){
                      return 'Length should be less than 250 characters';
                    }
                },
            ),
           Container(
             padding: new EdgeInsets.only(top:20.0),
             width: MediaQuery.of(context).size.width,
             child:  RaisedButton(
               onPressed:() => _submit(_nameController.text, _descriptionController.text),
               child: new Text('Add Category'),
             )
           )

          ],
        );
  }


  void _submit(String name, String description) {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      
      if(editedCategory != null){
        editedCategory.name = name;
        editedCategory.description = description;
        addVerseCategory(editedCategory);
      }else{
        VerseCategory categoryToAdd = VerseCategory(name: name, description: description, isDefault: false);
        addVerseCategory(categoryToAdd);
      }
    }
  }
}

