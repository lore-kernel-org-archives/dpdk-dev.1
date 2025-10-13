Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A093CCD187
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 03:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49462402E0;
	Mon, 13 Oct 2025 05:16:44 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
 by mails.dpdk.org (Postfix) with ESMTP id 217864013F;
 Mon, 13 Oct 2025 05:16:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9OA9kk7sWUgMjG1O6M4cVXu/l8lDSgj0ECi7PO+qCxSSmzoolpgzGPEuNlVrhtzzbXbLJXhWAsvV6kMnIph3NM/aijgMU4mGN6opRgMWUWN5NomLoFRJ6HdRnLPaZcNNQW4T/VEyYLrB9Fj7+/9166QbFWVpw7327e7JyMWnYVzhUn8bTEl8UPW3a6gC9I6BwCJbP2Uh2agG8bRc8eWY6xubAwbmjvWiUVnDIHJqnW6wFl9t/Tctz9vf6oE4EgOifB8bkJhLyZRu+eEQIRXUfJJv38ogA76szH80ngOxYUvomJs2WgTjS48QN0YOPu8OCyZzOojKcRpiP1MFcqHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61ePjeTm2SLGOQYyI08knggKo3HfB1OIED1Ol53M9Hs=;
 b=YUcQKNI3+2QcmrBO//gDZH7q53qdYSji05BRw3IFEBzLQ9cvhM8eW1MTDv8YkXN9IQ8XBh2S9S6dU1vNd2IP8tTa6kKnGHHLG/r/t4F8AGpwPmKY2QPp2ci9VvWuyGjMoqzKaOSFcJuIVe8Jw3pfGLEC8Ns9x+FzPoLwpt4S0v8PwRre4+oDvcMC9utKBr0OeyPabDkfFVp0a2HUu0ApuT7bsE+lkPMW2KgqQQfO0GrgJ0+PsCPisSZP6GSobVeFT/KLBuGu+noRgcwWLHr71I8fry8/RLq0u7O+gqBGbiw5OMKZgE4uX0TNuh+wv+8X7Ta+4tSgeSiIeOzeEw3xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61ePjeTm2SLGOQYyI08knggKo3HfB1OIED1Ol53M9Hs=;
 b=LOoZ9RZWii0DuQEtve05qype+pQ7Fda5ziqdhYTpWOFFRVWR49KbDjBD1tAS/o7opjj+eLbEvnwgX2jKWISG9SySppepmGF2a14cHksnKPxJ8DCzq6lMNOOw+5AEZ+7BPpZuqOBLeCf3dVGzPm8TjvnLoEcdCqCkM+sby7fIOZc=
Received: from DM6PR08CA0055.namprd08.prod.outlook.com (2603:10b6:5:1e0::29)
 by BN7PPF862C85B20.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 03:16:37 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::fa) by DM6PR08CA0055.outlook.office365.com
 (2603:10b6:5:1e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 03:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 03:16:36 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Oct
 2025 20:16:35 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <david.hunt@intel.com>, <anatoly.burakov@intel.com>, <jerinj@marvell.com>, 
 <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <ferruh.yigit@amd.com>,
 <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] eal/x86: enable timeout in AMD power monitor
Date: Mon, 13 Oct 2025 03:16:19 +0000
Message-ID: <20251013031619.2988915-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|BN7PPF862C85B20:EE_
X-MS-Office365-Filtering-Correlation-Id: a1242498-b538-4344-1f53-08de0a06eb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nbF+TOraN70d3W/VLVlqAgjfjcOFXG3ca+GR3KZJC5d3Pt1tBVGM2o9wWYXI?=
 =?us-ascii?Q?+2zDAxjocsTrrxIodHAKsHKTkej9CtZq+cytZ1N6OfkE9h6taTu0KGcWSeYD?=
 =?us-ascii?Q?qv69OI11gN+LNghdg0jMqcRpCwCZ/ePyERavbCz3wTEvADahBBWzPXN5ljLa?=
 =?us-ascii?Q?/VYKnwoEOVEtmaKTVm/rWACOroBoKq+Jdh2coeSZnLK3SwjJziV5HHt2f0i9?=
 =?us-ascii?Q?asDGRsG9lYqTOqnoqhDT6fxd/PJ4H8RD6yBu4CQEWFBTP5fm7i/Z8onhsKAN?=
 =?us-ascii?Q?3I7PNfElYfp1tYf5+0s0mpHvYlpXTz2gt81z9TWao1hIqDad782gDlpOnuGE?=
 =?us-ascii?Q?k1AAdCPGaPg8g5r82rpNnRKmQZO+wkUX7yzUYSdP5UXE/lM/WHjf0b/3GHpP?=
 =?us-ascii?Q?PnX0nGc3QaWCLmnzO5CWnO0gO2P/77DuPISKhP3zt77ceGsQQX3ACoCpjlUi?=
 =?us-ascii?Q?xN4RiSbBWkxhwBs8TZyVrO59dm0J/ONCrfeNG03hDfifVVjVQhZu30NagQqA?=
 =?us-ascii?Q?0P9c5t/W41xxhO7r7MoOrEm/uLsDayqeUgfaIDVaSKDO0swlhiJ8EaGqN9Uw?=
 =?us-ascii?Q?uMVI1g/X8W7kLLGDY4K4YzcvpxE/YKUI/gcqWDht9Uc0BMhfImaKDfKQNtbn?=
 =?us-ascii?Q?4ElLYVtXHo3dXOgIUNCcMdeHUNPfu4biaHpmIefwZvJ8ScjpEUKYnzlx5dIl?=
 =?us-ascii?Q?yvEyttILFx8mGyeQVhFONg9hMOzMzwcfaBZuTfX99Va0+NByJr7sgLQGIAQ7?=
 =?us-ascii?Q?lPn4BMjZ1qmAqE0xd9E7ctMDZSGLJYbYn8E2ADMcWXp9bWfJM3qlkczxY5aY?=
 =?us-ascii?Q?evD8SrwIZqPOh4lqyivyMK9TcegBOes1xr/o/MQGdNaqxtQmxIdB+cwd/j+b?=
 =?us-ascii?Q?kM7dvtCpveCw/HZr1BCll1F4ImeNGPa3hY1bKVCeJ/qkRs21gvgtKMU0lBwy?=
 =?us-ascii?Q?OiXwXynxzDCppVeb0Xak0Ht6LPG9F4rkTj5vW3vLQVGnxoaq3pDTWTPeigYs?=
 =?us-ascii?Q?RmrpteG/PJo0alMc+d3i2ZnIZIlp3ouEeo2aGvOIbapnZZbP9hgHbb/2zXPw?=
 =?us-ascii?Q?uU09cXpZ7H3J7anfOzhZILKJEYaMlSfJwgcbpR2Ja6Cnvw4j/bfgCvFnjyBK?=
 =?us-ascii?Q?OiJlw2Kf//l46w0wIDN6Pi2dcG1F0NOemEhJfKBu0CTGsJLBrWrvTmSJ9wm6?=
 =?us-ascii?Q?gIS9lrgT9Sq/gdZBPdtkWIg5/0IL4n9wGgvMIQ0ymoc69xVGSgt+iymA+hZv?=
 =?us-ascii?Q?36CfOc872bEKjCXOeM1znx8fGML42kkmfAb2mxj1h4M68GxzxOPru4v4jKEK?=
 =?us-ascii?Q?o9mmlHaa6YSduLgm096tTR9dZ8beLhiaQdas/dOY0dY1RYtkm0E3WhlbKwoP?=
 =?us-ascii?Q?kf46pdw9sDiXX0rLq8bV3MNgAhbFbgjyrn/XDxLfuD5JDdk5dB/WcbJ92An/?=
 =?us-ascii?Q?gU5tfOw14fCWhywQUbtHdDBIZFs/xGwsk8Qlujareeu0NhpsyDuniKvBI6Su?=
 =?us-ascii?Q?fu7EkBsQLN7TYMj5A3GqwWP4Sl+cBV29Rfhl+UlR7MgI/pqrBW2NvIDWdX1k?=
 =?us-ascii?Q?7APAO3hvbYswoYcaQjk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 03:16:36.5387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1242498-b538-4344-1f53-08de0a06eb41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
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
---
 lib/eal/x86/rte_power_intrinsics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/eal/x86/rte_power_intrinsics.c b/lib/eal/x86/rte_power_intrinsics.c
index 489ad3983f..010254548d 100644
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
+			: "b"((uint32_t)timeout),
+			"c"(2)); /* enable time-out */
 #endif
 }
 
-- 
2.43.0

