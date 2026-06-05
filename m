Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D11FCD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 21:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DB8D402DD;
	Fri,  5 Jun 2026 23:30:53 +0200 (CEST)
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com
 [209.85.217.73]) by mails.dpdk.org (Postfix) with ESMTP id 3D920402C4
 for <dev@dpdk.org>; Fri,  5 Jun 2026 23:30:52 +0200 (CEST)
Received: by mail-vs1-f73.google.com with SMTP id
 ada2fe7eead31-6798c46f723so1526688137.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780695051; x=1781299851; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=wcGMvB7NndrmDQV27iU6usNCnovLFcdK8LhE8Ct57xY=;
 b=KFfSwv0EgKhuHIhk2/rsdkxxN/0ycxs5cApF7dw247cdATZnUorW1I4x8e7NSygGjE
 qWlK3a3G7n1Fc99/zBM6xF0Euh6CRIyTqVZWavsvsnAWYD0qime5VSYoBySURjHbmbc8
 ekSf3wmphZNtdqhivj/QTVm3zzIOoQP+vl3foCi4s8O9Fglf/kepQ9XPUJpCkX2aw7Ig
 CdPQwSuw0GU5ZYzujwhIUdIy1dIgBrPb/sz3gfhcY/EpVENHPTbzPlgAZ8WI8E0KP51r
 5Mw4gowictoe2KwiCtMZ+v3NPxeyTNAcMqyRJvVev9ejsplXBL6jJTEO/0uKEhFqhi+e
 QbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780695051; x=1781299851;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wcGMvB7NndrmDQV27iU6usNCnovLFcdK8LhE8Ct57xY=;
 b=fFwmbJj78yzkaziIQKVtHn9CxhEb4lKsqCYbGkSJmkSFc0Z3YqN5lUwN+tBV+1ySqP
 ctjfdcCOHwWpV+cvJCd1If4L9wPUfO2FCotRcgWoavuoGi2fNcxkYgzdKJuqe6iuo4FM
 291Q9GO7yhRcmUSqeztvL3lNKV16V+G6tZXvhgswKRwyxM5WruaKrqanqKmQtvS2T1m8
 TO3SchTpdBsxCXRxkz/UaEeBWeJ8Q1L4SbJ00Ri4gTQ0nbzrYg32whWuXt6v/WwDdlS1
 ZAhYb7uiocLZa5TWiqOk841PwSgFw3U/w7rY7GqW/xukRAp0EKYtzqlAHuqYzNK9H8TP
 k/cQ==
X-Gm-Message-State: AOJu0Yxi7PaRttkTxLgjCK+r1cIlx3hJpARKZ8d+0nGTJPHYLYRRl0G5
 8cbSr5YeDc0Zfley/UlUf4qZrJEqMwlHayx14LDtoWr2KmC+8b8oD043l1Uvqy4GhJBXdojrXv5
 HQ9WMEA==
X-Received: from qvri9.prod.google.com ([2002:a0c:edc9:0:b0:8cc:e7ea:eb33])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5346:b0:6c2:e290:cc69
 with SMTP id ada2fe7eead31-6ff05e2d9ccmr3381079137.23.1780695051266; Fri, 05
 Jun 2026 14:30:51 -0700 (PDT)
Date: Fri,  5 Jun 2026 21:29:38 +0000
In-Reply-To: <20260515231936.3296603-1-blasko@google.com>
Mime-Version: 1.0
References: <20260515231936.3296603-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605213022.2770893-1-blasko@google.com>
Subject: [PATCH v3 0/6] net/gve: add hardware timestamping support
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

This patch series introduces support for GVE hardware timestamping on DQO
queues. To support concurrent access, a mutex lock is introduced to protect
admin queue operations. A mechanism is then added to periodically synchronize
the NIC clock via AdminQ, and support is introduced for the read_clock ethdev
operation. Finally, the RX datapath is updated to reconstruct full 64-bit
timestamps from the 32-bit values in DQO descriptors.

---
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
 doc/guides/nics/gve.rst                |  20 ++++
 doc/guides/rel_notes/release_26_07.rst |   4 +
 drivers/net/gve/base/gve_adminq.c      | 128 +++++++++++++++++---
 drivers/net/gve/base/gve_adminq.h      |  29 +++++
 drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
 drivers/net/gve/gve_ethdev.c           | 159 ++++++++++++++++++++++++-
 drivers/net/gve/gve_ethdev.h           |  40 +++++++
 drivers/net/gve/gve_rx_dqo.c           |  26 ++++
 10 files changed, 394 insertions(+), 22 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

