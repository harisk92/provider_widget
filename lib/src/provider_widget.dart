import 'package:flutter/widgets.dart';
import 'package:provider_widget/src/provider_element.dart';
import 'package:provider_widget/src/utils.dart';

class ProviderWidget<T extends ProvidedElement> extends StatefulWidget {
  final T provided;
  final Widget child;

  ProviderWidget({
    Key key,
    @required this.child,
    @required this.provided,
  }) : super(key: key);

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();

  static T of<T extends ProvidedElement>(BuildContext context) {
    ProviderWidget<T> provider = context
        .ancestorWidgetOfExactType(TypeCreator.create<ProviderWidget<T>>());
    return provider.provided;
  }
}

class _ProviderWidgetState<T> extends State<ProviderWidget<ProvidedElement>> {
  @override
  void dispose() {
    widget.provided.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
