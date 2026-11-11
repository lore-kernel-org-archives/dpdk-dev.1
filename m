Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275A606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G4SILZmH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90BA74029E;
	Wed, 11 Nov 2026 08:11:12 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 930064026D;
 Wed, 11 Nov 2026 08:11:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQ3ApLzMb9AOsugPfYtETrHH3emx/mZR+W1Cv42MlwcSNxDb3iPx5QIVK+J4lssVCUUVCEv7q9QcsA+tf1ktl2xXmMhgovpx+EZA7rxdbceb6s5/OZXc0aq8/9UZthzDPJcCUupsPvxB/YakE700vpguPLn5cOZ1DxGnbKehfsQjoGKQWD1jE3GjUkdjX/q3CqClLITw2VU+RfogUL8BlmCvFm+bcH7uYnH8Swrssv9pb6NLsBxc0eIgbH392F/roYfAXtz+Kh4Z0v3HIFV43CBIem6ilHrXKbqIxq9h4jRBssWVQS+5IAGdEYaZPCivvUBQFrDm6n4b88mHxjVUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl0QkNlVJMLKgkClronH58DgSxXRUdUngi7dueADrtc=;
 b=Bsm6luPDHx7Xrbuc+FKAn8vQkQ052aP2/PXzqAJx/lkN5HnC50bf+hjzRnMIqesNp/BNlKG4UPJA79RtC4rAd0CHeGr6i7mSRoaRfMp9/5COzXG7/ZOow0e504p+ze1xq8hh0lPN+6z6SPqc0m7vWagLD2fLYtJqFJRo9oW6DnYtxBBjPtszG7ECgjpLlI1jVcP5C/N9hB09S+bfQDxj+Z2qIwa9DqYp4rMqE1hbAwNhJR0dJU1R7YO0sOlmO0lCnbkuL5tPSwroIyynwFDb+IIhCjQ/IWDV4arEPUzjxeoMfSWK+yey/cc2J8PcNHbJ1XxRdJbLaKXwx4goQ0gNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl0QkNlVJMLKgkClronH58DgSxXRUdUngi7dueADrtc=;
 b=G4SILZmHhBSxG3rxy7CtCE8hLAh6cTOZpjDi+i5zEp957GlfIH4PsqdwMm0ei6yiLynUMeQriuo9pZKzHJCtSEA9Qggj00G/z84j41PIJIekaVaaLjHziIwUULIdokeb5nfqr7Sw1bJnkAFnL7jq/SCL0CMS4DG49RZb/6b7D+M=
Received: from CH0PR03CA0224.namprd03.prod.outlook.com (2603:10b6:610:e7::19)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 07:11:06 +0000
Received: from BL2PEPF000352D3.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::aa) by CH0PR03CA0224.outlook.office365.com
 (2603:10b6:610:e7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D3.mail.protection.outlook.com (10.167.254.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:03 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:14 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 04/16] raw/ntb: fix memory leaks
Date: Wed, 11 Nov 2026 12:36:38 +0530
Message-ID: <85d9ec96069e6be7e5104a6aa42f3c0d2085badc.1794377833.git.raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794377833.git.raghavendra.ningoji@amd.com>
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
 <cover.1794377833.git.raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D3:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 22162cfe-7ab7-44f9-4cf8-08df3fc2f3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|261102123227099003|4143699003|11063799006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|56012099006|261026121527099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 3bTYiGPNCduuiHGBASj3l2W+62nKWymFuApuVURwuxi2gyoP63Ai1YA+yfhdwIKulmxo74OrfpUDF/W+fJ7sNc3djfzyquIqNeWyoVN/H2skOihTBjuW6IyJDlkvaodRZTNCwh/jXWayoc1zBqOBXuPIQ96kWxGBeQVbP8vxnE5TsOPVC77NfMOW1W8p8IsAsA35MEh+MiooG5nCJ038Xu3ipS0AusMKGoYj3KE2kaOcep4GW45/upeerzN8pmT1Ds1zSZMiMrKH/Z1SAcnfDTkqUywpd2b6KvKKrOI51s3OZuuiePe6/YSrVcesBKkPRoPDJzicIl/K8rHukf/tKGqzwbec7XIolaDkgR6uxcfaz0J98VrmQQW+agZu7jh6Rh4+IFFoxGhv/KOsfx4sRdgY1JUQeqZtwMuN+7TnTBrPWwaXUfiKSqkGyvdOmffbbAM5AJgyFulC5J3KpjI1RSMNX9SgpsvkdCzNRDIlneLQVeyqpXInQ8YExqsBaIvY0rqnvuDDVWiSzy7EoMd3eP602sE/L9SEDN8XKDnERgypR3bY3C+q/E0DjzoFjPwlkArSgTOzuyKJQmvZJHC1BBcdwjH31KqOVupO/ZQONOQPfpaKrt9/EEbg+u00oP+WfxtJTbsRpHfHxOM6+izk+w4+wxhFRF2pDTB63QbVO23HCvHSgeRwVbe1IEj/biTyMI3GHE+CmCWAYOFBtdj8gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(261102123227099003)(4143699003)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(56012099006)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rl58/q5dsALukqjoYLAFuuJXm6YsfkaIwIewwl4iuUckkzQHZbXGNZYKeZDGjUWDN9MUnf2QBbC4lqIZX5ah9N5s/Lo21Ol38REj3eg7yjWHZF32ULngYspFtmak80QSrVkyG9a2vzgabAPCQij0Seb73pLtJ8wKtIc8EuEORtO3K2t0tNXMRd6o/hO17yVyexP8EdPiAc5CBcdSKBClf1oez89xFZR3Yu91vId4NZdtLgzn08V0wnYXh94BbvuwJxiIKxyZjPBFj1ouS5pAw+Nnse7IPhxPy0C52jW0+DoBafIn692DYFv/K5MBl2g3bwfyBvTgGLWen1ZCWxwxGi9rVvZasAygK0vauFIzopSWQMzp0G1g1n1TqDbOdsPlxiS478fl1zNgd8d0+I5IWX4As9gylA3uoemQc3WBvvCEa6teaK2kU9sNptb3rXZZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:05.7716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22162cfe-7ab7-44f9-4cf8-08df3fc2f3e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The memory window size array allocated by the vendor init at probe
time was never freed.
The peer memory window base array allocated at each device start was
only freed if the start failed, so it leaked on every stop/start cycle.

As the number of memory windows is fixed for all supported devices,
embed the memory window size array in the device private data instead
of allocating it: it lives as long as the device and remains valid for
the info get after close.
Free the peer memory window base array when stopping the device.

Fixes: c39d1e082a4b ("raw/ntb: setup queues")
Fixes: d6dc5a7f8b06 ("raw/ntb: support AMD NTB")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c          | 6 ++++++
 drivers/raw/ntb/ntb.h          | 5 ++++-
 drivers/raw/ntb/ntb_hw_amd.c   | 6 +-----
 drivers/raw/ntb/ntb_hw_intel.c | 8 +-------
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index e42af0b9c5..5985604cce 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -820,6 +820,8 @@ ntb_dev_start(struct rte_rawdev *dev)
 
 err_up:
 	rte_free(hw->peer_mw_base);
+	hw->peer_mw_base = NULL;
+	hw->peer_used_mws = 0;
 err_q_init:
 	for (i = 0; i < hw->queue_pairs; i++) {
 		ntb_rxq_release_mbufs(hw->rx_queues[i]);
@@ -872,6 +874,10 @@ ntb_dev_stop(struct rte_rawdev *dev)
 		ntb_txq_release_mbufs(hw->tx_queues[i]);
 	}
 
+	rte_free(hw->peer_mw_base);
+	hw->peer_mw_base = NULL;
+	hw->peer_used_mws = 0;
+
 	dev->started = 0;
 }
 
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index 0181bec5c9..31bf0f3260 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -17,6 +17,9 @@ extern int ntb_logtype;
 #define NTB_SPAD_USER               "spad_user_"
 #define NTB_SPAD_USER_LEN           (sizeof(NTB_SPAD_USER) - 1)
 #define NTB_SPAD_USER_MAX_NUM       4
+
+/* Maximum number of memory windows of supported devices. */
+#define NTB_MAX_MW                  2
 #define NTB_ATTR_NAME_LEN           30
 
 #define NTB_DFLT_TX_FREE_THRESH     256
@@ -220,7 +223,7 @@ struct ntb_hw {
 	char *hw_addr;
 
 	uint8_t peer_dev_up;
-	uint64_t *mw_size;
+	uint64_t mw_size[NTB_MAX_MW];
 	/* remote mem base addr */
 	uint64_t *peer_mw_base;
 
diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
index 64075501c2..9b274bc6b9 100644
--- a/drivers/raw/ntb/ntb_hw_amd.c
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -53,6 +53,7 @@ amd_ntb_dev_init(const struct rte_rawdev *dev)
 	NTB_LOG(INFO, "Device topology: %s (sideinfo 0x%" PRIx32 ")",
 		ntb->topo == NTB_TOPO_SEC ? "secondary" : "primary", sideinfo);
 
+	RTE_BUILD_BUG_ON(AMD_MW_COUNT > NTB_MAX_MW);
 	ntb->mw_cnt = AMD_MW_COUNT;
 	ntb->db_cnt = AMD_DB_COUNT;
 	/* The 16-register scratchpad bank is split into two halves, so only
@@ -60,11 +61,6 @@ amd_ntb_dev_init(const struct rte_rawdev *dev)
 	 */
 	ntb->spad_cnt = AMD_SPAD_PER_SIDE;
 
-	ntb->mw_size = rte_zmalloc("ntb_mw_size", ntb->mw_cnt * sizeof(uint64_t), 0);
-	if (ntb->mw_size == NULL) {
-		NTB_LOG(ERR, "Cannot allocate memory for mw size.");
-		return -ENOMEM;
-	}
 	for (i = 0; i < ntb->mw_cnt; i++) {
 		bar = amd_ntb_bar[i];
 		ntb->mw_size[i] = ntb->pci_dev->mem_resource[bar].len;
diff --git a/drivers/raw/ntb/ntb_hw_intel.c b/drivers/raw/ntb/ntb_hw_intel.c
index 47d5d39339..ad8e330199 100644
--- a/drivers/raw/ntb/ntb_hw_intel.c
+++ b/drivers/raw/ntb/ntb_hw_intel.c
@@ -194,17 +194,11 @@ intel_ntb_dev_init(const struct rte_rawdev *dev)
 	if (ret)
 		return ret;
 
+	RTE_BUILD_BUG_ON(XEON_MW_COUNT > NTB_MAX_MW);
 	hw->mw_cnt = XEON_MW_COUNT;
 	hw->db_cnt = XEON_DB_COUNT;
 	hw->spad_cnt = XEON_SPAD_COUNT;
 
-	hw->mw_size = rte_zmalloc("ntb_mw_size",
-				  hw->mw_cnt * sizeof(uint64_t), 0);
-	if (hw->mw_size == NULL) {
-		NTB_LOG(ERR, "Cannot allocate memory for mw size.");
-		return -ENOMEM;
-	}
-
 	for (i = 0; i < hw->mw_cnt; i++) {
 		bar = intel_ntb_bar[i];
 		hw->mw_size[i] = hw->pci_dev->mem_resource[bar].len;
-- 
2.34.1

