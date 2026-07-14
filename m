Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D0C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 07:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEEBA4028A;
	Tue, 14 Jul 2026 09:50:23 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by mails.dpdk.org (Postfix) with ESMTP id 0E6D240289
 for <dev@dpdk.org>; Tue, 14 Jul 2026 09:50:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVoSTEj0ds4Lx9r/1p4P5QIP93Nr9vaDWhjB8u/LHEG2Qx/H+UFSAdy9F7+qaukm2dqcD/igQba82BTlEVDOESsyuivkFMvRseH8rkGx00n0M5czZ7LEtMj8O4VHLBOalI48KFt9zl9OiByKygxuGh7x5wjXdzNexq3NdqJ02Owz61ygOGqBOxl86TXtpG6P5GolCmp2dXc20zrW7LCEOlvcykMPXurwAn5LKrSTsGHUmLfBADyUdmdJpPPuB00mpdUCGac8ViuWKYs8a+J/Ce3HTg5/RaDc9BcRVmByARgLs4aWvv9MpLf4mjGXG2t5Iz0BDAEH01kGVET6GZFvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHbwOfNXJCKG6Mfzy362xzsog9q1INpuohyICAhrpJY=;
 b=bA7h/7P3d3/IvO4MPRhGc/6SCr48O8mO0Q5fbrg+B+IboxmzZ1xirtNT2kzSEP+koaqYOHd0ys4KkpHMSn3H+ZK5lBkPFFHcaZTXbyO10uB+yNFIkg/6eOmhnWGvgo3q6vgLFWztR5Jgb6X03Njf+tPtTGRG305Fouor0GzRWJqqF3nWsInMWb4ZxYaILVRZQsA2IzvgMjpjj9gjZz1p9q5AI8T+G7EoyoTVL4EnbSb8YVZdfDKoTZZakMztFDgpBReu7O3r1Qg2UQZsYicb9a2+kujjiz9ZYp8bOz5V7XeE8TMkhat16dt5SG7z2eizxqsNR4t7Th/0AS9dIuxOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHbwOfNXJCKG6Mfzy362xzsog9q1INpuohyICAhrpJY=;
 b=U/QTFjAKPGnyL0ljtEXXrvpDbM0DkddcFSwuvdQPCwBk1gdedNJEHux8A9uB3ahOoV8eeQLdtUuvBV+C7tk58KPVv1j2MlqaJBSZL36hVjfzGD5fGBd+8lnAbL4HN+scfBpiiOVyQFeWmo4HvhQiQXRdtmZzu3BGcdQDmYzkjcA=
Received: from CH0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:610:b2::29)
 by DSVPR12MB999191.namprd12.prod.outlook.com (2603:10b6:8:496::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 14 Jul
 2026 07:50:16 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::81) by CH0PR13CA0054.outlook.office365.com
 (2603:10b6:610:b2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 07:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Tue, 14 Jul 2026 07:50:16 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 02:50:09 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, Bruce Richardson <bruce.richardson@intel.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, David Marchand <david.marchand@redhat.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH] dmadev: clarify last_idx documentation for completion APIs
Date: Tue, 14 Jul 2026 13:19:54 +0530
Message-ID: <20260714074954.3412248-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DSVPR12MB999191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f24250c-1ae5-419c-420d-08dee17c8b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bfte8Dp8G0jqYT692FdPJp9+v5riqqx0vBU9IE0jX+CWZo/q8qEoEqYhF+RaVnd2k7T7EcwxLXdJ2a/ygTsWCduKTnpggPBEswWegmQ10tK1QAjegd3e6G6AXRpiWsmbxlRE52ODfQhIimolx1cgj/pXqe0zdm4h7sCUux3lXsWkr90yVeV3aPxPX/fAdU5HbL7M6xpknAlXaS2+wTjukeoFBSGsNKdFNmrSTqTkLsUVxYZjt6bV9uxfU6ddBWMcLjI7NM6ZhFt3MvogSrdn7ODHDFRnIZFKST3LgXSZgmV0FMfKKUWKLPYhjc5q9xcLzzBq3Cqvq3/bjoRQJ3OIvglIKKnp1fnap/CYWNPN4KtsPScam1QmioV+rOAG0YSu7YWHDmkEx+V61Qcx9sZ0+lM7/eHdZkP5eGXH2bOP7lA9C6T4gy/bGIKPGy0UBRuBNyPd080lhqhrzPKmXzirZSTDWg+musF4IaY5c2I42HkQqHukyCSq3NQns/xjm7yS2SpvHwpDsqGby0lOElq/8MT0fzjWBfKSmZ/NFTw0YE1PiaP/+b77OHDn3YheOB1I/NsVOlPIGUdTzjXEsSy6kYW1sqGlFVVXYQ+fPl5mETjKNTzI9v97PGbtGWOdtAgU5/vIXOfAtNcRZxlkbO7Ptyt0G8FaVQ9D7TGvJJHIeVVT/Q9+CEybwv4/ARABU18Peshk59zXqJcmDBNcTNPVgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BJ9UqMcRMbQSKz+oNuZOKN2DVQu+X880/U7Vr4hIcJZBIRuuy1apAiIj8FWBcD/1rZSrZ9yDZvTaeJZKQASr5XakBhrmTECmDUWcl7uFCQzjduBgdUiCRLqwWi7mKJkmmR1feUvOi1n8BuJNyodz9eZp3bkaUerED+2EV4F4N+Z+chVcIjai0QkViBlv4XhqzQN8jW0msAsN5+tN4Snx0D+5OfYXb1WChyNsnAqqtHH9nvWPBu35OIuKubC3oSaDiDJn9szbXvf12XebmJuwr1HdbCf0Z1wXzdQO+AJv+zsN7xqiAxe8wt6x+iokFzjGi5ldWdSeGiWv+J9ZeUjpXCqe+eu/TdqctAbzB9SYq0gxZIvNtPqGNRlVYLiWhsHWyiJgi+yYus7KrltLu2ghNcnctZNRae3TloK1tJ5j63ycoeg3GJDwS4X86K7CIvFV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:50:16.4019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f24250c-1ae5-419c-420d-08dee17c8b6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999191
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

The last_idx output parameter was documented identically for
rte_dma_completed() and rte_dma_completed_status(), even though the two
APIs have different semantics:

- rte_dma_completed() only reports operations that completed
  successfully and stops at the first error, so its last_idx is the
  ring_idx of the last successfully completed operation.
- rte_dma_completed_status() reports all completed operations regardless
  of status, so its last_idx is the last completed operation's ring_idx
  irrespective of success or failure.

Clarify both descriptions to remove the ambiguity.

Fixes: 91e581e5c924 ("dmadev: add data plane API")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 lib/dmadev/rte_dmadev.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 81dfe187e2..394ee8bfdc 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -1338,7 +1338,7 @@ rte_dma_submit(int16_t dev_id, uint16_t vchan)
  * @param nb_cpls
  *   The maximum number of completed operations that can be processed.
  * @param[out] last_idx
- *   The last completed operation's ring_idx.
+ *   The last successfully completed operation's ring_idx.
  *   If not required, NULL can be passed in.
  * @param[out] has_error
  *   Indicates if there are transfer error.
@@ -1397,7 +1397,8 @@ rte_dma_completed(int16_t dev_id, uint16_t vchan, const uint16_t nb_cpls,
  * @param nb_cpls
  *   Indicates the size of status array.
  * @param[out] last_idx
- *   The last completed operation's ring_idx.
+ *   The last completed operation's ring_idx, regardless of whether it
+ *   completed successfully or with an error.
  *   If not required, NULL can be passed in.
  * @param[out] status
  *   This is a pointer to an array of length 'nb_cpls' that holds the completion
-- 
2.34.1

