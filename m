Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14F9C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 07:51:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B24F94025D;
	Wed, 14 May 2025 09:50:59 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by mails.dpdk.org (Postfix) with ESMTP id 4C7CF40041
 for <dev@dpdk.org>; Wed, 14 May 2025 09:50:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTb1PQJZxxqAjbNOloNJWrAGgb87hCSEEBwWijEHwzXAn0GLsmOD97MXr0+d/PPlmPnEn/NZj6NFfxM2QYKbuyWmjTq5O7yYRRa6zvmgaLzcDapuAn4m2NfQCOQ1R8YJJlZ8mtj+eBb8j4sg+b/y9C6FHo7RrhTco8tag1svoTLux5evWMQB6ZKHHSWNJ9fMD7kfAn2a15nFRwHPsbrumNJz2Uvd/AIZMUG5oMhBLEmMutn8N32HPsZrhpIVs4qpum1Uwup03IT506ZCM3/ma8FUUkChDTgz7lsVXXd4n4bGdIHn65Ow12jRBFcUq7Rgoi+aHibOa0CMTTV+defPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyg87zF3xlZr7XFtVanXwyKfhIktzBi3dbio1cT0kks=;
 b=Osfh0sTQHgyt4yMXrDONqmOX4ZTo2cdrdCKmEvvoj72A8Gpp5tdfK8TQCNaWtEX4z++kU5/ftOK8re3LWvnFZMB8fx/sjeBsVnmZ/1spg+r5+k5SYAwR2XyTgMlApB2vW7Dkm4jEL110HG2MGa6spIUdP1Wwk1P8ZdpB4e7aX0h4++bMAQShbQTkFmyh+Zi+8JRz7KLBjl01Bg3Dks6u/glhmCgleQkK6lXZxQVd3Y/StUjWryKtrJgoamYjJeEzwdAqnfEuTYHBe25xJ+qYdvKmyMo5kPYQ540jQrOV+ao2fpKNBwzBLTLZNiOuL7EpFRAADCmE8HWNY1HCyP4lrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyg87zF3xlZr7XFtVanXwyKfhIktzBi3dbio1cT0kks=;
 b=Jk+d2ybszMwU1UyAoUn9pjhYD+IpVIPsUh682dCS4mlJbUa6XcrmCNxoBJbYhlXIHm+Ciy43AJCWRZMN+E2avQPOeqqu2f1ZrSL4CtOiSWM+4FMqCmdLH2V4BgMlcuzZ4PbtuLNWOdPBdBiTfymxHTacqkJDqCP8tts1nrs4hsA0ttC8Zv3G9aG/GS5Dd15gpR4fGsbl6xkv8yDnOifEsm+1m7z/2HRDBMPEzh7+99mCCFz9rAkq9csnb8jPeV+5IukS3WXylMCwB9jA5eIpMOhp9Dl/TF+Qj39mozADGVbUPkMOmCgARw3yjeeYvU8RriZp67EeOZYMOhv91RzQ2A==
Received: from BLAPR03CA0042.namprd03.prod.outlook.com (2603:10b6:208:32d::17)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 07:50:53 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::29) by BLAPR03CA0042.outlook.office365.com
 (2603:10b6:208:32d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 14 May 2025 07:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 07:50:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 May
 2025 00:50:35 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 14 May
 2025 00:50:31 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Jiawei Wang <jiaweiw@nvidia.com>
Subject: [PATCH] net/mlx5: fix mark action value in shared Rx queue setup
Date: Wed, 14 May 2025 10:50:18 +0300
Message-ID: <20250514075018.67370-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c0292a-c32d-4966-e9af-08dd92bc0cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4FwOfm/Wp/B0ygrpoKXH4WoZBDr0GfyW07BJRk0KaHaPuIgkVB8NczqJQjJE?=
 =?us-ascii?Q?LT+ToB/SovPBhfIjh/kaktQccy6Epp5igOW4hD1DMcz8iVBLQ6Sp9QD9y7pP?=
 =?us-ascii?Q?4qkh/BuuZRBOZFRRkCxxM1O9J90BEi1DJjBW6orwQ2eoBIqVgAtP/qExQn44?=
 =?us-ascii?Q?P5aUc0LcdnyKi1Zw3GYGgFg4XtujAlOlabyb5yp5FVzX0J1gl4nfVAet2WHf?=
 =?us-ascii?Q?zEeBOAaNwd3sTGAxU+ZwPv0Wo1xZCvZpdj5ce2pbjWsIvfsbtKO568jU8U7O?=
 =?us-ascii?Q?IhZio7j2GM1dO8eIv1zLEN6wphiV9/Y1i2hgCI/F8mUMGl8HHigdmhTeaiEj?=
 =?us-ascii?Q?Q9E+D3DnFaKuZOitc6SX+EYUCtL1WAltPxcxpXrH9ydf+G77s6eyHEJFdhGX?=
 =?us-ascii?Q?5Ih9RnKCws8Ue0xHHvSNHSdNAjJvyI2it2F3VQ3rmil1ul1ZZy6PSK84caYt?=
 =?us-ascii?Q?7z2ORj3CkdeEY38LqXmx+Iwn/55gQlu5K6xsHKswrB1zYQrBHyUSW0NQXLXJ?=
 =?us-ascii?Q?FqU2nMIKoTFmVuHtl7ShC2vPsX+q1o1cLKdqKzF+NMkPezZ0dDIuQZZFWdIa?=
 =?us-ascii?Q?4XQlQhknNLABMnvRg6FV+x72MeZhGkuPP5cIlZUQfArbARU/TDR/G2ElxT02?=
 =?us-ascii?Q?jdJ6gGKCwcTpSP6XPW5ry4jLV2pv65C+lh293HsCJZjbbatLWhPB/wTD0OwK?=
 =?us-ascii?Q?u08+Mgtgn5TdckbxVURS6ZyJVLqTP7fOt4naW9rKp/HqUDHl0aCWsuvJdZAB?=
 =?us-ascii?Q?Ss/b/65WJJi4qJGMMXRNJk6pqPSYyAH6+XvD5M4BiK1FwV9+NeaNZO5D8+3L?=
 =?us-ascii?Q?L7R6Qz9rQEtkJlqpEZ/HaudMT4mXws22LpDxbUvdNhAFLQwXruZmvmimczkk?=
 =?us-ascii?Q?XSrj7O0f5AEu2DhppgagcGggdAVMRXZRvFLFwjHtci73IJDY5kABKVpqdFc0?=
 =?us-ascii?Q?/JG79u9UJbpSwUWbo9JtKg5wMmWEop87nQASgDE0Q1JVxvmjcHiDlaYhZ6KW?=
 =?us-ascii?Q?CHKN2ELo1NbKH2rZ+jgFXDEoTbPoNQZV4Xw3D8tTL/iLUSXbpT09cb0V44Km?=
 =?us-ascii?Q?sFR0a+68oYHCZeG768cCznJEKKkrprwRbHkFl/tsP10pzfnc2GupV2iBoUdw?=
 =?us-ascii?Q?vHzCRyNHDRe9Dx2yAPFHkowCnP8ReXvK3YkqJRJL3DY5OBUHeGK9Z74cIYjY?=
 =?us-ascii?Q?iTcjHpJfpkHoh6f6XmekN+zCT6CJ+J4ImF4oCvRqDGB6mm2ouRAHoy4V8Fj0?=
 =?us-ascii?Q?1ZM3dghpc0VNxQK/Oi3B8x2bQUGHdM1uLbnCYuXlbdVWV2Zs4LdOQtmMEBIW?=
 =?us-ascii?Q?I6sveAvv5XutIx3lLv83kLNqe+rG1JCn03INikXfkdgFwcdVUQL4AP+5rM1F?=
 =?us-ascii?Q?fyqK6SiC2wHTAArke5cHu2jvp0gImZZ9ISNJvrA/BKbS0QhdOFG1Ps+mN1J1?=
 =?us-ascii?Q?XMKmkHGtXIvvYPMORSaG4Q+sFkBBq6K8vHnFBCx/sc0Zl4D3MuVw7n3PEPma?=
 =?us-ascii?Q?e0D714GEzkZoaRMU1BvzXTdo5+unLZusaYEd?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:50:52.3791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c0292a-c32d-4966-e9af-08dd92bc0cfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274
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

Patch `2d8763432add` was not applied correctly.
As a result, `mlx5_rxq_data::mark_flag` was assigned wrong value.

Fixes: 2d8763432add ("net/mlx5: fix shared Rx queue data access race")
Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 8696cc4e95..3d49a2d833 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1866,8 +1866,8 @@ mlx5_flow_rxq_dynf_set(struct rte_eth_dev *dev)
 				data->flow_meta_offset = rte_flow_dynf_metadata_offs;
 				data->flow_meta_port_mask = priv->sh->dv_meta_mask;
 			}
-			data->mark_flag = mark_flag;
 		}
+		data->mark_flag = mark_flag;
 	}
 }
 
-- 
2.48.1

