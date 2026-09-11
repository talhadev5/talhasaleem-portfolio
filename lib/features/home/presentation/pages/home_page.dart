import 'package:flutter/material.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../widgets/about_section.dart';
import '../widgets/certifications_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_preview_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/tools_section.dart';

/// Home route: a single long scroll page assembling Hero → About →
/// Featured Work → Experience → Certifications & Leadership → Education
/// → Core Skills → Tools & Technologies → Contact → Footer. Nav links
/// scroll to the matching anchor via [SectionScrollRegistry].
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _projectsKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SectionScrollRegistry.register('projects', _projectsKey);
    SectionScrollRegistry.register('about', _aboutKey);
    SectionScrollRegistry.register('experience', _experienceKey);
    SectionScrollRegistry.register('skills', _skillsKey);
    SectionScrollRegistry.register('contact', _contactKey);
  }

  void _scrollToContact() => SectionScrollRegistry.scrollTo('contact');
  void _scrollToProjects() => SectionScrollRegistry.scrollTo('projects');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(
              onGetInTouch: _scrollToContact,
              onScrollDown: _scrollToProjects,
            ),
            KeyedSubtree(key: _projectsKey, child: const ProjectsPreviewSection()),
            KeyedSubtree(key: _aboutKey, child: const AboutSection()),
            KeyedSubtree(key: _experienceKey, child: const ExperienceSection()),
            const CertificationsSection(),
            const EducationSection(),
            KeyedSubtree(key: _skillsKey, child: const SkillsSection()),
            const ToolsSection(),
            KeyedSubtree(key: _contactKey, child: const ContactSection()),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
