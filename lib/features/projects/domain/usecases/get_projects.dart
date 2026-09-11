import '../entities/project.dart';
import '../repositories/project_repository.dart';

/// Returns all projects, optionally filtered by category.
class GetProjects {
  const GetProjects(this._repository);

  final ProjectRepository _repository;

  List<Project> call({ProjectCategory? category}) {
    final all = _repository.getAllProjects();
    if (category == null) return all;
    return all.where((p) => p.category == category).toList();
  }
}

/// Returns a single project by id, for the detail page.
class GetProjectById {
  const GetProjectById(this._repository);

  final ProjectRepository _repository;

  Project? call(String id) => _repository.getProjectById(id);
}
