Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4ADC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:39:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DBEB42DBB;
	Wed, 12 Feb 2025 17:39:09 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by mails.dpdk.org (Postfix) with ESMTP id DE0D842D9D
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:39:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcYTghzUVfZPLkEpH+07aP8jI29HxRMQZGXKK5LkiEzLyZQHALc/c6flfVX19KB18zE1h71WOUlYvf3Lg/uiLi6qLCVNIgllecjfAr10Hc1EsZFLIQIjhXq8tlnpVnmklnd8IgBYVdcsyBeB6z7J5aPL+OX5OV7V4NIHaKgfXbSlEsmvwIHt+2fgOwipezLVKFvCjYiP/gl9gQrn9Pb8Chc6EzM+kg4Bsi54XOan9UC4qfNv0S1XU931sN+jhcm83omwz1iTQ8YI25HBUfKH7LaVYA0JUwMpAxHFtHyskCp/f1Tb6waH1OC20LUZwIPc2EkW642FnjCMpeKU8FAqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taiiaUZUT3IzWCJOtdTqm2y2PblTQTLI2LMrIhHPAu8=;
 b=vpmW/gTGsDKt++UZiQIMQxFx7XaWouLyoNBrJdDZ7NuEJocd0a7yLdqtlPKf8tL/HiMlidN0UaNqIIgSmMrkLa5AZ+ww3Y4nCIDka2Dwr2dIw1+b2gWI8sj6qccbbCo1HucuqRiD0YXUwacXI4At8cCF9JF/rD96gHYYXSqqniZAbwAKe7P88iapYFUi1sEf14d7CuqqKlS10cxRiBSnpOKYkYhcZZpdQK+BAfNL76C80vjNyicE4uUZu+nMlKybuDzbhF5Cs66YscCw3k5Vy2AkjvvQNnCMLgEe16OarQW1iiXnCxvj7TeGHqXMwKJJtTa2tp+3vcE8/fWP2sG/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taiiaUZUT3IzWCJOtdTqm2y2PblTQTLI2LMrIhHPAu8=;
 b=L2vLxgZE9E3luzt8RvbDvD3tuWuMkyF8BEu5Jgu4hzhoDv4BuJiD7rdApPyoh5hxt2YqulpiP0r2xhoUjZyuj3rV9BH6VgvSBVEZFRaG2jAfWG/XYelqcOkm/l/BrLOf3mE2yjgbbIWN8f+2+qsXe8BnTR4XlyggbGPK9luQDbM+VRetdN+boiCrlEhcRWyJfFlJ75yMdj8oGNkl4CJZ54lHIwkNmPc8q7n7jYyhPNXtV8ZqDvcYSyPgm4yYq3CNGS7tkoh3Ogx2o8wWNgiG2xSjfBc1qRFiSPdqfBn3OP0s91l1FjTNlvAPDsyECfJki+9kiJzpO77K+vZIJ1Y/ww==
Received: from BN1PR12CA0015.namprd12.prod.outlook.com (2603:10b6:408:e1::20)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 16:39:00 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::52) by BN1PR12CA0015.outlook.office365.com
 (2603:10b6:408:e1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Wed,
 12 Feb 2025 16:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 16:39:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 08:38:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 08:38:47 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Feb 2025 08:38:43 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, "Nikhil
 Agarwal" <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, "Chenbo
 Xia" <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>,
 "Kevin Laatz" <kevin.laatz@intel.com>, Jan Blunck <jblunck@infradead.org>
Subject: [PATCH v7 2/4] lib: fix comparison between devices
Date: Wed, 12 Feb 2025 18:38:33 +0200
Message-ID: <20250212163836.178976-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212163836.178976-1-shperetz@nvidia.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 486c1f81-8505-4b91-363b-08dd4b83c0b3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UapMqa8Mj6H1kp5/oJ8L6W0OxVE4kWj23ji38BP5Fg8Vcsm0UahsmvCOtGVw?=
 =?us-ascii?Q?NT5yr9dY18K8dCYe1DHFjZ2UviKUo726fCerhqMREZS7YDeX6EqX5G95DmYC?=
 =?us-ascii?Q?WTVY3Wxi3VbwGM1XPK3pHhNqjYYJLL163zbVZFzYmvSZMDYOhy+W95zrL/aN?=
 =?us-ascii?Q?psNfFAO06YhLf7kWe+tHTV2sjEKbVtnm7yAD+MDxOMao39uYYBhjfhd9eT4D?=
 =?us-ascii?Q?tG4M+aOBd/ve3BgjTWrRZd6elY3tTgySMdxmJuoY8wCrvCo3CG3i1qR65LMY?=
 =?us-ascii?Q?2Fc1yn3+8RjVpFE5DPWiUHPmP3GcFkrjkFSXED+/LfxH+9ggFHG7Aof0um3V?=
 =?us-ascii?Q?343ONjt02UcVp3IwxlZBS12Ch9zk5BiUzYA1F/8zEmPXh7fhDZBkss9rElYO?=
 =?us-ascii?Q?/2k5sVnx7pTEGH+VLDVKow5TBJWpPJy6EcuHD7MKMKBUqXKAOfYDKQnp7rsn?=
 =?us-ascii?Q?jh0hgnksqlSyUBBHBCqkStyiFCVJaoBAJupL0j7Wltdkxmb0zbj6288c9oYm?=
 =?us-ascii?Q?Jc9VXrJPdp6q1vawd3GxY1xNwJMZvPe4UOT6MxHynE4RwdI3Kr8kkvAE+8PA?=
 =?us-ascii?Q?ZkAuEb1modVzF112vn25U6TXpDig3buWQlkOGJpXX4COinhL7Sjo1hCXCmlo?=
 =?us-ascii?Q?W8wqyJPr9Ers6pexw3zzwR1a+xZf9Gv2umDO8UpS1ajE1RL9dPEWE3qV02Gm?=
 =?us-ascii?Q?qbVCbsoN83nGqQAKGX79/iSxlPF3hALl+3Nf1Bsa1D1a2SE3MLL0wm6/oXr1?=
 =?us-ascii?Q?kV+z/NXB9c5TC5jGhnDoJelFylzEQHRqsBI6TTdgacouCp3Lg0aiGC/p7O55?=
 =?us-ascii?Q?gFV/UD+/m6EO+Q9b4NQdu/cKTx3gOLIEncBbkA1xSPIpHWSmki/RAdM9WzxL?=
 =?us-ascii?Q?qIJ1MmQRnxFRc4BoFaWUGYC33b4FsJyu0wY9IAsHz533aFb5cNs+STvPcA0y?=
 =?us-ascii?Q?eUgiMOY/ToCi9oHJzDiqdb4EHfnmgn2mc3UJ5LeLUt1pymWuG4KgD7fJSeRl?=
 =?us-ascii?Q?uTPDbejYfIyERbthD2zbq85MONJLryofgkN9fmwef99y+XPuwc1yovhNIIlQ?=
 =?us-ascii?Q?ZdqVACHYAeK+ZFiF+HHXpeaHzwF8/tyBsAR1q6yqiCcg8AkYTwGTyZTvK2sc?=
 =?us-ascii?Q?Wzp+klsKlIFzdmzfAU9v9GjfTtojTWNuAW4zNvu7PBEOV3GxEISSWMV2H6qu?=
 =?us-ascii?Q?T6qjt8Nq//s61xAXwsR4UD0M/ZRpEWW+pPoltQXdpCeRUe0NuvGv7R29PzuH?=
 =?us-ascii?Q?yqvrVuV+v734PFcC568nZ6r0dGwovFh/7jd++A9xlsG2lAek8kb/xTsad5Mq?=
 =?us-ascii?Q?uPJnEHnMpPDvLmgaa35KYZ2GXqy35PjU0WkETZKyK/VLJD1fmZzvfQkLG7DF?=
 =?us-ascii?Q?tJZ0myNvbRPoZ5Rb6wxAwBCqp2ARkrBsybMDLgwl6DeClmzArLXmejmmU/+Y?=
 =?us-ascii?Q?voL3TWssa1a4hhougpsNlQZelA6ii2CsYs4rBByqcEy4Vd7ymNf3oJFwdW3f?=
 =?us-ascii?Q?AZ4oUGPP/HpEeCw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:39:00.0216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 486c1f81-8505-4b91-363b-08dd4b83c0b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

DPDK supports multiple formats for specifying buses,
(such as "0000:08:00.0" and "08:00.0" for PCI).
This flexibility can lead to inconsistencies when using one
format while running testpmd, then attempts to use the other
format in a later command, resulting in a failure.

The issue arises from the find_device function, which compares
the user-provided string directly with the device->name in
the rte_device structure.
If we want to accurately compare these names, we'll need to bring both
sides to the same representation by invoking the parse function
on the user input.

The proposed solution is to utilize the parse function implemented
by each bus. When comparing names, we will call parse on the supplied
string as well as on the device name itself and compare the results.
As part of the change the parse function will now recive the address
to write to and the size of the pointer, in addition it will return
the size of the parsed address.

This will allow consistent comparisons between different representations
of same devices.

In addition, fixed vdev test to use the rte_cmp_dev_name function
instead of the custom one.

Fixes: a3ee360f4440 ("eal: add hotplug add/remove device")

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test/test_devargs.c                  |  2 +-
 app/test/test_vdev.c                     | 10 ++----
 drivers/bus/auxiliary/auxiliary_common.c | 17 +++++++---
 drivers/bus/cdx/cdx.c                    | 13 +++++---
 drivers/bus/dpaa/dpaa_bus.c              |  9 ++++--
 drivers/bus/fslmc/fslmc_bus.c            | 11 ++++---
 drivers/bus/ifpga/ifpga_bus.c            | 14 +++++---
 drivers/bus/pci/pci_common.c             |  7 ++--
 drivers/bus/platform/platform.c          | 15 ++++++---
 drivers/bus/uacce/uacce.c                | 14 +++++---
 drivers/bus/vdev/vdev.c                  | 23 +++++++++++--
 drivers/bus/vmbus/vmbus_common.c         | 11 ++++---
 drivers/dma/idxd/idxd_bus.c              |  9 ++++--
 drivers/raw/ifpga/ifpga_rawdev.c         |  8 +----
 lib/eal/common/eal_common_bus.c          |  2 +-
 lib/eal/common/eal_common_dev.c          | 41 +++++++++++++++++++++---
 lib/eal/common/hotplug_mp.c              | 11 ++-----
 lib/eal/include/bus_driver.h             | 27 +++++++++++++++-
 lib/eal/include/rte_dev.h                | 15 +++++++++
 lib/eal/linux/eal_dev.c                  | 10 +-----
 lib/eal/version.map                      |  1 +
 21 files changed, 187 insertions(+), 83 deletions(-)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 4166b2bea2..575a49ea82 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -171,7 +171,7 @@ test_valid_devargs(void)
 	int ret;
 
 	ret = test_valid_devargs_cases(list, RTE_DIM(list));
-	if (vdev_bus != NULL && vdev_bus->parse("net_ring0", NULL) == 0)
+	if (vdev_bus != NULL && vdev_bus->parse("net_ring0", NULL, 0, NULL) == 0)
 		/* Ring vdev driver enabled. */
 		ret |= test_valid_devargs_cases(legacy_ring_list,
 						RTE_DIM(legacy_ring_list));
diff --git a/app/test/test_vdev.c b/app/test/test_vdev.c
index 3e262f30bc..860fa260af 100644
--- a/app/test/test_vdev.c
+++ b/app/test/test_vdev.c
@@ -20,12 +20,6 @@ static const char * const valid_keys[] = {
 	NULL,
 };
 
-static int
-cmp_dev_name(const struct rte_device *dev, const void *name)
-{
-	return strcmp(rte_dev_name(dev), name);
-}
-
 static int
 cmp_dev_match(const struct rte_device *dev, const void *_kvlist)
 {
@@ -82,7 +76,7 @@ test_vdev_bus(void)
 		printf("Failed to create vdev net_null_test0\n");
 		goto fail;
 	}
-	dev0 = vdev_bus->find_device(NULL, cmp_dev_name, "net_null_test0");
+	dev0 = vdev_bus->find_device(NULL, rte_cmp_dev_name, "net_null_test0");
 	if (dev0 == NULL) {
 		printf("Cannot find net_null_test0 vdev\n");
 		goto fail;
@@ -93,7 +87,7 @@ test_vdev_bus(void)
 		printf("Failed to create vdev net_null_test1\n");
 		goto fail;
 	}
-	dev1 = vdev_bus->find_device(NULL, cmp_dev_name, "net_null_test1");
+	dev1 = vdev_bus->find_device(NULL, rte_cmp_dev_name, "net_null_test1");
 	if (dev1 == NULL) {
 		printf("Cannot find net_null_test1 vdev\n");
 		goto fail;
diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index e6cbc4d356..f8a064a400 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -237,10 +237,9 @@ auxiliary_probe(void)
 }
 
 static int
-auxiliary_parse(const char *name, void *addr)
+auxiliary_parse(const char *name, void *addr, int addr_size, int *out_size)
 {
 	struct rte_auxiliary_driver *drv = NULL;
-	const char **out = addr;
 
 	/* Allow empty device name "auxiliary:" to bypass entire bus scan. */
 	if (strlen(name) == 0)
@@ -250,9 +249,17 @@ auxiliary_parse(const char *name, void *addr)
 		if (drv->match(name))
 			break;
 	}
-	if (drv != NULL && addr != NULL)
-		*out = name;
-	return drv != NULL ? 0 : -1;
+
+	if (drv == NULL)
+		return -1;
+
+	if (out_size != NULL)
+		*out_size = strlen(name) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, name, addr_size);
+
+	return 0;
 }
 
 /* Register a driver */
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 62b108e082..85a50ff476 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -464,15 +464,20 @@ cdx_probe(void)
 }
 
 static int
-cdx_parse(const char *name, void *addr)
+cdx_parse(const char *name, void *addr, int addr_size, int *out_size)
 {
-	const char **out = addr;
 	int ret;
 
 	ret = strncmp(name, CDX_DEV_PREFIX, strlen(CDX_DEV_PREFIX));
 
-	if (ret == 0 && addr)
-		*out = name;
+	if (ret != 0)
+		return ret;
+
+	if (out_size != NULL)
+		*out_size = strlen(name) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, name, addr_size);
 
 	return ret;
 }
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 9ffbe07c93..8526bc258d 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -153,7 +153,7 @@ dpaa_devargs_lookup(struct rte_dpaa_device *dev)
 	char dev_name[32];
 
 	RTE_EAL_DEVARGS_FOREACH("dpaa_bus", devargs) {
-		devargs->bus->parse(devargs->name, &dev_name);
+		devargs->bus->parse(devargs->name, &dev_name, sizeof(dev_name), NULL);
 		if (strcmp(dev_name, dev->device.name) == 0) {
 			DPAA_BUS_INFO("**Devargs matched %s", dev_name);
 			return devargs;
@@ -447,7 +447,7 @@ dpaa_portal_finish(void *arg)
 }
 
 static int
-rte_dpaa_bus_parse(const char *name, void *out)
+rte_dpaa_bus_parse(const char *name, void *out, int addr_size, int *out_size)
 {
 	unsigned int i, j;
 	size_t delta, dev_delta;
@@ -494,6 +494,9 @@ rte_dpaa_bus_parse(const char *name, void *out)
 		max_name_len = sizeof("fm.-mac..") - 1;
 	}
 
+	if (out_size != NULL)
+		*out_size = max_name_len + 1;
+
 	if (out != NULL) {
 		char *out_name = out;
 
@@ -502,7 +505,7 @@ rte_dpaa_bus_parse(const char *name, void *out)
 		 * will be a ',' instead. Not copying past this comma is not an
 		 * error.
 		 */
-		strlcpy(out_name, &name[delta], max_name_len + 1);
+		strlcpy(out_name, &name[delta], addr_size);
 
 		/* Second digit of mac%u could instead be ','. */
 		if ((strlen(out_name) == max_name_len) &&
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 68ad2b801e..2cd666c218 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -103,7 +103,7 @@ fslmc_devargs_lookup(struct rte_dpaa2_device *dev)
 	char dev_name[32];
 
 	RTE_EAL_DEVARGS_FOREACH("fslmc", devargs) {
-		devargs->bus->parse(devargs->name, &dev_name);
+		devargs->bus->parse(devargs->name, &dev_name, sizeof(dev_name), NULL);
 		if (strcmp(dev_name, dev->device.name) == 0) {
 			DPAA2_BUS_INFO("**Devargs matched %s", dev_name);
 			return devargs;
@@ -235,7 +235,7 @@ scan_one_fslmc_device(char *dev_name)
 }
 
 static int
-rte_fslmc_parse(const char *name, void *addr)
+rte_fslmc_parse(const char *name, void *addr, int addr_size, int *out_size)
 {
 	uint16_t dev_id;
 	char *t_ptr;
@@ -298,8 +298,11 @@ rte_fslmc_parse(const char *name, void *addr)
 		goto err_out;
 	}
 
-	if (addr)
-		strcpy(addr, sep);
+	if (out_size != NULL)
+		*out_size = strlen(sep) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, sep, addr_size);
 
 	ret = 0;
 err_out:
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 11b31eee4f..87884401c3 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -459,9 +459,8 @@ ifpga_find_device(const struct rte_device *start,
 	return NULL;
 }
 static int
-ifpga_parse(const char *name, void *addr)
+ifpga_parse(const char *name, void *addr, int addr_size __rte_unused, int *out_size)
 {
-	int *out = addr;
 	struct rte_rawdev *rawdev = NULL;
 	char rawdev_name[RTE_RAWDEV_NAME_MAX_LEN];
 	char *c1 = NULL;
@@ -491,9 +490,14 @@ ifpga_parse(const char *name, void *addr)
 	rawdev = rte_rawdev_pmd_get_named_dev(rawdev_name);
 
 	if ((port < IFPGA_BUS_DEV_PORT_MAX) &&
-		rawdev &&
-		(addr != NULL))
-		*out = port;
+		rawdev) {
+		if (out_size != NULL)
+			*out_size = sizeof(port);
+
+		if (addr != NULL)
+			*(int *)addr = port;
+		}
+
 
 	if ((port < IFPGA_BUS_DEV_PORT_MAX) &&
 		rawdev)
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 70faae4e44..0e3d1dcc46 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -84,7 +84,7 @@ pci_devargs_lookup(const struct rte_pci_addr *pci_addr)
 	struct rte_pci_addr addr;
 
 	RTE_EAL_DEVARGS_FOREACH("pci", devargs) {
-		devargs->bus->parse(devargs->name, &addr);
+		devargs->bus->parse(devargs->name, &addr, sizeof(struct rte_pci_addr), NULL);
 		if (!rte_pci_addr_cmp(pci_addr, &addr))
 			return devargs;
 	}
@@ -487,12 +487,15 @@ rte_pci_dump(FILE *f)
 }
 
 static int
-pci_parse(const char *name, void *addr)
+pci_parse(const char *name, void *addr, __rte_unused int addr_size, int *size)
 {
 	struct rte_pci_addr *out = addr;
 	struct rte_pci_addr pci_addr;
 	bool parse;
 
+	if (size != NULL)
+		*size = sizeof(struct rte_pci_addr);
+
 	parse = (rte_pci_addr_parse(name, &pci_addr) == 0);
 	if (parse && addr != NULL)
 		*out = pci_addr;
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 11892caa24..e6ab8b7ea1 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -542,11 +542,10 @@ platform_bus_unplug(struct rte_device *dev)
 }
 
 static int
-platform_bus_parse(const char *name, void *addr)
+platform_bus_parse(const char *name, void *addr, int addr_size, int *out_size)
 {
 	struct rte_platform_device pdev = { };
 	struct rte_platform_driver *pdrv;
-	const char **out = addr;
 
 	rte_strscpy(pdev.name, name, sizeof(pdev.name));
 
@@ -555,10 +554,16 @@ platform_bus_parse(const char *name, void *addr)
 			break;
 	}
 
-	if (pdrv != NULL && addr != NULL)
-		*out = name;
+	if (pdrv == NULL)
+		return -ENODEV;
+
+	if (out_size != NULL)
+		*out_size = strlen(name) + 1;
 
-	return pdrv != NULL ? 0 : -ENODEV;
+	if (addr != NULL)
+		rte_strscpy(addr, name, addr_size);
+
+	return 0;
 }
 
 static int
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 9ca048122d..0e2215c16a 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -20,6 +20,7 @@
 #include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_kvargs.h>
+#include <rte_string_fns.h>
 #include <bus_driver.h>
 
 #include "bus_uacce_driver.h"
@@ -529,15 +530,20 @@ uacce_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,  const void
 }
 
 static int
-uacce_parse(const char *name, void *addr)
+uacce_parse(const char *name, void *addr, int addr_size, int *out_size)
 {
-	const char **out = addr;
 	int ret;
 
 	ret = strncmp(name, UACCE_DEV_PREFIX, strlen(UACCE_DEV_PREFIX));
 
-	if (ret == 0 && addr)
-		*out = name;
+	if (ret != 0)
+		return ret;
+
+	if (out_size != NULL)
+		*out_size = strlen(name) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, name, addr_size);
 
 	return ret;
 }
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index ec7abe7cda..f369720cb1 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -113,7 +113,7 @@ rte_vdev_remove_custom_scan(rte_vdev_scan_callback callback, void *user_arg)
 }
 
 static int
-vdev_parse(const char *name, void *addr)
+vdev_find_driver(const char *name, void *addr)
 {
 	struct rte_vdev_driver **out = addr;
 	struct rte_vdev_driver *driver = NULL;
@@ -197,7 +197,7 @@ vdev_probe_all_drivers(struct rte_vdev_device *dev)
 	name = rte_vdev_device_name(dev);
 	VDEV_LOG(DEBUG, "Search driver to probe device %s", name);
 
-	if (vdev_parse(name, &driver))
+	if (vdev_find_driver(name, &driver))
 		return -1;
 
 	iova_mode = rte_eal_iova_mode();
@@ -232,6 +232,23 @@ find_vdev(const char *name)
 	return NULL;
 }
 
+static int
+vdev_parse(const char *name, void *addr, int addr_size, int *out_size)
+{
+	struct rte_vdev_driver *driver;
+
+	if (vdev_find_driver(name, &driver))
+		return 1;
+
+	if (out_size != NULL)
+		*out_size = strlen(name) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, name, addr_size);
+
+	return 0;
+}
+
 static struct rte_devargs *
 alloc_devargs(const char *name, const char *args)
 {
@@ -647,7 +664,7 @@ vdev_get_iommu_class(void)
 
 	TAILQ_FOREACH(dev, &vdev_device_list, next) {
 		name = rte_vdev_device_name(dev);
-		if (vdev_parse(name, &driver))
+		if (vdev_find_driver(name, &driver))
 			continue;
 
 		if (driver->drv_flags & RTE_VDEV_DRV_NEED_IOVA_AS_VA)
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 8a965d10d9..ca69a5712d 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -245,14 +245,17 @@ rte_vmbus_cleanup(void)
 }
 
 static int
-vmbus_parse(const char *name, void *addr)
+vmbus_parse(const char *name, void *addr, int addr_size, int *out_size)
 {
 	rte_uuid_t guid;
 	int ret;
 
+	if (out_size != NULL)
+		*out_size = sizeof(guid);
+
 	ret = rte_uuid_parse(name, guid);
-	if (ret == 0 && addr)
-		memcpy(addr, &guid, sizeof(guid));
+	if (ret == 0 && addr != NULL)
+		memcpy(addr, &guid, addr_size);
 
 	return ret;
 }
@@ -269,7 +272,7 @@ vmbus_devargs_lookup(struct rte_vmbus_device *dev)
 	rte_uuid_t addr;
 
 	RTE_EAL_DEVARGS_FOREACH("vmbus", devargs) {
-		vmbus_parse(devargs->name, &addr);
+		vmbus_parse(devargs->name, &addr, sizeof(rte_uuid_t), NULL);
 
 		if (rte_uuid_compare(dev->device_id, addr) == 0)
 			return devargs;
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index ba8076715d..350e4a44c1 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -47,7 +47,7 @@ static int dsa_probe(void);
 static struct rte_device *dsa_find_device(const struct rte_device *start,
 		rte_dev_cmp_t cmp,  const void *data);
 static enum rte_iova_mode dsa_get_iommu_class(void);
-static int dsa_addr_parse(const char *name, void *addr);
+static int dsa_addr_parse(const char *name, void *addr, int addr_size, int *out_size);
 
 /** List of devices */
 TAILQ_HEAD(dsa_device_list, rte_dsa_device);
@@ -345,7 +345,7 @@ dsa_scan(void)
 			closedir(dev_dir);
 			return -ENOMEM;
 		}
-		if (dsa_addr_parse(wq->d_name, &dev->addr) < 0) {
+		if (dsa_addr_parse(wq->d_name, &dev->addr, sizeof(dev->addr), NULL) < 0) {
 			IDXD_PMD_ERR("Error parsing WQ name: %s", wq->d_name);
 			free(dev);
 			continue;
@@ -391,11 +391,14 @@ dsa_get_iommu_class(void)
 }
 
 static int
-dsa_addr_parse(const char *name, void *addr)
+dsa_addr_parse(const char *name, void *addr, int addr_size __rte_unused, int *out_size)
 {
 	struct dsa_wq_addr *wq = addr;
 	unsigned int device_id, wq_id;
 
+	if (out_size != NULL)
+		*out_size = sizeof(struct dsa_wq_addr);
+
 	if (sscanf(name, "wq%u.%u", &device_id, &wq_id) != 2) {
 		IDXD_PMD_DEBUG("Parsing WQ name failed: %s", name);
 		return -1;
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 5b9b596435..7238246e1c 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1833,12 +1833,6 @@ ifpga_cfg_probe(struct rte_vdev_device *vdev)
 	return ret;
 }
 
-static int cmp_dev_name(const struct rte_device *dev, const void *_name)
-{
-	const char *name = _name;
-	return strcmp(dev->name, name);
-}
-
 static int
 ifpga_cfg_remove(struct rte_vdev_device *vdev)
 {
@@ -1874,7 +1868,7 @@ ifpga_cfg_remove(struct rte_vdev_device *vdev)
 		args.port, args.bdf);
 	bus = rte_bus_find_by_name(RTE_STR(IFPGA_BUS_NAME));
 	if (bus) {
-		if (bus->find_device(NULL, cmp_dev_name, dev_name)) {
+		if (bus->find_device(NULL, rte_cmp_dev_name, dev_name)) {
 			ret = rte_eal_hotplug_remove(RTE_STR(IFPGA_BUS_NAME),
 				dev_name);
 		}
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 7cbd09c421..fc986570d6 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -200,7 +200,7 @@ bus_can_parse(const struct rte_bus *bus, const void *_name)
 {
 	const char *name = _name;
 
-	return !(bus->parse && bus->parse(name, NULL) == 0);
+	return !(bus->parse && bus->parse(name, NULL, 0, NULL) == 0);
 }
 
 struct rte_bus *
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 70aa04dcd9..b0a4739d5d 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -107,11 +107,42 @@ struct dev_next_ctx {
 #define CLSCTX(ptr) \
 	(((struct dev_next_ctx *)(intptr_t)ptr)->cls_str)
 
-static int cmp_dev_name(const struct rte_device *dev, const void *_name)
+int
+rte_cmp_dev_name(const struct rte_device *dev1, const void *name2)
 {
-	const char *name = _name;
+	void *parsed_name1;
+	void *parsed_name2;
+	int size1 = 0;
+	int size2 = 0;
+	int ret;
+
+	if (dev1->bus->parse(dev1->name, NULL, 0, &size1) != 0 ||
+		dev1->bus->parse(name2, NULL, 0, &size2) != 0)
+		return 1;
+
+	if (size1 != size2)
+		return 1;
+
+	parsed_name1 = malloc(size1);
+	if (parsed_name1 == NULL)
+		return 1;
+
+	parsed_name2 = malloc(size2);
+	if (parsed_name2 == NULL) {
+		free(parsed_name1);
+		return 1;
+	}
 
-	return strcmp(dev->name, name);
+	memset(parsed_name1, 0, size1);
+	memset(parsed_name2, 0, size2);
+
+	dev1->bus->parse(dev1->name, parsed_name1, size1, NULL);
+	dev1->bus->parse(name2, parsed_name2, size2, NULL);
+
+	ret = memcmp(parsed_name1, parsed_name2, size1);
+	free(parsed_name1);
+	free(parsed_name2);
+	return ret;
 }
 
 int
@@ -197,7 +228,7 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 	if (ret)
 		goto err_devarg;
 
-	dev = da->bus->find_device(NULL, cmp_dev_name, da->name);
+	dev = da->bus->find_device(NULL, rte_cmp_dev_name, da->name);
 	if (dev == NULL) {
 		EAL_LOG(ERR, "Cannot find device (%s)",
 			da->name);
@@ -335,7 +366,7 @@ rte_eal_hotplug_remove(const char *busname, const char *devname)
 		return -ENOENT;
 	}
 
-	dev = bus->find_device(NULL, cmp_dev_name, devname);
+	dev = bus->find_device(NULL, rte_cmp_dev_name, devname);
 	if (dev == NULL) {
 		EAL_LOG(ERR, "Cannot find plugged device (%s)", devname);
 		return -EINVAL;
diff --git a/lib/eal/common/hotplug_mp.c b/lib/eal/common/hotplug_mp.c
index 17089ca3db..a2623c96c3 100644
--- a/lib/eal/common/hotplug_mp.c
+++ b/lib/eal/common/hotplug_mp.c
@@ -21,13 +21,6 @@ struct mp_reply_bundle {
 	void *peer;
 };
 
-static int cmp_dev_name(const struct rte_device *dev, const void *_name)
-{
-	const char *name = _name;
-
-	return strcmp(dev->name, name);
-}
-
 /**
  * Secondary to primary request.
  * start from function eal_dev_hotplug_request_to_primary.
@@ -135,7 +128,7 @@ __handle_secondary_request(void *param)
 			goto finish;
 		}
 
-		dev = bus->find_device(NULL, cmp_dev_name, da.name);
+		dev = bus->find_device(NULL, rte_cmp_dev_name, da.name);
 		if (dev == NULL) {
 			EAL_LOG(ERR, "Cannot find plugged device (%s)", da.name);
 			ret = -ENOENT;
@@ -262,7 +255,7 @@ static void __handle_primary_request(void *param)
 			goto quit;
 		}
 
-		dev = bus->find_device(NULL, cmp_dev_name, da->name);
+		dev = bus->find_device(NULL, rte_cmp_dev_name, da->name);
 		if (dev == NULL) {
 			EAL_LOG(ERR, "Cannot find plugged device (%s)", da->name);
 			ret = -ENOENT;
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 60527b75b6..5a3e01b07d 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -112,11 +112,35 @@ typedef int (*rte_bus_unplug_t)(struct rte_device *dev);
  *	should be written. If NULL, nothing should be written, which
  *	is not an error.
  *
+ * @param[in] addr_size
+ *	size of addr.
+ *
+ * @param[out] out_size
+ *	device information size. If NULL, nothing should
+ *	be written, which is not an error.
+ *
  * @return
  *	0 if parsing was successful.
  *	!0 for any error.
  */
-typedef int (*rte_bus_parse_t)(const char *name, void *addr);
+typedef int (*rte_bus_parse_t)(const char *name, void *addr, int addr_size, int *out_size);
+
+/**
+ * Bus specific device name comparison function.
+ *
+ * This type of function is used to compare a bus name with an arbitrary
+ * name.
+ *
+ * @param dev
+ *	Device handle.
+ *
+ * @param name
+ *	Name to compare against.
+ *
+ * @return
+ *	0 if the device matches the name. Nonzero otherwise.
+ */
+typedef int (*rte_bus_cmp_name_t)(const struct rte_device *dev, const void *name);
 
 /**
  * Parse bus part of the device arguments.
@@ -258,6 +282,7 @@ struct rte_bus {
 	rte_bus_plug_t plug;         /**< Probe single device for drivers */
 	rte_bus_unplug_t unplug;     /**< Remove single device from driver */
 	rte_bus_parse_t parse;       /**< Parse a device name */
+	rte_bus_cmp_name_t cmp_name; /**< Compare device name */
 	rte_bus_devargs_parse_t devargs_parse; /**< Parse bus devargs */
 	rte_dev_dma_map_t dma_map;   /**< DMA map for device in the bus */
 	rte_dev_dma_unmap_t dma_unmap; /**< DMA unmap for device in the bus */
diff --git a/lib/eal/include/rte_dev.h b/lib/eal/include/rte_dev.h
index 738400e8d1..2df8143af1 100644
--- a/lib/eal/include/rte_dev.h
+++ b/lib/eal/include/rte_dev.h
@@ -17,6 +17,7 @@
 
 #include <rte_config.h>
 #include <rte_common.h>
+#include <rte_compat.h>
 #include <rte_log.h>
 
 #ifdef __cplusplus
@@ -170,6 +171,20 @@ int rte_dev_is_probed(const struct rte_device *dev);
 int rte_eal_hotplug_add(const char *busname, const char *devname,
 			const char *drvargs);
 
+/**
+ * General device name comparison. Will compare by using the specific bus
+ * compare function or by comparing the names directly.
+ *
+ * @param dev
+ *   Device handle.
+ * @param name
+ *   Name to compare against.
+ * @return
+ *   0 if the device matches the name. Nonzero otherwise.
+ */
+__rte_internal
+int rte_cmp_dev_name(const struct rte_device *dev, const void *name);
+
 /**
  * Add matching devices.
  *
diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index e63f24d108..3b68cda87f 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -91,14 +91,6 @@ static void sigbus_handler(int signum, siginfo_t *info,
 	EAL_LOG(DEBUG, "Success to handle SIGBUS for hot-unplug!");
 }
 
-static int cmp_dev_name(const struct rte_device *dev,
-	const void *_name)
-{
-	const char *name = _name;
-
-	return strcmp(dev->name, name);
-}
-
 static int
 dev_uev_socket_fd_create(void)
 {
@@ -280,7 +272,7 @@ dev_uev_handler(__rte_unused void *param)
 				goto failure_handle_err;
 			}
 
-			dev = bus->find_device(NULL, cmp_dev_name,
+			dev = bus->find_device(NULL, rte_cmp_dev_name,
 					       uevent.devname);
 			if (dev == NULL) {
 				EAL_LOG(ERR, "Cannot find device (%s) on "
diff --git a/lib/eal/version.map b/lib/eal/version.map
index a20c713eb1..e50a95fd31 100644
--- a/lib/eal/version.map
+++ b/lib/eal/version.map
@@ -448,4 +448,5 @@ INTERNAL {
 	rte_mem_unmap;
 	rte_thread_create_internal_control;
 	rte_thread_set_prefixed_name;
+	rte_cmp_dev_name;
 };
-- 
2.34.1

