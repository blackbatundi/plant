import 'package:flutter/material.dart';

class PopupModel extends StatefulWidget {
  final Widget? child;
  const PopupModel({super.key, this.child});

  @override
  State<PopupModel> createState() => _PopupModelState();
}

class _PopupModelState extends State<PopupModel> {
  bool hasFinished = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.87),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 260,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).disabledColor,
            ),
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              const BoxShadow(
                color: Colors.grey,
                offset: Offset(-3, 7),
                blurRadius: 7,
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(.3),
                offset: const Offset(3, -7),
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            children: [
              widget.child ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
