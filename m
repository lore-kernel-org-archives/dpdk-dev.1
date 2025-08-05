Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F30C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 13:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5209240BA4;
	Tue,  5 Aug 2025 15:21:40 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by mails.dpdk.org (Postfix) with ESMTP id 5471740A4B;
 Tue,  5 Aug 2025 15:21:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS5clusg7IKCcT/OLeZ1N2kV0qjHKQxwtr3+pZkRGbOyLYBbCJ73kI/CZBBWSad7PcvBQuDRbKgZPZrAVBx4qvgS+ks9bFYl9sLZ2eQ9+p77eDpbBmHrGxQ/gltE352x1XRgc7xMEwqzuEJGiu35uNvpAakbv7mjQOvDXQtpAi0p9G9ZugeNpswUzBpaJDHayPwvprhHVT4q+bLlbyXrXX+/T8b/8TF0KXxkzojE/P/hBXKHwL5/LCzD1V5DNwSufW80QCgrcT4DVgj3+Dof6fVBQmZoVrpxjJhgpM9xRnMN2TGTcdou8ZQ508FtQdPUddNu+acR0QN2OqOFhsANmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHlXTLji+ndWMlzgJCUw0nx6xQ49bcrPSG4ZlMVs9yw=;
 b=S0ZA3a3k9LpJmZzAnEbvZGzx6zDtV6PZnx1Tt0yZ5RFIPb+/Y7coFM34dqWhMXvFqW/FlF95iJk36Uhq+nS7Ow5GI3xrtTnQ81d3jJffupulZTKM1NUxXYQjAKhugUEf+SLbBEsMM51Qg5wK5UvoFwL6elz5IBMCZvk+pJ572zllMOfaI/oevEpYDI/5TVQ1qbQvYv0GweXBdQrUda7EFb9XjGT8NbDjgW/ypgtu0dm908WHCHeoCT5Uv5c0YqFcBW1ostd8cbDevdpRupPlaJf7fhD7hph6QeZTfTHDaHf88zcTSZdyG6vDcCe4DUF0daM73kn4DAGEBsJnT8ZczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHlXTLji+ndWMlzgJCUw0nx6xQ49bcrPSG4ZlMVs9yw=;
 b=bIgC1px+C1WFEbCS+Pahx0DITCn0LJJymmfucp5mDofxn/8I8SwkGD8RsTpreTi1O19BIAQmE2aQu+GKY8PmrryTVMnuH8pIApAScWslkRx/SAs2CFdemon1y4zgfnbamJFN7M/TL8N1op3bWe2KCswB7n7gCopX8Ltc0eQ9ixlhOSzJDlm/l9CHzbkK4bMa31q5l1iD3UycosUzI5NKOlFY4jX+hdG9Xk7AlU+3/zXpTWORn64+fhz/KJ2HyQaQkZ3FEcFm3F08vmKIbAh6+H3eS/eGl/sUsoKlaiBxPTMnxSUlJ+4i9CRQmEpjGKGjrwEBe/zakl8pseAI8ePETQ==
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 13:21:35 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::ac) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Tue,
 5 Aug 2025 13:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 13:21:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 5 Aug
 2025 06:21:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 5 Aug
 2025 06:21:05 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 5 Aug 2025 06:21:02 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH] net/mlx5: fix ASan issue in RSS flow creation
Date: Tue, 5 Aug 2025 16:20:57 +0300
Message-ID: <20250805132058.50966-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c112f47-b699-4ece-1cab-08ddd422fffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ui/KHjLG5zoYtgWAw8sA7QFzyQWw448nWiG4Zn1XzSkoN57a+DLV7p0A8PFV?=
 =?us-ascii?Q?YVrWAvkj0+mXVVGWOFOOCEG0PYOKAErURm/DgEhbIjusG5aGy09iKjDL+Enp?=
 =?us-ascii?Q?IkMDw2Zg5Uu5E7pT8TL7Fyf4oQmSnV3uu4PPjqBTXyibj9rbly5XaxcoSmUR?=
 =?us-ascii?Q?FuPn4nJySEUSgMNpmJAXFQv8jBYWKQxfOTvG/KlbW9sW3eywlbDFdNlLZ5Qa?=
 =?us-ascii?Q?aQf3h/7wGQ+vSHRggBBUniXzLZpFCHxOffmd424xio8Qgt54F56poQ/JlG/m?=
 =?us-ascii?Q?31Jr5gcIQIrvsCGDMIKNvgPIBx1Dtx1o2tAAzxwglrIqTCbT+QBt/YiRf/N3?=
 =?us-ascii?Q?+nZbgLu2lhSu3ffk+ok2bS/LdJqVjhD4AR24MQX9UMeaDYl70ezmOGfaZq6u?=
 =?us-ascii?Q?u9Ty+1yuvrjpuYSU34AjPC1gTSzAHvYKFNk/DFUDBOtmrem3XGuTRpf0WZ8t?=
 =?us-ascii?Q?C5x5ux+7ccXvKDRBArnHRJWhbHvwn7JR3iWa/7Wpeei+hXVDLmVnK+yDR5DU?=
 =?us-ascii?Q?ozMiGGjc4uYBL05yWcs5BvDyz9DE1OG3jeaiSolnTbV9kA4N2ac6xxjQoHq8?=
 =?us-ascii?Q?Q+gXJRnkzKitYpJXUadRYaGDGJ9Y1drpXx8hGPepv9krVtQRs1LXNV6upynE?=
 =?us-ascii?Q?6XhD//ie/mfFDCt0rL4RBUEbPKArSJXur+fcd1J7t+pjX3tXZc3C8/QDxyBW?=
 =?us-ascii?Q?HlnXUvigK9Awx5fuMBPoPubXJSIVSY5MK6uT5p8sXwBQK9OWn36H29FNs24W?=
 =?us-ascii?Q?cHhfLO1IhP/b00Hffs1CgOgYWSpqKgM40XhqiWwkLHW1nfzNVNMFZt0tpHyf?=
 =?us-ascii?Q?osYkb7SvsYGny9NTvILDsbmDLTZQ4wGqrp45KVWARfgj+2u0zVz3e17dR/5L?=
 =?us-ascii?Q?BhLI6DJeiX/1cnj8oC9VSi/gi87xBRxOu94+bQiNqgV6HCnQRVpUr4JdXu+F?=
 =?us-ascii?Q?ovM/KGO6cO5d9NXqQQcMpMWhgI+Epen0KaF8A3RwH0OLY0v3fv2OxwF4BpYM?=
 =?us-ascii?Q?av/SOQ4zyGbxPqOQSOFE1d3fAUJp5stmPWAOAIKT05VxYJOGpn2p9f/ool/t?=
 =?us-ascii?Q?DnjkkdtxpRVffVhLqdR6O7eSikc0jeDFocSR8Calx4n2RlKeDchCBc9KnlOs?=
 =?us-ascii?Q?bGk67IdRP25U5yaUcENogqvyn4ybAk3U7RvgTGn9bNlZ3ItRey7LwDEEjYUK?=
 =?us-ascii?Q?3pOntl7idtqT7cMikhGKga12jv/2nlODdiAcdSiYj6WCrTMbA3aoKOMdAN71?=
 =?us-ascii?Q?L91dRwoQ1cG4t/2pcS0pkM7gQqjRPgHS0QGTefWIk/PHSn1xHhvaOY9CV2KX?=
 =?us-ascii?Q?eItlcpxO0upPGxiB2499W7GpP5oJWZBWVuk2VBYcO5OymdVDC64UHX3fGRrt?=
 =?us-ascii?Q?9KYkce3kR8aZWTnLBLpO5A7ullMh79zZI0fnc0i5+ajPtH9cZn33MNQnFCVP?=
 =?us-ascii?Q?bP8qNtgaGv7PXyexkZgFln//ieym7V+qtYS5lmq6VuSi75tZGn4bV01LlZ4/?=
 =?us-ascii?Q?pYOVghlTShxd9Yn+SOOyVPhDHEXAEebEqU/e?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 13:21:34.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c112f47-b699-4ece-1cab-08ddd422fffa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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

This patch addresses AddressSanitizer (ASan) stack-use-after-scope
issues occurring during RSS flow creation in the MLX5 driver.
The root cause stemmed from the use of compound literals to
initialize flow action configurations, which could result in
pointers to temporary stack memory being retained in flow structures.
When these pointers were later accessed during flow conversion,
the underlying stack memory was no longer valid,
leading to ASAN-detected errors.

Modifications:
In mlx5_hw_rss_ptype_create_base_flow(),
the struct rte_flow_action_jump is now constructed
at the start of the function, rather than within the do statement.
This ensures a persistent stack allocation for the structure,
preventing use-after-scope situations.

This change eliminates the following ASan errors:
stack-use-after-scope reported in rte_flow_conv_copy

Fixes: ae67e3c43dd5 ("net/mlx5: support RSS expansion in non-template HWS setup")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_nta_rss.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_nta_rss.c b/drivers/net/mlx5/mlx5_nta_rss.c
index 8f005104454..1d2940a370d 100644
--- a/drivers/net/mlx5/mlx5_nta_rss.c
+++ b/drivers/net/mlx5/mlx5_nta_rss.c
@@ -320,6 +320,9 @@ mlx5_hw_rss_ptype_create_base_flow(struct rte_eth_dev *dev,
 	struct rte_flow_hw *flow = NULL;
 	struct rte_flow_action actions[MLX5_HW_MAX_ACTS];
 	enum mlx5_indirect_type indirect_type;
+	const struct rte_flow_action_jump jump_conf = {
+		.group = ptype_group
+	};
 
 	do {
 		switch (orig_actions[i].type) {
@@ -334,9 +337,7 @@ mlx5_hw_rss_ptype_create_base_flow(struct rte_eth_dev *dev,
 			/* Fall through */
 		case RTE_FLOW_ACTION_TYPE_RSS:
 			actions[i].type = RTE_FLOW_ACTION_TYPE_JUMP;
-			actions[i].conf = &(const struct rte_flow_action_jump) {
-				.group = ptype_group
-			};
+			actions[i].conf = &jump_conf;
 			break;
 		default:
 			actions[i] = orig_actions[i];
-- 
2.21.0

