Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBF7CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:39:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D320340685;
	Tue, 23 Jun 2026 13:38:54 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5F2464067C
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCyW5kA9fDbT+JCEVmlN4xIw7CD019+40GyDDDCqy7g79LVFW78GuBMkQiHbn29gH6t/JTUkJ83x0sjZSNo09h1GS0DitdNhmAjElIMyFdplsAFRpAZpuxRJ74hfpQkN6pPl4Hc0cj1F/2A2JC/tL8QkT08bns8JC0mDJGoLkE7kb80C5Xo+sjLMMuJ2yKOxjCkCsCiz1fe9lpWD/RpvCm6t0t/fsL76TDeB3mIt8rk+m87NwJQ3GC3aBpyxM5K0REuT+LdorUWtoDWkxhtzwUIwjPqUgseC5ecdRbGUc8pTZCG8WE3JevX6EV8FO4uw7Ys5tLOICDZNdWXijZR2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nie/7TQ/x7uZmRBP/lzdfetqwOoYGNhwOBwa1U61slM=;
 b=FSmvyOWdMqcbclxJpegr0w6SDMRCFnZfniMbg+KKrCK6m1JcXmBSzBd8k10a+Vtk0CMwF0h31N4HsIUUMl4UUVlzZ+0IYeIGzedr1h91i/8R6OsB8PzcIPXXUiXSbTd8qjgqzgFd89ii6EcEBnmkp8SH6sE8AcCo6Q6PDR6npgVhR4NjrN869K1VNiUIFSDoOS+7VymoLTescmPzmR4lu2Jbti2sd8McAFC0eHYZ3n1fVD5pTV+F2r/e23kc9V9VaM5TfFJ8f12Qvjr2Dwq6ed05WdPAWKM+IfO1u4Vbxz4CiDrHgikx/rU6pObKDYvpT4FKE+oAzIqJhSyJ//e7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nie/7TQ/x7uZmRBP/lzdfetqwOoYGNhwOBwa1U61slM=;
 b=WuvqafS/qupIeB2BVePnrRvT8vg/iHvdTRHKimRWQkwgGVtFj7Y/UI+0vItBdTAkZh4kKFaQMH0V6ztEs8s5d7obJs5nLmbuZTXVDcAalqOO9DX6+Vo585TtxqvAjEYx+GypPyMHdewDqbS3fMMN59lapbWo4Rl9WAMclOFRdLCmikRDosPwIGrv3LdQgVXElokuLBVt3Ptu5vcJDhW+4cnkdsl16/obAWHDzdrBquALTNrMRapA67DFSny/MdX4pfQXVBVTSplHZhZfx6B0dDQVkuk0WbEg87wtDIUpbB/jtYpGxo7rQjZofvTbZHUmMMHwlBxuEdWZvofNzCpi+A==
Received: from MN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:52f::30)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 11:38:45 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::a7) by MN0PR03CA0014.outlook.office365.com
 (2603:10b6:208:52f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 11:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:38:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:31 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:28 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ori Kam <orika@nvidia.com>
CC: <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH 5/5] ethdev: fix promoted flow metadata symbols
Date: Tue, 23 Jun 2026 13:37:51 +0200
Message-ID: <20260623113752.1100072-6-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623113752.1100072-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: f564f961-f167-4052-5341-08ded11bfc19
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: grMFHxZ/gjgU0ps8fW7m/QB1Cwg8mk0hU0SRMh7m65hH3gda8SfKWBcOVx8cUGhAhwy9wOL2dilLj37JEBU0J6i1ReDk/TTTzKlAO3ZmI5V4GCzwNAPr5HwgZ38rT0p4uZLIzw7uwvZGZP7agiqZjOaec8sGhD4wMMNvLPRfwfhNZ/I3H67f8qCVGr6WBmGc4WbJcKv8R3pR2sWPyEUpUFwm3BKxS6YA1SYDe6wwnPT6FfKUoeNb8q7MzAi0mpN9frfLlJq5O3eRpjM7bVq+TIzF5WimDNeK1DrOM5/F/kbw5rr5NwzKwMuntEATdG2UX1qlds/+Iv9G/LiYEc286jXU0d//jvuUXuKl614A9F66m0TmoiAupzvghgWd4+SV6YMyrEnmHnuMhS8I/aUZFoItLibt4NHqn6LVj61yUWZYwgR7Da1aMDueHghtAQG21/wLhM46n7aVDWLftYyAuDj7dH8GRkjRKgSp5OB9KRo+Zb9yZwi03LgxkikMzLEONB71aG4KKV4n1Gtvgvekk4DhPH3Wh6YP0Scsg2/hpr2sH+KnGol3clq/BcFZfceF1F6bw76Nha6yCBdLsEaW9SBMmptn0YFVj1HRby0UFOyZW2MRQwdZ5O3TApCl2j0R3n4jR7OtdThhypo0N5kEnvdy0p0RraTWeve7l/Gl3V66HkZ6jEfqc3m0MNjMUX7aGlNE4nI00CysyFI8Ukoz3w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 87ubsABWSrbr1RSsOTIUDUNhQiPtED1n1k3GmDC/6ontkhibluuio9zdVYjyaBNb2ECFYEKAep5hsFoEwD10NFjocTdXXJ/DnCyWqw7hRwUPK5983/zLUKSWRKHgTbDLqh3XBo2H81uVqFiXzi2TKgzdQVoXcq5DkxCJXiEbCt+FprcZNBIGLjB3BfY28nIXx9r1v9bhSMzTR3TtsEjnQuQS78VIgnzwbHS2wGidh+HN4w9YRkHIQ01oOE/L61kPrCnIfKf6/VI3RRhDv1R+9PZYBG5gkc5Rb4hEVvi5OTeZV3TgXr+34E/mcaNT1eZV3wfy0sNu3KFehjxzjnEi5jJ0jAOCXMbuWn8DR2kztkPofVCqvlUN/FnHwlLvWYv9RaI/FSFMusGveavlBIiay/DEH/0hrJgEzTfXt7GXE2Vhcg7J8+meSMyxkLhw8o0C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:38:45.5065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f564f961-f167-4052-5341-08ded11bfc19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
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

Offending patch stabilized the following symbols:

- 1 function symbol:
    - rte_flow_dynf_metadata_register
- 2 global variable symbols:
    - rte_flow_dynf_metadata_offs
    - rte_flow_dynf_metadata_mask

Any application using these flow metadata symbols,
which was linked dynamically against 25.11 version of ethdev
library and using current version of ethdev library
would fail on symbol resolution, because EXPERIMENTAL versions
were not exported.
Specifically, on application start up
variable symbol lookup error happens:

/tmp/dpdk-25.11/usr/local/bin/dpdk-testpmd:
  symbol lookup error: /tmp/dpdk-25.11/usr/local/bin/dpdk-testpmd:
    undefined symbol: rte_flow_dynf_metadata_offs, version EXPERIMENTAL

This error occurss because symbol lookup for global variables
happens on application startup.

This patch addresses that by adding versioned aliases
for the following variable symbols:

- rte_flow_dynf_metadata_offs
- rte_flow_dynf_metadata_mask

Versioned function symbols are also added
for rte_flow_dynf_metadata_register().

Bugzilla ID: 1957
Fixes: 4ee2f5c1cedf ("ethdev: promote flow metadata API to stable")

Reported-by: Yu Jiang <yux.jiang@intel.com>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 lib/ethdev/meson.build |  2 ++
 lib/ethdev/rte_flow.c  | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

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
index ec0fe08355..a8c01ffe8a 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -23,12 +23,20 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE
 
 /* Mbuf dynamic field name for metadata. */
-RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_offs)
-int32_t rte_flow_dynf_metadata_offs = -1;
+static int32_t rte_flow_dynf_metadata_offs_impl = -1;
+
+RTE_DEFAULT_SYMBOL_ALIAS(26, int32_t, rte_flow_dynf_metadata_offs,
+			 rte_flow_dynf_metadata_offs_impl);
+RTE_VERSION_EXPERIMENTAL_SYMBOL_ALIAS(int32_t, rte_flow_dynf_metadata_offs,
+				      rte_flow_dynf_metadata_offs_impl);
 
 /* Mbuf dynamic field flag bit number for metadata. */
-RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_mask)
-uint64_t rte_flow_dynf_metadata_mask;
+static uint64_t rte_flow_dynf_metadata_mask_impl = 0;
+
+RTE_DEFAULT_SYMBOL_ALIAS(26, uint64_t, rte_flow_dynf_metadata_mask,
+			 rte_flow_dynf_metadata_mask_impl);
+RTE_VERSION_EXPERIMENTAL_SYMBOL_ALIAS(uint64_t, rte_flow_dynf_metadata_mask,
+				      rte_flow_dynf_metadata_mask_impl);
 
 /**
  * Flow elements description tables.
@@ -281,9 +289,7 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };
 
-RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_register)
-int
-rte_flow_dynf_metadata_register(void)
+RTE_DEFAULT_SYMBOL(26, int, rte_flow_dynf_metadata_register, (void))
 {
 	int offset;
 	int flag;
@@ -303,19 +309,24 @@ rte_flow_dynf_metadata_register(void)
 	flag = rte_mbuf_dynflag_register(&desc_flag);
 	if (flag < 0)
 		goto error;
-	rte_flow_dynf_metadata_offs = offset;
-	rte_flow_dynf_metadata_mask = RTE_BIT64(flag);
+	rte_flow_dynf_metadata_offs_impl = offset;
+	rte_flow_dynf_metadata_mask_impl = RTE_BIT64(flag);
 
 	rte_flow_trace_dynf_metadata_register(offset, RTE_BIT64(flag));
 
 	return 0;
 
 error:
-	rte_flow_dynf_metadata_offs = -1;
-	rte_flow_dynf_metadata_mask = UINT64_C(0);
+	rte_flow_dynf_metadata_offs_impl = -1;
+	rte_flow_dynf_metadata_mask_impl = UINT64_C(0);
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

