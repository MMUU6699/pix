import 'package:flutter/material.dart';

class OptimizedListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;

  const OptimizedListView({
    Key? key,
    required this.children,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent ?? 250.0, // Optimized cache extent
      itemCount: children.length,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: children[index],
        );
      },
    );
  }
}

class OptimizedListViewBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Widget? separator;

  const OptimizedListViewBuilder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.separator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (separator != null) {
      return ListView.separated(
        controller: controller,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent ?? 250.0,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return RepaintBoundary(
            child: itemBuilder(context, index),
          );
        },
        separatorBuilder: (context, index) => separator!,
      );
    }

    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent ?? 250.0,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

class LazyLoadingListView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback? onLoadMore;
  final bool hasMore;
  final Widget? loadingWidget;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final double loadMoreThreshold;

  const LazyLoadingListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.onLoadMore,
    this.hasMore = true,
    this.loadingWidget,
    this.controller,
    this.padding,
    this.physics,
    this.loadMoreThreshold = 200.0,
  }) : super(key: key);

  @override
  State<LazyLoadingListView> createState() => _LazyLoadingListViewState();
}

class _LazyLoadingListViewState extends State<LazyLoadingListView> {
  late ScrollController _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_scrollListener);
    }
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - widget.loadMoreThreshold) {
      if (!_isLoading && widget.hasMore && widget.onLoadMore != null) {
        setState(() {
          _isLoading = true;
        });
        widget.onLoadMore!();
        // Reset loading state after a delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OptimizedListViewBuilder(
      controller: _scrollController,
      padding: widget.padding,
      physics: widget.physics,
      itemCount: widget.itemCount + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.itemCount) {
          return widget.loadingWidget ??
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        }
        return widget.itemBuilder(context, index);
      },
    );
  }
}

// Performance monitoring widget
class PerformanceOverlay extends StatelessWidget {
  final Widget child;
  final bool showFPS;
  final bool showMemory;

  const PerformanceOverlay({
    Key? key,
    required this.child,
    this.showFPS = false,
    this.showMemory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    if (showFPS || showMemory) {
      result = Stack(
        children: [
          child,
          if (showFPS)
            Positioned(
              top: 50,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'FPS Monitor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      );
    }

    return result;
  }
}