Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E79606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=suTlGHCo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 815984029E;
	Wed, 11 Nov 2026 09:12:15 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by mails.dpdk.org (Postfix) with ESMTPS id 01C9D4029B;
 Wed, 11 Nov 2026 09:12:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEPFVwVo+/G+xCzjvHXfqTGvzOwXYyEvktGmuwlXJq7F2uPgBN6RPCTDneonr0y1cP3Z8RuEJpK1Z7Bjpi2rUlFqMO66MiBPSrmNjaVrr/ClQtUN5rQdCVHW10R1D30U8iLsCIiQzpOPaU5JLLQzm9W2tk9RM0VRXl1x9Y3vUW5w8Qalt3TE5+31lwkuubroiSLSqhiNSXYaRCt4am0TVyNIFeRPIGLl9tj1vsfL68X0JbLUnZOzcdf5l4543Kkh2ieCB03pyVfy9m8RUdSVG0vx3J9pVNTAfOH+iSyFEBWQ/bKERtVdoaxO/VihiMCQjY+fFgGXX6jArbSmygGyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soBIql9A/uH2Fo+8jKqvwtSUSF3Oqprn2/eqpup8RuQ=;
 b=oXPtyKAg0FuKwsAuh++wFyqClpkkGiLElVj0+PuGwV6kK9/DAeMGQodn9lmbqHxExtD95mMnjVl89w+O6ZNKaGQpY2JYJq+zTc/E04KX5X6hloKP7FLHjFR/tL4nd67RqfrfMbeQIza8V+k2jeQ4y6PEY3zq/7p8KZxfiYDMkg/++fPo71kXqW/STSCXcaSQowBm/XfOvAbP0n4BO9TwRJWJUvVj++zF18GFDSqpyEhiagjN/oU/8Rwn9yqcJ1lhd8KySvEDL4YUidSutNQ/dNQW2pYKjWHG2egmYAxWsMQPhZGPeRJqZdXECvl0FZe8FCUmlxbIWacBsQDjWDVUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soBIql9A/uH2Fo+8jKqvwtSUSF3Oqprn2/eqpup8RuQ=;
 b=suTlGHCoowtBUQ2IJUC8EBHmDY9s31XdNaY/H7DZ/OZap474+Le/crH3cUiCAFatcgZhjfl39z91YEJ/+7NmZDsKKyMjOIDhSmi1qiC6fIltzIShNwtf6FKozOTd5wVeuIeSkT9SVVth+RZjnGV5XQ6NxvQL9xi61udH6C5103HIXwcal+HFJGjqorAwAmMEl/gMVY+M26gMBs3ieM8R7OwvOrfmdvsAy2+R2c1JWYd9tSyge6tEpgVnOtKCVDt1C4iQQdX7aeXXnDuCVqlKYfKY7JskjmRC/UgzB5zNuM6FFrAtZPogbFLTD61qCKnfC4cEsKnDsCCmmsyBPb/dLw==
Received: from BN9PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:fb::19)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 08:12:05 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::90) by BN9PR03CA0044.outlook.office365.com
 (2603:10b6:408:fb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 08:12:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:12:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 00:11:48 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 00:11:45 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <suanmingm@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5/hws: fix strict eCPRI matching
Date: Wed, 11 Nov 2026 10:11:28 +0200
Message-ID: <20261111081128.6924-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 505f8649-f743-4451-53b4-08df3fcb7909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: aydp1/xvWS27clFZdg92MHVC2gZmAt1PaUwKRBpl3pqFHp2Yc72PKcQyuaNjGcajIC0lHQxiK7fGCl0u0guZVjJLTy7eqaFa60OLCC7Bi/1vBMI2vjQqRYD0PppVoVV8Jg9PpB38fUKRnfWvP5H1/SVetdplFj6sWyslDja7BRZiKlk1WT2zBBV1fNYURqN4s5H0Q/otR7XxSlWNUtrh/dc0/Xr/sn0wU1/BnbmiVPHGS9rXaB0MOzhFYz30u1YhIsblDg5oQP3STqh+WjyX1Stkte9baOwpOqfNzOKo9kPYAImMMYFh3PfJ/TbQ3ZHkjpLxSPvTwLOgpNho5VnUm9JHQfOn3ETjCi1gDlRn0I32H+Y7g9mdgqY2GeVshUiQKic731VYZpQtZY7764i37ALqZaPNvmomsQjh09KMzG57+rMkJ1/3W0xwzbE1zZuHRNtOwvprY1s3eOLMtdyHQfJiSlsSVmS2JbCWkvRbyOGUklpsVcwbn8dvsMadR6E3DBnPfGTSktmwX6jejmO3e2UsE//Hr1ReqF0+WmRYxLDiZgWM35w6IJFC7AN/6wsCHzs1efIU9iduqShrRm86Af9VZiM4s63+2baoXBarCzos4ZwdVB57XWwQa6nXesnVsAFLbrh6us018rhhlliBpQH7wQa7JIc+dyY7tXOtYsCAgrpqSdEiA0/qfdrVd6Hd0Hcp9Kxl3d4ndouVwcsuWA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q39ME0hKEC9jQwNC2Iri3mKQBwYgryUAvG10fu3sVHVE3qRB78IOFu1dWFsBSG5llYSFZhasDVnfB/1grDZopdxtoZhXTMZPkRP6I4F5sUFKqRviJS9CvpQ40I5EqNFRDmQuuXfzA+Rc3C+CxPoQTvWGpfgzekRlX4IZobFOvb+Qt24GdNxjDC7hkYWnePEijapAXuPhhHw5mcDp4FVtj9HHNHjdUiJcMU3iRVdQ60xjxqBjbPYz92mOGYgAmBTGH0hZn3ylUVHay5spe2kKfIoQRbPVQPktWrO6ot54NQylhfc89sw7hzwCRTIN+lzzYsIQyAVvo4JlKBmbS7uE8fQhC4+2ZVAaJKN3c+GGoijBDlf9lul15XeyXqY47iQlMquODjlH90aqJAExA7d4GX1p3S8j60zpoWxFMXEWwBffIzPGhw+YnOe/l4qH5k+I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:12:04.9555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505f8649-f743-4451-53b4-08df3fcb7909
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared flex-parser field helper adds implicit ESP protocol and
UDP port matches in strict mode. Typed eCPRI patterns also use this
helper, so Ethernet eCPRI rules acquire an unrelated IP protocol 50
condition and miss their packets. Untyped eCPRI patterns skip the
helper and continue to match.

Remove the ESP-specific conditions from the generic helper and drop
its unused item index argument. Keep the existing strict-mode ESP
matching in the dedicated ESP item converter unchanged.

Fixes: f2f75ffe14a5 ("net/mlx5/hws: fix ESP header match in strict mode")
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 33 +++------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 7400b8f252..c56a53fd67 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -2548,8 +2548,7 @@ mlx5dr_definer_conv_item_meter_color(struct mlx5dr_definer_conv_data *cd,
 
 static struct mlx5dr_definer_fc *
 mlx5dr_definer_get_flex_parser_fc(struct mlx5dr_definer_conv_data *cd,
-				  uint32_t byte_off,
-				  int item_idx)
+				  uint32_t byte_off)
 {
 	uint32_t byte_off_fp7 = MLX5_BYTE_OFF(definer_hl, flex_parser.flex_parser_7);
 	uint32_t byte_off_fp0 = MLX5_BYTE_OFF(definer_hl, flex_parser.flex_parser_0);
@@ -2562,32 +2561,6 @@ mlx5dr_definer_get_flex_parser_fc(struct mlx5dr_definer_conv_data *cd,
 		return NULL;
 	}
 
-	/* To match on ESP we must match on ip_protocol and optionally on l4_dport */
-	if (!cd->relaxed) {
-		bool over_udp;
-
-		fc = &cd->fc[DR_CALC_FNAME(IP_PROTOCOL, false)];
-		over_udp = fc->tag_set == &mlx5dr_definer_udp_protocol_set;
-
-		if (over_udp) {
-			fc = &cd->fc[DR_CALC_FNAME(L4_DPORT, false)];
-			if (!fc->tag_set) {
-				fc->item_idx = item_idx;
-				fc->tag_mask_set = &mlx5dr_definer_ones_set;
-				fc->tag_set = &mlx5dr_definer_ipsec_udp_port_set;
-				DR_CALC_SET(fc, eth_l4, destination_port, false);
-			}
-		} else {
-			fc = &cd->fc[DR_CALC_FNAME(IP_PROTOCOL, false)];
-			if (!fc->tag_set) {
-				fc->item_idx = item_idx;
-				fc->tag_set = &mlx5dr_definer_ipsec_protocol_set;
-				fc->tag_mask_set = &mlx5dr_definer_ones_set;
-				DR_CALC_SET(fc, eth_l3, protocol_next_header, false);
-			}
-		}
-	}
-
 	idx = (byte_off_fp0 - byte_off) / (sizeof(uint32_t));
 	fname += (enum mlx5dr_definer_fname)idx;
 	fc = &cd->fc[fname];
@@ -2639,7 +2612,7 @@ mlx5dr_definer_conv_item_ipv6_routing_ext(struct mlx5dr_definer_conv_data *cd,
 
 	if (m->hdr.next_hdr || m->hdr.type || m->hdr.segments_left) {
 		byte_off = flow_hw_get_srh_flex_parser_byte_off_from_ctx(cd->ctx);
-		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off, item_idx);
+		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off);
 		if (!fc)
 			return rte_errno;
 
@@ -2761,7 +2734,7 @@ mlx5dr_definer_conv_item_ecpri(struct mlx5dr_definer_conv_data *cd,
 		if (!mask)
 			continue;
 		mask = htobe32(mask);
-		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off[i], item_idx);
+		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off[i]);
 		if (!fc)
 			return rte_errno;
 
-- 
2.43.0

