import 'package:flutter/material.dart';
import '../error/failure.dart';
import '../utils/constants/app_strings.dart';

class TikTokProWidget extends StatefulWidget {
  final bool isLoading;
  final Failure? failure;
  final String? error;
  final VoidCallback? onRetry;
  final Widget child;

  const TikTokProWidget({
    super.key,
    required this.isLoading,
    this.error,
    this.failure,
    required this.child,
    this.onRetry,
  });

  @override
  State<TikTokProWidget> createState() => _TikTokProWidgetState();
}

class _TikTokProWidgetState extends State<TikTokProWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      _animationController.repeat();
      return Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16),
              Text(
                AppStrings.loadingMessage,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.error != null) {
      _animationController.forward();
      return Container(
        color: Colors.black,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.failure?.message ?? widget.error ?? AppStrings.errorMessage,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (widget.onRetry != null)
                  ElevatedButton(
                    onPressed: widget.onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(AppStrings.retryButtonText),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    _animationController.forward();
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}