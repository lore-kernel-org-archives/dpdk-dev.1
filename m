Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD7C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:16:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1F8740A76;
	Fri, 28 Mar 2025 06:15:22 +0100 (CET)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 50A2540A6C
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:20 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138915tli094
X-QQ-Originating-IP: 14mK/bVzq8jLtYN5ojYIwi5jxaH8Q62VJguoalIjDRA=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8212797344527993010
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 11/29] net/rnp: add RSS support operations
Date: Fri, 28 Mar 2025 05:14:26 +0000
Message-Id: <20250328051444.1019208-12-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: N10XyoOyIIl0LOhuPhfeioVCLuvr9J5Wy2prWOVem/uTdeua4tJXocGy
 8Mnnp3ckyrZkUyj2TfFygrxY4abqzjwZGWB72x88929EvQxi/1RNbxaO1lOTtNLajLpeOKw
 6o9ge9/A4uhQlfrcX0mmOEwtHICu4+Ad/XldUp5TawqPcgiXXyP04swzanFoHfcMKwoQ4uC
 C8rFQmkdIugbkBbriwHmgeDS5/BJKXmTCOCaThkXzYtezFvfgQOX74tGrmmGykrtabA0GLn
 A92uzCwoRG237X/ASo+eoJc5eIX5bGL7crnwgk68HXVCEwnjfBuGcM8ANcy39tmnc0MgMnj
 4F2RLgtp2V9LZPbFxEAjXkivg5Lx6ZWeUwYiEkRKsqsxQmOUWmJtaKaGAIcYlfHZJKJl8RK
 aVnbiOIQQG8lCxSBytI2Fy90bnNBWwYHKTAvSAi0cxP0II8gNOYY0+OHZZloZmbd56UlNY7
 daPdGrvwsNHxW1QPKkroO2E+aDPbZzY6t9Ha9c8WUQzPAWgWgDWqCEdYwYehfj+ec+F6Ojb
 PFRoCHFTbLPKKkPBZV2RvBUtqHEkyfC0UouQIYF3VTbi7ETn5bYizDDiidtVNJQUqtpDkbA
 RghSPqpZBiO4E362SLcbvpbXsHXU/u4Yjx0r+r29/NO3LMxaSfCoVh/FluUo89e1qkxPwZY
 E/KmYNv+QmvTBzP5V8lFQpf8koBNZ5Z+w4a1ugNrvbj0qrtqn6aPehTp7g9PXvvqFzNwJ0o
 RgTzzFHuB3p3ZScl7fgKc91HpYuGh64Ppfq6uGVMMj+kO35zzUZ4bwMLIulQwsKnYe1mAnk
 bLqR9phlMiPfgxfHN488jWtOS5d5U4xBkY/d4yJkeZUdBNlgUXRBaMYMSeqM++hWXmV/oq6
 Pv+bAeYiuxk00sIj1UMy1hU+z5K0x2esozXCOPo+wzmxGl4L0tDuzX+WLlVzbJaw5ns322K
 TdEq8xU8Kc8qJcq6mxY3ptYpyuUgeBM4NXl7gUscpLthbEDILJH+ovihXvxEMlEZwLdu1nR
 FFvcxnKhewFbO36C3uadIhR3d0eNfAzcu51fzueBPeZYfNzhCEYJ3vsjOG/D1TrRFyFycdp
 ShDH4VJGz9E
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
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

add support rss reta updata/query rss hash update/get
dev_configure add rss conf check.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |   4 +
 doc/guides/nics/rnp.rst             |   7 +
 drivers/net/rnp/base/rnp_eth_regs.h |  16 ++
 drivers/net/rnp/meson.build         |   1 +
 drivers/net/rnp/rnp.h               |   7 +
 drivers/net/rnp/rnp_ethdev.c        |  23 ++
 drivers/net/rnp/rnp_rss.c           | 367 ++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rss.h           |  44 ++++
 8 files changed, 469 insertions(+)
 create mode 100644 drivers/net/rnp/rnp_rss.c
 create mode 100644 drivers/net/rnp/rnp_rss.h

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index fd7d4b9d8d..2fc94825f5 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -8,5 +8,9 @@ Speed capabilities   = Y
 Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
+Inner RSS            = Y
 Linux                = Y
 x86-64               = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 0ab9bba20b..5f9385720b 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -38,6 +38,9 @@ Features
 --------
 
 - Multiple queues for TX and RX
+- Receiver Side Steering (RSS)
+  Receiver Side Steering (RSS) on IPv4, IPv6, IPv4-TCP/UDP/SCTP, IPv6-TCP/UDP/SCTP
+  Inner RSS is only support for vxlan/nvgre
 - Promiscuous mode
 
 Prerequisites and Pre-conditions
@@ -70,6 +73,10 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_tx_queue_stop``
 * ``rte_eth_dev_start``
 * ``rte_eth_dev_stop``
+* ``rte_eth_dev_rss_hash_conf_get``
+* ``rte_eth_dev_rss_hash_update``
+* ``rte_eth_dev_rss_reta_query``
+* ``rte_eth_dev_rss_reta_update``
 * ``rte_eth_promiscuous_disable``
 * ``rte_eth_promiscuous_enable``
 * ``rte_eth_allmulticast_enable``
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index 60766d2035..be7ed5b886 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -32,7 +32,23 @@
 #define RNP_MAC_MULTICASE_TBL_EN	RTE_BIT32(2)
 #define RNP_MAC_UNICASE_TBL_EN		RTE_BIT32(3)
 /* rss function ctrl */
+#define RNP_RSS_INNER_CTRL	_ETH_(0x805c)
+#define RNP_INNER_RSS_EN	(1)
+#define RNP_INNER_RSS_DIS	(0)
 #define RNP_RSS_REDIR_TB(n, id) _ETH_(0xe000 + ((n) * 0x200) + ((id) * 0x4))
+#define RNP_RSS_MRQC_ADDR	_ETH_(0x92a0)
+/* RSS policy */
+#define RNP_RSS_HASH_CFG_MASK	(0x3F30000)
+#define RNP_RSS_HASH_IPV4_TCP	RTE_BIT32(16)
+#define RNP_RSS_HASH_IPV4	RTE_BIT32(17)
+#define RNP_RSS_HASH_IPV6	RTE_BIT32(20)
+#define RNP_RSS_HASH_IPV6_TCP	RTE_BIT32(21)
+#define RNP_RSS_HASH_IPV4_UDP	RTE_BIT32(22)
+#define RNP_RSS_HASH_IPV6_UDP   RTE_BIT32(23)
+#define RNP_RSS_HASH_IPV4_SCTP  RTE_BIT32(24)
+#define RNP_RSS_HASH_IPV6_SCTP  RTE_BIT32(25)
+/* rss hash key */
+#define RNP_RSS_KEY_TABLE(idx)	_ETH_(0x92d0 + ((idx) * 0x4))
 
 #define RNP_TC_PORT_OFFSET(lane)	_ETH_(0xe840 + 0x04 * (lane))
 
diff --git a/drivers/net/rnp/meson.build b/drivers/net/rnp/meson.build
index f88fa89a53..e20cc88497 100644
--- a/drivers/net/rnp/meson.build
+++ b/drivers/net/rnp/meson.build
@@ -22,4 +22,5 @@ includes += include_directories('base')
 sources = files(
         'rnp_ethdev.c',
         'rnp_rxtx.c',
+        'rnp_rss.c',
 )
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 9440d9df58..755b6c7f41 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -111,6 +111,13 @@ struct rnp_eth_port {
 	struct rnp_tx_queue *tx_queues[RNP_MAX_RX_QUEUE_NUM];
 	struct rnp_hw *hw;
 
+	struct rte_eth_rss_conf rss_conf;
+	uint16_t last_rx_num;
+	bool rxq_num_changed;
+	bool reta_has_cfg;
+	bool hw_rss_en;
+	uint32_t indirtbl[RNP_RSS_INDIR_SIZE];
+
 	rte_spinlock_t rx_mac_lock;
 	bool port_stopped;
 };
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 5603d767dc..6608c5c603 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -18,6 +18,7 @@
 #include "base/rnp_dma_regs.h"
 #include "base/rnp_mac_regs.h"
 #include "rnp_rxtx.h"
+#include "rnp_rss.h"
 
 static struct rte_eth_dev *
 rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
@@ -235,6 +236,9 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 	}
 	/* disable eth rx flow */
 	RNP_RX_ETH_DISABLE(hw, lane);
+	ret = rnp_dev_rss_configure(eth_dev);
+	if (ret)
+		return ret;
 	ret = rnp_rx_scattered_setup(eth_dev);
 	if (ret)
 		return ret;
@@ -302,6 +306,19 @@ static int rnp_disable_all_tx_queue(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static int rnp_dev_configure(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+
+	if (port->last_rx_num != eth_dev->data->nb_rx_queues)
+		port->rxq_num_changed = true;
+	else
+		port->rxq_num_changed = false;
+	port->last_rx_num = eth_dev->data->nb_rx_queues;
+
+	return 0;
+}
+
 static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
@@ -515,6 +532,7 @@ static int rnp_allmulticast_disable(struct rte_eth_dev *eth_dev)
 
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
+	.dev_configure                = rnp_dev_configure,
 	.dev_close                    = rnp_dev_close,
 	.dev_start                    = rnp_dev_start,
 	.dev_stop                     = rnp_dev_stop,
@@ -534,6 +552,11 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.tx_queue_release             = rnp_dev_tx_queue_release,
 	.tx_queue_stop                = rnp_tx_queue_stop,
 	.tx_queue_start               = rnp_tx_queue_start,
+	/* rss impl */
+	.reta_update                  = rnp_dev_rss_reta_update,
+	.reta_query                   = rnp_dev_rss_reta_query,
+	.rss_hash_update              = rnp_dev_rss_hash_update,
+	.rss_hash_conf_get            = rnp_dev_rss_hash_conf_get,
 };
 
 static void
diff --git a/drivers/net/rnp/rnp_rss.c b/drivers/net/rnp/rnp_rss.c
new file mode 100644
index 0000000000..19f31eb232
--- /dev/null
+++ b/drivers/net/rnp/rnp_rss.c
@@ -0,0 +1,367 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include <stdint.h>
+
+#include "base/rnp_bdq_if.h"
+#include "base/rnp_eth_regs.h"
+
+#include "rnp.h"
+#include "rnp_rxtx.h"
+#include "rnp_rss.h"
+
+static const struct rnp_rss_hash_cfg rnp_rss_cfg[] = {
+	{RNP_RSS_IPV4, RNP_RSS_HASH_IPV4, RTE_ETH_RSS_IPV4},
+	{RNP_RSS_IPV4, RNP_RSS_HASH_IPV4, RTE_ETH_RSS_FRAG_IPV4},
+	{RNP_RSS_IPV4, RNP_RSS_HASH_IPV4, RTE_ETH_RSS_NONFRAG_IPV4_OTHER},
+	{RNP_RSS_IPV6, RNP_RSS_HASH_IPV6, RTE_ETH_RSS_IPV6},
+	{RNP_RSS_IPV6, RNP_RSS_HASH_IPV6, RTE_ETH_RSS_FRAG_IPV6},
+	{RNP_RSS_IPV6, RNP_RSS_HASH_IPV6, RTE_ETH_RSS_NONFRAG_IPV6_OTHER},
+	{RNP_RSS_IPV4_TCP, RNP_RSS_HASH_IPV4_TCP, RTE_ETH_RSS_NONFRAG_IPV4_TCP},
+	{RNP_RSS_IPV4_UDP, RNP_RSS_HASH_IPV4_UDP, RTE_ETH_RSS_NONFRAG_IPV4_UDP},
+	{RNP_RSS_IPV4_SCTP, RNP_RSS_HASH_IPV4_SCTP, RTE_ETH_RSS_NONFRAG_IPV4_SCTP},
+	{RNP_RSS_IPV6_TCP, RNP_RSS_HASH_IPV6_TCP, RTE_ETH_RSS_NONFRAG_IPV6_TCP},
+	{RNP_RSS_IPV6_UDP, RNP_RSS_HASH_IPV6_UDP, RTE_ETH_RSS_NONFRAG_IPV6_UDP},
+	{RNP_RSS_IPV6_SCTP, RNP_RSS_HASH_IPV6_SCTP, RTE_ETH_RSS_NONFRAG_IPV6_SCTP}
+};
+
+static uint8_t rnp_rss_default_key[40] = {
+	0x6D, 0x5A, 0x56, 0xDA, 0x25, 0x5B, 0x0E, 0xC2,
+	0x41, 0x67, 0x25, 0x3D, 0x43, 0xA3, 0x8F, 0xB0,
+	0xD0, 0xCA, 0x2B, 0xCB, 0xAE, 0x7B, 0x30, 0xB4,
+	0x77, 0xCB, 0x2D, 0xA3, 0x80, 0x30, 0xF2, 0x0C,
+	0x6A, 0x42, 0xB7, 0x3B, 0xBE, 0xAC, 0x01, 0xFA,
+};
+
+int
+rnp_dev_rss_reta_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_reta_entry64 *reta_conf,
+			uint16_t reta_size)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t port_offset = port->attr.port_offset;
+	uint32_t *indirtbl = &port->indirtbl[0];
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	uint16_t i, idx, shift;
+	uint16_t hwrid;
+	uint16_t qid = 0;
+
+	if (reta_size > RNP_RSS_INDIR_SIZE) {
+		RNP_PMD_ERR("Invalid reta size, reta_size:%d", reta_size);
+		return -EINVAL;
+	}
+	for (i = 0; i < reta_size; i++) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		if (reta_conf[idx].mask & (1ULL << shift))
+			indirtbl[i] = reta_conf[idx].reta[shift];
+	}
+	for (i = 0; i < RNP_RSS_INDIR_SIZE; i++) {
+		qid = indirtbl[i];
+		if (qid < dev->data->nb_rx_queues) {
+			rxq = dev->data->rx_queues[qid];
+			hwrid = rxq->attr.index - port_offset;
+			RNP_E_REG_WR(hw, RNP_RSS_REDIR_TB(lane, i), hwrid);
+			rxq->rx_offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
+		} else {
+			RNP_PMD_WARN("port[%d] reta[%d]-queue=%d "
+					"rx queue is out range of cur Settings",
+					dev->data->port_id, i, qid);
+		}
+	}
+	port->reta_has_cfg = true;
+
+	return 0;
+}
+
+static uint16_t
+rnp_hwrid_to_queue_id(struct rte_eth_dev *dev, uint16_t hwrid)
+{
+	struct rnp_rx_queue *rxq;
+	bool find = false;
+	uint16_t idx;
+
+	for (idx = 0; idx < dev->data->nb_rx_queues; idx++) {
+		rxq = dev->data->rx_queues[idx];
+		if (!rxq)
+			continue;
+		if (rxq->attr.index == hwrid) {
+			find = true;
+			break;
+		}
+	}
+	if (find)
+		return rxq->attr.queue_id;
+
+	return UINT16_MAX;
+}
+
+int
+rnp_dev_rss_reta_query(struct rte_eth_dev *dev,
+		       struct rte_eth_rss_reta_entry64 *reta_conf,
+		       uint16_t reta_size)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t port_offset = port->attr.port_offset;
+	struct rnp_hw *hw = port->hw;
+	uint32_t *indirtbl = &port->indirtbl[0];
+	uint16_t lane = port->attr.nr_lane;
+	uint16_t i, idx, shift;
+	uint16_t hwrid;
+	uint16_t queue_id;
+
+	if (reta_size > RNP_RSS_INDIR_SIZE) {
+		RNP_PMD_ERR("Invalid reta size, reta_size:%d", reta_size);
+		return -EINVAL;
+	}
+	for (i = 0; i < reta_size; i++) {
+		hwrid = RNP_E_REG_RD(hw, RNP_RSS_REDIR_TB(lane, i));
+		hwrid = hwrid + port_offset;
+		queue_id = rnp_hwrid_to_queue_id(dev, hwrid);
+		if (queue_id == UINT16_MAX) {
+			RNP_PMD_ERR("Invalid rss-table value is the"
+					" Sw-queue not Match Hardware?");
+			return -EINVAL;
+		}
+		indirtbl[i] = queue_id;
+	}
+	for (i = 0; i < reta_size; i++) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		if (reta_conf[idx].mask & (1ULL << shift))
+			reta_conf[idx].reta[shift] = (uint16_t)indirtbl[i];
+	}
+
+	return 0;
+}
+
+static void rnp_disable_rss(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_adapter *adapter = RNP_DEV_TO_ADAPTER(dev);
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rte_eth_rss_conf *conf = &port->rss_conf;
+	struct rnp_rx_queue *rxq = NULL;
+	struct rnp_hw *hw = port->hw;
+	uint8_t rss_disable = 0;
+	uint32_t mrqc_reg = 0;
+	uint16_t lane, index;
+	uint16_t idx;
+
+	memset(conf, 0, sizeof(*conf));
+	lane = port->attr.nr_lane;
+	for (idx = 0; idx < hw->max_port_num; idx++) {
+		if (adapter->ports[idx] == NULL) {
+			rss_disable++;
+			continue;
+		}
+		if (!adapter->ports[idx]->rss_conf.rss_hf)
+			rss_disable++;
+	}
+
+	for (idx = 0; idx < dev->data->nb_rx_queues; idx++) {
+		rxq = dev->data->rx_queues[idx];
+		if (!rxq)
+			continue;
+		rxq->rx_offloads &= ~RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	}
+	/* we use software way to achieve multiple port mode
+	 * rss feature disable by set RSS table to default ring.
+	 * So when re enable RSS,the rss reta table need to set
+	 * last user set State
+	 */
+	rxq = dev->data->rx_queues[0];
+	index = rxq->attr.index - port->attr.port_offset;
+	for (idx = 0; idx < RNP_RSS_INDIR_SIZE; idx++)
+		RNP_E_REG_WR(hw, RNP_RSS_REDIR_TB(lane, idx), index);
+	if (rss_disable == hw->max_port_num) {
+		mrqc_reg = RNP_E_REG_RD(hw, RNP_RSS_MRQC_ADDR);
+		mrqc_reg &= ~RNP_RSS_HASH_CFG_MASK;
+		RNP_E_REG_WR(hw, RNP_RSS_MRQC_ADDR, mrqc_reg);
+	}
+}
+
+static void
+rnp_rss_hash_set(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
+{
+	uint64_t rss_hash_level = RTE_ETH_RSS_LEVEL(rss_conf->rss_hf);
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_rx_queue *rxq = NULL;
+	struct rnp_hw *hw = port->hw;
+	uint8_t *hash_key;
+	uint32_t mrqc_reg = 0;
+	uint32_t rss_key;
+	uint64_t rss_hf;
+	uint16_t i;
+
+	rss_hf = rss_conf->rss_hf;
+	hash_key = rss_conf->rss_key;
+	if (hash_key != NULL) {
+		for (i = 0; i < RNP_MAX_HASH_KEY_SIZE; i++) {
+			rss_key  = hash_key[(i * 4)];
+			rss_key |= hash_key[(i * 4) + 1] << 8;
+			rss_key |= hash_key[(i * 4) + 2] << 16;
+			rss_key |= hash_key[(i * 4) + 3] << 24;
+			rss_key = rte_cpu_to_be_32(rss_key);
+			RNP_E_REG_WR(hw, RNP_RSS_KEY_TABLE(9 - i), rss_key);
+		}
+	}
+	if (rss_hf) {
+		for (i = 0; i < RTE_DIM(rnp_rss_cfg); i++)
+			if (rnp_rss_cfg[i].rss_flag & rss_hf)
+				mrqc_reg |= rnp_rss_cfg[i].reg_val;
+		/* Enable inner rss mode
+		 * If enable, outer(vxlan/nvgre) rss won't cals
+		 */
+		if (rss_hash_level == RNP_RSS_LEVEL_INNER)
+			RNP_E_REG_WR(hw, RNP_RSS_INNER_CTRL, RNP_INNER_RSS_EN);
+		else
+			RNP_E_REG_WR(hw, RNP_RSS_INNER_CTRL, RNP_INNER_RSS_DIS);
+		RNP_E_REG_WR(hw, RNP_RSS_MRQC_ADDR, mrqc_reg);
+		for (i = 0; i < dev->data->nb_rx_queues; i++) {
+			rxq = dev->data->rx_queues[i];
+			if (!rxq)
+				continue;
+			rxq->rx_offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
+		}
+	}
+}
+
+static void
+rnp_reta_table_update(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t port_offset = port->attr.port_offset;
+	uint32_t *indirtbl = &port->indirtbl[0];
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	int i = 0, qid = 0, p_id;
+	uint16_t hwrid;
+
+	p_id = port->attr.nr_lane;
+	for (i = 0; i < RNP_RSS_INDIR_SIZE; i++) {
+		qid = indirtbl[i];
+		if (qid < dev->data->nb_rx_queues) {
+			rxq = dev->data->rx_queues[qid];
+			hwrid = rxq->attr.index - port_offset;
+			RNP_E_REG_WR(hw, RNP_RSS_REDIR_TB(p_id, i), hwrid);
+			rxq->rx_offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
+		} else {
+			RNP_PMD_LOG(WARNING, "port[%d] reta[%d]-queue=%d "
+					"rx queues is out range of cur set",
+					dev->data->port_id, i, qid);
+		}
+	}
+}
+
+int
+rnp_dev_rss_hash_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_conf *rss_conf)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+
+	if (rss_conf->rss_key &&
+			rss_conf->rss_key_len > RNP_MAX_HASH_KEY_SIZE) {
+		RNP_PMD_ERR("Invalid rss key, rss_key_len:%d",
+				rss_conf->rss_key_len);
+		return -EINVAL;
+	}
+	if (rss_conf->rss_hf &&
+			(!(rss_conf->rss_hf & RNP_SUPPORT_RSS_OFFLOAD_ALL))) {
+		RNP_PMD_ERR("RSS type don't support");
+		return -EINVAL;
+	}
+	if (!rss_conf->rss_hf) {
+		rnp_disable_rss(dev);
+	} else {
+		rnp_rss_hash_set(dev, rss_conf);
+		rnp_reta_table_update(dev);
+	}
+	port->rss_conf = *rss_conf;
+
+	return 0;
+}
+
+int
+rnp_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
+			  struct rte_eth_rss_conf *rss_conf)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_hw *hw = port->hw;
+	uint8_t *hash_key;
+	uint32_t rss_key;
+	uint64_t rss_hf;
+	uint32_t mrqc;
+	uint16_t i;
+
+	hash_key = rss_conf->rss_key;
+	if (hash_key != NULL) {
+		for (i = 0; i < 10; i++) {
+			rss_key = RNP_E_REG_RD(hw, RNP_RSS_KEY_TABLE(9 - i));
+			rss_key = rte_be_to_cpu_32(rss_key);
+			hash_key[(i * 4)] = rss_key & 0x000000FF;
+			hash_key[(i * 4) + 1] = (rss_key >> 8) & 0x000000FF;
+			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
+			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
+		}
+	}
+	rss_hf = 0;
+	mrqc = RNP_E_REG_RD(hw, RNP_RSS_MRQC_ADDR) & RNP_RSS_HASH_CFG_MASK;
+	if (mrqc == 0) {
+		rss_conf->rss_hf = 0;
+		return 0;
+	}
+	for (i = 0; i < RTE_DIM(rnp_rss_cfg); i++)
+		if (rnp_rss_cfg[i].reg_val & mrqc)
+			rss_hf |= rnp_rss_cfg[i].rss_flag;
+
+	rss_conf->rss_hf = rss_hf;
+
+	return 0;
+}
+
+int rnp_dev_rss_configure(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint32_t *indirtbl = port->indirtbl;
+	enum rte_eth_rx_mq_mode mq_mode = 0;
+	struct rte_eth_rss_conf rss_conf;
+	struct rnp_rx_queue *rxq;
+	int i, j;
+
+	mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+	if (dev->data->rx_queues == NULL) {
+		RNP_PMD_ERR("rx_queue is not setup skip rss set");
+		return -EINVAL;
+	}
+	rss_conf = dev->data->dev_conf.rx_adv_conf.rss_conf;
+	if (!(rss_conf.rss_hf & RNP_SUPPORT_RSS_OFFLOAD_ALL) ||
+			!(mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)) {
+		rnp_disable_rss(dev);
+
+		return 0;
+	}
+	if (rss_conf.rss_key == NULL)
+		rss_conf.rss_key = rnp_rss_default_key;
+
+	if (port->rxq_num_changed || !port->reta_has_cfg) {
+		/* set default reta policy */
+		for (i = 0; i < RNP_RSS_INDIR_SIZE; i++) {
+			j = i % dev->data->nb_rx_queues;
+			rxq = dev->data->rx_queues[j];
+			if (!rxq) {
+				RNP_PMD_ERR("rss Set reta-cfg rxq %d Is NULL", i);
+				return -EINVAL;
+			}
+			indirtbl[i] = rxq->attr.queue_id;
+		}
+	}
+	rnp_reta_table_update(dev);
+	port->rss_conf = rss_conf;
+	/* setup rss key and hash func */
+	rnp_rss_hash_set(dev, &rss_conf);
+
+	return 0;
+}
diff --git a/drivers/net/rnp/rnp_rss.h b/drivers/net/rnp/rnp_rss.h
new file mode 100644
index 0000000000..9b73be8eac
--- /dev/null
+++ b/drivers/net/rnp/rnp_rss.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_RSS_H_
+#define _RNP_RSS_H_
+
+#include "rnp.h"
+
+#define RNP_RSS_LEVEL_INNER	(2)
+struct rnp_rss_hash_cfg {
+	uint32_t func_id;
+	uint32_t reg_val;
+	uint64_t rss_flag;
+};
+
+enum rnp_rss_hash_type {
+	RNP_RSS_IPV4,
+	RNP_RSS_IPV6,
+	RNP_RSS_IPV4_TCP,
+	RNP_RSS_IPV4_UDP,
+	RNP_RSS_IPV4_SCTP,
+	RNP_RSS_IPV6_TCP,
+	RNP_RSS_IPV6_UDP,
+	RNP_RSS_IPV6_SCTP,
+};
+
+int
+rnp_dev_rss_reta_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_reta_entry64 *reta_conf,
+			uint16_t reta_size);
+int
+rnp_dev_rss_reta_query(struct rte_eth_dev *dev,
+		       struct rte_eth_rss_reta_entry64 *reta_conf,
+		       uint16_t reta_size);
+int
+rnp_dev_rss_hash_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_conf *rss_conf);
+int
+rnp_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
+			  struct rte_eth_rss_conf *rss_conf);
+int rnp_dev_rss_configure(struct rte_eth_dev *dev);
+
+#endif /* _RNP_RSS_H_ */
-- 
2.25.1


