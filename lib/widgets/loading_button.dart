import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {

  final bool loading;
  final bool disableOnLoad;
  final String text;
  final Function() onPressed;

  LoadingButton({this.loading, this.onPressed, this.disableOnLoad = true, this.text='Button'});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text),
      onPressed: (){

        if(!loading || (loading && !disableOnLoad)){
          onPressed();
        }

      },
    );
  }
}