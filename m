Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A497606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=azQQOio+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5967F410FC;
	Wed, 11 Nov 2026 08:11:20 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 12A844026D;
 Wed, 11 Nov 2026 08:11:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKkJXAoO3lGp/cDqnXMXwRVZQsdklhRSsUtQx85Z0bzdH3UjhsgCfslcd2L3CvMNu+AK6ycBjtdAgwWAWjB3andcCTejdZhAJoLAnWMjSsNYlWTeD5sTbNfCSujEEypfivF08SZuDWxj2fEJiRcP4jzdUuCHTqcfqD5W3VZRO3tEcJwkgXy6SSFfyk0xC2uw3D+iSV+8Pi23pu35jX4hVt6cpRFmSs3CYL69XO7fzBVOoR/4IWcIbmsoe40/oy/2Np5zlR1AvZlee0fZIr2lhf+nceQ225YROIOUO18IXfhUnutY7dhaBlvddugpE3cKpKhRU6RqCENfy/SuK8xneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIpi7ecqbO7vu6UrGQ1bs83khK59017WuRTn2WZsEgk=;
 b=BvRigXFuCzcsYRI1UvBkYhMqoRQeMUz1d7UbYSz3s/4yVDy78NobwbnKsPtMTgMPIIvJ4I11hOQKCqMD35HKgkk3DHrp4H84es8dryGC60eXYc8TAlpI9uxGgc/AuwKo2YQIudO3Jf8DjFwEGDk3FH1SKZ/ZZ0q3aGgOUs2eM0Cb9WkMQVrvykHhfqTP+GuvmQcBV1v6abmtfx+Z/jvY93i+BHc/yDcZclF+iQhZgys6NaanXu1wd6ZYT4IdW4/lJita7j2mKTqfI7m09WuR/P1xit62TWZsyeiJG3ZhRPnXsguqIqUUexUiQah/4ZHnNVJJNhK4JGyhY7qCNDifLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIpi7ecqbO7vu6UrGQ1bs83khK59017WuRTn2WZsEgk=;
 b=azQQOio+7s5qIeeATsjzO/m5rP2RGwwupSXEdQM6VFBM6RJsrgbe4Hnyv3f8m7feOs61n8EbKX7Xanma1MSKzMyQ64DNaZ/71zHrKCOg+GWrwj27AYg184yhtYnhDb4lazWjPczWUAc07U7rrzpo0bgivPi9TCr0OZ5r1gkLEAA=
Received: from CH2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:59::20)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 07:11:07 +0000
Received: from BL2PEPF000352D5.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::19) by CH2PR03CA0010.outlook.office365.com
 (2603:10b6:610:59::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D5.mail.protection.outlook.com (10.167.254.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:04 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:08:27 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 14/16] raw/ntb: fix peer device status access
Date: Wed, 11 Nov 2026 12:36:48 +0530
Message-ID: <174f4202836f82b166f9b718df421d9d7bb94b29.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D5:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e46d193-89a8-4b52-d6e1-08df3fc2f4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|261102123227099003|4143699003|11063799006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|56012099006|261026121527099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: jNBU271kwDrkciTPbc7/JTwhyg/FnQikkSDB66T79gsaiDV3ORTr8PTQoDSz3zjrCsfdbSgBICEsyy2kCyIvb8mmVPuHE+UMwe9VHlN0e5qEIglOqdiRWCzRXVOr4yJwB5VMf+gmiV7ZPdgxkMqUwHC2el65P/WBO6R3tzbrkWrmEm01SDaJE/+ROS0nqtnmReGDW+VwkFh+FxZc3aNyTzDTFLAeIIr2Ac3ENsJ9X5IIhdPjxb/OOV2gZvZWLNHeJTr4v+1/gBqodgmzS4IfyZM01Ma86IMMCKW/mGxqX8Mf4wt3n01BJv/7VTOeHLSNUFZZ/mIxSYU0xHdaW6T82v13iJvewDqJjw7W9paRn6raKS/EiXTs6V7wsyJ9I0P2eheuUYH0DOFbfibfs6G9btaz2LnBKB0eC9XdbK243N4TesuGXJuhLyehZBHfQLHSYbvdy0mym99fWkJXA9QVicBNfNBop1Sa8BMEn5E3dLmECE8nPthMGesOgzFesQHxfnn/2Wwk0Tepjl0+IJrAN2DOOxNu/tOU54avo9r6pNrUChxefUD4IRsfr2dNZ5y/dd/63sl2LuSjDCFusZX3CdufZMlnFouHq5jG5wqfcNrSD3PUdrjGl2b14ravMUk4STMJ3juPbFueePWU8ZPAniV5XAnLRiViUwbgMgQkzFsKtVf9yNH1oupUFABtqD9Cs/0pzzPiVRufzjdPPImE4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(261102123227099003)(4143699003)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(56012099006)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r7XURJ3dvDBKcOkyBoXzKG8D5vTBMObMSAV5bX/apLrdc3aBbpjKGuIoY/iXuU4xTA8ACN+h9hL2EBBhn95wHEL7X0YSp86apGLM/1wmroYyVJ2dy0DcB29qPYsZ6XOXxx0gVjWpt/5eXmlEZOMBCFx+rhL2rANNqki9jTSv7O4uC4asm/MzpfqzMU0AL9ryCa/FXR03HSvamc2uEa5JneSsevOq42jq/xCuHIYOXKEl988NbeUes+YOB5BsbYbw2Ul4JA6wJzzrkSuPPn9K7KIRX7gtJ9y7lHYVGxdEtctPXT8U5l7mTcvn25LDEgPR3ZUd5hFmgrRD9gpGX4vfUoFVsQqcw9l2N/ggqEH8aRPJaERRRYqQkzD+CQHy7zbs9OqQYqmYcTrIw0Zo4GkI7vExbv8NgtcSQGro49ePoUeqULgkdXUQSVnowOTmPNis
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:07.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e46d193-89a8-4b52-d6e1-08df3fc2f4eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

The peer device status is written by the interrupt thread when the
peer doorbells are handled, and read by the control and data paths;
in particular, device stop polls it while waiting for the peer to
acknowledge. Plain accesses do not guarantee that this update is seen,
the stop loop only works because the delay call is opaque to the
compiler.

Use atomic accesses with release/acquire ordering.

Fixes: 62012a76811e ("raw/ntb: add handshake process")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 28 +++++++++++++++++-----------
 drivers/raw/ntb/ntb.h |  5 ++++-
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 5b3abcb008..86405ad57a 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -48,6 +48,12 @@ static struct rte_rawdev_xstats_name ntb_xstats_names[] = {
 };
 #define NTB_XSTATS_NUM RTE_DIM(ntb_xstats_names)
 
+static inline bool
+ntb_peer_dev_is_up(struct ntb_hw *hw)
+{
+	return rte_atomic_load_explicit(&hw->peer_dev_up, rte_memory_order_acquire) != 0;
+}
+
 static void
 ntb_dev_intr_handler(void *param)
 {
@@ -69,14 +75,14 @@ ntb_dev_intr_handler(void *param)
 		 * Peer dev is already up. All mw settings are already done.
 		 * Skip them.
 		 */
-		if (hw->peer_dev_up)
+		if (ntb_peer_dev_is_up(hw))
 			return;
 
 		/* Check that the peer memory-window layout matches local. */
 		if ((*hw->ntb_ops->peer_mw_validate)(dev) < 0)
 			return;
 
-		hw->peer_dev_up = 1;
+		rte_atomic_store_explicit(&hw->peer_dev_up, 1, rte_memory_order_release);
 
 		/**
 		 * Handshake with peer. Scratchpad and translation programming
@@ -104,7 +110,7 @@ ntb_dev_intr_handler(void *param)
 		/* Peer device will be down, So clean local side too. */
 		(*hw->ntb_ops->link_cleanup)(dev);
 
-		hw->peer_dev_up = 0;
+		rte_atomic_store_explicit(&hw->peer_dev_up, 0, rte_memory_order_release);
 		/* Response peer's dev_stop request. */
 		(*hw->ntb_ops->peer_db_set)(dev, 2);
 		return;
@@ -114,7 +120,7 @@ ntb_dev_intr_handler(void *param)
 		NTB_LOG(INFO, "DB2: Peer device agrees dev to be down.");
 		/* Clear received doorbell. */
 		(*hw->ntb_ops->db_clear)(dev, (1 << 2));
-		hw->peer_dev_up = 0;
+		rte_atomic_store_explicit(&hw->peer_dev_up, 0, rte_memory_order_release);
 		return;
 	}
 
@@ -549,7 +555,7 @@ ntb_enqueue_bufs(struct rte_rawdev *dev,
 	void *buf_addr;
 	int i;
 
-	if (unlikely(dev->started == 0 || hw->peer_dev_up == 0)) {
+	if (unlikely(dev->started == 0 || !ntb_peer_dev_is_up(hw))) {
 		NTB_LOG(DEBUG, "Link is not up.");
 		return nb_tx;
 	}
@@ -660,7 +666,7 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 	uint16_t off, last_avail, used_cnt, used_nb, nb_segs;
 	int i;
 
-	if (unlikely(dev->started == 0 || hw->peer_dev_up == 0)) {
+	if (unlikely(dev->started == 0 || !ntb_peer_dev_is_up(hw))) {
 		NTB_LOG(DEBUG, "Link is not up");
 		return nb_rx;
 	}
@@ -853,7 +859,7 @@ ntb_dev_start(struct rte_rawdev *dev)
 	uint32_t i;
 	int ret;
 
-	if (!hw->link_status || !hw->peer_dev_up)
+	if (!hw->link_status || !ntb_peer_dev_is_up(hw))
 		return -EINVAL;
 
 	/* Set total stats. */
@@ -907,7 +913,7 @@ ntb_dev_stop(struct rte_rawdev *dev)
 	uint32_t time_out;
 	int status, i;
 
-	if (!hw->peer_dev_up)
+	if (!ntb_peer_dev_is_up(hw))
 		goto clean;
 
 	(*hw->ntb_ops->link_cleanup)(dev);
@@ -926,7 +932,7 @@ ntb_dev_stop(struct rte_rawdev *dev)
 	time_out = 1000000;
 
 	/* Wait for cleanup work down before db mask clear. */
-	while (hw->peer_dev_up && time_out) {
+	while (ntb_peer_dev_is_up(hw) && time_out) {
 		time_out -= 10;
 		rte_delay_us(10);
 	}
@@ -1061,7 +1067,7 @@ ntb_attr_get(struct rte_rawdev *dev, const char *attr_name,
 
 	if (!strncmp(attr_name, NTB_LINK_STATUS_NAME, NTB_ATTR_NAME_LEN)) {
 		/* hw->link_status only indicates hw link status. */
-		*attr_value = hw->link_status && hw->peer_dev_up;
+		*attr_value = hw->link_status && ntb_peer_dev_is_up(hw);
 		NTB_LOG(DEBUG, "Attribute (%s) Value (%" PRIu64 ")",
 			attr_name, *attr_value);
 		return 0;
@@ -1325,7 +1331,7 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	int ret, i;
 
 	hw->pci_dev = pci_dev;
-	hw->peer_dev_up = 0;
+	rte_atomic_store_explicit(&hw->peer_dev_up, 0, rte_memory_order_release);
 	hw->link_status = NTB_LINK_DOWN;
 	hw->link_speed = NTB_SPEED_NONE;
 	hw->link_width = NTB_WIDTH_NONE;
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index f9f5bceede..6dce038e0b 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -7,6 +7,8 @@
 
 #include <stdbool.h>
 
+#include <rte_stdatomic.h>
+
 extern int ntb_logtype;
 #define RTE_LOGTYPE_NTB ntb_logtype
 
@@ -223,7 +225,8 @@ struct ntb_hw {
 	struct rte_intr_handle **db_intr_handles;
 	uint16_t nb_db_intr_handles;
 
-	uint8_t peer_dev_up;
+	/* Written by the interrupt thread, read by control and data paths. */
+	RTE_ATOMIC(uint8_t) peer_dev_up;
 	uint64_t mw_size[NTB_MAX_MW];
 	/* remote mem base addr */
 	uint64_t *peer_mw_base;
-- 
2.34.1

