add_custom_target(libc_search_unittests)
add_libc_unittest(
  hsearch_test
  SUITE
    libc_search_unittests
  SRCS
    hsearch_test.cpp
  DEPENDS
    libc.src.search.hsearch_r
    libc.src.search.hcreate_r
    libc.src.search.hdestroy_r
    libc.src.search.hsearch
    libc.src.search.hcreate
    libc.src.search.hdestroy
    libc.src.errno.errno
)

add_libc_unittest(
  insque_test
  SUITE
    libc_search_unittests
  SRCS
    insque_test.cpp
  DEPENDS
    libc.src.search.insque
    libc.src.search.remque
)

add_libc_unittest(
  lfind_test
  SUITE
    libc_search_unittests
  SRCS
    lfind_test.cpp
  DEPENDS
    libc.src.search.lfind
)

add_libc_unittest(
  lsearch_test
  SUITE
    libc_search_unittests
  SRCS
    lsearch_test.cpp
  DEPENDS
    libc.src.search.lsearch
)
