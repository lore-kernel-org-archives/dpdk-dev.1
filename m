Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CABDC53209
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:54:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CBC6402E9;
	Mon, 27 Jul 2026 15:54:18 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id A1923400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 15:54:17 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-9034b6b7674so22597536d6.0
 for <dev@dpdk.org>; Mon, 27 Jul 2026 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160456; x=1785765256; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lgTXnYiNzUpXQU636yX9rUs4K1pPU61hgd8T5jLiIF4=;
 b=fjGJ1wCxNuvEEv8iY3JiRH4HR1EGqWSq0ueLFpL1bJdwNCzhqFevjZboqVfmgutS5L
 kfnDutslDLY2itWCbowYly5eMfsatEs2kphB19gikJAxIXnR0LgVooGSdfJHJfQFzB6J
 L4maJq+wi5JIQ7AM6ZK/IsZI8mlaGnBKD74Vmsz11jYv+KRrBFVg0mnKvukBtoufwm4R
 LeBSo/yR2dUeEddSPFdFRrPGiORgJWYiyY/n+zmuTZXvcxasOt74CNYPZzMM2oM2cHyZ
 nxH80L5T5LB0bo3RB11VegBAtkfnDx3/T4AXeZKw13NyAh7MWMZVHdPwGhrjb/1P+oah
 d3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160456; x=1785765256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lgTXnYiNzUpXQU636yX9rUs4K1pPU61hgd8T5jLiIF4=;
 b=B6Lav3UD0+zbWqrMY16TEx0jquHNbt2UF3e3MMZq+NNQlYU329yzP0B1PtK0iKgL3Z
 eUPW3+LtSbFkmbjb6NDXupGPsPHX8P+8JwwkTBNU7nbz+38Hfxvt/fMUWiJ8zCzUCrr8
 G6qqPZba+QrCv2UXPXRFiExQ3h6D7omYcPDbIIXW6Twbgs/lHEGrOUmrm9jnARc+rP/D
 gglDNX4+Y1H3DmToL/VWBhQzXCZzT6ZD8zepGBblIUCF1ng/COP5OBOvFR1Twf2vYEcg
 y6sGa1J/NRMJBzok7V81k6ngzYI8Bfqx7yUFE0GI5mWH/MseUKO48PVYZLrBuHlbxrYK
 l60w==
X-Gm-Message-State: AOJu0Yym7uDG0xOgKX+6+8KcJdSI3k9acb7M5qXwFes57P2cBRdAAdqH
 PwxNHentRWanX6HQgbTrVk9/AoybcWtRIXSst1nfIfyxqgay2qZIpHti
X-Gm-Gg: AR+sD12oivfUQUiC5r53yH3ZqxtRaIgi8SwPmRKHcjIdVqkg69IGzp/za9c1nnrMxqX
 JoV/i0fkRwPrQXgES6JSMUBJv9G9LEx9bir+HcuF7UpznTLmQzdGYd5vexJb1hUb6XzTHRACF1b
 l8kXmGQJoi6cSCzlsxRd24PcIiokvejm8LxwrIFSau+0UOYXsqXYEgKwyK08CRDASC4D3Iryq/u
 eNBqucAWMGbFEyOvoivjsRu0lzT3mXt2Yc2wTUGMUmZloZYVMrOPnCNaP7Cq/Sw49sdxEkHogB2
 BfGrKRsgxEHOniDv6UkRTrbo9OYeIk7aL/iY9fkAqBszUkrBgOhcZ7z687iVvcs6BWSMdtk7xvn
 AfZ00mVZE6mTnrdpTt6ho2ZH4txEYiI29jVQN7TBB8evGlaWIyBcMLNJUvWadp4OHcpSjEh5+ye
 g780zfPdOIpSU+Jb9d1nrN7sunQutoVvg=
X-Received: by 2002:a05:6214:2dc8:b0:8ef:6b06:44c8 with SMTP id
 6a1803df08f44-9080ff07623mr9154986d6.48.1785160456484; 
 Mon, 27 Jul 2026 06:54:16 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e854d8besm65530306d6.13.2026.07.27.06.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:54:16 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	ferruh.yigit@amd.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 0/4] net/tap: fix Rx queue interrupt support
Date: Mon, 27 Jul 2026 15:54:06 +0200
Message-ID: <20260727135411.2590931-1-maxime@leroys.fr>
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

The tap PMD registers each queue file descriptor for Rx interrupts but the
feature is not usable through the generic API. This series fixes a crash
reachable without any of the interrupt work, then two distinct issues
against the original Rx interrupt support, plus a small type cleanup.

Patch 1 fixes a NULL dereference: tap_tx_queue_release() reads
dev->data->rx_queues to decide whether the queue fd is still shared, but
ethdev releases the Rx queues first and frees that array. It is reached
from the reset_queues path of rte_eth_dev_configure() and from
rte_eth_dev_internal_reset(), so removing a tap port from a bonding device
crashes on current main. This is independent of the rest of the series.

Patch 2 adds the missing rx_queue_intr_enable/disable ops. Without them
rte_eth_dev_rx_intr_enable() returns -ENOTSUP, so applications that arm
queues before sleeping (l3fwd-power and similar) treat tap as having no
interrupt support and fall back to polling.

Patch 3 fixes a traffic stall specific to interrupt mode: the Rx burst
skips reading the queue fd until the SIGIO trigger advances, but the
trigger is process wide while the epoll wakeup targets the lcore waiting
on that queue, so the burst can run before the trigger has advanced and
return 0. The registration is edge triggered, so no further wakeup comes
for data that is already queued. The fd is now drained unconditionally in
interrupt mode and the SIGIO trigger is not armed on the data queue fds.

Patch 4 converts the driver's int-as-boolean fields to bool.

Patches 1 to 3 are candidates for stable.

v3:
 - new patch 1 fixing the tap_tx_queue_release() NULL dereference
   (Stephen), with its own Fixes: and Cc: stable
 - patch 3: commit message now explains why the trigger can lag behind the
   epoll wakeup, and that the registration is edge triggered, which is what
   makes the stall permanent (Stephen); no code change
 - patch 4: convert the remaining int-as-boolean local and parameters, and
   use !pmd->flow_init instead of comparing to 0 (Stephen)
 - rte_eth_tap.h includes <stdbool.h> directly (Stephen)

v2:
 - use bool for the new interrupt-mode fields instead of int (Stephen);
   both fit existing padding, so neither struct grows
 - add a patch converting the existing int booleans to bool

The coding_style.rst note that discouraged bool in structures no longer
matches DPDK practice; it is dropped by a separate patch.

Maxime Leroy (4):
  net/tap: fix crash on Tx queue release after reconfigure
  net/tap: support Rx queue interrupt enable/disable
  net/tap: drain queue FD in Rx interrupt mode
  net/tap: use bool for boolean flags

 drivers/net/tap/rte_eth_tap.c | 43 ++++++++++++++++++++++++++--------
 drivers/net/tap/rte_eth_tap.h | 12 +++++++---
 drivers/net/tap/tap_flow.c    |  6 ++---
 drivers/net/tap/tap_intr.c    | 44 +++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 16 deletions(-)

-- 
2.43.0

