Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F3C021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 08:33:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C17142ECA;
	Thu, 13 Feb 2025 09:33:24 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by mails.dpdk.org (Postfix) with ESMTP id 994FF4028C;
 Thu, 13 Feb 2025 09:33:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcamkiT8jbO/JM01ytyiiQsHoZ6/j3pkZO5mJrDGnGgb1DKPx9m0xCN40oANI4Oj3pgPXaF1Ttfhc83fRuDT5g32zSs6WhPOffORH7zbKpnRMp/HxgdByThVWJNQVLm9VkmutVTsAEpgX/i9fCaAQl8/DbNWqIzvEbfbU46R6Kw+ZElViLKXK0xcXMMm6qQRu9mjagj8y1C8CBv71nBhyarG4EhkNzAsAF10dqQLCTDXWKTNzncaiMq4ms0H/ujlBdnlMsCN5zPW74BskaYeOV3yt9lWZuzMVs6bHe0oJGVWR/+QqmWlDVsdQCIeFd15+i42Ay6XOdGAfWWsyj3csA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6Q+IogNE4TAcMQ2clx8NBdMFRhq4cBrR7zvQ6p+S38=;
 b=jF24RQYyXDmbu2Q/EbSZnJuKLkuNylsNoGki+UQXRxgxda21TGMxACwcq28Wpu788ISbo2nqvOEnaqrj4gSXy1eark75zSM8XcPzDRzB1bt/r3ERD+mSt0ZXTC7uFUimAoTD0T5M2MHB4ywWG7qy9EbFavv2VBGQt5iIwLsb0TrGpBF+apuHl6UmbDY8k7118tfcAOhHvNF/Y6sLAlOVz/w1E2y+X9WeYmYS8jPllRgFY0Vq/L1GKmC6fzuFtbNC9uGfZuQ5jt189ks0YAIZO1jpKTcCXVDM2xvukdYzxo3d3R1j5pXa7W1WjFQ7SaeavmZHCsq6UcfFBSo6iwmHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6Q+IogNE4TAcMQ2clx8NBdMFRhq4cBrR7zvQ6p+S38=;
 b=IL3mtAhMAShKLRlGYICibTylrmfGXZ7aFmiJ1VPGt5wKDujPep92Jyz43kYhb5/VvzSK2XMTbtnGJXksv7OFFWAwQ1Y4zwAwTzlhwC6reTDtGl8/3vpbxqP/L0hsstroRLguRhgYFs/4NsGd8elbs9ytk4GQWddEh/lUOi2S3vwfNEY9igj5v/yXZwCm5XY9GNiV1FmmLC9LdqQYcMttGiyMoj75c1P7xGu2G7/sIuO1r19GuIQm1A6GsuS58HmZPftVu0mo8e8xkvCWY5mxgKd6xWMoiniJoMZ2ZwlULV/VdJ7aJtYsCxA3zaDrNqEwjFVIEdLOvRz20JYBA2XNSQ==
Received: from SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::13)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 08:33:19 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:3c4:cafe::9e) by SA1P222CA0192.outlook.office365.com
 (2603:10b6:806:3c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 08:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 08:33:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 00:32:59 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 00:32:56 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Tamar Mashiah <tmashiah@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 2/2] net/mlx5/hws: add DROP action to multi destination actions
Date: Thu, 13 Feb 2025 10:32:39 +0200
Message-ID: <20250213083239.94360-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213083239.94360-1-getelson@nvidia.com>
References: <20250213083239.94360-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fb7e0e-1f56-4a5b-e958-08dd4c091188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wMdHZ2cE5jmr2iVJnwwOnNJho5ywF9GpvQMyjDZv7RNILhoDAhj55SS0RQPz?=
 =?us-ascii?Q?HOk1jNnIM9ZXQB9oFXcPvimKNvdJwllNvZ2kds/zCAaq6lrZIhrhIcVWtujc?=
 =?us-ascii?Q?1RGe60QUgPjP2QFZ7hWGLWGw++O45onG7sjQe9gePccvWXlPTJ1146eWKqOw?=
 =?us-ascii?Q?MWcFq7TTvcgzjdLh8JN2KM7cW2ZvFC60inoc8qFCAhq6NKpRMRcnfLy3uhVu?=
 =?us-ascii?Q?mm+ET91wOyBpL67VivYoRPdV5akh2lYC6FSFzUs7GuknE5sAnoyS9GpSNvJI?=
 =?us-ascii?Q?wOq+SLH8yAx81rH8fTUWTwnmOlfVj0PkU6zPyHOik9yidXp3vXaVXecg/rV3?=
 =?us-ascii?Q?MOGLMUrQI4urWwJ1btoBNnshXXzpVvcTcQ5XjXhJl+pxyfbj916yW0FDS5M5?=
 =?us-ascii?Q?CxhsRUqjDRzZy9JoXwoOO5HIkbOVSvLhJE6EK+UOh/oc5TlqHL14N2uvWaHt?=
 =?us-ascii?Q?ox9rrKiHMye0McmwGBhNuz3A8GAjKxfDWSUkH+PqoYPmVmwq6invDnfjI8dW?=
 =?us-ascii?Q?3je9lIELZOeL3qTlRwixvunPZ/8mbt/z+7QliMqVEoY38d0SbDFQWfBKvK+T?=
 =?us-ascii?Q?diXURgD/QhqJX/XdJ3zFK4FmZayomlb99DzLZmuyhc8aFfVrCCrs8pwmJFb4?=
 =?us-ascii?Q?LgvL8+qi+IanvtJVdbr8hARvdRMS8fZIDbOlWwgWPmAcJwtsbyXOiEsmjzID?=
 =?us-ascii?Q?hUEh261Oiquy+YmG8YAjl3jJED/F1Abi3RCDLs9DHtY+3DZ4MoQ8IYUhbbxK?=
 =?us-ascii?Q?avKq8U0QCjkBd+zwqeurssG6QmCPK+lYxofhHdXFlumx2EJ6OZROMiJ7pJKD?=
 =?us-ascii?Q?sDTxM/Bmf78wqvAmNgE74gHrh6XZjeR186NPCM1cK6twDznNTzJ1Lu3BLVZC?=
 =?us-ascii?Q?pftMyAaakAr7gqllvffcCFxh6r/nd9PZgWKLp4oePUfkzOr7wPnZsSyizczK?=
 =?us-ascii?Q?IZwLaJxSw3Vx/U2nSm3cb93rmtNit+JGq/iMqU9wqiNxk78gDWoEO2e+VB5K?=
 =?us-ascii?Q?70oNTwrMdEkuAx7AXq8E0YKY3IaO4Ay5apjUOSRNqKaR6nnO51cwtTyEa0BQ?=
 =?us-ascii?Q?o2Cctv2ziTEiH9zrJn99BrFx+We2NhH5XA12LOmhCp7hoGld6Mj0Bj0I8p2J?=
 =?us-ascii?Q?Sup1HngE72dHGcMX4n5YGn8ziI6I3RTGfUJvACOCT4oHaym16pEHzDvzkaUQ?=
 =?us-ascii?Q?t+CXn5lm/NZOzWqY0+3v6bf82vZNaa3VAvLB2J42O/j/PVZIXEzBi9gFETrh?=
 =?us-ascii?Q?EfHnGGX4WNhy0pgrYwIiUa0nCZ5iAwkc50dcXdqV4coisWRSLd6tgvalSdtp?=
 =?us-ascii?Q?Lx9weHyQSWp4GVziOuJfkWUVjO7VIAbFu6tGti9qekOVcOT/elC/nWlGB7EX?=
 =?us-ascii?Q?+1OwIvr/d1EkfxkPZY+jmr94MBFpk1nodkJw4XqDII4pN8X7IpuBae9TddC5?=
 =?us-ascii?Q?3h8MIaWRnu+pTj3LgNMiSMMRhM/2ldtjeLyGc+Q93AgLREeHxnp6WEmG8aWY?=
 =?us-ascii?Q?86yXOi1NlzIRN7Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:33:18.7674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fb7e0e-1f56-4a5b-e958-08dd4c091188
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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

From: Tamar Mashiah <tmashiah@nvidia.com>

Add DROP action to multi destination actions, set NOP
destination type when DROP is specified.

cc: stable@dpdk.org

Signed-off-by: Tamar Mashiah <tmashiah@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_action.c | 4 ++++
 drivers/net/mlx5/hws/mlx5dr_cmd.c    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index b038ca6879..309a55629b 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -2389,6 +2389,10 @@ mlx5dr_action_create_dest_array(struct mlx5dr_context *ctx,
 				dest_list[i].destination_id = dests[i].dest->devx_dest.devx_obj->id;
 				fte_attr.action_flags |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 				break;
+			case MLX5DR_ACTION_TYP_DROP:
+				dest_list[i].destination_type = MLX5_FLOW_DESTINATION_TYPE_NOP;
+				fte_attr.action_flags |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+				break;
 			case MLX5DR_ACTION_TYP_REFORMAT_L2_TO_TNL_L2:
 			case MLX5DR_ACTION_TYP_REFORMAT_L2_TO_TNL_L3:
 				packet_reformat = mlx5dr_action_dest_array_process_reformat
diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.c b/drivers/net/mlx5/hws/mlx5dr_cmd.c
index a4f778a8a4..2127757aab 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
@@ -239,6 +239,10 @@ mlx5dr_cmd_set_fte(struct ibv_context *ctx,
 						 dest->ext_reformat->id);
 				}
 				break;
+			case MLX5_FLOW_DESTINATION_TYPE_NOP:
+				MLX5_SET(dest_format, in_dests, destination_type,
+					 dest->destination_type);
+				break;
 			default:
 				rte_errno = EOPNOTSUPP;
 				goto free_devx;
-- 
2.45.2

