Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37407CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 15:59:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 708BB402E5;
	Wed, 29 Oct 2025 16:59:27 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16]) by mails.dpdk.org (Postfix) with ESMTP id DCDE54025E
 for <dev@dpdk.org>; Wed, 29 Oct 2025 16:59:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6V2HZlq0z+1v47fXemiD+7+U046UbV8JgY6xvxruIDSEYNOfDbh7ZFYtIoOo2LmVQvHvmzKzVWs74YbotS3sPPIJdClZjvYoFjEQGuMDKpOCEgNtqGqOoQqtJ4/b9rchSkY3L1P8OXHTeBOKs/1o4hX8TzZejbLXF+r0zvRy6CYRcvQf4u1+voBa3eww4CQLAbObBDx71T5RTtjFIPXAXHLRZL1TPI2TnNLTR2h5seQguR7s2XIVhNWceQDhAZ4IN0A06nPVsY++f0ekoR4eTxZrldL/5fL5DTfTNvsI8y9IzScz3cveZ+R9XpmiBqcYwgQ5QjMj7U7kBeC5rUQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYDJvuepxmQgXi76G55oYkbnB6TW6w3C3ErqiM8ESTI=;
 b=PxyRdzVIjU7AIvHp60OfRIWLP//TvLWmoQnXfix2cQD0JeKHruK8in0nD+QShzviu+KnSSwUN5PE5E3bVByw+KS/jYm2KbDB5XvhWdBLEPA9fd3ypfgm/+/PyAkWwOYa9r6EkNHPj3+L0NkJB46rX3d/c6PrHKtW3lOCw7DZYoseiGPjxiXkZx99T4WHcMLIwe1ukU6f4UQTVyF2hI14bAJFclfxbafiUakWerGgyAQnEaQ+yKOIt3r2JJ6LyglCa6kX64RBxP0lHSHIGP3cZW+d6mMfUoUAqqbcbw1mWqFMGofTODapb7xcRHOHz5aLMZ6ysD8Ms2bce2ZkuxggWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYDJvuepxmQgXi76G55oYkbnB6TW6w3C3ErqiM8ESTI=;
 b=TuojgJofSfdFzWzouN/eSU0Gx8eUXUs3cYsfv5wfT1S91PjSCcf+bL7c5NnN1wdlWT1BdFNw27/4Fz4NRitcSNGLQzbdhvdBcecFPSQZCX0G1eenjPKhe7JaTKp6HDootzQz8M4t/Q+OnifOCmsoBvUTmdtoEl2p8QNlcym3nXrWWZONKBlO5V4v0Sl/93hO0EPaRmxdfM1furS6oT6cELstR96W2xGOXNyeWwe1OJCPSshbXy5N+Y92gmxWMbrOhfc/UEHwYJuw3aMGHIC7A2RGEozFguMGwgqpuUwFQF4lk5S9hyZ7rJVSCF1gQ49i1IpFssq16WfyWOYxzlpDvA==
Received: from BN1PR12CA0007.namprd12.prod.outlook.com (2603:10b6:408:e1::12)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 15:58:54 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::e9) by BN1PR12CA0007.outlook.office365.com
 (2603:10b6:408:e1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 15:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:58:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 08:58:39 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:58:35 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 3/3] net/mlx5: support flow metadata exchange between E-Switch
 and VM
Date: Wed, 29 Oct 2025 17:57:10 +0200
Message-ID: <20251029155711.169580-3-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: c4eef2e8-7cd5-4f57-c47d-08de17040f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bjxslPMOHImTQapNrR9Zueb732BVHgCTuu6yB9X3R9JgHyNxUF19mAkWxbs6?=
 =?us-ascii?Q?Hb/p1mwiEpopoRDD+LkKWRpNNQTSKbH+zh26urZ4sftHy7RwykRmuhjY03GU?=
 =?us-ascii?Q?htdcG59b3B7lFYqMJHEMywddGi/tfdi7rwDduQ7DP/5rtkhebHfySZMYHEyg?=
 =?us-ascii?Q?azVPMBgpcFoms+5q9ICmCNVNocWFyK2Z7xuXED9iNnYPUpICzh1IDHXhUkwH?=
 =?us-ascii?Q?91PbLmvZq+XiwGjMUj2+FrgPF3uZ48TcNK3geIws3nK08/Ee5lktgP0j2bYw?=
 =?us-ascii?Q?DCWwzR4pukH/3fTDOLBl4OTuozGYCc6UlRcKDwqfAoi2vHqmSFTAp8rCtCc4?=
 =?us-ascii?Q?3YwmhnyWCYiEzgoGoRUD8XmF9VYbMPc66FqutIm/A2UhI7Z1yDqSPPTOThN+?=
 =?us-ascii?Q?ipkVuW4CBSSPYmqQbHBw9PjDHq1fpBdh/s6L7WWGL6uj5j7ZVU7SdDjE4XKV?=
 =?us-ascii?Q?c+wvEI66lvbwuhp97p99kD7YbuCGMLrPJ6Txe7Y5ORR9tUeAx2y0L5ZKmEZP?=
 =?us-ascii?Q?EknAVk1/EEsbDxLuIxSqSraDAOjxdGuDbdTDRb/dMwNU6WCfpWaY/VsykTyH?=
 =?us-ascii?Q?fdYVU6/sc1XdWMwUhkTXsBuDtL1emtQ9MDJgo0MDNWUwBZF+75kncepmUp9/?=
 =?us-ascii?Q?GCSDmTerKmJWboGdJDxzYjhTs4zEziOYnOKIuSHm6K88fwul88AW4T2s9KW6?=
 =?us-ascii?Q?UrF4GKrkuLOEmWMFk0Pm67w9M9O8JCbuF2++tXkHj+nSE6p7CehkN3EXy2Nm?=
 =?us-ascii?Q?tiej3G2uB5VH8VrB6c7Bz3TURCP/9s9uXj87AQZx4s9symVhSeZ8UZwuQzwB?=
 =?us-ascii?Q?RDDUG+AdrUota58jxEFcH46aEz4ExyNxUE03mBg4dOneIk0Vz6Wtyd5OHfC/?=
 =?us-ascii?Q?bvxnomqCOypMNyOx8OC0Y7YdkyDmEDhzXUl8DlZObxP1mr5Sdsaey4n/kahR?=
 =?us-ascii?Q?KWeoVW9PhtbSd0mqiCgleVtZTwUmMfC073DgJRZyB79aX9GfQSACI3sZJBy6?=
 =?us-ascii?Q?3/YZ6NI4hYiBnrqyYJaM9PRsBhQWuuMrQ7mkL7Zrs0iFpta9Kf/FHzrT4jla?=
 =?us-ascii?Q?3FgpqqNaM+5TXrjgQOsgFrRS8GMGpECzL/lUdq7MAM5f/GNZE3nOjBS2YfOi?=
 =?us-ascii?Q?xIa/bPuT20O4VghKxUeCCsPS+gIhTyLG6IS6bvOF3rasi9PNfrEN1uEZm4+8?=
 =?us-ascii?Q?oUTYEjeCVjMn0QpJkhkA7D/yV54EoB90XhBZYVoCVD1CriFuPLuILsglC/jF?=
 =?us-ascii?Q?TXGlBCkybu4ERZAGnZuqq3RP7pzD2O6AOWURnaTV70j9uITkEW4+J/amrn8r?=
 =?us-ascii?Q?2ahx0kApijvdwKFKLTWpFBqcDTMITyZq92owBINeh3vhhPAyRPsXdaufJhHR?=
 =?us-ascii?Q?zVFuR/SAGESijuuOV4L8W0KwOB0W6zQAkpwqv04+YQIUvT4PxnmW6eyeVeFD?=
 =?us-ascii?Q?rlyNSq/kN2VCE941vUJLeL7TrE+58GhgLSmPqMl9pY4++tzlo7Vflq8IXK3S?=
 =?us-ascii?Q?8ClsXc3e5k/dTdMZjckC+rXq3WpJpxJuC1zbpx9gbZm5NvMnO1jzHxj2aLaQ?=
 =?us-ascii?Q?xUE8KflajwrXOPSu5nE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:58:54.0030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4eef2e8-7cd5-4f57-c47d-08de17040f93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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

MLX5 port firmware has wiped out flow metadata if a packet was moved
between E-switch and VM applications.

Starting from version 47.0274, firmware can be configured to preserve
flow metadata after a packet was transferred between E-Switch and VM
applications.

The patch allows VM application to work with ingress and egress flow
metadata:

* Support FDB-to-VPORT and VPORT-to-FDB bits in firmware VPORT table.
* If VM ingress flow has RSS or QUEUE actions, copy medata from
  C1 register to B register.
* For VM egress flows, copy medata from register A to register C1.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst             |  10 ++
 drivers/common/mlx5/mlx5_devx_cmds.c |  31 ++++++
 drivers/common/mlx5/mlx5_devx_cmds.h |   5 +
 drivers/common/mlx5/mlx5_prm.h       |  55 +++++++++-
 drivers/net/mlx5/mlx5.c              |   4 +-
 drivers/net/mlx5/mlx5.h              |   3 +-
 drivers/net/mlx5/mlx5_flow.c         |  74 ++++++++++----
 drivers/net/mlx5/mlx5_flow.h         |  18 +++-
 drivers/net/mlx5/mlx5_flow_hw.c      | 144 +++++++++++++++++++++++++--
 drivers/net/mlx5/mlx5_trigger.c      |  13 ++-
 drivers/net/mlx5/mlx5_txq.c          |   2 +-
 11 files changed, 322 insertions(+), 37 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 20056f61d6..fde98ae993 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -2482,6 +2482,16 @@ and it should be allowed to specify zero values as parameters
 for the META and MARK flow items and actions.
 In the same time, zero mask has no meaning and should be rejected on validation stage.
 
+Starting from firmware version 47.0274, if :ref:`switchdev mode <mlx5_switchdev>` was enabled
+flow metadata can be shared between flows in FDB and VF domains:
+
+* If metadata was attached to FDB flow and that flow transferred incoming packet to a VF,
+  representor, ingress flow bound to the VF can match the metadata.
+
+* If metadata was attached to VF egress flow, FDB flow can match the metadata.
+
+The metadata sharing functionality is controlled with firmware configuration.
+
 Requirements
 ^^^^^^^^^^^^
 
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 5622847a4a..385759230a 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -487,6 +487,34 @@ mlx5_devx_cmd_destroy(struct mlx5_devx_obj *obj)
 	return ret;
 }
 
+static int
+mlx5_devx_cmd_query_esw_vport_context(void *ctx,
+				      struct mlx5_hca_attr *attr)
+{
+	uint32_t in[MLX5_ST_SZ_DW(query_esw_vport_context_in)] = {0};
+	uint32_t out[MLX5_ST_SZ_DW(query_esw_vport_context_out)] = {0};
+	void *vctx;
+	int rc;
+
+	MLX5_SET(query_esw_vport_context_in, in, opcode, MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT);
+	rc = mlx5_glue->devx_general_cmd(ctx, in, sizeof(in), out, sizeof(out));
+	if (rc || MLX5_FW_STATUS(out)) {
+		DEVX_DRV_LOG(ERR, out, "query ESW vport context", NULL, 0);
+		return MLX5_DEVX_ERR_RC(rc);
+	}
+	vctx = MLX5_ADDR_OF(query_esw_vport_context_out, out, esw_vport_context);
+	attr->fdb_to_vport_reg_c = MLX5_GET(esw_vport_context, vctx, fdb_to_vport_reg_c);
+	if (attr->fdb_to_vport_reg_c != 0) {
+		attr->vport_to_fdb_metadata =
+			MLX5_GET(esw_vport_context, vctx, vport_to_fdb_metadata);
+		attr->fdb_to_vport_metadata =
+			MLX5_GET(esw_vport_context, vctx, fdb_to_vport_metadata);
+		attr->fdb_to_vport_reg_c_id =
+			MLX5_GET(esw_vport_context, vctx, fdb_to_vport_reg_c_id);
+	}
+	return 0;
+}
+
 /**
  * Query NIC vport context.
  * Fills minimal inline attribute.
@@ -531,6 +559,8 @@ mlx5_devx_cmd_query_nic_vport_context(void *ctx,
 						   min_wqe_inline_mode);
 	attr->system_image_guid = MLX5_GET64(nic_vport_context, vctx,
 					     system_image_guid);
+	attr->vport_to_fdb_metadata = MLX5_GET(nic_vport_context, vctx, vport_to_fdb_metadata);
+	attr->fdb_to_vport_metadata = MLX5_GET(nic_vport_context, vctx, fdb_to_vport_metadata);
 	return 0;
 }
 
@@ -1407,6 +1437,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 				 esw_manager_vport_number_valid);
 		attr->esw_mgr_vport_id =
 			MLX5_GET(esw_cap, hcattr, esw_manager_vport_number);
+		mlx5_devx_cmd_query_esw_vport_context(ctx, attr);
 	}
 	if (attr->eswitch_manager) {
 		uint32_t esw_reg, reg_c_8_15;
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 01dbb40040..efae6826dc 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -262,6 +262,8 @@ struct mlx5_hca_attr {
 	uint32_t mini_cqe_resp_l3_l4_tag:1;
 	uint32_t enhanced_cqe_compression:1;
 	uint32_t pkt_integrity_match:1; /* 1 if HW supports integrity item */
+	uint32_t fdb_to_vport_metadata:1; /* 1 if enabled */
+	uint32_t vport_to_fdb_metadata:1; /* 1 if enabled */
 	struct mlx5_hca_qos_attr qos;
 	struct mlx5_hca_vdpa_attr vdpa;
 	struct mlx5_hca_flow_attr flow;
@@ -328,6 +330,9 @@ struct mlx5_hca_attr {
 	uint32_t fdb_unified_en:1;
 	uint32_t jump_fdb_rx_en:1;
 	uint32_t fdb_rx_set_flow_tag_stc:1;
+	uint32_t return_reg_id:16;
+	uint32_t fdb_to_vport_reg_c:1;
+	uint8_t fdb_to_vport_reg_c_id;
 	uint8_t max_header_modify_pattern_length;
 	uint64_t system_image_guid;
 	uint32_t log_max_conn_track_offload:5;
diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 2887f7354d..5db8d67cfc 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1260,6 +1260,7 @@ enum {
 	MLX5_CMD_OP_INIT2INIT_QP = 0x50E,
 	MLX5_CMD_OP_SUSPEND_QP = 0x50F,
 	MLX5_CMD_OP_RESUME_QP = 0x510,
+	MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT = 0x752,
 	MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT = 0x754,
 	MLX5_CMD_OP_ALLOC_Q_COUNTER = 0x771,
 	MLX5_CMD_OP_QUERY_Q_COUNTER = 0x773,
@@ -2546,8 +2547,14 @@ struct mlx5_ifc_mac_address_layout_bits {
 	u8 mac_addr_31_0[0x20];
 };
 
+/*
+ *  NIC_Vport Context table
+ */
 struct mlx5_ifc_nic_vport_context_bits {
-	u8 reserved_at_0[0x5];
+	u8 multi_prio_sq[0x1]; /* 00h: bit 31 */
+	u8 vport_to_fdb_metadata[0x1]; /* 00h: bit 30 */
+	u8 fdb_to_vport_metadata[0x1]; /* 00h: bit 29 */
+	u8 reserved_at_0_28[0x2];
 	u8 min_wqe_inline_mode[0x3];
 	u8 reserved_at_8[0x15];
 	u8 disable_mc_local_lb[0x1];
@@ -2603,6 +2610,52 @@ struct mlx5_ifc_query_nic_vport_context_in_bits {
 	u8 reserved_at_68[0x18];
 };
 
+/*
+ * Esw_Vport Context table
+ */
+struct mlx5_ifc_esw_vport_context_bits {
+	u8 fdb_to_vport_reg_c[0x1]; /* 00h bits 31 */
+	u8 vport_to_fdb_metadata[0x1]; /* 00h bits 30 */
+	u8 fdb_to_vport_metadata[0x1]; /* 00h bits 29 */
+	u8 vport_svlan_strip[0x1]; /* 00h bits 28 */
+	u8 vport_cvlan_strip[0x1]; /* 00h bits 27 */
+	u8 vport_svlan_insert[0x1]; /* 00h bits 26 */
+	u8 vport_cvlan_insert[0x2]; /* 00h bits 25:24 */
+	u8 fdb_to_vport_reg_c_id[0x08]; /* 00h bits 23:16*/
+	u8 reserved_at_00_16[0x10]; /* 00h bits 15:00*/
+	u8 reserved[0xfc * CHAR_BIT];
+};
+
+enum mlx5_esw_vport_metadata_reg_cmap {
+	MLX5_ESW_VPORT_METADATA_REG_C_0 = 0,
+	MLX5_ESW_VPORT_METADATA_REG_C_1 = 1,
+	MLX5_ESW_VPORT_METADATA_REG_C_2 = 2,
+	MLX5_ESW_VPORT_METADATA_REG_C_3 = 3,
+	MLX5_ESW_VPORT_METADATA_REG_C_4 = 4,
+	MLX5_ESW_VPORT_METADATA_REG_C_5 = 5,
+	MLX5_ESW_VPORT_METADATA_REG_C_6 = 6,
+	MLX5_ESW_VPORT_METADATA_REG_C_7 = 7,
+};
+
+struct mlx5_ifc_query_esw_vport_context_out_bits {
+	u8 status[0x8];
+	u8 reserved_at_8[0x18];
+	u8 syndrome[0x20];
+	u8 reserved_at_40[0x40];
+	struct mlx5_ifc_esw_vport_context_bits esw_vport_context;
+};
+
+struct mlx5_ifc_query_esw_vport_context_in_bits {
+	u8 opcode[0x10];
+	u8 uid[0x10];
+	u8 reserved_at_04_31[0x10];
+	u8 op_mod[0x10];
+	u8 other_vport[0x1];
+	u8 reserved_at_08_30[0xf];
+	u8 vport_number[0x10];
+	u8 reserved_at_0c_31[0x20];
+};
+
 struct mlx5_ifc_tisc_bits {
 	u8 strict_lag_tx_port_affinity[0x1];
 	u8 reserved_at_1[0x3];
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b018a4f0e2..6686dd7587 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1651,7 +1651,9 @@ mlx5_init_hws_flow_tags_registers(struct mlx5_dev_ctx_shared *sh)
 	unset |= 1 << mlx5_regc_index(REG_C_6);
 	if (sh->config.dv_esw_en)
 		unset |= 1 << mlx5_regc_index(REG_C_0);
-	if (meta_mode == MLX5_XMETA_MODE_META32_HWS)
+	if (meta_mode == MLX5_XMETA_MODE_META32_HWS ||
+	    mlx5_vport_rx_metadata_passing_enabled(sh) ||
+	    mlx5_vport_tx_metadata_passing_enabled(sh))
 		unset |= 1 << mlx5_regc_index(REG_C_1);
 	masks &= ~unset;
 	for (i = 0, j = 0; i < MLX5_FLOW_HW_TAGS_MAX; i++) {
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 07418b0922..e955c19217 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2032,7 +2032,8 @@ struct mlx5_priv {
 	rte_spinlock_t hw_ctrl_lock;
 	LIST_HEAD(hw_ctrl_flow, mlx5_ctrl_flow_entry) hw_ctrl_flows;
 	LIST_HEAD(hw_ext_ctrl_flow, mlx5_ctrl_flow_entry) hw_ext_ctrl_flows;
-	struct mlx5_flow_hw_ctrl_fdb *hw_ctrl_fdb;
+	struct mlx5_flow_hw_ctrl_fdb *hw_ctrl_fdb; /* FDB control flow context */
+	struct mlx5_flow_hw_ctrl_nic *hw_ctrl_nic; /* NIC control flow context */
 	struct rte_flow_pattern_template *hw_tx_repr_tagging_pt;
 	struct rte_flow_actions_template *hw_tx_repr_tagging_at;
 	struct rte_flow_template_table *hw_tx_repr_tagging_tbl;
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 1de398982a..2dcdddbe74 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1238,33 +1238,43 @@ mlx5_flow_get_reg_id(struct rte_eth_dev *dev,
 	case MLX5_HAIRPIN_TX:
 		return REG_A;
 	case MLX5_METADATA_RX:
-		switch (config->dv_xmeta_en) {
-		case MLX5_XMETA_MODE_LEGACY:
-			return REG_B;
-		case MLX5_XMETA_MODE_META16:
-			return REG_C_0;
-		case MLX5_XMETA_MODE_META32:
-			return REG_C_1;
-		case MLX5_XMETA_MODE_META32_HWS:
+		if (mlx5_vport_rx_metadata_passing_enabled(priv->sh)) {
 			return REG_C_1;
+		} else {
+			switch (config->dv_xmeta_en) {
+			case MLX5_XMETA_MODE_LEGACY:
+				return REG_B;
+			case MLX5_XMETA_MODE_META16:
+				return REG_C_0;
+			case MLX5_XMETA_MODE_META32:
+				return REG_C_1;
+			case MLX5_XMETA_MODE_META32_HWS:
+				return REG_C_1;
+			}
 		}
 		break;
 	case MLX5_METADATA_TX:
-		if (config->dv_flow_en == 2 && config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS) {
+		if ((config->dv_flow_en == 2 &&
+		    config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS) ||
+		    mlx5_vport_tx_metadata_passing_enabled(priv->sh)) {
 			return REG_C_1;
 		} else {
 			return REG_A;
 		}
 	case MLX5_METADATA_FDB:
-		switch (config->dv_xmeta_en) {
-		case MLX5_XMETA_MODE_LEGACY:
-			return REG_NON;
-		case MLX5_XMETA_MODE_META16:
-			return REG_C_0;
-		case MLX5_XMETA_MODE_META32:
-			return REG_C_1;
-		case MLX5_XMETA_MODE_META32_HWS:
+		if (mlx5_esw_metadata_passing_enabled(priv->sh)) {
 			return REG_C_1;
+		} else {
+			switch (config->dv_xmeta_en) {
+			case MLX5_XMETA_MODE_LEGACY:
+				return REG_NON;
+			case MLX5_XMETA_MODE_META16:
+				return REG_C_0;
+			case MLX5_XMETA_MODE_META32:
+				return REG_C_1;
+			case MLX5_XMETA_MODE_META32_HWS:
+				return REG_C_1;
+			}
 		}
 		break;
 	case MLX5_FLOW_MARK:
@@ -12526,3 +12536,33 @@ rte_pmd_mlx5_enable_steering(void)
 
 	return 0;
 }
+
+bool
+mlx5_vport_rx_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh)
+{
+	const struct mlx5_sh_config *dev_config = &sh->config;
+	const struct mlx5_hca_attr  *hca_attr = &sh->cdev->config.hca_attr;
+
+	return !dev_config->dv_esw_en && hca_attr->fdb_to_vport_metadata;
+}
+
+bool
+mlx5_vport_tx_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh)
+{
+	const struct mlx5_sh_config *dev_config = &sh->config;
+	const struct mlx5_hca_attr  *hca_attr = &sh->cdev->config.hca_attr;
+
+	return !dev_config->dv_esw_en && hca_attr->vport_to_fdb_metadata;
+}
+
+bool
+mlx5_esw_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh)
+{
+	const struct mlx5_sh_config *dev_config = &sh->config;
+	const struct mlx5_hca_attr  *hca_attr = &sh->cdev->config.hca_attr;
+	bool fdb_to_vport_metadata_on = (hca_attr->fdb_to_vport_reg_c_id &
+					 RTE_BIT32(MLX5_ESW_VPORT_METADATA_REG_C_1)) != 0;
+
+	return dev_config->dv_esw_en && hca_attr->fdb_to_vport_reg_c && fdb_to_vport_metadata_on &&
+		hca_attr->vport_to_fdb_metadata && hca_attr->fdb_to_vport_metadata;
+}
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index adfe84ef54..2a7d22dfad 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1755,6 +1755,10 @@ struct rte_flow_template_table {
 	struct mlx5_dr_rule_action_container rule_acts[];
 };
 
+bool mlx5_vport_rx_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh);
+bool mlx5_vport_tx_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh);
+bool mlx5_esw_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh);
+
 static __rte_always_inline struct mlx5dr_matcher *
 mlx5_table_matcher(const struct rte_flow_template_table *table)
 {
@@ -1799,6 +1803,11 @@ flow_hw_get_reg_id_by_domain(struct rte_eth_dev *dev,
 		    sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS) {
 			return REG_C_1;
 		}
+		if ((mlx5_vport_rx_metadata_passing_enabled(sh) &&
+		     domain_type == MLX5DR_TABLE_TYPE_NIC_RX) ||
+		    (mlx5_vport_tx_metadata_passing_enabled(sh) &&
+		     domain_type == MLX5DR_TABLE_TYPE_NIC_TX))
+			return REG_C_1;
 		/*
 		 * On root table - PMD allows only egress META matching, thus
 		 * REG_A matching is sufficient.
@@ -3015,6 +3024,12 @@ struct mlx5_flow_hw_ctrl_fdb {
 	struct rte_flow_template_table *hw_lacp_rx_tbl;
 };
 
+struct mlx5_flow_hw_ctrl_nic {
+	struct rte_flow_pattern_template *tx_meta_items_tmpl;
+	struct rte_flow_actions_template *tx_meta_actions_tmpl;
+	struct rte_flow_template_table *hw_tx_meta_cpy_tbl;
+};
+
 #define MLX5_CTRL_PROMISCUOUS    (RTE_BIT32(0))
 #define MLX5_CTRL_ALL_MULTICAST  (RTE_BIT32(1))
 #define MLX5_CTRL_BROADCAST      (RTE_BIT32(2))
@@ -3582,8 +3597,9 @@ int mlx5_flow_hw_esw_create_sq_miss_flow(struct rte_eth_dev *dev,
 int mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev,
 					  uint32_t sqn, bool external);
 int mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev);
-int mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
+int mlx5_flow_hw_create_fdb_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
 						  uint32_t sqn, bool external);
+int mlx5_flow_hw_create_nic_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t sqn);
 int mlx5_flow_hw_destroy_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
 						   uint32_t sqn, bool external);
 int mlx5_flow_hw_create_tx_repr_matching_flow(struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index eb3dcce59d..ff68483a40 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5324,6 +5324,15 @@ __translate_group(struct rte_eth_dev *dev,
 						  NULL,
 						  "group index not supported");
 		*table_group = group + 1;
+	} else if (mlx5_vport_tx_metadata_passing_enabled(priv->sh) && flow_attr->egress) {
+		/*
+		 * If VM cross GVMI metadata Tx was enabled, PMD creates a default
+		 * flow rule in the group 0 to copy metadata value.
+		 */
+		if (group > MLX5_HW_MAX_EGRESS_GROUP)
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
+						  NULL, "group index not supported");
+		*table_group = group + 1;
 	} else {
 		*table_group = group;
 	}
@@ -8006,14 +8015,17 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 		mf_masks[expand_mf_num] = quota_color_inc_mask;
 		expand_mf_num++;
 	}
-	if (priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
-	    priv->sh->config.dv_esw_en &&
-	    !attr->transfer &&
+	if (attr->ingress &&
 	    (action_flags & (MLX5_FLOW_ACTION_QUEUE | MLX5_FLOW_ACTION_RSS))) {
-		/* Insert META copy */
-		mf_actions[expand_mf_num] = rx_meta_copy_action;
-		mf_masks[expand_mf_num] = rx_meta_copy_mask;
-		expand_mf_num++;
+		if ((priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
+		    priv->sh->config.dv_esw_en) ||
+		    mlx5_vport_rx_metadata_passing_enabled(priv->sh)) {
+			/* Insert META copy */
+			mf_actions[expand_mf_num] = rx_meta_copy_action;
+			mf_masks[expand_mf_num] = rx_meta_copy_mask;
+			expand_mf_num++;
+			MLX5_ASSERT(expand_mf_num <= MLX5_HW_MAX_ACTS);
+		}
 	}
 	if (expand_mf_num) {
 		if (act_num + expand_mf_num > MLX5_HW_MAX_ACTS) {
@@ -10809,7 +10821,7 @@ flow_hw_create_lacp_rx_table(struct rte_eth_dev *dev,
  *   0 on success, negative values otherwise
  */
 static int
-flow_hw_create_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *error)
+flow_hw_create_fdb_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_flow_hw_ctrl_fdb *hw_ctrl_fdb;
@@ -10958,6 +10970,59 @@ flow_hw_create_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *error
 	return -EINVAL;
 }
 
+static void
+flow_hw_cleanup_ctrl_nic_tables(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_flow_hw_ctrl_nic *ctrl = priv->hw_ctrl_nic;
+
+	if (ctrl == NULL)
+		return;
+	if (ctrl->hw_tx_meta_cpy_tbl)
+		claim_zero(flow_hw_table_destroy(dev, ctrl->hw_tx_meta_cpy_tbl, NULL));
+	if (ctrl->tx_meta_items_tmpl != NULL)
+		claim_zero(flow_hw_pattern_template_destroy(dev, ctrl->tx_meta_items_tmpl, NULL));
+	if (ctrl->tx_meta_actions_tmpl != NULL)
+		claim_zero(flow_hw_actions_template_destroy(dev, ctrl->tx_meta_actions_tmpl, NULL));
+	mlx5_free(ctrl);
+	priv->hw_ctrl_nic = NULL;
+}
+
+static int
+flow_hw_create_nic_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *error)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	struct mlx5_flow_hw_ctrl_nic *ctrl = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*ctrl),
+							 0, SOCKET_ID_ANY);
+	if (!ctrl)
+		return rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "failed to allocate port control flow table");
+	priv->hw_ctrl_nic = ctrl;
+	ctrl->tx_meta_items_tmpl = flow_hw_create_tx_repr_sq_pattern_tmpl(dev, error);
+	if (ctrl->tx_meta_items_tmpl == NULL)
+		goto error;
+	ctrl->tx_meta_actions_tmpl =
+		flow_hw_create_tx_default_mreg_copy_actions_template(dev, error);
+	if (ctrl->tx_meta_actions_tmpl == NULL) {
+		rte_flow_error_set(error, rte_errno, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				  "failed to create default Tx metadata copy actions template");
+		goto error;
+	}
+	ctrl->hw_tx_meta_cpy_tbl =
+		flow_hw_create_tx_default_mreg_copy_table(dev, ctrl->tx_meta_items_tmpl,
+							  ctrl->tx_meta_actions_tmpl, error);
+	if (ctrl->hw_tx_meta_cpy_tbl == NULL) {
+		rte_flow_error_set(error, rte_errno, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				  "failed to create default Tx metadata copy table");
+	}
+	return 0;
+
+error:
+	flow_hw_cleanup_ctrl_nic_tables(dev);
+	return -rte_errno;
+}
+
 static void
 flow_hw_ct_mng_destroy(struct rte_eth_dev *dev,
 		       struct mlx5_aso_ct_pools_mng *ct_mng)
@@ -11697,6 +11762,7 @@ __flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 	flow_hw_rxq_flag_set(dev, false);
 	flow_hw_flush_all_ctrl_flows(dev);
 	flow_hw_cleanup_ctrl_fdb_tables(dev);
+	flow_hw_cleanup_ctrl_nic_tables(dev);
 	flow_hw_cleanup_tx_repr_tagging(dev);
 	flow_hw_cleanup_ctrl_rx_tables(dev);
 	flow_hw_action_template_drop_release(dev);
@@ -12141,12 +12207,19 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 					   NULL, "Failed to create vport actions.");
 			goto err;
 		}
-		ret = flow_hw_create_ctrl_tables(dev, error);
+		ret = flow_hw_create_fdb_ctrl_tables(dev, error);
 		if (ret) {
 			rte_errno = -ret;
 			goto err;
 		}
 	}
+	if (mlx5_vport_tx_metadata_passing_enabled(priv->sh)) {
+		ret = flow_hw_create_nic_ctrl_tables(dev, error);
+		if (ret != 0) {
+			rte_errno = -ret;
+			goto err;
+		}
+	}
 	if (!priv->shared_host)
 		flow_hw_create_send_to_kernel_actions(priv, is_proxy);
 	if (port_attr->nb_conn_tracks || (host_priv && host_priv->hws_ctpool)) {
@@ -16005,7 +16078,8 @@ mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev)
 }
 
 int
-mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
+mlx5_flow_hw_create_fdb_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
+						  uint32_t sqn, bool external)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_rte_flow_item_sq sq_spec = {
@@ -16059,6 +16133,56 @@ mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t
 					items, 0, copy_reg_action, 0, &flow_info, external);
 }
 
+int
+mlx5_flow_hw_create_nic_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t sqn)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_rte_flow_item_sq sq_spec = {
+		.queue = sqn,
+	};
+	struct rte_flow_item items[] = {
+		{
+			.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_SQ,
+			.spec = &sq_spec,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	};
+	struct rte_flow_action_modify_field mreg_action = {
+		.operation = RTE_FLOW_MODIFY_SET,
+		.dst = {
+			.field = (enum rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
+			.tag_index = REG_C_1,
+		},
+		.src = {
+			.field = (enum rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
+			.tag_index = REG_A,
+		},
+		.width = 32,
+	};
+	struct rte_flow_action copy_reg_action[] = {
+		[0] = {
+			.type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
+			.conf = &mreg_action,
+		},
+		[1] = {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+		},
+		[2] = {
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+	struct mlx5_ctrl_flow_info flow_info = {
+		.type = MLX5_CTRL_FLOW_TYPE_TX_META_COPY,
+		.tx_repr_sq = sqn,
+	};
+
+	return flow_hw_create_ctrl_flow(dev, dev,
+					priv->hw_ctrl_nic->hw_tx_meta_cpy_tbl,
+					items, 0, copy_reg_action, 0, &flow_info, false);
+}
+
 static bool
 flow_hw_is_matching_tx_mreg_copy_flow(struct mlx5_ctrl_flow_entry *cf,
 				      struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 6acf398ccc..996c1eb6ac 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1604,7 +1604,7 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 	struct mlx5_sh_config *config = &priv->sh->config;
 	uint64_t flags = 0;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	for (i = 0; i < priv->txqs_n; ++i) {
 		struct mlx5_txq_ctrl *txq = mlx5_txq_get(dev, i);
@@ -1635,10 +1635,13 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 		if (config->dv_esw_en && !config->repr_matching &&
 		    config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
 		    (priv->master || priv->representor)) {
-			if (mlx5_flow_hw_create_tx_default_mreg_copy_flow(dev, queue, false)) {
-				mlx5_txq_release(dev, i);
-				goto error;
-			}
+			ret = mlx5_flow_hw_create_fdb_tx_default_mreg_copy_flow(dev, queue, false);
+		} else if (mlx5_vport_tx_metadata_passing_enabled(priv->sh)) {
+			ret = mlx5_flow_hw_create_nic_tx_default_mreg_copy_flow(dev, queue);
+		}
+		if (ret != 0) {
+			mlx5_txq_release(dev, i);
+			goto error;
 		}
 		mlx5_txq_release(dev, i);
 	}
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 1d258f979c..e20165d74e 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1462,7 +1462,7 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 
 		if (!priv->sh->config.repr_matching &&
 		    priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
-		    mlx5_flow_hw_create_tx_default_mreg_copy_flow(dev, sq_num, true)) {
+		    mlx5_flow_hw_create_fdb_tx_default_mreg_copy_flow(dev, sq_num, true)) {
 			if (sq_miss_created)
 				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num, true);
 			return -rte_errno;
-- 
2.51.0

