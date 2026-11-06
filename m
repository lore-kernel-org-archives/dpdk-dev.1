Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5D606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=naxOoWtK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF73E42D97;
	Fri,  6 Nov 2026 06:51:17 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by mails.dpdk.org (Postfix) with ESMTPS id 4B4CF427DC;
 Fri,  6 Nov 2026 06:51:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f16tJ9LOUBkYxXzpj3cbrckYfgN6wAlH5xv1Y/3aovP8zCJ/LE6MBERO8PyQmnoE5eJY/58kRfRupca/9xR/dAfguCUsx8i231AKDk7aZumCXucBVflGM9N0ZzfNRJU30xIr5e09NCrua/VGvdaj/Vbox0UVNUCPHfmi/SPO53//J34CTO81MkvCNZ+GbYwjeNIcf0jkd8LfIb+d8VWYVDiXqN9ZF6J1HwZ16TEe1Jg2X47Bm2Ej6ZBfN4/+Z6bhDZSUbewbBJ3u+TYmvswqIpCkYHHAT5atV+1BUDuPSuvlINAQKnHyWrGNu8RmqVoXxc3h7W6Rok8EgbCybXXHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl0QkNlVJMLKgkClronH58DgSxXRUdUngi7dueADrtc=;
 b=lyMTjvRRCrsSH5Jtexse/ojb7illm6CdwDnRqhcc+Y+7GQk3Uet/Mg/QKYa5U5ytzbg2pHPcqSbnvreiILLnhOReE/tOhtceZXqoS/ucCnhXcCElqlC+E4e33L+0gGDZXS0xQPzEB/pFRgnEQYyCRA2deBk8zZeEqQz1jdWkBaIG5GQxvznpeapGjG9AmgCDWKgX7MbTkPmpacBBXJOvPS9TiYjm8pALke03KGMcjef35LsYYJ5vkYOtMSQQmZiIHkYcefWcajRb+0Fn7fEyzDq2aVY7qE7qdPP86MZM3r1+1LeeOSgo3ozXSzhxQv8K3Gnfx1of5dX0xWKZJMW1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl0QkNlVJMLKgkClronH58DgSxXRUdUngi7dueADrtc=;
 b=naxOoWtKkOg7WpdLa+wwpKFx/Vz0QlpTzYXDRoxS1nd3BeeSqhzagLLeMd9R0sztmmvbxqvK3KnfD1LP3t53ztmKtA6sANywuveH/CrgRjEjzLqFkyTaGmU6idO58gWtSMeHX8r7Q18zcnJbRv6jCPrpgf/jeh7fmz5TmpycW6w=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:51:11 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::8) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:11 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:08 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2 04/15] raw/ntb: fix memory leaks
Date: Fri, 6 Nov 2026 11:20:34 +0530
Message-ID: <20261106055045.720805-5-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3d3a01-7196-4dce-6981-08df3bc9f636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|56012099006|22082099003|10067099003|18002099003|261102123227099003|261009223027099003|261021121427099003|261022105027099003|261021123027099003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: w3bjNYR/4oEvnfgp47GJ4Lqvt5MoqcNfiQyzoleIdkf1YWFRD1V1IxvFMpvL7byMIgT2roo0+VqqTedGTuygzmOeGtSantkqTZpCH4wPIk+vyXNQ0tXurblX12EzrJ9Ouzb5Twwzx29akpj3fhUw9nXycU5uJ+hKOHfykcjOyQboN/yd0ZIxMlxVng0XQcojWl/FAgIgesJWROpTL8dMhZgtRhqmZuuUW9ShxRBUhLL5J8BgWBhKhkrQi3emG6D+7ftiRYWHocZABK3x0RS58DZuALmFtoSUhm8NTr6MWI8v5ovH+lKB1KZpc+CAgFFKxAmwV0legN9UqiAHedmzjuA6B5OQCGFmnWywbPkSQ/fdwl/u9TqZ/zlR+ld4oF+lcZSKBNn9G0bK1cW7VBWE+rrrRCkFL9XvZidSxNbJT/mGmjgmuaI1sJ9dNzctuYUo+7bDcm2nyCOPyUtTCJdnvuWw2iXclBd5k/CsXqRRh7mZfEJslZiPJGmmXWFTwb9PkfGbRhd2FAube8xjLqCqYzejFTSCt3ptuQ6II+oqAeG4XkmCzouSvQn90EYAArRJGm7L/bA5q/OYbvujPYev4DXQmssjZmVAx2KrW+DspDhMDfo/+A2pckz75u0WZpJEvWSrvHDWwW+hJceiMg9tyR2wcmb3XlzNZ9D+PTuxDD5g8eoGda0dd0IHZvW+9N5s60hRfKTrKncfQ09wcrFAHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(56012099006)(22082099003)(10067099003)(18002099003)(261102123227099003)(261009223027099003)(261021121427099003)(261022105027099003)(261021123027099003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: meNqIVpcGIJ6Rvhi9F+2qddhRFHbuSsmG+SOLnSuVCZVh8SZ9Qbj/iKsG8qUZk2S2XcFsiOxiDJgwLVQJUKPyvbD4KQjeArRT6ONogcms0035RTvVpUzeID6XOEaBzJSHdlhnCQ5AC/16G1HWXoZ0SMC7t1Pmgq6tq5QZTLu+yMfitqiRPckNk3kgW1TG1h6EYES1SYsn9vUMu/LmgxUmnSu6DeYfT1EJTE/IUL4E0uw/d2naK9apYi0WmuXVhqM4i/aFuSAjyI7rqV0lufwXCGFR0UxP8dIHMLMB9uzw0nJXNuldih5SnHujrVb5kBk+A6V+8QgTNGxblEU9sv13FB9LOatwiF+RgpMEP6fZg7KnbnyVU0ADnTrnhxudh03QuRksA6I/slaAxLVBjBSioWxSTL5TwjGBYVdGJNbHqo81nHZfPT1krTcoZapygSu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:11.4247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3d3a01-7196-4dce-6981-08df3bc9f636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8
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

