Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C036606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=elRppFNo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDF5C410DC;
	Mon,  9 Nov 2026 17:21:10 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTPS id 5CECE40A84
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=3gdf7Te/YQgMOqdPdfjyDOt9V+ZJ8/M4RydU6OpAb1Y=;
 b=elRppFNowWAPtVWJIUz+RMucMnqgwDcWGHJeEI4B5eEsmEbK2UaxB2gLunfXIQ
 73WLAcmqZakkEBHm5OczINSENwkTbXM1Grk3Qm0s0tGR2jiMdJwUPWcESNpQSI2X
 d0wA496gyak9TAcV6VpTOoxno7jVNBhTjemd693nL84z4=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 18/28] net/hinic3: update RSS hash type configuration
Date: Tue, 10 Nov 2026 00:20:22 +0800
Message-ID: <20261109162033.1144-19-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S20
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4rJr47ZFyxAr1fXw4rAFb_yoWfWw1fpa
 yUGFW7JrWDJrWfXwn8Ja17C3W5Zws7A3yIga4xJa4F9Fs8Zr18Aa4jyayUZrs09rWxA3W2
 vay8Zwn8K3WYvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULzV8UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwkOGGrx8ukPTgAA3p
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

The aggregated compact CQE enables RSS by default but does not expose
a readable RSS hash flags field. To keep the same behavior as the
normal CQE, derive the mbuf RSS flags from the software-configured
RSS hash capabilities (rss_hf) instead.

nic_dev->rss_type is never cleared when RSS is disabled, and the fast
path reads it through nic_dev for every packet. After a stop and
reconfigure without RSS (mq_mode NONE or a single queue), the compact
CQE path still sets RTE_MBUF_F_RX_RSS_HASH with a stale hash. Cache the
RSS state in struct hinic3_rxq at queue start, clear it on queue stop
and reset, and clear rss_type.val on the paths that disable RSS.

ipv6_ext and tcp_ipv6_ext are supported by every tile, so set them
directly from rss_hf rather than gating them on the HTN cmdq flag.
Also save the configured rss_type in software state and propagate the
error when setting the RSS type fails.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst   |  1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 21 ++++++++++++--------
 drivers/net/hinic3/hinic3_ethdev.c       | 25 +++++++++++-------------
 drivers/net/hinic3/hinic3_ethdev.h       |  2 ++
 drivers/net/hinic3/hinic3_rx.c           | 24 ++++++++++++++---------
 drivers/net/hinic3/hinic3_rx.h           |  1 +
 6 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index bbe363b8ae..e13a54d7b3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -168,6 +168,7 @@ New Features
   * Added CIR drop statistics and VF link aggregation (LAG) support.
   * Added FEC mode get and set support.
   * Added Class of Service (COS) mask and map support.
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
index 208e9c9632..d82aa07912 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1030,6 +1030,7 @@ hinic3_reset_rx_queue(struct rte_eth_dev *dev)
 		rxq->prod_idx = 0;
 		rxq->delta = rxq->q_depth;
 		rxq->next_to_update = 0;
+		rxq->rss_en = 0;
 
 		/*
 		 * Hardware does not clear the CI write-back memory on reset, so
@@ -1816,6 +1817,7 @@ hinic3_remove_rxtx_configure(struct rte_eth_dev *dev)
 		hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_DISABLE, 0, prio_tc);
 		hinic3_rss_template_free(nic_dev->hwdev);
 		nic_dev->rss_state = HINIC3_RSS_DISABLE;
+		nic_dev->rss_type.val = 0;
 	}
 }
 
@@ -2748,20 +2750,17 @@ hinic3_rss_hash_update(struct rte_eth_dev *dev,
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
+	return 0;
 }
 
 /**
@@ -2816,10 +2815,8 @@ hinic3_rss_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
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
index ed753ba4ec..e7dd0edb52 100644
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
 
+	rxq->rss_en = 0;
+
 	/* Disable rxq intr. */
 	hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);
 
@@ -779,6 +781,8 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
 	int err = 0;
 
+	rxq->rss_en = (nic_dev->rss_state == HINIC3_RSS_ENABLE);
+
 	/* Lock dev queue switch.  */
 	rte_spinlock_lock(&nic_dev->queue_list_lock);
 	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
@@ -933,6 +937,7 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)
 
 	for (i = 0; i < nic_dev->num_rqs; i++) {
 		rxq = eth_dev->data->rx_queues[i];
+		rxq->rss_en = (nic_dev->rss_state == HINIC3_RSS_ENABLE);
 		hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
 		err = hinic3_rearm_rxq_mbuf(rxq);
 		if (err) {
@@ -1056,6 +1061,7 @@ hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq
 	cqe_info->pkt_len = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PKT_LEN);
 	cqe_info->ts_flag = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, TS_FLAG);
 	cqe_info->ptype = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PTYPE);
+	cqe_info->rss_type = rxq->rss_en;
 	cqe_info->rss_hash_value = dw1;
 
 	if (cqe_info->cqe_len == HINIC3_RQ_COMPACT_CQE_16BYTE) {
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.h
index 129c2b4a59..075aa0bfd9 100644
--- a/drivers/net/hinic3/hinic3_rx.h
+++ b/drivers/net/hinic3/hinic3_rx.h
@@ -358,6 +358,7 @@ struct __rte_cache_aligned hinic3_rxq {
 	rte_iova_t cqe_start_paddr;
 	void *cqe_start_vaddr;
 	uint8_t dp_intr_en;
+	uint8_t rss_en; /**< RSS was enabled when this queue was started. */
 	uint16_t msix_entry_idx;
 
 	bool rx_deferred_start; /* don't start this queue in dev start */
-- 
2.33.0

