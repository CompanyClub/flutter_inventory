import 'package:flutter/material.dart';

class InventoryNameDialog extends StatefulWidget {
  const InventoryNameDialog({super.key, required this.inventoryName});

  final String inventoryName;

  @override
  State<InventoryNameDialog> createState() => _InventoryNameDialogState();
}

class _InventoryNameDialogState extends State<InventoryNameDialog> {
  final TextEditingController _inventoryNameTextController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _inventoryNameTextController.text = widget.inventoryName;
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
              controller: _inventoryNameTextController,
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return "Vous devez rentrer une valeur";
                }
                return null;
              },
            ),
            TextButton(onPressed: _onValidate, child: const Text("Valider"))
          ],
        ),
      ),
    ));
  }

  void _onValidate() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(_inventoryNameTextController.text);
  }
}
