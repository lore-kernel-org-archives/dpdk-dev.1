Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA50CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:56:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6334A40670;
	Sat, 23 May 2026 21:56:17 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id B5840402DF
 for <dev@dpdk.org>; Sat, 23 May 2026 21:56:12 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso8583833eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566172;
 x=1780170972; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l28ofkRJlxkvRH8FsGwDhU3UycbwfeVDOFSGQjuE/8Y=;
 b=Ks8kd6ZDbrJhA5EI3jJOqwsOP4UBlPTYcbZOs+Ew0KxGFbuE8sESLm307eV3N9rN4d
 BYFQQoih1+Va71jAMfBwNSB9nnLfgwgOD2MVT55ISPnEPWxUUFbjQFOfYYbDUp9xfvMU
 y6zFxmusczbf42mque1GJwJg+mgCZqdNjJetFOWK2Jsor3QwHRkYPrFOwyk1L3qD3B2K
 O3309cxOlaYrilWH2K6fN26SAiL12BzLwODkRKvt83oaTVvUGHjtRdtwSOev4HkawQKF
 +6KDmMfO98WeszYgol/8FBgD+IS+QHVvo7YsyiWqYhBF85jdtQUeQ4K/jwxAur4T4nzG
 1ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566172; x=1780170972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l28ofkRJlxkvRH8FsGwDhU3UycbwfeVDOFSGQjuE/8Y=;
 b=F1pCGkqQDFOIDG4vIfA2nNCQuTW0XJqPDU1cAob6+HfdATlqb28J1zSI4L/YUjNODC
 A5kMOJ6TPlFgKX0QT5wSEoUC0d1btDO3Bnp3ko3QdXokmX7zqfB/GycmL3oTe8jORFUR
 0jHgHNMugrJGh2Nz9y/J1yI7JtOAqZhQKDutWnjGwMqDiFz522IXHq28Ic6ttTgcNbUc
 e6LwgbQYeL7RYnNs9IVmwnDJFnW/GNG0rm+h7gDfhnOqOw6+bV9UFwpMMIicIXyAQDj8
 NrMaiknznSWpUJM7uYcze9or629v9Xad0tuFOKnhRHr23F6cHnujdCMNdO56rFRayQaQ
 p2sg==
X-Gm-Message-State: AOJu0Yys0nKGbTNkUNsd8rjMNiTR79LTQYSj4Y2an2hUc1JFU4SDwUt9
 jG1dPxeRj0C9F7Ozv8J7xjCumZNk59o5rtsBfXYQSyn9vX9WFLuh4hO4Ff23EFThqz/2WeaBiHu
 +Mg/1
X-Gm-Gg: Acq92OGQHRfI/RxKWdEn1f1PNCmu9P59+tA4FpBss64kKuwVdk6LUEILsLossDwWR5D
 ujX7OA3kZsF6oFI1fZmNRpy46QYpzjYLdv6eDOfvE8oVom4qM/gZXz+iUGLMdx+f7oeVimOtRR3
 N27gm2NbuDl0Dn15++tYURvuY1AuHFjoxoM9H4IuD5Vsx4kj0y8Eh1LnChbNniqbq1INbgWSl4h
 6TUdUAlSDaMeegc67vdoZoEF5Kyg8nmzXw0bPlzhFGBL6C0iz9hysE0BOEcmXfzWipPxoyoWL6Q
 un57aHMTaYvGfD9gsBkLmbg4VlGqyRzv2MNBkfesLw1mWUR0q0i+h7ysvns0+sBx39M4/XYaEiw
 fEVm/lpc0IlVT7diqNweuzG1Qs56zaZIcekP5gztly0p65SY2TT2skKCBYG8jujL8yd/h+aEJ9A
 agxeCB/OwSSNixacvre7Tw6lXoUHx75aBhzbNf/iuMIlbSsu/tZaTVgin1ZlveuA==
X-Received: by 2002:a05:7300:7fa6:b0:2ed:e14:7f54 with SMTP id
 5a478bee46e88-304490f655emr4144837eec.30.1779566171745; 
 Sat, 23 May 2026 12:56:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm5257271eec.13.2026.05.23.12.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:56:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 05/27] net/bonding: use stdatomic
Date: Sat, 23 May 2026 12:16:07 -0700
Message-ID: <20260523195604.441947-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195604.441947-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
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

