// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import '../../../../core/utils/responsive.dart';
// import '../../../../core/widgets/app_buttons.dart';
// import '../../../../core/widgets/gradient_background.dart';

// class HeroSection extends StatelessWidget {
//   const HeroSection({
//     super.key,
//     required this.onGetInTouch,
//     this.onScrollDown,
//   });

//   final VoidCallback onGetInTouch;
//   final VoidCallback? onScrollDown;

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = Responsive.isMobile(context);
//     final isTablet = Responsive.isTablet(context);
//     final size = MediaQuery.of(context).size;

//     // Compact, balanced hero height without excessive dead space
//     final desktopHeight = size.height.clamp(600.0, 710.0);
//     final heroHeight = isMobile ? null : desktopHeight;

//     final content = isMobile
//         ? Padding(
//             padding: const EdgeInsets.fromLTRB(20, 36, 20, 32),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _HeroText(
//                   isMobile: true,
//                   onGetInTouch: onGetInTouch,
//                 ),
//                 const SizedBox(height: 28),
//                 const _PortraitVisual(isMobile: true),
//                 if (onScrollDown != null) ...[
//                   const SizedBox(height: 24),
//                   _ScrollIndicator(onTap: onScrollDown!),
//                 ],
//               ],
//             ),
//           )
//         : Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center,
//             children: [
//               // Main centered content row
//               Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: Responsive.contentMaxWidth),
//                   child: Padding(
//                     padding: Responsive.pageHorizontalPadding(context),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Left column: main text/content and neatly aligned stats
//                         Expanded(
//                           flex: 6,
//                           child: _HeroText(
//                             isMobile: false,
//                             onGetInTouch: onGetInTouch,
//                           ),
//                         ),
//                         const SizedBox(width: 24),
//                         // Right column: large visual partially positioned off-screen on the right
//                         Expanded(
//                           flex: 5,
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Transform.translate(
//                               offset: Offset(isTablet ? 40 : 90, 0),
//                               child: const _PortraitVisual(isMobile: false),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // Subtle scroll indicator at bottom center
//               if (onScrollDown != null)
//                 Positioned(
//                   bottom: 14,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: _ScrollIndicator(onTap: onScrollDown!),
//                   ),
//                 ),
//             ],
//           );

//     return SizedBox(
//       height: heroHeight,
//       child: ClipRect(
//         child: GradientBackground(
//           child: content,
//         ),
//       ),
//     );
//   }
// }

// class _HeroText extends StatelessWidget {
//   const _HeroText({required this.isMobile, required this.onGetInTouch});

//   final bool isMobile;
//   final VoidCallback onGetInTouch;

//   @override
//   Widget build(BuildContext context) {
//     final alignment = isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
//     final textAlign = isMobile ? TextAlign.center : TextAlign.start;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: alignment,
//       children: [
//         // Status Badge / Greeting
//         _StatusBadge(isMobile: isMobile)
//             .animate()
//             .fadeIn(duration: 450.ms)
//             .slideY(begin: 0.2, end: 0),
//         const SizedBox(height: 10),

//         // Main Title (Talha Saleem)
//         RichText(
//           textAlign: textAlign,
//           text: TextSpan(
//             style: AppTextStyles.heroTitle(context),
//             children: const [
//               TextSpan(text: 'Talha '),
//               TextSpan(
//                 text: 'Saleem',
//                 style: TextStyle(color: AppColors.accentBlue),
//               ),
//             ],
//           ),
//         )
//             .animate()
//             .fadeIn(delay: 100.ms, duration: 600.ms)
//             .slideY(begin: 0.2, end: 0),
//         const SizedBox(height: 8),

//         // Role (Senior Flutter Developer)
//         Text(
//           AppConstants.role,
//           textAlign: textAlign,
//           style: AppTextStyles.heroSubtitle(context).copyWith(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.w600,
//             fontSize: isMobile ? 16 : 19,
//           ),
//         ).animate().fadeIn(delay: 180.ms, duration: 600.ms),
//         const SizedBox(height: 10),

//         // Tagline
//         ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 500),
//           child: Text(
//             AppConstants.tagline,
//             textAlign: textAlign,
//             style: AppTextStyles.body.copyWith(
//               color: AppColors.textSecondary,
//               fontSize: isMobile ? 13.5 : 14.5,
//               height: 1.5,
//             ),
//           ),
//         )
//             .animate()
//             .fadeIn(delay: 240.ms, duration: 600.ms)
//             .slideY(begin: 0.15, end: 0),
//         const SizedBox(height: 20),

//         // CTAs Row: "View my work" + "Get In Touch"
//         Wrap(
//           alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           spacing: 12,
//           runSpacing: 10,
//           children: [
//             PrimaryButton(
//               label: 'View my work',
//               icon: Icons.arrow_outward_rounded,
//               onPressed: () => context.go('/projects'),
//             ),
//             SecondaryButton(
//               label: 'Get In Touch',
//               isCompact: true,
//               onPressed: onGetInTouch,
//             ),
//           ],
//         )
//             .animate()
//             .fadeIn(delay: 320.ms, duration: 600.ms)
//             .slideY(begin: 0.15, end: 0),
//         const SizedBox(height: 24),

//         // Neatly aligned stats/highlights near the bottom of hero
//         _StatsBar(isMobile: isMobile)
//             .animate()
//             .fadeIn(delay: 420.ms, duration: 600.ms),
//       ],
//     );
//   }
// }

// class _StatusBadge extends StatelessWidget {
//   const _StatusBadge({required this.isMobile});

//   final bool isMobile;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceElevated.withValues(alpha: 0.7),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.accentBlue.withValues(alpha: 0.25)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 7,
//             height: 7,
//             decoration: const BoxDecoration(
//               color: Color(0xFF10B981),
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xFF10B981),
//                   blurRadius: 6,
//                   spreadRadius: 1,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             "Hello, I'm",
//             style: AppTextStyles.bodySmall.copyWith(
//               color: AppColors.accentBlue,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.5,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PortraitVisual extends StatelessWidget {
//   const _PortraitVisual({required this.isMobile});

//   final bool isMobile;

//   @override
//   Widget build(BuildContext context) {
//     final height = isMobile ? 330.0 : 510.0;
//     final width = isMobile
//         ? (MediaQuery.of(context).size.width - 40).clamp(280.0, 380.0)
//         : 580.0;

//     return _FloatingPortrait(
//       child: SizedBox(
//         height: height,
//         width: width,
//         child: Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.center,
//           children: [
//             // Ambient radial glow behind the visual
//             Positioned(
//               right: isMobile ? 10 : 20,
//               top: isMobile ? 20 : 30,
//               child: Container(
//                 width: isMobile ? 220 : 360,
//                 height: isMobile ? 220 : 360,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [
//                       AppColors.primary.withValues(alpha: 0.28),
//                       AppColors.accentBlue.withValues(alpha: 0.12),
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Main visual container with masked portrait or custom tech artwork
//             _MaskedPortrait(width: width, height: height),

//             // Floating Chip 1: Flutter Tech
//             Positioned(
//               top: isMobile ? 24 : 54,
//               left: isMobile ? 6 : 14,
//               child: const _FloatingChip(
//                 delay: Duration(milliseconds: 200),
//                 child: _TechChip(),
//               ),
//             ),

//             // Floating Chip 2: Code Snippet
//             Positioned(
//               top: isMobile ? 150 : 190,
//               right: isMobile ? 2 : 24,
//               child: const _FloatingChip(
//                 delay: Duration(milliseconds: 700),
//                 child: _CodeChip(),
//               ),
//             ),

//             // Floating Chip 3: Shipped status
//             Positioned(
//               bottom: isMobile ? 20 : 44,
//               left: isMobile ? 20 : 48,
//               child: const _FloatingChip(
//                 delay: Duration(milliseconds: 450),
//                 child: _AvailabilityChip(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _MaskedPortrait extends StatelessWidget {
//   const _MaskedPortrait({required this.width, required this.height});

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     Widget image = Image.asset(
//       AppConstants.profilePhotoAsset,
//       width: width,
//       height: height,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) => _PortraitFallback(
//         width: width,
//         height: height,
//       ),
//     );

//     // Apply soft gradient mask along the right and bottom edges for the half-visible blend
//     image = ShaderMask(
//       blendMode: BlendMode.dstIn,
//       shaderCallback: (bounds) => const LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [Colors.white, Colors.white, Colors.transparent],
//         stops: [0.0, 0.78, 1.0],
//       ).createShader(bounds),
//       child: image,
//     );

//     return ShaderMask(
//       blendMode: BlendMode.dstIn,
//       shaderCallback: (bounds) => const LinearGradient(
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//         colors: [Colors.white, Colors.white, Colors.transparent],
//         stops: [0.0, 0.76, 1.0],
//       ).createShader(bounds),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(28),
//         child: image,
//       ),
//     );
//   }
// }

// class _PortraitFallback extends StatelessWidget {
//   const _PortraitFallback({required this.width, required this.height});

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(28),
//         border: Border.all(color: AppColors.glassBorderHover),
//         gradient: const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF141929),
//             Color(0xFF0D101C),
//             Color(0xFF08090D),
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primary.withValues(alpha: 0.18),
//             blurRadius: 36,
//             offset: const Offset(0, 16),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Subtle top window control dots
//           Positioned(
//             top: 16,
//             left: 20,
//             child: Row(
//               children: [
//                 _dot(const Color(0xFFFF5F56)),
//                 const SizedBox(width: 6),
//                 _dot(const Color(0xFFFFBD2E)),
//                 const SizedBox(width: 6),
//                 _dot(const Color(0xFF27C93F)),
//               ],
//             ),
//           ),

//           // Central glowing developer illustration / emblem
//           Center(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Outer subtle ring
//                 Container(
//                   width: 220,
//                   height: 220,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: AppColors.accentBlue.withValues(alpha: 0.15),
//                       width: 1.5,
//                     ),
//                   ),
//                 ),
//                 // Inner glowing circle
//                 Container(
//                   width: 160,
//                   height: 160,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: RadialGradient(
//                       colors: [
//                         AppColors.primary.withValues(alpha: 0.35),
//                         AppColors.accentBlue.withValues(alpha: 0.08),
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Modern icon
//                 const Icon(
//                   Icons.flutter_dash_rounded,
//                   size: 110,
//                   color: AppColors.accentBlue,
//                 ),
//               ],
//             ),
//           ),

//           // Bottom code highlight tag
//           Positioned(
//             bottom: 24,
//             left: 20,
//             right: 20,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               decoration: BoxDecoration(
//                 color: AppColors.surface.withValues(alpha: 0.8),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: AppColors.glassBorder),
//               ),
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.terminal_rounded, size: 14, color: AppColors.accentBlue),
//                   SizedBox(width: 8),
//                   Text(
//                     'flutter build app --release',
//                     style: TextStyle(
//                       fontFamily: 'monospace',
//                       fontSize: 11,
//                       color: AppColors.textSecondary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _dot(Color color) => Container(
//         width: 9,
//         height: 9,
//         decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//       );
// }

// class _FloatingPortrait extends StatefulWidget {
//   const _FloatingPortrait({required this.child});

//   final Widget child;

//   @override
//   State<_FloatingPortrait> createState() => _FloatingPortraitState();
// }

// class _FloatingPortraitState extends State<_FloatingPortrait>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _offset;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 4200),
//     )..repeat(reverse: true);
//     _offset = Tween<double>(begin: -7, end: 7).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _offset,
//       builder: (context, child) =>
//           Transform.translate(offset: Offset(0, _offset.value), child: child),
//       child: widget.child,
//     );
//   }
// }

// class _FloatingChip extends StatefulWidget {
//   const _FloatingChip({required this.child, required this.delay});

//   final Widget child;
//   final Duration delay;

//   @override
//   State<_FloatingChip> createState() => _FloatingChipState();
// }

// class _FloatingChipState extends State<_FloatingChip>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _offset;
//   Timer? _delayTimer;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 3000),
//     );
//     _offset = Tween<double>(begin: -4.5, end: 4.5).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
//     );
//     _delayTimer = Timer(widget.delay, () {
//       if (mounted) _controller.repeat(reverse: true);
//     });
//   }

//   @override
//   void dispose() {
//     _delayTimer?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _offset,
//       builder: (context, child) =>
//           Transform.translate(offset: Offset(0, _offset.value), child: child),
//       child: widget.child,
//     );
//   }
// }

// class _GlassChip extends StatelessWidget {
//   const _GlassChip({
//     required this.child,
//     this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//   });

//   final Widget child;
//   final EdgeInsets padding;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(14),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
//         child: Container(
//           padding: padding,
//           decoration: BoxDecoration(
//             color: AppColors.surface.withValues(alpha: 0.8),
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.32),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }

// class _TechChip extends StatelessWidget {
//   const _TechChip();

//   @override
//   Widget build(BuildContext context) {
//     return const _GlassChip(
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             Icons.flutter_dash_rounded,
//             color: AppColors.accentBlue,
//             size: 20,
//           ),
//           SizedBox(width: 8),
//           Text(
//             'Flutter & Dart',
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//               fontSize: 12.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _CodeChip extends StatelessWidget {
//   const _CodeChip();

//   @override
//   Widget build(BuildContext context) {
//     return const _GlassChip(
//       padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
//       child: Text.rich(
//         TextSpan(
//           children: [
//             TextSpan(
//               text: 'final ',
//               style: TextStyle(color: AppColors.accentViolet),
//             ),
//             TextSpan(
//               text: 'ship',
//               style: TextStyle(color: AppColors.textPrimary),
//             ),
//             TextSpan(
//               text: ' = ',
//               style: TextStyle(color: AppColors.textMuted),
//             ),
//             TextSpan(
//               text: 'true',
//               style: TextStyle(color: AppColors.accentBlue),
//             ),
//             TextSpan(
//               text: ';',
//               style: TextStyle(color: AppColors.textPrimary),
//             ),
//           ],
//           style: TextStyle(
//             fontFamily: 'monospace',
//             fontSize: 11.5,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AvailabilityChip extends StatelessWidget {
//   const _AvailabilityChip();

//   @override
//   Widget build(BuildContext context) {
//     return const _GlassChip(
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.bolt_rounded, color: Color(0xFFFFC857), size: 17),
//           SizedBox(width: 6),
//           Text(
//             '30+ apps shipped',
//             style: TextStyle(
//               color: AppColors.textSecondary,
//               fontSize: 11.5,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StatsBar extends StatelessWidget {
//   const _StatsBar({required this.isMobile});

//   final bool isMobile;

//   static const _stats = [
//     (Icons.schedule_rounded, '4+ Years', 'Experience'),
//     (Icons.rocket_launch_rounded, '30+ Apps', 'Shipped'),
//     (Icons.devices_rounded, 'iOS & Android', 'Cross-Platform'),
//     (Icons.storefront_rounded, 'Concept to', 'Store Launch'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     if (isMobile) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//         decoration: BoxDecoration(
//           color: AppColors.surfaceElevated.withValues(alpha: 0.6),
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppColors.glassBorder),
//         ),
//         child: Wrap(
//           alignment: WrapAlignment.center,
//           spacing: 16,
//           runSpacing: 10,
//           children: [
//             for (final stat in _stats)
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(stat.$1, color: AppColors.accentBlue, size: 15),
//                   const SizedBox(width: 6),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         stat.$2,
//                         style: AppTextStyles.bodySmall.copyWith(
//                           color: AppColors.textPrimary,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 11.5,
//                         ),
//                       ),
//                       Text(
//                         stat.$3,
//                         style: AppTextStyles.bodySmall.copyWith(
//                           fontSize: 10,
//                           color: AppColors.textMuted,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceElevated.withValues(alpha: 0.6),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.glassBorder),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.22),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: IntrinsicHeight(
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             for (int i = 0; i < _stats.length; i++) ...[
//               if (i > 0) ...[
//                 const SizedBox(width: 12),
//                 Container(
//                   width: 1,
//                   height: 20,
//                   color: AppColors.divider,
//                 ),
//                 const SizedBox(width: 12),
//               ],
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: AppColors.accentBlue.withValues(alpha: 0.12),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Icon(_stats[i].$1, color: AppColors.accentBlue, size: 15),
//                   ),
//                   const SizedBox(width: 7),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         _stats[i].$2,
//                         style: AppTextStyles.bodySmall.copyWith(
//                           color: AppColors.textPrimary,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                         ),
//                       ),
//                       Text(
//                         _stats[i].$3,
//                         style: AppTextStyles.bodySmall.copyWith(
//                           fontSize: 10,
//                           color: AppColors.textMuted,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ScrollIndicator extends StatefulWidget {
//   const _ScrollIndicator({required this.onTap});

//   final VoidCallback onTap;

//   @override
//   State<_ScrollIndicator> createState() => _ScrollIndicatorState();
// }

// class _ScrollIndicatorState extends State<_ScrollIndicator>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _bounce;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat(reverse: true);
//     _bounce = Tween<double>(begin: 0, end: 5).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: GestureDetector(
//         onTap: widget.onTap,
//         child: AnimatedBuilder(
//           animation: _bounce,
//           builder: (context, child) {
//             return Transform.translate(
//               offset: Offset(0, _bounce.value),
//               child: child,
//             );
//           },
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'SCROLL',
//                 style: TextStyle(
//                   color: AppColors.textMuted.withValues(alpha: 0.75),
//                   fontSize: 9.5,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 2.2,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Icon(
//                 Icons.keyboard_arrow_down_rounded,
//                 color: AppColors.accentBlue.withValues(alpha: 0.75),
//                 size: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ).animate().fadeIn(delay: 600.ms, duration: 550.ms);
//   }
// }



import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/gradient_background.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onGetInTouch,
    this.onScrollDown,
  });

  final VoidCallback onGetInTouch;
  final VoidCallback? onScrollDown;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final size = MediaQuery.of(context).size;

    // Compact, balanced hero height without excessive dead space
    final desktopHeight = size.height.clamp(600.0, 710.0);
    final heroHeight = isMobile ? null : desktopHeight;

    final content = isMobile
        ? Padding(
            padding: const EdgeInsets.fromLTRB(20, 36, 20, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _HeroText(
                  isMobile: true,
                  onGetInTouch: onGetInTouch,
                ),
                const SizedBox(height: 28),
                const _PortraitVisual(isMobile: true),
                if (onScrollDown != null) ...[
                  const SizedBox(height: 24),
                  _ScrollIndicator(onTap: onScrollDown!),
                ],
              ],
            ),
          )
        : Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Main centered content row
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: Responsive.contentMaxWidth),
                  child: Padding(
                    padding: Responsive.pageHorizontalPadding(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left column: main text/content and neatly aligned stats
                        Expanded(
                          flex: 6,
                          child: _HeroText(
                            isMobile: false,
                            onGetInTouch: onGetInTouch,
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Right column: large visual partially positioned off-screen on the right
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Transform.translate(
                              offset: Offset(isTablet ? 40 : 90, 0),
                              child: const _PortraitVisual(isMobile: false),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Subtle scroll indicator at bottom center
              if (onScrollDown != null)
                Positioned(
                  bottom: 14,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _ScrollIndicator(onTap: onScrollDown!),
                  ),
                ),
            ],
          );

    return SizedBox(
      height: heroHeight,
      child: ClipRect(
        child: GradientBackground(
          child: content,
        ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.isMobile, required this.onGetInTouch});

  final bool isMobile;
  final VoidCallback onGetInTouch;

  @override
  Widget build(BuildContext context) {
    final alignment = isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isMobile ? TextAlign.center : TextAlign.start;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        // Status Badge / Greeting
        _StatusBadge(isMobile: isMobile)
            .animate()
            .fadeIn(duration: 450.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 10),

        // Main Title (Talha Saleem)
        RichText(
          textAlign: textAlign,
          text: TextSpan(
            style: AppTextStyles.heroTitle(context),
            children: const [
              TextSpan(text: 'Talha '),
              TextSpan(
                text: 'Saleem',
                style: TextStyle(color: AppColors.accentBlue),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 100.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 8),

        // Role (Senior Flutter Developer)
        Text(
          AppConstants.role,
          textAlign: textAlign,
          style: AppTextStyles.heroSubtitle(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 16 : 19,
          ),
        ).animate().fadeIn(delay: 180.ms, duration: 600.ms),
        const SizedBox(height: 10),

        // Tagline
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            AppConstants.tagline,
            textAlign: textAlign,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 13.5 : 14.5,
              height: 1.5,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 240.ms, duration: 600.ms)
            .slideY(begin: 0.15, end: 0),
        const SizedBox(height: 20),

        // CTAs Row: "View my work" + "Get In Touch"
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 10,
          children: [
            PrimaryButton(
              label: 'View my work',
              icon: Icons.arrow_outward_rounded,
              onPressed: () => context.go('/projects'),
            ),
            SecondaryButton(
              label: 'Get In Touch',
              isCompact: true,
              onPressed: onGetInTouch,
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 320.ms, duration: 600.ms)
            .slideY(begin: 0.15, end: 0),
        const SizedBox(height: 24),

        // Neatly aligned stats/highlights near the bottom of hero
        _StatsBar(isMobile: isMobile)
            .animate()
            .fadeIn(delay: 420.ms, duration: 600.ms),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accentBlue.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF10B981),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Hello, I'm",
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.accentBlue,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _PortraitVisual extends StatelessWidget {
  const _PortraitVisual({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final height = isMobile ? 330.0 : 510.0;
    final width = isMobile
        ? (MediaQuery.of(context).size.width - 40).clamp(280.0, 380.0)
        : 580.0;

    return _FloatingPortrait(
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Ambient radial glow behind the visual
            Positioned(
              right: isMobile ? 10 : 20,
              top: isMobile ? 20 : 30,
              child: Container(
                width: isMobile ? 220 : 360,
                height: isMobile ? 220 : 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.28),
                      AppColors.accentBlue.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main visual container with masked portrait or custom tech artwork
            _MaskedPortrait(width: width, height: height),

            // Floating Chip 1: Flutter Tech
            Positioned(
              top: isMobile ? 24 : 54,
              left: isMobile ? 6 : 14,
              child: const _FloatingChip(
                delay: Duration(milliseconds: 200),
                child: _TechChip(),
              ),
            ),

            // Floating Chip 2: Code Snippet
            Positioned(
              top: isMobile ? 150 : 190,
              right: isMobile ? 2 : 24,
              child: const _FloatingChip(
                delay: Duration(milliseconds: 700),
                child: _CodeChip(),
              ),
            ),

            // Floating Chip 3: Shipped status
            Positioned(
              bottom: isMobile ? 20 : 44,
              left: isMobile ? 20 : 48,
              child: const _FloatingChip(
                delay: Duration(milliseconds: 450),
                child: _AvailabilityChip(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaskedPortrait extends StatelessWidget {
  const _MaskedPortrait({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      AppConstants.profilePhotoAsset,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _PortraitFallback(
        width: width,
        height: height,
      ),
    );

    // Apply soft gradient mask along the right and bottom edges for the half-visible blend
    image = ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white, Colors.white, Colors.transparent],
        stops: [0.0, 0.78, 1.0],
      ).createShader(bounds),
      child: image,
    );

    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.white, Colors.white, Colors.transparent],
        stops: [0.0, 0.76, 1.0],
      ).createShader(bounds),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: image,
      ),
    );
  }
}

class _PortraitFallback extends StatelessWidget {
  const _PortraitFallback({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.glassBorderHover),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF141929),
            Color(0xFF0D101C),
            Color(0xFF08090D),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle top window control dots
          Positioned(
            top: 16,
            left: 20,
            child: Row(
              children: [
                _dot(const Color(0xFFFF5F56)),
                const SizedBox(width: 6),
                _dot(const Color(0xFFFFBD2E)),
                const SizedBox(width: 6),
                _dot(const Color(0xFF27C93F)),
              ],
            ),
          ),

          // Central glowing developer illustration / emblem
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer subtle ring
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accentBlue.withValues(alpha: 0.15),
                      width: 1.5,
                    ),
                  ),
                ),
                // Inner glowing circle
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.35),
                        AppColors.accentBlue.withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Modern icon
                const Icon(
                  Icons.flutter_dash_rounded,
                  size: 110,
                  color: AppColors.accentBlue,
                ),
              ],
            ),
          ),

          // Bottom code highlight tag
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.terminal_rounded, size: 14, color: AppColors.accentBlue),
                  SizedBox(width: 8),
                  Text(
                    'flutter build app --release',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) => Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

class _FloatingPortrait extends StatefulWidget {
  const _FloatingPortrait({required this.child});

  final Widget child;

  @override
  State<_FloatingPortrait> createState() => _FloatingPortraitState();
}

class _FloatingPortraitState extends State<_FloatingPortrait>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat(reverse: true);
    _offset = Tween<double>(begin: -7, end: 7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) =>
          Transform.translate(offset: Offset(0, _offset.value), child: child),
      child: widget.child,
    );
  }
}

class _FloatingChip extends StatefulWidget {
  const _FloatingChip({required this.child, required this.delay});

  final Widget child;
  final Duration delay;

  @override
  State<_FloatingChip> createState() => _FloatingChipState();
}

class _FloatingChipState extends State<_FloatingChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _offset;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _offset = Tween<double>(begin: -4.5, end: 4.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
    _delayTimer = Timer(widget.delay, () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) =>
          Transform.translate(offset: Offset(0, _offset.value), child: child),
      child: widget.child,
    );
  }
}

class _GlassChip extends StatelessWidget {
  const _GlassChip({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.32),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip();

  @override
  Widget build(BuildContext context) {
    return const _GlassChip(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flutter_dash_rounded,
            color: AppColors.accentBlue,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            'Flutter & Dart',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeChip extends StatelessWidget {
  const _CodeChip();

  @override
  Widget build(BuildContext context) {
    return const _GlassChip(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'final ',
              style: TextStyle(color: AppColors.accentViolet),
            ),
            TextSpan(
              text: 'ship',
              style: TextStyle(color: AppColors.textPrimary),
            ),
            TextSpan(
              text: ' = ',
              style: TextStyle(color: AppColors.textMuted),
            ),
            TextSpan(
              text: 'true',
              style: TextStyle(color: AppColors.accentBlue),
            ),
            TextSpan(
              text: ';',
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ],
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _AvailabilityChip extends StatelessWidget {
  const _AvailabilityChip();

  @override
  Widget build(BuildContext context) {
    return const _GlassChip(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_rounded, color: Color(0xFFFFC857), size: 17),
          SizedBox(width: 6),
          Text(
            '30+ apps shipped',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsBar extends StatelessWidget {
  const _StatsBar({required this.isMobile});

  final bool isMobile;

  static const _stats = [
    (Icons.schedule_rounded, '4+ Years', 'Experience'),
    (Icons.rocket_launch_rounded, '30+ Apps', 'Shipped'),
    (Icons.devices_rounded, 'iOS & Android', 'Cross-Platform'),
    (Icons.storefront_rounded, 'Concept to', 'Store Launch'),
  ];

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 10,
          children: [
            for (final stat in _stats)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(stat.$1, color: AppColors.accentBlue, size: 15),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        stat.$2,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.5,
                        ),
                      ),
                      Text(
                        stat.$3,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < _stats.length; i++) ...[
              if (i > 0) ...[
                const SizedBox(width: 12),
                Container(
                  width: 1,
                  height: 20,
                  color: AppColors.divider,
                ),
                const SizedBox(width: 12),
              ],
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(_stats[i].$1, color: AppColors.accentBlue, size: 15),
                  ),
                  const SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _stats[i].$2,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _stats[i].$3,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
  const _ScrollIndicator({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _bounce = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _bounce,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _bounce.value),
              child: child,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SCROLL',
                style: TextStyle(
                  color: AppColors.textMuted.withValues(alpha: 0.75),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.2,
                ),
              ),
              const SizedBox(height: 2),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.accentBlue.withValues(alpha: 0.75),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 550.ms);
  }
}
