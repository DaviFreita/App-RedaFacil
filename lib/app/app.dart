import 'package:flutter/material.dart';

import 'router.dart';

class RedaFacilApp extends StatelessWidget {
  const RedaFacilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'RedaFácil',

      routerConfig: AppRouter.router,
    );
  }
}
