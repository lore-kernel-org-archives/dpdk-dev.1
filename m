Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA9C5DF97
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Aug 2026 14:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67FF240693;
	Sun, 23 Aug 2026 16:07:28 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by mails.dpdk.org (Postfix) with ESMTP id C7D6840265
 for <dev@dpdk.org>; Sun, 23 Aug 2026 16:07:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1+C/9/UBWL7y6fggh0T88wOhbcLOkpg6vFgDCfLNC/PycdEU5vLNL2sWtLfcOXaTBLvF9SkTM6TMrONMhG0Jkkl+GDfGg0jA1TzN1Dg7YEd9NocTTlYtPXeCDusJHmZipx/OwBiQO3kAoQYLwh4kwJT6OZGyKUGvpQjug8ElXvRVdQC/9ffRLDuuAGiPxBWqvj6BFby/s9gBnFJEB9D5V+awSSzV0eZFLNyDeBe0kaEaCTAQl9l9W2tPDkwgCZYzzdAvIHYZgXsvTpDprP1nCVVvIAQSdVIMjqdlzD9XYPisdLv5oxVSOGwtIdM6n/SQsInumqECULIs8PnkYhg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxtCUx25LwBDnR+3xIPvtw/W90KyEM363+fcdYCOT+E=;
 b=hnZTGqt4+Nf/6KTiC9+POJZDSvrvCDmBUjUSPAF3ebvIsI4gaUv2GaAtweV3w8vAqShbTf0mEH4emXMicgdlSWA6gp6xdYzX3CBFuPCKAqMLhLxYXg6JHYIIiOQ/KtTNgwWpXmbLi96JMxdSt8gcyt7Mw1gaQB3FL/ApI/LyQ+oIeHYsYm9EhjUfNDxcMtCbZgwYCf6Ml4Rd03Ff6bIIB+ViH1olthofUP8Ys1pojI1c2InPjfbxH6hwbpGafDan3FIy5UbLMY/wv77zGHdDPjavSCZdH7Qr4HRUJIJVnbgkGlaXzXiqqsE5+8ySA1i9inI1uYKdaNPk6zoQUcvQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxtCUx25LwBDnR+3xIPvtw/W90KyEM363+fcdYCOT+E=;
 b=3ZXKzRxX2RxgBPUbE9DNtw7cOpYoLgZLQ+OhKIhXR1okvf0hS7DALSGrH2NQEMsOiIoU2s/W5hoErMVnVO7rNMOumDeFWmZNKceDb17fTC/FEktEIQUqJ3L2bs2nt9nxoF41qqGpkPH/BcDjWX713/ep92Tg4pvNRDh9W2yUctQ=
Received: from SJ0PR03CA0269.namprd03.prod.outlook.com (2603:10b6:a03:3a0::34)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 14:07:11 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::86) by SJ0PR03CA0269.outlook.office365.com
 (2603:10b6:a03:3a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Sun,
 23 Aug 2026 14:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 14:07:10 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 09:07:07 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v1 1/3] raw/ntb: generalize framework for multiple vendors
Date: Sun, 23 Aug 2026 19:36:37 +0530
Message-ID: <20260823140639.153997-2-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
References: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9d1934-5b85-45ca-ccad-08df011fd2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|3023799007|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M6oebH297vV87OWuGYbH7ExEX4KkhsKH76d5YAtjRgzDy0xyXO4UN5BCuw9RuOdNuku9s6xb+y/x+QTE65vTF3ipATJAmUaW8Gm721El+TS8n/EDc5BTWfOgEl8R3iCGOsC1q5WRFOrYft2E4i0IncsV4aBsMDJU3/4JDKyIMUCQF92tY5R59NMhnU5IYrmmKRJe73264UDqbikmPbAwUmjOXVkF4j21WVMeLoWV6o21U91u7Nm4C8iSprsSbpw+1SQTc5CUkuCglBJorQ5RJqfcQ1hvLuWXcG5PxJ5+s2u1bI3A7MxF0TuItFjzZlYw1BfZotMPiH0f4PvQQ6xmDn9ZqC32lBubwET4EdrGxmGXgHwZjQkG0naZdSR8KbWAJX+Y528XmQLnY4NfHjrMJb5cmD8XTdUUzFtzG4VUZ/nFFTPFkoOKbXkiVooQY3QXMgxYQRG0HU/JHqNr9mJcyVJHkSbM/7wfEgFXTRea7ovwXHsiqbEF/VFMz4zrg2Fe5ncvBfGesLJBWa0o8WuIi7pDmpzotqxLAe5PwqDECzkWz41LMxFlHPeGvzcbbvOLBu2pjNRs6V3B+lH3HEWvqGf+YebZJYabdqZW66SyZXBK0EzDV6BuBSe0sYty956c6IarG63yjo2LoITP2NrStPAkp3YLALNSIUo+lsvww1gm1IUjWQnQfm5D8PllaJZZfIjeV41g3kcIDIMlOhEZFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(3023799007)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AJvmFrjoJF7h18NUkjhx2NbAJ1EApAyALqcmNX11/pZOWU3E0TGZ421e4ABvxDx4Mex756F2M/eBQJMUkgcJtmoA99vucbBuThx33E5Ak8plTRBFEc6gvzav0L04Gz06x3qveBP5XY6Odsfn6JlgUrWCyFjw49dNGSuBJKlizmUevPBcfUH025uHKPDsl0oGf2/txFp6cHgMYteF57Q8iYoZtDrbFzRNNfI36MPOWg6E6AzQpe0cx/Z/mtJPej1eUu8osE8AeeAXK+a6st5d5Pa8MQO+T5mtzaLm7Mc97alWvH4zipLoHZkHAsUuG45lhzCfOnE8ZnM2KeWoUeF6lBHQvxXlsLk049yEa9hkVLcmHg6T/sMRV0jt7H6ByK4zNr+sWrOOm7Syms04RvbDZq6FvWh3VjY01AJoyxrWRHLMTgV4NMVOBS6kSI9vnuwX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 14:07:10.3134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9d1934-5b85-45ca-ccad-08df011fd2e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
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
- Add a pmd_private pointer to struct ntb_hw for vendor-specific state.
- Guard the receive path against a malformed stream with no end-of-packet
  marker so it cannot overflow the descriptor ring.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 94 ++++++++++++++++++++++++++++---------------
 drivers/raw/ntb/ntb.h | 18 +++++++++
 2 files changed, 80 insertions(+), 32 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index d54f2fb783..3a6a299081 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -746,6 +746,11 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
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
@@ -882,8 +887,13 @@ ntb_dev_configure(const struct rte_rawdev *dev, rte_rawdev_obj_t config,
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
@@ -929,35 +939,44 @@ ntb_dev_start(struct rte_rawdev *dev)
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
@@ -1057,8 +1076,13 @@ ntb_dev_close(struct rte_rawdev *dev)
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
@@ -1409,9 +1433,15 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
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
index 8c7a2230f9..270f9f9046 100644
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
@@ -100,6 +103,8 @@ enum ntb_spad_idx {
  * for those db bits.
  * @peer_db_set: Set doorbell bit to generate peer interrupt for that bit.
  * @vector_bind: Bind vector source [intr] to msix vector [msix].
+ * @interrupt_handler: Vendor-specific interrupt handler. If NULL, the
+ * built-in handler is used.
  */
 struct ntb_dev_ops {
 	int (*ntb_dev_init)(const struct rte_rawdev *dev);
@@ -119,6 +124,16 @@ struct ntb_dev_ops {
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
 };
 
 struct ntb_desc {
@@ -208,6 +223,9 @@ struct ntb_hw {
 
 	const struct ntb_dev_ops *ntb_ops;
 
+	/* Vendor-specific hardware private data. */
+	void *pmd_private;
+
 	struct rte_pci_device *pci_dev;
 	char *hw_addr;
 
-- 
2.34.1

