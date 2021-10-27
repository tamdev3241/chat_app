import 'package:flutter/material.dart';

class ListGroupPage extends StatefulWidget {
  const ListGroupPage({Key? key}) : super(key: key);

  @override
  _ListGroupPageState createState() => _ListGroupPageState();
}

class _ListGroupPageState extends State<ListGroupPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Flexible(
      child: const Center(
        child: Text('Your are not into groups'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
