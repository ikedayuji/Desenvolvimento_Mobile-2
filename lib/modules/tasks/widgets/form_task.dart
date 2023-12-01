import 'dart:math';
import 'package:cadastro_tasks/modules/tasks/styles/styles_task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class FormTask extends StatefulWidget {
  final Function update;

  const FormTask({Key? key, required this.update}) : super(key: key);

  @override
  State<FormTask> createState() => _FormTask();
}

class _FormTask extends State<FormTask> {
  TaskService service = TaskService();
  FocusNode descFocusNode = FocusNode();
  FocusNode detFocusNode = FocusNode();
  TextEditingController descriptionControl = TextEditingController();
  TextEditingController dataControl = TextEditingController();
  TextEditingController horaControl = TextEditingController();
  TextEditingController detalhesControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: descriptionControl,
          focusNode: descFocusNode,
          decoration: const InputDecoration(
            labelText: "Título",
            icon: Icon(Icons.task),
          ),
        ),
        TextFormField(
          controller: dataControl,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: "Data da tarefa",
            icon: Icon(Icons.calendar_month),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              String dataFormatada =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
              setState(() {
                dataControl.text = dataFormatada;
              });
            }
          },
        ),
        TextFormField(
          controller: horaControl,
          readOnly: true,
          decoration: const InputDecoration(
            icon: Icon(Icons.av_timer),
            labelText: "Hora da tarefa",
          ),
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              final formattedTime = DateFormat.Hm().format(
                DateTime(2022, 1, 1, pickedTime.hour, pickedTime.minute),
              );
              setState(() {
                horaControl.text = formattedTime;
              });
            }
          },
        ),
        TextFormField(
          controller: detalhesControl,
          focusNode: detFocusNode,
          decoration: const InputDecoration(
            icon: Icon(Icons.description),
            labelText: "Detalhes da tarefa",
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style:
              StylesTask.buttonStyle(MediaQuery.of(context).size.width * 0.75),
          child: const Text("Cadastrar"),
          onPressed: () {
            var uuid = Random().nextInt(4294967296).toString();
            Task task = Task(
              id: uuid,
              descricao: descriptionControl.text,
              data: dataControl.text,
              hora: horaControl.text,
              detalhes: detalhesControl.text,
            );
            setState(() {
              service.store(task).then((value) => widget.update());
            });
          },
        ),
      ],
    );
  }
}
