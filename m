Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D295C369D1
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 11:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2073340263;
	Sun, 27 Apr 2025 13:25:55 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by mails.dpdk.org (Postfix) with ESMTP id 23BCB4021F
 for <dev@dpdk.org>; Sun, 27 Apr 2025 13:25:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/cmSOBaGg9DBshWuuwRjZ/tl9+9wBHtPCtrYM54vY6IC5RdjpaC1TPTOKMT/Sn4NUAmvMwvOUSGelE43/dEJnWcTryHLqRXe15DIlMPbjEq8DNM8jBqlhtmdLXVYyZ+04bjn9wwnDLVBzu/Ba7vHt+F3ZwVaEPPcLBT6X/rE6zhhvQ3TpaQ+FUC8rKCrBB+SGra3G4RcIGpnsweSiRQPNjOFHVo5LBcEZLKLCf1ZdEtzrUAgiqCprDDW2dxxDatvKybQvyyKI/LnHCo4neJjFq0C37W+Go2QewCgol3o29tvrDmzVcusD8VuriUOJTQb0FfNbxKr58G4SGQGuTOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gnWCUr0Esm0I9jcd+NBCk/HhMvPIvl0hY7qtkybqF8=;
 b=s2Yb3FI5zeux9dcFR6K+ZiWQW3A7prTwvM3dlNzJt6/yXEj4HM0Pm3VhqxxrsL5YiXsGTmpDpTHKAI3Es4gseEJ26k28RfZSEs90DbA8154XShESL/p2Dz84beUjBN00yZWKZ0uOlG5iImZSMnBnBlLIJ0e/lFH+GT4LoOto6NW2qWCU8LybQ0A1gj+ymOHFg3f+ZDKTUYAanfrH+ZxX6y/wDwR3QWBUPtX4612oppk2AYMQdETEsDvTywxXUyW2sC2us4H28zMcVLSboiZdUwSg3eOphoFN7RTsRGsulOd4hy4zv4k0vnotWchS2xbzUislSRPf3hEj+YwecPW+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gnWCUr0Esm0I9jcd+NBCk/HhMvPIvl0hY7qtkybqF8=;
 b=KR4mSbm4qSJXg9ZfVxLNT/WeGXdUbIjPLSt6DAL5h4LfRUOVDlZjc0pt0ljujGYk15ajHoX6S6/JvSB8XmgS7YWUx893rot+YU4lPbV8iEp4VfMd6Td7qGNIK5WW49aldNkpinV3eGf9pXWpWphCzsXm9cyTZXeSBANI3zw15664j8mFrobiZLj6++aNeJTIvUcjZMpwPoA2kEPggY9lPN25SY57Skk7A4XK0RmPBerbhzk5/VcWqik9D4ESGxHTkeVOyNZJgEezTJoKEchXUrq00m8J8LVcGfnpbdlsw9HPe/6bylAZN8bWkyfTd+A8OSc5ciKO3t7RihUDehSRDw==
Received: from PH0PR07CA0101.namprd07.prod.outlook.com (2603:10b6:510:4::16)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 27 Apr
 2025 11:25:48 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::63) by PH0PR07CA0101.outlook.office365.com
 (2603:10b6:510:4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sun,
 27 Apr 2025 11:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 11:25:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 27 Apr
 2025 04:25:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 27 Apr 2025 04:25:43 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 27 Apr 2025 04:25:41 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: add match on IPv6 fragment extension header
Date: Sun, 27 Apr 2025 14:25:36 +0300
Message-ID: <20250427112537.108725-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 711392b4-0d5f-4a06-bb3f-08dd857e422b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l9Oiwk0tlNR5mzCjjfE0wZZxNmxQcnTvTOzOoujyor3Hyj7B4B0xzyFmQDD0?=
 =?us-ascii?Q?bpAs1N8/M4A11WIvu9PvFNtLMIrulgGLCETpZ5uvu9G7F0qpvXv/FBp5kCzf?=
 =?us-ascii?Q?j1B5Amo7+yyFiU6w1CuIaB2jwcFYx3iCsBk5tNz489ydOTaqMsYmu4bS5e/1?=
 =?us-ascii?Q?eoK3mJEtzIiq+MRZ98Jib7XPari8wTo9ff/ICUW79YwOvlo6HIPw0WW6eeXB?=
 =?us-ascii?Q?r3LszBFAyR/50A7BUFmJZ9qxKBgF3Evf4LtY220QZ2j1cLha1DzNPKX52nxB?=
 =?us-ascii?Q?ShG4kr/QftKb5bNy6YEMVPIHnmvdKyH3Jcl4el8n9Sd9i80vByeXwglldScJ?=
 =?us-ascii?Q?4zfQ4T1EII8W4lLhvouaYCUqlirztZxlHHN2HoRO5j13HRAbfudoSFFwkvRC?=
 =?us-ascii?Q?+tzR/S2F2UiGAJPsbgn7zfMJ9meT695jps3b+UpHWlmTzjAj8LsLLbDlGb/l?=
 =?us-ascii?Q?+9JWZ2MqaZ1a8903yDpn1I/nGgoC1yA2PMl4/4AVh0LqeqUDg/aY+eQHQ08c?=
 =?us-ascii?Q?pgWEzJqqRhBlEQhaKLysN1y8oz5MBAoxTpk/yFsp1ikerrNFkbo1DdwTVf2Y?=
 =?us-ascii?Q?8S2rD4K7umZV1SHXkxPe37eL1HyinbstO1ger2W8VUS4SWmi+SRco289VZWR?=
 =?us-ascii?Q?mLo6pbtt9HOSGh0gGA/PZEWCn25YMxvBY4JubsYPbVAQptIVcsWV+GlrDxN3?=
 =?us-ascii?Q?VqoxO0vu5siBdyb6gs/yZRODcIq6J67U5HiM/jYvRBxzQ69U8L7xUAeYB8Ea?=
 =?us-ascii?Q?fuLpt7h91hR3zSbKUg33lUsHahvCl+kf6vuh6N/QoLsv5mgLEjJk4Giolezm?=
 =?us-ascii?Q?QLAwvZYsKr0sGhw5zc2QNf7VJL2kKuV54ZwWFaRTruZOe2JD2KZ/KyjcJryz?=
 =?us-ascii?Q?iS0RlP59GQMIAP3OyeRCDVOwtAbhhxnQh08pyxfKBGD425949vgZDX5+bTBt?=
 =?us-ascii?Q?fNDS7UGiyo2aLOtyoY6vEInNnbKWcfMlVidhfXjz8dL3HvqGomQBev4W8fpY?=
 =?us-ascii?Q?SNhuZ8AWz7aCe0o7tQFfnGsVAJ7fZr3umXTWCrTOAHfiGjObChH4ZTb8g6Ua?=
 =?us-ascii?Q?JD7Ce8WKfWshYDsymIyi9ryg/BCa4gZwy9uxBxg8ArFn6P1Dn6Pv902lmH2a?=
 =?us-ascii?Q?Nl6C6jHUvIdndLf67Cl/sp6VU/vGoMCxefFOsCwM3tfhJwX0IjWu0dvy+ubi?=
 =?us-ascii?Q?VNg/pfe0unMfoG4DsQ3q+vEsH5EYOmb4/oAHIQUKIZ+sGHk1zxzv1HVmtvDB?=
 =?us-ascii?Q?eJ+/wPflu5jf8AstAVU7CJgEW9nMBKOLNDMy3t/VNbuDFLjGKW6boO2/tua/?=
 =?us-ascii?Q?4/4oRibA1VccTsQ+hpgwqiNkFVXRA8ynM2quj1A5LdFvRdahuW5w7K5dR5tT?=
 =?us-ascii?Q?Mo9YUGLMTXBOaQvYdCcj1TgcHCwk5hwOpjwV5VSx3ZsJ12/Fbw+o2MhMwfPs?=
 =?us-ascii?Q?pg0+bOE7jCxkj3fxsDSAtVHuWc2JnNR18hxMnuzecpE/Gifd3HrxFObbEjYZ?=
 =?us-ascii?Q?2ap81j6u3Hjmj1QOtGzz2u11I6U0no48RpbE?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 11:25:47.7764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711392b4-0d5f-4a06-bb3f-08dd857e422b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

Add HWS support for IPv6 fragment extension header
matching for HWS.
Supported field is next_header.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/rel_notes/release_25_07.rst |  4 ++
 drivers/net/mlx5/hws/mlx5dr_definer.c  | 51 ++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_flow_hw.c        |  1 +
 3 files changed, 56 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index cd1025aac09..6503f5a9f3c 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated NVIDIA mlx5 driver.**
+
+  * Support matching on IPv6 frag extension header with rte_flow template API.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 5272119bcbe..9c11d6c2cb9 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -176,6 +176,7 @@ struct mlx5dr_definer_conv_data {
 	X(SET,          ip_fragmented,          !!v->fragment_offset,   rte_ipv4_hdr) \
 	X(SET_BE16,	ipv6_payload_len,	v->hdr.payload_len,	rte_flow_item_ipv6) \
 	X(SET,		ipv6_proto,		v->hdr.proto,		rte_flow_item_ipv6) \
+	X(SET,		ipv6_frag_proto,	v->hdr.next_header, rte_flow_item_ipv6_frag_ext) \
 	X(SET,		ipv6_routing_hdr,	IPPROTO_ROUTING,	rte_flow_item_ipv6) \
 	X(SET,		ipv6_hop_limits,	v->hdr.hop_limits,	rte_flow_item_ipv6) \
 	X(SET_BE32P,	ipv6_src_addr_127_96,	&v->hdr.src_addr.a[0],	rte_flow_item_ipv6) \
@@ -2553,6 +2554,51 @@ mlx5dr_definer_conv_item_ipv6_routing_ext(struct mlx5dr_definer_conv_data *cd,
 	return 0;
 }
 
+static int
+mlx5dr_definer_conv_item_ipv6_frag_ext(struct mlx5dr_definer_conv_data *cd,
+					  struct rte_flow_item *item,
+					  int item_idx)
+{
+	const struct rte_flow_item_ipv6_frag_ext *m = item->mask;
+	struct mlx5dr_definer_fc *fc;
+	bool inner = cd->tunnel;
+
+	if (!cd->relaxed) {
+		fc = &cd->fc[DR_CALC_FNAME(IP_VERSION, inner)];
+		fc->item_idx = item_idx;
+		fc->tag_set = &mlx5dr_definer_ipv6_version_set;
+		fc->tag_mask_set = &mlx5dr_definer_ones_set;
+		DR_CALC_SET(fc, eth_l2, l3_type, inner);
+
+		/* Overwrite - Unset ethertype if present */
+		memset(&cd->fc[DR_CALC_FNAME(ETH_TYPE, inner)], 0, sizeof(*fc));
+
+		fc = &cd->fc[DR_CALC_FNAME(IP_FRAG, inner)];
+		if (!fc->tag_set) {
+			fc->item_idx = item_idx;
+			fc->tag_set = &mlx5dr_definer_ones_set;
+			fc->tag_mask_set = &mlx5dr_definer_ones_set;
+			DR_CALC_SET(fc, eth_l4, ip_fragmented, inner);
+		}
+	}
+
+	if (!m)
+		return 0;
+
+	if (m->hdr.frag_data || m->hdr.id || m->hdr.reserved) {
+		rte_errno = ENOTSUP;
+		return rte_errno;
+	}
+
+	if (m->hdr.next_header) {
+		fc = &cd->fc[DR_CALC_FNAME(IP_PROTOCOL, inner)];
+		fc->item_idx = item_idx;
+		fc->tag_set = &mlx5dr_definer_ipv6_frag_proto_set;
+		DR_CALC_SET(fc, eth_l3, protocol_next_header, inner);
+	}
+	return 0;
+}
+
 static int
 mlx5dr_definer_conv_item_random(struct mlx5dr_definer_conv_data *cd,
 				struct rte_flow_item *item,
@@ -3285,6 +3331,11 @@ mlx5dr_definer_conv_items_to_hl(struct mlx5dr_context *ctx,
 			item_flags |= cd.tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV6 :
 						  MLX5_FLOW_LAYER_OUTER_L3_IPV6;
 			break;
+		case RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT:
+			ret = mlx5dr_definer_conv_item_ipv6_frag_ext(&cd, items, i);
+			item_flags |= cd.tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV6_FRAG_EXT :
+						  MLX5_FLOW_LAYER_OUTER_L3_IPV6_FRAG_EXT;
+			break;
 		case RTE_FLOW_ITEM_TYPE_UDP:
 			ret = mlx5dr_definer_conv_item_udp(&cd, items, i);
 			item_flags |= cd.tunnel ? MLX5_FLOW_LAYER_INNER_L4_UDP :
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 20d38ce4141..9a281b67dc7 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -8899,6 +8899,7 @@ flow_hw_pattern_validate(struct rte_eth_dev *dev,
 			*item_flags |= MLX5_FLOW_LAYER_ECPRI;
 			break;
 		case RTE_FLOW_ITEM_TYPE_IB_BTH:
+		case RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT:
 		case RTE_FLOW_ITEM_TYPE_VOID:
 		case RTE_FLOW_ITEM_TYPE_END:
 			break;
-- 
2.21.0

