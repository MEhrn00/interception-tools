add_executable(mux main.cpp)
target_include_directories(mux PRIVATE ${Boost_INCLUDE_DIRS})
target_compile_options(mux PRIVATE -Wall -Wextra -pedantic -std=c++11
                                   -DBOOST_DATE_TIME_NO_LIB)
target_link_libraries(mux Threads::Threads rt)

install(TARGETS mux RUNTIME DESTINATION bin)
