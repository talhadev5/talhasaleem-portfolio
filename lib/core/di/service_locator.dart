import '../../features/projects/data/datasources/project_local_datasource.dart';
import '../../features/projects/data/repositories/project_repository_impl.dart';
import '../../features/projects/domain/repositories/project_repository.dart';
import '../../features/projects/domain/usecases/get_projects.dart';

/// Minimal manual dependency wiring — the app is small enough that a
/// full service-locator package would be overkill. Everything here is
/// a plain singleton constructed once at app start.
class ServiceLocator {
  ServiceLocator._();

  static final ProjectRepository projectRepository = ProjectRepositoryImpl(const ProjectLocalDataSource());
  static final GetProjects getProjects = GetProjects(projectRepository);
  static final GetProjectById getProjectById = GetProjectById(projectRepository);
}
