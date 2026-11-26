Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47F606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:35:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60575402B2;
	Thu, 26 Nov 2026 08:34:52 +0100 (CET)
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com
 [115.124.28.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 2118540284
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:44 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712908|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0126312-0.00539203-0.981977;
 FP=15156721796354016900|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033065158064; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1Ysj_1795678478; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1Ysj_1795678478 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:39 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 04/11] net/nbl: add draco resource layer
Date: Thu, 26 Nov 2026 15:34:21 +0800
Message-ID: <20261126073430.3168813-5-dimon.zhao@nebula-matrix.com>
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

Add draco resource initialization and teardown, and connect the
resource operations to the common Tx/Rx management code.

Use a shared static resource operations table, following leonis,
and provide hardware statistics names in kernel response order.
Capture the managing PF during resource initialization and save it
as the mailbox destination. Keep the leonis destination at zero.

Replace the resource placeholders and keep probing disabled at
dispatch initialization until the dispatch layer is implemented.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |   1 +
 drivers/net/nbl/nbl_core.c                    |  12 +-
 drivers/net/nbl/nbl_dispatch.c                |  19 +-
 .../nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c   | 265 ++++++++++++++++++
 .../nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h   |  10 +
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   4 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   3 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   1 +
 8 files changed, 303 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index e2b1487..9c54522 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -24,4 +24,5 @@ sources = files(
         'nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c',
         'nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c',
         'nbl_hw/nbl_hw_leonis/nbl_res_leonis.c',
+        'nbl_hw/nbl_hw_draco/nbl_res_draco.c',
 )
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index 263a61b..4ae22f2 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -4,17 +4,6 @@
 
 #include "nbl_core.h"
 
-static int nbl_res_init_draco(void *adapter __rte_unused,
-			      struct rte_eth_dev *eth_dev __rte_unused)
-{
-	/* Keep probing disabled until the Draco resource layer is implemented. */
-	return -ENOTSUP;
-}
-
-static void nbl_res_remove_draco(void *adapter __rte_unused)
-{
-}
-
 const struct nbl_product_core_ops nbl_product_core_ops[NBL_PRODUCT_MAX] = {
 	[NBL_LEONIS_TYPE] = {
 		.hw_init	= nbl_hw_init_leonis_snic,
@@ -62,6 +51,7 @@ int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
 	adapter->pci_dev = pci_dev;
 	common->eth_dev = eth_dev;
 	nbl_init_func_caps(pci_dev, &adapter->caps);
+	common->mgt_pf = 0;
 
 	common->is_vf = (pci_dev->id.device_id == NBL_DEVICE_ID_M18100_VF ||
 			 pci_dev->id.device_id == NBL_DEVICE_ID_M18305_VF);
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index f4f1ee4..b061f79 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -1429,11 +1429,28 @@ static int nbl_disp_leonis_uninit(void *p)
 	return 0;
 }
 
+static int nbl_disp_draco_init(void *p)
+{
+	RTE_SET_USED(p);
+	/* Keep probing disabled until the Draco dispatch layer is implemented. */
+	return -ENOTSUP;
+}
+
+static int nbl_disp_draco_uninit(void *p)
+{
+	RTE_SET_USED(p);
+	return 0;
+}
+
 static struct nbl_product_dispatch_ops nbl_product_dispatch_ops[NBL_PRODUCT_MAX] = {
-	{
+	[NBL_LEONIS_TYPE] = {
 		.dispatch_init		= nbl_disp_leonis_init,
 		.dispatch_uninit	= nbl_disp_leonis_uninit,
 	},
+	[NBL_DRACO_TYPE] = {
+		.dispatch_init		= nbl_disp_draco_init,
+		.dispatch_uninit	= nbl_disp_draco_uninit,
+	},
 };
 
 struct nbl_product_dispatch_ops *nbl_dispatch_get_product_ops(enum nbl_product_type product_type)
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c
new file mode 100644
index 0000000..9e50657
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c
@@ -0,0 +1,265 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_res_draco.h"
+
+/* store statistics names */
+struct nbl_xstats_name {
+	char name[RTE_ETH_XSTATS_NAME_SIZE];
+};
+
+static const struct nbl_xstats_name nbl_stats_strings[] = {
+	{"eth_rx_prio0_packets"},
+	{"eth_rx_prio0_bytes"},
+	{"eth_rx_prio0_drop_packets"},
+	{"eth_tx_prio0_packets"},
+	{"eth_tx_prio0_bytes"},
+	{"eth_tx_prio0_drop_packets"},
+	{"eth_rx_prio1_packets"},
+	{"eth_rx_prio1_bytes"},
+	{"eth_rx_prio1_drop_packets"},
+	{"eth_tx_prio1_packets"},
+	{"eth_tx_prio1_bytes"},
+	{"eth_tx_prio1_drop_packets"},
+	{"eth_rx_prio2_packets"},
+	{"eth_rx_prio2_bytes"},
+	{"eth_rx_prio2_drop_packets"},
+	{"eth_tx_prio2_packets"},
+	{"eth_tx_prio2_bytes"},
+	{"eth_tx_prio2_drop_packets"},
+	{"eth_rx_prio3_packets"},
+	{"eth_rx_prio3_bytes"},
+	{"eth_rx_prio3_drop_packets"},
+	{"eth_tx_prio3_packets"},
+	{"eth_tx_prio3_bytes"},
+	{"eth_tx_prio3_drop_packets"},
+	{"eth_rx_prio4_packets"},
+	{"eth_rx_prio4_bytes"},
+	{"eth_rx_prio4_drop_packets"},
+	{"eth_tx_prio4_packets"},
+	{"eth_tx_prio4_bytes"},
+	{"eth_tx_prio4_drop_packets"},
+	{"eth_rx_prio5_packets"},
+	{"eth_rx_prio5_bytes"},
+	{"eth_rx_prio5_drop_packets"},
+	{"eth_tx_prio5_packets"},
+	{"eth_tx_prio5_bytes"},
+	{"eth_tx_prio5_drop_packets"},
+	{"eth_rx_prio6_packets"},
+	{"eth_rx_prio6_bytes"},
+	{"eth_rx_prio6_drop_packets"},
+	{"eth_tx_prio6_packets"},
+	{"eth_tx_prio6_bytes"},
+	{"eth_tx_prio6_drop_packets"},
+	{"eth_rx_prio7_packets"},
+	{"eth_rx_prio7_bytes"},
+	{"eth_rx_prio7_drop_packets"},
+	{"eth_tx_prio7_packets"},
+	{"eth_tx_prio7_bytes"},
+	{"eth_tx_prio7_drop_packets"},
+	{"eth_frames_txd"},
+	{"eth_frames_txd_ok"},
+	{"eth_unicast_frames_txd"},
+	{"eth_multicast_frames_txd"},
+	{"eth_multicast_frames_txd_ok"},
+	{"eth_broadcast_frames_txd"},
+	{"eth_broadcast_frames_txd_ok"},
+	{"eth_underflow_error_frames_txd"},
+	{"eth_pause_frames_txd"},
+	{"eth_vlan_frames_txd"},
+	{"eth_frames_txd_64B"},
+	{"eth_frames_txd_65_to_127B"},
+	{"eth_frames_txd_128_to_255B"},
+	{"eth_frames_txd_256_to_511B"},
+	{"eth_frames_txd_512_to_1023B"},
+	{"eth_frames_txd_1024_to_MAXB"},
+	{"eth_octets_txd"},
+	{"eth_frames_rxd"},
+	{"eth_undersize_frames_rxd_good"},
+	{"eth_oversize_frames_rxd_good"},
+	{"eth_unicast_frames_rxd_ok"},
+	{"eth_multicast_frames_rxd_ok"},
+	{"eth_broadcast_frames_rxd_ok"},
+	{"eth_crc_error_frames_rxd"},
+	{"eth_runt_error_frames_rxd"},
+	{"eth_jabber_error_frames_rxd"},
+	{"eth_length_error_frames_rxd"},
+	{"eth_out_of_range_type_frames_rxd"},
+	{"eth_pause_frames_rxd"},
+	{"eth_vlan_frames_rxd"},
+	{"eth_watchdog_error_frames_rxd"},
+	{"eth_frames_rxd_64B"},
+	{"eth_frames_rxd_65_to_127B"},
+	{"eth_frames_rxd_128_to_255B"},
+	{"eth_frames_rxd_256_to_511B"},
+	{"eth_frames_rxd_512_to_1023B"},
+	{"eth_frames_rxd_1024_to_MAXB"},
+	{"eth_octets_rxd"},
+	{"eth_octets_rxd_ok"},
+};
+
+static int nbl_get_xstats_cnt(void *priv, u16 *xstats_cnt)
+{
+	RTE_SET_USED(priv);
+	*xstats_cnt = ARRAY_SIZE(nbl_stats_strings);
+	return 0;
+}
+
+static int nbl_get_xstats_names(void *priv,
+				struct rte_eth_xstat_name *xstats_names,
+				u16 need_xstats_cnt, u16 *xstats_cnt)
+{
+	u32 i = 0;
+	u16 count = *xstats_cnt;
+
+	RTE_SET_USED(priv);
+
+	if (need_xstats_cnt > ARRAY_SIZE(nbl_stats_strings))
+		return -EINVAL;
+
+	for (i = 0; i < need_xstats_cnt; i++) {
+		strlcpy(xstats_names[count].name, nbl_stats_strings[i].name,
+			sizeof(xstats_names[count].name));
+		count++;
+	}
+	*xstats_cnt = count;
+	return 0;
+}
+
+static struct nbl_resource_ops nbl_res_ops = {
+	.get_hw_xstats_cnt = nbl_get_xstats_cnt,
+	.get_hw_xstats_names = nbl_get_xstats_names,
+};
+
+static bool is_ops_inited;
+
+static void nbl_res_remove_ops(struct nbl_resource_ops_tbl **res_ops_tbl)
+{
+	free(*res_ops_tbl);
+	*res_ops_tbl = NULL;
+}
+
+static int nbl_res_setup_ops(struct nbl_resource_ops_tbl **res_ops_tbl,
+			     struct nbl_resource_mgt_draco *res_mgt_draco)
+{
+	int ret = 0;
+
+	*res_ops_tbl = calloc(1, sizeof(struct nbl_resource_ops_tbl));
+	if (!*res_ops_tbl)
+		return -ENOMEM;
+
+	if (!is_ops_inited) {
+		ret = nbl_txrx_setup_ops(&nbl_res_ops);
+		if (ret)
+			goto set_ops_failed;
+
+		is_ops_inited = true;
+	}
+
+	NBL_RES_OPS_TBL_TO_OPS(*res_ops_tbl) = &nbl_res_ops;
+	NBL_RES_OPS_TBL_TO_PRIV(*res_ops_tbl) = res_mgt_draco;
+
+	return ret;
+
+set_ops_failed:
+	nbl_res_remove_ops(res_ops_tbl);
+	return ret;
+}
+
+static void nbl_res_stop(struct nbl_resource_mgt_draco *res_mgt_draco)
+{
+	struct nbl_resource_mgt *res_mgt = &res_mgt_draco->res_mgt;
+	nbl_txrx_mgt_stop(res_mgt);
+}
+
+static int nbl_res_start(struct nbl_resource_mgt_draco *res_mgt_draco)
+{
+	struct nbl_resource_mgt *res_mgt = &res_mgt_draco->res_mgt;
+	const struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	u16 func_id, mgt_pf;
+	int ret;
+
+	ret = hw_ops->capture_bdf(NBL_RES_MGT_TO_HW_PRIV(res_mgt), &func_id, &mgt_pf);
+	if (ret)
+		return ret;
+	common->mgt_pf = mgt_pf;
+	res_mgt->res_info.base_qid = 0;
+
+	return nbl_txrx_mgt_start(res_mgt);
+}
+
+static void
+nbl_res_remove_res_mgt(struct nbl_resource_mgt_draco **res_mgt_draco)
+{
+	rte_free(*res_mgt_draco);
+	*res_mgt_draco = NULL;
+}
+
+static int
+nbl_res_setup_res_mgt(struct nbl_resource_mgt_draco **res_mgt_draco)
+{
+	*res_mgt_draco = rte_zmalloc("nbl_res_mgt",
+				      sizeof(struct nbl_resource_mgt_draco),
+				      0);
+	if (!*res_mgt_draco)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int nbl_res_init_draco(void *p, struct rte_eth_dev *eth_dev)
+{
+	struct nbl_resource_mgt_draco **res_mgt_draco;
+	struct nbl_resource_ops_tbl **res_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	int ret = 0;
+
+	res_mgt_draco = (struct nbl_resource_mgt_draco **)&NBL_ADAPTER_TO_RES_MGT(adapter);
+	res_ops_tbl = &NBL_ADAPTER_TO_RES_OPS_TBL(adapter);
+	hw_ops_tbl = NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
+	chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
+
+	ret = nbl_res_setup_res_mgt(res_mgt_draco);
+	if (ret)
+		goto setup_mgt_fail;
+
+	NBL_RES_MGT_TO_CHAN_OPS_TBL(&(*res_mgt_draco)->res_mgt) = chan_ops_tbl;
+	NBL_RES_MGT_TO_HW_OPS_TBL(&(*res_mgt_draco)->res_mgt) = hw_ops_tbl;
+	NBL_RES_MGT_TO_ETH_DEV(&(*res_mgt_draco)->res_mgt) = eth_dev;
+	NBL_RES_MGT_TO_COMMON(&(*res_mgt_draco)->res_mgt) = &adapter->common;
+
+	ret = nbl_res_start(*res_mgt_draco);
+	if (ret)
+		goto start_fail;
+
+	ret = nbl_res_setup_ops(res_ops_tbl, *res_mgt_draco);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_res_stop(*res_mgt_draco);
+start_fail:
+	nbl_res_remove_res_mgt(res_mgt_draco);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_res_remove_draco(void *p)
+{
+	struct nbl_resource_mgt_draco **res_mgt_draco;
+	struct nbl_resource_ops_tbl **res_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+
+	res_mgt_draco = (struct nbl_resource_mgt_draco **)&NBL_ADAPTER_TO_RES_MGT(adapter);
+	res_ops_tbl = &NBL_ADAPTER_TO_RES_OPS_TBL(adapter);
+
+	nbl_res_remove_ops(res_ops_tbl);
+	nbl_res_stop(*res_mgt_draco);
+	nbl_res_remove_res_mgt(res_mgt_draco);
+}
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h
new file mode 100644
index 0000000..c33ed47
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_RES_DRACO_H_
+#define _NBL_RES_DRACO_H_
+
+#include "nbl_resource.h"
+
+#endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index f2182ba..2d4f5d6 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -240,6 +240,10 @@ struct nbl_resource_mgt_leonis {
 	struct nbl_resource_mgt res_mgt;
 };
 
+struct nbl_resource_mgt_draco {
+	struct nbl_resource_mgt res_mgt;
+};
+
 int nbl_txrx_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_txrx_mgt_stop(struct nbl_resource_mgt *res_mgt);
 int nbl_txrx_setup_ops(struct nbl_resource_ops *resource_ops);
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index a803c59..604b6d0 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -96,4 +96,7 @@ struct nbl_resource_ops_tbl {
 int nbl_res_init_leonis(void *p, struct rte_eth_dev *eth_dev);
 void nbl_res_remove_leonis(void *p);
 
+int nbl_res_init_draco(void *p, struct rte_eth_dev *eth_dev);
+void nbl_res_remove_draco(void *p);
+
 #endif
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 08566ca..0203e43 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -140,6 +140,7 @@ struct nbl_common_info {
 	int nl_socket_route;
 	int dma_limit_msb;
 	u8 eth_id;
+	u8 mgt_pf;
 	/* isolate 1 means kernel network, 0 means user network */
 	u8 isolate:1;
 	/* curr_network 0 means kernel network, 1 means user network */
-- 
2.53.0

