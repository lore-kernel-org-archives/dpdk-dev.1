Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11EACA0FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 03:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFB7E4027D;
	Thu, 28 Aug 2025 05:23:12 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by mails.dpdk.org (Postfix) with ESMTP id CE87440263;
 Thu, 28 Aug 2025 05:23:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJouGDMbnZnLLbxfN4N5YKDsuWFsh3JDS1ZaulwZ+iheA0DJze7HQOQGd6MFOqbSU/ZeDHd1OqFiRUBa7xzUe5UnOhIkEV0wIMR/4za8I2X7zkDwGPDUbmAQqIWZpnSkg/7RWM32VZYBwzpCg64a4jFvflqqS+JimRA5yRoSxZ7cbGsSx+LYaRBYmDDUFu8xkGfljzNHVLXinRp4PYEICKVVVQfudWwUqTq9Uq8VysitBcv95pzuR2qhcjz/Tq2rrPY2Vos53/VwTFfHPtObfk8T0YeJwAXiK0nO9kuHJyw0Bh5N1dpcewqqfuIDYiw2Oi0ZtlivtZzRXeQY1PtTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhTOcTDDDIB8KmBQU5C3qmrd3YKdXOT5Bp13BbjeacY=;
 b=PAUSKrOwMKloTg8Zomr0BMNxSUTM7veA7BbL1Y0Tj48l31pEC80NO+oEpBmhualB3wHQyPwOOnqHOhMErrZey1MRIzaEFc48TtonEAcdDhXYtDvKEdUJF9rgEQpEFe88tkKVtvPvEcVuJMAL+BD39sK0GAAJrNycZDgg+Rn9B5qeyXpie3Nvaa02Wdu9Iw66y6fag+xkqC8h2xi9cVRYRTjcjXxPflMCBeYh/ToRALdPZs8g+B7aVdfEW855WgoHPXkDEMCBPNF044R2LQr3zt9gR0v7mzvh17bbR97wBjEm5Al+R7b+UgOUpuKHjdx3mq2WCd64a4D5EpRmC6InZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhTOcTDDDIB8KmBQU5C3qmrd3YKdXOT5Bp13BbjeacY=;
 b=ceX0iJcDnG2Dx45uRVAfA1dx43tPuOcEPSw4J59u2kBFOq7F3lr518y3sQlzvo/iItfw1zXumb0btx0aCGMAiFDuzExe7Dy9Ts9xp/dwkJ1SxHhGVJhnHNJNGmzvAttzMsCmV8YtwQPjSDEzGv53NYEFQoSc2Yf2weGsg9QfjHQHkiQGkk45EvP98wWKR2zZBqD82pUzDJlBZpTTqQSeJ+C9j+t1M3v/ywpWkdigWaXyy0FRQuK8QDYcNEmI+S/DAgyMVlceepZEPcqmeByx/NvOyHDHDhetLOehbeDaMqU9kokBdzYL36QqqMgGtQsbPg/be7Fd1VSZOW/u4Yu+Bg==
Received: from DM6PR08CA0061.namprd08.prod.outlook.com (2603:10b6:5:1e0::35)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 03:23:06 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::a6) by DM6PR08CA0061.outlook.office365.com
 (2603:10b6:5:1e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.15 via Frontend Transport; Thu,
 28 Aug 2025 03:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 03:23:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 20:22:52 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 20:22:49 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <rongweil@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: fix probe optimization race condition
Date: Thu, 28 Aug 2025 06:21:34 +0300
Message-ID: <20250828032134.167999-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 01060643-7458-4c3c-e309-08dde5e23422
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oGNtavB8kigW+ZtYBa32kwEuxcMPZZOUfyn5BYR89rL763aoUFBptxkzlyUf?=
 =?us-ascii?Q?pUFtFcjALTdlZmWekViLFpTxaL5AcI6/7zd4BzjA7nsOiP8sB6ymqY3lC7Sp?=
 =?us-ascii?Q?SrZUK3H48vJmM8nVm/KfB7+yqq908x1dELzF6f3zbfWIDO8WESxC1Mb/rS+z?=
 =?us-ascii?Q?SAKUThyv6Uxp4WbZLXiwSK5Shf0HOrp9DrU7JwFbFHSa4Fnm2sL+QfYWca/+?=
 =?us-ascii?Q?U1ioQU4pkZjcXXWnooXgieGH5pyC3dlIAwxMMQLLZ1qWzVQ8xdnIuBuXWkaF?=
 =?us-ascii?Q?L9JHEaury+pXtnhk4W1MsDZV3TwzM2SDEUPiCm3lzAK2asmmEKDCVxz7A9AE?=
 =?us-ascii?Q?PgIaTt0l1VjakEK2BRwVso5FFXtqBeFr8bo+uIJByZDF4zHW4nnTkNi4darJ?=
 =?us-ascii?Q?pFYgeHEYmzeFe7bhKRhkmtVLI1lAdYHpFUBFVyWvgCP1XxrKlp2v6DX/eUo0?=
 =?us-ascii?Q?u6ihzrNRl3/pHo/dthIThmA0bBmCxfHSDTdGex7cRryH8R6rG6C1h3aNF4Gj?=
 =?us-ascii?Q?qrn1hiOZaag3nrUkdt77LxiaK4e8B8BJoWadeNJnxlZe8Z5n+1UIqLm5EKhS?=
 =?us-ascii?Q?CsRCnbFPwLWHv2cRZabgJ+hA70AFMKTw/EUjOn+MSdm7y7LEXG2RY7XpmCal?=
 =?us-ascii?Q?dbysiIML8t+U6I5k5xvZqnJJXYYUl/0GEhfjWPbg+rSCN8Tv4XZBK+PCX0Z4?=
 =?us-ascii?Q?0P8vUOEXS4D7A9LDqJqpLNrOoMDJc4gfcZ6YnMgGbLO2d11kIu04+/1HoLyf?=
 =?us-ascii?Q?3r9xc3PbvkVI3KNPn+/yekB5F7pqK6Bc7AU6Cn+RxPWVJLrram3RLLh6WQ0z?=
 =?us-ascii?Q?B0csAKidqEPK+ZmhjBHBKav/rD+wSE/mlUE8mDsNpPuC9YngV0e+SYGWKf81?=
 =?us-ascii?Q?88V5t4YRWezFgjzgrIFVoQCGZ6oF21JIbDB3VvSC4rfNLaFXXalc80KChxro?=
 =?us-ascii?Q?kOiVWATIOj2EATwbn6hPTsTKk6S1eafvFL5IhAXrNIoqrf9/jCxmtNRUgF+J?=
 =?us-ascii?Q?P4rcvh3hO94S7SU5uLQPySJRflq/ri69CcpvlmQglFYkPLqUIV3hIAA3W6gQ?=
 =?us-ascii?Q?+6eLARTuPtC0RztdL/vxj3owTpJBQjx6/ys7IxnjmrspazPBHmUWwJePie1T?=
 =?us-ascii?Q?yOaPbdikOi/ZlWagICSUlWLLDf0M7xaTGLhiLwqVf6zfRShjoi2avsg+TlF2?=
 =?us-ascii?Q?NYiRRTuGEw+nTXJ2xO3+//GrNf8kae7poyjKfqzNjngKXpRoK1a3UhQP+t33?=
 =?us-ascii?Q?30ST/5GgKucMlHtL8vsO/SOQxOgE75HTUr6Aeq//vj5ofQJFaIDdiA7yIHfs?=
 =?us-ascii?Q?9Vt6ObNRcaCCE6MG9RB7KRqu/eRtMP0yN2JfMgqeUdi05e1UNw1zs4gEItA7?=
 =?us-ascii?Q?9vtMV0hwEvWbSSHcaDCdxRd14tUWg2guSj0r7VuLfeQAclLDtKGht1b/H5Zp?=
 =?us-ascii?Q?UOQnNjOQ7DninW++TlZdDTW5pQc1ONQiODU0LuUM1c8ky47Gu4NTc4m1NOOR?=
 =?us-ascii?Q?hgyMeoLG33kiEU0zUj2SeoREGfi223SJ4ulw?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 03:23:05.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01060643-7458-4c3c-e309-08dde5e23422
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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

With dedicated RDMA link monitor, there are two threads
which can update the IB device port information.

Add a new flag to avoid the race condition. Update should
go through RDMA link monitor once ready.

Fixes: 51fb5c40c826 ("net/mlx5: optimize device probing")
Cc: rongweil@nvidia.com
Cc: stable@dpdk.org
Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c     |  7 ++-
 drivers/common/mlx5/mlx5_common.h       |  1 +
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 69 ++++---------------------
 drivers/net/mlx5/linux/mlx5_os.c        |  9 +++-
 4 files changed, 25 insertions(+), 61 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index dd69e229e3..84c12efdc7 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -1171,8 +1171,12 @@ mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info
 			data.ibindex = dev_info->ibindex;
 	}
 
+	/* Update should be done via monitor thread to avoid race condition */
+	if (dev_info->async_mon_ready) {
+		rte_errno = ENODEV;
+		return 0;
+	}
 	ret = mlx5_nl_port_info(nl, pindex, &data);
-
 	if (dev_info->probe_opt && !strcmp(dev_info->ibname, name)) {
 		if ((!ret || ret == -ENODEV) && dev_info->port_info &&
 		    pindex <= dev_info->port_num) {
@@ -1182,7 +1186,6 @@ mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info
 			dev_info->port_info[pindex].valid = 1;
 		}
 	}
-
 	return ret ? 0 : data.ifindex;
 }
 
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index bea1382911..b49f0c850e 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -185,6 +185,7 @@ struct mlx5_dev_info {
 	uint32_t ibindex;
 	char ibname[MLX5_FS_NAME_MAX];
 	uint8_t probe_opt;
+	uint8_t async_mon_ready;
 	struct mlx5_port_nl_info *port_info;
 };
 
diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index a371c2c747..180fd60f3a 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -704,59 +704,6 @@ mlx5_link_update_bond(struct rte_eth_dev *dev)
 		((ifr.ifr_flags & IFF_UP) && (ifr.ifr_flags & IFF_RUNNING));
 }
 
-static void
-mlx5_handle_port_info_update(struct mlx5_dev_info *dev_info, uint32_t if_index,
-			     uint16_t msg_type)
-{
-	struct mlx5_switch_info info = {
-		.master = 0,
-		.representor = 0,
-		.name_type = MLX5_PHYS_PORT_NAME_TYPE_NOTSET,
-		.port_name = 0,
-		.switch_id = 0,
-	};
-	uint32_t i;
-	int nl_route;
-
-	if (dev_info->port_num <= 1 || dev_info->port_info == NULL)
-		return;
-
-	DRV_LOG(DEBUG, "IB device %s ifindex %u received netlink event %u",
-			dev_info->ibname, if_index, msg_type);
-	for (i = 1; i <= dev_info->port_num; i++) {
-		if (!dev_info->port_info[i].valid)
-			continue;
-		if (dev_info->port_info[i].ifindex == if_index)
-			break;
-	}
-	if (msg_type == RTM_NEWLINK && i > dev_info->port_num) {
-		nl_route = mlx5_nl_init(NETLINK_ROUTE, 0);
-		if  (nl_route < 0)
-			goto flush_all;
-
-		if (mlx5_nl_switch_info(nl_route, if_index, &info)) {
-			if (mlx5_sysfs_switch_info(if_index, &info))
-				goto flush_all;
-		}
-
-		if (info.name_type == MLX5_PHYS_PORT_NAME_TYPE_PFSF ||
-		    info.name_type == MLX5_PHYS_PORT_NAME_TYPE_PFVF)
-			goto flush_all;
-		close(nl_route);
-	} else if (msg_type == RTM_DELLINK && i <= dev_info->port_num) {
-		memset(dev_info->port_info + i, 0, sizeof(struct mlx5_port_nl_info));
-	}
-
-	return;
-flush_all:
-	if (nl_route >= 0)
-		close(nl_route);
-	for (i = 1; i <= dev_info->port_num; i++) {
-		if (!dev_info->port_info[i].ifindex)
-			dev_info->port_info[i].valid = 0;
-	}
-}
-
 static void
 mlx5_dev_interrupt_nl_cb(struct nlmsghdr *hdr, void *cb_arg)
 {
@@ -766,8 +713,6 @@ mlx5_dev_interrupt_nl_cb(struct nlmsghdr *hdr, void *cb_arg)
 
 	if (mlx5_nl_parse_link_status_update(hdr, &if_index) < 0)
 		return;
-	if (sh->cdev->config.probe_opt && sh->cdev->dev_info.port_num > 1 && !sh->rdma_monitor_supp)
-		mlx5_handle_port_info_update(&sh->cdev->dev_info, if_index, hdr->nlmsg_type);
 
 	for (i = 0; i < sh->max_port; i++) {
 		struct mlx5_dev_shared_port *port = &sh->port[i];
@@ -970,10 +915,18 @@ mlx5_dev_interrupt_handler_ib(void *arg)
 		return;
 
 	if (data.event_type == MLX5_NL_RDMA_NETDEV_ATTACH_EVENT &&
-	    !(data.flags & MLX5_NL_CMD_GET_NET_INDEX))
+	    !(data.flags & MLX5_NL_CMD_GET_NET_INDEX)) {
+		DRV_LOG(WARNING, "Incomplete RDMA ATTACH event for ibdev[%d]",
+			dev_info->ibindex);
+		if (data.flags & MLX5_NL_CMD_GET_PORT_INDEX)
+			memset(dev_info->port_info + data.portnum, 0,
+			       sizeof(struct mlx5_port_nl_info));
+		else
+			goto flush_all;
 		return;
+	}
 
-	DRV_LOG(DEBUG, "Event info: type %d, ibindex %d, ifindex %d, portnum %d,",
+	DRV_LOG(INFO, "Event info: type %d, ibindex %d, ifindex %d, portnum %d,",
 		data.event_type, data.ibindex, data.ifindex, data.portnum);
 
 	/* Changes found in number of SF/VF ports. All information is likely unreliable. */
@@ -992,7 +945,7 @@ mlx5_dev_interrupt_handler_ib(void *arg)
 				goto flush_all;
 		}
 	} else if (data.event_type == MLX5_NL_RDMA_NETDEV_DETACH_EVENT) {
-		memset(dev_info->port_info + data.portnum, 0, sizeof(struct mlx5_port_nl_info));
+		dev_info->port_info[data.portnum].ifindex = 0;
 	}
 	return;
 
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 85b3fabaf5..edfe61ea55 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3051,7 +3051,7 @@ mlx5_os_dev_shared_handler_install(struct mlx5_dev_ctx_shared *sh)
 		DRV_LOG(ERR, "Failed to allocate intr_handle.");
 		return;
 	}
-	if (sh->cdev->config.probe_opt &&
+	if (sh->cdev->dev_info.probe_opt &&
 	    sh->cdev->dev_info.port_num > 1 &&
 	    !sh->rdma_monitor_supp) {
 		nlsk_fd = mlx5_nl_rdma_monitor_init();
@@ -3076,8 +3076,15 @@ mlx5_os_dev_shared_handler_install(struct mlx5_dev_ctx_shared *sh)
 				close(nlsk_fd);
 				return;
 			}
+			sh->cdev->dev_info.async_mon_ready = 1;
 		} else {
 			close(nlsk_fd);
+			if (sh->cdev->dev_info.probe_opt) {
+				DRV_LOG(INFO, "Failed to create rdma link monitor, disable probe optimization");
+				sh->cdev->dev_info.probe_opt = 0;
+				mlx5_free(sh->cdev->dev_info.port_info);
+				sh->cdev->dev_info.port_info = NULL;
+			}
 		}
 	}
 	nlsk_fd = mlx5_nl_init(NETLINK_ROUTE, RTMGRP_LINK);
-- 
2.27.0

