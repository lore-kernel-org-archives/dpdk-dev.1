Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D3D2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 08:07:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E3E0402C3;
	Tue, 20 Jan 2026 09:07:18 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6]) by mails.dpdk.org (Postfix) with ESMTP id B1B7740273;
 Tue, 20 Jan 2026 09:07:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VELTxQOuDOUcslwY4vA1xcKzmU1TQdWSh9bJyAT4ZKTAsU1Yk1fKk1aC+Kl3qepgKpIoC2RK3EiXIwtt27yhBGQlK3Mu64KjtEydJCU5mvxwX8WOcbFwZGI4tB84Yo1WCdBSmJbC9I7rPcxAyA2EAE1uL6+LF4KdRk+V1+qmRqBaVKKSTTxa9DHvLNL9Xd5mSpgdotucMswOBpJrcr8ZcCqkxupqXsIiVT3F4nUus5xPRI3e1fTvxkI9IYvv0/dcwUbCKEGtN7UQIJG2FrVZQuDnCGSC+U67DYvQ8wrrYmJJNrXxdzptcFK7WPExsfOFuoBlK8V4pQEmR29QqwLnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVi7RbWWnN5EMxxuaUPMfWi6zMBGhPPbRbcwltr3eBo=;
 b=HoAqzTsE4dgNoBexCHMVza4omxqeuGTSgWQiizJaZKzLjDH/y1GQi+yf5VWBxmmaLBueY+nZFacjTMZvrTngLnURfdegUERIhth5soUR53POaCKA2Q2xYP7/ygaKm/fP/P/RkTw4oXKSmPNNTuu4jqBKzWeMc050NQxbihj9SSXh6sZ9Tn/3ICYtV7O3FTc8zRs3iBWhRLR/+YDkWZtMrJ7tVu320Y6crpKBNPYCX1AcqmooJACE+wrGrE2dVBTytiyQDWz8g53LIDpKe93EH2IVosFtaMS1bYqY7k07YgnSEokUKoieXMVmRTDP5/0KZH8H4e/eVLeEktNUqou4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVi7RbWWnN5EMxxuaUPMfWi6zMBGhPPbRbcwltr3eBo=;
 b=XMbHyspKCRPWumzYXmnF5sk8DQp34DxuVk3ZFRWHdeCcSKJ24fz8LxXhQV6rNoR3UGzDemXMfwMcYhYjoBte04yyR3YItR1HzojfyRtCA/bBnU9uUa8sGT5D+CKEHSGOiAuH+jgXL43CqxrdSLNAI7l/8djkjTF85DtmbfJTOFmqUl9QY9D/4WY4VhtfDEHWSbHNg7xqjjItKC7JjMgSu+yHB+o+evolfn+X8/groeylq8Q+Whjygm+69JCnmm+dfpYUsxq65EDIzLY4ppeOhhsBpE7lL4it4NIeHKdZ5/E3GMmtlTi/qVIAm+XBLrXGptN2u4muDza4d99wrlxSEg==
Received: from CH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:32::23)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:07:13 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::58) by CH0PR07CA0018.outlook.office365.com
 (2603:10b6:610:32::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 08:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:07:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:07:00 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:06:58 -0800
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix flex parser creation length attribute
Date: Tue, 20 Jan 2026 10:06:38 +0200
Message-ID: <20260120080638.1976999-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 1650b197-7559-49f0-ade4-08de57faeb72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P3rHCsRh8n/BDT0CU0+lcwbkadb15JV1sR2Jt7U5ImSQbRS76ezFc28AG1WN?=
 =?us-ascii?Q?sYsjvPKWD0wobS0lWXrKS8ZXLkijrMQm08Izq11JeU5QPUTfsievwRAIZYE/?=
 =?us-ascii?Q?12elZ4V7fNImmJVZqzFqHDrT6Ac9ro13xwIav99mut99rQ/WZW7N4A1DL0f0?=
 =?us-ascii?Q?qEgExt5XCZQcjhAL5zeh0mB1FuleIQGX4uvcAieNIBMSxZ5I+pfUhY+yolB6?=
 =?us-ascii?Q?qzYiobki2tiM1cc89lCw7EOze72DAJTSRP6p9z7yKskekfmFTRsvhBA8krys?=
 =?us-ascii?Q?wv43tG/18LmO6khSsPbgOnHpFhWhtiAglYvs4eqKWFyBtdcTf9R7B/UEzm/z?=
 =?us-ascii?Q?TDG0k1HFIjZs4l+BvSDM8zz/861qAjdKjeuVdXuu+TkdZ6R/U3TY4ivyi5hp?=
 =?us-ascii?Q?JxkTyYLGmdVYCPS2Z2bmojvRUwYGOdlyddrihPWd4Bz08pvWGtgM1yQeUAiK?=
 =?us-ascii?Q?jQpbxgNKQGco7xR4XGot7YyqphmMs1msLaudkQYAkmd7wQ/UQfhwVmW8gkT2?=
 =?us-ascii?Q?NuISku4JQejSZRIAP7SqgMViwz5Nx1KQd2EY2P76liaZ6q0rm89Temwe2vdL?=
 =?us-ascii?Q?ScPsrGvcUqsZI58gUNJKaeqOP8VzkRhPZx25XuSjoziGECVMTPwjd5zHMQBd?=
 =?us-ascii?Q?rBzUMqjLhIJzeFoHMIJS8fRHtXCCBhHIcbkPoibmXefUHtpauz9FpK8cSjCJ?=
 =?us-ascii?Q?LIyeRMWKTaWl0aub4q8LklEU1b5xQz+m8BIT8npewtBgMmLw6uc8JQByZF0f?=
 =?us-ascii?Q?0YeQC9QAOGXwgRbleIQuZlDZYss4EueABOestoVyb9DqGQkm3zFm/22k19qe?=
 =?us-ascii?Q?vFIMxzXbYDZuPyqdph5ChO/RbW5icYrKzAqPSOf6Ak5yGAVknEiB6r/sPlSm?=
 =?us-ascii?Q?V7rhTxKT++I1FERb6u2YdIF6OW+lCk+/1l+On3PGubASpWdbTRpXLEb07yQk?=
 =?us-ascii?Q?aTuMNQF0ePa0JjtVtswAPvUxVST7tMtzW92QYHePthp5o1Zl8xuki7Xa1JWx?=
 =?us-ascii?Q?gYayiK/0oPsA30/LJDu/UcnSBSdP7+fHjMZxssqRzG76OHi0CGkzFQ0v0UwB?=
 =?us-ascii?Q?uZcHNx8ch8mtLE3CW8lsrr6NnHALbiV+ffvJzKeePw6s5l3n67BeGExMZvsN?=
 =?us-ascii?Q?ptxaIJj92vAmGsSfcF/8KdKJUOxM/6b7FLdNuygH1Zdeen1KRBN3224MzCkt?=
 =?us-ascii?Q?rKxZLeezVv4a0PTnS4arUkXqRlVJ/PYVc0JVOac++4p/U+HkRJV0Wzc0uHS2?=
 =?us-ascii?Q?ZuvE2wVHjs7qkUNdiiTYttdSBclSq6Ue+33FJNF2DAzfs2kstcXA1LmbL3y+?=
 =?us-ascii?Q?sGHHEddghmNYKxusz3CETnD8ljQ508VDMYA/AD0NNOUXXrn00qbe16usrHe/?=
 =?us-ascii?Q?fXZ5TpNPWp8kQz8yB+ywQTAjcL+vPpwlnl3+G8FIcSZvrve8IT8x0gZxo49z?=
 =?us-ascii?Q?ZrPggdq0zId3pnITmufDmLEXvCgvuMPKZBaIOInwitLgOQROO4pd3gcZxMH8?=
 =?us-ascii?Q?oTyUie3NcYEQSXNDhV8L6hCPnoPa6k3u0oj/yTPavb4bmFYINPuXi5GW1VMV?=
 =?us-ascii?Q?YUMB3ewdl8QsG0d/oVsHoQD7OVszx9TXCDw7XMaofwcwj22+Hh8VXl9bju7U?=
 =?us-ascii?Q?zxhdSkZQ8gFUjp7/Fe3FzhRjPw6DW9UoKsVFt5lMHmRsqOMwB/c+ieAKA0p/?=
 =?us-ascii?Q?SnOwhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:07:13.5045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1650b197-7559-49f0-ade4-08de57faeb72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

The newer firmware on ConnectX-8 and above always check the
presence of length mode workaround bit, regardless of the
flex parser header length mode. The patch sets the workaround
bit for the all length modes for the parsers created by application.
The internal parsers for eCPRI and IPv6 SRH are updated as well.

Fixes: a2234609bf7e ("net/mlx5: fix flex flow item header length")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5.c           | 3 +++
 drivers/net/mlx5/mlx5_flow_flex.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index bde4d01e48..d82d8e7877 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -983,6 +983,7 @@ int
 mlx5_flex_parser_ecpri_alloc(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_hca_flex_attr *attr = &priv->sh->cdev->config.hca_attr.flex;
 	struct mlx5_ecpri_parser_profile *prf =	&priv->sh->ecpri_parser;
 	struct mlx5_devx_graph_node_attr node = {
 		.modify_field_select = 0,
@@ -996,6 +997,7 @@ mlx5_flex_parser_ecpri_alloc(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 	node.header_length_mode = MLX5_GRAPH_NODE_LEN_FIXED;
+	node.header_length_field_offset_mode = !attr->header_length_field_mode_wa;
 	/* 8 bytes now: 4B common header + 4B message body header. */
 	node.header_length_base_value = 0x8;
 	/* After MAC layer: Ether / VLAN. */
@@ -1075,6 +1077,7 @@ mlx5_alloc_srh_flex_parser(struct rte_eth_dev *dev)
 	if (!priv->sh->srh_flex_parser.flex.devx_fp)
 		return -ENOMEM;
 	node.header_length_mode = MLX5_GRAPH_NODE_LEN_FIELD;
+	node.header_length_field_offset_mode = !attr->header_length_field_mode_wa;
 	/* Srv6 first two DW are not counted in. */
 	node.header_length_base_value = 0x8;
 	/* The unit is uint64_t. */
diff --git a/drivers/net/mlx5/mlx5_flow_flex.c b/drivers/net/mlx5/mlx5_flow_flex.c
index d21e28f7fd..e308d1cd6f 100644
--- a/drivers/net/mlx5/mlx5_flow_flex.c
+++ b/drivers/net/mlx5/mlx5_flow_flex.c
@@ -482,6 +482,7 @@ mlx5_flex_translate_length(struct mlx5_hca_flex_attr *attr,
 		return rte_flow_error_set
 			(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
 			 "not byte aligned header length field");
+	node->header_length_field_offset_mode = !attr->header_length_field_mode_wa;
 	switch (field->field_mode) {
 	case FIELD_MODE_DUMMY:
 		return rte_flow_error_set
@@ -572,7 +573,6 @@ mlx5_flex_translate_length(struct mlx5_hca_flex_attr *attr,
 		node->header_length_field_mask = mask;
 		node->header_length_field_shift = shift;
 		node->header_length_field_offset = offset;
-		node->header_length_field_offset_mode = !attr->header_length_field_mode_wa;
 		break;
 	}
 	case FIELD_MODE_BITMASK:
-- 
2.34.1

