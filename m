Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4848EC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 06:31:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24F64402AC;
	Mon, 19 May 2025 08:31:21 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by mails.dpdk.org (Postfix) with ESMTP id C341740276;
 Mon, 19 May 2025 08:31:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+4kowUeQfTzP58V7937sUC2eci3u6YJNHf5tPdXw4IxFkL6fyGs7Kvhx4d3ZHbVQioweE2QJGgyzN5bxkdlkX6Ifau1307ygjiSrC5Dc0UR3zczmxfii2RWDO2LI2LMGZKZVbReKQw/uQFcX3DxHUqjZvITY3/sAErOb8gueHWG+WKr1ykZi+JrwAGrdhGJLRkj3blS8jnSb0ajjZwIIltyidpKo960qvmX0fznRvlj5aYRr9PBhs6jxhOWuqj18HCospKbdGPBnQxCFYmIDjKs5HAcBeE6TZth3irjF8nNmxW1CQnprrey9lckI86tVC+b3j6iq6Yn8/9kvleOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V0os3DizkDNLbbZiooriJjKc07+qyhQ2sqC3+piGSQ=;
 b=KNxQnn/KR3CE6GFrx9vzeZ3uzX6jtPsA/GQcd1yfGnug5oaQxC/DHNijG2cN0HsvYTOE0VUMHo15b5ea+Mjq4PrCOqtypETmVHFtxBP0o2/yujCOraGaY5OMSKWacd0VsDyX/bqRyAb4WisW4HBMPjywfkamV+t1H+DHlUWxGzuJ4BBubLW7fGcSrLIhmu7E/CfpQc0BgD0cEQ6y2keuL7Uu5t9YkbQ51MY0lpIzhPzMzXZrNi13w5HKRHcr6CNqt8NdiqcalOc/i/tdrEmuOkZ/exgyqRY22AsuopjW3+PXFzxeHDn7hLTtCGQGbeocrHLEl4JwCGngk/5sBFUBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V0os3DizkDNLbbZiooriJjKc07+qyhQ2sqC3+piGSQ=;
 b=t3etIReKgRCSHEp08iPGcvoGwOQ/FThdVTAymDvxoq6UqnfZ3FaiXvppB77GGrvxli6V3+YDx9PRa6sDTjNn8c+hhxOzc1oxAgJjoiF352lz11dJjXz6Wn9Jsh5NecjHBGK7A3KWLfCBUyhpYKa2KWBWvJmJQxGZ2GoBGldSyMGHy9XEU16UYL7hvrW6xT7b3vIgmpG5JA1U48qOLs5W2YESWcm4946IsxlYdfy5SjQkBzUEXAOjyQYWAL1IqG+c77Th2ZWkwo6M8rLGjjcWxOT/3wxyVxJ76lnWF4/lv1CG8mTKENpCEWxTqcWbOABEii/OWDq9l/snhIdktDpUUA==
Received: from SN7PR04CA0114.namprd04.prod.outlook.com (2603:10b6:806:122::29)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 06:31:16 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::8f) by SN7PR04CA0114.outlook.office365.com
 (2603:10b6:806:122::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 06:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Mon, 19 May 2025 06:31:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 18 May
 2025 23:31:02 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 18 May
 2025 23:30:59 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Ori Kam <orika@nvidia.com>, "Aman
 Singh" <aman.deep.singh@intel.com>, Michael Baum <michaelba@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: [PATCH] app/testpmd: fix random flow item token
Date: Mon, 19 May 2025 09:30:45 +0300
Message-ID: <20250519063045.394353-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: c77f2ef9-8674-4e50-d91e-08dd969ec1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8/mCcNh4BjnKf6yH0ZYmj3GmmxsWzPe3tpVuG/kPlGadTpTnmRguYU3+3bnA?=
 =?us-ascii?Q?gkUgqbX0N3+XcfYSTwptDrXteW2FzovYnVLECH9ttF78NGMM5jDEZT2gMNSw?=
 =?us-ascii?Q?hznJmF7BUmhjQLHpKnbCbKeGEBul4+J5TH1E4E7T1Y0RKt1TpD9YHBEV1PZI?=
 =?us-ascii?Q?n4lSVN9zoKa6kGS9jyDV6iHG/QyzjmXxeDTX5IZddVsd/Yk+GrooqVNrW1XI?=
 =?us-ascii?Q?bTYbL/ZVieHAqAztjpPn0PlmNPtn9aIPNVtqMcvOd3WGlEvU0wb7Sx1an1S2?=
 =?us-ascii?Q?yOgyUp+GWZh5da6jnPoeK7PXMnf1lzzCxaNdRWVNwyIJ8oE5C5LxvNg684R/?=
 =?us-ascii?Q?aHd5YektpLXhk5KHwzj1ObArEe6jTZHCNHjiCCkvJ+WTUvl+OPDR25cEttlW?=
 =?us-ascii?Q?hYHEFwbbft4xccXbgiRaQ2oAzMwOr+cHug474Om4BZG9TEQIqzVjzSk2IgzF?=
 =?us-ascii?Q?U1S508QLW5lRRBsOI9cvFuO8YFS+BWQE0sd5FZfv70yjBR/NcTBX0+F2e1w+?=
 =?us-ascii?Q?MM2Ui4giDT1QxB12uGTQb8zXp2IeEZFtlUcudyoLzktgLx01PXulkvu4BmV8?=
 =?us-ascii?Q?vY5M781bT44MmHWiuLU4oY0V3JKKVShJ3BXeMTMyUUCBESo3pD2FxEgSt+NT?=
 =?us-ascii?Q?pLf/GC8o4vvl5rtatVSAbLG3w8E58cVjqMmTNMx3N3qnvD3t772Ks6zvQdlK?=
 =?us-ascii?Q?/Mwt+QwXokq8kOyECc5C1JS+jLixmZdSRz32+cFrDPvkJR/O7e9WZ7RL3xk0?=
 =?us-ascii?Q?QRFdXU9dT37thWongVM8qfiCVwWPE3vKtbydBuEJ/Sh9ynMgaE229v6Q9eMc?=
 =?us-ascii?Q?w6tqPqVkXkeGw/enIUx+Zxkid08TVWejZp3WLqcbhA669omlHX8bsE5jTeR4?=
 =?us-ascii?Q?fSoXXpAgJdcE/iM/p0KbrN0S8ftNuyxAk7ZUpbkX08gpBIXkSKddheZg4TPz?=
 =?us-ascii?Q?RdHxbwKu3WLd0qRy1Z701zPsyl+b5CXWHP66DQoE2Y7WABI4ST0yN3AyTXA/?=
 =?us-ascii?Q?BKwCYV+ZJNjO5AuF/Nj7VaqWg7HLzlMWJ7oh6zuaRAoilCkY7v88P3Ofyper?=
 =?us-ascii?Q?ju7ZeTH5kWqgcuKjvNiwUx2esoZoOWkK1pD2IPnygYvU2EwuKLeg0lvpQYSp?=
 =?us-ascii?Q?6RbOdekR5OWewXqth9ctLfPV9MbXiRRFdLmXB2X2LNpYqisGcaX0q4S21MAe?=
 =?us-ascii?Q?WF7cisJNu4Y0A57wOskp4xsLpA2PoaMdl+dJDVPDrUBELP52iyvoGMQQFC1g?=
 =?us-ascii?Q?jcl47nQLxjIT4KZaz77Xcf49yRhRx3bL756dow/iPxFomd06F28t8fYNXxks?=
 =?us-ascii?Q?r8YqIyIv3zG7s4P5o7tSpeS5g0wgG0sWfKtxzD0IOxmZcAG7q2dw2z/bNWz7?=
 =?us-ascii?Q?VX1Zs7V8hgAvZQP33XcQg50JEdFpP/EzTxeKA1q8UuyXWdYV5LqHXwZhLosG?=
 =?us-ascii?Q?lAbgkip4NczUvgs5V+VZipsnjUYr8WWggvJkxhCqEO2Djg/PRyiU9R1jHqmx?=
 =?us-ascii?Q?NjIjajFjWHZNSZ9SdwwZs9WXBZGkSNpvgI0T?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 06:31:15.5008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77f2ef9-8674-4e50-d91e-08dd969ec1c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521
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

ITEM_RANDOM_VALUE token initializes 32 bits mask argument value from
a constant source buffer.

Testpmd initiated the mast value from the 3 bytes buffer -
[0xff, 0xff, 0x00].
When testpmd copied that value to 32 bits mask it accessed a memory
byte outside the source buffer.

The patch fixes the source buffer size.

Fixes: 738ef8f7c706 ("ethdev: add flow item for random matching")

Cc: stable@dpdk.org
Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 app/test-pmd/cmdline_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 998527590f..fc807ad8cf 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -5591,7 +5591,7 @@ static const struct token token_list[] = {
 		.next = NEXT(item_random, NEXT_ENTRY(COMMON_UNSIGNED),
 			     item_param),
 		.args = ARGS(ARGS_ENTRY_MASK(struct rte_flow_item_random,
-					     value, "\xff\xff")),
+					     value, "\x00\x00\xff\xff")),
 	},
 	[ITEM_GRE_KEY] = {
 		.name = "gre_key",
-- 
2.48.1

