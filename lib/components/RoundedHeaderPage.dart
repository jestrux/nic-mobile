import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';

class RoundedHeaderPage extends StatelessWidget {
  final Widget? child;
  final Widget? bottomNavigationBar;
  final String? title;
  final bool showLogo;

  const RoundedHeaderPage({
    Key? key,
    this.title,
    this.bottomNavigationBar,
    this.showLogo = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // backgroundColor: Colors.transparent,
      color: Constants.primaryColor,
      child: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.3,
                  scale: 10,
                  image: AssetImage(
                    "assets/img/patterns.png",
                  ),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showLogo)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          'assets/img/icon.png',
                          width: 40,
                        ),
                      ),
                    if (title != null)
                      Expanded(
                        child: Text(
                          title!.toUpperCase(),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                        ),
                      ),
                    if (ModalRoute.of(context)!.canPop)
                      const SizedBox(width: 56),
                  ],
                ),
                // automaticallyImplyLeading: showBackButton,
              ),
              body: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: colorScheme(context).surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: child ?? Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
