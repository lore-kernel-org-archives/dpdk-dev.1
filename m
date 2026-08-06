Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661F2C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 812A140697;
	Thu,  6 Aug 2026 05:25:57 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3FCF040679
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:55 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so564110b3a.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986754;
 x=1786591554; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HXdhoPZ+8+g0AzzXgq9blN8r4PRv+rnc31fFH5PC2+8=;
 b=wzIDK6glQYTFy50qTUSEoH8ykWJCx66Y0g/IChYloQT4GPT2dyB6HGJP8eFRbEMpYB
 PBuqCmsZO9/1gUttRGg58ext1sxGKQC8yDpNbeLmtzVOLASVjQZXxdT8bBgqZvBKw4DI
 zwhbftjdcQPZKiZW/8q6CitMNoUJaPLSp8NPsiu6mAYxW62mkASxAqDMgZxP9sk/cJBK
 xdE3/F+YhL5Utq9s74RW6x9lhJ+fxFSSOyEAPENQ8joW45tKqXu0NWwImkVAFWjzsTg4
 0NsurUh6R1HxVA70pNODVcQ/XBKECVmERyPLRbva/6E/zJuGdZdU8mr+lu/Mf8QuXuV4
 ujjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986754; x=1786591554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HXdhoPZ+8+g0AzzXgq9blN8r4PRv+rnc31fFH5PC2+8=;
 b=QmU8XTxV9b67GodQ6jsjynkVTiO5liZzXBan3Ey6XAm9q+y1UzFhvqzG37u4oSx8Qf
 jEtj9L1hzW8iRhFwltSTVaCKyf1e0WoTmUlMMyT+fVuoRiPyMVEf61BsB+m/qjZqDhPr
 aUZjuJ35Madjf9CsIu6e+YahuY+Fa1eHvkG++YJ0nVhBFUfsNDbkkB26dKF9lxqcIBk7
 9seLXAiTqXco34S+3I4i3bb3uRtQGYJZD+0TyXiVaw9D98kxddq+18D4v58ScvAbmK8M
 yoL1M5E5+KVgzKP4wpiM+bahyPsORLJOpHvXoeKoEIoJYudHDY3s3ZCLcsJd/Te4PRMr
 4zJA==
X-Gm-Message-State: AOJu0YxYuLv8Lg0nbAecOSw4UsFNKQiX7znoSzYtNpkkiOQ7KXdZvLMT
 QuxkK6rwHDlLkLHIQVWClXqy9o+Jp51acStHgDwQbOa3Svr6p0dSGKpsl2S7dyWEUONIbj4Uiy7
 +/iPuGZ4=
X-Gm-Gg: AR+sD12m+FkBbE2H+dqEc3s7EmOf9Ta3KB5dX/+IOqXPJZZEjfpXdkuTc7gh+Pttv1F
 yp9nL3Lz3SSiw3y5MqKclODo8QTIMvBoZQJnnPcDar8aaGJ0SAUVNOryiDJpriCeYN1RR0pmWcg
 8n6OGyJj99DsRJLO5hWTOnHXJcq1KwyDEClRHkzb7uYT2AeL4i5enzuMZWRCPlBBT95mS5STa1q
 z4vX7wul9aqcdeHnwtjEL4ROOrnAgGRv3z/COovNz8bvPBP7mDm6GsbRjbP5ob/VzghURF5mhT7
 1kHg1Fj63fAMSZNng1Sn/nwGUtaL4njNDevb8970xy3Q73uDked10rGeyZJBtAsKUq77wAgbal1
 DDEoAT4VCISnoKEZG26G5rAt3jpKnZZsZ1BNPCIXd/se2644bbvesxI8E1sHvmHMFXgAqSq3EYI
 1AjgfGYRqO0De+MGP9J/qIu5cy8ZS67fCLcdT8MEFA0FtqlAYhQvqWQpiS4+gfc46lC5d8qVtxi
 JewBgh1lGKEWk0jY+UcIwLYQsw=
X-Received: by 2002:a05:6a21:498:b0:3c8:e304:99d0 with SMTP id
 adf61e73a8af0-3cb9bc7f231mr4861860637.0.1785986754401; 
 Wed, 05 Aug 2026 20:25:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hyong Youb Kim <hyonkim@cisco.com>, John Daley <johndale@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v7 06/24] net/enic: do not use deprecated rte_atomic64
Date: Wed,  5 Aug 2026 20:22:58 -0700
Message-ID: <20260806032544.21337-7-stephen@networkplumber.org>
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

The rte_atomic64 datatype and functions are deprecated.
This driver was only using it for error statistics where atomic
is not necessary. The DPDK PMD model is that statistics do
not have to be exact in face of contention.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hyong Youb Kim <hyonkim@cisco.com>
---
 drivers/net/enic/enic.h               |  6 +++---
 drivers/net/enic/enic_compat.h        |  1 -
 drivers/net/enic/enic_main.c          | 17 +++++++----------
 drivers/net/enic/enic_rxtx.c          | 14 ++++++--------
 drivers/net/enic/enic_rxtx_vec_avx2.c |  4 ++--
 5 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
index 87f6b35fcd..0a8d4a29ca 100644
--- a/drivers/net/enic/enic.h
+++ b/drivers/net/enic/enic.h
@@ -59,9 +59,9 @@
 #define ENICPMD_RXQ_INTR_OFFSET 1
 
 struct enic_soft_stats {
-	rte_atomic64_t rx_nombuf;
-	rte_atomic64_t rx_packet_errors;
-	rte_atomic64_t tx_oversized;
+	uint64_t rx_nombuf;
+	uint64_t rx_packet_errors;
+	uint64_t tx_oversized;
 };
 
 struct enic_memzone_entry {
diff --git a/drivers/net/enic/enic_compat.h b/drivers/net/enic/enic_compat.h
index 7cff6831b9..3ce4299e81 100644
--- a/drivers/net/enic/enic_compat.h
+++ b/drivers/net/enic/enic_compat.h
@@ -9,7 +9,6 @@
 #include <stdio.h>
 #include <unistd.h>
 
-#include <rte_atomic.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
 #include <rte_io.h>
diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index 2696fa77d4..fb9a5754c9 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -83,17 +83,15 @@ static void enic_log_q_error(struct enic *enic)
 static void enic_clear_soft_stats(struct enic *enic)
 {
 	struct enic_soft_stats *soft_stats = &enic->soft_stats;
-	rte_atomic64_clear(&soft_stats->rx_nombuf);
-	rte_atomic64_clear(&soft_stats->rx_packet_errors);
-	rte_atomic64_clear(&soft_stats->tx_oversized);
+
+	memset(soft_stats, 0, sizeof(*soft_stats));
 }
 
 static void enic_init_soft_stats(struct enic *enic)
 {
 	struct enic_soft_stats *soft_stats = &enic->soft_stats;
-	rte_atomic64_init(&soft_stats->rx_nombuf);
-	rte_atomic64_init(&soft_stats->rx_packet_errors);
-	rte_atomic64_init(&soft_stats->tx_oversized);
+
+	memset(soft_stats, 0, sizeof(*soft_stats));
 	enic_clear_soft_stats(enic);
 }
 
@@ -132,7 +130,7 @@ int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats,
 	 * counted in ibytes even though truncated packets are dropped
 	 * which can make ibytes be slightly higher than it should be.
 	 */
-	rx_packet_errors = rte_atomic64_read(&soft_stats->rx_packet_errors);
+	rx_packet_errors = soft_stats->rx_packet_errors;
 	rx_truncated = rx_packet_errors - stats->rx.rx_errors;
 
 	r_stats->ipackets = stats->rx.rx_frames_ok - rx_truncated;
@@ -142,12 +140,11 @@ int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats,
 	r_stats->obytes = stats->tx.tx_bytes_ok;
 
 	r_stats->ierrors = stats->rx.rx_errors + stats->rx.rx_drop;
-	r_stats->oerrors = stats->tx.tx_errors
-			   + rte_atomic64_read(&soft_stats->tx_oversized);
+	r_stats->oerrors = stats->tx.tx_errors + soft_stats->tx_oversized;
 
 	r_stats->imissed = stats->rx.rx_no_bufs + rx_truncated;
 
-	r_stats->rx_nombuf = rte_atomic64_read(&soft_stats->rx_nombuf);
+	r_stats->rx_nombuf = soft_stats->rx_nombuf;
 	return 0;
 }
 
diff --git a/drivers/net/enic/enic_rxtx.c b/drivers/net/enic/enic_rxtx.c
index 549a153332..c87d947b93 100644
--- a/drivers/net/enic/enic_rxtx.c
+++ b/drivers/net/enic/enic_rxtx.c
@@ -112,7 +112,7 @@ enic_recv_pkts_common(void *rx_queue, struct rte_mbuf **rx_pkts,
 		/* allocate a new mbuf */
 		nmb = rte_mbuf_raw_alloc(rq->mp);
 		if (nmb == NULL) {
-			rte_atomic64_inc(&enic->soft_stats.rx_nombuf);
+			++enic->soft_stats.rx_nombuf;
 			break;
 		}
 
@@ -185,7 +185,7 @@ enic_recv_pkts_common(void *rx_queue, struct rte_mbuf **rx_pkts,
 		}
 		if (unlikely(packet_error)) {
 			rte_pktmbuf_free(first_seg);
-			rte_atomic64_inc(&enic->soft_stats.rx_packet_errors);
+			++enic->soft_stats.rx_packet_errors;
 			continue;
 		}
 
@@ -303,7 +303,7 @@ enic_noscatter_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		if (unlikely(cqd->bytes_written_flags &
 			     CQ_ENET_RQ_DESC_FLAGS_TRUNCATED)) {
 			rte_pktmbuf_free(*rxmb++);
-			rte_atomic64_inc(&enic->soft_stats.rx_packet_errors);
+			++enic->soft_stats.rx_packet_errors;
 			cqd++;
 			continue;
 		}
@@ -505,14 +505,12 @@ uint16_t enic_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint8_t offload_mode;
 	uint16_t header_len;
 	uint64_t tso;
-	rte_atomic64_t *tx_oversized;
 
 	enic_cleanup_wq(enic, wq);
 	wq_desc_avail = vnic_wq_desc_avail(wq);
 	head_idx = wq->head_idx;
 	desc_count = wq->ring.desc_count;
 	ol_flags_mask = RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_IP_CKSUM | RTE_MBUF_F_TX_L4_MASK;
-	tx_oversized = &enic->soft_stats.tx_oversized;
 
 	nb_pkts = RTE_MIN(nb_pkts, ENIC_TX_XMIT_MAX);
 
@@ -527,7 +525,7 @@ uint16_t enic_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/* drop packet if it's too big to send */
 		if (unlikely(!tso && pkt_len > ENIC_TX_MAX_PKT_SIZE)) {
 			rte_pktmbuf_free(tx_pkt);
-			rte_atomic64_inc(tx_oversized);
+			++enic->soft_stats.tx_oversized;
 			continue;
 		}
 
@@ -558,7 +556,7 @@ uint16_t enic_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			if (unlikely(header_len == 0 || ((tx_pkt->tso_segsz +
 			    header_len) > ENIC_TX_MAX_PKT_SIZE))) {
 				rte_pktmbuf_free(tx_pkt);
-				rte_atomic64_inc(tx_oversized);
+				++enic->soft_stats.tx_oversized;
 				continue;
 			}
 
@@ -681,7 +679,7 @@ static void enqueue_simple_pkts(struct rte_mbuf **pkts,
 		 */
 		if (unlikely(p->pkt_len > ENIC_TX_MAX_PKT_SIZE)) {
 			desc->length = ENIC_TX_MAX_PKT_SIZE;
-			rte_atomic64_inc(&enic->soft_stats.tx_oversized);
+			++enic->soft_stats.tx_oversized;
 		}
 		desc++;
 	}
diff --git a/drivers/net/enic/enic_rxtx_vec_avx2.c b/drivers/net/enic/enic_rxtx_vec_avx2.c
index 600efff270..53589ab788 100644
--- a/drivers/net/enic/enic_rxtx_vec_avx2.c
+++ b/drivers/net/enic/enic_rxtx_vec_avx2.c
@@ -81,7 +81,7 @@ enic_noscatter_vec_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		if (unlikely(cqd->bytes_written_flags &
 			     CQ_ENET_RQ_DESC_FLAGS_TRUNCATED)) {
 			rte_pktmbuf_free(*rxmb++);
-			rte_atomic64_inc(&enic->soft_stats.rx_packet_errors);
+			++enic->soft_stats.rx_packet_errors;
 		} else {
 			*rx++ = rx_one(cqd, *rxmb++, enic);
 		}
@@ -761,7 +761,7 @@ enic_noscatter_vec_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		if (unlikely(cqd->bytes_written_flags &
 			     CQ_ENET_RQ_DESC_FLAGS_TRUNCATED)) {
 			rte_pktmbuf_free(*rxmb++);
-			rte_atomic64_inc(&enic->soft_stats.rx_packet_errors);
+			++enic->soft_stats.rx_packet_errors;
 		} else {
 			*rx++ = rx_one(cqd, *rxmb++, enic);
 		}
-- 
2.53.0

