Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50E3CD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 12:11:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1296840ED1;
	Sun, 16 Nov 2025 13:11:02 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by mails.dpdk.org (Postfix) with ESMTP id F2FB640648;
 Sun, 16 Nov 2025 13:10:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyHV3F3I8oKdxvYI3kisoqRvkL++LtNmImf+iUQ9nFIfSko5T0FSF3CdgAiWPa9O0X+JLEA7Vzs5ZU2svRvgCdnFI6ZDP7lH+2hStAKiFfnKrNVBDhgxelK76VgcRzUZq4JjrXv/46RuCNyLpw8l0vdYSq/DpXYRodx6jT60JbbiFvnyFW50X/dG0QW/M3wBSGa6xR/wYufZoL4/RewOiynJ8a3yru9MuKXPxnJFWdLyBKW7sbP90/Qe2xyxQ7tQwgqgJyQNYzaWLx3L/hCAyHyNdburxjb7JrV0EZgBiVlQJ4e/HU5PDLZoiycQjIjkqJvX7sBUwg+Z5b4SJDfxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Zwd2Dnx/UYnA8YmmWF2DzWIiTo9g22GnpSnmEi8a/w=;
 b=Vid2/nuh9iBH1UjsQYSkhoVYrxwetKEkTXySrhc+8koyrdK20A9JbiRWWyjO6QYKpspBw4SSntF0JnuYHL9fHW7sEvP35ErunoG2fpb2VpGnibwd2PYjxjxXuKWyBDZO3Rcl9hhDtb1aKl7VAvfaxHCiMhDd4mBleqizDCDAnWAfNfzGs+vy0WndiqtJSAsVId8ipycsOJooXJIR86h39ACz0ZHjJa34wh7Jw0FcQGEkKaTCmnsBhWQ5ko1AIKi0qjzggWBhdt+g0BI+0/ADiBucJLFyow4qFLZ5rfKhMe/ZcCVxWSB9wsY8xYmq77MsdTzvlven9ABRiegsUW03gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Zwd2Dnx/UYnA8YmmWF2DzWIiTo9g22GnpSnmEi8a/w=;
 b=A0JdlD87MUGqkh85jFHBaSj+5eU34GU52/a7dsUXToUmmiRStg8+idfHmXNPOE9yAdRbIhZXt+FzRierFDqxvGKVnh+a9NzMYpAbjk1BbAryphXq9m2+5AbvIrvgQccdWYAoGg2bYow1wQIhF1QxK+EMaXRPyrq4hj/CYQLG3VpDIz85NoGHTQNbCKFwKtGG7qc8a4ug8CQpNRdpTeNf6qmEjBLBzNQNBAjB87yLfMzNEF6DlBy3q5r90i/qF2vx+8Hq7XZZLsiNpWKHATjksEzGuhk5tacVKXOJXg4mmtm64B6/wVhIjCiM1erZ8W/DlkTsVbnpOIqvq8IxEFDxKg==
Received: from CH0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:610:b3::30)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sun, 16 Nov
 2025 12:10:54 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::6f) by CH0PR03CA0055.outlook.office365.com
 (2603:10b6:610:b3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Sun,
 16 Nov 2025 12:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 12:10:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 04:10:34 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 04:10:33 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 04:10:30 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Subject: [PATCH] net/mlx5: fix null dereference in modify header
Date: Sun, 16 Nov 2025 14:10:26 +0200
Message-ID: <20251116121026.180707-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a56ccb-0a36-45bc-eca3-08de2509311c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PtEyd0NTVFutDjhgCjvB8R1UZ27TLU4PMOM41o0uQRHlrFAPNqFWL6K5gcwx?=
 =?us-ascii?Q?m53YB+6l9M/5YpegaO0jg2kL0rihlsKX42IxMOwQG7AHQTLuV/gNq40HZ0rH?=
 =?us-ascii?Q?ls2VLqiBYuIEGAr2XmhkzvjLJZZ10w9KvOsCA8IObl1mHKefrQpAgyzEVuc3?=
 =?us-ascii?Q?s55D0AHVNDBYLnd9jas0f+IiPJAWiK4hmcrffvczk06VaxGepiTQA9buuTar?=
 =?us-ascii?Q?7/vnyJ9Gv98Gw+SijX81MU2ajNJAWZunOnVLE0hpijt6MP8GmProdT2U7EcB?=
 =?us-ascii?Q?Obk9rsSA0o2YByjRXgV0+fyoJhSRAu461xGowEXiiB4RL8TwMvApKPr3DDaD?=
 =?us-ascii?Q?wkhV1Eyt3vNDiOMXtt3MgDBW9rTai4pl7gvyVl0bprB4KXgo2NSq6Lc+IEIp?=
 =?us-ascii?Q?IcKyvO4ghs4fFCvC7nFyB7n/DlqhY9t65hZLZNqP8967L186v3msFJ5x17AD?=
 =?us-ascii?Q?LiBgJyK+MWrigjPY6hQ4o9igLCDwMfcNLDgwWL01yfmjw53GwYNsftFPUY6n?=
 =?us-ascii?Q?4mlC7ZHEwpy/hcJ4kCoDrNclF4vbU9dX1+E95TPZs49uhmQDgPTbybpcwCqL?=
 =?us-ascii?Q?jN7/dZ9cprUnTE9Gr7nzUEUZ/pyF84N99ZJcgPbvi5wWrluOKsfmVNFPh3DT?=
 =?us-ascii?Q?9HCkijEPFyzRazR8YY3SCiP1t4ExrKGm3tUX1Rme1+fIfhgn3SN1jsNjSZ4V?=
 =?us-ascii?Q?C80+zIoCgQWeuMX8j3WuAuEl3QGyiyLa1OEZ1ooXKpsaDQh9AlmSwUWCxrQZ?=
 =?us-ascii?Q?R2Ll2Ofaj1D4ZRA9zigvWAs/nF57Hgj+qa6J67bnqE2niMhVbkCL3ix1nzbu?=
 =?us-ascii?Q?+6vVwetBfBswDRCgFqhJtV5xwqGC6rm3yZiezwII4r2HK6UaRd3XnpZde7r5?=
 =?us-ascii?Q?N0e67V1rAlbCOhT7dcgk3fkMJXvKIYH2dRFYdssM+kBG/0LMzYzgeCCo6jyJ?=
 =?us-ascii?Q?cvTNbkfEMTwhenCU6tlflXj9jgz49DinIwcPBtRGPGKk87Zo+vz1bNVCqpqv?=
 =?us-ascii?Q?Xp9E0/P0OvdtfmZ318fFPigNfOKSnu3ZqeH/QNdbj70HOJajZpkz0SKOswEY?=
 =?us-ascii?Q?UETTkVvFlsengApHKviF9bqJT/D85rZ+wMiW5chGyXTSYxaxeXOdtmNDHH+w?=
 =?us-ascii?Q?FAVq06RZuQH/cII/6ZQkW+X1IfaOyX/ZmdvIJN4yi4Ax/ep9s4MH1LlujQnq?=
 =?us-ascii?Q?LtNVhDNQwEmIBd0BJ6CgzfzFRCMBlydpAezpy0STTg8mR40DBe6SItvbbzpa?=
 =?us-ascii?Q?q7JsVDmtKcjk1UIzIkB/K5Su5N85erWlyC63+IPxatsYx8hNT6lYW50cqB/C?=
 =?us-ascii?Q?xz8OLPw+zK+stS7t1O7hzuwwYWIZsb3KjHFklEBVeZvaDKzkEqOO4Z5RMVJV?=
 =?us-ascii?Q?+yrIdqxymhQdzMCw1Lk5MrvJtvJakzwb59yuQI0c12tg84n6R67UBhC3k0EN?=
 =?us-ascii?Q?r8+Rc8QpVdRYowuNCeHktBkh49/7Dd/txDf2lqHcZn/HgY6r3YZ671pUqYKO?=
 =?us-ascii?Q?QotiKeV7yREhLMh/O0tQI6ILZ3dLiNa1zn8d5h57/WkL7t6EZwxXYPgV7ebC?=
 =?us-ascii?Q?j9L+YtA0gpknzrHRUhc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 12:10:54.0487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a56ccb-0a36-45bc-eca3-08de2509311c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
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

GCC analyzer identified a code path where acts->mhdr could be
NULL when dereferenced.
When modify header validation fails in mlx5_tbl_translate_modify_header(),
 __flow_hw_action_template_destroy() sets acts->mhdr to NULL.
Add defensive NULL check in mlx5_tbl_ensure_shared_modify_header()
to prevent the dereference.

Bugzilla ID: 1521
Fixes: 12f2ed3f03c8 ("net/mlx5: set modify header as shared flow action")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 208f50fbfd..519bec8556 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2335,9 +2335,10 @@ mlx5_tbl_translate_modify_header(struct rte_eth_dev *dev,
 		.sz = sizeof(struct mlx5_modification_cmd) * mhdr->mhdr_cmds_num
 	};
 
-	if (flow_hw_validate_compiled_modify_field(dev, cfg, mhdr, error)) {
+	int ret = flow_hw_validate_compiled_modify_field(dev, cfg, mhdr, error);
+	if (ret) {
 		__flow_hw_action_template_destroy(dev, acts);
-		return -rte_errno;
+		return ret;
 	}
 	acts->mhdr = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*acts->mhdr),
 				 0, SOCKET_ID_ANY);
@@ -2370,9 +2371,14 @@ mlx5_tbl_ensure_shared_modify_header(struct rte_eth_dev *dev,
 	const struct rte_flow_attr *attr = &table_attr->flow_attr;
 	enum mlx5dr_table_type tbl_type = get_mlx5dr_table_type(attr, table_attr->specialize,
 								unified_fdb);
-	struct mlx5dr_action_mh_pattern pattern = {
-		.sz = sizeof(struct mlx5_modification_cmd) * acts->mhdr->mhdr_cmds_num
-	};
+	struct mlx5dr_action_mh_pattern pattern;
+
+	if (!acts->mhdr)
+		return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+						"translate modify_header: mhdr is NULL");
+
+	pattern.sz = sizeof(struct mlx5_modification_cmd) * acts->mhdr->mhdr_cmds_num;
 	uint16_t mhdr_ix = acts->mhdr->pos;
 	uint32_t flags = mlx5_hw_act_flag[!!attr->group][tbl_type] | MLX5DR_ACTION_FLAG_SHARED;
 
-- 
2.43.0

