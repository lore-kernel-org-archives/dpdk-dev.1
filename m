Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8EBCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 12:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A13804069F;
	Wed,  5 Nov 2025 13:56:13 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by mails.dpdk.org (Postfix) with ESMTP id EEB024021F;
 Wed,  5 Nov 2025 13:56:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i63fn6LwX4DND9ak50156kcRU9guQpHf8YJDPaq3pdlciPhtBUMQLhOzfmY+RJ8LPhg8wjPJWM+MMdxaY421qchaH+tQBHC2LIwHnVxQ119UqYYc2IqZxJJUngRGP+MY+ekM6pZfP2TpRG6095JSMLJCedODgNrjCPZAk9J5z06OwYaQIPy1sL4aWSCRxCCk4wrcRo5ONJC26ATQE94xvHhCNFc7q+rnpWxomLR+Z5C6eOAh217pRd/3OvYfIUrAphwKDFbhvVf0Il/ync0Fcpu95coEP0isiova2Ht82WppsTIirUIxidiml7qj4gJk4ZoAvdhYEvCA1q/dVB9/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbSIUencNEcjPqkVRqt+NVABM4nzHFIUm7TZGBrcOB8=;
 b=vINtLkIDFXF2lpgaV8l4vRAXp1TdBswyON05/mfNOsnYhSrcrZ12mR+T+r1/TIFQPLpfproWiAc0L8iI6nym32lluUhH2yc1klxw0+c5eV81RmRgZ5y6Jon0+KHGjRyVx2TbKEi0nMDDulMNvfviEx7VxWOzGSyo6/eWXuJUS1OABZuOyD0o+zfWvM3XAi6E31C2VALxfkiHiUgCS43/K8Dqw15U3geUSvXrVUh0LNXdfNoD+kv/vXF03q25hb5LWoDU3pn1GSeQsSeUHlNGwx0ro4TqOubA+oaGT2lkCu6HtPdyGeoC69nAxEDhgFSA8vESEjnTSb0279GphTodcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbSIUencNEcjPqkVRqt+NVABM4nzHFIUm7TZGBrcOB8=;
 b=XqGi9M1K2qQEN98KMVDD/3ItMRW3XaNnq2PqnQ+EuKyzr1xWLW9+iW/ADLPnYyXA5GG9XThJYGoWjEonWVTk3EuhvmamddYHu0sO5n6M1ZGFYB+y34uZCnCaomiFM3Xm2NMkqWk5cnWhz6Zb+hY7DOmMRtSYz6vFAJKFqqPkUJ+O/yZNp9qMshmu0Xj9p1p1qN4z31bkSOaE2MBYYCbFhAkH/hc2oBM05z/l6yhEZoq4z6acMJPBzspNeU+FGjp+jgaswRnbJKwdwgvXTRJbK0CohPjK7/5XFVOVMskcg/h71tdCW5pvrU9emxA3tXMdSLh4ixU45J/Lgyki4LJkHA==
Received: from CH2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:610:4f::17)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 12:56:06 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::47) by CH2PR18CA0007.outlook.office365.com
 (2603:10b6:610:4f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 12:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 12:56:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 04:55:52 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 04:55:48 -0800
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <akozyrev@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: fix indirect meter index leak
Date: Wed, 5 Nov 2025 14:54:33 +0200
Message-ID: <20251105125433.468878-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d43cc91-0ca0-4a12-5b92-08de1c6aaf23
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?asuuaN8UJkgiY7Xmt+8q0hoU/tObEfVdzmFaVrKmaQeaim8rOSWFNPhWI5iS?=
 =?us-ascii?Q?lt24WszkIOvRIyofb4P+1CuNnCMEcfdTxEEMqTB1PTvPyLAV9rBl+DtKdPUx?=
 =?us-ascii?Q?hxjETFw9Wp80D96Exu9gjWAD+ne4IvEaf9UhH1E/g3YCFgy+Pm7fBQGhXAq4?=
 =?us-ascii?Q?F8oHXjRb8QqCoEqww3QNFl39fGUD/ff8pktD/osWM4TXxc9ar+4mJIF6zu3C?=
 =?us-ascii?Q?z+xSbAsH8EJrhjlfMqH1pUjrGi5+QvA9hEoq7n3/YXLbhHkQqvwIplcUqriA?=
 =?us-ascii?Q?4noMFeZuWepK0oxm/BXcPzmciH5nyIXmLbiOHz9jYHxgYI6GK/jNZVLL4v6B?=
 =?us-ascii?Q?gdoLNWGTb7HQ9eOHG6klQv+d1/E0Jx4WbDjtwYQF5coM/lcvCryg8ur0U2ay?=
 =?us-ascii?Q?ZA+Bfh31EGcKe2rsqNKciHwSvvyn9I+pd1Spu8fnW0M3Hq3XetFwAoEBNM5S?=
 =?us-ascii?Q?tspTpfiAZhhlBz9rq9wMibhIWudYf734DLmUhSkAaGlwq5u6y5cqnR1yaOSB?=
 =?us-ascii?Q?D2hpM9JueKX6xfsTGv6e4PIM8JiXgNESnq2BKaXRnQX/LHVFvprzWG+ghHfe?=
 =?us-ascii?Q?LQehagHsvHYR1gyQEIURnkyl3SjQCzXE07xKZGOXSZRasuVviNmVfGWWNYW+?=
 =?us-ascii?Q?MvXtnzWtMPIOJ8LcGvGMXNG6PP+wKOYnQNDlCvTE2iJ04McIlRz12bkj5CYV?=
 =?us-ascii?Q?s+Z+Lqxl2dYY6MC8V2rMQroVLcDv4EmchVB+QDoMFODVwPRCw1ovWziwDGGA?=
 =?us-ascii?Q?jmXozY4Ci/qs7zXpPyE08FieINlf7PhSrvQGck/NK9z91iN0T8AmGJs30dnW?=
 =?us-ascii?Q?LxG6sKSkgn+miqRk4sql14tbmNsuJ5ZQT80+kYZRtVb0IrWzgWItkaqtZZjO?=
 =?us-ascii?Q?9BbFy1m3HjZ1FQ8hxNyHiwuRA6SDE3/gIrmr23RXCBqJp5lLeNKYCNj58IyZ?=
 =?us-ascii?Q?VQVuoj6+0CAyMYf6GyK/mPwb+2c4S3lzQ9iykjDo2cD13xwQ0YnvJvA7owBs?=
 =?us-ascii?Q?Ive/0N3rbLU2/VoB/uwWynarb65FfH9DHSwcanzZIakH0uZgFnyc82jMTgst?=
 =?us-ascii?Q?mQClSvPyTpjd/XaorT0P3X/WOw09gwIAL8hVguOQIkBPb5i1RQdBJIDV2BoO?=
 =?us-ascii?Q?S+kGt9yUbm7wZDjR03LJQamyvW8sJwYmU5ZIAyhKrJhz0t+mtYOPFKoMTF8X?=
 =?us-ascii?Q?piPo5PRvHOkV1kay+EB1JjpGsBJCxIwnP/QxoX66t8KbtYhC3d8quby0dnPG?=
 =?us-ascii?Q?KS4rFG2L7Y9PACJNjjIL04XY9wc4wt5hdriDVFNk5XczXeukjwt7kbpBr8S+?=
 =?us-ascii?Q?9jaKGyX0YXP9C33f24rMVCenMYp3Nd4fZcNTCTNGda+Yz37y4RWO5MsqwIPG?=
 =?us-ascii?Q?xa6xhaRtVYrvzHBST68jsJwOOLhwD222XZ6fJYBNg8r68EHF10jW8vMcCIxC?=
 =?us-ascii?Q?nAndu9e9cxCn0F62GV77tFaUnE/zOPxIEKBG+4WMzrBXwsW0IBKIhDAu9ucn?=
 =?us-ascii?Q?oJmZRZL1KXtJrgLDESaN4PUXuNQ1O+FpUNJZoSRDnx2EN+N0+S85S4vi+WUK?=
 =?us-ascii?Q?5J4p2UFCDS3JDa0ilxU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:56:06.1427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d43cc91-0ca0-4a12-5b92-08de1c6aaf23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
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

When destroying the meter_mark indirect action, PMD
didn't recycle the ipool resources.

Fixes: 48fbb0e93d06 ("net/mlx5: support flow meter mark indirect action with HWS")
Cc: akozyrev@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index ff68483a40..22503f49d5 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -13011,13 +13011,16 @@ flow_hw_action_handle_destroy(struct rte_eth_dev *dev, uint32_t queue,
 			break;
 		}
 		/* Wait for ASO object completion. */
-		if (queue == MLX5_HW_INV_QUEUE &&
-		    mlx5_aso_mtr_wait(priv, aso_mtr, true)) {
-			ret = -EINVAL;
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL, "Unable to wait for ASO meter CQE");
-			break;
+		if (queue == MLX5_HW_INV_QUEUE) {
+			if (mlx5_aso_mtr_wait(priv, aso_mtr, true)) {
+				ret = -EINVAL;
+				rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					NULL, "Unable to wait for ASO meter CQE");
+			}
+			mlx5_ipool_free(pool->idx_pool, idx);
+			if (ret < 0)
+				break;
 		}
 		aso = true;
 		break;
-- 
2.27.0

