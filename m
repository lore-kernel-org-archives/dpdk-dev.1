Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FABC021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 17:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD70A400EF;
	Mon, 17 Feb 2025 18:21:51 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by mails.dpdk.org (Postfix) with ESMTP id 5F5ED400D6
 for <dev@dpdk.org>; Mon, 17 Feb 2025 18:21:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwxwrYXW8FrpXM2v22curyiNPgRwExTIBjuOBolXZVXRaLpUW76WQvAmxu6+jXUbcBFhb/1qed21hGxe1sykL1rDjhlWVYxboWgpreK5ciXXhFO12sDzmqkEqoBRABfXEAsJAfL6x99s1TK8y6mSIoDY7CX24uE9sRAXKXmeq3dqkftE72caf9qjk4vuHaoYmHUyfU2QpE6mHlLybqUqMoLbuyVWrrlpq1adDxfD9gqU6I4gHpnwR5il58GchkXa7YzWpCSJDcDkm2n7IFHMGphVhxxUyL2e7/CrtFkZ4tQ3M7hhrAWUgKfwC9S6SySqaYPt0dKQrqoiWC6Dc87Gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOOm824RWgD536kqH/JxTSmFortss58zAuYITCM0Dss=;
 b=vxsNP4KWJkC0n6y93YVYllKsLOLTZeZE0ai1yW3JpkzhUrM6vLAh2fp6/dldKgrnEDlXWnnsMRNAK6aN/rpDLgoXLKIPDjLZkgtWlnlc1gwTdGqnhL6MyM9mUfj+iQTcoIIaOap0TbAv7GFuXgw3AbslhiY2b/8XYW2mhNYrRj9HaL4LWzIYWIJ93MU8G/5UCvJUdA7Nu6HwHX/r2/w+05ft5p47R0X//wURy8SoZ04sDOGunEl5NOTlNrVfWiKgYeukDarSlBErlYp0B4BZKTPBb+QC+6gqHX+lVX9BlLokyDUmQIcLNv4TQtg1lAWBoOgjjLU9P942qbnLPx9mbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOOm824RWgD536kqH/JxTSmFortss58zAuYITCM0Dss=;
 b=UcbHA7kCQCF7fHG9yKZjSGbZ3muSEQEYdzIpukAiFDlKbu6Dh7TTWNtUcU7aN/2qSgmJpfN5jU8NbUUuMaJCtc5Ytop6HXE0iYFxTvJw/ImV2d9Qjv6SBsZOS4POe1ioIcbXklrLwbQQjHKqNohZOo+yoKviOMoLaggCoIqx0QY191t4TCVFLj9+6jPspjD0bT44Hy91unsYDkTU5MSed8VGGBQk28IbOs4DNp5NbR5Z2diVWzvfqQAd19g8PGUEMk8+BTIcAqlnx/J7NdJJuyEb/+gCPz3UX9FOIsQoNwpvN2T/o/5pAakGNM8xaQH1IsJYjzb9IsYc4zYrI/B2Fg==
Received: from CH2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:4e::17)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 17:21:46 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::f0) by CH2PR02CA0007.outlook.office365.com
 (2603:10b6:610:4e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Mon,
 17 Feb 2025 17:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 17:21:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 09:21:30 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 09:21:28 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>
Subject: [PATCH v2] testpmd: support meter_mark init_color in indirect list
 configuration
Date: Mon, 17 Feb 2025 19:21:10 +0200
Message-ID: <20250217172111.67655-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250216140420.216805-1-getelson@nvidia.com>
References: <20250216140420.216805-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4553d696-376c-457a-a4eb-08dd4f778e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xE86C/6tBxra31x1rK36i9g9x2oysmS1LcJZpL5m3KuhKNNQshyD9E9xAqZJ?=
 =?us-ascii?Q?gN0TRvRzoEkNPcyBykYeDP6zhAM9rNOFBDQhGIsRbrh7y2ot0JlX6UkE3SJd?=
 =?us-ascii?Q?kAcbSyuRX4WhI8kcJt2nisHdtCp5+ExTldRrcOSxlWr16K+1h1eHn7NzfH3u?=
 =?us-ascii?Q?MqcBYTD5DoU4Mtjm9cw+XRkHW1LnOwiDWgDnRVCQ8l7SM/hhnqW1WTc7d6pi?=
 =?us-ascii?Q?oSx6nTVWOWOALrKUQwg5z6XVbMSNweBBSC1SnmOGsPD+GetBXy5m0igVkDld?=
 =?us-ascii?Q?aK3o35Jp40ESF+J6N2h5Xa3lDVAHgXN0ft8U6CYi2SA3wAq/N+XJzT16rTMw?=
 =?us-ascii?Q?TWHZ3cbsccZNTGFtyC3JH7gLsbo53ptRiX6NiqXlSaweMdCJDhz5eZ70pZPR?=
 =?us-ascii?Q?5Mak2xPcaRCLKdWsE4YQaXLrrL8DicP1ossjtrlMEN/IYwtm9TWrU770/S5V?=
 =?us-ascii?Q?ps28TE4tYfIQjGHFvMWlupgRgNpmJhCSY/DSkILfWY9hQUEToF7r8mef6lXD?=
 =?us-ascii?Q?MhX396FedmU0W+JCK7KxXLT1JZgCTGS9v/50CadKxliJylI6xzuBuKAdUdlB?=
 =?us-ascii?Q?IV4SaLUbI7nRoeV5q6sU+4CNgcfNnWbJ64TzfSUlCsTXbAeI2DpL+SPLTrYX?=
 =?us-ascii?Q?PMIM3reKqIQSi8O/c5Tmlw42nzeXmCQLH8I7WgzmdJTkMXHG3fRBBVaixejZ?=
 =?us-ascii?Q?asnRoPsWEvH/669NQtH/IEQqlRt5dAEOmRQbUr//uTQHNsf3FutlE4SbSQs2?=
 =?us-ascii?Q?M4pMU/SB5vU9DdddeK4sNxgk7R8ZJt0LJOdWqc4rZSWyOBWeba7LIbALee6k?=
 =?us-ascii?Q?Gw8XZ4tvRLV3c7lDSDQdqgrryZ0oZ7RS4pUVxL/fZvL781S/Om3oqlC7H+5M?=
 =?us-ascii?Q?a2klz8dhysufSkBVgLKhdbtun4ThZ5xQGkVXoGPs+H8qbe64uifsrw2ZttAa?=
 =?us-ascii?Q?xvIBC0C5G9K9BrLZDAPCtDsZseU6+ktVpDxD43fFHyQ0SpBzp9BPx+0GitGt?=
 =?us-ascii?Q?YbHilXa4JhyRHLFYU0hD3v7n5lKw9IC8aMF3OUbl4c6DH37qqPiNor8hb4/1?=
 =?us-ascii?Q?AaDtQwPr/ogXVL4MrFnABcOvQVJINHJTXPsbIX4fwY/MoaiW7IoevEqzH5Wm?=
 =?us-ascii?Q?TVEBmExnOyPzXYkS7i106Adfnc/GPYeWM85IAYA3BnpnFAx1ii5RvqL8eEMU?=
 =?us-ascii?Q?806cauvg+SY4kWv/1O7X7mKBb5AfP7IcPhQoUMvBTx3dLu7DhHcsSIagSg43?=
 =?us-ascii?Q?N1lZ7qcOPXfHHCi5KuQJ81DaBX88XF2ZYsJiIKP7/J8rOKljDOuLycjHgnEL?=
 =?us-ascii?Q?2cC+Ie77DJMqs1l6syHv5NtNMM/kuY/NGfWlvWMeeNt6EIBEWKasv0JnQD/x?=
 =?us-ascii?Q?uNtgj3w4a/i/aL+PkeJaHPkfoJXPzmFarCE+fRkjsarJ2sd6MAB8OIOgbhBP?=
 =?us-ascii?Q?EyxgCdAOTaWmfzczERsizrv57QToKo1wSbP3Vt8kZ1O2YgzLjbBNz82X5JFI?=
 =?us-ascii?Q?JxW52gXOQpcqmzM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:21:46.0408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4553d696-376c-457a-a4eb-08dd4f778e36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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

// create indirect actions list with meter_mark flow action:
testpmd> flow indirect_action 0 create action_id 10 ingress \
  list actions meter_mark mtr_profile 20 \
  mtr_state 1 mtr_color_mode 1 / end

// create a flow specific meter_mark init_color configuration:
testpmd> flow indirect_action 0 create action_id 11 flow_conf \
   actions meter_mark_conf mtr_update_init_color red / end

// queue a flow rule with indirect actions list
// and flow specific configuration:
testpmd> flow queue 0 create 0 template_table 1 pattern_template 0 \
   actions_template 0 postpone no pattern eth / ipv4 / udp / end \
   actions indirect_list handle 10 conf 11 / \
   jump group 10 / end

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
v2: Fix commit log.
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

