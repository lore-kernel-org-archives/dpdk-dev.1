Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E63CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EF0D42E4A;
	Tue, 29 Sep 2026 16:04:25 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 08CA342DF0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:19 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-86b90133ae8so2012955b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690658;
 x=1791295458; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TpQ6k867EL4e3/O3XVIooK46T2H3XhHHVg03JJEA84k=;
 b=gLPPvMsvDMLTVm1POImnX3IkyEGK3cu1R+5ZXfobozdnrq2rToCX1JVkDHUjRuP+8d
 MAo5L/gwC5i7FiDdxX6Bb6AVVjLLdX0z2LcLpEfnjnynkEx4/kvq6ojMR3e/zexl2McF
 vrG1cBOsiXBxQ0HqVGwqRpEiQR4bGQp3EALQx1PaQP6clm5V8Usg1yoi+0ga1W33ZdIF
 URQx8YsOD3I/h1lnN/P8cuMrAEUfdmL90JdJvgWjLz3CDJYG4fROuU+yGtDYiWLTLMW0
 dcID2Dce9cpeGxUKmiFi2kTfkEIgYxZlG46Uy0j/85sO93qz9YCGhGeYCTdnGSMFjg7W
 V6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690658; x=1791295458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TpQ6k867EL4e3/O3XVIooK46T2H3XhHHVg03JJEA84k=;
 b=PxwZ6vmFku6MNe4tql+fg23nIGFjwkcEJs1lOc3N9qqhb5Su3BTtp9ByI+FeSuozDr
 f5+/RbenllhHmhZZtBpqQZBbL5yGretZMnYYqjxylsjzDALUNlvOkE/B6B4PzpKhcjg+
 h22k6FOh1scBtb6tb/GLLYXM7dulSimZF2Asxw5ukwMV5ArpjQJpNgUayg0H5v0x5QXm
 c1PbG3lV3xT+tNmAys7ARhlH9l4kpFdpLbXMFAM3I9RzrC69fEyGwa0ny4YAXWNfd2xL
 npCKjclp3UOC7WH28qXmZg8JCBHErrQvO2LDU/2I0zPgWpQm1tyFc0DVraZF1HursClm
 wA/A==
X-Gm-Message-State: AFuF++mGt/Hvjgi/5pr7/9lT0gaTVD3mC8E9GfU7vjbeliSb+LRw1nYt
 n7O3LrH6x1zhpDbC7gZ7dZeAcPdHzaJt9r+acXVdux3545S8Ez2idVsU1XZ8N5pFIcuM06bPbwf
 SjRH/BRI=
X-Gm-Gg: AYBFou0QQfd4WCyXa7qqcD36lD9dnZWhxdVVkvceW26l5PFKgcphd8eslOK99aZLdbY
 2JhmW5bd/nFKx0d2J0LzQ+HnM7Tq17cH3590qP9clyVayl6qnMHPUijh01EzsyNyGlihFuyQsVv
 n30o32pb6SRAMoc1Y9LzysN2oRZOzYqcoSrBrc6zW/XeTfG/2EfwvDY/L2yFYQb3qHduGbbxOL5
 lvt5rF37C5FR7FdyNsib31cQ/+KfPBNWNPKBC/whplBdIyJVcRuSDZP8ucY6zocEiRy9URinQQ8
 c9woRhOUy0uDkvlBm8wGYef4QNb1h1nSXtO52cLL33a/ICza2sl1QRyW0pAl7YJpNxQLlJH59yi
 11R5rQQUlDF2mvJs7vI5c/GOCCx/iprMkgGxztKfH8MQ7LVypd2FMTpH9uBitzTz8ZdeYf8Jdxk
 Y2es0QmbkhzyaPqRNGvHWhefMtRmefmntpVy0z6OUGv3JuF3kf89n6GGgXZXJmTPsjB437WE159
 +Nf+sAEwzYTwsQULrNn9CCmdgBQmo2ADnRQCw==
X-Received: by 2002:a05:6a00:4515:b0:881:e737:8213 with SMTP id
 d2e1a72fcca58-881e737874cmr6813129b3a.7.1790690658038; 
 Tue, 29 Sep 2026 07:04:18 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hyong Youb Kim <hyonkim@cisco.com>, John Daley <johndale@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v9 06/25] net/enic: do not use deprecated rte_atomic64
Date: Tue, 29 Sep 2026 07:01:52 -0700
Message-ID: <20260929140409.234453-7-stephen@networkplumber.org>
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

The rte_atomic64 datatype and functions are deprecated.
This driver was only using it for error statistics where atomic
is not necessary. The DPDK PMD model is that statistics do
not have to be exact in face of contention.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hyong Youb Kim <hyonkim@cisco.com>
---
 drivers/net/enic/enic.h               |  6 +++---
 drivers/net/enic/enic_compat.h        |  1 -
 drivers/net/enic/enic_main.c          | 21 +++++----------------
 drivers/net/enic/enic_rxtx.c          | 14 ++++++--------
 drivers/net/enic/enic_rxtx_vec_avx2.c |  4 ++--
 5 files changed, 16 insertions(+), 30 deletions(-)

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
index 2a1a65d8da..0c7f085d66 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -83,18 +83,8 @@ static void enic_log_q_error(struct enic *enic)
 static void enic_clear_soft_stats(struct enic *enic)
 {
 	struct enic_soft_stats *soft_stats = &enic->soft_stats;
-	rte_atomic64_clear(&soft_stats->rx_nombuf);
-	rte_atomic64_clear(&soft_stats->rx_packet_errors);
-	rte_atomic64_clear(&soft_stats->tx_oversized);
-}
 
-static void enic_init_soft_stats(struct enic *enic)
-{
-	struct enic_soft_stats *soft_stats = &enic->soft_stats;
-	rte_atomic64_init(&soft_stats->rx_nombuf);
-	rte_atomic64_init(&soft_stats->rx_packet_errors);
-	rte_atomic64_init(&soft_stats->tx_oversized);
-	enic_clear_soft_stats(enic);
+	memset(soft_stats, 0, sizeof(*soft_stats));
 }
 
 int enic_dev_stats_clear(struct enic *enic)
@@ -132,7 +122,7 @@ int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats,
 	 * counted in ibytes even though truncated packets are dropped
 	 * which can make ibytes be slightly higher than it should be.
 	 */
-	rx_packet_errors = rte_atomic64_read(&soft_stats->rx_packet_errors);
+	rx_packet_errors = soft_stats->rx_packet_errors;
 	rx_truncated = rx_packet_errors - stats->rx.rx_errors;
 
 	r_stats->ipackets = stats->rx.rx_frames_ok - rx_truncated;
@@ -142,12 +132,11 @@ int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats,
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
 
@@ -1313,7 +1302,7 @@ int enic_setup_finish(struct enic *enic)
 	int err;
 
 	ENICPMD_FUNC_TRACE();
-	enic_init_soft_stats(enic);
+	enic_clear_soft_stats(enic);
 
 	/*
 	 * Enable admin channel so we can perform certain devcmds
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

