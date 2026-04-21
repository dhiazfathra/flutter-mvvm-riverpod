# Style Guide

Please follow [Flutter's official style guide](https://github.com/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md). This document outlines additional coding conventions and best practices for this Flutter project, in addition to it.

## Widget Construction

### Prefer Classes Over Functions for Reusable Widgets

The Flutter team has officially stated that classes are preferable over functions for building reusable widget trees. See: https://www.youtube.com/watch?v=IOyq-eTRhvo

**Key Differences:**

When using functions to split your widget tree:

```dart
Widget functionWidget({ Widget child}) {
  return Container(child: child);
}

// Usage:
functionWidget(child: functionWidget());
```

The generated widget tree looks like:

```
Container
  Container
```

But with classes:

```dart
class ClassWidget extends StatelessWidget {
  final Widget child;

  const ClassWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(child: child);
  }
}

// Usage:
ClassWidget(child: ClassWidget());
```

The widget tree is:

```
ClassWidget
  Container
    ClassWidget
      Container
```

**Why Classes Matter:**

1. **Performance optimization** - Classes allow const constructors and more granular rebuilds
2. **Correct resource disposal** - Classes ensure switching between layouts correctly disposes of resources
3. **Hot-reload reliability** - Functions can break hot-reload for `showDialog` and similar widgets
4. **Widget inspector integration** - Classes appear in the devtool widget tree, aiding debugging
5. **Better error messages** - Framework gives helpful widget names in exceptions
6. **Key support** - Classes can define keys
7. **Context API** - Classes can use the context API properly

**Rule:**

- Use `StatelessWidget` or `ConsumerWidget` for public widgets intended to be reused
- Private functions used only once are acceptable, but be aware of the trade-offs
- Avoid splitting widget trees into functions for reusable components

**Resources:**

- https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html
- https://pub.dev/packages/functional_widget (code generation solution if preferring functions)
- https://stackoverflow.com/a/53234826
