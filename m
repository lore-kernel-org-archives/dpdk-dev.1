Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE9CD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E6A440696;
	Sat, 20 Jun 2026 04:31:49 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9320440656
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:47 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-7ff05e5d009so28231957b3.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922707;
 x=1782527507; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWV6khu0w4x+J4ZN9pn34Np9by7/Yw3slW8qG814vqs=;
 b=0yRgAuwKx8NhbSJq1oHkFHGeuh+8UrBSEsO/dHI4+YBhXP3yc45kOhqz3IqwTTTy08
 SSbQaJfAQoAJHkmWmbk7fkN5Sa/+iPiXekPCcLbs+y6fP26025RzSRZrllT5HQePcoFA
 S8RuircKW7IOjzvhv5u34B4r2bbM8A0poCjcyvD7aeRDMEHgV3guGdWeHu09Ej3z0DkQ
 uAL/lzaL8gXM7FmYuTj67Y56/4vo7E4h9AYaNS5s3RPfaINRYjEQMpNM3EYCOeKqQ/bZ
 30E73z/IoY/2o/crib+XtbWSLdSdOD5ZyrqHooT8aPSp7SjdvK5DGAe2BSDutzL91djb
 KCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922707; x=1782527507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tWV6khu0w4x+J4ZN9pn34Np9by7/Yw3slW8qG814vqs=;
 b=iSazUSxuFQNrjszjpi4UxDfnNBcuIc4h1cFAyujHA1rHeKDJdmTs7AVBX3NDmdcnX7
 JhUpNwMlX8cTWbxZ90L2T+oYKPv0GNIx4zdbGiAk649lrNakuSttGyJzmWNhxpHLZdzv
 QEeutfJGYWVAuEwCf7Mi6eABLtOx4rT80NQPaXMDaMPztM2alV4K9YPUbMTkk8pHvmGT
 CfXGBxn5WoMBYeh0d9WbOVW0Q7AOMilhTRnetgcyzZUBKkAPx7T/UnoBzRxXUVeRzAGP
 RqGsAz0Fp9sCHoce81CfgUok4dCNuR8OxDcBQQY+WQpwPVraxSkYSAaao0iAXI5THmtS
 vI8g==
X-Gm-Message-State: AOJu0Ywg1x6aewbp+HVfQdbR1TPm3CG8pWzy9RjLImBY79seN3muKeuB
 geyN4Jll3v4qmOeVeAHdsKnINmW6Rb9owHxhskiPcEUODq90un7wa/REIpNF55GkhCDcvkSsi0K
 HoxYC
X-Gm-Gg: AfdE7clxThkIGU7X1q+3dNTJN6LP5D3Vke8lBCbCRZeUH51nnoKU9dcd26woFZYtxlX
 I1WZRkpb38I26XImgJzGGHMqFM4HkMCcIt8wnURoHxcHR1TwDiPcKf1nDMi/QizmAq8Ff7c7Ajx
 n0xws5zmODOWYBHzq1bRLoOd2PNiJATV/3VkuyqEW1zPSgBcG9l97TcKKgNbFKGZMg6xapQk2pu
 tXK9zuTnf2qHMmofFVAzuj/PBv5Ee7HikoEEdOV4zo8jVr/WPZ3yhQOeh2uedjjeFTRPfsusYkf
 RtvaTIebaBATTTRrlFwkzKA0cXrmlHpxeJJgjtqz9ohx8Eig57SGzpJ/QJrc/qtsd/u4bwQT0g4
 s7w+1PXNtri4Syc1Jtq2CaRow0IzLP33kSScKUtRP5FJOSn7EjxNcrTOxyW5LWW+/9XBh0W3d9P
 cTG+aJB55qh5br0i93IK9GGCHXoXcWSdqd+wz8VrfSlF3KH2Y+xa4=
X-Received: by 2002:a05:690c:7402:b0:7f8:7e31:28a7 with SMTP id
 00721157ae682-8017866845bmr57154107b3.47.1781922706813; 
 Fri, 19 Jun 2026 19:31:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v5 06/24] net/enic: do not use deprecated rte_atomic64
Date: Fri, 19 Jun 2026 19:28:31 -0700
Message-ID: <20260620023134.42877-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

