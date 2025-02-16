Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0878AC02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 14:04:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F32F74065F;
	Sun, 16 Feb 2025 15:04:57 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by mails.dpdk.org (Postfix) with ESMTP id 05971402DF;
 Sun, 16 Feb 2025 15:04:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYvvAquyB7BwCFK6xbvtwwMXsoa+n0AB7+jwM3r+jsqWExAPbXOqhDpe3JzUWq6tqERC2ptHtXqN0KbyzfW21ziMWlQE9jxr2+PQAE/GOUm73DCADQtHdSf7+EbpYkyaRF+Y5SHjJz3l1AEQ4Coh3psgSfOvazh7xmcFye3pKKiXRnYb6FS1cPARQ48J9iGmM+Ebo6wtbKnoy6kUTVrh5D1SMkh1UD0RsCrs5j7B5FKZMNGILEqzavOicsbIubDPcPYYF75RmTTPI4jbU5j5D/bbxvK7w1HTdT2ODj0lgQFvLidjjQ5ACdx1LSWU+xtn4NuiVTt8qzBUIiF2IHOAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub9oWPBztXzxC4DQHHS75zh/0lzR/ZlCUJrcXYpz00I=;
 b=FxGDdmGTI0XFvpDJyhCoA97cQcuW0TsKqDGzZL4bFJ9AZYPhnUwh6dOX7wG5BFE/0SMXJgH6J5VMsk9gs9DC1BsokcceRYvQtU8pVamv2vH/wzh4QQiNhn9+NRC0hkAUlyeuZJz7KxI9EFw1DR5cQIFdoKJLY+esj3j2ShLF4GDck8WD28OBgQEq16ZFAuBa7mSzQviz6W1qXPOzeFD8EgcxEWL2ReWvLuuSeaZOQ3fIQ1q3j34iWesqL9XP4c8W7dGBFF2oGWs7B+0a0Y1W29GU5RwCfsd2lmwaVHkLowYg6I5Q0LjbuCzM/v/wgMQ5zQiDTtQTe/g179+ry58v7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub9oWPBztXzxC4DQHHS75zh/0lzR/ZlCUJrcXYpz00I=;
 b=IAnD0SBJPDbS72OcmfXfoh/YO7JK+JgGiqFLTkga23S+VLJ2zujnsE5INxMNfL2E+XNh8miBJB9bGicc/soX+YObn27uNUlot5UK+0yQLbwbtTU153vqOb6WKm/5GDzBA+tTHAtinlJLAwLsOLUtJLcpc/Xt49uBRziG9d2DzUMrRsPznnNXR+GUBFCCqofOay1SYr7s/odwPTjx7i7J1jlUCcm/g8SADnetNk9P/8hLbMzgi+Ara6irE4M+4mxYdZ/3skcdLY7ZCUI93nP5eaXjCdWeHCIevu3HkI2pWjABLtzIRkjLqszdvDrWMkV/k4KFJyqoL2S889ed9BIhIA==
Received: from CYZPR17CA0020.namprd17.prod.outlook.com (2603:10b6:930:8c::13)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sun, 16 Feb
 2025 14:04:52 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::80) by CYZPR17CA0020.outlook.office365.com
 (2603:10b6:930:8c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Sun,
 16 Feb 2025 14:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 14:04:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 06:04:39 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 06:04:37 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] testpmd: support meter_mark init_color in indirect list
 configuration
Date: Sun, 16 Feb 2025 16:04:20 +0200
Message-ID: <20250216140420.216805-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: f83bfc1e-7154-4f46-8632-08dd4e92e214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wmKiy8u5uMPAPSkkMsU9c3zRkmKGHbjpWx1OZX2OIPf0FKW6mlHRX4EFPHp/?=
 =?us-ascii?Q?RQtbfKhgonCcWislex5TkgPylOqInf3FR/03I6ZZ1YleOzeFtUe5coPQXQqW?=
 =?us-ascii?Q?x8s+mdvrIIJQ0xq6/N2UBuE1HZ2oXBPBmlHGqi36z0rwpVhbyFu1MCb7uai1?=
 =?us-ascii?Q?M/HWMOP6c+NGjERxknWgYnLFRf/UKNvwwMhqEq9aCkHOOspJBLOr7Nq3G3wL?=
 =?us-ascii?Q?SfjQFVDDCovGmQcItxmbQSASCS0d5t0VhwGj+RcGXTvYlDrBbd0Uepi/gH+2?=
 =?us-ascii?Q?PILQ5hX3gvG+g+2jXLlLsTYWrJcMk7UbJz7yzxg4WGD1oVFnZM/q0Z00bRih?=
 =?us-ascii?Q?doG9E9TaWWQXMBzuGWoxYMbqwDI9VCEPd88Ey+lOKnRNuasZ/uRi6Cgiee4n?=
 =?us-ascii?Q?YSLNsiPmJbwwwEoOpKKcibkxMj+md64ldhVmP3K0QsQTaG2FRv8e88O/vs5T?=
 =?us-ascii?Q?d87/ksNzMYoh++kwX3ps3V8Rcj8V6FSPiwDC99w2xe1McyGcTMtqTku4jlZM?=
 =?us-ascii?Q?RN/6ZSiKjBbexpdLr39XTDMgGcPuMGiA7CcfXo7NsXW7lzrfnGiYS+R9VUty?=
 =?us-ascii?Q?rbB/SPuOuHxVD6fbbcOb02GS8Q/LxubaCO0G+8r6tVaZXGnqbaabTh/a3DuV?=
 =?us-ascii?Q?B5/04vw5Na6odhmol7oiBR2GKuJQLKd4tvHvtRfMpqsAkVOJ/r6TaoQVA29E?=
 =?us-ascii?Q?jL5qrCvG+7PUZTMLPZKTvGCIO6/9xBHmTlFLT7PGxMIivmW97nPaUFzApDfn?=
 =?us-ascii?Q?na/ZrybF1UTWtNe/mcR90eU0gjJ1EkqglJtPPdh0cdyOzix3oDlu5tOujSzv?=
 =?us-ascii?Q?ueLIsQLJEZTydvPx5BYNllMyBGh40DvZIdWs9Va70iQ+jGL3ZTOoPRfmPsc2?=
 =?us-ascii?Q?4N49NOy71E3gy1LEn91XE6kvu6XwsnY/vCWGCNj7s0MX1CBaSNEJdKMHxXLs?=
 =?us-ascii?Q?H9YgbRXJs6mb89MFqbSV17Y5WTMc1s3OQfSritkf+NTR15B1cNTUzRZZ4T4s?=
 =?us-ascii?Q?LDFHth3Fo2IfInrdgoBdhdDLwywCxLbyRgxPZPsTJFA+ghy4bBQrV5q1B4ZR?=
 =?us-ascii?Q?bZo7XAljaR2nWA9q3pVVgI0Y1O4QwwgmrP95pakHebtD4aCNqmMHfxG8i00H?=
 =?us-ascii?Q?GT6IYykMar+6krYQmiCLY6lSqIXe0EG96d7g7eAoP3tZaePWXkd9+mw7iiBw?=
 =?us-ascii?Q?iQYMQMLZZmoHVtnbG1EJmEDKmGGJVOdbGGWeF6EeC6nXLH/7ggIb9Cc4XM+T?=
 =?us-ascii?Q?e99Jos2MBFgeL9J0p8BypxUBiEkV71ZezQUdZSbkE2nWj02XutyGI6i9s3hq?=
 =?us-ascii?Q?NWq6GYspCOPiW3oY4fDZDw3E6y5gHtVt7qbVNgK9UOhqxv4Tla1/RyNFBbAR?=
 =?us-ascii?Q?LlmgseXqjEpQanp9t+lojw+p+UDllQhfUjYTMF3mk3ZpYmu9PNClzlJ+MFAK?=
 =?us-ascii?Q?lEsUq4xE8UODGMT/9l6TH3EQbfIJ6far/FDQ8gj3wuyEwqGQS8IAB6Zr1paV?=
 =?us-ascii?Q?YayqZkfOpIlGpUE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 14:04:52.0416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83bfc1e-7154-4f46-8632-08dd4e92e214
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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

Flow actions parameters in indirect actions list are created as
read-only and shared between all flows that reference that indirect
list.

If a flow rule needs to apply rule specific actions list parameters it
does it with the indirect actions list conf parameter.

The patch allows flow rule to set meter_mark init_color value when
meter_mark action was created in indirect actions list.

Example:

# create indirect actions list with meter_mark flow action:
testpmd> flow indirect_action 0 create action_id 10 ingress \
  list actions meter_mark mtr_profile 20 \
  mtr_state 1 mtr_color_mode 1 / end

# create a flow specific meter_mark init_color configuration:
testpmd> flow indirect_action 0 create action_id 11 flow_conf \
   actions meter_mark_conf mtr_update_init_color red / end

# queue a flow rule with indirect actions list
# and flow specific configuration:
testpmd> flow queue 0 create 0 template_table 1 pattern_template 0 \
   actions_template 0 postpone no pattern eth / ipv4 / udp / end \
   actions indirect_list handle 10 conf 11 / \
   jump group 10 / end

cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 app/test-pmd/cmdline_flow.c | 52 +++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index e1720e54d7..6add4e56ec 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -62,6 +62,7 @@ enum index {
 	COMMON_ACTIONS_TEMPLATE_ID,
 	COMMON_TABLE_ID,
 	COMMON_QUEUE_ID,
+	COMMON_METER_COLOR_NAME,
 
 	/* TOP-level command. */
 	ADD,
@@ -556,7 +557,6 @@ enum index {
 	ITEM_PPP_PROTO_ID,
 	ITEM_METER,
 	ITEM_METER_COLOR,
-	ITEM_METER_COLOR_NAME,
 	ITEM_QUOTA,
 	ITEM_QUOTA_STATE,
 	ITEM_QUOTA_STATE_NAME,
@@ -642,6 +642,8 @@ enum index {
 	ACTION_METER_COLOR_RED,
 	ACTION_METER_ID,
 	ACTION_METER_MARK,
+	ACTION_METER_MARK_CONF,
+	ACTION_METER_MARK_CONF_COLOR,
 	ACTION_METER_PROFILE,
 	ACTION_METER_PROFILE_ID2PTR,
 	ACTION_METER_POLICY,
@@ -2270,6 +2272,7 @@ static const enum index next_action[] = {
 	ACTION_METER,
 	ACTION_METER_COLOR,
 	ACTION_METER_MARK,
+	ACTION_METER_MARK_CONF,
 	ACTION_OF_DEC_NW_TTL,
 	ACTION_OF_POP_VLAN,
 	ACTION_OF_PUSH_VLAN,
@@ -3235,6 +3238,12 @@ static const struct token token_list[] = {
 		.call = parse_int,
 		.comp = comp_queue_id,
 	},
+	[COMMON_METER_COLOR_NAME] = {
+		.name = "color_name",
+		.help = "meter color name",
+		.call = parse_meter_color,
+		.comp = comp_meter_color,
+	},
 	/* Top-level command. */
 	[FLOW] = {
 		.name = "flow",
@@ -6280,17 +6289,11 @@ static const struct token token_list[] = {
 		.name = "color",
 		.help = "meter color",
 		.next = NEXT(item_meter,
-			     NEXT_ENTRY(ITEM_METER_COLOR_NAME),
+			     NEXT_ENTRY(COMMON_METER_COLOR_NAME),
 			     item_param),
 		.args = ARGS(ARGS_ENTRY(struct rte_flow_item_meter_color,
 					color)),
 	},
-	[ITEM_METER_COLOR_NAME] = {
-		.name = "color_name",
-		.help = "meter color name",
-		.call = parse_meter_color,
-		.comp = comp_meter_color,
-	},
 	[ITEM_QUOTA] = {
 		.name = "quota",
 		.help = "match quota",
@@ -6856,6 +6859,23 @@ static const struct token token_list[] = {
 		.next = NEXT(action_meter_mark),
 		.call = parse_vc,
 	},
+	[ACTION_METER_MARK_CONF] = {
+		.name = "meter_mark_conf",
+		.help = "meter mark configuration",
+		.priv = PRIV_ACTION(METER_MARK,
+				    sizeof(struct rte_flow_action_meter_mark)),
+		.next = NEXT(NEXT_ENTRY(ACTION_METER_MARK_CONF_COLOR)),
+		.call = parse_vc,
+	},
+	[ACTION_METER_MARK_CONF_COLOR] = {
+		.name = "mtr_update_init_color",
+		.help = "meter update init color",
+		.next = NEXT(NEXT_ENTRY(ACTION_NEXT),
+			     NEXT_ENTRY(COMMON_METER_COLOR_NAME)),
+		.args = ARGS(ARGS_ENTRY
+			     (struct rte_flow_indirect_update_flow_meter_mark,
+			      init_color)),
+	},
 	[ACTION_METER_PROFILE] = {
 		.name = "mtr_profile",
 		.help = "meter profile id to use",
@@ -12375,8 +12395,8 @@ parse_meter_color(struct context *ctx, const struct token *token,
 		  const char *str, unsigned int len, void *buf,
 		  unsigned int size)
 {
-	struct rte_flow_item_meter_color *meter_color;
 	unsigned int i;
+	struct buffer *out = buf;
 
 	(void)token;
 	(void)buf;
@@ -12388,8 +12408,18 @@ parse_meter_color(struct context *ctx, const struct token *token,
 		return -1;
 	if (!ctx->object)
 		return len;
-	meter_color = ctx->object;
-	meter_color->color = (enum rte_color)i;
+	if (ctx->prev == ACTION_METER_MARK_CONF_COLOR) {
+		struct rte_flow_action *action =
+			out->args.vc.actions + out->args.vc.actions_n - 1;
+		const struct arg *arg = pop_args(ctx);
+
+		if (!arg)
+			return -1;
+		*(int *)RTE_PTR_ADD(action->conf, arg->offset) = i;
+	} else {
+		((struct rte_flow_item_meter_color *)
+			ctx->object)->color = (enum rte_color)i;
+	}
 	return len;
 }
 
-- 
2.45.2

