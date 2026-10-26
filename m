Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C949606A324
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LsAGudLI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29AB3402E4;
	Mon, 26 Oct 2026 09:55:51 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25]) by mails.dpdk.org (Postfix) with ESMTPS id A6DDF40150
 for <dev@dpdk.org>; Mon, 26 Oct 2026 09:55:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aotJN5foceK5+Ke7UBGieHuI/5YrQUjdSgrOACIS+GnK8Vwm9WLmHmvdxMbEn4nhBd/7/Kmyr+yvUgljO92/QeEC/amOey2rtiGVrolxGhORCo+LqjIUoQJltNU+MMVK+GL+jMie8xK1COlxpN2l1xym3oMKuyTeU5SD8cPXKCrw6sgm3bmAwVhdlxb9DZfCCgKpvW6Em+YqlTJbPwwBquccpABdbU39GD5MqLuRe44hskVCeA43UPx4Kb2yDMpXPq/VjxwmtJre+ut19MQIEy8HpDdDZhBLtlv6F1SISYAnmDZB6pXaTzkO7I2EZNAIHWanLRhAvhyulRSk7eVn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxrmdeYxS212De3+zrVTVJDAsJDZNVYyJ4mgh5wPRc0=;
 b=JOMSOYuYsq3vfC7UhdDrQJSeMHzZ9WHdF13eDan7du3P86WcZ2NCFnGKc/D/FpeONWIfEt4rJS6Bb8jQHybd1f1ggr045sFeeDNFZz6O7yB5wFXHCT4sc74ujDR69sQ3YkRmdabXJROHc8Z7LW7BRhgp03El7zIv8L3QazLfYK2MExzX3/TENjSYwRC5kqpPZ5P3mYvZFIg0eXmmQR7SHdDXB58DjSCKbjt2pS8JkI3/n0CTp89D0rs1O4qnBDuDC0k6enNWxq5rkQmUtY5tzSKZU77RsbVfDf4xtNKod0483W/6ggVzwUhbD81gGdgKMY0efPVFqlTJIBI/ZSdKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxrmdeYxS212De3+zrVTVJDAsJDZNVYyJ4mgh5wPRc0=;
 b=LsAGudLIfy1MrVi+kYeAa8cjsbeCf7VtCXNEj0a6d47nar5P2RMUE+6HL/SLMtPeddxPJ6ZayC3C25mG1IiH8HIvD1Eu1+8HszdXMWBcatWGdGoA5PwSqF13J/BeAM1lzDrZ1yCeqc5joaRhwZ7BO6yq/BhYC28OWMiAjpXHtEk=
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by PH9PR12MB252631.namprd12.prod.outlook.com (2603:10b6:510:42d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:55:43 +0000
Received: from CO1PEPF00018862.namprd02.prod.outlook.com (2603:10b6:303:b5::4)
 by MW4PR03CA0278.outlook.office365.com (2603:10b6:303:b5::13) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22
 via Frontend Transport; Mon, 26 Oct 2026 08:55:43 +0000
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
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:55:42 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:55:39 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v4 1/3] raw/ntb: validate vendor ops at probe
Date: Mon, 26 Oct 2026 14:25:13 +0530
Message-ID: <20261026085515.3238805-2-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00018862:EE_|PH9PR12MB252631:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8d2d90-cc67-4388-4988-08df333eea9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lstMFayzh3CjIPn++8d+h0b4CjUlvB4Q3kWGfEU+xl8yCyzWqB6e/WStsIYCELAREAUKOi51ne+GqyHXK2Zk/fjT/xvIp5JnZf5TZeNsKaFvhzk+b8QEw6mP5cmuqCU47oy8t/p1Yh3DxV2OmZ0WFwvJJ+OSEwqAGnAJApjS3jvF3ESHUevedzLNbb4kKSrT5fEHV5kVgqGktGkZ2mYXeF36kglytmBSREmcugC/khMp15iEJqlefJL8Q+4eeJFiyFp0Yg8s3NMfickmPwmf9kGFFzBDXC0/FPOGKckmhmXKdP1si8DJx4jxHjRb7lcd84nScA/aYXxXwHm9ZnYt1JpMe3yTeSCJcDrEisnPxQc588hqh9oenaS8A+FqzqOrTXJhgm1+WmNYe6fnteQLGnTXykYpgPOOiAVcq6dnHIuAhGw32R0rdNZGhxCyfuv6JM0niRcj7vw4zEyinhrGYvUD1+GBOZlR0Wo1XSaIywGoLyYGgokzrwwjpyYavB0P8zew+MAWb06MrCzeUvdEvBuseu5hqBD3lyudPqWA5Ppy5mkbG/cjbVAyojY+0ZeGCdA90yGEAJJCgfAxh8ni4+XIbK8OCrV2oX3DT2lSfNLRPEWMlhrDGyp2QWquBDnFrz28HSViL8cEVo1F171f3neLybt1yCO4SnicwRKF05Vc5qu67/zaWai9do+cEpycWEUnEtO35OeyFsc/VI4Nuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: liSYP7BvG1ad3uYSsX2oILTJSALxLHTBAv02MCuvl2rc/AyL3rfzlH4R5HbeGEQ24zbvpkROP3k3bVfR8GufHv8v4vHS8gmt86b6LoLTIkwX8lTgRRnFDu9EJO97qnP4xVUCBhiL1OUoKsHtG6JkMksBLixRtp09npboNOPjXf6u6plWVUMW/oLWFgvNOd9MDOte8jPLMn/qhxoffWOeMhXiU038cGL4YOD0yC8BbbRmKveV6SIaLUrf+3WvfpbDdiVlueShdJCA21DTFjjQJsUIqFAB/rqSnCrYaHr29Rg28yKLcpbwEdYU/3DDu8qXh9yLKvvGhBYZdA5GtZo7MCZFxG5uFhNSRkE1t07PXhRgH/PFG1u4TjlJx3ulG1ZlybC0ZUvVrhHsP/e4teqijLLlR+B+NLlLmwgZzM5z2KQ8JTCbzxGH7Mc2lFgoxkSI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:55:42.5645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8d2d90-cc67-4388-4988-08df333eea9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018862.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB252631
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

The NTB driver dereferences the vendor ntb_ops hooks unconditionally
throughout the common code, yet also guards many of those calls with
runtime NULL checks. Those checks can never fire for a correctly
populated vendor ops table and only make the code harder to follow.

Validate the mandatory ops once, right after the vendor ops table is
selected at probe time, and drop the scattered per-call NULL checks.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 103 ++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 68 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index d54f2fb783..09cf325c9a 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -46,12 +46,6 @@ ntb_link_cleanup(struct rte_rawdev *dev)
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
@@ -74,12 +68,6 @@ ntb_handshake_work(const struct rte_rawdev *dev)
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
@@ -150,13 +138,6 @@ ntb_dev_intr_handler(void *param)
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
@@ -174,11 +155,6 @@ ntb_dev_intr_handler(void *param)
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
@@ -214,10 +190,6 @@ ntb_dev_intr_handler(void *param)
 		}
 
 		/* To get the link info. */
-		if (hw->ntb_ops->get_link_status == NULL) {
-			NTB_LOG(ERR, "Not supported to get link status.");
-			return;
-		}
 		(*hw->ntb_ops->get_link_status)(dev);
 		NTB_LOG(INFO, "Link is up. Link speed: %u. Link width: %u",
 			hw->link_speed, hw->link_width);
@@ -511,11 +483,6 @@ ntb_queue_init(struct rte_rawdev *dev, uint16_t qp_id)
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
@@ -615,11 +582,6 @@ ntb_enqueue_bufs(struct rte_rawdev *dev,
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
@@ -929,11 +891,6 @@ ntb_dev_start(struct rte_rawdev *dev)
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
@@ -988,10 +945,6 @@ ntb_dev_stop(struct rte_rawdev *dev)
 	ntb_link_cleanup(dev);
 
 	/* Notify the peer that device will be down. */
-	if (hw->ntb_ops->peer_db_set == NULL) {
-		NTB_LOG(ERR, "Peer doorbell setting is not supported.");
-		return;
-	}
 	status = (*hw->ntb_ops->peer_db_set)(dev, 1);
 	if (status) {
 		NTB_LOG(ERR, "Failed to tell peer device is down.");
@@ -1012,10 +965,6 @@ ntb_dev_stop(struct rte_rawdev *dev)
 
 clean:
 	/* Clear doorbells mask. */
-	if (hw->ntb_ops->db_set_mask == NULL) {
-		NTB_LOG(ERR, "Doorbell mask setting is not supported.");
-		return;
-	}
 	status = (*hw->ntb_ops->db_set_mask)(dev,
 				(((uint64_t)1 << hw->db_cnt) - 1));
 	if (status)
@@ -1084,8 +1033,6 @@ ntb_attr_set(struct rte_rawdev *dev, const char *attr_name,
 	hw = dev->dev_private;
 
 	if (!strncmp(attr_name, NTB_SPAD_USER, NTB_SPAD_USER_LEN)) {
-		if (hw->ntb_ops->spad_write == NULL)
-			return -ENOTSUP;
 		index = atoi(&attr_name[NTB_SPAD_USER_LEN]);
 		if (index < 0 || index >= NTB_SPAD_USER_MAX_NUM) {
 			NTB_LOG(ERR, "Invalid attribute (%s)", attr_name);
@@ -1182,8 +1129,6 @@ ntb_attr_get(struct rte_rawdev *dev, const char *attr_name,
 	}
 
 	if (!strncmp(attr_name, NTB_SPAD_USER, NTB_SPAD_USER_LEN)) {
-		if (hw->ntb_ops->spad_read == NULL)
-			return -ENOTSUP;
 		index = atoi(&attr_name[NTB_SPAD_USER_LEN]);
 		if (index < 0 || index >= NTB_SPAD_USER_MAX_NUM) {
 			NTB_LOG(ERR, "Attribute (%s) out of range", attr_name);
@@ -1364,6 +1309,37 @@ static const struct rte_rawdev_ops ntb_ops = {
 	.xstats_reset         = ntb_xstats_reset,
 };
 
+/* Every vendor ops entry is dereferenced unconditionally in the common
+ * code, so enforce their presence once at probe time instead of guarding
+ * every call site at runtime.
+ */
+static int
+ntb_vendor_ops_check(const struct ntb_hw *hw)
+{
+#define NTB_OPS_REQ(member) do { \
+	if (hw->ntb_ops->member == NULL) { \
+		NTB_LOG(ERR, "Vendor ops lacks mandatory ." #member); \
+		return -EINVAL; \
+	} \
+} while (0)
+	NTB_OPS_REQ(ntb_dev_init);
+	NTB_OPS_REQ(get_peer_mw_addr);
+	NTB_OPS_REQ(mw_set_trans);
+	NTB_OPS_REQ(ioremap);
+	NTB_OPS_REQ(get_link_status);
+	NTB_OPS_REQ(set_link);
+	NTB_OPS_REQ(spad_read);
+	NTB_OPS_REQ(spad_write);
+	NTB_OPS_REQ(db_read);
+	NTB_OPS_REQ(db_clear);
+	NTB_OPS_REQ(db_set_mask);
+	NTB_OPS_REQ(peer_db_set);
+	NTB_OPS_REQ(vector_bind);
+#undef NTB_OPS_REQ
+
+	return 0;
+}
+
 static int
 ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 {
@@ -1387,16 +1363,16 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
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
@@ -1404,8 +1380,6 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	/* Init doorbell. */
 	hw->db_valid_mask = RTE_LEN2MASK(hw->db_cnt, uint64_t);
 	/* Clear all valid doorbell bits before registering intr handler */
-	if (hw->ntb_ops->db_clear == NULL)
-		return -ENOTSUP;
 	(*hw->ntb_ops->db_clear)(dev, hw->db_valid_mask);
 
 	intr_handle = pci_dev->intr_handle;
@@ -1423,19 +1397,12 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
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

