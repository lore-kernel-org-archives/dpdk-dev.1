Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F16C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07B5340A7D;
	Fri, 10 Jul 2026 09:36:51 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6]) by mails.dpdk.org (Postfix) with ESMTP id 3446140A6C
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:36:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9LGFUSVK0esEptxKHp58l7Cz9cAsSCDeEhWBeBDjnjKZb//mlyTK1we006A/3QRAVGINtshN2f0v3NLS60/cqi+3zLp+NqwHwEhBdA5ggHvolVGvLqLe2ag5cyPQnJ9YZFhMowSU1oYa7NYPKkAbjj1PC5DaNWJOhQpiC+1BJ89m3LpSxDL+XgBV1oeakktH6iuMT7Hd29v6EFdoXVNn+DVG7b/tYT108HIykv04BN5sulbArKl+2mTDlLJX5aQ62D7WmAt+ovRP80zedfZQksifMbM33Hab/Spi3uTaPo94FvS6r9cLNdXXYfCJIuNWmT2Rdbxza6RpHhmm/l7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qH5fgGflH6mo7Ne9ru+HUdSvC+oeSz3wLVEjeW8RSM=;
 b=par/wDN5xoysF9DaZtHOJgj2S68FkMNviTPEiYXFh0ho1t0/yVd1C07wQlNMcVlNBoFLGg5hvmKPJ462iuqKVgTyGvW59DlTs8u+hnBMR+k4PgaoaK6HViIuf+So+VnZhI1kPaj9vDRNbfu7aBwRUUp/FHke8P05aR/h5FS1OFOkngi4Y/LzIaSY+acrObavqc8U4Lp8D1ED8ReFjgBs+DJ8Z2L3UjxPF0bORM9mDIGILM9av1PfwXVUHCtGeZx3095oDx7/3ittC2HXt94YTrFV/f5QsI5SHGPk+wDRp1n0uatXpEIGR+CyoqbKAHNNUTbWcbvo8luvmBRuj30OOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qH5fgGflH6mo7Ne9ru+HUdSvC+oeSz3wLVEjeW8RSM=;
 b=dc+MOL4utbDNA6F9YiUdtfjAFH0G2u+mzGk57WBZm16sul2cUS9T4mCBjd62Gt7DANM7dxRoQ/QU12TJXxOF8n3zrTvlFUXk7dWh3QJhdIT7atx7tiiOoxIZMu+ykRwyxzL+1UeEEqWE/eDcE5aMkEW0DUQkwv002fWjCSO01sA=
Received: from BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::21)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 07:36:41 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::2e) by BL1P222CA0016.outlook.office365.com
 (2603:10b6:208:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Fri,
 10 Jul 2026 07:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:36:41 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:36:38 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v5 4/4] test/dma: skip instance suite on low burst capacity
Date: Fri, 10 Jul 2026 13:06:08 +0530
Message-ID: <20260710073608.3034898-5-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
References: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 4392b350-7716-4619-817d-08dede55fbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: YOXAgn/1CpAPexr4FmVI1svPiGSUb0xoIJQME8l3r+zQ+DxqwKdYsk2skJ8gI7rqxca38Fz0cFkguv/SAZ39ytCkO+NrxPoIyrYpmzr43JO8WCgIyC0wz9rUkVTgZInaXyXgxIPi3g9R23hbpH6t3diwEqXB0C7K/HEtGyCo89gxuSSjxPiMTPIxwPVO7PH/ElvxOV5hzwW1yt54utTSkidFFMzcgcVO7EMOHYysGTa0PwQLR5909ZkygUGtEPux1SA0wZ/5hi13l/ecK+dO6mr23UdJcQVp1kMclgXUFfsNuIhI63aEiRgm97JozUss/SyxOs/hkFXdL9vim4vYDnEEaSXm26hjKjKC/boit41QwcPTr2jKtFmqeaTOkXWSpgZkCpgYsFYtfRRKVo3Y0bpuDh7rP/MQgwRObPU7mvAWn3B39YnrfUs/oSN3L8TxkgrfudxycNp2mrb+EnQxMkTCSCrBSghg5yz3ewQH7BJ6y/EGfAVscSJX8vW4kpG25fA8MEbz3OM0XnY3v7EREQveHPbrounhKzpQ9U2ITaFTsjorpMipz39b7FQXLA0DFaVYNdnOdBGnmCA+jpPXP/Yj3vHX8kXn22qIQf/nN4sLtVRBr6Vq7ulrkw/rXQPo045iOgju/9AdpY79K4vQuSxx1wsSlCmXlVIK7m5seshZDPzN06FcQtmqiXCZJN0ZMHjq94EnUfCAH2h/3TqTJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F5ovIai7T7jDrnUbPk5rJgEalMNpBXnAYI1sJoc67UcKcYIvZLPkoY498ePmvD7dSEquOJSzYx65aQNFuz6f67GmASr6ACsnksANfue6piNKTJUQHhgtD4PCC4JA9xTBL/3+46uPI5xtfbTfZDbiwdJzMQCR4B0RHJqx5d8UVqucqfmn7mwgQ9OPXcqFSCanVdIBT8edrceZPHYEc5UPIwZ6Rd5+jo2w9Qu82tu5cmMsxeKF1L7Orx5FBzAXK0Po0tCdsMyiE/LC6mQmc/TlD2LjTtXb1XQXasDVUTqq4HqCvc7jP3haNR6Pislyg1Ks5PovjgkfEYy4O/lrt3BZKWx+rhrMvyxaZmpDU5/Ccd6AGS95635umpfYfPJGmLY7+h8s6PnJvzx55BIg89UHWDmYb1JM9T9iFmyg7C5y4c91+Bs+44Kn+j0DlgQetfGg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:36:41.0484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4392b350-7716-4619-817d-08dede55fbc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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

