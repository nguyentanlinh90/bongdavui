class Utils {
  static bool validEmail(email) {
    final RegExp _regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return _regex.hasMatch(email);
  }

  static bool validPassword(String value) {
    /*
    Minimum 1 Upper case
    Minimum 1 lowercase
    Minimum 1 Numeric Number
    Minimum 1 Special Character
    Common Allow Character ( ! @ # $ & * ~ )
    */
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
