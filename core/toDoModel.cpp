#include "toDoModel.h"

ToDoModel::ToDoModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

QHash<int, QByteArray> ToDoModel::roleNames() const
{
    QHash<int, QByteArray> newRoles;
    newRoles[descriptionRole] = "description";
    newRoles[isFinishedRole] = "isFinished";
    return newRoles;
}

int ToDoModel::rowCount(const QModelIndex &parent) const
{
    // Return the number of the children for the root parent only.
    // Root parent is invalid parent, while its children are valid parent.
    if(parent.isValid()) return 0;
    return tasks.size();
}

QVariant ToDoModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) return QVariant();

    const Task requiredTask = tasks[index.row()];

    switch (role) {
    case descriptionRole:
        return requiredTask.description;
    case isFinishedRole:
        return requiredTask.isFinished;
    default:
        return QVariant();
    }
}

bool ToDoModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!index.isValid()) return false;

    Task requiredTask = tasks[index.row()];

    switch (role) {
    case descriptionRole:
        requiredTask.description = value.toString();
        break;
    case isFinishedRole:
        requiredTask.isFinished = value.toBool();
        break;
    }

    emit dataChanged(index, index, QVector<int>() << role);
    return true;
}

Qt::ItemFlags ToDoModel::flags(const QModelIndex &index) const
{
    if(!index.isValid()) return Qt::NoItemFlags;
    return Qt::ItemIsEditable;
}

