#pragma once

#include<QObject>
#include<QAbstractListModel>
#include<QString>
#include<QVector>
#include<QVariant>

struct Task {
    QString description;
    bool isFinished;
};

class ToDoModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    enum TaskRoles {
        descriptionRole = Qt::UserRole,
        isFinishedRole
    };

    explicit ToDoModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

    int count() { return rowCount(); }
    Q_INVOKABLE void insertNewTask(QString description);
    Q_INVOKABLE void removeTask(int index);


signals:
    void countChanged();

private:
    QVector<Task> tasks;
};
