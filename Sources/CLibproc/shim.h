#ifndef SNOWHUSH_CLIBPROC_SHIM_H
#define SNOWHUSH_CLIBPROC_SHIM_H

// libproc.h is deliberately left out of the Darwin umbrella module, but its
// process-inspection APIs are available on every macOS version we support.
#include <libproc.h>

#endif
