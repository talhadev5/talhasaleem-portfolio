part of 'projects_bloc.dart';

class ProjectsState extends Equatable {
  const ProjectsState({
    this.allProjects = const [],
    this.filteredProjects = const [],
    this.selectedCategory,
  });

  final List<Project> allProjects;
  final List<Project> filteredProjects;
  final ProjectCategory? selectedCategory;

  ProjectsState copyWith({
    List<Project>? allProjects,
    List<Project>? filteredProjects,
    ProjectCategory? selectedCategory,
    bool clearCategory = false,
  }) {
    return ProjectsState(
      allProjects: allProjects ?? this.allProjects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
    );
  }

  @override
  List<Object?> get props => [allProjects, filteredProjects, selectedCategory];
}
