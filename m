Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DDC44506
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:19:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3221040298;
	Mon, 13 Jul 2026 06:19:55 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by mails.dpdk.org (Postfix) with ESMTP id B95784028A;
 Mon, 13 Jul 2026 06:19:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9VFSv2VU39pVVRLllJFYyC5J4QkIKspOCVrWrLDTERGGourxiEpt+6Ptljp41JDoo3x+TKINvr96xFVcEsBlEO41cW+We8dTISt76vU2j/PLS08YorYqggRsHbEfUt+E5SVw4pwshWr+CT1mzSAjT2EDw5zELC3pHy++asSkWAAPS8FkLHbcUVOnA3gV6U+NJD5LHlKF4jXRelNzV3Rm0yCEIDBBq1gwdkwSBGM7lb8iDtCmEzrDSf9uaosYU3+8cqZAJpaphyVyWbfbbyfKC1m7cbZ8a0VHz7ISnMiAxAiU516oYmkB9bO55Qwv5p1cQO5FD/4A4ErFlhtH5g2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1QgswRRthINqWoB3av1Aw4UivB7psKX23C5oZPSdsc=;
 b=WE7A80zmzxInvAsxw1TOgXoS9sg7SvOTvZeMTxdKQBSOl2E6b6NuFw/cXXEn4hHGFAQbXfbtcKtvhLQCAfjOPOgwk/HQwwz30KpbOOG0yYHH9lH0TD/YoW3pXPzCyQB3Y2HmkRihCLmP5mI8TzmJWgNyJaQj8ZSoNGYA4NKVPHaq15yLVqiFuBCm1rXJuDNUviDaT+5GL96by539fCV+FGcak5OGU+7fQRkSWhVw8z/XuN6MPVk1tIkl9jLQyVxupJtf9tSQiS/6YtAN6KhiWvH1OdTfrDpsxzbw/VoZCSWSg7TiKtLgsVLjaJ5p2UrYF5lEatFIM3PUOCtV1dR9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1QgswRRthINqWoB3av1Aw4UivB7psKX23C5oZPSdsc=;
 b=OwqBaK+TsjBvTC+DN7TsYAEzUbaUzJAVwX3gfz8Alx79vpTxQi17+PrnujGUTIurrZqs1r+uQ78LarJw88ptgGZVQjH4fsQaTkr8EkHhbquQza5zRGB41wKw153vykjNeLdpvNlqCOgG8gPwXtH7Ll2KIuhmCBMVsoO8/fEcaMTipQO2sgb0MVADQ6s/rfHAsPS0Y6XoDQtUuc0CtqDt7OZJWwSVcLJZsAodsnXu1Rn0zTZ7GQIokS90WK9VPFyi7niOToOOZxeP2zXnEM+cwAHasxvmLbOt7W770tT/3DdB3rH6hoWHYChsrsDfCV5QaEGAY10C9W2HroeFcgZoHQ==
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 04:19:49 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::62) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 04:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Mon, 13 Jul 2026 04:19:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 12 Jul
 2026 21:19:26 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 12 Jul
 2026 21:19:22 -0700
From: Gavin Hu <gahu@nvidia.com>
To: <dev@dpdk.org>
CC: Wei Yan <yanwei.wy@bytedance.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Ophir Munk
 <ophirmu@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH] net/mlx5: avoid wildcard drop flow in priority discovery
Date: Mon, 13 Jul 2026 12:18:55 +0800
Message-ID: <20260713041856.67144-1-gahu@nvidia.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b435bc9-e847-4379-35d7-08dee095f7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: z12j6igcA9u4Ypt+RPb4s8AyfEY73pyhyNR9eOud9OMIjJ1ydb5RcNb3BSEKQ8RyKDOoELDx8Bq3iHJHn0iN8pa5d0GWPVo+utPMelAWk/TR9RAdPFQ++FGurTdxumUanwD08nXwwPcC7QuWHDyRWcPL7sF/U7KY62lARWyvOFVl60/MeHyOUxDhnv52hIktp3gOyQ2QcV9Oy4jURvi57w8FPEDcl/E29GNcBkFebRFUBvYztG/SidTCj0nvzMhAJRaEL+P96o9DlSYLDxa02FrgZuPRqbfC0m/pJjmbRwCcpcGRXc0FVDQD+eMlQh/jFH5YRfOeqXJ5W75jJigsn/OABvveDCkvPTTkh+kuoOGI9+1vN7xBPIWLjTxOe6abT3sL9K4DDa+SmGvoRXWrr0Diz/eoZadCygZuVTbw25Y4ZfnpD5+RFaoBnVDgvlfzTDzZKDBm/GP3B/dPDHFnEBxpjOUQLYGFwk7AFvSZ/IkSbhmjhBSc3FdmEe/nd9yEZg0j9rMNvx3LsAfY5dzyjP8XuzS+nMVsOXifIqg+RKogj2LGqN3aEsPJ2A7wQAQ6slZrO97boBsQQClumI69Wsotp1Zbf7MJNyI/Y7p7GL9z3isYPMjGnBvq/z9DEZ/Hzr3WIFx0K/rd1h/nfJGTVBUgqnT+3Euk5BniwSCek+xH3FYKxAJG82QKCvxo3MBB2fi8d1nRDCvpeK7q0A3yRw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: piyw+VPfpyXj2/BmO1Yywn319xgLxbU3n3xibzVf59FFD82UYdgX5fK16IKhPRyYpbrlW7kDcusHVLSCVAHQ7PGuzfoXwUxWrQxqjSYLf15MJ46inzRjHiqGbwv1zCcLGNcf7Az9J3UYHkXV2XgcwSRwuc9I21CTpArewHj353aNSCq9hGCr+ZgiFOwL5glQyCg7Khtw8gYV5x/DsosOlxE2MRTlQjJ66YyIRF9ePdwKul/YV3G5plmeqXjsUTMz33mxvMRBpIAISvDL9wOnWKkW7hPgSC2JxDO5zZqwZZ0f8gOK/Prpm4KyWAji25FGDB39LNibbtC4W9nGpOmWH+LUBpFaIMOuEwpjQAM/AlMVQKW3jz4m1unAqARo8UQbVjo9GCK98DMIa0YFfUEFmyt8KI+ofqZEpcYnNy2lyeE6LZwmTgfkJZC/fW2Oad4w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:19:44.6724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b435bc9-e847-4379-35d7-08dee095f7fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422
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

From: Wei Yan <yanwei.wy@bytedance.com>

Priority discovery installs temporary drop flows to probe supported flow
priorities. These flows match a wildcard Ethernet pattern, so they can
also match real traffic while discovery is running. On shared devices this
may temporarily drop kernel traffic and cause TCP connection timeouts.

Constrain the probe flows to match both source and destination MAC
addresses as ff:ff:ff:ff:ff:ff. This keeps the rule valid for discovery
while avoiding matches on normal Ethernet traffic.

Fixes: 3eca5f8a610e ("net/mlx5: move flow priority discovery to Verbs file")
Fixes: c5042f93a425 ("net/mlx5: discover max flow priority using DevX")
Cc: stable@dpdk.org

Signed-off-by: Wei Yan <yanwei.wy@bytedance.com>
Signed-off-by: Gavin Hu <gahu@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_dv.c    | 18 ++++++++++++++++++
 drivers/net/mlx5/mlx5_flow_verbs.c |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 58ebcf87eb..9cb7c59b83 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -19794,6 +19794,22 @@ mlx5_flow_discover_dr_action_support(struct rte_eth_dev *dev)
 	void *matcher = NULL;
 	void *flow = NULL;
 	int ret = -1;
+	struct rte_flow_item_eth eth;
+	struct rte_flow_item item = {
+		.type = RTE_FLOW_ITEM_TYPE_ETH,
+		.spec = &eth,
+		.mask = &eth,
+	};
+
+	memset(&eth, 0, sizeof(eth));
+	memset(&eth.hdr.dst_addr, 0xff, sizeof(eth.hdr.dst_addr));
+	memset(&eth.hdr.src_addr, 0xff, sizeof(eth.hdr.src_addr));
+	flow_dv_translate_item_eth(mask.buf, &item,
+				   /* inner */ false, /* group */ 0,
+				   MLX5_SET_MATCHER_SW_M);
+	flow_dv_translate_item_eth(value.buf, &item,
+				   /* inner */ false, /* group */ 0,
+				   MLX5_SET_MATCHER_SW_V);
 
 	tbl = mlx5_flow_dv_tbl_resource_get(dev, 0, 0, 0, false, NULL,
 					    0, 0, 0, NULL);
@@ -20683,6 +20699,8 @@ flow_dv_discover_priorities(struct rte_eth_dev *dev,
 	flow.dv.actions[0] = action;
 	flow.dv.actions_n = 1;
 	memset(&eth, 0, sizeof(eth));
+	memset(&eth.hdr.dst_addr, 0xff, sizeof(eth.hdr.dst_addr));
+	memset(&eth.hdr.src_addr, 0xff, sizeof(eth.hdr.src_addr));
 	flow_dv_translate_item_eth(matcher.mask.buf, &item,
 				   /* inner */ false, /* group */ 0,
 				   MLX5_SET_MATCHER_SW_M);
diff --git a/drivers/net/mlx5/mlx5_flow_verbs.c b/drivers/net/mlx5/mlx5_flow_verbs.c
index bb240d38d9..f92258cb5a 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -65,6 +65,14 @@ flow_verbs_discover_priorities(struct rte_eth_dev *dev,
 		.eth = {
 			.type = IBV_FLOW_SPEC_ETH,
 			.size = sizeof(struct ibv_flow_spec_eth),
+			.val = {
+				.dst_mac = "\xff\xff\xff\xff\xff\xff",
+				.src_mac = "\xff\xff\xff\xff\xff\xff",
+			},
+			.mask = {
+				.dst_mac = "\xff\xff\xff\xff\xff\xff",
+				.src_mac = "\xff\xff\xff\xff\xff\xff",
+			},
 		},
 		.drop = {
 			.size = sizeof(struct ibv_flow_spec_action_drop),
-- 
2.27.0

