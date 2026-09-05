import 'package:flutter/material.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';
import 'package:my_protfolio/features/admin/data/providers/skill_provider.dart';

class AdminSkillCard extends StatelessWidget {
  final SkillModel skill;
  final SkillProvider provider;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggleActive;

  const AdminSkillCard({
    super.key,
    required this.skill,
    required this.provider,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isActive = skill.isActive;

    return Opacity(
      opacity: isActive ? 1.0 : 0.72,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: isActive ? 1 : 0,
        color: isDark
            ? (isActive ? theme.cardColor : Colors.white.withValues(alpha: 0.04))
            : (isActive ? Colors.white : Colors.grey.shade100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isActive
                ? (isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.08))
                : Colors.amber.withValues(alpha: 0.4),
            width: isActive ? 1 : 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Status Bar: Active/Inactive badge & quick switch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.green.withValues(alpha: 0.15)
                          : Colors.amber.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isActive ? Icons.check_circle : Icons.visibility_off,
                          size: 12,
                          color: isActive ? Colors.green : Colors.amber.shade800,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isActive ? Colors.green : Colors.amber.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: isActive,
                      activeThumbColor: Colors.green,
                      onChanged: onToggleActive,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Image Area
            Expanded(
              child: Container(
                color: theme.primaryColor.withValues(alpha: 0.03),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: skill.image.isNotEmpty
                    ? (skill.image.startsWith('http')
                        ? Image.network(
                            skill.image,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.broken_image_rounded,
                              size: 40,
                              color: Colors.grey,
                            ),
                          )
                        : Image.asset(
                            skill.image,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.broken_image_rounded,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ))
                    : const Icon(Icons.image_rounded, size: 40, color: Colors.grey),
              ),
            ),

            // Bottom Action Bar: Name, Edit & Delete
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      skill.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isActive ? null : theme.disabledColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.blue),
                    tooltip: 'Edit Skill',
                    onPressed: onEdit,
                    splashRadius: 16,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Colors.red),
                    tooltip: 'Delete Skill',
                    onPressed: onDelete,
                    splashRadius: 16,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
