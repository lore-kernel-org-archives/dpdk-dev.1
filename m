Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437AC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 00:09:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86A9A40669;
	Thu,  6 Feb 2025 01:09:28 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by mails.dpdk.org (Postfix) with ESMTP id 7860940678
 for <dev@dpdk.org>; Thu,  6 Feb 2025 01:09:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8KvyCz9s8MMSHx5Y4JswWDuOI5M8kU2Jsa626GbY1IDY0Bmh62zXi1iFoRaEojqX7nyrJU2yGVK7vdM74cIZ4bzdrUz//2Wrmw7GjGkv3Nn/LBP8v87QK2FACcFCIwRLY23WG02OrmaXHnxtcKUUrVAm9EGg9XOreigiMRbnoBuHnkiza1EZ/0hZtulUCUBpuNjTSGFEekkMMD6VLwdMLPMCzMhZPZszCB4x8HCd6Oq5doiBh9NikCd7Nw0il3/bQbNwRysr1mqA7XitT+jvPhTKTodVqWVT5eYv4fNko3g/6NJk1zQ+zecCkOWAiCVVlNoM8fjc3lhe/DuW1d6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnr6w/WI8Iruz44ERFqNVuaNncS5OElvkrq3TGcRuZw=;
 b=ocaXl1Gh8xOOhviWvBRViBe+H4pMrNE1kiEmnPXd6bp0TvE/gNfIUXGeIJ5jVkGqgUGr/9R4B6kYaMzQLOdAZ1lPiXVRF2Vkh3y7EfHI1IXyk5iRR7moAGjEwIbonpMOLeJvknfK5EExNzOJSe0ZhJmT5mNhdCce+Xj2+enxNz0U1GkDdmaGAtw0WYo+QgDenGx1MnxE/M4RitHbFDvdEFhV4rZaOi9LEOHj3m4gzHTIYDwa6gcXQhkDCborOv4MpS0nG11iHicicz+g1IQ8s5KjN3NgJE3aMSSwIsAIRDZ/s92j67KUcjcK1HzWLgYQ50lgHVYj5EynP1qC3PcO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnr6w/WI8Iruz44ERFqNVuaNncS5OElvkrq3TGcRuZw=;
 b=gg1G1hbeywFJ9RqRalxjKd1DA7HAD0l2bMr/0UMe5PHTVrlQDKbnxsTg83DulFvpSNOAz8que6x+bdfoiAwvjwvA/2KQ2oGk8b2DgS8lsxJmAeRwsL65YLXQr9kaYGwZtH0qzv2HWU38lOQjeGXdgH7k3UAgckzffDb0usV9UctyIKr86zXmRqlXIUwVJzQB4buKaIEO4VeRbkd3Gl0ga6qAqx772S1Ra1ed1gfDElvg7r5AEtKUwfSUYKTGGSHQGwbhi81OAb2QprWAgK0hz9VCH2bYhWNbKiU/pcuvi3N6IpcZKSqbpOSZHbX7mRCAtrY+WQ8dPJ8J3wcikPngVg==
Received: from SN6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:805:66::42)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 00:09:22 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::4f) by SN6PR08CA0029.outlook.office365.com
 (2603:10b6:805:66::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Thu,
 6 Feb 2025 00:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 00:09:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 16:09:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 16:09:03 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Feb 2025 16:09:01 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>
Subject: [PATCH v5 3/4] app/test: add tests to find devices
Date: Thu, 6 Feb 2025 02:08:37 +0200
Message-ID: <20250206000838.23428-4-shperetz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 3075dc3c-9a85-4b51-cf55-08dd4642822e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IDh4bBHNZxk+W7ZFD1T44uSdg017Rt0NjF/mWFo4LT349CwjMMDi8yKKT2xo?=
 =?us-ascii?Q?q75nG6qgi4axL4qL+YKqFyrxF6n8pRNW20mKflq4dvg2P8LcQgCdWFcqOWIE?=
 =?us-ascii?Q?7K+s8S9hGnOgwCuRWHRPoBLe8NJLIEOVafoDLVIgD93pVuzqI1XLNkK8R4tf?=
 =?us-ascii?Q?Fnm2I51DR3UtFiPyCW+XSKcMJ1UQIBEvDpcWWSAntgMMrdaJ5Xs0WESEIryP?=
 =?us-ascii?Q?4KoY4wNMwsaEYVpAx0A/QDz2qoh6ydICCjYca0evUDoR7YSRUu+4SwhJ6yUe?=
 =?us-ascii?Q?ISmf41uFgowCH+yq+JOTkOjlR/+98MBH9qXaODAW9usnUXzyoQeiGAbY+4bh?=
 =?us-ascii?Q?AgkDBtgpBqGRV2KGQecSlt++BF8gaoQm3BLt/a1w8RktPq5bNO/Lk4XBR+qy?=
 =?us-ascii?Q?SEVoQwSZdsLaNV0OMinRzZrlERO3zAUfW3RsyhkQP+QA496BFuJOT9td3It9?=
 =?us-ascii?Q?tDUIqpG3vD3T/1MsIGoxL0pTNKaQaA1TuNl44XLe8BR+1dzuFAjZ5/jJtgOG?=
 =?us-ascii?Q?+EUN1GAZVsVMjPlBseGpEbJ03qzRuOO53niKutkesLqT40XcjiudMd0Zljck?=
 =?us-ascii?Q?+zacP9KA7nPYe25zs4w/8wzieb2OfdCUaFM5L0SAT13A5YD3dWs2oldFGCaw?=
 =?us-ascii?Q?atBxU+vXFnLPd/IbnyDBl6LqsOFE6MDZRijBU0L/bAOqAb99Vp/8qM0Vskyn?=
 =?us-ascii?Q?Arn1xJcSadolDa4qaBW5FgTWqTO1WdB1Z5UQTv7mO4oAj1OWrTBYcVVdbA3I?=
 =?us-ascii?Q?6Ik76z+YQjq1JPO9Shioz/6JUfXByJ0o9EF0mkVSP6ZKrSU0gMh3yRx6kelK?=
 =?us-ascii?Q?/sQGWfgArNHiuMIC4UjhNuhl9sG8zi9cC+qCwxV54S8XH1wBIBvKl59Jvgtq?=
 =?us-ascii?Q?Y7QdYkGYNaSXYOKdbq+ImTiQZR0DTOqYTBxYwQr/Zmtd1mG+tvNRyN1lqm0b?=
 =?us-ascii?Q?MTkeYHF6pyXPWiseU0kfb7npjDzNmcFwfvRRNQFAkWS9JcpzWhMP0Gdft9C8?=
 =?us-ascii?Q?9/cQSpvdnS+2MPoVyWMzE5HlheWJjUFnZgx6VF6a12+hsc3siAZcyM+dbTzs?=
 =?us-ascii?Q?X9J10hDM3QgxzUVHAMxKwEYJI+ScMku9dwRoYca0z86BotmK4IvocZH3M5aI?=
 =?us-ascii?Q?zMgmUA6XRDIOZ2MoIyymNtTpxiF1+oK/RAmrgVZSGrdQ2NA2vnPuDY7G4NlI?=
 =?us-ascii?Q?PalX76XD78gCFWSmrjMlJgmcA5d+xNqQPmwo77QH5eD+zykb7h3OzOd0SZQm?=
 =?us-ascii?Q?6uGAEHH4X7zp+4iM2xKKXGIxje4zWRuZ9xyLMIsXW4tHvpi09T1nezX0auF+?=
 =?us-ascii?Q?FfhQqgi8diaNgzCHfNhMpY5kFINEbhT6KWjNZ9BzCMSnXo4jQp8VoIoy2jXC?=
 =?us-ascii?Q?BAqEmCqGm2y+9HzPMiVPtvvco+Zs5mxyLpyEE82nz6Q1fKLV8z/uKMqlXO37?=
 =?us-ascii?Q?+lSISjloedLmmb+3NzJmYwDrZ3yJsx/35Gw4wMWHkOz8eObkFa6j5sMBq8JB?=
 =?us-ascii?Q?22hK1jsrt651f7o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 00:09:22.1276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3075dc3c-9a85-4b51-cf55-08dd4642822e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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
 app/test/test_devargs.c | 125 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 4166b2bea2..2d973a643a 100644
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
@@ -302,6 +304,121 @@ test_invalid_devargs_parsing(void)
 	return fail;
 }
 
+static struct rte_device *
+create_pci_dev(const char *name)
+{
+	int port_id;
+	struct rte_ether_addr mac_addr = {
+		.addr_bytes = {
+				0x00, 0xFF, 0x00, 0xFF, 0x00, 0x00
+			}
+		};
+
+	char pmd_name[RTE_ETH_NAME_MAX_LEN];
+	strlcpy(pmd_name, name, RTE_ETH_NAME_MAX_LEN);
+
+	port_id = virtual_ethdev_create(pmd_name,
+			&mac_addr, rte_socket_id(), 1);
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
@@ -317,6 +434,12 @@ test_devargs(void)
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

