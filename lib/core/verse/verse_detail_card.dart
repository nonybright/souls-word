import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';

enum VerseDetailAction { share, shareAsImage, favToggle, edit }

class VerseDetailCard extends StatelessWidget {
  final Verse verse;
  final Function onVerseTapped;
  final Function(Verse) onShareClicked;
  final Function(Verse) onShareImageClicked;
  final Function(Verse) onFavToggleClicked;

  VerseDetailCard(
    this.verse, {
    this.onVerseTapped,
    this.onShareClicked,
    this.onShareImageClicked,
    this.onFavToggleClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: new Row(
        children: <Widget>[
          Expanded(
            child: Text(verse.content),
          ),
          new PopupMenuButton<VerseDetailAction>(
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<VerseDetailAction>>[
                   PopupMenuItem<VerseDetailAction>(
                    value: VerseDetailAction.share,
                    child: Text('Share'),
                    
                  ),
                  PopupMenuItem<VerseDetailAction>(
                    value: VerseDetailAction.shareAsImage,
                    child: Text('Share As Image'),
                  ),
                  PopupMenuItem<VerseDetailAction>(
                    value: VerseDetailAction.favToggle,
                    child: verse.isFaved? Text('Remove Favorite'): Text('Make Favorite'),
                  ),
                  PopupMenuItem<VerseDetailAction>(
                    value: VerseDetailAction.share,
                    child: Text('Edit'),
                  ),
                ],
            onSelected: (VerseDetailAction action) {
              switch (action) {
                case VerseDetailAction.share:
                  onShareClicked(verse);
                  break;
                case VerseDetailAction.shareAsImage:
                  onShareImageClicked(
                      verse); //TODO: May need to remove this if nothing will bw dispatched
                  break;
                case VerseDetailAction.favToggle:
                  onFavToggleClicked(verse);
                  break;
                case VerseDetailAction.edit:
                  //edit the image
                  break;
              }
            },
          ),
        ],
      ),
      subtitle: (verse.isFaved)
          ? IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () => onFavToggleClicked(verse),
            )
          : IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => onFavToggleClicked(verse)),
      onTap: () {
        onVerseTapped();
      },
    );
  }
}
