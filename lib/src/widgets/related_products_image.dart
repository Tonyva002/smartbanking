import 'dart:io';

import 'package:flutter/material.dart';

class RelatedProductsImage extends StatelessWidget {
  final String? picture;

  const RelatedProductsImage({super.key, this.picture});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _boxDecorationImage(),
        width: 80,
        height: 50,
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: getImage(picture),

          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecorationImage() => BoxDecoration(
    color: Colors.black12,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(4),
        blurRadius: 10,
        offset: Offset(5, 5),
      ),
    ],
  );

  Widget getImage(String? picture){

    if(picture == null) {
      return Image(
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,
    );
    }

    if(picture.startsWith('http')) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(picture),
        fit: BoxFit.cover,
      );
    }

     return Image.file(
      File(picture),
      fit: BoxFit.cover,
        );

  }


}


