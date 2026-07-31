Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DFFC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:00:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BB21406A2;
	Fri, 31 Jul 2026 06:59:56 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id A8196402BB
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:59:54 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso315382a12.3
 for <dev@dpdk.org>; Thu, 30 Jul 2026 21:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785473994;
 x=1786078794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1M8DgLxh9zJee56aCpvEjip5lZcu7fgmihu7sYn2RZM=;
 b=D4drw8aBpSd5w5yGAd+ljt7MBriQmt87IpNnl01qWp4HOSmK/0EPw1AFQtbvoiMw7S
 MNEhOtv8fIV86+jrHpYOqbUqeU0IuhBMXCAYNH9clvSMmRncVl9II/yqn7VheSSWcJ19
 v897iK1McyEQuyXPibTXqaOl3nZ2Go1Q0i0KKSvrFMcW+LOYuG6b4jHTgJ7B/LYFQetp
 9saGNYmmc2tGwa4q9ZQs9TIaW3yXFJzISG6GJw1jY1dlmVAJVEALdJ0uuEjMsrZraZzD
 3aO0IwbYNiNDylicoognCqJPPiywxz5yUSujbVWFAHxFygRWXRuXhO5y4LcajPV4L0/4
 nlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785473994; x=1786078794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1M8DgLxh9zJee56aCpvEjip5lZcu7fgmihu7sYn2RZM=;
 b=tXcp251wjTdB1vviNqwMYFXAhKJfKQBJ9zV2FDwaWY3mH1zwRZGpGesqwecQ6WVtuy
 cz+s8kyuw05PYeUKvLpzeu30Bk0+RQoQF7LS8mBCI35bEm/OeJoZfxHxnaKGKZlt2rQT
 XbPj/3SvhIjaefIqo1233eGr5+1QDplCgFyxFb3vjuxNHSgDuzSOBW6lODOI0GQOajjV
 2ZyMCsQKD3QBkhSgDY6ggOMfNQhQ4bR7M4oD4Qw4xJy1DCniNRUIxDze+QKMe6Du93on
 YcZFOd7TdBiRF+wA5k6aeUcRW0pQE6rszaBSVwuTjAlc6KKO6fuozQ4/74/MPvC/CuAX
 8HBg==
X-Gm-Message-State: AOJu0YyHHt4x/6neiNrivnPu8oZSBoL71k3IMWSEQj/FgGbEJtWz+BWu
 TlzMNqDlY0s2S2yfV0sjecX25FfIXDZkhZmUdMjNU1iemkPgSfvzMclXzVK/G0iwZIyn017uOcj
 TGLaZ
X-Gm-Gg: AR+sD10AjKLNGkvWXoLhxXscKU7WquvBT2nNvXDH0TmIEC6WkxKOpbkAQTyLSy39b1H
 re54dT5SASFEvNTTlQW4Yd9NrXWqAOFQxo2Z28zOVJLCNehyNMdYmUBvbzq/rRqFuv/UtdTKwoF
 JMccvI1q3cCeVy9MxEe/FR0dfaDUj4fXm6UjqVUex43QKaKwXEm/74y2o2rIUuLb9bjeUsGzErg
 TZEz/AAlWvOUsJiL6E2advLsE2bTFIiWFtcmPGWJHCfZ4i3a9YK7N44HYZlEMBFt3znN2ljUoHB
 aqnr2SPJNF9wcnkgfUCZWrRqOdRjTmnkR/c6AvOkK7EWPIhUh/X89I6QRsTgRObXVNtzdAh0qje
 MOhjhzJhTZDR0OSRUzSQEPd4DlzIIAAgRQ6poH0RmwF9b25upr0OTOYDHH/mKEk1n5VL95wBiYG
 uURazWK7WSUE7txR2Om7C9QvY+HAOTSI/CtjmfL0TYv1UqH3yIjRRAL5Wog1BSO0mJGoJVmdXqG
 Fgok0AnkpHo5YXOko+z3BBAZ8I=
X-Received: by 2002:a05:6a21:a89:b0:3c4:2cf9:28b7 with SMTP id
 adf61e73a8af0-3c91b12ab1dmr491811637.31.1785473993805; 
 Thu, 30 Jul 2026 21:59:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.21.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 21:59:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v6 02/24] net/bonding: use stdatomic
Date: Thu, 30 Jul 2026 21:57:40 -0700
Message-ID: <20260731045948.769926-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

