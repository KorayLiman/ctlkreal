import 'package:ctlk2/locator.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/repository/userrepository.dart';
import 'package:ctlk2/services/authbase.dart';
import 'package:flutter/cupertino.dart';

enum ViewState { idle, busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _viewState = ViewState.idle;
  UserRepository _userRepository = locator<UserRepository>();
  CuTalkUser? _user;
  String? emailerrormessage;
  String? passworderrormessage;

  ViewState get viewstate => _viewState;
  CuTalkUser? get user => _user;
  set viewstate(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<CuTalkUser?> createUserWithEmailandPassword(
      String email, String pw,) async {
    try {
      viewstate = ViewState.busy;
      _user = await _userRepository.createUserWithEmailandPassword(email, pw);
      return _user;
    } finally {
      viewstate = ViewState.idle;
    }
  }

  @override
  Future<CuTalkUser?> currentUser() async {
    try {
      viewstate = ViewState.busy;
      _user = await _userRepository.currentUser();
      return _user;
    } catch (error) {
      return null;
    } finally {
      viewstate = ViewState.idle;
    }
  }

  @override
  Future<CuTalkUser?> signinwithEmailAndPassword(
      String email, String password) async {
    try {
      viewstate = ViewState.busy;
      _user = await _userRepository.signinwithEmailAndPassword(email, password);
      return _user;
    } finally {
      viewstate = ViewState.idle;
    }
  }

  @override
  Future<CuTalkUser?> signinwithGoogle() async {
    try {
      viewstate = ViewState.busy;
      _user = await _userRepository.signinwithGoogle();
      return _user;
    } catch (error) {
      return null;
    } finally {
      viewstate = ViewState.idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      viewstate = ViewState.busy;
      bool result = await _userRepository.signOut();
      _user = null;
      return result;
    } catch (error) {
      return false;
    } finally {
      viewstate = ViewState.idle;
    }
  }
}
