import 'package:flutter/material.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/features/home/presentation/footer_section.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_details_info_column.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_details_screenshot_gallery.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class ProjectDetailsPage extends StatefulWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late int _visibleCount;
  bool _isLoadingMore = false;
  final int _batchSize = 10;

  @override
  void initState() {
    super.initState();
    _visibleCount = min(_batchSize, widget.project.screenshots.length);
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _visibleCount = min(
          _visibleCount + _batchSize,
          widget.project.screenshots.length,
        );
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.title),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 850;

          if (isDesktop) {
            return Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left section (1/3) - Project details
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: ProjectDetailsInfoColumn(
                            project: widget.project,
                            onLaunchUrl: _launchUrl,
                          ),
                        ),
                      ),

                      // Right section (2/3) - Screenshots
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Screenshots',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              if (widget.project.screenshots.isNotEmpty)
                                Expanded(
                                  child: ProjectDetailsScreenshotGallery(
                                    project: widget.project,
                                    visibleCount: _visibleCount,
                                    isLoadingMore: _isLoadingMore,
                                    onLoadMore: _loadMore,
                                    onRetry: () => setState(() {}),
                                  ),
                                )
                              else
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF2A3D4F)
                                          : const Color(0xFFEFEFEF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No screenshots available',
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const FooterSection(),
              ],
            );
          } else {
            // Mobile layout
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProjectDetailsInfoColumn(
                          project: widget.project,
                          onLaunchUrl: _launchUrl,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Screenshots',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        if (widget.project.screenshots.isNotEmpty)
                          SizedBox(
                            height: 300,
                            child: ProjectDetailsScreenshotGallery(
                              project: widget.project,
                              visibleCount: _visibleCount,
                              isLoadingMore: _isLoadingMore,
                              onLoadMore: _loadMore,
                              onRetry: () => setState(() {}),
                            ),
                          )
                        else
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF2A3D4F)
                                  : const Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'No screenshots available',
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const FooterSection(),
              ],
            );
          }
        },
      ),
    );
  }
}
