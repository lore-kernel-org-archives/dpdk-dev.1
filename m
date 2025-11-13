Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A9CD98DB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 20:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 636F04064C;
	Thu, 13 Nov 2025 21:17:56 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by mails.dpdk.org (Postfix) with ESMTP id 742DF40151;
 Thu, 13 Nov 2025 21:17:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQOOu44E+hdQGQWXsaRIR644B7YyEbm1/27ceIjEuqX46Ft5Df21is+0QgKaqToM5WFt/XF7KjliZTueQ4DkpJubejEQi0NhhPI6QvIE3UPE/+zx8Rlbi5xEn8a0x/IXYaahC10tdRV6Wfc9qel96uWHaYAa1Gb2cpTET53XZDZGy35RBjtmcxYedHMAcFUqWg02KesVYB7YduYGg4LcELzmm15fE6XLmbAGSEbv+HH9pQy4euDZQuoQ0dsx3P/wT1F57fXwpUawIG9JCJkrqsrks6k41dqoK9GU95gyIXFQGkijrLnd1oK6WIPzJlhge8noBfkB6f603T07h18/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8bl6GOY3zyksndEU1dFgpwgfxfpsPK2AIyN1IlntT4=;
 b=mtvp1upNqmRb4aDBWblqivvJj8ByCGh94dlUerLedRf4e3sfSvne24J8PGhiNUkq2UFK2aGQbZLYsO4KI2PaZ92PvrMxH6OQsDPHdtcgvxI1nc8fHI9RLM781BxEy0sb++GboKZL3J07DonPIor4aU7ktFph4ueYgm6/jDXbcPbJvthDquBlgAv8q4LALbLpz3n1OXmPuxcP/NvnhMmstMqLU6hgWBFskX8iHpJj+Fqhv6bYTQg2bDy/cm85QLanEuU8KyJNjlQK4NXFMhBfXNLC0FCbAIerCG5XlyOngZeWm5+1syAGH0/DTu7znHnnbrkrih2jiZiyg0iKgCbEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8bl6GOY3zyksndEU1dFgpwgfxfpsPK2AIyN1IlntT4=;
 b=nO9+ozWZId6sG/8OJbXlSdQBr6Feazy9bIQPpTPpO4o4RwrKK2ImwMFRFanrTrYe+uVr5/tI1mW6WO6BJvkJOmQm0bBzxpg5TFT9CuBxSIlQZxvxaHNV0f/sZx5dFxRHtGnirtYHpzKAsgExRiPBu/VBZ5bizADcKfYR2RlQwrIn10slVuIYxExlFyTLo1Ge1St2wFJ9CunOBmSJmTrK/p2PX2j7FeETFhALDTiPPBtTPtfVH8CwmxsFupYnHvTBX6i3/7mlk13JcLrXzgrpPrluSas9bXtQgROsZoJqZMmYzneXYT43MgS7cYNADle0CdEMFPpfQFAS9QV2wOSEgw==
Received: from MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::18)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 20:17:49 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::ce) by MW4P221CA0013.outlook.office365.com
 (2603:10b6:303:8b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 20:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Thu, 13 Nov 2025 20:17:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 12:17:32 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Nov 2025 12:17:31 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 12:17:29 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Aman Singh
 <aman.deep.singh@intel.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH] app/testpmd: fix flex item link parsing
Date: Thu, 13 Nov 2025 22:17:25 +0200
Message-ID: <20251113201726.10597-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 14eb7530-2d78-43b7-cb00-08de22f1b731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OoPI196xkxbtLEoi310WpnJFhA9M8zYEP0nbPZP8Uv5ANxl2Ufw3jcqIW9RK?=
 =?us-ascii?Q?D2LWSRDKeSUZVjbqL4A2e1mwAeWQb9Y2PPPRkOdBjwWO16Y/B3j8S+B0WWZl?=
 =?us-ascii?Q?I0SJWpz+q+sD00rCHrtyG0K8gm0a1lHfCc/ylyk6Y3bxtbd0EHCfeMDonYMG?=
 =?us-ascii?Q?qFuyj2meSSvsyDkUlmrjnyfFsb5o3FIIwZUC/1Dw65/gsqfKX3XXnW3cH7DU?=
 =?us-ascii?Q?0Jd+GEQy9a4349ZQZiTmq8FR/FmJoJe8Jo+mN83lA2O5jSADkvdKOdYmcCZM?=
 =?us-ascii?Q?/lIu+IrxXbvU17iJ8rA+Sp7xO5J6g+sj01nWnXkrEpt3MBzismiKBtFywsNO?=
 =?us-ascii?Q?9B2JcfIP1jjypjobFcrszHq6sffJBP2TgzsBgsmGeqq8zyOYST0B3U6b+RfS?=
 =?us-ascii?Q?O8cJIngiP1WHZ3S9I0JkCHrB4rP01Y4V87y6cVxfvKvyQ0fxkb+j+evnP0w3?=
 =?us-ascii?Q?Vrck10fhbY4H1MHOoOefovZlPGu7HlUdQrL5Ine/MeQGmOjgULjhzujy2gAq?=
 =?us-ascii?Q?YupgWmnUSxHuNX2lIRrqLpvG6hChJhrfKtfXOEm+D3e+peGx/gU9tp1KLsX4?=
 =?us-ascii?Q?F6J9hCwrL/f5ieEKiVEpxmA+oCCzG3KVfN6HO222yaLl/TJwk7ZZz5MyYZTb?=
 =?us-ascii?Q?Jt18K8YdiFYIFkqfy36j7oha40sXzQl8Orodd53c6Wy1+fGuN4GzRuTtPiQ1?=
 =?us-ascii?Q?U5g8mQdi+zGQ1DzIhwTrJzubudxZmF3FKrQcVxm0JAA4Ya7sag4S77fSsRnw?=
 =?us-ascii?Q?mSKlQKZ0xneJxr+JnQ0RTAejlFR3FN2R3iw1y/MuqQ3FeiiDuCwxpXYNQpAC?=
 =?us-ascii?Q?Kn6ruS77iyOLbSpELT35bUieWHq9RDqZFH/RVqvsf773Qr6jIM56npyZBmr5?=
 =?us-ascii?Q?U0QQsrr5YiHfI1yIDv5DEDvOxpg2tGHjDkuBBdovWnrlEuvlSavNpoNxi015?=
 =?us-ascii?Q?wrv9e8MT/ppXJalq6a6ftCBweUEP7GCku4PLdh2DNvRVe0nK8R/YQW1PkF0U?=
 =?us-ascii?Q?PLSl9IdfpNd1XopKMZQXI1OkUnKdShn03puZc68xvel1mQBrqk7l+lnalZyK?=
 =?us-ascii?Q?c39NTaEvjRUL6UZZ6TGqaKFnsV4oas9B97P98Xqu1ZE+ZM+2BmfbTtAqXMUX?=
 =?us-ascii?Q?ZH8i3XH/WAwFQGFlho/tYJd9kCr7KErx/m9v/2/YtquHvTE7Ov5rQBSq80Tz?=
 =?us-ascii?Q?4bxtPoDQ/0UfR4heBsAvtrhz7NODdAEi+FADucI0F9/hiqb08dHywJIjVZHW?=
 =?us-ascii?Q?kdGXpSMwZGRazo+bJ/YTRGT36tsyKkedEkFqy2T1uT1ExWEdsAJC7KYeDHYI?=
 =?us-ascii?Q?jWyD3sfZOK7a+Gqv731pb0IFOzPwU81Sd7d2VY39z3ZaRd13KLnzT+If2fVw?=
 =?us-ascii?Q?zmB+gfJvKNYiFxItKBybVtPosqvT9bO+PhZQb3qCyBu+6lf+X8BfIW+bdY7u?=
 =?us-ascii?Q?8/AfuHvYGBIQE2//5MoI3DiAEDMpnKeWeH/ayR5iEgmLn8ZTbm3pveCd78L4?=
 =?us-ascii?Q?rcS5TCQHwpntLc4w2X0z8O0voPGLPeomhKh6nEVcgCzx80fqbR0B1QalApnx?=
 =?us-ascii?Q?I3NrDcLG3IUGt3ZPN/g=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 20:17:48.8270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eb7530-2d78-43b7-cb00-08de22f1b731
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16
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

The flex_link_item_parse function was using FLEX_MAX_FLOW_PATTERN_LENGTH
for all memcpy operations regardless of the actual flow item type. This
could lead to copying incorrect amounts of data.

This patch adds a switch statement to determine the correct size based
on the actual flow item type (IPv4, IPv6, UDP, TCP) and uses that size
for the memcpy operations on spec, mask, and last fields.

Also adds validation to reject unsupported item types.

Fixes: 59f3a8acbcdb ("app/testpmd: add flex item commands")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 app/test-pmd/cmd_flex_item.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/cmd_flex_item.c b/app/test-pmd/cmd_flex_item.c
index e6e1cefeb3d..ec19ab63e75 100644
--- a/app/test-pmd/cmd_flex_item.c
+++ b/app/test-pmd/cmd_flex_item.c
@@ -134,6 +134,7 @@ flex_link_item_parse(const char *src, struct rte_flow_item *item)
 	struct rte_flow_attr *attr;
 	struct rte_flow_item *pattern;
 	struct rte_flow_action *actions;
+	size_t sz = 0;
 
 	sprintf(flow_rule,
 		"flow create 0 pattern %s / end actions drop / end", src);
@@ -143,21 +144,24 @@ flex_link_item_parse(const char *src, struct rte_flow_item *item)
 	if (ret)
 		return ret;
 	item->type = pattern->type;
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_MASK, NULL, 0, item, NULL);
+	if (ret > 0)
+		sz = ret;
 	if (pattern->spec) {
 		ptr = (void *)(uintptr_t)item->spec;
-		memcpy(ptr, pattern->spec, FLEX_MAX_FLOW_PATTERN_LENGTH);
+		memcpy(ptr, pattern->spec, sz);
 	} else {
 		item->spec = NULL;
 	}
 	if (pattern->mask) {
 		ptr = (void *)(uintptr_t)item->mask;
-		memcpy(ptr, pattern->mask, FLEX_MAX_FLOW_PATTERN_LENGTH);
+		memcpy(ptr, pattern->mask, sz);
 	} else {
 		item->mask = NULL;
 	}
 	if (pattern->last) {
 		ptr = (void *)(uintptr_t)item->last;
-		memcpy(ptr, pattern->last, FLEX_MAX_FLOW_PATTERN_LENGTH);
+		memcpy(ptr, pattern->last, sz);
 	} else {
 		item->last = NULL;
 	}
-- 
2.21.0

