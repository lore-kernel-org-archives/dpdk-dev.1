Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2435FFCEE8A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 11:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22DC54021E;
	Wed, 25 Feb 2026 12:42:06 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by mails.dpdk.org (Postfix) with ESMTP id 71061400D6;
 Wed, 25 Feb 2026 12:42:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S73TgAI6CLdWQouIu9I32A8/5y/s1pwSZlaSIr6ftfbjH1ezSqsGAx6yHY0BwB01OoGb3m3mGTDz+DhSSjW2/YggoTXRDmwNQZp6rowyhakWGBSvlkq0oriJyPubLmz/DkH89OyJdY9y3/lB9BWw4XukQ6/T10M4VJPml4rd4uFKp57YQc+BSxqodFThrUkPwROp27SjDoexPNAabmFFDe/N9QrDZ4NSXlZKL0wSRuNSjFWVJ36R0/o/Xk7YjLToduZB+SYMCI599BPaWVHedGsu0H2/fhe2tK7f0+9lQ96R7l4vgtZ/Ulw/IqR1arKyRL5dzKkPLfoM8Mz1GHMQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8R+nil6KN0xEKlefUj/+S7/o5CWhrSqK+0/BFxVmF8=;
 b=BgY5ClpXAZt6dlk43mPpanA6Pukdy0vP30DvvVjRrC6vka5EruUx+WlchPco0uC1pb8zsFllswfyuTw5y8Cfy8lZfKfMTSqs2835EnHerrDKMT0Q1iFA0KB/S01czasDsG0V9Jt4cwv6YjI38Ps8MzX4gC1xv2Qn8vlB3NJT6zf0kUgCh3a2eBw2BrVm4DGu/zNA8uQqb3cuk0TFEcpBu7gkYc5vjoGEUtw+omgIf2MDsthw7g6sES8Pb7k5O4vaxvIEY2y+QH0TbOhRqxANftX7WH4Tlo7yAAGpv8u2ZxJwtF6sBdropCCobmNKv25V6gkhXCAXy0vbVle8JlQxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8R+nil6KN0xEKlefUj/+S7/o5CWhrSqK+0/BFxVmF8=;
 b=kkyCHq2aiueZ//tnyXqqb7odoG6vfdss1H86Ke3lMiCbndLWjJCidCFCsVMesqnkUqNa/s1mf4rYA9aiEJ6CHh63Yummd+lDVU10iAyMY6oalzi9wzx6eq99gkuvusn9IKlue+474sbAzeaBSVn/LlB/kSwwi+LxicTWsfpftOo=
Received: from BL1PR13CA0290.namprd13.prod.outlook.com (2603:10b6:208:2bc::25)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 25 Feb
 2026 11:42:00 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::db) by BL1PR13CA0290.outlook.office365.com
 (2603:10b6:208:2bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 11:41:59 +0000
Received: from BLRVIVARGHE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 05:41:57 -0600
From: Vipin Varghese <vipin.varghese@amd.com>
To: <dev@dpdk.org>, <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>
CC: <stable@dpdk.org>, <cheng1.jiang@intel.com>
Subject: [PATCH] app/dma-perf: fixes buffer overflow error
Date: Wed, 25 Feb 2026 17:11:20 +0530
Message-ID: <20260225114120.2036-1-vipin.varghese@amd.com>
X-Mailer: git-send-email 2.47.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: a8adc3cc-5684-4058-3272-08de7462e32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: bJv977f9OvswpDlmDuNnfqgKrXSlsWQM4hVv4ZQ/IGr7SyeohT9c8zI1X54CnR7dwrWNvwWI100tMZOA38NakQSAXMPYJDO63/s1YWwx8CZcA5Fi7KkDLkVkbtGY2cQ2NDWv8NkNifB/8a1ENLsG5NucpNh4wiInPVeRHYFNE0oE79o0Dc7Knm/FhXpVQ8d7LPnU8BXymO+AssJto7XoxK4J+ZV8ZmW9QknOBRct8vDbZ9H5VLzul1rBy3vIeQEH6BZfjBn6dxDVsqDmT/ud0nCAywf7QZaiC+BRVtsLt0MClCaGvSuArR1JhpFqwIPHhLEtOWEYOjA3FcEH895Es2fCKs7/1qq166StOneCMrVHivwsQdknexqESWcUbUz4YQJu/G7L6G5OedHCjvbBUkLH6aQC9slVbAWuHp/sgcRJZBGFKw76R1dgptn2f6AZvIb8V73uG00rXOk6ECeIIP5qMITGHMuPSkfvZImaKLASyN7NmiR+YwDtzCxjOWBCwO5LbtJBdJSl4opOqTSmSr6mFr2zPKvQm31vo3GYe11BLfdFHkewqB7lzSulKfJbH9/60O6/WiDb5AO51KXksABzHPx66kcnJWJ/bI2EpB1THTfUFr5cPRN02lONXifI/d3Mejac9nbt7Ev9B/Nu4UGpKFAWDLW61TUGbMSfjgU8yE94w6IR9VSTxOpcA3HeMNTEdJIvjPbHDhHxHAk0NDAA1nkqEcpTlF3wChcsArGjJJiXz5MZ0qOqzLSsaWY8vmPymCwUglCsKpsIl/0F9vbX52wqPsPRWnwRVwMlUYuPxzoeYHZeE461Es/uhtwE+CBsf7AGO3CYsL5FCBvtxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9ioROlRNRH+/qjVgEj6AFKyHakwWT+p4PtrscDaOZmqGC1oiWZyu+nfnqUrnBQNQGg53etTSQX3mwHCKiuZ5HbMYrtyzqZe0a8Dj+aNxJQYZybbUqSmu8dHrWZfCdMTE/yZP8Gklw5FKBB3KZPh6ToOQCAlAex5ASfJ+6umT029KaY0M201U/zZmKFKcGo4oKCdHszdFXuvKnYQ3upuBLqi2zY80wIw8dW335Bs/5RqFykKtQsZq0U9RFV7J6pz48zrDPv/Bq00vfkGaiJbvwKf9MraGfZgLkadurX67PLLahwPzrMJ5NVH5gas+bdIaoKomieTKFraOp4XI1Ymx0dQFbS1biOFTSsoyHQTySogalWQoVY6hxEu0Kn3frkbyvRiNutUMUs0GkxqqyMNYoONFlj8i18cGaBEaJCv2mx3a+jba/5aSKxQUiod/CSmr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:41:59.9620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8adc3cc-5684-4058-3272-08de7462e32b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
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

test-dma-perf limits the number of worker thread to 128.
The current change accomadates to RTE_MAX_LCORES. This allows
high core density platforms to run the test on `(RTE_MAX_LCORE - 1)`

Without the change we encounter `buffer overflow detected, terminated`.

Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
Cc: cheng1.jiang@intel.com
Cc: stable@dpdk.org
Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
---
---
 app/test-dma-perf/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-dma-perf/main.h b/app/test-dma-perf/main.h
index 25f32b72f7..a383ac0bb3 100644
--- a/app/test-dma-perf/main.h
+++ b/app/test-dma-perf/main.h
@@ -10,7 +10,7 @@
 #include <rte_cycles.h>
 #include <rte_dev.h>
 
-#define MAX_WORKER_NB 128
+#define MAX_WORKER_NB RTE_MAX_LCORE
 
 enum {
 	TEST_TYPE_NONE = 0,
-- 
2.43.0

