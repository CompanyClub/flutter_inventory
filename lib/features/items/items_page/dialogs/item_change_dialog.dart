import 'package:flutter/material.dart';

class ItemChangeDialog extends StatefulWidget {
  const ItemChangeDialog({super.key, this.itemName});

  final String? itemName;

  @override
  State<ItemChangeDialog> createState() => _ItemChangeDialogState();
}

class _ItemChangeDialogState extends State<ItemChangeDialog> {
  final TextEditingController _itemChangeTextController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _itemChangeTextController.text = widget.itemName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: _itemChangeTextController,
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return "Vous devez rentrer une valeur";
                }
                return null;
              },
            ),
            TextButton(
                onPressed: _onValidate,
                child: Text(widget.itemName == null ? "Ajouter" : "Modifier"))
          ],
        ),
      ),
    ));
  }

  void _onValidate() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(_itemChangeTextController.text);
  }
}
