import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import 'package:infinicard_v1/models/ICObject.dart';

class ICImage extends ICObject{
  String path;
  double? width;
  double? height;
  String semanticLabel = "";
  BoxShape shape = BoxShape.rectangle;
  BorderRadiusGeometry? border;
  String? shapeDescription;

  ICImage(this.path);

  void setSize({double? widthArg, double? heightArg}){
    height = heightArg;
    width = widthArg;
  }

  void setAltText(String text) {
    semanticLabel = text;
  }

  void setShape(String? imgShape){
    if(imgShape!=null){
      shapeDescription = imgShape;
      switch(imgShape.toLowerCase().replaceAll(' ', '')){
        case "circle":
          shape = BoxShape.circle;
          border = null;
          break;
        case "rectangle":
          shape = BoxShape.rectangle;
          border = null;
          break;
        case "roundedrectangle.10" || "roundedrectangle":
          shape = BoxShape.rectangle;
          border = const BorderRadius.all(Radius.circular(10));
          break;
        case "roundedrectangle.20":
          shape = BoxShape.rectangle;
          border = const BorderRadius.all(Radius.circular(20));
          break;
        case "roundedrectangle.30":
          shape = BoxShape.rectangle;
          border = const BorderRadius.all(Radius.circular(30));
          break;
        case "roundedrectangle.40":
          shape = BoxShape.rectangle;
          border = const BorderRadius.all(Radius.circular(40));
          break;
        case "roundedrectangle.50":
          shape = BoxShape.rectangle;
          border = const BorderRadius.all(Radius.circular(50));
          break;
      }
    }
  }


  @override
  Widget toFlutter(BuildContext context) {
    return  Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/$path"),
          fit: BoxFit.cover,
        ),
        shape: shape,
        borderRadius: border,

      ),
    );
  }

  @override
  XmlElement toXml({bool verbose=false}){
    final imgElement = XmlElement(XmlName("image"));
    final pathElement = XmlElement(XmlName("path"), [], [XmlText(path)]);
    imgElement.children.add(pathElement);

    final propertiesElement = XmlElement(XmlName("properties"));
    final sizeElement = XmlElement(XmlName("size"));
    final shapeElement = shapeDescription != null ? XmlElement(XmlName("shape"),[],[XmlText(shapeDescription as String)]) : XmlElement(XmlName("shape"),[],[XmlText("")]);
    final heightElement = (height!= null) ? XmlElement(XmlName("height"), [], [XmlText(height.toString())]) : XmlElement(XmlName("height"), [], [XmlText("")]);
    final widthElement = (width!= null) ? XmlElement(XmlName("width"), [], [XmlText(width.toString())]) : XmlElement(XmlName("width"), [], [XmlText("")]);
    final labelElement = (semanticLabel != "") ? XmlElement(XmlName("altText"), [], [XmlText(semanticLabel)]) : XmlElement(XmlName("altText"), [], [XmlText("")]);
    
    if(verbose==false){
      if(height != null){sizeElement.children.add(heightElement);}
      if(width != null){sizeElement.children.add(widthElement);}
      if(sizeElement.children.isNotEmpty){propertiesElement.children.add(sizeElement);}
      if(shapeDescription != null){propertiesElement.children.add(shapeElement);}
      if(semanticLabel != ""){propertiesElement.children.add(labelElement);}
      if(propertiesElement.children.isNotEmpty){imgElement.children.add(propertiesElement);}
    } else {
      sizeElement.children.add(heightElement);
      sizeElement.children.add(widthElement);
      propertiesElement.children.add(sizeElement);
      propertiesElement.children.add(shapeElement);
      propertiesElement.children.add(labelElement);
      imgElement.children.add(propertiesElement);
    }

    return imgElement;
  }
}
