
import 'package:eat_more_app/component/jumping_dot_progress_indicator.dart';
import 'package:flutter/material.dart';

class ProgressComponent extends StatelessWidget {
  const ProgressComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JumpingDotsProgressIndicator();
  }
}
