Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C079CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:11:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4A6640E09;
	Wed, 14 Oct 2026 17:10:02 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 9E776406B6
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=x+b7bB7CgnB4RhVp3L4tKHgZSBjjbctMKwaUtAB+kGY=;
 b=GDyeHRvovoFXQaVqLk0/G5LJ0hLACwiI1aDd14l+dx/B4f6yFZbNQfWCOAMU8C
 zDY5V8Y5cLsWA2qO2nclYNKnrCmCDMUNyJO7HOx4FrpQifPusqvJYLXxwu0wQJvl
 SL3/V6whOhCKaMuTHKyBV8La04fGiQM4knJvXoiHWqo7I=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 14/26] net/hinic3: update RSS hash type configuration
Date: Wed, 14 Oct 2026 23:09:10 +0800
Message-ID: <20261014150923.838-15-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S16
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF13WF4rtr4UArWktw1kKrg_yoWxJr1rp3
 y7G3y7JrWDtrWrXwn5Xa1UC3W5Zw4kC3yIgw12q3sYkF4kZr1xA345Aay0yrs0gFWxX3Wa
 vayrZ3s8K3WYv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULzV8UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhqDjWrPmzofcQAA3I
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

The aggregated compact CQE does not expose a readable RSS hash flags field.
To keep the same behavior as the normal CQE, always enable ipv6_ext and
tcp_ipv6_ext (every tile supports them) and save the configured RSS hash
flags in software state.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst   |  1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 21 +++++++++++++--------
 drivers/net/hinic3/hinic3_ethdev.c       | 23 +++++++++--------------
 drivers/net/hinic3/hinic3_ethdev.h       |  2 ++
 drivers/net/hinic3/hinic3_rx.c           | 17 ++++++++---------
 5 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 09917a19c9..3f106bfe31 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -119,6 +119,7 @@ New Features
   * Added CIR drop statistics and VF link aggregation (LAG) support.
   * Added FEC mode get and set support.
   * Added Class of Service (COS) mask and map support.
+  * Updated RSS hash type configuration.
   * Added mailbox message counter reporting through the device private dump API.
 
 * **Updated Intel iavf driver.**
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index 4d4cb2d8cb..d8b7dd9bc4 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -73,14 +73,19 @@
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
index 21d7fc1a0e..f3dc5a15a6 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2680,20 +2680,17 @@ hinic3_rss_hash_update(struct rte_eth_dev *dev,
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
@@ -2748,10 +2745,8 @@ hinic3_rss_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
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
index ec5daf523b..f7d3dfcff6 100644
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
index ed753ba4ec..a4846dc695 100644
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
@@ -1056,6 +1054,7 @@ hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq
 	cqe_info->pkt_len = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PKT_LEN);
 	cqe_info->ts_flag = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, TS_FLAG);
 	cqe_info->ptype = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PTYPE);
+	cqe_info->rss_type = (rxq->nic_dev->rss_type.val != 0) ? 1 : 0;
 	cqe_info->rss_hash_value = dw1;
 
 	if (cqe_info->cqe_len == HINIC3_RQ_COMPACT_CQE_16BYTE) {
-- 
2.33.0

