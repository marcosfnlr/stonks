import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/blocs/panelexpansion/panel_expansion_bloc.dart';

class SecurityPanel extends StatelessWidget {
  const SecurityPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      iconColor: Theme.of(context).colorScheme.primary,
      child: BlocProvider(
        create: (context) => PanelExpansionBloc(),
        child: BlocBuilder<PanelExpansionBloc, bool>(
          builder: (context, state) {
            return ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                BlocProvider.of<PanelExpansionBloc>(context)
                    .add(ExpansionToggled());
              },
              children: [
                ExpansionPanel(
                  isExpanded: state,
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
                          title: Text('Report issue'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
