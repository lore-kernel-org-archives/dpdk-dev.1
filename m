Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD9FCDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 13:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF87340A6E;
	Thu, 25 Jun 2026 15:34:40 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67]) by mails.dpdk.org (Postfix) with ESMTP id C4D9D40A6C
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:34:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXSpBGHtNak+OCt8UWyQRoPjLOlqqWee3JRlBqqDNFAvdWSFRwHgpsT5o5ppBq6220za76w+B1tMMqNcNXKW2UAx0j0d+aKSbuK6pIBLL/D3vmzZyyhCKzqTFmSBLi+nnrcGgzxoU3eJURlHpbRRm5eIRuzxTGayKw5geJ0nhLwJGcSqySpCqZYX7qaX9e5BeTk/PaKfn12nU9bHP7Zn2Cw6LF5phFIBeot56xbK+YRm2/qjZr/lEKDAXPubx0YnekEonyCvniC3cirbbD+DesqQXH9k4FsdBZ9XqbYaLxG6kyFKImKjVrVR8t2K3E4NrwTohHbnRnIPm5MvIkh4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkaspCYt7TXr2RH8Uy8SEqP7m+O3b9FJfytLb+ckW/U=;
 b=CVSdYc2FRfe1rEIg5YWF4qjlPCmKV9IIGo6v4zjzFi2rMm/zaSFlAOiPiVi8cgx5+A47CBcM7hwJQlKzPa6PfiVxiWNNukm0IJOBHra2eSGgiP5OVdJApmaCqzEFCVY4vBm3Dy1+/OtIhFrtWLG/Bzd4kDAi40vuZfyda2+TXxm+xRuUw/6OKnuraqXiCYmTjZjqFef3f6ggrBYi6tFTPLr2ZcgzbZNcSZWcpNWrkPie4VDAG2X4A/FGRpTDwljpDhGnKUK9W7/it+HzJ8AIiEs2RshhoFliZqcLZCJt/jztzmcHIu11t6dd6ew9n3lEaIalBm1DsTR9WRLNb3Uh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkaspCYt7TXr2RH8Uy8SEqP7m+O3b9FJfytLb+ckW/U=;
 b=FWtUWQWrtTDS8JRKgedDwSTACkvINkOWwP6rOXMeYu+u+8XvaRQ4NYt6t+dAQXdrb65RgWU5AvHOWaNvkw1jv8P0rLPLNLRVrzvcOs5Oqs2uU3IDoiwJWLFvyZI8qSoIPM16h7d9y6+qLtfSqI07Sui6BREX8xV2z9tyk824wNMzAtpBoqi0uQORhSP4NjckyF9EYtBogwTlcMMr/kvuRVYeLJGLkBtb2U4X1kyvhA9PZd9yilCeTqa2824V3do3/Zx5Vv61LyP1mktqCVKEwhX+Ceq25/bFocupqg6l3pyyNTR2dIXuE2iDfcHJUL+4NvzyuldLKKMO7dqY+iQZcQ==
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.12; Thu, 25 Jun 2026 13:34:34 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::a5) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Thu,
 25 Jun 2026 13:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 13:34:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:09 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:07 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v3 1/4] eal: fix macro for versioned experimental symbol
Date: Thu, 25 Jun 2026 15:33:07 +0200
Message-ID: <20260625133311.1299705-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb2c3e7-a16d-4e5c-81bb-08ded2be7e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: auKQRHhNYE/emXd25GsnfnhKtNRwhRBJ0ljHgRiM8L6wEyTSL8ue32i36viZlgNzHjbS1zCJS0ofDmZa9DqW5kyog20oa/c6mRppzjVfmlFl2AhWVRekE5R3KXXj9GPzfqGO2mmqzICMIrI3bfcxHZNs5cVI+m0f2FQtqb8ADtTv/7XnSLjEaBkw+ppAHeAi7HB/dAINjEG5+FKwJYtUpHml/ASYpGmz22PbMiTZTDz66PE9dqPM6Ip2fvItJMP7vOngEvDrrUAU4OQds1a0L6z91H4GCl9MmfBnfrMqexITXYSkEx4uc6Q/XOKbmAdNSJphYMPDzOwOEhAmD/Mmz7VwqPiUqEFNgjCVvz5EMDfWzfJe2Ig87lMq/CQ+swhAZIw6k6+v3UuQMRKs5nxnpe681MU4a+/+w2LNug8qxcsfT5h7tqhhOq65K39MjUce+1J4t5KlNkYOWO1kkQk0k6paD9JdOIPLPtqvqI05zhOVofyVFczAUWKKj0ZUvN8nU0Pa2pcsCqE4FKxCPU9jkWugAKyXb8DAstI4rFm2MyHNSwclRlMR0KkVc/kLsWe4ZXfJpHyQRE5dzRXjG6I9eAr75GZd8WL/FQz8P8WNTa2JzEpyN3dJuuoCEd5Qmus05lLPipjizfK5BqPgpl9VgtqY+Lhj+xPeuvesV0F03zktsI75vlyTEFVob+tjH3rliP9lXyZ3aMv8+ryomFNY9Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 11qXF5qMG9rB/jdgTG5Er85dm/FJCONd/HEpd3OXm5rTwmvC+EPlJw8pUs7TLcP4ahtlZRJ1q4m83j7oF1O4N69AnAF5dc8SreMtTdjYoB8Jdu9oesRq1IZz6Dek1OK9mi1n8A1q5qRKWHqdNqmiWN5wyfURiX7Ok5UFhvWgOCperngQGqsLnNGYckXq2FeuHd2WXSabj7p0tWrk5C1oSuTlMiFkB5yP4rvbMFogWgOd8cjlaEz9P34Ii3eT8mn5G2mYQ7Szjz7aYkCRB6RXY3BG93JN4bxJACiPEU3GX1JFxO+fdhhiN2gSt02cIKGtVb5+gc2s2yxOhjsr5/eaDozrHhHGtuh6fwxpFMjD/Po43paWyLm6A1SzlALnacmwNI4oC8KNV3/6hb8DqUbgyoeVTDsFXhRn9wYnD4uHc4C9nVK5fhnFJxO3Nt5r0OLm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:34:33.8713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb2c3e7-a16d-4e5c-81bb-08ded2be7e77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
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

