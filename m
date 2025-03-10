Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B0C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 11:20:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FEA3402D0;
	Mon, 10 Mar 2025 12:20:39 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by mails.dpdk.org (Postfix) with ESMTP id 751E640151;
 Mon, 10 Mar 2025 12:20:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdkeIuWujhBMergkq4muQ+4Cko6kDs9wBq6nG7vv3cGDEsdFFXPzBpUL9X+mY3V1akMKyMcFpP4YvwN89+1OgUFP8P6cXOa62AnGCIrYS0k3/R9SupspigJ4gzzaQnfRa1kKJZLm6K8NrMcaybxVNbGb2lpC8VCvysm0G41VB93itYe9xUFx38JsolaWOc9NF5u02EHiDw0opZ/5q41hMKu0PFjWPMQjvSjNJ6r207H9vfv5wTNNr2BY05HEhLos0OoHix2egvsg7PNN+oHiPAZsgXmJc9XuLpceQeYZs/BSZ1IHLtmAsAV11gDLzVSEAguLesnDNZqK9QiHs2eW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5NVZFoHihysA5XPpjhFqfiV1k7jLnL+KVOjX5StsjU=;
 b=TE+JL3q3ieJBr5MHRdf0IOpmXkiIpheE7LmpOTUKtRhDtbxVXuOP0PSAOH/XLsgDGTwh92FUwDlMgxvRZul1IzXFqo9FfBbGJMchyV7dFr9SxRFQ//vVxrVBzBoFcHOnr2RXCROhE+LAdpHIj5mailz9NN9tT9CQp4lJp2X1J4IR3ic5d7uMiyYeNDDFjIDpcIHAVvzp190UFJCkmMZsHqQrhbkLDtcftv0M45H2oAVwAIjGCQThAKyem45LsYzBTJiVsQDD/+VrnIqQlqgkp/b5KZa7apTKx/yWR0uxGAnHbMWkTazy1VhdBqVD5+z2B3RIWmDJE7djpQNuFPBa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5NVZFoHihysA5XPpjhFqfiV1k7jLnL+KVOjX5StsjU=;
 b=OdO3vQW5dxDJ1BQqk9x/sr/VQgo+omjRcFJK2uCs+udqbV4eXKVysak13uI7NMEucj0x88f6lQO+FYxvhfQjX1rMUyo6w7S28/ZGA23jB2KYCDOGAt2NcCt3qmJzKiuZYMVtTFWU0ZWx7Yh4vVXGvG6lQ8RTtIS6seSvkKTf+nhJjTBlDgNwx0TGCIDLCgmhhQvdQNt5DRtkr+KJTFW39WO5AXziei/OVttWkYlo16qPXQCddwhwPCv6ePAGvs/s1+XW+HBVZXUtc26vgdbKLCyKtObvZHNZK3db+REoeLPua5jTiQX/nRQVfcOvBR7bb1ZCnlafZ4CFO5VkQ8ivsQ==
Received: from BL1PR13CA0071.namprd13.prod.outlook.com (2603:10b6:208:2b8::16)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 11:20:33 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::80) by BL1PR13CA0071.outlook.office365.com
 (2603:10b6:208:2b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.18 via Frontend Transport; Mon,
 10 Mar 2025 11:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 11:20:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 04:20:12 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Mar
 2025 04:20:06 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix IPIP tunnel verification
Date: Mon, 10 Mar 2025 13:19:45 +0200
Message-ID: <20250310111945.1144018-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e14ed04-0554-48ec-cb83-08dd5fc592ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QJbJs7ratkQ826q9OzJ9jNULhfAw7ejyWs5whuq1CWP292lWKZRdV0tWvrnK?=
 =?us-ascii?Q?UBgujX/R0dlDHzyUyDsUQOu8Pb8LwZE8NHAHSM2/goAHW8ri+S3k/5+qTejE?=
 =?us-ascii?Q?iukr7i2Nd3VLHyXpnTuwtiOL31/ecXMZOQ5KdG3ocfrE1g/+bb6BD8s95jM/?=
 =?us-ascii?Q?4uTnaETTJ6qMqWNbrd0br/nzbZarn6+FZ3TSIj7PZ8YiVbSDHDEozolr1c01?=
 =?us-ascii?Q?qIhXiPG9i8zRAyGUuqpZ/nCE/dJKc+kVCq5iBS+UHlSYl+0B2KXtfRkx5OMW?=
 =?us-ascii?Q?m/As7ex6EWbt9uCNnCmiXHeTD6j6wY8VlP/7kYQRSW3dRSQc714jSry+HE0h?=
 =?us-ascii?Q?UXhrd31YoMp/Iw7Ac50zEs3NmE1NWTI4oSNIrGBMBDfyh2VMlgMEerojQapp?=
 =?us-ascii?Q?eNBkDn99ynvGu2iqCyKA03+orDaBBFqOms2Q1o0Y36uU1kX9NKtgSxo2AcdQ?=
 =?us-ascii?Q?TjtZ7lNiSNgY3NRZBEyRC0TMMLrWIm5TU7IDjn/v3N5E2X1IDhDnRFORe4IG?=
 =?us-ascii?Q?vI1EGCZOUlq/5y3wZE2HxkRGXT7ShA46h2a+DRTjPLgTi0860sDl8/5OOoVr?=
 =?us-ascii?Q?Wht9lYPz0Lv2QjksFZeErJQcH4I7BulpcJC/VOCpu/w79e+dxDD2YKYym5QZ?=
 =?us-ascii?Q?F9mQU7ImOAZFc8/7JF1tf71XNzUmMEy67XXqgPu6O7vkDdKGX6vjgfutyrGp?=
 =?us-ascii?Q?2ubUDMebjJJLwV2hLAD1iAKn+z0lnvCmzXavVL3PQ9eZkW/QXExZKmCECIcG?=
 =?us-ascii?Q?e26/Mb27Stm8ZpvI/+MAJVbFVppZ+2tWRdE2fX56e+9LiYSQIGU+RhPyGV5x?=
 =?us-ascii?Q?NMd7UnfVtGDA1NCR+IZUyzO0TENU9m0+MJnXeMT35Vpq7FCdrNT0RWzfew8a?=
 =?us-ascii?Q?LyNVqX8krQ7PO+ivCoLp3zDrvqWIbQvKEA6PSmPcvo9ZVFdwqZcFZOWFjFj0?=
 =?us-ascii?Q?nbCIh/PsXNhpsIoVbtHXPAgT9IwZx4BOG7BBn54b7OkjpyZf1MDZozFR0yxH?=
 =?us-ascii?Q?qveAcl/DXYWicVC2J7vQuotL2idqsI7G6KQIg1AjTI5jF009VnPbe5zhGBp7?=
 =?us-ascii?Q?6aSmOvrcDVjNKkAxf99z5JyLvdImBY7BBjZvsL/1Lrwmhdjzjy7e61fe/rmt?=
 =?us-ascii?Q?Lx52U6AD55d5EivlPQQVXqSNLIkskSSBh8YTTr0KvGcWL1Ik8C+vz7zqFC7t?=
 =?us-ascii?Q?IWUEumePf9PhAFlswEeJ5g3Bs94eZQZGtVCvRNGx783qwPTHEhXkziZIUFWn?=
 =?us-ascii?Q?g5L0sD8qESBCNdsVY6qBfyXM0tFXzcTCy4uUSpmHTbDVZv8wLtQUQLKZcwZL?=
 =?us-ascii?Q?wD5zutlWicStg7VNt4+hkT8QoZqxHG60AEmqsZJxQxsE8kI11QIqUxzXJS6b?=
 =?us-ascii?Q?g8XYv6Z+D+c11MjEzvmUmoUJO52jfMndm+mir7jnJQmKX0KMgHs/LsOXmNYs?=
 =?us-ascii?Q?58tgvKLIYOBrF/G5yAx1RHDHTwovP3DW+6Oz7I5i2Fw3oRQraq0DwpqTu/Lo?=
 =?us-ascii?Q?IHBvRNkAcWhz38k=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 11:20:33.2973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e14ed04-0554-48ec-cb83-08dd5fc592ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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

Assuming a case with the following pattern:

eth / ipv4 / udp / vxlan / eth / ipv4 proto is (IPv4 | IPv6)

MLX5 PMD incorrectly recognized this as a packet encapsulated as
VXLAN and IP in IP at the same packet header level.
This caused a flow validation error.

This patch fixes the inner IP in IP detection logic.

Fixes: 2db234e769e1 ("net/mlx5: fix IP-in-IP tunnels recognition")

Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 61d3101ce8..2d03a3f480 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -7925,7 +7925,10 @@ flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 				mlx5_flow_tunnel_ip_check(items, next_protocol,
 							  item_flags,
 							  &l3_tunnel_flag);
-			if (l3_tunnel_detection == l3_tunnel_inner) {
+			/*
+			 * explicitly allow inner IPIP match
+			 */
+			if (l3_tunnel_detection == l3_tunnel_outer) {
 				item_flags |= l3_tunnel_flag;
 				tunnel = 1;
 			}
@@ -7949,7 +7952,10 @@ flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 				mlx5_flow_tunnel_ip_check(items, next_protocol,
 							  item_flags,
 							  &l3_tunnel_flag);
-			if (l3_tunnel_detection == l3_tunnel_inner) {
+			/*
+			 * explicitly allow inner IPIP match
+			 */
+			if (l3_tunnel_detection == l3_tunnel_outer) {
 				item_flags |= l3_tunnel_flag;
 				tunnel = 1;
 			}
-- 
2.45.2

