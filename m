Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C15C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 10:55:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05A3440DD6;
	Thu,  6 Feb 2025 11:55:09 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by mails.dpdk.org (Postfix) with ESMTP id 5A2BC40B9D
 for <dev@dpdk.org>; Thu,  6 Feb 2025 11:55:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2zeWfeccgIguyOCSs1D16tYVMnhfsOb3zAKZ6fM+tF1xdmBByNQWmtnpCYIt+qx9Abt4mEixdweQcMqBFFvqjWmO8BELGG5m04YQ5GR3vNwNBVxUYsZRKttEDYhpit07UZvEDWp16oGJTeTpPnXVTyeHY9DOWcST7JdYf1kdHFNftGgZ23X6QyiNPRKR66Tsoow5x5GLbaSH16j3yZCC8oqcdNpLSiowioUgI45OqZ62ezWMSD32waQNh6SS6pNOLXKRAj5mw6vg/atwxuAnOwosFpxF+D69JbU+jurc1uiSmYSNT/At6r9OrqelsCYQh+1yC6nLag6UGPMHsK1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHoO2/zEASsttOnwN1exQbB2Rb/uPBW/ITIMhn0EcTw=;
 b=Lwts1+m5ssEiNcUlphAWiZhxnfKypS7gUAu/bX5Z6xcrucLEP1PWXy5+OdmJh1PtAdgqCHc7BoB9XMc8lDa8w+zhf3Ve7kXYIPx6w1inVTOqlw6kCnHGJ1LIVGWFwf2yOK9zeExF0FmYGui8Yv2S313M0O6czj/J4SUlA5Uc8Mz0J5LMeqeskwSjQ1jQg/8L2g2PSiApMpyda2tU41k21bpvsdTuubtjx7bG8zh4AR5EORtiqo6sLnBkwVde+ZHeu0MkRjndeTQQj+qWEkgjLZSsb9wMfYE4v7we0qBE7DjqBO9Pp8WTlSY0xEleHkeUGCjvdVaY9go1Ai+6DOP9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHoO2/zEASsttOnwN1exQbB2Rb/uPBW/ITIMhn0EcTw=;
 b=ri58JVs13nBQSyH70wSJ6dohMTYEG7Ppdq3tOfaVN9TsjV/DCsFDMOo8iyh94XKTnhBDtnIqxE9KMSvGm3vzv/PQMhvJeYxOCgTEzwG23zUbJf5sgZMU8iiLziDZk2OzJtT8T5fAT6SOG3jjqkaB7X20J2+BHuv3lRGuivp3J2nJ+1NvBvmWBiwjtiBYbthVZI5zaGtlNWS8EX59SwMHHeHObt3jb7WG0xBK/xqblo2kXXo6Azv0jaylK4HEN0TK+3/amtZFmPur9dNzJPBIuO92Gm/5Wh+0cg6RgMSYF9tBmfbyeYXle1T/EahPBMOtcEBUl22jaMKtZgOBMJMSeg==
Received: from SJ0PR05CA0188.namprd05.prod.outlook.com (2603:10b6:a03:330::13)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 10:55:02 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::62) by SJ0PR05CA0188.outlook.office365.com
 (2603:10b6:a03:330::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Thu,
 6 Feb 2025 10:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 10:55:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Feb 2025
 02:54:43 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Feb
 2025 02:54:43 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Feb 2025 02:54:42 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>
Subject: [PATCH v6 3/4] app/test: add tests to find devices
Date: Thu, 6 Feb 2025 12:54:26 +0200
Message-ID: <20250206105428.237346-3-shperetz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 8320f208-8db3-4f81-44ec-08dd469cb4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4d1vKq5CXlQwFL7U1jqj0XSCvChj9UWEHQKe4WEwQIbq16PClBzMekXx0CFZ?=
 =?us-ascii?Q?daSwYsEE+rmbRmL9IhOp46OdfHkc1MXBacRcR7RkNBKavBmL2wfhhNkejE4q?=
 =?us-ascii?Q?F8K9NFcO6TnJ56SG9GdcSJn+7CUtroIwFKOM1eRJEfTcLFsr9ZiM/FgbGy1t?=
 =?us-ascii?Q?NMoLSBCroy9hdQWUKjzbzPF6vxsLF8YO3vP9zVo5Y024F9s4SE+x9f1k1wB+?=
 =?us-ascii?Q?YoZV3yPT6w2IQZnQF01kx2ZUs/kSrMDS6zKTan1Jt4gOA0+ATP7f31xtxwQj?=
 =?us-ascii?Q?ufY0nNU68xxCrY2u5lKzovCM1r63eXOl9LD6hfj3vcmv6NgLjR9g3vGzQJpe?=
 =?us-ascii?Q?AwSklslNb6nhMjoPb9nbF5U+2SAmV8p43+tdX+3j5rkYppzugFXWERng4V88?=
 =?us-ascii?Q?gLz5W+sdrEiCgrUrdBo9KrQHng2nKDcP72Sw9Ad+4FvJtKWJ4fbcgJZx/Wga?=
 =?us-ascii?Q?xvZFq4yIFfo/KSoqod70FaEwA8rIcdcAQnm6m5TFEAy9+/Mi+SScbDyoYAVv?=
 =?us-ascii?Q?b04e5RkyyC9Y/AGzOvK0wA7Raqs9C0aEE24mdD/qBI9CllCrOOjxsjhaz63n?=
 =?us-ascii?Q?nFk7QFs71oSj5dFUETThiRNbhllUvk0YIUIW8fTIGW5ZVJJ0FnmVFIJir4zb?=
 =?us-ascii?Q?4q+xVs2XDzkNeaS0fDizDj7C3neLMVg/6C8wNdO5JbADM3t+E8/lv/ON2QY2?=
 =?us-ascii?Q?eAH5wuXnijb15mgbt6/RwG/y4QoXx9VbZpLAxPDFOu5RvKWMyt2zi5EbYtFD?=
 =?us-ascii?Q?8f4reYkv1rFQVYfensl4jE6JOjR2nGxjXVyCA93Ic8/5JeTbePIyxKmQ+I7L?=
 =?us-ascii?Q?vBAbAL3MKv7Ptc3sXVIc5ES4jvhnq/Pbg2LXmb8xBXzznQGsJg+qF/kqF7BN?=
 =?us-ascii?Q?BqhdGhssE9GewrRn+mmjap1Ykpy2w17IxBPqyEE8m0CBvii30s86orBOWN1+?=
 =?us-ascii?Q?ObXdafX6e50jzyUKJzpYWc7DmFQ85Hm+hfD1uZvl5jJCEJWAu7H6mzqcbd6G?=
 =?us-ascii?Q?tpEUF4JyWinaojpVAZhfzjCKDNvFJsUen+isKGfgj64Oc6MUIefeO02NJg3W?=
 =?us-ascii?Q?fdwCEBNEXQw4O6YDpDNzsaLBCcsbjwOkVY05CoZzD1zeBpf9jQeIFae/rERs?=
 =?us-ascii?Q?WR9ScWG3wc+OJEv7IL9o8Zyu47EpChQSAfAX365z1oSptdgXfMBVhGwi5/Co?=
 =?us-ascii?Q?GmmE/mM0c89LZZhZXtO3APZp8NNGYuH7gf7R6V5XBYcm0L9cE1setf8fE1YH?=
 =?us-ascii?Q?/aT3uQcmeoEVSGR3yjWUA6i1EUVju8QJYb9CFTPY/sYnc5iOgyK1WbEdHvNp?=
 =?us-ascii?Q?+L9it67TlfY01WkRPpadlnAxGwVyoFoCKRzvF9iFIOFavGbrLQ6iyS5XKByl?=
 =?us-ascii?Q?tx+TSNVsNLUNWKDySliqVXtMbqdAcarmhKnCjtWFsIDwvJpri2s9eVaksUH0?=
 =?us-ascii?Q?bW9agM9wozPsNDLiUkoVwxqXuL0RaDqaL6UZApcXXIGrcg8aszIqAktTM9wt?=
 =?us-ascii?Q?Cgjp1+mM8m2vY0o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:55:01.5063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8320f208-8db3-4f81-44ec-08dd469cb4a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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
 app/test/test_devargs.c | 122 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 4166b2bea2..fab88b00ee 100644
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
@@ -171,7 +173,7 @@ test_valid_devargs(void)
 	int ret;
 
 	ret = test_valid_devargs_cases(list, RTE_DIM(list));
-	if (vdev_bus != NULL && vdev_bus->parse("net_ring0", NULL) == 0)
+	if (vdev_bus != NULL && vdev_bus->parse("net_ring0", NULL, NULL) == 0)
 		/* Ring vdev driver enabled. */
 		ret |= test_valid_devargs_cases(legacy_ring_list,
 						RTE_DIM(legacy_ring_list));
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

