Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3619CD4851
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 23:19:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 942944026C;
	Sat, 16 May 2026 01:19:42 +0200 (CEST)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mails.dpdk.org (Postfix) with ESMTP id C1DDF40269
 for <dev@dpdk.org>; Sat, 16 May 2026 01:19:40 +0200 (CEST)
Received: by mail-qk1-f201.google.com with SMTP id
 af79cd13be357-90ffa709073so108252685a.1
 for <dev@dpdk.org>; Fri, 15 May 2026 16:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778887180; x=1779491980; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zdBc0QdlhDrEhovHqTRgpH5RftYd7mzBxI6fZOP87UI=;
 b=XYfmDt1pMfx+NYuPYAPCW0noR30cLxJIWq+5NzQ3RgSJBvBdxOl7e1N52TvmKY22E2
 9Bzv4+GuaFXJH64pJbkODSIH884tAxhddwNGwYXZg9fs5wjvIOzNDpBKI1r37fX3knk2
 N9sgdosgR/Bv1RUCgZJQKn/ua7jFmnERi+sYdRozSeyb3825kwOl6fIRAREfrW0YHRSH
 TtThvqhQPModZH94d+3szp9UovIFE9H2yB/92onT9GZQlm+LlsnnGNiCWgbB+gqt2q7/
 zQQR2TA/34HjhkV79GJ+DoBgQBMHEZQIdvit9CwbGRAv03oNXzSuliaY/K4lLZM8Jq9k
 ShWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778887180; x=1779491980;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zdBc0QdlhDrEhovHqTRgpH5RftYd7mzBxI6fZOP87UI=;
 b=gkL4SqTWUbV6QgPY5yW/EaXvOd3+fJgIaHIFWpQfKW5cQ1YgTQtbtKpVCOUoMu13L8
 2JwNFGiZpxIIbIfHbBhSQOWFOlYxxfl7gKwy3UPfLUTCVJlmInD1NLAWqQmP7pZRVT+P
 BiajmkVlJkm5/weBJTCSWAaWgt0/zpznh5ZOfYI6H6k08/TdGxEO6w7KcFhnNU+Z4ar4
 D0lheXjdRncDJ1/uFqWgBvhnBwTjv5/8L7SxDKezGDytNlMJj0X3u5WJCCk+Kl/oQElV
 bLwringiJE6IVXPNirrTdbkarUkaFwxnPESvnYjIuYgh07Oc2DfSPSVPhpMSzYGrqDcF
 OU7g==
X-Gm-Message-State: AOJu0YwmlfMZnr/+NK0ROQn9WPMB2P8v/3F7o23JOagWGdg27WZ1zL5S
 PJTuIyBd15jC51qzxnp2v2vqbZRX47LZkfQAsjpsAgt8g3RNNb3h9MB99blJBONd7rbNuCGjFi0
 iFBqEwA==
X-Received: from qkgt18.prod.google.com ([2002:a05:620a:b12:b0:90f:784c:22db])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28cb:b0:8ec:a621:a3aa
 with SMTP id af79cd13be357-911cce8e64fmr955088585a.2.1778887179764; Fri, 15
 May 2026 16:19:39 -0700 (PDT)
Date: Fri, 15 May 2026 23:19:29 +0000
In-Reply-To: <20260511224354.872997-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515231936.3296603-1-blasko@google.com>
Subject: [PATCH v2 0/6] net/gve: add hardware timestamping support
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>
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
 drivers/net/gve/base/gve_adminq.c      | 128 +++++++++++++++++----
 drivers/net/gve/base/gve_adminq.h      |  29 +++++
 drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
 drivers/net/gve/gve_ethdev.c           | 149 ++++++++++++++++++++++++-
 drivers/net/gve/gve_ethdev.h           |  39 +++++++
 drivers/net/gve/gve_rx_dqo.c           |  26 +++++
 10 files changed, 383 insertions(+), 22 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

