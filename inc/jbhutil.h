#ifndef JBH_DEBUG_TOOLS
#define JBH_DEBUG_TOOLS

#define _FULL 0
#define _CRIT 1
#define _WARN 2
#define _INFO 3
#define _OFF  4

#ifdef DFULL
  #define DBG_L _FULL
#elif DCRIT
  #define DBG_L _CRIT
#elif DWARN
  #define DBG_L _WARN
#elif INFO
  #define DBG_L _INFO
#else
  #define DBG_L 0
#endif

#include <stdio.h>
#ifdef DEBUG
  #define DBG_T 1
#else
  #define DBG_T 0
#endif
#define debug_printf(lvl, fmt, ...) \
  do { if (DBG_T && lvl <= DBG_L) fprintf(stderr, "%s:%d:%s(): " fmt, \
      __FILE__, __LINE__, __func__, __VA_ARGS__); \
  } while (0)
#endif
