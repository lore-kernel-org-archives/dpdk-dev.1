Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD61CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:08:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E89B940616;
	Thu, 25 Jun 2026 18:08:10 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by mails.dpdk.org (Postfix) with ESMTP id E6B64402D2
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:08:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD7W4VnmmmWPYcw/03VRNEqNMnsiooX9xVbZAzun3lmwKhp3lv1EcvNBJZRHt4d72fq5GZ5evELDj7pnHjjdp16Io7Z99AY/au+Pd8/CruvSNRsd0hZo/ynSYsgL4QOGV/HKu7eAYU+z5kH6yWEDG+TXwkwQyQGOQDPzAlmbTDGMl1peeVjb6+QkWbmGfOaJJUDhGNNNu/P8DzvapRwHFeAApqQy6TY4iOQ8KSuUm0ZegQAGCUOT4f6jYZRRNgsGQS1+3Pce9+Dg5t7WqXJcm0f59TP+YMESpA1fgthLh2xvSCOGHaoSMC6btb5RPjTsdMEZCE4Wn6bwL2zslrCDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkaspCYt7TXr2RH8Uy8SEqP7m+O3b9FJfytLb+ckW/U=;
 b=DpbuviNnO0zoSSAF81emh7YrTNJXfu0jRaOJQBNdXkJIDDOHXywnkpG+0t5+RPdEJj5DZKr85Hiv6qNcdvEgTNgJM9e3JUMlX83DF1OZcoH4tdMDdGyAtTQcCNdylxTBt52IFgtBFLJObLx36lCo/T751OVPOjo9gCBsM2KfUlma9IOc2gWzygjuQvaKO7chJp5UFZXK1XwMJ04x8QlV99fQ5sb0JRU6zoU0DWi8H1ay2BIhsA5umdFzsG+ohm+iGgH0JiWK/togkcfLg9LyjJBnKtJ7nk4jU5kHnvuJ2dcXOfnhDnA76xy2r4/Gb59CD+B8egCVaPIfl3OLbmYmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkaspCYt7TXr2RH8Uy8SEqP7m+O3b9FJfytLb+ckW/U=;
 b=Lri3WE/905nZMi5k9ir40jiEZY5sGalr1hapKR57XdBSWc9tKWeHtgB5L0c1xc2U1fEsjSHLNNIUoFfNoTsmcL/5Il6LhJk21qK2vGVhirbmvox8EQ3V+m69CQeR2Qj5oYFTF6oXqmhuGh8U5LQqq3tixeSAlPV5kgQcQ6V4IBThvUB3r0xrFtx4AwFpqf0uaHsg3/gj7IQ+vxStxAP8Vi+U9SkWjFEIo60A7eut3sH1mDL/2gmie82mKrWK5Nopjjcw38jwkSWBM+iwb7IxXEBG/H6a8ei8bJhCiFVlAXLR7P/f9euwVvX+ohxFpYOf3ptGvQnGpGL5dCZqAXn6tA==
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 16:08:04 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::17) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.7 via Frontend Transport; Thu, 25
 Jun 2026 16:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:08:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:41 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:39 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v4 1/4] eal: fix macro for versioned experimental symbol
Date: Thu, 25 Jun 2026 18:06:40 +0200
Message-ID: <20260625160645.1341914-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac156ba-a0d8-40e4-afcd-08ded2d3f070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sLygN7/gE0pCPhT1ZN/FAMGijKCREwYlTnhoGeGGmYhtkFu/YqKVp3HyoEpvZE+29rsZp9lUWeIoE7Coo3MJcYpOAiN2wvn/22hBP81hZ7so9y+KgiQEYLme65m0sExeGvlrZyuS5lg8MscH6Tdrq9naXDpnFVOaRyyvTtd7m22/KkaZ6i0+vogWbPkWWQb/2dARzHlh0TmG1w70jKWszDtvvgz4+J4Sq9fj9J7zQZA9dIt3cEQxFcrf7GOw+Wr2BjOqrTYxU9p091MnmzWtgg5HrbyqFb9gRj+FeBwEsanM9rE3KHN1uyukalYXiHJio5PLdYEtJBJSE+HqTqqk4dfn7CKQPbtPltQKxiO5c250o6PmdYskdDpXpuUplQtVhWeNw/zYzP8ssHq34fw9V59klsGsvDCz/BQfhpiM1fxdi2Atp96/Oo42j1tvYY1a5q7MtoC+DKjOvllQ51isyfEZ91WDrGJH2mR3uDdXIFiCOw6972e3cWlhhEyeEvdu172od3XAr82Ei+YqiVl6k+lvRtqGhEgRsTNP1viQyBs3Nb08Mzw/1m3c4wDDknGrusDH7768E8sbBQ5Km/1KBC5FCOVzSFJ93IZ8G4c6frpkyS3KP8R7Dcv28MaMjdI16EB2tnlzFMhJySVcueq4GGJIviXaaocGeH/bNtYnEw9/2p2I86BtQm0z5GZVa6OeAg3eUR5njWhTYj8mCDAH4g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5qFFXGtKUhRfJxXcRbNnrO/5a+Oozm3B6I2ZlhUvSv/SKQOBhraWjuMhQfysb6bAyhvDb9Nx5HswIebrPWmET7ahBH2/BhlBVqSwMYXZsMtktreKSgo6yHFDYBYTeqaEOnoUijHDgpV3ddQedq9XoQu/SZsqQYVlE1pXd2q+4yyfBgXH5wotKGb4G8+K9lYMP1B3iiZ2/lwfbyBiBmXCowlbLIXJXcCubsxWPqUAyjL7byYyIOSR8EHXJ1QRjTiNRMpLMrbuh9EFHfdu37RNs3XkDsOg/tiYDgWoW6qztrRLEEHUMXnKtnaRspgxc7TBvq3i/pe3Ng9GeQLQUZH3gOtEy9Nu8hOXtbeD7T/m1+k8JKsPRokDonXK3/qhSa9XWBcGElFShc0zQjZKmxn8XfyigyKp4GJKwCBY84W5pTR5gYTh2tltt6wu1px7n+Sh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:08:04.6756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac156ba-a0d8-40e4-afcd-08ded2d3f070
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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

Add a missing semicolon after __asm__ block in
RTE_VERSION_EXPERIMENTAL_SYMBOL macro.
It's lack triggers the following compilation error with clang:

    ../lib/ethdev/rte_flow.c:320:1: error: expected ';' after top-level asm block
      320 | RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_flow_dynf_metadata_register, (void))
          | ^
    ../lib/eal/common/eal_export.h:75:74: note: expanded from macro 'RTE_VERSION_EXPERIMENTAL_SYMBOL'
       75 | __asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
          |                                                                          ^
    ../lib/eal/include/rte_common.h:237:20: note: expanded from macro '\
    __rte_used'
      237 | #define __rte_used __attribute__((used))
          |                    ^

Fixes: e30e194c4d06 ("eal: rework function versioning macros")
Cc: david.marchand@redhat.com

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Reviewed-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/common/eal_export.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_export.h b/lib/eal/common/eal_export.h
index 888fd9f9ed..7971bf8d7a 100644
--- a/lib/eal/common/eal_export.h
+++ b/lib/eal/common/eal_export.h
@@ -72,7 +72,7 @@ __rte_used type name ## _v ## ver args; \
 type name ## _v ## ver args
 
 #define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) VERSIONING_WARN \
-__asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
+__asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL"); \
 __rte_used type name ## _exp args; \
 type name ## _exp args
 
-- 
2.47.3

