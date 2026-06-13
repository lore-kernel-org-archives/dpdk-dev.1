Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3FCD98C5
	for <dpdk-dev@archiver.kernel.org>; Sat, 13 Jun 2026 04:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA2C2435BF;
	Sat, 13 Jun 2026 06:23:24 +0200 (CEST)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mails.dpdk.org (Postfix) with ESMTP id DBC1340264
 for <dev@dpdk.org>; Sat, 13 Jun 2026 06:23:23 +0200 (CEST)
Received: by mail-qk1-f201.google.com with SMTP id
 af79cd13be357-9157de5360fso506016985a.0
 for <dev@dpdk.org>; Fri, 12 Jun 2026 21:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781324603; x=1781929403; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=A/CwQGf+3SPM+TDT+vkX9RMIQN0+70J0PsB6OeHzB/U=;
 b=OCYALunFPWi8cvM8LUHaNlcjVhAb0RliGZsKvm1+AiY+16b1YhWbY1s3HlTGUNN6fp
 XwAivKwoDKpC6M8Alud/13DMspHZ+8VtEUvk6wnktz+xmVVsKaV/74Z/emUvkDd8rr//
 uilo5G6IBVF2gJ+s2vOLHpy1QRhd/1febfT0hTzQzNLGoASDSpBL2aKWyCHIau4fZ6YR
 GNNAD7//tDgttGhLlTCgFHUZjDOaSMSIfmjrEh+p7KWlcY4PQmGLiZ2wpSQ9wiBdDfD5
 gMVDO8ExcsOh3gzk6toGvG/FDlfvTZ9qo9OLUCznWWKDCiI3Ycy/hYmVrLQZICHf+k4t
 lElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781324603; x=1781929403;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A/CwQGf+3SPM+TDT+vkX9RMIQN0+70J0PsB6OeHzB/U=;
 b=mYyTIwKKoQt970ZdFupQ6Fe1QwI4/4R7TLj8sebuBQFU1SurNpl41Ojph1tIKhlfKa
 Hp9tDp4NzAULZeB0DQCLnMr4Q2CzHTSIxsn3G0522DSMW1dN28TSb8Mo0ixhTVBQFQO3
 SQ37ZxghyMjvWNAembfD1H4pWiR3xNrPrPSpy9C1ETGtXv+qiA+3bAtvZMAlD+4xi+VL
 XIfL/6eA4MQsU+q6odgIr1BE6aYPBjIrNCq1LwFffkpJQquErZeKN2dpgaWG5qvo06Ok
 irPQ960NFQAZeYWHJzpfQF+FXtZTT53M/8Tppvxk79O/Oze8GBubUMvsNfHnlq1Pey8S
 PwTA==
X-Gm-Message-State: AOJu0YxxP7vFyaOUQOkSINd1SmuyxjSYrkKtXL9rSpLjitlsQfoKslgJ
 TqfOS2Tdv7kzCj8bm3P+SxjDo8NHI/j2GcuUSaibYVRRrwuvz26QQfhRwAlee2PF4jjLmAylpMs
 p4JLs1Q==
X-Received: from qkk50.prod.google.com ([2002:a05:620a:9632:b0:915:80a4:bb24])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2948:b0:90f:47f6:832f
 with SMTP id af79cd13be357-91619f395b3mr831774485a.33.1781324602807; Fri, 12
 Jun 2026 21:23:22 -0700 (PDT)
Date: Sat, 13 Jun 2026 04:22:33 +0000
In-Reply-To: <20260605213022.2770893-1-blasko@google.com>
Mime-Version: 1.0
References: <20260605213022.2770893-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613042300.3760470-1-blasko@google.com>
Subject: [PATCH v4 0/6] net/gve: add hardware timestamping support
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com, 
 blasko@google.com
Content-Type: text/plain; charset="UTF-8"
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

This patch series introduces support for GVE hardware timestamping
on DQO queues. To support concurrent access, a mutex lock is introduced
to protect admin queue operations. A mechanism is then added to
periodically synchronize the NIC clock via a dedicated control thread,
and support is introduced for the read_clock ethdev operation.
Finally, the RX datapath is updated to reconstruct full 64-bit
timestamps from the 32-bit values in DQO descriptors.

---
v4:
- Patch 4: Offload periodic NIC clock reads to a dedicated control thread.
- Patch 5: Correct mutex initialization and teardown ordering.
- Patch 6: Update GVE documentation to clarify queue format requirements.

v3:
- Patch 5:
  - Add mutex lock to protect shared NIC timestamp memzone access.
  - Fix missing read_clock assignment to DQO queue ops table
    (accidental omission in v2).

v2:
- Patch 1: Dropped ROBUST mutex attribute.
- Patch 3: Added adminq timestamp counter reset to gve_adminq_alloc.
- Patch 4:
  - Removed redundant void* casts.
  - Handled alarm reschedule failures by marking timestamp stale.
  - Added transient error logging on memzone allocation failure.
- Patch 5: Scoped read_clock ethdev operation strictly to DQO queues.
- Patch 6:
  - Scoped timestamp offload capability advertisement strictly to
    DQO queues.
  - Predicated capability advertisement directly on memzone
    allocation.
  - Initialized mbuf_timestamp_offset to -1.
  - Added blank line separating release notes.
---

Mark Blasko (6):
  net/gve: add thread safety to admin queue
  net/gve: add device option support for HW timestamps
  net/gve: add AdminQ command for NIC timestamps
  net/gve: add periodic NIC clock synchronization
  net/gve: support read clock ethdev op
  net/gve: reconstruct HW timestamps from DQO

 .mailmap                               |   1 +
 doc/guides/nics/features/gve.ini       |   1 +
 doc/guides/nics/gve.rst                |  20 +++
 doc/guides/rel_notes/release_26_07.rst |   4 +
 drivers/net/gve/base/gve_adminq.c      | 128 +++++++++++++---
 drivers/net/gve/base/gve_adminq.h      |  29 ++++
 drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
 drivers/net/gve/gve_ethdev.c           | 194 +++++++++++++++++++++++--
 drivers/net/gve/gve_ethdev.h           |  43 ++++++
 drivers/net/gve/gve_rx_dqo.c           |  26 ++++
 10 files changed, 424 insertions(+), 30 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog

