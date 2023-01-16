import 'package:flutter/material.dart';

class BigBroScaffold extends StatelessWidget {
  const BigBroScaffold({
    this.title,
    this.subtitle,
    this.centerWidget,
    this.subtitleStyle,
    required this.body,
    this.enableInfoOverlay = false,
    this.removeTrailingIcon = false,
    Key? key,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget body;
  final Widget? centerWidget;
  final bool enableInfoOverlay;
  final bool removeTrailingIcon;

  @override
  Widget build(BuildContext context) {
    if (enableInfoOverlay) {
      return Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            SizedBox(
                              height: kToolbarHeight / 1.5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: removeTrailingIcon ? 0 : 8,
                                ),
                                removeTrailingIcon
                                    ? const SizedBox()
                                    : IconButton(
                                        icon: Icon(Icons.arrow_back_ios),
                                        color: Theme.of(context).accentColor,
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    title ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46,
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 92,
                      width: 92,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'i',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: body,
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  SizedBox(
                    height: kToolbarHeight / 1.5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: removeTrailingIcon ? 56 : 8,
                      ),
                      removeTrailingIcon
                          ? const SizedBox()
                          : IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              color: Theme.of(context).accentColor,
                              onPressed: () => Navigator.pop(context),
                            ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      centerWidget != null
                          ? Container()
                          : Container(
                              margin: const EdgeInsets.only(
                                left: 8,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                padding: const EdgeInsets.all(10),
                                color: Colors.transparent,
                                onPressed: () {},
                              ),
                            ),
                      centerWidget != null
                          ? Expanded(
                              child: Column(
                                crossAxisAlignment: centerWidget != null
                                    ? CrossAxisAlignment.center
                                    : CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Center(child: centerWidget)
                                ],
                              ),
                            )
                          : Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 16,
                                ),
                                child: Text(
                                  subtitle ?? '',
                                  style: subtitleStyle ??
                                      TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: body,
          )
        ],
      ),
    );
  }
}
