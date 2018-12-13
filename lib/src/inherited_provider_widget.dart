import 'package:flutter/widgets.dart';
import 'package:provider_widget/provider_widget.dart';

class InheritedProviderWidget<T extends ProvidedComponent>
    extends InheritedWidget {
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
  static T of<T extends ProvidedComponent>(BuildContext context) {
    InheritedProviderWidget<T> provider = context.inheritFromWidgetOfExactType(
        TypeCreator.create<InheritedProviderWidget<T>>());
    return provider.provided;
  }

  @override
  bool updateShouldNotify(InheritedProviderWidget oldWidget) {
    print("Called updateShouldNotify");
    return oldWidget.provided != this.provided;
  }

  @override
  InheritedElement createElement() => InheritedElement(this);
}

class InheritedProviderElement extends InheritedElement {
  InheritedProviderWidget widget;

  InheritedProviderElement(this.widget) : super(widget);

  @override
  void unmount() {
    widget.provided.dispose();
    super.unmount();
  }
}
