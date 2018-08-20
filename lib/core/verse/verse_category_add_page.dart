import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_add_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';

class VerseCategoryAddPage extends StatefulWidget {
  final VerseCategory editedCategory;
  VerseCategoryAddPage({Key key, this.editedCategory}) : super(key: key);

  @override
  _VerseCategoryAddPageState createState() => new _VerseCategoryAddPageState();
}

class _VerseCategoryAddPageState extends State<VerseCategoryAddPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VerseAddViewModel>(
      // TODO: Implement == and hashcode and set distinct to true;
      converter: (store) => VerseAddViewModel.fromStore(store),
      builder: (_, viewModel) {
        return new Scaffold(
          appBar: AppBar(
            title: Text('Add Category'),
          ),
          body: CategoryAddContent(viewModel.addVerseCategory,
              editedCategory: widget.editedCategory),
        );
      },
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
    final TextEditingController _nameController =
        TextEditingController(text: editedCategory?.name);
    final TextEditingController _descriptionController =
        TextEditingController(text: editedCategory?.description);

    return Form(
        key: formKey,
        child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new TextFormField(
            decoration: InputDecoration(hintText: 'name', labelText: 'Name'),
            controller: _nameController,
            validator: (String val) {
              if (val.trim().isEmpty) {
                return 'Please Input a valid name';
              }
            },
          ),
          new TextFormField(
            decoration: InputDecoration(
                hintText: 'less than 250 characters', labelText: 'Description'),
            controller: _descriptionController,
            validator: (String val) {
              if (val.length > 250) {
                return 'Length should be less than 250 characters';
              }
            },
          ),
          Container(
              padding: new EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () =>
                    _submit(_nameController.text, _descriptionController.text),
                child: new Text('Add Category'),
              ))
        ],
      ),
    );
  }

  void _submit(String name, String description) {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      if (editedCategory != null) {
        editedCategory.name = name;
        editedCategory.description = description;
        addVerseCategory(editedCategory);
      } else {
        VerseCategory categoryToAdd = VerseCategory(
            name: name, description: description, isDefault: false);
        addVerseCategory(categoryToAdd);
      }
    }
  }
}
