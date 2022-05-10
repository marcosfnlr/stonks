import 'package:flutter/material.dart';

class SecurityPanel extends StatefulWidget {
  const SecurityPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<SecurityPanel> createState() => _SecurityPanelState();
}

class _SecurityPanelState extends State<SecurityPanel> {
  bool _securityExpanded = true;
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      iconColor: Theme.of(context).colorScheme.primary,
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _securityExpanded = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                leading: const Icon(
                  Icons.security,
                ),
                title: Text(
                  'Security',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
            body: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  const ListTile(
                    leading: Icon(Icons.password),
                    title: Text('Change password'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const ListTile(
                    leading: Icon(Icons.chat),
                    title: Text('Report a problem'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ).toList(),
            ),
            isExpanded: _securityExpanded,
          ),
        ],
      ),
    );
  }
}
