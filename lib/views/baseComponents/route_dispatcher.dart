import 'package:app/views/pages/home_page.dart';
import 'package:flutter/material.dart';


import 'package:app/tools/app/app_broadcast.dart';

class RouteDispatcher {
  RouteDispatcher._();

  static Widget dispatch(){

    /*if(!SessionService.hasAnyLogin()){
      if(kIsWeb){
        final query = IrisNavigatorObserver.getPathQuery(IrisNavigatorObserver.currentUrl());
        bool contain = query.contains('register=');

        if(contain){
          if(AppCache.canCallMethodAgain('request_is_verify_email')){
            final code = query.substring(9);
            LoginService.requestCanRegisterWithEmail(code: code);
          }

          return const WaitToLoad();
        }
      }

      return HomePage();
    }*/

    return HomePage(key: AppBroadcast.homePageKey);
  }
}
