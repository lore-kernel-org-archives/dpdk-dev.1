Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7E4CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51CFF4067B;
	Thu, 21 May 2026 06:20:55 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 0297D402E7
 for <dev@dpdk.org>; Thu, 21 May 2026 06:20:52 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso7872599eec.1
 for <dev@dpdk.org>; Wed, 20 May 2026 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779337251;
 x=1779942051; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rnRsY1TFT++E2F0JT4s4zBJkIVxEIg2Slk3SSO1iDg=;
 b=kvzEW97Ig7rAMYQSiq7sShBgv6pWazBwopDPXjZWvKmVXT0fnoEhRoCBY3u+LIMdPw
 PWBsbWWA5k282OyasGRUR+cv6Y1dX4glKDUxMKCfpLAem6xkgX2v1t7+VUMAoWLNm6bG
 Vi4VjBij/0S5nQofJ/JtEUcHIJVoYVDy4BRjwAtfVmPU9V/aUak4+VQyqQpBlOfycfJp
 htaARr0rZh+u3l4chjgjQoIskAFKt14Tn9lcEcP5/IT52k2YNQCTWnkbVurO2O+mQr0s
 uHTlX/NSkMRNGZAH43bGQPiDkQn9SBLO3ZGwy2OGiSsVrJVzEpBOp8v5X0wBn0d7bfcV
 ndog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779337251; x=1779942051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+rnRsY1TFT++E2F0JT4s4zBJkIVxEIg2Slk3SSO1iDg=;
 b=DLA7+adCPif59h3BHeUb5Of1RB8wstJkzTYjH59ds7rX+0ZCv1kqy/oQ3NYxxUO9pq
 o0t9WloHC02k9rHmAC4mez9WQpO8qKSOQV9h2ITCNVxxPvIt2QpmXGARHt/fugn9e/lQ
 3c5RZoSfhnMSZvTc30v9XUqPwIlw/NOGxkmYu5UjXFg/Ck2ATngTFPIQig0AdC7N9RS2
 PQMFMHzEWZltNMf/WDS384nXdq/3FZqHbdZGZjO0V/KqggKkF7Yl6T/VKN4I+F+x0uv6
 VsPqknmYZ+GV2T6bzqPCiMhjDKCTx6G/Gg8PjEGfNgKOCqvfVG7yWWuuBm1uHd9l0WPE
 uLMw==
X-Gm-Message-State: AOJu0YycMZaJCA6npQHMWRNLs7ZkiHNH5QjkZshFv1iwGHpl5ZFSwyCW
 EUm+2sCvO67oCnV13nexUY4RnMKmoQbMQiLSO3XP34RHbGzFzsGJnW+dwpJticANJ07N0lYyu2h
 1bHm8
X-Gm-Gg: Acq92OHj5cM+1613tOJqJpGCCkXWifBBr4IdAzlC/fDE85j/kibSYyQgHsSyTNOOWse
 mmEwHtjWOtGanO4YScrvwOQ7ACLZEAeM/irzz3/D+tdKSqlAznbkiF2Ds0XfoPX1odcRiYMRTSi
 IfhX/ic3oA9CXw0F2snbMD/j1laf0lUew1k3L5h6bLnTfkXI1Y7cqAuIZbbZRZU9BjSSAXoUmjv
 br38m7edC3I+o1YzPQV12t82CqvTwLB7VOZNpjOUW5k6FEPuj+C3chpN9X9KN+/rtPY3EeG7NIZ
 mOX+kNouvXGluC1pBrmALvOMewxiMtHVqqzdF/ODfKym/Sgl3ZaZZwv9aPy/NF2857sGI1NRIzn
 dFf0kIpwJXLYmdZu83y8YgN1bxj+ON3CnhQw6f5acWwNn7INmLn9ArgWtcnRHoqR8yWokrUNhBP
 LgWLvvVnsOXvwR/gobBLLMQhZw0ZyhzSIMkTCGZDwSVc71tr8mI2BTlCo+aomUFw==
X-Received: by 2002:a05:7300:ef89:b0:303:f2fc:c483 with SMTP id
 5a478bee46e88-3042f4854d4mr833994eec.1.1779337251082; 
 Wed, 20 May 2026 21:20:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm24347748eec.5.2026.05.20.21.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:20:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [RFC 5/7] net/bonding: use stdatomic
Date: Wed, 20 May 2026 21:17:05 -0700
Message-ID: <20260521042043.1590536-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
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

The old rte_atomic16 functions are deprecated.
Replace with rte_stdatomic for managing warning flag.
Can also use fetch_or and exchange to avoid CAS here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/eth_bond_8023ad_private.h |  4 ++--
 drivers/net/bonding/rte_eth_bond_8023ad.c     | 18 ++++--------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/bonding/eth_bond_8023ad_private.h b/drivers/net/bonding/eth_bond_8023ad_private.h
index ab7d15f81a..1756c9307d 100644
--- a/drivers/net/bonding/eth_bond_8023ad_private.h
+++ b/drivers/net/bonding/eth_bond_8023ad_private.h
@@ -9,7 +9,7 @@
 
 #include <rte_ether.h>
 #include <rte_byteorder.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_flow.h>
 
 #include "rte_eth_bond_8023ad.h"
@@ -143,7 +143,7 @@ struct port {
 	volatile uint64_t rx_marker_timer;
 
 	uint64_t warning_timer;
-	volatile uint16_t warnings_to_show;
+	RTE_ATOMIC(uint16_t) warnings_to_show;
 
 	/** Memory pool used to allocate slow queues */
 	struct rte_mempool *slow_pool;
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index ba88f6d261..641aae1a67 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -171,27 +171,17 @@ timer_is_running(uint64_t *timer)
 static void
 set_warning_flags(struct port *port, uint16_t flags)
 {
-	int retval;
-	uint16_t old;
-	uint16_t new_flag = 0;
-
-	do {
-		old = port->warnings_to_show;
-		new_flag = old | flags;
-		retval = rte_atomic16_cmpset(&port->warnings_to_show, old, new_flag);
-	} while (unlikely(retval == 0));
+	rte_atomic_fetch_or_explicit(&port->warnings_to_show, flags, rte_memory_order_relaxed);
 }
 
 static void
 show_warnings(uint16_t member_id)
 {
 	struct port *port = &bond_mode_8023ad_ports[member_id];
-	uint8_t warnings;
-
-	do {
-		warnings = port->warnings_to_show;
-	} while (rte_atomic16_cmpset(&port->warnings_to_show, warnings, 0) == 0);
+	uint16_t warnings;
 
+	warnings = rte_atomic_exchange_explicit(&port->warnings_to_show, 0,
+						rte_memory_order_relaxed);
 	if (!warnings)
 		return;
 
-- 
2.53.0

