Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F338CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 17:39:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A146140A6F;
	Wed,  5 Nov 2025 18:39:08 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by mails.dpdk.org (Postfix) with ESMTP id A45F640A6E
 for <dev@dpdk.org>; Wed,  5 Nov 2025 18:39:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjzmGvMl4Y/E28Sn1liKnpgeyjbU0YKOeDz+FbbUz2IIHcUK/ENK4DOQPVn1JnPpQRn3xueDhjmb+BzS1XV1acc9FkADasV6rFHIDG6q5DgKr/3zl4ETzPZ53Zgn+kvwO8rWHjEhM8iCNCsbp4E0Fj6JZNwdKojn47uzVigdbS4J6gHTXMqQzoumZQku1OIWgY9jLrixCd9e1Vt/OI0YBq2ycd7ducCrJwHFb2q913CpuTS+xaK/6k5/opsPYXJaXXYEKEp/DSRNW1o7FHggljeOdrtBjqMJVCrzLTFsLUH7/PNfhts735xjpJAjq2TNJg4lQI1MibO8ZW9zTVVxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJJQOsMZvp9cnlOeCDVkazuMoJbk2FdYEsQJp5kh3nc=;
 b=RGw2RmKhWEEf0ZvMz2v8m6WzIEAgTU5b+XoAQht/4XbzVEVFBB9Qurf/Y4V3POeqsIrYuQCKckaveqIznzToGf6fb4fYMDih6nv6E25b/rL4jj430EpiyTgRghpCKdEqtT3uhfc9IcmYpko9xvRYLd+4uWxBtQRgphKfZHJvu5c7efepN+/Dei2iTmVCdazHHWnDJ5b5AWOI2uxZqZvA+Q/gu6KDNortIsz6LT7k7aIv/mnLUXrNUOPdtTzA7wcKHWhxD2gkZ7xcTwa/X0K5CHDomtWHMwpJ/QF9wv16lFOF9E+1TU2kTrbDwmfL83zglQ+49e2RHsTsV9NTYCcnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJJQOsMZvp9cnlOeCDVkazuMoJbk2FdYEsQJp5kh3nc=;
 b=Si+/OtBSeFXRiHkFBGoAw1RGiTKmCM/lRYb0P80N2khfGNR2y2As2zVy1EmnY278CQ3xgVdO4CzsAyvBaP7Gxw4buTNoyi0dUTR9icbq8XH7yAVNQ1P1y3qus3CeC5W63nJ5f5UhNiRXxGOS4U+qFTONYbtYiMvzL3aDy9rgmBQgjjq1r0gLMXyBW6K+x6buf5CoFriw0/JJg2m0Ru9LXEuUexzhGBqEI0pHbjF9XaaIkBQuzMQEpIbUmWNjfw/P9uEkidaRlW9R/GD7q1XCf7rwz6ubRsLPKtNQpEx2KsUiMxSj2lqJyVEkCtSh4cnNClOpIKle56uUVhmKdoOwhA==
Received: from BY5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:1d0::19)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Wed, 5 Nov 2025 17:39:04 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::9e) by BY5PR04CA0009.outlook.office365.com
 (2603:10b6:a03:1d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 17:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 17:39:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:38:42 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:38:39 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v2 2/2] net/mlx5: support PF representor suppresion in
 multi-port E-Switch
Date: Wed, 5 Nov 2025 19:37:17 +0200
Message-ID: <20251105173718.316971-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105173718.316971-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251105173718.316971-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8cf2c2-03e0-4cc1-4b30-08de1c923695
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Ju5chXmKXCCbJXEJlkja/i4EhMmgSCUcpDPm1bB5OpeGzuJU/0zo25p53/D?=
 =?us-ascii?Q?x550J+yTBKPxykAjK9j7JQlgCNgwRiDCEmk6zIt3eLbJ/mIsiq2YHSusYP6M?=
 =?us-ascii?Q?CrDEULBKLElVMiW3O5bpj8j1hnGdhfDRL2pJ/DkakzSys66DPyHg+ABRdga9?=
 =?us-ascii?Q?AWt+zzxEICPH9tAyknJIkJ+thYuf/eVdnm8Q0rTS2A9kqErsHbqbSlAp+e+M?=
 =?us-ascii?Q?BUDERi0q4gHk5nEAuqd7ItC0MSe55ehDi5ZWy8Sk/oIBUAsLx9Or9Zqi/ZJK?=
 =?us-ascii?Q?L1ioIx83R/UJ2n8GmsDbxM8dZ18WzDVMp509wBeegisWI4eDgcnaAEbXkJe2?=
 =?us-ascii?Q?qexYzCIz8pxsigzSja1t0MuSUxw9B4Y2l8ypk64HN15kiegFpy2oLsW5p1HN?=
 =?us-ascii?Q?Vud6FU69uQq1HtMCs2neWcs5dDH1iOJ51Ar2LQ4l5lce7Q2Niy8F+wyzdYUK?=
 =?us-ascii?Q?T6nSkH9TEpuTj+3RqplLPdixhndg+sGSV2ZZpCwr3Wcqved6kEgldmgE+GpE?=
 =?us-ascii?Q?S472M040aSSxMSlKpjFZvN3l1KIwEps3c1Nm1lRHV6BxKRlTFEfKQhyZTREn?=
 =?us-ascii?Q?DhYp75uN4DZ7fURm7JQj5Ze2Y2dKOmNB0ZoMYR1bK2UrdJSOcABj61tnev4P?=
 =?us-ascii?Q?RpV0JI4F90w7pVMheKRM2QFwPjGyvqjrmkax4fgNfwfBULFWOAVMEMGLE1tU?=
 =?us-ascii?Q?yJ6LC/Iwe4UFfBE4EU3lJGBnoYlgPIIx5nqvejwXB7NpXzcITxHrOB+IHOpp?=
 =?us-ascii?Q?b3SytXHnnTs8hhZevHd5JYxYa/5Kh/nIjJ7NihjMNiwOo/yPikwhuRZAz3Xu?=
 =?us-ascii?Q?+ZPdRiz/U0kYWwA2kaxjqq/BnySzhFBaUc/K2zYAz3+0hFrYIOBHS/bqyeDi?=
 =?us-ascii?Q?EfNIEZ2CoBIDAV2zfYhiKd1eqKKaODu/sg492icdLLHFUohnn1Hfr2eCklm4?=
 =?us-ascii?Q?ANT5kM3k/LKkOngrbrkcREAicfEm5uLZz8hm6d8B1sHjsB7ht5tGM8j0znS+?=
 =?us-ascii?Q?nShlgmOzZDNqj4O2mm+qRR7h/XWE6MVzdMmc6PohhShrTimfMyfMjcTrA9AR?=
 =?us-ascii?Q?I4tu03RIa3SoOei69qmmQJ3k7YvDnJONfAHisTg35k0o/xgThio8qOJGZaaW?=
 =?us-ascii?Q?to4UjZG1hM/AjXNYOZXHhwGZ2MWbQPhQcJqBmdJ9/cQp9V3ej4264GQEhrDc?=
 =?us-ascii?Q?R2XdROvYeY0EZVpCEvZFv2LEKyy9XBFmC6FPz8nJOrNmwLSxZtGf6riPfj9J?=
 =?us-ascii?Q?0P5Z3CjWGKpaNRkJ+p0AmC6Jqmv1SsMUSGTnzfxwHq+NgfMBzkCzCNrCc2AE?=
 =?us-ascii?Q?0qJZ30f/c4GHXUmJonk4aQVc0ej8PKrm6ebGq5N4U7qxC/1dI8N6gYxekiQW?=
 =?us-ascii?Q?ZPHG2F+llJYAAhbrJz3utzK9P8iujjnRXCbEQDR+g6cW3II5VHntQINaziG1?=
 =?us-ascii?Q?szjPHkHOFkFQtfYGGFGIsIkNx6MFoI9u3b1DB+Uz1kem2ZGoU9PCo/ih69q8?=
 =?us-ascii?Q?u02aUYtfV6yGkffy0gCH6PGzisGqO5oBpTtX5YrW4hIiTRjp3yCjr/BfQG3D?=
 =?us-ascii?Q?/65CUT4idozjxZQqQ1A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:39:03.8459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8cf2c2-03e0-4cc1-4b30-08de1c923695
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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
 drivers/net/mlx5/linux/mlx5_os.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index c742e0f282..fe80773d49 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -2284,6 +2284,12 @@ mlx5_device_mpesw_pci_match(struct ibv_device *ibv,
 	return -1;
 }
 
+static inline bool
+mlx5_ignore_pf_representor(const struct rte_eth_devargs *eth_da)
+{
+	return (eth_da->flags & RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR) != 0;
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

