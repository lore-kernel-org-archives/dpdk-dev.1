Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C2CC021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 10:33:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C118940A4B;
	Thu, 27 Feb 2025 11:33:50 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by mails.dpdk.org (Postfix) with ESMTP id 93A644064F;
 Thu, 27 Feb 2025 11:33:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcnaIR/CO7y8PDzGIllcSdixtgntKbahEqGK7tGvj0Gs8NohXHPc4OZi9S/NMNo+VPihxl65UPo3ZK6bu/8vLNhf2VA//YutPTIZuMUNhGiT70qTXsGzrwd14NcOw3bD0SuiclXuKzTjo/Vw92tUFZempEc780xCwo2CbRzrE3DrWoDPvFrtJHXKaKfQFD46u9WOn8haRwd5rGJlZNmRi2NSkT1lw+aLrojqQeVTqZPzDZfQ7SdupCR1SYkFwFWDRPoO55MNyNcjkdW9Al9KmxeJGatZc2V+dDAQXf2VNyTjDw2i7snftxjaV4R3QWh5CwggV2zupzlidyom8wdpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpOMREvBLG3gJfbFicyUDmD9IihQKnUJaUJ6yxDswg4=;
 b=LBP35fa9ysiqGkwsqtl8kCJS9y78D0+Q3dy7n9TCA5873F5rOucs+ro0H/RvxNx5UoG5I6/9L+/Ax7zb+FCknWsFiUxaYqQi1l8HUGOE8PV/+G4roZclM6Z5Tn/ghYeZJ/FiMIMz9WBg5PaE+lfG/QrD9k6u49GUQzO4jkns3f1oDR/wv8BXTOWfvWpEVyfwEhU0FmPup9FCC0kUitMhJ/GDB9EmV7+Y7YSURcGypKAh1vyeVsh/UkqBWKr2GN4VeahgQXhIn7F2jxikT8MPAb+2nPqc0YW7sBLKg16845hSYP3GWTrjUmCV5Fje5T03Bit0G+j3W4U9fYyjCMbSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpOMREvBLG3gJfbFicyUDmD9IihQKnUJaUJ6yxDswg4=;
 b=ZcxrfyhtDpTGdKOEjoJNOZMuKB3srxWcJZLAT6llbIKgTQbRDkBDmSBHF6w30nPXtfq/BKjaq6TfPblHEwrpjnu3/cGvZRAvdABpAopRnNTqC4jSF1tpTjL29EF05ynUQjFh6BBij3ZNAz9DlB9lCVNDZ0hvsx5E78BxsxsLg5szgdpkO7/o4HgCd8oEBe552/oTUPjwD7zNxEF19Wlio5dCy7lEzI7DWWVAC0sM8GNQvA3KBIrwvU+97jamitO3LSShNasNBFde19mLms8Wd9oTT/lIZ/p0dBKjAhZ0SILKgtOD3cWS7OevbtdDtuy7Ivo7qhubsV1r1A5jMVBS5Q==
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 27 Feb
 2025 10:33:45 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::f0) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Thu,
 27 Feb 2025 10:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:33:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 02:33:37 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 02:33:36 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 02:33:33 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alex Vesker
 <valex@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH] net/mlx5: fix crash when using represented port w/o port ID
Date: Thu, 27 Feb 2025 12:33:29 +0200
Message-ID: <20250227103329.93196-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 007c4b46-71dc-44e0-b826-08dd571a365e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?axnXZFIUd6PJMy/3c4WkUJrtg9xPBRgAo2XSCt0z/eCTUvGkpozNxWw1upsC?=
 =?us-ascii?Q?xvbIhQJqw6wfyQtJT/711PA3Eq1TGKeFni/CGS6Zwo2C+J9dPwJucnJ6cGVt?=
 =?us-ascii?Q?PCZKbbmAzITdrGXMeqflxOusxERZCqD79mqjs0ke+tBwibI7L8x2m42+rLVP?=
 =?us-ascii?Q?odpRZOHBEAAevQ7lcV6K120sqeFw8TDHoOIonl5gtJH22djRjNcQj5MWRJSZ?=
 =?us-ascii?Q?CAahJzEQ/q8gJshmeOobc5B6wSCME7xr0//LOZjXx2HzlSjDaPeAXyO8Aw21?=
 =?us-ascii?Q?ntw8Z313+ocum9rnCT+qwW6MeeqUhhTHTvSCdaTuhBES5lDzrA+OAhh/cmzv?=
 =?us-ascii?Q?Fu8d8GDEqNiFf+rJOuiCyxmMwbTTnQLVlTxy4BweEy4s3ifprZd066SEzr8Z?=
 =?us-ascii?Q?wlSEo3B5KkZ4ZqsT0Tr3mvA88onbBnmJ5Jk+o/E8DjQ802oO3R7SCIiRncEb?=
 =?us-ascii?Q?Gp0wDUI9lYMtn1WjnuOZCMhTdbMRpGqcoxF6yqTK/iJb4DkGgJTCecaMLac6?=
 =?us-ascii?Q?KRDvintNV9TOLrSmS9X/oxXJo0JbH4d/OLCjhgvgmd5FmJCADmCuCqcrTKLS?=
 =?us-ascii?Q?Z7b7yzjSgjkuaH0Bh4oWmHP0LRn8cLU/wAzURb+LcPVfWnHCtHZIwc9543/Z?=
 =?us-ascii?Q?Bs59+joGBe9GuMtm0YkGyaA3wmmRf/stOY8sLutIxwb1v6BZZTvLI+dlvHOg?=
 =?us-ascii?Q?+8eZ4UyL5LERYwrDcvsfziUcKVPVll3ruOTLH2NKCQ8mW5LySB99Nz1dCZk4?=
 =?us-ascii?Q?W1XxWMH7HO6NKcQAnq3CtbMvzbjqtTnjvjPQwd0uU8FMYicxiHCR/mU64z8d?=
 =?us-ascii?Q?DwTYo0P3QMbEMQK0fs0ccfUqApx+8FZw/2YvBbjjrRSQEX6LDa1X85aafCN2?=
 =?us-ascii?Q?pxgAqULDcEgRLlrWd3TXps9vaOeCVe1sg0dZSxF7nUHLi+pr5TPWeFl/Gi6x?=
 =?us-ascii?Q?/IuknIeMwmxh/iB4Sf0N8zqYRvwf0oygfH4F5sDlONPGCpZ/xHsk9qrZf5E2?=
 =?us-ascii?Q?fQV45EozNr188NzlvyQ51HsyJbKgq7s29Cd1roGJTl2eK/5GWZYMmaKd0hKz?=
 =?us-ascii?Q?AZEo//I1RDkEnmoJi8UFO01sZA68DozB+JExcjbCcrNZJTVeQtV8n7anMNmt?=
 =?us-ascii?Q?mJvJmQhIXUfEK5oLOxGWgo2xSbnqmyS+wSjeRRaS4kB7B+7gMv7a1P02XTtk?=
 =?us-ascii?Q?tR/h7jw9JdcRcdevpSUnPy5mfk1KR35BcqCStsNhc8mriJf1ANIQHshyE/Xp?=
 =?us-ascii?Q?MoSsWbj0yd/p/TUYLWIIHjwfiPQfUgCIqOFDI7J41slHqg7+PnVPbTO3Pa1v?=
 =?us-ascii?Q?PJA6e3knl5sZGQAW/3If4RdaOLM+cFchMNlV9EJal/7bxFt8TgoCrW2oE/pN?=
 =?us-ascii?Q?N0DY5qiCZCVQlBOzhjo6KB3haOnJJcYMIJCbHjjt6+JU11GHsviBcQv/NlNr?=
 =?us-ascii?Q?2cbaYS31iU9Aanip1PcGTK14/mTShZVSfjHttRx2h6ZQz4azBvD5ZzFqHdd/?=
 =?us-ascii?Q?Srss+voYEhjWnbU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:33:44.8640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007c4b46-71dc-44e0-b826-08dd571a365e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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

For non template API on top of HWS, when trying to use
represented-port item w/o setting the ethdev_port_id,
it crashes.

Added default values to match the case for SWS.
Default port is now eswitch manager id.

Fixes: c55c2bf35333 ("net/mlx5/hws: add definer layer")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 98d670fc1ce..a4b9306d2b8 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -772,10 +772,11 @@ mlx5dr_definer_vport_set(struct mlx5dr_definer_fc *fc,
 			 uint8_t *tag)
 {
 	const struct rte_flow_item_ethdev *v = item_spec;
-	const struct flow_hw_port_info *port_info;
+	const struct flow_hw_port_info *port_info = NULL;
 	uint32_t regc_value;
 
-	port_info = flow_hw_conv_port_id(fc->dr_ctx, v->port_id);
+	if (v)
+		port_info = flow_hw_conv_port_id(fc->dr_ctx, v->port_id);
 	if (unlikely(!port_info))
 		regc_value = BAD_PORT;
 	else
@@ -1585,10 +1586,11 @@ mlx5dr_definer_conv_item_port(struct mlx5dr_definer_conv_data *cd,
 			      int item_idx)
 {
 	struct mlx5dr_cmd_query_caps *caps = cd->ctx->caps;
-	const struct rte_flow_item_ethdev *m = item->mask;
+	uint16_t port_id = item->mask ?
+			   ((const struct rte_flow_item_ethdev *)(item->mask))->port_id : 0;
 	struct mlx5dr_definer_fc *fc;
 
-	if (m->port_id) {
+	if (port_id) {
 		if (!caps->wire_regc_mask) {
 			DR_LOG(ERR, "Port ID item not supported, missing wire REGC mask");
 			rte_errno = ENOTSUP;
@@ -1603,10 +1605,6 @@ mlx5dr_definer_conv_item_port(struct mlx5dr_definer_conv_data *cd,
 		fc->bit_off = rte_ctz32(caps->wire_regc_mask);
 		fc->bit_mask = caps->wire_regc_mask >> fc->bit_off;
 		fc->dr_ctx = cd->ctx;
-	} else {
-		DR_LOG(ERR, "Pord ID item mask must specify ID mask");
-		rte_errno = EINVAL;
-		return rte_errno;
 	}
 
 	return 0;
-- 
2.21.0

