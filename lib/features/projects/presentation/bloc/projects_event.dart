part of 'projects_bloc.dart';

sealed class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object?> get props => [];
}

class ProjectsRequested extends ProjectsEvent {
  const ProjectsRequested();
}

class ProjectsCategoryChanged extends ProjectsEvent {
  const ProjectsCategoryChanged(this.category);

  final ProjectCategory? category;

  @override
  List<Object?> get props => [category];
}
