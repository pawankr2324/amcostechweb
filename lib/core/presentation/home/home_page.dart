// File: lib/core/pages/home_page.dart

import 'package:amcostechweb/core/utils/responsive/responsive_layout.dart';
import 'package:amcostechweb/core/widgets/app_navbar.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/side_navbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amcostechweb/core/utils/theme/app_text_styles.dart';

import 'package:userdata/userdata.dart';

import '../../widgets/sideNavbar/cubit/side_nav_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavbar(),
      body: ResponsiveLayout(
        mobile: _buildMobileBody(context),
        tablet: _buildTabletBody(context),
        desktop: _buildDesktopBody(context),
      ),
    );
  }

  Widget _buildDesktopBody(BuildContext context) {
    return BlocProvider(
      create: (_) => SideNavCubit(), // start expanded
      child: Row(
        children: [
          const SideNavbar(), // <-- fixed width; do NOT wrap with Expanded
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserdataCubit, UserdataState>(
                  builder: (ctx, state) {
                    final name =
                        (state is UserdataLoaded &&
                                state.userdata.firstName.isNotEmpty)
                            ? state.userdata.firstName
                            : 'User';
                    return Text(
                      'Welcome, $name!',
                      style: AppTextStyles().titleLarge,
                    );
                  },
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: Text(
                      'Your main content goes here.',
                      style: AppTextStyles().bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMobileBody(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(child: Container(color: Colors.green)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<UserdataCubit, UserdataState>(
                builder: (ctx, state) {
                  final name =
                      (state is UserdataLoaded &&
                              state.userdata.firstName.isNotEmpty)
                          ? state.userdata.firstName
                          : 'User';
                  return Text(
                    'Welcome, $name!',
                    style: AppTextStyles().titleLarge,
                  );
                },
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Text(
                    'Your main content goes here.',
                    style: AppTextStyles().bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTabletBody(BuildContext context) => Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 600),
    child: _buildMobileBody(context),
  ),
);
