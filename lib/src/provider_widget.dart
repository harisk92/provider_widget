import 'package:flutter/widgets.dart';
import 'package:provider_widget/src/provider.dart';
import 'package:provider_widget/src/utils.dart';

/*
  Provides component that implements *ProvidedElement downstream
 */

class ProviderWidget<T> extends StatefulWidget {
  /*
    Component that implements ProvidedComponent
  */
  final T provided;
  /*
    Child which will be rendered
  */
  final Widget child;

  final Disposable<T> disposable;

  ProviderWidget({
    Key key,
    @required this.child,
    @required this.provided,
    @required this.disposable,
  }) : super(key: key);

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();

  /*
    Call this method when you want to access provided components downstream.
  */
  static T of<T>(BuildContext context) {
    Type type = TypeCreator.of<InheritedProviderWidget<T>>();
    InheritedProviderWidget<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type).widget;
    return provider.provided;
  }
}

class _ProviderWidgetState<T> extends State<ProviderWidget<T>> {
  @override
  void dispose() {
    widget.disposable(widget.provided);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProviderWidget<T>(
      child: widget.child,
      provided: widget.provided,
    );
  }
}

class InheritedProviderWidget<T> extends InheritedWidget {
  /*
    Component that implements ProvidedComponent
  */
  final T provided;
  /*
    Child which will be rendered
  */
  final Widget child;

  InheritedProviderWidget({
    Key key,
    @required this.child,
    @required this.provided,
  }) : super(key: key, child: child);

  /*
    Call this method when you want to access provided components downstream.
  */
  static T of<T>(BuildContext context) {
    InheritedProviderWidget<T> provider = context.inheritFromWidgetOfExactType(
        TypeCreator.of<InheritedProviderWidget<T>>());
    return provider.provided;
  }

  @override
  bool updateShouldNotify(InheritedProviderWidget oldWidget) {
    return oldWidget.provided != this.provided;
  }
}
