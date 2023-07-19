import '../all_export.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  // for registration section
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _registrationErrorMessage = '';
  String get registrationErrorMessage => _registrationErrorMessage;

  void updateRegistrationErrorMessage(String message) {
    _registrationErrorMessage = message;
    notifyListeners();
  }

  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoading = true;
    _registrationErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registration(signUpModel);
    ResponseModel responseModel;
    if (apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String token = map["token"];
      authRepo.saveUserToken(token);
      await authRepo.updateToken();
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error!;
        errorMessage = errorResponse.errors[0].message;
      }
      print(errorMessage);
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  // ... (other functions updated in a similar manner)

  // for Remember Me Section
  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    notifyListeners();
  }

  void clearRememberMe() {
    _isActiveRememberMe = false;
    notifyListeners();
  }

  // ... (other functions updated in a similar manner)

  String? getUserNumber() {
    return authRepo.getUserNumber();
  }

  String? getUserPassword() {
    return authRepo.getUserPassword();
  }

  // ... (other functions updated in a similar manner)

  String getUserToken() {
    return authRepo.getUserToken();
  }
}
