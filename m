Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637C3C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 00:09:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A18DA40693;
	Thu,  6 Feb 2025 01:09:39 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by mails.dpdk.org (Postfix) with ESMTP id 2868440667
 for <dev@dpdk.org>; Thu,  6 Feb 2025 01:09:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6YGmPt2nUnb0O0JetSBs9rq4ChVD54BE59H5ctbwbcE9cMDE6UMnkzono3oMuylkEYiXAdLsfdToTvtlSSkAx9EsuSW2w/v3NOAt4/o+LZqPAzGjldbCwguZK9SUexJWGxrNLRBWh4rd2H0zg7ggTRvcuHBBWu6zfqC0qD1IeoKKu5S4MV0IOJKXPUM3vXRY/+ND03g9UuVWb0SgbKPozCgEI1GSNn3BwyFfwhra4jznMRq8nU57shmr6GUHvMNvXf+8OnqvticSoxutPJrsOyp4OkoRN1MqrfEILq2UsBc4bxjvuEeg4owhONogn0igCYufezzpTkIcZtq4KmNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YxiGyv2hsDh2jP+WvvRD9CJCZrRtcC4f/ag4z06dME=;
 b=eOL3Jp0itu80/bnsD6ESL09lxEPVh2CJPU+lkgiflNw7jK/AheuVa35LgzhbQL3AH4W8N4Qy/s0TgNWFRYnTqVt8iy2hnt5m9LWgRbJFIeJ1PHYbhOA+rlesYO/SlZNy34040RBA/sfVBhklHZaw5digyh5xaWzYeooU5f0Mu2RAQusySSXQqUYKIwK6sw1HgpFkBco43kIow7J05yoxk6yO8n2xyc57zWGWK4wC9RjqQpA/UGTBtqaB7lDBAnX0eQyUsZ4bqvOza4ez+U8NRX9nIRI75fWReR63zMK7wNAm1jYPmRTmXOqtUHTIx39+YvNrNUehIL/rf4hauwyAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YxiGyv2hsDh2jP+WvvRD9CJCZrRtcC4f/ag4z06dME=;
 b=kJS7Uue8IW9epIp7/JBLlVYNtAFdiOIpD6PoE79YWbTosoJIoRKO/oAyW1gy2SiDpDkIO5RJbh+gOnfbrt6G7i40C2pBWwr1udXXR5hwDn2WkaQ+7WA+NV8VxiY+Zm8De3HKoiDH6EHBXGTnzRS132A6I6CmI8QJBIbA9lR9rWxxAsJaJeDVVj5NT2G8Grr6sMPcj5npSf1ClYaKvrFuKbZzEAW8+wTmXE4QwApSD15OJZRbtdE42xAQ9wzAsEbCn9FFpKVkJU9gLZruo9Psov5FKiYEXh32feLMKXhd1UbioJLiRndmIM5Id/3ejDW6GRAQSAj7OMCYicum1pPOxg==
Received: from BN0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:408:e5::29)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 00:09:28 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::89) by BN0PR02CA0054.outlook.office365.com
 (2603:10b6:408:e5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Thu,
 6 Feb 2025 00:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 00:09:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 16:09:10 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 16:09:09 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Feb 2025 16:09:04 -0800
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
 "Kevin Laatz" <kevin.laatz@intel.com>, Chas Williams <chas3@att.com>, "Min Hu
 (Connor)" <humin29@huawei.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v5 4/4] lib: change find device and cmp dev name functions
Date: Thu, 6 Feb 2025 02:08:38 +0200
Message-ID: <20250206000838.23428-5-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206000838.23428-1-shperetz@nvidia.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 308123d9-2185-4231-c2f2-08dd464285e3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?90OtN1onzxhAqG25io6AQWoRPLmgBeBmwHWd6OctYrDYob8VXyzbHmL98dzT?=
 =?us-ascii?Q?MNRzmGQf8jgB4OPcy1T4jR6hrvgw0PSdzxgZPfcajjgmHHXYEW7f1+gf+jIK?=
 =?us-ascii?Q?KjAyOzJh6eCI4Ts99JSUUVRq0aSgn49UjneV63XKaGfmIgEuXEhSB2cxmvcz?=
 =?us-ascii?Q?2DUaywaSQqOXscr14dXuLmZSKLs5NCWcMK/2xoe0l42V+Y32LLdE2cdpvZ2j?=
 =?us-ascii?Q?fhwtj3I3iWuBpdrE/HaxvTX4ixDZIi/Ba4+rKXWD3DxCD70dp2ymgNs1l0OC?=
 =?us-ascii?Q?4dBWkCQEZHZUpPEoafIhWtXFV3LqHlMXjbYmsi6f5mItFLjJtTFA1KSCCMLo?=
 =?us-ascii?Q?zzwhEuopSNOmIk5xHGsH7ksgOBepdCGjVwMuZW9G0prPVj8SZDuD49bNwyYS?=
 =?us-ascii?Q?H/lrgs6JxbngLJGO18hT0xlMYn1YbTxtlzyKS9xJwgvBJ10fam+lauP+gwx+?=
 =?us-ascii?Q?B9OETogAgpvzt25m4G8PmIfQu2+I//6n8JGRMrspYtSM9Ei02/O9/yvEShyc?=
 =?us-ascii?Q?RIuMxmmW1v4UJi0GH23nuj/p4xGMO4WUhrFMAvJeVQXi5WUAerCMXWngT9Y0?=
 =?us-ascii?Q?ZSZ7g0i8Oq1+0Pau8mzCxyHyfg8bfcDTgqejor5WvJ89YvcM+ZY+XX6J5CSa?=
 =?us-ascii?Q?Fgt7yiZVKWjqcWbSa6lIGDLpyLJjGwwPzvDjcFrdqkrKtMQVCs3qUFxzDuE3?=
 =?us-ascii?Q?ZdwCcJ6QUuSiRIbHrBsueSX8cpKhaZNxbCtAnD5q/d5OlYOlzqb/20M7hQMI?=
 =?us-ascii?Q?GnaDePaG4hAYwcLcSX3UI4LSekYmSD9ITK8endJal2i+p3pMslJO6hebsU/M?=
 =?us-ascii?Q?/VeJrfxfg1DjNAhsdLjfJlwqh6Abdw26JvBD1jpGKc/SRA1zzKngXt3vVzr7?=
 =?us-ascii?Q?nGZvcU+AD1HSN2kfQkqQc+8mTceRZwPyl9imvkxY9Kib7fYvNeqT+2GNZiv7?=
 =?us-ascii?Q?n/BFpf08nRLRZRe/M70lwFsybNS+Ue+4eq0H3b36vO1PjVG+qkAqC4T1/74M?=
 =?us-ascii?Q?Q2E3H//CmQ7vVXa9reuBqJ/hag0G1bfKs5nzD8U8WrE7+qwXttCLxAGJxR3r?=
 =?us-ascii?Q?clMJqxnIqoQWX3rfO0FkeQCjIWMQB6Mi//yecyOVLY269a6A82GaMQGQo6KR?=
 =?us-ascii?Q?4ktuTHijaiP6qlMusjBPXNQZOl5az6hMNPTTzxlWm1wto2hCqvf0OKX+jXRE?=
 =?us-ascii?Q?UC6cGKXnsEQGmIZmYkswobalaQ+Jw2oakD4d5a3sLCmwDXBksoaynob6Byza?=
 =?us-ascii?Q?5z/JjZOfxyGLx3LuomKXrHyVREOy3iGfI1Sg4nBbL5QHDus/TOwljXeje3YA?=
 =?us-ascii?Q?FajyKZ3h7+pSWhrBqZCMUEc+2br9OzKyLkSQ1CVSaqIxm1xOg4eqMehcyK5u?=
 =?us-ascii?Q?Mu7cp8R2oa+c9dzjuB282WB3uKdzkNBT80SIE/ADtCWnYvqNnhcX43RY0mgB?=
 =?us-ascii?Q?Gq9NkK6iIAp148ahahTp//wgwwEbAuKQ02pXdy0NXVElxS6p1b3q7I1Iw4Nb?=
 =?us-ascii?Q?drzlfTQTYCOkkm4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 00:09:28.2529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308123d9-2185-4231-c2f2-08dd464285e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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

Change find_device and rte_cmp_dev_name to accept a struct
with pointer and size instead of a void* pointer.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test/test_devargs.c                  | 23 +++++++++++++++++++----
 app/test/test_vdev.c                     | 23 ++++++++++++++++++-----
 drivers/bus/auxiliary/auxiliary_common.c |  2 +-
 drivers/bus/auxiliary/auxiliary_params.c | 10 +++++++---
 drivers/bus/cdx/cdx.c                    | 12 ++++++++----
 drivers/bus/dpaa/dpaa_bus.c              |  2 +-
 drivers/bus/fslmc/fslmc_bus.c            |  2 +-
 drivers/bus/ifpga/ifpga_bus.c            |  2 +-
 drivers/bus/pci/pci_common.c             |  2 +-
 drivers/bus/pci/pci_params.c             | 10 +++++++---
 drivers/bus/platform/platform.c          |  3 ++-
 drivers/bus/platform/platform_params.c   | 10 +++++++---
 drivers/bus/uacce/uacce.c                | 13 +++++++++----
 drivers/bus/vdev/vdev.c                  |  2 +-
 drivers/bus/vdev/vdev_params.c           | 10 +++++++---
 drivers/bus/vdev/vdev_private.h          |  2 +-
 drivers/bus/vmbus/vmbus_common.c         |  2 +-
 drivers/dma/idxd/idxd_bus.c              |  4 ++--
 drivers/net/bonding/rte_eth_bond_args.c  | 15 +++++----------
 drivers/net/vdev_netvsc/vdev_netvsc.c    |  8 ++++++--
 drivers/raw/ifpga/ifpga_rawdev.c         |  6 +++++-
 lib/eal/common/eal_common_bus.c          | 10 +++++++---
 lib/eal/common/eal_common_dev.c          | 18 +++++++++++++-----
 lib/eal/common/hotplug_mp.c              | 12 ++++++++++--
 lib/eal/include/bus_driver.h             |  2 +-
 lib/eal/include/rte_dev.h                | 15 ++++++++++-----
 lib/eal/linux/eal_dev.c                  |  6 +++++-
 27 files changed, 156 insertions(+), 70 deletions(-)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 2d973a643a..e7b73f2ff1 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -336,7 +336,12 @@ test_pci(struct rte_bus *pci_bus, const char *dev_name, const char *name2)
 
 	pci_dev->bus = pci_bus;
 
-	if (rte_cmp_dev_name(pci_dev, name2) != 0) {
+	struct rte_bus_address addr = {
+		.addr = name2,
+		.size = strlen(name2)
+	};
+
+	if (rte_cmp_dev_name(pci_dev, &addr) != 0) {
 		printf("rte_cmp_dev_name(%s, %s) device name (%s) not expected (%s)\n",
 			       pci_dev->name, name2, pci_dev->name, name2);
 		return -1;
@@ -353,20 +358,30 @@ test_vdev(struct rte_bus *vdev_bus, const char *dev_name, const char *name2)
 		return -1;
 	}
 
-	struct rte_device *vdev_dev = vdev_bus->find_device(NULL, rte_cmp_dev_name, dev_name);
+	struct rte_bus_address dev_addr = {
+		.addr = dev_name,
+		.size = strlen(dev_name)
+	};
+
+	struct rte_device *vdev_dev = vdev_bus->find_device(NULL, rte_cmp_dev_name, &dev_addr);
 	if (vdev_dev == NULL) {
 		printf("Cannot find %s vdev\n", dev_name);
 		rte_vdev_uninit(dev_name);
 		return -1;
 	}
-	int ret = rte_cmp_dev_name(vdev_dev, name2);
+
+	struct rte_bus_address dev_addr2 = {
+		.addr = name2,
+		.size = strlen(name2)
+	};
+	int ret = rte_cmp_dev_name(vdev_dev, &dev_addr2);
 	if (ret != 0) {
 		printf("rte_cmp_dev_name(%s, %s) device name (%s) not expected (%s)\n",
 			       vdev_dev->name, name2, vdev_dev->name, name2);
 		return -1;
 	}
 
-	if (vdev_dev != vdev_bus->find_device(NULL, rte_cmp_dev_name, name2)) {
+	if (vdev_dev != vdev_bus->find_device(NULL, rte_cmp_dev_name, &dev_addr2)) {
 		printf("rte_cmp_dev_name(%s, %s) device name (%s) not expected (%s)\n",
 			       vdev_dev->name, name2, vdev_dev->name, name2);
 		return -1;
diff --git a/app/test/test_vdev.c b/app/test/test_vdev.c
index 860fa260af..568c16593e 100644
--- a/app/test/test_vdev.c
+++ b/app/test/test_vdev.c
@@ -21,9 +21,9 @@ static const char * const valid_keys[] = {
 };
 
 static int
-cmp_dev_match(const struct rte_device *dev, const void *_kvlist)
+cmp_dev_match(const struct rte_device *dev, const struct rte_bus_address *_kvlist)
 {
-	const struct rte_kvargs *kvlist = _kvlist;
+	const struct rte_kvargs *kvlist = _kvlist->addr;
 	const char *key = TEST_VDEV_KEY_NAME;
 	const char *name;
 
@@ -54,7 +54,11 @@ get_matching_vdev(const char *match_str)
 		}
 	}
 
-	dev = vdev_bus->find_device(NULL, cmp_dev_match, kvargs);
+	struct rte_bus_address dev_addr = {
+		.addr = kvargs,
+		.size = sizeof(struct rte_kvargs),
+	};
+	dev = vdev_bus->find_device(NULL, cmp_dev_match, &dev_addr);
 	rte_kvargs_free(kvargs);
 
 	return dev;
@@ -76,7 +80,12 @@ test_vdev_bus(void)
 		printf("Failed to create vdev net_null_test0\n");
 		goto fail;
 	}
-	dev0 = vdev_bus->find_device(NULL, rte_cmp_dev_name, "net_null_test0");
+
+	struct rte_bus_address dev0_addr = {
+		.addr = "net_null_test0",
+		.size = strlen("net_null_test0")
+	};
+	dev0 = vdev_bus->find_device(NULL, rte_cmp_dev_name, &dev0_addr);
 	if (dev0 == NULL) {
 		printf("Cannot find net_null_test0 vdev\n");
 		goto fail;
@@ -87,7 +96,11 @@ test_vdev_bus(void)
 		printf("Failed to create vdev net_null_test1\n");
 		goto fail;
 	}
-	dev1 = vdev_bus->find_device(NULL, rte_cmp_dev_name, "net_null_test1");
+	struct rte_bus_address dev1_addr = {
+		.addr = "net_null_test1",
+		.size = strlen("net_null_test1")
+	};
+	dev1 = vdev_bus->find_device(NULL, rte_cmp_dev_name, &dev1_addr);
 	if (dev1 == NULL) {
 		printf("Cannot find net_null_test1 vdev\n");
 		goto fail;
diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index ba2f69e851..091e559c60 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -300,7 +300,7 @@ rte_auxiliary_remove_device(struct rte_auxiliary_device *auxiliary_dev)
 
 static struct rte_device *
 auxiliary_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		      const void *data)
+		      const struct rte_bus_address *data)
 {
 	const struct rte_auxiliary_device *pstart;
 	struct rte_auxiliary_device *adev;
diff --git a/drivers/bus/auxiliary/auxiliary_params.c b/drivers/bus/auxiliary/auxiliary_params.c
index e4c7ee0c3b..93f0bd46be 100644
--- a/drivers/bus/auxiliary/auxiliary_params.c
+++ b/drivers/bus/auxiliary/auxiliary_params.c
@@ -22,9 +22,9 @@ static const char * const auxiliary_params_keys[] = {
 
 static int
 auxiliary_dev_match(const struct rte_device *dev,
-	      const void *_kvlist)
+	      const struct rte_bus_address *_kvlist)
 {
-	const struct rte_kvargs *kvlist = _kvlist;
+	const struct rte_kvargs *kvlist = _kvlist->addr;
 	const char *key = auxiliary_params_keys[RTE_AUXILIARY_PARAM_NAME];
 	const char *name;
 
@@ -59,7 +59,11 @@ auxiliary_dev_iterate(const void *start,
 		}
 	}
 	find_device = auxiliary_bus.bus.find_device;
-	dev = find_device(start, auxiliary_dev_match, kvargs);
+	struct rte_bus_address dev_addr = {
+		.addr = kvargs,
+		.size = sizeof(struct rte_kvargs),
+	};
+	dev = find_device(start, auxiliary_dev_match, &dev_addr);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index b97f1ce1af..58596d1f71 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -500,7 +500,7 @@ rte_cdx_unregister(struct rte_cdx_driver *driver)
 
 static struct rte_device *
 cdx_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		const void *data)
+		const struct rte_bus_address *data)
 {
 	const struct rte_cdx_device *cdx_start;
 	struct rte_cdx_device *cdx_dev;
@@ -613,9 +613,9 @@ cdx_get_iommu_class(void)
 
 static int
 cdx_dev_match(const struct rte_device *dev,
-		const void *_kvlist)
+		const struct rte_bus_address *_kvlist)
 {
-	const struct rte_kvargs *kvlist = _kvlist;
+	const struct rte_kvargs *kvlist = _kvlist->addr;
 	const char *key = cdx_params_keys[RTE_CDX_PARAM_NAME];
 	const char *name;
 
@@ -649,7 +649,11 @@ cdx_dev_iterate(const void *start,
 		}
 	}
 	find_device = rte_cdx_bus.bus.find_device;
-	dev = find_device(start, cdx_dev_match, kvargs);
+	struct rte_bus_address dev_addr = {
+		.addr = kvargs,
+		.size = sizeof(struct rte_kvargs),
+	};
+	dev = find_device(start, cdx_dev_match, &dev_addr);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index f768fb9454..5a24fc2f47 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -745,7 +745,7 @@ rte_dpaa_bus_probe(void)
 
 static struct rte_device *
 rte_dpaa_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		     const void *data)
+		     const struct rte_bus_address *data)
 {
 	struct rte_dpaa_device *dev;
 	const struct rte_dpaa_device *dstart;
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index a525b5e245..7a80cb41f1 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -497,7 +497,7 @@ rte_fslmc_probe(void)
 
 static struct rte_device *
 rte_fslmc_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		      const void *data)
+		      const struct rte_bus_address *data)
 {
 	const struct rte_dpaa2_device *dstart;
 	struct rte_dpaa2_device *dev;
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index d5d9a86a97..195429c1d4 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -443,7 +443,7 @@ ifpga_unplug(struct rte_device *dev)
 
 static struct rte_device *
 ifpga_find_device(const struct rte_device *start,
-	rte_dev_cmp_t cmp, const void *data)
+	rte_dev_cmp_t cmp, const struct rte_bus_address *data)
 {
 	struct rte_afu_device *afu_dev;
 
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 82632bc473..29cec5f588 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -540,7 +540,7 @@ rte_pci_remove_device(struct rte_pci_device *pci_dev)
 
 static struct rte_device *
 pci_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		const void *data)
+		const struct rte_bus_address *data)
 {
 	const struct rte_pci_device *pstart;
 	struct rte_pci_device *pdev;
diff --git a/drivers/bus/pci/pci_params.c b/drivers/bus/pci/pci_params.c
index 087ec38bb9..de7ea8f2f8 100644
--- a/drivers/bus/pci/pci_params.c
+++ b/drivers/bus/pci/pci_params.c
@@ -41,9 +41,9 @@ pci_addr_kv_cmp(const char *key __rte_unused,
 
 static int
 pci_dev_match(const struct rte_device *dev,
-	      const void *_kvlist)
+	      const struct rte_bus_address *_kvlist)
 {
-	const struct rte_kvargs *kvlist = _kvlist;
+	const struct rte_kvargs *kvlist = _kvlist->addr;
 	const struct rte_pci_device *pdev;
 
 	if (kvlist == NULL)
@@ -76,7 +76,11 @@ rte_pci_dev_iterate(const void *start,
 		}
 	}
 	find_device = rte_pci_bus.bus.find_device;
-	dev = find_device(start, pci_dev_match, kvargs);
+	struct rte_bus_address dev_addr = {
+		.addr = kvargs,
+		.size = sizeof(struct rte_kvargs),
+	};
+	dev = find_device(start, pci_dev_match, &dev_addr);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 87ed7404e1..5b72418ad0 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -473,7 +473,8 @@ platform_bus_probe(void)
 }
 
 static struct rte_device *
-platform_bus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp, const void *data)
+platform_bus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
+		const struct rte_bus_address *data)
 {
 	struct rte_platform_device *pdev;
 
diff --git a/drivers/bus/platform/platform_params.c b/drivers/bus/platform/platform_params.c
index 8a6214b97c..00f6774c8c 100644
--- a/drivers/bus/platform/platform_params.c
+++ b/drivers/bus/platform/platform_params.c
@@ -27,10 +27,10 @@ static const char * const platform_params_keys[] = {
 };
 
 static int
-platform_dev_match(const struct rte_device *dev, const void *_kvlist)
+platform_dev_match(const struct rte_device *dev, const struct rte_bus_address *_kvlist)
 {
 	const char *key = platform_params_keys[RTE_PLATFORM_PARAM_NAME];
-	const struct rte_kvargs *kvlist = _kvlist;
+	const struct rte_kvargs *kvlist = _kvlist->addr;
 	const char *name;
 
 	/* no kvlist arg, all devices match */
@@ -68,7 +68,11 @@ platform_bus_dev_iterate(const void *start, const char *str,
 		return NULL;
 	}
 
-	dev = platform_bus.bus.find_device(start, platform_dev_match, kvargs);
+	struct rte_bus_address dev_addr = {
+		.addr = kvargs,
+		.size = sizeof(struct rte_kvargs),
+	};
+	dev = platform_bus.bus.find_device(start, platform_dev_match, &dev_addr);
 	rte_kvargs_free(kvargs);
 
 	return dev;
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index b18fbe1103..76d4c3f467 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -508,7 +508,8 @@ uacce_unplug(struct rte_device *dev)
 }
 
 static struct rte_device *
-uacce_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,  const void *data)
+uacce_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
+		const struct rte_bus_address *data)
 {
 	const struct rte_uacce_device *uacce_start;
 	struct rte_uacce_device *uacce_dev;
@@ -549,10 +550,10 @@ uacce_parse(const char *name, void *addr, int *size)
 }
 
 static int
-uacce_dev_match(const struct rte_device *dev, const void *_kvlist)
+uacce_dev_match(const struct rte_device *dev, const struct rte_bus_address *_kvlist)
 {
 	const char *key = uacce_params_keys[RTE_UACCE_PARAM_NAME];
-	const struct rte_kvargs *kvlist = _kvlist;
+	const struct rte_kvargs *kvlist = _kvlist->addr;
 	const char *name;
 
 	/* no kvlist arg, all devices match. */
@@ -583,7 +584,11 @@ uacce_dev_iterate(const void *start, const char *str,
 		}
 	}
 	find_device = uacce_bus.bus.find_device;
-	dev = find_device(start, uacce_dev_match, kvargs);
+	struct rte_bus_address dev_addr = {
+		.addr = kvargs,
+		.size = sizeof(struct rte_kvargs),
+	};
+	dev = find_device(start, uacce_dev_match, &dev_addr);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 0d3c8ca3c5..e287c8cf64 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -621,7 +621,7 @@ vdev_cleanup(void)
 
 struct rte_device *
 rte_vdev_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		     const void *data)
+		     const struct rte_bus_address *data)
 {
 	const struct rte_vdev_device *vstart;
 	struct rte_vdev_device *dev;
diff --git a/drivers/bus/vdev/vdev_params.c b/drivers/bus/vdev/vdev_params.c
index 68ae09e2e9..7197c0f350 100644
--- a/drivers/bus/vdev/vdev_params.c
+++ b/drivers/bus/vdev/vdev_params.c
@@ -24,9 +24,9 @@ static const char * const vdev_params_keys[] = {
 
 static int
 vdev_dev_match(const struct rte_device *dev,
-	       const void *_kvlist)
+	       const struct rte_bus_address *_kvlist)
 {
-	const struct rte_kvargs *kvlist = _kvlist;
+	const struct rte_kvargs *kvlist = _kvlist->addr;
 	const char *key = vdev_params_keys[RTE_VDEV_PARAM_NAME];
 	const char *name;
 
@@ -58,7 +58,11 @@ rte_vdev_dev_iterate(const void *start,
 			return NULL;
 		}
 	}
-	dev = rte_vdev_find_device(start, vdev_dev_match, kvargs);
+	struct rte_bus_address dev_addr = {
+		.addr = kvargs,
+		.size = sizeof(struct rte_kvargs),
+	};
+	dev = rte_vdev_find_device(start, vdev_dev_match, &dev_addr);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/vdev/vdev_private.h b/drivers/bus/vdev/vdev_private.h
index e683f5f133..ef15266b16 100644
--- a/drivers/bus/vdev/vdev_private.h
+++ b/drivers/bus/vdev/vdev_private.h
@@ -14,7 +14,7 @@ extern "C" {
 struct rte_device *
 rte_vdev_find_device(const struct rte_device *start,
 		     rte_dev_cmp_t cmp,
-		     const void *data);
+		     const struct rte_bus_address *data);
 
 void *
 rte_vdev_dev_iterate(const void *start,
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 18805aee0d..06aa64c20d 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -323,7 +323,7 @@ vmbus_remove_device(struct rte_vmbus_device *vmbus_dev)
 /* VMBUS doesn't support hotplug */
 static struct rte_device *
 vmbus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		  const void *data)
+		  const struct rte_bus_address *data)
 {
 	struct rte_vmbus_device *dev;
 
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index d68e8b630e..ee33ddbfb4 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -45,7 +45,7 @@ struct dsa_bus;
 static int dsa_scan(void);
 static int dsa_probe(void);
 static struct rte_device *dsa_find_device(const struct rte_device *start,
-		rte_dev_cmp_t cmp,  const void *data);
+		rte_dev_cmp_t cmp,  const struct rte_bus_address *data);
 static enum rte_iova_mode dsa_get_iommu_class(void);
 static int dsa_addr_parse(const char *name, void *addr, int *size);
 
@@ -366,7 +366,7 @@ dsa_scan(void)
 
 static struct rte_device *
 dsa_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-			 const void *data)
+			 const struct rte_bus_address *data)
 {
 	struct rte_dsa_device *dev = TAILQ_FIRST(&dsa_bus.device_list);
 
diff --git a/drivers/net/bonding/rte_eth_bond_args.c b/drivers/net/bonding/rte_eth_bond_args.c
index bdec5d61d4..2ef42db796 100644
--- a/drivers/net/bonding/rte_eth_bond_args.c
+++ b/drivers/net/bonding/rte_eth_bond_args.c
@@ -23,15 +23,6 @@ const char *pmd_bond_init_valid_arguments[] = {
 	NULL
 };
 
-static inline int
-bond_pci_addr_cmp(const struct rte_device *dev, const void *_pci_addr)
-{
-	const struct rte_pci_device *pdev = RTE_DEV_TO_PCI_CONST(dev);
-	const struct rte_pci_addr *paddr = _pci_addr;
-
-	return rte_pci_addr_cmp(&pdev->addr, paddr);
-}
-
 static inline int
 find_port_id_by_pci_addr(const struct rte_pci_addr *pci_addr)
 {
@@ -45,7 +36,11 @@ find_port_id_by_pci_addr(const struct rte_pci_addr *pci_addr)
 		return -1;
 	}
 
-	dev = pci_bus->find_device(NULL, bond_pci_addr_cmp, pci_addr);
+	struct rte_bus_address dev_addr = {
+		.addr = pci_addr,
+		.size = PCI_PRI_STR_SIZE
+	};
+	dev = pci_bus->find_device(NULL, rte_cmp_dev_name, &dev_addr);
 	if (dev == NULL) {
 		RTE_BOND_LOG(ERR, "unable to find PCI device");
 		return -1;
diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..020b703906 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -771,7 +771,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_vdev_netvsc,
 /** Compare function for vdev find device operation. */
 static int
 vdev_netvsc_cmp_rte_device(const struct rte_device *dev1,
-			   __rte_unused const void *_dev2)
+			   __rte_unused const struct rte_bus_address *_dev2)
 {
 	return strncmp(dev1->devargs->name, VDEV_NETVSC_DRIVER_NAME,
 		       VDEV_NETVSC_DRIVER_NAME_LEN);
@@ -794,8 +794,12 @@ vdev_netvsc_scan_callback(__rte_unused void *arg)
 			     VDEV_NETVSC_DRIVER_NAME_LEN))
 			return;
 
+	struct rte_bus_address dev_addr = {
+		.addr = VDEV_NETVSC_DRIVER_NAME,
+		.size = VDEV_NETVSC_DRIVER_NAME_LEN,
+	};
 	dev = vbus->find_device(NULL, vdev_netvsc_cmp_rte_device,
-				VDEV_NETVSC_DRIVER_NAME);
+				&dev_addr);
 	if (dev)
 		return;
 	if (rte_devargs_add(RTE_DEVTYPE_VIRTUAL, VDEV_NETVSC_DRIVER_NAME))
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 7238246e1c..9a081fd5d8 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1868,7 +1868,11 @@ ifpga_cfg_remove(struct rte_vdev_device *vdev)
 		args.port, args.bdf);
 	bus = rte_bus_find_by_name(RTE_STR(IFPGA_BUS_NAME));
 	if (bus) {
-		if (bus->find_device(NULL, rte_cmp_dev_name, dev_name)) {
+		struct rte_bus_address dev_addr = {
+			.addr = dev_name,
+			.size = RTE_RAWDEV_NAME_MAX_LEN
+		};
+		if (bus->find_device(NULL, rte_cmp_dev_name, &dev_addr)) {
 			ret = rte_eal_hotplug_remove(RTE_STR(IFPGA_BUS_NAME),
 				dev_name);
 		}
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index b1bb5df5b7..15d3cfb29b 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -159,9 +159,9 @@ rte_bus_find(const struct rte_bus *start, rte_bus_cmp_t cmp,
 }
 
 static int
-cmp_rte_device(const struct rte_device *dev1, const void *_dev2)
+cmp_rte_device(const struct rte_device *dev1, const struct rte_bus_address *_dev2)
 {
-	const struct rte_device *dev2 = _dev2;
+	const struct rte_device *dev2 = _dev2->addr;
 
 	return dev1 != dev2;
 }
@@ -171,7 +171,11 @@ bus_find_device(const struct rte_bus *bus, const void *_dev)
 {
 	struct rte_device *dev;
 
-	dev = bus->find_device(NULL, cmp_rte_device, _dev);
+	struct rte_bus_address dev_addr = {
+		.addr = _dev,
+		.size = 0,
+	};
+	dev = bus->find_device(NULL, cmp_rte_device, &dev_addr);
 	return dev == NULL;
 }
 
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index c0e2202482..4e4951a73f 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -108,7 +108,7 @@ struct dev_next_ctx {
 	(((struct dev_next_ctx *)(intptr_t)ptr)->cls_str)
 
 int
-rte_cmp_dev_name(const struct rte_device *dev1, const void *name2)
+rte_cmp_dev_name(const struct rte_device *dev1, const struct rte_bus_address *dev2_addr)
 {
 	void *parsed_name1;
 	void *parsed_name2;
@@ -117,7 +117,7 @@ rte_cmp_dev_name(const struct rte_device *dev1, const void *name2)
 	int ret;
 
 	if (dev1->bus->parse(dev1->name, NULL, &size1) != 0 ||
-		dev1->bus->parse(name2, NULL, &size2) != 0)
+		dev1->bus->parse(dev2_addr->addr, NULL, &size2) != 0)
 		return 1;
 
 	if (size1 != size2)
@@ -137,7 +137,7 @@ rte_cmp_dev_name(const struct rte_device *dev1, const void *name2)
 	memset(parsed_name2, 0, size2);
 
 	dev1->bus->parse(dev1->name, parsed_name1, NULL);
-	dev1->bus->parse(name2, parsed_name2, NULL);
+	dev1->bus->parse(dev2_addr->addr, parsed_name2, NULL);
 
 	ret = memcmp(parsed_name1, parsed_name2, size1);
 	free(parsed_name1);
@@ -228,7 +228,11 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 	if (ret)
 		goto err_devarg;
 
-	dev = da->bus->find_device(NULL, rte_cmp_dev_name, da->name);
+	struct rte_bus_address dev_addr = {
+		.addr = da->name,
+		.size = RTE_DEV_NAME_MAX_LEN
+	};
+	dev = da->bus->find_device(NULL, rte_cmp_dev_name, &dev_addr);
 	if (dev == NULL) {
 		EAL_LOG(ERR, "Cannot find device (%s)",
 			da->name);
@@ -366,7 +370,11 @@ rte_eal_hotplug_remove(const char *busname, const char *devname)
 		return -ENOENT;
 	}
 
-	dev = bus->find_device(NULL, rte_cmp_dev_name, devname);
+	struct rte_bus_address dev_addr = {
+		.addr = devname,
+		.size = strlen(devname)
+	};
+	dev = bus->find_device(NULL, rte_cmp_dev_name, &dev_addr);
 	if (dev == NULL) {
 		EAL_LOG(ERR, "Cannot find plugged device (%s)", devname);
 		return -EINVAL;
diff --git a/lib/eal/common/hotplug_mp.c b/lib/eal/common/hotplug_mp.c
index a2623c96c3..f4cce7c2e5 100644
--- a/lib/eal/common/hotplug_mp.c
+++ b/lib/eal/common/hotplug_mp.c
@@ -128,7 +128,11 @@ __handle_secondary_request(void *param)
 			goto finish;
 		}
 
-		dev = bus->find_device(NULL, rte_cmp_dev_name, da.name);
+		struct rte_bus_address dev_addr = {
+			.addr = da.name,
+			.size = RTE_DEV_NAME_MAX_LEN
+		};
+		dev = bus->find_device(NULL, rte_cmp_dev_name, &dev_addr);
 		if (dev == NULL) {
 			EAL_LOG(ERR, "Cannot find plugged device (%s)", da.name);
 			ret = -ENOENT;
@@ -255,7 +259,11 @@ static void __handle_primary_request(void *param)
 			goto quit;
 		}
 
-		dev = bus->find_device(NULL, rte_cmp_dev_name, da->name);
+		struct rte_bus_address dev_addr = {
+			.addr = da->name,
+			.size = RTE_DEV_NAME_MAX_LEN
+		};
+		dev = bus->find_device(NULL, rte_cmp_dev_name, &dev_addr);
 		if (dev == NULL) {
 			EAL_LOG(ERR, "Cannot find plugged device (%s)", da->name);
 			ret = -ENOENT;
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 01447670de..16e8838868 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -70,7 +70,7 @@ typedef int (*rte_bus_probe_t)(void);
  */
 typedef struct rte_device *
 (*rte_bus_find_device_t)(const struct rte_device *start, rte_dev_cmp_t cmp,
-			 const void *data);
+			 const struct rte_bus_address *data);
 
 /**
  * Implementation specific probe function which is responsible for linking
diff --git a/lib/eal/include/rte_dev.h b/lib/eal/include/rte_dev.h
index 2df8143af1..47a6c22b53 100644
--- a/lib/eal/include/rte_dev.h
+++ b/lib/eal/include/rte_dev.h
@@ -171,19 +171,24 @@ int rte_dev_is_probed(const struct rte_device *dev);
 int rte_eal_hotplug_add(const char *busname, const char *devname,
 			const char *drvargs);
 
+struct rte_bus_address {
+	const void *addr;
+	size_t size;
+};
+
 /**
  * General device name comparison. Will compare by using the specific bus
  * compare function or by comparing the names directly.
  *
  * @param dev
  *   Device handle.
- * @param name
- *   Name to compare against.
+ * @param addr
+ *   Address to compare against.
  * @return
- *   0 if the device matches the name. Nonzero otherwise.
+ *   0 if the device matches the address. Nonzero otherwise.
  */
 __rte_internal
-int rte_cmp_dev_name(const struct rte_device *dev, const void *name);
+int rte_cmp_dev_name(const struct rte_device *dev, const struct rte_bus_address *addr);
 
 /**
  * Add matching devices.
@@ -245,7 +250,7 @@ int rte_dev_remove(struct rte_device *dev);
  *   <0 if ordering is possible and the device is lower than the data.
  *   >0 if ordering is possible and the device is greater than the data.
  */
-typedef int (*rte_dev_cmp_t)(const struct rte_device *dev, const void *data);
+typedef int (*rte_dev_cmp_t)(const struct rte_device *dev, const struct rte_bus_address *data);
 
 #define RTE_PMD_EXPORT_NAME_ARRAY(n, idx) n##idx[]
 
diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index 3b68cda87f..22c126278b 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -272,8 +272,12 @@ dev_uev_handler(__rte_unused void *param)
 				goto failure_handle_err;
 			}
 
+			const struct rte_bus_address dev_addr = {
+				.addr = uevent.devname,
+				.size = strlen(uevent.devname)
+			};
 			dev = bus->find_device(NULL, rte_cmp_dev_name,
-					       uevent.devname);
+					       &dev_addr);
 			if (dev == NULL) {
 				EAL_LOG(ERR, "Cannot find device (%s) on "
 					"bus (%s)", uevent.devname, busname);
-- 
2.34.1

