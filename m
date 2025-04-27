Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C74AC369D1
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 11:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D89240263;
	Sun, 27 Apr 2025 13:28:42 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by mails.dpdk.org (Postfix) with ESMTP id BCC544021F;
 Sun, 27 Apr 2025 13:28:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KslxfKehAoG1Od9ws/gHk5fODyLpnvKFrTWMmZP5nA6ZiRkXYA96hxY2I8nYFCzgC3msNJgMD3+LU06nwkvdImppKndrjq1Fly6fumON6htuMNDV22EnOpvzgGV7FL983TOk966IUIzvfCvu9+xCmQx5eHg+zJcWMMQp8HL+8flfb9nQBU0gnhpR0J+BGi4M35XOJN39WL3rCsSMdcKl+YC//6Bw/5ONuT8R/mCq1wKlIh9CIx32hdYQtfY4zg5ShuRrJyMxTmWq3RkKGcHxaImzrQT2NGEo0NFAJ5wlWSDgLQ9RsbQy4rZ2PutEWSENjTETSsLJKdleu43O/oqGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrJEe6ijV2xa6IFnCyUDRSwA7ayGD65rmFv2wqoT5ZY=;
 b=ScGothopP5whjJfLnt8UKkkc9U5C7UPiwXXPX/Fkxsrn51oVrwEI6BxWgcoHQg6P24M0bILxf28Dqphq1WWNCTVAQTn3F5BfHUlOK3z9+LVM56V2XYn7Qjnz0v6KjlRXuWhuXcW1Qt1D9oNV26tO/kZVHbIJnODhp0MDH2N9lhhiS0k6TyUg+o2Uf/FCM6h4Pi0CGyCkaa+G0+LhegTDBcizAqI2r8V+GPLRd7zjAzxkwZWeDesRHPwALv1/AuFjb4WI464hNW/35r2hv3/PtI03zOPW21/XuifEJDjsP4vN+JLwI5HSGnOMcBevxYxIU5iT9e5lnBkaxctNbtTXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrJEe6ijV2xa6IFnCyUDRSwA7ayGD65rmFv2wqoT5ZY=;
 b=o0pIcSDJR5lc8Fal+VoIRTUniDgGC8iHkywrNLnEy7qo18QKRF82XEZZARRCWkDEuD6qrIIp4UYd9CXEus1ynkOQtkeA6rp9O5DTUqOu8JWqIKsXmb8E818coYWpQqXHieebNHkyRBsaHTqIwcMtoANS/kD/TyA0vo7lr/kgoSjYESVi3ZLKmiUfKO4cEzAzfIFI52SoTNVvXACZsFdtx0Oa+XqaP9bFc4RybzGfLvCMLDD50OclpRUhoLiHRtRiZFxS3oE7DbO3MX4dCvuLqa6VXXwoNFB1FCpGM078l2EreIbvV9SQo13H1gbmz5SFqzIZ49k5HB4J7chOcH/aJw==
Received: from CH0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:610:cc::6)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Sun, 27 Apr
 2025 11:28:37 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::fc) by CH0PR03CA0061.outlook.office365.com
 (2603:10b6:610:cc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sun,
 27 Apr 2025 11:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 11:28:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 27 Apr
 2025 04:28:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 27 Apr
 2025 04:28:28 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 27 Apr 2025 04:28:25 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Alex Vesker <valex@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5/hws: fix send queue drain on FW WQE destroy
Date: Sun, 27 Apr 2025 14:28:21 +0300
Message-ID: <20250427112821.108929-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: faf787e8-ed2e-4558-efde-08dd857ea729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hxhgn939K8t9l3eWZtC+sPc+Z3x9rScsIPIFuBZZTD5NIZb0gcD7RWuojka+?=
 =?us-ascii?Q?hLWt/PaNCaWY0vydhsunWZQpDhWF+XgYkPXbco+phYR+0fLfhh4vDONqmBkN?=
 =?us-ascii?Q?KqVap0j2r1UVyUZ+Rdp6lCbG08iP65RhhlNDnLPd3nwAhdLI0UEGLCYCQGKE?=
 =?us-ascii?Q?OvnzFswG0IEHR0KoAlRP3gytXzOx6JjQxslWRPyhLctzwb48Cn7N8/TPYi40?=
 =?us-ascii?Q?XO9UZxSlxMe1TLZuD+KeKvNX3/lC7nThO/CzxQQrFQzt3ouJJxpChd1P+sR9?=
 =?us-ascii?Q?YWR7MYmvZ5+zM0U55ehgsTJLfUvDo6MtUyYOqBtSUbb/2veKYF8piJfR+J3f?=
 =?us-ascii?Q?Nmd7iY3ROLTzlKrAAZQPWOE6hl5RGN9C1hmaSLAm9wsQaH1+gCRObwDXGvcM?=
 =?us-ascii?Q?qY+gT/y00oJzeXEwFNhe3bwlVI5mn5ctUAoZYGVv/4Drk3tAG3AvNOlZ9ElD?=
 =?us-ascii?Q?8mnxmk5T8dABdg+FrkTecaqqpOIatfSRD+VlncKdMUYEUQC+5XXSBzZS1vYU?=
 =?us-ascii?Q?umuY5zJKv/V2gIdnE1jD4nNoJZApl8uPUJnjcrv5Vs4WdFxUS8Ro3ZYs68l6?=
 =?us-ascii?Q?REVDjK5LsITQI8t/+YiKB9G2G85dAaSfZcsEMxVHTfSJ5XVjwcB5YqKoty/Z?=
 =?us-ascii?Q?B3Mvg+EyzgC1GraWC0CNynC5g8gfBfOfONVHwwY4I8iBs0mEXOkczSzuU6Hk?=
 =?us-ascii?Q?uL5zecJNpDvm8XVajKnVDLSeXS2th5V59L5u+8zKG3lrWmCv1RoTuiNNe/Ph?=
 =?us-ascii?Q?Dh4qx54XGQ666dEpy0yhYtcNQw834R/wAbep89uQ9HZQNuU772FDJsrIrQmJ?=
 =?us-ascii?Q?FfevhJdSYAM7qfeqQIDBbEmayUFQO8wKU/Ny4ron5XZoGrAimwbD7Sp429OD?=
 =?us-ascii?Q?ulV6j1I656WrSp+GNJiZ3JGFs3kh28w9HefZYXd0sJFNc4Jn0K/ToYILes1K?=
 =?us-ascii?Q?Uj3I/cqa6iKQ8g7RjPJVGlAN3Qqd/P1X/m+71yoOUZgRtjDHtlMxLAdSSZp/?=
 =?us-ascii?Q?6CSeI0zwTPFYKzWlaWnGdnA/FpKSDYTR7AxT2RH66B/1XkGbrVm1F1uBF4cM?=
 =?us-ascii?Q?y0qmx5+uuNXYsixD8cx3HqJjOecLxgFoqIRGgcFR6BX4ktOguwa/xr+XeDBv?=
 =?us-ascii?Q?L8K1QKjdu/pHwMymXfjYfVwiHKaGk0br2RPj7w3ncLq8d055BNJ+SJh1ddv0?=
 =?us-ascii?Q?aRlOJTQhIHZ+fXDBVYyitHRA3PYGUsQzDqRRxgnFDB5R81ok7050CadEGCkp?=
 =?us-ascii?Q?GyxrCB4uBsmdqflAjp6GRfRIddY1DjsK/WPTaRxkWaWKa1TqTNG1LEozUBK3?=
 =?us-ascii?Q?rrGJ5wCORGLOiMdmu/RqYtbZHWW8PqMThpx3VNjYPsdHr8JaEcX/9YrIOTSz?=
 =?us-ascii?Q?AZvORGsJJZEgyJm95BOikyO5Mx100/Mf9v1izYQ/Yc1Uo+jjrsd3mToQ5vYI?=
 =?us-ascii?Q?UHjWBP1v97vQgZX0Z1BeiMTizpkQwTzC9DMixtgQ/Y27GKBBc6an8pNbgELX?=
 =?us-ascii?Q?3SX0JU3ApY7d0dYHdTwRzENrF07QS/lKVbsP?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 11:28:37.2301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf787e8-ed2e-4558-efde-08dd857ea729
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
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

Queue sync operation was skipped on rule destroy.
Unlike on fw wqe rule create in which both fence and notify_hw
are set to true, on destroy fence was set to false causing
previous queue operation to be stuck in the queue forever.
Example:
   rule_a - HW rule, rule_b - FW WQE rule.
Sequence:
   rule_a destroy, burst=1 (HW rule put to queue but no DB)
   rule_b destroy, burst=0 (FW WQE rule cmd but no queue sync)
Outcome:
   rule_a is stuck forever in the queue - no completion.

Fixes: 338aaf911665 ("net/mlx5/hws: add send FW match STE using gen WQE")
Cc: stable@dpdk.org

Signed-off-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_send.c b/drivers/net/mlx5/hws/mlx5dr_send.c
index e121c7f7ed5..d01fc7ef2ca 100644
--- a/drivers/net/mlx5/hws/mlx5dr_send.c
+++ b/drivers/net/mlx5/hws/mlx5dr_send.c
@@ -339,7 +339,7 @@ void mlx5dr_send_stes_fw(struct mlx5dr_send_engine *queue,
 	pdn = ctx->pd_num;
 
 	/* Writing through FW can't HW fence, therefore we drain the queue */
-	if (send_attr->fence)
+	if (send_attr->fence || send_attr->notify_hw)
 		mlx5dr_send_queue_action(ctx,
 					 queue_id,
 					 MLX5DR_SEND_QUEUE_ACTION_DRAIN_SYNC);
-- 
2.21.0

