import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  late BuildContext _context;
  setContext(BuildContext context) {
    _context = context;
  }

  BuildContext get getContext => _context;
}
