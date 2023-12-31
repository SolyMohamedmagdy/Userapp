import '../../../all_export.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late GlobalKey<ScaffoldMessengerState> _globalKey;
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey<ScaffoldMessengerState>();
    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        print('-----------------${isNotConnected ? 'Not' : 'Yes'}');
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected
                ? getTranslated('no_connection', context) ?? ''
                : getTranslated('connected', context) ?? '',
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Provider.of<SplashProvider>(context, listen: false).initSharedData();
    Provider.of<CartProvider>(context, listen: false).getCartData();
    _route();
  }

  void _route() {
    Provider.of<SplashProvider>(context, listen: false)
        .initConfig(context)
        .then((bool isSuccess) {
      if (isSuccess) {
        if (Provider.of<SplashProvider>(context, listen: false)
            .configModel
            .maintenanceMode) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteHelper.getMaintenanceRoute(), (route) => false);
        } else {
          Timer(Duration(seconds: 1), () async {
            double _minimumVersion = 0.0;
            if (Platform.isAndroid) {
              _minimumVersion =
                  Provider.of<SplashProvider>(context, listen: false)
                          .configModel
                          .playStoreConfig
                          .minVersion ??
                      6.0;
            } else if (Platform.isIOS) {
              _minimumVersion =
                  Provider.of<SplashProvider>(context, listen: false)
                          .configModel
                          .appStoreConfig
                          .minVersion ??
                      6.0;
            }
            if (AppConstants.APP_VERSION < _minimumVersion &&
                !ResponsiveHelper.isWeb()) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteHelper.getUpdateRoute(), (route) => false);
            } else {
              if (Provider.of<AuthProvider>(context, listen: false)
                  .isLoggedIn()) {
                Provider.of<AuthProvider>(context, listen: false).updateToken();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteHelper.menu, (route) => false,
                    arguments: MenuScreen());
              } else {
                print(
                    '===intro=>${Provider.of<SplashProvider>(context, listen: false).showIntro()}');
                if (Provider.of<SplashProvider>(context, listen: false)
                    .showIntro()) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteHelper.onBoarding, (route) => false,
                      arguments: OnBoardingScreen());
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteHelper.menu, (route) => false,
                      arguments: MenuScreen());
                }
              }
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            Images.app_logo,
            width: 170,
            height: 170,
          ),
          SizedBox(height: 30),
          Text(
            AppConstants.APP_NAME,
            textAlign: TextAlign.center,
            style: poppinsMedium.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 50,
            ),
          ),
        ],
      ),
    );
  }
}
