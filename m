Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EABCD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:07:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E90A40672;
	Thu, 21 May 2026 20:07:17 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 31463400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:15 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso7528320eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386834;
 x=1779991634; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l28ofkRJlxkvRH8FsGwDhU3UycbwfeVDOFSGQjuE/8Y=;
 b=S4uMx+4KjezwJIrJV5xrOcx2qnCk/bhQEa/cxH0xC5ON2jBezYXix3GDNvVWKAVFVk
 Jpihfg9xnofKIdK3/0SmMpEq05jxkEO8i+DjdzfEfbDRuPSYBXw/Wnhd/WAkzxNgCWl+
 IvCYUiHgbw3CTGgNsww/oT1pIAEhSwP8R41XeqUnYNT+zI0zD6OA0UpckyD7sPyN3wZo
 SnsYJNgTM09zt9aAkSJQw9wiGZcicSWQAXwHNCqTVDdSPgKJR1VfXF4d4HivluXSfcRZ
 dx2HpeOiAEa/MpLipgibWNgHPaSUBHQ/KWTJ1M/VK8fOVoEtO8r24juGnEOVEb7JhocK
 n9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386834; x=1779991634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l28ofkRJlxkvRH8FsGwDhU3UycbwfeVDOFSGQjuE/8Y=;
 b=ER1x052kUMaDJgiM0PIgS2O4iF8mFwL2vWyJzlIdVQuA2qQ8zaaAakew6EsrIgGQah
 fb8Ii1FEqwlJBY92Pt9CKr/Jg+AZRWN8WjovhiZnive9CDOfRYCzDvwlpL1y7sjJuNgs
 NAvz2sYWkAN0ZdC/cN4R5LbKfVJC+chTZPAA1evOj999smSl2/zKRIMT1RCL8QU6vdNv
 zV/NAehaK7tzaCyLDXkxiQf68Y060R2UPB8lDmQsgDqisTIycWK8LFKRekv6sKxUGlRJ
 H61wTpbF6c2n0HIHsVvCyaLYXZ6wJQ8SYtehrUwTg6ut6PZEJ7Rl+ryuo6K9uMokJ7hg
 D6Fw==
X-Gm-Message-State: AOJu0YzXCNmp8dyQdWKCQMC63PQlNsFfsB9hz42r8bS5kFCDQq25Wlkn
 7fjjDgPjL/ebBK66fTo3GKiWc4AGvecX74+C7jGPz0UThNPhk/ltsAfa00UxcEjuA8PUGDvPJCs
 JOooh
X-Gm-Gg: Acq92OHm88dNwQR3PQiYpxbcETvPlS7A/nRBjj9EV4bqiti1epscSZ2prbfBj87rOWt
 jOY3TgzJWi7kPZgymIG9mkFUk21Dbf/inhwfIpmAEf2qXu3Wja9CXxg3Hsp4ORPikzqAr7N/oUr
 1YQz0wNMHhaFrSUqSqHyUsb1pDiJk+fx0eD7/P/LDXf62JPR+gm3B/fgh5s3ZZ8zGio5i7Dcd3Z
 s4puOiIjLPzUr+KFdper6RzzC5BEq/UtN82mrcRFn7N365b2KoO8dCwZt8KoWePRruDsEXz0X8F
 M4l/F0ODrAiZOKWDIap662sh3VstszsSZkrM3ITygcmJq5G3jUYAqQ6oY+rXlz3b3fovAumO7n1
 YckQgwRBVC3pfVk2vhWbjmy5hc9f1IbY7n/HRmq3wbwesCX5zQLUKSAdTVdrViPvUQ+pmyihPBo
 v7vVL3YEVTS6f67oMwvcZu9a3Lrza91reFc9hBrlnb+nC0QuBRrE8xziaBUlCzgg==
X-Received: by 2002:a05:7300:cb86:b0:2ee:ade0:e0bf with SMTP id
 5a478bee46e88-304491fba87mr116180eec.30.1779386834130; 
 Thu, 21 May 2026 11:07:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [RFC v2 04/11] net/bonding: use stdatomic
Date: Thu, 21 May 2026 11:04:16 -0700
Message-ID: <20260521180706.678377-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
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

