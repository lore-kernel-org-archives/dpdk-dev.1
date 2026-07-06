Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80038C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:56:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F56C40A72;
	Mon,  6 Jul 2026 13:56:25 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66]) by mails.dpdk.org (Postfix) with ESMTP id 4AD9140A72
 for <dev@dpdk.org>; Mon,  6 Jul 2026 13:56:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNwwOz9fmuF+nDLC7gCMQBHPDjyd/PCWMWMHuBtbGYYQ/Cf+FcYaU5lOJD+u/afspegoNLwvKz/GKS5baasmowMvgjuRFFeQOZ06/qGqax3kK5GXPRviKuPkk9LVbmmRfMwk2GI+NdOGhFTixKvULuStQ9VBMr1QgtuaqaDrPk5WM/ChOXrox79nt6SlbQazU0nT7lFTWMoAAuZ64+XCLONUn1Dtvyhz5NrBf9uP42WwhjLHs7LCIsy7aiqUvWPYw9KZiALB/Uzwq+iTnphezZKPw/juY0XQjsUHEHdev7FRR2czpS940SpCU6TR6+wWIUp8mReaXuOTdvkRcQw3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qH5fgGflH6mo7Ne9ru+HUdSvC+oeSz3wLVEjeW8RSM=;
 b=jIEumIR3c5eAYHUOHXToXb0mhGjKWtd4Dv2sDgyL5VxQwlls1BTG+fPja3KAAJUFY+yn5m9KjYRZkPDCDihGmuLt0HaB9A3mxa1omI96FNYpgcNW6RWhxu84mDEu35+gMi7+2+JrNh3AbhuKzBcfPXT+TdRBMGKscjbqT9ppTrQCriDbUaUOIlxQR8YBacdu9t7whdpgdS58Bf9S5Sr98wbzPS4qle+0UqTff0dahJzTW9v53eaV4WSDJ13LIC82I82spXUnu6oYkopSEg2Loh73/QVkocWzMNegEgmxn5r7AcT77WRVIcpHLjQPOPRSVow4T0ooi46CiPpc0j5vuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qH5fgGflH6mo7Ne9ru+HUdSvC+oeSz3wLVEjeW8RSM=;
 b=ZAPWhhVltSipqARp2lp915cEKDOgeT/PnNPNyP6WMP4Y6EE0mBZdRekqmFSoPjx3tmdkpe46NOtcW3LwXuDf9SPtqf1hLuhDEsZ08/8aslKjrhyIHS3JiAPbWtSanKgSpY+lEHz5+Wp4FD6GnUfw21U4gVCWN7iyZL2WY73gYtc=
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 11:56:19 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::29) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 11:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 11:56:19 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 06:56:16 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v4 4/4] test/dma: skip instance suite on low burst capacity
Date: Mon, 6 Jul 2026 17:25:33 +0530
Message-ID: <20260706115533.2937512-5-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706115533.2937512-1-raghavendra.ningoji@amd.com>
References: <20260706115533.2937512-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8b5f43-c87b-4cd3-e719-08dedb55979e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uv0JgkqHrse3+aII8LiFjGsFL07UzT+13uh+rtapxMTYFWrTAKs/6nGIVZ2kWLZIazPNisEl9dKErY9cgf/mpAJpTWrQzMzMExBdgB34Ab1oziX/bEXIxxRiCCH74rrig+Tmjg/rxqg1gEB6FJZSUhk3jdRatG6VbDv1pcNogofV7S96yfZ1t8KArIVNnbzDhvCxXzQvzjBmiR3nHifgXIcu3QRIoCnYYSiEuG4H2C5vX6OriTho6/INk5LHojESMVucNqADB+EyfhUO08UD7fs4cO+98lrqb5hm2/Mw8wDTCt8SotdLm1D9AycEFRGWHV4mHtIPBUKv8zd+1l0ekU5gAzDTrCMlVp2rkiRJ2EJ54FsdLlKLZ/ZOo7dJxEz7O9BlIFWVR6Je83Gpvx51uVree+Bq+wIH0PO0IdUvaSsgzfzQsyT0kjopNfWvHLwIG57pCnhauYJRFtwq+jfgBMg3CJRd+RIbnya6L/laCX7/5sXB3akAiZiiblK2D8GqV9vvRsjcmCL03Pf/p7j6H+fzJntaLqXuZh8zTwC7wP3pZCSN8CgZnXC4t0UkZQFfdavxD778+HKLkbx0x4UiNeLt7hcVGpVeEM2zHvFSFB64d4N3n/Kn+NX990bpAJZbDIyywtxQA7ELp4VldcsoVk6vIA8YJ7BUO0fPwp4QVAG2VwaQbD+wOe+PoC7ZHOKt/qc09k1iTp4Ho6eagOhj0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y18sB92dXBlNZHaUk3laO04pI3JeLv5ga/pqJIltQYrfBM+lOdTi4CqBtzB2ir+GtucpmUQV42K0Dap/ifzX27ZyX6JXmxDdytQ+nmBg3oWu8AoYgiIZnRdy8mn9AsuLWRAdJAhpA8QpZj10dAO2zTc0unXDieM2rZbr43ZY0yC+7uHh2yz2ggbWx+DATwGyodwMnqC4J5lJ2fMp3nyyZb7udoawB5GqTaoAg69Ru5o3kmXxCVuMws1P/8sRNo9OBpZ4J4R5LU1HHAJArdEOoDMdcA02M7m3/HV2i2kSqKCaoIisecp2mv8/+cJn2nSfLREi9xJ2pXcdh5KNtUdBCRm4YlQLzcBsW8szwwF0JiJ+oLQEPnr6few6jT6lxYlI0FTZlZeaosYKAt6P0BZfW97l5W5/7hKDSLNKLOxImuumm9JcCXlugpWUkto4HBkM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:56:19.4970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8b5f43-c87b-4cd3-e719-08dedb55979e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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

test_dmadev_setup() aborts the entire "DMA dev instance" test suite
with a hard failure when rte_dma_burst_capacity() reports fewer than
32 descriptors. Some DMA engines expose a small hardware ring; for
example a 32-entry ring that reserves one slot to distinguish a full
ring from an empty one leaves only 31 descriptors usable. Such a
device genuinely cannot run the instance tests, which enqueue 32-deep
bursts, but it should be reported as skipped rather than failed.

Return TEST_SKIPPED instead, matching test_dmadev_burst_setup() which
already skips (rather than fails) when the capacity is below 64.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 app/test/test_dmadev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 5488a1af33..1cfa8c1e10 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -1397,8 +1397,12 @@ test_dmadev_setup(void)
 	if (rte_dma_stats_get(dev_id, vchan, &stats) != 0)
 		ERR_RETURN("Error with rte_dma_stats_get()\n");
 
-	if (rte_dma_burst_capacity(dev_id, vchan) < 32)
-		ERR_RETURN("Error: Device does not have sufficient burst capacity to run tests");
+	if (rte_dma_burst_capacity(dev_id, vchan) < 32) {
+		RTE_LOG(ERR, USER1,
+			"DMA Dev %u: insufficient burst capacity (32 required), skipping tests\n",
+			dev_id);
+		return TEST_SKIPPED;
+	}
 
 	if (stats.completed != 0 || stats.submitted != 0 || stats.errors != 0)
 		ERR_RETURN("Error device stats are not all zero: completed = %"PRIu64", "
-- 
2.34.1
