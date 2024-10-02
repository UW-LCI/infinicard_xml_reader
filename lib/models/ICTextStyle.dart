import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import 'package:infinicard_v1/models/ICColor.dart';
class ICTextStyle{

  ICColor? textColor;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;

  ICTextStyle();

  void color(ICColor? color){
    textColor=color;
  }

  void setFontSize(double? fontSizeArg){
    fontSize = fontSizeArg;
  }

  void setFontWeight(FontWeight? fontWeightArg){
    fontWeight = fontWeightArg;
  }

  void setFontFamily(String? fontFamilyArg){
    fontFamily = fontFamilyArg != "" ? fontFamilyArg : null;
  }

  TextStyle? toFlutter({BuildContext? context}){
    final colorVal = textColor==null && context != null ? Theme.of(context).textTheme.bodyLarge?.color : textColor?.toFlutter();
    final fontFamilyVal = fontFamily == null && context != null ? Theme.of(context).textTheme.bodyLarge?.fontFamily : fontFamily; 
    return TextStyle(color: colorVal, fontSize: fontSize, fontWeight: fontWeight, fontFamily: fontFamilyVal);
  }

  XmlElement toXml({bool verbose=false, String name = "textStyle"}){
    final element = XmlElement(XmlName(name), [], [XmlText("")]);

    final colorElement = textColor != null ? XmlElement(XmlName("color"), [], [XmlText(textColor!.toColorString())]) : XmlElement(XmlName("color"),[],[XmlText("")]);
    final fontSizeElement = fontSize!=null ? XmlElement(XmlName("fontSize"), [], [XmlText(fontSize.toString())]) : XmlElement(XmlName("fontSize"),[],[XmlText("")]);
    final fontWeightElement = fontWeight!=null ? XmlElement(XmlName("fontWeight"), [], [XmlText(fontWeight.toString())]) : XmlElement(XmlName("fontWeight"),[],[XmlText("")]);
    final fontFamilyElement = fontFamily!=null ? XmlElement(XmlName("fontFamily"), [], [XmlText(fontFamily!)]) : XmlElement(XmlName("fontFamily"),[],[XmlText("")]);

    if(verbose==false){
      if(textColor!=null){element.children.add(colorElement);}
      if(fontSize!=null){element.children.add(fontSizeElement);}
      if(fontWeight!=null){element.children.add(fontWeightElement);}
      if(fontFamily!=null){element.children.add(fontFamilyElement);}
    } else {
      element.children.add(colorElement);
      element.children.add(fontSizeElement);
      element.children.add(fontWeightElement);
      element.children.add(fontFamilyElement);
    }
    return element;
  }
}