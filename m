Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72203CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 10:20:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C96A4029F;
	Fri, 22 May 2026 12:20:17 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by mails.dpdk.org (Postfix) with ESMTP id 04FE44028D;
 Fri, 22 May 2026 12:20:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L36FZ5bFWdjiRFT6TxqhkUqBOxrlzOZIqRzJsAKUzRNiUeNGdmrLt0iIlLZdJCBs4F6i2xiI032OLGVv3r45PvbaobEgZUB35Q5empHt8kRvdALpLD35qxnE9OrMjtK8LZocWcCUD5ob/7snKG3rpL7TO8bWrLxldJWz3kvlHDZq+5EVRMLJKE/Qggec90gUALV5DMq9cl17iOjQZ47BTLcq2UsvS3QdgK4aD2hCoCmpG8Qu0QMCUSbZIr4P8uEizT4wCUqosCFCOIiGmXwGfklLmVKQrDfY4awioNDIy4vT51AMeIzO12pfLBDCwSooAk2BCM33tsB3CjWNOMSJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPjO/Ixiu548om9AmDcG2yd0w2XF8MQFnjJ7Sbg0j8s=;
 b=MkxKmnN8vCScn6zOSKR8LIiNodGf82KbLyq5uF5xTPU6H+7sKEv8OF9e+ywvXJbLV8eZAir8vkWMEjgsbY4+Ft4OAHPvgwF9T7XHN1DpS8sDNjiriTGuPAVF2NFeu9+V0A3PlWf19UWLcgjuLatmsIqsenTPtixZLn7GWXYfr5WI/ld18nUPH7ruQOa3LPQCcQPhZSrSbcCFnghL055JSh2P5hEUw84TWHachUDKQks2wg3nIWtMU48qLJNHwbNJRVCBs7N+QBdpob+JspSBPjGQ9XQPmh/D72u2WzqmREmec1bcKEBs8Am1I7OypNYCsasDpPRGMNFkiWnGxlYClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPjO/Ixiu548om9AmDcG2yd0w2XF8MQFnjJ7Sbg0j8s=;
 b=byi/V8xhbrNNr8c9jTSfUsNsC+UvC6POOY5DbFKzvBwC3IHuIa/qYBvG7K/ksj44by9IX7bX0eShQWCBbDlgEFsSNVuX3XPCg8U2lWKxyqr4PvEexR1YihsJ6NAE9jM7ngYMXkMlS+bicv5y78A7ehE7gOpaDMaUJz6+nMolO3WQhWLjp3vl1skk2kTqZCJoOqaPvl6wwOqd1oCC8vaFLKCYiNAX+ZDeYrHuc4nzoqQtB5gOoHsr0r/GraZiqpV6MwQEzHmiRaW/OenCTkpQ1zSLjk0k738teA+s8o4iQRjl+7qMPbl1TnMRvu1MvHOU1NNcRt2X0N9GNJc12mlGmA==
Received: from SA1PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:2d3::23)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 10:20:07 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::a6) by SA1PR03CA0011.outlook.office365.com
 (2603:10b6:806:2d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 10:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 10:20:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 22 May
 2026 03:19:49 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 22 May
 2026 03:19:46 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: use port index as representor index
Date: Fri, 22 May 2026 12:19:33 +0200
Message-ID: <20260522101933.540423-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS7PR12MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ee6743-d8fb-407d-f664-08deb7ebb26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: G2Xi84SBjotPuas6RJwGB1fVW8nZLlhLYvIVKpF0gcsrWgsQmeveGxAEZoyBViOTQ2yk8ohUB3zv9BTx0+G58jP78yzjniOygwtI79LRnkIHlV542O7xb6qLgql856QbCV3v+zanFxZXgXTAz7ZXGGBhLHYI8OQ5NhS6nJhrq7PZMjLeZoxo0HGCDEA28TLsqoCKL6mORdagxhpBwRLXgr9sWoaOvo6Qdz0o7W+BswmYqwP7kY9595AUOrEAKHMJNfiEuuoo77uD2sjpVWl+4ZLiBKJK7cSoeAzuIfFenRo4AKhYSIfgQn5ARFFXImE9Q5csNRgPTiM7NMIktd8Jlmd3MMqpRS+3UCuPmT+1uQF3ZJU4/mNqosPCNfuRwa5qk37xkk6JHnVv+ZnIH6NnBHOalhZwxyP3N62AsY34qqqmPxvu2Hryd2EkEhN/qlTE5q+qD+8CARBAJl7tTwjLH5XqX62ycKnsd8nNVIzMiZRy4XqdbYa69wx/vDZOsQ5hVjnn6kCVIHYdnbtRfeoSdxUC+j/fSLl/qiph5Mn5PKI6B32JnR40Jlfi0gtyMoOJdmPtUoH7HVWTSONhvWbUkPEh8jncMT268r0e1irC4Pbip04LLx7GpQCkP8ZXAAZ3hG1O0jARU5JeQ0DOuycqecviXyYVDqkmbZaCvIk8fC+Rk6DI+PYqGeWYO/UFB7rfw0BlmJn77SUECs1Dn6QY8iZGTOUojoRpfnyfX+vt2h4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: di+J/SysZeU0DCBq9079PyHniXjVBy/wrdzFOSI38QaGXkihYCJfpam+l3li0FXLkg8hAIJQREqwGy/ln4TIfDlkGCdbTP7V1sidAAoo7OihfzHs4gdlUrCn/zJV3Ccy7FrOAqonAL/xVxDLQ6OnfYylTXm4wy90r0yqDukEhUA9D7svZEovrJtt3kBaK8vQKeiv5wdxh+GM5dVneBP9+XWC04s599/Wrg/u2XTSr95ZEPf71foNr2VyB/Lhc/W5Juy9JuKl14Dfemv1Vp+9Q0hvZ92kuZKocqEn082ig36cHr4PPM/hPv8Jwxv80cD63IRzjUgvNJkWLIr/jW7katyOdTsCUMZPXOkixG9Xi3dZ1S5BRS9NGcJvA1if9GUv3u1SpqKKJ/za6zIqqfvEIgJacgXy5UMqeIhbLjyF6bz7qt+Uc7N6foS6frymiR9t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 10:20:07.0493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ee6743-d8fb-407d-f664-08deb7ebb26d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503
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

Since the offending commit, mlx5 driver supports probing
representors on BlueField DPUs with Socket Direct (SD).
Such card can be connected to 2 different CPUs on the host system.
On DPU, user would see the following network devices:

- p0 and p1 - physical ports
- pf0hpf and pf2hpf - PF0 on CPU 0 and CPU 1 respectively
- pf1hpf and pf3hpf - PF1 on CPU 0 and CPU 1 respectively

mlx5 driver finds the relevant netdev by matching information
provided in representor devarg to phys_port_name
reported by Linux kernel.
For the above interfaces phys_port_name's would be reported
and probed as:

- p0 -> p0, no need for representor devarg
- p1 -> p1, with representor=pf1
- pf0hpf -> c1pf0, with representor=c1pf0vf65535
- pf1hpf -> c1pf1, with representor=c1pf1vf65535
- pf2hpf -> c2pf0, with representor=c2pf0vf65535
- pf3hpf -> c2pf1, with representor=c2pf1vf65535

Although hot-plugging all these representors is successful,
RTE_ETH_FOREACH_MATCHING_DEV() macro would find DPDK ports.
This is caused missing information reported by mlx5 driver,
through rte_eth_representor_info_get() API.
Specifically, mlx5 driver did not report controller index for all
representor ranges.

Until now mlx5 driver used static encoding for 16-bit representor_id:

- 2 bits for representor type
- 2 bits for PF index
- 2 bits for representor index (either VF or SF number)

Controller index was not encoded. This caused the mentioned issue
and on top of that:

- limits the number of PFs
- limits the number of SFs

This patch changes the mlx5 driver logic for
rte_eth_representor_info_get().
Instead of static encoding:

- representor_id's will be dynamically assigned
  to each probed representor.
- rte_eth_representor_info_get() will report N ranges:
    - N == number of probed ports on single embedded switch
    - Each range will define single representor_id
      for given controller/PF/VF/SF.

Fixes: 2f7cdd821b1b ("net/mlx5: fix probing to allow BlueField Socket Direct")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c |   6 +-
 drivers/net/mlx5/mlx5.h          |  19 +++
 drivers/net/mlx5/mlx5_ethdev.c   | 284 +++++++++++++++++++------------
 3 files changed, 199 insertions(+), 110 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 0fc721592b..5305523c1b 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1677,9 +1677,13 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		err = ENOMEM;
 		goto error;
 	}
+	priv->port_info.type = spawn->info.name_type;
+	priv->port_info.ctrl_num = spawn->info.ctrl_num;
+	priv->port_info.pf_num = spawn->info.pf_num;
+	priv->port_info.port_num = spawn->info.port_name;
 	if (priv->representor) {
 		eth_dev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
-		eth_dev->data->representor_id = priv->representor_id;
+		eth_dev->data->representor_id = eth_dev->data->port_id;
 		MLX5_ETH_FOREACH_DEV(port_id, dpdk_dev) {
 			struct mlx5_priv *opriv =
 				rte_eth_devices[port_id].data->dev_private;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 49a0c03544..23803b450b 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1984,6 +1984,24 @@ struct mlx5_quota_ctx {
 	struct mlx5_indexed_pool *quota_ipool; /* Manage quota objects */
 };
 
+/* Stores info parsed from phys_port_name related to given DPDK port. */
+struct mlx5_representor_info {
+	enum mlx5_nl_phys_port_name_type type;
+	/* PCI controller index. 0 if no controller was reported in phys_port_name. */
+	int32_t ctrl_num;
+	/* PF index. */
+	int32_t pf_num;
+	/*
+	 * Representor number:
+	 *
+	 * - For VF/SF - VF/SF index.
+	 * - For PFHPF - -1.
+	 * - For uplink - physical port index.
+	 * - For others - VF representor is assumed, so VF index.
+	 */
+	int32_t port_num;
+};
+
 struct mlx5_nta_sample_ctx;
 struct mlx5_priv {
 	struct rte_eth_dev_data *dev_data;  /* Pointer to device data. */
@@ -2019,6 +2037,7 @@ struct mlx5_priv {
 	uint32_t vport_meta_tag; /* Used for vport index match ove VF LAG. */
 	uint32_t vport_meta_mask; /* Used for vport index field match mask. */
 	uint16_t representor_id; /* UINT16_MAX if not a representor. */
+	struct mlx5_representor_info port_info;
 	int32_t pf_bond; /* >=0, representor owner PF index in bonding. */
 	int32_t mpesw_owner; /* >=0, representor owner PF index in MPESW. */
 	int32_t mpesw_port; /* Related port index of MPESW device. < 0 - no MPESW. */
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index a29cdeeb50..e14b7f148b 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -345,6 +345,23 @@ mlx5_dev_get_max_wq_size(struct mlx5_dev_ctx_shared *sh)
 	return max_wqe;
 }
 
+/**
+ * Get switch port ID for given DPDK port.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ * @return
+ *   Switch port ID reported through rte_eth_dev_info_get().
+ */
+static uint16_t
+mlx5_dev_switch_info_port_id_get(struct rte_eth_dev *dev)
+{
+	if (rte_eth_dev_is_repr(dev))
+		return dev->data->port_id;
+
+	return UINT16_MAX;
+}
+
 /**
  * DPDK callback to get information about the device.
  *
@@ -401,7 +418,7 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		info->dev_capa |= RTE_ETH_DEV_CAPA_RXQ_SHARE;
 	info->switch_info.name = dev->data->name;
 	info->switch_info.domain_id = priv->domain_id;
-	info->switch_info.port_id = priv->representor_id;
+	info->switch_info.port_id = mlx5_dev_switch_info_port_id_get(dev);
 	info->switch_info.rx_domain = 0; /* No sub Rx domains. */
 	if (priv->representor) {
 		uint16_t port_id;
@@ -472,14 +489,162 @@ mlx5_representor_id_encode(const struct mlx5_switch_info *info,
 	return MLX5_REPRESENTOR_ID(pf, type, repr);
 }
 
+static unsigned int
+mlx5_representor_info_count_one(struct mlx5_priv *priv)
+{
+	switch (priv->port_info.type) {
+	case MLX5_PHYS_PORT_NAME_TYPE_PFHPF:
+		return 2;
+	case MLX5_PHYS_PORT_NAME_TYPE_UPLINK:
+		/* Only representor uplinks should be reported */
+		if (!priv->representor)
+			return 0;
+		return 1;
+	case MLX5_PHYS_PORT_NAME_TYPE_NOTSET:
+		/* FALLTHROUGH */
+	case MLX5_PHYS_PORT_NAME_TYPE_LEGACY:
+		/* FALLTHROUGH */
+	case MLX5_PHYS_PORT_NAME_TYPE_PFVF:
+		/* FALLTHROUGH */
+	case MLX5_PHYS_PORT_NAME_TYPE_PFSF:
+		/* FALLTHROUGH */
+	case MLX5_PHYS_PORT_NAME_TYPE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		return 1;
+	}
+}
+
+static unsigned int
+mlx5_representor_info_count(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	uint16_t port_id;
+	unsigned int count = 0;
+
+	MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
+		struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+
+		if (!opriv ||
+		    opriv->sh != priv->sh ||
+		    opriv->domain_id != priv->domain_id)
+			continue;
+
+		count += mlx5_representor_info_count_one(opriv);
+	}
+
+	return count;
+}
+
+static void
+mlx5_representor_info_fill_one(struct mlx5_priv *priv,
+			       struct rte_eth_representor_info *info)
+{
+	struct rte_eth_representor_range *range;
+	unsigned int count;
+
+	count = mlx5_representor_info_count_one(priv);
+	if (count == 0)
+		return;
+
+	if (info->nb_ranges + count > info->nb_ranges_alloc) {
+		DRV_LOG(ERR, "port %u representor info already full", priv->dev_data->port_id);
+		return;
+	}
+
+	range = &info->ranges[info->nb_ranges];
+
+	switch (priv->port_info.type) {
+	case MLX5_PHYS_PORT_NAME_TYPE_UPLINK:
+		range->type = RTE_ETH_REPRESENTOR_PF;
+		range->controller = priv->port_info.ctrl_num;
+		range->pf = priv->port_info.port_num;
+		range->id_base = priv->dev_data->port_id;
+		range->id_end = range->id_base;
+		snprintf(range->name, sizeof(range->name), "pf%d", range->pf);
+		break;
+	case MLX5_PHYS_PORT_NAME_TYPE_PFSF:
+		/* Secondly, fill in SF variant. */
+		range->type = RTE_ETH_REPRESENTOR_SF;
+		range->controller = priv->port_info.ctrl_num;
+		range->pf = priv->port_info.pf_num;
+		range->sf = priv->port_info.port_num;
+		range->id_base = priv->dev_data->port_id;
+		range->id_end = range->id_base;
+		snprintf(range->name, sizeof(range->name), "pf%dsf", range->pf);
+		break;
+	case MLX5_PHYS_PORT_NAME_TYPE_PFHPF:
+		/*
+		 * Host PF can be probed either through VF(0xffff) or SF(0xffff).
+		 * Firstly fill in VF variant.
+		 */
+		range->type = RTE_ETH_REPRESENTOR_VF;
+		range->controller = priv->port_info.ctrl_num;
+		range->pf = priv->port_info.pf_num;
+		range->vf = UINT16_MAX;
+		range->id_base = priv->dev_data->port_id;
+		range->id_end = range->id_base;
+		snprintf(range->name, sizeof(range->name), "pf%dvf", range->pf);
+
+		/* Move the SF variant. */
+		range++;
+
+		/* Fill in SF variant. */
+		range->type = RTE_ETH_REPRESENTOR_SF;
+		range->controller = priv->port_info.ctrl_num;
+		range->pf = priv->port_info.pf_num;
+		range->sf = UINT16_MAX;
+		range->id_base = priv->dev_data->port_id;
+		range->id_end = range->id_base;
+		snprintf(range->name, sizeof(range->name), "pf%dsf", range->pf);
+		break;
+	case MLX5_PHYS_PORT_NAME_TYPE_PFVF:
+		/* FALLTHROUGH */
+	case MLX5_PHYS_PORT_NAME_TYPE_NOTSET:
+		/* FALLTHROUGH */
+	case MLX5_PHYS_PORT_NAME_TYPE_LEGACY:
+		/* FALLTHROUGH */
+	case MLX5_PHYS_PORT_NAME_TYPE_UNKNOWN:
+		range->type = RTE_ETH_REPRESENTOR_VF;
+		range->controller = priv->port_info.ctrl_num;
+		range->pf = priv->port_info.pf_num;
+		range->vf = priv->port_info.port_num;
+		range->id_base = priv->dev_data->port_id;
+		range->id_end = range->id_base;
+		snprintf(range->name, sizeof(range->name), "pf%dvf", range->pf);
+		break;
+	}
+
+	info->nb_ranges += count;
+}
+
+static unsigned int
+mlx5_representor_info_fill(struct rte_eth_dev *dev,
+			   struct rte_eth_representor_info *info)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	uint16_t port_id;
+
+	info->controller = priv->port_info.ctrl_num;
+	info->pf = RTE_DEV_TO_PCI(dev->device)->addr.function;
+
+	MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
+		struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+
+		if (!opriv ||
+		    opriv->sh != priv->sh ||
+		    opriv->domain_id != priv->domain_id)
+			continue;
+
+		mlx5_representor_info_fill_one(opriv, info);
+	}
+
+	return info->nb_ranges;
+}
+
 /**
  * DPDK callback to get information about representor.
  *
- * Representor ID bits definition:
- *   vf/sf: 12
- *   type: 2
- *   pf: 2
- *
  * @param dev
  *   Pointer to Ethernet device structure.
  * @param[out] info
@@ -492,110 +657,11 @@ int
 mlx5_representor_info_get(struct rte_eth_dev *dev,
 			  struct rte_eth_representor_info *info)
 {
-	struct mlx5_priv *priv = dev->data->dev_private;
-	/* Representor types: PF, VF, HPF@VF, SF and HPF@SF, total 5. */
-	int n_type = RTE_ETH_REPRESENTOR_PF + 2; /* Maximal type + 2 for HPFs. */
-	int n_pf = 8; /* Maximal number of PFs. */
-	int i = 0, pf;
-	int n_entries;
-
 	if (info == NULL)
-		goto out;
-
-	n_entries = n_type * n_pf;
-	if ((uint32_t)n_entries > info->nb_ranges_alloc)
-		n_entries = info->nb_ranges_alloc;
-
-	info->controller = 0;
-	info->pf = 0;
-	if (mlx5_is_port_on_mpesw_device(priv)) {
-		info->pf = priv->mpesw_port;
-		for (i = 0; i < n_pf; i++) {
-			/* PF range, both ports will show the same information. */
-			info->ranges[i].type = RTE_ETH_REPRESENTOR_PF;
-			info->ranges[i].controller = 0;
-			info->ranges[i].pf = priv->mpesw_owner + i + 1;
-			info->ranges[i].vf = 0;
-			/*
-			 * The representor indexes should be the values set of "priv->mpesw_port".
-			 * In the real case now, only 1 PF/UPLINK representor is supported.
-			 * The port index will always be the value of "owner + 1".
-			 */
-			info->ranges[i].id_base =
-				MLX5_REPRESENTOR_ID(priv->mpesw_owner,
-						    info->ranges[i].type,
-						    info->ranges[i].pf);
-			info->ranges[i].id_end =
-				MLX5_REPRESENTOR_ID(priv->mpesw_owner,
-						    info->ranges[i].type,
-						    info->ranges[i].pf);
-			snprintf(info->ranges[i].name,
-				 sizeof(info->ranges[i].name),
-				 "pf%d", info->ranges[i].pf);
-		}
-	} else if (priv->pf_bond >= 0)
-		info->pf = priv->pf_bond;
-	for (pf = 0; pf < n_pf; ++pf) {
-		/* VF range. */
-		info->ranges[i].type = RTE_ETH_REPRESENTOR_VF;
-		info->ranges[i].controller = 0;
-		info->ranges[i].pf = pf;
-		info->ranges[i].vf = 0;
-		info->ranges[i].id_base =
-			MLX5_REPRESENTOR_ID(pf, info->ranges[i].type, 0);
-		info->ranges[i].id_end =
-			MLX5_REPRESENTOR_ID(pf, info->ranges[i].type, -1);
-		snprintf(info->ranges[i].name,
-			 sizeof(info->ranges[i].name), "pf%dvf", pf);
-		i++;
-		if (i == n_entries)
-			break;
-		/* HPF range of VF type. */
-		info->ranges[i].type = RTE_ETH_REPRESENTOR_VF;
-		info->ranges[i].controller = 0;
-		info->ranges[i].pf = pf;
-		info->ranges[i].vf = UINT16_MAX;
-		info->ranges[i].id_base =
-			MLX5_REPRESENTOR_ID(pf, info->ranges[i].type, -1);
-		info->ranges[i].id_end =
-			MLX5_REPRESENTOR_ID(pf, info->ranges[i].type, -1);
-		snprintf(info->ranges[i].name,
-			 sizeof(info->ranges[i].name), "pf%dvf", pf);
-		i++;
-		if (i == n_entries)
-			break;
-		/* SF range. */
-		info->ranges[i].type = RTE_ETH_REPRESENTOR_SF;
-		info->ranges[i].controller = 0;
-		info->ranges[i].pf = pf;
-		info->ranges[i].vf = 0;
-		info->ranges[i].id_base =
-			MLX5_REPRESENTOR_ID(pf, info->ranges[i].type, 0);
-		info->ranges[i].id_end =
-			MLX5_REPRESENTOR_ID(pf, info->ranges[i].type, -1);
-		snprintf(info->ranges[i].name,
-			 sizeof(info->ranges[i].name), "pf%dsf", pf);
-		i++;
-		if (i == n_entries)
-			break;
-		/* HPF range of SF type. */
-		info->ranges[i].type = RTE_ETH_REPRESENTOR_SF;
-		info->ranges[i].controller = 0;
-		info->ranges[i].pf = pf;
-		info->ranges[i].vf = UINT16_MAX;
-		info->ranges[i].id_base =
-			MLX5_REPRESENTOR_ID(pf, info->ranges[i].type, -1);
-		info->ranges[i].id_end =
-			MLX5_REPRESENTOR_ID(pf, info->ranges[i].type, -1);
-		snprintf(info->ranges[i].name,
-			 sizeof(info->ranges[i].name), "pf%dsf", pf);
-		i++;
-		if (i == n_entries)
-			break;
-	}
-	info->nb_ranges = i;
-out:
-	return n_type * n_pf;
+		return mlx5_representor_info_count(dev);
+
+	return mlx5_representor_info_fill(dev, info);
+
 }
 
 /**
-- 
2.47.3

