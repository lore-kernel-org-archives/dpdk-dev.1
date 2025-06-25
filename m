Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007AAC7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 09:44:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 168C540667;
	Wed, 25 Jun 2025 11:44:23 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by mails.dpdk.org (Postfix) with ESMTP id F2A4E402B1;
 Wed, 25 Jun 2025 11:44:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rszxyp6h5Neq1UL66ItaNhOrUYRiTea1FF5q0P/7dDJYCgaxLRyvFTuKAmAedlBf+kwbYjTbuxhJdOAoUAYzm7X+bNk3eQeBKDzvC4xGiCmnH5tjr7e9Byal2VHh+T9nttZSZ4/Lq9D5OtBu6K0d641Glq58dUbtb/qXziP03NLvZ6fov/AYhGLJAaf93BtQxOYh6x4g1u2+Q4zDWq+rIA5w3YSVg8F9AxZ4RyQva96LPFWAbAjq431PGdH6W13uWAeqH47zEvlNT6qKS6RVyT6bGCTK+zyL1qzz56QgS0PkclG9GskbU5ZVnma5Je/ClVUazseybK9kIBkBW2L2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX0gYE95zgPy6nHhPapp4ghmB6Xru1mxrZaMUv6khMI=;
 b=kUedmDuonM6WuCL5AM9uKtuMnnU+E+JlNb3r+5UUZuvCW0hTWa2uAW7bGJ+zW+eNu46i+HnQhCXsuTYmG0ecBo9SVry+XAjhceVTx9rWSwOKijzwIQhGCp+n7GVDIA3QoNJ6x8K5Q9THjG1QlaQmlSe7D5wYHEF2QreJEiMTNxpJHiO1Q36alApUQJgjzHLMf/h6i7i7+DJfep2F2cTdXZD6h3Mngm3C0p1lyrMyW2wSJGeM4Wdoq1Ko+fK+ABb2U/Jx+r0O3s+hLYlvjcnt6EKlMOHLgVGcDWe0VLvrNvkKwq+d1G3EeilX4m4r9TZqHXAZYJ8OGSptgXmLrBefhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX0gYE95zgPy6nHhPapp4ghmB6Xru1mxrZaMUv6khMI=;
 b=bAD5LxNe9m5/QhfP5Atu+95g5gjiy8GIytNyv8Q4OZHvfJsrCFSLE4kHSwGzLlcg4E2bCku+6y2rbny3xdHF3I17iVlZY6xD1p/aY/5ggV6w4hSHyTE44ExwVNDXK1lQFucO35ikHPNWLegfDMX1riH++zYG50XlsL7FmKT5wrEogNP+uaZGNB3Noh/gYWjONrWYqpXEmdnrDbK0pIQ3QzPK802geXbceD1rFSgivtosLxDDFTTiaxSP6PQ6dsr3tazuSHP6b+DEou53wwBvECf7eSyWxYdrR7CeMfwGFP7AzWmYHTNn42rPnksOrhfgHJaXgBdnULUWOynxc6lXmg==
Received: from BN8PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:94::21)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Wed, 25 Jun
 2025 09:44:17 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::a4) by BN8PR03CA0008.outlook.office365.com
 (2603:10b6:408:94::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 09:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.1 via Frontend Transport; Wed, 25 Jun 2025 09:44:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 02:43:57 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 02:43:53 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix access to auxiliary flow data
Date: Wed, 25 Jun 2025 12:43:39 +0300
Message-ID: <20250625094339.344416-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4f9198-edee-4379-b5b8-08ddb3ccda4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8U9LNtq75j3oFxggRIIasFunBHhY16EBWEe0puAYd5YkKD9f6bMF7rBN0FZF?=
 =?us-ascii?Q?v04zFN3GmdHc+5XBeNe71NGlL6TlEflMKGtwUtS52EmFjcdRYpbB845s7LGt?=
 =?us-ascii?Q?kNAsK6spwHUe8iojxFNOSRNGcw/VjNgC2xQsvXW9goQ3FFApOOu2dc7qEa4L?=
 =?us-ascii?Q?xqq67hipg4ymU9Y5luEf0qiHeu0DKHBnTXC3cIBJsM6t49XAMuFHjy6eAOCU?=
 =?us-ascii?Q?joXOQgHRDteGvHHD8JaaZlWADzC09z4BfweYnAQfdlN043cFTIIqkyVUwrz5?=
 =?us-ascii?Q?kvAH0ZbAr1vz4vTUf89R0Ir2rYAfzkPFcYA/vg3EWv9CCNDvdzqNgQ8SWxq8?=
 =?us-ascii?Q?zBOEv0Tyq/RmSkLj2jrQFJ6n1D3kiM1Z2CcKX8c2+9q+ViM0OtpNeiq1Vn+v?=
 =?us-ascii?Q?ZJX6jI9BEfd7R2i8X7PrTedHaSpZ3PcB97ISDYYn1b7iPFHNi/OZTEKxlnxO?=
 =?us-ascii?Q?2JTKt5nvMYCfGCYmejC65KEBx6bJINW7thvPv6PVI2j8Nwy4InyN3EuVaS4J?=
 =?us-ascii?Q?dUO739WKHyGsylScX8l9kr1+3KOXLR9YUe+ze74HjW2002uq+PKkBuoUNtsI?=
 =?us-ascii?Q?OGmSRBGVRIDTVYOtfU8JRe9hxWm2CN0Y8PTISJzEaeYcR9OSjK8dcGYvUsLP?=
 =?us-ascii?Q?ujbkqf813LSIXlfNDIzZqpOROGgjxzia8MehfxoxImsmIqZrXk4TBIeDk4hh?=
 =?us-ascii?Q?iJETmAdUKJTk6P1Pe08SmvPvMPluk05eKwMdpjIWR7hA0GDq4zsPgc09R/NN?=
 =?us-ascii?Q?T8poimdsZ+IYr8Z0Olgcqs0/nnVVhEVfKHVK45HInFLKY2oBFewjTLVU2F2a?=
 =?us-ascii?Q?c+jewo8TkwYiHeSCjg2yfaBuA6TQtuY/PX7ZkE+Q+NRBf6yINJbLvzajZdEB?=
 =?us-ascii?Q?7b2I8D45sb4zIW5mkuXSTLoXuoF4/inCgzNuxILzXoZ4lxQeISaxyxLlY8f6?=
 =?us-ascii?Q?eiBt+QMhKDkfrgJG+rV9gP63HrLXcDpAOfyWzpW3h4ID65etfBD9S5BSMdnE?=
 =?us-ascii?Q?MiLpFm51iFI4DiV07LDN/IAQZBXwZWN0LPsPrA6/rpwDjJGIr7IOFbqOH3jl?=
 =?us-ascii?Q?VlXPOp3ONEcP9LHjzq5B6gdGJ9k8izbEWrCPJPNDl89pm7/Yr+EM3IDPGvgQ?=
 =?us-ascii?Q?k8Be+mhfuL4KPISQrwh5l3nrfzW2aIUfFW7lubJzZSS+umazb3lGOYqlyEJr?=
 =?us-ascii?Q?Rt5ts3delIko//u1iELddJpCRPA7ZiA+cHd2r4kdbaJmvjRedaYg6xES819e?=
 =?us-ascii?Q?hV6wX1lmAVGCTOMCXPWSZdqCUfZpY8IhKiuSHxuIloETOaMhvf7cULdQW7bb?=
 =?us-ascii?Q?q8qc6CPIgYoZ8u5XfseJ4d4kpI4yNtb89viecEZD6tXvhPFuR70WO9/zA6TF?=
 =?us-ascii?Q?LM3VwdgC7LlxektXgFPt2cMLw0e/ASZp4OchAE/FuzvZzZgw6yoa9SPtJQhz?=
 =?us-ascii?Q?B41F2YEoYhiP4nMpIPslU9x7/HPMN4GzXF8ipwb0VigbPIznMCv1rcyxYru1?=
 =?us-ascii?Q?8Mj2Zvh2IFzAmnthVLXTGeS7bb005dIT6+zj?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 09:44:17.1605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4f9198-edee-4379-b5b8-08ddb3ccda4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
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

The MLX5 PMD keeps non-essential flow data in an auxiliary structure
to reduce flow L1 cache usage.

The auxiliary data location differs in HWS and non-template flows.

The PMD tried to fetch HWS flow table from a non-template flow object
and accessed stale memory address.

The patch separates the `mlx5_flow_hw_aux()` implementation for HWS
and non-template flows

Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index af2e7a84a5..d65f4cf4e2 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -129,12 +129,16 @@ mlx5_flow_hw_aux(uint16_t port_id, struct rte_flow_hw *flow)
 {
 	struct rte_flow_template_table *table = flow->table;
 
-	if (rte_flow_template_table_resizable(port_id, &table->cfg.attr)) {
-		size_t offset = sizeof(struct rte_flow_hw) + mlx5dr_rule_get_handle_size();
+	if (!flow->nt_rule) {
+		if (rte_flow_template_table_resizable(port_id, &table->cfg.attr)) {
+			size_t offset = sizeof(struct rte_flow_hw) + mlx5dr_rule_get_handle_size();
 
-		return RTE_PTR_ADD(flow, offset);
+			return RTE_PTR_ADD(flow, offset);
+		} else {
+			return &table->flow_aux[flow->idx - 1];
+		}
 	} else {
-		return ((flow->nt_rule) ? flow->nt2hws->flow_aux : &table->flow_aux[flow->idx - 1]);
+		return flow->nt2hws->flow_aux;
 	}
 }
 
-- 
2.48.1

