Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBEAC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 11:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74CD94067A;
	Mon, 13 Jul 2026 13:00:14 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by mails.dpdk.org (Postfix) with ESMTP id E5C4F40290
 for <dev@dpdk.org>; Mon, 13 Jul 2026 13:00:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFvF3ySxVMUZe2tPRVir9yn+aE/WXHfYmqry0lJztUeeJB6pu69MfH49t0EytF1VFgfS0l17E2IZ650zwPina7EiQ6ckqNSxGhXy6uiaYxPk4mjfTSqRfGg4X2Znpyt8u/c4XZW+OFs/E5fqzegpK32rzJ6u3mXUqURc+zNQqnKF670BJWnobkm7JaMGgYDoUMsGW1aQaPQo38FhDP2JXyMa1HglwV6EA8DpVweAnpSFbb/NubwIEC8zKQurYTaog+GBINLM5q8WiCvPztQ2JvI/CZd39fr/ie6asMldJdBg9v30RLhVk28oKOgnanPItQrlq2FRo+KRZRKFeP9Rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy1gQonx8wG/1IsGYSdyzYkRdHPzF9x5yq/e42+GwBs=;
 b=KmtyauH2hcJ0QBpx577Y1OjGa99Qx9stpLsLrFLsyb7cWxiLlWncBKgnZgIQ3L//rT6USQZS4mPbygirmtIC+aMeuUbU+MBd1Qha3MC6wr3pzFQfrV+4oMiDOffReNxEw9bARNKLNSUD/m42kSp0NYC34+LIK0Y722akUzqItVAjO3osRhoBsJTBzHH/40Xzzw+XpS2Sq+z2H0t1xu8ClNit/sKAFDtWWMYkbHCEPNXw/+kTMrZvvXN5qgYx34L/azfZeF+hUxsuE28bSMDJhHBjeLHo5owWXl/UCH3GRSkqWtXo5hfwdydFKWSXPhNwq3LhSu7/+DKgWocjKkUOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy1gQonx8wG/1IsGYSdyzYkRdHPzF9x5yq/e42+GwBs=;
 b=UBWOpoUARl+q1LIJNqyfi04Q/bRlMo2xvpH29KL70aO29AUhzj+N6NFUuKBP+ErrvODGXj9ILJ8BEjs3n01Z8YZyeK26DVzzm0m+9CTu8F1utq8b31vLsR4woRnJGv/nBsRjppEqyoHSO28R1zjkZjGnRV6YrwgP4yvmEKUoC1Smx80P39lYxDSdGXuZ9Zn2+RSmRmY0gk2zFDOmeespQCT5wH2YXnbFn8bla7YYaQeBmqfbSF2/QagB5sFD604ekWjpP2uowtYoto5U/wvAmYp8DRky1zvPTvueIyEDsaGN4mAE7e1NhUS8bWCZOQQ/zk9uybtApRCyh4hYnkYzcg==
Received: from BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 11:00:08 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::94) by BY3PR10CA0008.outlook.office365.com
 (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 11:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 11:00:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 03:59:52 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 03:59:50 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, "Ori
 Kam" <orika@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 26.11] ethdev: remove flow metadata symbol aliases
Date: Mon, 13 Jul 2026 12:59:35 +0200
Message-ID: <20260713105935.24152-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bfd4ce-ab11-41e2-718f-08dee0cde720
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: q/fq7YPp6ojKsIadCqRaZYbF7cNQTXNq0P/1s5cncZ/ojX/F2Jy2KcJPrAt4CEnp3mcLBDNOU1CORhl1eWGJGz1CKrZi2ZvDQ+CJRcmXfPSsOiyr/Cf5AQNzaS0C8VW7UgBbLQKFy4URH0YQTwM/RKnN5KQXidiFHmTDGoX+edUgRn9wyR4T+DdHtK65X+/65iLfkljqkVtbPlWJosKkB6Ai+lP4FKfu2YzyUqDAGgCvA/2hBAdQPZzYOoutBEa2I1eSoL8goyZ8Xo7tyO9IwMExzEgo5UmLAziGKzmSy7U8lFndTEoMQ25BAXwSe4/moeX+zVtMw71WDQB1Auw/5awAnnrM77P6q6axXNkXG7bldDM9skNn58dN4Rok56LlpGN/aRGuLdfi9Fuk/tJE9TnK7nqrXqMz5lN+BnNoGR/EhTQyiV3QKdCxkKlUBA/XqNTPRDaPkmgkPI7clIC6/d4Rnl/ua6sLlGKXkZG1gZqMaE7oX9qy0Lw/0Lnddg6txcL1wHllKivv6dIYvrAwf6fQiRZHUTKF/2oxqjsKHRJV2s8epcilhgp+h4ZW4ozmkC5GQuXxwCnpRsYiRw3ZVj0lsvloP01Nf+GJdh72kanmRVagf/pjaiQ+ra5Zr9l+TcbV+F3+sJBuBlSoyYak6BddGTBuQqUJ1vZiZbt1m9vPP/QgfQcY/txIsiAeFU1bJGP8HsM9o1m5Z6CS2ncQLA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cCIRF1FhqeRUvXioPMLsxEte4Mmx9BsRghRfLzXrY9jP3YkupUkeYn7qPJ9cPcN3QOoLRloE69R1sqK7JGLkp6U13QQ3UI4+H5AtNaJWPMLkQ3c5QeTgVoIqlldFv1z3/Uv+RKsCu5U01aYxg0ovfDoTSAU1g7ADzOTX1f69Kz61w6y+stDAOOWJAXRAh8faQcyQYXXoi0dAYef3Ay7Nc1EMFcsOBrA7ALP8dArraLdd8Ppv+s8nujupkr6Y5e1bDlpLazDp+ZMixhC0iOvteFdSdiYjm13pfWrN/JYCcTNXIpiuqFEnoYVyEaBntzoD1nGYmPbvqsx+reSvb8pFIDrN3UR8P0CHbHi4VGS76lUYwuMoV2MM3BIwXzciSh29dyRzGXhksnqzbxA70c+gQrdv9goFDDOQCzgqkaOd6Gof6IDDDaH2FhmFsJN8nSi4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:00:08.2686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bfd4ce-ab11-41e2-718f-08dee0cde720
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
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

Version aliases for rte_flow_dynf_metadata_register
and EXPERIMENTAL version on rte_flow_dynf_metadata_offs
and rte_flow_dynf_metadata_mask symbols added in [1]
are not needed after ABI version bump.
This patch removes them.

[1]: 56045d198968 ("ethdev: add aliases for flow metadata symbols")

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 lib/ethdev/meson.build |  2 --
 lib/ethdev/rte_flow.c  | 13 +++++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 63fd866af9..8ba6c708a2 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-use_function_versioning = true
-
 sources = files(
         'ethdev_driver.c',
         'ethdev_private.c',
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 651630b2f8..60c9a3d06f 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -23,11 +23,11 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE
 
 /* Mbuf dynamic field name for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_offs)
 int32_t rte_flow_dynf_metadata_offs = -1;
 
 /* Mbuf dynamic field flag bit number for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_mask)
 uint64_t rte_flow_dynf_metadata_mask;
 
 /**
@@ -282,7 +282,9 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };
 
-RTE_DEFAULT_SYMBOL(26, int, rte_flow_dynf_metadata_register, (void))
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_register)
+int
+rte_flow_dynf_metadata_register(void)
 {
 	int offset;
 	int flag;
@@ -315,11 +317,6 @@ RTE_DEFAULT_SYMBOL(26, int, rte_flow_dynf_metadata_register, (void))
 	return -rte_errno;
 }
 
-RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_flow_dynf_metadata_register, (void))
-{
-	return rte_flow_dynf_metadata_register();
-}
-
 static inline void
 fts_enter(struct rte_eth_dev *dev)
 {
-- 
2.47.3

