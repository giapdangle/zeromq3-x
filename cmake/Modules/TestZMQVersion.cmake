
  MESSAGE(STATUS "Detecting ZMQ")
        SET(TRY_RUN_DIR ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/zmq_run.dir)

        TRY_RUN(RUN_RESULT COMPILE_RESULT
          ${TRY_RUN_DIR}
          ${CMAKE_SOURCE_DIR}/cmake/Modules/zmq_version.cpp
          CMAKE_FLAGS 
            "-DINCLUDE_DIRECTORIES:STRING=${CMAKE_SOURCE_DIR}/include"
          COMPILE_OUTPUT_VARIABLE COMPILE_OUTPUT
          RUN_OUTPUT_VARIABLE RUN_OUTPUT)

        IF(COMPILE_RESULT)
          IF(RUN_RESULT MATCHES "FAILED_TO_RUN")
            MESSAGE(STATUS "Detecting ZMQ - failed")
          ELSE()
            STRING(REGEX REPLACE "([0-9]+)\\.([0-9]+)\\.([0-9]+).*" "\\1" ZMQ_VERSION_MAJOR "${RUN_OUTPUT}")
            STRING(REGEX REPLACE "([0-9]+)\\.([0-9]+)\\.([0-9]+).*" "\\2" ZMQ_VERSION_MINOR "${RUN_OUTPUT}")
            STRING(REGEX REPLACE "([0-9]+)\\.([0-9]+)\\.([0-9]+).*" "\\3" ZMQ_VERSION_PATCH "${RUN_OUTPUT}")
            MESSAGE(STATUS "Detecting ZMQ - ${ZMQ_VERSION_MAJOR}.${ZMQ_VERSION_MINOR}.${ZMQ_VERSION_PATCH}")
          ENDIF()
        ELSE()
          MESSAGE(STATUS "Check for ZMQ version - not found")
          MESSAGE(STATUS "Detecting ZMQ - failed")
        ENDIF()

  if(MSVC_VERSION MATCHES "1700")
    if(CMAKE_GENERATOR_TOOLSET MATCHES "v110_xp")
      set(_zmq_TOOLSET "-v110_xp")
      set(_zmq_COMPILER "vc110")
    else()
      set(_zmq_TOOLSET "-v110")
      set(_zmq_COMPILER "vc110")
    endif()
  elseif(MSVC10)
    set(_zmq_TOOLSET "-v100")
    set(_zmq_COMPILER "vc100")
  elseif(MSVC90)
    set(_zmq_TOOLSET "-v90")
    set(_zmq_COMPILER "vc90")
  else()
    set(_zmq_TOOLSET "")
    set(_zmq_COMPILER "")
  endif()
