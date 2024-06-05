function(fetch_submodule submodule_path)
  find_package(Git QUIET)

  if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
    execute_process(
      COMMAND ${GIT_EXECUTABLE} submodule status ${submodule_path}
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
      RESULT_VARIABLE git_cmd_rc
      OUTPUT_VARIABLE git_cmd_stdout
      ERROR_VARIABLE git_cmd_stderr
      OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_STRIP_TRAILING_WHITESPACE)

    if(NOT git_cmd_rc EQUAL "0")
      message(
        FATAL_ERROR
          "'git submodule status ${submodule_path}' failed with exit code ${git_cmd_rc}\n\t${git_cmd_stderr}"
      )
    endif()

    if(git_cmd_stdout MATCHES "^-.*${submodule_path}")
      execute_process(
        COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                ${submodule_path}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        RESULT_VARIABLE git_cmd_rc
        ERROR_VARIABLE git_cmd_stderr
        OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_STRIP_TRAILING_WHITESPACE)
    endif()

    if(NOT git_cmd_rc EQUAL "0")
      message(
        FATAL_ERROR
          "'git submodule update --init --recursive ${submodule_path}' failed with exit code ${git_cmd_rc}\n\t${git_cmd_stderr}"
      )
    endif()

  endif()
endfunction()
