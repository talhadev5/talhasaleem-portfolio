import '../entities/project.dart';

abstract class ProjectRepository {
  List<Project> getAllProjects();
  Project? getProjectById(String id);
}
