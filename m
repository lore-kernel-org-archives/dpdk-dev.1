Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7061CCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 168C64066A;
	Tue,  4 Nov 2025 18:48:01 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62]) by mails.dpdk.org (Postfix) with ESMTP id 0464A40653
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:48:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2iqxt6BayCh7FiJL8lkfZhXJunVsGMkfUpIe0dLUdfb5AJzEUzBlyBJompTfv4+IiUO/eXQ0uYDK0X2/ImKpkJy3ul+iFeWUvAGezhzaCQeCmPH93KqFs8JpjM1H571wMvIskZ6SD7H5qX+aBNvNXOf3FHvD7REUnhRJS7OdkHaOt6dtrys/M4xPCAwkVSHKzclupwMlaqC6iYtM5W+nRdr3H/Zxr/py0T8LMGj2bwoJeih8iH9MGGCAjzlWVKZIRYGotwTMEI4oHdUOL7fRgX5I5jfRGQGjbxqMIDGNrLhgZdsquLRqdtvNoU2GLjnoGw3jN8l+/0EQYIGPqfN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tQl+JwS0UVOySBPDVdVtmGdshi9jw4VQWqwdWasHK4=;
 b=g1CItvFBpBMUGM7lLkuF8A2Lf7MkgFUj5S3Ndzk46uOe6+eXMPHjsWkJqpJrBrFqaIiqPMw68PtX3vmIXeklkDWn5t01V3zLshzz3zwHPW7jwCC9W8cLcIUsIF4aRfBajyGMj5EumEemImkipxXxECTHq9QgVTc5xJyOX8pAdB+dHDK90elk8Y0Lcz9IbQdXTAZAByIzUq4vc2cdJ266ps9im4BSLAwnddb2qlVgIq9ws94/JdRGwGA0cBk0A6mbz6HSXX6/nPIT0TzBDX1nLBgLU850a+f2Z2+W9cAQtzScmIsPd7OJovMLAL0xd3UGRRM/N3GRQaEiL7j1zgSpWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tQl+JwS0UVOySBPDVdVtmGdshi9jw4VQWqwdWasHK4=;
 b=drglNUQjY011s7WYTARMylDeNo8aaH4g+jPNzAEspk+ItDV5WliC4GxNM6bEOgpTpG7RzoMNyNsLE3OQVgsoLZ7kcIgjqkpK3Bh556ePveEf+csZDJuVwaimTXIW1HShF34T5aJ2NSIC696qoEVQbkgdsegJ8BEFGjxfndHEQoxjChL1V6A2s/E2FbeGTheqXvXd1cR90cELg4WYAAtcYEyuS0Av3OXW+KakcSc0tZ92VmblPEd3uqKlFAI6wTr8d3PZX1b0uyj65OQDcaJjX9iL7qr5C7b1v3C0Ic45ePyaeyRA1ovZ+na6QphbvkQorYPqi8wgrS7biNq7e2I5ZA==
Received: from CY5PR18CA0056.namprd18.prod.outlook.com (2603:10b6:930:13::23)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:47:57 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::e4) by CY5PR18CA0056.outlook.office365.com
 (2603:10b6:930:13::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:47:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:36 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:33 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 2/5] net/mlx5/hws: support counter from DevX bulk on root
Date: Tue, 4 Nov 2025 18:46:09 +0100
Message-ID: <20251104174612.1341962-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104174612.1341962-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: fd358180-4709-4e0e-5cfc-08de1bca4a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k4IoHgVCvBG07rSidFgFVD/cGeQ8swywWMEq6Pn+GDo1AUVaiNvY1TvZtlP2?=
 =?us-ascii?Q?4jLRG6H5/lpIP6GYT/dFZY4agLqD8lzb2rlPANEYLXx3SBIleX6biCSNxF5c?=
 =?us-ascii?Q?RXdOmDwrs+R9N63+FCfsthE3ecyGmEpKubN5kPa6B3272e34f5+PKcFWi/0z?=
 =?us-ascii?Q?gynhjeshGEXpan812mr9MFT0eOM1UPoBMlDZjgWcEofNZCOBcRz+QisiHDKm?=
 =?us-ascii?Q?5JVWZWl74kQhLiPnguQqgy2vRApawMyZhNszMivzt4ieBE8+NwPD58Us2RUo?=
 =?us-ascii?Q?umzdsmpl0bn3ObkdOzAm7T7d/riWmTVTYh3cIkdVjxLhwsgMANFDemF/U/lc?=
 =?us-ascii?Q?EhSVgiYOVjfnvf3p06mZxLJ+d5Cu8+WAY1FTB8Kk46Wg0lqoKq1goEHOncbg?=
 =?us-ascii?Q?w60Lx/tDXffwuc2gwx7wKTT2op4r7TCmHg8Yyv4lNmNRVghL92CQxucaArg1?=
 =?us-ascii?Q?KYfifPY/j2l32hJta4hTmJWj+nbUt2NVl3Pn/Bc2IF4oSiz+kneowKDIRJye?=
 =?us-ascii?Q?83C27KQDmQV4qg+rJVc6gEdWfpM+L78KXS0ZAuckS7j2hHNbYGTsyUTfYIBx?=
 =?us-ascii?Q?AUsMu345Pjvmt87H/g+8d31F1cBo2ZgaEx8VXjmK7CHZQTMYKydX2RbfSArz?=
 =?us-ascii?Q?ardmZHq6vji5SAWLAa2Aa0lA1o0VJsfyi3sRJ4lALFsMc2J5eVhGx+RD7aGJ?=
 =?us-ascii?Q?SEnG0TeehAykm2qtlZ091ggVy9NBw+AHQ0MLWZWJXNO8GAWlF/++FRPxD4Sr?=
 =?us-ascii?Q?Xxvq99TsWTLFiP3HouQgpMAm4mnt0A5d2XJB0Z2MJDAbmaV88YQKDfW6HthN?=
 =?us-ascii?Q?YJsNUKOwE+KNlOPD3jPd+42dR2AWEXaI0OloGt8W1qL918okaqzOMCEoDG1P?=
 =?us-ascii?Q?d076xlBCkhbIy9l7C3Q6KSc+0RfuTpLuAUpKEqUe1Ac6MUIkACKM2K91o1vh?=
 =?us-ascii?Q?ynO6enw2nqEbEj4aYxIxhzosFjNkOPcGN9qcDurSFvR55bU7lKdqU7FWYHA3?=
 =?us-ascii?Q?93TRBsscLpXePC5yp9pwuaveg3dVbwsMsfOgPhF30ASYJp5Q2v4jkIbw5uve?=
 =?us-ascii?Q?Ck3FgvOKQuuULBLWVce5Z3IT3KQVhVwpvjSlQm2dVeY/NjAkkGPy/G6r5mvo?=
 =?us-ascii?Q?AjGkxYUxty0jp11cinI6MdoN9xm3YBc84rvlX7B0/mZcVF+905QR9A6n32T5?=
 =?us-ascii?Q?dUGkFOJgHjxK3AFJVEMYXROdLc8NxGz8pTxb9NSWqg3JQuAI/VEBQEyLf9Sk?=
 =?us-ascii?Q?mmfqmqxDt7JT9n8CehZHeeIRttaDguHqXajC974rrekY5NICSxghJjqKNjpd?=
 =?us-ascii?Q?8eaI94UDRb2tqfPx3Ric4tNbBBZwcbyFKaIYxGvN07TGMBnzXXGft1goY0ru?=
 =?us-ascii?Q?DDPPYzDe9tGD2nZMJpQchexkDRAqQMKLq2QesbnBuoAOuWnIGS8g18XYGSMX?=
 =?us-ascii?Q?gN2GyKkV0T74sgyM0PVsPE0yluLWEZgVITBXRNAQYLudRKAwYJwgz0srhR5X?=
 =?us-ascii?Q?tck2Y2XR+zCmvh49vSRGxOy+wb/yIokCa5UzQXENrlaKu0gy+184BC4gRB09?=
 =?us-ascii?Q?wc+xmQanjVIZv0+/ksE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:47:57.2543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd358180-4709-4e0e-5cfc-08de1bca4a14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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

This patch adds support for using flow counters with offsets
within a DevX bulk, in flow rules on root table, in HWS layer.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr.h        | 14 ++++++++++++++
 drivers/net/mlx5/hws/mlx5dr_action.c | 19 ++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr.h b/drivers/net/mlx5/hws/mlx5dr.h
index 58526fc08e..c13316305f 100644
--- a/drivers/net/mlx5/hws/mlx5dr.h
+++ b/drivers/net/mlx5/hws/mlx5dr.h
@@ -738,6 +738,20 @@ mlx5dr_action_create_counter(struct mlx5dr_context *ctx,
 			     struct mlx5dr_devx_obj *obj,
 			     uint32_t flags);
 
+/* Check if counter action on root table is supported.
+ *
+ * @return true if counter action on root table is supported.
+ */
+static inline bool
+mlx5dr_action_counter_root_is_supported(void)
+{
+#ifdef HAVE_MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET
+	return true;
+#else
+	return false;
+#endif
+}
+
 /* Create direct rule reformat action.
  *
  * @param[in] ctx
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index d765d57a8f..1be66629e5 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -832,16 +832,11 @@ int mlx5dr_action_root_build_attr(struct mlx5dr_rule_action rule_actions[],
 			attr[i].type = MLX5DV_FLOW_ACTION_IBV_FLOW_ACTION;
 			attr[i].action = action->flow_action;
 			break;
-#ifdef HAVE_IBV_FLOW_DEVX_COUNTERS
+#ifdef HAVE_MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET
 		case MLX5DR_ACTION_TYP_CTR:
-			attr[i].type = MLX5DV_FLOW_ACTION_COUNTERS_DEVX;
-			attr[i].obj = action->devx_obj;
-
-			if (rule_actions[i].counter.offset) {
-				DR_LOG(ERR, "Counter offset not supported over root");
-				rte_errno = ENOTSUP;
-				return rte_errno;
-			}
+			attr[i].type = MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET;
+			attr[i].bulk_obj.obj = action->devx_obj;
+			attr[i].bulk_obj.offset = rule_actions[i].counter.offset;
 			break;
 #endif
 		default:
@@ -1712,6 +1707,12 @@ mlx5dr_action_create_counter(struct mlx5dr_context *ctx,
 		return NULL;
 	}
 
+	if (mlx5dr_action_is_root_flags(flags) &&
+	    !mlx5dr_action_counter_root_is_supported()) {
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+
 	action = mlx5dr_action_create_generic(ctx, flags, MLX5DR_ACTION_TYP_CTR);
 	if (!action)
 		return NULL;
-- 
2.39.5

