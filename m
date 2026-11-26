Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2F606A32C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 265BD406B7;
	Thu, 26 Nov 2026 08:34:53 +0100 (CET)
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com
 [115.124.28.73])
 by mails.dpdk.org (Postfix) with ESMTPS id 3E98440616
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:44 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712908|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0347778-0.00209423-0.963128;
 FP=15014999111489947108|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037033194; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1YvR_1795678481; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1YvR_1795678481 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:41 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 09/11] net/nbl: support draco stats and xstats
Date: Thu, 26 Nov 2026 15:34:26 +0800
Message-ID: <20261126073430.3168813-10-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Draco priority packet counters are 32 bits wide and byte counters
are 48 bits wide. Subtracting their baselines as 64-bit values
produces incorrect deltas when these counters wrap.

Move the xstats name structure to the common resource header and
record the counter width in each product's statistics table.
Expose these widths through resource and dispatch ops, and use
them to calculate xstats deltas.

Keep all leonis counter widths at 64 bits to preserve its existing
statistics behavior.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  24 ++-
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   3 +-
 drivers/net/nbl/nbl_dispatch.c                |  11 +
 .../nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c   | 193 +++++++++---------
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c | 181 ++++++++--------
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   5 +
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   1 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   1 +
 8 files changed, 239 insertions(+), 180 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 062f95c..531ac96 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -611,6 +611,13 @@ int nbl_stats_reset(struct rte_eth_dev *eth_dev)
 	return ret;
 }
 
+static u64 nbl_counter_delta(u64 current, u64 baseline, u8 bits)
+{
+	if (bits == 64)
+		return current - baseline;
+	return (current - baseline) & ((UINT64_C(1) << bits) - 1);
+}
+
 static int nbl_dev_update_hw_xstats(struct nbl_dev_mgt *dev_mgt, struct rte_eth_xstat *xstats,
 				    u16 need_xstats_cnt, u16 *xstats_cnt)
 {
@@ -624,7 +631,8 @@ static int nbl_dev_update_hw_xstats(struct nbl_dev_mgt *dev_mgt, struct rte_eth_
 					common->eth_id, net_dev->hw_xstats,
 					net_dev->hw_xstats_size);
 	for (i = 0; i < need_xstats_cnt; i++) {
-		xstats[count].value = net_dev->hw_xstats[i] - dev_mgt->net_dev->hw_xstats_offset[i];
+		xstats[count].value = nbl_counter_delta(net_dev->hw_xstats[i],
+			net_dev->hw_xstats_offset[i], net_dev->hw_xstats_bits[i]);
 		xstats[count].id = count;
 		count++;
 	}
@@ -920,6 +928,7 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 	}
 
 	net_dev->hw_xstats_offset = NULL;
+	net_dev->hw_xstats_bits = NULL;
 	if (!dev_mgt->common->is_vf)
 		disp_ops->get_hw_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &priv_cnt);
 	if (priv_cnt) {
@@ -930,6 +939,15 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 			ret = -ENOMEM;
 			goto alloc_xstats_offset_failed;
 		}
+		net_dev->hw_xstats_bits = rte_zmalloc("nbl_xstats_bits", priv_cnt, 0);
+		if (!net_dev->hw_xstats_bits) {
+			ret = -ENOMEM;
+			goto alloc_xstats_bits_failed;
+		}
+		ret = disp_ops->get_hw_xstats_bits(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+						 net_dev->hw_xstats_bits, priv_cnt);
+		if (ret)
+			goto get_xstats_bits_failed;
 		disp_ops->get_private_stat_data(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
 						dev_mgt->common->eth_id,
 						net_dev->hw_xstats_offset, net_dev->hw_xstats_size);
@@ -944,6 +962,9 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 	return 0;
 
 alloc_hw_xstats_failed:
+get_xstats_bits_failed:
+	rte_free(net_dev->hw_xstats_bits);
+alloc_xstats_bits_failed:
 	rte_free(net_dev->hw_xstats_offset);
 alloc_xstats_offset_failed:
 add_multi_rule_failed:
@@ -1000,6 +1021,7 @@ static void nbl_dev_snic_stop(void *p)
 	u8 *mac;
 
 	free(net_dev->hw_xstats);
+	rte_free(net_dev->hw_xstats_bits);
 	rte_free(net_dev->hw_xstats_offset);
 
 	mac = net_dev->eth_dev->data->mac_addrs->addr_bytes;
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index bfe2b06..9fa8a9d 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -50,6 +50,7 @@ struct nbl_dev_net_mgt {
 	struct nbl_eth_link_info eth_link_info;
 	u64 *hw_xstats;
 	u64 *hw_xstats_offset;
+	u8 *hw_xstats_bits;
 	u32 hw_xstats_size;
 	u16 vsi_id;
 	u8 eth_mode;
@@ -92,7 +93,7 @@ int nbl_stats_reset(struct rte_eth_dev *eth_dev);
 int nbl_xstats_get(struct rte_eth_dev *eth_dev, struct rte_eth_xstat *xstats, unsigned int n);
 int nbl_xstats_get_names(struct rte_eth_dev *eth_dev,
 			 struct rte_eth_xstat_name *xstats_names,
-			 __rte_unused unsigned int limit);
+			 unsigned int limit);
 int nbl_xstats_reset(struct rte_eth_dev *eth_dev);
 int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu);
 int nbl_promiscuous_enable(struct rte_eth_dev *eth_dev);
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index dae62e1..c693d8d 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -990,6 +990,14 @@ static int nbl_disp_get_hw_xstats_cnt(void *priv, u16 *xstats_cnt)
 	return res_ops->get_hw_xstats_cnt(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), xstats_cnt);
 }
 
+static int nbl_disp_get_hw_xstats_bits(void *priv, u8 *bits, u16 count)
+{
+	struct nbl_dispatch_mgt *disp_mgt = priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return res_ops->get_hw_xstats_bits(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), bits, count);
+}
+
 static int nbl_disp_get_hw_xstats_names(void *priv, struct rte_eth_xstat_name *xstats_names,
 					u16 need_xstats_cnt, u16 *xstats_cnt)
 {
@@ -1272,6 +1280,9 @@ do {									\
 	NBL_DISP_SET_OPS(get_hw_xstats_cnt, nbl_disp_get_hw_xstats_cnt,	\
 			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
 			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(get_hw_xstats_bits, nbl_disp_get_hw_xstats_bits,	\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
+			 NULL, NULL);					\
 	NBL_DISP_SET_OPS(get_hw_xstats_names,				\
 			 nbl_disp_get_hw_xstats_names,			\
 			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c
index 9e50657..43468c2 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c
@@ -4,99 +4,94 @@
 
 #include "nbl_res_draco.h"
 
-/* store statistics names */
-struct nbl_xstats_name {
-	char name[RTE_ETH_XSTATS_NAME_SIZE];
-};
-
 static const struct nbl_xstats_name nbl_stats_strings[] = {
-	{"eth_rx_prio0_packets"},
-	{"eth_rx_prio0_bytes"},
-	{"eth_rx_prio0_drop_packets"},
-	{"eth_tx_prio0_packets"},
-	{"eth_tx_prio0_bytes"},
-	{"eth_tx_prio0_drop_packets"},
-	{"eth_rx_prio1_packets"},
-	{"eth_rx_prio1_bytes"},
-	{"eth_rx_prio1_drop_packets"},
-	{"eth_tx_prio1_packets"},
-	{"eth_tx_prio1_bytes"},
-	{"eth_tx_prio1_drop_packets"},
-	{"eth_rx_prio2_packets"},
-	{"eth_rx_prio2_bytes"},
-	{"eth_rx_prio2_drop_packets"},
-	{"eth_tx_prio2_packets"},
-	{"eth_tx_prio2_bytes"},
-	{"eth_tx_prio2_drop_packets"},
-	{"eth_rx_prio3_packets"},
-	{"eth_rx_prio3_bytes"},
-	{"eth_rx_prio3_drop_packets"},
-	{"eth_tx_prio3_packets"},
-	{"eth_tx_prio3_bytes"},
-	{"eth_tx_prio3_drop_packets"},
-	{"eth_rx_prio4_packets"},
-	{"eth_rx_prio4_bytes"},
-	{"eth_rx_prio4_drop_packets"},
-	{"eth_tx_prio4_packets"},
-	{"eth_tx_prio4_bytes"},
-	{"eth_tx_prio4_drop_packets"},
-	{"eth_rx_prio5_packets"},
-	{"eth_rx_prio5_bytes"},
-	{"eth_rx_prio5_drop_packets"},
-	{"eth_tx_prio5_packets"},
-	{"eth_tx_prio5_bytes"},
-	{"eth_tx_prio5_drop_packets"},
-	{"eth_rx_prio6_packets"},
-	{"eth_rx_prio6_bytes"},
-	{"eth_rx_prio6_drop_packets"},
-	{"eth_tx_prio6_packets"},
-	{"eth_tx_prio6_bytes"},
-	{"eth_tx_prio6_drop_packets"},
-	{"eth_rx_prio7_packets"},
-	{"eth_rx_prio7_bytes"},
-	{"eth_rx_prio7_drop_packets"},
-	{"eth_tx_prio7_packets"},
-	{"eth_tx_prio7_bytes"},
-	{"eth_tx_prio7_drop_packets"},
-	{"eth_frames_txd"},
-	{"eth_frames_txd_ok"},
-	{"eth_unicast_frames_txd"},
-	{"eth_multicast_frames_txd"},
-	{"eth_multicast_frames_txd_ok"},
-	{"eth_broadcast_frames_txd"},
-	{"eth_broadcast_frames_txd_ok"},
-	{"eth_underflow_error_frames_txd"},
-	{"eth_pause_frames_txd"},
-	{"eth_vlan_frames_txd"},
-	{"eth_frames_txd_64B"},
-	{"eth_frames_txd_65_to_127B"},
-	{"eth_frames_txd_128_to_255B"},
-	{"eth_frames_txd_256_to_511B"},
-	{"eth_frames_txd_512_to_1023B"},
-	{"eth_frames_txd_1024_to_MAXB"},
-	{"eth_octets_txd"},
-	{"eth_frames_rxd"},
-	{"eth_undersize_frames_rxd_good"},
-	{"eth_oversize_frames_rxd_good"},
-	{"eth_unicast_frames_rxd_ok"},
-	{"eth_multicast_frames_rxd_ok"},
-	{"eth_broadcast_frames_rxd_ok"},
-	{"eth_crc_error_frames_rxd"},
-	{"eth_runt_error_frames_rxd"},
-	{"eth_jabber_error_frames_rxd"},
-	{"eth_length_error_frames_rxd"},
-	{"eth_out_of_range_type_frames_rxd"},
-	{"eth_pause_frames_rxd"},
-	{"eth_vlan_frames_rxd"},
-	{"eth_watchdog_error_frames_rxd"},
-	{"eth_frames_rxd_64B"},
-	{"eth_frames_rxd_65_to_127B"},
-	{"eth_frames_rxd_128_to_255B"},
-	{"eth_frames_rxd_256_to_511B"},
-	{"eth_frames_rxd_512_to_1023B"},
-	{"eth_frames_rxd_1024_to_MAXB"},
-	{"eth_octets_rxd"},
-	{"eth_octets_rxd_ok"},
+	{"eth_rx_prio0_packets", 32},
+	{"eth_rx_prio0_bytes", 48},
+	{"eth_rx_prio0_drop_packets", 32},
+	{"eth_tx_prio0_packets", 32},
+	{"eth_tx_prio0_bytes", 48},
+	{"eth_tx_prio0_drop_packets", 32},
+	{"eth_rx_prio1_packets", 32},
+	{"eth_rx_prio1_bytes", 48},
+	{"eth_rx_prio1_drop_packets", 32},
+	{"eth_tx_prio1_packets", 32},
+	{"eth_tx_prio1_bytes", 48},
+	{"eth_tx_prio1_drop_packets", 32},
+	{"eth_rx_prio2_packets", 32},
+	{"eth_rx_prio2_bytes", 48},
+	{"eth_rx_prio2_drop_packets", 32},
+	{"eth_tx_prio2_packets", 32},
+	{"eth_tx_prio2_bytes", 48},
+	{"eth_tx_prio2_drop_packets", 32},
+	{"eth_rx_prio3_packets", 32},
+	{"eth_rx_prio3_bytes", 48},
+	{"eth_rx_prio3_drop_packets", 32},
+	{"eth_tx_prio3_packets", 32},
+	{"eth_tx_prio3_bytes", 48},
+	{"eth_tx_prio3_drop_packets", 32},
+	{"eth_rx_prio4_packets", 32},
+	{"eth_rx_prio4_bytes", 48},
+	{"eth_rx_prio4_drop_packets", 32},
+	{"eth_tx_prio4_packets", 32},
+	{"eth_tx_prio4_bytes", 48},
+	{"eth_tx_prio4_drop_packets", 32},
+	{"eth_rx_prio5_packets", 32},
+	{"eth_rx_prio5_bytes", 48},
+	{"eth_rx_prio5_drop_packets", 32},
+	{"eth_tx_prio5_packets", 32},
+	{"eth_tx_prio5_bytes", 48},
+	{"eth_tx_prio5_drop_packets", 32},
+	{"eth_rx_prio6_packets", 32},
+	{"eth_rx_prio6_bytes", 48},
+	{"eth_rx_prio6_drop_packets", 32},
+	{"eth_tx_prio6_packets", 32},
+	{"eth_tx_prio6_bytes", 48},
+	{"eth_tx_prio6_drop_packets", 32},
+	{"eth_rx_prio7_packets", 32},
+	{"eth_rx_prio7_bytes", 48},
+	{"eth_rx_prio7_drop_packets", 32},
+	{"eth_tx_prio7_packets", 32},
+	{"eth_tx_prio7_bytes", 48},
+	{"eth_tx_prio7_drop_packets", 32},
+	{"eth_frames_txd", 64},
+	{"eth_frames_txd_ok", 64},
+	{"eth_unicast_frames_txd", 64},
+	{"eth_multicast_frames_txd", 64},
+	{"eth_multicast_frames_txd_ok", 64},
+	{"eth_broadcast_frames_txd", 64},
+	{"eth_broadcast_frames_txd_ok", 64},
+	{"eth_underflow_error_frames_txd", 64},
+	{"eth_pause_frames_txd", 64},
+	{"eth_vlan_frames_txd", 64},
+	{"eth_frames_txd_64B", 64},
+	{"eth_frames_txd_65_to_127B", 64},
+	{"eth_frames_txd_128_to_255B", 64},
+	{"eth_frames_txd_256_to_511B", 64},
+	{"eth_frames_txd_512_to_1023B", 64},
+	{"eth_frames_txd_1024_to_MAXB", 64},
+	{"eth_octets_txd", 64},
+	{"eth_frames_rxd", 64},
+	{"eth_undersize_frames_rxd_good", 64},
+	{"eth_oversize_frames_rxd_good", 64},
+	{"eth_unicast_frames_rxd_ok", 64},
+	{"eth_multicast_frames_rxd_ok", 64},
+	{"eth_broadcast_frames_rxd_ok", 64},
+	{"eth_crc_error_frames_rxd", 64},
+	{"eth_runt_error_frames_rxd", 64},
+	{"eth_jabber_error_frames_rxd", 64},
+	{"eth_length_error_frames_rxd", 64},
+	{"eth_out_of_range_type_frames_rxd", 64},
+	{"eth_pause_frames_rxd", 64},
+	{"eth_vlan_frames_rxd", 64},
+	{"eth_watchdog_error_frames_rxd", 64},
+	{"eth_frames_rxd_64B", 64},
+	{"eth_frames_rxd_65_to_127B", 64},
+	{"eth_frames_rxd_128_to_255B", 64},
+	{"eth_frames_rxd_256_to_511B", 64},
+	{"eth_frames_rxd_512_to_1023B", 64},
+	{"eth_frames_rxd_1024_to_MAXB", 64},
+	{"eth_octets_rxd", 64},
+	{"eth_octets_rxd_ok", 64},
 };
 
 static int nbl_get_xstats_cnt(void *priv, u16 *xstats_cnt)
@@ -106,6 +101,19 @@ static int nbl_get_xstats_cnt(void *priv, u16 *xstats_cnt)
 	return 0;
 }
 
+static int nbl_get_xstats_bits(void *priv, u8 *bits, u16 count)
+{
+	u16 i;
+
+	RTE_SET_USED(priv);
+	if (count > ARRAY_SIZE(nbl_stats_strings))
+		return -EINVAL;
+
+	for (i = 0; i < count; i++)
+		bits[i] = nbl_stats_strings[i].bits;
+	return 0;
+}
+
 static int nbl_get_xstats_names(void *priv,
 				struct rte_eth_xstat_name *xstats_names,
 				u16 need_xstats_cnt, u16 *xstats_cnt)
@@ -129,6 +137,7 @@ static int nbl_get_xstats_names(void *priv,
 
 static struct nbl_resource_ops nbl_res_ops = {
 	.get_hw_xstats_cnt = nbl_get_xstats_cnt,
+	.get_hw_xstats_bits = nbl_get_xstats_bits,
 	.get_hw_xstats_names = nbl_get_xstats_names,
 };
 
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
index 5d40d4f..14df50a 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
@@ -4,93 +4,88 @@
 
 #include "nbl_res_leonis.h"
 
-/* store statistics names */
-struct nbl_xstats_name {
-	char name[RTE_ETH_XSTATS_NAME_SIZE];
-};
-
 static const struct nbl_xstats_name nbl_stats_strings[] = {
-	{"eth_frames_tx"},
-	{"eth_frames_tx_ok"},
-	{"eth_frames_tx_badfcs"},
-	{"eth_unicast_frames_tx_ok"},
-	{"eth_multicast_frames_tx_ok"},
-	{"eth_broadcast_frames_tx_ok"},
-	{"eth_macctrl_frames_tx_ok"},
-	{"eth_fragment_frames_tx"},
-	{"eth_fragment_frames_tx_ok"},
-	{"eth_pause_frames_tx"},
-	{"eth_pause_macctrl_frames_tx"},
-	{"eth_pfc_frames_tx"},
-	{"eth_pfc_frames_tx_prio0"},
-	{"eth_pfc_frames_tx_prio1"},
-	{"eth_pfc_frames_tx_prio2"},
-	{"eth_pfc_frames_tx_prio3"},
-	{"eth_pfc_frames_tx_prio4"},
-	{"eth_pfc_frames_tx_prio5"},
-	{"eth_pfc_frames_tx_prio6"},
-	{"eth_pfc_frames_tx_prio7"},
-	{"eth_verify_frames_tx"},
-	{"eth_respond_frames_tx"},
-	{"eth_frames_tx_64B"},
-	{"eth_frames_tx_65_to_127B"},
-	{"eth_frames_tx_128_to_255B"},
-	{"eth_frames_tx_256_to_511B"},
-	{"eth_frames_tx_512_to_1023B"},
-	{"eth_frames_tx_1024_to_1535B"},
-	{"eth_frames_tx_1536_to_2047B"},
-	{"eth_frames_tx_2048_to_MAXB"},
-	{"eth_undersize_frames_tx_goodfcs"},
-	{"eth_oversize_frames_tx_goodfcs"},
-	{"eth_undersize_frames_tx_badfcs"},
-	{"eth_oversize_frames_tx_badfcs"},
-	{"eth_octets_tx"},
-	{"eth_octets_tx_ok"},
-	{"eth_octets_tx_badfcs"},
-	{"eth_frames_rx"},
-	{"eth_frames_rx_ok"},
-	{"eth_frames_rx_badfcs"},
-	{"eth_undersize_frames_rx_goodfcs"},
-	{"eth_undersize_frames_rx_badfcs"},
-	{"eth_oversize_frames_rx_goodfcs"},
-	{"eth_oversize_frames_rx_badfcs"},
-	{"eth_frames_rx_misc_error"},
-	{"eth_frames_rx_misc_dropped"},
-	{"eth_unicast_frames_rx_ok"},
-	{"eth_multicast_frames_rx_ok"},
-	{"eth_broadcast_frames_rx_ok"},
-	{"eth_pause_frames_rx"},
-	{"eth_pfc_frames_rx"},
-	{"eth_pfc_frames_rx_prio0"},
-	{"eth_pfc_frames_rx_prio1"},
-	{"eth_pfc_frames_rx_prio2"},
-	{"eth_pfc_frames_rx_prio3"},
-	{"eth_pfc_frames_rx_prio4"},
-	{"eth_pfc_frames_rx_prio5"},
-	{"eth_pfc_frames_rx_prio6"},
-	{"eth_pfc_frames_rx_prio7"},
-	{"eth_macctrl_frames_rx"},
-	{"eth_verify_frames_rx_ok"},
-	{"eth_respond_frames_rx_ok"},
-	{"eth_fragment_frames_rx_ok"},
-	{"eth_fragment_rx_smdc_nocontext"},
-	{"eth_fragment_rx_smds_seq_error"},
-	{"eth_fragment_rx_smdc_seq_error"},
-	{"eth_fragment_rx_frag_cnt_error"},
-	{"eth_frames_assembled_ok"},
-	{"eth_frames_assembled_error"},
-	{"eth_frames_rx_64B"},
-	{"eth_frames_rx_65_to_127B"},
-	{"eth_frames_rx_128_to_255B"},
-	{"eth_frames_rx_256_to_511B"},
-	{"eth_frames_rx_512_to_1023B"},
-	{"eth_frames_rx_1024_to_1535B"},
-	{"eth_frames_rx_1536_to_2047B"},
-	{"eth_frames_rx_2048_to_MAXB"},
-	{"eth_octets_rx"},
-	{"eth_octets_rx_ok"},
-	{"eth_octets_rx_badfcs"},
-	{"eth_octets_rx_dropped"},
+	{"eth_frames_tx", 64},
+	{"eth_frames_tx_ok", 64},
+	{"eth_frames_tx_badfcs", 64},
+	{"eth_unicast_frames_tx_ok", 64},
+	{"eth_multicast_frames_tx_ok", 64},
+	{"eth_broadcast_frames_tx_ok", 64},
+	{"eth_macctrl_frames_tx_ok", 64},
+	{"eth_fragment_frames_tx", 64},
+	{"eth_fragment_frames_tx_ok", 64},
+	{"eth_pause_frames_tx", 64},
+	{"eth_pause_macctrl_frames_tx", 64},
+	{"eth_pfc_frames_tx", 64},
+	{"eth_pfc_frames_tx_prio0", 64},
+	{"eth_pfc_frames_tx_prio1", 64},
+	{"eth_pfc_frames_tx_prio2", 64},
+	{"eth_pfc_frames_tx_prio3", 64},
+	{"eth_pfc_frames_tx_prio4", 64},
+	{"eth_pfc_frames_tx_prio5", 64},
+	{"eth_pfc_frames_tx_prio6", 64},
+	{"eth_pfc_frames_tx_prio7", 64},
+	{"eth_verify_frames_tx", 64},
+	{"eth_respond_frames_tx", 64},
+	{"eth_frames_tx_64B", 64},
+	{"eth_frames_tx_65_to_127B", 64},
+	{"eth_frames_tx_128_to_255B", 64},
+	{"eth_frames_tx_256_to_511B", 64},
+	{"eth_frames_tx_512_to_1023B", 64},
+	{"eth_frames_tx_1024_to_1535B", 64},
+	{"eth_frames_tx_1536_to_2047B", 64},
+	{"eth_frames_tx_2048_to_MAXB", 64},
+	{"eth_undersize_frames_tx_goodfcs", 64},
+	{"eth_oversize_frames_tx_goodfcs", 64},
+	{"eth_undersize_frames_tx_badfcs", 64},
+	{"eth_oversize_frames_tx_badfcs", 64},
+	{"eth_octets_tx", 64},
+	{"eth_octets_tx_ok", 64},
+	{"eth_octets_tx_badfcs", 64},
+	{"eth_frames_rx", 64},
+	{"eth_frames_rx_ok", 64},
+	{"eth_frames_rx_badfcs", 64},
+	{"eth_undersize_frames_rx_goodfcs", 64},
+	{"eth_undersize_frames_rx_badfcs", 64},
+	{"eth_oversize_frames_rx_goodfcs", 64},
+	{"eth_oversize_frames_rx_badfcs", 64},
+	{"eth_frames_rx_misc_error", 64},
+	{"eth_frames_rx_misc_dropped", 64},
+	{"eth_unicast_frames_rx_ok", 64},
+	{"eth_multicast_frames_rx_ok", 64},
+	{"eth_broadcast_frames_rx_ok", 64},
+	{"eth_pause_frames_rx", 64},
+	{"eth_pfc_frames_rx", 64},
+	{"eth_pfc_frames_rx_prio0", 64},
+	{"eth_pfc_frames_rx_prio1", 64},
+	{"eth_pfc_frames_rx_prio2", 64},
+	{"eth_pfc_frames_rx_prio3", 64},
+	{"eth_pfc_frames_rx_prio4", 64},
+	{"eth_pfc_frames_rx_prio5", 64},
+	{"eth_pfc_frames_rx_prio6", 64},
+	{"eth_pfc_frames_rx_prio7", 64},
+	{"eth_macctrl_frames_rx", 64},
+	{"eth_verify_frames_rx_ok", 64},
+	{"eth_respond_frames_rx_ok", 64},
+	{"eth_fragment_frames_rx_ok", 64},
+	{"eth_fragment_rx_smdc_nocontext", 64},
+	{"eth_fragment_rx_smds_seq_error", 64},
+	{"eth_fragment_rx_smdc_seq_error", 64},
+	{"eth_fragment_rx_frag_cnt_error", 64},
+	{"eth_frames_assembled_ok", 64},
+	{"eth_frames_assembled_error", 64},
+	{"eth_frames_rx_64B", 64},
+	{"eth_frames_rx_65_to_127B", 64},
+	{"eth_frames_rx_128_to_255B", 64},
+	{"eth_frames_rx_256_to_511B", 64},
+	{"eth_frames_rx_512_to_1023B", 64},
+	{"eth_frames_rx_1024_to_1535B", 64},
+	{"eth_frames_rx_1536_to_2047B", 64},
+	{"eth_frames_rx_2048_to_MAXB", 64},
+	{"eth_octets_rx", 64},
+	{"eth_octets_rx_ok", 64},
+	{"eth_octets_rx_badfcs", 64},
+	{"eth_octets_rx_dropped", 64},
 };
 
 static int nbl_get_xstats_cnt(__rte_unused void *priv, u16 *xstats_cnt)
@@ -99,6 +94,19 @@ static int nbl_get_xstats_cnt(__rte_unused void *priv, u16 *xstats_cnt)
 	return 0;
 }
 
+static int nbl_get_xstats_bits(void *priv, u8 *bits, u16 count)
+{
+	u16 i;
+
+	RTE_SET_USED(priv);
+	if (count > ARRAY_SIZE(nbl_stats_strings))
+		return -EINVAL;
+
+	for (i = 0; i < count; i++)
+		bits[i] = nbl_stats_strings[i].bits;
+	return 0;
+}
+
 static int nbl_get_xstats_names(__rte_unused void *priv,
 				struct rte_eth_xstat_name *xstats_names,
 				u16 need_xstats_cnt, u16 *xstats_cnt)
@@ -117,6 +125,7 @@ static int nbl_get_xstats_names(__rte_unused void *priv,
 
 static struct nbl_resource_ops nbl_res_ops = {
 	.get_hw_xstats_cnt = nbl_get_xstats_cnt,
+	.get_hw_xstats_bits = nbl_get_xstats_bits,
 	.get_hw_xstats_names = nbl_get_xstats_names,
 };
 
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index 688dba9..d240935 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -23,6 +23,11 @@
 #define NBL_RES_MGT_TO_RX_RING(res_mgt, index)	\
 	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->rx_rings[(index)])
 
+struct nbl_xstats_name {
+	char name[RTE_ETH_XSTATS_NAME_SIZE];
+	u8 bits;
+};
+
 union nbl_tx_extend_head {
 	struct nbl_tx_ehdr_leonis {
 		/* DW0 */
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
index 45e7504..ebf94d3 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -87,6 +87,7 @@ struct nbl_dispatch_ops {
 	int (*get_txrx_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
 				     u16 need_xstats_cnt, u16 *xstats_cnt);
 	int (*get_hw_xstats_cnt)(void *priv, u16 *xstats_cnt);
+	int (*get_hw_xstats_bits)(void *priv, u8 *bits, u16 count);
 	int (*get_hw_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
 				   u16 need_xstats_cnt, u16 *xstats_cnt);
 	void (*get_private_stat_data)(void *priv, u32 eth_id, u64 *data, u32 data_len);
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index 604b6d0..fd33bff 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -57,6 +57,7 @@ struct nbl_resource_ops {
 	int (*get_txrx_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
 				     u16 need_xstats_cnt, u16 *xstats_cnt);
 	int (*get_hw_xstats_cnt)(void *priv, u16 *xstats_cnt);
+	int (*get_hw_xstats_bits)(void *priv, u8 *bits, u16 count);
 	int (*get_hw_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
 				   u16 need_xstats_cnt, u16 *xstats_cnt);
 	void (*get_private_stat_data)(void *priv, u32 eth_id, u64 *data);
-- 
2.53.0

