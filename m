Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F71CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 05:52:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34FAE4021E;
	Mon, 13 Oct 2025 07:52:20 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by mails.dpdk.org (Postfix) with ESMTP id 531AE4013F;
 Mon, 13 Oct 2025 07:52:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqBe+o/ygzghCLXb5Hgjb8cwuR0V22g5GfXprACKmsNovsVb++znEUOSAjDmnNEo26Mqw9fXgAbSV5wPvCXpCeVwS2fOzZuRSvU95DEMkhV+BNv9kznIn2YC1z0TvwIfO5fBQKwIG4EtYil8LQFOGPweQDubPe/v1P5pqdexukOxmzYXWdIEgLSLKP+/zhet+58GfhEOiweW7mVLPyhw73Ntphzj3B5YMleIrWayswibAT9UWv33M8PzZkEY4cJx2CKkmn3Gyf3ijUOw0w+RdZ3rcwjIrcWQ7hjHUuf5VFAdmEWWDxW/kiZAw5dYEM5mhYyrFD9YodpmZSteVc6+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+o6d1N2I8+cw8fvHcr1vZDTFyR/rJkMnjDRLBlH/KPA=;
 b=C/iTJ0AqXL2plocCccpQ4R7aKBndPJYJveVYXKguOx5D6tspMZdxSdkhHr00f2d7NRp/icnlnim+pXkRP/x9ovtb9JuMVkRJJiv3trZeNmAKNj6vL9LG/I3JvLat8Vvams8qY5ejLw3JMc85qI/dHbM/iH+LjaVq88CyWjbrZGSbJDJU7lMZ1Qrt9Nz75IcDguGwRb/a2Kl+en6CxypEyfD6lDf5INjH8q4meCo9gxDylUwgT9Hc1koghpyoJIpOJy7Ost4EHEMU/M6K9aQ9oSCNLdx9CX9udYZp6wzqwdIRZleOqhneHKqLjMP5VAJGxcST+ImxXJV+/kM0g9BRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o6d1N2I8+cw8fvHcr1vZDTFyR/rJkMnjDRLBlH/KPA=;
 b=XwJVaf7u5NAMvcf+hUXlHTLuKDCEPxtdzJv7w3cA8Yv98J/5KxULNSYVRQbPl9cc7YHwlt+RN4m6KdsvDZTibcptRvMvW6jiNo4SYv31Is3hVuo0CMTVrMnGvPKPXlmEWOVu2Q5iAlTAUwRKvxhsDiVxuaaxcVm1z3wC1vGmYEU=
Received: from BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:52:15 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ac) by BL1P223CA0006.outlook.office365.com
 (2603:10b6:208:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 05:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 05:52:15 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Oct
 2025 22:52:14 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <david.hunt@intel.com>, <anatoly.burakov@intel.com>, <jerinj@marvell.com>, 
 <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <ferruh.yigit@amd.com>,
 <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2] eal/x86: enable timeout in AMD power monitor
Date: Mon, 13 Oct 2025 05:51:57 +0000
Message-ID: <20251013055158.3037400-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013031619.2988915-1-sivaprasad.tummala@amd.com>
References: <20251013031619.2988915-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: b34fdb36-9c99-406a-9c84-08de0a1ca994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6uD1L/94CKbk9fPEwKzKBwMdxdab0rsUP0q9hd3HK0BuMBIOPSgAvRQAGF4O?=
 =?us-ascii?Q?juapvknHvV/aoC6woKFoSe1cPwyiaQD8q0dAJO0HUP1KKt+7xdMg/MM+kC4f?=
 =?us-ascii?Q?FBXcUmjB3rcuECblZTzuhGXMzkJQlKNaHJWV1Dwhmn3GLyY9CVwQoXaFcKoV?=
 =?us-ascii?Q?GTxuEoEY6sKyPnDjMBXUBrCKPxpAJJ2y2Jc/eCChKn4AbL0QspFzkbRx0UUN?=
 =?us-ascii?Q?Ut59RC25rCFBZ5jGbctJhksTx+SNNNZSjId+fdYq4g+np98FdexF0dhcNrBp?=
 =?us-ascii?Q?CWU0xrEYgP6QLSG5em3GeTGIADb3ApH63IJz5YbYeQrdzdvLmizHN5uz1IBL?=
 =?us-ascii?Q?FnOUyRyy8cokKmH8FvBoakRoFZOptDAFl8tOXn/lNL47m5SM9Nglff4MDLri?=
 =?us-ascii?Q?RZatRnmMqLXMulODvr+aDetHqk9vaDfmYQbzwW2KNXPU/eZ1KuBKHN7rghEH?=
 =?us-ascii?Q?AQk2O15ukNv3aI5gLRB9c91WJkAzSc6qh3VCVcJeQyuVhcoaauEXRXjJrRcN?=
 =?us-ascii?Q?O2ohHWJrueaPTn27uPgecM4kY8HVpBwaRB8tBrM+oAFNWMsKzCQ1JXXYCvBw?=
 =?us-ascii?Q?bGhaUlVWO+ap6iH3sz+e7QeIojDsarINQ2RZB7RgkrZSHRvUkGNzAbIgD5PP?=
 =?us-ascii?Q?scfZYU0Azs3HBb+nceT44/NXHm0rzahMz6MBy6xD4l9p/rl50n83Kb6AJFWY?=
 =?us-ascii?Q?88U+a7II/pejFaVy0AzN0LvNF/GMVbkO0WBCGevZaDsYvGrL+kkjEm5LSpKf?=
 =?us-ascii?Q?/qATimFAvazSd6o61QPIkWManT/IboJnvGgQeB3G3ae+bzWir7phpFBEra+C?=
 =?us-ascii?Q?87x9RkpFS00nhFedoWNUZyVvRJPKHh7rIsgHnbnvS3OlnEAdwA2Px348i/k4?=
 =?us-ascii?Q?DYSEcb/NXznJAH9xTRFd3/Avofi87uFind15GI/ZII1MDciu09fMZwZYXal7?=
 =?us-ascii?Q?SdDO7CG2ncTLZ+wPn2AU596TJ9vNpd7ozefQkZy0AWOgMxmlyyJdHOtqZFVM?=
 =?us-ascii?Q?JEM+G6mlHSvVJaKyqqpVILogYASGkgIjnAKGiLGwpu9sewSUWfn5ldHyMIjr?=
 =?us-ascii?Q?MkETdJuu8VOUbs9AU3241pWT1hLg+IlM2UWQ2C2/SHDCAVrrgCarKPoXtbXG?=
 =?us-ascii?Q?HVPAsbh6rL+/z8L34E0hvn4LHneS6SlGSQvt8KWHMhUVJaM9z0pmA25vqRr3?=
 =?us-ascii?Q?lRqX7R2H5AfeKE9USMJduA+hVrpHaO5wdJx+ayl75OXOnVeduO/8q01vD0MR?=
 =?us-ascii?Q?w7zS+UPvlMAbKodbv3HsCepr6B5frJZNQBF2fsZZ6vKQnAK0Hr/pPX+yR/WL?=
 =?us-ascii?Q?KpgVXg4PmpyTPYWU9QyeelSIi+Y5xs/IzGR/v8tWM2llmpa02xb5+Ui5qiNK?=
 =?us-ascii?Q?gSz6Sb7lGq0TU6vtYfQ1oIAAy11BkCUG5TVVzLeSndxAlomO2P6BVZ6k5fzw?=
 =?us-ascii?Q?FLtD8HUuTdu2xgMP0NBuuStkKplvKMtbOx7lp9qVa5Peynh0PuvZi28CaPqK?=
 =?us-ascii?Q?QbwthESL2dMyZGdq5VHiCCiairxplgRW+HWRloy9cWREjp//aHSOr6Asillv?=
 =?us-ascii?Q?K62aUkVe+13zy7kJhqc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 05:52:15.3213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34fdb36-9c99-406a-9c84-08de0a1ca994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

Previously, the AMD power monitor implementation did not enable the
timeout, causing the lcore to remain in a wait state until an external
monitoring event occurred or an interrupt was received.

This patch enables the timeout-based exit condition, allowing
the lcore to automatically wake up after the specified period.
The maximum supported timeout value is 2^32 - 1.

Fixes: c7ed1ce04704 ("eal/x86: add power intrinsics for AMD")
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>

v2:
1. fixed asm compilation error.
---
 lib/eal/x86/rte_power_intrinsics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/eal/x86/rte_power_intrinsics.c b/lib/eal/x86/rte_power_intrinsics.c
index 489ad3983f..8a5f222aea 100644
--- a/lib/eal/x86/rte_power_intrinsics.c
+++ b/lib/eal/x86/rte_power_intrinsics.c
@@ -89,14 +89,14 @@ static void amd_monitorx(volatile void *addr)
 
 static void amd_mwaitx(const uint64_t timeout)
 {
-	RTE_SET_USED(timeout);
 #if defined(RTE_TOOLCHAIN_MSVC) || defined(__MWAITX__)
-	_mm_mwaitx(0, 0, 0);
+	_mm_mwaitx(2, 0, (uint32_t)timeout);
 #else
 	asm volatile(".byte 0x0f, 0x01, 0xfb;"
 			: /* ignore rflags */
 			: "a"(0), /* enter C1 */
-			"c"(0)); /* no time-out */
+			"b"((uint32_t)timeout),
+			"c"(2)); /* enable time-out */
 #endif
 }
 
-- 
2.43.0

