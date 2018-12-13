/*
Interface that needs to be implemented to be able to provide component using @ProviderWidget

```dart
class AppState implements ProvidedElement{
}
```
 */
abstract class ProvidedComponent {
  /*
   Called by @InheritedWidget when it's getting destroyed.
   */
  void dispose();
}
