Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF4C87FDA
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 05:06:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31BA940264;
	Mon,  4 Aug 2025 07:06:13 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by mails.dpdk.org (Postfix) with ESMTP id 3C8EC400D5;
 Mon,  4 Aug 2025 07:06:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+yTsanREgtHDheNd0RsjTpcPat76p9dfXOeLgAc+mnz+0cFRdOTHw957pD7YyPTIBWIZKNyi9RDePeu/WY2RiY8UtjHEvPk2zHnLBzsxBkkqCJegFFB+oeeZcP/rgZ9v0gzrAep5UbtZxTt51GL/xh0r3HYu0wK8Bv7QdYUcSVyipVR8KzNWurugeBRK1dQTeNAOe21/R/D9HTgFdStG87VBiCHPg9t0TDINMDsxixtdO2mjX4AHKkfoT+KGehrtWoTYx41O0DaviCleXjvO9rqsvt+gJJhH3FCDiB2NFX02uMGZb6vsMry0L4QLPGvQdGYyx7/3Q2g5xZ5X3cNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szTae1XNI18R+KazyOsIjuMwBohu8KhCVaCe1G7HwDc=;
 b=dFd1NnMu73rwLRvC8sPxhu18cq5qHsPgvPDfj0xIaOVOGmNzz51Z9L7I5LaouBWU/twdKrVH87NMZP1dMHuWFBViKrzuMScMt7vUPQozsj9cxYkbsRSkso1qTQanlKWqcf3M1VRwIAVFwZq7Ron+AyPPHuhyrTyoTigqoTa1lg+8buLk7vkW/N2ZyG3Px7KDOoDV0qF8eDfEIe7LtecolsDAVu3VlKQHXZ6c87lCaOUVvqy4viF7cmAWzmXRlGrwN8NjgEYaDLR2m1R3wYOq3isCv388ead7aSS7b1IRb+g6zjstb+lnbeeMtNpHgO+DDVTsyX6HEdCjw4YNPt75tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szTae1XNI18R+KazyOsIjuMwBohu8KhCVaCe1G7HwDc=;
 b=pk9U8pF7YbQ9cAtsKy1lT+ef5WY3R4QW5alIBXly1mSq70KfN9v9YQR4FvMdUzBCvZJWpaLnFizwefDO9FnXqV+f7uJGj16ogtj3TNlEKUSCRfZxTfeSk5UbiMfb++ASjTHrK8tfvsZaNJjWiwr0Y9kO+GbKpqjb1RLG4x2cq+PoLdT2+CV+YfUGMG9wM7VT3cr88cB8v2TqdGLwzhNgRfk5Qu4ILQyQWd5BtzKTc8CXCY4vSUeQtl+Taa/exyWKAcXVv++VLN2rWrJfj068qpMAKpgYAbyCfhEWQkqx2H6PAOAMWbGTVbGNMB5igRdu9h9UsNkJCF5z1FddNmdEmA==
Received: from MN2PR19CA0047.namprd19.prod.outlook.com (2603:10b6:208:19b::24)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 4 Aug 2025 05:06:07 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::b) by MN2PR19CA0047.outlook.office365.com
 (2603:10b6:208:19b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Mon,
 4 Aug 2025 05:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 05:06:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 3 Aug
 2025 22:05:34 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 3 Aug
 2025 22:05:32 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5/hws: fix ESP header match in strict mode
Date: Mon, 4 Aug 2025 08:05:14 +0300
Message-ID: <20250804050514.244896-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ea5b2b-a975-4985-ceae-08ddd3149e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NtyPaNwfx89ukerpPFnniylRR1JPEO8ZTa4fYRcwZhdncW+CU/IhfFodAcl+?=
 =?us-ascii?Q?2n1h2EAXoH36HU0LsdEHL3x3Pe2gsdhUgEj9/SIatK1LimeBa+6Kq0XTgKff?=
 =?us-ascii?Q?8IV0d22xBaDcGwJwOex2aYMnLr/KhX2LHUZn4t8BX2I+wcj+9dK92TOuNbIj?=
 =?us-ascii?Q?Pql0TKst+jcfnPfsqfZdXzspoLWeGY5OX2stGTSsgjD+MV4kEB8L7s2OfuZM?=
 =?us-ascii?Q?MW/YWS8kqnUbWtsOS3FRkqJCG8dDaMw2P9SJ6BQhPZZkNUG4th6n0ayjDF2B?=
 =?us-ascii?Q?NiMo9Mn7pwq13pmdok3G7X5wA5X5MGCyt3TvRQmdZxxT68MGUP+9soD9jWJ7?=
 =?us-ascii?Q?xdOfZ/8g1Ft9auUP0JemhvFqNidwIN2g7ElzZOvtfgETS7H2oYvZcGdIhiVv?=
 =?us-ascii?Q?4ZlDqvdfcY2rm+44lOiCY9thicQ/WWSKWRb31Ui/vr2o2czYWv62WdcDK7Uf?=
 =?us-ascii?Q?/NadTk7VHcXFkKmlS626UBBTrMomH0WktjysnXymlPqSV5QJ4SjfLyg2WXut?=
 =?us-ascii?Q?MBVUZiKWiS5LysqdJKvBUYsza9zd1RXVtHZzErzNtf5L8mQxOJ2fGaCxvNWv?=
 =?us-ascii?Q?I8m1fFYVKN+qgJymhYgLr6U4l35rANXahSVmbhucoG237dasleeVPym/EMUt?=
 =?us-ascii?Q?FAxz7Yz8sY99kurb7STr/YoKP8cwrdgdEjjl6Po8Xupf1P6vz20OvWfNLZ/O?=
 =?us-ascii?Q?LPQGCNlohUDxXjtH6j8v1kybBtQo5Kp/pcdwpZNs9vZ4MwEkQUsQPoe9x97K?=
 =?us-ascii?Q?5kJVrZ69jqee87mXgnUXxoW7Dgc2Fy0TuxmvZPBFt66vgo1+ULCMqdjnc6cs?=
 =?us-ascii?Q?R3IIn/dSuc/hzu259XlV/1Rth/W5PkHK2Va8c1fS91Lpoh6YNXzdWE6CYti6?=
 =?us-ascii?Q?oTd5bJL5cJFZGwm0Vlrha12rAtD1pP8gsMKGBlo+GH3+jfU1m2wvRbSLtogF?=
 =?us-ascii?Q?aq3AiiA1VEzTO8dNZ5fWcL/Rw8OAXRuWRViLbKvNgt6ckHUBvlETU1Tertti?=
 =?us-ascii?Q?Vom2WY7asYftiA6mKw21H1k98kzvblu2vxPkQXmcdJTtWo6Y/K07tI4SrGWA?=
 =?us-ascii?Q?97RiUAvIxPqk6RR0uoqy8GMnBAVwreLIxDTYwNRSQIysUCFof+E+wUPhZAm8?=
 =?us-ascii?Q?As4whmSU/FjcEKy9ASEeVj6O5r1TnVdd5iGbx3dKxehjJBE8rkBZZ2s5jFRi?=
 =?us-ascii?Q?bhbMe982zGDHU0qWEK6Qht7u0Kyx8k04Dld3H79tywujRfsESq0njVzYSXwV?=
 =?us-ascii?Q?tjbS6YUs5EQS6d9z9HKXZbnwy5g88mcVsAkXv1Lf6Jtc7QIIt+cql9k/PVk3?=
 =?us-ascii?Q?wm3a6/jarW0z6XSBPNxwocbZgtLhmhUhHdoOJH3VjUet1NggmPTg/RVFfYz5?=
 =?us-ascii?Q?RLOwK905WdeK5ZuYJ/RV9t4Nf2BQiplTb3Ddyypnrvx292IlWeqVf97wanHA?=
 =?us-ascii?Q?2osc2E5SPBGjeCCf8p9ZObCbbrw6uG9l9CfTTsLquC/O1UBR5mjR8WMU/8rU?=
 =?us-ascii?Q?2EwQJW+HbKRLnfKxiqsq+LRYP71Zmgx+f+1o?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 05:06:05.9820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ea5b2b-a975-4985-ceae-08ddd3149e32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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

The pattern like "eth / ipv6 / esp / end" matched on any IPv6
packet in strict mode, because there was no impicit match on the
IP.proto forced.

This patch adds the implicit match on IP.proto with value 50 (ESP)
and adds implicit match on UDP.dport with value 4500 for the case
ESP over UDP.

Fixes: 18ca4a4ec73a ("net/mlx5: support ESP SPI match and RSS hash")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 38 ++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 7464d95373..113feae291 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -14,6 +14,7 @@
 #define UDP_VXLAN_PORT	4789
 #define UDP_VXLAN_GPE_PORT	4790
 #define UDP_GTPU_PORT	2152
+#define UDP_ESP_PORT	4500
 #define UDP_PORT_MPLS	6635
 #define UDP_GENEVE_PORT 6081
 #define UDP_ROCEV2_PORT	4791
@@ -231,6 +232,8 @@ struct mlx5dr_definer_conv_data {
 	X(SET_BE16,	nvgre_protocol,		v->protocol,		rte_flow_item_nvgre) \
 	X(SET_BE32P,	nvgre_dw1,		&v->tni[0],		rte_flow_item_nvgre) \
 	X(SET,		meter_color,		rte_col_2_mlx5_col(v->color),	rte_flow_item_meter_color) \
+	X(SET,		ipsec_protocol,		IPPROTO_ESP,		rte_flow_item_esp) \
+	X(SET,		ipsec_udp_port,		UDP_ESP_PORT,		rte_flow_item_esp) \
 	X(SET_BE32,     ipsec_spi,              v->hdr.spi,             rte_flow_item_esp) \
 	X(SET_BE32,     ipsec_sequence_number,  v->hdr.seq,             rte_flow_item_esp) \
 	X(SET,		ib_l4_udp_port,		UDP_ROCEV2_PORT,	rte_flow_item_ib_bth) \
@@ -2481,7 +2484,9 @@ mlx5dr_definer_conv_item_meter_color(struct mlx5dr_definer_conv_data *cd,
 }
 
 static struct mlx5dr_definer_fc *
-mlx5dr_definer_get_flex_parser_fc(struct mlx5dr_definer_conv_data *cd, uint32_t byte_off)
+mlx5dr_definer_get_flex_parser_fc(struct mlx5dr_definer_conv_data *cd,
+				  uint32_t byte_off,
+				  int item_idx)
 {
 	uint32_t byte_off_fp7 = MLX5_BYTE_OFF(definer_hl, flex_parser.flex_parser_7);
 	uint32_t byte_off_fp0 = MLX5_BYTE_OFF(definer_hl, flex_parser.flex_parser_0);
@@ -2493,6 +2498,33 @@ mlx5dr_definer_get_flex_parser_fc(struct mlx5dr_definer_conv_data *cd, uint32_t
 		rte_errno = EINVAL;
 		return NULL;
 	}
+
+	/* To match on ESP we must match on ip_protocol and optionally on l4_dport */
+	if (!cd->relaxed) {
+		bool over_udp;
+
+		fc = &cd->fc[DR_CALC_FNAME(IP_PROTOCOL, false)];
+		over_udp = fc->tag_set == &mlx5dr_definer_udp_protocol_set;
+
+		if (over_udp) {
+			fc = &cd->fc[DR_CALC_FNAME(L4_DPORT, false)];
+			if (!fc->tag_set) {
+				fc->item_idx = item_idx;
+				fc->tag_mask_set = &mlx5dr_definer_ones_set;
+				fc->tag_set = &mlx5dr_definer_ipsec_udp_port_set;
+				DR_CALC_SET(fc, eth_l4, destination_port, false);
+			}
+		} else {
+			fc = &cd->fc[DR_CALC_FNAME(IP_PROTOCOL, false)];
+			if (!fc->tag_set) {
+				fc->item_idx = item_idx;
+				fc->tag_set = &mlx5dr_definer_ipsec_protocol_set;
+				fc->tag_mask_set = &mlx5dr_definer_ones_set;
+				DR_CALC_SET(fc, eth_l3, protocol_next_header, false);
+			}
+		}
+	}
+
 	idx = (byte_off_fp0 - byte_off) / (sizeof(uint32_t));
 	fname += (enum mlx5dr_definer_fname)idx;
 	fc = &cd->fc[fname];
@@ -2544,7 +2576,7 @@ mlx5dr_definer_conv_item_ipv6_routing_ext(struct mlx5dr_definer_conv_data *cd,
 
 	if (m->hdr.next_hdr || m->hdr.type || m->hdr.segments_left) {
 		byte_off = flow_hw_get_srh_flex_parser_byte_off_from_ctx(cd->ctx);
-		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off);
+		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off, item_idx);
 		if (!fc)
 			return rte_errno;
 
@@ -2666,7 +2698,7 @@ mlx5dr_definer_conv_item_ecpri(struct mlx5dr_definer_conv_data *cd,
 		if (!mask)
 			continue;
 		mask = htobe32(mask);
-		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off[i]);
+		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off[i], item_idx);
 		if (!fc)
 			return rte_errno;
 
-- 
2.34.1

