Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A07C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B104402D3;
	Thu,  6 Aug 2026 05:25:52 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 9C5554060F
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:50 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so1639051a91.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986750;
 x=1786591550; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1M8DgLxh9zJee56aCpvEjip5lZcu7fgmihu7sYn2RZM=;
 b=f4pLZVl2tPvPcQe+1y16v++GWvQHoj/L68vYiH+MLBMi+sM5P5ubDSei/gowuexp89
 tq2pfWSACv+swPJeLyrVWirrTPu8f6ey5HjD1L/FQHRQ0Ul9Jc5zG7l0NINAScKV7i0n
 Z5MXlCAnXPRJe0B52RVt5Ts2MyaFTI1I0jHNruGvh6MyX8IGty6PLKPxxj9debSLkMpx
 eG7DTtg2ppA2Q174WDVeWP1Smb83y/RARh73zxqDuXRZcGOd3S3z2TVf7S7TMhYBlzuw
 TBJWC3ALCyl+IQYj9qsbTnT8NdWi1J7DpsSZdMcCd85t6wyEQSkJyVDUrL3HHX1cAHJe
 0PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986750; x=1786591550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1M8DgLxh9zJee56aCpvEjip5lZcu7fgmihu7sYn2RZM=;
 b=ktEUMnDnSK4hUTqadsTd+9Yd1crlHlKvLXWq+uV86m4hBssu/fmonC+fyCEg7MC5Jj
 xYOMQE4c2sNQzWJOOP/zJc/Dvf5krQsn+8UOua/cbvdWfq/Ngj3OZp35cM8NREYwYPr0
 6eNWf7wnNuCwqRLx1qn0p2yIAzf7ybZ7WPFn8IbDRIMUfzHQ8LZALKJ2GboE5jyNtJSq
 xmkCRrOAWqLNSicJnrX8aLlucOgl70ktb8kWyUa5CW+bYi9Xf69bOJG6pRuobTOq0HRu
 sYxxge0KRoP/EPOH65na9TJtMoUvyWFFMUQj5ZwpYUjavGfL5WbdJWf520Hf6V4QGehl
 5L+w==
X-Gm-Message-State: AOJu0Ywg5qNhe1S/QbIqMvfW4wxZt0e1Tg5EAxbEE4Q8ottMg2+fsP7B
 dSvoh913WtE8djKmAPox9NX2Cg+KqiojTdNkXr5rB8eLI2oQ4dE0Kv4vlDfk2rgWEsylbQWbZMN
 SUi84i0E=
X-Gm-Gg: AR+sD10kvIohvMkwmqDCMe0EVIKZaW8sOp4PVoJjVsxofxarxSfjQio/GQgNRXiC3i2
 AFkyDJHlfUni+cJxl7clFXrgFsjdTArjGobzWwzVOTQ9NF7s6xaI7T3CcQuQQrdIQv7iNK/m1wU
 cBP8m8Imw6vV3zuMxZw9Do5diUljgxYKNCpDey7iHxmqjDVfefTYgfnUI2xgM/LcKLXl8hyMbsj
 gBH6CY/+t3qNi7Lvd2eHEUx/1YSU7egFf0deCG034sLaRyOSU1xy36/UvzNRgGoO+dwVTocPDQQ
 0q0XOqjOb2WtSb0D9KT1ptPRHNfuEV1gL3gr7hxLFhcDQ2piDCotu2H4jKVd7wpN5+RVxN2Lx54
 ab3kB6fEBDVFqUVQy91sXv0hVFpVZeOMepgRg9viLTNw10iuVXDbn0Gn7jqCQDgX5anuP0oqdYF
 pUDIxqJ75ziMt5Abe9QZhuGcVJ3DKwzMg4b8GTHNwuCJVgRUaprzMohVSJU5P1P9fck+IYXbGCq
 Z2TUaJavvILjhYeFMnjZ8z9gM0=
X-Received: by 2002:a17:90b:2f03:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-3903c53404amr12796159a91.7.1785986749743; 
 Wed, 05 Aug 2026 20:25:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v7 02/24] net/bonding: use stdatomic
Date: Wed,  5 Aug 2026 20:22:54 -0700
Message-ID: <20260806032544.21337-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

The old rte_atomic16 and rte_atomic64 functions are deprecated.
Replace with rte_stdatomic for managing warning and timer flags.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/eth_bond_8023ad_private.h |  6 ++--
 drivers/net/bonding/rte_eth_bond_8023ad.c     | 35 ++++++++-----------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/net/bonding/eth_bond_8023ad_private.h b/drivers/net/bonding/eth_bond_8023ad_private.h
index bd7a5848de..01dd08b4b7 100644
--- a/drivers/net/bonding/eth_bond_8023ad_private.h
+++ b/drivers/net/bonding/eth_bond_8023ad_private.h
@@ -9,7 +9,7 @@
 
 #include <rte_ether.h>
 #include <rte_byteorder.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_flow.h>
 
 #include "rte_eth_bond_8023ad.h"
@@ -140,10 +140,10 @@ struct port {
 	/** Timer which is also used as mutex. If is 0 (not running) RX marker
 	 * packet might be responded. Otherwise shall be dropped. It is zeroed in
 	 * mode 4 callback function after expire. */
-	volatile uint64_t rx_marker_timer;
+	RTE_ATOMIC(uint64_t) rx_marker_timer;
 
 	uint64_t warning_timer;
-	volatile uint16_t warnings_to_show;
+	RTE_ATOMIC(uint16_t) warnings_to_show;
 
 	/** Memory pool used to allocate slow queues */
 	struct rte_mempool *slow_pool;
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index d1f30229d0..c445290079 100644
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
 
@@ -1335,7 +1325,6 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 	struct port *port = &bond_mode_8023ad_ports[member_id];
 	struct marker_header *m_hdr;
 	uint64_t marker_timer, old_marker_timer;
-	int retval;
 	uint8_t wrn, subtype;
 	/* If packet is a marker, we send response now by reusing given packet
 	 * and update only source MAC, destination MAC is multicast so don't
@@ -1352,17 +1341,19 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 		}
 
 		/* Setup marker timer. Do it in loop in case concurrent access. */
+		old_marker_timer = rte_atomic_load_explicit(&port->rx_marker_timer,
+							    rte_memory_order_acquire);
 		do {
-			old_marker_timer = port->rx_marker_timer;
 			if (!timer_is_expired(&old_marker_timer)) {
 				wrn = WRN_RX_MARKER_TO_FAST;
 				goto free_out;
 			}
 
 			timer_set(&marker_timer, mode4->rx_marker_timeout);
-			retval = rte_atomic64_cmpset(&port->rx_marker_timer,
-				old_marker_timer, marker_timer);
-		} while (unlikely(retval == 0));
+
+		} while (!rte_atomic_compare_exchange_weak_explicit(&port->rx_marker_timer,
+					&old_marker_timer, marker_timer,
+					rte_memory_order_release, rte_memory_order_acquire));
 
 		m_hdr->marker.tlv_type_marker = MARKER_TLV_TYPE_RESP;
 		rte_eth_macaddr_get(member_id, &m_hdr->eth_hdr.src_addr);
@@ -1370,7 +1361,8 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 		if (internals->mode4.dedicated_queues.enabled == 0) {
 			if (rte_ring_enqueue(port->tx_ring, pkt) != 0) {
 				/* reset timer */
-				port->rx_marker_timer = 0;
+				rte_atomic_store_explicit(&port->rx_marker_timer, 0,
+							  rte_memory_order_release);
 				wrn = WRN_TX_QUEUE_FULL;
 				goto free_out;
 			}
@@ -1384,7 +1376,8 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 					&pkt, tx_count);
 			if (tx_count != 1) {
 				/* reset timer */
-				port->rx_marker_timer = 0;
+				rte_atomic_store_explicit(&port->rx_marker_timer, 0,
+							  rte_memory_order_release);
 				wrn = WRN_TX_QUEUE_FULL;
 				goto free_out;
 			}
-- 
2.53.0

