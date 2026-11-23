Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3549606A321
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V/nwbk/l
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3653140262;
	Mon, 23 Nov 2026 08:30:58 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D4B0400D5;
 Mon, 23 Nov 2026 08:30:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dU4pXbQAZSF6MGg0wBXyPQWjeXyn9UHAbZb4qTpCWO64sLl4GfzDBMobe+eP4TjRmUGlAnNyi9NdTUyHA1fIx1zOI5MrEHlT5SW6hydJCMPKSbuqMrDJW1tZvh8AuiLLy6PgxYrvBv3fDeJKzcDsaX38P5iftvAiLR8rAPChnIdfj2waUyZvhEMTfWA9Uu1pHIYw69u3dap6B/sQDkxiKBJp5bs3VmcZtjp6RyzHGMdgNtSd/DCZxh6p7cGXtS2O6JXL/JMNPeUq4x7fGR5oK1GiUw8ySD0Re6mYw0EickO++FxAMuo4DmlfzbgcUfbj3B2RzuedQQUoillswQBc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6IviSeEThtXdrSmjGGJVkn977oz1evmKDCPdp6wsvI=;
 b=d1qnj4IcPKKaGhKq+RPpGh2fSJ6cv8hU0YfkIUE7hKfWAxX7PRO2n6doWz0kD+jfPTXkWz9LWZ+rzrG2Iob8VMgb5Yz4Iksbush8shb+L4KOOcZf92vy10ITvlG0f7N5gPvpK0+rqBV4+pjm+GUva3sUPhJS0dnf4hTEL1vQ7vLdb0p7aSU3tN7C1ln+UEZSyPFfzVTtXUA9Re/HU0ClP5WtrsZqrivhE8cL9KX8Xhc4A52QeCiDsKZLyJ9I4IyLd6TwVhGcCzZcaZ///DQ8EARwb9YqqYWEzRmx2ST5alwhUF9kGGrPM74IZomVSaCrqMXycjEz9aQW9/Jdb0IdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6IviSeEThtXdrSmjGGJVkn977oz1evmKDCPdp6wsvI=;
 b=V/nwbk/lkzk2tws5Sr00Lw0gkI1uTlCuLloZ2Xp1jsrHgaBVTSKkXnA6iTUwQErpwqUiVapVRRKZp+2ZApb9Q/VUOoxVzHmUnEcPhR/KXE15fEGbnz2IwGTGh/jJY/klomnzgf+MYr2ih7T+sAOOYYcU/kXeIbE635p2zufUr35hQtv3zaqVAMG2vjNMjxu7qXxd4FKjkXWnsoC582IzdBebVZO6ziqZdp31Shjr4EQR6AqYRqp1TSYVBzzffNzVTSBp71z0SyFw7aQjX4/vb3eLUp5g7YDXzFGaTVoA40EBLwCkSD2ZvelHYlOQ871m+BDuX4uJcRmVdh9GZuMV5w==
Received: from PH8P221CA0053.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::18)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 07:30:50 +0000
Received: from MW3PEPF00001652.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::74) by PH8P221CA0053.outlook.office365.com
 (2603:10b6:510:346::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 07:30:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW3PEPF00001652.mail.protection.outlook.com (10.167.249.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 23 Nov 2026 07:30:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 23:30:33 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 23:30:30 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <rasland@nvidia.com>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix the flow list breakage
Date: Mon, 23 Nov 2026 07:30:07 +0000
Message-ID: <20261123073007.450065-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001652:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: aa867fe1-0ec7-46f3-cd06-08df4933b23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|18002099003|11063799006|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: djX8MrHhzY91chSSoHMNvbuSS447bhBl2OZjdxmc1g4sJlvFnp98xpRQowvdTJnecIXZjZFTQYhvjq4Adj7EDhpLH4uzhQGFlHGAkNAxvO6SyoVkxOxi+8UgjZYGkh/xC8sYH6toxvxIPSAmwY2DNbh4Vb69VyoqxygU9p33BGR0ccL1OFaJTvbsWemhnLEoPA/L3syRADqmM7bGiq0HfwFlRliinKSjwIvE9G2CLQLoJwy/RFxwJAqBsP0Qt2Wh3Xi7IXfHkJFe8dmx+HsuSOIhcjTLcg+AslBH+C+uYqqmtcInLzNv3F/kjH/DM3O17u5jVOwMdB/0vB1jA6yXCbtkDAMfOtWxYuAk5GbqNG/H3AleYCg6ZrQtvAFbbn+6KiQi7edlrOSLa4qHVs4DqElXIAAG4GenUBWlxulW40TdDMzpZTYI7xdXgHBwxkBVxmWPMhxdF4yTBKENeQJNIzKwYIDbO3qZaOalVCo2cl9akm+rUI14kPqagcq9yhnARXRpxaGKFZLLprxY9642l1Zmjarav7XPkFi74hWUOIdbZl/dYptCgNY78gYZqtl2BAO7X/B2mfqGzkYFE2TIjtvV43jslozX1VMK+GKR5tUtiEOsKo+c9OGNZAhQqTxeKMsEoBbFYfoVuaT9Zfjnmj0MiWrc62QXh55GXETqSeVxANBpLhPxhBNjjw/zV8E1kpumaRWE3pWb3wi/JwZyXg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vm8YvoIHKpyxPnAKrtKgEIAqtiKqyYkKfs8tIsD15HOCkjmNiFEZ0sFtdllz9wxkPv2uLrI7xnGsWdnvSoUkgiFdAYxFC0igdzQawO7zmsfbKImFPAO+IAU8EByIIorX6MNqqSOQG09UffJjgl0/NEFS2h3CI0+Y9LI7hXxnliJ3KvppjCd4K/PdUdxAf7S0a5k7dB87Lr9M5qzpgQ/qMIpV+rYZlUEl6AinoqcVjRnjh33K88Cqz8Dj8qS5QOrx59+nULbb86BDzRsnhN8S2YP8WGPplvWIOsLiT1X0ENMcdstSkqRdaKNMZckWOJQudxtEeWzjf5qHixUpPId5z+jIaGoEMNr2kpAmXrA/khARTUosvWhAXQVoDKvpHuA3sfi6/VyMVoDy+Z94P/F13bHPG0TaS/tegZRa6M6GAcEf6kR07hh2U9y/y914pwp2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 07:30:49.1406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa867fe1-0ec7-46f3-cd06-08df4933b23c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001652.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When using synchronous API in HWS mode, the implicit flow splitting
will also be done as that in the SWS mode.

Now the RSS expansion and metadata copy are done in order. The RSS
expansion will create a jump flow to the RSS table and all L3 / L4
RSS flows will be created then. The metadata copy will create a jump
flow to copy the metadata and set the prefix flow ID and then the RSS
part.

Due to the incorrect usage of SLIST_INSERT_AFTER macro, the sle_next
was wrongly cleared to zero since the prefix flow of metadata copy
didn't have the next flow. The RSS flows were missed in the flow
list and would not be destroyed when deleting the flow list. The
Rx queues that were referenced by the RSS flows will not be released
and some resource leak occurred.

By directly assigning the prefix flow's next pointer the list will
not be broken and all the flow rules can be destroyed.

Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
Cc: stable@dpdk.org

Suggested-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6e6bf07799..f4720e0858 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14594,7 +14594,12 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	if (prfx_flow) {
 		prfx_flow->nt2hws->rix_mreg_copy = flow->nt2hws->rix_mreg_copy;
 		flow->nt2hws->chaned_flow = 1;
-		SLIST_INSERT_AFTER(prfx_flow, flow, nt2hws->next);
+		/*
+		 * Prefix flow is a single, newly created flow. Preserve any RSS
+		 * expansion flows already linked after the suffix.
+		 */
+		MLX5_ASSERT(SLIST_NEXT(prfx_flow, nt2hws->next) == NULL);
+		SLIST_NEXT(prfx_flow, nt2hws->next) = flow;
 		mlx5_flow_nta_split_resource_free(dev, &resource);
 		mlx5_free(copied_items);
 		return (uintptr_t)prfx_flow;
-- 
2.34.1

