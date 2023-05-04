import 'package:flutter/material.dart';


class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget?  bottomNavigationBar;
  const DefaultLayout({
  required this.child,
    this.title,
    this.backgroundColor,
    this.bottomNavigationBar,
  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
    appBar: renderAppbar(),
    body: child,
    bottomNavigationBar: bottomNavigationBar,);
  }
  renderAppbar(){
    if (title == null){
      return null;
    }else{
      return AppBar(backgroundColor: Colors.white,
      elevation: 0,
      title: Text(title!, style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600
      ),),
        foregroundColor: Colors.black,
      );
    }
  }
}

