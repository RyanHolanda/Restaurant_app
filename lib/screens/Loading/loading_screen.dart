import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeShimmer(
                          width: 50,
                          height: 10,
                          baseColor: Theme.of(context).colorScheme.onPrimary,
                          highlightColor:
                              Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeShimmer(
                          width: 50,
                          height: 10,
                          baseColor: Theme.of(context).colorScheme.onPrimary,
                          highlightColor:
                              Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeShimmer(
                          width: 50,
                          height: 50,
                          baseColor: Theme.of(context).colorScheme.onPrimary,
                          highlightColor:
                              Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: FadeShimmer(
                              width: 200,
                              height: 5,
                              baseColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              highlightColor:
                                  Theme.of(context).colorScheme.onTertiary,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: FadeShimmer(
                              width: 200,
                              height: 5,
                              baseColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              highlightColor:
                                  Theme.of(context).colorScheme.onTertiary,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: FadeShimmer(
                              width: 100,
                              height: 5,
                              baseColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              highlightColor:
                                  Theme.of(context).colorScheme.onTertiary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: FadeShimmer(
                          width: 20,
                          height: 20,
                          baseColor: Theme.of(context).colorScheme.onPrimary,
                          highlightColor:
                              Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeShimmer(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 70,
                      baseColor: Theme.of(context).colorScheme.onPrimary,
                      highlightColor: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, bottom: 20, left: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeShimmer(
                        width: 170,
                        height: 10,
                        baseColor: Theme.of(context).colorScheme.onPrimary,
                        highlightColor:
                            Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeShimmer(
                            width: 170,
                            height: 170,
                            baseColor: Theme.of(context).colorScheme.onPrimary,
                            highlightColor:
                                Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeShimmer(
                            width: 170,
                            height: 170,
                            baseColor: Theme.of(context).colorScheme.onPrimary,
                            highlightColor:
                                Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeShimmer(
                            width: 170,
                            height: 170,
                            baseColor: Theme.of(context).colorScheme.onPrimary,
                            highlightColor:
                                Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeShimmer(
                        width: 100,
                        height: 10,
                        baseColor: Theme.of(context).colorScheme.onPrimary,
                        highlightColor:
                            Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeShimmer(
                        width: 250,
                        height: 10,
                        baseColor: Theme.of(context).colorScheme.onPrimary,
                        highlightColor:
                            Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 70),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeShimmer(
                        width: 100,
                        height: 10,
                        baseColor: Theme.of(context).colorScheme.onPrimary,
                        highlightColor:
                            Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeShimmer(
                        width: 250,
                        height: 10,
                        baseColor: Theme.of(context).colorScheme.onPrimary,
                        highlightColor:
                            Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
