import 'package:flutter/material.dart';

class InventoryChangeDialog extends StatefulWidget {
  const InventoryChangeDialog({super.key, this.inventoryName});

  final String? inventoryName;

  @override
  State<InventoryChangeDialog> createState() => _InventoryChangeDialogState();
}

class _InventoryChangeDialogState extends State<InventoryChangeDialog> {
  final TextEditingController _inventoryChangeTextController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _inventoryChangeTextController.text = widget.inventoryName ?? "";
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
              controller: _inventoryChangeTextController,
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return "Vous devez rentrer une valeur";
                }
                return null;
              },
            ),
            TextButton(
                onPressed: _onValidate,
                child:
                    Text(widget.inventoryName == null ? "Ajouter" : "Modifier"))
          ],
        ),
      ),
    ));
  }

  void _onValidate() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(_inventoryChangeTextController.text);
  }
}
