Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A2BCDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6390140616;
	Thu, 25 Jun 2026 18:08:30 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by mails.dpdk.org (Postfix) with ESMTP id 39C3F40DD8
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:08:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4q1U4VkXGeyElG4NlD7VWOqsm59viiFBWrq9CKoxckWVlxgCQ+LdLzoqje7hJ6l1rJtFWIVcvE9VHo0qI/UCVbrRKAAJHiY/U+8D7NWgOV0jPq2coTswxhcpDYI0qEpqW2NHwack2BDB4Og1nKYmGWyLVkC2J1zlmVsycR8uEH1cXI0VaTA4Cjef0LiLrJs42epFI4UwdQ7V4ynpaChvuyCp8NzlRwgbOk/E+sSxhjIaEYcx1yCZEmCjODDDLKt/Ag8k10+F2V2oGHK7SEWB66LT1XO+U5qYVrEDnM4kSKHu3z6vOuxsEaSAlTAEBz9wYimCuYpp6FEhqeX5eJUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBq8wsg1r6AsWO5Ar8tPQjA4cvZ+wGRx68AvGdQO7es=;
 b=S9vg66bBtjS6rBfE7d4vcHSgIVOxvgpNU4y+2HA6NYPwTcZhIFnyhHGG8Di9P+mgLL7ZRIruEDM+4tpEgUkXek7ZQTU6nER5Dj4CkN7hFl2IFCvT4jGw8nTRVK4/anoYM57OgdpM864KEtQfXBTqq3igl5KwkyinoQnLBv7e5sGa8ykjtTT3XjQ3WiYN0tkoqAOU5IfrAxWmiBelmuc92RTx1Vso5WT25pB8YOrO/DdfxhCN3QnifYPhDKa2HqBay9HyDB7t/cpdw21mn7UBeUAMFhMJ10epjceL70tdteAbvDo04gWqfZdHTF2I9Ta9y+xtgHoeT/OW6OHyrl3+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBq8wsg1r6AsWO5Ar8tPQjA4cvZ+wGRx68AvGdQO7es=;
 b=suA0B31CNAcbFA1CSKM8B87T/H67a4vPdofrW2RKSZQ04VbYE0JXSEBZFGnKWtSD0LF4/L/jCMqkwKjpCicLt2h7jivA6S4LAw0n+EVzkgNbRvEQRZDmIHQn8FibtiFE4AdFc6AdRWOmV4omiJfPVmRsGQO8ehg7HIWP65G/IzfCL1+X1MiGDuRD0ExXNjnmSKZyUspo7TzGW6xmB4gKI7ceescp+FEkESkod2rF/oSw9c6LVM/KQKps2ckafm/7DOkb8ERXS84QxrHPn+SBqcT60wIt/CdVVGnnpVQ7Y6QX8OWa9DeARjrEx4utpJFlpCgurupZ5hJE/672bx+xmg==
Received: from SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::7)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 16:08:21 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::a3) by SJ0P220CA0001.outlook.office365.com
 (2603:10b6:a03:41b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 16:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:08:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:49 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:47 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Ori Kam <orika@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v4 4/4] ethdev: fix promoted flow metadata symbols
Date: Thu, 25 Jun 2026 18:06:43 +0200
Message-ID: <20260625160645.1341914-5-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625160645.1341914-1-dsosnowski@nvidia.com>
References: <20260625133311.1299705-1-dsosnowski@nvidia.com>
 <20260625160645.1341914-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fdc4ca-2c0c-4c47-f89d-08ded2d3f8e5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: En3+pSEyjB07oAUsgbpoeqZxhBxHA0WOpnPH+Dq+GLrwd1Lqb+619oL8IZ9neBNE3c+aHi4efSe1g12eJDaPFXJBHpKSAnLfuepvuGUbVblVc+sna/UTUFwtz5ZijQzHtAQnMhC+8tEJSGOirWz5nt4efU8NYrj55ZmmxWhuJEYhU1WcmP6HsRaLckVPCsrxprarhbFxIwP/Z8zDyNyWDecNr46RDWp5vIbKC+b3vl9Opt6Uf/fVymugWVls192EKKtW77FOuQcXSnLU8nL2mM0KnmYTsIHRy8vqJ5+ntXvHdTLPK4rlFUqFuISIidLjZk6/uWwAlQ5Skv3MJpdaFpjsD+PWydTylEsGKZPpCNiu6i6KfeMjCFjKMNdVBn/8u4KD5oZyQOJ2Er/u1LqsSWVJwzgOdvTDajVHYTaxbd/L/ec6esJROPdu8t6hRJXPAdW6oIfI/EICId4E5a0WgEvQbf9CfuTzkBtnEPaUEAb3NfNVg6cYUgBPQVEh3kra1ZIL9lUucNlyGlwvgkVpjLGiYflYDZBGFHgdxlPsk6mqBG1mV1of3smbH6X0DQX3aojaBJn3sqisJEiFcoiAz+vMiQziMfnAMt5LFPx68KRkAaOBC8GbGHHQwu9QjLU3C8AYt9Lk0mJvsP6SPXbQm5i/+sk8YllMujGfImjMScGJCdWRqBTy/UGeQr3ge9Sart4G7oerVpcAKiQooW8l8Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vIARUY9PSqerBtZh9yBlF9BBYIrs2sk8K0glakenZlTbhidUGx9VApV9w0vDtz1PhsCF+sfa4szpdyPSnq/WDnJStj52lMXEfeIMtLDjt89TfRzCPucQ1ScljO4s78kZL5+zfpoKXLLLlZUgeGRoZr1oBse9Qu5zNYV+J1jris/TCe6b9TJqIX9ed7iUfC9ikeofidQCDVmBawKXNSVMx5VqvWIOY8pkbqdeAaDmtfTMYzcKBLlIuFfO05ECoBp8/nOIaUEmofvJf4ZOEBogHulhCbJEAuAGuvVwjVk6nG0qeWmfUbem+VgIT829/MAQsj9BQX8W3KoGLuuY+dn64nV+YGTOLQjmd7Y7kSXHRoZCjUcPJwgtRog4zO1twtdJJuJas0+dbSsStgJ9SVC/HY8ebpAPaxnykSrkS2tYuxwPHjMte3lgJwnECyftDRvs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:08:18.7503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fdc4ca-2c0c-4c47-f89d-08ded2d3f8e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
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

