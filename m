Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57010CFD376
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 09:57:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 811A940268;
	Tue,  2 Dec 2025 10:57:40 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by mails.dpdk.org (Postfix) with ESMTP id 063D2400D5;
 Tue,  2 Dec 2025 10:57:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlw3Vg4fPnhavo3JNnHEuHHMGiEMiTzGoLErxo46sAjreEzqfw9ypvZhF2meU2xErCK41AeUffD3GgDnEBYgXmZKbABzpuEVob5N5PO/rFHU6TXmHhTVDHXmmaxUE6ikwtMYilpi7bVhuVpx7rAeNnghoxRE9+8ZZCKcLCWpvgnsOnzcfBDvOMLL0yGXxjNKItFOkXF5YDM9upkiE6LRlUiOrlg0lx+3DmDa+GhSk8wh2p6OZmebIOdUQGJiuy4uJGXK6M7xiTg0RAxrSmgAMTfPSOLG+zfFzbhNNkWprq316FuuXKIR9Hxc38o3ZeXrCv9/1a2W4VKAoMpwmowNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TskRLxHSPbFTvqteI4HM1/3JCMxr0zPYh9KBAjNg+yk=;
 b=R0SGMazwAUv+QPav7jj5iOKDVcy3qszOmiVVvZbJUQMl7PGaI3oJw4CnZ8HWdf280EVVBkNWD4C4qoB0rkCGKM0J87CahO73FS79+fLRxkt+Q2Fa6n8xWb5bUbe/rnRvbQ33+fH3k+BFzuscFSco4Fw/YEATyDOJSM0d5SvTxA2gk8MWLzwjOH1QeoKlT0lfYCXMzIN8k0Xohs/jjTS90IDHVWwiCvaYF8wgb6cGqa1kz88HlULts0jOmUX3fgRF2cBTZFR/rFpFD6CmujOIGp3tZT1tePcjkEZnnHhoOVS7aS5xWo6+mZ9zexSbH8FoMhRxlcxNgJTXzJh2E7vSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TskRLxHSPbFTvqteI4HM1/3JCMxr0zPYh9KBAjNg+yk=;
 b=NOmn5GcK6XIRVPfWduzf7WiSSQXpDrh8kxRLnLDWO/NBZUNASqNrrZr+va7PvnxGORhk/z08bez1TxY7/hICt3ltSrCfNV8g/SEPsdTs50ClvTIcY7luEOKfF6gYM9d+fbekG5vpvqetk75qNxEjT2tsny0kcdaw9xefM3ljcwiBcv3d9879HpM+igI7qWa5TEphE3Ihc2I4cXEHoYdMXSdC/KjlJOLHX+YeVhp/r/wrV9UNR8qVv722iSdWMqHASzJ/lYUuBvOKfRW+Telo5vgA68OKvoAcPkswU+AHhBtzw/UoxNMUg7Hez4FQs17UKpiy7x6dXvH7BBbw2LuIhQ==
Received: from BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::31)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 09:57:33 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::2e) by BN9P222CA0026.outlook.office365.com
 (2603:10b6:408:10c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 09:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 09:57:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 01:57:25 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 2 Dec 2025 01:57:25 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Dec 2025 01:57:23 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, Gregory Etelson
 <getelson@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: [PATCH] app/testpmd: fix memory leak in port attach
Date: Tue, 2 Dec 2025 11:57:20 +0200
Message-ID: <20251202095720.264195-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad32608-f897-4737-f3b2-08de31893712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bickP+zJviXs8shpgc/Nb/VAT3UN1zlUlvTm8DFkTKLZK6X8uHRax/SjoLMJ?=
 =?us-ascii?Q?TGc1UOZoP2PWd+lcr/J6fzQZ3A4kOZpws3l1cmkeS0UsS6evTxGoomW94qzD?=
 =?us-ascii?Q?SZ8f+Ete/6k/db9a7h1H9D80sz0dQtxX7V1Uac+1Xrk73AOLeA/KMbdIQbN9?=
 =?us-ascii?Q?ulIbMlLMzCZlFNmQAnNzpl2tgRyLfpIXPhOcrhS65dpfGEfbA6SaoKO8PXBe?=
 =?us-ascii?Q?25Edxge7ROcH1a3m51tEVI1iB0MaE+w9OhZYYaRHc1RK7lM+fdEpGVm9o0Zt?=
 =?us-ascii?Q?eZ770HiPjEGIyWQb8P1f51ntIVo8WCUmClzqBR5GqDyQ9RLkRPytWKeIj1Bx?=
 =?us-ascii?Q?Tye8qqtULOuUtDQVAPuQj9uFDFVSSq0VnK2Xw1iLz4kXb0dOQIVWAYMnf8jl?=
 =?us-ascii?Q?vZ8XQP5jGtxXNXWg7pl3VUHEWVhjnTq5VWvx0plV0G+gfSs3OAYv3JzmyyK3?=
 =?us-ascii?Q?DTTfQy/ZKmxmaMrrEPuXim0W9chZCKjArjVF9OVj5xe5o80ckhgQmh0YiWsH?=
 =?us-ascii?Q?7+3/BFUqt05d6nrQwi5PBr67EnpotkTCyEmRfcqd3Ll2YOv/FPZpPMSeThAt?=
 =?us-ascii?Q?9mECXS2UeXdZrAlRA6MQA8gaSM4Ykc5YrMzeFknIM2IwYLchxXvRt/o/kT2w?=
 =?us-ascii?Q?hlr1Z+IBNcei9Uo4RjuUXJkfcadgYhWF1T798IApXaDy2RIGnR4k37D5KEPG?=
 =?us-ascii?Q?ldNkn+yiGjvta0MUrWuoSaGIxpx4MN4vJ6xHeN8mZWpROT2MDp8pOVlxwcjk?=
 =?us-ascii?Q?acrf4R+Ze6OrhwXSaDV/YvcHt44Sey4dNHd1b0IBoS430+dKpjBrLAIgIROd?=
 =?us-ascii?Q?sagzG/IXkfPqiteHdvRqgU0Qla476FD+WoRSyIrRMPJpzUFDl4sFPd5pADrH?=
 =?us-ascii?Q?9bfqlqY5aXVnIx4gLl3OHDalSA0s9SUcyzZXreBIUQv7a8sfacHBBBSm2KFu?=
 =?us-ascii?Q?LRhtA9ag7ZsnPJxzG6wPDqfkPIo9tlqLEqZXj3Wib/gVTaXKkyxmC2vjc7mI?=
 =?us-ascii?Q?cY30xjgJ7haxZRtuk4SnoZ1oCkDy5/CSpwXkM7jJmCwbJxCgno9NAkYnrBaU?=
 =?us-ascii?Q?T7AhE8C/O5GzyIuNaFE2t9ZXhDIVwpRh6gOUdplyW7TB1hef/rED/vdo1mOU?=
 =?us-ascii?Q?XA8FX+29/uSI4wR1lvBJ9YoVu6sbh5Zl36QRfuOxhOcCcIVzxW95udlEnSEY?=
 =?us-ascii?Q?oRlE0i84dXMWzCC9IPfdVClOM4nEYT0QfgTYBLqgrOGdxvrRieT0IjzhYNY1?=
 =?us-ascii?Q?N/RAOmrfHT+VTQQeL6RhLaJKgWXw/FcSSfYosXa7fXiPx/JX5c15GAtyH0PO?=
 =?us-ascii?Q?0elu2HMZ7/omTF402Nffijr6UzM+hA2uxz73OTSWYpYPwOGLh1fduBW/7BC+?=
 =?us-ascii?Q?2Zymb09gc0RlRxENVS7hCY46V6xAQFR+24NidT5qEXKcBmQLmXAG9ztjSYFp?=
 =?us-ascii?Q?4NlCSIgb3ZttspsEcyomQltEX8tGGGa/PejKqEl9CPFxNOw60KYlcTudLmwA?=
 =?us-ascii?Q?/g65qd0vE2e6jjOlXJhseABSGTV3YvZySWYyDWamIrzF1B7kPcsA0toVoo6i?=
 =?us-ascii?Q?zgdDNVtJV1KnLiLVAmQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 09:57:33.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad32608-f897-4737-f3b2-08de31893712
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
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

The convert_pci_address_format() function was leaking memory because
rte_devargs_parse() allocates memory internally via strdup(), but the
function never called rte_devargs_reset() to free it.

Add a cleanup label to ensure rte_devargs_reset() is called on all
return paths.

Fixes: 12c2405989f6 ("app/testpmd: canonicalize short PCI name format")
Fixes: acbff64ea5b1 ("app/testpmd: fix devargs format in port attach")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-pmd/testpmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 1fe41d852a..7c8cd44013 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3433,23 +3433,28 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
 	struct rte_devargs da;
 	struct rte_pci_addr pci_addr;
 	size_t pci_len;
+	char *result = NULL;
 
 	if (rte_devargs_parse(&da, identifier) != 0)
 		return NULL;
 
 	if (da.bus == NULL)
-		return NULL;
+		goto cleanup;
 
 	if (strcmp(rte_bus_name(da.bus), "pci") != 0)
-		return NULL;
+		goto cleanup;
 
 	if (rte_pci_addr_parse(da.name, &pci_addr) != 0)
-		return NULL;
+		goto cleanup;
 
 	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
 	pci_len = strlen(pci_buffer);
 	snprintf(pci_buffer + pci_len, buf_size - pci_len, ",%s", da.args);
-	return pci_buffer;
+	result = pci_buffer;
+
+cleanup:
+	rte_devargs_reset(&da);
+	return result;
 }
 
 void
-- 
2.43.0

