Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46234C28B30
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 21:01:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39D38402E6;
	Mon, 10 Mar 2025 22:01:42 +0100 (CET)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6FDFF402D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 22:01:41 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-3f8ae3ed8f4so763887b6e.3
 for <dev@dpdk.org>; Mon, 10 Mar 2025 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1741640500; x=1742245300; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ld3BrGet5aj14i17M9hk8uYMuL5M32Xsn4LQIEM/kY4=;
 b=ORBhxlBdVJxKA8hmwwCiPXLzJJdquDiRlF7jcvpPZT3YOHWLeulKWLrAPAMcBOH4j0
 G4qxUnkOyfC+WA6TjDL+8L0oOqNLjq2SoPIZEluW4A9U3dM3iuTecaywWqCm1H893QRR
 UkJ5Qse5oA5NWljHV+8SI0nn1ZaHCtc3bxqUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741640500; x=1742245300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ld3BrGet5aj14i17M9hk8uYMuL5M32Xsn4LQIEM/kY4=;
 b=QHrdNQtSBiGqiNas+5Sm6GtgDt86cHhyJHYdDjhPMpdrQ/VlgvaXiDZ83dAlvnygfI
 GezmMBUtGRC/nv2qMg8GvRW4dRxUtfM7PYA3KPfHZyfzfssGmw5kfwKla3TfHcAF5H0I
 ZZ6kmGvxlv4320YQzLy6Ci4YkmsdJ6SBHgJj6vtNLkZ3KGMp2OcCoJFmoSNX+2JURl0T
 bPW0c1xd7RiffI88YHnhLcM8lKc7bFsPoY2TY5QLLdLOSFYXRMmu76rIBdKuyxqjAL+g
 rWiSjKe1dU1omzoziE8n2EvAwy4XckEGy9dNL9mgqGLHZuQlJtPlrkZdUNYj2Iux3TvB
 4dkA==
X-Gm-Message-State: AOJu0YzQfaxv85F2JEVvQ2zfHXhKWWj/KY2u0J8nyCBoDimonaxaU4ON
 6hXUcsR3jAw3xyfnk6SDtzlluWzea8UjOOF1Ots0k9dIrFZXcXvyeNgymj1So89XrSDMhBg26lU
 IUL6CJTu4UY2NlNElWgqlCOHp4TCOX5XuhOYo3aiSQKOrqbc0qntkw1OfZhh96bNxTMEEQBAVK3
 Kpd1IMSXoj8EmZEHT9U3XR3t5eSqlG
X-Gm-Gg: ASbGnct52+xTCvYAIAK1f628W11F6As+vTnypb4+7Efu91UFP+ixgxi8ENypb78xWCA
 8LhjV0rlnzlqxgV2UFj9toQpd5RDvwnnx2yV4TVYC3ZXcaWycCOK1Inw6ZDv7A4tCEDaKTjfWKp
 JiGmuBv48Qsmq04eTyJwfMokXCyQbLLrl57z73Uxyt0mnlE+KuQkqqpQs7XfzB5doXEmqEsMjlK
 m8CkYXajwYP4c+JT/Z0HBnCIZ1QQ917eJsmosknYf4bzwcu+QkpAs6noZqRmNSXUvfFeo0w7xvm
 sAUPVwYwgO2uV35YnUtOvsv/IuYFM7YVOCmR+qlfbC3xyf4Vt3mQnuaSaYAdGP6ZMIMsgPQmZrS
 4FtjsVLHjy8ptPnF5+1b08IrcNmGVLnSE+4rtJhs5JbDHui8W
X-Google-Smtp-Source: AGHT+IGxKiAibIMw6ERJZ3LhPUG5s060aSFUW6mw+8BhMZxKsteH5A0yqbU5Q3sg7LuXzH7uz6Gesg==
X-Received: by 2002:a05:6808:1a13:b0:3f8:3eeb:11a2 with SMTP id
 5614622812f47-3f83eeb1b52mr3963082b6e.26.1741640500309; 
 Mon, 10 Mar 2025 14:01:40 -0700 (PDT)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f7dcdc4050sm1034092b6e.40.2025.03.10.14.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 14:01:39 -0700 (PDT)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH 1/2] net/bnxt: configure burst threshold based on speed
Date: Mon, 10 Mar 2025 14:01:31 -0700
Message-Id: <20250310210132.48829-2-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250310210132.48829-1-ajit.khaparde@broadcom.com>
References: <20250310210132.48829-1-ajit.khaparde@broadcom.com>
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

The fixed value of Rx burst threshold may not be optimal
for all the NIC speeds. For high speed NIC ports, like 400G
configure a higher Rx burst value.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c        | 20 ++++++++++++++++++++
 drivers/net/bnxt/bnxt_rxq.h           |  1 +
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c | 18 ++++++++++--------
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c |  9 +++++----
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c  | 18 ++++++++++--------
 5 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 144d4377bd..a0e3cd8bbe 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1793,10 +1793,27 @@ int bnxt_dev_stop_op(struct rte_eth_dev *eth_dev)
 	return bnxt_dev_stop(eth_dev);
 }
 
+static void bnxt_update_max_rx_burst(struct bnxt *bp, struct rte_eth_link *link)
+{
+	if (link->link_speed == RTE_ETH_SPEED_NUM_400G) {
+		uint32_t i;
+
+		/* Faster port speed. Update threshold.  Else use default. */
+		for (i = 0; i < bp->rx_nr_rings; i++) {
+			struct bnxt_rx_queue *rxq = bp->rx_queues[i];
+
+			rxq->rx_free_thresh =
+				RTE_MIN(rte_align32pow2(rxq->nb_rx_desc) / 4,
+					RTE_BNXT_MAX_RX_BURST_TH2);
+		}
+	}
+}
+
 int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
 	uint64_t rx_offloads = eth_dev->data->dev_conf.rxmode.offloads;
+	struct rte_eth_link *link = &eth_dev->data->dev_link;
 	int vlan_mask = 0;
 	int rc, retry_cnt = BNXT_IF_CHANGE_RETRY_COUNT;
 
@@ -1877,6 +1894,8 @@ int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 	eth_dev->rx_pkt_burst = bnxt_receive_function(eth_dev);
 	eth_dev->tx_pkt_burst = bnxt_transmit_function(eth_dev);
 
+	bnxt_update_max_rx_burst(bp, link);
+
 	bnxt_schedule_fw_health_check(bp);
 
 	if (BNXT_P5_PTP_TIMESYNC_ENABLED(bp))
@@ -2114,6 +2133,7 @@ int bnxt_link_update_op(struct rte_eth_dev *eth_dev, int wait_to_complete)
 		rte_eth_linkstatus_set(eth_dev, &new);
 		bnxt_print_link_info(eth_dev);
 	}
+	bnxt_update_max_rx_burst(bp, &new);
 
 	return rc;
 }
diff --git a/drivers/net/bnxt/bnxt_rxq.h b/drivers/net/bnxt/bnxt_rxq.h
index 0b411a941a..cd49faf4cf 100644
--- a/drivers/net/bnxt/bnxt_rxq.h
+++ b/drivers/net/bnxt/bnxt_rxq.h
@@ -8,6 +8,7 @@
 
 /* Maximum receive burst supported in vector mode. */
 #define RTE_BNXT_MAX_RX_BURST		64U
+#define RTE_BNXT_MAX_RX_BURST_TH2	296U
 
 /* Drop by default when receive desc is not available. */
 #define BNXT_DEFAULT_RX_DROP_EN		1
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 43d9528134..35550534de 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -660,18 +660,19 @@ uint16_t
 bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
 {
+	struct bnxt_rx_queue *rxq = rx_queue;
+	uint32_t brst = rxq->rx_free_thresh;
 	uint16_t cnt = 0;
 
-	while (nb_pkts > RTE_BNXT_MAX_RX_BURST) {
+	while (nb_pkts > brst) {
 		uint16_t burst;
 
-		burst = recv_burst_vec_avx2(rx_queue, rx_pkts + cnt,
-					     RTE_BNXT_MAX_RX_BURST);
+		burst = recv_burst_vec_avx2(rx_queue, rx_pkts + cnt, brst);
 
 		cnt += burst;
 		nb_pkts -= burst;
 
-		if (burst < RTE_BNXT_MAX_RX_BURST)
+		if (burst < brst)
 			return cnt;
 	}
 	return cnt + recv_burst_vec_avx2(rx_queue, rx_pkts + cnt, nb_pkts);
@@ -681,18 +682,19 @@ uint16_t
 bnxt_crx_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 		       uint16_t nb_pkts)
 {
+	struct bnxt_rx_queue *rxq = rx_queue;
+	uint32_t brst = rxq->rx_free_thresh;
 	uint16_t cnt = 0;
 
-	while (nb_pkts > RTE_BNXT_MAX_RX_BURST) {
+	while (nb_pkts > brst) {
 		uint16_t burst;
 
-		burst = crx_burst_vec_avx2(rx_queue, rx_pkts + cnt,
-					     RTE_BNXT_MAX_RX_BURST);
+		burst = crx_burst_vec_avx2(rx_queue, rx_pkts + cnt, brst);
 
 		cnt += burst;
 		nb_pkts -= burst;
 
-		if (burst < RTE_BNXT_MAX_RX_BURST)
+		if (burst < brst)
 			return cnt;
 	}
 	return cnt + crx_burst_vec_avx2(rx_queue, rx_pkts + cnt, nb_pkts);
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
index 840b21cef9..03f39280e5 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
@@ -317,18 +317,19 @@ recv_burst_vec_neon(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 uint16_t
 bnxt_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
+	struct bnxt_rx_queue *rxq = rx_queue;
+	uint32_t brst = rxq->rx_free_thresh;
 	uint16_t cnt = 0;
 
-	while (nb_pkts > RTE_BNXT_MAX_RX_BURST) {
+	while (nb_pkts > brst) {
 		uint16_t burst;
 
-		burst = recv_burst_vec_neon(rx_queue, rx_pkts + cnt,
-					    RTE_BNXT_MAX_RX_BURST);
+		burst = recv_burst_vec_neon(rx_queue, rx_pkts + cnt, brst);
 
 		cnt += burst;
 		nb_pkts -= burst;
 
-		if (burst < RTE_BNXT_MAX_RX_BURST)
+		if (burst < brst)
 			return cnt;
 	}
 
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
index c1c3e1ecaf..7d455b6f56 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
@@ -517,18 +517,19 @@ crx_burst_vec_sse(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 uint16_t
 bnxt_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
+	struct bnxt_rx_queue *rxq = rx_queue;
+	uint32_t brst = rxq->rx_free_thresh;
 	uint16_t cnt = 0;
 
-	while (nb_pkts > RTE_BNXT_MAX_RX_BURST) {
+	while (nb_pkts > brst) {
 		uint16_t burst;
 
-		burst = recv_burst_vec_sse(rx_queue, rx_pkts + cnt,
-					   RTE_BNXT_MAX_RX_BURST);
+		burst = recv_burst_vec_sse(rx_queue, rx_pkts + cnt, brst);
 
 		cnt += burst;
 		nb_pkts -= burst;
 
-		if (burst < RTE_BNXT_MAX_RX_BURST)
+		if (burst < brst)
 			return cnt;
 	}
 
@@ -538,18 +539,19 @@ bnxt_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 uint16_t
 bnxt_crx_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
+	struct bnxt_rx_queue *rxq = rx_queue;
+	uint32_t brst = rxq->rx_free_thresh;
 	uint16_t cnt = 0;
 
-	while (nb_pkts > RTE_BNXT_MAX_RX_BURST) {
+	while (nb_pkts > brst) {
 		uint16_t burst;
 
-		burst = crx_burst_vec_sse(rx_queue, rx_pkts + cnt,
-					   RTE_BNXT_MAX_RX_BURST);
+		burst = crx_burst_vec_sse(rx_queue, rx_pkts + cnt, brst);
 
 		cnt += burst;
 		nb_pkts -= burst;
 
-		if (burst < RTE_BNXT_MAX_RX_BURST)
+		if (burst < brst)
 			return cnt;
 	}
 
-- 
2.39.5 (Apple Git-154)

