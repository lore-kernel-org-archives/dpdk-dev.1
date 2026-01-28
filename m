Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB7AD46BF4
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:11:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41DEF4014F;
	Wed, 28 Jan 2026 20:11:52 +0100 (CET)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id A93674003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:11:51 +0100 (CET)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2b71320f501so365471eec.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769627510; x=1770232310; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ve7DDt7OE2ZaHNLgQ5jBWC4/eCUoLJZLY+nsi238Tv0=;
 b=MLtd20w7wtTMM1xLgaVfSzUbrxNjYs3H+kX4NOHLFuTXq5dcTZxT4iPatq9uKE8oCP
 gXUyPPIokf65XUFgYo3bXRA2GYABWz1MBso3vMjnhvFVmDO/U1DBoMhhSsRRBjf0QVUj
 NXsUvCZDZXLONpwcbEIKqEIXVcGat4bXQYaj2esbbDR5QF5tRGfeHcd5Yq0Q6RRQjI1q
 IuQhZD9dkNrHJce4IPHXXuTXBauSfb3KpyguN4nEksFQ/zfniFUzeZEHOYeRoY8l2Cce
 Lel5zlQwUYSmMTNpaO2VvjGgZS/jc5a6feuP9shgb/alJzfdhcbiEq4bjPp/ZUm3QlAD
 Q5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769627510; x=1770232310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ve7DDt7OE2ZaHNLgQ5jBWC4/eCUoLJZLY+nsi238Tv0=;
 b=aqo9hWjhGvNvU6KGQvejsQAv+njhGmXATw33pvIHin1onBSDitkTVK+2jDHYV7kUbM
 Bg1ac3bjEYHDToHfvZQy0m7r/8IHcOg/M0h5f6kTA1gzIlyEOiN5khylPTXGl+LWy47e
 pP47zOHEZlIMQnzr+RC8IEck0D+KGl38TO8f1/kQeKfcSR4D01U0ngNOYtS+ZOxt1Qsc
 cXK8Gg2yP1BUlTDR4WB/zcO9jjYpclmF9s8hLDtlVjfumkV7uLVBWADM2/pPImaFeQoy
 tInEAk1O2kaMciBXex+9SFWE8eR5vPOhCG7lMcIRWJnR+KEi60/YUNJpU+DGv2QLoeLu
 EgjQ==
X-Gm-Message-State: AOJu0YzQYzawDo+8lhAp9pDR0UdDAyPLCmXEQwkRiFwQ1X0i0Q3/6WQ6
 QzsvM36/BF5Yvc7UZ8O1XJCo/w1vmSodz9uZ5YnvUkn+mkeIjDe1nrgmu2bkIA==
X-Gm-Gg: AZuq6aLtSL7ViWJ9W3nrMtZwtwaDokGZkNn0WmLfVYnV1avvocIVyXNkjN7lE7CB4Oq
 hw95JUYx8Wet9ITmGO/GcwzzWc5f9wPHOtk43r3rz1DTn49l/GHEu5/pV6WGBF+LXiYvkijoz/3
 a/0+wWPDazdja+0P1E19Edvicx2i7+gh9UgeHFQLABnGZ/k9oiBHXS7rUgI0ms1yn4grMfMQfHF
 4vHxrAEI8xfiIaHpYvuqtb0AV9i5xXuGfhhfBv+C00ZDm0IU1eWyKKx0m3P4sBvTnalcyfyHv/t
 7yv5oPzUBRCr9FGZFuDgRSl5ROpVpvhn9p1+MDFxoaQwhbKLYZANyyb5pblpQE2AHXjadJpCBCJ
 YWVVxKSqa4XLtPavJWJWl6rvfbphEmx6sjThGlFq9EtHglSG08RcMP+HU3TRYdaWMzrtGi/EQvd
 moAIpTaPMdhB5dvubLqOw1FPnfIUP/y7pQCd4djK7gLKLFe1JXqw==
X-Received: by 2002:a05:7301:fa0e:b0:2b0:5bfb:86 with SMTP id
 5a478bee46e88-2b78d9245cdmr3420362eec.17.1769627509915; 
 Wed, 28 Jan 2026 11:11:49 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1adc5ecsm4261286eec.24.2026.01.28.11.11.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 11:11:49 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v3 0/4] af_packet correctness, performance, cksum
Date: Wed, 28 Jan 2026 11:10:28 -0800
Message-Id: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
References: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
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

From: Scott <scott.k.mitch1@gmail.com>

This series fixes critical thread safety bugs in the af_packet PMD
and adds performance optimizations.

Patch 1 fixes two major correctness issues:
- Thread safety: tp_status was accessed without memory barriers,
  violating the kernel's PACKET_MMAP protocol. On aarch64 and other
  weakly-ordered architectures, this causes packet corruption due to
  missing memory ordering. The fix matches the kernel's memory model:
  volatile unaligned reads/writes with explicit rte_smp_rmb/wmb
  barriers and __may_alias__ protection.

- Frame calculations: Fixed incorrect frame overhead and address
  calculations that caused memory corruption when frames don't evenly
  divide blocks.

Patches 2-4 add performance improvements:
- Patch 2: Bulk mbuf freeing, unlikely annotations, and prefetching
- Patch 3: TX poll control to reduce syscall overhead
- Patch 4: Software checksum offload support with shared rte_net
  utility

v3 changes:
- Patch 4: Fix compile error due to implict cast with c++ compiler

v2 changes:
- Patch 1: Rewrote to use volatile + barriers instead of C11 atomics
  to match kernel's memory model. Added dependency on patch-160274
  for __rte_may_alias attribute.
- Patch 4: Refactored to use shared rte_net_ip_udptcp_cksum_mbuf()
  utility function, eliminating code duplication with tap driver.

Scott Mitchell (4):
  net/af_packet: fix thread safety and frame calculations
  net/af_packet: RX/TX unlikely, bulk free, prefetch
  net/af_packet: tx poll control
  net/af_packet: software checksum

 doc/guides/nics/af_packet.rst             |   6 +-
 drivers/net/af_packet/rte_eth_af_packet.c | 257 ++++++++++++++++------
 drivers/net/tap/rte_eth_tap.c             |  61 +----
 lib/net/rte_net.h                         |  90 ++++++++
 4 files changed, 283 insertions(+), 131 deletions(-)

-- 
2.39.5 (Apple Git-154)

