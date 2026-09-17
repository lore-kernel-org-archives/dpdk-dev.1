Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5021C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D301042F8B;
	Thu, 17 Sep 2026 22:11:26 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 6452E40A71
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:25 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747f05ffcso326925ad.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675884;
 x=1790280684; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1M8DgLxh9zJee56aCpvEjip5lZcu7fgmihu7sYn2RZM=;
 b=eY+sb9GqsK1uNKwIq+EFBK3CnEsoJtsY+KX7iu/qnQ3T07qVFm6D1TFWMQP2zWhY6F
 fF2709E13iKGOvkm7E+vW8XIhdU4w9PumsMcIBYTTKRUZmBqTPQ7ZkxJB83xUk4+cybY
 o6qsS1dC8V7q1QY/+CRRPKl0lbsjjonvV1Kgkl6dk3dI5C9qxLSO53/jKA9D8p13cH6s
 dx7nPJAkLvzGFk11xjESghKgMak+P34HoN7UX6E1/KZOzK+aFHsAlSLdyKc1LDKrEcgD
 DBEkcaTfNqUB/jcmsVi1bSWDa5L99jUgF6UL/uVXYXIyuEpsjbopF4pkuAGmiuAwaQlE
 ENyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675884; x=1790280684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1M8DgLxh9zJee56aCpvEjip5lZcu7fgmihu7sYn2RZM=;
 b=iiyW3J3eldiouCBjGKuCFga0tU/cbRgXAMVK4n9+z2mcdxzNvDv8v36a8TRmh4lpVH
 rLX4Hhvbp3iM9TknUWXGqzQ/L8eWE5DyjUdcnWpPh3lGL/RAWWX28NpO9oHmStr62v1B
 ArlIr8/JiS54ojY1hKI4hkG4qJ1tdR+wBhyyLg4UBa/peg2EXK43ri2wExd/3guq4GE7
 HyC/GDApSBH5Yf9nlStkWJLEViN80eXIXAO4kqtH43yh6jgU2+8dCboAbMmqFQQTOlIb
 rERCSH/+potSFJ3m3i005PY/FxqUbJcnxouS/J7Q6nHiE9k83YzJ1Pk8SjXHyh8MIwF2
 bDkg==
X-Gm-Message-State: AFuF++nr2q01l9NakKRnHeRDVymXiDwSvMqfKjpKDrfn/McAdznen7NJ
 06NY+/EoB43G/8SUKZyFS0p7No9c9VuQnWWDGnSAl6ulhsu1QzZ8JKAcgcMQSrM1kG1tK3mmrIB
 hwaFg
X-Gm-Gg: AYBFou1n/aAJOZvOPIYow1Kx/3NOhyC1E0HQKRh6w7LIyARAi7dett+T3GtNQSCViAh
 jYkmB0YcBxjGnqDUaRZvneTHtWROasdUQ25N0dHWpQYkD064pB8UuYjaFy+x5MRh9RzGdkQKBdf
 73DgX6TlYt1AKg2DlRSTjjLxSAePaDYnBBGrFZzSDYzPe4o/AYId0oLzewaKOA2cX6sxKWZGvKd
 KFTxhDhLoXQNh3N7wsGmamvq7i5ZZPqV4cSKY9qm0N3GfRXna0jZ+fnoAWLC9ytw6bnTsXlAIKO
 bGxSxsMMmSoSmajzlF7LlaM3zzPzvGMbyIH9sMKnhpUvsGdriqFPkPPFVA5LPRq7+z0PIJrZD2R
 6OGAUALjwiTz1j99JRjQfXkkOqQGgBk/H/gZnMWUVen9uVIGq/0TJMqUcf68n2A8uD+gET0gfB+
 vKBb+hzMquppDTH3VWh1tL3rwslHfRshrGgnSuiYn2yTqtA+lx90mxLZsI2t/fOu7rbjxoHzxPd
 c5HTAybbjkknimzT4LPRh4DmHGchWCCxoZVQkSHWMPDsB7p
X-Received: by 2002:a17:902:db0d:b0:2d8:da29:da41 with SMTP id
 d9443c01a7336-2ddb1b79ec2mr5359425ad.15.1789675884505; 
 Thu, 17 Sep 2026 13:11:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v8 02/25] net/bonding: use stdatomic
Date: Thu, 17 Sep 2026 13:10:06 -0700
Message-ID: <20260917201119.2168234-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

