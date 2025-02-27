Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF1C021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 10:50:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0899740A7D;
	Thu, 27 Feb 2025 11:50:05 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by mails.dpdk.org (Postfix) with ESMTP id 3EAAC4064F;
 Thu, 27 Feb 2025 11:50:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ1n6aqjhBYs6aga7agWVKiKZFtHi6r7qAM1HBWFIRSODWuollwSDkgKquHokKcOr3PK/RtT+h1Uasl3EDoAnDRYmT6kdXwIWVokCTjm61sXW2OAbxeqTifwun5pzPryq+/3EGY+Ee7abGS4k76cqT58QVkyyc3oCH7XYKj7shM7I3Oa1sl/ZyjxCK5IL/ecy7fn4A8FmaZ4ERhJcinfsd24BbEmg8IxdTsIU0M3zF/Pc8HjhQpq8mpbZ6mKbvace5apHROsrH8kaiIAB9oXGRSvPPaeEyLpm8pbSwJLtN9ppgzy3NInVDZtk7t8KApxgFM51ycZcuC1e69H35v2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAnd+7wJoDvnsiKZMFzLWYCR/aCdoxYiqrSqXE/jXdE=;
 b=qreu80hDeQ6GTUJ4CtYjnjVccNha5qZOBvAnk5PEHZtrp+ApaRKA9f8zCUXEbjoeouqblCtRSovhlXZf37kcHL6z1bFIdRDpf9aymLGi3WPkJu6sXHhC+xMk/0tFmKvoBe0DHP/Ya58K+J1BHEMeOmnECQ4z/Kgp5HTOF8OyW842d1Pk4pRQKM+q9Dr6kEWLZlFb6JnLsfmdTqrSyDbjHMKUw+U9G+v7l5JySkRdpOHD0jOTvvyjBhyvYir9j8ZBtdVXozbSbuw7lqVyiTpWf/m+EXTKTlXm0ThTeD3awUzzcafIOMWVfh1wPig72FXcvkr9cvbn2+J5osVkbwO0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAnd+7wJoDvnsiKZMFzLWYCR/aCdoxYiqrSqXE/jXdE=;
 b=iGT3qq/jfrQS5DqiFUskTOqGIhq9W7Uqgw1Dzejg9htEMgLBqD0yjaUxjnuX7WTb4glPQcySwZv+dMgXLQ9Qxtz55s+3W94rhShc6rwwXdSRl3R55SXIWJgSaDqEHhMDveBB4fexXAxrz+bQLkb8rMvJGVy+i8YDnnWtglMgBDlqmLISdh0c6ikL1C/y+1/0WXMp+o4JtLDbuOEGcJlqBV51lSgDQP2ZQ+9+mKtiuK4l3fNFuE7ySZtGm2WoTBxsOiQvwheffIV3RkLhjxM6W5cQa1OwC5IqbHADcKZ5EzJirMhvUn15F9b240l4GL3o64aTF4Bh9VZlnXwP5S2uwQ==
Received: from DS7PR03CA0338.namprd03.prod.outlook.com (2603:10b6:8:55::31) by
 PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Thu, 27 Feb 2025 10:49:58 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::c9) by DS7PR03CA0338.outlook.office365.com
 (2603:10b6:8:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 10:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:49:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 02:49:48 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 02:49:48 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 02:49:45 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alex Vesker
 <valex@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH] net/mlx5: fix GTP flags matching
Date: Thu, 27 Feb 2025 12:49:40 +0200
Message-ID: <20250227104941.93927-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7568548c-919b-4e75-96e9-08dd571c7a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+bRZjkwLl596QJjJPkOeDVV2VZPxKZzlSA23oBoDZO+TM9Kp5Ceo28VNrhav?=
 =?us-ascii?Q?KZ6VFgww1mjSNydy5M/rpmXKrNI1KpecOjZn4jXHKboJaId9BDlL7F31TXrL?=
 =?us-ascii?Q?vmBiAZilqV7VXPczqdoDiEQnWDLxLLIbjnSECp0E6WNuNaLpOsif3L3npqBU?=
 =?us-ascii?Q?4QYu0NeQwymPB2ksUzXyWn4wGp8jJlIHEWQeCFOWwXH5iS0n552yucyrDWA0?=
 =?us-ascii?Q?VLBPdbx1x20VfTLrJIULPPsLDFdw/xGgvJl/27wuXtblQ4YVrPaxIp2EbImy?=
 =?us-ascii?Q?Ci8XSFbLkyXBD5xJVT+I82dFuEuFfJhjceL8cOgK2kOqE9TjzNRcDt+cbH5o?=
 =?us-ascii?Q?boMmnzS98Cp8lNSir69fE5Q/0GdXBoVechrJP+y8rCtaxBKPzH4tnMh+wt+t?=
 =?us-ascii?Q?q7t/88IgW/tjYf151xo9bD/1QRgKzK1W/w/EXOM51K2c38AAv+yyLnlvVF2j?=
 =?us-ascii?Q?ZsoxJ/Hriuzwd9WwO6L5PdiFAdqLbIWkh2GyC+3s0bfi7Jm4Lnl36ITgOYTz?=
 =?us-ascii?Q?MX+/qY6o4G0bmMhwgEtO/lmOVcuf0HXrIhsN2OLwyFZ1av9wAPxx8MojhZiz?=
 =?us-ascii?Q?1XGviPcJT3RDarcOJgYL4IcoX/CTGbKQOU4VA1uUWb4zreIUaM0vne9PxOYV?=
 =?us-ascii?Q?AsqgFatvKU9YYuo5276eTP6dx+NBG1Evr/nX8GkGls13B7kMyfzPrvmpZfKq?=
 =?us-ascii?Q?3lBku4ttkW3AoHMLzTt/PY4qrQqhKP9GvsWjxe//wPmHf7UKeA79sKDMXw7d?=
 =?us-ascii?Q?xjIh1VqI5g4H7oWLlKtvcpgY9s8F3sXv/U2474FpPjd74PEK1NA6lW5NTnUd?=
 =?us-ascii?Q?8XPKSnJgFr1tQqRPu3ab8XOQJPqzwM0/xAyV4UqnXrv96dW9JbXmP7oda+IX?=
 =?us-ascii?Q?LJqRQ78c8U0lDUBTG/pUbpsm6rvdWE/2cJW8VosCXoi7OR26tAQC7k6t6Rl+?=
 =?us-ascii?Q?9qs6pZaBa0ZdWwT8mPXcA6cQmCkwofivkb4anzJO40yzM75NA6gj3UXR+Bi8?=
 =?us-ascii?Q?o4iglE3IUe1O9pZcdfj4VRxgWTPIB2F48871gOjGKKYk+hSzXiD9+X04FueV?=
 =?us-ascii?Q?51+ODweAVvlW1VZ4CQ9yw2Q9G9xK6mfuyn9yC7BSAHrTzMY8KlcO7kd9pRWG?=
 =?us-ascii?Q?B2BbsFwS6vAVk9B7UUKChWuMcphlfuB62PInvrxs3ZAPmIjLpPC+G31hxz6b?=
 =?us-ascii?Q?kHwveWo2lfy3UqJR4mFqV58zf1jquv8J/djGNbrj5Dj7Z/IXhzUFdNHoy6Xw?=
 =?us-ascii?Q?1lWryNi8jnvORBtR7vCVVg92s2niA5CIqxaRC2Pawoyg0BRgliu5O7Ncvlyq?=
 =?us-ascii?Q?XzElSYyGqjwi9KfjBzfKsC7UU2txM97GLlsGATVFPnprjIWIaGu1oWhiRNtW?=
 =?us-ascii?Q?FHNgFEQc7qSViV32giDpnwwd6afptIFS/8g0ocqRJ39Ep+nRnkdws90WGsVz?=
 =?us-ascii?Q?ORUn9Rb5eFXxQpIPA7tE2lwjsP+sFFf9Yo2epgKbsTQfo2Oo43wvIqps70po?=
 =?us-ascii?Q?5TeBCsveKAvaqiE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:49:57.7022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7568548c-919b-4e75-96e9-08dd571c7a43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
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

Support gtp flags in non template on top of HWS.
Currently, only extension flag was supported,
Added support to all bits under v_pt_rsv_flags.

Fixes: c55c2bf35333 ("net/mlx5/hws: add definer layer")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 12 ++++++------
 drivers/net/mlx5/hws/mlx5dr_definer.h | 18 ++++++++++++------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 98d670fc1ce..d7799888b1f 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -199,7 +199,7 @@ struct mlx5dr_definer_conv_data {
 	X(SET,		gtp_udp_port,		UDP_GTPU_PORT,		rte_flow_item_gtp) \
 	X(SET_BE32,	gtp_teid,		v->hdr.teid,		rte_flow_item_gtp) \
 	X(SET,		gtp_msg_type,		v->hdr.msg_type,	rte_flow_item_gtp) \
-	X(SET,		gtp_ext_flag,		!!v->hdr.gtp_hdr_info,	rte_flow_item_gtp) \
+	X(SET,		gtp_flags,		v->hdr.gtp_hdr_info,	rte_flow_item_gtp) \
 	X(SET,		gtp_next_ext_hdr,	GTP_PDU_SC,		rte_flow_item_gtp_psc) \
 	X(SET,		gtp_ext_hdr_pdu,	v->hdr.type,		rte_flow_item_gtp_psc) \
 	X(SET,		gtp_ext_hdr_qfi,	v->hdr.qfi,		rte_flow_item_gtp_psc) \
@@ -1462,7 +1462,7 @@ mlx5dr_definer_conv_item_gtp(struct mlx5dr_definer_conv_data *cd,
 	if (!m)
 		return 0;
 
-	if (m->hdr.plen || m->hdr.gtp_hdr_info & ~MLX5DR_DEFINER_GTP_EXT_HDR_BIT) {
+	if (m->msg_len) {
 		rte_errno = ENOTSUP;
 		return rte_errno;
 	}
@@ -1484,11 +1484,11 @@ mlx5dr_definer_conv_item_gtp(struct mlx5dr_definer_conv_data *cd,
 			rte_errno = ENOTSUP;
 			return rte_errno;
 		}
-		fc = &cd->fc[MLX5DR_DEFINER_FNAME_GTP_EXT_FLAG];
+		fc = &cd->fc[MLX5DR_DEFINER_FNAME_GTP_FLAGS];
 		fc->item_idx = item_idx;
-		fc->tag_set = &mlx5dr_definer_gtp_ext_flag_set;
-		fc->bit_mask = __mlx5_mask(header_gtp, ext_hdr_flag);
-		fc->bit_off = __mlx5_dw_bit_off(header_gtp, ext_hdr_flag);
+		fc->tag_set = &mlx5dr_definer_gtp_flags_set;
+		fc->bit_mask = __mlx5_mask(header_gtp, v_pt_rsv_flags);
+		fc->bit_off = __mlx5_dw_bit_off(header_gtp, v_pt_rsv_flags);
 		fc->byte_off = caps->format_select_gtpu_dw_0 * DW_SIZE;
 	}
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.h b/drivers/net/mlx5/hws/mlx5dr_definer.h
index 092b1b3b10e..d0c99399ae5 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.h
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.h
@@ -110,6 +110,7 @@ enum mlx5dr_definer_fname {
 	MLX5DR_DEFINER_FNAME_GTP_TEID,
 	MLX5DR_DEFINER_FNAME_GTP_MSG_TYPE,
 	MLX5DR_DEFINER_FNAME_GTP_EXT_FLAG,
+	MLX5DR_DEFINER_FNAME_GTP_FLAGS,
 	MLX5DR_DEFINER_FNAME_GTP_NEXT_EXT_HDR,
 	MLX5DR_DEFINER_FNAME_GTP_EXT_HDR_PDU,
 	MLX5DR_DEFINER_FNAME_GTP_EXT_HDR_QFI,
@@ -606,12 +607,17 @@ enum mlx5dr_definer_gtp {
 };
 
 struct mlx5_ifc_header_gtp_bits {
-	u8 version[0x3];
-	u8 proto_type[0x1];
-	u8 reserved1[0x1];
-	u8 ext_hdr_flag[0x1];
-	u8 seq_num_flag[0x1];
-	u8 pdu_flag[0x1];
+	union {
+		 u8 v_pt_rsv_flags[0x8];
+		struct {
+			u8 version[0x3];
+			u8 proto_type[0x1];
+			u8 reserved1[0x1];
+			u8 ext_hdr_flag[0x1];
+			u8 seq_num_flag[0x1];
+			u8 pdu_flag[0x1];
+		};
+	};
 	u8 msg_type[0x8];
 	u8 msg_len[0x8];
 	u8 teid[0x20];
-- 
2.21.0

