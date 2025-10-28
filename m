Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B663ACCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 10:00:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13C394060A;
	Tue, 28 Oct 2025 11:00:16 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by mails.dpdk.org (Postfix) with ESMTP id 1D8244021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 11:00:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlsVmB5SHQDQi08icSF/10aKLSNrOLYbHpLxVHea/fJR/l1U8Q7bAS1exGE3TXMDvV20l7n901ZGTn05msQOjI7WXwgv4oLxS9wQTQ/YT3bu7eJq0YpDtZmsXLeoeTZ0/1gmOPyy7RNVVJ6U9XacVtNf/YLU8nTq0GMZN9RKx/OZKptkGsjGxu6ZfQ+74Y1E5E6+WVfl+z3cwwyY+EOkd0RloUGZIqcChgWmjFwXIl5aRiFHJAvt36WZ1wxCAO2NCrTvgS9TDWtuZ29Ft2JZKDCJL7PIehj8BJXtVe/nS6KI2hpgn237sxyM3vR5u0gCK1y9ChPUXw7/+gR76/Vv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPkzm5sV8sZ/DPYkdNrSes3U1SgyCQhi6N2xvAZeCnk=;
 b=saOvQrjD7L8GeovQG7KF/30wldL6aTID8hCy1pgKZNBvVwLxFHg8ibnCVINfGQt+KWmKy8ORM9rmBO9iiP9B9USFtpTuFzbckYObnxKieipYdInSLgc+rFRaiCa83Tj5BeU6jMp+8Pney5WJedxDpsg3xb5XP+8eNhY/sjNErDWVswRl/8jLhd8WShAJY9Ur2is7mgwoqjdSXPDz0KYv9RV2EFCWy0OfES8apTNoKuLrVJI8AEndOf92p805Qwrv10vppvg19X5L6I2ClElzuqZtyykQK+CV9png+fYdlxjfn/v0oqZD0AT8steM4DhZFWuUZxYFBBOuqDa/jwLPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPkzm5sV8sZ/DPYkdNrSes3U1SgyCQhi6N2xvAZeCnk=;
 b=lYXhJ9yXy6gjxc5GhSmLUhNb4wRJO4nJSogmx+7i+x5B0luxF0Tv9tIEIQw2E7Y0mSoCaxFB2fAq2a6FWpzdAo780WfepzNIRfaj2qm3XP/FS+iemKPGssR/g3WiD/bOxq2GbRn2haEVQYEEENWhoReeZOHc6U0KuP64aGrz/RquyiBxvjJ+ZCXlYKxJv+OSbEkHuDsstud4jc6jQe/twUcQUDmi/qN3GuKVeYHLJAr92iGjajiV4Rl+SeBiFR0YLZfKZGCQxFhSQTD4n9xYQ8teYMdtzeNMwxn4j01915O7lTeplzyHgpgqA38NrnmcQAmfsnsybu/Tc9BMFGg/6w==
Received: from PH1PEPF00013304.namprd07.prod.outlook.com (2603:10b6:518:1::16)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 10:00:07 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2a01:111:f403:c801::5) by PH1PEPF00013304.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 10:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 10:00:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 28 Oct
 2025 02:59:52 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 02:59:48 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: support PF representor suppresion in multi-port
 E-Switch
Date: Tue, 28 Oct 2025 11:58:30 +0200
Message-ID: <20251028095831.53669-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028095831.53669-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e493799-6d76-4396-8707-08de1608c5d5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CBRFUlbhQl8WtjwXVGK2KwQXicir0CoElswPeF4BuI5/BVKVhvb6h64S6zq0?=
 =?us-ascii?Q?Scu9Is+tJQ2alXcbYv2AD1VS+wO7yUy8QBItKdNOQZBG3T+5j6Dw9SLqJ49P?=
 =?us-ascii?Q?2lXYVEbm8KvjHvoFnvPV7DQEh+obBjN7MrpAdZhv4AKoXHZZ5bUOpKsRbCD4?=
 =?us-ascii?Q?B6zp7dCXBw+l6Xlc+jbpfay4YzTELOFYpqObGIJwQEWaWN3hnHJ85Nw3YEp/?=
 =?us-ascii?Q?tdxnIFj45BkZFNjRko1Lo4NskztIIQto29qfx4AcA0GN/MHOm/itEaCCiF9C?=
 =?us-ascii?Q?ycDix7+jF3fGjvO/j6ykLv6a604+Agcks46V7s5Uut/BFbsQrljEWJEb+ziR?=
 =?us-ascii?Q?S6AdjZ58AIZL2QzJQXNyvTubtBOad+xWqF3JgABsFozVBGwzBLA/QqwMu7za?=
 =?us-ascii?Q?Q762wmAtItGR/ZxxcsiZxWpeCAWdwukdHY2y/YKr+Dhbw/rjg0yR0Kog4m11?=
 =?us-ascii?Q?HEp/nxWc2mmdEzBblrfoSLOLSJd37gm9yr5K5SFagTXoQEh/rTnlSrBQnkSc?=
 =?us-ascii?Q?VA3VfK4BzzN4QCeuHBx8pYtF5KAZhxbk3zlTcyW4lVLjiI150FLObGj3Vyxz?=
 =?us-ascii?Q?PKOhb58+7cfJ57/ZAth9T1lmHWLOeBuhtbBV7SBdm6W808IMPZw7Lj/Pthof?=
 =?us-ascii?Q?swAIjzWZqBZzOOCxXJt5Eqr7cT1oAAR9okjGx01uzyLSU0U1aiKWIvrUOuqS?=
 =?us-ascii?Q?RP+flvlQpwC93HkU3roPoAN3IBrf9fppFXBXFu6PQU3ya7MkUBTz9mz+DvF0?=
 =?us-ascii?Q?aF6GDPQy0MQYhw1g5eKMKQYIyIMwfS12fHw+7JlvrhO8yDoeQc88Wh9r9kcZ?=
 =?us-ascii?Q?YF01APBTJlD5K3msgJtcKSkf0kX0XV70DYO6EwM2skqQqfNkE2Sq2jqtnVRL?=
 =?us-ascii?Q?lSX8nmEicBc1ioy4eRb3hvorXZwcvNcYrDUFW87QPIpKGwgfWz9oCMr+mD41?=
 =?us-ascii?Q?34QNNWSr0yNpX1WBzWmFy1ig3k0trmmyIYsGsirT7NXHupr8OukZemWmAHFt?=
 =?us-ascii?Q?Jvm8mYLHkxPb5sLX1ICAo3VzgttSS8im+gDgXCtzm+Y68Rx3nyBT+ouvnopK?=
 =?us-ascii?Q?OqAMJNSyn4igRt6KL6+T2sjgfY7wHnxniPIHf8l/YiFOfwxN8MlvKJXa/Gui?=
 =?us-ascii?Q?oPgBz2kZdqNlHfv/3apgeXaBMMcWcDeojcyEZp9oOrjaTNFDUcLIutDuGGBg?=
 =?us-ascii?Q?okoT9eAFLEijxFKTnzQwCr68F463hIyr4hbHoxjcVUwQcp5X9PcSW5wg0f0+?=
 =?us-ascii?Q?Oi4Abni+xiz9IUuQeWtlnslCRkIlCZB6Hpx8Em3+KOBVjD2hOku/Ul/h5p7S?=
 =?us-ascii?Q?MqJ6Lw7zn5u2BUVW9VyZMC2R4odudE2eaKHhPN0Q+7pCwKQqZOEyRPRZph3H?=
 =?us-ascii?Q?XvJFspAuACeV5R4M2A9P1ghJlQzH8udcfQDEwfAjfSLHu9po1bg/E7zzsxgc?=
 =?us-ascii?Q?5rHVvElha3J3rpUZUEqsC0eJanoiDfCvyNy32jpLIRq0/Ebm/E0TORUg8BIZ?=
 =?us-ascii?Q?nu3lNqD5CUM90AV8HX7znL9+x5ATS5T6Bih+FQpD04QTlvgPPEbq9JcCNgNh?=
 =?us-ascii?Q?GqrShZiZ86BaVSFztio=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:00:06.6454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e493799-6d76-4396-8707-08de1608c5d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
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
 drivers/net/mlx5/linux/mlx5_os.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 8d11b1ac3a..92084b4cdd 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -2284,6 +2284,12 @@ mlx5_device_mpesw_pci_match(struct ibv_device *ibv,
 	return -1;
 }
 
+static inline bool
+mlx5_ingnore_pf_representor(const struct rte_eth_devargs *eth_da)
+{
+	return (eth_da->port_flags & RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR) != 0;
+}
+
 /**
  * Register a PCI device within bonding.
  *
@@ -2593,8 +2599,12 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 						list[ns].info.master = 1;
 						list[ns].info.representor = 0;
 					} else {
-						list[ns].info.master = 0;
-						list[ns].info.representor = 1;
+						if (mlx5_ingnore_pf_representor(req_eth_da)) {
+							continue;
+						} else {
+							list[ns].info.master = 0;
+							list[ns].info.representor = 1;
+						}
 					}
 					/*
 					 * Ports of this type have uplink port index
-- 
2.51.0

