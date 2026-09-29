Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2044CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45BCF42DBB;
	Tue, 29 Sep 2026 16:04:17 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id C2C91427E7
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:14 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8805988a200so2715322b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690654;
 x=1791295454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1M8DgLxh9zJee56aCpvEjip5lZcu7fgmihu7sYn2RZM=;
 b=tRjN3/CefOVD7qpLjxL4LnEWsoqL5NjuUA/j6eCt4tJgsBxDTL7eIKyVwW0BC+WIU+
 D/fHWI7v14Qw+mE0Sur86nVquVLGcOtIqFWOd3slBNtwzD/mDeI+/kyYdvZODK7bZbO7
 Bimc97djmQZg3v5mXXwNIs7LonN4C5a6i+KAgaMXU3WP6XCVrQpanfZm8mMUYcloz5Sr
 CZbLJ/Vuhpb5y7PO4NrV4KBG1T3bYz8IFRMnGYbSFzGXM1zXf8Mdq8CMcwcufPoErQmq
 cqfQ8aTtC50JjMQtOYkiortFXjhnOZHgM8OkvHcBL48Mu/0qyWEeoXoI3dneFuADyVlo
 JrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690654; x=1791295454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1M8DgLxh9zJee56aCpvEjip5lZcu7fgmihu7sYn2RZM=;
 b=DWrHMv3DBFgNbEE02Z4iun8V6ZrXWjZytUGdyNPt6uirAuMDshZUDhkhvFL1etwsCr
 d3L5HnFZWnPk2vvxoVrrq/WKn2a3icbIlXem/VWufYnORVHu7ymrQ6b5ruiKB0/4sXuV
 WcQt6ZPaq7ZJdHAHHqjOsISmvgr6R2rJ1sck8UpjFAc0gWGrT3j+jKyQpqs+s14gVOJ0
 1+XrBdy1FN5eVCE5Fcd6rHSN/KP1GqNP6S3IEtyZVOqCEdWYmRyadT7xTRPWzzYtGc0P
 KDA8kug+iPfW7sZzbqM/uIKvDg05HEP1Av16xeXbv85ystfQVzE0RIZABKgvQe4GHDJ5
 fw1Q==
X-Gm-Message-State: AFuF++mF9MCJq7Y/exJ9AKnUO5uc7XPjda9RzPl0KHItiA5H3Fh5f3Qz
 F4bdnd0dHRbFNQe9BQwUq2HKFzH5WXq7+G3JwyFcu9eoq39HTkCUTdunjeC9WHfsqIaJJxspHpv
 aZUxB5/E=
X-Gm-Gg: AYBFou3LRH2CTgsLteDYmHWDjrjU9evGs23K7BE65Oku8OiwO2MTB4lPHQyB7dYZxxJ
 HXi2LMH+uj78MeutUK18Z74273NAC8NYG+q6njAAKJ4Y5qwcHfDqpFIqUGJwGH8BCeMbcxHBsa1
 msof5s3TipH0SpfJjDAtVsXPC3ClFtKhoHIxRFuDXKaKiWyA0xiV0zstrhfgh51yogXQN8W5HXi
 gFTrCmmZKHDP6sSTvz2Tmr03oBZa1S6Wygdagc/Gd4rQJejFJOJFL+8P1x8rCNlnEdfAVTNSXUA
 WjTAYgaRksez4GpMt7sf4Vu0L8zMgJLhhZ5DojpnPbOeKgUssgWTWqZXH/U8FQJf++2jN2h7c5P
 RUjhcW9mLO+1Dbqwjc3tb4v993apgdZQajBfJy8sKc4wMhcmmTllqeFLk4PZlE1QeszKD7yahGa
 UzlTO4bZ9taqOg+WQCp/PwTPo8sVzuO8OXrNy8IxqRYB54pVSUDYh6xtZMwbNjN0SgENG3ZRdYq
 rW2QjJd5xKI2ZpKOgcVb+Px0PYwGLv4NW5h5A==
X-Received: by 2002:a05:6a00:4c07:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-87e9f62c5dbmr12562246b3a.52.1790690653905; 
 Tue, 29 Sep 2026 07:04:13 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v9 02/25] net/bonding: use stdatomic
Date: Tue, 29 Sep 2026 07:01:48 -0700
Message-ID: <20260929140409.234453-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

