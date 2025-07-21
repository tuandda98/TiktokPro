import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:widget_common/core/utils/strings.dart';

void useErrorListener<NotifierT extends StateNotifier<StateT>, StateT extends Object>({
  required WidgetRef ref,
  required BuildContext context,
  required StateNotifierProvider<NotifierT, StateT> provider,
  void Function()? doAfter,
}) {
  ref.listen<StateT>(
    provider,
        (prev, next) {
      final failure = (next as dynamic).failure;

      if (failure != null && (prev as dynamic)?.failure != failure) {
        final message = getMessage(failure);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
        if (doAfter != null) {
          doAfter();
        }
      }
    },
  );
}

