Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E582CCD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:57:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A390640689;
	Sat, 23 May 2026 21:56:21 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 0523040666
 for <dev@dpdk.org>; Sat, 23 May 2026 21:56:16 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-3042dffd80bso4802301eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566175;
 x=1780170975; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWV6khu0w4x+J4ZN9pn34Np9by7/Yw3slW8qG814vqs=;
 b=zMnDF1pEdXNdTIsIqOqxcIMQ8wKFDimXCkEVauUEFozAXfbqmHZnJ4KeRh1vn8OZYk
 Cc8hHeqk/xB9Pk4jDwv4h8+9vCA81EWj4jmX5KmBRwAH255vIkDvSrcyJqIioOfoODk+
 FJYyIT1TBvswMp0JHPNQEGenOvBHJ2rGJWEUbaSLtY0vrIv8u5PptrlflKDQ2ZwsikmD
 jv7mWUglSH91Pwz1lktbVdA/G6gDnVozNFWyalPjHWYf/oyHQOuDHvglC4OavUWlrrto
 qVbxGfql1V+n4inLqjZDvuQgL5kMzBHsrHXuLizS4ZVDo1RAggiqZevItDf74nzrvw0A
 6kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566175; x=1780170975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tWV6khu0w4x+J4ZN9pn34Np9by7/Yw3slW8qG814vqs=;
 b=YPiWpG6O9PgIm/0X2EI8cCkhKhkH5aiX9mon7Coom4tEJG3a+aeysCxvhms2ypoqt+
 mK/Z63x1elGdyizq2Ch+amwdb4GWJWt3RTJUJB3Hhs3LpMQY9I/084RLyip1J7ae4EYq
 DyspO6bp3Ny9575T3X6ZXVeALZRIF5TfILQemmdTSP+rVM/l4s/qcWi6Q3yG7LTodhRk
 oTfe+87NDoyW/qSRsM7jVyoy2ID9a5TltiWa86Is07b9kUIJHFl/JYGLhlo4hrOalwPs
 daBOH3zVU/SwMNmyQPOSrh7fSBV7lPGBQSDgsJFnvctyeU5HZRDH+/5rXO+6uuWsYKIn
 hzpQ==
X-Gm-Message-State: AOJu0YxyMJAgPAs4loqhkhC8kqdBquPuagMYMJaJ625dsi/zI6nuttC/
 Uao+J5XEfjeMO+kN/hZ8We1g+/z4zlQuOUodJO2zHMxjZtjzBO+tdkoswS2Brs8yYPcx8d3LTr7
 PLeXD
X-Gm-Gg: Acq92OGsfuNijhfiqEVRBLIkPyNGbrDLH3QP9MmwwSrwl+EDC7S37TqfSZZH8e6wuIy
 C0O/4WK6Jj7uPEbDNALVePbkBgN2aPG9wd0YLRl56RJ+v4pfy1nKtM1qTbPSrEDKSjBmYW6tCRk
 GCrAmg51pUdJdMGDJHPhFHN2zrmDmliP2CHRydFePLmRXvEWhgmSnrpTtfq45AeEsg932Qf/Yb2
 AexAT03evmvw0udHgYnT4byTaedR5cmp5SpcRJYF/YSgt1uPv35cd18LOF5AJGIywgDCyfUJ5sa
 FZ2aqk4YALKFhQu3OsjycOlqQezmteN7qvzs0rFCXWg1jYngIiouCTCfUO6bnNL7/bRQfGiMEE5
 Hc/Qgv2g3se1SJtbaXKXV+2Vihm6Yr1pAlSZsE2Wciv1JYWEoU/lSs+ZFV4QdbwS1WR+ScZ8Lqf
 x2MDLcPkHUjah17SdeoGNtZsllskgeubxjAeaezEaLLeGSsrrZS2n1/QlgQehkXg==
X-Received: by 2002:a05:7301:6588:b0:2c1:7afc:df06 with SMTP id
 5a478bee46e88-3044904e2bcmr4711050eec.5.1779566175066; 
 Sat, 23 May 2026 12:56:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm5257271eec.13.2026.05.23.12.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:56:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 09/27] net/enic: do not use deprecated rte_atomic64
Date: Sat, 23 May 2026 12:16:11 -0700
Message-ID: <20260523195604.441947-10-stephen@networkplumber.org>
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

