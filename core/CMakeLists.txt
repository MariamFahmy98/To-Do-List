cmake_minimum_required(VERSION 3.12)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 COMPONENTS Core Gui Qml Quick REQUIRED)

add_executable(todo_app
    main.cpp
    toDoModel.cpp
    modelInterface.cpp
    resources/qml/resources.qrc
    resources/icons/resources.qrc
)

target_link_libraries(todo_app PUBLIC
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)
