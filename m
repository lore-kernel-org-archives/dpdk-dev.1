Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433CC8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 05:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C18E1402C6;
	Fri, 29 Aug 2025 07:37:12 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by mails.dpdk.org (Postfix) with ESMTP id CAD0540263;
 Fri, 29 Aug 2025 07:37:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNobuLqRkA6nREBQk5BpZSc6jA48ps4xz9wFh05JeKUxsZzg09CJnT+lajRuO53ljxFVgYoNlJkpma49Ew620Ppkqr1ODJetZ1rgBDEIh3bY7JWbkR+sVJJn5l/ivWttob3zP3I1haosAASb5REjiISCgwQUsWNa5V9K4BiKFT7bwpV+Sp1+nrftTtplnx78n3HS7GKm8iYygg1yIP66QG4I5yRlcxMK173mKybkuKFA2vOsgZaDWSGupTOtkyaB7XtTsu+cQtSQcF2ZeRu1L4TCnQkIGDCNDkBCgl56Fji6CP+QcstHvMZNAcjlsOPdkVFJC6gJP5najl5Ts792Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPzudE7bdG++fFgxDO2MlFoGsm3V0TPIwI0s9gttJYg=;
 b=p0QtKabkOiRQGTfQ/pP47CXHD72XJ7e3BO33a2Nkgixso7FF0h8EuXx5/+ceqKv9ybsTuvhQ9GQ3kogkKBMcwG78gPrpMo6hlFdbwA5CMUPUImiUy4QGbLs0OoQX+OZTkNmujHKFhuhgacyq4o3rfjp8m2lFf3pdThjTPZQvbFJEn9QvQe5sVsyyBw32oc4g3PdwONz6KmYPUa4zySg401jf+hLtu1dyAB+OJXChmyMtHVUqkfPVtGT6MqVm3fB07fWBmy5YmF6CxHeb36dTb2si2fYDKgeDRYZsce+oTl1HeXbyMm4WpRJ8R4JMPxGPIokRP+kxf7XEtbL+pWsN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPzudE7bdG++fFgxDO2MlFoGsm3V0TPIwI0s9gttJYg=;
 b=CHqa3pFkQM5uxTMZWelc+XXm3ApMAc3/Pf0yFf7U5FLbaEw2BOH/PTietARrXjkQ+1DRSV1QUnZkZD9fbqLyntKqWzIZocCAhDJq3nfqppoe0TWgPeHdi0+uU6gRg/0VkKAm08R8eAIZhZBH+0mCdZ0pdOp3cOo2z/JFC2hKETSOXO5wkjLfqnGvtjXwBNxyama8k7eSs7Qj5ear//h6ets/UNQoCEEpjXjtt3jyjFzojxCyTppBpSSFjS/URtnxexB3T21hb6pk6B3sn+vVyemaxv9/3ZMQOdSR4F5PMZd8wlG/MhN3dCaJfISu5dVjcgG4HcpXtc8GTduyZnEgvA==
Received: from CH2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:52::35)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 05:37:05 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::8b) by CH2PR04CA0025.outlook.office365.com
 (2603:10b6:610:52::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 05:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 29 Aug 2025 05:37:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 28 Aug
 2025 22:36:48 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 28 Aug
 2025 22:36:45 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <rongweil@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v2] net/mlx5: fix probe optimization race condition
Date: Fri, 29 Aug 2025 08:35:32 +0300
Message-ID: <20250829053532.445865-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <23111985.hxa6pUQ8Du@thomas>
References: <23111985.hxa6pUQ8Du@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f34409-d9a4-4594-4c7f-08dde6be1696
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bUew6MQLuPwVn/rEP3vl7eYOEez97vRfBHwMW8c50tdUfj+e/zj2tvNfIhZq?=
 =?us-ascii?Q?UL16FEaH0vMorOZtjz+Ubl1enhDZKjrWMNt3L1+r+h6QVyEC9PO2bPcgNu62?=
 =?us-ascii?Q?OlwGdyyasCkojNwSV7ZkQrpBlQXlm67aQMjOyaZzskMGC8kZ45zDC9f7ekWM?=
 =?us-ascii?Q?lhHe3K3pAcT1N2C2Hus2/9fvroDoo4K5HLpL7xZUoRqXsVljdGYxLKVMdc+Q?=
 =?us-ascii?Q?b4z8lfaCUF2fLhcgH788pIJKzwhjQExvMiKxIQq1XUiPw6VH6KHbLZ4MYzwc?=
 =?us-ascii?Q?UQI4AXacFHQSMkwhB1ofkESgqvL6aRiiG20fYUQ6OXINGiQY/2g7PRuEfr4c?=
 =?us-ascii?Q?qjvjHdgIb19QMlFYCgvXo82ANqzrIn77VEh/lFpMTyvpCqCWihV9HrBFln/o?=
 =?us-ascii?Q?9nwOEq3iNUayGuzp5JW8bd5FbG/I6iFALcT5KgmJ8hh/npmVCtfd8Jqy2GlS?=
 =?us-ascii?Q?hD9r3u3n5XDw5UTx4f23Rx+Yef4m1kyUjcL7PxT5F1jG/6Wqz06xuoVE9xYC?=
 =?us-ascii?Q?rDnau8APcLdovkxgTG45kuGVmSdaYo3P3Rt0vGj5Ign3PiuEvP6eCDVlYdhp?=
 =?us-ascii?Q?p4jVLGf4Op0UMeTJlD3uixW+AU4zUCVOkd+exodgAgvjmOyx9jMqbkEihbA9?=
 =?us-ascii?Q?dq9RXSaoKEPEiPPCwUFlAqJpmBrXm1As+GJ+Uv1zpxRvoG4ocCfHndOdjMIa?=
 =?us-ascii?Q?1irqejShPtGSytbfvVA33h/ChAIJqOUpKr6gum8GyPjXzUMnDbHqERxNMmnB?=
 =?us-ascii?Q?/gxMi6OJTnV1NMnDxLQkTioCwL8retvtqSM5urWSunUpLWvBcrAiGIcOPG9q?=
 =?us-ascii?Q?KvQ/1bZYl1ILoVfC93RmsE5xZfyd7R4O/J2nI1njvM3KetyXdnMVDOxGKEEm?=
 =?us-ascii?Q?KX3GEZOWIICWlSQU+emTt8iMie2rAjcscPemI0Regp7PT6FxXWVA1wGLQ11l?=
 =?us-ascii?Q?QGTRJyiKB3ZgdnWLazelsm0NOxkUCWGuBd7ar7tv42qqh/kihF998x0umPP1?=
 =?us-ascii?Q?pZPk87agA77eUluW0vto6bbHLiq8qLwCWhAI5H2l9mfGdq859gRtFUFhhqbe?=
 =?us-ascii?Q?29OILAtHIMguhdjuA4/fW+CTGIBgP0Hj2n/CRPFKkZdx4z/Kk6paIfwbdITs?=
 =?us-ascii?Q?cnaop0bOx1y1f7/pn4P5DB6sZHs1f6NmVWxHKWJMwBoUdddpB03sngUM8fbQ?=
 =?us-ascii?Q?VT660pUr9wvPs6fdFFW4CQJ25WLMHfpOv0mALVlACg62tos3u3kEi2GjJNxH?=
 =?us-ascii?Q?GdCcT8W6FhHMZ+HCcvPeB9SG7c7L8+ptd+bYmoRanYGDf6CgornG6PWoE368?=
 =?us-ascii?Q?QIrwe3ln+BBmPqZV2BbQvMMnoOzbV18fhf10vIbQvYC4Zhvo9fUR4W/PUCO2?=
 =?us-ascii?Q?yVX6EB9WNCtqFVNAOagG3nBP2Dd0n/JBnqnMeycNENq0FWMgiUkXB2StlOi0?=
 =?us-ascii?Q?Sc/nR5ap3/pLxIZ23thedsWoixMutZwsgg+4DbrrIL6ciu923p78dPy6BpTH?=
 =?us-ascii?Q?jQXJgzpY6VY87ed9MB5gbzr+6UEMeoG59os/?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:37:05.1784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f34409-d9a4-4594-4c7f-08dde6be1696
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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

Current logic is:
1. Update all port information in probing thread.
2. Probe thread initiates the dedicated rdma monitor thread.
   Once ready, port information update will be handled by this thread.
3. Next probing won't trigger PMD port information update.

No lock is required.

Fixes: 51fb5c40c826 ("common/mlx5: optimize device probing")
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

