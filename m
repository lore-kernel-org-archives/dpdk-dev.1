Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152D606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=KT95qdFQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA15740EF0;
	Wed, 25 Nov 2026 18:06:17 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTPS id 32BD340DF6
 for <dev@dpdk.org>; Wed, 25 Nov 2026 18:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=BHuzpZEFF93sFZG3DpXI+xBG7wNeRa3TuD1qcfIhPX4=;
 b=KT95qdFQpI9vLvLyoCRaWCSSUmanJsczAIw83PN5k1AP3dmd9+3B+a8tRlJC5t
 E3Kmn74E8Lbd8/YfwVe5d/ClGCBTKIVKBhKkeF3Wi6suErYgrbBq8T5fEuykTJ4u
 XXDEeef4wNdvyCgin0i1nqkSqDRW33Yc3qGeAPyG/xGpI=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 20/30] net/hinic3: update RSS hash type configuration
Date: Thu, 26 Nov 2026 01:04:14 +0800
Message-ID: <20261125170425.5430-21-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S22
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cw4UJw4fuF4UJr1xXr4ktFb_yoWDurykpa
 yUGa9rJrWDJrZ7Xwn8Cw47u3W5Wws2y3yIg3y8Xa4Y9F4kXr18Aa4jy3yDZrs0q3yxA3W2
 vay0v3s8K3WjvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeeHDUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQ-8B2sHFW8fxQAA3N
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The aggregated compact CQE does not expose a readable RSS hash flags
field. To keep the behavior consistent with the normal CQE path, derive
the mbuf RSS flags from the software configured rss_hf instead.

Cache the RSS enablement in struct hinic3_rxq, refresh it when a runtime
RSS update changes rss_type, and clear rss_type when RSS is disabled so a
reconfigure without RSS after stop does not use a stale hash setting for
RTE_MBUF_F_RX_RSS_HASH. The flag is written by the control path and read
by the Rx path, so use relaxed atomics.

ipv6_ext and tcp_ipv6_ext are supported on all tiles, so set them from
rss_hf rather than gating them on the HTN cmdq flag.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst   |  1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 21 +++++++----
 drivers/net/hinic3/hinic3_ethdev.c       | 27 +++++++------
 drivers/net/hinic3/hinic3_ethdev.h       |  2 +
 drivers/net/hinic3/hinic3_rx.c           | 48 +++++++++++++++++++-----
 drivers/net/hinic3/hinic3_rx.h           |  9 +++++
 6 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 13c62f71ac..7bcb6a9d43 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -135,6 +135,7 @@ New Features
   * Added FEC mode get and set support.
   * Added Class of Service (COS) mask and map support.
   * Added VF link up/down and promiscuous mode support.
+  * Updated RSS hash type configuration.
   * Added mailbox message counter reporting through the device private dump API.
 
 * **Updated Intel iavf driver.**
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index b5d7ce07a1..8c48f6d8a9 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -72,14 +72,19 @@
 	HINIC3_SUPPORT_FEATURE(dev, IPXIP_OFFLOAD)
 
 struct hinic3_rss_type {
-	uint8_t tcp_ipv6_ext;
-	uint8_t ipv6_ext;
-	uint8_t tcp_ipv6;
-	uint8_t ipv6;
-	uint8_t tcp_ipv4;
-	uint8_t ipv4;
-	uint8_t udp_ipv6;
-	uint8_t udp_ipv4;
+	union {
+		struct {
+			uint8_t tcp_ipv6_ext;
+			uint8_t ipv6_ext;
+			uint8_t tcp_ipv6;
+			uint8_t ipv6;
+			uint8_t tcp_ipv4;
+			uint8_t ipv4;
+			uint8_t udp_ipv6;
+			uint8_t udp_ipv4;
+		};
+		uint64_t val;
+	};
 };
 
 enum hinic3_rss_hash_type {
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 714533ea52..2ffebddf3a 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1032,6 +1032,8 @@ hinic3_reset_rx_queue(struct rte_eth_dev *dev)
 		rxq->prod_idx = 0;
 		rxq->delta = rxq->q_depth;
 		rxq->next_to_update = 0;
+		rte_atomic_store_explicit(&rxq->rss_en, 0,
+					  rte_memory_order_relaxed);
 
 		/*
 		 * Hardware does not clear the CI write-back memory on reset, so
@@ -1816,6 +1818,7 @@ hinic3_remove_rxtx_configure(struct rte_eth_dev *dev)
 		hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_DISABLE, 0, prio_tc);
 		hinic3_rss_template_free(nic_dev->hwdev);
 		nic_dev->rss_state = HINIC3_RSS_DISABLE;
+		nic_dev->rss_type.val = 0;
 	}
 }
 
@@ -2785,20 +2788,18 @@ hinic3_rss_hash_update(struct rte_eth_dev *dev,
 	rss_type.tcp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;
 	rss_type.udp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;
 	rss_type.udp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;
-
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {
-		rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
-		rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
-	} else {
-		rss_type.ipv6_ext = 0;
-		rss_type.tcp_ipv6_ext = 0;
-	}
+	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
+	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
 
 	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
-	if (err)
+	if (err) {
 		PMD_DRV_LOG(ERR, "Set RSS type failed");
+		return err;
+	}
 
-	return err;
+	nic_dev->rss_type = rss_type;
+	hinic3_rxq_rss_en_update(dev);
+	return 0;
 }
 
 /**
@@ -2853,10 +2854,8 @@ hinic3_rss_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
 	rss_conf->rss_hf |= rss_type.tcp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_TCP : 0;
 	rss_conf->rss_hf |= rss_type.udp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_UDP : 0;
 	rss_conf->rss_hf |= rss_type.udp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_UDP : 0;
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {
-		rss_conf->rss_hf |= rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;
-		rss_conf->rss_hf |= rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0;
-	}
+	rss_conf->rss_hf |= rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;
+	rss_conf->rss_hf |= rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0;
 
 	return 0;
 }
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 84f9b2db0e..13c9c69e7f 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -9,6 +9,7 @@
 #include <rte_ethdev_core.h>
 
 #include "hinic3_fdir.h"
+#include "base/hinic3_nic_cfg.h"
 
 #define HINIC3_PMD_DRV_VERSION "B106"
 
@@ -130,6 +131,7 @@ struct hinic3_nic_dev {
 	uint16_t num_rss; /**< Number of RSS queues. */
 
 	uint32_t rx_mode;
+	struct hinic3_rss_type rss_type;
 	uint8_t rx_queue_list[HINIC3_MAX_QUEUE_NUM];
 	rte_spinlock_t queue_list_lock;
 
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index 90681ce15c..74dfddac9d 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -437,17 +437,15 @@ hinic3_init_rss_type(struct hinic3_nic_dev *nic_dev,
 	rss_type.tcp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;
 	rss_type.udp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;
 	rss_type.udp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;
-
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {
-		rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
-		rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
-	} else {
-		rss_type.ipv6_ext = 0;
-		rss_type.tcp_ipv6_ext = 0;
-	}
+	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
+	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
 
 	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
-	return err;
+	if (err)
+		return err;
+
+	nic_dev->rss_type = rss_type;
+	return 0;
 }
 
 int
@@ -502,6 +500,8 @@ hinic3_update_rss_config(struct rte_eth_dev *dev,
 	return 0;
 
 init_rss_fail:
+	nic_dev->rss_type.val = 0;
+
 	if (hinic3_rss_template_free(nic_dev->hwdev))
 		PMD_DRV_LOG(WARNING, "Free rss template failed");
 
@@ -701,6 +701,8 @@ hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 	uint32_t head_ci, head_done;
 	int err;
 
+	rte_atomic_store_explicit(&rxq->rss_en, 0, rte_memory_order_relaxed);
+
 	/* Disable rxq intr. */
 	hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);
 
@@ -779,6 +781,11 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
 	int err = 0;
 
+	rte_atomic_store_explicit(&rxq->rss_en,
+				  (nic_dev->rss_state == HINIC3_RSS_ENABLE) &&
+				  (nic_dev->rss_type.val != 0),
+				  rte_memory_order_relaxed);
+
 	/* Lock dev queue switch.  */
 	rte_spinlock_lock(&nic_dev->queue_list_lock);
 	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
@@ -921,6 +928,23 @@ hinic3_recv_jumbo_pkt(struct hinic3_rxq *rxq, struct rte_mbuf *head_mbuf,
 	}
 }
 
+void
+hinic3_rxq_rss_en_update(struct rte_eth_dev *eth_dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+	uint8_t rss_en = (nic_dev->rss_state == HINIC3_RSS_ENABLE) &&
+			 (nic_dev->rss_type.val != 0);
+	uint16_t i;
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		struct hinic3_rxq *rxq = eth_dev->data->rx_queues[i];
+
+		if (rxq != NULL)
+			rte_atomic_store_explicit(&rxq->rss_en, rss_en,
+						  rte_memory_order_relaxed);
+	}
+}
+
 int
 hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)
 {
@@ -933,6 +957,10 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)
 
 	for (i = 0; i < nic_dev->num_rqs; i++) {
 		rxq = eth_dev->data->rx_queues[i];
+		rte_atomic_store_explicit(&rxq->rss_en,
+					  (nic_dev->rss_state == HINIC3_RSS_ENABLE) &&
+					  (nic_dev->rss_type.val != 0),
+					  rte_memory_order_relaxed);
 		hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
 		err = hinic3_rearm_rxq_mbuf(rxq);
 		if (err) {
@@ -1056,6 +1084,8 @@ hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq
 	cqe_info->pkt_len = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PKT_LEN);
 	cqe_info->ts_flag = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, TS_FLAG);
 	cqe_info->ptype = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PTYPE);
+	cqe_info->rss_type = rte_atomic_load_explicit(&rxq->rss_en,
+						      rte_memory_order_relaxed);
 	cqe_info->rss_hash_value = dw1;
 
 	if (cqe_info->cqe_len == HINIC3_RQ_COMPACT_CQE_16BYTE) {
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.h
index 129c2b4a59..59a198c070 100644
--- a/drivers/net/hinic3/hinic3_rx.h
+++ b/drivers/net/hinic3/hinic3_rx.h
@@ -5,6 +5,8 @@
 #ifndef _HINIC3_RX_H_
 #define _HINIC3_RX_H_
 
+#include <rte_stdatomic.h>
+
 #define RQ_CQE_OFFOLAD_TYPE_PTYPE_OFFLOAD_SHIFT	0
 #define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_SHIFT	21
 #define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_SHIFT	24
@@ -358,6 +360,12 @@ struct __rte_cache_aligned hinic3_rxq {
 	rte_iova_t cqe_start_paddr;
 	void *cqe_start_vaddr;
 	uint8_t dp_intr_en;
+	/**
+	 * RSS was enabled when this queue was started. Written by the
+	 * control path and read by the Rx data path, so it is accessed with
+	 * relaxed atomics.
+	 */
+	RTE_ATOMIC(uint8_t)rss_en;
 	uint16_t msix_entry_idx;
 
 	bool rx_deferred_start; /* don't start this queue in dev start */
@@ -421,6 +429,7 @@ void hinic3_init_rx_queue_list(struct hinic3_nic_dev *nic_dev);
 void hinic3_remove_rq_from_rx_queue_list(struct hinic3_nic_dev *nic_dev,
 					 uint16_t queue_id);
 int hinic3_start_all_rqs(struct rte_eth_dev *eth_dev);
+void hinic3_rxq_rss_en_update(struct rte_eth_dev *eth_dev);
 
 #ifdef HINIC3_XSTAT_RXBUF_INFO
 void hinic3_get_stats(struct hinic3_rxq *rxq);
-- 
2.33.0

