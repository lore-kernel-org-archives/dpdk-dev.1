Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC20CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BA5B4069F;
	Sat, 23 May 2026 21:58:53 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 777E14066E
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:48 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-133466cf955so24737917c88.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566327;
 x=1780171127; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l28ofkRJlxkvRH8FsGwDhU3UycbwfeVDOFSGQjuE/8Y=;
 b=o4vH7EE0T5fEH8ywn+zMgURhb8wdSPdLoba4i07xWs/hOinr/Krl12u8Ae6jem+Tk2
 rJ14aWg11s/R+5k6lVKB5U43a12PbyNmuC9MbA93jmikXlGmZU60wHZxNKLniIxkqsa1
 r/zIRHi9Bka424/RT7rCagaG8wQiIob4me4O00I5ZhgT4dtcRZLLvaqIxd9iRv08Oeke
 ImjrjQEjkCmAeHzKvOKV+hp4i1nic8zxAw2imbb8sB9slooOBB53zT+TWgvaPelPJQAI
 ADOxvJGlKIVnd9GgIXRyBcJ/+GkLMKfJ9WamSy6q+cX6AEHE1AQQjQ++m1qms/UrOc4/
 L28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566327; x=1780171127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l28ofkRJlxkvRH8FsGwDhU3UycbwfeVDOFSGQjuE/8Y=;
 b=GX4PtaLdD4derxLwC2CRQbEWR6X/dYS+TjPMVuYHQfRbwzgCBza1Mkd6VdzlIlcadv
 wwJa4+DIkGb2QkziZmiC7CuF/sotsCP70BAdgnRsQRSyi1X2HfjPAqcTEh/bFWfszMGw
 1qNYcypMNhgmbkuBFxQATJowLv0if+32iIoLFc3Rn42LDvF7tsrBmAPCzE/dB3099q5f
 eibQQzkhGxvHO+gEaDzEnZtZGouz+usVQX7jdc0sr27m79q+cAEZeh3IoAd5arIfq7GD
 CEGJqf4HsuE7DJQTyIC+y2vgxbFelzbRgAbKqJRVp1+tlQXR7zp+cM2kEchnDBbGF3MI
 D47g==
X-Gm-Message-State: AOJu0YyqVKeImgBhASC5yiuVRawgJU9VQ8R8kv+shg8JDMEvUMGPQWXK
 XLTUuWUArBT1WAB0x3nHCLVWsHsHfh61Vkf/r8sf1ZCosLHH2wWobEHqMHpqJ0SgRo2D1S0Fpc0
 PfDBR
X-Gm-Gg: Acq92OEO4i+txxMssTXJO/9kXi4zbD1b1U2P3TGredbSUKKT30eA2E/CmuflVNDgj/L
 35Tft1+sD2U9Es1+Ej277yOfz6nMiPOpiGEPyNXnKF9123i8s0BRtOd+LiiJTr+/RqVJw3/BJbf
 pk4SB8919V5C3sVk0vJfmlzZS8wC0vGLWV+mwA/S16+O+Oy8+EPRViSXWDde0zx2km3VBxoxG5s
 bC6ADtN9UO5qplfHqE00GVCA6r5GOF2aYJ7VleBlwoQYxeDwu2tfJSUb/s1WvTK7FH9+pICRCjv
 Hcn+PPfaxWpEzjkTANM08ljhkUrVB1U7IJn0FbZahHnxvwl6AxBT6WRiu9fTNjp+wchN9MrfPf5
 Qbg26j3MyotT0DPnhLm+iBuRwAT+itQKxj1Z9WcFIl1zjfsz+hSWb4cUtwLOQtIct8NaQgSBdTo
 2DD6S5e4Un/q1NCdlKY1oo+++Il6rBKq/zJGNU6ee5+RYk9KUI/vfBWDt7eZ+Jtg==
X-Received: by 2002:a05:7300:f191:b0:2c5:50fe:c795 with SMTP id
 5a478bee46e88-304491a075fmr4204084eec.29.1779566327370; 
 Sat, 23 May 2026 12:58:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v3 05/27] net/bonding: use stdatomic
Date: Sat, 23 May 2026 12:56:19 -0700
Message-ID: <20260523195839.454952-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

