import '../../../all_export.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<WishListProvider>(
        builder: (context, wishlistProvider, child) {
          if (wishlistProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          }

          return wishlistProvider.wishList != null
              ? wishlistProvider.wishList.length > 0
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await Provider.of<WishListProvider>(context,
                                listen: false)
                            .getWishList(context);
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight:
                                        !ResponsiveHelper.isDesktop(context) &&
                                                _height < 600
                                            ? _height
                                            : _height - 400,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1,
                                        vertical:
                                            Dimensions.PADDING_SIZE_DEFAULT),
                                    child: SizedBox(
                                      width: 1170,
                                      child: GridView.builder(
                                        gridDelegate: ResponsiveHelper
                                                .isDesktop(context)
                                            ? SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 250,
                                                mainAxisExtent: 300,
                                              )
                                            : SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                childAspectRatio: 4,
                                                crossAxisCount:
                                                    ResponsiveHelper.isTab(
                                                            context)
                                                        ? 2
                                                        : 1,
                                              ),
                                        itemCount:
                                            wishlistProvider.wishList.length,
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ResponsiveHelper.isDesktop(
                                                  context)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: ProductWidget(
                                                      product: wishlistProvider
                                                          .wishList[index]),
                                                )
                                              : ProductWidget(
                                                  product: wishlistProvider
                                                      .wishList[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (ResponsiveHelper.isDesktop(context))
                                FooterView(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : NoDataScreen()
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                );
        },
      ),
    );
  }
}
