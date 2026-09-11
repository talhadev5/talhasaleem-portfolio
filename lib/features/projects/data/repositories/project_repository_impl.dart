import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/project_local_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  const ProjectRepositoryImpl(this._dataSource);

  final ProjectLocalDataSource _dataSource;

  @override
  List<Project> getAllProjects() => _dataSource.getProjects();

  @override
  Project? getProjectById(String id) {
    for (final project in _dataSource.getProjects()) {
      if (project.id == id) return project;
    }
    return null;
  }
}
