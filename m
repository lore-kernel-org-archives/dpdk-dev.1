Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5554CDE002
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 13:15:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A08CD4067B;
	Wed, 24 Jun 2026 15:15:13 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by mails.dpdk.org (Postfix) with ESMTP id 3BD514068E
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:15:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2o4EqTSHOc+n9Kb/xklFrvFlA2wmfkZP3OLBrYshYDxzpRc0u0nMtha2oFi6YlooUmovsVFCmY2Zp1p5ELj46NSz8J+fXL2yw2yKJKg3OymJKi96cXoBBU7KFh2NUBt7O/7Z78MHAQlDahG1d9Hrd4iHqKsdGfA1uksrmslfHp8Oy/dhpGbxTK7kRVX8beI7OA5XxW0RVhjiWmLCzA7qSaWQdzeR3FlsbP+85xy99DR7cf56MLsnpAGaLP2LuerVHebbhYsv0mUdQ9JVXVP/1RPvQ5Y2mbtlRotHEUE7o8g3kePtRjxPBEZJZPYMOrRgU25ab/QlS83qFBCyNnTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RBauX+q+1XpPbTQLA6KFvqd6aRbayZlVwY8rJOfmww=;
 b=W1w5o2RpnN0s7Xs9WbBsRFxihactu4QJN+Jt6ozuQhnOwC34b61Ho0LsSkAejrZJQ5yTwGknEIxgB2pEqJ3CoPz8Ugv5td/zVH3nZEoUxqyCW7pxoGU/j2YO96IjUEufFG3Nl2LEjqVIm4/0yfBmPnYeGRFJryj9liphhuojnKe5euIV2LtFoPLVvVBdy40B1Smk0JZVtq6zeORy0rOQgySkWXsPn4Ai1uU1t6pLRoIKmxA5eZmApDNxkmCb+v7a6kbGAXeidNzdZEJBgC1VwOd1wu2OoqXd4MQXYwfPcHCJftkBNQ763s19Ih1sbWt3PcRpXXQ2gvLy5imp7STkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RBauX+q+1XpPbTQLA6KFvqd6aRbayZlVwY8rJOfmww=;
 b=tiSlPIo7coWFoBr/cm5wJXsYI6p+t+wCCpQwx46EYD+0eyJzQIdzcp+wNU5DKrDMp9yW6W7K/37F9pgxwaNxPxXFzQmhx/Dx8o0Q+D7b+iR8lawxx8PAO8wknlM35+15Z2phbyGFdI2+tnGnhxd1dH2AgVMn7kMOjBHMRGuhKo7C4l5a2lrvMzaAcOwFRCIWBTFtpVnGWOap2ByWzocE8nUXH44nYb9GEya8SiaYQkxD064JEGyqajrZBg1wUtxT8YKk2eOMQE0SUQx98/Rcw9w3q5bslanOgK4hp82QHjrzB+/BSON1vPZIFOtVr059D6aUklIvmqOiRvNa9qv7bA==
Received: from BN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:408:e6::25)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 13:15:03 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::8a) by BN0PR03CA0020.outlook.office365.com
 (2603:10b6:408:e6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 13:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:15:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:41 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:39 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Ori Kam <orika@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v2 4/4] ethdev: fix promoted flow metadata symbols
Date: Wed, 24 Jun 2026 15:13:36 +0200
Message-ID: <20260624131337.1127323-5-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624131337.1127323-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9ef3c8-e655-4d35-d5fb-08ded1f29a1d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|4143699003|22082099003|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: Bl34mkbSoEIbYpJUBhmfA10c9Jb5vCTbSOh5ySr36lj0OiKalMDbZuXkUj6U4MpF05kdX/v0+Z/8pLHLdlEDnMPFXEwfnXXzJReZHBrG+nAM27jTSLXq9Pw+x0h/H1Sgn0NYv2R1P5YkhvdvANCmqkZgajSfQr8iU1jvYdYzGQUmwsWKrlu1T2c790Jyto0yVcDxGBc8tjvH8EO5Z+ZtcSRv330Xs+/LtUP/z/8tdJkjoxNjqPuevmBqbdgtDa5dl8SetxVdJAQ5TdGDdv5PKSK4Ux0DB2y9pAazuocaaPCgW9oDsygrr2Rg5dEZT1TWRn00wH71B1aBUzlHB8W5kHmX86626+MO5e4pMWU0DAbjMBeuwLfFWa84sF4FTxc2EDWuHi/8chrjqX3ISY7wBel91AP4fvFDSozQg6hr0kktwlCKJtD60OOxRoLI1cNURpAv1Q/zMGIW/oRuSv38hnah7t9Og6UminlWHXyqswwJbhFp9OGh2I9d5jv/tJwRDJ1Hg/ccLG9ab7yOL+45ktK8dYQ54UTlBS8hEeO2NDY8WhZ4yy0NE2Fi43tOoVtyOrJK2CiXT/2T2Rlo2a3vqcoQelQf5XAjlcEtImzPTX3cM0LgNtcWbcUqnKWRqO1uJ8kHXlRIY4ts5P9KfS10yRb+IiIf5GXHjvKRg79D3PSVfPiieYs3npFcyjMvRsJJ/tRxeF7YT6WZu4o47Juk5Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VLXYyGYszwpCQZUdVJJh5ky4oiwAPirjVRsuT2o78unZqH1XqOXWI9JjAnG75rqvyK6eopGYCVtgdHruKDdn7cv/4G9LJVBw43FBdkq2F9DnCUbdjpv3jGD78dvpLhiMxdFCdNncoohEptfx8VTbXirNMY7NRTCw+cJyw9OfZjNCTgn5JSdNPeTiDFiHKpwU71RMa0R2zcyYdcXySinl4ELElyJYhRt1go+nFt2eWlBUTtX+1ib3g7DNPpxHIf6wP5pl2GRWelXPhFMcI/hGh4uMXhyXkIB1v1oK+QpR2bDVU0eYYFipxgYlN16vyjpUYJjv/IV71FiY2hUoBNdJ/xsfnl4niCsqMfh2OSza7B9k3C1Y9GIDDg9vodbUA5yNpQMs/Dq3MRWWM3bECzJs9OWldCJdOm7YlE5uKZT9a+h/8nNOT9mH67uqx7v7SIQ8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:15:02.9241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9ef3c8-e655-4d35-d5fb-08ded1f29a1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528
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

