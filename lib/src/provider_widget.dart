import 'package:flutter/widgets.dart';
import 'package:provider_widget/src/provider_element.dart';
import 'package:provider_widget/src/utils.dart';

/*
  Provides component that implements *ProvidedElement downstream
 */
class ProviderWidget<T extends ProvidedComponent> extends StatefulWidget {
  /*
    Component that implements ProvidedComponent
  */
  final T provided;
  /*
    Child which will be rendered
  */
  final Widget child;

  ProviderWidget({
    Key key,
    @required this.child,
    @required this.provided,
  }) : super(key: key);

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();

  /*
    Call this method when you want to access provided components downstream.
  */
  static T of<T extends ProvidedComponent>(BuildContext context) {
    ProviderWidget<T> provider = context
        .ancestorWidgetOfExactType(TypeCreator.create<ProviderWidget<T>>());
    return provider.provided;
  }
}

class _ProviderWidgetState<T> extends State<ProviderWidget<ProvidedComponent>> {
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
