Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0745CFD376
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 07:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A44D40268;
	Tue,  2 Dec 2025 08:12:17 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by mails.dpdk.org (Postfix) with ESMTP id 7A620400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 08:12:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqccdM+99vwpSS5tkQ5LI8CfLc6stjQ+bmyqJe8kV/cmZlFQSPFqudU3Eew8nuTzm2IMGnh6PGpTjsZVBe4H/EGPQdBe6CHNMleBC5wZg6orHufdydfP5UkwY9T+IoD4lYmP24o5ARQdS1EGGxFPMef/eCzjBxL8qDnhzUd3A63IWEPbvkVAMR0I4L/v6Br9r7tt8PhD7VHFFmZnWfZphLnjfEt+e6mrNTHW6uh6WkPcZdcjykKaYKxKa6k4eZ2DyXfTNHpmcjfCC4vJGprqPeeGoO4L1eoj7CCDxbi2GcDdwQPBjhGX77+g4HWU4yZUGdNbljXyJ39xct6+0h+Sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCkQAWSEr6NHIvXldtQQ3rAQcFGpuR4q4WroKDBAmeI=;
 b=QtKr5dxfns4ypVZuSCCcdzyXu5I3CfmJs9+oBOX3VDweaQxGs1i/5Fll7WTpu/bIscTJK5TeoxtJqyCuOgq93SPBb8ZlY25NINw0pW/hkWIo9OVO9Is01K/JWtL+6QVGwuOlNrJpaoue9Xouv2ud+SNmRvf67iU6g0YgCKcbjSc+nYellP8OIlx5d4iqDRO2uKHa5eAoCX/B5iTd9bPH67zUYe75gSCxxbAhjCfx4JBhII39ym8g1LtHJZv3v95hjC0O0KAhEcrv/OZ//3eIaCaIPkgh7bhzyy/QICZ1a6YPeh3VurnHBZFqBV4iFf9F6TXWMt+MW4AGFxIr7BdR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCkQAWSEr6NHIvXldtQQ3rAQcFGpuR4q4WroKDBAmeI=;
 b=mMLW8jDEZLV1MjfWEsdMxJ/Io30RMBl+Y4cg2Vx485vNrzzsmmSASZcCwispclrFDIX+CRzqayFRRNJ9qK8RcshpYBfXIVlqkiQPnCO3t4HDj8vBFdY4VT3ThgThKtoSFqJltcJs8Wq2bilCUiiEfQu/3TOv7n1KrkWjvXWdmlQ=
Received: from BL0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:207:3c::35)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:12:12 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::e8) by BL0PR02CA0022.outlook.office365.com
 (2603:10b6:207:3c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 07:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 07:12:12 +0000
Received: from cae-Wallaby.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 01:12:10 -0600
From: Vinay Govindaiah <vigovind@amd.com>
To: <dev@dpdk.org>
CC: <selwin.sebastian@amd.com>, Vinay Govindaiah <vigovind@amd.com>
Subject: [PATCH] net/axgbe: add support for V4000 Kracken2e
Date: Tue, 2 Dec 2025 12:41:52 +0530
Message-ID: <20251202071152.317942-1-vigovind@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: f17958b5-9546-4b81-9e05-08de31721d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pw0rGuG15nECnIsBhR5u1BVRtEfz4AzRv5SS5P48piyKHevdUoeD5zrBm6Wi?=
 =?us-ascii?Q?c09OIu/BpAGPznoWvEbAaws4Vuj6c1kX6Gxccen9OKMeJaI/Lr7j4OGUQTbV?=
 =?us-ascii?Q?9KB0o4uFiIS8HLjqbyoqfxg+iPpTyHofW2yzN9vZ3NRz6y8fBzjR3+5PpYFz?=
 =?us-ascii?Q?XIECSHGL8TaIN4+U4/IIs9L6dtsj9cG9cN0+ysXIgPtfaaDlX2lExQN6v1i3?=
 =?us-ascii?Q?SQAy1fhCKMULuVf139TKzZPVwOgEyV72D3zgb0vPR3NPXYHRlIQP+rrQtzm/?=
 =?us-ascii?Q?VhjGqn3Pin+Eg0YrsYqrWLSg+FjDD0Lk9Vqci90JVGFZmEE60fTtppkPQhct?=
 =?us-ascii?Q?SpMA0TXO+JkZStZv3zQvqdgssHbrCmga4sCII0Lsiy5+WByvdo8gZ1WekY6I?=
 =?us-ascii?Q?C475tqx0JyTfTsrvzsOnQx/vvdVmjmZK4dnFskGRmCspniW5MHMRP0qPjpK3?=
 =?us-ascii?Q?K6jA2qXtGTgRBt0hmRB/ZQCw0qFjAmwPkG29E+nDQ5htDHZMJ9XtPB89HzyI?=
 =?us-ascii?Q?vY2cEi1ANmOkOWw9DpjqARrwcSamLEjhLuj4QcJoUZhv1ZA03+X7yy4TB5BP?=
 =?us-ascii?Q?mND1oDVqqdyRDu84UwF3cACmvIi7eVw0pV4qzvfTagIKB9vzoNpqEAQyd16q?=
 =?us-ascii?Q?SB4NXDlJBworOpApWlDBC49YelnvaENWR9oLn5vamZMMV0VfNsYif6ckPpwb?=
 =?us-ascii?Q?LblsU76GPSiiXK67ZHTryaWaJWjJp+UXsdD4EFIwZqxvl59/AC4zvv1ApxOv?=
 =?us-ascii?Q?vt7PShQYzppSz1dyc61W1fF18TGwRL0/lxohGfTSQznR5vHPGkQsqXGW2fC5?=
 =?us-ascii?Q?qgaZwLYTBoeb6PYN0ugogJru6Sr19lLs08kkfHaSJxlaWpDM+GiFKBB5Qn1x?=
 =?us-ascii?Q?N+UzHF9D8CcrPsr39vBJPeYTCpzHjVy3K12FC2nbz3ZQ2fqvZiVUJPJ5p3rY?=
 =?us-ascii?Q?aVci5JgGsvnO/K8AacWxOnbSI8yGniEZy3p+geeCJWgY8yASmd1qLjUWobkZ?=
 =?us-ascii?Q?dFx1WW2b63JufPAoBSXDuuU812pbNtGKLhopD6T+oWPwW7a20HqEUot3563s?=
 =?us-ascii?Q?wnBkvj4vzvhZ3he53zQW1FFQb+yHg/VxhTepelCEA+icfPg71PTUb4sUtRqb?=
 =?us-ascii?Q?MpKxs3safbLaTrR8UQzh23MHCcyOZdosQ8Bl+Wb02XwhgPaF06vooyRZ4oXg?=
 =?us-ascii?Q?KSFqGJkKPhPDnRoVXERmYjcxLPWOm4Lr9JLMr/jiJvIoFOLm8cwMI53RcYng?=
 =?us-ascii?Q?qdmivR4XZu9o0OtNFLG4pvGOH7XzXK0ze+eHL3c1RIFL1pl56OY9jVVQEnq2?=
 =?us-ascii?Q?7+s4lOsBNTKnP2uHKq528E9r+kM5g7yuwXvnWm3WFQ8IAL6XnoyTQuPEJ004?=
 =?us-ascii?Q?uggg8duON7aOtPOB39RL3HkCOqszujI2AXj2RMsHO3xSqq64z/5kAfwmw1nM?=
 =?us-ascii?Q?cGbaS8Kg6yhmXC6G1CEFmNuclLuh28ViQcxaXAGSOoSsURfSmbw8xUBZgXen?=
 =?us-ascii?Q?eCYXaz22l5c7RvtEev3QS4eUiOjmStghlWLdZVR3AHWz0JCVElo9hZ1NVc51?=
 =?us-ascii?Q?NboZBlJFkJewra4TiAE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:12:12.2779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17958b5-9546-4b81-9e05-08de31721d71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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

add device ID's for Kracken2e to enable
driver to support this device.

Signed-off-by: Vinay Govindaiah <vigovind@amd.com>
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

