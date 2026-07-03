Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090AFC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 04:36:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF053402D4;
	Fri,  3 Jul 2026 06:36:55 +0200 (CEST)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52]) by mails.dpdk.org (Postfix) with ESMTP id 4882A402D1
 for <dev@dpdk.org>; Fri,  3 Jul 2026 06:36:54 +0200 (CEST)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-664ce3000e6so131037d50.0
 for <dev@dpdk.org>; Thu, 02 Jul 2026 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783053413;
 x=1783658213; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RR5G/eNKtv5xnNs8oHMSWhA+jKeZ8bNUFEtOTyylJQ=;
 b=MXPBAA6CK0gJ2HwMltICugFCKqDaYW1yhv3GrnWQCZsykjX5ZFTWeegWQKAgbR1KIM
 HcZoVdXpzlVBA8bJnWStYxjX5uo4ygoiqPaJkUeUgCwNsmw/ZSn5Bdbe/e9E9mlyjmXN
 C/J2F7RlW52FTlolGIv8+Netp/xveXGqp00wVegF6oBitVTsUB2YxvsXNAcwrVjTZlvK
 u02Iy1Y/PbyZMXN1ezfHzylP+wHQDYvfZs8wkQogF2YauUF2UpX/ecbY82BxUCaF/uVj
 rnTPhUpiO+8LPhl1jQPAa6EafI9nkmrMPIXQ05wHk/38yzYk0r4mSpx+GNaQAmQXsLIO
 B6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783053413; x=1783658213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5RR5G/eNKtv5xnNs8oHMSWhA+jKeZ8bNUFEtOTyylJQ=;
 b=SW9ZEM7cXB0MsRCR/FxvNLJB+6sqebOASLUFQRELJQrRF5PwEBur1VPSMQc+odiQTS
 fiBNggheONKdUmhW4n+Cs0CZY1Qam9S8EUv52Sd/1R/XF3We3yi9meYYKQOyRZVr1hm0
 1PDVd4aucHH9xVaJFoEwbaPqgeDXTPjhW7UhEbQuAXBaVj/9lagcRUQ3QCry+eVapQqV
 OkVAmNTvw5n5sczEUEr6lsYHmealTbVZV1c0a4zc3BUitYFZ1YTxbNg+vrZRCTb0U4HC
 uhFnwTUYAnHcmhUUq0cusUAkah+FZEBRzeTcUsoppNo+5BqJ+wfZUbTLkWUswbI87Pqn
 Q5Qw==
X-Gm-Message-State: AOJu0Yyi59B4SQEbHq028pYaRPk3KI7BaA0T2PSBM41TuaeRFtZrhe4f
 yuvF3mHvPfvzSef+0QkrrFzgrQVU3Gf6BTV1q7QBStuHJw7mehWZjf9I7CW7lf+6gxVmI+lzCK3
 dg9x7
X-Gm-Gg: AfdE7ckfd6/OgmnHwRLnPloAncQiy+E+f50cHnBWWBxGxhYDbitpC0zBK7Oagu+Ywoj
 +O3kCc4Z0YLd/e1sAtWvVwX9NSG1zryWWAgceR+HIvuMCT+h4MiidSPbxRVJfhietuYjaNVNNgJ
 crly8XuO+2r6F9dWi36fDAB4L9DA7usxKpwir6jtzOJM1uZAsZZ+hNVGBzzbCGCp/P8dn4RTQ2I
 nM2Sg1IClcud7aua/cReGQfRu9oLEu7s+8pKiTZKHvwPPTrj0J6NhOuSsfi9nLaJWTcTdXFms4E
 t9giSL25tjmoVGQfojzS2NyE2hcR7lOhQ2V1VAL9t9kU/usrTQnrFFcRoFPG76/na5wmNhFgX7b
 xFYOEkiR1J1kgUgwvVtP5ZWdq6Rb6YI89O2I7npJgmURIup/sxKRbjVl2Ezfk7/Ki2/ij3CPkY5
 8wwIRlOkmJ5RpWoFcj1/8AytTdZdu0GE/WZqlzQYI+Jn8owldRtudflQ==
X-Received: by 2002:a05:690e:4814:b0:664:ec3c:93e2 with SMTP id
 956f58d0204a3-66596576211mr5806613d50.41.1783053413229; 
 Thu, 02 Jul 2026 21:36:53 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-666401c8fe3sm302016d50.2.2026.07.02.21.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 21:36:52 -0700 (PDT)
Date: Thu, 2 Jul 2026 21:36:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/9] Stability fixes for GVE
Message-ID: <20260702213649.674d8b16@phoenix.local>
In-Reply-To: <CALuQH+XNRfWpd1zXm9GOe08h3z7DHb=FdV5jOnqGFP4Y5E8q=Q@mail.gmail.com>
References: <20260701183528.2443032-1-joshwash@google.com>
 <20260701115016.39c34f53@phoenix.local>
 <CALuQH+XNRfWpd1zXm9GOe08h3z7DHb=FdV5jOnqGFP4Y5E8q=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Wed, 1 Jul 2026 12:59:18 -0700
Joshua Washington <joshwash@google.com> wrote:

> On Wed, Jul 1, 2026 at 11:50=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Wed,  1 Jul 2026 11:35:18 -0700
> > Joshua Washington <joshwash@google.com> wrote:
> > =20
> > > This patch series consists of mostly unrelated fixes in the GVE drive=
r.
> > >
> > > Joshua Washington (9):
> > >   net/gve: clear out shared memory region for stats report
> > >   net/gve: delay adding mbuf head to software ring
> > >   net/gve: copy data to QPL buffer when mbuf read does not
> > >   net/gve: validate buf ID before processing Rx packet
> > >   net/gve: set mbuf to null in software ring after use
> > >   net/gve: free ctx mbuf if packet dropped after first segment
> > >   net/gve: increase range of DMA memzone ids to 64 bits
> > >   net/gve: don't reset ring size bounds to default on reset
> > >   net/gve: restrict max ring size in GQ QPL to 2K
> > >
> > >  drivers/net/gve/base/gve_adminq.c | 12 ++++++---
> > >  drivers/net/gve/base/gve_osdep.h  |  4 +--
> > >  drivers/net/gve/gve_ethdev.c      |  8 +++---
> > >  drivers/net/gve/gve_ethdev.h      |  1 +
> > >  drivers/net/gve/gve_rx.c          |  3 +++
> > >  drivers/net/gve/gve_rx_dqo.c      |  6 +++++
> > >  drivers/net/gve/gve_tx.c          | 42 +++++++++++++++++++----------=
--
> > >  7 files changed, 52 insertions(+), 24 deletions(-)
> > > =20
> >
> > *Build Failed #1:
> > OS: OpenAnolis8.10-64
> > Target: x86_64-native-linuxapp-gcc
> > FAILED: drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o
> > gcc -Idrivers/libtmp_rte_net_gve.a.p -Idrivers -I../drivers -Idrivers/n=
et/gve -I../drivers/net/gve -I../drivers/net/gve/base -Ilib/ethdev -I../lib=
/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config =
-Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal=
/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/l=
inux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib=
/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ili=
b/argparse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbu=
f -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../=
lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux=
 -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -fdiagnost=
ics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -We=
rror -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -W=
format -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissi=
ng-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsha=
dow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-=
not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dna=
tive -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-trunca=
tion -Wno-vla -DRTE_COMPONENT_CLASS=3Dpmd_net -DRTE_COMPONENT_NAME=3Dgve -D=
RTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.gve -MD -MQ drivers/libtmp_rte_net_gve.a.=
p/net_gve_gve_tx.c.o -MF drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o.=
d -o drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o -c ../drivers/net/gv=
e/gve_tx.c
> > ../drivers/net/gve/gve_tx.c: In function =E2=80=98gve_tx_burst_qpl=E2=
=80=99:
> > ../drivers/net/gve/gve_tx.c:258:21: error: variable =E2=80=98addr=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
> >   uint64_t ol_flags, addr, fifo_addr;
> >                      ^~~~
> > cc1: all warnings being treated as errors
> > [1640/3750] Compiling C object drivers/libtmp_rte_net_gve.a.p/net_gve_g=
ve_rx.c.o
> > [1641/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hin=
ic_base_hinic_pmd_cfg.c.o
> > [1642/3750] Compiling C object drivers/libtmp_rte_net_failsafe.a.p/net_=
failsafe_failsafe_ops.c.o
> > [1643/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hin=
ic_base_hinic_pmd_api_cmd.c.o
> > [1644/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hin=
ic_base_hinic_pmd_cmdq.c.o
> > [1645/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hin=
ic_hinic_pmd_rx.c.o
> > [1646/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hin=
ic_hinic_pmd_flow.c.o
> > [1647/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hin=
ic_hinic_pmd_ethdev.c.o
> > [1648/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hin=
ic_hinic_pmd_tx.c.o
> > ninja: build stopped =20
>=20
> Will fix in v2.

Here is AI review if it helps
Review of "net/gve" 9-patch series (bundle 1995)

Applied cleanly on top of 26.07-rc2 and built with
  meson -Dbuildtype=3Dminsize -Ddefault_library=3Dstatic -Dwerror=3Dtrue

The series is a solid set of datapath and reset-path bug fixes. One patch
breaks the build on its own, which blocks the series until fixed.


Patch 3/9 (net/gve: copy data to QPL buffer when mbuf read does not)

Error: build failure. Removing the two rte_memcpy() calls that consumed
'addr' leaves 'addr' set but never read, so the driver no longer compiles
under -Werror:

  gve_tx.c: In function 'gve_tx_burst_qpl':
  gve_tx.c:258:28: error: variable 'addr' set but not used
                          [-Werror=3Dunused-but-set-variable]

Both remaining assignments are now dead:

  addr =3D (uint64_t)(tx_pkt->buf_addr) + tx_pkt->data_off;
  ...
  addr =3D (uint64_t)(tx_pkt->buf_addr) + tx_pkt->data_off + hlen;

Drop 'addr' from the declaration and delete both assignments. This also
means each commit does not build independently, breaking git bisect.

The fix itself is correct: rte_pktmbuf_read() returns a pointer into the
mbuf when the range is contiguous and does not touch the destination, so
the guarded rte_memcpy() is needed for both the header and the TSO
payload copy.


Patch 9/9 (net/gve: restrict max ring size in GQ QPL to 2K)

Info: the new include uses quotes,

  #include "rte_common.h"

but every other DPDK header in this driver (including base/gve_osdep.h)
uses angle brackets. Prefer:

  #include <rte_common.h>

The GQ-QPL RTE_MIN() cap and the DQO override refactor are correct; the
initial device-value assignment that DQO overwrites is an intentional
default, not a dead store.


Patches 1, 2, 4, 5, 6, 7, 8: no issues found.

- 2/9: sw_ring record loop advances sw_id by nb_segs exactly as before;
  the added !tx_pkt guard is a safe bound.
- 4/9: buf_id bound check sits after the completion descriptor is
  consumed (rx_id / nb_rx_hold / generation advanced), so a bad id is
  dropped without stalling the ring.
- 5/9 + 6/9: nulling sw_ring after handing the mbuf to the application
  and freeing ctx->mbuf_head on drop are consistent - the head chain is
  removed from sw_ring before being freed, so no double free, and refill
  overwrites the slots with freshly allocated mbufs.

No Reviewed-by given: patch 3 does not build. Once the unused 'addr' is
removed I'm happy to ack the series.
