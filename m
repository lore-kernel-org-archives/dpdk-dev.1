Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03268C9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:50:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFB2B40B9A;
	Mon, 28 Sep 2026 12:50:15 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by mails.dpdk.org (Postfix) with ESMTP id C61FB40B9F
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:50:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGjHX2dKY0MMhlGFUGPcWQOMw1hM6ASH/I5Ln2qeexkuCC0yqnfnlF+ccJyE4Fvt9uxAdn4dQTobC1z/Kiw3G1t+zTRIp/NsSvKerSIVGCjG/gC6bJUbSK4A4XI86cFUI0Ni3xxjUZ2wTB8taWK0I5NNnp87UfsNGfw9H19f97MwM++mr+kd+EGtAgSbPPS+IwwvyY5B1KVZ0VPf9wPFHmjz/bwH30WC198e4maSLuUiD8M0EzjSUv9LIoP94eJeuCqkI6Bw4DzA/btC0mv8qLtlqDpDDZ2xbg2vKDHlsBDl26Sr4QRJVMKOT+jPAVieX2CScyRIEBQy3ceqPWFt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaVYqmCpSHHfm25mwn5ECoNxw6OGNbXYNwmcym9Wbv0=;
 b=IrZyhwx3adA+gti5ryPfxPACXTMRH14SoQes1GN2rIbad9q2p6ugYuBapk9F3NSLZJaBcCrAsor7lDjj5bCxPCAV9SkIOQkCEWQRldKmhmsqZRFj0WLufWXRr41GDm+lykLHrQEpHT2E71tVZ05J11WioQuMnqdGgpuSgeBEIhPdUn+QztEORynjIBFkAlgbBYU/nz2jr39L7r4Ag/F2Ma6z231WWcsBRrHZ6eHIe+qX+sP09iIN7PI3+a2I/nAscccjbQ7vXs2pMCGGDjhC9aF/6ZPKdtgxze/u3Rie7+yMtF39NkUWqo7anafBiTvVFjMKXEHd5iaZOe3mMTG0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaVYqmCpSHHfm25mwn5ECoNxw6OGNbXYNwmcym9Wbv0=;
 b=BGVN6ihXyUSFnFwJ+qmFsn1+AZKhctyI61ujb7wkRRpaWiemhPP3P2I2iEh78ZiNrzS+YCzpFYE8JZ1ohUUNTVuUll6MzUG6tkjUf83bThxpMEQd2h23Fuui2NGEl9mjVD6GaH0P5MAewNIgVvFAp1VEryLDRk2iGhpnQB1A7nk=
Received: from BY1P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::7)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:50:08 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::99) by BY1P220CA0039.outlook.office365.com
 (2603:10b6:a03:59e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 10:50:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:50:08 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 05:50:05 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v2 1/2] raw/ntb: generalize framework for multiple vendors
Date: Mon, 28 Sep 2026 16:19:28 +0530
Message-ID: <20260928104929.2373409-2-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928104929.2373409-1-raghavendra.ningoji@amd.com>
References: <20260928104929.2373409-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 935b7967-06d9-41d8-88f8-08df1d4e4382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PaW/TPU+H8ZkizNOH9VsTHLyC6f1Onqu8VNt37A3VjXtXBjg/bBmDYoolmTZJZgwEkWoEI+U/9n7sypvt5iQQq+eIGDwo06BHJMnSRxzSjMq2nUsnUko2kg8OveNvT1HjCexx9VJa+xkmjkeMG1EoY13s2iGxmOZh7LfKV0LRK+tTX8/+Kuj8t1bt5tGBKyPPpyCjtD2fxKrLkVWYvOkvt5FRB+nersPEo1RDZWiZp2WbaMvrw4/3v6WSlVsQA+fWKAZ2ZQ3rDS0c0R9pZzFfP4VRg/capcHJE0tZxGvq+jEaYfEsdKvlq52p6v2E+YXbVtlOzcFlHe3GTQsDjVhUpDpLq5NM8yyIIzdVh5cH063pW3ur8TpLZWTWtozmzUE22DityIsjgD4RYYaYd5sereMYkcARdugI7dKbF8GummFGpzvK1hbb28lj3rf1A72VL1oGVnLRNy20tdy6saYh4p/Du8ixKYKdD6uvk22GXpxOfouE3FOO9zxvd07iyBdyH+A+5xrlih0xVbKIctxPnZyKwEktNEq7xHe22DPciJW5fr5L77iYt9UcvKDWJGhHi8Ka3fZFg86tqSDs/BSvAkVF5cnUZSjEqlfy1C747ZSCsnIoqgX3h2gndV718ia7YZtQYmeoP9EG5jCkPHcK7qfpC1ncUPlLw/dooqytEGPA78wDiOkwQQh9Dlwre6kZAxiXIitaGXeXY8IIN71pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0mmWzYHB7rcev9q+xPwrOKhJy3E4p1snM6DktmEVI24WXq9MEyreVYVk6dQeH8fHj5R+rnw38wg0yuMUS8G6NhSSjtwjYWtD0eCO9SccWCa8UZqtFZXUbIDgz7pZWjYxlGPXHsVLXRiTHuSjuFeDBH3xEVHF0ygkV7L+SEaZ9DMvMKTp8vv4TYADye5cCWzzeaTm4JJPp1RnzOMr5WtRTvcx0A1GZSw2fasyy1dCf+KjWaC8WENkotf78sYTjpAsQQxUJ4ST1Go6oIyWgsTxmHQO/McI2jiy/54CeuK3YcLwkG9BN2a2z58l9Sg8RrDrHv8hRH/ho9XssDvrmUxnmgJESF+6iH8OE5ZM8doFNuAN0kYZNzrl5WwkLUNV6pMpO7r/fifojzTJoL9oFkNb1rRVjK+tBF+GukjXkATuZ2rjrnr07kNBn8LgcPRzWA06
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:50:08.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935b7967-06d9-41d8-88f8-08df1d4e4382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

The NTB rawdev framework was written around the Intel back-to-back
topology and the built-in scratchpad handshake protocol. To allow
other vendors to plug into the same framework, add vendor-neutral
hooks and make the common code dispatch through them:

- Add NTB_TOPO_PRI/NTB_TOPO_SEC topology types for hardware that uses
  a primary/secondary topology instead of back-to-back.
- Add optional ntb_dev_ops hooks: interrupt_handler (vendor-specific
  MSI-X handler), dev_handshake (vendor-specific link handshake) and
  read_peer_config (vendor-specific peer-config read at start). When a
  hook is NULL the common code keeps using the existing built-in path,
  so the Intel driver is unaffected.
- Add a mem_align op and the rte_pmd_ntb_get_mem_align() API so an
  application can query the base-address alignment a memory window
  memzone needs, without embedding hardware-specific rules in the app.
  The Intel driver reports its memory-window size.
- Add a pmd_private pointer to struct ntb_hw for vendor-specific state.
- Guard the receive path against a malformed stream with no end-of-packet
  marker so it cannot overflow the descriptor ring.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c          | 115 ++++++++++++++++++++++++---------
 drivers/raw/ntb/ntb.h          |  22 +++++++
 drivers/raw/ntb/ntb_hw_intel.c |  11 ++++
 drivers/raw/ntb/rte_pmd_ntb.h  |  26 ++++++++
 examples/ntb/ntb_fwd.c         |   6 +-
 5 files changed, 146 insertions(+), 34 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index d54f2fb783..497c86b58c 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -18,6 +18,7 @@
 #include <rte_memcpy.h>
 #include <rte_rawdev.h>
 #include <rte_rawdev_pmd.h>
+#include <eal_export.h>
 
 #include "ntb_hw_intel.h"
 #include "rte_pmd_ntb.h"
@@ -746,6 +747,11 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 	for (nb_rx = 0; nb_rx < count; nb_rx++) {
 		i = 0;
 		while (true) {
+			if (unlikely(nb_mbufs >= rxq->nb_rx_desc)) {
+				NTB_LOG(ERR, "Malformed rx stream (no EOP); "
+					"aborting to avoid desc overflow.");
+				goto end_of_rx;
+			}
 			rx_item = rxq->rx_used_ring + rxq->last_used;
 			rxm_t = sw_ring[rxq->last_used].mbuf;
 			rxm_t->data_len = rx_item->len;
@@ -855,6 +861,26 @@ ntb_dev_info_get(struct rte_rawdev *dev, rte_rawdev_obj_t dev_info,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ntb_get_mem_align, 26.11)
+uint64_t
+rte_pmd_ntb_get_mem_align(uint16_t dev_id, uint32_t mw_id, uint64_t mw_len)
+{
+	struct rte_rawdev *dev;
+	struct ntb_hw *hw;
+
+	if (dev_id >= RTE_RAWDEV_MAX_DEVS)
+		return 0;
+	dev = rte_rawdev_pmd_get_dev(dev_id);
+	if (dev->dev_private == NULL)
+		return 0;
+
+	hw = dev->dev_private;
+	if (mw_id >= hw->mw_cnt || hw->ntb_ops->mem_align == NULL)
+		return RTE_CACHE_LINE_SIZE;
+
+	return (*hw->ntb_ops->mem_align)(dev, mw_id, mw_len);
+}
+
 static int
 ntb_dev_configure(const struct rte_rawdev *dev, rte_rawdev_obj_t config,
 		size_t config_size)
@@ -882,8 +908,13 @@ ntb_dev_configure(const struct rte_rawdev *dev, rte_rawdev_obj_t config,
 	hw->ntb_xstats_off = rte_zmalloc("ntb_xstats_off", xstats_num *
 					 sizeof(uint64_t), 0);
 
-	/* Start handshake with the peer. */
-	ret = ntb_handshake_work(dev);
+	/* Start handshake with the peer. Use the vendor-specific handshake
+	 * if provided, otherwise the built-in scratchpad protocol.
+	 */
+	if (hw->ntb_ops->dev_handshake != NULL)
+		ret = (*hw->ntb_ops->dev_handshake)(dev);
+	else
+		ret = ntb_handshake_work(dev);
 	if (ret < 0) {
 		rte_free(hw->rx_queues);
 		rte_free(hw->tx_queues);
@@ -929,35 +960,44 @@ ntb_dev_start(struct rte_rawdev *dev)
 		goto err_q_init;
 	}
 
-	if (hw->ntb_ops->spad_read == NULL) {
-		ret = -ENOTSUP;
-		goto err_up;
-	}
+	/* Read/validate peer config. Use the vendor-specific reader if
+	 * provided, otherwise the built-in scratchpad reads.
+	 */
+	if (hw->ntb_ops->read_peer_config != NULL) {
+		ret = (*hw->ntb_ops->read_peer_config)(dev);
+		if (ret < 0)
+			goto err_up;
+	} else {
+		if (hw->ntb_ops->spad_read == NULL) {
+			ret = -ENOTSUP;
+			goto err_up;
+		}
 
-	peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_Q_SZ, 0);
-	if (peer_val != hw->queue_size) {
-		NTB_LOG(ERR, "Inconsistent queue size! (local: %u peer: %u)",
-			hw->queue_size, peer_val);
-		ret = -EINVAL;
-		goto err_up;
-	}
+		peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_Q_SZ, 0);
+		if (peer_val != hw->queue_size) {
+			NTB_LOG(ERR, "Inconsistent queue size! (local: %u peer: %u)",
+				hw->queue_size, peer_val);
+			ret = -EINVAL;
+			goto err_up;
+		}
 
-	peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_QPS, 0);
-	if (peer_val != hw->queue_pairs) {
-		NTB_LOG(ERR, "Inconsistent number of queues! (local: %u peer:"
-			" %u)", hw->queue_pairs, peer_val);
-		ret = -EINVAL;
-		goto err_up;
-	}
+		peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_QPS, 0);
+		if (peer_val != hw->queue_pairs) {
+			NTB_LOG(ERR, "Inconsistent number of queues! (local: %u peer:"
+				" %u)", hw->queue_pairs, peer_val);
+			ret = -EINVAL;
+			goto err_up;
+		}
 
-	hw->peer_used_mws = (*hw->ntb_ops->spad_read)(dev, SPAD_USED_MWS, 0);
+		hw->peer_used_mws = (*hw->ntb_ops->spad_read)(dev, SPAD_USED_MWS, 0);
 
-	for (i = 0; i < hw->peer_used_mws; i++) {
-		peer_base_h = (*hw->ntb_ops->spad_read)(dev,
-				SPAD_MW0_BA_H + 2 * i, 0);
-		peer_base_l = (*hw->ntb_ops->spad_read)(dev,
-				SPAD_MW0_BA_L + 2 * i, 0);
-		hw->peer_mw_base[i] = (peer_base_h << 32) + peer_base_l;
+		for (i = 0; i < hw->peer_used_mws; i++) {
+			peer_base_h = (*hw->ntb_ops->spad_read)(dev,
+					SPAD_MW0_BA_H + 2 * i, 0);
+			peer_base_l = (*hw->ntb_ops->spad_read)(dev,
+					SPAD_MW0_BA_L + 2 * i, 0);
+			hw->peer_mw_base[i] = (peer_base_h << 32) + peer_base_l;
+		}
 	}
 
 	dev->started = 1;
@@ -1057,8 +1097,13 @@ ntb_dev_close(struct rte_rawdev *dev)
 	rte_intr_disable(intr_handle);
 
 	/* Unregister callback func to eal lib */
-	rte_intr_callback_unregister(intr_handle,
-				     ntb_dev_intr_handler, dev);
+	if (hw->ntb_ops->interrupt_handler != NULL)
+		rte_intr_callback_unregister(intr_handle,
+					     hw->ntb_ops->interrupt_handler,
+					     dev);
+	else
+		rte_intr_callback_unregister(intr_handle,
+					     ntb_dev_intr_handler, dev);
 
 	return 0;
 }
@@ -1409,9 +1454,15 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	(*hw->ntb_ops->db_clear)(dev, hw->db_valid_mask);
 
 	intr_handle = pci_dev->intr_handle;
-	/* Register callback func to eal lib */
-	rte_intr_callback_register(intr_handle,
-				   ntb_dev_intr_handler, dev);
+	/* Register callback func to eal lib. Use the vendor-specific handler
+	 * if provided, otherwise fall back to the built-in handler.
+	 */
+	if (hw->ntb_ops->interrupt_handler != NULL)
+		rte_intr_callback_register(intr_handle,
+					   hw->ntb_ops->interrupt_handler, dev);
+	else
+		rte_intr_callback_register(intr_handle,
+					   ntb_dev_intr_handler, dev);
 
 	ret = rte_intr_efd_enable(intr_handle, hw->db_cnt);
 	if (ret)
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index 8c7a2230f9..57d09a2cd4 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -42,6 +42,9 @@ enum ntb_topo {
 	NTB_TOPO_NONE = 0,
 	NTB_TOPO_B2B_USD,
 	NTB_TOPO_B2B_DSD,
+	/* Primary/secondary topology (e.g. AMD NTB). */
+	NTB_TOPO_PRI,
+	NTB_TOPO_SEC,
 };
 
 enum ntb_link {
@@ -100,6 +103,10 @@ enum ntb_spad_idx {
  * for those db bits.
  * @peer_db_set: Set doorbell bit to generate peer interrupt for that bit.
  * @vector_bind: Bind vector source [intr] to msix vector [msix].
+ * @interrupt_handler: Vendor-specific interrupt handler. If NULL, the
+ * built-in handler is used.
+ * @mem_align: Base-address alignment required for a memory window memzone
+ * of a given length.
  */
 struct ntb_dev_ops {
 	int (*ntb_dev_init)(const struct rte_rawdev *dev);
@@ -119,6 +126,18 @@ struct ntb_dev_ops {
 	int (*peer_db_set)(const struct rte_rawdev *dev, uint8_t db_bit);
 	int (*vector_bind)(const struct rte_rawdev *dev, uint8_t intr,
 			   uint8_t msix);
+	void (*interrupt_handler)(void *param);
+	/* Optional vendor-specific handshake. If NULL, the built-in
+	 * scratchpad handshake is used. Used by hardware (e.g. AMD) whose
+	 * scratchpad layout differs from the built-in protocol.
+	 */
+	int (*dev_handshake)(const struct rte_rawdev *dev);
+	/* Optional vendor-specific peer-config read at device start. If NULL,
+	 * the built-in scratchpad reads are used.
+	 */
+	int (*read_peer_config)(const struct rte_rawdev *dev);
+	uint64_t (*mem_align)(const struct rte_rawdev *dev, uint32_t mw_id,
+			      uint64_t mw_len);
 };
 
 struct ntb_desc {
@@ -208,6 +227,9 @@ struct ntb_hw {
 
 	const struct ntb_dev_ops *ntb_ops;
 
+	/* Vendor-specific hardware private data. */
+	void *pmd_private;
+
 	struct rte_pci_device *pci_dev;
 	char *hw_addr;
 
diff --git a/drivers/raw/ntb/ntb_hw_intel.c b/drivers/raw/ntb/ntb_hw_intel.c
index 956f411ea3..955b384614 100644
--- a/drivers/raw/ntb/ntb_hw_intel.c
+++ b/drivers/raw/ntb/ntb_hw_intel.c
@@ -613,6 +613,16 @@ intel_ntb_vector_bind(const struct rte_rawdev *dev, uint8_t intr, uint8_t msix)
 }
 
 /* operations for primary side of local ntb */
+static uint64_t
+intel_ntb_get_mem_align(const struct rte_rawdev *dev, uint32_t mw_id,
+			uint64_t mw_len __rte_unused)
+{
+	struct ntb_hw *hw = dev->dev_private;
+
+	/* The memzone base must be aligned to the memory window size. */
+	return hw->mw_size[mw_id];
+}
+
 const struct ntb_dev_ops intel_ntb_ops = {
 	.ntb_dev_init       = intel_ntb_dev_init,
 	.get_peer_mw_addr   = intel_ntb_get_peer_mw_addr,
@@ -627,4 +637,5 @@ const struct ntb_dev_ops intel_ntb_ops = {
 	.db_set_mask        = intel_ntb_db_set_mask,
 	.peer_db_set        = intel_ntb_peer_db_set,
 	.vector_bind        = intel_ntb_vector_bind,
+	.mem_align          = intel_ntb_get_mem_align,
 };
diff --git a/drivers/raw/ntb/rte_pmd_ntb.h b/drivers/raw/ntb/rte_pmd_ntb.h
index 76da3be026..70c89dab11 100644
--- a/drivers/raw/ntb/rte_pmd_ntb.h
+++ b/drivers/raw/ntb/rte_pmd_ntb.h
@@ -7,6 +7,8 @@
 
 #include <stdint.h>
 
+#include <rte_compat.h>
+
 /* App needs to set/get these attrs */
 #define NTB_QUEUE_SZ_NAME           "queue_size"
 #define NTB_QUEUE_NUM_NAME          "queue_num"
@@ -42,4 +44,28 @@ struct ntb_queue_conf {
 	struct rte_mempool *rx_mp;
 };
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Get the base-address alignment a memory window memzone must be reserved
+ * with. Some NTB hardware constrains the address a memory window can be
+ * translated to (for example, hardware that forms the peer target as
+ * (base | offset) needs the base aligned to a power of two >= the window
+ * length). Applications should reserve the memzone for memory window
+ * @p mw_id, of length @p mw_len, with at least the returned alignment.
+ *
+ * @param dev_id
+ *   The identifier of the raw device.
+ * @param mw_id
+ *   The memory window index.
+ * @param mw_len
+ *   The length, in bytes, of the memzone to be reserved.
+ * @return
+ *   The required base-address alignment in bytes, or 0 on error.
+ */
+__rte_experimental
+uint64_t
+rte_pmd_ntb_get_mem_align(uint16_t dev_id, uint32_t mw_id, uint64_t mw_len);
+
 #endif /* _RTE_PMD_NTB_H_ */
diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index 33f3c1ef17..a187022718 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -1146,8 +1146,6 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 		if (!left_sz)
 			break;
 		snprintf(mz_name, sizeof(mz_name), "ntb_mw_%d", mz_id);
-		align = ntb_info.mw_size_align ? ntb_info.mw_size[mz_id] :
-			RTE_CACHE_LINE_SIZE;
 		/* Reserve ntb header space on memzone 0. */
 		max_mz_len = mz_id ? ntb_info.mw_size[mz_id] :
 			     ntb_info.mw_size[mz_id] - ntb_info.ntb_hdr_size;
@@ -1155,6 +1153,10 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 			(max_mz_len / total_elt_sz * total_elt_sz);
 		if (!mz_len)
 			continue;
+		/* Let the driver report the base-address alignment its
+		 * hardware needs for a memory window of this length.
+		 */
+		align = rte_pmd_ntb_get_mem_align(dev_id, mz_id, mz_len);
 		mz = rte_memzone_reserve_aligned(mz_name, mz_len, socket_id,
 					RTE_MEMZONE_IOVA_CONTIG, align);
 		if (mz == NULL) {
-- 
2.34.1

