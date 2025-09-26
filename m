Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC444CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 12:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC64B402B5;
	Fri, 26 Sep 2025 14:32:30 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by mails.dpdk.org (Postfix) with ESMTP id DD5914025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 14:32:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXx11uvsFKKJ0R1YQwLYAd/sUe3iRZaoUB0ZHRYd81hVsNmp5HqHdxQzpj+jdhRf60LBsZFBW5UYbpWC9uKax/YwRZgSZmEUr+utadensTHOO1StUEXwlOj9jF9b38vTT4VUlBS/CaVJAPqHuLvaKJmsQ/I3eOKT/S5edOzQx0VvwUZovWXnJIWDFWaXfPqsbXHXo4DBwIznhwbTcCzWgFmgFrXgYTMi/5NbR1Wd+bduuaEa6w3Xg0OzDvlHLKVbF/gcEWBbKX7wcSl2wMkF3lV3UBXZPScdEeWXRAPq7p3nA6CcEShEJT+i5zJrfRD5HK2cY7Qp2/wnCyeGhBHUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U50/g3O4gTWtRPkd0Bs93BrzZctwc3c4+505c9eieu4=;
 b=n/d2EX5cu6ZbMZT9IRX8oN+Tul8dDfUrwxSPz+FGH3/mimaMCP2MMlUUgTsCQKAgk5R1z9io2CNNdhafzhNeM+FH1UmIgF/EkLe3FqNCoyCPbB0IB4POFy03AyV8dhITtalndrxpKADbU9v8FWiZs3FPakuU/OV0fu3T36BcYMqt/vDyFjIVEUH2PpJe5vtKq3F8CbWQ/w5FCr07S3fYfrmLbC8WSGOEy2JEDE7ytE8IcFnpyHcjRBCpfqrm8MW3bIveBj0Zu1s1Thyv0fWDgAcS5aJtIRevyNJ0zyPWGICmF/rSZ/xQrVms+3Jb+NXyQRNf08UDn15M/Jlfb6lnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U50/g3O4gTWtRPkd0Bs93BrzZctwc3c4+505c9eieu4=;
 b=QUKBRMD4WNnyKHKC6bkPNiEaJSVl9SXSXLEv1XQrBI2PTs/mt1VrvkdrrrOUBJZqM6ROthPe9a8fG5R4UJi3VADsHyWDljYJ0wCjySLo7H1/CW2uKk4E0isFSBOcND2Um5CBcgVGkNZOcza44kYnqRiAs2rdDG6f8MANYxGjehrRV/p3UD0Ou5s1P8TpITFkjKXRSw69EpNVHjevpT8npaHCEqsLqFNEi6KWtafGKxevnIt7DlAOHjvFhF6GlcpT+Zi2JgR4dliAQ3coQ/kgHPZhk7ZlgUrLieUVErXLPszXL9gBZmhdFXU7MIE6/s6WmgZ2xtWTloY+FV0691AZjw==
Received: from BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17) by
 SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 12:32:25 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::2d) by BYAPR01CA0040.outlook.office365.com
 (2603:10b6:a03:94::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.13 via Frontend Transport; Fri,
 26 Sep 2025 12:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 12:32:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 26 Sep
 2025 05:32:06 -0700
Received: from pegasus01.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 26 Sep 2025 05:32:03 -0700
From: Alexander Kozyrev <akozyrev@nvidia.com>
To: <dev@dpdk.org>
CC: <bingz@nvidia.com>, <dsosnowski@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, <matan@nvidia.com>, <ferruh.yigit@amd.com>,
 <stephen@networkplumber.org>
Subject: [PATCH v2] app/testpmd: use table ID for jump to matcher action
Date: Fri, 26 Sep 2025 15:30:33 +0300
Message-ID: <20250926123045.3944957-1-akozyrev@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819144508.722653-1-akozyrev@nvidia.com>
References: <20250819144508.722653-1-akozyrev@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b72ee0-0f95-487c-437e-08ddfcf8bf91
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dOxgcj+jjusIdtZzATu6u00fxPf51zaVgOOdNI0Htn9Jjk/asMf1z4wSyQXW?=
 =?us-ascii?Q?9BEmCJ3zz44z+bXrE0YDk+WHU8oNZzo8LM+F5ATxKz+5vu6Vb1QN8YCFKqt6?=
 =?us-ascii?Q?aVNX0xOABBvSGMlAJ2So92sK2pK55ReM8Ovodw1GKfX09WYGv18SGT59kDjk?=
 =?us-ascii?Q?CxOnDMuRKTnHRlppnBm6MF/Q597VmiiSZg2ma7njKWWEkmFLX3Oxsm1pjoMM?=
 =?us-ascii?Q?Gj3A9mSXojHAK3a2ajWeXguH/usuyNTDe00NVNNuDtUwBDOFDERs80bgouTW?=
 =?us-ascii?Q?c7nBbM8Z/JnL3UbOQGkv+vHytlzqsmDQv4dv5bSGutbkK/B7daEvrKnPv/tr?=
 =?us-ascii?Q?yC+U+mFjKklYnn8ORftOigHQD95cF4Phwtpop5IFK7IKvV3QFRvTimBefdQZ?=
 =?us-ascii?Q?jOxSFf6tZhrkq3FBzpyGI09eyvDtDz8sFE544Q1Hj2gDv0qNHbBJtmb2pZvv?=
 =?us-ascii?Q?Gw5Auu2CPPXnc4m0AX+A1HjoW0JAFdFT9pHyTue61o8c1USoWMRhHIi3AY44?=
 =?us-ascii?Q?MrfTiUgSfWR95UuUQ7WP4IllnT5xDQqj9PjTtaeOCSe1I3soCUNmmQ4wOSfC?=
 =?us-ascii?Q?LjT/JutW8Dnu0ewJxYzAhLPcz9FjvL9V09icwXQx4c56wYoSfUbRRZd0UVcf?=
 =?us-ascii?Q?4mQiL4RsCThpUx7ykK9gG/E6iln+eR4WWzRSkRi+LoeykV1XWJ41cz08ndEY?=
 =?us-ascii?Q?554Ct+8vea0hFcuTal3pEd6ZySNyY1iKcWu1SkoZjs+XE3cEHH9nRxRrt2MD?=
 =?us-ascii?Q?Xl2xIkivGtMiuoOaBD3fO1P0fxhvfKgoXWFawLDXY5pe2ZMkX0mwNXe3uRJU?=
 =?us-ascii?Q?UKCLs50G643tAFbFc6hZQ4hoalYX/iZKrNL8cDCxfPWxqFWeEGz6Zhf79929?=
 =?us-ascii?Q?67vlhnNDdhRNg1Mtb4oVOixyF7qC23zE6oQvJ10MNuXZBUDSr3tii7DYfHHi?=
 =?us-ascii?Q?t1AHuMrT2ye8ODfDG15Z8CAj0YwkIQar0gtEbQKNpMbw08NMIv1NgjpfOKck?=
 =?us-ascii?Q?t9OL4jvNYS8/o9j92WyCiLHOnL/qQaYzHCAlOWDSkN413/GfM5p4CcwkFEHE?=
 =?us-ascii?Q?Kc5HSVu9Dap1QsWxFVYNpSRDzO3/4L/WcwG9KWwGkZqT6S6HALylbCnOuwcB?=
 =?us-ascii?Q?mLbAkGiW5P1zl4fWKy7l6MdNtmaZNhma+PbgOczufpTiOynHtVNmwvsNZ9L8?=
 =?us-ascii?Q?mmz8a1j0CtPm/8zPL5TyHJx81dR5nffm91hLLGVbG057Sp+3GgFks+xmVXY5?=
 =?us-ascii?Q?sP1Xveh1+FijdmLv6U+L5ISXSE6jWmSY7+nEU9hAYZV7zlwWVCfj92EhSapi?=
 =?us-ascii?Q?YTJAk1fix1dHMFPVHzFZ/PkfGDJE1dN6pZYBYsyBl4eQzwi/qXLEw9oz9slG?=
 =?us-ascii?Q?TuZgWqavEC0SNCbxIV2q7U+BOEkcd6lHvRpHXf0vzP+JEQO50MTADGhQWhBT?=
 =?us-ascii?Q?k+wLu1fXa1T/w0e12YjEMUjsYpRmSjoiMQmDNk6hHG0mAFhakgJOO3FeQ0SK?=
 =?us-ascii?Q?MuAuON6kk6cHsUPUSr77Q4BHEK79spY2P+aDBuQ8WAUP4Udq4lTo1hMyZ9cO?=
 =?us-ascii?Q?uou9RT7JaFNpzzuh/lE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 12:32:25.1225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b72ee0-0f95-487c-437e-08ddfcf8bf91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
index 38e751f3f3..04d3dbbdca 100644
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
+	memcpy(&table_id, entry_ptr, sizeof(uint32_t));
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
+	memcpy(entry_ptr, &pt->table, sizeof(struct rte_flow_template_table *));
+	return len;
+}
+
 /** Parse tokens for queue create commands. */
 static int
 parse_qo(struct context *ctx, const struct token *token,
-- 
2.43.0

