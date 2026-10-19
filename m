Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0657CCF2DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 06:40:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B95E4028E;
	Mon, 19 Oct 2026 08:40:11 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by mails.dpdk.org (Postfix) with ESMTP id C70CB40269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 08:40:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxThvm21IuJ4nBGOyVHm66g0plCyZBykfKwwXeK9M6JUcmQhp7Pai5cy8D1se9oShTEIF3dGbwTorcbkqcCCuBpr2ROQ5GFxVDtWiJ1cTaezVJh2U9kNZaG1cmLEvT+V57cJbqNox95LEDqN6VRSpbhh0xGcmgnvGdnt8WwqWGcMJSTPYX+tuh2m0hgcqXibBVE7MHvsBkROFm6wIWh6Q6DTUCl5/iU0jdlNZyxa0yg0dBTthctbN4Tw0NZSz+0kOk+2cctLrmP9pnaA7B2SFimFPk70DEqA7a/wFyqFeQ9CAc5UMyzA616G3SJIrebN7YQoTS2OdYknoB5SPPGLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmXSU99/czX8dFh6qONjIAaczx4R28whJOdhne2+ryc=;
 b=R/pTrwbue35Zw292XAcCrEN3B2Kz3LrWOf7ykqk95vcqYGvbNgvOs9kmZnmEDi4qQZk/cEvNBVQ3iPP6F/XX83qHStuYslqgi7uLkp7fDJ6bOC3MVlXphFKZp6gXlu7WdVZ3QxEJNZfM/w7qJaH3xshYKodId52PTQliQ7LtXw65JqySUNnWUYI3DlYR1Rjd2ZlJaKYVxCHahp9f75GUHVcbNnbTPD6xIsEASjJMCtRO/KEexEHQDD/CVAe6PLJnGkcds0DBMY+S0APeMSczKdF8jwTys4GeY97dX7mkCxzd2LOKlAZzqlhMdP14kVz7VzFEQPMX6pcb4rxnDY/abA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmXSU99/czX8dFh6qONjIAaczx4R28whJOdhne2+ryc=;
 b=ZKACaZR5njgAfPXMrMJD1OStL4IqsC82CbHGMovVkml3gdE0BZHvCS+AGhZuZ8LfZBtRfYWcnKN4pJy4qSFoe4sPHuggARcH05rDkwcPnL3kJ57cmRMPvHao26h0Mywh79+I2WyrdiRVGGQXox+2YtZ63HxXYV0OYNFxmVfLwqw=
Received: from CH0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:610:cc::7)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:40:02 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::3e) by CH0PR03CA0062.outlook.office365.com
 (2603:10b6:610:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 06:40:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:40:02 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:39:51 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v3 2/3] raw/ntb: generalize framework for multiple vendors
Date: Mon, 19 Oct 2026 12:08:22 +0530
Message-ID: <20261019063823.2831572-3-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019063823.2831572-1-raghavendra.ningoji@amd.com>
References: <20261019063823.2831572-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb33211-e64f-442d-128b-08df2dabcdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 0wTJYAxBW6VxOhLKgnE2mToWDe6KvZctjKU9xFbbIZX14tRnUxokzlHsTXsXZUligfXcBRfW7BEKvnVLcWOcYKavkFmcB1RXbTzHJLdEn35qeYYBz5DnmTydmSr2HqV8OucOglwoBRVe1WKhtwMSGTVGud6VkeJwBZPbH2Ahcm+WYy/maMFaVk1tul/gzMBbu/ZXqHSuWUog5FHGjRSOJKrzd5mxqrQ1/NkElYLW35nZKAjMvfBJmXqqRJvn62t8oHUvIV62csbk4Ub0KFiOLiNVV5Um9YvFiv1Dkcryu98lNnFFK9/LeoqvTmZ+VugPnj1pPLsVgJQUfWaofuLfX0RqVKpYpSLBFJHUZCK90CX8xAhQvzuOV798xF6lA2meSwfHvAu8dKzdlaj1RP6b11xccpLPF7vdszAadV8LVbIKvEnG9NLN0dJwzPkBTlo12PVWD7DbSNWb5L/xjcgdEV5QqJiZdnyKIC/Zfryn9eNfHlpgMrxarW8297s5jbWbNKeC3jyz8pwLUIIHBR/HrfRmnIlASqdv9YQjSz1VVxDbVUaYrEEvv/DSk/N45yntroE6v4seGbtJmkpdWm7iW+SeNtd10YQ5SYobM7DRQT9BSMfhsptDUytyALfY8lcwK8FQpT3vfQqexfEfl2YWnYbbnhCgil45pNUX9vYbUqt3mVLH+GsQnbStLIY/f60l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NLV+zcn7ggXZWiEekh/rWw0YEQY7If9jSC2/CsZ0kZrmg74wefaC1gY4F8bLHqIwim3BMMS4sVhMxySumFLTgGPwgjICRTwUQRnkWUP5Tam24uz/lSGVYaI3dadDjprRmR4oDluZ4cNFZEoG9kv59Fpbci0VEyqwbP1VI8DwbztEn8G/2gLkYueQ6YMXdXB+XjCJJQa7XG9ldNqEAKTidYIL2svto/dBYp1H9cABUcrC7T/Qzfvz024vcBExFE3qawvlVIDhIEELC0gXeLC1o4h264xsTPS/q2/SO9fNvmtQp33JK2kqI0f8vAwvSgFmj1lw1E38S+Fe/x5dHlyEr3a68It/mFLP5vkh1Magf7rqxIMrbdF9P0DdGxLmUygn8wRS+3tW8pA9OAjQEDdXTD2o+A6WsGcD0tvuH1csxsusWoT/6MmbYJYBGv+AaVph
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:40:02.5019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb33211-e64f-442d-128b-08df2dabcdcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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
topology and the built-in scratchpad handshake protocol. Rework the
common code so other vendors can plug into the same framework through
a mandatory vendor ops table, without runtime op presence checks.

- Add NTB_TOPO_PRI/NTB_TOPO_SEC topology types for hardware that uses
  a primary/secondary topology instead of back-to-back.
- Turn the link bring-up/tear-down logic into mandatory vendor ops:
  dev_handshake, peer_mw_validate, read_peer_config and link_cleanup.
  The former built-in scratchpad logic now lives in the Intel driver.
- Drop the mw_set_trans op: programming the memory-window translation
  is a vendor-internal concern of the handshake, not a framework op.
- Keep a single common interrupt handler and let it dispatch through the
  new ops, with an optional handle_hw_event op for vendor-specific
  hardware events (none for Intel).
- Add a mem_align op and the rte_pmd_ntb_get_mem_align() API so an
  application can query the base-address alignment a memory window
  memzone needs, without embedding hardware-specific rules in the app.
  The Intel driver reports its memory-window size.
- Add a pmd_private pointer to struct ntb_hw for vendor-specific state.
- Guard the receive path against a malformed stream with no end-of-packet
  marker so it cannot overflow the descriptor ring.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c          | 195 +++++++++------------------------
 drivers/raw/ntb/ntb.h          |  27 ++++-
 drivers/raw/ntb/ntb_hw_intel.c | 165 +++++++++++++++++++++++++++-
 drivers/raw/ntb/rte_pmd_ntb.h  |  26 +++++
 examples/ntb/ntb_fwd.c         |   6 +-
 5 files changed, 267 insertions(+), 152 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 874365748c..1015634c52 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -19,6 +19,7 @@
 #include <rte_memcpy.h>
 #include <rte_rawdev.h>
 #include <rte_rawdev_pmd.h>
+#include <eal_export.h>
 
 #include "ntb_hw_intel.h"
 #include "rte_pmd_ntb.h"
@@ -41,103 +42,12 @@ static struct rte_rawdev_xstats_name ntb_xstats_names[] = {
 };
 #define NTB_XSTATS_NUM RTE_DIM(ntb_xstats_names)
 
-static inline void
-ntb_link_cleanup(struct rte_rawdev *dev)
-{
-	struct ntb_hw *hw = dev->dev_private;
-	int status, i;
-
-	/* Clean spad registers. */
-	for (i = 0; i < hw->spad_cnt; i++) {
-		status = (*hw->ntb_ops->spad_write)(dev, i, 0, 0);
-		if (status)
-			NTB_LOG(ERR, "Failed to clean local spad.");
-	}
-
-	/* Clear mw so that peer cannot access local memory.*/
-	for (i = 0; i < hw->used_mw_num; i++) {
-		status = (*hw->ntb_ops->mw_set_trans)(dev, i, 0, 0);
-		if (status)
-			NTB_LOG(ERR, "Failed to clean mw.");
-	}
-}
-
-static inline int
-ntb_handshake_work(const struct rte_rawdev *dev)
-{
-	struct ntb_hw *hw = dev->dev_private;
-	uint32_t val;
-	int ret, i;
-
-	/* Tell peer the mw info of local side. */
-	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_NUM_MWS, 1, hw->mw_cnt);
-	if (ret < 0)
-		return ret;
-	for (i = 0; i < hw->mw_cnt; i++) {
-		NTB_LOG(INFO, "Local %u mw size: 0x%"PRIx64"", i,
-				hw->mw_size[i]);
-		val = hw->mw_size[i] >> 32;
-		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_SZ_H + 2 * i,
-						 1, val);
-		if (ret < 0)
-			return ret;
-		val = hw->mw_size[i];
-		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_SZ_L + 2 * i,
-						 1, val);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Tell peer about the queue info and map memory to the peer. */
-	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_Q_SZ, 1, hw->queue_size);
-	if (ret < 0)
-		return ret;
-	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_NUM_QPS, 1,
-					 hw->queue_pairs);
-	if (ret < 0)
-		return ret;
-	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_USED_MWS, 1,
-					 hw->used_mw_num);
-	if (ret < 0)
-		return ret;
-	for (i = 0; i < hw->used_mw_num; i++) {
-		val = (uint64_t)(size_t)(hw->mz[i]->addr) >> 32;
-		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_BA_H + 2 * i,
-						 1, val);
-		if (ret < 0)
-			return ret;
-		val = (uint64_t)(size_t)(hw->mz[i]->addr);
-		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_BA_L + 2 * i,
-						 1, val);
-		if (ret < 0)
-			return ret;
-	}
-
-	for (i = 0; i < hw->used_mw_num; i++) {
-		ret = (*hw->ntb_ops->mw_set_trans)(dev, i, hw->mz[i]->iova,
-						   hw->mz[i]->len);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Ring doorbell 0 to tell peer the device is ready. */
-	ret = (*hw->ntb_ops->peer_db_set)(dev, 0);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static void
 ntb_dev_intr_handler(void *param)
 {
 	struct rte_rawdev *dev = (struct rte_rawdev *)param;
 	struct ntb_hw *hw = dev->dev_private;
-	uint32_t val_h, val_l;
-	uint64_t peer_mw_size;
-	uint64_t db_bits = 0;
-	uint8_t peer_mw_cnt;
-	int i = 0;
+	uint64_t db_bits;
 
 	db_bits = (*hw->ntb_ops->db_read)(dev);
 	if (!db_bits)
@@ -156,36 +66,19 @@ ntb_dev_intr_handler(void *param)
 		if (hw->peer_dev_up)
 			return;
 
-		/* Check if mw setting on the peer is the same as local. */
-		peer_mw_cnt = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_MWS, 0);
-		if (peer_mw_cnt != hw->mw_cnt) {
-			NTB_LOG(ERR, "Both mw cnt must be the same.");
+		/* Check that the peer memory-window layout matches local. */
+		if ((*hw->ntb_ops->peer_mw_validate)(dev) < 0)
 			return;
-		}
-
-		for (i = 0; i < hw->mw_cnt; i++) {
-			val_h = (*hw->ntb_ops->spad_read)
-				(dev, SPAD_MW0_SZ_H + 2 * i, 0);
-			val_l = (*hw->ntb_ops->spad_read)
-				(dev, SPAD_MW0_SZ_L + 2 * i, 0);
-			peer_mw_size = ((uint64_t)val_h << 32) | val_l;
-			NTB_LOG(DEBUG, "Peer %u mw size: 0x%"PRIx64"", i,
-					peer_mw_size);
-			if (peer_mw_size != hw->mw_size[i]) {
-				NTB_LOG(ERR, "Mw config must be the same.");
-				return;
-			}
-		}
 
 		hw->peer_dev_up = 1;
 
 		/**
-		 * Handshake with peer. Spad_write & mw_set_trans only works
-		 * when both devices are up. So write spad again when db is
-		 * received. And set db again for the later device who may miss
-		 * the 1st db.
+		 * Handshake with peer. Scratchpad and translation programming
+		 * only takes effect when both devices are up, so run the
+		 * handshake again on the doorbell and ring the peer so the
+		 * device that came up second does not miss the first doorbell.
 		 */
-		if (ntb_handshake_work(dev) < 0) {
+		if ((*hw->ntb_ops->dev_handshake)(dev) < 0) {
 			NTB_LOG(ERR, "Handshake work failed.");
 			return;
 		}
@@ -203,7 +96,7 @@ ntb_dev_intr_handler(void *param)
 		(*hw->ntb_ops->db_clear)(dev, 2);
 
 		/* Peer device will be down, So clean local side too. */
-		ntb_link_cleanup(dev);
+		(*hw->ntb_ops->link_cleanup)(dev);
 
 		hw->peer_dev_up = 0;
 		/* Response peer's dev_stop request. */
@@ -221,6 +114,10 @@ ntb_dev_intr_handler(void *param)
 
 	/* Clear other received doorbells. */
 	(*hw->ntb_ops->db_clear)(dev, db_bits);
+
+	/* Let the vendor process any hardware-specific events. */
+	if (hw->ntb_ops->handle_hw_event != NULL)
+		(*hw->ntb_ops->handle_hw_event)(dev);
 }
 
 static int
@@ -709,6 +606,11 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
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
@@ -818,6 +720,26 @@ ntb_dev_info_get(struct rte_rawdev *dev, rte_rawdev_obj_t dev_info,
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
+	if (mw_id >= hw->mw_cnt)
+		return RTE_CACHE_LINE_SIZE;
+
+	return (*hw->ntb_ops->mem_align)(dev, mw_id, mw_len);
+}
+
 static int
 ntb_dev_configure(const struct rte_rawdev *dev, rte_rawdev_obj_t config,
 		size_t config_size)
@@ -846,7 +768,7 @@ ntb_dev_configure(const struct rte_rawdev *dev, rte_rawdev_obj_t config,
 					 sizeof(uint64_t), 0);
 
 	/* Start handshake with the peer. */
-	ret = ntb_handshake_work(dev);
+	ret = (*hw->ntb_ops->dev_handshake)(dev);
 	if (ret < 0) {
 		rte_free(hw->rx_queues);
 		rte_free(hw->tx_queues);
@@ -862,8 +784,6 @@ static int
 ntb_dev_start(struct rte_rawdev *dev)
 {
 	struct ntb_hw *hw = dev->dev_private;
-	uint32_t peer_base_l, peer_val;
-	uint64_t peer_base_h;
 	uint32_t i;
 	int ret;
 
@@ -892,31 +812,10 @@ ntb_dev_start(struct rte_rawdev *dev)
 		goto err_q_init;
 	}
 
-	peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_Q_SZ, 0);
-	if (peer_val != hw->queue_size) {
-		NTB_LOG(ERR, "Inconsistent queue size! (local: %u peer: %u)",
-			hw->queue_size, peer_val);
-		ret = -EINVAL;
-		goto err_up;
-	}
-
-	peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_QPS, 0);
-	if (peer_val != hw->queue_pairs) {
-		NTB_LOG(ERR, "Inconsistent number of queues! (local: %u peer:"
-			" %u)", hw->queue_pairs, peer_val);
-		ret = -EINVAL;
+	/* Read and validate the peer configuration. */
+	ret = (*hw->ntb_ops->read_peer_config)(dev);
+	if (ret < 0)
 		goto err_up;
-	}
-
-	hw->peer_used_mws = (*hw->ntb_ops->spad_read)(dev, SPAD_USED_MWS, 0);
-
-	for (i = 0; i < hw->peer_used_mws; i++) {
-		peer_base_h = (*hw->ntb_ops->spad_read)(dev,
-				SPAD_MW0_BA_H + 2 * i, 0);
-		peer_base_l = (*hw->ntb_ops->spad_read)(dev,
-				SPAD_MW0_BA_L + 2 * i, 0);
-		hw->peer_mw_base[i] = (peer_base_h << 32) + peer_base_l;
-	}
 
 	dev->started = 1;
 
@@ -943,7 +842,7 @@ ntb_dev_stop(struct rte_rawdev *dev)
 	if (!hw->peer_dev_up)
 		goto clean;
 
-	ntb_link_cleanup(dev);
+	(*hw->ntb_ops->link_cleanup)(dev);
 
 	/* Notify the peer that device will be down. */
 	status = (*hw->ntb_ops->peer_db_set)(dev, 1);
@@ -1325,7 +1224,6 @@ ntb_vendor_ops_check(const struct ntb_hw *hw)
 		{ offsetof(struct ntb_dev_ops, member), #member }
 		NTB_OPS_REQ(ntb_dev_init),
 		NTB_OPS_REQ(get_peer_mw_addr),
-		NTB_OPS_REQ(mw_set_trans),
 		NTB_OPS_REQ(ioremap),
 		NTB_OPS_REQ(get_link_status),
 		NTB_OPS_REQ(set_link),
@@ -1336,6 +1234,11 @@ ntb_vendor_ops_check(const struct ntb_hw *hw)
 		NTB_OPS_REQ(db_set_mask),
 		NTB_OPS_REQ(peer_db_set),
 		NTB_OPS_REQ(vector_bind),
+		NTB_OPS_REQ(dev_handshake),
+		NTB_OPS_REQ(peer_mw_validate),
+		NTB_OPS_REQ(read_peer_config),
+		NTB_OPS_REQ(link_cleanup),
+		NTB_OPS_REQ(mem_align),
 #undef NTB_OPS_REQ
 	};
 	unsigned int i;
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index 8c7a2230f9..545f4c1425 100644
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
@@ -88,7 +91,6 @@ enum ntb_spad_idx {
  * NTB device operations
  * @ntb_dev_init: Init ntb dev.
  * @get_peer_mw_addr: To get the addr of peer mw[mw_idx].
- * @mw_set_trans: Set translation of internal memory that remote can access.
  * @ioremap: Translate the remote host address to bar address.
  * @get_link_status: get link status, link speed and link width.
  * @set_link: Set local side up/down.
@@ -100,12 +102,21 @@ enum ntb_spad_idx {
  * for those db bits.
  * @peer_db_set: Set doorbell bit to generate peer interrupt for that bit.
  * @vector_bind: Bind vector source [intr] to msix vector [msix].
+ * @dev_handshake: Advertise the local configuration to the peer, program
+ * the memory-window translations and signal readiness.
+ * @peer_mw_validate: Validate that the peer's advertised memory-window
+ * layout matches the local one.
+ * @read_peer_config: Read and validate the peer configuration at start.
+ * @link_cleanup: Tear down the local scratchpad/translation state so the
+ * peer can no longer reach local memory.
+ * @mem_align: Base-address alignment required for a memory window memzone
+ * of a given length.
+ * @handle_hw_event: Optional. Process vendor-specific hardware events from
+ * the common interrupt handler. May be NULL.
  */
 struct ntb_dev_ops {
 	int (*ntb_dev_init)(const struct rte_rawdev *dev);
 	void *(*get_peer_mw_addr)(const struct rte_rawdev *dev, int mw_idx);
-	int (*mw_set_trans)(const struct rte_rawdev *dev, int mw_idx,
-			    uint64_t addr, uint64_t size);
 	void *(*ioremap)(const struct rte_rawdev *dev, uint64_t addr);
 	int (*get_link_status)(const struct rte_rawdev *dev);
 	int (*set_link)(const struct rte_rawdev *dev, bool up);
@@ -119,6 +130,13 @@ struct ntb_dev_ops {
 	int (*peer_db_set)(const struct rte_rawdev *dev, uint8_t db_bit);
 	int (*vector_bind)(const struct rte_rawdev *dev, uint8_t intr,
 			   uint8_t msix);
+	int (*dev_handshake)(const struct rte_rawdev *dev);
+	int (*peer_mw_validate)(const struct rte_rawdev *dev);
+	int (*read_peer_config)(const struct rte_rawdev *dev);
+	void (*link_cleanup)(const struct rte_rawdev *dev);
+	uint64_t (*mem_align)(const struct rte_rawdev *dev, uint32_t mw_id,
+			      uint64_t mw_len);
+	void (*handle_hw_event)(const struct rte_rawdev *dev);
 };
 
 struct ntb_desc {
@@ -208,6 +226,9 @@ struct ntb_hw {
 
 	const struct ntb_dev_ops *ntb_ops;
 
+	/* Vendor-specific hardware private data. */
+	void *pmd_private;
+
 	struct rte_pci_device *pci_dev;
 	char *hw_addr;
 
diff --git a/drivers/raw/ntb/ntb_hw_intel.c b/drivers/raw/ntb/ntb_hw_intel.c
index 956f411ea3..ed449255dd 100644
--- a/drivers/raw/ntb/ntb_hw_intel.c
+++ b/drivers/raw/ntb/ntb_hw_intel.c
@@ -11,6 +11,7 @@
 #include <bus_pci_driver.h>
 #include <rte_rawdev.h>
 #include <rte_rawdev_pmd.h>
+#include <rte_memzone.h>
 
 #include "ntb.h"
 #include "ntb_hw_intel.h"
@@ -612,11 +613,168 @@ intel_ntb_vector_bind(const struct rte_rawdev *dev, uint8_t intr, uint8_t msix)
 	return 0;
 }
 
+/* Advertise the local configuration to the peer and program the memory
+ * windows. Scratchpad writes and translations only take effect once both
+ * sides are up, so this is also re-run from the ready doorbell.
+ */
+static int
+intel_dev_handshake(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *hw = dev->dev_private;
+	uint32_t val;
+	int ret, i;
+
+	/* Tell peer the mw info of local side. */
+	ret = intel_ntb_spad_write(dev, SPAD_NUM_MWS, 1, hw->mw_cnt);
+	if (ret < 0)
+		return ret;
+	for (i = 0; i < hw->mw_cnt; i++) {
+		NTB_LOG(INFO, "Local %u mw size: 0x%"PRIx64"", i,
+				hw->mw_size[i]);
+		val = hw->mw_size[i] >> 32;
+		ret = intel_ntb_spad_write(dev, SPAD_MW0_SZ_H + 2 * i, 1, val);
+		if (ret < 0)
+			return ret;
+		val = hw->mw_size[i];
+		ret = intel_ntb_spad_write(dev, SPAD_MW0_SZ_L + 2 * i, 1, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Tell peer about the queue info and map memory to the peer. */
+	ret = intel_ntb_spad_write(dev, SPAD_Q_SZ, 1, hw->queue_size);
+	if (ret < 0)
+		return ret;
+	ret = intel_ntb_spad_write(dev, SPAD_NUM_QPS, 1, hw->queue_pairs);
+	if (ret < 0)
+		return ret;
+	ret = intel_ntb_spad_write(dev, SPAD_USED_MWS, 1, hw->used_mw_num);
+	if (ret < 0)
+		return ret;
+	for (i = 0; i < hw->used_mw_num; i++) {
+		val = (uint64_t)(size_t)(hw->mz[i]->addr) >> 32;
+		ret = intel_ntb_spad_write(dev, SPAD_MW0_BA_H + 2 * i, 1, val);
+		if (ret < 0)
+			return ret;
+		val = (uint64_t)(size_t)(hw->mz[i]->addr);
+		ret = intel_ntb_spad_write(dev, SPAD_MW0_BA_L + 2 * i, 1, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	for (i = 0; i < hw->used_mw_num; i++) {
+		ret = intel_ntb_mw_set_trans(dev, i, hw->mz[i]->iova,
+					     hw->mz[i]->len);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Ring doorbell 0 to tell peer the device is ready. */
+	return intel_ntb_peer_db_set(dev, 0);
+}
+
+/* Check that the peer advertises the same memory-window layout as local. */
+static int
+intel_peer_mw_validate(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *hw = dev->dev_private;
+	uint64_t peer_mw_size;
+	uint32_t val_h, val_l;
+	uint8_t peer_mw_cnt;
+	int i;
+
+	peer_mw_cnt = intel_ntb_spad_read(dev, SPAD_NUM_MWS, 0);
+	if (peer_mw_cnt != hw->mw_cnt) {
+		NTB_LOG(ERR, "Both mw cnt must be the same.");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < hw->mw_cnt; i++) {
+		val_h = intel_ntb_spad_read(dev, SPAD_MW0_SZ_H + 2 * i, 0);
+		val_l = intel_ntb_spad_read(dev, SPAD_MW0_SZ_L + 2 * i, 0);
+		peer_mw_size = ((uint64_t)val_h << 32) | val_l;
+		NTB_LOG(DEBUG, "Peer %u mw size: 0x%"PRIx64"", i, peer_mw_size);
+		if (peer_mw_size != hw->mw_size[i]) {
+			NTB_LOG(ERR, "Mw config must be the same.");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* Read and validate the peer configuration recorded in the scratchpad. */
+static int
+intel_read_peer_config(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *hw = dev->dev_private;
+	uint32_t peer_base_l, peer_val;
+	uint64_t peer_base_h;
+	int i;
+
+	peer_val = intel_ntb_spad_read(dev, SPAD_Q_SZ, 0);
+	if (peer_val != hw->queue_size) {
+		NTB_LOG(ERR, "Inconsistent queue size! (local: %u peer: %u)",
+			hw->queue_size, peer_val);
+		return -EINVAL;
+	}
+
+	peer_val = intel_ntb_spad_read(dev, SPAD_NUM_QPS, 0);
+	if (peer_val != hw->queue_pairs) {
+		NTB_LOG(ERR, "Inconsistent number of queues! (local: %u peer:"
+			" %u)", hw->queue_pairs, peer_val);
+		return -EINVAL;
+	}
+
+	hw->peer_used_mws = intel_ntb_spad_read(dev, SPAD_USED_MWS, 0);
+
+	for (i = 0; i < hw->peer_used_mws; i++) {
+		peer_base_h = intel_ntb_spad_read(dev, SPAD_MW0_BA_H + 2 * i, 0);
+		peer_base_l = intel_ntb_spad_read(dev, SPAD_MW0_BA_L + 2 * i, 0);
+		hw->peer_mw_base[i] = (peer_base_h << 32) + peer_base_l;
+	}
+
+	return 0;
+}
+
+/* Tear down the local scratchpad and translations so the peer can no
+ * longer reach local memory.
+ */
+static void
+intel_link_cleanup(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *hw = dev->dev_private;
+	int status, i;
+
+	/* Clean spad registers. */
+	for (i = 0; i < hw->spad_cnt; i++) {
+		status = intel_ntb_spad_write(dev, i, 0, 0);
+		if (status)
+			NTB_LOG(ERR, "Failed to clean local spad.");
+	}
+
+	/* Clear mw so that peer cannot access local memory. */
+	for (i = 0; i < hw->used_mw_num; i++) {
+		status = intel_ntb_mw_set_trans(dev, i, 0, 0);
+		if (status)
+			NTB_LOG(ERR, "Failed to clean mw.");
+	}
+}
+
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
 /* operations for primary side of local ntb */
 const struct ntb_dev_ops intel_ntb_ops = {
 	.ntb_dev_init       = intel_ntb_dev_init,
 	.get_peer_mw_addr   = intel_ntb_get_peer_mw_addr,
-	.mw_set_trans       = intel_ntb_mw_set_trans,
 	.ioremap            = intel_ntb_ioremap,
 	.get_link_status    = intel_ntb_get_link_status,
 	.set_link           = intel_ntb_set_link,
@@ -627,4 +785,9 @@ const struct ntb_dev_ops intel_ntb_ops = {
 	.db_set_mask        = intel_ntb_db_set_mask,
 	.peer_db_set        = intel_ntb_peer_db_set,
 	.vector_bind        = intel_ntb_vector_bind,
+	.dev_handshake      = intel_dev_handshake,
+	.peer_mw_validate   = intel_peer_mw_validate,
+	.read_peer_config   = intel_read_peer_config,
+	.link_cleanup       = intel_link_cleanup,
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

