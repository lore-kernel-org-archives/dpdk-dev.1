Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C32D358D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 08:13:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D47F402BA;
	Thu, 29 Jan 2026 09:13:46 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by mails.dpdk.org (Postfix) with ESMTP id 970CB4026A;
 Thu, 29 Jan 2026 09:13:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7y7NM7G/X5sJ5BTxMYcd9ML9QonYZfrDVYVLLdVmZyblUmI6JDqdcxSuwSZqvexyTUpup+giz0zloqGLboa+lQC083OB6mEpDD2s5apRq64PjR7+ZGFGSxQ/wgtdzjnPN/YXnroLzsylic0p8p62u/RrQDHV8rV7kngDrXtLCRHit/gjsBy7JTat4MTuJQjyWR3Sn8irrLE8T4J0NeCydLENGYQZl097qla3nxEK/PnJ9dBHkEu4WEetNqFEvkAR5WunMhDUOfrtx33zEdgktdmGPVnNUJU6jxaWyzPRsUiErXYvXsq0lkuWzyo5vLflMc8EShDh/Yaqm4H6dnZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbNDP0YoxrmQAx3bmtxkt28d1J6F+bk2Po8zIImMqyE=;
 b=VGR/5wPpEGSPlTvj7/hOugIxFfceE/GaNayoS7xbfeJ9T1ZD2ANzTDLsY3NOEHo0UYjONL4XJXGS6FTPuTx7pJKNQLFxe46G+6uWCAntA/0JJ3gLXf3P2heXN8GA36SoOTsVnHImozmbO11nwm+Hsr+W6ubBONjaZ6umdiDsBtPchEK5AJKodaJXrgTO2G16e3dbwNGd4QeGp/tlY6gs7DH+HCYn42ErzUrU9YU3IVP5Lik5trdMjBiGN12WoXmwvlji+XrSBsSlGh6/sE43BFoBkcTTyq1vl6ytXTqtfbdtLUajnaYD3W4CLejTZ5tl7J28b5x9N9Ilwi4ScazoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbNDP0YoxrmQAx3bmtxkt28d1J6F+bk2Po8zIImMqyE=;
 b=YkqHHWkiE6hPwMk/zQYfTgrYuDBIcom5DBoHylxcBak3lb9+gmRc1JKS2EVxB0SlEp1bwx0bffycPQ8AKDFgpBrg5Svv0n8FUU8UebLfhl6PGc1P53w7k4gOwSSf7Hg8cwF36hhpVhiCZmBjpwgTLiglbdurL9JK4loJuBK0LLj9u9XDfYdJrYW/ZsBGBFeVP9oqKC3TDwPr0Cuo6Ab7UgpETZrZ/2I7Qh2vudQq7OQFH1nTmhwOO03X3znk8ILFsW37l/fFEMW2uBRO5b5+OsY8nj/asMH/3qgBGLld7J+k7jK4BvegKJeyllA0duCApBB6oNHpaTP7QTnVHTD2tg==
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:13:37 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::8d) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 08:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 08:13:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 00:13:30 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 00:13:29 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 00:13:27 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <dsosnowski@nvidia.com>, Shani Peretz
 <shperetz@nvidia.com>, <a.schollmeyer@syseleven.de>, <stable@dpdk.org>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Xueming Li <xuemingl@nvidia.com>
Subject: [PATCH v2] net/mlx5: allow MTU mismatch for running shared Rx queues
Date: Thu, 29 Jan 2026 10:13:23 +0200
Message-ID: <20260129081323.4713-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117073937.1514124-1-shperetz@nvidia.com>
References: <20251117073937.1514124-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: a391d682-f4d1-42fa-75c2-08de5f0e4e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cwCL4G4291Cy9lkSd0DQ7THFaRr10iZDqiCnoCiK8xiz9jwdL19lYzrMS8Yp?=
 =?us-ascii?Q?t30TyD0uQUH1qWm+q6CfE84jUQFGXfsUkjSSnXsEifNwsKfzw0zq7v4SRHDp?=
 =?us-ascii?Q?V0oFg/w+rUsal2VOMm8tiPNedGE63Fsl2cEBhl1WJ2jX1avFcvsmBjcdVpRV?=
 =?us-ascii?Q?IwbM5wSouoo1UEoXkBPW0i139l1E0iRwbE+c6RqGWkVxALrjg70WIdk8t5Ch?=
 =?us-ascii?Q?2bNkb7t+rfVfFinLcRvxNalb8BrR5QpGK7Q2X1wfqG4RzzOL+aG2itqqcNXA?=
 =?us-ascii?Q?yNvYiNOjUIwUrtFqkiffc+RWImK3gyyuDBP3lFd50a6ZHtIlDX19wX8FzHJo?=
 =?us-ascii?Q?nGwt9aGz2pX0XSbQFXY0QsKEIwRptcpTEbJsi+ze31ZadIse8g7p2iIAJcrj?=
 =?us-ascii?Q?VYNXxIXZGUejdDgn1TNIhkaziQdhRKKOItBBMdLFPoyhcAWoLGJ0YTE1h16/?=
 =?us-ascii?Q?X5PGWkVTNBbmM+6v3z2xmAzGQAqKVd0wMpLcVAB4Oxy3cdVaQXmGYX9DVrX0?=
 =?us-ascii?Q?xQCu4MqVVD2sPC//zH4KRa5mLb8k/blZWEcIcgMyTnO+hOzyDn2kN6ZzRx7c?=
 =?us-ascii?Q?WqbBij2gsa8SOZA5KdHZOn9ucYHWavpPrFydIM7C1KZFDii8cAeiFosbcAQb?=
 =?us-ascii?Q?Sp/HqTxh7MiRpZgnRi3IOwelyx8wNskaxokSNfaGDJu9H1mSOwEXWmNdH1Sc?=
 =?us-ascii?Q?Dxcx2XBAxDxPZ5bxBNbkTQMBJVj1eSXmSGuOSdHkhm4No1CEls/Rx3Immzzg?=
 =?us-ascii?Q?luo9i8LnEDRw9IA+7sbVhLiDzt1uyi48d1YWaArdrz5l+BGRiFTxfOJL+bfB?=
 =?us-ascii?Q?NhjxrpBO8SvjNT70uDruSolk+fFQyygucSO+A8lH4KwdnJL0S7gPIDrPAgGF?=
 =?us-ascii?Q?J1BJbuSzPYVhbQgsS2/LSvx/LwHzqRwS2s9yYh87g5Rfuv568mZcNY0rsyKX?=
 =?us-ascii?Q?aFICo7oUhvnaAdpcvt5mXwzxwZnzwRXk1tj2Pj5spCKJPjgARsP7R6osOxJm?=
 =?us-ascii?Q?b1dgt/9wvXSuFeEiQMr4kM8WeYlPYslStmAT1Hblv6k784rX9629B3UlKAjz?=
 =?us-ascii?Q?zJLVN8yLpnXE3srgkx7sTQG0n0n8ForS3y7nrwBs6LLGVAyT93yUZJfDBoyO?=
 =?us-ascii?Q?hYEi1eOyr0oUtclRtTVA5xZFatk7Qvnulf6MBmocEnCfqQNM8pm9r9hBfFu1?=
 =?us-ascii?Q?1rhmxu6a/BHT7vvg36/efFS6zIJhcnOuEJnNz9XWA8HISqgWaVB6zooSOjF7?=
 =?us-ascii?Q?BGRhziXYpGD7paC84nOesnQRlBbgQ56FDaZGYshDRypJ0RjVhV+oTx6oytQW?=
 =?us-ascii?Q?IMbnpgsi7edPZA+1hmhsBdQElYCUKIe0bDtxPZOBilA6ymd6MO/8K3hXaO0W?=
 =?us-ascii?Q?JpvVB+NFtElAzl1y7F2AXRL98FgC72tNhQ3zbk2opmwAHJqvS8ZAvgS9lD8m?=
 =?us-ascii?Q?ZwFyaQFnTX3o4xsO9fEeL9hFPWRR6PGYoBcuCEYw7OLjR9xXavfAW+9YYXoj?=
 =?us-ascii?Q?MuonrrzAjYzHqTmxaLzZdvFhf7inQTKffnAZid6m5HNAYZ0QRpBYaSj8Xixq?=
 =?us-ascii?Q?FWUBa5ukEMA6Jiqn9ax/dOQO+JWkLi7XbKlIODzQZYnYpEzkuNt+3jr3uyj9?=
 =?us-ascii?Q?PiknV4uUHvjR5Dbq5tGlb69FvgBYqUmKPWvmKX/8iGg5808krbkT6skCS7I1?=
 =?us-ascii?Q?k9jG3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 08:13:37.4894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a391d682-f4d1-42fa-75c2-08de5f0e4e08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287
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

Previously, mlx5_shared_rxq_match() rejected any MTU mismatch between
a port and the shared RX queue, even when the queue hardware was already
running. This caused failures when hot-adding representors after runtime
MTU changes (new port has default MTU=1500, but running queue was created
with MTU=9000). It also prevented proper port reconfiguration scenarios.

The fix allows MTU mismatches when rxq_ctrl->obj != NULL (queue is
running), since runtime MTU changes via rte_eth_dev_set_mtu() only update
software bookkeeping without recreating hardware resources. Stopped queues
still enforce MTU matching to trigger proper reconfiguration.

This patch also removes the redundant priv->mtu field and uses
dev->data->mtu consistently for MTU tracking throughout the driver.

Fixes: 4414eb800708 ("net/mlx5: store MTU at Rx queue allocation time")
Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")
Cc: a.schollmeyer@syseleven.de
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst           |  6 +++
 drivers/net/mlx5/linux/mlx5_os.c   |  6 +--
 drivers/net/mlx5/mlx5.h            |  1 -
 drivers/net/mlx5/mlx5_ethdev.c     |  3 --
 drivers/net/mlx5/mlx5_rxq.c        | 85 ++++++++++++++++++++++++------
 drivers/net/mlx5/windows/mlx5_os.c |  6 +--
 6 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 904a0ac358..66323907a9 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1827,6 +1827,12 @@ Limitations
 
 #. Counters of received packets and bytes of queues in the same group and queue ID are same.
 
+#. Each Rx queue in share group must have the same queue configuration.
+
+#. Ports in share group must have equal MTU at port start time.
+
+#. Reconfiguring a shared queue while it is in use (started or referenced by flows) is not allowed.
+
 
 .. _mlx5_rx_threshold:
 
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7f73183bb1..e8c4fb62c8 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1334,7 +1334,6 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	priv->sh = sh;
 	priv->dev_port = spawn->phys_port;
 	priv->pci_dev = spawn->pci_dev;
-	priv->mtu = RTE_ETHER_MTU;
 	/* Some internal functions rely on Netlink sockets, open them now. */
 	priv->nl_socket_rdma = nl_rdma;
 	priv->nl_socket_route =	mlx5_nl_init(NETLINK_ROUTE, 0);
@@ -1606,14 +1605,13 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	}
 #endif
 	/* Get actual MTU if possible. */
-	err = mlx5_get_mtu(eth_dev, &priv->mtu);
+	err = mlx5_get_mtu(eth_dev, &eth_dev->data->mtu);
 	if (err) {
 		err = rte_errno;
 		goto error;
 	}
-	eth_dev->data->mtu = priv->mtu;
 	DRV_LOG(DEBUG, "port %u MTU is %u", eth_dev->data->port_id,
-		priv->mtu);
+		eth_dev->data->mtu);
 	/* Initialize burst functions to prevent crashes before link-up. */
 	eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
 	eth_dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 966e802f5f..551f3b9d17 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1983,7 +1983,6 @@ struct mlx5_priv {
 	uint16_t vlan_filter[MLX5_MAX_VLAN_IDS]; /* VLAN filters table. */
 	unsigned int vlan_filter_n; /* Number of configured VLAN filters. */
 	/* Device properties. */
-	uint16_t mtu; /* Configured MTU. */
 	uint16_t min_mtu; /* Minimum MTU allowed on the NIC. */
 	uint16_t max_mtu; /* Maximum MTU allowed on the NIC. */
 	unsigned int isolated:1; /* Whether isolated mode is enabled. */
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index c93a7ac4f2..00a1d444ef 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -679,7 +679,6 @@ mlx5_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 int
 mlx5_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 {
-	struct mlx5_priv *priv = dev->data->dev_private;
 	uint16_t kern_mtu = 0;
 	int ret;
 
@@ -688,7 +687,6 @@ mlx5_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 		return ret;
 
 	if (kern_mtu == mtu) {
-		priv->mtu = mtu;
 		DRV_LOG(DEBUG, "port %u adapter MTU was already set to %u",
 			dev->data->port_id, mtu);
 		return 0;
@@ -702,7 +700,6 @@ mlx5_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 	if (ret)
 		return ret;
 	if (kern_mtu == mtu) {
-		priv->mtu = mtu;
 		DRV_LOG(DEBUG, "port %u adapter MTU set to %u",
 			dev->data->port_id, mtu);
 		return 0;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 9210a92c5f..c4ba746d47 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -659,8 +659,6 @@ mlx5_rx_queue_pre_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t *desc,
 			struct mlx5_rxq_ctrl **rxq_ctrl)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_rxq_priv *rxq;
-	bool empty;
 
 	if (*desc > mlx5_dev_get_max_wq_size(priv->sh)) {
 		DRV_LOG(ERR,
@@ -699,14 +697,6 @@ mlx5_rx_queue_pre_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t *desc,
 		if ((*rxq_ctrl)->obj != NULL)
 			/* Some port using shared Rx queue has been started. */
 			return 0;
-		/* Release all owner RxQ to reconfigure Shared RxQ. */
-		do {
-			rxq = LIST_FIRST(&(*rxq_ctrl)->owners);
-			LIST_REMOVE(rxq, owner_entry);
-			empty = LIST_EMPTY(&(*rxq_ctrl)->owners);
-			mlx5_rxq_release(ETH_DEV(rxq->priv), rxq->idx);
-		} while (!empty);
-		*rxq_ctrl = NULL;
 	}
 	return 0;
 }
@@ -780,10 +770,21 @@ mlx5_shared_rxq_match(struct mlx5_rxq_ctrl *rxq_ctrl, struct rte_eth_dev *dev,
 			dev->data->port_id, idx);
 		return false;
 	}
-	if (priv->mtu != rxq_ctrl->mtu) {
-		DRV_LOG(ERR, "port %u queue index %u failed to join shared group: mtu mismatch",
-			dev->data->port_id, idx);
-		return false;
+	if (dev->data->mtu != rxq_ctrl->mtu) {
+		/*
+		 * MTU mismatch is only a problem when the queue hasn't been started yet.
+		 * If rxq_ctrl->obj is NULL, the queue hardware objects haven't been created,
+		 * meaning we're in the initial configuration phase where MTU must match.
+		 * If obj != NULL, the queue is already running with its hardware configured,
+		 * and runtime MTU changes are safe as they only update software bookkeeping
+		 * without recreating hardware resources.
+		 */
+		if (rxq_ctrl->obj == NULL) {
+			DRV_LOG(DEBUG, "port %u queue index %u: mtu mismatch with existing shared rxq_ctrl "
+					"(port mtu=%u rxq_ctrl mtu=%u), reconfiguration needed",
+					dev->data->port_id, idx, dev->data->mtu, rxq_ctrl->mtu);
+			return false;
+		}
 	}
 	if (priv->dev_data->dev_conf.intr_conf.rxq !=
 	    spriv->dev_data->dev_conf.intr_conf.rxq) {
@@ -926,8 +927,57 @@ mlx5_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		if (rxq_ctrl != NULL &&
 		    !mlx5_shared_rxq_match(rxq_ctrl, dev, idx, desc, socket,
 					   conf, mp)) {
-			rte_errno = EINVAL;
-			return -rte_errno;
+			struct mlx5_rxq_priv *rxq_tmp;
+			bool empty;
+
+			/*
+			 * Configuration mismatch detected with existing shared RXQ.
+			 * We need to reconfigure, but only if it's safe to do so.
+			 *
+			 * First check: If hardware objects are allocated, the shared queue has
+			 * been started. Reconfiguration would require destroying and recreating
+			 * hardware resources, which cannot be done while the queue is active.
+			 * Return EBUSY to force caller to stop the queue first.
+			 */
+			if (rxq_ctrl->obj != NULL) {
+				DRV_LOG(ERR, "port %u queue index %u: cannot reconfigure shared RXQ while started",
+					dev->data->port_id, idx);
+				rte_errno = EBUSY;
+				return -rte_errno;
+			}
+
+			/*
+			 * Second check: Even if hardware objects aren't allocated yet,
+			 * verify that no owner port is actively using this queue.
+			 * refcnt == 1 means the queue exists but is idle (only setup reference).
+			 * refcnt > 1 means the queue is being used by flows or other components.
+			 * This prevents releasing a queue that other ports depend on.
+			 */
+			LIST_FOREACH(rxq_tmp, &rxq_ctrl->owners, owner_entry) {
+				if (rxq_tmp->refcnt > 1) {
+					DRV_LOG(ERR, "port %u queue index %u: cannot reconfigure shared RXQ "
+						"while other ports are running",
+						dev->data->port_id, idx);
+					rte_errno = EBUSY;
+					return -rte_errno;
+				}
+			}
+
+			/*
+			 * Safe to reconfigure: hardware not started and no active users.
+			 * Release all owner ports from the existing shared rxq_ctrl.
+			 * This will decrement references and eventually free the old rxq_ctrl.
+			 * Setting rxq_ctrl to NULL triggers creation of a new one below with
+			 * the updated configuration.
+			 */
+			do {
+				rxq_tmp = LIST_FIRST(&rxq_ctrl->owners);
+				LIST_REMOVE(rxq_tmp, owner_entry);
+				empty = LIST_EMPTY(&rxq_ctrl->owners);
+				mlx5_rxq_release(ETH_DEV(rxq_tmp->priv), rxq_tmp->idx);
+			} while (!empty);
+
+			rxq_ctrl = NULL;
 		}
 	} else {
 		res = mlx5_rx_queue_pre_setup(dev, idx, &desc, &rxq_ctrl);
@@ -1813,7 +1863,8 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	LIST_INIT(&tmpl->owners);
 	MLX5_ASSERT(n_seg && n_seg <= MLX5_MAX_RXQ_NSEG);
 	/*
-	 * Save the original MTU to check against for shared rx queues.
+	 * Save the current MTU to check against for shared rx queues.
+	 * Use dev->data->mtu which reflects the actual current MTU.
 	 */
 	tmpl->mtu = dev->data->mtu;
 	/*
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 4eadc872a5..5dcabfbed2 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -396,7 +396,6 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	priv->sh = sh;
 	priv->dev_port = spawn->phys_port;
 	priv->pci_dev = spawn->pci_dev;
-	priv->mtu = RTE_ETHER_MTU;
 	priv->mp_id.port_id = port_id;
 	strlcpy(priv->mp_id.name, MLX5_MP_NAME, RTE_MP_MAX_NAME_LEN);
 	priv->representor = !!switch_info->representor;
@@ -504,14 +503,13 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	}
 #endif
 	/* Get actual MTU if possible. */
-	err = mlx5_get_mtu(eth_dev, &priv->mtu);
+	err = mlx5_get_mtu(eth_dev, &eth_dev->data->mtu);
 	if (err) {
 		err = rte_errno;
 		goto error;
 	}
-	eth_dev->data->mtu = priv->mtu;
 	DRV_LOG(DEBUG, "port %u MTU is %u.", eth_dev->data->port_id,
-		priv->mtu);
+		eth_dev->data->mtu);
 	/* Initialize burst functions to prevent crashes before link-up. */
 	eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
 	eth_dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
-- 
2.43.0

