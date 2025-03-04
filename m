Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A0C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 07:57:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 798C040156;
	Tue,  4 Mar 2025 08:57:26 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by mails.dpdk.org (Postfix) with ESMTP id 8307C40041;
 Tue,  4 Mar 2025 08:57:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgP7JdDSbBVlTnMj/OhUyVwCPHj81bxN/y7xCa6dp9j7WzSoT//HpPx+7OLfdssky48l0ryNVwNjY/FxVJNaDdSd7htbafdyQB5K2rnud7KZv5BOPRVcW4biMyrFq9CSjGxBqxMxn9ky/sRr4kmNQHlFttMZ3GQbSfxOjEn4uCHuk3PUKnXEhkjITsSQTGl1ycuD8veX6KSnkM7ER5L1pYtrCdlXR+vl1Mu3g84rCfMys1MQz7EXiZ8EgQ7ufTLII3t2YKhHs6iisgqySI9xry+TydJxBDTUILrkhX9rVMyWRcH8T/ocAhQQX4iZfgd4Ov8AH90zQnBlw1Seceg6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaSVo16LmqqpOqk1qZNQlujPx6ungostj5BjRtE9rZU=;
 b=jSEpmuuok+e/hJDX5grOgjcF1imnx5+jc6rZGOQ/fQYu5kWt6VVkTFcZFTMxg9DH3eMaS6FSLFTvtDB1LChQUgX5mazaZaHhGdxQHwKDeyxuF46u9U9dqCwpRrytWmcTVT7uamfI7iLkYdSmuCWEGJrIsBzCR9oysR5XuFt9Y6VBsZEc538LqIBYd92yQ7tvnIVuCUFr8Z9H/uqbSf0z/wyZFqONgzECQUilewM07AmsMAQ46+qCUi+NanSvgmip7369JB8QbAYZWcFW9MYRuFDuZyzP2xpYLKJ5v0DOpK4zSZDPl95kTOARMsKICCc6MuMOQuOjkcYr06uXrqOf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaSVo16LmqqpOqk1qZNQlujPx6ungostj5BjRtE9rZU=;
 b=nKZZVQXgdYDsREu9/nzu2M0GG80BI4dptF5D9wg/f33LR1R5UwUniP247ayg2I/votIN4euqorczYdFmPfeKAUYtw1A+xCX8VfG7OqCLFGqTtPUNfNDqNLeCXMp5gz20p9dp7Aur9GZV7yxNyR7kcY3ppuwMKA/V6JtNzmeAL7oAWcAUXL/pnzFYHXtYnPIV9MLZywEitbQi7SnjAWPGTNFafVjzLgZ9JhkhPmF6ZlULh3qjZOE19oXuE50m4/zBxDIKW0tZeDLChPN78jMLBOkFfhIgl542qooR20VjS7NgLG+LtINlzNgDopFWCeZY3Pl5At8G8LKBxREpN09ioA==
Received: from SJ0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:2c0::17)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 07:57:18 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::5f) by SJ0PR13CA0012.outlook.office365.com
 (2603:10b6:a03:2c0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Tue,
 4 Mar 2025 07:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 07:57:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 23:57:02 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 23:57:01 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 23:56:59 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2] net/mlx5: fix flow create failure with GENEVE options match
Date: Tue, 4 Mar 2025 09:56:54 +0200
Message-ID: <20250304075655.110947-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: acccf143-d409-4928-a705-08dd5af22f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+l5VftudClVfXdB/jVg5RG1z4ry5t/LAgTdkYSAAtVbUfcuqz2sT2xPIo/w?=
 =?us-ascii?Q?1V3C5rdWHMRsSmmFij6uVrida2aHNzASxC4aPFzaEUPJ5l+YqTAGZ9VuL89u?=
 =?us-ascii?Q?Tak7+e2QhZxKFzXHfTJ2dAq0V2+muITx6biwskJNyVkxBAcSRI4otOanarAc?=
 =?us-ascii?Q?jFDQGJf2sOHlWoLHCmxEy5yFoiYP1I9qTEbe5dWl/CpjxhuF/K3tFq3WP56h?=
 =?us-ascii?Q?2lg6bIpF2Rwrg65tnqQK5Tajz1MUA2Frv9/xYmvQ5N1jBdn/b96KIw+0boIx?=
 =?us-ascii?Q?u/f2wZliB4erID+p35TKp0oR+DA93cK2yuEA8QJs5e281Y1iBk0aZy8Dv/H2?=
 =?us-ascii?Q?XdDrQug7R9dXhl/SdJjv6fue9LKiBvAhl8sjlQm4OQ77Dn+XNlVxQFkivgF2?=
 =?us-ascii?Q?gYlV4MB3tr8Z3zis2eCzgG/5UnfFZcio0FL5fheJ/8lDsaSSdpeElRbfPvqj?=
 =?us-ascii?Q?nCWjv8uSfaDoRZjBl4/rfGBjHjLW0Q7BJl3oPzGWhPhfzQEI2dbVI3HJAq7h?=
 =?us-ascii?Q?Tv374wL+o6w9Zmcede4h1b2m5GyCfu9AN92YECXcghYJ4YntRLXQRUb/ywrP?=
 =?us-ascii?Q?SBGgFFkz1kF3RwwRu6b321SkyKEFwGe4Ig6ijHNo88QXOnM0V2mS+PxukKce?=
 =?us-ascii?Q?IYuKRwoXdSVZoEWBDr9ow5dmGFxMs9SQcHJ8gVxTKTy9c4O1o8zzppfnbFSz?=
 =?us-ascii?Q?IgKvCynnNmLAhKb+SSq/27KNHfaoIyB070cF4ap7LD0OFxDBnFfwp4iKTbMB?=
 =?us-ascii?Q?cmr69uvzEj44xfS8EoLyRdfSFzWgz+bDoqQ8hBjJRPXheAbrP3mz8KYJUBCn?=
 =?us-ascii?Q?FXdD4taBEA+i06SmURxkz0itg175kHlo+Ufp+x+9fXnvaaNTtEFwmNnFXMcj?=
 =?us-ascii?Q?vxEuAMJhDvUrTN6sqIb66idJhaxbtGdBXA/x4Cpsm9kcZSrnZxPQOvBJm1jk?=
 =?us-ascii?Q?I8BHk1ZQQvaHkxS92qNOS73KgdNcpVbczJtHogLlQZU9R4cAzQJY3Jxlga3k?=
 =?us-ascii?Q?lgaF+4Gae2onTEIwIQSHzVM2k8c9Gftc0tZ4NPn/xyufTyZKth1CMz8TOV8w?=
 =?us-ascii?Q?W6vf0qEmwvxIS83SYrwsjkwijrk6Oodz4Xz75ZqtymQejnXJll3Tt5xoS7WO?=
 =?us-ascii?Q?OgIIEGKYbjA5Zh3xGFOeGgJMFl6HQh/YKUixRhes9iBGeFaUS4ehrMhimyQd?=
 =?us-ascii?Q?jTS9LU395JFkp1iFd/9Oxdnx7DafVJ7F7PAtnI+V9NchAP6D3ITF57x+ICuR?=
 =?us-ascii?Q?4RWOLLWpoxDhdWJ6oQ/BseJZNdBM7SqKkORnDMz1BP5f1wvcpO12BnRWkjRR?=
 =?us-ascii?Q?ym9nHGE0XDgpO3OtvECf4lpDOFYYb7cpaytjeRuHl4Iz6BIqDGfziEOKAueu?=
 =?us-ascii?Q?Ee3DC37jC/mNe3+omb+iEUSbZ3SoXURLIs8gFMjBl0OhtezA/oCZgbdcr9cW?=
 =?us-ascii?Q?qvMcOnqFM3Y0seMQHyD9IQVLwIHHIZGUDDVWuGepQ21cXLVTHOR8l7q9F4Hq?=
 =?us-ascii?Q?M+O698lsPw17HdY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:57:18.2518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acccf143-d409-4928-a705-08dd5af22f9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
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

For non template API on top of HWS,
geneve options were missing a parser and therefore it failed.
In template API it geneve options is configured by the user
using mlx5 set/apply tlv_options commands.

To support hybrid mode, if no parser exists,
added inner configuration of geneve parser, else,
in debug mode, check if the geneve option needed exist in
current parser configured.
In release mode, assume the option exist in current configured parser.

Updated needed configuration for geneve options in doc.

Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/mlx5.rst            |  5 +++
 drivers/net/mlx5/mlx5_flow.h        | 17 +++++++
 drivers/net/mlx5/mlx5_flow_dv.c     | 69 ++++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_flow_geneve.c |  2 +-
 drivers/net/mlx5/mlx5_flow_hw.c     |  6 +--
 5 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 190c58b54d6..1e34eab8d8e 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -288,6 +288,11 @@ Limitations
     - RTE_FLOW_ITEM_TYPE_MPLS matching is not supported on group 0.
     - mpls_encap and mpls_decap actions support only one level of MPLS.
 
+  - When using synchrounous rte_flow APIs,
+    the following limitations and considerations apply:
+
+    - Geneve options is supported when ``FLEX_PARSER_PROFILE_ENABLE`` = 0(default).
+
 - When using Verbs flow engine (``dv_flow_en`` = 0), flow pattern without any
   specific VLAN will match for VLAN packets as well:
 
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e5245edd463..a5bde158caa 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -2158,6 +2158,23 @@ flow_hw_get_port_id_from_ctx(void *dr_ctx, uint32_t *port_val)
 	return -EINVAL;
 }
 
+/**
+ * Get GENEVE TLV option matching to given type and class.
+ *
+ * @param priv
+ *   Pointer to port's private data.
+ * @param type
+ *   GENEVE option type.
+ * @param class
+ *   GENEVE option class.
+ *
+ * @return
+ *   Pointer to option structure if exist, NULL otherwise and rte_errno is set.
+ */
+struct mlx5_geneve_tlv_option *
+mlx5_geneve_tlv_option_get(const struct mlx5_priv *priv, uint8_t type,
+			    uint16_t class);
+
 /**
  * Get GENEVE TLV option FW information according type and class.
  *
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 61d3101ce8c..c77041317b4 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -14448,6 +14448,64 @@ flow_dv_translate_items(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static int
+flow_dv_translate_items_geneve_opt_nta(struct rte_eth_dev *dev,
+				   const struct rte_flow_item *items,
+				   struct mlx5_flow_attr *attr,
+				   struct rte_flow_error *error)
+{
+	rte_be32_t geneve_mask = 0xffffffff;
+	struct rte_pmd_mlx5_geneve_tlv geneve_tlv = {
+		/* Take from item spec, if changed, destroy and add new parser. */
+		.option_class			= 0,
+		/* Take from item spec, if changed, destroy and add new parser. */
+		.option_type			= 0,
+		/* 1DW is supported. */
+		.option_len			= 1,
+		.match_on_class_mode		= 1,
+		.offset				= 0,
+		.sample_len			= 1,
+		.match_data_mask		= &geneve_mask
+	};
+	const struct rte_flow_item_geneve_opt *geneve_opt_v = items->spec;
+	const struct rte_flow_item_geneve_opt *geneve_opt_m = items->mask;
+	void *geneve_parser;
+	struct mlx5_priv *priv = dev->data->dev_private;
+#ifdef RTE_LIBRTE_MLX5_DEBUG
+	struct mlx5_geneve_tlv_option *option;
+#endif
+
+	/* option length is not as supported. */
+	if ((geneve_opt_v->option_len & geneve_opt_m->option_len) > geneve_tlv.option_len)
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ITEM, items,
+			" GENEVE OPT length is not supported ");
+	geneve_tlv.option_class = geneve_opt_v->option_class & geneve_opt_m->option_class;
+	geneve_tlv.option_type = geneve_opt_v->option_type & geneve_opt_m->option_type;
+	/* if parser doesn't exist */
+	if (!priv->tlv_options) {
+		/* Create a GENEVE option parser. */
+		geneve_parser = mlx5_geneve_tlv_parser_create(attr->port_id,
+						&geneve_tlv, 1);
+		if (!geneve_parser)
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, items,
+				" GENEVE OPT parser creation failed ");
+#ifdef RTE_LIBRTE_MLX5_DEBUG
+	} else {
+		/* Check if option exist in current parser. */
+		option = mlx5_geneve_tlv_option_get(priv,
+						geneve_tlv.option_type,
+						geneve_tlv.option_class);
+		if (!option)
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, items,
+				" GENEVE OPT configured does not match this rule class/type");
+#endif
+	}
+	return 0;
+}
+
 /**
  * Fill the flow matcher with DV spec for items supported in non template mode.
  *
@@ -14472,6 +14530,7 @@ flow_dv_translate_items_nta(struct rte_eth_dev *dev,
 			const struct rte_flow_item *items,
 			struct mlx5_dv_matcher_workspace *wks,
 			void *key, uint32_t key_type,
+			struct mlx5_flow_attr *attr,
 			struct rte_flow_error *error)
 {
 	int item_type;
@@ -14492,6 +14551,12 @@ flow_dv_translate_items_nta(struct rte_eth_dev *dev,
 		mlx5_flex_flow_translate_item(dev, key, flex_item_key.buf, items, tunnel != 0);
 		wks->last_item = tunnel ? MLX5_FLOW_ITEM_INNER_FLEX : MLX5_FLOW_ITEM_OUTER_FLEX;
 		break;
+	case RTE_FLOW_ITEM_TYPE_GENEVE_OPT:
+		ret = flow_dv_translate_items_geneve_opt_nta(dev, items, attr, error);
+		if (ret)
+			return ret;
+		wks->last_item = MLX5_FLOW_LAYER_GENEVE_OPT;
+		break;
 	default:
 		ret = flow_dv_translate_items(dev, items, wks, key, key_type,  error);
 		if (ret)
@@ -14562,12 +14627,12 @@ __flow_dv_translate_items_hws(const struct rte_flow_item *items,
 		/* Non template flow. */
 		if (nt_flow) {
 			ret = flow_dv_translate_items_nta(&rte_eth_devices[attr->port_id],
-							  items, &wks, key, key_type,  NULL);
+							  items, &wks, key, key_type, attr, error);
 			if (ret)
 				goto exit;
 		} else {
 			ret = flow_dv_translate_items(&rte_eth_devices[attr->port_id],
-						      items, &wks, key, key_type,  NULL);
+						      items, &wks, key, key_type, error);
 			if (ret)
 				goto exit;
 		}
diff --git a/drivers/net/mlx5/mlx5_flow_geneve.c b/drivers/net/mlx5/mlx5_flow_geneve.c
index d8086d333ff..6bf53e12708 100644
--- a/drivers/net/mlx5/mlx5_flow_geneve.c
+++ b/drivers/net/mlx5/mlx5_flow_geneve.c
@@ -97,7 +97,7 @@ option_match_type_and_class(uint8_t type, uint16_t class,
  * @return
  *   Pointer to option structure if exist, NULL otherwise and rte_errno is set.
  */
-static struct mlx5_geneve_tlv_option *
+struct mlx5_geneve_tlv_option *
 mlx5_geneve_tlv_option_get(const struct mlx5_priv *priv, uint8_t type,
 			   uint16_t class)
 {
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 03cbf53f492..7099b59319a 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14096,9 +14096,9 @@ flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 	/* TODO TBD flow_hw_handle_tunnel_offload(). */
 	(*flow)->nt_rule = true;
 	(*flow)->nt2hws->matcher = &matcher;
-	ret = flow_dv_translate_items_hws(items, &flow_attr, &matcher.mask.buf,
-					MLX5_SET_MATCHER_HS_M, NULL,
-					NULL, error);
+	ret = __flow_dv_translate_items_hws(items, &flow_attr, &matcher.mask.buf,
+					    MLX5_SET_MATCHER_HS_M, NULL,
+					    NULL, true, error);
 
 	if (ret)
 		goto error;
-- 
2.21.0

