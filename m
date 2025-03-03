Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD01C282D2
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 13:29:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E2014027F;
	Mon,  3 Mar 2025 14:29:55 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by mails.dpdk.org (Postfix) with ESMTP id A0BC4400D7;
 Mon,  3 Mar 2025 14:29:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoU/P6vXS1rubAxGTIRp+f1mEyTvmpeeWEvNa8cws1/ysVZd6BPch/4f/73MH2byxmHuxMPpEfxLLWWEcTg1dRbCDCz6vFanoVw0SBrvWFjSVI0408Xkqcs5vhb054yHuG7BGUJnqJmY1elYplWugDEtHmZ/31j4SaO955Sgxr6OMleYjiXWu9yXxTrB1lW+iwq8RHaP2Ntf6tYdZH+50FOLWZzwGGqvFWDJm4oYhNC3I6a2G7Hxo31oL12QrTdVR0ag0/mdIy5s/eXn2bXJLMQbQQQL98nTdGEc/wrA9x7lcLe9AFZfNDuJFgWBj/48iFbCSEMgh+oVWPeiZnBvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGcXkrpr6Wpqj8gswMXeuhomzrDUYZMj+jFBkATqfMc=;
 b=dnlZKB333sp6800NsHGQcUQ5yFB3cfSBau5pPo/TcWeEHNVeDvq823XLqiLJAWhcqGU+pm1Arjk8wiaK/4gZ58XIz05kwfCASgQ93t35VJovElnVuiD7q4N6srscY9eQbHIaLSsqSUFzDikabvkWSC0UNu4UQFFoZ+v7AT6LHChq5G8zeRUkCWBowb4LqEy9fgy288Ptt91CcnFJrjZpf8L6mOdXrigQs0t9oOw/gahiSb+h/Hlxw7GCcgd1d1ZiItCrv/4ElsAsyAeKmmEpnrB2Cw/mYxJe1z0fc8wrKiPLeWPA/Ca4xVthKQEkz3fCLU/eH0cDdUM9DuIHbZZMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGcXkrpr6Wpqj8gswMXeuhomzrDUYZMj+jFBkATqfMc=;
 b=QHCExw+AI9HOMiZQvogJv3+u4nt/H06LuqO9BvGQziLEo+cXpqo3RNbOescD+Q1fgk1ZKDfuCaG7tZ1lbJvtXPiRqs9mq66MaIFuvSHRncruTvAlTZS2eoWWO3kOYIhK59fGAWFtHlkdVymoDUBxDPMJRcDgOi6L/MDdZHOKYZDCGgJVvhW03iHNUvsHZ2ELUGiEwF1f0WBTu8uvF8P5DZYNKGdGMrtHseQ7cuiczuwvGh2lCis/uQVYab4cnNGKE+xn29BqjFEEir1TXT8ygTYKC27Hjx6OGi69lhpTjPbkgYXTXl9qKvP91kJutAI797U6grlcpU7bzF+Ph6oNzw==
Received: from CH0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:610:cc::7)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 3 Mar
 2025 13:29:48 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::6b) by CH0PR03CA0062.outlook.office365.com
 (2603:10b6:610:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 13:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 13:29:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 05:29:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 05:29:38 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 05:29:36 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix flow create failure with GENEVE options match
Date: Mon, 3 Mar 2025 15:29:31 +0200
Message-ID: <20250303132931.71335-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 68115586-c0d4-41bd-ed8a-08dd5a5777b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/gMnagfNu5rueC5npC94dKEyKkScdqp3IvQbQblFfRYkyipk9M6mLooS0NL6?=
 =?us-ascii?Q?HDiHtFUUhZqX2Z+ZNGsxQNrLuU5E6vVPajWKcvyik4957LIGzUivf5aZ/O57?=
 =?us-ascii?Q?h0XDw1A4p+OpKtV/8+2QW78sN3rP6tuBf/YYF1xNz2/JgQbsK4XVIPdMSDzZ?=
 =?us-ascii?Q?ZiGabM8ASBE8sxk02nVxgImSBz/V0zq8ekzjPOWzhRKceW9hXJD22+hB7tAm?=
 =?us-ascii?Q?UNEz3e4CM4Z6sadYy1Uo5t7NJkWGhmwF16QqGksSOdBhkeEAro/nF8kZLOpX?=
 =?us-ascii?Q?osfB/IXBoNYQZ2qHdXJi4us1goFcpUC+KuyMj972fqB75CUub0WHAE4hHM0/?=
 =?us-ascii?Q?NWzR7HAsbVzlJ8bGLixengc8TJQX5GdLSmgxIQJKs0Hwcb6k4kAQw+mxaQAD?=
 =?us-ascii?Q?JpjrYKPfByWVCyhxFBaJ4DWWF2gL+Sjx5pGyvTtbRHPEVVJNqcvRt0RMbRvt?=
 =?us-ascii?Q?jPcsrC9d8EhQNfQ6dMCVVWX2fT5u+SGk0YIuGrH8EDtfRyVBwuwvAaHJ29vp?=
 =?us-ascii?Q?fldIUfMlSkKw10sNQtyHFI0dkRCwBacV6463x41nc6l2Be8YtKDm5XLI65tu?=
 =?us-ascii?Q?/mZqQbsFBFEgXGCUqkWksHdzAAsvsn2KLEX2+U3nB/fYXAR9QzruCcBbw9ci?=
 =?us-ascii?Q?wgAR7dMCYG1aHVeZctUzONeRVtDSfq+JO2+G3YHBgj6Su3GT/PdTcXRI+kgi?=
 =?us-ascii?Q?v3SNIMZfF/gO2JbcmpVPpUJTnmdbuNqzhE7b1SnWd7ENYHZWQf1+ELrOUG1h?=
 =?us-ascii?Q?9PO0bYhGEddieJOClfX/LyxtU3Uw/ceAHtgD22cN9LXg8nusKGjS0DU4OloO?=
 =?us-ascii?Q?2c7BQbDKMc+If2t42XuuvjR2pLDPgO+FXB+gwYYUvg3JyDoK5xpIKyW6GXXP?=
 =?us-ascii?Q?cAbJK36qdNrSVzADLa6F8CoS175d6KqmHbeKos7uhmq2yopbxJAMg79sx2vo?=
 =?us-ascii?Q?xOyFTz5R7HaviuRQKFDoP+pkm0szWynKQe1Bkfc4HXW5A9ck0o/NOEpbAJEv?=
 =?us-ascii?Q?QjrPLO+GDUyD50f6a+L3grJuDsyQsk3yHNOxqZKi2kFPlGllk7KO5IZR8XrY?=
 =?us-ascii?Q?uJavQnyfQCQFg27r2pB6yrTR8oy2SM+h0e/CylsEcUUSn3olpZonv4adD774?=
 =?us-ascii?Q?CLHtyXKiNAYWlVOfa90BqqyvRCZItc6V34JIp7BHQlOl5okilIPOp4WsGb6z?=
 =?us-ascii?Q?2NRf9PRGv+PJzJzM9UADgrepJNQLiR2yora4b7FdbKS65xLff3hseuNEzzD1?=
 =?us-ascii?Q?o3+qdBkpgcSgU++YMBrJZbTk/XkzJmakIXNN7AR9Eld/tEqYG1E92OLaLu5i?=
 =?us-ascii?Q?LyvoPzI55H+wSDNRZdamIerWUSZVFQJHKF8QmZuC4IByHBBuls3+C6CusB6X?=
 =?us-ascii?Q?261d6kV/ckQbXMxFxx8Zw5UguItfJVXDoQ1ZXBf00rIv7B3pIH7cCPw2bxp7?=
 =?us-ascii?Q?AJPN1G67dCL62XtTl14wGgjdWeqW1mhiSdYInSakvXJWpEIF9TBhjzUOT9CP?=
 =?us-ascii?Q?3px6iuNwRoF7qlk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:29:47.2072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68115586-c0d4-41bd-ed8a-08dd5a5777b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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
geneve options were missing a parser and therefor it failed.
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

