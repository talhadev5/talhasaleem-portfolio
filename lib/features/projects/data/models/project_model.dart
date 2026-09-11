import '../../domain/entities/project.dart';

/// Data-layer representation of a [Project]. Since project data is a
/// hardcoded local list (no remote/JSON source), this simply mirrors the
/// entity shape and gives the data layer a place to grow into if a real
/// CMS/API is introduced later.
class ProjectModel extends Project {
  const ProjectModel({
    required super.id,
    required super.name,
    required super.category,
    required super.tagline,
    required super.description,
    required super.features,
    required super.techStack,
    required super.storeLinks,
    super.hasNoPublicLink = false,
  });
}
