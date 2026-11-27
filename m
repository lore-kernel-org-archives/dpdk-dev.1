Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913A606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PFTbSktM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30086402B2;
	Fri, 27 Nov 2026 10:12:38 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by mails.dpdk.org (Postfix) with ESMTPS id 187AA40291;
 Fri, 27 Nov 2026 10:12:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz2aL2+PRZ1486JI0Bxad3D8OyXcV6VyVsmDg5vXItA7hVAJqNEU67qvtx4lMTI+J9pF0vSbFvuNlQ7c/5UQrgK4hlfiCQQ4A0bQgmVhDnmsJQWi2RgG8zuQdQVVRFyzCgCO9CLKIIwVgdS2WkQLt1hzNq7ue1TPZie90cW9f8tjKwOtcgNoyBqQc2oDTsOxnWJmizcLUflHgFlXUnjkjsIPAu+2o0M4OzB558H+0J+EMfrVPZCftYIgRRfGnpdfGDa1BeQzbBpRGmkv6SUEGzzURIfWdSXkhifK0QrEmMhoRSk8RBcgdmN2fxNUV2OG0ixCnWAbeMpOkpGfB7D66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4145aw3CSRfiILyyitGz/KNitBq6MuDmxABBDgcoNk=;
 b=xpcpR7pPa4MuuW+y72/WBz6q6anw5dWEw9kUmolljTzqUgBmuFcYGDtxJMAwt9v5I4S83h5E85gV3kQVaWFTAXoAgjwi37PaVfvDB9rMBJ43VeTaod+V6FyTzsukhywRssk1AUT6ugH1BEOr//atcsJBMVM5DpSKsWJqIRGefQhZBsRkP39RaJP5rlZFhFmKcD/kwz/D5quJT00qN0buebA3UPXS7bNN1eXB0fnmUwvnKAUeECQR4msuf2BRLkTbW2JDaJE5xm+eFjorXYiWmFJequcDoKfT5LsGk1NaUmVWm2DwckAEBgZ4YWhTUFek4a2k93ZKnZu7mBDiG/0G5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4145aw3CSRfiILyyitGz/KNitBq6MuDmxABBDgcoNk=;
 b=PFTbSktMPhk2DOoSGMaSzq/LkdD0fzc3VrLuh+cw7x+hViLNl0rk0EEL7Ybc0XnK2LAWK1MBfSMDAq1JX8xRpwrqe5HZhF00n0gS2BvqaPh7PPhChtl5tU2LMZruckk1XgMSANlic7YspzsJ1Sa4/qDvWamsByIAVWIAk5rJDmcuAwKVKABrF+sQrX1zPlJHX4zdm99CnlXxjI8Qtp3V7v9hnY5GOHoGJzvGheTV2dxKb8+vI24kWCYXLWNwWEzLcHRyCdjx/kqOgnlPIEk8KiXE8vNLKyoRJylUh+d0rjSVoqFge/MgOkfOlk5/CDXAJNOuYZBV40Cu9C4eK6iRqw==
Received: from CH2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:610:51::36)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 09:12:30 +0000
Received: from CH2PEPF000166C8.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::4d) by CH2PR15CA0026.outlook.office365.com
 (2603:10b6:610:51::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 09:12:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000166C8.mail.protection.outlook.com (10.167.244.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 09:12:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 01:12:16 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 01:12:13 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: [PATCH] net/mlx5: fix unreachable code warnings
Date: Fri, 27 Nov 2026 10:11:22 +0100
Message-ID: <20261127091134.1354021-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C8:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c57c52-a917-40cd-44b9-08df4c668ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|10067099003|56012099006|11063799006|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: xuqIbflY8mXVjd0AbGuwHud2IOyx+rrL9HXp4d3sp3YdcAiRJuicFOS8FLMobPm+wx8rRgdzpa4jQ15h73S7HA6IwpsJ7XGjI/x1dUT4VObEuFMJn8dJ3ZgQNo71R4ODxnY1eoLjACxNfdjdnBuOL3FdiUJRpUxqcx3IqgdGmxEknKqjHB4MmwHCfXjD6JV332c8KJMUjDSkYtmfgD/LlXJXRgZBv9fQo7eNWgBpdk16m3iU9teM0EMsKSbaafSA6+nGlJOs1fzlfvI3/WUswM3smS4kGyJx9I5X1N47G55r5cyFB1nJUTcMMhggKjB5Ix0wLhcX+EfHQLrhNaOLx+4w3b7xYbQDmI4h93c7aDyNhg1ygQNpX7soVniGl9IAegSA99S4kzia5VfIgaNN14HJEophuZQTp+yQ1kehzXJEutC+HeDF6FVi+5dqtpQ/7LdCJdR0+NHt+9UIdPiT+knrI/Z6eAwGyE1XZzL6YscYVFT+qnkJK09gPyD3TLFPA7DozELDFup+6pvvQ6dNKLi8L26LmxwnuM5gGSZ1dbRaOJbs9zt3LnvGJdzShwBCN6knHnJKuhzqtWP1zYf0VfZ2PG+uo/NFzJpqCbOLxcQErJzTxgjVFmcceDIwV8YZZl6f/EEzBklQ0igER2FgudP2hRyxuVpjlpK0OWASCsNkMlUvDMznuS9WJ05OkVTmbzR3OPw/rYrKnypbBaBNUA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5ZR8bhNit1PYqqdj5vXxazbkwDiRbBWfwvgcZkkobvMEs5xMO9EZ3oHitng9qNl/5Pkcv6PcUL3uMHZY12PKKBIoyZxsJOrKTRtOfD8ZZIe3+lpkBKqeOmoxBPG+oNqLfZ8R7HqFN+wzn0Say5D2DtEbQoTMWk//l9znY7ktnCHRGy91XSTWokZxREG0MtsGCsGDrPo3bmxB1ntl4XlnqN0j0YGjfW/1LGb6jL44NyU8KGSOSNtOGzxZU4C7q0QkVVHkzR6fOwfOmIF8dftJq3NfRb4n4gY2YuhZhV3tjDiXLNwx47DbANp7SfadmP9sLlPEwWjmtK3zBdWWifLyq94lwAgVbojIPPwpyAX2SRH6qmhuIDjnIAtR84Gv2cqHbxExCbMXirg8JcmhuBmbmQPMadXchUcftfwIfB0BNTegRUC0DH8rAP9eYpklVUr8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:12:29.4327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c57c52-a917-40cd-44b9-08df4c668ffa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510
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

Building with clang and -Wunreachable-code produces warnings:

- In flow_verbs_discover_priorities()
    - With recent rdma-core versions, a condition is skipped
      because of goto statement under ifdefs for new version.
- In flow_hw_validate_rule_pattern() and
  flow_hw_validate_rule_actions()
    - On variable declarations inside switch at the beginning of
      switch blocks.

This patch silences these warnings.
First issue is resolved by reorganizing ifdef guards
to remove the need for goto.
Second issue is resolved by moving variable declarations
out of the switch block.

Bugzilla ID: 2140
Fixes: 1d47e9335e2f ("net/mlx5: improve Verbs flow priority discovery")
Fixes: 57c7b94301ee ("net/mlx5: add async flow operation validation")
Fixes: 179e70fd7ad2 ("net/mlx5: fix connection tracking state item validation")
Cc: xuemingl@nvidia.com
Cc: 14pwcse1224@uetpeshawar.edu.pk
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c    | 17 ++++++++---------
 drivers/net/mlx5/mlx5_flow_verbs.c | 11 +++++++----
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6e6bf07799..62482c911d 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -17351,6 +17351,11 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 		pt_item++;
 
 	for (; pt_item->type != RTE_FLOW_ITEM_TYPE_END; pt_item++, items++) {
+		const struct rte_flow_item_ethdev *ethdev;
+		const struct rte_flow_item_tx_queue *tx_queue;
+		const struct rte_flow_item_conntrack *spec;
+		struct mlx5_txq_ctrl *txq;
+
 		if (pt_item->type != items->type)
 			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 						  items, "Item type does not match the template");
@@ -17375,11 +17380,6 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 						  items, "Item spec is required");
 
 		switch (items->type) {
-		const struct rte_flow_item_ethdev *ethdev;
-		const struct rte_flow_item_tx_queue *tx_queue;
-		const struct rte_flow_item_conntrack *spec;
-		struct mlx5_txq_ctrl *txq;
-
 		case RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT:
 			ethdev = items->spec;
 			if (flow_hw_validate_target_port_id(dev, ethdev->port_id)) {
@@ -17486,7 +17486,10 @@ flow_hw_validate_rule_actions(struct rte_eth_dev *dev,
 	 * Configuration of masked actions is ignored.
 	 */
 	LIST_FOREACH(act_data, &hw_acts->act_list, next) {
+		const struct rte_flow_action_modify_field *mf;
+		const struct rte_flow_action_ethdev *ethdev;
 		const struct rte_flow_action *user_action;
+		enum rte_flow_action_type expected_type;
 
 		user_action = &actions[act_data->action_src];
 
@@ -17507,10 +17510,6 @@ flow_hw_validate_rule_actions(struct rte_eth_dev *dev,
 						  "Action requires configuration");
 
 		switch ((int)user_action->type) {
-		enum rte_flow_action_type expected_type;
-		const struct rte_flow_action_ethdev *ethdev;
-		const struct rte_flow_action_modify_field *mf;
-
 		case RTE_FLOW_ACTION_TYPE_INDIRECT:
 			expected_type = act_data->indirect.expected_type;
 			if (!flow_hw_valid_indirect_action_type(user_action, expected_type))
diff --git a/drivers/net/mlx5/mlx5_flow_verbs.c b/drivers/net/mlx5/mlx5_flow_verbs.c
index eb576f73d4..c0c0da5833 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -85,10 +85,15 @@ flow_verbs_discover_priorities(struct rte_eth_dev *dev,
 	int priority = 0;
 
 #if defined(HAVE_MLX5DV_DR_DEVX_PORT) || defined(HAVE_MLX5DV_DR_DEVX_PORT_V35)
+	RTE_SET_USED(flow_attr);
+	RTE_SET_USED(flow);
+	RTE_SET_USED(drop);
+	RTE_SET_USED(i);
+	RTE_SET_USED(vprio);
+	RTE_SET_USED(vprio_n);
 	/* If DevX supported, driver must support 16 verbs flow priorities. */
 	priority = 16;
-	goto out;
-#endif
+#else
 	if (!drop->qp) {
 		rte_errno = ENOTSUP;
 		return -rte_errno;
@@ -101,8 +106,6 @@ flow_verbs_discover_priorities(struct rte_eth_dev *dev,
 		claim_zero(mlx5_glue->destroy_flow(flow));
 		priority = vprio[i];
 	}
-#if defined(HAVE_MLX5DV_DR_DEVX_PORT) || defined(HAVE_MLX5DV_DR_DEVX_PORT_V35)
-out:
 #endif
 	DRV_LOG(INFO, "port %u supported flow priorities:"
 		" 0-%d for ingress or egress root table,"
-- 
2.43.0

