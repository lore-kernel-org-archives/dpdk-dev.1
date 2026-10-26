Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACB606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=17Wj0HnT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2558E4064F;
	Mon, 26 Oct 2026 09:55:59 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by mails.dpdk.org (Postfix) with ESMTPS id 10479402E8
 for <dev@dpdk.org>; Mon, 26 Oct 2026 09:55:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJBQF3GO+Bip7HzX9NB0C0iDbXHoD4+nUsimVKyaQXbvrgMIXAiWkeb+aENMvMQlvsOXcaflRrqO3VC4mtybw96NY/DAIm4MvTI8JYtWr2yympI9EFgtpsZDEycbLSPLnhsbjUup6LP9/U27o5+try3pMsNZUwW2ESDcOKXJEdks1nHmZX4K8xqQ+gWqM/edqVHqMHH4e2H2AXI9aub5cn04G2zTl5xeVvV8QcrwM2qOf80FywQYg2VEGusrdzJkdJZ893mK3+abqDrOKaQhm2KuHpFFsgale2vV8nKUVLFcOJdva8mSCH8SF2jrVeagCx7vN2S4cdqYYboPX/tyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2a2DqGv0ixmDOA3bPCIPoKybp0EPXH9FlXa8/2Jc2s=;
 b=JSxOGoPjVDgh3sYJeg/8qrCvIDMmyQDsR7hVL7VSE5C+3c46uiaEIRouXu1SzBFuExNB7cCiugbWqvxqMsZQDgaqJr1bGmbzwtX8Wiyui6Ww9Q1cNQrGOqP2lOME8C13csed2sU7sdwss38YHfaeiK9XTsKau3g37z/8RItabtNUG+zZtuePlBgocS8wySjde/9PMutyjKnCpxhxwMlaQl0hDYKrEbOceBLzwVXATHn2gBfrGN3KrXYkHhNdnfYwKfYx9Snc57w4uIvtZhuA4qHY/LiuIUAsZA1H0l8sR6xX8PaR68To5b4vrPR043qYLAbZv84IOEu1ShGTgX7ZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2a2DqGv0ixmDOA3bPCIPoKybp0EPXH9FlXa8/2Jc2s=;
 b=17Wj0HnTs518m2CQFrH3S2CNidurBAbup71y4n47SI5RaYCwi3GWjEPpSwxlNIg2Y6cr5F2x7qi8WaXYkjQrJ/xyEFmbxNrySpEwab3pZtad4+5odCVLI6RxuhJLFhGVNLJtue9/86exQfilzY/LcAtVO1CxWgrFXmDAV40tITY=
Received: from MW4PR03CA0297.namprd03.prod.outlook.com (2603:10b6:303:b5::32)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:55:49 +0000
Received: from CO1PEPF00018862.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::91) by MW4PR03CA0297.outlook.office365.com
 (2603:10b6:303:b5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:55:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018862.mail.protection.outlook.com (10.167.249.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:55:49 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:55:46 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v4 2/3] raw/ntb: generalize framework for multiple vendors
Date: Mon, 26 Oct 2026 14:25:14 +0530
Message-ID: <20261026085515.3238805-3-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
References: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018862:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 0127a67d-3c81-42a4-a871-08df333eeed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|56012099006|261021123027099003|261021121427099003|261022115727099003|261022105027099003|261022075727099003|261021135927099003|261021133027099003|261021130227099003|261022113327099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: JP/Z5adZT7Ze2VAkeNW//QqaOaQr77YPZez398Z73eNBitAuoSZm5+7yXqj578UO4QnEZIcJVFxdN2c0RE1QXBYwCVlqHijKUnc9VvKXIJyz8lLECvQGm7RAR81HL99pVmhQZEPKCrx63V7xk/JTXdx85yHGx+yxQBKFaxQu8+vJiPegv8pasMKVH/vZUxZEwvwv07+e79hMxgIacYO30KUs6bBazKqDb8PvnuVfeeg3c2SwViWStW05I5etsG5CTsI/vouhGF4uVinfslXfI65mnEqKpaUalTPKV0kgDwPT5+Rbu+SVEsfd76yY70VZqkuh/Qrpp0Dik4lznWCJf7J3WIgo3Rz5YAv2E332X9As/eCC8ohvOUNVftuksmN6/0e17PJH2WHQa027PbyVJgAHR6dVYkgt1BUk3eYgZFOsxHgZg+8JeBCIEhOSFcOAUqaWsvQ7nHfYfG9ZnW+W6WO/hXjrJCYWZ7dv27w47RKG48oP11Eqz/qXP43qKSyPiUt/R/DBJva7feALhkzp9xGtVJ/Afa2FuL+Yf776I4nNzetD//lu7LlGwx9P21BClmXrL/k3OY38TSPGktF5ArzjCckBXRwXdzOMqVqaChplLoIS1LkQ1F+0PRsFaVx44QtkaB1BKV/GVIiNkCYUngCqt/sNzmGSAaSABRi9FGNDQ4yYRzjIIDnySpLiJ0JRJF5ref1uT46Elu+FFw1rmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261022113327099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mdgzuiGozBy+/KsqrXjHcGsJZIbE8xW9XQakItMqh/BU3ZmKSjvHWoWQyrVDY8RKEPVKYmBppykFNPoniaQVHpr090Zj1xhjYODs4sfuHWnnydYKkeu9x+4LyzTvaXIKSIdgqDx0uoB9oF69NbBtaRMjjnzxwdi4iKj5BH4JD3yNDs0W//bBpi9U1/Zjw9WEJlIa9iA2XpoQK1ECMJPTZ1Q5wLGjhN2H5cKbEgvpLm0zxG5SYLiG/Mak715vm0JAyOrpZ9DGSBJA4jOlFtiIBoa+A1MsMSu+Z6P2pB2w0edJ/4532c79xxHsIcZUlTH0LsdjBkVKT/xitjKmm+QP6kSDu9fLLpfxhE7Q+VfRzP3Dxn6K8CCPEm/9KqaQybuPsFZmELfkHqtfse+MsIZYxBVXuhYGQ1/nPjhlSH2eq3O7/M7AzH6k1P69GFNcN7vt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:55:49.6505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0127a67d-3c81-42a4-a871-08df333eeed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018862.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 doc/guides/rel_notes/release_26_11.rst |   5 +
 drivers/raw/ntb/ntb.c                  | 202 ++++++-------------------
 drivers/raw/ntb/ntb.h                  |  21 ++-
 drivers/raw/ntb/ntb_hw_intel.c         | 165 +++++++++++++++++++-
 drivers/raw/ntb/rte_pmd_ntb.h          |  28 +++-
 examples/ntb/ntb_fwd.c                 |   6 +-
 6 files changed, 266 insertions(+), 161 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..30f2f3009f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -545,6 +545,11 @@ API Changes
   * ``rte_tel_data_add_dict_uint_hex``
   * ``rte_telemetry_register_cmd_arg``
 
+* raw/ntb: Removed the ``mw_size_align`` field from ``struct ntb_dev_info``.
+  Applications must now query the required memory window base-address
+  alignment with the new ``rte_pmd_ntb_get_mem_align()`` function
+  instead of relying on this field.
+
 
 ABI Changes
 -----------
diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 09cf325c9a..0e0cdf38e3 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -18,6 +18,7 @@
 #include <rte_memcpy.h>
 #include <rte_rawdev.h>
 #include <rte_rawdev_pmd.h>
+#include <eal_export.h>
 
 #include "ntb_hw_intel.h"
 #include "rte_pmd_ntb.h"
@@ -40,103 +41,12 @@ static struct rte_rawdev_xstats_name ntb_xstats_names[] = {
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
@@ -155,36 +65,19 @@ ntb_dev_intr_handler(void *param)
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
@@ -202,7 +95,7 @@ ntb_dev_intr_handler(void *param)
 		(*hw->ntb_ops->db_clear)(dev, 2);
 
 		/* Peer device will be down, So clean local side too. */
-		ntb_link_cleanup(dev);
+		(*hw->ntb_ops->link_cleanup)(dev);
 
 		hw->peer_dev_up = 0;
 		/* Response peer's dev_stop request. */
@@ -220,6 +113,10 @@ ntb_dev_intr_handler(void *param)
 
 	/* Clear other received doorbells. */
 	(*hw->ntb_ops->db_clear)(dev, db_bits);
+
+	/* Let the vendor process any hardware-specific events. */
+	if (hw->ntb_ops->handle_hw_event != NULL)
+		(*hw->ntb_ops->handle_hw_event)(dev);
 }
 
 static int
@@ -708,6 +605,11 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
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
@@ -796,13 +698,6 @@ ntb_dev_info_get(struct rte_rawdev *dev, rte_rawdev_obj_t dev_info,
 	info->mw_cnt = hw->mw_cnt;
 	info->mw_size = hw->mw_size;
 
-	/**
-	 * Intel hardware requires that mapped memory base address should be
-	 * aligned with EMBARSZ and needs continuous memzone.
-	 */
-	info->mw_size_align = (uint8_t)(hw->pci_dev->id.vendor_id ==
-					NTB_INTEL_VENDOR_ID);
-
 	if (!hw->queue_size || !hw->queue_pairs) {
 		NTB_LOG(ERR, "No queue size and queue num assigned.");
 		return -EAGAIN;
@@ -817,6 +712,26 @@ ntb_dev_info_get(struct rte_rawdev *dev, rte_rawdev_obj_t dev_info,
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
@@ -845,7 +760,7 @@ ntb_dev_configure(const struct rte_rawdev *dev, rte_rawdev_obj_t config,
 					 sizeof(uint64_t), 0);
 
 	/* Start handshake with the peer. */
-	ret = ntb_handshake_work(dev);
+	ret = (*hw->ntb_ops->dev_handshake)(dev);
 	if (ret < 0) {
 		rte_free(hw->rx_queues);
 		rte_free(hw->tx_queues);
@@ -861,8 +776,6 @@ static int
 ntb_dev_start(struct rte_rawdev *dev)
 {
 	struct ntb_hw *hw = dev->dev_private;
-	uint32_t peer_base_l, peer_val;
-	uint64_t peer_base_h;
 	uint32_t i;
 	int ret;
 
@@ -891,31 +804,10 @@ ntb_dev_start(struct rte_rawdev *dev)
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
 
@@ -942,7 +834,7 @@ ntb_dev_stop(struct rte_rawdev *dev)
 	if (!hw->peer_dev_up)
 		goto clean;
 
-	ntb_link_cleanup(dev);
+	(*hw->ntb_ops->link_cleanup)(dev);
 
 	/* Notify the peer that device will be down. */
 	status = (*hw->ntb_ops->peer_db_set)(dev, 1);
@@ -1324,7 +1216,6 @@ ntb_vendor_ops_check(const struct ntb_hw *hw)
 } while (0)
 	NTB_OPS_REQ(ntb_dev_init);
 	NTB_OPS_REQ(get_peer_mw_addr);
-	NTB_OPS_REQ(mw_set_trans);
 	NTB_OPS_REQ(ioremap);
 	NTB_OPS_REQ(get_link_status);
 	NTB_OPS_REQ(set_link);
@@ -1335,6 +1226,11 @@ ntb_vendor_ops_check(const struct ntb_hw *hw)
 	NTB_OPS_REQ(db_set_mask);
 	NTB_OPS_REQ(peer_db_set);
 	NTB_OPS_REQ(vector_bind);
+	NTB_OPS_REQ(dev_handshake);
+	NTB_OPS_REQ(peer_mw_validate);
+	NTB_OPS_REQ(read_peer_config);
+	NTB_OPS_REQ(link_cleanup);
+	NTB_OPS_REQ(mem_align);
 #undef NTB_OPS_REQ
 
 	return 0;
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index 8c7a2230f9..546677a694 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -88,7 +88,6 @@ enum ntb_spad_idx {
  * NTB device operations
  * @ntb_dev_init: Init ntb dev.
  * @get_peer_mw_addr: To get the addr of peer mw[mw_idx].
- * @mw_set_trans: Set translation of internal memory that remote can access.
  * @ioremap: Translate the remote host address to bar address.
  * @get_link_status: get link status, link speed and link width.
  * @set_link: Set local side up/down.
@@ -100,12 +99,21 @@ enum ntb_spad_idx {
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
@@ -119,6 +127,13 @@ struct ntb_dev_ops {
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
index 76da3be026..73e4628b28 100644
--- a/drivers/raw/ntb/rte_pmd_ntb.h
+++ b/drivers/raw/ntb/rte_pmd_ntb.h
@@ -7,6 +7,8 @@
 
 #include <stdint.h>
 
+#include <rte_compat.h>
+
 /* App needs to set/get these attrs */
 #define NTB_QUEUE_SZ_NAME           "queue_size"
 #define NTB_QUEUE_NUM_NAME          "queue_num"
@@ -23,8 +25,6 @@
 
 struct ntb_dev_info {
 	uint32_t ntb_hdr_size;
-	/**< memzone needs to be mw size align or not. */
-	uint8_t mw_size_align;
 	uint8_t mw_cnt;
 	uint64_t *mw_size;
 };
@@ -42,4 +42,28 @@ struct ntb_queue_conf {
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
index bbacce97db..9168f299c6 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -1150,8 +1150,6 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 		if (!left_sz)
 			break;
 		snprintf(mz_name, sizeof(mz_name), "ntb_mw_%d", mz_id);
-		align = ntb_info.mw_size_align ? ntb_info.mw_size[mz_id] :
-			RTE_CACHE_LINE_SIZE;
 		/* Reserve ntb header space on memzone 0. */
 		max_mz_len = mz_id ? ntb_info.mw_size[mz_id] :
 			     ntb_info.mw_size[mz_id] - ntb_info.ntb_hdr_size;
@@ -1159,6 +1157,10 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
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

