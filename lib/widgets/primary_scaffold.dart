import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/primary_text.dart';


import '../resource/app_colors.dart';
import '../resource/app_dimension.dart';
import '../resource/app_font.dart';


class PrimaryScaffold extends StatelessWidget {
  final Widget? body;
  final Color backgroundColor;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBrBottom;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final String appBarTitle;
  final String appBarSubTitle;
  final List<Widget>? action;
  final bool isLeadingIconDisable;
  final Widget? bottomNavigationBar;
  const PrimaryScaffold({super.key,this.appBarTitle = '',this.appBarSubTitle = '',this.body,this.backgroundColor = AppColors.backgroundColor,this.floatingActionButton,this.floatingActionButtonLocation,this.appBrBottom,this.action,this.bottomNavigationBar,this.isLeadingIconDisable = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          backgroundColor: backgroundColor,
          appBar:appBarTitle.isEmpty ? null : AppBar(
            leading:isLeadingIconDisable ?
                null
                : IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_sharp,size: 30,)),
            toolbarHeight: 80.0,
            foregroundColor: AppColors.primaryColor,
            bottom: appBrBottom,
            backgroundColor: AppColors.backgroundColor,
            title: Padding(
              padding: const EdgeInsets.only(top: 28),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: appBarTitle,
                      style: TextStyle(
                        fontSize: 24, // Larger font size for the first sentence
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor, // Black color for the first sentence
                      ),
                    ),
                    TextSpan(
                      text: "\n$appBarSubTitle",
                      style: TextStyle(
                        fontSize: 20, // Smaller font size for the second sentence
                        color: AppColors.textColor, // Grey color for the second sentence
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: action ?? [],
          ),
          body: body ?? const SizedBox.shrink(),
          bottomNavigationBar: bottomNavigationBar,
        )
    );
  }
}
