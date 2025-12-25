Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C073E7AD48
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Dec 2025 11:02:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7E9040267;
	Thu, 25 Dec 2025 12:02:41 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by mails.dpdk.org (Postfix) with ESMTP id 1FA7B40262;
 Thu, 25 Dec 2025 12:02:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kU4F+Q77hVE0ys/v4A+GQQhFf2b7PdkFmg5r7IRyBBC3A5Xi00HbUM36IyuZKI4Rvdb/Cq+KM7YN8qBMAtP6Al6cwpDyP0gtlLm09w8wAltNU/Nlc7XlKDvUSqAL7b+bcWA4wqPENERSX8wK5WRvdMzRb7MJAY6ze/6BZxDOHEPSuOQYomd9X/nbYtOa8ODaSn1Xz7QEov9PgRyEhcp7ENMxndNqBOSaLQviTLSWatk3zkLiVrmkkal1ZcsFz73kfDP/dyfHCUQAGurs0RYHeOOjJvWXvvOIcRulZ0zFXau5N1IHhDCAOSMGMGP6hq6Se+bcB45vkgX3hSwe/2MxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRrcT0H01CECcXCX2hweJ4NwRatCNRBK1ypLqGytx/A=;
 b=BgU4cU3coNyMZaWQPeAxpVKiPYep4El6sxalimDGe4Y2LfcjKyk27rjIuUjh7f/VtgyNEmiuvNR35nhg7mhYsms+DiMYSf4o5UrHUpDa3tCW9csP6EykUknR0jiLd63o/BIcK7nGLksElnjmd1QPWvnHPMRPnr5BCaFVO++f0DIcg8lFvPNOAF6VxWIpKt9aHN/LIn1M8JqXfDpB7UZYPfhH8Zl85LDEtPNgMZygpBKUwiv/FfKgiCSV55jiWUd0/kyoXax2+8Z4OHxt4K8hqf/0glGHkEe23u+UZyjVKH7aBQhOPeSTi7OWprsVX9oOODPPz7jU2CzoMWEqj0MUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRrcT0H01CECcXCX2hweJ4NwRatCNRBK1ypLqGytx/A=;
 b=EvHNGStUxkURFqThZR+GWVB/WdB1/9bD1pfN/YWKeqIm+B0NlLJnEMCjIxVE7UGNdFfEyz/0o5k0OcVr7fCogB4DqxJsouKhWVccx5Sf+GXCslJZdO7mFofTYVfzJauFDsBcEPuOAtkuoua+b2OXeqcJmhYF7NaIerT2xPO5sqHJGZbu6Ulk/0RG22P0THqBHvH5UDuMJN63B+m8+rrU4rIEjzxTjzEEde6sZfOqjDMZYsi5jV7NRWorz0VCscWaPOnhY0IKqay4XVo/+2stv4eqp9FbTWayB2WpFT7fv+j1EghcHEkyIwffB8oW+YqLtaD/vX896f7uKMowXCmpCQ==
Received: from SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14) by
 PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 11:02:36 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::a7) by SN6PR01CA0001.outlook.office365.com
 (2603:10b6:805:b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Thu,
 25 Dec 2025 11:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Thu, 25 Dec 2025 11:02:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 03:02:21 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 03:02:17 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix IPv6 SHR flex node header length definition
Date: Thu, 25 Dec 2025 13:02:00 +0200
Message-ID: <20251225110201.590263-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e8ff1f-edc4-42c6-e7a3-08de43a51c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DkOMke81p3Mm/CIU4umV9/quocDeX4F12IzEWhJq2wIN6T2ebsiwgWo6MOQH?=
 =?us-ascii?Q?sxpSDM7N2aTDeu4IqFldVTWChDC55P++UV4u7evn/lOLMHWMHiTfL/zr7UOr?=
 =?us-ascii?Q?39BER5e3LEA3fTSlunNqDEQxkMeBr/94PaAJJjACXk6deg7zgns0w5sSVsTF?=
 =?us-ascii?Q?4Itb9+JZNQniVNA2hz1z+NCR9Hjg1jevigwmH6gYC+bh+eRy7i2qONNQHBaB?=
 =?us-ascii?Q?QRJ5k+jbKCfJ0hyoRSwt2JBcg9mCRwHpOCKnmVn3ObJVSmRnFPx9dLMtCsUY?=
 =?us-ascii?Q?DYpNEB5fCPxY//M62dHLkfERjBmmcBBLG+dsLVv8VIa4V4DZxN92o8d7O4AS?=
 =?us-ascii?Q?rnZ3y3XXgInTkAgM1H61uL6qwz7kGKC5bRIj4G4LDCE/WFYseGYMfqySLwnL?=
 =?us-ascii?Q?qBMk14Qp44yNQv4E57NrDjQGoS/hRYIHzCsdFv6EE5uz5y/W+8/lzwdk8/vF?=
 =?us-ascii?Q?QIT2Iym8D26yXeCK4qR47R/oQIDVMlCphlvG1z2EeJr3FqG1D9z+6iRz8S/L?=
 =?us-ascii?Q?gHQXoqSRUUAECuFH1mfVQTvpQCvvQKnLbOEFCu9g4cItrRO5uYtYchRHnlW+?=
 =?us-ascii?Q?ORczY32DBWm43wLK4lg/jc6bh9cPzkEAMIZOD/6ZYCqSqKMLc3tp4gI4KSoI?=
 =?us-ascii?Q?NpRLK9frOc1nJdj6pt/e8d0wSjIpwelan61ZYgmZIWtwUnr59RkIIFbYdWMN?=
 =?us-ascii?Q?1Izdnug3cVoP4C8e7nSwPyxXLgRGAoAhaAZukPaPz/jYs5xCeQJT/WZC8OiG?=
 =?us-ascii?Q?kX8CxPKWoHKzvPGdn+H8JifKNV7/Yn93qU47tzHOjPv4BiKi+tooKFgO5kiT?=
 =?us-ascii?Q?1KYzVhUIrYLbZIfxS/q48hb0NPghj2wHz1OMr3RbHeyU669dA/5koyehCeiK?=
 =?us-ascii?Q?KQ4q9sDbJnQgQcjAf04Ui4WRoHsXBs0RrMAWmN85Pea0MVJTW/XSU/iIrnJf?=
 =?us-ascii?Q?cTADenklfVJ0JVC297I93kCOeIeSNxTnwZIXdcB/bA/xcg1D6ZRH3+QH2vGz?=
 =?us-ascii?Q?lcmV/24iZ04cbdjoEeaFzsWfLpEOw/Wpo2tbxpLK+sWgOAKwqc7wW5y77ZJq?=
 =?us-ascii?Q?8kGPt2L8uHNmp0tMivPEomZ03BS4Bm/ftV2gzpWJgKSEO1XB5XmUgz4jYNhy?=
 =?us-ascii?Q?iruQm9hCTFX26fONGrVciHgaH9PtRzavJsTly+WKMbUZ6tsP5gfWJu6wlP79?=
 =?us-ascii?Q?+wAlIMsgXLyYIq/fO3D5rlA2s5sk2185tBg2UYpQYQc1tYqV72voL1XfJTHT?=
 =?us-ascii?Q?qdx3En0DwQWO59gLxjtgS/WWTtYL6J7or3bYUC9Biat2NwBLMahwdpHr7U0q?=
 =?us-ascii?Q?y2/Ep3iSPjdpxsnhOBy6b9T+c41LXXSSfb+Rj49TLSP8IF5e606JvVNheTGY?=
 =?us-ascii?Q?cYi8qJeq7cWxU/4ArCikuZL/yB4QiomAWyJaIQcK8yVOaUeUthmxXojotzCs?=
 =?us-ascii?Q?QoRNHiV78HvzCvpuNacAY74lLpWGu7RPIeS/+H46pBoFBhTtZIUGWp94vtgR?=
 =?us-ascii?Q?IPC9vvdBcDTysUvqR3dGb8K7/mqLOD23TJiFl45XIRd2TKZh+hvVkGSRbA7/?=
 =?us-ascii?Q?dFuXkinvpWiD5LkbWZI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 11:02:35.8137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e8ff1f-edc4-42c6-e7a3-08de43a51c7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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

MLX5 PARSE_GRAPH_NODE defines the header_length_field_offset_mode bit,
starting from ConnectX-8. The bit value must match
HCA_CAP.header_length_field_offset_mode.

1. The patch copies header_length_field_offset_mode bit from a port
PARSE_GRAPH node capabilities to PARSE_GRAPH node definition.

2. The patch fixes the header_length_field_offset value to match
HCA_CAP.header_length_mask_width.

3. The patch replaces the static value in PARSE_GRAPH node
header_length_field_mask definition with one that matches
HCA_CAP.header_length_mask_width.

Fixes: a2234609bf7e ("net/mlx5: fix flex flow item header length")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5.c           | 28 +++++++++++++++++-----------
 drivers/net/mlx5/mlx5.h           |  3 ++-
 drivers/net/mlx5/mlx5_flow.h      |  2 ++
 drivers/net/mlx5/mlx5_flow_flex.c |  2 +-
 4 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index decf540c51..3884caed01 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1038,6 +1038,11 @@ mlx5_flex_parser_ecpri_alloc(struct rte_eth_dev *dev)
 	return (rte_errno == 0) ? -ENODEV : -rte_errno;
 }
 
+/* IPv6 SRH header is defined in RFC 8754 */
+#define MLX5_SRH_HEADER_LENGTH_FIELD_OFFSET 8
+#define MLX5_SRH_HEADER_LENGTH_FIELD_SIZE 8
+#define MLX5_SRH_HEADER_LENGTH_SHIFT 3
+
 /*
  * Allocation of a flex parser for srh. Once refcnt is zero, the resources held
  * by this parser will be freed.
@@ -1078,18 +1083,14 @@ mlx5_alloc_srh_flex_parser(struct rte_eth_dev *dev)
 	/* Srv6 first two DW are not counted in. */
 	node.header_length_base_value = 0x8;
 	/* The unit is uint64_t. */
-	node.header_length_field_shift = 0x3;
+	node.header_length_field_shift = MLX5_SRH_HEADER_LENGTH_SHIFT;
+	node.header_length_field_offset_mode = !attr->header_length_field_mode_wa;
 	/* Header length is the 2nd byte. */
-	if (attr->header_length_field_mode_wa) {
-		/* Legacy firmware before ConnectX-8, we should provide offset WA. */
-		node.header_length_field_offset = 8;
-		if (attr->header_length_mask_width < 8)
-			node.header_length_field_offset += 8 - attr->header_length_mask_width;
-	} else {
-		/* The new firmware, we can specify the correct offset directly. */
-		node.header_length_field_offset = 12;
-	}
-	node.header_length_field_mask = 0xF;
+	node.header_length_field_offset = MLX5_SRH_HEADER_LENGTH_FIELD_OFFSET;
+	if (attr->header_length_mask_width < MLX5_SRH_HEADER_LENGTH_FIELD_SIZE)
+		node.header_length_field_offset +=
+			MLX5_SRH_HEADER_LENGTH_FIELD_SIZE - attr->header_length_mask_width;
+	node.header_length_field_mask = mlx5_flex_hdr_len_mask(MLX5_SRH_HEADER_LENGTH_SHIFT, attr);
 	/* One byte next header protocol. */
 	node.next_header_field_size = 0x8;
 	node.in[0].arc_parse_graph_node = MLX5_GRAPH_ARC_NODE_IP;
@@ -1143,6 +1144,11 @@ mlx5_alloc_srh_flex_parser(struct rte_eth_dev *dev)
 						(i + 1) * sizeof(uint32_t) * CHAR_BIT;
 	}
 	priv->sh->srh_flex_parser.flex.map[0].shift = 0;
+	DRV_LOG(NOTICE,
+		"SRH flex parser node object is created successfully. "
+		"Header extension length field size: %d bits\n",
+		attr->header_length_mask_width > MLX5_SRH_HEADER_LENGTH_FIELD_SIZE ?
+		MLX5_SRH_HEADER_LENGTH_FIELD_SIZE : attr->header_length_mask_width);
 	return 0;
 error:
 	if (fp)
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 966e802f5f..d84445db49 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1472,7 +1472,8 @@ struct mlx5_flex_item {
 };
 
 /*
- * Sample an IPv6 address and the first dword of SRv6 header.
+ * Sample IPv6 address in the first segment list
+ * and the first dword of SRv6 header.
  * Then it is 16 + 4 = 20 bytes which is 5 dwords.
  */
 #define MLX5_SRV6_SAMPLE_NUM 5
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 218b55d536..cad1a00265 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3712,6 +3712,8 @@ flow_hw_get_ipv6_route_ext_mod_id_from_ctx(void *dr_ctx, uint8_t idx)
 	return 0;
 }
 
+uint8_t mlx5_flex_hdr_len_mask(uint8_t shift, const struct mlx5_hca_flex_attr *attr);
+
 static inline bool
 mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv)
 {
diff --git a/drivers/net/mlx5/mlx5_flow_flex.c b/drivers/net/mlx5/mlx5_flow_flex.c
index d21e28f7fd..12d79ffb9e 100644
--- a/drivers/net/mlx5/mlx5_flow_flex.c
+++ b/drivers/net/mlx5/mlx5_flow_flex.c
@@ -458,7 +458,7 @@ mlx5_flex_release_index(struct rte_eth_dev *dev,
  *    6     b00000011  0x03
  *    7     b00000001  0x01
  */
-static uint8_t
+uint8_t
 mlx5_flex_hdr_len_mask(uint8_t shift,
 		       const struct mlx5_hca_flex_attr *attr)
 {
-- 
2.51.0

