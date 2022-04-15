import 'package:bongdavui/core/resume.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'loading_view.dart';

abstract class GeneralScreen<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver{
  Resume resume =  Resume();
  bool _isPaused = false;
  LoadingView? loadingView;
  // todo check status screen
  void onResume() {}
  void onReady() {}
  void onPause() {}
  log(String data){
    if(kDebugMode){
      print('My Log ::::::::: $data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();}

  @override
  void initState() {
    initAll();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((_) => onReady());
  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    disposeAll();
    super.dispose();
  }
  // todo from https://pub.dev/packages/need_resume
  // todo https://github.com/nuruddinsyah/need_resume/blob/master/lib/need_resume.dart
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
       //log('GeneralScreen paused');
    }
    if (state == AppLifecycleState.resumed) {
      //log('GeneralScreen resumed');
      if (!_isPaused) {
        onResume();
      }
    }
  }
  void initAll(){
    loadingView = LoadingView();
  }
  void disposeAll(){
    dismissLoading();
  }
  void dismissLoading() {
    if (loadingView != null) {
      loadingView!.hide();
    }
  }
  void showLoading(bool show) {
    loadingView ??= LoadingView();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if(mounted){
        if (show) {
            loadingView!.show(context);
        } else {
          loadingView!.hide();
        }
      }
    });
  }
  // todo handle open screens
  addScreen(Widget screen, [String? source]) {
    _isPaused = true;
    onPause();
    log('${context.widget.toString()} onPause');
    log('${screen.toString()} onReady');
    // Navigator.push(context, MaterialPageRoute(builder: (context) => screen));// todo old code
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen))
        .then((value) {
      _isPaused = false;
      resume.data = value;
      resume.source = source; // todo resume data
      onResume();
      log('${context.widget.toString()} onResume');
      return value;
    });
  }
  replaceScreen(Widget screen,[String? source]) {
   // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (Route<dynamic> route) => false);// todo old cod
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (Route<dynamic> route) => false).then((value)  {
    _isPaused = false;
        resume.data = value;
        resume.source = source; // todo resume data
        onResume();
    return value;
    });
  }
  // todo addScreen with name

  backToScreen() {
    if(mounted){
      Navigator.of(context).pop();
    }
  }

}

