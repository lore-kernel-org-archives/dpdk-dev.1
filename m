Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8280CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 13:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B4A240DFD;
	Thu, 25 Jun 2026 15:34:48 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by mails.dpdk.org (Postfix) with ESMTP id EAFB540DDD
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:34:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdBcaWjPfdAY//JqTB+v6OnqD9lCQ0nXZDm2OTOZNiWhP7xlpJyBRIwaC3qEyU56eV4YhK38iLPat3x0w7PZTeoxQLWve6UXmP8VB+MuKD6llO+gPMVe7/xAVuUMuXv+snCXXthhMDFfTgoQh3zWhdVrbtGxC7gGiBszScbJSWKCROWl8dxyMREs8aCCanBNzxDZbUJVK570aZPLsWp06WFPCn3TZbkgbB4Sukl7SOSQ/2E9HIkaXT8Em9BkxhFPWsV1vf7b1rBskiJemiIXlk8iALIsWW6d9pizb9HMK4LjEjUnTSDq/nvwfgfxLUF6rO6VZNRMV1kJBHAvHUU9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBq8wsg1r6AsWO5Ar8tPQjA4cvZ+wGRx68AvGdQO7es=;
 b=Og3UpD45ncGRthW861n3bdvO5Al7o1iSXTt+7Kgx0qzYmhXqpqis6N1ckMmNFc83iFcRVXo/Wp2Y9c6YXebw/fcuTmJhgLVa80UEeimTve5HGsc/UYjZ7eYQLq/zn8lUTsxTA6aBg6IFc3JNA0e0GY1xRDicWUh52WViU6V3HgyhoyTUOkSG9TDznH0P0FrocEsgK9V4axAjiM7SD/4v+lAKCOaKTgZv3easj8iBhEgD4dD+A4B85d34rkK/DSd9InQGUll+BMJJgqF2itmJV9zZ3e7vmR+XTferlO0j5au+X0UfFSFrMH/EfBo/BSLyd5yHmQhk6WPMTHVBWcsBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBq8wsg1r6AsWO5Ar8tPQjA4cvZ+wGRx68AvGdQO7es=;
 b=kvZav7qgkx88UsL3rFjyuZNNDhRzGUeQCAeWs5WOf8YjvYyI9Y5OUNnXPgLvdGgb4zZV/7/fY9BzjwoTeJexlURvgNST28yDv6CoDT524q2N0kwl/+gUQ7Dk4Jtj4/+dS3CmljNdjJP68IGIWJRpzBRnckdlHMivVtHgyEOkyKMXprocY6VB+jLYmhgVizyNt9BUFCL4vi7P6HA8pYBepJprNr/P9EMHiv67FrBNk0E+QmEXzRris8TVxIYzadrjB2J1ejBmdgwthw7TkRJgQeYcbQb8gnD7Fc0750kBY2OaHLujiJTBBxeFxNgC8t0ReTLYbuAWEAgpTdtLyuKmJA==
Received: from BN9PR03CA0512.namprd03.prod.outlook.com (2603:10b6:408:131::7)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 13:34:42 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::82) by BN9PR03CA0512.outlook.office365.com
 (2603:10b6:408:131::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 13:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 13:34:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:15 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:13 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Ori Kam <orika@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v3 4/4] ethdev: fix promoted flow metadata symbols
Date: Thu, 25 Jun 2026 15:33:10 +0200
Message-ID: <20260625133311.1299705-5-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625133311.1299705-1-dsosnowski@nvidia.com>
References: <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260625133311.1299705-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3daca745-a0a0-4533-73bc-08ded2be825c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: RCDoFLd6HEFPq95mvyZQHmu7jmeNz6KTq8ztYneJQFxSzEiC6gZ6VDJfwYQbal0OwzUeWmEfAcn4x0o76O3NmqP4wU7ikN+022KXfWb+YJVs9OFWv1+G0pbI8hgwewAIZKJ9KPT0r+sdGG7fBJhEh14LoQUav+c8gphjmjMfPCDRPR/5Rg4exvIo7zixh7mWVZkFpwZ6mKa7nmkglgfySdsdIienYNk8K7BR9tUGldG3KC7x88qxfpeyWVWv9Xdfi2Quaw6pOl4rx5/YFyUulx5QcMtLdnYSSAOppFccxElAVt12ORAkV5EzHqZ62N0BU6MgDgcPOV3Rri5P8ETE3HTMuzokfk+QSBDItX+6jjAJRt1+53XmbvQjW3DqJoygS3GyPoarF9zAc/+p+ZOWhLMY4NAAPlzDoN23vDluOTh8J2qa8pbsBaiKwLwMMUXYIaj/I+BxsFkXcAmbLlNarEfOkGcQCY1LWh2c9QnSxjwG0pRZlytr3j2VQPWkUUGIVG5oxc/ryenlVqwA7R8/kJYYdhQwu7MCsvj9+eKBTP2zIEfBq3k8oxb1opDWe0WmHsF9AqffVkJsRSL72kWme+IGX2PbNK4DFiB+uwSmA8GlF9bxfR7GQknm5omtCTFRB2nKK4Oh2GzXTbipIdxrVyvOlPwD4drB8BKdXlVXhYHtlS3ctptYLkopylYRzmAjAlCdXSh+dxja5bre5aih5A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yDyufpSLivq+9w0zc1mAB1J4B2aFNBuuCJVHtFncd33clFlZNIn7yOZHxKdL/+EbTkdl0d0bfxhO6oKEKhDxLtSWz9BZRorr6l+NIpG9GxHFdyVP8blSAVFOJWzqFfnFJsfR/xbLRCtA15OOLVEwSvrWMfQv8Js74HWB+q1m4RtYM1Vf5bRDlkTKmo06tcQHevwmdpCosygzbUvhtW6FMvcM4li+TH8YVIiL5UYMw1EHQT1sNUuc+stbMDwBNhzJwnJLrkq0sSqoga3iJBKQFG2Vrd1AX1aubNo+j23jtYGMYyD/JRtdd3hto46wqnEhKK1QLlGcAtD6X6LOPkGrS/8+xHaunWUEB6Hv4hSIRWllEc3yX6ARNuewfYK/r9FEXtFY0Z6Lp+xULYeu46oz/ewmHbL7iJ0tPFzaKgx+5B6b0tX4LIZPZVT1YYFYI+Wm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:34:40.4031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daca745-a0a0-4533-73bc-08ded2be825c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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

Offending commit stabilized the following symbols
related to flow metadata:

- 1 function symbol:
    - rte_flow_dynf_metadata_register
- 2 variable symbols:
    - rte_flow_dynf_metadata_offs
    - rte_flow_dynf_metadata_mask

Any application using experimental flow metadata symbols,
which was linked dynamically against 25.11 version of ethdev
library and using current version of ethdev library
would fail to start on symbol lookup error:

/tmp/dpdk-25.11/usr/local/bin/dpdk-testpmd:
  symbol lookup error: /tmp/dpdk-25.11/usr/local/bin/dpdk-testpmd:
    undefined symbol: rte_flow_dynf_metadata_offs, version EXPERIMENTAL

This patch addresses that issue by restoring EXPERIMENTAL version
on the global variables to keep ABI compatibility [1].
Related inline helpers and variable declarations are kept as stable
(i.e., no __rte_experimental marker).
EXPERIMENTAL version will be removed from these global variables
in 26.11 release cycle on next ABI version bump.

Standard function symbol versioning is also applied on
rte_flow_dynf_metadata_register() function.

[1]: https://inbox.dpdk.org/dev/m7s3jl2566kibbapr2mfa2ic2opuc6b4ok2g67j3il5dgduzih@cz5wcdstb75n/

Bugzilla ID: 1957
Fixes: 4ee2f5c1cedf ("ethdev: promote flow metadata API to stable")

Reported-by: Yu Jiang <yux.jiang@intel.com>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 lib/ethdev/meson.build |  2 ++
 lib/ethdev/rte_flow.c  | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 8ba6c708a2..63fd866af9 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
+use_function_versioning = true
+
 sources = files(
         'ethdev_driver.c',
         'ethdev_private.c',
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index ec0fe08355..24eb5a95b0 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -23,11 +23,11 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE
 
 /* Mbuf dynamic field name for metadata. */
-RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_offs)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
 int32_t rte_flow_dynf_metadata_offs = -1;
 
 /* Mbuf dynamic field flag bit number for metadata. */
-RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_mask)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
 uint64_t rte_flow_dynf_metadata_mask;
 
 /**
@@ -281,9 +281,7 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };
 
-RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_register)
-int
-rte_flow_dynf_metadata_register(void)
+RTE_DEFAULT_SYMBOL(26, int, rte_flow_dynf_metadata_register, (void))
 {
 	int offset;
 	int flag;
@@ -316,6 +314,11 @@ rte_flow_dynf_metadata_register(void)
 	return -rte_errno;
 }
 
+RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_flow_dynf_metadata_register, (void))
+{
+	return rte_flow_dynf_metadata_register();
+}
+
 static inline void
 fts_enter(struct rte_eth_dev *dev)
 {
-- 
2.47.3

