add_library(
  QML_FrontEnd
  main.qml
)

find_package(Qt6 COMPONENTS Core Gui Qml Quick QuickControls2 REQUIRED)

target_include_directories(QML_FrontEnd PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")
target_compile_definitions(QML_FrontEnd PUBLIC QML_DIR="${CMAKE_CURRENT_SOURCE_DIR}")
