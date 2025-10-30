Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8589CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 09:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A33284027A;
	Thu, 30 Oct 2025 10:21:56 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by mails.dpdk.org (Postfix) with ESMTP id A44044026F
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:21:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh2iMn0UE5JveDnp2lHD3CrqV0Rov9MkHvKg9kAwrS4ItHeAPy1zKcCeOLHxv0lLA9fH7QjzxxHO01bsBG2LPfT7wsTP1rh0VUxSZ7XZx3591kSKzYmrXIicfaXc60yZ3FYZmubPYjSehZ3p+/eDtUAvO39uPibPyBbHEQmovHy6r+os5GaXFGgVT8ITixh+y7emjI8TDKdg5z3xm+wNMVXJrNFBnx5d+R+2n2huhlO64w08jQwjELseqLHUK4NK7vLx9gCW0FktVMHyssr5gxYrlsatNNrtz4rrEBzFUTG4FCmsuleklzv2CeZ87LpPpHLI+2kuFLs9s0yqb9iZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4GwfXOKSDFju768cWT2NNEMkgo9etHKDY4AUMZpPUg=;
 b=l1esgdqBIhpGrXU5xAphBWReKXBJLSZ/5LSLgSvTFEikRJ8Wf87/paHMLW1oAEDsS4plhWQsgsNC5xD/j5bHHHOgCGeIbhMTrLlf9DIA+0kqbgKpWwjAj50l89RcpQAsQVDGL8TBxIiciS3l19u9D3sQX+iBQKXzoEEjmaNuk0+QTXWlmoIvVuf71U0pWo+9On2bQWfX/OSL/Sf3VBgOBhEwpks43+L4Fir6X6oq4DN9y8rMuOFgjYoneDMayw9/SiH0xNjNOdTacKb0Tl7y/12uwd63PiOYPGyHXXVHudKubDJxMYoHPS34Ng0uEFz8rf6NouHyRzdj1oAp9s3RLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4GwfXOKSDFju768cWT2NNEMkgo9etHKDY4AUMZpPUg=;
 b=bDEA93ME2enmlV7ABqANdPPp7/KSAnZx7YFE76imLpMx37MSMVT/R61NpYGQTdRfWOprdwDPGl2q2XTrTMEAhbGM6cuQvSzLMoDw7mKhpqEBbeN3KLoL2RPp4yFBTD9lpmuPHVefJskaZviaq90kCHQ82d8QPMUmVAX2QcaFLXsvyfpqdhif3bI7Oci9QA8NZLhkVmZeRXB2q0ZwEdHMDzz+UaeZX+cllKdDTwFnP7Z0b7oZgTPJKOAzGv1il9arUdWXBtRj7Vj4twZ3t5fgSgfhTuXkd9JUrRDye+wp89ZQLt9q/wk4JxD2HnQsoCHL95yIPdaF8o+aKYaPSfzZXA==
Received: from MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33)
 by SA5PPFC3F406448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 09:21:52 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::f6) by MN2PR07CA0023.outlook.office365.com
 (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 09:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:21:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 02:21:37 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 02:21:34 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Aman Singh
 <aman.deep.singh@intel.com>, Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH] app/testpmd: fix devargs format in port attach
Date: Thu, 30 Oct 2025 11:20:15 +0200
Message-ID: <20251030092016.226974-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: c178965c-c637-4d18-baa0-08de1795c2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AfaM0NX7oEXbVADk4E4PhPbuWcubwoMN8gYNGjHduwSG8Ps6wAMRk5cMlXNp?=
 =?us-ascii?Q?FdjeoJhLJlubyy6OIQIpIjgxD44iWyZWxPTXuV2BcT4aE+vuul9vctpSha4d?=
 =?us-ascii?Q?8EeR/pIGJtfCnFY1kf/ES33Qkb3ptth0SlmBDCmD1fkxgoV1NW56bsEcIqSh?=
 =?us-ascii?Q?8WhnzDuQUkNAtpcsLa0fIGdt8xke5mP3rhroyo6ayieDW5hkjt0CBAY10BH5?=
 =?us-ascii?Q?ILjDj0hRfrMFE8emlo6eySOK0woHHBxduZyj8nVrpnr7HeUr+f9CWXXs0cwD?=
 =?us-ascii?Q?T2Y3AW/8zVDa6oxZTE3CVd9fgjCMx3LGxwbCDHuxokJnmgmWfq4iTkjOfHxS?=
 =?us-ascii?Q?fKg3m/jyMAwsX8+U9K23myx1E8zFQjJgPCpLJ3ZPuOAhtZzMcY9Mi3QypLKg?=
 =?us-ascii?Q?vfxXONmt9e3iwiHYoYGTYKDgFc9MvJHX07QmZ8csNfGUO9Z1KlDmv/EXCOGu?=
 =?us-ascii?Q?s4ta0luMTmaR8fTGh90h+vFAxTmRcu5jI7GvEwarm+/y+sre8wVvdZYZj9iU?=
 =?us-ascii?Q?3ZkK+7JH5aJQxOW8wTclWJHIcCh5g9uV0DiTi7YYTSpdrsOpc//pcThrPQz6?=
 =?us-ascii?Q?PnUSSCThIa4W5QgR/zhzalFFcH8DU6jhJZxUeCAN4AqI7cnutTGak+kgSNe4?=
 =?us-ascii?Q?qdHJhzq/MpFB4U7Z/tVfNu2iFpchfCeUHu2Fy1ymzTR2HHMF5xroAo8DSM87?=
 =?us-ascii?Q?dFj9s8z94iUf1+stggwvAHa9IhwPQr3XRn1sup6f2UuH9PYreCCh8onV+Xzq?=
 =?us-ascii?Q?MhDgHcX9OVvrGMxReU97t+k073okPVa9gnrz8zRG0QvCkNd1j44utX8RkBaK?=
 =?us-ascii?Q?cwcZ/sQ0vTvGhnVoAKugA9Wg8JXPeQLw1yW2iOMmylmjR7Cv20Rw7DlCoR6i?=
 =?us-ascii?Q?oFzwi1ytEVxNw7pRpxkUfYX5kuN0IhNOS32w7zYnDc4pmhy22qHKvvFJ3lD8?=
 =?us-ascii?Q?LmZNiZmWlYVAdQKPnWSFikrpeMyi8zlxoxYLklq1tzRYxGaVG5DrVOikl9H2?=
 =?us-ascii?Q?7KhIEkegT2pWUcdMB2cyJCr6QnNkUhQPA3HaPc3KIsfMOmPZYEG3csKhxrRl?=
 =?us-ascii?Q?yIxMjZ7t3Re1/+mb87f6VR9I6JBoqUg4EDAgP2ah+4z8SBRyiDP8FjSwMLMR?=
 =?us-ascii?Q?TrNDMBRA35fkvwqtd+gvIA2/64Dc9+9iuJeAKq8NjSfZ9Rjpyp2qAtp7O5QD?=
 =?us-ascii?Q?/fiZRk/ppDCtx32NH0UvCEL/0TBuqf+HLPSE4EhnNzg/CMubKTVf4dLAzEbk?=
 =?us-ascii?Q?EZwVVw9BK8z+ccEueK9xpxLwDPh0Ek08YU6HUGoKBGV9yGcCyNJ3mFQN+oNN?=
 =?us-ascii?Q?gO9UwrXS+angBZX3rGg7xzSoDJ2ZSTIa99gp9x7XbRMr+tfgPc/bBK1Weqcn?=
 =?us-ascii?Q?TQY1auIAwaZ3p42BSqvAC/8EdICZ47mpERZVyqGnJKSFESuG7kRmWPo+TZvm?=
 =?us-ascii?Q?GKtGU2l67AojUc45dQyEltMwD55vRRF5s1sC/CvHG26xMO9xmGfUs88QxktW?=
 =?us-ascii?Q?1T4n38k0UEjcEsfcRYO4YMlPTWKr4zaF8ItEE0qD3rJb7HrMof50LSdQ6HB2?=
 =?us-ascii?Q?Er9axn1Gv5l47JNpZIA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:21:51.5212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c178965c-c637-4d18-baa0-08de1795c2af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448
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
 app/test-pmd/testpmd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 2360da3a48..cc384f0b14 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3413,7 +3413,7 @@ reset_port(portid_t pid)
 }
 
 static char *
-convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_size)
+convert_pci_address_format(const char *identifier, char *pci_buffer)
 {
 	struct rte_devargs da;
 	struct rte_pci_addr pci_addr;
@@ -3430,7 +3430,8 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
 	if (rte_pci_addr_parse(da.name, &pci_addr) != 0)
 		return NULL;
 
-	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
+	rte_pci_device_name(&pci_addr, pci_buffer, PCI_PRI_STR_SIZE);
+	sprintf(pci_buffer + strlen(pci_buffer), ",%s", da.args);
 	return pci_buffer;
 }
 
@@ -3439,8 +3440,7 @@ attach_port(char *identifier)
 {
 	portid_t pi;
 	struct rte_dev_iterator iterator;
-	char *long_identifier;
-	char long_format[PCI_PRI_STR_SIZE];
+	char *long_format, *long_identifier;
 
 	printf("Attaching a new port...\n");
 
@@ -3448,9 +3448,14 @@ attach_port(char *identifier)
 		fprintf(stderr, "Invalid parameters are specified\n");
 		return;
 	}
+	long_format = alloca(strlen(identifier) + PCI_PRI_STR_SIZE);
+	if (long_format == NULL) {
+		TESTPMD_LOG(ERR, "Failed to attach port %s - allocation failure\n", identifier);
+		return;
+	}
 
 	/* For PCI device convert to canonical format */
-	long_identifier = convert_pci_address_format(identifier, long_format, sizeof(long_format));
+	long_identifier = convert_pci_address_format(identifier, long_format);
 	if (long_identifier != NULL)
 		identifier = long_identifier;
 
-- 
2.51.0

