Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FD9C83F10
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 01:21:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6233C410F2;
	Thu, 10 Jul 2025 03:20:50 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id ED40240EF0
 for <dev@dpdk.org>; Thu, 10 Jul 2025 03:20:46 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [60.29.3.194])
 by APP-03 (Coremail) with SMTP id rQCowAAHX4BYFW9oVdOrAg--.27893S11;
 Thu, 10 Jul 2025 09:20:44 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v5 10/14] net/sxe: add xstats function
Date: Wed,  9 Jul 2025 21:20:17 -0400
Message-ID: <20250710012021.7698-10-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710012021.7698-1-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250710012021.7698-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAHX4BYFW9oVdOrAg--.27893S11
X-Coremail-Antispam: 1UD129KBjvAXoWfuw45uw1kZr4UCFy3uF4DArb_yoW8Zw4rCo
 W2qrsxta1rCr97CrWvqrn5JF9rua1qgryUGr4Fyws8ua13Aw1Uury7Kw43J3Z0gw4rtF1D
 X3s2ya4agrs5Gw4rn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYt7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_KwCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUW7KsUUUUU=
X-Originating-IP: [60.29.3.194]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

Add xstats function.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/meson.build    |   1 +
 drivers/net/sxe/pf/sxe.h       |   2 +
 drivers/net/sxe/pf/sxe_main.c  |   2 +
 drivers/net/sxe/pf/sxe_stats.c | 577 +++++++++++++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_stats.h |  71 ++++
 5 files changed, 653 insertions(+)
 create mode 100644 drivers/net/sxe/pf/sxe_stats.c
 create mode 100644 drivers/net/sxe/pf/sxe_stats.h

diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
index 5bd44f3f65..b06cc4c1fe 100644
--- a/drivers/net/sxe/meson.build
+++ b/drivers/net/sxe/meson.build
@@ -17,6 +17,7 @@ sources = files(
 	'pf/sxe_queue.c',
 	'pf/sxe_rx.c',
 	'pf/sxe_tx.c',
+	'pf/sxe_stats.c',
         'pf/sxe_pmd_hdc.c',
         'pf/sxe_phy.c',
         'pf/sxe_ptp.c',
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 8699e1a82f..2da5c4df96 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -9,6 +9,7 @@
 #include "sxe_filter.h"
 #include <stdbool.h>
 #include "sxe_types.h"
+#include "sxe_stats.h"
 #include "sxe_irq.h"
 #include "sxe_phy.h"
 #include "sxe_dcb.h"
@@ -61,6 +62,7 @@ struct sxe_adapter {
 #endif
 	struct sxe_ptp_context ptp_ctxt;
 	struct sxe_phy_context phy_ctxt;
+	struct sxe_stats_info stats_info;
 	struct sxe_dcb_context dcb_ctxt;
 
 	bool rx_batch_alloc_allowed;
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
index 6fc4a41703..bbee8035d6 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -203,6 +203,8 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 void sxe_hw_start(struct sxe_hw *hw)
 {
 	sxe_hw_vlan_filter_array_clear(hw);
+
+	sxe_hw_stats_regs_clean(hw);
 	sxe_hw_dcb_rate_limiter_clear(hw, SXE_TXRX_RING_NUM_MAX);
 
 	sxe_fc_autoneg_localcap_set(hw);
diff --git a/drivers/net/sxe/pf/sxe_stats.c b/drivers/net/sxe/pf/sxe_stats.c
new file mode 100644
index 0000000000..6b9e1beb3e
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_stats.c
@@ -0,0 +1,577 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include "sxe_dpdk_version.h"
+#include "sxe_stats.h"
+#include "sxe.h"
+#include "sxe_logs.h"
+#include "sxe_errno.h"
+#include "sxe_queue.h"
+#include "sxe_compat_platform.h"
+#include <rte_string_fns.h>
+
+#define SXE_STAT_MAP_WIDTH 8
+#define SXE_STAT_MAP_CNT 4
+#define SXE_STAT_MAP_MASK 0x0F
+
+#define SXE_QUEUE_STAT_COUNT ARRAY_SIZE(stats_info->hw_stats.qprc)
+
+static const struct sxe_stats_field sxe_xstats_sw_field[] = {
+	{"rx_l3_l4_xsum_error", offsetof(struct sxe_sw_stats,
+		hw_csum_rx_error)},
+};
+
+static const struct sxe_stats_field sxe_xstats_mac_field[] = {
+	{"rx_crc_errors", offsetof(struct sxe_mac_stats, crcerrs)},
+	{"rx_error_bytes", offsetof(struct sxe_mac_stats, errbc)},
+	{"rx_length_errors", offsetof(struct sxe_mac_stats, rlec)},
+	{"rx_size_64_packets", offsetof(struct sxe_mac_stats, prc64)},
+	{"rx_size_65_to_127_packets", offsetof(struct sxe_mac_stats, prc127)},
+	{"rx_size_128_to_255_packets", offsetof(struct sxe_mac_stats, prc255)},
+	{"rx_size_256_to_511_packets", offsetof(struct sxe_mac_stats, prc511)},
+	{"rx_size_512_to_1023_packets", offsetof(struct sxe_mac_stats,
+		prc1023)},
+	{"rx_size_1024_to_max_packets", offsetof(struct sxe_mac_stats,
+		prc1522)},
+	{"rx_broadcast_packets", offsetof(struct sxe_mac_stats, bprc)},
+	{"rx_multicast_packets", offsetof(struct sxe_mac_stats, mprc)},
+	{"rx_fragment_errors", offsetof(struct sxe_mac_stats, rfc)},
+	{"rx_undersize_errors", offsetof(struct sxe_mac_stats, ruc)},
+	{"rx_oversize_errors", offsetof(struct sxe_mac_stats, roc)},
+	{"rx_jabber_errors", offsetof(struct sxe_mac_stats, rjc)},
+	{"rx_size_packets", offsetof(struct sxe_mac_stats, tpr)},
+	{"rx_size_bytes", offsetof(struct sxe_mac_stats, tor)},
+	{"tx_size_packets", offsetof(struct sxe_mac_stats, tpt)},
+	{"tx_size_64_packets", offsetof(struct sxe_mac_stats, ptc64)},
+	{"tx_size_65_to_127_packets", offsetof(struct sxe_mac_stats, ptc127)},
+	{"tx_size_128_to_255_packets", offsetof(struct sxe_mac_stats, ptc255)},
+	{"tx_size_256_to_511_packets", offsetof(struct sxe_mac_stats, ptc511)},
+	{"tx_size_512_to_1023_packets", offsetof(struct sxe_mac_stats,
+		ptc1023)},
+	{"tx_size_1024_to_max_packets", offsetof(struct sxe_mac_stats,
+		ptc1522)},
+	{"tx_multicast_packets", offsetof(struct sxe_mac_stats, mptc)},
+	{"tx_broadcast_packets", offsetof(struct sxe_mac_stats, bptc)},
+
+	{"flow_navigator_add_filters", offsetof(struct sxe_mac_stats,
+		fnavadd)},
+	{"flow_navigator_remove_filters", offsetof(struct sxe_mac_stats,
+		fnavrmv)},
+	{"flow_navigator_filters_add_errs", offsetof(struct sxe_mac_stats,
+		fnavadderr)},
+	{"flow_navigator_filters_remove_errs", offsetof(struct sxe_mac_stats,
+		fnavrmverr)},
+	{"flow_navigator_matched_filters", offsetof(struct sxe_mac_stats,
+		fnavmatch)},
+	{"flow_navigator_missed_filters", offsetof(struct sxe_mac_stats,
+		fnavmiss)},
+};
+
+static const struct sxe_stats_field sxe_xstats_fc_field[] = {
+	{"dropped", offsetof(struct sxe_mac_stats, mpc)},
+	{"rx_xon_xoff_packets", offsetof(struct sxe_mac_stats, prcpf)},
+	{"tx_xon_xoff_packets", offsetof(struct sxe_mac_stats, pfct)},
+};
+
+#define SXE_XSTAT_SW_CNT  (sizeof(sxe_xstats_sw_field) / \
+			  sizeof(sxe_xstats_sw_field[0]))
+
+#define SXE_XSTAT_MAC_CNT (sizeof(sxe_xstats_mac_field) / \
+			  sizeof(sxe_xstats_mac_field[0]))
+
+#define SXE_XSTAT_FC_CNT (sizeof(sxe_xstats_fc_field) / \
+			   sizeof(sxe_xstats_fc_field[0]))
+
+#define SXE_FC_PRIO_VALUES 8
+
+#define SXE_XSTAT_CNT  (SXE_XSTAT_MAC_CNT + SXE_XSTAT_SW_CNT + \
+			SXE_XSTAT_FC_CNT * SXE_FC_PRIO_VALUES)
+
+#ifdef SXE_TEST
+u32 sxe_xstats_cnt_get(void)
+{
+	return SXE_XSTAT_CNT;
+}
+#endif
+
+s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev,
+				struct rte_eth_stats *stats)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_stats_info *stats_info = &adapter->stats_info;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 i;
+	u64 rx_packets = 0;
+	u64 rx_bytes = 0;
+	s32 ret = 0;
+
+	sxe_hw_stats_get(hw, &stats_info->hw_stats);
+
+	if (stats == NULL) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "input param stats is null.");
+		goto l_out;
+	}
+
+	for (i = 0; i < RTE_MIN_T(SXE_QUEUE_STAT_COUNT,
+		RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i++) {
+		rx_packets += stats_info->hw_stats.qprc[i];
+		rx_bytes += stats_info->hw_stats.qbrc[i];
+
+		stats->q_ipackets[i] = stats_info->hw_stats.qprc[i];
+		stats->q_opackets[i] = stats_info->hw_stats.qptc[i];
+		stats->q_ibytes[i] = stats_info->hw_stats.qbrc[i];
+		stats->q_obytes[i] = stats_info->hw_stats.qbtc[i];
+		stats->q_errors[i] = stats_info->hw_stats.qprdc[i];
+	}
+
+	stats->ipackets = rx_packets;
+	stats->ibytes = rx_bytes;
+	stats->opackets = stats_info->hw_stats.gptc;
+	stats->obytes = stats_info->hw_stats.gotc;
+
+	stats->imissed  = 0;
+	stats->ierrors  = stats_info->hw_stats.crcerrs +
+			  stats_info->hw_stats.rlec +
+			  stats_info->hw_stats.ruc +
+			  stats_info->hw_stats.roc +
+			  stats_info->hw_stats.rfc;
+
+	stats->oerrors  = 0;
+
+l_out:
+	return ret;
+}
+
+static s32 sxe_hw_xstat_offset_get(u32 id, u32 *offset)
+{
+	s32 ret = 0;
+	u32 size = SXE_XSTAT_MAC_CNT;
+
+	if (id < size) {
+		*offset = sxe_xstats_mac_field[id].offset;
+	} else {
+		ret = -SXE_ERR_PARAM;
+		PMD_LOG_ERR(DRV, "invalid id:%u exceed stats size cnt:%u.",
+				id, size);
+	}
+
+	return ret;
+}
+
+static s32 sxe_sw_xstat_offset_get(u32 id, u32 *offset)
+{
+	s32 ret = 0;
+	u32 size = SXE_XSTAT_SW_CNT;
+
+	if (id < size) {
+		*offset = sxe_xstats_sw_field[id].offset;
+	} else {
+		ret = -SXE_ERR_PARAM;
+		PMD_LOG_ERR(DRV, "invalid id:%u exceed stats size cnt:%u.",
+				id, size);
+	}
+
+	return ret;
+}
+
+static s32 sxe_fc_xstat_field_offset_get(u32 id, u8 priority, u32 *offset)
+{
+	s32 ret = 0;
+	u32 size = SXE_XSTAT_FC_CNT;
+
+	if (id < size) {
+		*offset = sxe_xstats_fc_field[id].offset + (sizeof(u64) * priority);
+	} else {
+		ret = -SXE_ERR_PARAM;
+		PMD_LOG_ERR(DRV, "invalid id:%u exceed stats size cnt:%u.",
+				id, size);
+	}
+
+	return ret;
+}
+
+static void sxe_sw_stats_get(struct rte_eth_dev *eth_dev,
+				struct sxe_sw_stats *stats)
+{
+	u32 i;
+	u64 hw_csum_rx_error = 0;
+	sxe_rx_queue_s *rxq;
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		rxq = eth_dev->data->rx_queues[i];
+		hw_csum_rx_error += rxq->rx_stats.csum_err;
+	}
+	stats->hw_csum_rx_error = hw_csum_rx_error;
+}
+
+s32 sxe_xstats_get(struct rte_eth_dev *eth_dev,
+				struct rte_eth_xstat *xstats,
+				u32 usr_cnt)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_stats_info *stats_info = &adapter->stats_info;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 i;
+	u32 cnt;
+	s32 ret;
+	u32 offset;
+	u8 prio;
+
+	cnt = SXE_XSTAT_CNT;
+	PMD_LOG_INFO(DRV, "xstat size:%u. hw xstat field cnt:%u "
+			"fc xstat field cnt:%u ", cnt,
+			SXE_XSTAT_MAC_CNT,
+			SXE_XSTAT_FC_CNT);
+
+	if (usr_cnt < cnt) {
+		ret = cnt;
+		PMD_LOG_ERR(DRV, "user usr_cnt:%u less than stats cnt:%u.",
+				usr_cnt, cnt);
+		goto l_out;
+	}
+
+	sxe_hw_stats_get(hw, &stats_info->hw_stats);
+	sxe_sw_stats_get(eth_dev, &stats_info->sw_stats);
+
+	if (xstats == NULL) {
+		ret = 0;
+		PMD_LOG_ERR(DRV, "usr_cnt:%u, input param xstats is null.", usr_cnt);
+		goto l_out;
+	}
+
+	cnt = 0;
+	for (i = 0; i < SXE_XSTAT_MAC_CNT; i++) {
+		sxe_hw_xstat_offset_get(i, &offset);
+		xstats[cnt].value = *(u64 *)(((s8 *)(&stats_info->hw_stats)) + offset);
+		xstats[cnt].id = cnt;
+		cnt++;
+	}
+
+	for (i = 0; i < SXE_XSTAT_SW_CNT; i++) {
+		sxe_sw_xstat_offset_get(i, &offset);
+		xstats[cnt].value = *(u64 *)(((s8 *)(&stats_info->sw_stats)) + offset);
+		xstats[cnt].id = cnt;
+		cnt++;
+	}
+
+	for (i = 0; i < SXE_XSTAT_FC_CNT; i++) {
+		for (prio = 0; prio < SXE_FC_PRIO_VALUES; prio++) {
+			sxe_fc_xstat_field_offset_get(i, prio, &offset);
+			xstats[cnt].value = *(u64 *)(((s8 *)(&stats_info->hw_stats))
+					  + offset);
+			xstats[cnt].id = cnt;
+			cnt++;
+		}
+	}
+
+	ret = cnt;
+	PMD_LOG_INFO(DRV, "usr_cnt:%u stats cnt:%u stats done.", usr_cnt, cnt);
+
+l_out:
+	return ret;
+}
+
+s32 sxe_stats_reset(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_stats_info *stats_info = &adapter->stats_info;
+	struct sxe_hw *hw = &adapter->hw;
+	sxe_rx_queue_s *rxq;
+	u32 i;
+
+	sxe_eth_stats_get(eth_dev, NULL);
+	sxe_hw_stats_seq_clean(hw, &stats_info->hw_stats);
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		rxq = eth_dev->data->rx_queues[i];
+		memset(&rxq->rx_stats, 0, sizeof(rxq->rx_stats));
+	}
+
+	memset(&stats_info->hw_stats, 0, sizeof(stats_info->hw_stats));
+	memset(&stats_info->sw_stats, 0, sizeof(stats_info->sw_stats));
+
+	return 0;
+}
+
+s32 sxe_xstats_reset(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_stats_info *stats_info = &adapter->stats_info;
+	struct sxe_hw *hw = &adapter->hw;
+	sxe_rx_queue_s *rxq;
+	u32 size = SXE_XSTAT_CNT;
+	u32 i;
+
+	sxe_xstats_get(eth_dev, NULL, size);
+	sxe_hw_stats_seq_clean(hw, &stats_info->hw_stats);
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		rxq = eth_dev->data->rx_queues[i];
+		memset(&rxq->rx_stats, 0, sizeof(rxq->rx_stats));
+	}
+
+	memset(&stats_info->hw_stats, 0, sizeof(stats_info->hw_stats));
+	memset(&stats_info->sw_stats, 0, sizeof(stats_info->sw_stats));
+
+	return 0;
+}
+
+s32 sxe_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
+	struct rte_eth_xstat_name *xstats_names, __rte_unused unsigned int usr_cnt)
+{
+	u32 i = 0;
+	u32 cnt = 0;
+	s32 ret;
+	u8 prio;
+
+	if (xstats_names == NULL) {
+		ret = SXE_XSTAT_CNT;
+		PMD_LOG_INFO(DRV, "xstats field size:%u.", ret);
+		goto l_out;
+	}
+
+	if (usr_cnt < SXE_XSTAT_CNT) {
+		ret = -SXE_ERR_PARAM;
+		PMD_LOG_ERR(DRV, "max:%u usr_cnt:%u invalid.(err:%d)",
+				SXE_XSTAT_CNT, usr_cnt, ret);
+		goto l_out;
+	}
+
+	for (i = 0; i < SXE_XSTAT_MAC_CNT; i++) {
+		strlcpy(xstats_names[cnt].name,
+			sxe_xstats_mac_field[i].name,
+			sizeof(xstats_names[cnt].name));
+		cnt++;
+	}
+
+	for (i = 0; i < SXE_XSTAT_SW_CNT; i++) {
+		strlcpy(xstats_names[cnt].name,
+			sxe_xstats_sw_field[i].name,
+			sizeof(xstats_names[cnt].name));
+		cnt++;
+	}
+
+	for (i = 0; i < SXE_XSTAT_FC_CNT; i++) {
+		for (prio = 0; prio < SXE_FC_PRIO_VALUES; prio++) {
+			snprintf(xstats_names[cnt].name,
+				sizeof(xstats_names[cnt].name),
+				"priority%u_%s", prio,
+				sxe_xstats_fc_field[i].name);
+			cnt++;
+		}
+	}
+
+	ret = cnt;
+
+l_out:
+	return ret;
+}
+
+static s32 sxe_all_xstats_value_get(struct rte_eth_dev *eth_dev,
+						u64 *values, u32 usr_cnt)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_stats_info *stats_info = &adapter->stats_info;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 size = SXE_XSTAT_CNT;
+	s32 ret;
+	u32 offset;
+	u32 cnt = 0;
+	u32 i;
+	u8 prio;
+
+	if (usr_cnt < size) {
+		PMD_LOG_WARN(DRV, "ids null usr_cnt:%u less than xstats"
+				 " cnt:%u, return xstat cnt.",
+				  usr_cnt, size);
+		ret = size;
+		goto l_out;
+	}
+
+	sxe_hw_stats_get(hw, &stats_info->hw_stats);
+	sxe_sw_stats_get(eth_dev, &stats_info->sw_stats);
+
+	if (values == NULL) {
+		PMD_LOG_WARN(DRV, "ids and values null, "
+				 "read clean stats regs");
+		ret = 0;
+		goto l_out;
+	}
+
+	for (i = 0; i < SXE_XSTAT_MAC_CNT; i++) {
+		sxe_hw_xstat_offset_get(i, &offset);
+		values[cnt] = *(u64 *)(((s8 *)(&stats_info->hw_stats)) + offset);
+		cnt++;
+	}
+
+	for (i = 0; i < SXE_XSTAT_SW_CNT; i++) {
+		sxe_sw_xstat_offset_get(i, &offset);
+		values[cnt] = *(u64 *)(((s8 *)(&stats_info->sw_stats)) + offset);
+		cnt++;
+	}
+
+	for (i = 0; i < SXE_XSTAT_FC_CNT; i++) {
+		for (prio = 0; prio < SXE_FC_PRIO_VALUES; prio++) {
+			sxe_fc_xstat_field_offset_get(i, prio, &offset);
+			values[cnt] = *(u64 *)(((s8 *)(&stats_info->hw_stats))
+					  + offset);
+			cnt++;
+		}
+	}
+
+	ret = cnt;
+
+l_out:
+	return ret;
+}
+
+s32 sxe_xstats_get_by_id(struct rte_eth_dev *eth_dev,
+					const u64 *ids,
+					u64 *values, u32 usr_cnt)
+{
+	s32 ret;
+	u32 size = SXE_XSTAT_CNT;
+	u32 i;
+	u64 value_all[size];
+
+	if (ids == NULL) {
+		ret = sxe_all_xstats_value_get(eth_dev, values, usr_cnt);
+		goto l_out;
+	}
+
+	if (values == NULL) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "invalid param values.");
+		goto l_out;
+	}
+
+	sxe_all_xstats_value_get(eth_dev, value_all, size);
+
+	for (i = 0; i < usr_cnt; i++) {
+		if (ids[i] >= size) {
+			PMD_LOG_ERR(DRV, "index:%u invalid ids:%" SXE_PRIU64, i, ids[i]);
+			ret = -EINVAL;
+			goto l_out;
+		}
+		values[i] = value_all[ids[i]];
+	}
+
+	ret = usr_cnt;
+
+l_out:
+	return ret;
+}
+
+s32 sxe_xstats_names_get_by_id(struct rte_eth_dev *eth_dev,
+	const u64 *ids,
+	struct rte_eth_xstat_name *xstats_names,
+	u32 usr_cnt)
+{
+	s32 ret;
+	u32 i;
+	u32 size = SXE_XSTAT_CNT;
+	struct rte_eth_xstat_name xstat_names_all[size];
+
+	if (ids == NULL) {
+		ret = sxe_xstats_names_get(eth_dev, xstats_names, usr_cnt);
+		goto l_out;
+	}
+
+	sxe_xstats_names_get(eth_dev, xstat_names_all, size);
+	for (i = 0; i < usr_cnt; i++) {
+		if (ids[i] >= size) {
+			PMD_LOG_ERR(DRV, "index:%u invalid ids:%" SXE_PRIU64, i, ids[i]);
+			ret = -EINVAL;
+			goto l_out;
+		}
+		strcpy(xstats_names[ids[i]].name, xstat_names_all[ids[i]].name);
+	}
+
+	ret = usr_cnt;
+
+l_out:
+	return ret;
+}
+
+s32 sxe_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
+				  u16 queue_id,
+				  u8 stat_reg_idx,
+				  u8 is_rx)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_stats_map *stats_map = &adapter->stats_info.stats_map;
+	u32 qsmr_mask = 0;
+	u32 map_mask = SXE_STAT_MAP_MASK;
+	u8 reg_idx;
+	u8 map_idx;
+	s32 ret = 0;
+
+	reg_idx = queue_id / SXE_STAT_MAP_CNT;
+	if (reg_idx >= SXE_QUEUE_STATS_MAP_REG_NUM) {
+		ret = -EIO;
+		PMD_LOG_ERR(DRV, "invalid queue_id:%u reg_idx exceeded "
+				"max map cnt:%u.(err:%d)",
+				queue_id, SXE_QUEUE_STATS_MAP_REG_NUM, ret);
+		goto l_out;
+	}
+
+	map_idx = (u8)(queue_id % SXE_STAT_MAP_CNT);
+	map_mask <<= (SXE_STAT_MAP_WIDTH * map_idx);
+
+	if (!is_rx)
+		stats_map->txq_stats_map[reg_idx] &= ~map_mask;
+	else
+		stats_map->rxq_stats_map[reg_idx] &= ~map_mask;
+
+	qsmr_mask = (stat_reg_idx & SXE_STAT_MAP_MASK) << (SXE_STAT_MAP_WIDTH * map_idx);
+	if (!is_rx) {
+		stats_map->txq_stats_map[reg_idx] |= qsmr_mask;
+		sxe_hw_txq_stat_map_set(hw, reg_idx, stats_map->txq_stats_map[reg_idx]);
+	} else {
+		stats_map->rxq_stats_map[reg_idx] |= qsmr_mask;
+		sxe_hw_rxq_stat_map_set(hw, reg_idx, stats_map->rxq_stats_map[reg_idx]);
+	}
+
+	PMD_LOG_INFO(DRV, "port %u %s queue_id %d stat map to stat reg[%u] "
+			 "%s[%u] 0x%08x ",
+			 (u16)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
+			 queue_id, stat_reg_idx,
+			 is_rx ? "RQSMR" : "TQSM", reg_idx,
+			 is_rx ? stats_map->rxq_stats_map[reg_idx] :
+			 stats_map->txq_stats_map[reg_idx]);
+
+l_out:
+	return ret;
+}
+
+void sxe_queue_stats_map_restore(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_stats_map *stats_map = &adapter->stats_info.stats_map;
+	u8 reg_idx;
+
+	for (reg_idx = 0; reg_idx < SXE_QUEUE_STATS_MAP_REG_NUM; reg_idx++) {
+		sxe_hw_txq_stat_map_set(hw, reg_idx, stats_map->txq_stats_map[reg_idx]);
+		sxe_hw_rxq_stat_map_set(hw, reg_idx, stats_map->rxq_stats_map[reg_idx]);
+	}
+}
+
+void sxe_queue_stats_map_reset(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u8 reg_idx;
+
+#ifdef SET_AUTOFILL_QUEUE_XSTATS
+	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+#endif
+
+	for (reg_idx = 0; reg_idx < SXE_QUEUE_STATS_MAP_REG_NUM; reg_idx++) {
+		sxe_hw_txq_stat_map_set(hw, reg_idx, 0);
+		sxe_hw_rxq_stat_map_set(hw, reg_idx, 0);
+	}
+}
+
diff --git a/drivers/net/sxe/pf/sxe_stats.h b/drivers/net/sxe/pf/sxe_stats.h
new file mode 100644
index 0000000000..78a13e7a0b
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_stats.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_STATS_H__
+#define __SXE_STATS_H__
+
+#include <rte_ethdev.h>
+#include <rte_ethdev_core.h>
+
+#include "sxe_dpdk_version.h"
+#include "sxe_hw.h"
+
+#define SXE_STATS_FIELD_NAME_SIZE  50
+
+struct sxe_sw_stats {
+	u64 hw_csum_rx_error;
+};
+
+struct sxe_stats_map {
+	u32 txq_stats_map[SXE_QUEUE_STATS_MAP_REG_NUM];
+	u32 rxq_stats_map[SXE_QUEUE_STATS_MAP_REG_NUM];
+};
+
+struct sxe_stats_info {
+	struct sxe_sw_stats  sw_stats;
+	struct sxe_mac_stats hw_stats;
+	struct sxe_stats_map stats_map;
+};
+
+struct sxe_stats_field {
+	s8  name[SXE_STATS_FIELD_NAME_SIZE];
+	u32 offset;
+};
+
+s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev,
+				struct rte_eth_stats *stats);
+
+s32 sxe_stats_reset(struct rte_eth_dev *eth_dev);
+
+s32 sxe_xstats_get(struct rte_eth_dev *eth_dev,
+				struct rte_eth_xstat *xstats,
+				u32 cnt);
+
+s32 sxe_xstats_reset(struct rte_eth_dev *eth_dev);
+
+
+s32 sxe_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
+	struct rte_eth_xstat_name *xstats_names, __rte_unused unsigned int size);
+
+s32 sxe_xstats_get_by_id(struct rte_eth_dev *eth_dev,
+					const ulong *ids,
+					ulong *values, u32 usr_cnt);
+
+s32 sxe_xstats_names_get_by_id(struct rte_eth_dev *eth_dev,
+	const ulong *ids,
+	struct rte_eth_xstat_name *xstats_names,
+	u32 usr_cnt);
+
+
+s32 sxe_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
+				  u16 queue_id,
+				  u8 stat_reg_idx,
+				  u8 is_rx);
+
+void sxe_queue_stats_map_restore(struct rte_eth_dev *eth_dev);
+
+void sxe_queue_stats_map_reset(struct rte_eth_dev *eth_dev);
+
+#endif
+
-- 
2.18.4

