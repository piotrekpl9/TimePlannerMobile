import 'package:get_it/get_it.dart';
import 'package:time_planner_mobile/application/application_dependency_injection.dart';
import 'package:time_planner_mobile/infrastructure/infrastructure_dependency_injection.dart';
import 'package:time_planner_mobile/presentation/config/presentation_dependency_injection.dart';

final diContainer = GetIt.instance;
void setupDependencyInjectionContainer() {
  setupInfrastructureDependencyInjection(diContainer);
  setupApplicationDependencyInjection(diContainer);
  setupPresentationDependencyInjection(diContainer);
}
