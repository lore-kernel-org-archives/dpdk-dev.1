Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1EE606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=OjsqsV8A
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC0C040A67;
	Fri, 23 Oct 2026 17:58:57 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 9FF1640265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=aDYAj0g1U24vsK2R4tJ77QKufYTlyoAHZXZZPowZBLQ=;
 b=OjsqsV8ADTDAIoBeXyce5a268Y09OdfjhL7SIJQEis2Sc3MC6C60jAjEx73X4e
 5O8yw9vDIHj0F11JJmXsdXDAj8oBwc0aNjEuV4G/QlUPZw9RbaujCJMPkZIyV9EJ
 uoOYce2j4jFVK/Jd2gIAxk6TZZiaPjNqJDtqV8cPxSHUA=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 17/27] net/hinic3: update RSS hash type configuration
Date: Fri, 23 Oct 2026 23:57:58 +0800
Message-ID: <20261023155809.855-18-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S19
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4rJr47ZFyxArWkury3Jwb_yoWxXr1rpa
 y7G3y7JrWDtrWrXwn5Ja1UC3W5Zw4kC3yIg34IqasYkF4kZr1xAa45Aayjvrs0grWxX3W2
 v3yrZr98K3WYv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULzV8UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRu4wmrbhBsCLgAA3W
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

ipv6_ext and tcp_ipv6_ext are supported by every tile, so set them
directly from rss_hf rather than gating them on the HTN cmdq flag.
Also save the configured rss_type in software state and propagate the
error when setting the RSS type fails.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst   |  1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 21 +++++++++++++--------
 drivers/net/hinic3/hinic3_ethdev.c       | 23 +++++++++--------------
 drivers/net/hinic3/hinic3_ethdev.h       |  2 ++
 drivers/net/hinic3/hinic3_rx.c           | 17 ++++++++---------
 5 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 88a337efef..8454567de6 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -147,6 +147,7 @@ New Features
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
index ba476a857a..13c6a240cb 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2708,20 +2708,17 @@ hinic3_rss_hash_update(struct rte_eth_dev *dev,
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
@@ -2776,10 +2773,8 @@ hinic3_rss_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
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
index 0061051bb2..7c635535ae 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -9,6 +9,7 @@
 #include <rte_ethdev_core.h>
 
 #include "hinic3_fdir.h"
+#include "base/hinic3_nic_cfg.h"
 
 #define HINIC3_PMD_DRV_VERSION "B106"
 
@@ -131,6 +132,7 @@ struct hinic3_nic_dev {
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

