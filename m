Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBB5CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 15:59:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C35454065B;
	Wed, 29 Oct 2025 16:59:28 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8]) by mails.dpdk.org (Postfix) with ESMTP id 28C18402E5;
 Wed, 29 Oct 2025 16:59:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sB9d0WXDC1wnja6rqtPocVeMONuz7Non8YFotso7sTIcoqt9R1pof8sjTeasV22G+U9MExcNa0NEAvuU0gSXydGijfmkoAwyQhpTE4aZh9HZn4Fhw7/WmGIc/lQAvkLnPMaFxIub5A7erYZk1IMYPFssrMWpgizSOxbDZzXJaUVh4wO1cH7Y+Fs68cyH5Up6K/2Qn8sHko9IbKK2d+RQ27E85pUMbiVaUJ8cOQP9oKXA5FjUgS5G3yk4uQgLrJjOM18YR644Q0oIDuNRd+ykEvlVYS7y0g6WvSEWt9VeHQH+sfwJw6nFoh3k+nqwGdg+IVnGZ7Ml8Zxm0ylojFK2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnQsBuaLPE86oYlj7Vyc/MLYyeTSEVThKjhyRlyGcVQ=;
 b=q+1Lxg9WAZbjrEE4380TxPMah1oouHZUHM+0MVZJXj3Pfh5u65mEJwEjrAPqBnnYr32oB+vG0bipaHwCY8fAZ10QIY1+vhWRwJ3GH32QISlox2REr2EOrDSyG1YmblxKA16A+GV9qNOfVrZ90fdsar+m2XM0mzfahAqYlu5yOA5KSu7/6wbrKf7MuOdYtqbZL7l2kKALl8JH+19CrdGoBZbGJcVwgh6kR9nU2lwHs1GT1xqFjBwSYN+ge2QVAfM9tupi/hQegpofRUrCBc3cJtJL43kf5pLHYdId5Vi6brawOngNfIw68xc8kC16LqXyJp+mwuffH2ZajLI7zce7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnQsBuaLPE86oYlj7Vyc/MLYyeTSEVThKjhyRlyGcVQ=;
 b=rCETlzhPtBFXuMuLMDBholgB78YOH/g72WCT9prSo+nq19Kg+ZhEuSPpRMwvxoVP9HTPmQVmh0BcTrt2/8wPQdatOkn11nP7YR9c6dh7lt/Getfo992AAmekpUm+wyxc+MaxQcrXY+bO+WDUOa79KbJPO1gghsfn3jAhSAyVAbf72JceDPUVjvNpGXMSAsbxtI1eDANEL4oUx6WAhZX09XfDzQwEGfM4lDpvRrmig6l24D/PSM0PG8a5lflmEH5YPMyvTsZVjfOEhDuU2qdysIVN8VZZyQd+VaRzPpjRUsipJDANWnonRJkzd4erdRLbZhA8CwvkRojmNIqsF7bTgg==
Received: from SJ0PR05CA0210.namprd05.prod.outlook.com (2603:10b6:a03:330::35)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 15:58:53 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::c1) by SJ0PR05CA0210.outlook.office365.com
 (2603:10b6:a03:330::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 15:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:58:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 29 Oct
 2025 08:58:35 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:58:30 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Xueming Li <xuemingl@nvidia.com>
Subject: [PATCH 2/3] net/mlx5: fix control flow leakage for external SQ
Date: Wed, 29 Oct 2025 17:57:09 +0200
Message-ID: <20251029155711.169580-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029155711.169580-1-getelson@nvidia.com>
References: <20251029155711.169580-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aeee7f8-8dc1-4260-aa4c-08de17040d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VFK16/8P1zn0pukcEQN18JIWPo4/WDKWvPsaaq5g7gCrWdcwVzfCEMHd0YR+?=
 =?us-ascii?Q?A58RRtwFPv9TSen/kYIAJA9wljLyCFr7h355UjJKNYd8tv3Ny290Q4NX0ptL?=
 =?us-ascii?Q?J/bWSzFzkUh4I6Na8BY0e66Ek6hmY2LCwYAl1UIW2vueWpVRlTT483sj/cde?=
 =?us-ascii?Q?P5T98a1easzRnFN919QgR1HGv6a8YDFJq0/1yStxMki1QgQKGnd+LtZhqpIz?=
 =?us-ascii?Q?rrn9GsLnS4NuTOC1PdEQ1KHouuoA4QavaObivm5oqLrzlxnV16V7IfsHSpjN?=
 =?us-ascii?Q?4XFL/IjFnmKGVtPq7I4rf/+gl9GVQ+DbXLSj1q71HL7hTFgLRX8L1jLobjq9?=
 =?us-ascii?Q?PZ2h3e3adyMcE/pU8Q7j8whEV5IWdFKN35nPcxDt+RWxGUpCFTo8W+hY9qGT?=
 =?us-ascii?Q?Vg2ZW8sFXt8FVpHM9H6Rx6OebluI88ZITh+yGqQNThXDiYh8iJUjfHeyAMs9?=
 =?us-ascii?Q?Yqj4+SXxs9K1tMxMBN7a6Abp3VAzNYgz/3Q+3F4dd1MeD9NC0e20bWiMBOBR?=
 =?us-ascii?Q?ExcN+wBvsp/mAsS5rfDXQWDn7uzYMbl7XcIfNWIYVph0Tw0XcOD2uBIr0G0e?=
 =?us-ascii?Q?wqMVNkb2CptzO7WMNHTWr/1KtRxVFb5XUxuwro0tXi2cNpJsic4B1PbiKNDd?=
 =?us-ascii?Q?WDqVsRwoiqXFYU2Rlio39+Vno5+deDy43DOIieos7PHuHo/NzydubPhukQTK?=
 =?us-ascii?Q?ooIgnKEYSpBmG9Dbo+qohxKE4rTsY9jVdpxwObFETaTyerN6l1QNXW3vqT3l?=
 =?us-ascii?Q?HqfTV5ug8j8TxOXd6TG3FQ/dX0PhtXXAvLqaqe6n4euzihh5T0aVFo//hvJM?=
 =?us-ascii?Q?rJgHBCFkfTITzHRT3by0lVZ4pyzDDTwR7cqOGQo4RXQuOlwvk5JbfH5re0+t?=
 =?us-ascii?Q?DGdCKiCdnGgCa901XNoGaFV44WyNF5xejNxV7hPG3R4nJtU4rwIjNTxiq+XW?=
 =?us-ascii?Q?guomKYyixEghZLuu07lYK3k7NSOMaNYVVfX1sHi7hyaWZeLpUeDncZw833IK?=
 =?us-ascii?Q?xMvv2NICnZ1Arz9A1P2LJ0RWLHXdoBzZD/rFeoulJ/7hcsGPs0lN/V3MvyHl?=
 =?us-ascii?Q?DXb5cBcvVjd8Up4nPduKJC35niZVm4Sgo4yjfpHUm3xiO+oj6SyHnhgFjkPG?=
 =?us-ascii?Q?G0apy+2OyJq2vATCFsaS3sUfN+JoOkWqakcoI3OG0pAQlTlGhZXkYGwFd1ij?=
 =?us-ascii?Q?qHW22KUQ9vBGMzBsSUTdKI35fjVHCzs0s/kU0we9a+DeLoBN0egPjamTH8Eq?=
 =?us-ascii?Q?VOaZZMVc5zJhQA6DB8Y6JLLqWVkfehCrNfCXfMQLQPGIi/iwtERio75CgQZn?=
 =?us-ascii?Q?Ew3Jcd8xrXLfwNAy6qdvv0s/VeAjRgnRZibwfJtR76v+N2kuY/AqdKUP7YaD?=
 =?us-ascii?Q?VzuFfkdncxyhDh7OcPhogQxHFsjjDdpYt4N25qL6YfypXjhx30Xb3behCKS6?=
 =?us-ascii?Q?jHNZr16YDRlfql7PktwzmBB9Z8ieVrYxh5GxUnNcJqiOsGG9CDZ3erqFi7za?=
 =?us-ascii?Q?LY+OKG7mN8PsLI796X/ISd9SYs3f2lkNCyv3DISDy8F9nb544hJ0eGf3hJez?=
 =?us-ascii?Q?qzcz6mHXlI7vnPKQz8c=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:58:50.1019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeee7f8-8dc1-4260-aa4c-08de17040d34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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

From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

There is the private API rte_pmd_mlx5_external_sq_enable(),
that allows application to create the Send Queue (SQ) on its own
and then enable this queue usage as "external SQ".

On this enabling call some implicit flows are created to provide
compliant SQs behavior - copy metadata register, forward queue
originated packet to correct VF, etc.

These implicit flows are marked as "external" ones, and there is
no cleanup on device start and stop for this kind of flows.
Also, PMD has no knowledge if external SQ is still in use by
application and implicit cleanup can not be performed.

As a result, on multiple device start/stop cycles application
re-creates and re-enables many external SQs, causing implicit
flow tables overflow.

To resolve this issue the rte_pmd_mlx5_external_sq_disable()
API is provided, that allows to application to notify PMD
the external SQ is not in usage anymore and related implicit
flows can be dismissed.

Fixes: 26e1eaf2dac4 ("net/mlx5: support device control for E-Switch default rule")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h    |  12 ++--
 drivers/net/mlx5/mlx5_flow_hw.c | 106 +++++++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_trigger.c |   2 +-
 drivers/net/mlx5/mlx5_txq.c     |  55 +++++++++++++++--
 drivers/net/mlx5/rte_pmd_mlx5.h |  18 ++++++
 5 files changed, 181 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 07d2f4185c..adfe84ef54 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3580,12 +3580,16 @@ int mlx5_flow_hw_flush_ctrl_flows(struct rte_eth_dev *dev);
 int mlx5_flow_hw_esw_create_sq_miss_flow(struct rte_eth_dev *dev,
 					 uint32_t sqn, bool external);
 int mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev,
-					  uint32_t sqn);
+					  uint32_t sqn, bool external);
 int mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev);
 int mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
-						  uint32_t sqn,
-						  bool external);
-int mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external);
+						  uint32_t sqn, bool external);
+int mlx5_flow_hw_destroy_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
+						   uint32_t sqn, bool external);
+int mlx5_flow_hw_create_tx_repr_matching_flow(struct rte_eth_dev *dev,
+					      uint32_t sqn, bool external);
+int mlx5_flow_hw_destroy_tx_repr_matching_flow(struct rte_eth_dev *dev,
+					       uint32_t sqn, bool external);
 int mlx5_flow_hw_lacp_rx_flow(struct rte_eth_dev *dev);
 int mlx5_flow_actions_validate(struct rte_eth_dev *dev,
 		const struct rte_flow_actions_template_attr *attr,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index d945c88eb0..eb3dcce59d 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -15897,7 +15897,7 @@ flow_hw_is_matching_sq_miss_flow(struct mlx5_ctrl_flow_entry *cf,
 }
 
 int
-mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev, uint32_t sqn)
+mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
 {
 	uint16_t port_id = dev->data->port_id;
 	uint16_t proxy_port_id = dev->data->port_id;
@@ -15924,7 +15924,8 @@ mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev, uint32_t sqn)
 	    !proxy_priv->hw_ctrl_fdb->hw_esw_sq_miss_root_tbl ||
 	    !proxy_priv->hw_ctrl_fdb->hw_esw_sq_miss_tbl)
 		return 0;
-	cf = LIST_FIRST(&proxy_priv->hw_ctrl_flows);
+	cf = external ? LIST_FIRST(&proxy_priv->hw_ext_ctrl_flows) :
+			LIST_FIRST(&proxy_priv->hw_ctrl_flows);
 	while (cf != NULL) {
 		cf_next = LIST_NEXT(cf, next);
 		if (flow_hw_is_matching_sq_miss_flow(cf, dev, sqn)) {
@@ -16058,8 +16059,58 @@ mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t
 					items, 0, copy_reg_action, 0, &flow_info, external);
 }
 
+static bool
+flow_hw_is_matching_tx_mreg_copy_flow(struct mlx5_ctrl_flow_entry *cf,
+				      struct rte_eth_dev *dev,
+				      uint32_t sqn)
+{
+	if (cf->owner_dev != dev)
+		return false;
+	if (cf->info.type == MLX5_CTRL_FLOW_TYPE_TX_META_COPY && cf->info.tx_repr_sq == sqn)
+		return true;
+	return false;
+}
+
+int
+mlx5_flow_hw_destroy_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
+{
+	uint16_t port_id = dev->data->port_id;
+	uint16_t proxy_port_id = dev->data->port_id;
+	struct rte_eth_dev *proxy_dev;
+	struct mlx5_priv *proxy_priv;
+	struct mlx5_ctrl_flow_entry *cf;
+	struct mlx5_ctrl_flow_entry *cf_next;
+	int ret;
+
+	ret = rte_flow_pick_transfer_proxy(port_id, &proxy_port_id, NULL);
+	if (ret) {
+		DRV_LOG(ERR, "Unable to pick transfer proxy port for port %u. Transfer proxy "
+			     "port must be present for default SQ miss flow rules to exist.",
+			     port_id);
+		return ret;
+	}
+	proxy_dev = &rte_eth_devices[proxy_port_id];
+	proxy_priv = proxy_dev->data->dev_private;
+	if (!proxy_priv->dr_ctx ||
+	    !proxy_priv->hw_ctrl_fdb ||
+	    !proxy_priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl)
+		return 0;
+	cf = external ? LIST_FIRST(&proxy_priv->hw_ext_ctrl_flows) :
+			LIST_FIRST(&proxy_priv->hw_ctrl_flows);
+	while (cf != NULL) {
+		cf_next = LIST_NEXT(cf, next);
+		if (flow_hw_is_matching_tx_mreg_copy_flow(cf, dev, sqn)) {
+			claim_zero(flow_hw_destroy_ctrl_flow(proxy_dev, cf->flow));
+			LIST_REMOVE(cf, next);
+			mlx5_free(cf);
+		}
+		cf = cf_next;
+	}
+	return 0;
+}
+
 int
-mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
+mlx5_flow_hw_create_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_rte_flow_item_sq sq_spec = {
@@ -16116,6 +16167,55 @@ mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool e
 					items, 0, actions, 0, &flow_info, external);
 }
 
+static bool
+flow_hw_is_tx_matching_repr_matching_flow(struct mlx5_ctrl_flow_entry *cf,
+					  struct rte_eth_dev *dev,
+					  uint32_t sqn)
+{
+	if (cf->owner_dev != dev)
+		return false;
+	if (cf->info.type == MLX5_CTRL_FLOW_TYPE_TX_REPR_MATCH && cf->info.tx_repr_sq == sqn)
+		return true;
+	return false;
+}
+
+int
+mlx5_flow_hw_destroy_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
+{
+	uint16_t port_id = dev->data->port_id;
+	uint16_t proxy_port_id = dev->data->port_id;
+	struct rte_eth_dev *proxy_dev;
+	struct mlx5_priv *proxy_priv;
+	struct mlx5_ctrl_flow_entry *cf;
+	struct mlx5_ctrl_flow_entry *cf_next;
+	int ret;
+
+	ret = rte_flow_pick_transfer_proxy(port_id, &proxy_port_id, NULL);
+	if (ret) {
+		DRV_LOG(ERR, "Unable to pick transfer proxy port for port %u. Transfer proxy "
+			     "port must be present for default SQ miss flow rules to exist.",
+			     port_id);
+		return ret;
+	}
+	proxy_dev = &rte_eth_devices[proxy_port_id];
+	proxy_priv = proxy_dev->data->dev_private;
+	if (!proxy_priv->dr_ctx ||
+	    !proxy_priv->hw_tx_repr_tagging_tbl)
+		return 0;
+	cf = external ? LIST_FIRST(&proxy_priv->hw_ext_ctrl_flows) :
+			LIST_FIRST(&proxy_priv->hw_ctrl_flows);
+	while (cf != NULL) {
+		cf_next = LIST_NEXT(cf, next);
+		if (flow_hw_is_tx_matching_repr_matching_flow(cf, dev, sqn)) {
+			claim_zero(flow_hw_destroy_ctrl_flow(proxy_dev, cf->flow));
+			LIST_REMOVE(cf, next);
+			mlx5_free(cf);
+		}
+		cf = cf_next;
+	}
+	return 0;
+}
+
 int
 mlx5_flow_hw_lacp_rx_flow(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index e6acb56d4d..6acf398ccc 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1622,7 +1622,7 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 			}
 		}
 		if (config->dv_esw_en && config->repr_matching) {
-			if (mlx5_flow_hw_tx_repr_matching_flow(dev, queue, false)) {
+			if (mlx5_flow_hw_create_tx_repr_matching_flow(dev, queue, false)) {
 				mlx5_txq_release(dev, i);
 				goto error;
 			}
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 834ca541d5..1d258f979c 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1433,7 +1433,7 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 	priv = dev->data->dev_private;
 	if ((!priv->representor && !priv->master) ||
 	    !priv->sh->config.dv_esw_en) {
-		DRV_LOG(ERR, "Port %u must be represetnor or master port in E-Switch mode.",
+		DRV_LOG(ERR, "Port %u must be representor or master port in E-Switch mode.",
 			port_id);
 		rte_errno = EINVAL;
 		return -rte_errno;
@@ -1454,9 +1454,9 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 		}
 
 		if (priv->sh->config.repr_matching &&
-		    mlx5_flow_hw_tx_repr_matching_flow(dev, sq_num, true)) {
+		    mlx5_flow_hw_create_tx_repr_matching_flow(dev, sq_num, true)) {
 			if (sq_miss_created)
-				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num);
+				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num, true);
 			return -rte_errno;
 		}
 
@@ -1464,7 +1464,7 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 		    priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
 		    mlx5_flow_hw_create_tx_default_mreg_copy_flow(dev, sq_num, true)) {
 			if (sq_miss_created)
-				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num);
+				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num, true);
 			return -rte_errno;
 		}
 		return 0;
@@ -1478,6 +1478,53 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 	return -rte_errno;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_sq_disable, 25.11)
+int
+rte_pmd_mlx5_external_sq_disable(uint16_t port_id, uint32_t sq_num)
+{
+	struct rte_eth_dev *dev;
+	struct mlx5_priv *priv;
+
+	if (rte_eth_dev_is_valid_port(port_id) < 0) {
+		DRV_LOG(ERR, "There is no Ethernet device for port %u.",
+			port_id);
+		rte_errno = ENODEV;
+		return -rte_errno;
+	}
+	dev = &rte_eth_devices[port_id];
+	priv = dev->data->dev_private;
+	if ((!priv->representor && !priv->master) ||
+	    !priv->sh->config.dv_esw_en) {
+		DRV_LOG(ERR, "Port %u must be representor or master port in E-Switch mode.",
+			port_id);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	if (sq_num == 0) {
+		DRV_LOG(ERR, "Invalid SQ number.");
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+#ifdef HAVE_MLX5_HWS_SUPPORT
+	if (priv->sh->config.dv_flow_en == 2) {
+		if (priv->sh->config.fdb_def_rule &&
+		    mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num, true))
+			return -rte_errno;
+		if (priv->sh->config.repr_matching &&
+		    mlx5_flow_hw_destroy_tx_repr_matching_flow(dev, sq_num, true))
+			return -rte_errno;
+		if (!priv->sh->config.repr_matching &&
+		    priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
+		    mlx5_flow_hw_destroy_tx_default_mreg_copy_flow(dev, sq_num, true))
+			return -rte_errno;
+		return 0;
+	}
+#endif
+	/* Not supported for software steering. */
+	rte_errno = ENOTSUP;
+	return -rte_errno;
+}
+
 /**
  * Set the Tx queue dynamic timestamp (mask and offset)
  *
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index 4d4821afae..31f99e7a78 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -484,6 +484,24 @@ typedef void (*rte_pmd_mlx5_driver_event_callback_t)(uint16_t port_id,
 		const void *opaque);
 
 
+/**
+ * Disable traffic for external SQ. Should be invoked by application
+ * before destroying the external SQ.
+ *
+ * @param[in] port_id
+ *   The port identifier of the Ethernet device.
+ * @param[in] sq_num
+ *   SQ HW number.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise and rte_errno is set.
+ *   Possible values for rte_errno:
+ *   - EINVAL - invalid sq_number or port type.
+ *   - ENODEV - there is no Ethernet device for this port id.
+ */
+__rte_experimental
+int rte_pmd_mlx5_external_sq_disable(uint16_t port_id, uint32_t sq_num);
+
 /**
  * Register mlx5 driver event callback.
  *
-- 
2.51.0

