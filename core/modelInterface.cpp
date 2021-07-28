#include "modelInterface.h"

ModelInterface::ModelInterface(QObject *parent)
    : QObject(parent)
{
}

ToDoModel* ModelInterface::taskModel()
{
    return &m_taskModel;
}
