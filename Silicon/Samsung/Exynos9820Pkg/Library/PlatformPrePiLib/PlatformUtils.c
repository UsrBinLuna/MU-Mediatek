#include <PiPei.h>
#include <Library/IoLib.h>
#include <Library/PlatformPrePiLib.h>
#include "PlatformUtils.h"

VOID PlatformInitialize(VOID)
{
  // Enable Framebuffer
  MmioWrite32(0x19030000, 0x1281);
}
