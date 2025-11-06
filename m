Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45E1CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 05:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC76440B8D;
	Thu,  6 Nov 2025 06:54:29 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
 by mails.dpdk.org (Postfix) with ESMTP id 0370F40DD8
 for <dev@dpdk.org>; Thu,  6 Nov 2025 06:54:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV9khYydL8pP8pg7jhmR0IJJk5eEVkAY8Owuv4V3MjG98NlEA6aZ1prXRLobt4xImhImuaw84e4Nc0iy4G3q/4UBuNSosc2jMIBeNQN5mmd//iwWIchr3bw5BAoF8Mc3BXGzitCx5YFDa9cefuP4ZmkCpUKm1ViPnPiLUrAU85LOrWW5SeFofv2k9E1hMBTvFdL9AbKSh/Qw2LbiYiA70esghzxXA2mF1GgiqaU/HP6jI3xZmFJGkuvyeSfByPwNefrnTd0fC412k3tR3OsLxVfoX4UmPoPvREApJkMW4rv6Z0uzJHZCHuDxjMZuzVEleZqvviYnAur/5IIq4c5ruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fqNHpV/wLSs/72lRyP0wX93RiUkO3/SBQ7VXdUmp0k=;
 b=yrTLpt51QOc6t9VMz6ZVLLqwXOi1XbwxOPCY6n3UIY/BWg/eZdW2mVGvwHsB3KiVob8a6SuX2xaoNHasmyBCTndwsRsGzz89druWf+v1Lj0fs4N9rv+B73y865MHQEBggms8Bon/aUMjJFLkjwnJnzlbwGp0RuQHCVbJufd5q7SD2yaMAH5BkCErKu1d0zLACbmrnN2zgyUwJV1nRoNAumn1o6Ad9eQn1bLYkqzENUGn+n08qQcE5PmKNwBYbXO6BNspJG3yoPkKFByPT0tyBM4tQHW/hFZ1byLRL9shtoiHIeBYK6miwVZNH8t2zGMsp9dOWUdw0aAQFGmruoHQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fqNHpV/wLSs/72lRyP0wX93RiUkO3/SBQ7VXdUmp0k=;
 b=XsfTRiDu4NsxJb4jk78uNzm2l/GldTF7/TDkfNgvJHOwpaDM60LcaN2DgRyOX9ImSHGWbBIZiu/XO/y1WiydvoWU8NHpNcx8XpLLG0yM5O0m6BOQHf9SEo1qjs2IrEtyIxpHSfhGSTnZ0gvUZtPDg3DuTc0+chUW6HO0iYEFUJzueokh5O1vbLmiMizDdmQ2oQxcrhLlIZNdWeoq8WIIzD9vAEbuwL8hASo4b2qQq7HjFlqCto8zAn2NnvikPbkAxNA5Z2I1jyDeNOwesW1awUHCNyYX3m/yPYUqFwl2SreTmnoOsq2zguEzJV7kRSLvbT98OUD9cey5+8/x4AmY0Q==
Received: from BN9PR03CA0877.namprd03.prod.outlook.com (2603:10b6:408:13c::12)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 05:54:23 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::29) by BN9PR03CA0877.outlook.office365.com
 (2603:10b6:408:13c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Thu,
 6 Nov 2025 05:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 05:54:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 21:54:06 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 21:54:03 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v4 2/2] net/mlx5: support PF representor suppression in
 multi-port E-Switch
Date: Thu, 6 Nov 2025 07:52:45 +0200
Message-ID: <20251106055246.360824-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106055246.360824-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251106055246.360824-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abc6de5-4845-4897-53ef-08de1cf8efc6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rclx/GDFqzmNtr+aW58KfoDvXMKZc+tuYBN0bTqYLATyVhw0U/D6qyS12kT0?=
 =?us-ascii?Q?RPk93n9iRJtxBYu8aSRgyJuymoMhqQm/EGqZG/VcYMB/MKp30mGwI5DIQiLe?=
 =?us-ascii?Q?LljId0G3rUvZMxuDXlAyg+iaDc7rMSwfcJ4W2egxF17n1ZWVFrI78fj6l9fX?=
 =?us-ascii?Q?mgsrR+p5kHojFkiOA/ZqZyAsbAIMqKIRO63zx11TfCWnT16vdu8A18N33kYM?=
 =?us-ascii?Q?icThw5c8gHfhztnSoByjvocibc9g+7Um/3iRastGKJ2JsQv4S7g/RXrwHUAc?=
 =?us-ascii?Q?TXDHfkHXtZo9HZVyyeu3Fc5aa3jHOExKREdQxgB5UnOPrNyvLmsNGW1Esuvk?=
 =?us-ascii?Q?/elRDDuyWfL/Z+Cd2vneUw7hoFc0qZGUZcdlxn7aPpWSEYxUxs1U2U4uhU3N?=
 =?us-ascii?Q?io4kC7iqU7FsVEE9oDaAU3qHkqsFWbaOdhtAagwe/xevhkpzMipMh6AG3CTy?=
 =?us-ascii?Q?uWD5dQJzwbgBBP3xsTNQf9phFeqcZsuICQ1+n8wfCmqiuRL+hmIJ37aQW7Hh?=
 =?us-ascii?Q?nTrfP+pn2zsJXpBSWJIRAywv0cA+fzRFKa48Vbln4fWZPuDJREvxEzC5P9eK?=
 =?us-ascii?Q?HELhU9WJqFVayl8T79h8x5gyhKguk+Yu2lztoWXUDkERnSY1axDpcCZL5Vlx?=
 =?us-ascii?Q?TvqbWWiRvqDaHv8yfnUlj3N53+OORHsZJtrsvFb+Lnyl0xLuMGPP9wTk9eI1?=
 =?us-ascii?Q?73VFzEQ950IpfoO8yTrJwQ/CpinSZ8j3CDtBA8DZB+Zc9iqhcWgNgVdo8Gfz?=
 =?us-ascii?Q?LXkUgrZBWm8+fJxFW7eSI9HtniLFqCVmn8mzoPr4coRkA++TQOct8aj2o/Wb?=
 =?us-ascii?Q?X0IkhOgLY6EwYBuZfoGaRMLc3xpQLVmW8KflPKvusKu7ae8sOWijYqI6V7pY?=
 =?us-ascii?Q?arSHKzKoG5PgO1r8x0vaGbgYGepWstS6U5M3wqT0Io6DYlqu3dF373VOLqz9?=
 =?us-ascii?Q?AYfsVIvkBKx+T6NL8odmghwCDKX9J83vMQx1qhnoMZF+SctcHkc5T74fb1Sn?=
 =?us-ascii?Q?Zs8EAdw8IB2WADCipJGKgvXphXZdL+i3Jd7biFeDXO2gqmtYLL0BE6/t37ef?=
 =?us-ascii?Q?1omiENObSOawP0C6vm5ZHtXFUFCj4IB1BuFqmtZVhsPcJ7vEs/KeWab4AXhf?=
 =?us-ascii?Q?VeBlVw0PiinrPHqY6ju5AmHgjG5BO/jTQiZSk8Dh61Rz2PAZ3S5ZWotLSWWB?=
 =?us-ascii?Q?VEgEGT0GT5k1mH8OijSzffI2IjQzT9qjjH5v78fxIsf/oAYkbUlnlhV8Bt+K?=
 =?us-ascii?Q?y6nrdyWf9/PENOC9p1BAIP1DD4bQES5XfeKXIF+wjz6IFvdC/UtbTePqCRDv?=
 =?us-ascii?Q?nyY5KQ5SRLbxYg0XD5M13I6JTitrLPKFtU+yJARFCg3g5QYTxpVBLCB6v+Ul?=
 =?us-ascii?Q?cPkYRxpKepvS4o8D7AP3EY+k8EKDOqh7+S+ACWEWiHk4kXxn8etn1r92I3Tt?=
 =?us-ascii?Q?M0rz3JhH75p0wVaMve847Zh4+LdttrLswDSslfnAIpQyEZjaNDfFdea1pPj2?=
 =?us-ascii?Q?dw/3vVhb1tR1Xk60x/TktLxO8PjgHPbDbWOXIq/4s0E+CEm4TiW4agrwpd1T?=
 =?us-ascii?Q?SgydWIVn+sArnMHEmhM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 05:54:23.1604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abc6de5-4845-4897-53ef-08de1cf8efc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
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

In multi-port E-Switch setup, the MLX5 PMD always added
PF representor port.
For example, `representor=pf1vf[0,1]` implicitly added PF1 representor
port:

```
Port     Name
0        p0
1        p1
2        representor_c0pf1vf0
3        representor_c0pf1vf1
```

The patch adds support for the new representor format that suppresses
PF representor attachment:

Example: `representor=(pf1)vf[0,1]`

```
Port     Name
0        p0
1        representor_c0pf1vf0
2        representor_c0pf1vf1
```

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
v2: Use updated rte_eth_devargs::flags.
v3: Fix typo in comment.
v4: Use update devarg macro name.
---
 drivers/net/mlx5/linux/mlx5_os.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index c742e0f282..dba3b61b68 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -2284,6 +2284,12 @@ mlx5_device_mpesw_pci_match(struct ibv_device *ibv,
 	return -1;
 }
 
+static inline bool
+mlx5_ignore_pf_representor(const struct rte_eth_devargs *eth_da)
+{
+	return (eth_da->flags & RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF) != 0;
+}
+
 /**
  * Register a PCI device within bonding.
  *
@@ -2592,6 +2598,8 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 					if (list[ns].info.port_name == mpesw) {
 						list[ns].info.master = 1;
 						list[ns].info.representor = 0;
+					} else if (mlx5_ignore_pf_representor(&eth_da)) {
+						continue;
 					} else {
 						list[ns].info.master = 0;
 						list[ns].info.representor = 1;
-- 
2.51.0

