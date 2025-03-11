Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE0AC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 12:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E40F4027F;
	Tue, 11 Mar 2025 13:47:11 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by mails.dpdk.org (Postfix) with ESMTP id 5870940263;
 Tue, 11 Mar 2025 13:47:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmX2CyYYhhN+E/ADbcyQ2zdJTR6uF6zz4wWKuFFxm6ItpLpLVUMOgYy1qS+2YWEpAR//SmThYUBKfJP1KtalQOyzYARPpkC0hp+JxMLLlvAAjVLbtJThFBQ7rj3yKzvUCnxxIqhRONwc0tPKOYAQyxSiy21XhIgfeKTOEA9ig6UDrF3PCGwOKQsn0DxgYLx1DOu9xycbTl8CXxX0I87rRlZ4UTQlDAmMqD9IFxJBrT+qmtIp336Skr+1YWK1MbbfLKyF9gQWh6AMKnIoYF9QZx+iU+TrOISNwpPz9T5Oaj1EzpEpNeaeqoS0ZMSKWkfLXN6RFDMxuNB+O04E4CYhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAe3yDpJvMAZTFUjnvdUhe2kls8mNkTDnL9dmI7ra7c=;
 b=s02VBCYxyiXu7CoNQDx1J3BwENG8AE5vtbP7IA4QhJKj0/iVWMrjUC6vTis9kpQA/O3wWZlNlIJBJUYtnnRk8FaWinXCi+2A2cgrpQZEN4U3ePhahXdoWL2xQrZZIegreApyR+973a85waLorXzfiLGtGo+f8WXg/CEPOK5PLHAhnacH8KGL6IW1EI+CEwX3eaa/XrueMhWJ3hpTnjkWaFG+nOnWNuJw1dT/JC3lrYQwRyc3KuUynhGa5jcSA6FTMYgfZclJMyuYnTgr7WkGI+wzLHlESh4ykWWJwSPcKBbPp7E1iQIZSpbyymSwVdsfiCS/GU/5WD+3pg/IR6WFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAe3yDpJvMAZTFUjnvdUhe2kls8mNkTDnL9dmI7ra7c=;
 b=XkBIWwW+/ruGmwa/G3i7IYk/UMs4s7lPfLdjDSXbI/lWBP4QlJgB3IKLTEXu6JBnWutTpHmRzcbSMyJkAGGp7K3wi6GobYuK4ZdwNL/bGfGlXDAVD/ExtKOPusS414zTl4qrthG52xPwxZJL7tVtE2iX7ViAANjKf2wSrUSEF+7XEK48GfgbJ9oeKcFYEv8kZ1Y4OOv6K4YICAtDyOdeP21Vt2lGYsg6jwK8mq290WMlHKRPWyMaBF/EDRA+Mx70yrDT8k8UpXRbFRP5qxoTlZtsC8MorrA1ta4TeJFwhWOFWy3/FOV/vAtKITkGbwFJqzpi/ppRx6lpk0JdcpEztQ==
Received: from CH5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:1f4::28)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:47:04 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::5f) by CH5PR04CA0012.outlook.office365.com
 (2603:10b6:610:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 12:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 12:47:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 05:46:54 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Mar
 2025 05:46:49 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix mark flow action validation in FDB mode
Date: Tue, 11 Mar 2025 14:46:35 +0200
Message-ID: <20250311124635.1262066-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 9620cc6f-01a6-4847-efc9-08dd609ad392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j1og1IYEDvlKXsTrPsCCSWxoMAU6CwR4d859NWjyukE8cQYJ2+IOPj/doyUk?=
 =?us-ascii?Q?NpghyJGntfxkjDLmkVNREVpU2NJq95RoIDcvRq5geRvuX8Vibky6bNHXpZTU?=
 =?us-ascii?Q?5w0PgqYGQsRXBLvxHKQP/GUL5HtmwIWTTVzbIrz7sVbRPh51YEZQ+CvwZxZS?=
 =?us-ascii?Q?1InOv9vxCNXgQVWeyUuoqp2gK7SVldJQHLr//4SGRv39pGnVCanqbLdYgOSw?=
 =?us-ascii?Q?vC96juj6Y2NYdqLqrjhYjaQhs/DhlTtDawfpDeDdhXkwrUwB0UPHxsBZDjDL?=
 =?us-ascii?Q?1/dXA9fZcmbnH+uuBMMMUfg29sT9e8zwOokdivGYdMUKxKCF7diWfx97Wh43?=
 =?us-ascii?Q?ekiNyAXVCtJbrDln17UKeLshj9AujH6gvY+lGQPPrkeUkAz4ZY0rLjKljNio?=
 =?us-ascii?Q?tDNj89KN0DY0TFVFyZ/6SCmKYwmUMFhedOBPEjBdhcPr1fiWJc7FmAPemYUj?=
 =?us-ascii?Q?SlHIKPBSNXYGTWmY0pUR3FQfiv8fpgxyl4zbZE3wJKvRAbR1vMGvUsAO95Eb?=
 =?us-ascii?Q?k2T7MmsZirauVVtzZUUw9jGWk8nz/q6H+0QldugdiYBZ+YkUsmxjrej5jxUV?=
 =?us-ascii?Q?jorNLPq4509LsYeMtmX8NvIGw/2kc3yPk3zTvYweHHKNo4RirzVwYnHd+5yH?=
 =?us-ascii?Q?6RmylSWWKc99+xmc/CGJp/r4vqgH2/i//Hktj1+eycmlFjmD6wkOflN6IY1d?=
 =?us-ascii?Q?wCXiPO2Jzkk6lJajM28zrl1ATiaxVm82pEIi9vtntpa+mON2boILpaQBtwzj?=
 =?us-ascii?Q?lL9YNw7OtF+/DnHQXg8UluvT05zFfItb/ylUDStmTG4OXVLfvkGoIqz8a+Lg?=
 =?us-ascii?Q?W142fJ674u2D2crBlNMMNN1CV2b4dqkRrZBkPgsA1NaHkbNEM+6Bu7GeG6WQ?=
 =?us-ascii?Q?SF3xbSFeRZtvB+MLPEUmBF2JApS7H+I8SKZPENCFqTERTylYjHBXNVN9u6UO?=
 =?us-ascii?Q?XiQ0wrLVJF4Mo88mq6Acl8gnX8gt/bv4N1OhSEvndNDybv+LQpfdgBlJLpAR?=
 =?us-ascii?Q?IrtJSI4DzJPFW4EdLYcsC3LcRk50LiDR2YX4Cowqukvz2hrhaoZCRBkFVqH0?=
 =?us-ascii?Q?ivVn24ll2EcJs82C/2XAfs2uSOuWtzXiAcrXiDbnTiMRAZmS3ruCwILER3m3?=
 =?us-ascii?Q?+28+R7PX43GNzRuFaJS7CHS30AZGPwCD31SRkgvzS69zDikun7iEe/vJARUD?=
 =?us-ascii?Q?RsJV/mhIhakwiRHvKAiIdq+Tg6KPDfMi1dnHSBypA//0gJTrJjF2XmSpS0JQ?=
 =?us-ascii?Q?BPp1i/Mq+UCtKcfSVeZTb/iK7K+4k/36fWy5Qgq7E4VDkmqmLRJiP0CnhvTP?=
 =?us-ascii?Q?EhDi3ShD4fSJg582YNYLl5wY5EExJd2NN/yD3luAIOfMSqXeerkkknz4zbjv?=
 =?us-ascii?Q?KuLkHjAwXGjZSz539QlbvKyLXIqGYYtU62nPub654xS1Q6/WVAmmYlMET+A1?=
 =?us-ascii?Q?OqiR8WEPnVe+S+3jxl33gIvToQ5SQYNwUXc84eW30vK7ZBXoxyNS1juITX5+?=
 =?us-ascii?Q?/dXhPyFd5Be9po8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:47:04.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9620cc6f-01a6-4847-efc9-08dd609ad392
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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

The MARK flow action is supported in FDB SWS mode, but it
was not supported in the early FDB HWS implementations.

The current MARK flow action validation reflects
the original HWS functionality.

Recent MLX5 FW supports the MARK flow action in FDB mode.

The patch clears the MARK action for both SWS FDB and HWS FDB.

Cc: stable@dpdk.org

Fixes: d6dc072aeb12 ("net/mlx5: validate flow actions in table creation")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 6169ebc13f..e2f4bd8cef 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1944,7 +1944,7 @@ mlx5_flow_validate_action_flag(uint64_t action_flags,
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-mlx5_flow_validate_action_mark(struct rte_eth_dev *dev,
+mlx5_flow_validate_action_mark(__rte_unused struct rte_eth_dev *dev,
 			       const struct rte_flow_action *action,
 			       uint64_t action_flags,
 			       const struct rte_flow_attr *attr,
@@ -1977,10 +1977,6 @@ mlx5_flow_validate_action_mark(struct rte_eth_dev *dev,
 					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
 					  "mark action not supported for "
 					  "egress");
-	if (attr->transfer && !mlx5_hws_active(dev))
-		return rte_flow_error_set(error, ENOTSUP,
-					  RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER, NULL,
-					  "non-template mark action not supported for transfer");
 	return 0;
 }
 
-- 
2.45.2

