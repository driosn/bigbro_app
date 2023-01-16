import 'package:flutter/material.dart';

class CustomDialog {
  final BuildContext context;
  final Color iconColor;
  final Widget icon;
  final Widget content;
  final List<Widget> extraActions;
  final bool hideActions;
  final bool barrierDismissible;

  CustomDialog({
    required this.context,
    required this.iconColor,
    required this.icon,
    required this.content,
    this.hideActions = false,
    this.barrierDismissible = true,
    this.extraActions = const [],
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(barrierDismissible);
          },
          child: _CustomDialog(
            context: context,
            iconColor: iconColor,
            icon: icon,
            content: content,
            extraActions: extraActions,
            hideActions: hideActions,
          ),
        );
      },
    );
  }
}

class _CustomDialog extends StatelessWidget {
  final BuildContext context;
  final Color iconColor;
  final Widget icon;
  final Widget content;
  final List<Widget> extraActions;
  final bool hideActions;

  _CustomDialog({
    required this.context,
    required this.iconColor,
    required this.icon,
    required this.content,
    required this.extraActions,
    required this.hideActions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          34,
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 46,
                width: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    34,
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    content,
                    hideActions
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cerrar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              if (extraActions.isNotEmpty)
                                const SizedBox(
                                  width: 12,
                                ),
                              ...extraActions
                            ],
                          )
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
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
                    color: iconColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: icon,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
