Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A933BC3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 09:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C58740655;
	Mon, 24 Mar 2025 10:34:29 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by mails.dpdk.org (Postfix) with ESMTP id 80CEB402DA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 10:34:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQPE/YI1FK81XBT6OB2g6TN/a9uErRFWRz5ENMxNauR1+jheRYnHwQ247IoLpaGQV+d3asBUFbm2WOQS2s3A1x5BDIAo4fEAojDGWIZqlqQ/uCCIM8bRefQED6W3mQ7DTeDnL+KmCPe171JBJoIjgqt+OvL797bPVouN48nkqrx3voqLrmaDOjM6bO7A9X5GxWRwP+gaLWiW1OBdldFADixN0tcrRzQ/MhNofE7Qo/4D8NtyTFn1bMxcACowh7sTvYQBvr8Lm97F2gjtyBORbkAcnFu6YslAhbBAlRtgH3H54CaEoYy8fZTDF+SZhWiXllfBoAMNKHDQ5zOb4Kor+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lcms1LGKFyFpS077oV/l2UJ/4WaOW/HEij8+4m2tw4=;
 b=tYRiAYwM+j7nO1O1tZZItUj/U0Sjb0pq2Zs3qsPH+jNzwZnxA8FRkxqUOM2wN9pJf6HIdRu7jsD/1NCMXPpUD++6/Krej+pb1RiWNfJH2S/7C9DopgDPnHwLC1fXuGUnv/+/Yt1TwyXRhogBXynxkUZPJzqeur+1qb7W0+Qsk2jn4pgTjYRmuE5bkEdRRDc8oBIxAGfk3ip0zn44T5M6uY17zwv6s5d8ATDL1OBQLluhaMIfYm3nEL5aikg243wLM3F41qZLj3DKVhDTUF2m9kuW/t21KMM2K2qUa/NanitlhPuJujndB20y/oJ/0LKpiarsy2K4iZhKflxoqwVf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lcms1LGKFyFpS077oV/l2UJ/4WaOW/HEij8+4m2tw4=;
 b=gE+NSQEWN9EDrUbzyu+F1S3WfWVH+tOpryTZyLQ4WbQ4AqFMZ4Gdk8DM1UaSybjGanGL8B7I0+Raqi2+riVDREwQ1no5KeSuwiq0n+w/wxbzdlbHOmmThjyOwdUOT5mqBQmwY0BPQUMR2Q3PZdB196g6vafCNIvwagV15MpepDBhuloTyxQ+GKnoCRUeh8DQUoizd7vh+YXWK79l+YJrSFpWQXvPBEFlMCUpG+gO6jWoAVIXqiB35Hk3ldu9e6Wcjdqnh3VMRVm582eK9LFdp6VYUhlcS2ruRJHlbCOLLHBmEFg3K22ILbK+vQfhE8T4sdFhqhxVe9CnH2qeVQU9Vg==
Received: from BL0PR02CA0093.namprd02.prod.outlook.com (2603:10b6:208:51::34)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:34:23 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:51:cafe::55) by BL0PR02CA0093.outlook.office365.com
 (2603:10b6:208:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Mon,
 24 Mar 2025 09:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 09:34:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 02:34:07 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 02:34:04 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>, <stephen@networkplumber.org>, 
 <haijie1@huawei.com>
Subject: [PATCH v3] app/testpmd: fix VLAN header parsing
Date: Mon, 24 Mar 2025 11:33:49 +0200
Message-ID: <20250324093349.26509-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250323122822.90407-1-rasland@nvidia.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 043168f6-ba2e-4f5a-3a27-08dd6ab70f81
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?du+rwW7Ah3MRketakz2KxqDqXpolYxRwi3RWqKZGXkmvDNfCSjkBmcXDMF6/?=
 =?us-ascii?Q?zYuHpwhtU/6r+JrBGhye7IAvlpTkyXsypxDVrUZwiNuLYgaz0IbOCYz+BJ62?=
 =?us-ascii?Q?BdiXUp2Rf5HvtUq/9FbwS2tiRT7Dz9L0GUuswfsjyZjhAGR83cpj9xRO0z49?=
 =?us-ascii?Q?VXyTpEm6nCvfyGhwB0UG1vvbblVoQI2aF3vcvBlNBlD16gzwmEBVmxNdk+GJ?=
 =?us-ascii?Q?y80eyP737pZYt6sk69lg49K+X5J/yMqlscU+F7jEI+G/OemkX0PywNfvpJHd?=
 =?us-ascii?Q?Lxy80DT6GzMaKVuTaoz/ur5upsak6u3I5ahZiOcIngEfOaZOhOuh+FXqF5Fg?=
 =?us-ascii?Q?/RuylwUc2RGLTOETsyH9/UEC2UxATguUut3oZ8ARKDnwQRoJCBF0H/kfN3v3?=
 =?us-ascii?Q?I+YdlU3sdZfQ3QawM8Gy7pkc92gsToOgqiCoTD6OQYCwV2F1dwwsNxAU+qxz?=
 =?us-ascii?Q?vY8u1TPJekMIyzlHSFscTK0rt4c5F6MTCvIw6i0PfM/EuQELIbTiyeMZeLUh?=
 =?us-ascii?Q?yUe4lYkwugXRAb8CSjHp1GFFfGpPeUeYD9iEaJAJqgq2asx6pOgDR3HlEBMm?=
 =?us-ascii?Q?KRRruPcx6mooA4eIKJr2pNzYYl/tNfG8JtsrL6jTX/AVfGfRiQlhBQK/lw6c?=
 =?us-ascii?Q?qjYdVrlvjOgD5oJtUJPHml18VKCBP5V2bMN3pI1zuz3EngSAts0pFsB5mmLd?=
 =?us-ascii?Q?2DXIjA3T31iT9NkNqzbkylEyV+5+rdBDg8TkGTQV+CMP8X9c8DeDus6W9mWR?=
 =?us-ascii?Q?mToSA9lxeNn7qdwFPL9sdXwFNKJNbnw0ezimR5/ECklIEvPBMEO6Igh5Pts9?=
 =?us-ascii?Q?G0rfcDmGD9YMftR/jIdsrHpuo59BPQVR46zvsu5cOCkiJ6fctGZ0Mt3Pk+DI?=
 =?us-ascii?Q?yrb4mTLqfy13VqUROzqlxjZvUN81x6m2U0+LiWRF09rOPyKxwwDxkTbPGmt4?=
 =?us-ascii?Q?D8IywenfUh4yy/CiIw6L3V/QRJfsHaHhWqeH8aG9EFDeWgFFlnrnLlf9kcaw?=
 =?us-ascii?Q?hlEb6pJWt3Y8w2o9dRRVP08GQJkdh6sNJydoa8OZqP7WsDXDsrtNrkRQFH56?=
 =?us-ascii?Q?r4SRSVPYt08Q2dgXe4qSqmxE+4dWp+r3NI7FGiH7+roEjCyjX5GyXPWmvsOJ?=
 =?us-ascii?Q?G09D81fVuM+IYOJwjvi6jeIBD3uh9aLXmNZZT902g6CJFvYp4dUDTDwRIX7I?=
 =?us-ascii?Q?SqxJhg/IiV5FaaY226hp97p9H9HPKDy83MyEK6gSWgN5vTU3vbR/G7o/dZPY?=
 =?us-ascii?Q?X6IhfX/wAnAVJieyGtcHeyTXAvxwkgFxJXw/uXH4l00wTNQZ1T5atrXwa4pQ?=
 =?us-ascii?Q?vEitJPCws4UH5pnX3Nlcyb3zzIuWYuilQvxQupNHjtVYq5GFNF/OKIhsu7cX?=
 =?us-ascii?Q?0VPmo0bU1jYpOO7pUfY6EUNGQ/rCVt1HJ5D763jwzdyV73q1IdqOWYfK1vRG?=
 =?us-ascii?Q?dfaWNXy/NoxotOx3X8zprFXQqX/TXEHvbuigqvqfeNwk26pDPpo3HQEwzeZv?=
 =?us-ascii?Q?itRz+oRCE7ED+3E=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:34:22.6133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043168f6-ba2e-4f5a-3a27-08dd6ab70f81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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

When processing VLAN or QinQ packets, an infinite loop occurred,
preventing the csum forward engine from proceeding and causing
testpmd to hang during shutdown attempts.

Updated the `get_ethertype_by_ptype` function to correctly parse
VLAN headers.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: haijie1@huawei.com

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
v3: fixed wrong indentation
    add boundaries check for 8 VLANs at max
 
v2: update commit log
    fixed pointer handling to actually move the pointer
---
 app/test-pmd/csumonly.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index 5b906eaa53..710967ca4d 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -59,6 +59,8 @@
 #define GRE_SUPPORTED_FIELDS	(GRE_CHECKSUM_PRESENT | GRE_KEY_PRESENT |\
 				 GRE_SEQUENCE_PRESENT)
 
+#define MAX_VLAN_HEADERS 8
+
 /* We cannot use rte_cpu_to_be_16() on a constant in a switch/case */
 #if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
 #define _htons(x) ((uint16_t)((((x) & 0x00ffU) << 8) | (((x) & 0xff00U) >> 8)))
@@ -466,9 +468,10 @@ pkts_ip_csum_recalc(struct rte_mbuf **pkts_burst, const uint16_t nb_pkts, uint64
 static uint32_t
 get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
 {
-	struct rte_vlan_hdr *vlan_hdr;
+	struct rte_vlan_hdr *vlan_hdr, *max_vlans;
 	uint16_t ethertype;
 
+
 	switch (ptype) {
 	case RTE_PTYPE_L3_IPV4:
 	case RTE_PTYPE_L3_IPV4_EXT:
@@ -486,10 +489,13 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
 		return _htons(RTE_ETHER_TYPE_IPV6);
 	default:
 		ethertype = eth_hdr->ether_type;
-		while (eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_VLAN) ||
-			eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_QINQ)) {
-			vlan_hdr = (struct rte_vlan_hdr *)
-				((char *)eth_hdr + sizeof(*eth_hdr));
+		vlan_hdr = (struct rte_vlan_hdr *) RTE_PTR_ADD(eth_hdr,
+					offsetof(struct rte_ether_hdr, ether_type));
+		max_vlans = vlan_hdr + MAX_VLAN_HEADERS;
+		while (((ethertype == _htons(RTE_ETHER_TYPE_VLAN) ||
+			ethertype == _htons(RTE_ETHER_TYPE_QINQ))) &&
+			vlan_hdr < max_vlans) {
+			vlan_hdr++;
 			ethertype = vlan_hdr->eth_proto;
 		}
 		return ethertype;
-- 
2.39.5 (Apple Git-154)

