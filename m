Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB43FEA838
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D408B40B98;
	Wed, 25 Mar 2026 10:08:38 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17]) by mails.dpdk.org (Postfix) with ESMTP id 3D75640B98
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:08:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBQUw1yWD9fFatwVbrf4OhkCkPOs2JTjCRfVjtysaLdnek5sc5b6oTkPdoSRRqK+K94tdliwJmJzo5e//RjiR2jG+jqoQfw2zdTjhLCun5mW4g/DFh9/BTWGP7+LMaWahVx6rhMk9Hv4Eqd237eu5CYEqTlpA1alx7egqVUSJHvQSeeNKZunuuhV7b6uv6PrdS07olmd9W+GwRic0xWbPb3QTb7j7Fo6QpCxrzuCkZ1fstNlQ3yn2xswhhb6lkl5U31Yb3F93awadIMnzEnIa+CrdyA7i2TgPpR52dtmDzoyA8EZQD581Yd5T2AOBBF/59M0QJGkslny/rc5gQbDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frMkrURASr6CZeGIzlM/+E9nU/Cp3AmEj5oI4WpZ+Ek=;
 b=yfo+PkvACQVWfEqgQt9z7FgBnhpzGukk4VsxzmeFj56Obf/nwRB/d33kVysg1WC+9zYA91hxNz8ugeFgNMKVaVw7buO0eonTlAfH4o9e+AxmoRKf7G/dIK2H79UX4ZWFoL00fVKpFQDDRwghd/D5zXtMdGAYIGSos3svDBfxvZvOR5Tr+AhqOkpOrYpRfAx6kRGMAq5WDEPX6ppUM7nQtTTDd+u0Ss2BDv8brLrKPYBt+3PWyoFXBAcNW0of2o0CbxZ99dfyj7NQAZL+mQPiqx54DeKpQMfdRjjKXfhmb8+3rpRXSpaWnFFPooUkifzpjjJawsq2bRK109ZsZ4BOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frMkrURASr6CZeGIzlM/+E9nU/Cp3AmEj5oI4WpZ+Ek=;
 b=GTGrdD7fT4xL7zifVzN8NAUeaAuRGMKpR8dMzu5mTfYyA5lThgb6AxdBLiFZ5Vzf7K3MvAdxvp8h8Z+3w1APj4aKVOd5zSbdftrpz3xcRPAJSk8KiPy6PFaSI1EJzatx1ZkEZ8+xEkV0/6JxyZ9piou7pgMkJ8bZpUokCoZyLYjpE7w4S2tNgA7UyL5ROP9LBS2rdlGXaaPhFd/Ejl0RaFPwhjrCAL5FeSi3S3lcX+91imZ4X+X36QqVlV92xRv3P+8N0EXg91RvKcILYIYY2MhNRLpKGJRNvz9+BBnzumEC0A4iKPdxzLmGb0imLIT2683y5g32vnQPPS9ABHV4ZA==
Received: from CH2PR10CA0029.namprd10.prod.outlook.com (2603:10b6:610:4c::39)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:08:33 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::dc) by CH2PR10CA0029.outlook.office365.com
 (2603:10b6:610:4c::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Wed,
 25 Mar 2026 09:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 09:08:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:19 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:16 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 26.07 2/5] net/mlx5: store port VHCA ID
Date: Wed, 25 Mar 2026 10:07:54 +0100
Message-ID: <20260325090758.42403-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325090758.42403-1-dsosnowski@nvidia.com>
References: <20260325090758.42403-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: a262c706-f7e2-4a8e-1b54-08de8a4e16ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: O+4V7Li6lli9vX8ndF9K+Kmww7F3hIYJWRzuiN3thjjzk9CaoklJib8KVtuJBweE5KJrpJ36ld8bkPZ6O1/MS94jxjVbFYxUWC8H+tGhIYHpcjQvtZNFqjbpFyUKUGcpRhvXmKXkmtJX/Veh/yG4OJz3RnJDhqROf82AXwjmBuWLu+TpazRv8NlbOSHZ2CUNiCnPdpo9RT47mXhpMe/7hJ2XdLlIx1i1wAoQY3ikekytVK4MNs7OmVPi+VV1YhmVxxKx8+kMjf55B6YLpHCTpAJQO6z6+8eIlv+kQ62IOKQAetaaaGQY6AJZVcqBQWZYCxZmHR2VquEbXz0iiM9/KBo1p+v6luiO7hqmdsN+lgxgKH/75SgRrFFTrz4L1eGrXINbxF7TDUaLbQcIX3WPAuqLmJQ74gIhVo2PLyKvRZjEEyonPcvGUmTvmSpnt7u/lLcPn3dkiZLMFiNWiT8S153Ag5mlxucWlqrt8UVxaCDr4iqwMzmyaxF9PDToP6DgbIO2ZGZaHUC3lFFiBWtaF0/ifrrplRKAYMykbb1xlKufJgOQE8QGZwHvPdZlpUhX2NZGBRILWxzJJhX6hmZdpvOgCvWvJ0pY8pwbMiZTkq0pEuh0yuxk5DLBU2aYRJWwm57cjATSLmBArYZkXCNUtQLaZHRzsBjXwZOATNlLQo4EjiXrgiJdVhsxllmCjg7PKrDjr+TiLejGS+qj0NcY/YUxf84KqTlulAl/2eAFt8w6e1G5+ue6Hy9QblMaZY8nkKVq5TrBG7GkxUeAcdRfsw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Qe5yLP0HBJhpVPxQKT9NDK7jvsPr6OhtOKzMEDQLGCZVVtgQtu+/bobLWkDqSAFIKtNLrVFy+bn5wOFado4bno6tkLIkcIUsT1+W9OYSTAp1HeemdJ68phxGjkaQ13BLkt9cZdUqDjYLDzxYA9hyap/tt1pNRWRrSaowk9YVOBIZ0tpuE8zhkd0XyOsYJUWCETNUHfsdZq+xc7DHSVpcPjMAJyQqGt7jf0Br++b8Ok5612zA5W5EWu59AQ79VaCcsNuCU+3InBrt28n9A0BjtrzD2tdBqDbFWq6pieSPzmDDT9LXZDihNYKjFraRQwX+Eb8akRkVKhstolm/V4U7KYPj+YzJ4G01vn/SvrJhesXpslot1atCW9THwCCalNQW3ohdS0NHrBPxTKFgeWt000THu94OI0Or21olbSrjHRssiyZq7hGI+tJ5x+PaGug
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:08:32.8310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a262c706-f7e2-4a8e-1b54-08de8a4e16ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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

Save VHCA ID (if available) of each mlx5 port and
of E-Switch Manager, and update port info cache
(mlx5_flow_hw_port_infos array) used for translating
DPDK port ID into HW matching value and mask,
when matching on source vport.

This data will be later used to implement source vport matching
without E-Switch vport metadata enabled.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 3 +++
 drivers/net/mlx5/mlx5.h          | 2 ++
 drivers/net/mlx5/mlx5_flow_hw.c  | 5 ++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index a717191002..3a9b019601 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -377,6 +377,7 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 					hca_attr->scatter_fcs_w_decap_disable;
 	sh->dev_cap.rq_delay_drop_en = hca_attr->rq_delay_drop;
 	mlx5_rt_timestamp_config(sh, hca_attr);
+	sh->dev_cap.esw_info.vhca_id = hca_attr->vhca_id;
 #ifdef HAVE_IBV_DEVICE_ATTR_ESW_MGR_REG_C0
 	if (dv_attr.comp_mask & MLX5DV_CONTEXT_MASK_REG_C0) {
 		sh->dev_cap.esw_info.regc_value = dv_attr.reg_c0.value;
@@ -1524,6 +1525,8 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			goto error;
 		}
 	}
+	if (vport_info.query_flags & MLX5_PORT_QUERY_VPORT_VHCA_ID)
+		priv->vport_vhca_id = vport_info.vport_vhca_id;
 	if (vport_info.query_flags & MLX5_PORT_QUERY_VPORT) {
 		priv->vport_id = vport_info.vport_id;
 	} else if (spawn->pf_bond >= 0 && sh->esw_mode) {
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 4da184eb47..7ae9129e46 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -152,6 +152,7 @@ struct mlx5_flow_cb_ctx {
 struct flow_hw_port_info {
 	uint32_t regc_mask;
 	uint32_t regc_value;
+	uint32_t vhca_id;
 	uint32_t is_wire:1;
 	uint32_t direction:2;
 };
@@ -2003,6 +2004,7 @@ struct mlx5_priv {
 	uint32_t jump_fdb_rx_en:1; /* Jump from FDB Tx to FDB Rx flag per port. */
 	uint16_t domain_id; /* Switch domain identifier. */
 	uint16_t vport_id; /* Associated VF vport index (if any). */
+	uint16_t vport_vhca_id; /* VHCA ID of the associated vport (if any). */
 	uint32_t vport_meta_tag; /* Used for vport index match ove VF LAG. */
 	uint32_t vport_meta_mask; /* Used for vport index field match mask. */
 	uint16_t representor_id; /* UINT16_MAX if not a representor. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..adbd4f33b0 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -12305,6 +12305,7 @@ mlx5_flow_hw_set_port_info(struct rte_eth_dev *dev)
 	info = &mlx5_flow_hw_port_infos[port_id];
 	info->regc_mask = priv->vport_meta_mask;
 	info->regc_value = priv->vport_meta_tag;
+	info->vhca_id = priv->vport_vhca_id;
 	info->is_wire = mlx5_is_port_on_mpesw_device(priv) ? priv->mpesw_uplink : priv->master;
 }
 
@@ -12317,9 +12318,7 @@ mlx5_flow_hw_clear_port_info(struct rte_eth_dev *dev)
 
 	MLX5_ASSERT(port_id < RTE_MAX_ETHPORTS);
 	info = &mlx5_flow_hw_port_infos[port_id];
-	info->regc_mask = 0;
-	info->regc_value = 0;
-	info->is_wire = 0;
+	memset(info, 0, sizeof(*info));
 }
 
 static int
-- 
2.47.3

