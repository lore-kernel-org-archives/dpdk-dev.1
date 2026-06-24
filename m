Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5831DCDE002
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 13:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55DE040669;
	Wed, 24 Jun 2026 15:15:10 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by mails.dpdk.org (Postfix) with ESMTP id 4B03C40687
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:15:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPvMaK4NqnppBdA3cd654sDde+4Bs7FTK5RhcyOKKxy9ZDfo+Ypm0zYtPZrUAJDryxme+KnoxqW+VXzu+y9n40VqbgRzJwqJAyLSWVi5Th9Ys2Z/1zU51dbTZD/34yqvsmDsjcNiDPq/3Yg+ctdxmHjS8QJQoPRXA/v12QdCsOBiOKAEsiTd/jTwihmXPvFPhDlmW9px8V1nZTafAhkFV7hD2TmbJYwwv/A7tFKfWBW+0F1HpE2dLfkfQi1E272N/KyxKYz3mM3WRb8wbUgruuvsjD/p4hDQDEsJsFWIx0KWdDq6aHZaNENYiSV8iI4RW4UJz5penVkxCVQ9nG+fRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld+kycsHXve+vpDl6v1tOZT+JGl+dQd0ZYBHJNSG39U=;
 b=QkE711wNHBlot9YnL3m+jTqLM1HFHuNYS+eH6mS0BHKzo9LVtVGfD3vDhqA0Cti0SAstpbo/gDU5ea7iNhQDISZD6YR9xafxI9SkIKfX1naR0Ubi+FbGMumltdztaAaoz8S/UAZXUAVcea9W/aH+OGJonXn64Uti+U2Luei7RdimXfz3V1prwWEIxcilEaT+eAnfM5sIeMQHyXo9nEJsjIENgfmRCOmLMgjvq4siliUZfQvwExJpZvg8pHmDVSeE9pDAc7f/8zb9Vevctu//nRhb5bMEkkXNMJvUnU4Y5PUCEKK9kdRqGTJV/Jv+LxZAf7ea3YoM+M4Zpe6pvAv1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld+kycsHXve+vpDl6v1tOZT+JGl+dQd0ZYBHJNSG39U=;
 b=RqPJlW2RqCjUATMSZuR8G9Q0594Q0DUaQdXg8RkuIxDURQvnbs+3G2lYPt8PmeMfheRecycCzVx4y1W5BOzKLMCTeDsJ6Ol94zzy0a0xZ4cfncoXGVdOLq5Vj+fEQYJ9YxXl7qRRsLlA4B2kPLU90lzdSCHURYl7O5vAx3fWtRHfdTfsnYlMwWKVL2kG3UpVz+Gqph4qENs0dIklr9R5dCAYbLMvlHQ15N3LLWZg2stUpcELuYVK9iNPagbouOWn2F9zvT2p7L8jvu1LAjE3MZMddUUWIjQRWzh0M87I72hyJ8GYD3c4YxpGqOSO4cWdzwWEeGzodr9dGcPOh5xOtA==
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 13:14:58 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::33) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 13:14:57 +0000
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
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:14:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:34 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:33 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v2 1/4] eal: fix macro for versioned experimental symbol
Date: Wed, 24 Jun 2026 15:13:33 +0200
Message-ID: <20260624131337.1127323-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: d9984f94-a8cb-4d9a-49ef-08ded1f296bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|22082099003|6133799003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: LNt+XF3uTptKa+pZWJvSIA5cgqboFlGOemD5E84QvtYqlFcae1BwDtIRShxWeU0zmPjYFzgZWAAOg5sb3zelwMvtPHX7MNbNeE9K6AVfaUFCErv0gXw7NdCk73cPyAh71bC8kET0XIb9jnnwfFXeW/Ft2TUjkHKQldQjDJK97hvkkEKqH+e66H0QpqpCvcDAtFwn3wz9Fg5TOcmae4G7hYFZsUGgySTlSNfVkrvY9OFiVqS6csOAlesu3pJbKlTfwAGszr0akrDuq/WjrJ2XVo2862o9uSzPegBXkHn09gEI+nnxFP7TjGwQaxKSh50bxwtKpbi4WqkfQz3pIFI8yZHdPAKXif1nhM9G4X9hTCU57C7Uv1U4NalVM0ZuPCG79GCRH3i/2vnQXarijU13KySfBrNnOxnjI6oUeJbc/WmBahNcmQ7O4CYezgh2aH1tDxkK1oyMcdDmjc91gD0jjhuUMlIj2F3skLI1hzpyxuldUIEZRZjyFOa3HlZHWq5bsc9frSMBhShT/m5oXTlGJSmHfiy3kHy8CQAXOvZOZ5GHuIDPbyJo8cn0fTbSKHvkB6b3miR+pgjpVgsDjKPgtImV3Nl339Q0GGNk/FsaPpuEo6ADpehQ7+bHVPXGl0zZkSy323jk4nM+/3xZ4fqs1X5ZUj1J1SIovAb4QA8IqR512HEONXDrTgDQXerjUb4QsQ9JSHvhwIduuN2yOrJIdQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yhR5+1ckdBIoNvnFZvLczcIfNU5vpqz/yP1AiJ1lttrm4mSgLdp1ibkX80Zi7vnQgWkrcOIU56YqOmkdY1owGNo3YgKoTFCEyUOzerohMWXTCjs2x4gw4G7o1Gui55a2zmRJj7PDZhnw4uh2aOiDWxQSwDeegqum2uXY9zTjNG8oG+AV0JT/wpFhe4T47+NKw3Ltkw8zGteDn8iNleU2x2+55DQceQZPHUbkYeDk4fdboRaxuaYiR+WZgBSPDxEVNoHeRYMHyFojqHzGtLXf9URDdIyhuOxCE9ZA/518i1Cjqrw9nsTH7Q7YO6O+wjb0/PSnaTJqx0Zut0GuMV9Jtt4c+aYBQd37NAFM24E5SIIlJom5cjtY1BTqwztOXMUqcSI+zzD27WAXuVU2rk9xzzwitGEmAgcDZ8DRg5tLAHnDYQtXYxu77IjkLp9r+G66
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:14:57.2608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9984f94-a8cb-4d9a-49ef-08ded1f296bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
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

