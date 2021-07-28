#pragma once

#include "toDoModel.h"

class ModelInterface : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ToDoModel* taskModel READ taskModel CONSTANT)
public:
    explicit ModelInterface(QObject* parent = nullptr);

    //NOTE: QObject based classes aren't copiable.
    ToDoModel* taskModel();

private:
    ToDoModel m_taskModel;
};
