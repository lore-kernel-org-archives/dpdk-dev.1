Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6627EC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5834A4067B;
	Tue, 30 Jun 2026 16:43:37 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id BB06840655
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:43:35 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so5787505e9.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782830615; x=1783435415; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXX9TTHVKgAs576Ntxwcs11oPkCSS9SBo7Gb7Tu1xDg=;
 b=j9oydWRx83woXAEpxuekN4jlwUBxRHKgO53ld+K8Uxxi7FQ0oKS79j1W+SIBHhYLnU
 /C9mcF6rUNJgXsp0MhCdtj0fjJEfAGE86xn3fGjEeGc5AfvmgD2uopoXwqpxhYmzuO+C
 sQSghpruPWx9Hm1j/OHctcC2x3c6Szln3VjXw/9iOVU+bNrLxycX8rX7+GjoxG1+MqrD
 M2udDifkzn5/3kDWmbWzg2fLXL6ZWEDfU+NXUvIW9pdO4c7BXeRACKBbDvL7qXxo1P/F
 9Y3ySoHItt4VmLEHovfg4Ri/dGCMRQXDclossUIl2L7o+U1mdtrM5/UlkEMA6EyhQqIV
 nqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830615; x=1783435415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uXX9TTHVKgAs576Ntxwcs11oPkCSS9SBo7Gb7Tu1xDg=;
 b=hGHyngD3vFXZ3MgKRW0LLeJebeRfaAdZYt4RMNlN55SlYcDxxZhKnVchjh2CVSeXsW
 qU1J30hJvB3F0368DS/XGYBLixtZhCvUcYtytp5ELoIm5KztonMW/Lwg9stEZFCBJ7K+
 v4pP0TPXszaXsVgxNEW4TAfjsXYK5BoNERr+U6/mEmHr4+i7yMbuMJI5KIqKYdTFoNQU
 gzmb9fOYk5d4IjdH3Mpv2UV63IkxPwnSJjJjD/3LxQTtCKg+fQnktAcJkbD11yr8PSkD
 6d5Pfq58gNAo0X3kUvH1uEU59N7L2Sq3wqMOrG48plj8EljM1p4hVcjno0i9CXkyHjbS
 n83w==
X-Gm-Message-State: AOJu0YxWZQaIWLLuS+M12I537D2881DfD2VCpgrYSz2bYUaSTN3pgRiG
 YHzg1SqrEKyPEiMLQ4+vZBhWgtO7oRwvuks5RGatDevSP0axipFgJdxysaKgVSfR
X-Gm-Gg: AfdE7cny/9m4k22CJVioHHxQVPiMrM2f6PeUpefcKwxCt3A+js0bBKl/XA9qXmLzrBE
 BeNjaqFDHucUCoGlwGSjDI6BI60ZIPu9fkz2f7EzlfblJl9l0sR+dHUTari0yros4ctTehRZWMm
 J6xPGcZs1KViwZwZ/pdqUZmFBHr6hOyHhbz92eq00TV0feGdtGdH0FjoOIIJt7yBgXAwvRVF8Pn
 wHJuAAbr0AoweKuML+eemf9V8Ef8rZlqu52fX64Kpy8iR0jm8zbOtoeYKZykGknOc6vGNRhGNCb
 QtAy+KXbxtpw76Fu29Cbzjau19yUKnXDwBay4Zt+kLBQSIoVw9Gca1vfF38A/qQzWtxbxCBIJp8
 V1vkaLWqOgE3rkB7OJeBKDHQJUjpE0m5wjyDs1MJZ40Vp9mclR3dK2JfQoBwA2UaN+NpHMOMHki
 iSfFEU6XtFNABXPb9KRKod8L0E6wVCR3DYbuSILC/XCWXy
X-Received: by 2002:a05:600c:8a5:b0:493:a5f9:d341 with SMTP id
 5b1f17b1804b1-493b828b5c7mr41243535e9.15.1782830615013; 
 Tue, 30 Jun 2026 07:43:35 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be45f244sm1019705e9.0.2026.06.30.07.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:43:33 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, david.marchand@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 0/6] net/dpaa2: NAPI-style Rx queue interrupts
Date: Tue, 30 Jun 2026 16:43:23 +0200
Message-ID: <20260630144329.457643-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616102727.708948-1-maxime@leroys.fr>
References: <20260616102727.708948-1-maxime@leroys.fr>
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
Each Rx FQ is bound to its own DPCON channel, statically, at dev_start
while the dpni is still disabled (no knowledge of the polling lcore). A
worker later subscribes its own ethrx portal to the channel and arms the
DQRI in rx_queue_intr_enable, a one-shot per-portal op, never the wedging
set_queue. On a wakeup the worker drains each of its queues by a volatile
dequeue on the queue's own DPCON channel (one FQ per channel, so no
per-frame demux); it polls all its queues, the same scheduling contract
as plain DPDK polling. A queue can be re-homed to another lcore at
runtime with no set_queue and no port stop.

This reuses the event PMD's pushed/DQRR model but with one DPCON per FQ
and static affinity (no QBMan scheduling), so the DPCON allocator is
moved from the event driver to the fslmc bus and shared.

Patch 1 disables the DPCON channel before closing it, an event/dpaa2 fix
the shared allocator depends on. Patches 2 to 4 move the DPCON allocator
to the fslmc bus, make the portal DQRI epoll optional, and add the
dpcon_set_notification MC command. Patch 5 adds the interrupt support
proper; patch 6 pins each DPIO's MSI to the lcore that arms it, a latency
optimisation.

Tested on LX2160A (lx2160acex7).

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
  event/dpaa2: disable channel before closing it
  bus/fslmc: move DPCON management from event driver to bus
  bus/fslmc/dpio: make the portal DQRI epoll optional
  bus/fslmc/mc: implement dpcon_set_notification
  net/dpaa2: support Rx queue interrupts
  net/dpaa2: pin Rx queue interrupt to the polling core

 doc/guides/nics/dpaa2.rst                     |  21 +
 doc/guides/nics/features/dpaa2.ini            |   1 +
 doc/guides/rel_notes/release_26_07.rst        |   1 +
 drivers/bus/fslmc/mc/dpcon.c                  |  31 ++
 drivers/bus/fslmc/mc/fsl_dpcon.h              |  18 +
 drivers/bus/fslmc/meson.build                 |   1 +
 .../fslmc/portal}/dpaa2_hw_dpcon.c            |  17 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 112 ++++--
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |  12 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  12 +
 .../fslmc/qbman/include/fsl_qbman_portal.h    |   5 +
 drivers/bus/fslmc/qbman/qbman_portal.c        |   5 +
 drivers/event/dpaa2/dpaa2_eventdev.h          |   3 -
 drivers/event/dpaa2/meson.build               |   1 -
 drivers/net/dpaa2/dpaa2_ethdev.c              | 372 +++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h              |   4 +
 drivers/net/dpaa2/dpaa2_rxtx.c                | 104 +++--
 17 files changed, 649 insertions(+), 71 deletions(-)
 rename drivers/{event/dpaa2 => bus/fslmc/portal}/dpaa2_hw_dpcon.c (88%)


base-commit: 030328f5f920a87dabde54dacd4f5ac411ddcac9
-- 
2.43.0

