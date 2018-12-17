import 'dart:collection';

import 'package:provider_widget/src/provider.dart';

/*
ProviderStore is used to hold multiple components that implement @ProvidedElements and provide them using @ProviderWidget
```dart
class AppState implements ProvidedElement{
}

class Api implements ProvidedElement{
}

ProviderStore([
Provider<AppState>(
            provider: AppState(),
            disposable: (provider) => {},
          ),
Provider<Api>(
            provider: Api(),
            disposable: (provider) => {},
          ),
```
])
 */
class ProviderStore {
  final HashMap<Type, Provider> providers = HashMap();

  ProviderStore(List<Provider> providers) {
    if (providers == null) {
      throw Exception("List of providers can't be null");
    }
    for (dynamic provider in providers) {
      inject(provider);
    }
  }

  T get<T>() => providers[T].provider;

  void dispose() {
    providers.forEach((_, provider) => provider.dispose());
    providers.clear();
  }

  void inject(Provider provider) {
    providers.putIfAbsent(provider.type, () => provider);
  }

  void remove<T>() {
    Provider provider = providers.remove(T);
    if (provider != null) {
      provider.dispose();
    }
  }
}
