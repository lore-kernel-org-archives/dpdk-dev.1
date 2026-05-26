Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51002CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:26:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5156A40676;
	Wed, 27 May 2026 01:25:56 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 2F54E40659
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:52 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so2740543eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837951;
 x=1780442751; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l28ofkRJlxkvRH8FsGwDhU3UycbwfeVDOFSGQjuE/8Y=;
 b=Zx3vNp/NXKY21bfxA+Fk3uIm+o9DqnuduF+np/+IXJCZjanofU/O88e19p1JoSHSpv
 YNpb3ovzvBEAzNQkgDFUPmFPaMvaYUMTvtciKAqy41aiLwFxs5r9V/lM2xnQVKlMxA6j
 zTtGWNxBshyvOwOzwI0au70wA8RTMjpwSS4Ejses63ecmXePvNTvmewyPzFWGiTYxVIK
 2/T1qFhzCOk57jqf3zL3NYpTL6D/5po+qoq1USUcZllLBGD1b+9wX47uRes0ph9pVv3w
 KbabjuK+WjNysqyj/YDwzJuFiXdnEttolf1ERy7IFw+ZIcGGfolN5WIt/tZDnclkOtSa
 0utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837951; x=1780442751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l28ofkRJlxkvRH8FsGwDhU3UycbwfeVDOFSGQjuE/8Y=;
 b=Kk7s8MZDJ3Pmze8NxKkeqDEHkffo6RHDsey8I4xRGJaHKe1h96CCqWG0GMTDT+OCPG
 aqcbgS9Ct3wqRhcXXVWhP9ploXFyLTc6lkr8DuhTXFvCIBNYLcQms+XDU1eBYes3V0P8
 syJ8bkzyUL6AEOET2GEUz3gHwY/JC9wWcKxTLLdeEGC4Aa0WtBM0awa5iWu208ihI2/n
 TWuThVLYoLIqMnGoF1oybtZK0M0iwhcSo8EJS26ObwIgpOVxd13yh1Xtkvir+PSU8krq
 sCcbYjQJ8g1rqlBVkkjjgPQ0g3WbGt7rHWYC8vQYI9r0w8WDMub+sDATtFHGgTmaBSR5
 muTw==
X-Gm-Message-State: AOJu0YyD+Pmmajmzm2smfnnziZdeE0tVBy8R6H2Ny7gTrIjTlh78cxjo
 L/TmbRbo0e3D2/qKl5HGmn6RUi//seIEsE6/wIUL2awUtcorYTzMzeiWSi2AukCdMR5chMVzG+l
 pDqO4
X-Gm-Gg: Acq92OHhI1BZBg5AIENnWRogk2sod6fAk8/PD8kEMZMV/bAhkuxsQ/gldpAUskDM9zA
 9DME0QGtfjqwHwXf2mACH+NmEWQG8EjbBqxw9td6hdZoVUpeLH/uVrrj7gX/SfjJxdMc9/3BRZ5
 LJ+OTnwmO5aN3JlwOP9RLjC86hxNqPmSAnpt4b/kRrgRW++0mPKPFZie6Idlxyl103p+DI9s1Oz
 1gsJjgJUw2N94L2R+Bb0/9cAtelvo6/TS7S8VjQoI2UCWUNZoh2nUCXhmedYFA3XYeQ/hWIdwRR
 OFDXro0dKAq/MHqyOWFE3yzCfY8OXosqIACwql4M/XIo/xVLb4wK7g7Po3jpLdQuXJsMMlMibJH
 HScR18m0R85wCQOruSaO/M7tJXtAn+RBxi5gvsk5Dv+7xs3CnRS1MStJRxiM+vvszZaL/81hwlb
 RKni1U+fpuU+deD2BtC9Bqa+B+7KNP84/fIyjIIRC6tLzUZ7rZ5OMUGxiJ4qKxTjpqZf++aoxz
X-Received: by 2002:a05:7300:134a:b0:2de:6fac:f666 with SMTP id
 5a478bee46e88-3044918673bmr9427901eec.27.1779837951238; 
 Tue, 26 May 2026 16:25:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v4 05/27] net/bonding: use stdatomic
Date: Tue, 26 May 2026 16:23:55 -0700
Message-ID: <20260526232542.620966-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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
index ab7d15f81a..dd3cf3ed26 100644
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
index ba88f6d261..cc7e4af2b9 100644
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
 
@@ -1337,7 +1327,6 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 	struct port *port = &bond_mode_8023ad_ports[member_id];
 	struct marker_header *m_hdr;
 	uint64_t marker_timer, old_marker_timer;
-	int retval;
 	uint8_t wrn, subtype;
 	/* If packet is a marker, we send response now by reusing given packet
 	 * and update only source MAC, destination MAC is multicast so don't
@@ -1354,17 +1343,19 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 		}
 
 		/* Setup marker timer. Do it in loop in case concurrent access. */
+		old_marker_timer = rte_atomic_load_explicit(&port->rx_marker_timer,
+							    rte_memory_order_relaxed);
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
+					rte_memory_order_seq_cst, rte_memory_order_relaxed));
 
 		m_hdr->marker.tlv_type_marker = MARKER_TLV_TYPE_RESP;
 		rte_eth_macaddr_get(member_id, &m_hdr->eth_hdr.src_addr);
@@ -1372,7 +1363,8 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 		if (internals->mode4.dedicated_queues.enabled == 0) {
 			if (rte_ring_enqueue(port->tx_ring, pkt) != 0) {
 				/* reset timer */
-				port->rx_marker_timer = 0;
+				rte_atomic_store_explicit(&port->rx_marker_timer, 0,
+							  rte_memory_order_release);
 				wrn = WRN_TX_QUEUE_FULL;
 				goto free_out;
 			}
@@ -1386,7 +1378,8 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
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

