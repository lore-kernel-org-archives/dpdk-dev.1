Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D2D2505D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 09:25:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBF7040B90;
	Mon, 12 Jan 2026 10:25:14 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by mails.dpdk.org (Postfix) with ESMTP id DE96F40B8F;
 Mon, 12 Jan 2026 10:25:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1wyHumhMN0LlF0M/xiPmqn1S6bSXFe2Q6wvQcIPYLVoBvUSQmDYTs2lGhsu7D5EfqhAuTO3MWowwEFlI2bhGkfc4gYFs131iDj9eX0Db+OgbyD5Bt+FsJoYzjzOgzeAwuMNDa/gbcTDuduel3G/E7+60L7eIemN4R1Y8O22l5TDbGuxo2wOhKP9ck/NyizAP79ikHc3kCipVIGFVDfs58sff4K/qbe/pwTpVKBIotBOm9+igajGW4A2Ho4KhtP5Yl5UzppPeRfiU0CBr9UzpoUMJDJYYD32XqnRaYOF6S5yRwRi8n28+KeIc1j3znLUWlGGsKUgQgwv2xLuOq8IdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUSKUPa0SvIRdj1yb3D0j34DN0fny0LNMAwxc92vKq8=;
 b=ERbMpMGKZK+43P3qqJCNKhnvzQ/HfwY3thRuTa3INk4O6dsVxpwty5BY7AC+beSeZ6VIPeKc60ICyE6YgH4K5mO1SrdHVpADOuXiMHiAn/oX9lGfeZNGmH0WLl791T71INl+3Q/3D3go29k6dkN3CZVXhdmtCLQcjB6nn1Dlmi2IkVUse2retmfo+j/Suxq1JNjROGPXqnnEvYA3TW3RuFKgUH+U4Pv3nXzSvrb168rijbMoq5jDjUkEAnMUf2M88xcGyCIa0CaKtp+8xzWwO1a8q2+fg9BYhSgvV862rfJziL2nOziNqbwgMoXssFKLlY/ILAd7FFKuzaKvOuFGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUSKUPa0SvIRdj1yb3D0j34DN0fny0LNMAwxc92vKq8=;
 b=hhJilJkDm9CRm1Qpy6NIbRZdXuP+/YGadNqZGs1f3b+ch+rmY0qvXOmRZbjC+ecVQ0xmFCaJfKJbSVvKaz0Ea+yVM1wGrv9ZLjMx/BNwkCHY/S1tVok+jYC2XK3KbDcAzuSCSecI9gNJukYLtkVIX+OL7JCpsY80+CdhXIQVJ3z02kSBG+5xEKXpNGyiPOt1NWHqURQWXXD3+kMKMDTHVvkjRLRK7qF3wk0YDMPwhFM9tHdyWzAv2/fXHLAygB+ViptphjD31Lv4pH4gbM0ETF4wY4S6KTxYRyvwtIMkW88EopfhglXPG5EDD/WVY2qZZi0VAK4QYtNYxfpRvBO3wQ==
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 09:25:07 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::69) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:25:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:24:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 01:24:53 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 01:24:51 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/4] net/mlx5: fix default memzone requirements in HWS
Date: Mon, 12 Jan 2026 11:24:36 +0200
Message-ID: <20260112092439.14843-3-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260112092439.14843-1-mkashani@nvidia.com>
References: <20260112092439.14843-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4184dddd-7cd3-4831-138b-08de51bc79f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HZuV2VSGIX3m3ZBW6oAmYM9Gy5kcqdsazYG0ThPHArquXXTJJigBcSkWvr7z?=
 =?us-ascii?Q?661J5Qjyv2WebySP4Kl1Pib+6GgxPVb4nk92qTUC0vM8YowEWPa6vzHzmaBo?=
 =?us-ascii?Q?OasVxv2M/dp3/lCf91K41WqqXdkeXsuyYMrzsmv1Kfa2NhfQgyFKw/voM/68?=
 =?us-ascii?Q?UhGpkk6WH/V7Crd+hk24d//AWaQpaf6D8icNAUpThqMksyeJLw52lgf/mh9g?=
 =?us-ascii?Q?blaGA5+8RtTt0hgBqa9wrh/WSlUVcJb3qD5+sqOaEWHqJOGmzZSkNNj/vnhZ?=
 =?us-ascii?Q?3dk7PmPCcBYqsoBeLECmvZDqbVqlIZA7AvA1Ji0lKfIKGTNOLQiMv3ClIMTw?=
 =?us-ascii?Q?3N5KE5QeoutxwqtOutatBRbbvutjmdAdWDZtwPRaNfI12gq8uLeBXgfBVQ9Y?=
 =?us-ascii?Q?708E248pt6rrbsoe2ND5IK0LkCTO/gXxs1yt7plDlj9rYV/qgM6k5evbc8x2?=
 =?us-ascii?Q?1GZsGhTbnYlmv0HHO+1RCduAXWUSjabVI1jHhPI8jyAK5bNguzqe1h0U3i6D?=
 =?us-ascii?Q?+kIOc89hVrWitD2vFOzZPrszduX3ipGl36MQfJKBW2OKw1U7AfNqD8/D2Fk0?=
 =?us-ascii?Q?4Xk0Ol9vp2gv95NeKt1xDlChe/RE2AN/kS9sEczEBPZlNT3oSjgxAXxcB1WO?=
 =?us-ascii?Q?zEv7ScG4sHUaaev1R8coCGQjsmwqWjrUab+3W1lVQEVb9g+A8eOmrxiUkFjM?=
 =?us-ascii?Q?WWU/exl1LHXVmRqiadyyTNczYDlq7f7l0L2TL0Zm8vIEP5Xsp5YeU24EXTUI?=
 =?us-ascii?Q?JKfx8UQTrfoXIAbZ1SwVH1mChL3o1UuzTc4GrB/yl2DpiraWWOXFBGmcaYKe?=
 =?us-ascii?Q?At0HxQOgiy+13hh946A1Y/URwTGAUPb7qMCYo7sx5n4+eg5dOrHwvm8i+OGh?=
 =?us-ascii?Q?wzOaObhslb7GTJHIEbGqvzP1RJFfEJx7AS/G+VYUWUu7lNhd6vN1KpoqEWKN?=
 =?us-ascii?Q?S1HMbk/uwN+Hn/eUfQ02EikWgs4GaPt/hY9b/76LrfKwb0xD00XkdIfg1ysr?=
 =?us-ascii?Q?bIGR05iZbRlD4+u6/2Gx0p3KneaMGdW7tVJkS9uFc0pt5Kq6zsBLeU/hudOl?=
 =?us-ascii?Q?MQw/SlBUWL9rhnOWiiRHJISkhcneGJedEnRiQY+Fvaok/Rw73OJQCcqDiJlB?=
 =?us-ascii?Q?FPQ2vcEI6g/O0hWvc5eJIDXnJDD/N9m2YkwAIOkFlgTOAQ9fgYPe4/0/ac+2?=
 =?us-ascii?Q?zeAD820s7kfFCKJWHtGdZuXIhYKUj3maTCZ6m/YhMGoU3xdt7224IjdmYZCz?=
 =?us-ascii?Q?20wU5uQWIxEjP4UwjTq3p3V/nc+yFLln4y2tb0BTrBu/ZoVBeUH24jDBaqAA?=
 =?us-ascii?Q?GUvWuz/Uzof0FSuYYbdhEQEafXdKLQvX1YCfKSYTuQkm/fD3lBAVBL/Ga2tQ?=
 =?us-ascii?Q?sMAkkCaXl3lGhdYQfF32lULBCysd0YcAXIp4D+Pe9nuoL28YjscTHgduXsYK?=
 =?us-ascii?Q?sD9hVlOCIzxckxtP04vtlE4GcDlzBoc6d8Xv5lvEkwvJlWlYZ0tZf+DcMF8k?=
 =?us-ascii?Q?H1eCr8WfY27T7Rb5PcyJQDXODg9HiV47l+X8CT2ZWdKd1HGWhDBS6Z+YVaTM?=
 =?us-ascii?Q?jf/wv2kAtw0NB6F42gc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:25:07.3794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4184dddd-7cd3-4831-138b-08de51bc79f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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

From: Dariusz Sosnowski <dsosnowski@nvidia.com>

Commit [1] has changed the default behavior of flow engine selection
in mlx5 PMD to accommodate for new NIC generations.
Whenever underlying device does not support SWS (e.g., ConnectX-9
or untrusted VFs/SFs) and device does support HWS,
default flow engine would be HWS (dv_flow_en=2) which also supports
sync flow API.

This behavior change had consequence in memory usage whenever
SFs are probed by DPDK. In default HWS configuration supporting
sync flow API (i.e. without calling rte_flow_configure())
mlx5 PMD allocated 4 rte_ring objects per port:

- indir_iq and indir_cq - For handling indirect action completions.
- flow_transfer_pending and flow_transfer_completed - For handling
  template table resizing.

This has not happened previously with SWS as default flow engine.

Since a dedicated memzone is allocated for each rte_ring object,
this lead to exhaustion of default memzone limit
on setups with ~1K SFs to probe.
It resulted in the following error on port start:

    EAL: memzone_reserve_aligned_thread_unsafe():
        Number of requested memzone segments exceeds maximum 2560
    RING: Cannot reserve memory
    mlx5_net: Failed to start port 998 mlx5_core.sf.998:
        fail to configure port

Since template table resizing is allowed if and only if
async flow API was configured, 2 of the aforementioned rings
are never used in the default sync flow API configuration.

This patch removes allocation of flow_transfer_pending and
flow_transfer_completed rings in default sync flow API configuration
of mlx5 PMD to reduce memzone usage and allow DPDK probing
to succeed on setups with ~1K SFs to probe.

[1] commit d1ac7b6c64d9
    ("net/mlx5: update flow devargs handling for future HW")

Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 86 ++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 98483abc7fc..1dada2e7cef 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -4483,6 +4483,9 @@ mlx5_hw_pull_flow_transfer_comp(struct rte_eth_dev *dev,
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_ring *ring = priv->hw_q[queue].flow_transfer_completed;
 
+	if (ring == NULL)
+		return 0;
+
 	size = RTE_MIN(rte_ring_count(ring), n_res);
 	for (i = 0; i < size; i++) {
 		res[i].status = RTE_FLOW_OP_SUCCESS;
@@ -4714,8 +4717,9 @@ __flow_hw_push_action(struct rte_eth_dev *dev,
 	struct mlx5_hw_q *hw_q = &priv->hw_q[queue];
 
 	mlx5_hw_push_queue(hw_q->indir_iq, hw_q->indir_cq);
-	mlx5_hw_push_queue(hw_q->flow_transfer_pending,
-			   hw_q->flow_transfer_completed);
+	if (hw_q->flow_transfer_pending != NULL && hw_q->flow_transfer_completed != NULL)
+		mlx5_hw_push_queue(hw_q->flow_transfer_pending,
+				   hw_q->flow_transfer_completed);
 	if (!priv->shared_host) {
 		if (priv->hws_ctpool)
 			mlx5_aso_push_wqe(priv->sh,
@@ -11889,6 +11893,60 @@ mlx5_hwq_ring_create(uint16_t port_id, uint32_t queue, uint32_t size, const char
 			       RING_F_SP_ENQ | RING_F_SC_DEQ | RING_F_EXACT_SZ);
 }
 
+static int
+flow_hw_queue_setup_rings(struct rte_eth_dev *dev,
+			  uint16_t queue,
+			  uint32_t queue_size,
+			  bool nt_mode)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	/* HWS queue info container must be already allocated. */
+	MLX5_ASSERT(priv->hw_q != NULL);
+
+	/* Notice ring name length is limited. */
+	priv->hw_q[queue].indir_cq = mlx5_hwq_ring_create
+		(dev->data->port_id, queue, queue_size, "indir_act_cq");
+	if (!priv->hw_q[queue].indir_cq) {
+		DRV_LOG(ERR, "port %u failed to allocate indir_act_cq ring for HWS",
+			dev->data->port_id);
+		return -ENOMEM;
+	}
+
+	priv->hw_q[queue].indir_iq = mlx5_hwq_ring_create
+		(dev->data->port_id, queue, queue_size, "indir_act_iq");
+	if (!priv->hw_q[queue].indir_iq) {
+		DRV_LOG(ERR, "port %u failed to allocate indir_act_iq ring for HWS",
+			dev->data->port_id);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Sync flow API does not require rings used for table resize handling,
+	 * because these rings are only used through async flow APIs.
+	 */
+	if (nt_mode)
+		return 0;
+
+	priv->hw_q[queue].flow_transfer_pending = mlx5_hwq_ring_create
+		(dev->data->port_id, queue, queue_size, "tx_pending");
+	if (!priv->hw_q[queue].flow_transfer_pending) {
+		DRV_LOG(ERR, "port %u failed to allocate tx_pending ring for HWS",
+			dev->data->port_id);
+		return -ENOMEM;
+	}
+
+	priv->hw_q[queue].flow_transfer_completed = mlx5_hwq_ring_create
+		(dev->data->port_id, queue, queue_size, "tx_done");
+	if (!priv->hw_q[queue].flow_transfer_completed) {
+		DRV_LOG(ERR, "port %u failed to allocate tx_done ring for HWS",
+			dev->data->port_id);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int
 flow_hw_validate_attributes(const struct rte_flow_port_attr *port_attr,
 			    uint16_t nb_queue,
@@ -12057,22 +12115,8 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 		      &priv->hw_q[i].job[_queue_attr[i]->size];
 		for (j = 0; j < _queue_attr[i]->size; j++)
 			priv->hw_q[i].job[j] = &job[j];
-		/* Notice ring name length is limited. */
-		priv->hw_q[i].indir_cq = mlx5_hwq_ring_create
-			(dev->data->port_id, i, _queue_attr[i]->size, "indir_act_cq");
-		if (!priv->hw_q[i].indir_cq)
-			goto err;
-		priv->hw_q[i].indir_iq = mlx5_hwq_ring_create
-			(dev->data->port_id, i, _queue_attr[i]->size, "indir_act_iq");
-		if (!priv->hw_q[i].indir_iq)
-			goto err;
-		priv->hw_q[i].flow_transfer_pending = mlx5_hwq_ring_create
-			(dev->data->port_id, i, _queue_attr[i]->size, "tx_pending");
-		if (!priv->hw_q[i].flow_transfer_pending)
-			goto err;
-		priv->hw_q[i].flow_transfer_completed = mlx5_hwq_ring_create
-			(dev->data->port_id, i, _queue_attr[i]->size, "tx_done");
-		if (!priv->hw_q[i].flow_transfer_completed)
+
+		if (flow_hw_queue_setup_rings(dev, i, _queue_attr[i]->size, nt_mode) < 0)
 			goto err;
 	}
 	dr_ctx_attr.pd = priv->sh->cdev->pd;
@@ -15440,6 +15484,12 @@ flow_hw_update_resized(struct rte_eth_dev *dev, uint32_t queue,
 	};
 
 	MLX5_ASSERT(hw_flow->flags & MLX5_FLOW_HW_FLOW_FLAG_MATCHER_SELECTOR);
+	/*
+	 * Update resized can be called only through async flow API.
+	 * These rings are allocated if and only if async flow API was configured.
+	 */
+	MLX5_ASSERT(priv->hw_q[queue].flow_transfer_completed != NULL);
+	MLX5_ASSERT(priv->hw_q[queue].flow_transfer_pending != NULL);
 	/**
 	 * mlx5dr_matcher_resize_rule_move() accepts original table matcher -
 	 * the one that was used BEFORE table resize.
-- 
2.21.0

