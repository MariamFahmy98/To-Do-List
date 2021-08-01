cmake_minimum_required(VERSION 3.12)
project(TO-DO-APP LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

add_subdirectory(core)

find_package(Qt6 COMPONENTS Core Gui Qml Quick QuickControls2 REQUIRED)

