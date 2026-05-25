Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039AECD5BBF
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 09:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8AEB402D0;
	Mon, 25 May 2026 11:18:22 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by mails.dpdk.org (Postfix) with ESMTP id 762F4402AC;
 Mon, 25 May 2026 11:18:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE/RRPt+vY7Ki0S8z4IXDz51iG7rQwzUtNuqwSBZknET3QTwYSK9CQpb1g6jYuKdQJg9a6zu5OtVbkEYWyHBJv55IIZwSYfszTC2fLsXBWKzFJ3PBR2w4itjtEyDE3bkat3rzhjFy/qob9QJLJGEofWsoytZVHXazdSyKdCikv4vXS1anDnFezigd12pVU4qTfyjF5/IT4j0CEccqhdv11275AAbYPfYVk1uwbRsjvPRUHQ7solT3Hu/ujnVgCRKx5eFW0uRRDbXLiC4KXbry5kZdtMr+uaiUHEOfAuPMS4U8MmVizSMA7V3Y2i0i+asXc1w7dxbcQgrTAtNjf8l9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skOswrMnKXQt9LAXSv/byhofZ5zKR2uC88lg75qM754=;
 b=gD6D9t3UqBS2WtJDpvoSabpr6MoB5gDGp/ievupY4hh/pOEADurbp2Qz/O4xT/eizDz7fFQvRYX5MTnHa+3OxEAin/1iY+61wuNehXRXTfcapyGb0GIJlYtpyMcx2NyZtNC5VEOrzIwucMVyRyaX0YUO6QX8QdIRtql/KGzkRCydy7yJZWxL8F+YHcAFFV+IT4HQI85I3FpsMbD8T3ZpeK5zTLp4fzTVJhvGihM3bbwJ28frJ8gThZ0ynl3AoOG5wS3Xg6Px1fberrw+XLw+6s6qfYbjECZ9GlZFLAxYc1bm222/N5SIgZAiBFUBmxHuexcl7hzAGbuL0T9zQvYr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skOswrMnKXQt9LAXSv/byhofZ5zKR2uC88lg75qM754=;
 b=OHgl/zKuKlk6OsGlri6IeMCrht+O6SuiI3Fi2tzHXxb+TLSW+wteBT/4ErH77hnXWHXbXpUejVI3lxG9XPGIcpB6bUGuYOvAoRuZUYZHhjhFqNfytKYz8QeR+3UWgTrAGWPGvY4kt7jbsi1X6CEy+8AKF7EQWG/wL6qAqB5UaC6Der+yNQJ68cqw9xd8EUs5C76tP/T+26y3pebcSzRPwLEaNdY/4Vl9zEWzna/r90WpIXVpcsTuB2/vIxteurufckb9822zbAeF5xS0luFeiVCvs78tokRNumV9HjUu6ZEDRIbTi0jxSe4+28kYbZR+VxTOGyL2Ov+IE3njNshNkA==
Received: from BY3PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:39a::23)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 09:18:12 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::18) by BY3PR03CA0018.outlook.office365.com
 (2603:10b6:a03:39a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 09:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 09:18:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 02:17:54 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 02:17:51 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2] net/mlx5: use port index as representor index
Date: Mon, 25 May 2026 11:17:32 +0200
Message-ID: <20260525091733.558838-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522101933.540423-1-dsosnowski@nvidia.com>
References: <20260522101933.540423-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 57402519-10d2-438d-cff8-08deba3e8b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|3023799007|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 72E3lO3hyKTmv1D9hK/6MrVlyNvdmak0EFLx0h7DfcsZatiOvUUrnYXxzJpk9cQ+XQ5mMIiXG7BAeuXX/YBIMb8cOas68ueOvxbpNzXzqe7fQ38zSP4oSDr1Od51i6iUh9Qgn0BxM1jTmSDOPx/Lw3AlkIkv6Q2Qs0Il8aie7sc4hHO3iYNQSMI07CxV8HdHlPd8OFUAw7AGaHKJD+D84qoeFBYmNjfqz9636cG/pqm8nZTs9tohby7OfbjGADsOGo/o+0pr4ZNdfaXyZtpycSpx2frSfzaLw+e4n7sjHOCTOD5fV/ZvReQ6peNhQ+n+hVFUOPHQ+PszmtuFwaAGBw1jcAaVPHecExSoW7J8rXyF29b5z9mo7cNeqB07NjW1XJKOzaKJWVtt4VgmEniSlLCWs+cCsGTc8sQdbfpT8Ci8j0Y87ebkcqXHq7dN5usgH2M+jFkc6Z7KW5rJImnuGwWqjiICL947dNt7tBJ1qEJbATG4LbMC1xuOaYNhXFhu9IVtGVFaR/jbfUVDT90OYNe8qRO0njvMgiNMUYoXkwsmjk9Fhj254iCe1EYW6rqVylXNFXu6cZbFEZChp8Jymf6xil2RTX6m1+XoKyfN73JRuzQoB1FyR3DVOFFg+U2TsV1zAFfobzw/3T2lUi95M0/tKYk9oKixruLLq3vsOprtTpE3Qs3cFAbsz/g5PjZhNpjU8c6QKkdbuYDYh28l+JNVrJmTXqE9i6zg/tlUPjE=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(3023799007)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HxPxaGPVnG5bZzN+SxVM8IxypDjwAp/dSXmH6gP73uvvo0HKb69mA+SvXE676fS34UR9Cky4O3fktO4602bIckJ/QPh29I1vU5gfyT89Nrf/AnK6ymtw0qRpUTWYVpjAX0ctGUBFeGeOfDZM8l9XDK6C3UENNp6SLB5naEdi849oIN35O2ax0ujNBpuaMFls3KdMmyLisrjZBLkoYwksRUrRZMybyUMI8XtfYSQSgGajrYtl/vOJTnnX7dCVueU2nKJZRq3Vnh8tPurRIqVrMh4KGAouF7N1KRIklEDoQnFJqRr+cr8cTQlUBONgFfyoef5bhjnDIKHPXsYKnY/6kBS5u+Jd2H+duFR6EtDw3IkhHv+BKcEjD1r6RXvoVckW/yDrPKLmREk6QKCnpa3MfLA9fVN61My2GYVY6TqC9wI/cDAAYw++koiKNqFbWRXw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 09:18:12.0917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57402519-10d2-438d-cff8-08deba3e8b56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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
RTE_ETH_FOREACH_MATCHING_DEV() macro would not find DPDK ports.
This is caused missing information reported by mlx5 driver,
through rte_eth_representor_info_get() API.
Specifically, mlx5 driver did not report controller index for all
representor ranges.

Until now mlx5 driver used static encoding for 16-bit representor_id:

- 2 bits for representor type
- 2 bits for PF index
- 12 bits for representor index (either VF or SF number)

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
v2:
- Added missing "not" in "RTE_ETH_FOREACH_MATCHING_DEV() macro would not find DPDK ports"
  in the commit message.
- Fixed typo in number of bits for representor index.
  Should be 12, not 2.

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

