Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C12C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4F6840611;
	Fri, 10 Jul 2026 23:09:26 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 7AB514060B
 for <dev@dpdk.org>; Fri, 10 Jul 2026 23:09:25 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso10646525e9.1
 for <dev@dpdk.org>; Fri, 10 Jul 2026 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783717764; x=1784322564; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GQaOS+VgMFac++fdvL3APFqmS9+N15Fqdvlp9kWviCw=;
 b=oEVioQNnG6Bmt/uAAO+rQzX5B2VUZnOhsHjYAAD3aP/HGiHm4wtDCm0XU9QGyp3zHE
 b373ERo1tE3gg2q5C2R+3zqd6CJ6d83n7QWoDWKcq6pcKfzNAyCRiSvJKJZQQ9ViGvwU
 Ikmo+oqD2njZ2XxmsfAo4gf7iOttRPiTFK7nJXnxDjzLncphxRaK5RphwXo4QROv6Fe8
 UT8bd8e17HUK0u7I1lM6GmRvM9zD2zABl+8TyGcJbUo9nCNFNO3aXeneILIjM8BgI3IM
 LYD5zf9n17tZ4ot6esOgd4x2DgCAZL4kwFYzXLcwJrtH/yur6+Js7lcc0y9ExoOZyu5x
 fSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717764; x=1784322564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GQaOS+VgMFac++fdvL3APFqmS9+N15Fqdvlp9kWviCw=;
 b=FAITjE5jE/mMCEYMJl8DcwZujVOKh7PdPnuW7yJOV4rFKpcyCCpCg8sS+MHAPdTIv1
 u664AnVnrwwOxursEf4gdSwj5mRgHvUCJoctsfeUWKzli7YozHadC42dPNCVcwAtrBUq
 JUlqmfASM0Y6e+NMF698WV6Xdh2YTzRRuOaerF+um71u8vKw5d8Bb1dyGnQkOQKrRSE3
 s66UVDcldjwWaYKkJfiiq0xrPmJxU6jfB22spwAfkQ+icZxBd7srE+sFcIe3mNVDRvR1
 J68Cnjaz0gqv5Gk//6YiDDS6jW0DXNDHw4fvCL0wXHtnk6dTGaHmXRfMjR3RzIVvJ37O
 BKqA==
X-Gm-Message-State: AOJu0Yw/gLtuLpzJ7Ad+bGUN1HpoBRqigfG/20Av5KTEcnHWur+i4kEs
 e7oGhtaM1fYpHIQjKtxLWZNmqYfZ8wDPoeoTtx3QGWCfEvccvtg64XVSr/YAidBV
X-Gm-Gg: AfdE7cm1NGpB+45mLRmNmkjqlf8xZzFi5vc3xEI9Zt8OuLYj+qpPz2jcsbencVmT4Ww
 E7c2es2CnXOUtlYz4LSDNz6npNca5UPQBhUB+BmNDJOLaNYCBztYquqLzfVYlz6jUQBw+B1htpp
 olG8o3bPH2+UXtOzOA7awPFzyQ93S2Nms0/AM/ePFfj94vrxh1gjEYeCy1ecYIEdUDCZbrCJRLO
 WJ381mdjGuGwE2y9PQRBc6ZwE3D0wFXxBE2lo9+RWnlBJGjY4JMIxcXfzBPHFK87bNBfSme87z7
 fahYB1Yy1xMW0t0eN+I21PXmZ/mqqbEmKpfV3I7kwtElQFEPgtSlKIrFT0+Ou9DoVyGxFctIatQ
 Rt5swSP0IBqsCXvGdWPdt/e6gLTh/oMOW7BLQK/KUjg4fRMn0m/C/bfiXLDHO1WW7tVzqDOTzuD
 QX+0LUGA==
X-Received: by 2002:a05:600c:e548:10b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-493f881d146mr2657255e9.21.1783717764214; 
 Fri, 10 Jul 2026 14:09:24 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:a821:a41b:93f0:2def])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2a2e499sm95309755e9.0.2026.07.10.14.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:09:23 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 0/6] net/dpaa2: NAPI-style Rx queue interrupts
Date: Fri, 10 Jul 2026 23:09:14 +0200
Message-ID: <20260710210920.2402309-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630144329.457643-1-maxime@leroys.fr>
References: <20260630144329.457643-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series lets a dpaa2 worker sleep on a queue's data-availability
notification instead of busy-polling, exposed through the generic
rte_eth_dev_rx_intr_* API (NAPI-style: poll while frames keep coming,
arm the interrupt and sleep when the queue runs dry).

Why it is not a trivial .rx_queue_intr_enable
----------------------------------------------
A worker wakes on its software portal's DQRI, which fires when the
portal's DQRR holds frames. The default dpaa2 Rx burst pulls frames
from the FQ with a volatile dequeue and cannot be interrupt-driven; to
wake on the DQRI the FQ must instead be pushed to the portal's DQRR.

The natural dpni_set_queue with a notification destination would have to
target the worker's portal, but that portal is only known once a worker
affines, after dev_start, and that MC command holds the global MC lock
long enough to wedge the firmware while traffic runs. So the bind cannot
be done late, against the polling lcore.

Design
------
Each Rx FQ is bound to its own DPCON channel, statically, at
rx_queue_setup while the dpni is still disabled (no knowledge of the
polling lcore). It stays scheduled to that channel for the life of the
port and is never re-bound, because the MC refuses to move a scheduled
FQ back to parked at runtime; a queue-count reconfigure (stop, configure,
setup, start) is therefore supported without a port close. A worker later
subscribes its own ethrx portal to the channel and arms the DQRI in
rx_queue_intr_enable, a one-shot per-portal op, never the wedging
set_queue. On a wakeup the worker drains each of its queues by a volatile
dequeue on the queue's own DPCON channel (one FQ per channel, so no
per-frame demux); it polls all its queues, the same scheduling contract
as plain DPDK polling. A queue can be re-homed to another lcore at
runtime with no set_queue and no port stop.

This reuses the event PMD's pushed/DQRR model but with one DPCON per FQ
and static affinity (no QBMan scheduling), so the DPCON allocator is
moved from the event driver to the fslmc bus and shared.

Patch 1 fixes an existing dpaa2 bug the interrupt path relies on: the
rx_queue_count callback was wired only for the secondary process, so the
generic arm-then-verify (rte_eth_rx_queue_count) misbehaves on a primary
process. Patches 2 to 4 move the DPCON allocator to the fslmc bus, make
the portal DQRI epoll optional, and add the DPCON set-notification MC
command. Patch 5 adds the interrupt support proper; patch 6 pins each
DPIO's MSI to the lcore that arms it, a latency optimisation.

Tested on LX2160A (lx2160acex7).

v4:
- Addressed Hemant's v3 review:
  - Dropped the "event/dpaa2: disable channel before closing it" patch.
    Pooled DPAA2 objects reprogram on borrow (the sibling DPCI close has
    no dpci_disable either), so an enabled DPCON returned to the pool is
    inert; the patch was an unnecessary outlier.
  - Allocate the rx-interrupt handle once and keep it, instead of calling
    rte_intr_vec_list_alloc() again on the existing handle at a second
    dev_configure (which leaked the vector list and could size-mismatch).
  - Store napi_sub_dpio with rte_atomic_store_explicit() at rx_queue_setup
    instead of a plain assignment, for weakly-ordered architectures.
- Re-added the "fix Rx queue count for primary process" patch (patch 1).
  v3 dropped it as applied to main, but only the ethdev dummy/keep-fast-
  path fixes are upstream; the dpaa2 primary-process wiring is not, and
  rte_eth_rx_queue_count returns 0 (defeating arm-then-verify) without it.
- Made the Rx queue count changeable at runtime in interrupt mode: the FQ
  is scheduled to its DPCON once, at rx_queue_setup, and never re-bound
  (the handle kept above lets the application's rx-intr epoll registration
  stay valid across a reconfigure). Switching the interrupt mode on or off
  is refused after the first configure.
- Advertise the supported packet types in interrupt mode too:
  dpaa2_supported_ptypes_get returned NULL for the channel Rx bursts
  (dpaa2_dev_rx_channel, dpaa2_dev_prefetch_rx_channel), so an application
  saw no ptypes although they are parsed; the bursts are now recognised.
- Documented the arm-before-register contract (the interrupt fd is bound
  at arm time) in doc/guides/nics/dpaa2.rst.
- Rebased on next-net/for-main (v3 was on an older main snapshot).
- Reworded the DPCON set-notification headline to drop the underscore.

v3:
- Reworked the Rx drain. Both versions bind one DPCON per FQ, but v2
  drained the shared portal DQRR and demuxed frames to their FQ by
  fqd_ctx, stashing foreign frames in a per-queue FIFO. v3 drains each
  queue with a volatile dequeue on its own channel (one FQ per channel),
  which drops the demux and stash code.
- Dropped the rx_queue_count fix; it is applied to main.
- Dropped the software VLAN strip patch; an independent net/dpaa2 cleanup,
  sent standalone and now applied to next-net.
- Dropped the Depends-on: the ethdev fast-path ops fix is now in main.
- Split the dpcon_set_notification MC command into its own patch.
- Added an event/dpaa2 fix to disable the DPCON channel before close,
  needed once the allocator is shared.
- Dropped the DQRI holdoff-tuning patch; the immediate-DQRI holdoff is now
  set inline in the arm path.
- Added a patch reusing the event driver's MSI-affinity helper (exposed
  from its RTE_EVENT_DPAA2 guard) to pin the portal MSI to the lcore that
  arms it, so a CDAN wake lands on the worker's own core.

v2:
- Dropped the RSS RETA patch, an independent net/dpaa2 change the
  interrupt path does not require; it will be sent as its own series.
- Dropped the ethdev fast-path ops fix; it is now a standalone series.
- Dropped the eal/interrupts -EEXIST fix, applied to main by David
  Marchand.
- Declared qbman_swp_interrupt_set_inhibit and qbman_swp_dqrr_size
  __rte_internal (David Marchand).
- Minor formatting cleanup in the Rx interrupt setup.

Maxime Leroy (6):
  net/dpaa2: fix Rx queue count for primary process
  bus/fslmc: move DPCON management from event driver to bus
  bus/fslmc/dpio: make the portal DQRI epoll optional
  bus/fslmc/mc: implement DPCON set notification
  net/dpaa2: support Rx queue interrupts
  net/dpaa2: pin Rx queue interrupt to the polling core

 doc/guides/nics/dpaa2.rst                     |  28 ++
 doc/guides/nics/features/dpaa2.ini            |   1 +
 doc/guides/rel_notes/release_26_07.rst        |   1 +
 drivers/bus/fslmc/mc/dpcon.c                  |  31 ++
 drivers/bus/fslmc/mc/fsl_dpcon.h              |  18 +
 drivers/bus/fslmc/meson.build                 |   1 +
 .../fslmc/portal}/dpaa2_hw_dpcon.c            |  16 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 125 ++++--
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |  12 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  15 +
 .../fslmc/qbman/include/fsl_qbman_portal.h    |   5 +
 drivers/bus/fslmc/qbman/qbman_portal.c        |   5 +
 drivers/event/dpaa2/dpaa2_eventdev.h          |   3 -
 drivers/event/dpaa2/meson.build               |   1 -
 drivers/net/dpaa2/dpaa2_ethdev.c              | 414 +++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h              |   7 +
 drivers/net/dpaa2/dpaa2_rxtx.c                | 114 ++++-
 17 files changed, 725 insertions(+), 72 deletions(-)
 rename drivers/{event/dpaa2 => bus/fslmc/portal}/dpaa2_hw_dpcon.c (90%)

-- 
2.43.0

