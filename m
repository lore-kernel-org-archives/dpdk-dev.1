Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB1CD98D2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 00:07:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39B4B40276;
	Wed, 17 Jun 2026 02:07:18 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id 3B2E34026A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 02:07:17 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8ce9df49c6bso64082746d6.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781654836; x=1782259636; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gnu2dMrC8XKzDL+Y2gDSWEQcaE5qyNWN2jCrKGQ45AE=;
 b=HsFp6hGh/7MG2fru3eKZ/Km06+AYfAtBX6EeXAPIqQBjimLBJVFSzrYHcvzIaTzV/1
 +wGbZURXEYVbbYa9hPuTU2tBZPOe80PrZLV4MYQ3jDlWkmXxN0NZIPa7H3TlWwT1+k33
 eSHU6IgU3vDiSimKZVHgtu7fJo7k4ysLbKxXd8k0r76rMpXrwamjXBLIpBiakTZm1g9P
 zNLzilxzmdSYFzQwH95jwmyc3IcCdEm+QvlkYnB55+rXHaMxYLP/vqwc+S6kBHdaPh+U
 duIu4JvNx+RlA1x2JBmUj0xk0uz0jLHpSKtCvcwbr5jgi9gcvHtTStPbM6OdQbTvYKpU
 ILKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654836; x=1782259636;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gnu2dMrC8XKzDL+Y2gDSWEQcaE5qyNWN2jCrKGQ45AE=;
 b=PNBfuzGuQ1grpYpDMBwR2iL/1EWLGLZVXOo4jK7mgvTINghSba+9Kcl3/aObztG0Zf
 RDU/ohC1vNiiuun22Ybw1cM+BGFljty5O6mFgg6h9qMF6lqAh9fYIiyj7JP1Gloth43X
 qmFpF0bdkU1+t0t3654zdVrXdjh7bFICK7h2Euc6opoYfan3d3Rk+OGr9KpPh0M/3rm8
 P/oN/0HwV/qvT6HRMw6ZJxOKWZQ0U1VWTwcP4AGGdeVm6H66dNkxgy8ez02xDmXgDy+m
 RU5fPcqcWHG7Mm+lzCjN1dvZYKPxhODJzmXKWy/9LP7M+49vxRrIx7rvw8kPEy7e3RhZ
 yJQg==
X-Gm-Message-State: AOJu0Yzxjfk64cj8bSbwlZeHVNnrydb9e0FIjPAdR/IIUsY67pxBDmV0
 ybgoPhsMtwRh5ShzZvNymDZpv+nTWP/Ykpbio+g7fuSZiVIOiQ6lENMgQaNtAjIEJsp2mtxXLdY
 +lM4ENQ==
X-Received: from qtlj12.prod.google.com ([2002:ac8:404c:0:b0:517:697f:f2b2])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1b0f:b0:50d:9f02:86c7
 with SMTP id d75a77b69052e-519a8df13c0mr30129171cf.13.1781654836151; Tue, 16
 Jun 2026 17:07:16 -0700 (PDT)
Date: Wed, 17 Jun 2026 00:07:04 +0000
In-Reply-To: <20260613042300.3760470-1-blasko@google.com>
Mime-Version: 1.0
References: <20260613042300.3760470-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260617000712.2195506-1-blasko@google.com>
Subject: [PATCH v5 0/6] net/gve: add hardware timestamping support
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
v5:
- Patch 4: Reword commit message to describe control thread implementation.

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
2.54.0.1189.g8c84645362-goog

