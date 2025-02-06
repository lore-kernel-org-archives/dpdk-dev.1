Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD336C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 10:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7A6140DD3;
	Thu,  6 Feb 2025 11:55:17 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by mails.dpdk.org (Postfix) with ESMTP id 4DE0C40C35
 for <dev@dpdk.org>; Thu,  6 Feb 2025 11:55:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk+smbP+dqNj7S9R0j7PsDkGNkujX+oEag2n5YE2ly1DQzotTSz8OBAjb7YVH3sNN4/ILeIvfKN8PoEpy+KGvnTM1Y36HvAJA44IKGOF8ODYJ5ahCQ9Y3p3/nm1LUCrJZkCjdZTsxhwZuHJu/V8oMMuIMQ5cXFuL1ucPbzvTBfe1bz39sQCpTfRCby4Pxz+3Uyjxnz5Q0XaaPwOwzgy6owV7iJWOnFvABaLw3XHGy7KWQbCSs9TWGmMT3tGwqGjLEhfclkEZhJjAc6bT1Z3ih5jkbDlaIdyM2A8Ni7+yoEE0zdOuq61pFWesRYOjZACILvRIVa+M0pNTmML53dYDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSx68up67IYzooyln1BP7LQkG/2V31GpNEoTq6MktJA=;
 b=U5QerquoOX5LrDvLhK9g+poX2OjV0wAWlEURQAA16DkKflWQcFDQaz5tmy1X1MHfY4gGHbdv6eO6G++/VUSZWE26WLeL9/SlAMTE8XRDB5RcA9VJpNSG0HSnqt17MbovRyHLpw30UXLB13C3sVsuQN/ozNPNdlcfk8nXvRjnqaBDvwtz07OfXtXi2WbBajLxyfocPWphQAK8/iNZi6aFSjYZ/w0TwRpl/Npo29V1Smiwkw8s7FPikV2r5JOHtb3IiaZrzw+z/tL/aRHbo79o2XMCWKq2if5GDv2lCvNg0x8lCiWg8BuvRNhU4ruY91sybayVDlBRKyOU/ITs+xECYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSx68up67IYzooyln1BP7LQkG/2V31GpNEoTq6MktJA=;
 b=eJT5dqeRjF51Sjy0iHABYjleAy5juahfBtzkT7a1E2njIPfXl5wc388hZSHJmEtDLgONyy/cSHhanSm1Niqcs36H46fQvfQdKi+3nVFL31qyOw7WNgMaODVmfDRkDLBwuWyYH09lknFADgLAcc+ukQhK0LhIADfVc3LlcVHZ2H0yChJ/RO6kdCh57zqmLlEexq/HUXLmy41qXemEYtX8yy0xmW4vzn/iBKclG9wD8Uqemfa1g9297rM9tZgseAfItRAfwJR0hqMcSruRHucqtLDNl3yCBLciF5oHc8gABjbXqilvFEeNGTM+/CCRS7Z9ezPqD2A717qJKKF4ZO2vMg==
Received: from PH8PR02CA0025.namprd02.prod.outlook.com (2603:10b6:510:2da::15)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 10:55:09 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::ad) by PH8PR02CA0025.outlook.office365.com
 (2603:10b6:510:2da::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 10:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 10:55:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Feb 2025
 02:54:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Feb
 2025 02:54:49 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Feb 2025 02:54:44 -0800
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
Subject: [PATCH v6 4/4] lib: change find device and cmp dev name functions
Date: Thu, 6 Feb 2025 12:54:27 +0200
Message-ID: <20250206105428.237346-4-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206105428.237346-1-shperetz@nvidia.com>
References: <20250206000838.23428-5-shperetz@nvidia.com>
 <20250206105428.237346-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: a75f88f7-c281-4b9c-fa15-08dd469cb896
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mmD830Z07joXe1PyN4LXX0EWWq5LSB3+EW7V98epMgiZoJWaYxNS8902zU78?=
 =?us-ascii?Q?rVSRXwFbAKTpn3oGI9LKcwhmtiQMJB2MiQ5QHO1/ftO7Ng/3O+Kn/6pIaMol?=
 =?us-ascii?Q?m5g7wJZZ63CwgWFVx2H0emdxc2AOF7/1Lec80KLX+xkcmVdsPYtKGMr+LDH1?=
 =?us-ascii?Q?mpWry+z44L1WgXtcY/XWYAdpUb+9RvYXqr0V6mbyztBiyjrT5vf602QNREH5?=
 =?us-ascii?Q?cvqyRzCjtw/OwCbDKNOm91NZWHC4T5VjM7uMurVw53jdj3Sc444Oi+e0o53m?=
 =?us-ascii?Q?dAjsLT0kkhar/kZMPsbcZIzjyB+Ijw8tnU5IXn+EAtE9x+tGjdU6yeaWDdOC?=
 =?us-ascii?Q?rtdyMulUBi5WBnwvaetD3q/nRHbUvcyHf/krdKz42an9V8RO7CmAGUMc9voR?=
 =?us-ascii?Q?MVjkkXzqgFmk4OxiofvOZhP26LDE7zqkN6qk9kjkQBTaN05NqjHvSxJ9bslM?=
 =?us-ascii?Q?uzHxNKdbN89C3YGKNYuAJRtRPEtaYWt0tb7CmjxxBPnHONiZidBMTqpc4/2t?=
 =?us-ascii?Q?n7JVocMpbIcQX1Cfjk2YrBYqGZDZeH/IRlv5O+iThtGG7t62q5POuLsnUfhm?=
 =?us-ascii?Q?lTFD1Z+65buxRkaKwvTo3B/jrFqOSllTqml58pYDeO150DQapcMwYYz+YX7H?=
 =?us-ascii?Q?5nPzCG7takgOJOHxlxUv860tCAmlOs0jPYVo7N7W3QUsVU9tevRQEs6HdwOF?=
 =?us-ascii?Q?RnbM2ipfYQSOVx77mH3NNJ875n/pwy+995f2AFIIo4AA6JRnXBvCGE5rMzxU?=
 =?us-ascii?Q?zs4ErinR1NB2BUn0XxyK1CZ3x6q/h8v8Y/SnKI26hbDcFxVeRwT5Tr/VnIvl?=
 =?us-ascii?Q?tMBYvWNMHG0ivKa38FzT83Hl9sOtaz3IIfg64SyR+WDDoGuG1+iSDL3LDIXG?=
 =?us-ascii?Q?0ww+oQe9AhPQI2TXX99zpX1ycwdIuTP0cpaXfQpu3jVLha0PN9vndXEsUHVY?=
 =?us-ascii?Q?RSAtJWclM2+weyjq+yHXXqP4fOY4OR67MhRLCZd8f0pCWl9SzPd/fAiqx+zj?=
 =?us-ascii?Q?WUikjz0a3HTuESILFOIb3FGfuA+5mMP4mJvo9Bj2wZ60Z1sS6zAIiq1YC5We?=
 =?us-ascii?Q?u+KLrzA7YHL93co7Faj4wAKtCu2I1f72GRneWa9b+2CxXXsmtrvwZXjJpOoG?=
 =?us-ascii?Q?Du0La4kC9Ya0/PRv2P8bLKhOShf0ZGlKDwhbVI0KQwE3yqx5IHhsMP8K1/Dv?=
 =?us-ascii?Q?dWnNcgE9AJDg5Nch/4BAw/jrm3i4A9Rc/Xd8oaOJ/UZ35AyHi4rmufAIMpGI?=
 =?us-ascii?Q?jc/3aRdngFywpjvFqgVonNuQchWRyBokoUYzapb253yzuc+PDsKV7n3H0/vh?=
 =?us-ascii?Q?n0dZTTtntQyy8XbkmtyuUE33iop2V9griCgA8lB+eK+/CyruaDz1SAvNaMm4?=
 =?us-ascii?Q?Nazd4FFOUdkDd5T1g7MPLiFXMympIE1bcK7djVB2O6XEfB6wGbvEW4VZFlsL?=
 =?us-ascii?Q?BwEWEmnVvLtzK4dRaWMc6YPJgj5P0+PigcAzgHqmnQHZEPNOyXCWpCiQAGx+?=
 =?us-ascii?Q?5llaHteu14JhtXk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:55:08.0660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75f88f7-c281-4b9c-fa15-08dd469cb896
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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
index fab88b00ee..54dc4e122e 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -333,7 +333,12 @@ test_pci(struct rte_bus *pci_bus, const char *dev_name, const char *name2)
 
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
@@ -350,20 +355,30 @@ test_vdev(struct rte_bus *vdev_bus, const char *dev_name, const char *name2)
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

