Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E1AC87FC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 11:33:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B173A40698;
	Wed, 30 Jul 2025 13:33:28 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by mails.dpdk.org (Postfix) with ESMTP id 72A24402A7;
 Wed, 30 Jul 2025 13:33:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHh8NSR7TOogIPelcIHwEfAOM5IjW5LUy/zUOl9ntHV87ERxE9mpuxvoz7r7ykSTEOhlQvvCgn/Mpkfvi6CL2IQMQ/M27JIBl4Hm94YKGSTiBCrc/9+4kzcIIiPzULqBfTrtuyZ6JIRxrqhZ8N6LgapitXY42igrazIM1bV5exOunzslwQjAwV0WMjBaO025Tu7ZXohCqaXpdZy0xZ9VJ6q5MGTTboOkbqHoRhwhyoddF0aXw4t/DlwC1MbAPEhMZ271uxT9vWS4PlX8AUQG262o5XgEntI9Msp4So3+8W7CByM/fGGVI3cZdyiENGolL499iSJP8noRRcWAWOVocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCch7hS8ljB4e9qwRuEX1FjCrSONLb1U6vXae/09FIc=;
 b=iDm++1WcWPajpLLIlH5/ZdXddhVSJV8Ay9JLq5SsKJJyTVZIcnrG7xTAdsC5qpvKK+l3Cfj/p80Jz7z0eAaDTI5BThabAHJiDVT/LsztgEki29JPYCUE6p/zoX7V3Be5UD5mF/7IJNlCYEe1hVsefp55I9JgxzgAcsUJiFNo3K95Nz5OguKEbgtgjEgk/F4Bxbu7Li1gWKvTsnNe1mBHWNZPysnp7eD0/CaM+lC7+MIEbmcMw0JcEetpfdwGEk1hq+WFvbq+ZvfSiP4YvKm1P6xPhHtk892wr/jSja30PNfl/GX7wYhwzBWZXxXn5ydDt9X0o4suJUW95JgAokn3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCch7hS8ljB4e9qwRuEX1FjCrSONLb1U6vXae/09FIc=;
 b=Tg23DdNCEg6fbgfGG4uEF6Zk72Mpx25PVdUFq+7PJKkjFdLLNjbp7+Juig132VUlc1aId2FI28+p5gIJq1uWOThPB6r6NTv3JGuNXLwUxrf+Q7wrqYSbbG/2hCruzg0C4B5BZvmOQL3MWcIWlH8F75N2CxPIkvvFJT2YEt5mc5baPQ/YtirMG3VyWgRnRHTt5JKQu1mn0kYNG/7jTb1yw4PQD4B8aLPhoPor4s23LK11K+9e6rkM79SMteoA37FzGoZK8lMgGBAhb6WC5g/t1g5RcnHw/tlDyi0v7b7AC/m2NcK4Lb+RsAAexpvCFNuWFTR5Ptij/DktetvSfvQb4A==
Received: from SA0PR11CA0140.namprd11.prod.outlook.com (2603:10b6:806:131::25)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 11:33:21 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::9f) by SA0PR11CA0140.outlook.office365.com
 (2603:10b6:806:131::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 11:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 11:33:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Jul
 2025 04:33:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Jul
 2025 04:33:00 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 30 Jul 2025 04:32:58 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Ori Kam <orika@nvidia.com>, Aman Singh
 <aman.deep.singh@intel.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH] app/testpmd: fix mask in random flow item definition
Date: Wed, 30 Jul 2025 14:32:43 +0300
Message-ID: <20250730113243.197386-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acb5d87-5294-4ba2-70fa-08ddcf5ce2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AD5sqFVxE6NEkT3e4JlOCfvmN4rvPpf7xA5kUvANajCN0eMMSHEVdhYQGfrS?=
 =?us-ascii?Q?Vg/tqWDZ1JBOR6vZ+lTr7Ufr8/oXs9J+kz6J6cYlVGO7rn2RsB7kZHA+XAed?=
 =?us-ascii?Q?Oy89kLpu8mC3iEKZ8/dNf4Y3dM1cFPa9yG+D+ZXwjgSm7PYJ5yltzzGcgyXQ?=
 =?us-ascii?Q?w5aL+6y9BV5kKPb2TSe1cdJn/FjMdgxfdAdB8VScf57ntZO/DM+/UMuTD2Ru?=
 =?us-ascii?Q?FcH9VVY0Fe8fvQwH/Ebq1/9rKeQDFWBCwn2tDInMKt8gH04Dol66VJvqnfdu?=
 =?us-ascii?Q?Jnz191D4Eg8GES78a72TCZK+PgM5Wp2oU7YGS6Tf6iv/Xap0hDa45QnyL0YK?=
 =?us-ascii?Q?2kRJtQaYXHwhTOHmIbS4OrmpsEttltdYITHMVYOi1TV0mFBF/1WjsD5twD8V?=
 =?us-ascii?Q?RHVXiiiHLBsuXtmiBpeSguAls/rNRi28f+XEaE+GOGuHlwpNX1pHbOrbquMm?=
 =?us-ascii?Q?y3QduqHs8Perpf7q04usMCt+80haP7RxLxmEfqTnBAHLeGj4dnBTBYmF/2Bl?=
 =?us-ascii?Q?Bo4ubTYWCEQ8K3HSQ8wlPGpK3b1MVj50OilKdkOS67xbG510MibIdGUnCWAe?=
 =?us-ascii?Q?bMfmyaNXt5A1EpkguiBfcAnyRMCgnGM7kFGU/pkMdtMlrFb/tMpeMAZ3LKUq?=
 =?us-ascii?Q?ni/KP56zAjRLWH6N5Y0B9RaM5mqkxf2S9U5wEcNcPUF9ImlzDYlfV2adqPrT?=
 =?us-ascii?Q?apw9eQS1Sn4Fpus1MyWaRokie5C7od6fE/BDyeb5q2P5yuJ+9UIemRfWgGey?=
 =?us-ascii?Q?iRtrErKGiuG3sL/EAMAflc8kEwM88HYsf1LohfgbqiBGiifYh6Ejc1prhtT6?=
 =?us-ascii?Q?kiAWg7KLbP6oawwHfCXZWwUJRMsBexlN5+ekgKPXyKg7t7UtTdQ9+PtapgMr?=
 =?us-ascii?Q?AZyVYWBabDlF20i1Iw5UGer6JOpYwurGWjJzt7uoL84+9Wgz4kHMIiVHgnGm?=
 =?us-ascii?Q?adoFoWoE1oP9y8VihhLPSpLWj9B/YQJKavWuzo7osJmLNyDveP0GQwCV1Jl2?=
 =?us-ascii?Q?xc+5PqsX8tpRr4bBdraMZN9eQ/R3X03hSo41qckuJFV1/1+M293Moi318FSd?=
 =?us-ascii?Q?OAOQkgQiEbhodwSvTiFp5j8mETmyqTCYfxJ8M3NhKGNP6IBiPEyesESHd/XK?=
 =?us-ascii?Q?rQqsD7v1WfLGvUoj/RFo6pxYn2ZjtR/tze33dvLb5hvFj/Cnq1d6Ba7rielO?=
 =?us-ascii?Q?LYLpmvxV2VAU6Tr4JOuf90/GLuNX0/iBYtIGLmZtctaz4mTJuILvvq4ttbEN?=
 =?us-ascii?Q?gKK/BM538CoB+4POOGF0Mevn8KMsuUmJEP4JezbhPhpPG73GZA1gRC6myaZp?=
 =?us-ascii?Q?OUl4mBnRIJZiCRLoysAPzkCojywPpkUwR8XJxZphxZaIxVylvyAwOAi4roW2?=
 =?us-ascii?Q?m9K54950hgNjBxQWMt1A8ZdTFd4CqSwDWM1fx1g9cBQLXy2Y7OCNurtUaeBy?=
 =?us-ascii?Q?A/pB9m0b0b5jG4XRvVCAr6Ay259/udhV2LnZ6RMRyi+7fg1ejT5t9kDHK1PL?=
 =?us-ascii?Q?vLSDygznVlZg7JiZZ2HHPS9j3HgdGQINMFrT?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 11:33:20.5804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acb5d87-5294-4ba2-70fa-08ddcf5ce2e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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

A previous patch addressing an ASAN global-buffer-overflow issue
inadvertently degraded the random mask value translation.
Specifically, changing the mask from 0xffff to 0x0000ffff caused
the value to be shifted left by 16 bits, since Testpmd
defines arg::mask as a byte array.

Independent of the ASAN fix, the random item mask specification
was invalid at the API level: random items require a 32-bit mask,
but only a 16-bit mask was being used.

The correct mask for this use case is 0xffffffff.
This fix restores the correct random value translation
by applying the proper 32-bit mask and
addresses the original ASAN issue.

Fixes: 9a18070e3fe4 ("app/testpmd: fix flow random item token")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 app/test-pmd/cmdline_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 83d398f8eea..38e751f3f3c 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -5591,7 +5591,7 @@ static const struct token token_list[] = {
 		.next = NEXT(item_random, NEXT_ENTRY(COMMON_UNSIGNED),
 			     item_param),
 		.args = ARGS(ARGS_ENTRY_MASK(struct rte_flow_item_random,
-					     value, "\x00\x00\xff\xff")),
+					     value, "\xff\xff\xff\xff")),
 	},
 	[ITEM_GRE_KEY] = {
 		.name = "gre_key",
-- 
2.21.0

