Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B6CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEC5340612;
	Tue, 23 Jun 2026 13:38:43 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48]) by mails.dpdk.org (Postfix) with ESMTP id D2545402EB
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isNw4UsSb3ZsIIsMTreKq29nJIP/EUAQuK8Q4D93ai4BNTUfUmifuR4MydboQMsOoHACgy+tCRoAu09IpqY5DjLAiPBaaAVGkzc2/gycCBlppWmR7+moLqhUglp4xh2X5VLL5IOkpbtlvHn2CTjD9m5aSbcwxgKXz2ztkHBTN5Fl3lOGcXLP4nWkwm8BbUAy/ilEenbhoRWrKDYFw5H59kJd3Cgdn5f7dEgqX4IMR4k3pY7dfDzI1s30pr9RQlh/CkrVo1hLvTPt14HQT4cBOohdqGnkqJdLSRG3H/1nQ34J9KfolU+/FKAKzeVYiAsvH1SqmVihqU8rkPR9SlbO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld+kycsHXve+vpDl6v1tOZT+JGl+dQd0ZYBHJNSG39U=;
 b=XPfNtvz6gILrCv+DzF0mZjh0EAlyND5pz6ZWqhUQUx7DfCD//7ryuFH8CvYN6Z/RnDYr4tVptjB5QXrz7ZpIv2tCFROub/9V1shyrwlDDc//B++r56R0MYmR2bkr6Wv2tTm+xP+sajsot6wuTB8248hxQsgPrdLATAi6bsqMdGEZjW5ZZ6gI2xITGOhQF8qFs+exNmnaDi965yG+skbZwy8JFKYhuISOlTuOG9mABSiQE9XlU9plzF8Iio0m9C+TcRKh8GgCOz++TVXc7CuKPx6mDxy+Sqv3Y82nGoUHaPjghVZf1ZQu1rSCggonVwvyDdnx/2m0jnhJmYH4VOlYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld+kycsHXve+vpDl6v1tOZT+JGl+dQd0ZYBHJNSG39U=;
 b=hJd718OuMyinaLRhQOYahMaUG8NFFn3FuCUMZSP9Q+iOrwa3MzoFUhfpfMjEeUFF34xHoUkRBbyCnVaJnZzAXByj9uzSvSkQnNuXAUOOXxTrLdsevcm8yes7uiQUdu89FBTQCr6mupXbAZvT4sEHkZAzfqGak0XLzzlcQQx7BXn/HkijGAIQSYeUTkBau3UuoKy3CISzxsEQz8UA8ZteOgR3+HGbVk5xzAidrdYN/YZSSaE1fqLkqp0Ns088f0cnKDNbOSPT42SjdbRf7zD95rU/sGTYeq3qLen3ncXM2jYP/qqG+NJZiEMRlvdpIIVzro0UMHX4PXqt3QnZjPaFFQ==
Received: from BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::9)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:38:37 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::30) by BN9P222CA0004.outlook.office365.com
 (2603:10b6:408:10c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 11:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:38:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:22 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:21 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/5] eal: fix macro for versioned experimental symbol
Date: Tue, 23 Jun 2026 13:37:47 +0200
Message-ID: <20260623113752.1100072-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 612593f2-99e9-496b-6664-08ded11bf6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tCGEV/vxoBAaqEU7JIksluLbbBvc3Lgwmn4hNZ0FhujglIa5cLjpN8pVZCrDeIab4wqVnVYSTijig+KJmpKesDFlx343dxzGDwU3XvF1X5PgPP+rJh4O/p+U0CVe4bGu2poWm+qwbkCk86SL6pmO8aiqF0KxIjVnaJGSoZauBW8/JdK1vRS6gRCyaO2+1V9NXX3vGLlzGxvL+DB0d+o9+qyI4ch2mbNmRe8AB1e08ruIIAGncK8jz+TX1VPlRQOb5QogNm/i7rXgTjovsBPBiTMhUblRKtYBM54bXzt5WX4I+BubVr3xalpVQJatFXPum//VD2pG0fVAB4Z6oYQiGMfTH88yHaiLv8Kaq9P8hLwoOqF7KZ1fkaq5i0xjGTusAp2dtxsy+vSdd6sPLK3WBASbRhuFoBBXKni8hg+u5UAXfMGu8B2AoloJFOIlRUWpQW2GA8kL4AhLA9D5BWfBvciCMoDq4l7KqilGt+bNUiOB3AoHHt5CKq9RM5WUiD7HXxPAVfVpDYANRvHahJqHsHl0YM8HnQjY5ptRs0o/PqTqV5K82MJXyNZUHBwtje6WgI1oDYq5BOFf3M9o43uCXlW5Q5xK1m9Uq00UzFxyxg8ls1rP2gB4OEwo+vjHhU2b0dGP+L3HdTmgM+KP6KkbibAE55l34i6yQnyJQ8rJ0wGeSH6GamwUqYOH+092miXa2XW4Xw8YXaM3M4sECfTtFg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b56f4QJR2d1u3+aDcAQlxSCWeYHYO9oqNzGTMWB/51D3a6EhlOibuSAOQuz+CySHgf+ZYbClKYWL0si6Sddn4Cn9sMDPVsTNIkg086oJvj456/z8Jd7OLoyevsCxPxLqg15xMNc5o2kkNgGFRKk217fkX/7MZbu4Q834LMhVX50QaByMUEZMWi7i81w8Jc8y3FCUeY6GWEyDXPyFuBBIdk/FyER4nEfJ29Ioy4i0I3i/VoZA9gMUhgtqxnNnFrJAWwn8BeQ8ZqAl659oHfudNbMQd+EjkRS98Ab0BKFjKq8s0Vv/ub6Jz+fWtLlNeiU+M+jz7TNlK0jR9BtJRvo/8hQvXSXZpTWo2dSWIJ2PMFCEt+1cUCgll2Zdl1cVmHL92bsfWJP08JKt1ORHMkEbP0QQcp5Dc2ZVfd+mINHO9QX6dHpIANQjPLH2Vt2oOItG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:38:36.7454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612593f2-99e9-496b-6664-08ded11bf6e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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

