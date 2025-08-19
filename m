Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F41CCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 14:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A309C40612;
	Tue, 19 Aug 2025 16:46:58 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by mails.dpdk.org (Postfix) with ESMTP id CA36840611;
 Tue, 19 Aug 2025 16:46:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBlqPF3wdWI9/AefptrO8dmIppI1KcY15PxF9RnvZACgxh4miFR+KqQosO2pPvV/VU/UbjQ9oehjq8U0PC6LDmjRI3KGGhtUCAs3mrBIPeTE84wLTNARAZXNbApQqUyda9ub9enNj2e/aJ8EfLg7w0IXaaxWLYKlmWZqb/ra9MuGeP1ntsfqJOnK7/74z/xeXmeIfb072bLFTXqXo3VBLvRYEGGR06qF50J9m67O9xYcYBz5NMhwU5F1fD4qmU5hj6zJ3UN51i+8ZOebvbLn9OBR0QyJgZxsTC+UICAOa4MZykMabzgrPYxxre0rqxp/yt/xu9j1EVrdkFKauYrUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZJVJO4E0Ap5RlAg+q/CDeoGK+i4xyXfGC/rEBucLoQ=;
 b=CqumPRy8r+0P/56pwTBmo7WVXfwfKjvgVJ8qVST/HUD+bGM/5h+qJx28jAJ31ikQ4+Jff9X6TC9bDp0mYxYj8wcP4cbndrBNt5Shcr7U8avMGIIHNtBy9jpxD02kqCVd5KrvB5zwWIzNsYcufRFC0jTWn+5r1ucRtgrc+bqT/vzEj5Xe8mlMv7oMVq/CnkO+aXOQYYcarf3R4o7NaBJO43Dutc9TFDP/+i0PoFeqjJKqjNyO1X9uTwDVe43SBQWbz8GQ9Gy99+KWpJWC+Kv3SWYQbNxALGKC+4yg3W4cAkEAmBhzAepWTzsGXzyADFsd9V2+fjd2ZaqrP3fgrPH66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZJVJO4E0Ap5RlAg+q/CDeoGK+i4xyXfGC/rEBucLoQ=;
 b=hvU6HzM0JNGKZ0HwH8T3loEh9J74bPPjGF9dQlKjZ4OF2O/y11h5VfczaU5DOL3KR/Ny3or9tXpii4DjDKbc0m/UNB7vTGTpon4L4oicpbhkB7Zp4ARfURbYNnY8jlJGVrfcVWuTVitbw/hv3oae1ECh1fAd5ezJbFMLNeA6US6sCLa9ONrQVLaBYuh2IwNCJz7Fw/euCLR4otOldAXmLic0baIznd1ptkF3TA1E/PpXsz5j3mrz/5zm6l+QhYhpiNRylvfOXhzzSu2AwdYNCSgniWYKsQ9clXngBuzhoTDVIXvMNYV1bHh42rnUOfjcZzTUuamAVKfJxrB/4c9O6Q==
Received: from BN9PR03CA0906.namprd03.prod.outlook.com (2603:10b6:408:107::11)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 14:46:53 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::c1) by BN9PR03CA0906.outlook.office365.com
 (2603:10b6:408:107::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Tue,
 19 Aug 2025 14:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 14:46:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 19 Aug
 2025 07:46:27 -0700
Received: from pegasus01.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 19 Aug 2025 07:46:25 -0700
From: Alexander Kozyrev <akozyrev@nvidia.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, <rasland@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>
Subject: [PATCH] app/testpmd: use table ID for jump to matcher action
Date: Tue, 19 Aug 2025 17:45:05 +0300
Message-ID: <20250819144508.722653-1-akozyrev@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: c19adbf6-8cac-4bba-685f-08dddf2f3cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?flroDg98sy64xJdUwpmdnOGEqGKnnQpcyjtHnX23+ltBvuF0gTzLwGHyLlSh?=
 =?us-ascii?Q?cYVPdw/6ritjjUWZQwCFWVQSmMhAZcdew2DdEItiB3U1db1SSLzwMhZXd2I8?=
 =?us-ascii?Q?j2QSwT2Aa+3QY4obGzN0pdk80QPnamFTWZv01T+dJZdLzAi1pxIh7xYVw2xz?=
 =?us-ascii?Q?R6nuswytvrdu2IEqq1JdHZCL93VwXW7bWzb6GMOSXdig+vQ0VSjzSyD462eT?=
 =?us-ascii?Q?n0PBUgK3RA6lymeU4ELucxUOR0sRmVeOxm5lYEsbuqzUASGEHeEC4ANUOb37?=
 =?us-ascii?Q?OFSdzSXeqr/fxvYidWEwSbeY0Qx7s15KkKASRjg/CgIyiK2HgFeqqr1de+AE?=
 =?us-ascii?Q?LzI8KT0KWfR0WbeZTyroF8ETHqhMq0cyi6x5gk7s7yY8U7FKqjoVFFhiyK3F?=
 =?us-ascii?Q?gTLgIrGRHlwQ7kxOBV9APCtZwwrtb3qFT+f4BNOfKDTOdEfbxhd3oee7kSq9?=
 =?us-ascii?Q?PD2MvhQ5CP4GQ6jKJGL3RPGxdSHHwN7V5toCGkjYhMdSAwb3uPrKJhD4rGaQ?=
 =?us-ascii?Q?HnPEfpv1dYvHY/szsZa9Ljpn/xeqJCZ1l4vUxawVN94a+3JG2O9kRGJuNaaP?=
 =?us-ascii?Q?K90VG+JQXa4JdCbB+G6scvzYl2hotyJUnfPAs0EgsuLY8rIvFFtfHEckS4g1?=
 =?us-ascii?Q?V/qbskmDETS07P9jVsY0xUC1+SW3Vlcf6Gcb5KF2u1elv7tB5PJkrmUXfjiy?=
 =?us-ascii?Q?FnVlOx2ANu58cdMRcfqHasB/uUYS51+PIAWw5UnnoKk0xtVqqPOITKGU/bCG?=
 =?us-ascii?Q?H8aePpRYP+YBNBQYwCUiWC0i1xGaHdGIZfJjaoIh3Z6xyZo3KgqD56F1acEC?=
 =?us-ascii?Q?3szqyoi1+oR2Q0n31sU48basm6vx/9AXpGH1tzhAfOBr7JskMARjQDn22/+J?=
 =?us-ascii?Q?v2WW21eSOtO1+83/rdq3T671I1AsbQi9RuVxn7SghWpBocmDcPCQI/bDRi6g?=
 =?us-ascii?Q?8BXjaX4H0t3dmndKn2CXbJLUmIH4TY1bLlsXVewpO8AwKvML7U8FPtHwtqTq?=
 =?us-ascii?Q?aX4OpTK+Z+JRmnYWs2aUbLis7Y+IsoIGdwuM868YGNT6uEG0MYS9eAtlYhy5?=
 =?us-ascii?Q?1CQzv5aoY02BsWXguavZVeQ+wpBACeKfTRt2z+eTYmz8nnasL72r9eEaxEbE?=
 =?us-ascii?Q?axRBe0P+nzqDUIw9hbBAJdfk4DcdCB5E5QvSfQtGGGJvLoEN3l2o4GuX8fOt?=
 =?us-ascii?Q?Igslu/5f0I8CRY2xPwSqfZer2AXGv4XJAYHMb45RBBB1dfS09sHs6n2k8yT+?=
 =?us-ascii?Q?PAl+Opft+Ul1xcVVW/90n7eJYwjvcO2m/pLCAuv5n3WT/Bndw47pRmtd8Yz+?=
 =?us-ascii?Q?5f/e0lAUnpsDnZ4CWisGRRq4LKWk0/+Y3hWeayJoEx4GaJORlssTy7ONry+h?=
 =?us-ascii?Q?r72gJRLmJPNlnCq1iPqeGnejPwT/kx8eUo7OcIg0axUu/1GWOBr9WXojLxN8?=
 =?us-ascii?Q?/3zC7n5GPfAkM3b0XCuggTb/WMer+cC8+JT3OY/61UWk6RVTRfQTYSunNeGI?=
 =?us-ascii?Q?+g4Kuio1Qcdr5H4ZbhX2HR272FggrO8/cbr7?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:46:53.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19adbf6-8cac-4bba-685f-08dddf2f3cd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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

Current implementation requires specifying the pointer to the table
you want to jump to in the jump to matcher action. It is inconvenient
since there is no table pointer shown anywhere in the table management.
Table creation/destruction uses the standard table ID for that purpose.
Use the table ID in the jump to matcher action as well.

Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>
---
 app/test-pmd/cmdline_flow.c | 59 +++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 38e751f3f3..5d9c8f04f2 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -788,6 +788,7 @@ enum index {
 	ACTION_NAT64_MODE,
 	ACTION_JUMP_TO_TABLE_INDEX,
 	ACTION_JUMP_TO_TABLE_INDEX_TABLE,
+	ACTION_JUMP_TO_TABLE_INDEX_TABLE_VALUE,
 	ACTION_JUMP_TO_TABLE_INDEX_INDEX,
 };
 
@@ -2864,6 +2865,9 @@ static int parse_table(struct context *, const struct token *,
 static int parse_table_destroy(struct context *, const struct token *,
 			       const char *, unsigned int,
 			       void *, unsigned int);
+static int parse_jump_table_id(struct context *, const struct token *,
+			       const char *, unsigned int,
+			       void *, unsigned int);
 static int parse_qo(struct context *, const struct token *,
 		    const char *, unsigned int,
 		    void *, unsigned int);
@@ -7634,11 +7638,19 @@ static const struct token token_list[] = {
 	},
 	[ACTION_JUMP_TO_TABLE_INDEX_TABLE] = {
 		.name = "table",
-		.help = "table to redirect traffic to",
-		.next = NEXT(action_jump_to_table_index, NEXT_ENTRY(COMMON_UNSIGNED)),
+		.help = "table id to redirect traffic to",
+		.next = NEXT(action_jump_to_table_index,
+			NEXT_ENTRY(ACTION_JUMP_TO_TABLE_INDEX_TABLE_VALUE)),
 		.args = ARGS(ARGS_ENTRY(struct rte_flow_action_jump_to_table_index, table)),
 		.call = parse_vc_conf,
 	},
+	[ACTION_JUMP_TO_TABLE_INDEX_TABLE_VALUE] = {
+		.name = "{table_id}",
+		.type = "TABLE_ID",
+		.help = "table id for jump action",
+		.call = parse_jump_table_id,
+		.comp = comp_table_id,
+	},
 	[ACTION_JUMP_TO_TABLE_INDEX_INDEX] = {
 		.name = "index",
 		.help = "rule index to redirect traffic to",
@@ -11182,6 +11194,49 @@ parse_table_destroy(struct context *ctx, const struct token *token,
 	return len;
 }
 
+/** Parse table id and convert to table pointer for jump_to_table_index action. */
+static int
+parse_jump_table_id(struct context *ctx, const struct token *token,
+		    const char *str, unsigned int len,
+		    void *buf, unsigned int size)
+{
+	struct buffer *out = buf;
+	struct rte_port *port;
+	struct port_table *pt;
+	uint32_t table_id;
+	const struct arg *arg;
+	void *entry_ptr;
+
+	/* Get the arg before parse_int consumes it */
+	arg = pop_args(ctx);
+	if (!arg)
+		return -1;
+	/* Push it back and do the standard integer parsing */
+	if (push_args(ctx, arg) < 0)
+		return -1;
+	if (parse_int(ctx, token, str, len, buf, size) < 0)
+		return -1;
+	/* Nothing else to do if there is no buffer */
+	if (!out || !ctx->object)
+		return len;
+	/* Get the parsed table ID from where parse_int stored it */
+	entry_ptr = (uint8_t *)ctx->object + arg->offset;
+	table_id = *(uint32_t *)entry_ptr;
+	/* Look up the table using table ID */
+	port = &ports[ctx->port];
+	for (pt = port->table_list; pt != NULL; pt = pt->next) {
+		if (pt->id == table_id)
+			break;
+	}
+	if (!pt || !pt->table) {
+		printf("Table #%u not found on port %u\n", table_id, ctx->port);
+		return -1;
+	}
+	/* Replace the table ID with the table pointer */
+	*(struct rte_flow_template_table **)entry_ptr = pt->table;
+	return len;
+}
+
 /** Parse tokens for queue create commands. */
 static int
 parse_qo(struct context *ctx, const struct token *token,
-- 
2.43.0

