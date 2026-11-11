Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB9606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BhhHeABm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85D9E427B9;
	Wed, 11 Nov 2026 08:11:28 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 082F141143;
 Wed, 11 Nov 2026 08:11:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihrArfuG1ElMvD+a6sokmZChwfoI5n9bDxD0YJdFlY7K44EGyL1I73hDhqjRVdEggiikkO0X3MR4ZH9NwFBNxhfKUOHWHIUBPEmeIGlaumKs8LG57Ky9C/L5qCDWOSf9sVo/d9iI2Kg7pB/zHKPkLdah/NPEF25qd8K4rhXH6kovnZgnXiYkU6Us0vj7y2Km5fOvIydCCKLFI5jtE3NxXJ5SGH1oreVwpnyUmhp5/6R8gkemnUBweS3xQ75+cqGhqvJE+YcdufLI/3nYUGNdkoAbs7a/dt1nSRYR4NEUEsTEIxt20G7VODVpT8j5RWKNAGpsZL2nLVQ93XqDeg2ZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjy4jRaESSQJ1Vu13iE+z8pHaz7BVJXEhKKhVcvR2/w=;
 b=G0DJX8kX+Z0fLeexi4nElLb5arYd+ew/iovvBEI3brrLDfdAIkc5+1ro8X8ZChyWgZyDFyKcjH6+27kme5K8EFfGUjiPTtyFpnzZQlBSIqhyWZnUrrRxl/1rb8VLgh2xLD1ftEC56GFgr4TpnHzmqmW5Ozx7SdnDU8Ho3vVjSRTekWfOf060UWUoWQyTFFttYPFS+kIgpiGPpgpD3/0lIK1zEkwJhHocfTUEM1tt1P2OtTTKo/UmEuaPQbDGi5KFEJGFRjOsEyQIbxXwGYjX/9kKmKOLZvIN+mIxrFN8QRSQC1OkEx1MNRehEBY5CeLOpTsG1Eaj+OVmePwtlLTK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjy4jRaESSQJ1Vu13iE+z8pHaz7BVJXEhKKhVcvR2/w=;
 b=BhhHeABmyf8DF7GzInAICjPcRR53SEBj/kWONXHRyuKyA9ey95YASoaYqbOT2m1EBx+G8RhE+GSvGBjgmXNthQ5eHla00U0Dp7oPFOklFE3O8uF5D09RC7hc+/6ictprqpF4kOQtvYHWRoUf1PQtAiCPcbFfLUvUC2xd8u4rWV4=
Received: from MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 07:11:11 +0000
Received: from IA0PEPF0000003F.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::4e) by MN2PR06CA0028.outlook.office365.com
 (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:04 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:08:32 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 16/16] raw/ntb: fix queue leaks on setup
Date: Wed, 11 Nov 2026 12:36:50 +0530
Message-ID: <0afc4c17d346b1f195ced75c2670e47638ad6758.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003F:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 2656cf1f-87be-4471-71f4-08df3fc2f710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|4143699003|261102123227099003|56012099006|11063799006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|261022075727099003|261028144727099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: NPEIklSD21mg/DF2mzUu5U+VUnpZYTfhrqIi6HQN33HVo+lauoixxzySzga3VY7mLiO5Jc1/GoVAyWlb+nf45BrmD2yA7M26uxsse4dbbao/dnrsXXkT2XJEhQ9D1q0M0DEONDtB9iieK+FHTHkAhSkmDkZSBU7KFZLpBtKDr/SnhPsPDH0pLmhIHIy187jZcFXMs6PW9By0c4gGHYbsdd8txaTngqvJ+8GrLR266XIXwUZSHZslJLQehX/G4tYrnwAy0OUXNGspUlvYuaIwIz3q/xey7Wxsc6oFmYJdOLECCI4YP9OgoYcfisAlInvHjxMHeHCy1cgR7Dg43qrTpPVXzb8eoWedXJoenUWo4rz70s2nZCKphK9lcQpGLMDWK2l5+UzKqSP4khEGh/a4J2IveAOK/mIj2POe6Aie2X57eCY1pjEc2+daU3LxfOEWIEwlahxygICSjJI3OxjYrOpCx9uBWOgDz6dYdZVl9yXTDu3MgtftbIeyQtPI48mJozgS8oGNE09aidrWpNzRYg6C7Do9dJKid4X4FN+8dR+RUSafJs2sBkF0XGpMuh9kQdNPuVFgAX2XZL98zq775qJxbJbIp3aGntlm7TFqC0wtSSrxiyfxvRZPJELsye8GUBXPrrHF41GcTvvdq8KPihXl+wEMl2RXBjA/pz6oV4dEkZNkejpKuq9ZNToVePikOyfKwp0LJRLSuuQN2ZZrIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(4143699003)(261102123227099003)(56012099006)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ODsrsbBAajJ7o0rjp15WaG1LOAUK/0oxrPD6zu2zKFStbJXq+jizk27U7XSi76EC7hjaY1G8cIdDsbALfS0GqhoyeNHPXhOKXXjJQAqHprGO4qtfwiFChhFPXHER/REbJnm+GqWsp0jAWgNikJ+wRTTJ/cN5ttgxD4jSi0z8WMH+sFQHeeW/P7WBS8mcIQZWeJc+Jdy+uQ1F79h7oWukRAJBk1zyKxSdBNc3dSL1XvrMx8eR+MvEnGKsVZzeM2UO21jrbN5DcMDbr+CY4hWMq3L/KgyxUzzQjIeNgl4nz2rvgn5qns3/Vv/lUtkjX7WTpDh2CjvvCEZpg4fcuc4FAnG4erMm9TDnw1lmF0L3AXQA7JKSPurWGaKXQIshfA/isAjLbangE+hV3+ik3ZzhK53mh0ixa2fpexu969Vh9bVNAgAYLXy/P4T0FW40R/Pw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:11.0711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2656cf1f-87be-4471-71f4-08df3fc2f710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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

The Tx queue was set up first and left in place when the Rx queue
setup failed. A new setup of the same queue pair, either a retry after
such a failure or a reconfiguration, then overwrote the previous queue
pointers without freeing them.

Check the shared configuration before setting up any queue, release
the queues of a previous setup, and release the Tx queue if the Rx
queue setup fails. As the previous queues are released, refuse the
setup while the device is started.

Fixes: c39d1e082a4b ("raw/ntb: setup queues")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 64 +++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 8b1c332fbb..68137c4237 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -235,10 +235,8 @@ ntb_rxq_release_mbufs(struct ntb_rx_queue *q)
 static void
 ntb_rxq_release(struct ntb_rx_queue *rxq)
 {
-	if (!rxq) {
-		NTB_LOG(ERR, "Pointer to rxq is NULL");
+	if (!rxq)
 		return;
-	}
 
 	ntb_rxq_release_mbufs(rxq);
 
@@ -273,11 +271,6 @@ ntb_rxq_setup(struct rte_rawdev *dev,
 	if (conf_size != sizeof(*rxq_conf))
 		return -EINVAL;
 
-	if (rxq_conf->rx_mp == NULL) {
-		NTB_LOG(ERR, "Invalid null mempool pointer.");
-		return -EINVAL;
-	}
-
 	if (ntb_queue_nb_desc_check(rxq_conf->nb_desc) < 0)
 		return -EINVAL;
 
@@ -338,10 +331,8 @@ ntb_txq_release_mbufs(struct ntb_tx_queue *q)
 static void
 ntb_txq_release(struct ntb_tx_queue *txq)
 {
-	if (!txq) {
-		NTB_LOG(ERR, "Pointer to txq is NULL");
+	if (!txq)
 		return;
-	}
 
 	ntb_txq_release_mbufs(txq);
 
@@ -422,43 +413,62 @@ ntb_txq_setup(struct rte_rawdev *dev,
 }
 
 
+static int
+ntb_queue_release(struct rte_rawdev *dev, uint16_t queue_id)
+{
+	struct ntb_hw *hw = dev->dev_private;
+
+	if (queue_id >= hw->queue_pairs)
+		return -EINVAL;
+
+	ntb_txq_release(hw->tx_queues[queue_id]);
+	hw->tx_queues[queue_id] = NULL;
+	ntb_rxq_release(hw->rx_queues[queue_id]);
+	hw->rx_queues[queue_id] = NULL;
+
+	return 0;
+}
+
 static int
 ntb_queue_setup(struct rte_rawdev *dev,
 		uint16_t queue_id,
 		rte_rawdev_obj_t queue_conf,
 		size_t conf_size)
 {
+	struct ntb_queue_conf *conf = queue_conf;
 	struct ntb_hw *hw = dev->dev_private;
 	int ret;
 
 	if (queue_id >= hw->queue_pairs)
 		return -EINVAL;
 
+	if (conf == NULL || conf_size != sizeof(*conf))
+		return -EINVAL;
+
+	if (conf->rx_mp == NULL) {
+		NTB_LOG(ERR, "Invalid null mempool pointer.");
+		return -EINVAL;
+	}
+
+	if (dev->started) {
+		NTB_LOG(ERR, "Cannot setup queue %u of a started device.", queue_id);
+		return -EBUSY;
+	}
+
+	/* Release the queues of a previous setup. */
+	ntb_queue_release(dev, queue_id);
+
 	ret = ntb_txq_setup(dev, queue_id, queue_conf, conf_size);
 	if (ret < 0)
 		return ret;
 
 	ret = ntb_rxq_setup(dev, queue_id, queue_conf, conf_size);
+	if (ret < 0)
+		ntb_queue_release(dev, queue_id);
 
 	return ret;
 }
 
-static int
-ntb_queue_release(struct rte_rawdev *dev, uint16_t queue_id)
-{
-	struct ntb_hw *hw = dev->dev_private;
-
-	if (queue_id >= hw->queue_pairs)
-		return -EINVAL;
-
-	ntb_txq_release(hw->tx_queues[queue_id]);
-	hw->tx_queues[queue_id] = NULL;
-	ntb_rxq_release(hw->rx_queues[queue_id]);
-	hw->rx_queues[queue_id] = NULL;
-
-	return 0;
-}
-
 static uint16_t
 ntb_queue_count(struct rte_rawdev *dev)
 {
-- 
2.34.1

