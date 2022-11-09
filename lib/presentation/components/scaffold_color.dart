import '../../utils/my_material.dart';

class ScaffoldColor extends StatelessWidget {
  final Widget? child, bottomNavigationBar;

  const ScaffoldColor({Key? key, required this.child, this.bottomNavigationBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: SafeArea(child: child!),
      bottomNavigationBar: bottomNavigationBar ,
    );
  }
}
