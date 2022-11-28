import 'package:flutter_structure/presentation/router/no_animation_route.dart';
import 'package:flutter_structure/utils/my_material.dart';

import '../screens/detail_note/detail_note.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments =
        settings.arguments as Map<String, dynamic>?;
    Widget? page;
    switch (settings.name) {
      case pageWelcome:
        page = const WelcomePage();
        break;
      case pageHome:
        page =  Home(
            arguments?[ARGUMENT_USER]
        );
        break;
      case pageSignIn:
        page = const SignIn();
        break;
      case pageSignUp:
        page = const SignUp();
        break;
      case pageDetailNote:
        page =  DetailNote(
          note: arguments?[ARGUMENT_NOTE],
        );
        break;
      case pageCalendar:
        page =  Calendar();
        break;
      default:
    }

    if (page != null) {
      if (arguments != null && (arguments[argumentIsNOAnimation] ?? false)) {
        return NoAnimationMaterialPageRoute(builder: (_) => page!);
      }

      return MaterialPageRoute(builder: (_) => page!);
    }

    return null;
  }
}
