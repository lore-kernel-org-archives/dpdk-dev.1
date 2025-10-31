Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47E7CCF9EE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 06:20:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2E1840270;
	Fri, 31 Oct 2025 07:19:59 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by mails.dpdk.org (Postfix) with ESMTP id D02484026F
 for <dev@dpdk.org>; Fri, 31 Oct 2025 07:19:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUljDv5TQKrds6ClIWNFDScu7Xk/YLyBUWNEkZvZEZFP/WlzFIMmr2W9pSk1UMEpz0icvIjLFM18En2uQvsT9QxCjMBfaxpA0ofcXBf9hnGRC+09a6TlYBbEKH3lUYliwMiKT6K2LgkpPLZsCSz7d9Eki0WSliydL1WNGshlxCELOPguhgAn45uIn1ESIIMRyS4eD6xard8Yka1QuGghL3OlnC4j7q4Tr6vSFXxqez0X2LnDB7HOQt1bY6h1FHxD4AANxBBCS5CRUGqoFnr3d5vEmdsif5lcLipuYmR5AzQV9T4xwF1GoAFhlTlBITW89gCvk25+E4adpDiqUeEBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx7DJK8bWtmFzaNoUFcIUhwKMAZBmRlptJN/QSDyNR0=;
 b=Ws9x/onRP3YrOi3zmyMVTF7UaCGMyRkViny9+c6WwsCzeWxZOTwnh32MaNMeTYkqMzUTr/KhWowZWEzkZyd6/GWlSXUQomkmjlV/qP7QW8try620tuaO7GPjBXoq4GQW6OCXTxHrHAnNM+NTlyTL9bdUoWvXOLx3GbXddUxFV3VsdF5hNIDOuoiQHbHi/z/3Sg8YLpC3ftIbGd2ArQqG7umr65tDMBfjESY0ofDgIiisQP9Ox3VkSpkjPc1A9lmPYbOiSAQyZuljmm2ujyFTzq7j/TlNnxdXxBJIWXOn7ZN824l1eSpWX2iFL7Yk3U6XxmKWzNv2EzyJZgqm3/OCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx7DJK8bWtmFzaNoUFcIUhwKMAZBmRlptJN/QSDyNR0=;
 b=LztkmFUW55Iu9L0QnVkRCq/rwGo/9BxoJ/Iwrh/j/Cq2xmY2DN/Fp5dMl2Uw3PGbTv2f00iHeNae8st9WExQ9I02eUi+PfpXt9BusNgRid5oeo10dcPoTjaSjBS+IySZ1ILjVeTZdC1IbxeQKCVcrPeGX1UDntXqa3P7p8xltf8Kpf2QuqNkmL/ntWOTlq1S1rKEN3D/PBPpg10pFmLxnR8DjRj2gpvJLn8TRVtpVK1Op/HzQVGnThQlissLbtqdYm85y6rcAW3f2jWXEwpDP/O13emIN2WcPTlxhtq2cI7CfveiM/NS+qiCvUrJWLefR/aUwAHVOg6chSYXSYO0dA==
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 06:19:55 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::9) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Fri,
 31 Oct 2025 06:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 06:19:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 23:19:41 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 23:19:37 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <stephen@networkplumber.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 "Aman Singh" <aman.deep.singh@intel.com>, Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH v3] app/testpmd: fix devargs format in port attach
Date: Fri, 31 Oct 2025 08:18:16 +0200
Message-ID: <20251031061816.333400-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030092016.226974-1-getelson@nvidia.com>
References: <20251030092016.226974-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: af26937b-2400-49e8-1c74-08de1845816d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w+jQnt7h21siaMwb1aI5fy77Gekbg/QkOzMOIj198hp9bYIydWSCYFZpQYpJ?=
 =?us-ascii?Q?xSlcRnmZdC06rGw//rneSbU/+Bk7kV6ra6YNjzpGZO9WyUYpLmkty0CjNOeI?=
 =?us-ascii?Q?ftCFzLlHVp8lBoVvaROIZmnB2ioMwmiJZuHuC32xj7DBxXXyvq4oVVgoItsl?=
 =?us-ascii?Q?KhZGJbq4VQUdwdGpWbkyUhagWzPpsvgBhrlvUBSm8JI8VFvSBe7NCQFDpzQX?=
 =?us-ascii?Q?IkjBVRQCNxgidpcRFmUiiIJrbtO8MVUC5iL1ydQlO9SeQWB4H+VHY9/NJuCt?=
 =?us-ascii?Q?aF++ckAbbOfju0y9Q8Lwq4BWTApesGAQYT4ysN9JG2V2581Dz/Ar1ZYv7Nj9?=
 =?us-ascii?Q?PtLiDru06OHBgAZSh2c26Am03RmWp3UmDRfTLgtiQQuUVL/491EB3FQkeTSx?=
 =?us-ascii?Q?ShXkRmOwt3LBuk6UjccZh75zln+vt8/F0vIeLQtefKAF8gD7vdmsw7Qq6AiR?=
 =?us-ascii?Q?rSQUNs6/+fdTVUEOwb0Lsw3rJ8c8pMnm796mfrBycKi95E+xdWtVCKw53oJY?=
 =?us-ascii?Q?VRDDRl1JGX2Nrcb6woXjqtiGKN7IdFb/ddLFsuo7U61RL7hWR8WaH72y2mjY?=
 =?us-ascii?Q?F9K25MWsEF3V7P2r256n50C3HZVFnjeHpoE+6Fsr5ADTqgwK51TefnQy4lYd?=
 =?us-ascii?Q?vv+IlEtdV6eeY/kLhYAowBUBfiGKys2DmhlpAAJyA4V5UGGBDwvAc+QTtpjr?=
 =?us-ascii?Q?7lefvgR6dD4xlqOq2KanMQotg1S2SD5scgpDMgzcAavBtS4Oq53oEPEXZbbQ?=
 =?us-ascii?Q?CBXOAwdAsNSL/sQrEXNK0C7zgwubyvtfVbSI1HlFxU6pWzsf1BU2ChGabh43?=
 =?us-ascii?Q?yBLALaUEGfKXxftOZAWsQV3nTLHMPbPYy9ghVeEyyTdbOnS0Yx2p/Nr8wI86?=
 =?us-ascii?Q?IWm1SfInrZIZ5saWBT6yLN0auoFvOf/TIh0reDmbl/h7+wivyty5OM7Re8o1?=
 =?us-ascii?Q?JkxC0yx6NjhjENKngDMJFa5eCFuLjzS72Ub0jMJsplYuojpqgbe2zw/hfCPL?=
 =?us-ascii?Q?DdpQo5T480Lo2h5Ysg+FYkiccGXDGcAyQCGZIF++NptBNro/OacKwjh1QW1x?=
 =?us-ascii?Q?/FlILV8UB3Ia0VwFjAwr8AQk+mdFVu3saC6sm3ROaj9DwzR+ElxvTf4wvFmN?=
 =?us-ascii?Q?hSoXiAoTNnbgrfsZhKFg1SaWfCJBLJ/JTn55cd1yfvzkr2NaxTj9CDa+4T24?=
 =?us-ascii?Q?QUBOMRSCE1qf6OqFj2EZXORmVHoxmSVSV5gLN1M/aYvmIBMzB7k1Fepaq5JJ?=
 =?us-ascii?Q?10xMCdUnZ4QbwNEsTJbTLyg9nTQ6P6Nl0c6tF96Qs4UQm6Iv7YMMCcTBXjAz?=
 =?us-ascii?Q?RWXf7EPKjHq3Y42gMxkn0YIeP1xTxWhdBjjhnuExmbr8GZ1ZZmVxKvzAq1fZ?=
 =?us-ascii?Q?y3T8SEcDa6q9+HuCC7A3kSjGfaWL4xWSl0TlnN0fqW4mJvG47Ozi/15bOMMv?=
 =?us-ascii?Q?fqdU7GCmo9tyUzzVTw0rU16EhY/AecYyLOx1NcgmpMs7Gc2FpNgWxb7rHkad?=
 =?us-ascii?Q?x6Kw7+CgPDn2m9NUjBoq7ng5LBP4J3+Czon9w2ARo7N3siGPtK41uWFa0PWy?=
 =?us-ascii?Q?4qkTDvlvhJ36Fd2j3rI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 06:19:53.6074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af26937b-2400-49e8-1c74-08de1845816d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8
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

The port attach procedure discarded PCI port devargs provided
by application.
The patch restores PCI port devargs.

Fixes: 12c2405989f6 ("app/testpmd: canonicalize short PCI name format")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
v2: add buf_size parameter to convert_pci_address_format()
v3: use snprintf()
---
 app/test-pmd/testpmd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 2360da3a48..b10f6baee2 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3417,6 +3417,7 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
 {
 	struct rte_devargs da;
 	struct rte_pci_addr pci_addr;
+	size_t pci_len;
 
 	if (rte_devargs_parse(&da, identifier) != 0)
 		return NULL;
@@ -3431,6 +3432,8 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
 		return NULL;
 
 	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
+	pci_len = strlen(pci_buffer);
+	snprintf(pci_buffer + pci_len, buf_size - pci_len, ",%s", da.args);
 	return pci_buffer;
 }
 
@@ -3439,8 +3442,8 @@ attach_port(char *identifier)
 {
 	portid_t pi;
 	struct rte_dev_iterator iterator;
-	char *long_identifier;
-	char long_format[PCI_PRI_STR_SIZE];
+	char *long_format, *long_identifier;
+	size_t long_format_size;
 
 	printf("Attaching a new port...\n");
 
@@ -3448,9 +3451,15 @@ attach_port(char *identifier)
 		fprintf(stderr, "Invalid parameters are specified\n");
 		return;
 	}
+	long_format_size = strlen(identifier) + PCI_PRI_STR_SIZE;
+	long_format = alloca(long_format_size);
+	if (long_format == NULL) {
+		TESTPMD_LOG(ERR, "Failed to attach port %s - allocation failure\n", identifier);
+		return;
+	}
 
 	/* For PCI device convert to canonical format */
-	long_identifier = convert_pci_address_format(identifier, long_format, sizeof(long_format));
+	long_identifier = convert_pci_address_format(identifier, long_format, long_format_size);
 	if (long_identifier != NULL)
 		identifier = long_identifier;
 
-- 
2.51.0

