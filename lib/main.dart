import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/utils/my_material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SettingsItem settings = await SettingsRepository().getSettings();
  runApp(MyApp(appRouter: AppRouter(), settings: settings,));
}

class MyApp extends StatelessWidget {

  final AppRouter appRouter;
  final SettingsItem settings;

  const MyApp({Key? key, required this.appRouter, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(SettingsState(settings))
        ),
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(AppState())
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {

          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
            locale: Locale(state.settings.langCode),
            supportedLocales: supportedLanguages.toList().map((lang) => Locale(lang)),
            debugShowCheckedModeBanner: false,
            theme: (state.settings.isDarkMode)? darkTheme: lightTheme,
            onGenerateRoute: appRouter.onGenerateRoute,
            home: BlocListener<AppCubit, AppState>(
              listener: appListener,
              child: BlocBuilder<AppCubit, AppState>(
                builder: (appContext, appState) {

                  if (appState.loadingState == CustomState.loading) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return const WelcomePage();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  appListener(BuildContext context, AppState state) {

  }

  openPage(BuildContext context, String page, Map<String, dynamic> arguments) {

  }

}
