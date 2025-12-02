Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3127CFD376
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 06:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C536E40268;
	Tue,  2 Dec 2025 07:43:52 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by mails.dpdk.org (Postfix) with ESMTP id 38046400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 07:43:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNuz5q4vNQ8lufrZ1NGwtoYtdVr/T/fvxGUHw6aDQpEX5k7kohr/PAIDqD2jgBxyGHbRX5Do3r5DTEkLGwMw/2Lpe2UcJn0IlI8n/rPpEd5S/kiKSPhW3bknttOyFg1Rw8vpBkB44yrQzVhVvbBU7bhyiMA8p3ELl53xaM+9TZfI0fZPZdxCKbX6mJjIBZ1ysNAt7K5fU/Pveo29A4T8RGUonyOk1y9lP9Umi9L6HTGinBYcRqYd5hV6dsTMha8EX4Zl051E8wMZBO6Kv6GItrgEKwsTNfCEkQtf8BMMsMoIBkvpSeBfkloszvwWh1scXkXrDraS/BThdcKMVLrO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP/wpWHvscu8V78JB9OcZrvo6XwwhDTaaTi/WedhGGw=;
 b=hsaEts6qaBvZO4ump04cj0YGvsv1OScMnj57b05P4+p8zBLAOKwHv3ezejQN2mgBYUCRrqPKVmu16ThZMMCHNob8vdgaSs91m2dYWPHajYp/xQjowynMfzPrfIBFBdIa9meB4KkFVd740yZ37+aFWEikcO3i//HoVLJBRrcLAU4/gKMmLv7jtcHygija6lUQsuIte2OS1hCRMpe/6sFDqe5WRcOz4Vsru/r7MZnpO+FeoAVRWRyoovCdFdE60ac4qaG6SlFr2b51ajVOlwPg+PWB/apb4hFHDtVp6Q9S13yUbWMGurVrE/JWOqVjAWqcV6QisotwTZJRzYMekiF17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP/wpWHvscu8V78JB9OcZrvo6XwwhDTaaTi/WedhGGw=;
 b=gUFkUsC0bszPRmvid/bH6UNAhCLWGr5ZwqKoWNiXbuv40h8mTyaLfV/EkT9LEYLq9z2DBHAm3DHXvgw6yl54xao4axa3HNpm7KgDiB92Ygptt6Mw2mL/mBCEtTGfcoXQepkDO1HHWvGP2Eq5w6MRTn4e69He5k6ZVY1Iz8gnLHg=
Received: from CH2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:610:58::39)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:43:47 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::ca) by CH2PR20CA0029.outlook.office365.com
 (2603:10b6:610:58::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 06:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 06:43:47 +0000
Received: from cae-Wallaby.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 00:43:46 -0600
From: Vinay Govindaiah <vigovind@amd.com>
To: <dev@dpdk.org>
Subject: [PATCH] net/axgbe:Add support for V4000 Kracken2e
Date: Tue, 2 Dec 2025 12:13:34 +0530
Message-ID: <20251202064334.312225-1-vigovind@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: d931789b-4200-4af4-6009-08de316e250d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2NlSHrSZnH5x8MsSfA25D78y44BvYEyMahpGAFzwUuy/ikufuQrvmrQU4yFa?=
 =?us-ascii?Q?T47HSlYWqz2HVle5Va1a47fv1OG0fFmoxfV4wdbVBMVu7wXuYC0AWefrUNHc?=
 =?us-ascii?Q?OvkVo/1fx96vuOlU9nKK2GjS8hy3MmSuv1PKOLbO70TIO7vxpo+r6NbZ3Z8m?=
 =?us-ascii?Q?D06EHT8bDbWzePd+8eVCI77YNY+Y1s5JG0JMBGWaDtn/IiFdjbxtUOd6ycj3?=
 =?us-ascii?Q?2m9ojw7kaVT47m4axNTCbL9vWCuOJuxkBDdQm0nrSgySUc/2cuze5gC3ZjX+?=
 =?us-ascii?Q?DZ8cVB02EabvRmEO3eT/PI/h1OYLdjnSLtP43NVbkaSqqoR9PGBjyIBqYrrM?=
 =?us-ascii?Q?wG71UfFQMNVUtijCyHLyCxsX0O2Nwrls8QDi2pRUuATY5CMzyIcHMbvOp7Oi?=
 =?us-ascii?Q?VV4jq9ttrlTEvkepOp92SlI49KR3AqK+HfwWQ08OM3Oq9aseBHKzyhaCg/J5?=
 =?us-ascii?Q?/g8Xk7aIO6aMNYtF0P78Yg84pkLpQG1Cg5Hl3uG+/IlYz2mvy7gy3vwKxjmP?=
 =?us-ascii?Q?8rCy/hwTBJG5ZGLG69Nf3JZCeyMJHxzOQdUr9Fg959CBlJ+A+4Du9WsnHuNq?=
 =?us-ascii?Q?2owd2vUpFP3r5ed56z53OJg3VsGNmI7t8xsDhimTW3EzaFO83xQ9lz0CCiVN?=
 =?us-ascii?Q?tttxISQAzkgKhxTqfW+xuacbr2GkMN9AK49shxRNZeFkaGx3aNkMJtDjQB8R?=
 =?us-ascii?Q?YX1JbdMr+nDoJDEUBzRHQHvEIrH1ZQgDrcslVeCHUWxK+fLI6LLxTrcmXXTO?=
 =?us-ascii?Q?gJwgMrBnlwp64aQ07GJb0JQwnmwMZV6vRKeGamIoZb5YVQSPoqdPF+sCOGCz?=
 =?us-ascii?Q?jA382oW9fYD9BLEEb+phWrOxPAmb+jtsG+nMrGlLhDYgrejwZG9Tj45tqCp9?=
 =?us-ascii?Q?sGM4wiu6bAWPv8Mm1IomBoMrvRx9cNJPRSWD5uHuYdjE0rzYJpuInp5PBhDn?=
 =?us-ascii?Q?S0G5j5KUHATM4FC90opbzoulJyY3qule7qKPXehj8loC5qvMmIaLs36pGpAP?=
 =?us-ascii?Q?Gh2u00CPl+B2+yEju7dBT5XdKMrOwR/BElXOqT/aFKRV6352GRyLXrI651jo?=
 =?us-ascii?Q?eMpdRW2GI3l46K4u+q7zHD9XWCnTfjJveI7JAxjQpvSCTArXnKqwxAx0d861?=
 =?us-ascii?Q?JQ4sbNp2CBwvsGVZ8OBVrBgV7xy/3Vfws3OdsR4f6R22pqKCtAJLkW7kZXnP?=
 =?us-ascii?Q?vUeL8XowKh+jsgeRBLkPOU4WacLs1LK8NjMo2Ir4f9Fio5XUAQ6LqxMV1i1k?=
 =?us-ascii?Q?yu2Ytqa+gBinGIg3A+Qn7rdgsJ+s4ijoA7ci3+wXaDV7sQR1ufr1x84isRrr?=
 =?us-ascii?Q?yterCnwUxa/fTYc+K4CQgQdlWiZhf6AjQI+oYF10qk6zrPQoIbYkx7BziGTY?=
 =?us-ascii?Q?j1JmRQQh50zlfUhwI6MwXm8ZSEVl5AcmcAFJGECo4Ycob4Uwe28A4hSNwaRu?=
 =?us-ascii?Q?dwNAEW72yaohxJmCIymsaO3P2HLI9JKmczW62UxKoM9eFzeCGaAD8icZeTLM?=
 =?us-ascii?Q?8VCd+q+x33FVMHZlQJx1CylRig9pTIKNiWKd6EYkVppwwr0/kmUmRdlaNCbP?=
 =?us-ascii?Q?sn/lUXiGpm7BpdsolEU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:43:47.0693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d931789b-4200-4af4-6009-08de316e250d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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

Add device ID's for Kracken2e to enable
driver to support this device.

Signed-off-by: Vinay Govindaiah <vinay.govindaiah@amd.com>
---
 drivers/net/axgbe/axgbe_common.h |  2 ++
 drivers/net/axgbe/axgbe_ethdev.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_common.h
index 93e6c177b6..6e4e23027d 100644
--- a/drivers/net/axgbe/axgbe_common.h
+++ b/drivers/net/axgbe/axgbe_common.h
@@ -905,6 +905,8 @@
 #define PCS_V2_RV_WINDOW_SELECT		0x1064
 #define PCS_V2_YC_WINDOW_DEF		0x18060
 #define PCS_V2_YC_WINDOW_SELECT		0x18064
+#define PCS_KR_WINDOW_SELECT            0x8080
+#define PCS_KR_WINDOW_DEF               0x8060
 
 /* PCS register entry bit positions and sizes */
 #define PCS_V2_WINDOW_DEF_OFFSET_INDEX	6
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index cf3b0d9ef5..aa7d332b44 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -185,6 +185,7 @@ static const struct axgbe_xstats axgbe_xstats_strings[] = {
 
 #define	Fam17h	0x17
 #define	Fam19h	0x19
+#define	Fam1Ah	0x1A
 
 #define	CPUID_VENDOR_AuthenticAMD_ebx	0x68747541
 #define	CPUID_VENDOR_AuthenticAMD_ecx	0x444d4163
@@ -2291,6 +2292,21 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 			unknown_cpu = 1;
 		}
 		break;
+		case Fam1Ah:
+		/* V4000 (krackan2e) */
+		if (cpu_model == 0x68) {
+			pdata->xpcs_window_def_reg = PCS_KR_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_KR_WINDOW_SELECT;
+
+			/* V4000-Krkan2e devices do not need cdr workaround */
+			pdata->vdata->an_cdr_workaround = 0;
+
+			/* V4000-Krkan2e devices do not need rrc */
+			pdata->vdata->enable_rrc = 0;
+		} else {
+			unknown_cpu = 1;
+		}
+		break;
 		default:
 			unknown_cpu = 1;
 			break;
-- 
2.34.1

