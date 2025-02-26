Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91225C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:40:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07B4040663;
	Wed, 26 Feb 2025 09:40:05 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by mails.dpdk.org (Postfix) with ESMTP id BAFCD40666
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:40:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsFh7tLw2DsNmW88nXl0I+6ZAtUtxG68nfX3sem/+wpgvhoUTYWNq4wkSqXDFAEoAbJtULdWRgw06pW9kc1OB7j54nn1CLUJgGKdX0vLVVggnOvAA8UaEwmmOlBhOLaMkI2tggbZ2MkEhDE7Cki0bCn0P2686xAOrRgqw0rMUpFSA3KIfsCUdPETL5xV3LiKIP2jzxlT/AO0AHp+HG/OwceFlkCj8SbNGFtwGj/JC4oqwAK++5wCrmefrwYrbsJsDufbv63Ek+YSZyO21z5gtT5Rw1IyhWo8HBUaaXwaK0SvCopRS/g5s7FO/E+S+j4DSfeOPKFOOeiXmA9UnyFvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYLjGHf6SIxI0aDEQxrmQ/2iPhdxsGNTb81pTxQYais=;
 b=VCxSG6wW/B+7XRvLp+hE/WgwbspTbaMhWsm5FH5VLLVhqcB6Qou8ryD0i6VuS1zkbpwJFLtJryI875Sys0cYV0hBSM4lo3WJwNKqySY4tnSnR3RaJ2xifUrqKn4gJPc1UPkW1HOjfggLUqQJpHL+91yDXJLC1dH+x3l9D/Swy2yio8UkPFB4tgCnE0x8Q6qfLkOzZPCITq8fHJKi4y4DFWhLrkfJTMr2+cXSp+phiMG8vP5PETiSmCBit0/becBrgc0iMZGGxUen1n++ZojebcLiAsj7PTzaQtqcb6PY0hrFhmmXF7cHXd1g22ipR5xI9m1IFeMG5gAIEe2PC3eA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYLjGHf6SIxI0aDEQxrmQ/2iPhdxsGNTb81pTxQYais=;
 b=GfF7oJWyqeD+bRx2/t0NHhRnh6+X03MDVounR9+hTJhW6wKwg7pZjpRFbWJHZI02UsTa3BkVpBBoA8fDphZ7aeZAiC8qRl8OSwkX1pH5viBdO8+oZOkJFBpoGlnjmq6uGZByooUfq0DGQRUOvIYDsy2x6WCWb7DVpY77EKzoNA4AJfrson38GfyhxfDH4DezSmOUe0et4IckMmzrQhZdFI2ubBoOo0YAknaaHNWV68IzuYwpx+4Nh9tD/9vFIDWHFBiakhmOMK4+iHRaAc/jWu3knv91KwSG39vge135+j5cr8pfoUJQG8pJlSecGANLn0SauRlRpQ0hOYuuS76BHw==
Received: from PH8PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:2cf::19)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 08:39:52 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::29) by PH8PR07CA0048.outlook.office365.com
 (2603:10b6:510:2cf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 08:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:39:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 00:39:32 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 00:39:29 -0800
From: Ophir Munk <ophirmu@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH V2 2/4] net/mlx5: support FDB unified domain
Date: Wed, 26 Feb 2025 10:38:44 +0200
Message-ID: <20250226083846.4023622-3-ophirmu@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226083846.4023622-1-ophirmu@nvidia.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f94fae-f2e8-4346-b782-08dd56412389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lkbTQOCwu9/tuH48J9pCtg92SJDSV3nn+xNjLC2xC8efViVQe9d8OdR0h7Ab?=
 =?us-ascii?Q?MNzV4bT+VjPs49IL8rU5kRAF8Ol23Ermzouf8Cr98pnB/vvqBM9Boqvgrly5?=
 =?us-ascii?Q?WC4y02eF9EDakAkBM114wC3JKOfueQ5a2op7r5MWgn3X8oYUV/B106/t5j+3?=
 =?us-ascii?Q?EkIT/cZPi/wj9fivdhamV7qGwtGC1vjAgVU4sm/JZpbRdqfEzyZehj8zPGqZ?=
 =?us-ascii?Q?avcy+aLZqCs054KVcukjdm1aM9HMQG851C+4QL3R+ZKbuExuBEDjJWjEK8SC?=
 =?us-ascii?Q?8TnVvCZtcmjc5IcY4NdTHVVhJpermGWksqGZEVRQkvhQHv4o8Pc3qKfpKDey?=
 =?us-ascii?Q?FbWqMXKNA6anD1OBDyEcFsRTLG9eYRGtnXBX6SziLt60tqkTBeFhXkYkQI0p?=
 =?us-ascii?Q?lXfrdvJ9yZsYxp6oroo5Lz4FDXB12oJ01Jzfpu4jH1BEUOF4yP2/mFBC1bk9?=
 =?us-ascii?Q?aFKceV9Lda6UwIRIMXrFYHZcys+DTFe23tm6DQWEIGKGZ9fMJl3UrYMrgrY+?=
 =?us-ascii?Q?Ohab5kjT/T5t3D+yp/a3F6Ameei2Z8/jsuSwI1gtKGNGBrtsLwuMyEGNQnlU?=
 =?us-ascii?Q?CMzGbHZ2JsZuk1kEyCGLvdT45MLQkwy2sToQDldjaSrQgiCpRYTqD1jIOVl6?=
 =?us-ascii?Q?UfKAbxO1Iv+dzETisvaVIvULiWrsipCv7RrX3sGkmZed+wHOv5tJHqiwSa5R?=
 =?us-ascii?Q?aU+JW8tEd+LbiZG5834hpm6vSxN5ECGaW8P3jxfmRLRChUaPCgkTORax6sYn?=
 =?us-ascii?Q?g6yBYMAE3NqnJdK25hQSmMlcEXncs1OgbSMPS9M3DYxsBlr7mShUsd9vMSk1?=
 =?us-ascii?Q?h1axHq6pcYADdMBfl0Mq6+xz3e+k4HTuaH4Ijk1oyTYtWKCo3CDuFvGm13g0?=
 =?us-ascii?Q?YZDohx1KR2d5JCMKuUxPEHWEQUU42ofVOtdbynhBC8gUL69yhhFE+4zk8lli?=
 =?us-ascii?Q?ZrFTt15YUsnCSVdHbsApfNQgrumGr8YGM0kOSL+6K7lnd85AMUTbrC8ELTIC?=
 =?us-ascii?Q?f/6+FoByMMqRid0/BmNPuTOeW/O7DrnJZeah0YB9JljcqfTyQ1gHmUJpufK1?=
 =?us-ascii?Q?JeSVkkX07ZW2EwQP1j8kHvfGws/3ZShVqudB3xadO3g2OVxlNv562S+TgtGB?=
 =?us-ascii?Q?I3ZUHLk8eO1xREmD0lANhJg4C/Xrysrpvo+kE+jfcIIwnJBSdZOtYNBjhCAJ?=
 =?us-ascii?Q?NIjiwehArvyJu4FfYq8nNUeVvGVewlgykTjqD6TREiUgmXtst8STBHV93ABL?=
 =?us-ascii?Q?+ebcHh9BjEIRJs/8ScfUR0esxcE2ppVQKFqvcID8ttwK8rZTNqT7vCkgPAXf?=
 =?us-ascii?Q?Od4eltn2Sf1vU4801lwhMkwf+J92nB8JJacJxDhhMOi9lszilfy15Exk1lCg?=
 =?us-ascii?Q?PMtME2YJFwdYW1Ei4BUVTGXhSmAdkblrBAeJzaITBmwSGSj5kSy0XuyafbGA?=
 =?us-ascii?Q?9LK1Sq7rrJo+XJBuDCZC+cADN0lc5wmQ7N+MHLpLwG12p/bxWAXb4Q5+qA6w?=
 =?us-ascii?Q?N2/CCPnav+5py7s=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:39:52.4162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f94fae-f2e8-4346-b782-08dd56412389
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

Legacy FDB domain is enhanced with optional three sub-domains: FDB_RX
FDB_TX and FDB_UNIFIED. Based on FW capability bit mlx5 will work in
either legacy or unified mode. To work in fdb unified mode the flow
attribute transfer bit must be set and the fdb sub domains are
determined by the table specialize flags SPECIALIZE_TRANSFER_WIRE_ORIG
and SPECIALIZE_TRANSFER_VPORT_ORIG.

+------------+-------------+--------------+
| WIRE_ORIG  | VPORT_ORIG  | FDB domain   |
+------------+-------------+--------------+
| 0          | 0           | FDB_UNIFIED  |
| 0          | 1           | FDB_TX       |
| 1          | 0           | FDB_RX       |
+------------+-------------+--------------+

There can be no two groups which only differ in their fdb sub domain.
A table must be created in a group which has the same fdb sub domain.

Signed-off-by: Ophir Munk <ophirmu@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c   |  11 +
 drivers/net/mlx5/mlx5.h            |   8 +
 drivers/net/mlx5/mlx5_flow_hw.c    | 519 ++++++++++++++++++++++++++-----------
 drivers/net/mlx5/mlx5_flow_meter.c |  16 +-
 drivers/net/mlx5/mlx5_flow_quota.c |   9 +-
 drivers/net/mlx5/mlx5_hws_cnt.c    |   9 +-
 6 files changed, 409 insertions(+), 163 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 091f288..7f13cb2 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1707,6 +1707,17 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	LIST_INIT(&priv->hw_ext_ctrl_flows);
 	if (priv->sh->config.dv_flow_en == 2) {
 #ifdef HAVE_MLX5_HWS_SUPPORT
+		/*
+		 * Unified FDB flag is only needed for the actions created on the transfer
+		 * port. proxy port. It is not needed on the following ports:
+		 *   1. NIC PF / VF / SF
+		 *   2. in Verbs or DV/DR mode
+		 *   3. with unsupported FW
+		 *   4. all representors in HWS
+		 */
+		priv->unified_fdb_en = !!priv->master && sh->cdev->config.hca_attr.fdb_unified_en;
+		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled.",
+			eth_dev->data->port_id, priv->unified_fdb_en ? "is" : "isn't");
 		if (priv->sh->config.dv_esw_en) {
 			uint32_t usable_bits;
 			uint32_t required_bits;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 2b590c9..f73f6e6 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1986,6 +1986,7 @@ struct mlx5_priv {
 	uint32_t mark_enabled:1; /* If mark action is enabled on rxqs. */
 	uint32_t num_lag_ports:4; /* Number of ports can be bonded. */
 	uint32_t tunnel_enabled:1; /* If tunnel offloading is enabled on rxqs. */
+	uint32_t unified_fdb_en:1; /* Unified FDB flag per port. */
 	uint16_t domain_id; /* Switch domain identifier. */
 	uint16_t vport_id; /* Associated VF vport index (if any). */
 	uint32_t vport_meta_tag; /* Used for vport index match ove VF LAG. */
@@ -2226,6 +2227,13 @@ mlx5_is_port_on_mpesw_device(struct mlx5_priv *priv)
 	return priv->mpesw_port >= 0;
 }
 
+static inline bool
+is_unified_fdb(const struct mlx5_priv *priv)
+{
+	/* Only needed on proxy port in E-Switch mode. */
+	return priv->unified_fdb_en;
+}
+
 /* mlx5.c */
 
 int mlx5_getenv_int(const char *);
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e72b87d..1cc074d 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -282,12 +282,34 @@ mlx5_multi_pattern_reformat_index_to_type(uint32_t ix)
 }
 
 static inline enum mlx5dr_table_type
-get_mlx5dr_table_type(const struct rte_flow_attr *attr)
+get_mlx5dr_fdb_table_type(const struct rte_flow_attr *attr,
+			  uint32_t specialize, bool fdb_unified_en)
+{
+	if (fdb_unified_en && !!attr->group) {
+		if ((specialize & (RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG |
+				   RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_VPORT_ORIG)) == 0)
+			return MLX5DR_TABLE_TYPE_FDB_UNIFIED;
+		MLX5_ASSERT((specialize & (RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG |
+					   RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_VPORT_ORIG)) !=
+					  (RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG |
+					   RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_VPORT_ORIG));
+		if (specialize & RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG)
+			return MLX5DR_TABLE_TYPE_FDB_RX;
+		if (specialize & RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_VPORT_ORIG)
+			return MLX5DR_TABLE_TYPE_FDB_TX;
+	}
+
+	return MLX5DR_TABLE_TYPE_FDB;
+}
+
+static inline enum mlx5dr_table_type
+get_mlx5dr_table_type(const struct rte_flow_attr *attr, uint32_t specialize,
+		      bool fdb_unified_en)
 {
 	enum mlx5dr_table_type type;
 
 	if (attr->transfer)
-		type = MLX5DR_TABLE_TYPE_FDB;
+		type = get_mlx5dr_fdb_table_type(attr, specialize, fdb_unified_en);
 	else if (attr->egress)
 		type = MLX5DR_TABLE_TYPE_NIC_TX;
 	else
@@ -364,14 +386,36 @@ static uint32_t mlx5_hw_act_flag[MLX5_HW_ACTION_FLAG_MAX]
 		MLX5DR_ACTION_FLAG_ROOT_RX,
 		MLX5DR_ACTION_FLAG_ROOT_TX,
 		MLX5DR_ACTION_FLAG_ROOT_FDB,
+		MLX5DR_ACTION_FLAG_ROOT_FDB,
+		MLX5DR_ACTION_FLAG_ROOT_FDB,
+		MLX5DR_ACTION_FLAG_ROOT_FDB,
 	},
 	{
 		MLX5DR_ACTION_FLAG_HWS_RX,
 		MLX5DR_ACTION_FLAG_HWS_TX,
 		MLX5DR_ACTION_FLAG_HWS_FDB,
+		MLX5DR_ACTION_FLAG_HWS_FDB_RX,
+		MLX5DR_ACTION_FLAG_HWS_FDB_TX,
+		MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED,
 	},
 };
 
+/**
+ * Jump table flags.
+ * Can jump to FDB_RX table from FDB_RX or UNIFIED tables.
+ * Can jump to FDB_TX table from FDB_TX or UNIFIED tables.
+ * Can jump to UNIFIED table from all tables.
+ */
+static uint32_t mlx5_hw_act_dest_table_flag[MLX5DR_TABLE_TYPE_MAX] = {
+		MLX5DR_ACTION_FLAG_HWS_RX,
+		MLX5DR_ACTION_FLAG_HWS_TX,
+		MLX5DR_ACTION_FLAG_HWS_FDB,
+		(MLX5DR_ACTION_FLAG_HWS_FDB_RX | MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED),
+		(MLX5DR_ACTION_FLAG_HWS_FDB_TX | MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED),
+		(MLX5DR_ACTION_FLAG_HWS_FDB_RX | MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+		MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED),
+};
+
 /* Ethernet item spec for promiscuous mode. */
 static const struct rte_flow_item_eth ctrl_rx_eth_promisc_spec = {
 	.hdr.dst_addr.addr_bytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
@@ -776,11 +820,13 @@ flow_hw_jump_action_register(struct rte_eth_dev *dev,
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_flow_attr jattr = cfg->attr.flow_attr;
+	uint32_t specialize = cfg->attr.specialize;
 	struct mlx5_flow_group *grp;
 	struct mlx5_flow_cb_ctx ctx = {
 		.dev = dev,
 		.error = error,
 		.data = &jattr,
+		.data2 = &specialize,
 	};
 	struct mlx5_list_entry *ge;
 	uint32_t target_group;
@@ -2339,7 +2385,9 @@ mlx5_tbl_create_reformat_action(struct mlx5_priv *priv,
 				enum mlx5dr_action_type refmt_type)
 {
 	const struct rte_flow_attr *attr = &table_attr->flow_attr;
-	enum mlx5dr_table_type tbl_type = get_mlx5dr_table_type(attr);
+	bool unified_fdb = is_unified_fdb(priv);
+	enum mlx5dr_table_type tbl_type = get_mlx5dr_table_type(attr, table_attr->specialize,
+								unified_fdb);
 	struct mlx5dr_action_reformat_header hdr;
 
 	mlx5_set_reformat_header(&hdr, encap_data, data_size);
@@ -2398,9 +2446,11 @@ mlx5_tbl_ensure_shared_modify_header(struct rte_eth_dev *dev,
 				     struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
 	const struct rte_flow_template_table_attr *table_attr = &cfg->attr;
 	const struct rte_flow_attr *attr = &table_attr->flow_attr;
-	enum mlx5dr_table_type tbl_type = get_mlx5dr_table_type(attr);
+	enum mlx5dr_table_type tbl_type = get_mlx5dr_table_type(attr, table_attr->specialize,
+								unified_fdb);
 	struct mlx5dr_action_mh_pattern pattern = {
 		.sz = sizeof(struct mlx5_modification_cmd) * acts->mhdr->mhdr_cmds_num
 	};
@@ -2428,9 +2478,11 @@ mlx5_create_ipv6_ext_reformat(struct rte_eth_dev *dev,
 			      enum mlx5dr_action_type recom_type)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
 	const struct rte_flow_template_table_attr *table_attr = &cfg->attr;
 	const struct rte_flow_attr *attr = &table_attr->flow_attr;
-	enum mlx5dr_table_type type = get_mlx5dr_table_type(attr);
+	enum mlx5dr_table_type type =
+		get_mlx5dr_table_type(attr, table_attr->specialize, unified_fdb);
 	struct mlx5_action_construct_data *act_data;
 	struct mlx5dr_action_reformat_header hdr = {0};
 	uint32_t flag, bulk = 0;
@@ -2528,8 +2580,8 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				     struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_hca_attr *hca_attr = &priv->sh->cdev->config.hca_attr;
 	const struct rte_flow_template_table_attr *table_attr = &cfg->attr;
-	struct mlx5_hca_flex_attr *hca_attr = &priv->sh->cdev->config.hca_attr.flex;
 	const struct rte_flow_attr *attr = &table_attr->flow_attr;
 	struct rte_flow_action *actions = at->actions;
 	struct rte_flow_action *masks = at->masks;
@@ -2557,15 +2609,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	uint32_t ct_idx;
 	int ret, err;
 	uint32_t target_grp = 0;
-	int table_type;
+	bool unified_fdb = is_unified_fdb(priv);
 
 	flow_hw_modify_field_init(&mhdr, at);
-	if (attr->transfer)
-		type = MLX5DR_TABLE_TYPE_FDB;
-	else if (attr->egress)
-		type = MLX5DR_TABLE_TYPE_NIC_TX;
-	else
-		type = MLX5DR_TABLE_TYPE_NIC_RX;
+	type = get_mlx5dr_table_type(attr, cfg->attr.specialize, unified_fdb);
 	for (; !actions_end; actions++, masks++) {
 		uint64_t pos = actions - at->actions;
 		uint16_t src_pos = pos - at->src_off[pos];
@@ -2767,7 +2814,8 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			refmt_type = MLX5DR_ACTION_TYP_REFORMAT_TNL_L2_TO_L2;
 			break;
 		case RTE_FLOW_ACTION_TYPE_IPV6_EXT_PUSH:
-			if (!hca_attr->query_match_sample_info || !hca_attr->parse_graph_anchor ||
+			if (!hca_attr->flex.query_match_sample_info ||
+			    !hca_attr->flex.parse_graph_anchor ||
 			    !priv->sh->srh_flex_parser.flex.mapnum) {
 				DRV_LOG(ERR, "SRv6 anchor is not supported.");
 				goto err;
@@ -2788,7 +2836,8 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			recom_src = src_pos;
 			break;
 		case RTE_FLOW_ACTION_TYPE_IPV6_EXT_REMOVE:
-			if (!hca_attr->query_match_sample_info || !hca_attr->parse_graph_anchor ||
+			if (!hca_attr->flex.query_match_sample_info ||
+			    !hca_attr->flex.parse_graph_anchor ||
 			    !priv->sh->srh_flex_parser.flex.mapnum) {
 				DRV_LOG(ERR, "SRv6 anchor is not supported.");
 				goto err;
@@ -2809,10 +2858,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 					"Send to kernel action on root table is not supported in HW steering mode");
 				goto err;
 			}
-			table_type = attr->ingress ? MLX5DR_TABLE_TYPE_NIC_RX :
-				     ((attr->egress) ? MLX5DR_TABLE_TYPE_NIC_TX :
-				      MLX5DR_TABLE_TYPE_FDB);
-			acts->rule_acts[dr_pos].action = priv->hw_send_to_kernel[table_type];
+			acts->rule_acts[dr_pos].action = priv->hw_send_to_kernel[type];
 			break;
 		case RTE_FLOW_ACTION_TYPE_MODIFY_FIELD:
 			err = flow_hw_modify_field_compile(dev, attr, actions,
@@ -3552,7 +3598,7 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 
 	attr.group = table->grp->group_id;
 	ft_flag = mlx5_hw_act_flag[!!table->grp->group_id][table->type];
-	if (table->type == MLX5DR_TABLE_TYPE_FDB) {
+	if (table->type >= MLX5DR_TABLE_TYPE_FDB && table->type < MLX5DR_TABLE_TYPE_MAX) {
 		attr.transfer = 1;
 		attr.ingress = 1;
 	} else if (table->type == MLX5DR_TABLE_TYPE_NIC_TX) {
@@ -3819,6 +3865,7 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 			break;
 		case RTE_FLOW_ACTION_TYPE_NAT64:
 			nat64_c = action->conf;
+			MLX5_ASSERT(table->type < MLX5DR_TABLE_TYPE_MAX);
 			rule_acts[act_data->action_dst].action =
 				priv->action_nat64[table->type][nat64_c->type];
 			break;
@@ -4874,10 +4921,12 @@ mlx5_tbl_multi_pattern_process(struct rte_eth_dev *dev,
 	int ret = 0;
 	uint32_t i;
 	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
 	struct mlx5_tbl_multi_pattern_ctx *mpctx = &tbl->mpctx;
 	const struct rte_flow_template_table_attr *table_attr = &tbl->cfg.attr;
 	const struct rte_flow_attr *attr = &table_attr->flow_attr;
-	enum mlx5dr_table_type type = get_mlx5dr_table_type(attr);
+	enum mlx5dr_table_type type =
+		get_mlx5dr_table_type(attr, table_attr->specialize, unified_fdb);
 	uint32_t flags = mlx5_hw_act_flag[!!attr->group][type];
 	struct mlx5dr_action *dr_action = NULL;
 
@@ -5045,6 +5094,7 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 		.message = NULL,
 	};
 	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
 	struct mlx5dr_matcher_attr matcher_attr = {0};
 	struct mlx5dr_action_jump_to_matcher_attr jump_attr = {
 		.type = MLX5DR_ACTION_JUMP_TO_MATCHER_BY_INDEX,
@@ -5056,10 +5106,12 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	struct mlx5dr_action_template *at[MLX5_HW_TBL_MAX_ACTION_TEMPLATE];
 	const struct rte_flow_template_table_attr *attr = &table_cfg->attr;
 	struct rte_flow_attr flow_attr = attr->flow_attr;
+	uint32_t specialize = table_cfg->attr.specialize;
 	struct mlx5_flow_cb_ctx ctx = {
 		.dev = dev,
 		.error = &sub_error,
 		.data = &flow_attr,
+		.data2 = &specialize,
 	};
 	struct mlx5_indexed_pool_config cfg = {
 		.trunk_size = 1 << 12,
@@ -5076,6 +5128,7 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	bool port_started = !!dev->data->dev_started;
 	bool rpool_needed;
 	size_t tbl_mem_size;
+	enum mlx5dr_table_type table_type;
 	int err;
 
 	if (!flow_hw_validate_table_domain(&attr->flow_attr)) {
@@ -5157,6 +5210,14 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	if (!ge)
 		goto error;
 	grp = container_of(ge, struct mlx5_flow_group, entry);
+	/* Verify unified fdb sub domains consistency */
+	table_type = get_mlx5dr_table_type(&flow_attr, specialize, unified_fdb);
+	if (table_type != grp->type) {
+		DRV_LOG(ERR, "Table type (%u) does not match group id (%u) type (%u)",
+			table_type, grp->group_id, grp->type);
+		rte_errno = EINVAL;
+		goto error;
+	}
 	tbl->grp = grp;
 	/* Prepare matcher information. */
 	matcher_attr.resizable = !!rte_flow_template_table_resizable
@@ -5194,13 +5255,14 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 			goto it_error;
 		}
 		if (attr->specialize &
-		    RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG)
+		    RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG) {
 			matcher_attr.optimize_flow_src =
 				MLX5DR_MATCHER_FLOW_SRC_WIRE;
-		else if (attr->specialize &
-			 RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_VPORT_ORIG)
+		} else if (attr->specialize &
+			 RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_VPORT_ORIG) {
 			matcher_attr.optimize_flow_src =
 				MLX5DR_MATCHER_FLOW_SRC_VPORT;
+		}
 	}
 	/* Build the item template. */
 	for (i = 0; i < nb_item_templates; i++) {
@@ -5237,9 +5299,7 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	if (!tbl->matcher_info[0].matcher)
 		goto at_error;
 	tbl->matcher_attr = matcher_attr;
-	tbl->type = attr->flow_attr.transfer ? MLX5DR_TABLE_TYPE_FDB :
-		    (attr->flow_attr.egress ? MLX5DR_TABLE_TYPE_NIC_TX :
-		    MLX5DR_TABLE_TYPE_NIC_RX);
+	tbl->type = table_type;
 	if (matcher_attr.isolated) {
 		jump_attr.matcher = tbl->matcher_info[0].matcher;
 		tbl->matcher_info[0].jump = mlx5dr_action_create_jump_to_matcher(priv->dr_ctx,
@@ -5653,6 +5713,7 @@ flow_hw_group_set_miss_group(struct rte_eth_dev *dev,
 		.dev = dev,
 		.error = &sub_error,
 		.data = &cfg->attr.flow_attr,
+		.data2 = &cfg->attr.specialize,
 	};
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_list_entry *ge;
@@ -5794,6 +5855,7 @@ flow_hw_group_set_miss_actions(struct rte_eth_dev *dev,
 		.dev = dev,
 		.error = &sub_error,
 		.data = &cfg.attr.flow_attr,
+		.data2 = &cfg.attr.specialize,
 	};
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_flow_group *src_grp = NULL;
@@ -6800,9 +6862,19 @@ flow_hw_validate_action_nat64(struct rte_eth_dev *dev,
 		nat64_c = (const struct rte_flow_action_nat64 *)action->conf;
 		cov_type = nat64_c->type;
 		if ((attr->ingress && !priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_RX][cov_type]) ||
-		    (attr->egress && !priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_TX][cov_type]) ||
-		    (attr->transfer && !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB][cov_type]))
+		    (attr->egress && !priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_TX][cov_type]))
 			goto err_out;
+		if (attr->transfer) {
+			if (!is_unified_fdb(priv)) {
+				if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB][cov_type])
+					goto err_out;
+			} else {
+				if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_RX][cov_type] ||
+				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_TX][cov_type] ||
+				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_UNIFIED][cov_type])
+					goto err_out;
+			}
+		}
 	} else {
 		/*
 		 * Usually, the actions will be used on both directions. For non-masked actions,
@@ -6816,10 +6888,29 @@ flow_hw_validate_action_nat64(struct rte_eth_dev *dev,
 			if (!priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_TX][RTE_FLOW_NAT64_6TO4] ||
 			    !priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_TX][RTE_FLOW_NAT64_4TO6])
 				goto err_out;
-		if (attr->transfer)
-			if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB][RTE_FLOW_NAT64_6TO4] ||
-			    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB][RTE_FLOW_NAT64_4TO6])
-				goto err_out;
+		if (attr->transfer) {
+			if (!is_unified_fdb(priv)) {
+				if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB]
+						       [RTE_FLOW_NAT64_6TO4] ||
+				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB]
+						       [RTE_FLOW_NAT64_4TO6])
+					goto err_out;
+			} else {
+				if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_RX]
+						       [RTE_FLOW_NAT64_6TO4] ||
+				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_RX]
+						       [RTE_FLOW_NAT64_4TO6] ||
+				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_TX]
+						       [RTE_FLOW_NAT64_6TO4] ||
+				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_TX]
+						       [RTE_FLOW_NAT64_4TO6] ||
+				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_UNIFIED]
+						       [RTE_FLOW_NAT64_6TO4] ||
+				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_UNIFIED]
+						       [RTE_FLOW_NAT64_4TO6])
+					goto err_out;
+			}
+		}
 	}
 	return 0;
 err_out:
@@ -7141,12 +7232,10 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 	bool fixed_cnt = false;
 	uint64_t action_flags = 0;
 	bool actions_end = false;
-#ifdef HAVE_MLX5DV_DR_ACTION_CREATE_DEST_ROOT_TABLE
-	int table_type;
-#endif
 	uint16_t i;
 	int ret;
 	const struct rte_flow_action_ipv6_ext_remove *remove_data;
+	bool res;
 
 	if (!mlx5_hw_ctx_validate(dev, error))
 		return -rte_errno;
@@ -7216,14 +7305,25 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 							  RTE_FLOW_ERROR_TYPE_ACTION,
 							  action,
 							  "action not supported in guest port");
-			table_type = attr->ingress ? MLX5DR_TABLE_TYPE_NIC_RX :
-				     ((attr->egress) ? MLX5DR_TABLE_TYPE_NIC_TX :
-				     MLX5DR_TABLE_TYPE_FDB);
-			if (!priv->hw_send_to_kernel[table_type])
+			if (attr->ingress) {
+				res = priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_NIC_RX];
+			} else if (attr->egress) {
+				res = priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_NIC_TX];
+			} else {
+				if (!is_unified_fdb(priv))
+					res = priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_FDB];
+				else
+					res =
+					    priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_FDB_RX] &&
+					    priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_FDB_TX] &&
+					    priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_FDB_UNIFIED];
+			}
+			if (!res)
 				return rte_flow_error_set(error, ENOTSUP,
 							  RTE_FLOW_ERROR_TYPE_ACTION,
 							  action,
 							  "action is not available");
+
 			action_flags |= MLX5_FLOW_ACTION_SEND_TO_KERNEL;
 			break;
 #endif
@@ -9214,7 +9314,9 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct rte_eth_dev *dev = ctx->dev;
 	struct rte_flow_attr *attr = (struct rte_flow_attr *)ctx->data;
+	uint32_t *specialize = (uint32_t *)ctx->data2;
 	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
 	struct mlx5dr_table_attr dr_tbl_attr = {0};
 	struct rte_flow_error *error = ctx->error;
 	struct mlx5_flow_group *grp_data;
@@ -9234,12 +9336,7 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 		return NULL;
 	}
 	dr_tbl_attr.level = attr->group;
-	if (attr->transfer)
-		dr_tbl_attr.type = MLX5DR_TABLE_TYPE_FDB;
-	else if (attr->egress)
-		dr_tbl_attr.type = MLX5DR_TABLE_TYPE_NIC_TX;
-	else
-		dr_tbl_attr.type = MLX5DR_TABLE_TYPE_NIC_RX;
+	dr_tbl_attr.type = get_mlx5dr_table_type(attr, *specialize, unified_fdb);
 	tbl = mlx5dr_table_create(priv->dr_ctx, &dr_tbl_attr);
 	if (!tbl)
 		goto error;
@@ -9248,7 +9345,7 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 		/* Jump action be used by non-root table. */
 		jump = mlx5dr_action_create_dest_table
 			(priv->dr_ctx, tbl,
-			 mlx5_hw_act_flag[!!attr->group][dr_tbl_attr.type]);
+			 mlx5_hw_act_dest_table_flag[dr_tbl_attr.type]);
 		if (!jump)
 			goto error;
 		grp_data->jump.hws_action = jump;
@@ -9340,7 +9437,7 @@ flow_hw_grp_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
 
 	return (grp_data->dev != ctx->dev) ||
 		(grp_data->group_id != attr->group) ||
-		((grp_data->type != MLX5DR_TABLE_TYPE_FDB) &&
+		((grp_data->type < MLX5DR_TABLE_TYPE_FDB) &&
 		attr->transfer) ||
 		((grp_data->type != MLX5DR_TABLE_TYPE_NIC_TX) &&
 		attr->egress) ||
@@ -9442,7 +9539,11 @@ flow_hw_create_vport_action(struct rte_eth_dev *dev)
 	}
 	proxy_priv->hw_vport[port_id] = mlx5dr_action_create_dest_vport
 			(proxy_priv->dr_ctx, priv->dev_port,
-			 MLX5DR_ACTION_FLAG_HWS_FDB);
+			 is_unified_fdb(priv) ?
+				(MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
+				MLX5DR_ACTION_FLAG_HWS_FDB);
 	if (!proxy_priv->hw_vport[port_id]) {
 		DRV_LOG(ERR, "port %u unable to create HWS vport action",
 			port_id);
@@ -9488,6 +9589,7 @@ flow_hw_create_vport_actions(struct mlx5_priv *priv)
 	uint16_t port_id;
 
 	MLX5_ASSERT(!priv->hw_vport);
+	bool unified_fdb = is_unified_fdb(priv);
 	priv->hw_vport = mlx5_malloc(MLX5_MEM_ZERO,
 				     sizeof(*priv->hw_vport) * RTE_MAX_ETHPORTS,
 				     0, SOCKET_ID_ANY);
@@ -9505,7 +9607,11 @@ flow_hw_create_vport_actions(struct mlx5_priv *priv)
 			priv->dev_data->port_id, port_id, port_priv->dev_port);
 		priv->hw_vport[port_id] = mlx5dr_action_create_dest_vport
 				(priv->dr_ctx, port_priv->dev_port,
-				 MLX5DR_ACTION_FLAG_HWS_FDB);
+				 unified_fdb ?
+					(MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+					 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+					 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
+					MLX5DR_ACTION_FLAG_HWS_FDB);
 		DRV_LOG(DEBUG, "port %u :: priv->hw_vport[%u]=%p",
 			priv->dev_data->port_id, port_id, (void *)priv->hw_vport[port_id]);
 		if (!priv->hw_vport[port_id])
@@ -9528,27 +9634,38 @@ flow_hw_free_vport_actions(struct mlx5_priv *priv)
 	priv->hw_vport = NULL;
 }
 
+static __rte_always_inline void
+_create_send_to_kernel_actions(struct mlx5_priv *priv, int type)
+{
+	int action_flag;
+
+	action_flag = mlx5_hw_act_flag[1][type];
+	priv->hw_send_to_kernel[type] =
+		mlx5dr_action_create_dest_root(priv->dr_ctx,
+				MLX5_HW_LOWEST_PRIO_ROOT,
+				action_flag);
+	if (!priv->hw_send_to_kernel[type])
+		DRV_LOG(WARNING, "Unable to create HWS send to kernel action");
+}
+
 static void
-flow_hw_create_send_to_kernel_actions(struct mlx5_priv *priv __rte_unused)
+flow_hw_create_send_to_kernel_actions(struct mlx5_priv *priv)
 {
 #ifdef HAVE_MLX5DV_DR_ACTION_CREATE_DEST_ROOT_TABLE
-	int action_flag;
-	int i;
+	int i, from, to;
 	bool is_vf_sf_dev = priv->sh->dev_cap.vf || priv->sh->dev_cap.sf;
+	bool unified_fdb = is_unified_fdb(priv);
 
-	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i < MLX5DR_TABLE_TYPE_MAX; i++) {
-		if ((!priv->sh->config.dv_esw_en || is_vf_sf_dev) &&
-		     i == MLX5DR_TABLE_TYPE_FDB)
-			continue;
-		action_flag = mlx5_hw_act_flag[1][i];
-		priv->hw_send_to_kernel[i] =
-				mlx5dr_action_create_dest_root(priv->dr_ctx,
-							MLX5_HW_LOWEST_PRIO_ROOT,
-							action_flag);
-		if (!priv->hw_send_to_kernel[i]) {
-			DRV_LOG(WARNING, "Unable to create HWS send to kernel action");
-			return;
-		}
+	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i <= MLX5DR_TABLE_TYPE_NIC_TX; i++)
+		_create_send_to_kernel_actions(priv, i);
+
+	if (priv->sh->config.dv_esw_en && !is_vf_sf_dev) {
+		from = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_RX :
+					MLX5DR_TABLE_TYPE_FDB;
+		to = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_UNIFIED :
+				      MLX5DR_TABLE_TYPE_FDB;
+		for (i = from; i <= to; i++)
+			_create_send_to_kernel_actions(priv, i);
 	}
 #endif
 }
@@ -9583,18 +9700,49 @@ flow_hw_destroy_nat64_actions(struct mlx5_priv *priv)
 }
 
 static int
-flow_hw_create_nat64_actions(struct mlx5_priv *priv, struct rte_flow_error *error)
+_create_nat64_actions(struct mlx5_priv *priv,
+		      struct mlx5dr_action_nat64_attr *attr,
+		      int type,
+		      struct rte_flow_error *error)
 {
-	struct mlx5dr_action_nat64_attr attr;
-	uint8_t regs[MLX5_FLOW_NAT64_REGS_MAX];
-	uint32_t i;
 	const uint32_t flags[MLX5DR_TABLE_TYPE_MAX] = {
 		MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_SHARED,
 		MLX5DR_ACTION_FLAG_HWS_TX | MLX5DR_ACTION_FLAG_SHARED,
 		MLX5DR_ACTION_FLAG_HWS_FDB | MLX5DR_ACTION_FLAG_SHARED,
+		MLX5DR_ACTION_FLAG_HWS_FDB_RX | MLX5DR_ACTION_FLAG_SHARED,
+		MLX5DR_ACTION_FLAG_HWS_FDB_TX | MLX5DR_ACTION_FLAG_SHARED,
+		MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED | MLX5DR_ACTION_FLAG_SHARED,
 	};
 	struct mlx5dr_action *act;
 
+	attr->flags = (enum mlx5dr_action_nat64_flags)
+		(MLX5DR_ACTION_NAT64_V6_TO_V4 | MLX5DR_ACTION_NAT64_BACKUP_ADDR);
+	act = mlx5dr_action_create_nat64(priv->dr_ctx, attr, flags[type]);
+	if (!act)
+		return rte_flow_error_set(error, rte_errno,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to create v6 to v4 action.");
+	priv->action_nat64[type][RTE_FLOW_NAT64_6TO4] = act;
+	attr->flags = (enum mlx5dr_action_nat64_flags)
+		(MLX5DR_ACTION_NAT64_V4_TO_V6 | MLX5DR_ACTION_NAT64_BACKUP_ADDR);
+	act = mlx5dr_action_create_nat64(priv->dr_ctx, attr, flags[type]);
+	if (!act)
+		return rte_flow_error_set(error, rte_errno,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to create v4 to v6 action.");
+	priv->action_nat64[type][RTE_FLOW_NAT64_4TO6] = act;
+	return 0;
+}
+
+static int
+flow_hw_create_nat64_actions(struct mlx5_priv *priv, struct rte_flow_error *error)
+{
+	struct mlx5dr_action_nat64_attr attr;
+	uint8_t regs[MLX5_FLOW_NAT64_REGS_MAX];
+	uint32_t i, from, to;
+	int rc;
+	bool unified_fdb = is_unified_fdb(priv);
+
 	attr.registers = regs;
 	/* Try to use 3 registers by default. */
 	attr.num_of_registers = MLX5_FLOW_NAT64_REGS_MAX;
@@ -9602,25 +9750,22 @@ flow_hw_create_nat64_actions(struct mlx5_priv *priv, struct rte_flow_error *erro
 		MLX5_ASSERT(priv->sh->registers.nat64_regs[i] != REG_NON);
 		regs[i] = mlx5_convert_reg_to_field(priv->sh->registers.nat64_regs[i]);
 	}
-	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i < MLX5DR_TABLE_TYPE_MAX; i++) {
-		if (i == MLX5DR_TABLE_TYPE_FDB && !priv->sh->config.dv_esw_en)
-			continue;
-		attr.flags = (enum mlx5dr_action_nat64_flags)
-			     (MLX5DR_ACTION_NAT64_V6_TO_V4 | MLX5DR_ACTION_NAT64_BACKUP_ADDR);
-		act = mlx5dr_action_create_nat64(priv->dr_ctx, &attr, flags[i]);
-		if (!act)
-			return rte_flow_error_set(error, rte_errno,
-						  RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-						  "Failed to create v6 to v4 action.");
-		priv->action_nat64[i][RTE_FLOW_NAT64_6TO4] = act;
-		attr.flags = (enum mlx5dr_action_nat64_flags)
-			     (MLX5DR_ACTION_NAT64_V4_TO_V6 | MLX5DR_ACTION_NAT64_BACKUP_ADDR);
-		act = mlx5dr_action_create_nat64(priv->dr_ctx, &attr, flags[i]);
-		if (!act)
-			return rte_flow_error_set(error, rte_errno,
-						  RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-						  "Failed to create v4 to v6 action.");
-		priv->action_nat64[i][RTE_FLOW_NAT64_4TO6] = act;
+	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i <= MLX5DR_TABLE_TYPE_NIC_TX; i++) {
+		rc = _create_nat64_actions(priv, &attr, i, error);
+		if (rc)
+			return rc;
+	}
+	if (priv->sh->config.dv_esw_en) {
+		from = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_RX :
+					MLX5DR_TABLE_TYPE_FDB;
+		to = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_UNIFIED :
+			MLX5DR_TABLE_TYPE_FDB;
+
+		for (i = from; i <= to; i++) {
+			rc = _create_nat64_actions(priv, &attr, i, error);
+			if (rc)
+				return rc;
+		}
 	}
 	return 0;
 }
@@ -10933,8 +11078,13 @@ flow_hw_ct_pool_create(struct rte_eth_dev *dev,
 	}
 	reg_id = mlx5_flow_get_reg_id(dev, MLX5_ASO_CONNTRACK, 0, NULL);
 	flags |= MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_HWS_TX;
-	if (priv->sh->config.dv_esw_en && priv->master)
-		flags |= MLX5DR_ACTION_FLAG_HWS_FDB;
+	if (priv->sh->config.dv_esw_en && priv->master) {
+		flags |= ((is_unified_fdb(priv)) ?
+			(MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+			 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+			 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
+			 MLX5DR_ACTION_FLAG_HWS_FDB);
+	}
 	pool->dr_action = mlx5dr_action_create_aso_ct(priv->dr_ctx,
 						      (struct mlx5dr_devx_obj *)pool->devx_obj,
 						      reg_id - REG_C_0, flags);
@@ -11008,38 +11158,50 @@ flow_hw_destroy_vlan(struct rte_eth_dev *dev)
 }
 
 static int
-flow_hw_create_vlan(struct rte_eth_dev *dev)
+_create_vlan(struct mlx5_priv *priv, enum mlx5dr_table_type type)
 {
-	struct mlx5_priv *priv = dev->data->dev_private;
-	enum mlx5dr_table_type i;
 	const enum mlx5dr_action_flags flags[MLX5DR_TABLE_TYPE_MAX] = {
 		MLX5DR_ACTION_FLAG_HWS_RX,
 		MLX5DR_ACTION_FLAG_HWS_TX,
-		MLX5DR_ACTION_FLAG_HWS_FDB
+		MLX5DR_ACTION_FLAG_HWS_FDB,
+		MLX5DR_ACTION_FLAG_HWS_FDB_RX,
+		MLX5DR_ACTION_FLAG_HWS_FDB_TX,
+		MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED,
 	};
 
 	/* rte_errno is set in the mlx5dr_action* functions. */
+	priv->hw_pop_vlan[type] =
+		mlx5dr_action_create_pop_vlan(priv->dr_ctx, flags[type]);
+	if (!priv->hw_pop_vlan[type])
+		return -rte_errno;
+	priv->hw_push_vlan[type] =
+		mlx5dr_action_create_push_vlan(priv->dr_ctx, flags[type]);
+	if (!priv->hw_push_vlan[type])
+		return -rte_errno;
+	return 0;
+}
+
+static int
+flow_hw_create_vlan(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	enum mlx5dr_table_type i, from, to;
+	int rc;
+	bool unified_fdb = is_unified_fdb(priv);
+
 	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i <= MLX5DR_TABLE_TYPE_NIC_TX; i++) {
-		priv->hw_pop_vlan[i] =
-			mlx5dr_action_create_pop_vlan(priv->dr_ctx, flags[i]);
-		if (!priv->hw_pop_vlan[i])
-			return -rte_errno;
-		priv->hw_push_vlan[i] =
-			mlx5dr_action_create_push_vlan(priv->dr_ctx, flags[i]);
-		if (!priv->hw_pop_vlan[i])
-			return -rte_errno;
+		rc = _create_vlan(priv, i);
+		if (rc)
+			return rc;
 	}
+	from = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_RX : MLX5DR_TABLE_TYPE_FDB;
+	to = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_UNIFIED : MLX5DR_TABLE_TYPE_FDB;
 	if (priv->sh->config.dv_esw_en && priv->master) {
-		priv->hw_pop_vlan[MLX5DR_TABLE_TYPE_FDB] =
-			mlx5dr_action_create_pop_vlan
-				(priv->dr_ctx, MLX5DR_ACTION_FLAG_HWS_FDB);
-		if (!priv->hw_pop_vlan[MLX5DR_TABLE_TYPE_FDB])
-			return -rte_errno;
-		priv->hw_push_vlan[MLX5DR_TABLE_TYPE_FDB] =
-			mlx5dr_action_create_push_vlan
-				(priv->dr_ctx, MLX5DR_ACTION_FLAG_HWS_FDB);
-		if (!priv->hw_pop_vlan[MLX5DR_TABLE_TYPE_FDB])
-			return -rte_errno;
+		for (i = from; i <= to; i++) {
+			rc = _create_vlan(priv, i);
+			if (rc)
+				return rc;
+		}
 	}
 	return 0;
 }
@@ -11512,6 +11674,7 @@ static int
 flow_hw_action_template_drop_init(struct rte_eth_dev *dev,
 			  struct rte_flow_error *error)
 {
+	uint32_t i, from, to;
 	const struct rte_flow_action drop[2] = {
 		[0] = { .type = RTE_FLOW_ACTION_TYPE_DROP },
 		[1] = { .type = RTE_FLOW_ACTION_TYPE_END },
@@ -11521,28 +11684,31 @@ flow_hw_action_template_drop_init(struct rte_eth_dev *dev,
 	const struct rte_flow_actions_template_attr attr[MLX5DR_TABLE_TYPE_MAX] = {
 		[MLX5DR_TABLE_TYPE_NIC_RX] = { .ingress = 1 },
 		[MLX5DR_TABLE_TYPE_NIC_TX] = { .egress = 1 },
-		[MLX5DR_TABLE_TYPE_FDB] = { .transfer = 1 }
+		[MLX5DR_TABLE_TYPE_FDB] = { .transfer = 1 },
+		[MLX5DR_TABLE_TYPE_FDB_RX] = { .transfer = 1 },
+		[MLX5DR_TABLE_TYPE_FDB_TX] = { .transfer = 1 },
+		[MLX5DR_TABLE_TYPE_FDB_UNIFIED] = { .transfer = 1 },
 	};
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	priv->action_template_drop[MLX5DR_TABLE_TYPE_NIC_RX] =
-		flow_hw_actions_template_create(dev,
-						&attr[MLX5DR_TABLE_TYPE_NIC_RX],
-						actions, masks, error);
-	if (!priv->action_template_drop[MLX5DR_TABLE_TYPE_NIC_RX])
-		return -1;
-	priv->action_template_drop[MLX5DR_TABLE_TYPE_NIC_TX] =
-		flow_hw_actions_template_create(dev,
-						&attr[MLX5DR_TABLE_TYPE_NIC_TX],
-						actions, masks, error);
-	if (!priv->action_template_drop[MLX5DR_TABLE_TYPE_NIC_TX])
-		return -1;
-	if (priv->sh->config.dv_esw_en && priv->master) {
-		priv->action_template_drop[MLX5DR_TABLE_TYPE_FDB] =
-			flow_hw_actions_template_create(dev,
-							&attr[MLX5DR_TABLE_TYPE_FDB],
-							actions, masks, error);
-		if (!priv->action_template_drop[MLX5DR_TABLE_TYPE_FDB])
+	from = MLX5DR_TABLE_TYPE_NIC_RX;
+	to = MLX5DR_TABLE_TYPE_NIC_TX;
+	for (i = from; i <= to; i++) {
+		priv->action_template_drop[i] =
+			flow_hw_actions_template_create(dev, &attr[i], actions, masks, error);
+		if (!priv->action_template_drop[i])
+			return -1;
+	}
+
+	if (!(priv->sh->config.dv_esw_en && priv->master))
+		return 0;
+
+	from = MLX5DR_TABLE_TYPE_FDB;
+	to = is_unified_fdb(priv) ? MLX5DR_TABLE_TYPE_FDB_UNIFIED : MLX5DR_TABLE_TYPE_FDB;
+	for (i = from; i <= to; i++) {
+		priv->action_template_drop[i] =
+			flow_hw_actions_template_create(dev, &attr[i], actions, masks, error);
+		if (!priv->action_template_drop[i])
 			return -1;
 	}
 	return 0;
@@ -11747,6 +11913,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	struct rte_flow_queue_attr **_queue_attr = NULL;
 	struct rte_flow_queue_attr ctrl_queue_attr = {0};
 	bool is_proxy = !!(priv->sh->config.dv_esw_en && priv->master);
+	bool unified_fdb = is_unified_fdb(priv);
 	int ret = 0;
 	uint32_t action_flags;
 	bool strict_queue = false;
@@ -11942,9 +12109,17 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
 		uint32_t act_flags = 0;
 
-		act_flags = mlx5_hw_act_flag[i][0] | mlx5_hw_act_flag[i][1];
-		if (is_proxy)
-			act_flags |= mlx5_hw_act_flag[i][2];
+		act_flags = mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
+			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
+		if (is_proxy) {
+			if (unified_fdb)
+				act_flags |=
+					(mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX] |
+					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_TX] |
+					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
+			else
+				act_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
+		}
 		priv->hw_drop[i] = mlx5dr_action_create_dest_drop(priv->dr_ctx, act_flags);
 		if (!priv->hw_drop[i])
 			goto err;
@@ -11967,8 +12142,18 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	 */
 	action_flags = MLX5DR_ACTION_FLAG_ROOT_RX | MLX5DR_ACTION_FLAG_HWS_RX |
 		       MLX5DR_ACTION_FLAG_ROOT_TX | MLX5DR_ACTION_FLAG_HWS_TX;
-	if (is_proxy)
-		action_flags |= (MLX5DR_ACTION_FLAG_ROOT_FDB | MLX5DR_ACTION_FLAG_HWS_FDB);
+	if (is_proxy) {
+		if (unified_fdb)
+			action_flags |=
+				(MLX5DR_ACTION_FLAG_ROOT_FDB |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED);
+		else
+			action_flags |=
+				(MLX5DR_ACTION_FLAG_ROOT_FDB |
+				 MLX5DR_ACTION_FLAG_HWS_FDB);
+	}
 	priv->hw_def_miss = mlx5dr_action_create_default_miss(priv->dr_ctx, action_flags);
 	if (!priv->hw_def_miss)
 		goto err;
@@ -13322,16 +13507,21 @@ static int flow_hw_prepare(struct rte_eth_dev *dev,
 	return 0;
 }
 
-#define FLOW_HW_SET_DV_FIELDS(flow_attr, root, dv_resource) {					\
-	typeof(flow_attr) _flow_attr = (flow_attr);						\
-	if (_flow_attr->transfer)								\
-		dv_resource.ft_type = MLX5DV_FLOW_TABLE_TYPE_FDB;				\
-	else											\
-		dv_resource.ft_type = _flow_attr->egress ? MLX5DV_FLOW_TABLE_TYPE_NIC_TX :	\
-					     MLX5DV_FLOW_TABLE_TYPE_NIC_RX;			\
-	root = _flow_attr->group ? 0 : 1;							\
-	dv_resource.flags =									\
-		mlx5_hw_act_flag[!!_flow_attr->group][get_mlx5dr_table_type(_flow_attr)];	\
+static inline void
+flow_hw_set_dv_fields(struct rte_flow_template_table_attr *table_attr, uint32_t fdb_unified_en,
+		      bool *root, uint8_t *ft_type, uint64_t *flags)
+{
+	if (table_attr->flow_attr.transfer)
+		*ft_type = MLX5DV_FLOW_TABLE_TYPE_FDB;
+	else
+		*ft_type = table_attr->flow_attr.egress ?
+					MLX5DV_FLOW_TABLE_TYPE_NIC_TX :
+					MLX5DV_FLOW_TABLE_TYPE_NIC_RX;
+	uint32_t group = table_attr->flow_attr.group;
+	*root = group ? 0 : 1;
+	*flags = mlx5_hw_act_flag[!!group][get_mlx5dr_table_type(&table_attr->flow_attr,
+								 table_attr->specialize,
+								 fdb_unified_en)];
 }
 
 static int
@@ -13342,7 +13532,9 @@ flow_hw_modify_hdr_resource_register
 			 struct rte_flow_hw *dev_flow,
 			 struct rte_flow_error *error)
 {
-	struct rte_flow_attr *attr = &table->cfg.attr.flow_attr;
+	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
+	struct rte_flow_template_table_attr *table_attr = &table->cfg.attr;
 	struct mlx5_flow_dv_modify_hdr_resource *dv_resource_ptr = NULL;
 	union {
 		struct mlx5_flow_dv_modify_hdr_resource dv_resource;
@@ -13358,7 +13550,9 @@ flow_hw_modify_hdr_resource_register
 	} else {
 		return 0;
 	}
-	FLOW_HW_SET_DV_FIELDS(attr, dummy.dv_resource.root, dummy.dv_resource);
+	flow_hw_set_dv_fields(table_attr, unified_fdb,
+			      &dummy.dv_resource.root, &dummy.dv_resource.ft_type,
+			      &dummy.dv_resource.flags);
 	dummy.dv_resource.flags |= MLX5DR_ACTION_FLAG_SHARED;
 	ret = __flow_modify_hdr_resource_register(dev, &dummy.dv_resource,
 		&dv_resource_ptr, error);
@@ -13381,7 +13575,9 @@ flow_hw_encap_decap_resource_register
 			 struct rte_flow_hw *dev_flow,
 			 struct rte_flow_error *error)
 {
-	struct rte_flow_attr *attr = &table->cfg.attr.flow_attr;
+	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
+	struct rte_flow_template_table_attr *table_attr = &table->cfg.attr;
 	struct mlx5_flow_dv_encap_decap_resource *dv_resource_ptr = NULL;
 	struct mlx5_flow_dv_encap_decap_resource dv_resource;
 	struct mlx5_tbl_multi_pattern_ctx *mpctx = &table->mpctx;
@@ -13393,7 +13589,8 @@ flow_hw_encap_decap_resource_register
 		dv_resource.reformat_type = hw_acts->encap_decap->action_type;
 	else
 		return 0;
-	FLOW_HW_SET_DV_FIELDS(attr, is_root, dv_resource);
+	flow_hw_set_dv_fields(table_attr, unified_fdb, &is_root, &dv_resource.ft_type,
+			      &dv_resource.flags);
 	ix = mlx5_bwc_multi_pattern_reformat_to_index((enum mlx5dr_action_type)
 			dv_resource.reformat_type);
 	if (ix < 0)
@@ -14252,8 +14449,11 @@ mirror_format_tir(struct rte_eth_dev *dev,
 	uint32_t hws_flags;
 	enum mlx5dr_table_type table_type;
 	struct mlx5_hrxq *tir_ctx;
+	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
 
-	table_type = get_mlx5dr_table_type(&table_cfg->attr.flow_attr);
+	table_type = get_mlx5dr_table_type(&table_cfg->attr.flow_attr, table_cfg->attr.specialize,
+					   unified_fdb);
 	hws_flags = mlx5_hw_act_flag[MLX5_HW_ACTION_FLAG_NONE_ROOT][table_type];
 	tir_ctx = flow_hw_tir_action_register(dev, hws_flags, action);
 	if (!tir_ctx)
@@ -14417,6 +14617,7 @@ mlx5_hw_mirror_handle_create(struct rte_eth_dev *dev,
 	struct mlx5_mirror *mirror;
 	enum mlx5dr_table_type table_type;
 	struct mlx5_priv *priv = dev->data->dev_private;
+	bool unified_fdb = is_unified_fdb(priv);
 	const struct rte_flow_attr *flow_attr = &table_cfg->attr.flow_attr;
 	uint8_t reformat_buf[MLX5_MIRROR_MAX_CLONES_NUM][MLX5_ENCAP_MAX_LEN];
 	struct mlx5dr_action_dest_attr mirror_attr[MLX5_MIRROR_MAX_CLONES_NUM + 1];
@@ -14425,7 +14626,7 @@ mlx5_hw_mirror_handle_create(struct rte_eth_dev *dev,
 
 	memset(mirror_attr, 0, sizeof(mirror_attr));
 	memset(array_action_types, 0, sizeof(array_action_types));
-	table_type = get_mlx5dr_table_type(flow_attr);
+	table_type = get_mlx5dr_table_type(flow_attr, table_cfg->attr.specialize, unified_fdb);
 	hws_flags = mlx5_hw_act_flag[MLX5_HW_ACTION_FLAG_NONE_ROOT][table_type];
 	clones_num = mlx5_hw_mirror_actions_list_validate(dev, flow_attr,
 							  actions);
@@ -16423,12 +16624,17 @@ mlx5_flow_hw_ctrl_flow_dmac_vlan_destroy(struct rte_eth_dev *dev,
 }
 
 static __rte_always_inline uint32_t
-mlx5_reformat_domain_to_tbl_type(const struct rte_flow_indir_action_conf *domain)
+mlx5_reformat_domain_to_tbl_type(const struct rte_flow_indir_action_conf *domain,
+				 bool fdb_unified_en)
 {
 	uint32_t tbl_type;
 
 	if (domain->transfer)
-		tbl_type = MLX5DR_ACTION_FLAG_HWS_FDB;
+		tbl_type = (fdb_unified_en ?
+			   (MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+			    MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+			    MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
+			   MLX5DR_ACTION_FLAG_HWS_FDB);
 	else if (domain->egress)
 		tbl_type = MLX5DR_ACTION_FLAG_HWS_TX;
 	else if (domain->ingress)
@@ -16448,8 +16654,9 @@ __mlx5_reformat_create(struct rte_eth_dev *dev,
 	struct mlx5_hw_encap_decap_action *handle;
 	struct mlx5dr_action_reformat_header hdr;
 	uint32_t flags;
+	bool unified_fdb = is_unified_fdb(priv);
 
-	flags = mlx5_reformat_domain_to_tbl_type(domain);
+	flags = mlx5_reformat_domain_to_tbl_type(domain, unified_fdb);
 	flags |= (uint32_t)MLX5DR_ACTION_FLAG_SHARED;
 	if (flags == UINT32_MAX) {
 		DRV_LOG(ERR, "Reformat: invalid indirect action configuration");
diff --git a/drivers/net/mlx5/mlx5_flow_meter.c b/drivers/net/mlx5/mlx5_flow_meter.c
index 804f437..dab3c4b 100644
--- a/drivers/net/mlx5/mlx5_flow_meter.c
+++ b/drivers/net/mlx5/mlx5_flow_meter.c
@@ -105,7 +105,11 @@ mlx5_flow_meter_init_guest(struct rte_eth_dev *dev)
 	priv->hws_mpool->devx_obj = host_priv->hws_mpool->devx_obj;
 	flags = MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_HWS_TX;
 	if (priv->sh->config.dv_esw_en && priv->master)
-		flags |= MLX5DR_ACTION_FLAG_HWS_FDB;
+		flags |= (is_unified_fdb(priv) ?
+			 (MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+			  MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+			  MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
+			 MLX5DR_ACTION_FLAG_HWS_FDB);
 	priv->hws_mpool->action = mlx5dr_action_create_aso_meter
 			(priv->dr_ctx, (struct mlx5dr_devx_obj *)priv->hws_mpool->devx_obj,
 			 reg_id - REG_C_0, flags);
@@ -188,8 +192,14 @@ mlx5_flow_meter_init(struct rte_eth_dev *dev,
 		goto err;
 	}
 	flags = MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_HWS_TX;
-	if (priv->sh->config.dv_esw_en && priv->master)
-		flags |= MLX5DR_ACTION_FLAG_HWS_FDB;
+	if (priv->sh->config.dv_esw_en && priv->master) {
+		flags |= ((is_unified_fdb(priv)) ?
+			(MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+			 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+			 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
+			 MLX5DR_ACTION_FLAG_HWS_FDB);
+	}
+
 	priv->mtr_bulk.action = mlx5dr_action_create_aso_meter
 			(priv->dr_ctx, (struct mlx5dr_devx_obj *)dcs,
 				reg_id - REG_C_0, flags);
diff --git a/drivers/net/mlx5/mlx5_flow_quota.c b/drivers/net/mlx5/mlx5_flow_quota.c
index 6ad0e8a..d94167d 100644
--- a/drivers/net/mlx5/mlx5_flow_quota.c
+++ b/drivers/net/mlx5/mlx5_flow_quota.c
@@ -741,8 +741,13 @@ mlx5_flow_quota_init(struct rte_eth_dev *dev, uint32_t nb_quotas)
 		ret = mlx5_quota_init_guest(priv);
 	if (ret)
 		goto err;
-	if (priv->sh->config.dv_esw_en && priv->master)
-		flags |= MLX5DR_ACTION_FLAG_HWS_FDB;
+	if (priv->sh->config.dv_esw_en && priv->master) {
+		flags |= (is_unified_fdb(priv) ?
+				(MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
+				MLX5DR_ACTION_FLAG_HWS_FDB);
+	}
 	qctx->dr_action = mlx5dr_action_create_aso_meter
 		(priv->dr_ctx, (struct mlx5dr_devx_obj *)qctx->devx_obj,
 		 reg_id - REG_C_0, flags);
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index eaceedd..7b5e731 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -666,8 +666,13 @@ mlx5_hws_cnt_pool_action_create(struct mlx5_priv *priv,
 	uint32_t flags;
 
 	flags = MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_HWS_TX;
-	if (priv->sh->config.dv_esw_en && priv->master)
-		flags |= MLX5DR_ACTION_FLAG_HWS_FDB;
+	if (priv->sh->config.dv_esw_en && priv->master) {
+		flags |= (is_unified_fdb(priv) ?
+				(MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+				 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
+				MLX5DR_ACTION_FLAG_HWS_FDB);
+	}
 	for (idx = 0; idx < hpool->dcs_mng.batch_total; idx++) {
 		struct mlx5_hws_cnt_dcs *hdcs = &hpool->dcs_mng.dcs[idx];
 		struct mlx5_hws_cnt_dcs *dcs = &cpool->dcs_mng.dcs[idx];
-- 
2.8.4

