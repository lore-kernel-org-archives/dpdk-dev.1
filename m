Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63FBC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 00:09:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45AFB4066F;
	Thu,  6 Feb 2025 01:09:23 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by mails.dpdk.org (Postfix) with ESMTP id 901524066A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 01:09:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLKpqdjhoOgTwHwE8XSTdX3aYFTl4JFB0Wy4zIFGcRUn+j9kAV4TN/jfWU4I2Nqld3Gj2xZYk9bLbDuufJRpJL0grNYxw5DcdF1brMzWGf1EXeVslzeTk37+btwYysi8gIbeawtMuOOEuf6QpRzA9Il19CLpYnBi+pVzV4pqfJ4bMReMgUjHkyHBQG6Daa3P2XcvFOQ+Q0Gnfeya7CT63oQjLw1mvK9f1gEF31e9FyaNZyCu6mrDU828kv2mjK4UOai8/F7OQLY3iCfa27SvU99478CPQsydtwIVoFp124kACnVXCW/1kd713oEpZBnbPfoUi8WccKEbTnThX2Rb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvtmcNI6GN1rfIxTReITFnXowJAv0KuafVvlWE71Lmw=;
 b=F71rpDjCdVltqVkEtl1ZCRfOG/s2UzcL9gwLoQ0fQn3HlPzGXpajo5H6DL0v7LCu1VGbOaD3oo8FcsCVGUrlEnHX1pNCzxFsISMtV2a/5E8SSTH0y5PsH0op2xCSnCRnZR+EDiwGB9V3/zQ+y/OsM+zDUdabwJmM9dw5lfKIJjlg4R9MR07kl6GdM4ERsRScu/8yrRHnErNrhMiLTuHbaaRd5kBJlDySqpep3qSkkVpBffnQCjAqwYPpuBlOVm4aWY/wPg69a8450PtjU3VseHWXB/rcr6RbggJTGFD5f3+yXiIB/fxFIp7lU7N7Uiltl5QeIIHNfK0+nBYc3fGMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvtmcNI6GN1rfIxTReITFnXowJAv0KuafVvlWE71Lmw=;
 b=IEXYS7g/nw2xgSh+mRAQM/8lGeceaselUoj3IbWKIU6g73ABzDA6J+ZodCXY7VZUXTzs4vdfuY3v6EGp16ZVSdWrQTs5Op6VzHMcgOZZuqqZ/G64E/a+3znd15ZepzeINbRpaMMDPXmOs/Z017SyD938A1DHwa7iw3QeBWIYTJkrEN1iMyJkS5c67LoarEWfJxOa9xqmpNNDkR7iCD3SE53Xz4hXje4JOWyioFQLbKJw2nY8LBMlwqHnnH4b04ceiV3g/AqAUk+j/PUu7xTp26o9Z03Ur367jVNAkTdn/gQWdf7PrsFr7cRFt2ree4AwPZJ15mjFuMIRMA6f6XJS6w==
Received: from SA9P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::19)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 00:09:15 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::b0) by SA9P223CA0014.outlook.office365.com
 (2603:10b6:806:26::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Thu,
 6 Feb 2025 00:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 00:09:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 16:08:58 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 16:08:57 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Feb 2025 16:08:53 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Kevin Laatz <kevin.laatz@intel.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>, Jan Blunck <jblunck@infradead.org>
Subject: [PATCH v5 2/4] lib: fix comparison between devices
Date: Thu, 6 Feb 2025 02:08:36 +0200
Message-ID: <20250206000838.23428-3-shperetz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 315bc574-eb87-4d68-0840-08dd46427e09
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eeRljlfDdmK+ThFWcRtILDw+qeWItOpaPt8HrrI1LbAL4scMhRyPKtJne+di?=
 =?us-ascii?Q?m+zXzPVdUNPXxFopiaL532JlvVX7TPhwgdy2lynQQiIA/VvfgS4J8GbjkkzC?=
 =?us-ascii?Q?JiyHBeE/YghqBfslT/Lm2MQGoO8GlgAAIfWfBd1zyJFm2Aa3hoFY5FIojath?=
 =?us-ascii?Q?uD2zpqkLzLWusH51DlkcoPyGaTiTn1It1mDEp+MTuVzkQZm7iMgOSMug3/qj?=
 =?us-ascii?Q?MBuqV16X26EfraxJd+G0GAoa13Z/gHTX5evAfiWQ1moNjm1QcCor67D6b3Qu?=
 =?us-ascii?Q?GPmIFDIiMgrniKieV2xaqY++0HC4o57bYMFoX5XOUvPmfHNyuDtvQI+okDrv?=
 =?us-ascii?Q?S3uu0bHjVYchjCNx0lGjjKKVfTbfq16YD32i7L2xtcF/51ljHfwQ4Et6vS1x?=
 =?us-ascii?Q?U/kaBelgebznJNcpO+pXO8cc7DmD2w+fzT+KhBEEJviZ0ugxJrt1iYbfGRE7?=
 =?us-ascii?Q?nRWZOKHhlJyTYDeIHxk7vsR49fmChYI5K5yyevBgWmbZl6iu4TokBkuaWiGQ?=
 =?us-ascii?Q?nhplsL9ZOvsGq3IvSlt6/GyKqidSsVhzxqqyvWy/bb+lmrHYIQYyWGPnjmLv?=
 =?us-ascii?Q?gsBwsjwjQ9ucutmHAD1zSW8wPx7XSjp053WU5uagEzin72oArvwtOP942CnL?=
 =?us-ascii?Q?yDzI9jTImw/7WCihCmVrYTpGFMdWkbwQ7IOoMkB4Tem0KAt0plTAgd2bKomF?=
 =?us-ascii?Q?cWFLnhcBc/PLuF610Z5KHoFWKZD/kQItpOY/8yw7y/R6rki+o02SxUnX+MyN?=
 =?us-ascii?Q?+lnBP279qvGkf27mEDfP+etU5ag0LJ4hhq35oX8O0DAyrxP2rEtV16yeNwTl?=
 =?us-ascii?Q?sY6XTumotqotj4T9CxJNN91ypsRDbJsZdA6+SvWhKzKhq22oRYFd+LiP2gZ3?=
 =?us-ascii?Q?D0FaU/HpPnx/mgnaieWhgzywNxq6YHZ71zGzdy5ZnkcXYv0nKBou/SfsibM4?=
 =?us-ascii?Q?2dnfJJWaGE+XvEsld7XfV8JwXZhn4gTY8/LTyWpHU2QCZuiX9hX1j7wXZANq?=
 =?us-ascii?Q?JsQm0z0PyKaKGwlxEm6kURCLQQgh89xmadzkbOU/mNSF3/taVuBVcDsRS+i9?=
 =?us-ascii?Q?uhEsSbLXwz++XA3piNIReaEJ1Y/4at29lyPV7KwOkJEDKzKtZZlWgN473cDb?=
 =?us-ascii?Q?GEKw59rG9C0/oGVqYWX3fN56vRHvjHfV7yYJDSmxnlCwYBClqeJtu/oJ8QCJ?=
 =?us-ascii?Q?F2keTCThkybdH4keVSZMfBtRjEoMrSxSkARQJafGu3n7/pE+gGPJFbblwnm1?=
 =?us-ascii?Q?O4xbolaQZB9pfr5/zwLreRAZKQLD3td5aFz4Z+m5v/dGltnp+SoDkpxvj5CK?=
 =?us-ascii?Q?GK0DSy0jGZHcqI7s2hktm7e4W2Xaex60w4Co15X1NYGpiVsyskdHf6opZ+rQ?=
 =?us-ascii?Q?wKB5ObNqeOpK5sOjVLP093e6dJ/Fgy7Uo2tIxoYcw0axckzQRDl3M0VY9DSd?=
 =?us-ascii?Q?fNzYJVQFb5Fwn0GvcFsNuFVxJNH73dlNcSc3PihCTWm6Emosjciiy/ERuON3?=
 =?us-ascii?Q?9+iw5qFcuTXEcXs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 00:09:15.1379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315bc574-eb87-4d68-0840-08dd46427e09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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
As part of the change the parse function will now return the size of the
parsed address.

This will allow consistent comparisons between different representations
of same devices.

In addition, fixed vdev test to use the rte_cmp_dev_name function
instead of the custom one.

Fixes: a3ee360f4440 ("eal: add hotplug add/remove device")

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test/test_vdev.c                     | 10 ++----
 drivers/bus/auxiliary/auxiliary_common.c | 17 +++++++---
 drivers/bus/cdx/cdx.c                    | 13 +++++---
 drivers/bus/dpaa/dpaa_bus.c              |  7 ++--
 drivers/bus/fslmc/fslmc_bus.c            |  9 ++++--
 drivers/bus/ifpga/ifpga_bus.c            | 14 +++++---
 drivers/bus/pci/pci_common.c             |  7 ++--
 drivers/bus/platform/platform.c          | 15 ++++++---
 drivers/bus/uacce/uacce.c                | 14 +++++---
 drivers/bus/vdev/vdev.c                  | 23 +++++++++++--
 drivers/bus/vmbus/vmbus_common.c         |  9 ++++--
 drivers/dma/idxd/idxd_bus.c              |  9 ++++--
 drivers/raw/ifpga/ifpga_rawdev.c         |  8 +----
 lib/eal/common/eal_common_bus.c          |  2 +-
 lib/eal/common/eal_common_dev.c          | 41 +++++++++++++++++++++---
 lib/eal/common/hotplug_mp.c              | 11 ++-----
 lib/eal/include/bus_driver.h             | 24 +++++++++++++-
 lib/eal/include/rte_dev.h                | 15 +++++++++
 lib/eal/linux/eal_dev.c                  | 10 +-----
 lib/eal/version.map                      |  1 +
 20 files changed, 180 insertions(+), 79 deletions(-)

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
index e6cbc4d356..ba2f69e851 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -237,10 +237,9 @@ auxiliary_probe(void)
 }
 
 static int
-auxiliary_parse(const char *name, void *addr)
+auxiliary_parse(const char *name, void *addr, int *size)
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
+	if (size != NULL)
+		*size = strlen(name) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, name, strlen(name) + 1);
+
+	return 0;
 }
 
 /* Register a driver */
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 62b108e082..b97f1ce1af 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -464,15 +464,20 @@ cdx_probe(void)
 }
 
 static int
-cdx_parse(const char *name, void *addr)
+cdx_parse(const char *name, void *addr, int *size)
 {
-	const char **out = addr;
 	int ret;
 
 	ret = strncmp(name, CDX_DEV_PREFIX, strlen(CDX_DEV_PREFIX));
 
-	if (ret == 0 && addr)
-		*out = name;
+	if (ret != 0)
+		return ret;
+
+	if (size != NULL)
+		*size = strlen(name) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, name, strlen(name) + 1);
 
 	return ret;
 }
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 9ffbe07c93..f768fb9454 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -153,7 +153,7 @@ dpaa_devargs_lookup(struct rte_dpaa_device *dev)
 	char dev_name[32];
 
 	RTE_EAL_DEVARGS_FOREACH("dpaa_bus", devargs) {
-		devargs->bus->parse(devargs->name, &dev_name);
+		devargs->bus->parse(devargs->name, &dev_name, NULL);
 		if (strcmp(dev_name, dev->device.name) == 0) {
 			DPAA_BUS_INFO("**Devargs matched %s", dev_name);
 			return devargs;
@@ -447,7 +447,7 @@ dpaa_portal_finish(void *arg)
 }
 
 static int
-rte_dpaa_bus_parse(const char *name, void *out)
+rte_dpaa_bus_parse(const char *name, void *out, int *size)
 {
 	unsigned int i, j;
 	size_t delta, dev_delta;
@@ -494,6 +494,9 @@ rte_dpaa_bus_parse(const char *name, void *out)
 		max_name_len = sizeof("fm.-mac..") - 1;
 	}
 
+	if (size != NULL)
+		*size = max_name_len + 1;
+
 	if (out != NULL) {
 		char *out_name = out;
 
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 68ad2b801e..a525b5e245 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -103,7 +103,7 @@ fslmc_devargs_lookup(struct rte_dpaa2_device *dev)
 	char dev_name[32];
 
 	RTE_EAL_DEVARGS_FOREACH("fslmc", devargs) {
-		devargs->bus->parse(devargs->name, &dev_name);
+		devargs->bus->parse(devargs->name, &dev_name, NULL);
 		if (strcmp(dev_name, dev->device.name) == 0) {
 			DPAA2_BUS_INFO("**Devargs matched %s", dev_name);
 			return devargs;
@@ -235,7 +235,7 @@ scan_one_fslmc_device(char *dev_name)
 }
 
 static int
-rte_fslmc_parse(const char *name, void *addr)
+rte_fslmc_parse(const char *name, void *addr, int *size)
 {
 	uint16_t dev_id;
 	char *t_ptr;
@@ -298,7 +298,10 @@ rte_fslmc_parse(const char *name, void *addr)
 		goto err_out;
 	}
 
-	if (addr)
+	if (size != NULL)
+		*size = strlen(sep) + 1;
+
+	if (addr != NULL)
 		strcpy(addr, sep);
 
 	ret = 0;
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 11b31eee4f..d5d9a86a97 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -459,9 +459,8 @@ ifpga_find_device(const struct rte_device *start,
 	return NULL;
 }
 static int
-ifpga_parse(const char *name, void *addr)
+ifpga_parse(const char *name, void *addr, int *size)
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
+		if (size != NULL)
+			*size = sizeof(port);
+
+		if (addr != NULL)
+			*(int *)addr = port;
+		}
+
 
 	if ((port < IFPGA_BUS_DEV_PORT_MAX) &&
 		rawdev)
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 70faae4e44..82632bc473 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -84,7 +84,7 @@ pci_devargs_lookup(const struct rte_pci_addr *pci_addr)
 	struct rte_pci_addr addr;
 
 	RTE_EAL_DEVARGS_FOREACH("pci", devargs) {
-		devargs->bus->parse(devargs->name, &addr);
+		devargs->bus->parse(devargs->name, &addr, NULL);
 		if (!rte_pci_addr_cmp(pci_addr, &addr))
 			return devargs;
 	}
@@ -487,12 +487,15 @@ rte_pci_dump(FILE *f)
 }
 
 static int
-pci_parse(const char *name, void *addr)
+pci_parse(const char *name, void *addr, int *size)
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
index 11892caa24..87ed7404e1 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -542,11 +542,10 @@ platform_bus_unplug(struct rte_device *dev)
 }
 
 static int
-platform_bus_parse(const char *name, void *addr)
+platform_bus_parse(const char *name, void *addr, int *size)
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
+	if (size != NULL)
+		*size = strlen(name) + 1;
 
-	return pdrv != NULL ? 0 : -ENODEV;
+	if (addr != NULL)
+		rte_strscpy(addr, name, strlen(name) + 1);
+
+	return 0;
 }
 
 static int
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 9ca048122d..b18fbe1103 100644
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
+uacce_parse(const char *name, void *addr, int *size)
 {
-	const char **out = addr;
 	int ret;
 
 	ret = strncmp(name, UACCE_DEV_PREFIX, strlen(UACCE_DEV_PREFIX));
 
-	if (ret == 0 && addr)
-		*out = name;
+	if (ret != 0)
+		return ret;
+
+	if (size != NULL)
+		*size = strlen(name) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, name, strlen(name) + 1);
 
 	return ret;
 }
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index ec7abe7cda..0d3c8ca3c5 100644
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
+vdev_parse(const char *name, void *addr, int *size)
+{
+	struct rte_vdev_driver *driver;
+
+	if (vdev_find_driver(name, &driver))
+		return 1;
+
+	if (size != NULL)
+		*size = strlen(name) + 1;
+
+	if (addr != NULL)
+		rte_strscpy(addr, name, strlen(name) + 1);
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
index 8a965d10d9..18805aee0d 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -245,13 +245,16 @@ rte_vmbus_cleanup(void)
 }
 
 static int
-vmbus_parse(const char *name, void *addr)
+vmbus_parse(const char *name, void *addr, int *size)
 {
 	rte_uuid_t guid;
 	int ret;
 
+	if (size != NULL)
+		*size = sizeof(guid);
+
 	ret = rte_uuid_parse(name, guid);
-	if (ret == 0 && addr)
+	if (ret == 0 && addr != NULL)
 		memcpy(addr, &guid, sizeof(guid));
 
 	return ret;
@@ -269,7 +272,7 @@ vmbus_devargs_lookup(struct rte_vmbus_device *dev)
 	rte_uuid_t addr;
 
 	RTE_EAL_DEVARGS_FOREACH("vmbus", devargs) {
-		vmbus_parse(devargs->name, &addr);
+		vmbus_parse(devargs->name, &addr, NULL);
 
 		if (rte_uuid_compare(dev->device_id, addr) == 0)
 			return devargs;
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index ba8076715d..d68e8b630e 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -47,7 +47,7 @@ static int dsa_probe(void);
 static struct rte_device *dsa_find_device(const struct rte_device *start,
 		rte_dev_cmp_t cmp,  const void *data);
 static enum rte_iova_mode dsa_get_iommu_class(void);
-static int dsa_addr_parse(const char *name, void *addr);
+static int dsa_addr_parse(const char *name, void *addr, int *size);
 
 /** List of devices */
 TAILQ_HEAD(dsa_device_list, rte_dsa_device);
@@ -345,7 +345,7 @@ dsa_scan(void)
 			closedir(dev_dir);
 			return -ENOMEM;
 		}
-		if (dsa_addr_parse(wq->d_name, &dev->addr) < 0) {
+		if (dsa_addr_parse(wq->d_name, &dev->addr, NULL) < 0) {
 			IDXD_PMD_ERR("Error parsing WQ name: %s", wq->d_name);
 			free(dev);
 			continue;
@@ -391,11 +391,14 @@ dsa_get_iommu_class(void)
 }
 
 static int
-dsa_addr_parse(const char *name, void *addr)
+dsa_addr_parse(const char *name, void *addr, int *size)
 {
 	struct dsa_wq_addr *wq = addr;
 	unsigned int device_id, wq_id;
 
+	if (size != NULL)
+		*size = sizeof(struct dsa_wq_addr);
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
index 7cbd09c421..b1bb5df5b7 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -200,7 +200,7 @@ bus_can_parse(const struct rte_bus *bus, const void *_name)
 {
 	const char *name = _name;
 
-	return !(bus->parse && bus->parse(name, NULL) == 0);
+	return !(bus->parse && bus->parse(name, NULL, NULL) == 0);
 }
 
 struct rte_bus *
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 70aa04dcd9..c0e2202482 100644
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
+	if (dev1->bus->parse(dev1->name, NULL, &size1) != 0 ||
+		dev1->bus->parse(name2, NULL, &size2) != 0)
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
+	dev1->bus->parse(dev1->name, parsed_name1, NULL);
+	dev1->bus->parse(name2, parsed_name2, NULL);
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
index 60527b75b6..01447670de 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -112,11 +112,32 @@ typedef int (*rte_bus_unplug_t)(struct rte_device *dev);
  *	should be written. If NULL, nothing should be written, which
  *	is not an error.
  *
+ * @param[out] size
+ *	device information size. If NULL, nothing should
+ *	be written, which is not an error.
+ *
  * @return
  *	0 if parsing was successful.
  *	!0 for any error.
  */
-typedef int (*rte_bus_parse_t)(const char *name, void *addr);
+typedef int (*rte_bus_parse_t)(const char *name, void *addr, int *size);
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
@@ -258,6 +279,7 @@ struct rte_bus {
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

