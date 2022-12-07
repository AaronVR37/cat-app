import 'dart:io';
import 'package:flutter/material.dart';

class Image_s extends StatefulWidget {
  String? path;
  Image_s({super.key, this.path});

  @override
  State<Image_s> createState() => _ImageProviderState();
}

class _ImageProviderState extends State<Image_s> {
  @override
  Widget build(BuildContext context) {
    if (widget.path == ''|| widget.path == null){
      return Placeholder();
    }
    else{
      return Image.file(File(widget.path!));
    }
  }
}