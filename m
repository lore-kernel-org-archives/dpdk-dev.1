Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE8C79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 05:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29F5A402D6;
	Wed,  9 Sep 2026 07:01:47 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by mails.dpdk.org (Postfix) with ESMTP id A4ABB40144;
 Wed,  9 Sep 2026 07:01:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruDeX/Ou7GZARy69qzskJXlcEcaEpGuwdyruMvU2g8j3ulLDwkiewYjlhmnN/trrryvzxQgWqU17gP9pSTbee20N0Qxkt3Y8gfRIbeIreKUUhbG96NsNo4RdhDcoxs9cpEkKUww0ki9UV9YVQ+ZmGpPgkUiBck4Ox2eaqJ4N8GueQqRP/uSU57l2OtDvy3FNt3jx06cFdAsg8LASgTWxrhehSn67AnQzTmQu5Q3ZXtm3PtRJR9BcTsTFk1p8rW8qCiwTdmpX1TKMijP2yENDjMvs5hs7DEyUo/75P2EWzxzQd2phuhkFY8EPz/1WhUE3RZzVEx2lvoLb5ApEgMnglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHxwkEsKUQ9mlON6lkrQWBeNO4GI7sm1nMGgXoW3E1Q=;
 b=lE3Aciml3arzaVJuqt9KfsEUSa02QZzHF8adt+EwVWGnTm3aHCExA7/ieOUVDNl0ogqzJSCfBWpb1l8EgBTAJG2jXaCO4Bd62sIDYt1qwvCGgzL8B14V876JA/QEnBG899trkRu15IlXg7WgWEqIkUPa/44wlNgN0bCYFjVoF+pzvn0eUEQK2Ri5ZK7dkzlziiqJxVwv60EuQ4YOg2PrjjW6bsP6FwtupZhWbMHvGRGyjV13set5XCFqSZE2yH0g+5yzhKegDu3/Nz25FC6to54zmJhFrIQkRY6l6/77JmmufUNswldWFFcndJ02KwCgrjRaQW0r8q9npQUlfoVtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHxwkEsKUQ9mlON6lkrQWBeNO4GI7sm1nMGgXoW3E1Q=;
 b=up0yEGpmLXj1q527wMU2xo5QnNzf5kZDcJodrHwsQOtwRzqOEq5FjX4Urr4ld4M14mIc5g0LKacan3PN6dDpkDe3dY21JqhbbxPktjN/cZ47QJxBls7rxszqk+FqmcrLILhzPT3bJ9pmcDlgvk/3Jh2JV2Gcw+VnCQaz3LtRbMQDMgKx+x2zTOKOeSheFT7Aci0vA0XBqUXoZQENtqq0K3gO41FeN2iVv8DKkwkLgNrN5GopUkqlFLgvQaAsaTHo5hybffKZ+CEhqO3Hc2GQixn1kp1wPSmsjGYJheZDtwENLN5oD2DUNxVPTVKYL+dvSdEj5c+yJlBMU1lMVHUWOQ==
Received: from PH7P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::8)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 05:01:39 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:510:33c:cafe::7e) by PH7P221CA0048.outlook.office365.com
 (2603:10b6:510:33c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 05:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 05:01:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 22:01:15 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 22:01:11 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <stable@dpdk.org>, <dsosnowski@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <gavinl@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH] net/mlx5: fix processing of batched RDMA monitor events
Date: Wed, 9 Sep 2026 08:00:57 +0300
Message-ID: <20260909050057.25075-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 8345c3ef-e9bf-4f8b-42cb-08df0e2f6e2d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: jfBFZflgGMrhpiNI13FlnRmv+k8BaULKe9+QOeHqSmuH8UnGoxnWYJg1MlyK00UbVUsTusl4F7aGNQxapYai9Aia7yuuL1AH4b+1Aw4y0tHwqLSnWttG+bUQpyNxmTfm3CnBbluOsHxQMcaw8bvpLjfcq8/wSZThNSaDIHSkNcxMHzEIBl0XURlgRunFzCOPEj5/PKPf8IsuV4v8HxME8bDBa7dynl0SkCxjvq/8zXwTuq2whHYndmG4XbDsXoNfu8TyLntHz+fjELLZC9zgoQ6Q2MExw9kpEbibCoW9bDodgfiuFyw87GthWQ9L+ueI1XZpQCNvwcA+atvFMPYO+vJtcxPB6pGJ68vc3qUBf3eNSumFBX9kt6F8jkmj+V8aLWfhSy6byAE9aMBW6cxuMpQY7j4Hl6QwiNCwgZEUFZsKrJ392axZJa9tHHJII1o8P6q5MZYGyZAOpj8uERTRNTyRObN/kfKoR5jz4TkIzvyDY+SEncHFHs/dLbQ2tsxgfbUpWgtI2+lBg7YaMFkIbbSSpN0MyeTY90A5XXD0oHBBrzrbJomqYxZCwXPkUlNv56fa7e1FnZSsH/PsDzBYGvWaepKns8GkDUFw8HJfdfXcv7wv7gnFBk+yi4RmOZnnbN7vT7V8zSifVEN+2P7Bd8jj6RfVrs/XYsIDGMH72HNMeYZtZqAqRrUTZDCipsAL9ElngS0znlLIJ7USoTID3A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ro0C8wOiycux5cG0Rug+73TGizhkvGzB3gmrAgFPlfRKPhTMSYssnG8VJfTM7O/wi4clj8kh5YdqT7itin+MFJap1Ju3G2UH0LReExkzmYuYRF8RQRguT+oltOv/9+HT++EWXabG781hTaR7/BYjdlm6kH+V/b7559s0a2cJVgrkYUb/X5vVc+ZSRpnLfCDpqbdBc3ja6lySTRvH+bP2f3uXi1Bav9f9D+dFuh18Q638g4rDdmF2b1Uk9XfFsWGkSyd7h4CUB9/0HXijzabeiyT1VOhyP2Eg4y1jrAZlBYlFiHKMEcK4ScM/IKmrru1xm1+uXgu6ZHlI94PpGGl7KYVHvMjHJdy6HpcLxXBMN0o46tJ99d0XPl3zM0bOvuEHV8wuC15SkBW+gED9pNDxnBsN43sZyhHd2PDOgW2qaMBFNLU9ZPuniEdykUYbUib/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 05:01:38.3121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8345c3ef-e9bf-4f8b-42cb-08df0e2f6e2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589
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

mlx5_nl_read_events() may deliver multiple RDMA attach or detach
messages in one drain. The interrupt handler previously parsed all
messages into one structure and processed only the last one, leaving
earlier port cache updates unhandled.

Parse and process each Netlink message in its callback. Always drain
pending messages, validate the port index before updating the cache,
and log at INFO when multiple messages for the same IB device are
received in one drain.

Fixes: 2a18d0022c05 ("common/mlx5: use RDMA Netlink to update port info")
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 135 +++++++++++++-----------
 1 file changed, 75 insertions(+), 60 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 4bbc590e91..f6394ebd19 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -890,85 +890,53 @@ mlx5_dev_interrupt_handler_devx(void *cb_arg)
 }
 
 static void
-mlx5_dev_interrupt_ib_cb(struct nlmsghdr *hdr, void *cb_arg)
-{
-	mlx5_nl_rdma_monitor_info_get(hdr, (struct mlx5_nl_port_info *)cb_arg);
-}
-
-void
-mlx5_dev_interrupt_handler_ib(void *arg)
+mlx5_dev_interrupt_ib_process(struct mlx5_dev_ctx_shared *sh,
+			      const struct mlx5_nl_port_info *data)
 {
-	struct mlx5_dev_ctx_shared *sh = arg;
-	struct mlx5_nl_port_info data = {
-		.flags = 0,
-		.name = "",
-		.ifindex = 0,
-		.ibindex = 0,
-		.portnum = 0,
-	};
-	int nlsk_fd = rte_intr_fd_get(sh->intr_handle_ib);
-	struct mlx5_dev_info *dev_info;
+	struct mlx5_dev_info *dev_info = &sh->cdev->dev_info;
 	uint32_t i;
 
-	dev_info = &sh->cdev->dev_info;
-	DRV_LOG(DEBUG, "IB device %s received RDMA monitor netlink event", dev_info->ibname);
 	if (dev_info->port_num <= 1 || dev_info->port_info == NULL)
 		return;
-
-	if (nlsk_fd < 0)
-		return;
-
-	if (mlx5_nl_read_events(nlsk_fd, mlx5_dev_interrupt_ib_cb, &data) < 0)
-		DRV_LOG(ERR, "Failed to process Netlink events: %s",
-			rte_strerror(rte_errno));
-
-	if (!(data.flags & MLX5_NL_CMD_GET_EVENT_TYPE) ||
-		!(data.flags & MLX5_NL_CMD_GET_PORT_INDEX) ||
-		!(data.flags & MLX5_NL_CMD_GET_IB_INDEX))
+	if (!(data->flags & MLX5_NL_CMD_GET_EVENT_TYPE) ||
+	    !(data->flags & MLX5_NL_CMD_GET_PORT_INDEX) ||
+	    !(data->flags & MLX5_NL_CMD_GET_IB_INDEX))
 		return;
-
-	if (data.ibindex != dev_info->ibindex)
+	if (data->ibindex != dev_info->ibindex)
 		return;
-
-	if (data.event_type != MLX5_NL_RDMA_NETDEV_ATTACH_EVENT &&
-		data.event_type != MLX5_NL_RDMA_NETDEV_DETACH_EVENT)
+	if (data->event_type != MLX5_NL_RDMA_NETDEV_ATTACH_EVENT &&
+	    data->event_type != MLX5_NL_RDMA_NETDEV_DETACH_EVENT)
 		return;
-
-	if (data.event_type == MLX5_NL_RDMA_NETDEV_ATTACH_EVENT &&
-	    !(data.flags & MLX5_NL_CMD_GET_NET_INDEX)) {
+	/* IB ports are 1-based. */
+	if (data->portnum < 1 || data->portnum > dev_info->port_num) {
+		DRV_LOG(ERR, "Port[%u] is outside valid range [1, %u]",
+			data->portnum, dev_info->port_num);
+		goto flush_all;
+	}
+	if (data->event_type == MLX5_NL_RDMA_NETDEV_ATTACH_EVENT &&
+	    !(data->flags & MLX5_NL_CMD_GET_NET_INDEX)) {
 		DRV_LOG(WARNING, "Incomplete RDMA ATTACH event for ibdev[%d]",
 			dev_info->ibindex);
-		if (data.flags & MLX5_NL_CMD_GET_PORT_INDEX)
-			memset(dev_info->port_info + data.portnum, 0,
-			       sizeof(struct mlx5_port_nl_info));
-		else
-			goto flush_all;
+		memset(dev_info->port_info + data->portnum, 0,
+		       sizeof(struct mlx5_port_nl_info));
 		return;
 	}
-
 	DRV_LOG(INFO, "Event info: type %d, ibindex %d, ifindex %d, portnum %d,",
-		data.event_type, data.ibindex, data.ifindex, data.portnum);
-
-	/* Changes found in number of SF/VF ports. All information is likely unreliable. */
-	if (data.portnum > dev_info->port_num) {
-		DRV_LOG(ERR, "Port[%d] exceeds maximum[%d]", data.portnum, dev_info->port_num);
-		goto flush_all;
-	}
-	if (data.event_type == MLX5_NL_RDMA_NETDEV_ATTACH_EVENT) {
-		if (!dev_info->port_info[data.portnum].ifindex) {
-			dev_info->port_info[data.portnum].ifindex = data.ifindex;
-			dev_info->port_info[data.portnum].valid = 1;
+		data->event_type, data->ibindex, data->ifindex, data->portnum);
+	if (data->event_type == MLX5_NL_RDMA_NETDEV_ATTACH_EVENT) {
+		if (!dev_info->port_info[data->portnum].ifindex) {
+			dev_info->port_info[data->portnum].ifindex = data->ifindex;
+			dev_info->port_info[data->portnum].valid = 1;
 		} else {
 			DRV_LOG(WARNING, "Duplicate RDMA event for port[%d] ifindex[%d]",
-				data.portnum, data.ifindex);
-			if (data.ifindex != dev_info->port_info[data.portnum].ifindex)
+				data->portnum, data->ifindex);
+			if (data->ifindex != dev_info->port_info[data->portnum].ifindex)
 				goto flush_all;
 		}
-	} else if (data.event_type == MLX5_NL_RDMA_NETDEV_DETACH_EVENT) {
-		dev_info->port_info[data.portnum].ifindex = 0;
+	} else if (data->event_type == MLX5_NL_RDMA_NETDEV_DETACH_EVENT) {
+		dev_info->port_info[data->portnum].ifindex = 0;
 	}
 	return;
-
 flush_all:
 	for (i = 1; i <= dev_info->port_num; i++) {
 		dev_info->port_info[i].ifindex = 0;
@@ -976,6 +944,53 @@ mlx5_dev_interrupt_handler_ib(void *arg)
 	}
 }
 
+struct mlx5_dev_interrupt_ib_cb_arg {
+	struct mlx5_dev_ctx_shared *sh;
+	uint32_t message_count;
+};
+
+static void
+mlx5_dev_interrupt_ib_cb(struct nlmsghdr *hdr, void *cb_arg)
+{
+	struct mlx5_dev_interrupt_ib_cb_arg *arg = cb_arg;
+	const uint32_t count_flags = MLX5_NL_CMD_GET_EVENT_TYPE |
+				     MLX5_NL_CMD_GET_IB_INDEX;
+	struct mlx5_nl_port_info data = { 0 };
+
+	mlx5_nl_rdma_monitor_info_get(hdr, &data);
+	if ((data.flags & count_flags) == count_flags &&
+	    data.ibindex == arg->sh->cdev->dev_info.ibindex)
+		arg->message_count++;
+	mlx5_dev_interrupt_ib_process(arg->sh, &data);
+}
+
+void
+mlx5_dev_interrupt_handler_ib(void *arg)
+{
+	struct mlx5_dev_ctx_shared *sh = arg;
+	struct mlx5_dev_info *dev_info = &sh->cdev->dev_info;
+	struct mlx5_dev_interrupt_ib_cb_arg cb_arg = {
+		.sh = sh,
+		.message_count = 0,
+	};
+	int nlsk_fd = rte_intr_fd_get(sh->intr_handle_ib);
+
+	DRV_LOG(DEBUG,
+		"IB device %s received RDMA monitor netlink event",
+		dev_info->ibname);
+	if (nlsk_fd < 0)
+		return;
+	if (mlx5_nl_read_events(nlsk_fd, mlx5_dev_interrupt_ib_cb,
+				&cb_arg) < 0)
+		DRV_LOG(ERR, "Failed to process Netlink events: %s",
+			rte_strerror(rte_errno));
+	if (cb_arg.message_count > 1)
+		DRV_LOG(INFO,
+			"RDMA monitor received %u netlink messages for "
+			"IB device %s in one drain",
+			cb_arg.message_count, dev_info->ibname);
+}
+
 /**
  * DPDK callback to bring the link DOWN.
  *
-- 
2.43.0

