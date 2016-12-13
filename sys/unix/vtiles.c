/* Copyright (c) Jack Whitham, 2009 */

#include "hack.h"
#include "dlb.h"
#include "config.h"

#ifdef SHORT_FILENAMES
#include "patchlev.h"
#else
#include "patchlevel.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if defined(USE_TILES) && defined(VTILES) && defined(TTY_GRAPHICS)


extern short glyph2tile[]; 


int
vtiles_enabled()
{
    const char * t;
    static int result = 0;

    if (result == 0) {
        result = -1;
        t = getenv("TERM");
        if ((t != NULL)
        && (strcmp(t, "tilehack") == 0)) {
            result = 1;
        }
    }

    return (result == 1);
}

void
vtiles_move(window)
winid window;
{
  int hp100, danger = 9;
  static int old_danger;

  if (!vtiles_enabled()) return;

  if ((window == WIN_MAP) && !(
	Is_rogue_level(&u.uz) ||
    iflags.wc_ascii_map)) {
      /* When the cursor is in the map window, its colour is
       * set by the player's health, like in the Qt version:
       * unless we're using an ASCII map, in which case you get a
       * black cursor which is easy to see. */
      if (u.mtimedone) {
          hp100=u.mhmax ? u.mh*100/u.mhmax : 100;
      } else {
          hp100=u.uhpmax ? u.uhp*100/u.uhpmax : 100;
      }
      if (hp100 > 75) danger = 4;
      else if (hp100 > 50) danger = 3;
      else if (hp100 > 25) danger = 2;
      else if (hp100 > 10) danger = 1;
      else if (hp100 > 0) danger = 0;
  }
  if (danger != old_danger) {
    printf("\e[%dy", danger);
    old_danger = danger;
  }
}

void
vtiles_put_glyph(glyph, special)
    int glyph;
    int special;
{
    int i, n = glyph2tile[glyph];
    int flag = ((special & MG_PET) ? 1 : 0);

    putchar(flag | 0x1c);
    for (i = 0; i < 2; i++) {
      int out = ((n >> ((1 - i) * 6)) & 0x3f);
      if (out < 0x30) {
        out |= 0x40;
      }
      putchar(out);
    }
}
#endif

