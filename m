Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64234C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 08:38:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21C1F4066F;
	Tue,  8 Jul 2025 10:38:10 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by mails.dpdk.org (Postfix) with ESMTP id 8703540608
 for <dev@dpdk.org>; Tue,  8 Jul 2025 10:38:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEOC0Uq5xEksTGUIQMOQWVz4BEzlPESaObqKecFhKu/X+7KRmI7yp9JA4D845tOLUKUYHBw9IDWD1zH1NdIKFFYgOg3EixdU19jv/O/RepIre1NxrY4M3O8HX7gTrij1I8v323qBkmQA50cP7CrKeQEzCcUme3QmV2054PkoiV0rOt6dUpcY/WQ8vCyU8HlUtnHEBF2LZgQqIUgIhuY/0a8lEvVVsU4NCUeDSf2Pu08w+RdOyavyapEG+D4CnP5zncwrjHa0YfBubZzdXolC9aQLZETWXzbtfecJWgS8ZPRpik9PWIJHlXudphdkQNayAfbQ/RicnVuE+FaB0SFs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l08UvH6jtfzSZ8vMQX3iG56db4JVGYDIQPTzWSkCxqE=;
 b=jSo2Sax7y5ws0k3NPouhY6DYyJtkw4OvUhMlqVJQH8iRWkBLyQlSKh4zb5vNetaMmTvmil1DkBoVJihCLP/HEmxV3TJqF72ccJi/QNp+ozap5vcAdsw4e7tGvKS4B4f6ycNTMLdPhlUTGkIh6944kODxSoRChqpfcyGOvcMyfWJCHpL19N45FlqH693Ygekc+KWhDyNmagcGlq9gfPdjmbGUIhLucfSr6y2PpxOev9YOqHahdTefFKO+s54PQJJEcoiHgEssT+c9kylLEYQI0PSvJbkZF8dRXhnxCwyqW1HPrTHoTIWtIRzyeC4X4Sssy1wc6vhkyVGwy6msc2WCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l08UvH6jtfzSZ8vMQX3iG56db4JVGYDIQPTzWSkCxqE=;
 b=ek3lFb99CpsURVV9Gjz4WE+BON0wHk9GzkitzDUcU3RGUUtlgXaDYy301f8UwfX0utyAqPflbXn9/2ZZ6oeb79A6tIqOcWS7kLCokGz8Iix4rBYjIkUIMK7cspUCcBInirz2XJH16ySTnJRmm76O/7gl9KnQr/DJBlqMnPrKyF4n2DlNNLHHgdFHJhbrE95iZHOirDrjvsMyM44ay+7cIX5CDafthmmGvf4qzHQlsevYe6MKs16r33LYLu7Iv7KVlxaOazcwwLPGiWXlDRrDpVmVPvuQhiN4Qj61KxvMeldmaJ6UlHtEJZV3kRHoM5K3/wmpklwG1dA4xFzR/eOaog==
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 08:38:01 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:10e::4) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 08:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 08:38:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 01:37:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 01:37:48 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 01:37:47 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <thomas@monjalon.net>, Shani Peretz
 <shperetz@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v8 1/1] app/testpmd: canonicalize short PCI name format
Date: Tue, 8 Jul 2025 11:37:40 +0300
Message-ID: <20250708083740.128610-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708083740.128610-1-shperetz@nvidia.com>
References: <20250212163836.178976-2-shperetz@nvidia.com>
 <20250708083740.128610-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 23af3a2c-b23e-46a8-faed-08ddbdfabfa9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?peKgDkHU+Mt+IQfYx7zXIe/xYNoafNEWIhTMOcw3AhQA6LrkAwEjT1H1WfcA?=
 =?us-ascii?Q?q949edpich8eF56bIkuxhI6GSduARlBjS1qreGsxtqFYgivRXnXcC7q6TLjL?=
 =?us-ascii?Q?zclHWpipMGbpL2RZL9cASV8OmjPkTaVrN5r7XkK76amxmF2ytePFDrRRnQtg?=
 =?us-ascii?Q?Q3MnyoiBvxK2KFoOepqpCdxIfdOcjq+BNtM1eSv4MYTp8367Fs+3ECBM2rOG?=
 =?us-ascii?Q?J8KzwDh8Ws6mT3XpdTbnAnASaVpySf2CFyUrI3b0u1nrFfgd3pQA4wq0XWTo?=
 =?us-ascii?Q?l5b/mm9M1IybCtaLbivkejmZLYZSzjXHefP8D9euTdUcPNxIIPbT+Gf4kZP9?=
 =?us-ascii?Q?u/ti734Mp4s3E/QFxmvNgjdnc5MoA1UbELaI29+QqjZ1ZcMNoRcc84uxhq7k?=
 =?us-ascii?Q?5olQf15WJ4nXwzpUCOOtTAn7gc27yrsq//YG40tGMDZtL2VuYN9ZkLorH9HO?=
 =?us-ascii?Q?h/GWZlwYAnNWgQ766VGH1tCU0mD4Ylzn8R6NXvx0LgBH5zuZhl/NQuYfwjqf?=
 =?us-ascii?Q?1tEUO711NY42ig56jFtGZIxdVQeVcpiEr5xMGutmvFe4JXSKt0uerngbwKf8?=
 =?us-ascii?Q?iGzivK5hIGhlC15vJQeUydoxPaq+MkULJoxziRAGO39eEKI8qZfrwUz6/wqa?=
 =?us-ascii?Q?LIVqRPt9gPt4mSkCCFIQ6OoNSfeP4Xxf8LBufVQfbjfabN2ROXi/jFHfjaIZ?=
 =?us-ascii?Q?3UxaKGPizbEU2dW/0KJOoMH4scwqt6MdykOCiovhQ/ODvBNsOCeLLhS3OVQn?=
 =?us-ascii?Q?G/0GwJrRVh/+z+xqkyR81067dgz/HrGq40QrDw32thUjhMf/25mCm2bBeiTc?=
 =?us-ascii?Q?+GGuseDytq9qm9BQ4e9A4SWKJbyA2Qo2sLj9brhBNG74CO7RPmEQSQljFV7M?=
 =?us-ascii?Q?UuMD1OwpXhWkPouA4vcXipKGqfEExmYHLeGN3ZcomwmR+SwG+4PgZcQAcMA2?=
 =?us-ascii?Q?XmycomylbsoPazaFRW6QzA8kjKqka3xoGcDwVSgz34Uh52Lg/+TJxplCXQNm?=
 =?us-ascii?Q?QrR1uUcPyD4jU8LefNWm18xSqAriak/vYePqHvURdV9l8OFqypmhARMyeoUR?=
 =?us-ascii?Q?Flg6cgY+KY1j+kQ87YPx12J+O+nKuOCdSBnSkuaXLq+LQ7botUTKGoUidSuJ?=
 =?us-ascii?Q?Xglxl6YsV9/aojK/3mDwh95C4HoNgkO6ftTZGHtBjheFOSCyxNiMq+9d+/aD?=
 =?us-ascii?Q?FhkeH//Oj7a+Yt6tV1CIin9fOnbHMhHWp4NdCcG/BxqHrXjNfF1VdQ1nDAJZ?=
 =?us-ascii?Q?IzLFIjpvHzCuc/sTQh1pmVabolRhImJF/2XGzkOtPzSDERmQfNyCd9RDEl0Q?=
 =?us-ascii?Q?b9ktyK+fADYEvlrpVv6/uxCuZw3m+aHkN0hQRlSop+qaW314iRskP9X/zQp4?=
 =?us-ascii?Q?JPfTlpd9FA/cblX+N/rq/lKDVmqb3O+LzmhgFVF1mZxYV4qa3T+XNvz2d0r5?=
 =?us-ascii?Q?p0e9w4tbCs170ytZ+J+tAatXTWamakdBqH9v+KOUPpG9rtYOy233PezK7jJ7?=
 =?us-ascii?Q?ahifUw+vgYONz+vV3dzmqvo4S9zdV+6FiN3J?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 08:38:00.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23af3a2c-b23e-46a8-faed-08ddbdfabfa9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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

when providing short format PCI device names in devargs
(e.g. "08:00:0") it is converted and stored as long format.
however when attach_port is called from testpmd, the user might
provide a short format, which will be passed to find_device with
a comparison function that simply compare stings, which will
cause find_device not to find any device.

This fix canonicalize the user provided string before it is being
passed to find_device.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-pmd/testpmd.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..f8d67f2c64 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -47,6 +47,7 @@
 #include <rte_ethdev.h>
 #include <rte_dev.h>
 #include <rte_string_fns.h>
+#include <rte_pci.h>
 #ifdef RTE_NET_IXGBE
 #include <rte_pmd_ixgbe.h>
 #endif
@@ -3407,12 +3408,35 @@ reset_port(portid_t pid)
 	printf("Done\n");
 }
 
+static char *
+convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_size)
+{
+	struct rte_devargs da;
+	struct rte_pci_addr pci_addr;
+
+	if (rte_devargs_parse(&da, identifier) != 0)
+		return NULL;
+
+	if (da.bus == NULL)
+		return NULL;
+
+	if (strcmp(rte_bus_name(da.bus), "pci") != 0)
+		return NULL;
+
+	if (rte_pci_addr_parse(da.name, &pci_addr) != 0)
+		return NULL;
+
+	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
+	return pci_buffer;
+}
+
 void
 attach_port(char *identifier)
 {
 	portid_t pi;
 	struct rte_dev_iterator iterator;
-
+	char *long_identifier;
+	char long_format[PCI_PRI_STR_SIZE];
 	printf("Attaching a new port...\n");
 
 	if (identifier == NULL) {
@@ -3420,6 +3444,11 @@ attach_port(char *identifier)
 		return;
 	}
 
+	/* For PCI device convert to canonical format */
+	long_identifier = convert_pci_address_format(identifier, long_format, sizeof(long_format));
+	if (long_identifier != NULL)
+		identifier = long_identifier;
+
 	if (rte_dev_probe(identifier) < 0) {
 		TESTPMD_LOG(ERR, "Failed to attach port %s\n", identifier);
 		return;
-- 
2.34.1

