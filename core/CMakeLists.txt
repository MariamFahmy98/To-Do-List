add_executable(todo_app main.cpp toDoModel.cpp modelInterface.cpp ../qml/resources.qrc ../icons/resources.qrc)

find_package(Qt6 COMPONENTS Core Gui Qml Quick QuickControls2 REQUIRED)

target_link_libraries(
       todo_app PUBLIC
       Qt6::Core
       Qt6::Gui
       Qt6::Qml
       Qt6::Quick
       Qt6::QuickControls2
)

