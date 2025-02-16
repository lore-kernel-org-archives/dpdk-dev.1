Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B3C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 11:05:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DC444065F;
	Sun, 16 Feb 2025 12:05:02 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by mails.dpdk.org (Postfix) with ESMTP id 97C1C402DF
 for <dev@dpdk.org>; Sun, 16 Feb 2025 12:05:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kqw9ii3vP10LLvgEWpBiWo0TLEvJ1tZQuDAps0bCb9hO9hW2fiuorl7tuKXBrvkjDP0b7Lzm4+CnmTiTrXjeYKEN19LuiKVmVQj9myRrCW9XqB8Y8cL6PIJHveyv56R7QxSyDi4HGKGHz7l2ABRaxGEvC55Rt32fHMuhNJivGEhzS7af8aA+Di6AC8ycA/jYH5wI2JHE7d4Y4RKgBcW6BloKj+Igcld7CMXxPR07MQSAeCpGnW0XHxHinYDFGhSQvJgSfesMpCGUCSUkqZ6qYWfHzG8IuEVJrQySX9rXjmuBM9MMJ4HD3Ub3/GfJjSJIQ9PdMTaTjxi0ycu0aBXwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAyYxa8s+XWcFeR7yTfkb6DKGop1HxFPfMXos8ABumM=;
 b=Snyx2kjt2YeuwV/VpYDOCFS/hMxBuV4kD8npgyQiniXek/8zmPCSS4+IwFxh6jFeJ9gx2bN14aEjkKPP4jJnesBmYrrCwvIuf/fha7Zl+AfMBjjgldVMAbXMd/lLQi8uWwbkBctxhkHBRhhN9xxpXrkiSRcj4om8isH5iA0daR0zVKm7L/vFB1I/uy5248hURjZA8DyRCxjWZ3lyCfbLnhJjslriqwtZqEwNJxkXEdlfU+vv/ORvyCXMFMEpemZCpFVKBQyZbOAlhcukrTTlN8iv6CxNeJNWMSR8+Tcb+MOnB+VViXLmPI5UiOLmBbtk7WN2TcmSqhjhoGNjJUg6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAyYxa8s+XWcFeR7yTfkb6DKGop1HxFPfMXos8ABumM=;
 b=i8H3rN4j5bwktFI8keQ7qjzDsHhVvenZG7KmOUF86VXxI7bIPVFtlkWNZO9KyrBSi7PyAGpXDZVKxdjyJl2xbGxZrSuurJ9Eoa4BPQv5OF4Cbl21N707wXAnsm4dIl+KO2u6/wtGthU7kQxJzsN6x0kvJZ4IcWaNlyIW59sWid8W2fUw4RpEyRYUiz1bP4S7LyDVnuTTWwOXOui+aydHxyiTPXJsZf1F2uQaKW4Rr5Z7HizW3c9+krqmi9JdFrvGMcJj/vV/3FG/i+VSKZ0yLVHQvAa8/TfivEuac+nHbudUKp0X5KyxVmCvZaA1DeNFAVUQ0gDoxel2mdStG41iYw==
Received: from BY5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:180::36)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 11:04:55 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::76) by BY5PR13CA0023.outlook.office365.com
 (2603:10b6:a03:180::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.9 via Frontend Transport; Sun,
 16 Feb 2025 11:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 11:04:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 03:04:40 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 03:04:37 -0800
From: Hamdan Igbaria <hamdani@nvidia.com>
To: <hamdani@nvidia.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 <suanmingm@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH 1/8] net/mlx5/hws: introduce capability for unified mode
Date: Sun, 16 Feb 2025 13:04:07 +0200
Message-ID: <20250216110414.10926-1-hamdani@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c2c679-b16f-4467-29b8-08dd4e79be4c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3hzwamIlLugF/ZviXbiEPmgpNwpDAeiuslzITskxL2kQIIFkstpFbX1AkNrW?=
 =?us-ascii?Q?yMgogZEOjLhiHOFjZkpE6P9Q+Dm/3tRQu/xyf+lpfbFrdgiOSghyyUw5AP6V?=
 =?us-ascii?Q?igEMyMln5ucRe21T7ZmtdoALakKW4TId0E1+6q+byCX3zcemDL0kInUmHiQD?=
 =?us-ascii?Q?uvwkm6FU11vNL/F9K3V4gxMFBiVm59iCj5nyQR3X2TYFD/LeP2nvTColX+LU?=
 =?us-ascii?Q?gM77qXlsN0WHYz6imnv5ZFvy6yY1PlimUVXhfHgfUzlzMjf8HgKhp+gqusvo?=
 =?us-ascii?Q?ap782Y6eDymSchXZQtvUgky87ibhYib+0QgzjYDGd6fzkQAkcbeOlNfXXOuI?=
 =?us-ascii?Q?0M01LDRHJscoTPtCVp/wOCoTnnB/mAS76h9nMXgD6n7YuQ0lmChCysqCLr26?=
 =?us-ascii?Q?Iecb9Qr6hOKx5ILlPgXy2lemlNeqfKLw2iKJZYiIPMZ8HlBvqNuTcUyiFgv5?=
 =?us-ascii?Q?iNg8CFJr0tr6A8EbfK8XxYwX3UBnl1ZsWPrCH/DD7d3M8dHSvoK+O/fxRfCP?=
 =?us-ascii?Q?/E3DpHw4Ydztl3nXi8efynF5gR2Tu/JJZoiz8RBCJ6Q89LUBlp/LuPLj3j0+?=
 =?us-ascii?Q?mqxqmkT/f4KC1Cka5IcqOzmo+olIrATk9kTTw8Gy4VMmT3qiBuF4LT6Q/1c+?=
 =?us-ascii?Q?I8otBWqCsg1NB5GHjohLfTN7xPfNv0SSZOydDFSYof60IN1Y+vxbbkYR8jry?=
 =?us-ascii?Q?i2FO+K7rDYWVBwJg+3ODEMvcyZNvVsCn/vnzLWYdm1ZIfX0LDYIEieHpH9JX?=
 =?us-ascii?Q?AYwigZXqBshkSeKLHOh8OPWf7SFURG4PaufOQbJu/w1f6gsMrvdHVL1xno/F?=
 =?us-ascii?Q?QYQGhKzb0mrdgZ6npSUz/GVRQwM9ovqAExaVn7/DcMgcECv+sbSbbY/l/yeG?=
 =?us-ascii?Q?+wRihskb0I7yUxjzF+uS24X407DF0pKsW19Q7UOT5F3Viy5bqrPnAVWQjGCp?=
 =?us-ascii?Q?+CvSrFr9XV0+GZgBhUWJTaGpT5jrGSJsqskNYOQK21BgPqtCJ2FhqtiNMCss?=
 =?us-ascii?Q?MguNvHKHXuLy0PpYs3riyO+D0PLlCueMKUCCndirA+v7elJwtVV3nMcaEQ4Q?=
 =?us-ascii?Q?2jrDn6jP8fJf60nSt8phhKm69+pbz5rj3b9d4a0c9dMkKv+g61S7Aj7MsMdX?=
 =?us-ascii?Q?Np5kmD1LBc2SVY3FHm0cg77A/60CZrpWwMuR5qcD43/CdmL8HCBdNNxdV0FS?=
 =?us-ascii?Q?fO18QvZdsv7mn5rbv3RWo+9CgYgUN9ebFI3R7g5dPwrEgPBKIChfexVB3t/h?=
 =?us-ascii?Q?J67VXAMQg/6I9uYqp/pKdCQHdAHFrP6h8cNBxTDQh3CZhNiF8CsbVykHVKhH?=
 =?us-ascii?Q?x5QXHPx9jTNLCzDDdROCmxGrdDiWXslOosuo7Ju9VZI9xZ2Xc2QEpR2dmX4P?=
 =?us-ascii?Q?MVaK2sQiThyg+D9/WYRmwBHOUAAaKzDkzieQMKRYAlET1knwbI+H9FXz22Kp?=
 =?us-ascii?Q?wKpzXPIeZhK0UHL7ZpVTSA114S0Pibjzl+KDmdLOxi79OUFes7gOeSK4d5IO?=
 =?us-ascii?Q?N6bSY6lQE0NJdmg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 11:04:54.5900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c2c679-b16f-4467-29b8-08dd4e79be4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772
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

From: Erez Shitrit <erezsh@nvidia.com>

Till now the FDB processing domain is split into two mutually
exclusive sub domains FDB_RX and FDB_TX.
Packets originating from the Uplink(s) are processed in the FDB_RX
sub domain, while packets originating from all other Vports are
processed in the FDB_TX sub domain.

Now adding new sub domain: FDB_UNIFIED which can process packets
originated by any VPORT / WIRE.
This new domain will process actions only that allowed on both RX
and TX domains.
That way the user can define specifically the domain he wants the
packet to be processed, whenever it is RX/TX only he will use
FDB_RX/TX, or whenever it can by FDB_UNIFIED.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/common/mlx5/mlx5_prm.h    | 4 +++-
 drivers/net/mlx5/hws/mlx5dr_cmd.c | 4 ++++
 drivers/net/mlx5/hws/mlx5dr_cmd.h | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index d0cb0131f6..6e141b6520 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -2478,7 +2478,9 @@ struct mlx5_ifc_wqe_based_flow_table_cap_bits {
 	u8 ste_format_gen_wqe[0x10];
 	u8 linear_match_definer_reg_c3[0x20];
 	u8 fdb_jump_to_tir_stc[0x1];
-	u8 reserved_at_1c1[0x1f];
+	u8 reserved_at_1c1[0x1];
+	u8 fdb_unified_en[0x1];
+	u8 reserved_at_1c3[0x1d];
 };
 
 union mlx5_ifc_hca_cap_union_bits {
diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.c b/drivers/net/mlx5/hws/mlx5dr_cmd.c
index a4f778a8a4..8a788709b5 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
@@ -1276,6 +1276,10 @@ int mlx5dr_cmd_query_caps(struct ibv_context *ctx,
 		caps->fdb_tir_stc = MLX5_GET(query_hca_cap_out, out,
 					     capability.wqe_based_flow_table_cap.
 					     fdb_jump_to_tir_stc);
+
+		caps->fdb_unified_en = MLX5_GET(query_hca_cap_out, out,
+						capability.wqe_based_flow_table_cap.
+						fdb_unified_en);
 	}
 
 	if (caps->eswitch_manager) {
diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.h b/drivers/net/mlx5/hws/mlx5dr_cmd.h
index 54840ec445..3c615b8925 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.h
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.h
@@ -250,6 +250,7 @@ struct mlx5dr_cmd_query_caps {
 	bool roce;
 	uint16_t roce_max_src_udp_port;
 	uint16_t roce_min_src_udp_port;
+	bool fdb_unified_en;
 };
 
 int mlx5dr_cmd_destroy_obj(struct mlx5dr_devx_obj *devx_obj);
-- 
2.21.0

