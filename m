Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0990ECD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:08:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1564F406A2;
	Thu, 21 May 2026 20:07:23 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 8758040658
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:19 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so21649049eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386839;
 x=1779991639; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWV6khu0w4x+J4ZN9pn34Np9by7/Yw3slW8qG814vqs=;
 b=kUKKyiBhepW1gvK1Uo4Bl2md3wh3aHgjY/wnUTfTH+snyqGaoevF1GXoihIVGJXmft
 OpuqvD52+rAplE7hRp/jyoGNQ9FjvQM5sflv+FGC+q0zXCTfM6LkUPeEUTGX8jGjiXV5
 XaGLO+w241Q1vkuUFp/sUaXYuYAapmlgZpORuV5AWS0PhJwV2Wy659Sxy3C0Lhd55DZ+
 sBlZ5dPK0uCFrHa7t+9OmVZlC+ird9kmuMmM5GWuhADM8pY0li01NdGAC6eiYQfXp2N2
 WKeonbg/q+rv/Yig4/cBbw4z/cAfk9V8ZLk6D/vJKOG3wm9qC8F70UCeYkAma2S63ExM
 hkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386839; x=1779991639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tWV6khu0w4x+J4ZN9pn34Np9by7/Yw3slW8qG814vqs=;
 b=lWEsGm4rrW4TW+soHn/aQg+3ialJezbQLGnY+8lFBbyHyNh/dgd9rxILzTysCC4/1M
 eCxsFu8r5pbEcfZSrl6w4fLLsclNP2wxiCRxYR7Mnzirv+KPiyB775HSH3CRButE0uoO
 OgiCsyVFTDmiIKvEAfnuMYg5oud7APaBF3g9V8eR8WwyaLHxu6x18iHPq5Pzk6lj7mHV
 jWNvASXa4Yiu2VAUd2BlLJ/yvliU4YHUoD+57i28XdtLrms0m9yBrlXeCo4yZrzumD+S
 Eeq9vkOJZBtLcRnysLfIzJcquRCq7WkCjxb8m+Rdu//y0N4DfsLEFQwG8NAh/MbY2zhd
 esZg==
X-Gm-Message-State: AOJu0YwEttkTXjeEsF4LFIRnF8uCumbsd9KOS2SX5hb+ali58pujOhHM
 XaxMkg2EfXUa3zfMbHjdl9PXyeBwLWQ7f8l3Kijr0pm9a+toKeIaa2Qh368Ljznq5mSRU4r5IhP
 Ug7zQ
X-Gm-Gg: Acq92OEMmz65A+Stal4Hx//smAJNiexNmGwJJ9Of8DUgY4eQ3C+yXLsAIoWHcjBJdLB
 TG6lRJdfteRbsEEEHGNL5GZY41iEXuhrbnjNqXnKXr8dB4pDG2vQXN5ufWbcU7FdgAJqeocoLZq
 b+RzAQ6zwnVhGIGWg3XuMsoIxazIoHJxGyb8GuF/EdELiRcE9WZ06bXOadOxObWj1BZvK8c6EHk
 xypf9tQdjgbOYnY1ifDsm9pOH1Y7T4RsAjwS6MU0/dqc7ExIvwhRK3d9tnK0Y8cZxYyksGLbiaY
 TIhDpW9mLX9yVuT89o4PStoWcnP4Bal4zmso3a3WIqaRWxs8zXcy+5AicmtDJRT8Ot6n5ej1yUm
 YJHJVD5IUlQEgeY01c9mHrt9VfgRbacTsdNALBYCikOJDJr+yMiRs9RO5ECiWeasGzfc2S3VzQO
 obSRK3HaHwHg6ud/vrtuUDhdHBJfaGz/xIJeQ3uRIFuqdBupzNNLlnH9if1veFJQ==
X-Received: by 2002:a05:7300:b104:b0:304:ab8:f899 with SMTP id
 5a478bee46e88-30448ff1322mr149549eec.8.1779386838544; 
 Thu, 21 May 2026 11:07:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [RFC v2 08/11] net/enic: do not use deprecated rte_atomic64
Date: Thu, 21 May 2026 11:04:20 -0700
Message-ID: <20260521180706.678377-9-stephen@networkplumber.org>
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

The rte_atomic64 datatype and functions are deprecated.
This driver was only using it for error statistics where atomic
is not necessary. The DPDK PMD model is that statistics do
not have to be exact in face of contention.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

