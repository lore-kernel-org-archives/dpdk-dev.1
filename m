Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CABCCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 06:39:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 371104060B;
	Mon, 19 Oct 2026 08:39:24 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66]) by mails.dpdk.org (Postfix) with ESMTP id 2925040269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 08:39:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inZ102uOlXueH/HcI/0qHhhKQ7ZIGI27C1He/BbBjud2+yfhuP6xhL3Sv3Py+rGzigu5mY63ig9YTeDRBD5lrR3oDyYqJtNbjTXgp3dQaxqugVhhzNSLwZW36eTLqJrI41gavz12rpUxWXJuRrMdyDFh6FuHATQGE4xKKUbJCjx2vWlCv2DmvQyTINft634snaGpxp45ji/YbH9ibsmDZD9tBr7lor0lASBh4988JQRzahVvZplMUixD2he4LERjl3CKttp/gu+O+n/8Ap3UuQb4f4ou+0iULFM5ZuZYbfsRcveP5hN6YeCPzk2alLMtZAvwZ6Nk6ir5T5f6V5aiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8YaQJz6O5wkdY+NZVTw1pWtzOZlkNhEyRN/MRQNmys=;
 b=T4oMceRqsxv6zKcEVof7IdhW/Eqol1gVMmRuQygZoo2FmFCblF0225FsfajYYs2tpEPqbnb++p2zDfw5BHZZXgIrxB4HSShfylDEB01+9hqyAIAtND82iOiCTamPoBlmtUpMtuSJoRQ8fOOCMLotEwkIrVXkTVa9jHD2ojcrnprzI+QNXcsHBJ8bpPSPuKeMRbUfkTy+Gx/8ZAgNv/y+3f/LBOtwBgkUFYL//gboUlCWKBYU9ULyylhZHscOPxKX5Pawaj/5MMbyzeEpJuXgwoN0NOddL8uskHMufkVMaDRlmOkGr3FGCKMrmRcqa12krneO2x9Tfd7Y4AVfpzb/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8YaQJz6O5wkdY+NZVTw1pWtzOZlkNhEyRN/MRQNmys=;
 b=DnTmc8i54/aXQeXm09VcljSQu4FLAGk6bi5AbAhDisW6DSzBCxTNF4I+MlUlk8X3umc7dH/qpKoWYZGQaL+Ed/GihjNdKM6SJT00BtsyT6DyxosJGJaA1pbARLKSxdn3WSEhpNFI64Wgc9tWrKxfrhVCG4TD7p1lPdYeCBd6hUY=
Received: from CH0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:610:b3::17)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 06:39:16 +0000
Received: from BL6PEPF0006C3DB.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::9c) by CH0PR03CA0042.outlook.office365.com
 (2603:10b6:610:b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Mon,
 19 Oct 2026 06:39:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DB.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:39:15 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:39:04 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v3 1/3] raw/ntb: validate vendor ops at probe
Date: Mon, 19 Oct 2026 12:08:21 +0530
Message-ID: <20261019063823.2831572-2-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DB:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b34549f-bb4d-46a1-d933-08df2dabb181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|22082099003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: VOUJpoCqIxQPKcgsK44hgA+l4aiDOwiN0npPMcWr6IOFy/ZVbpPK9YRsLxmp3ThiDzk6p4BQzigBPRWQTj0QikkUjkhdDwNGNSJP4zfB2HkwIPW8T4tRbPqiyjDxtW0AIrpwv0S4oUN8ij07qOgMexY9oj5hdisC7DLlFp5xrcfcx2YSR0kT6TEq7G3/63q7wv6d5PGV5hz8VW0y9J8hUlVYcqvbEdKqEBpe9EzRVowTUtXgObGuyp67hpuAAogMlAo2Z54eflVmoYJcbg9JGhtbe5h3Ji0s2FpOR91VPd0qs3ERR5Z71Oy/3ULj0PzAnbzOVaZk/3p50L2Rkp1KIrxDyJIEFiSQqfbdLqy/AHvikIQix7b4f81KZjDlvWC1/ozjNL7peS/WMTTKAccpMogpwuAcArFMeQN74lUj0h3Xt4vzdfq0A6FMZfZXhxsfhDMbUGF0N7MmfZhvFtdmqrE32TnEEJ0/3YCHA5YJ8gmYaHH1qh+NEqesZ6SzHm7nMGHrJCrejAkg848QeWn7DsADmrQDrbiotowYdeBr29X+Y1hS5/iDcRwwu2Gai1Ye72dHf5ayirO5FQzQLpUdou0WoMxyE7PZCAiGqduVCigL6libGo9xCzRt7DeJYYSIBKNHTm21iWDfJ4IFh5XAOyScPZzQPPEePQE6MDot+ys+0jJW3RKaoSGrYO1tK9NI/5PGD/6USbryAO90yi2f9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HdGTNu1mCqPbPq8HZjE8evIg6PVpA010DNiuJkOtkfG4A7kHeTfKZ8lHSkIaJLjax6uFr+cEICajkosO8qltwMKkxe+BGQXRFfWu1+fAlFTZfHBugOAYOW/gHOuag7c3lbVM+AMojs13vbF75+7IYvXuVYZT5A3PtKBqLkzoMDlseSliRI61rLQTfFJsW+p6b6pQZXNjzRea54QpCVWZ9k0Goo34DUaKPHGDPlhxgQC4QZx11XNxMQw67FHUXImsJDQoCIEG6Aqs68H79TVjfw1vuk78DUqa6w5wjMepYmNRIzSX5zebsG++c1RrS+xwb+a8E6VVePf+CA7NSwSvxe2umZITsY7boUoeWpMCjGmEg+SWyB91VDS/TJpgNnTVNhapvpiQeHGHuw098HLz7E/AvQblL54/w3MdDt0OH0Dz1TqK90D5UWtP5EstkGkh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:39:15.0275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b34549f-bb4d-46a1-d933-08df2dabb181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

The NTB driver dereferences the vendor ntb_ops hooks unconditionally
throughout the common code, yet also guards many of those calls with
runtime NULL checks. Those checks can never fire for a correctly
populated vendor ops table and only make the code harder to follow.

Validate the mandatory ops once, right after the vendor ops table is
selected at probe time, and drop the scattered per-call NULL checks.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 116 +++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 68 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index d54f2fb783..874365748c 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2019 Intel Corporation.
  */
+#include <stddef.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
@@ -46,12 +47,6 @@ ntb_link_cleanup(struct rte_rawdev *dev)
 	struct ntb_hw *hw = dev->dev_private;
 	int status, i;
 
-	if (hw->ntb_ops->spad_write == NULL ||
-	    hw->ntb_ops->mw_set_trans == NULL) {
-		NTB_LOG(ERR, "Not supported to clean up link.");
-		return;
-	}
-
 	/* Clean spad registers. */
 	for (i = 0; i < hw->spad_cnt; i++) {
 		status = (*hw->ntb_ops->spad_write)(dev, i, 0, 0);
@@ -74,12 +69,6 @@ ntb_handshake_work(const struct rte_rawdev *dev)
 	uint32_t val;
 	int ret, i;
 
-	if (hw->ntb_ops->spad_write == NULL ||
-	    hw->ntb_ops->mw_set_trans == NULL) {
-		NTB_LOG(ERR, "Scratchpad/MW setting is not supported.");
-		return -ENOTSUP;
-	}
-
 	/* Tell peer the mw info of local side. */
 	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_NUM_MWS, 1, hw->mw_cnt);
 	if (ret < 0)
@@ -150,13 +139,6 @@ ntb_dev_intr_handler(void *param)
 	uint8_t peer_mw_cnt;
 	int i = 0;
 
-	if (hw->ntb_ops->db_read == NULL ||
-	    hw->ntb_ops->db_clear == NULL ||
-	    hw->ntb_ops->peer_db_set == NULL) {
-		NTB_LOG(ERR, "Doorbell is not supported.");
-		return;
-	}
-
 	db_bits = (*hw->ntb_ops->db_read)(dev);
 	if (!db_bits)
 		NTB_LOG(ERR, "No doorbells");
@@ -174,11 +156,6 @@ ntb_dev_intr_handler(void *param)
 		if (hw->peer_dev_up)
 			return;
 
-		if (hw->ntb_ops->spad_read == NULL) {
-			NTB_LOG(ERR, "Scratchpad read is not supported.");
-			return;
-		}
-
 		/* Check if mw setting on the peer is the same as local. */
 		peer_mw_cnt = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_MWS, 0);
 		if (peer_mw_cnt != hw->mw_cnt) {
@@ -214,10 +191,6 @@ ntb_dev_intr_handler(void *param)
 		}
 
 		/* To get the link info. */
-		if (hw->ntb_ops->get_link_status == NULL) {
-			NTB_LOG(ERR, "Not supported to get link status.");
-			return;
-		}
 		(*hw->ntb_ops->get_link_status)(dev);
 		NTB_LOG(INFO, "Link is up. Link speed: %u. Link width: %u",
 			hw->link_speed, hw->link_width);
@@ -511,11 +484,6 @@ ntb_queue_init(struct rte_rawdev *dev, uint16_t qp_id)
 	void *bar_addr;
 	uint16_t i;
 
-	if (hw->ntb_ops->get_peer_mw_addr == NULL) {
-		NTB_LOG(ERR, "Getting peer mw addr is not supported.");
-		return -EINVAL;
-	}
-
 	/* Put queue info into the start of shared memory. */
 	hdr_offset = hw->hdr_size_per_queue * qp_id;
 	local_hdr = (volatile struct ntb_header *)
@@ -615,11 +583,6 @@ ntb_enqueue_bufs(struct rte_rawdev *dev,
 	void *buf_addr;
 	int i;
 
-	if (unlikely(hw->ntb_ops->ioremap == NULL)) {
-		NTB_LOG(ERR, "Ioremap not supported.");
-		return nb_tx;
-	}
-
 	if (unlikely(dev->started == 0 || hw->peer_dev_up == 0)) {
 		NTB_LOG(DEBUG, "Link is not up.");
 		return nb_tx;
@@ -929,11 +892,6 @@ ntb_dev_start(struct rte_rawdev *dev)
 		goto err_q_init;
 	}
 
-	if (hw->ntb_ops->spad_read == NULL) {
-		ret = -ENOTSUP;
-		goto err_up;
-	}
-
 	peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_Q_SZ, 0);
 	if (peer_val != hw->queue_size) {
 		NTB_LOG(ERR, "Inconsistent queue size! (local: %u peer: %u)",
@@ -988,10 +946,6 @@ ntb_dev_stop(struct rte_rawdev *dev)
 	ntb_link_cleanup(dev);
 
 	/* Notify the peer that device will be down. */
-	if (hw->ntb_ops->peer_db_set == NULL) {
-		NTB_LOG(ERR, "Peer doorbell setting is not supported.");
-		return;
-	}
 	status = (*hw->ntb_ops->peer_db_set)(dev, 1);
 	if (status) {
 		NTB_LOG(ERR, "Failed to tell peer device is down.");
@@ -1012,10 +966,6 @@ ntb_dev_stop(struct rte_rawdev *dev)
 
 clean:
 	/* Clear doorbells mask. */
-	if (hw->ntb_ops->db_set_mask == NULL) {
-		NTB_LOG(ERR, "Doorbell mask setting is not supported.");
-		return;
-	}
 	status = (*hw->ntb_ops->db_set_mask)(dev,
 				(((uint64_t)1 << hw->db_cnt) - 1));
 	if (status)
@@ -1084,8 +1034,6 @@ ntb_attr_set(struct rte_rawdev *dev, const char *attr_name,
 	hw = dev->dev_private;
 
 	if (!strncmp(attr_name, NTB_SPAD_USER, NTB_SPAD_USER_LEN)) {
-		if (hw->ntb_ops->spad_write == NULL)
-			return -ENOTSUP;
 		index = atoi(&attr_name[NTB_SPAD_USER_LEN]);
 		if (index < 0 || index >= NTB_SPAD_USER_MAX_NUM) {
 			NTB_LOG(ERR, "Invalid attribute (%s)", attr_name);
@@ -1182,8 +1130,6 @@ ntb_attr_get(struct rte_rawdev *dev, const char *attr_name,
 	}
 
 	if (!strncmp(attr_name, NTB_SPAD_USER, NTB_SPAD_USER_LEN)) {
-		if (hw->ntb_ops->spad_read == NULL)
-			return -ENOTSUP;
 		index = atoi(&attr_name[NTB_SPAD_USER_LEN]);
 		if (index < 0 || index >= NTB_SPAD_USER_MAX_NUM) {
 			NTB_LOG(ERR, "Attribute (%s) out of range", attr_name);
@@ -1364,6 +1310,49 @@ static const struct rte_rawdev_ops ntb_ops = {
 	.xstats_reset         = ntb_xstats_reset,
 };
 
+/* Every vendor ops entry is dereferenced unconditionally in the common
+ * code, so enforce their presence once at probe time instead of guarding
+ * every call site at runtime.
+ */
+static int
+ntb_vendor_ops_check(const struct ntb_hw *hw)
+{
+	static const struct {
+		size_t offset;
+		const char *name;
+	} required[] = {
+#define NTB_OPS_REQ(member) \
+		{ offsetof(struct ntb_dev_ops, member), #member }
+		NTB_OPS_REQ(ntb_dev_init),
+		NTB_OPS_REQ(get_peer_mw_addr),
+		NTB_OPS_REQ(mw_set_trans),
+		NTB_OPS_REQ(ioremap),
+		NTB_OPS_REQ(get_link_status),
+		NTB_OPS_REQ(set_link),
+		NTB_OPS_REQ(spad_read),
+		NTB_OPS_REQ(spad_write),
+		NTB_OPS_REQ(db_read),
+		NTB_OPS_REQ(db_clear),
+		NTB_OPS_REQ(db_set_mask),
+		NTB_OPS_REQ(peer_db_set),
+		NTB_OPS_REQ(vector_bind),
+#undef NTB_OPS_REQ
+	};
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(required); i++) {
+		const void * const *slot = (const void * const *)
+			((const char *)hw->ntb_ops + required[i].offset);
+		if (*slot == NULL) {
+			NTB_LOG(ERR, "Vendor ops lacks mandatory .%s.",
+				required[i].name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int
 ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 {
@@ -1387,16 +1376,16 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 		return -EINVAL;
 	}
 
-	if (hw->ntb_ops->ntb_dev_init == NULL)
-		return -ENOTSUP;
+	ret = ntb_vendor_ops_check(hw);
+	if (ret)
+		return ret;
+
 	ret = (*hw->ntb_ops->ntb_dev_init)(dev);
 	if (ret) {
 		NTB_LOG(ERR, "Unable to init ntb dev.");
 		return ret;
 	}
 
-	if (hw->ntb_ops->set_link == NULL)
-		return -ENOTSUP;
 	ret = (*hw->ntb_ops->set_link)(dev, 1);
 	if (ret)
 		return ret;
@@ -1404,8 +1393,6 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	/* Init doorbell. */
 	hw->db_valid_mask = RTE_LEN2MASK(hw->db_cnt, uint64_t);
 	/* Clear all valid doorbell bits before registering intr handler */
-	if (hw->ntb_ops->db_clear == NULL)
-		return -ENOTSUP;
 	(*hw->ntb_ops->db_clear)(dev, hw->db_valid_mask);
 
 	intr_handle = pci_dev->intr_handle;
@@ -1423,19 +1410,12 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	 */
 	if (!rte_intr_cap_multiple(intr_handle)) {
 		for (i = 0; i < hw->db_cnt; i++) {
-			if (hw->ntb_ops->vector_bind == NULL)
-				return -ENOTSUP;
 			ret = (*hw->ntb_ops->vector_bind)(dev, i, 0);
 			if (ret)
 				return ret;
 		}
 	}
 
-	if (hw->ntb_ops->db_set_mask == NULL ||
-	    hw->ntb_ops->peer_db_set == NULL) {
-		NTB_LOG(ERR, "Doorbell is not supported.");
-		return -ENOTSUP;
-	}
 	hw->db_mask = 0;
 	ret = (*hw->ntb_ops->db_set_mask)(dev, hw->db_mask);
 	if (ret) {
-- 
2.34.1

