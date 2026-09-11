import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/project.dart';
import '../../domain/usecases/get_projects.dart';

part 'projects_event.dart';
part 'projects_state.dart';

/// Drives the filterable Projects grid: loads all projects once, then
/// re-filters in memory as the user taps a category tab.
class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc(this._getProjects) : super(const ProjectsState()) {
    on<ProjectsRequested>(_onRequested);
    on<ProjectsCategoryChanged>(_onCategoryChanged);
  }

  final GetProjects _getProjects;

  void _onRequested(ProjectsRequested event, Emitter<ProjectsState> emit) {
    final all = _getProjects();
    emit(state.copyWith(allProjects: all, filteredProjects: all));
  }

  void _onCategoryChanged(ProjectsCategoryChanged event, Emitter<ProjectsState> emit) {
    final filtered = _getProjects(category: event.category);
    emit(state.copyWith(
      filteredProjects: filtered,
      selectedCategory: event.category,
      clearCategory: event.category == null,
    ));
  }
}
