import 'dart:collection';

import 'package:provider_widget/src/provider_element.dart';

/*
ProviderStore is used to hold multiple components that implement @ProvidedElements and provide them using @ProviderWidget
```dart
class AppState implements ProvidedElement{
}

class Api implements ProvidedElement{
}

ProviderStore([
AppState(),
Api(),
```
])
 */
class ProviderStore extends ProvidedComponent {
  final HashMap<Type, ProvidedComponent> providers = HashMap();

  ProviderStore(List<ProvidedComponent> providedElements) {
    if (providedElements == null) {
      throw Exception("List of providers can't be null");
    }
    for (ProvidedComponent provider in providedElements) {
      inject(provider);
    }
  }

  ProvidedComponent get(Type type) => providers[type];

  @override
  void dispose() {
    providers.forEach((_, provider) => provider.dispose());
  }

  void inject(ProvidedComponent provider) {
    print("Injecting provider");
    providers.putIfAbsent(provider.runtimeType, () => provider);
  }

  void remove(Type type) {
    ProvidedComponent provider = providers.remove(type);
    if (provider != null) {
      provider.dispose();
    }
  }
}
