cmake_minimum_required(VERSION 3.16)

project(TODO_APP VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick)


qt_add_executable(appTODO_APP
    main.cpp
)

qt_add_qml_module(appTODO_APP
    URI TODO_APP
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES utils/AppPopup.qml
        RESOURCES images.qrc
        QML_FILES utils/CustomTextField.qml
        SOURCES backendhelper.h backendhelper.cpp
        QML_FILES utils/CustomScrollbar.qml
        QML_FILES utils/EditPopup.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTODO_APP PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTODO_APP
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTODO_APP
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appTODO_APP
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
