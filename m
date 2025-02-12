Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2CEC021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:39:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C087B42E12;
	Wed, 12 Feb 2025 17:39:12 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by mails.dpdk.org (Postfix) with ESMTP id E546342DD1
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:39:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHmQmjVhHaTXYnWInOvOH74x/+fdwIcQaCuw+YPmH+ZI27yxLkgiz3fK0iYGXIVJv/eZAyTGvT3RQoZtPKECjupZwbTZGhzQ3s2yRNsGzbpipO8oIrGjQ4khBjAjIAsWQCuEz7CUMP3S2XpgRtZaGjFuC8ZsQliz7RwLHMGUm5c9jG+WWwBVm4hiDrH60iUtSHrnL4V1Gy682RHv1PveSz6UzuSMrP6gVu+UM5Mtnc8279nY1BvVavF8BU7PdxYfts42yaIsRRiTPAYsWqY4V1EgkrDJDlEWi/1fl0ORnWF7+NvgmtXBLMQ8hAZqPn+FrP8j1YDrNLRUc7HwhYkFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaE4hBP7MnukQtNIn5/fV7HxozTtIzykzjWQbw3oAhw=;
 b=phmVvPGv80wBrCiNnt+n/HNQ53h+5agZdqZGa85ZQRXIw2QWwCp2s+jRt1iXs4e2In5Gv3BBY+DN4kYS5OGZLbt9UlM9IPv4oiDJ4TZ6PHVktvSdxkCJWjb+mLVlbAqQ2zyibwHDZ2kSSfNFJ8NMD8vZ/2TcKqA1WZms+mIxNhqrHN/ex5IBO0fz0b+ONXnj+a2Tfxeln83JXwQ1Xzt0kg6JfhX/ttr8+jNrM9Z2XoZJpDTSwXadr3G5lghsHI7flPL2P7zGqwvPogbt2UeE7sTV6kjkjQqL7fCSjg2Z1mdg28kD5/iXLPRYshkK3/AG1MzoVva03LjWjJND3Qosyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaE4hBP7MnukQtNIn5/fV7HxozTtIzykzjWQbw3oAhw=;
 b=BV2HBDJBzQmDODC9O9ZhONpk1u+W3bR3eJSb1HdqFlhwyUZnv7GFzRdynyAGgEosKnsSBH2dH5v0/udaJkYrl+IlodQmtprgwMfRwU8mprFEEiJjR4owuPH4pCvVyQ8VGVN9kvXYvlkOwM1AH+hbSobIzfAQcOKmEvboBTnioDpK4dJ0TQrtzF8FCDEcQsjxsaco9YKYF4FNKaECujqVLhPmwdEX6GugbQCW5/zC006YV+cfoSZIx5MKJD5HvTqbL83CPnyyyQ/NEjooBekDMvJG3x/tcHl3lR618rN8sgPQ3xCbpJlZxBUp0ykcBherPNkpuNZrs1568jhMsEWIrA==
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 16:39:07 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::52) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 16:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 16:39:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 08:38:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 08:38:50 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Feb 2025 08:38:49 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>
Subject: [PATCH v7 3/4] app/test: add tests to find devices
Date: Wed, 12 Feb 2025 18:38:34 +0200
Message-ID: <20250212163836.178976-3-shperetz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e16a7c-c662-4a1b-225a-08dd4b83c47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?55WaydaZczJksu4FMtxxYMrO1f6Ev/CMOJmNflW9LxQLhmmsI+qgar8uwDXV?=
 =?us-ascii?Q?lqCG820DqOe1hJ+bQLGL5q02G+iCLx01rfgaFHn99trjDXtOlH/mkrANNgQz?=
 =?us-ascii?Q?29KsNwHz4ibqgonPvset3IiwzdexahZEu2S1sXsQO4E32Iu//uRbfhS7OnL1?=
 =?us-ascii?Q?nowJNcslyh3B1j2uo1nQHHZR3yGneucbnqV8NM5ZPc2y21B3Rw2Pwp5tEDyA?=
 =?us-ascii?Q?fNR7qbYbleCig4oE1/QJSwQo/N4PkJfaFbmV6p0HYHQe9dz++dm6vmqC8wQB?=
 =?us-ascii?Q?aP/srasfPu/8Y0SGUIXJAJcaZoPNP+PIFVEXkSlGYTB2aUg4sjFcz5K+bJUW?=
 =?us-ascii?Q?qlTp8rGJ8L7r+2336Htliw8lHvdomN9cBDFQkqKZ3CLVVIPBV4okHxB3vnpD?=
 =?us-ascii?Q?VvbiPp5X79uSwPU7JXCuz8gEnlhWxOX+HiX4W7ORb9A24769Md19yAGAJOnq?=
 =?us-ascii?Q?06QwzAcYD0kPTdqV56TDIPAQ7FhAcoqWuJLPngBR+XviJV1pXIPx8cwyxr9D?=
 =?us-ascii?Q?BhJqmRRCyNzMqhC86a7LsB7AjxgTTiYc1jJFxgoidWpruGZAPzZYKadf+FR8?=
 =?us-ascii?Q?8vfC2SRmF48mkBRI3+V0VJKWPhjfG6aLqbnoQrBTZ9cIGflEgPZ7L7RqW5/M?=
 =?us-ascii?Q?7ucd+X2nH6dtMreQu/0cb4fgKrF09f6qJ8CQA9ZaEJgvijJUE56yI5FRMhjR?=
 =?us-ascii?Q?o8rdmPnWUWSY2MfWgB/kvP2hCq0PU4wiOlydpYZxzDaziXeKfuyEfGYH34Kh?=
 =?us-ascii?Q?CbCQsfSiGlSm48NWMQkZx+aF116U4pf+6vXSj8YPodw6EMPGGifPnlQEwmsi?=
 =?us-ascii?Q?r8YsPvypxAdZVYd4ohH2B6IGI5RHgWp+jLnUotHzZZezSZd4snacqDwZuPVL?=
 =?us-ascii?Q?3ZOGdm5N+7i1AJel6LTVjZrGJJnNXsQNAm0x9TWTtCEhp0wO7bkc4ErkpM/l?=
 =?us-ascii?Q?tvg2F5gmHwrkl+HyKk/9+agObWpm+4GD+7OwDJbDgeC6GU70DKZbFQEisGqd?=
 =?us-ascii?Q?3r7Ueaf7jEQb9uwAyltp0d7vJpt4SDZoSe+5uRZg+yX+pxDRgxFpJowIVi40?=
 =?us-ascii?Q?W2ZGEM1vnAwn5hyEGWdrUrNZZDfb93TQYKJgJnM1S64pDWl/FyvclAUFAaBn?=
 =?us-ascii?Q?IypDPwMS4gpr8br50YY0K2uVS1pzj6SLvlwFt179EaQYGhxeiiudtPAMmJhz?=
 =?us-ascii?Q?G+RqtLBI53ZjjfNbg6jVr8RiOEQ+4Z6jNlcok/lO8165s3+orI6tEFpq6O/A?=
 =?us-ascii?Q?mRabBX3rvjGkSSnF2VLMztSEpVnx7ILFGklHgK7/VdGiDhveF4anjKHFj8+q?=
 =?us-ascii?Q?XexNARIotCd9jcYmF0zBr3WXrRoMqEq/HYbr2BeMQpMpkSt8PbbVagXIJAPu?=
 =?us-ascii?Q?zhGOOL56NLWZIy8A1NzYUR4Nm4UmEB582S1g8YxIMglEHiYq0nmRpqEPEdDD?=
 =?us-ascii?Q?zhwt7AaDeLEOzAi93kjCTx7MfzFALGI9BoFe7gRJQRtJ9ULn4KzwH69G1jDK?=
 =?us-ascii?Q?5h5bdDcPGJtOFSA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:39:06.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e16a7c-c662-4a1b-225a-08dd4b83c47e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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

Added tests to PCI and vdev bus that compare and find devices
in various forms of names under test_devargs.
The tests check the functionality of the rte_cmp_dev_name function by
calling it with different variations of names, like short and full,
full and full, etc.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test/test_devargs.c | 120 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 575a49ea82..e510f0491e 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -12,7 +12,9 @@
 #include <rte_kvargs.h>
 #include <bus_driver.h>
 #include <rte_class.h>
+#include <rte_bus_vdev.h>
 
+#include "virtual_pmd.h"
 #include "test.h"
 
 /* Check layer arguments. */
@@ -302,6 +304,118 @@ test_invalid_devargs_parsing(void)
 	return fail;
 }
 
+static struct rte_device *
+create_pci_dev(const char *name)
+{
+	int port_id;
+	struct rte_ether_addr rand_ea = {0};
+	rte_eth_random_addr(rand_ea.addr_bytes);
+
+	char pmd_name[RTE_ETH_NAME_MAX_LEN];
+	strlcpy(pmd_name, name, RTE_ETH_NAME_MAX_LEN);
+
+	port_id = virtual_ethdev_create(pmd_name,
+			&rand_ea, rte_socket_id(), 1);
+
+	if (port_id < 0)
+		return NULL;
+
+	return (&rte_eth_devices[port_id])->device;
+}
+
+static int
+test_pci(struct rte_bus *pci_bus, const char *dev_name, const char *name2)
+{
+	struct rte_device *pci_dev = create_pci_dev(dev_name);
+
+	if (pci_dev == NULL)
+		return -1;
+
+	pci_dev->bus = pci_bus;
+
+	if (rte_cmp_dev_name(pci_dev, name2) != 0) {
+		printf("rte_cmp_dev_name(%s, %s) device name (%s) not expected (%s)\n",
+			       pci_dev->name, name2, pci_dev->name, name2);
+		return -1;
+	}
+	return 0;
+}
+
+static int
+test_vdev(struct rte_bus *vdev_bus, const char *dev_name, const char *name2)
+{
+	/* create vdev */
+	if (rte_vdev_init(dev_name, "") < 0) {
+		printf("Failed to create vdev %s\n", dev_name);
+		return -1;
+	}
+
+	struct rte_device *vdev_dev = vdev_bus->find_device(NULL, rte_cmp_dev_name, dev_name);
+	if (vdev_dev == NULL) {
+		printf("Cannot find %s vdev\n", dev_name);
+		rte_vdev_uninit(dev_name);
+		return -1;
+	}
+	int ret = rte_cmp_dev_name(vdev_dev, name2);
+	if (ret != 0) {
+		printf("rte_cmp_dev_name(%s, %s) device name (%s) not expected (%s)\n",
+			       vdev_dev->name, name2, vdev_dev->name, name2);
+		return -1;
+	}
+
+	if (vdev_dev != vdev_bus->find_device(NULL, rte_cmp_dev_name, name2)) {
+		printf("rte_cmp_dev_name(%s, %s) device name (%s) not expected (%s)\n",
+			       vdev_dev->name, name2, vdev_dev->name, name2);
+		return -1;
+	}
+
+	rte_vdev_uninit(dev_name);
+	return 0;
+}
+
+static int
+test_valid_cmp_dev_name(void)
+{
+	struct rte_bus *pci_bus = rte_bus_find_by_name("pci");
+	struct rte_bus *vdev_bus = rte_bus_find_by_name("vdev");
+
+	if (pci_bus) {
+		if ((test_pci(pci_bus, "0000:08:11.0", "08:11.0") != 0) ||
+			(test_pci(pci_bus, "08:12.0",  "0000:08:12.0") != 0) ||
+			(test_pci(pci_bus, "08:13.0",  "08:13.0") != 0) ||
+			(test_pci(pci_bus, "0000:08:14.0",  "0000:08:14.0") != 0))
+			return -1;
+	}
+
+	if (vdev_bus) {
+		if (test_vdev(vdev_bus, "net_null_test0", "net_null_test0") != 0)
+			return -1;
+	}
+	return 0;
+}
+
+static int
+test_invalid_cmp_dev_name(void)
+{
+	struct rte_bus *pci_bus = rte_bus_find_by_name("pci");
+	struct rte_bus *vdev_bus = rte_bus_find_by_name("vdev");
+
+	if (pci_bus) {
+		if ((test_pci(pci_bus, "0000:08:15.0", "08:00.0") == 0) ||
+			(test_pci(pci_bus, "08:16.0",  "0000:08:15.0") == 0) ||
+			(test_pci(pci_bus, "08:17.0",  "08:13.0") == 0) ||
+			(test_pci(pci_bus, "0000:08:18.0",  "0000:08:14.0") == 0))
+			return -1;
+	}
+
+	if (vdev_bus) {
+		if ((test_vdev(vdev_bus, "net_null_test0", "net_null_test") == 0) ||
+			(test_vdev(vdev_bus, "net_null_test1", "net_null_test2") == 0))
+			return -1;
+	}
+	return 0;
+}
+
 static int
 test_devargs(void)
 {
@@ -317,6 +431,12 @@ test_devargs(void)
 	printf("== test devargs parsing invalid case ==\n");
 	if (test_invalid_devargs_parsing() < 0)
 		return -1;
+	printf("== test find device valid case ==\n");
+	if (test_valid_cmp_dev_name() < 0)
+		return -1;
+	printf("== test find device invalid case ==\n");
+	if (test_invalid_cmp_dev_name() < 0)
+		return -1;
 	return 0;
 }
 
-- 
2.34.1

