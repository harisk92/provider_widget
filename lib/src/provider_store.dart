import 'dart:collection';

import 'package:provider_widget/src/provider_element.dart';

class ProviderStore<T extends ProvidedElement> extends ProvidedElement {
  final HashMap<Type, T> providers = HashMap();

  ProviderStore(List<T> providedElements) {
    if (providedElements == null) {
      throw Exception("List of providers can't be null");
    }
    providedElements.forEach((provider) => inject(provider));
  }

  T get(Type type) => providers[type];

  @override
  void dispose() {
    providers.forEach((_, provider) => provider.dispose());
  }

  void inject(T provider) {
    providers.putIfAbsent(provider.runtimeType, () => provider);
  }

  void remove(Type type) {
    T provider = providers.remove(type);
    if (provider != null) {
      provider.dispose();
    }
  }
}
