Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29134CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0FD042F99;
	Thu, 11 Jun 2026 17:50:11 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id A6E8940677
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:50:10 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so84436955e9.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781193010; x=1781797810; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=shhjkLtXUcKumOx4Oi8o0jtB32vpLSUb34S0qLxZmZo=;
 b=eFRBRGl74u9r28MvPli3SqPgDzKQ8Tkv2FBLMCZryFs1URNwKzVsBPbQL74i+rrsQg
 pFSpa91RzosA2CHDS7M2gFTnTaOIebcy/ZykIHY2l37bXn33BInkHu0DzrK83k2xmORq
 C8K4M9+f72B7Wybo44vERTvgb0q79m3omM6rAYm7PQYOhrAG9GBfbFPfAxul4iGuYWQv
 /Bjr2v05AjLeLhrVurvhaoLe/gmTrnYvff963ioTuGqcuhpo8XPqIeU6ObW5NUl5Ifou
 GOeXyRSvCRVIwN0BVZzcdJpuivmXSaSPTcTob4IifUDlrAop9UR45BerJY0oyBGzAUxQ
 wx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193010; x=1781797810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shhjkLtXUcKumOx4Oi8o0jtB32vpLSUb34S0qLxZmZo=;
 b=Ue/dTQeH2AKUMqTZNIrwgBPhMdX+C1MaDZJaEF5/ux5L83QPM42NAzoVkdnZtk15Kp
 Kqk1VPKHrzW5s1rA9grjrc+zLInLCHZ31ctaKcCgjz1Wod3s0xU9NpPxgxukkdMRa4W/
 OVJgcUSUmTlCa45kM3UTdE1CU+PO7WjyfBTDAN99Kg3VjyrzbFrQCu2FP9Bmpwoo7gVN
 Z0OZOzALHZFNBhx9i0uQn5pyRHkA1My1LPppxeEiTpVvVLgH8qTI/jZZbtSLRemkxkmm
 jkSxy2j3Hddm/HrlS2Dv8WQT0KhlypuRSmGLnLAfZVEAVqQIMCPWUn+heoex2f3Qlg1g
 HSfA==
X-Gm-Message-State: AOJu0YyAOcCfcEKzge3dUSx9NjrlwZi5bPa9UyWHpijNIqR1xIvX3b5Q
 lzWjf2SjTOI+7UZp3KehnUbglv4z6/SdAbtQCBjhzjEZMDH7tSDmvhDxBQmVCw==
X-Gm-Gg: Acq92OF/m7M3pO9pfxAV1DX7iMz9qi/UEoTyPgFP90YPtINUinzMUjbHNazD/BPIxKS
 9f0uT2S+Ht7wt2pW7O8GWyX06r6K4U8ijc2jWNubRcrif7euNjiRrdXh52mvPcE1o7u2KivJS0Y
 GvZV7DOlo4dOlr09TA9tqkc3Zxup78dRYcGueWP8nTJfwcpSAeIUm/XgQDLzytrCsKSvJr6XaQ5
 vv+qyBCBxnlglssX/3FhI/Q0LlGNOk3wYiC99acyi93jySjoOWjvoxOLW99UUTDYENHAd77Y3J9
 ITsLvTcg8CW81FU8zqHzEIrw2qq+8oDEO5x+7vsp2aBgeQHZmrQSlEEgGMlC7aIUN8XTzXyELX0
 uCwq8tsfjswSvkaTNXjxrsj22WHkr0djcLK1RUdu1c3P4z/oAmVwO6t9fmFGUpEV7rRmHH8rez6
 BOcWwshd9WvGAahvx6nMXVBOwMs5Q7Y76fm2syawaJrDcKzvtkNiJUivzIRZsiW3A=
X-Received: by 2002:a05:600c:3511:b0:490:b99c:9337 with SMTP id
 5b1f17b1804b1-490e55d6e5amr48032335e9.10.1781193009888; 
 Thu, 11 Jun 2026 08:50:09 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d0475asm119556315e9.12.2026.06.11.08.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:50:09 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com,
	sachin.saxena@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 0/9] net/dpaa2: NAPI-style Rx queue interrupts
Date: Thu, 11 Jun 2026 17:49:15 +0200
Message-ID: <20260611154926.392670-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
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
set_queue. One portal serves every queue a worker owns, so the DQRR
burst demuxes frames to their FQ by fqd_ctx; foreign frames are parked in
the target queue's stash, so the application polls all its queues after a
wakeup, the same scheduling contract as plain DPDK polling. A queue can
be re-homed to another lcore at runtime with no set_queue and no port
stop.

This reuses the event PMD's pushed/DQRR model but with one DPCON per FQ
and static affinity (no QBMan scheduling), so the DPCON allocator is
moved from the event driver to the fslmc bus and shared.

Patches 3 to 6 build the interrupt support proper, on top of three bug
fixes the path depends on and which it uncovered: patch 2 (eal, the
shared portal eventfd must not fail with -EEXIST), patch 7 (rx_queue_count
NULL on the primary process) and patch 8 (fast-path ops NULL after port
stop). They are real fixes, tagged for stable and backportable on their
own. Patches 1 (RSS RETA) and 9 (drop the software VLAN strip) are
independent net/dpaa2 changes the interrupt path does not require.

Tested on LX2160A (lx2160acex7).

Maxime Leroy (9):
  net/dpaa2: implement RSS RETA query and update
  eal/interrupts: keep real errno on epoll error
  bus/fslmc: move DPCON management from event driver to bus
  bus/fslmc/dpio: make the portal DQRI epoll optional
  net/dpaa2: support Rx queue interrupts
  bus/fslmc/dpio: tune DQRI interrupt coalescing holdoff
  net/dpaa2: fix Rx queue count for primary process
  ethdev: keep fast-path ops valid after port stop
  net/dpaa2: drop the fake software VLAN strip offload

 doc/guides/nics/dpaa2.rst                     |  10 +
 doc/guides/nics/features/dpaa2.ini            |   2 +
 doc/guides/rel_notes/release_26_07.rst        |   8 +
 drivers/bus/fslmc/meson.build                 |   1 +
 .../fslmc/portal}/dpaa2_hw_dpcon.c            |  16 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 113 +++-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |  12 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  35 +-
 .../fslmc/qbman/include/fsl_qbman_portal.h    |   9 +
 drivers/bus/fslmc/qbman/qbman_portal.c        |   7 +
 drivers/event/dpaa2/dpaa2_eventdev.h          |   5 +-
 drivers/event/dpaa2/meson.build               |   1 -
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |  34 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              | 556 +++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h              |  19 +
 drivers/net/dpaa2/dpaa2_rxtx.c                | 123 +++-
 lib/eal/include/rte_epoll.h                   |   3 +-
 lib/eal/linux/eal_interrupts.c                |  18 +-
 lib/ethdev/ethdev_private.c                   |   7 +
 19 files changed, 908 insertions(+), 71 deletions(-)
 rename drivers/{event/dpaa2 => bus/fslmc/portal}/dpaa2_hw_dpcon.c (90%)

-- 
2.43.0

