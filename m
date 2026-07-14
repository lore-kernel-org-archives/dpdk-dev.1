Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80994C44501
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 06:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C9BF4028A;
	Tue, 14 Jul 2026 08:08:45 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by mails.dpdk.org (Postfix) with ESMTP id 15A7540289;
 Tue, 14 Jul 2026 08:08:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYSqtzZPmN7MyQ5TwIOKFNTFZqteSE6DVMYqlP21idL7iPxfKCIH4MGd+XwRa8K1q0WrjwEB6SL9VHuSLRvI5DVzy3MO7IjY3Q4pyfYbAbezwkF062UTkrmtJKCEVE7cxGSKokLrZHMVaggX6sEJrUYCoZZdmv64PUumWyagydgNLJ2uihlroGsfsg0Y80yO4CaxXogz2uEp6qVkpuTFcSOwxQmPGJqaJGNAdnFtw/lRSPijCaWlsskfkvLA/bGnqWS6LxMkc8XI6n0oXoBgdgBs4gEYEgTPjGbUVGr4rlgK234k6NymJEHaPM4sInqal0lZwHXyq4EkbODpYEEJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMv2gVCnXlwF+Xq41pKpNflGMlh7ihoTP5LVek7uNTI=;
 b=JcAFeApekz5x5lCUgWiIptTiea0uM46ShrYIG9bLSYmlmNr6+QAPXjJshyhzKyJvFVFF36iRrSYVpzxp0HItXotyNv9+3sXCBW4NN7KKY4nBFvGVq1MM4hdaCw2pObboywq8U5PmZ6VUTj+DESg6+9uNUormmGRtK3Qw4wqXYKtElHeoN7SVfNtAum6srZ+ER/ycCWFe+2WiSH3u7jo9bUNWC3hn6KbeZITAZloR+ytwY3ITimqp8d7pTqTwYhGo2jBc/CyZR+59pNcg4thzvYm6/cghdh77aQV9vcCIlBQ02DkfSOXBq7izdy2E17pzPDVuldjTrafgLu3Jk/dfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMv2gVCnXlwF+Xq41pKpNflGMlh7ihoTP5LVek7uNTI=;
 b=ag6VoO/p3aNQhX56n39nBvcVImsDyqllSa6UC9bCj808VEbPUBWyhDKchTQ0v3eU+MBA5NdfcuuBocQ1rMhQsxQbDLAUqWS8PDgQEzLjXXTYsn3tmc+r9G7BsFiAzitp/TwZwv2THwqfMzv+ijumbWHXlecELM0inS+Wr/15OJnH51R1/qkPo1EY3s4Ol2+i3tat/Bu9r58DjrwdHyvrskGpIGdXAR6ZYpIOr67qK42YQpGRuy42gjUXkGA5fpK6luZwecdZ2ONt2iKpLb3rd8Pi9CqLiQqMHoRpmXPQ4i8b0dPBW7moTJRPgQQAICiA3ug1fL0+ipLrvT0Ji4IvJQ==
Received: from SJ0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:a03:39e::8)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 06:08:36 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e) by SJ0PR03CA0273.outlook.office365.com
 (2603:10b6:a03:39e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 06:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 06:08:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:08:18 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:08:14 -0700
From: Gavin Hu <gahu@nvidia.com>
To: <dev@dpdk.org>
CC: Wei Yan <yanwei.wy@bytedance.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Ophir Munk
 <ophirmu@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v2] net/mlx5: avoid wildcard drop flow in priority discovery
Date: Tue, 14 Jul 2026 14:07:51 +0800
Message-ID: <20260714060751.44814-1-gahu@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713041856.67144-1-gahu@nvidia.com>
References: <20260713041856.67144-1-gahu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 649a46cd-1fd1-40ef-a253-08dee16e5715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BhfZc5jo9xGDzDcM3izLUzNW5j6xejJylkNw/wyZqBYsqzr/+9grt4syGdwjBa+RJG4ym8caPzfF0Nfwf8V9VPief+UsYfIZ8pC/vDD2EyQeYK5Z6Ydrc5RvIomzvBnwhaNC/mqYS0tGscjLtDBpnf1X2+pmvG/oooXto13QuzPBDNUe7CBeICUH+YdumyZ9c+LCqJJkWFhAMwoJ9SJE4geGGYI7iBix9wnuIJtpKFUw7WQ2D2saRHBs5r6nd/gj+r9xfx6T7XsuLNsgKDCENaBVdpvhlTDjfzzumBvW5j0BVOOS4dKlne3ClB/HEOh4oysUxAiBRWbwVI67XTwatLSCdKxRpIRVQIW4wJ5MD06DYDdr4/jW92ER7pv4yb4065XFKWcWP0t4Q2eh01mh3IulwX5tnakLStTTS/R0zp6zz2aCnpK5vn0ZcPxeXGtQAvauR+LcAUjqy9YaNoKQAAXuhXubjr1tgf9grekMVTBjUk822LhrKIrdT7Zk841qn4z3cE190+OYQJBtwAxR+Z6dN237agZy5sxLRS2zMif31+jIpcywatIb/V4QP8oZ3iypInfeBbQoVBFzAHOitX5pe6RS7y+d3jQlO0ectHNHERdZbCtxFsjaUCQ12xFyuYbejprTU0GonVNvSi0nbUJH79Z+NTleAYAPXIcJ6BnhSbqjwquSGmlt85fVuOpmC9CpIuwJVPHGxDV33cfZFA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /gt5rJAI7DC4zdqXZ7SW9KmGrReVy8ef7oh0/3mDoru5Lcwg4mmeSzR8rA8AZmDh6AcFV1KdKsEMnRqT1Db0L6Nx9p5R+aqDeRh+UWyxejHmdcOgkf0UkpZ/i7Wflg+tlPf0fNvqQvh495ZWTkSpORYKRykuqtAGXZalmB8d3ekzWkoYcG2NZOGG+RZrLmLFZ8KFWUkBUHECY/gFERVGFzNZ+HFwlrU2ny5bmn2fJtwJ1Ms8Itm+c7C4ZgTg9hExeKNCTVVWZxng0T5HDk01rYF2m1Xs8HsP9CZM5wXaO9A8937La0JqlGf2N0rATTg99c1EQyMloPasGp1oaSzlEtwtiXZwbl+NkLmx9tPnyvV+Me9jAjal1TjHF9R4e0TXgoLH+SsAdR0mst5k8fTjRmIRTUQgHqUvCofKyNReDFG7wNTudHRKUzDHccpRXuug
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:08:35.5890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649a46cd-1fd1-40ef-a253-08dee16e5715
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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
+v2:
+* Fixed the compiling issue by some compilers in mlx5_flow_verbs.c.

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
index bb240d38d9..eb576f73d4 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -65,6 +65,14 @@ flow_verbs_discover_priorities(struct rte_eth_dev *dev,
 		.eth = {
 			.type = IBV_FLOW_SPEC_ETH,
 			.size = sizeof(struct ibv_flow_spec_eth),
+			.val = {
+				.dst_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+				.src_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+			},
+			.mask = {
+				.dst_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+				.src_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+			},
 		},
 		.drop = {
 			.size = sizeof(struct ibv_flow_spec_action_drop),
-- 
2.27.0

