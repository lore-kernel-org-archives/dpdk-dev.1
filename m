Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68344CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:27:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53CB040289;
	Tue, 16 Jun 2026 12:27:40 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 296274026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:27:39 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso33667505e9.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781605658; x=1782210458; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kW+nocENqKhXFopoa7U9LerV3SjIVAL1h/nklZyZK+4=;
 b=FBLV4D90y89DmRIjw8dt3Z+jQ6USVYSoyYsgNl43YeOAwLABF+CnWTzC00qIYduPH2
 twha1YesNzR0UMG4KUIZAexTPhoyQglWOD4gjv1eiTg9Tb/Vqxlj6ewbdySQ7SQ7EtQh
 GwHsPjt0VUc3KyZubhkv2iqZ0wxKFp8NbRAfTAltDGj69wqiEV3iSAxOn8WqwhpDbNDh
 DzO9E4aov2moxO4/cjtzRcOojSCHh+JSBtGotTPSOcLDDNCo7fKA1BVAyjV7siEh3fjX
 gZnCmtpYzZa6UVimZXC7DpaNlcxm90uRy3StUU/eMTAZvQNNtGkoQloIhpF3qg9Bdbj5
 WRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605658; x=1782210458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kW+nocENqKhXFopoa7U9LerV3SjIVAL1h/nklZyZK+4=;
 b=DG+oaFaaTZzaydzGJTaeH2Xy4PLmX/qUS2PDro5HTaDwJ23neN5NsKLs3rR+X4FZV8
 ka9tGrxopdlHGJmhv1xpPpsVZCg/nqgXI/R8dtRAwuuJIehXAs/n8JdU4jzAjpwt78YE
 kUrZLehzsemO8h924dmRLpA9BDPfR4PZPfdcJqezVEN4JemdCbEjn8SwfKKjNsq6BT9+
 mrFgcvqL6gI+toTfMWo7ixNZpTwmaHSotwcsqt9fNbF5tBt84+tizP32RjcrsEytzidv
 3n/jOnltvH3ulYGQjlYtVaDzpt1ox/m1svXTcDbwBzPGz5udY7kX35EVvQZebTq8uTD1
 e5/w==
X-Gm-Message-State: AOJu0YzJV+UElvybviNc/ukjHECYVi1ElO9HKfLPK+SJ/LiBt6+H5FXd
 ABrWdzVZW1ubQVaK8OcoqZAvC1e9gOhx34LaDMoJQNDclZEx0ZjPnVKT9zjILAoh
X-Gm-Gg: Acq92OETIYcT0kLNB3lj+M63Ftg7/nxC5bM+kr3DsCO6s9Op2cgy297hxn7HXKaHV7z
 6yt5F07iTfJt3jAAqShwTLjcbRmFgTeh2Ko055TagCvLUWHgI4W2x6N3QDfcCTnT6IlpWxPy3Q5
 vQxn+7Vp00wLObDwChCvCAbgQPfodN86koGGe/F4pr89/lL4zNR1SjJgr45U2KwWjNdLcCYdKIZ
 /evPauPq2u5qarTs4KnNA8BeMDP7HzEKPzTeklczBc6JrmukGcKliDR0151EiUVk4ma4qaW45x5
 GgNpKrxN6tVBAKFtMch5vx5ldu0u/n7gB7GbMCcZV2HLRQ2y75ZokKwUu9HDBVr420GxBUzGjRy
 1Dhsjcq2j7Jj7xcS1FPemMmyEQzNUe0SKedVONs4883iQWGpoZiikYjeuC0+ikxNlpDDzHmP8qm
 rSoWmf6jmMwduQKwpKRW2mM8gyP9HLSki2ALTVA/6lh/bACOTjgTY4
X-Received: by 2002:a05:600c:e557:20b0:490:c024:2eba with SMTP id
 5b1f17b1804b1-4922ff95f5dmr31754095e9.22.1781605658367; 
 Tue, 16 Jun 2026 03:27:38 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97227sm69182395e9.13.2026.06.16.03.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:27:37 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 0/6] net/dpaa2: NAPI-style Rx queue interrupts
Date: Tue, 16 Jun 2026 12:27:20 +0200
Message-ID: <20260616102727.708948-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611154926.392670-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
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

Patches 1 and 2 move the DPCON allocator to the fslmc bus and make the
portal DQRI epoll optional; patch 3 adds the interrupt support proper and
patch 4 tunes the DQRI coalescing holdoff. Patch 5 (rx_queue_count NULL on
the primary process) is a real fix the path depends on and uncovered,
tagged for stable and backportable on its own. Patch 6 (drop the software
VLAN strip) is an independent net/dpaa2 change the interrupt path does not
require.

The path also depends on two fixes sent separately: an eal change so the
shared portal eventfd does not fail with -EEXIST (already applied to main)
and the ethdev fix for fast-path ops left NULL after port stop (see
Depends-on below).

Tested on LX2160A (lx2160acex7).

Depends-on: series-38450 ("ethdev: fix fast-path ops on a stopped port")

v2:
- Dropped the RSS RETA patch, an independent net/dpaa2 change the
  interrupt path does not require; it will be sent as its own series.
- Dropped the ethdev fast-path ops fix; it is now a standalone series
  (Depends-on above).
- Dropped the eal/interrupts -EEXIST fix, applied to main by David Marchand.
- Declared qbman_swp_interrupt_set_inhibit and qbman_swp_dqrr_size
  __rte_internal (David Marchand).
- Minor formatting cleanup in the Rx interrupt setup.

Maxime Leroy (6):
  bus/fslmc: move DPCON management from event driver to bus
  bus/fslmc/dpio: make the portal DQRI epoll optional
  net/dpaa2: support Rx queue interrupts
  bus/fslmc/dpio: tune DQRI interrupt coalescing holdoff
  net/dpaa2: fix Rx queue count for primary process
  net/dpaa2: drop the fake software VLAN strip offload

 doc/guides/nics/dpaa2.rst                     |  10 +
 doc/guides/nics/features/dpaa2.ini            |   1 +
 doc/guides/rel_notes/release_26_07.rst        |   7 +
 drivers/bus/fslmc/meson.build                 |   1 +
 .../fslmc/portal}/dpaa2_hw_dpcon.c            |  16 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 113 ++++--
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |  12 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  35 +-
 .../fslmc/qbman/include/fsl_qbman_portal.h    |  11 +
 drivers/bus/fslmc/qbman/qbman_portal.c        |   7 +
 drivers/event/dpaa2/dpaa2_eventdev.h          |   5 +-
 drivers/event/dpaa2/meson.build               |   1 -
 drivers/net/dpaa2/dpaa2_ethdev.c              | 349 +++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h              |  10 +
 drivers/net/dpaa2/dpaa2_rxtx.c                | 123 +++++-
 15 files changed, 647 insertions(+), 54 deletions(-)
 rename drivers/{event/dpaa2 => bus/fslmc/portal}/dpaa2_hw_dpcon.c (90%)

-- 
2.43.0

