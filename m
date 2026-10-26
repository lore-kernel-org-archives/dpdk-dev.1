Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2136606A325
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n2S3AGie
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB53A40A80;
	Mon, 26 Oct 2026 17:28:30 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by mails.dpdk.org (Postfix) with ESMTPS id ABF83406BA
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErPiLQshosh44iz8BSSiXQ12Se2do1QK1MjCEECMl+vupkp123G5i0XtAfu8fK/4qR60BQxRCEvYfa3unZv0FsY1wNHiy+ukR2L83zgx+HOcFKPuh1vSEuk85A7Qw1n6814Wvn3H68QoKHgs+C95SmgZA1SpBYC0OpE0fOBBhsCaDkicQE9Mqxn5RjGv138fH6RPODQWO9XS/MVCF0wpt5vGiT7+MCTzjYEh0jEjX4YwgQ2G7IUb1fzuFgvlpMXxLn7iAe3Ur8mFNsRFxzZoa9qBcsCQvw2DWVomUT1FRGRCOh8nGA5lawlcH8cHd7AZU703rVrLLZJbckpO1wldQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szaN4IX22HgG+er93Mte+LNz22uLypglM99sVgEKkpc=;
 b=sBEhbP9T2siUtsU+Pn/OBDLS+gzbCTqnBMN4NEAdLs9ZnyyNE+HYWLF52YxcSd7M5cAWrmGKfZfYN1NYKkRke/UQuK/CxYDRjMdE7oZxArAqN9lIRcn7BYUd3zUMs//siMzcPcohFsM9oDoDSthVl3FTCGHWBvn6sJi6hSwSbCV5sV0zCSv9GKZQakBYUOXF5i7SctlvN3kDiiHiaek5ZQFi2b2PKSD3Z4kg+EkzhRHqdTkM+1XCCh93q7+BiYu0dXVQQkTub2QN0bfeEWDtSJXnk6upytCX9n8Ibt//h9UMD/s41rTS13rI2BcTA1514dcK8WqfnX7Et5f/kUlu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szaN4IX22HgG+er93Mte+LNz22uLypglM99sVgEKkpc=;
 b=n2S3AGiePdF8Q93JaGIA6gff38pKwhcg/UG3W5sY8fX2NoT6uCed+gGMexYx+kAWraoEeVow/72Uc3sATr3DuS+He3AZ/2BjVKB/1NkwG8Gl0aff6vkv/YUlXFUKPmChmROnaOeoCAGHRBJAf0EoPoo2SQc/vh15eabBh3+1tpjCuXVEJKoyexGTQLVVTt3Y+VRTgbwbvPRC2V/3aJNFCvY96xx8iixcS1fLZqAGSSbOPKH84gsUERVqFilQPpi9+Rs7SHcbZGT1tEbws2NZL8pKtYtVcKEzSnUexqac2o9vjKniBR4v/CukDW/6366+KbWg85clqf3xc/dWE5nfNg==
Received: from CH0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:610:b1::19)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:28:19 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::95) by CH0PR13CA0014.outlook.office365.com
 (2603:10b6:610:b1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 26
 Oct 2026 16:28:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:28:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:49 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:47 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 12/13] net/mlx5: allow associated devices
Date: Mon, 26 Oct 2026 17:27:08 +0100
Message-ID: <20261026162709.1292958-13-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026162709.1292958-1-dsosnowski@nvidia.com>
References: <20261026162709.1292958-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa55946-a3af-4c57-c28c-08df337e24fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|3023799007|6133799003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: AhM51RFfKR1b16Wy2F6xU1Tu3vhoyO2C97imdw689GxCcno+0rBSe5zPI9KlqgjJ34Cu0Mgs+mwyLyHDjMXZGB736Nas7bi1yD4QxEqNZdQMWH3+XbRg8kPC/wjOrXVlob8SjgnPCODLK1qfwSu/EtKDAaobhddMMx0RheCvrAzFSCTLw9ecOfbolgvPRbocCZpGh0zsHBubNYBtkiBiDMN4Egk4Y3RSMWVZOouAVDv/L5odYjbZPU55vB40yCAskiPBiY1ljktuTw/8ONWWO5JlEWs+14QbQMs1K4wVDlkBOCWHLf/Ljsx8YBMeLjUTTW4lkckZFsK1WBdYuSczoszX90C9yxVNkBqtv++sn0OSID3M4uC6x2S2y5ZXiGI0Ii/2hKu3mpw/rVxnjjatE2Nu+RMdBrL7D385Fjh+Vq+lijahFdDijQsvpv6n3cHT/giaTW2EX5RCXbU7Etv0y8vnFugqgmoAFqCqEuhREW+DNuH4/GldQ5J0UKrxL41Zo+YqqFRHrsQHFw8HsfrUYtxq9h/i81xGKcnasSlwxlLMkqMhp/rHDmEXJadmJGkLMN7Rr0rTU9DxXfgnr9fo4o6x2M7VYfcQ62gn0tSv4BP/nyuzoT9eK3ftUqWsafUw8ztzzk2SjaATLPtlFxnhUO7n7zty/Xncg+DTH5yIJ1jrKS1c+JZ62CWu92eo66G+Xi2FjKyVe1LFSshCc7ATVg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mDDbTtCaN7eg5yTlpseeqN/F25GTT/Qerhls62XoNB7MmkRpzWzaY0Pfwu9rY3tAu9TDZo4BN8tq7yupEL9WIVKxwxke3GtfWO9ly2ng86c5gDJ6UQ3/REMcUjo6wRNOuHcSLe9KQ3eMwHCI7CIFwPZqvvVRjCYyWQARaE0NKGnaaLMonoNRnkDcX0aTGCLQvg3kkKSGJbH4k3Y8nfLPsX+stEm2v+4zauB91NrgYKDzK2/5V1Kw6o1H2L/0FDNXyKix+AErez3AudlRPixs66okIJgd390rAfrCdTdn4EwyOtv7vzeAcJqydPsXkJMVI/v0Bpr01dKnLkPGbatmrgzgcVsvFfr/B27Cxtr2ljEZFfqcC0PhmDk9rPFPctXEYe5tALXG/ZmiBUo+PCQKYF8abHE7pI6JmlcPLoaZpOmi6585sXcVO5lTyO1+K0d8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:28:18.7687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa55946-a3af-4c57-c28c-08df337e24fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow probing mlx5 networking devices using multiple rte_device's,
which are associated with single mlx5 common device.
This requires a few changes in probing:

- When going through list of IB devices to check for MPESW
  or bond setups, use owner IB device from common device,
  not the probed device.
- When preparing data for a list of spawned ports,
  keep "probed device" and "owner device" separate.
- Use the name of "probed device" when
  ethdev port name is constructed.
- Any device related to VIRTUAL devlink port,
  which is not an E-Switch owner should be accepted
  as a representor port. Representor devarg is not required.

Patch also extends mlx5_nl_check_switch_info() to query
the flavour of related devlink port if phys_port_name is not available.

As of this patch, probing through associated devices
is only allowed for PCI devices.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c |  95 +++++++++++++++++++++++-
 drivers/common/mlx5/linux/mlx5_nl.h |   4 +-
 drivers/common/mlx5/mlx5_common.h   |   5 ++
 drivers/net/mlx5/linux/mlx5_os.c    | 109 +++++++++++++++++++++-------
 drivers/net/mlx5/mlx5.c             |   3 +-
 drivers/net/mlx5/mlx5.h             |   1 +
 drivers/net/mlx5/mlx5_ethdev.c      |  13 +++-
 drivers/net/mlx5/mlx5_mac.c         |   6 +-
 8 files changed, 199 insertions(+), 37 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index e57007831c..6a22476a15 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -1620,7 +1620,7 @@ mlx5_nl_devlink_port_info_get_cb(struct nlmsghdr *nh, void *arg)
 	return -rte_errno;
 }
 
-static int __rte_unused
+static int
 mlx5_nl_devlink_port_info_get(int nl, int family, struct mlx5_devlink_port_info *info)
 {
 	struct nlmsghdr *nlh;
@@ -1668,6 +1668,8 @@ mlx5_nl_devlink_port_info_get(int nl, int family, struct mlx5_devlink_port_info
  * Analyze gathered port parameters via Netlink to recognize master
  * and representor devices for E-Switch configuration.
  *
+ * @param[in] parent_dev_match
+ *   True if underlying netdev's parent device is the same as for IB device.
  * @param[in] num_vf_set
  *   flag of presence of number of VFs port attribute.
  * @param[inout] switch_info
@@ -1679,7 +1681,8 @@ mlx5_nl_devlink_port_info_get(int nl, int family, struct mlx5_devlink_port_info
  *   recognized parameters (if any).
  */
 static void
-mlx5_nl_check_switch_info(bool num_vf_set,
+mlx5_nl_check_switch_info(bool parent_dev_match,
+			  bool num_vf_set,
 			  struct mlx5_switch_info *switch_info)
 {
 	switch (switch_info->name_type) {
@@ -1714,12 +1717,67 @@ mlx5_nl_check_switch_info(bool num_vf_set,
 		/* New representors naming schema. */
 		switch_info->representor = 1;
 		break;
+	case MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL:
+		switch_info->master = parent_dev_match;
+		switch_info->representor = !parent_dev_match;
+		break;
 	}
 }
 
+static void
+check_virtual_port(struct mlx5_netdev_info *netdev_info,
+		   struct mlx5_switch_info *switch_info)
+{
+	struct mlx5_devlink_port_info devlink_port_info = {
+		.bus_name = netdev_info->devlink_port_bus_name,
+		.dev_name = netdev_info->devlink_port_dev_name,
+		.index = netdev_info->devlink_port_index,
+	};
+	int nl;
+	int family;
+	int ret = 0;
+
+	nl = mlx5_nl_init(NETLINK_GENERIC, 0);
+	if (nl < 0) {
+		DRV_LOG(DEBUG, "Unable to open NETLINK_GENERIC socket");
+		return;
+	}
+
+	family = mlx5_nl_devlink_family_id_get(nl);
+	if (family < 0) {
+		DRV_LOG(DEBUG, "Unable to query devlink genetlink family ID");
+		goto exit_end;
+	}
+
+	if (mlx5_netdev_info_has_devlink_port(netdev_info)) {
+		ret = mlx5_nl_devlink_port_info_get(nl, family, &devlink_port_info);
+	} else {
+		/*
+		 * TODO: Kernel too old. Devlink port must be found by dumping all ports
+		 * and matching by netdev_ifindex. Until this is done, log unsupported.
+		 */
+		DRV_LOG(DEBUG, "Kernel does not expose IFLA_DEVLINK_PORT");
+		ret = -ENOTSUP;
+	}
+
+	if (ret < 0) {
+		DRV_LOG(DEBUG, "Unable to query devlink port flavour");
+		goto exit_end;
+	}
+
+	if ((devlink_port_info.flags & MLX5_DEVLINK_PORT_INFO_FLAG_FLAVOUR) &&
+	    devlink_port_info.flavour == MLX5_DEVLINK_PORT_FLAVOUR_VIRTUAL)
+		switch_info->name_type = MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL;
+
+exit_end:
+	close(nl);
+}
+
 /**
  * Get switch information associated with network interface.
  *
+ * @param cdev
+ *   Pointer to common device.
  * @param nl
  *   Netlink socket of the ROUTE kind (NETLINK_ROUTE).
  * @param ifindex
@@ -1732,12 +1790,15 @@ mlx5_nl_check_switch_info(bool num_vf_set,
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_switch_info)
 int
-mlx5_nl_switch_info(int nl, unsigned int ifindex,
+mlx5_nl_switch_info(struct mlx5_common_device *cdev,
+		    int nl,
+		    unsigned int ifindex,
 		    struct mlx5_switch_info *info)
 {
 	struct mlx5_netdev_info netdev_info = {
 		.ifindex = ifindex,
 	};
+	bool parent_dev_match;
 	bool num_vf_set;
 	int ret;
 
@@ -1756,7 +1817,33 @@ mlx5_nl_switch_info(int nl, unsigned int ifindex,
 
 	if (netdev_info.flags & MLX5_NETDEV_INFO_FLAG_PHYS_SWITCH_ID) {
 		info->switch_id = netdev_info.phys_switch_id;
-		mlx5_nl_check_switch_info(num_vf_set, info);
+
+		if (info->name_type == MLX5_PHYS_PORT_NAME_TYPE_NOTSET)
+			check_virtual_port(&netdev_info, info);
+
+		/* Port type could be updated to virtual. Recheck. */
+		if (info->name_type == MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL) {
+			if (!(netdev_info.flags & MLX5_NETDEV_INFO_FLAG_PARENT_DEV_NAME) ||
+			    !(netdev_info.flags & MLX5_NETDEV_INFO_FLAG_PARENT_DEV_BUS_NAME)) {
+				DRV_LOG(ERR, "ifindex %u cannot get parent dev", ifindex);
+				rte_errno = EINVAL;
+				return -rte_errno;
+			}
+
+			strlcpy(info->parent_dev_bus_name, netdev_info.parent_dev_bus_name,
+				sizeof(info->parent_dev_bus_name));
+			strlcpy(info->parent_dev_name, netdev_info.parent_dev_name,
+				sizeof(info->parent_dev_name));
+
+			parent_dev_match = mlx5_dev_matches(cdev->dev,
+							    netdev_info.parent_dev_bus_name,
+							    netdev_info.parent_dev_name);
+		} else {
+			/* Irrelevant for other port flavours. */
+			parent_dev_match = false;
+		}
+
+		mlx5_nl_check_switch_info(parent_dev_match, num_vf_set, info);
 	}
 
 	if (info->master && info->representor) {
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 0a9aab6610..7663864e56 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -144,7 +144,9 @@ __rte_internal
 int mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 			       struct rte_ether_addr *mac, int vf_index);
 __rte_internal
-int mlx5_nl_switch_info(int nl, unsigned int ifindex,
+int mlx5_nl_switch_info(struct mlx5_common_device *cdev,
+			int nl,
+			unsigned int ifindex,
 			struct mlx5_switch_info *info);
 
 __rte_internal
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 548f0c887b..fb73b3a038 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -152,6 +152,7 @@ enum mlx5_nl_phys_port_name_type {
 	MLX5_PHYS_PORT_NAME_TYPE_PFVF, /* pf0vf0, kernel ver >= 5.0 */
 	MLX5_PHYS_PORT_NAME_TYPE_PFHPF, /* pf0, kernel ver >= 5.7, HPF rep */
 	MLX5_PHYS_PORT_NAME_TYPE_PFSF, /* pf0sf0, kernel ver >= 5.0 */
+	MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL, /* Virtual devlink port. */
 	MLX5_PHYS_PORT_NAME_TYPE_UNKNOWN, /* Unrecognized. */
 };
 
@@ -169,6 +170,8 @@ struct mlx5_dev_info {
 	struct mlx5_port_nl_info *port_info;
 };
 
+#define MLX5_SWITCH_INFO_PARENT_DEV_NAME_MAX (128)
+
 /** Switch information returned by mlx5_nl_switch_info(). */
 struct mlx5_switch_info {
 	uint32_t master:1; /**< Master device. */
@@ -179,6 +182,8 @@ struct mlx5_switch_info {
 	int32_t port_name; /**< Representor port name. */
 	int32_t mpesw_owner; /**< MPESW owner port number. */
 	uint64_t switch_id; /**< Switch identifier. */
+	char parent_dev_bus_name[MLX5_SWITCH_INFO_PARENT_DEV_NAME_MAX];
+	char parent_dev_name[MLX5_SWITCH_INFO_PARENT_DEV_NAME_MAX];
 };
 
 /* CQE status. */
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 1b1b1bb013..83c9774443 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1122,6 +1122,9 @@ build_port_name(struct rte_device *dpdk_dev,
 		written += ret;
 		if (written >= (int)name_sz)
 			return written;
+	} else if (spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL) {
+		/* All relevant information was put in the name. Finish here. */
+		goto end;
 	} else if (spawn->info.representor) {
 		/*
 		 * If port is a representor, then switchdev has been enabled.
@@ -1249,6 +1252,13 @@ mlx5_representor_match(struct mlx5_dev_spawn_data *spawn,
 	bool ignore_ctrl_num = eth_da->nb_mh_controllers == 0 ||
 			       switch_info->name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK;
 
+	/*
+	 * Representor on virtual devlink port always match.
+	 * Probing logic filters out unwanted ports before mlx5_dev_spawn() is reached.
+	 */
+	if (switch_info->name_type == MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL)
+		return true;
+
 	switch (eth_da->type) {
 	case RTE_ETH_REPRESENTOR_PF:
 		if (switch_info->name_type != MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
@@ -1299,8 +1309,6 @@ mlx5_representor_match(struct mlx5_dev_spawn_data *spawn,
 /**
  * Spawn an Ethernet device from Verbs information.
  *
- * @param dpdk_dev
- *   Backing DPDK device.
  * @param spawn
  *   Verbs device parameters (name, port, switch_info) to spawn.
  * @param eth_da
@@ -1316,11 +1324,11 @@ mlx5_representor_match(struct mlx5_dev_spawn_data *spawn,
  *   EEXIST: device is already spawned
  */
 static struct rte_eth_dev *
-mlx5_dev_spawn(struct rte_device *dpdk_dev,
-	       struct mlx5_dev_spawn_data *spawn,
+mlx5_dev_spawn(struct mlx5_dev_spawn_data *spawn,
 	       struct rte_eth_devargs *eth_da,
 	       struct mlx5_kvargs_ctrl *mkvlist)
 {
+	struct rte_device *dpdk_dev = spawn->dpdk_dev;
 	const struct mlx5_switch_info *switch_info = &spawn->info;
 	struct mlx5_dev_ctx_shared *sh = NULL;
 	struct ibv_port_attr port_attr = { .state = IBV_PORT_NOP };
@@ -2477,6 +2485,7 @@ calc_nb_uplinks_hpfs(struct ibv_device **ibv_match,
  */
 static int
 mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
+		     struct rte_device *dev,
 		     struct rte_eth_devargs *req_eth_da,
 		     uint16_t owner_id, struct mlx5_kvargs_ctrl *mkvlist)
 {
@@ -2511,13 +2520,22 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 	 *  >= 0 - MPESW device. Value is the port index of the MPESW owner.
 	 */
 	int mpesw = MLX5_MPESW_PORT_INVALID;
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(cdev->dev, *pci_dev);
+	struct rte_pci_device *owner_pci_dev;
 	struct mlx5_dev_spawn_data *list = NULL;
 	struct rte_eth_devargs eth_da = *req_eth_da;
-	struct rte_pci_addr owner_pci = pci_dev->addr; /* Owner PF. */
+	struct rte_pci_addr owner_pci; /* Owner PF. */
 	struct mlx5_bond_info bond_info;
 	int ret = -1;
 
+	if (!mlx5_dev_is_pci(cdev->dev)) {
+		DRV_LOG(ERR, "Owner device is not PCI: dev %s owner %s",
+			dev->name, cdev->dev->name);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	owner_pci_dev = RTE_BUS_DEVICE(cdev->dev, *owner_pci_dev);
+	owner_pci = owner_pci_dev->addr;
+
 	errno = 0;
 	ibv_list = mlx5_glue->get_device_list(&ret);
 	if (!ibv_list) {
@@ -2699,8 +2717,9 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			list[ns].phys_port = i;
 			list[ns].phys_dev_name = ibv_match[0]->name;
 			list[ns].eth_dev = NULL;
-			list[ns].pci_dev = pci_dev;
+			list[ns].pci_dev = owner_pci_dev;
 			list[ns].cdev = cdev;
+			list[ns].dpdk_dev = dev;
 			list[ns].pf_bond = bd;
 			list[ns].mpesw_port = MLX5_MPESW_PORT_INVALID;
 			list[ns].ifindex = mlx5_nl_ifindex(nl_rdma,
@@ -2718,7 +2737,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			}
 			ret = -1;
 			if (nl_route >= 0)
-				ret = mlx5_nl_switch_info(nl_route,
+				ret = mlx5_nl_switch_info(cdev, nl_route,
 							  list[ns].ifindex,
 							  &list[ns].info);
 			if (ret || (!list[ns].info.representor &&
@@ -2731,6 +2750,11 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 				ret = mlx5_sysfs_switch_info(list[ns].ifindex,
 							     &list[ns].info);
 			}
+			/* Allow usage of associated devices only for VIRTUAL devlink ports. */
+			if (!ret &&
+			    list[ns].info.name_type != MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL &&
+			    cdev->dev != dev)
+				continue;
 			if (!ret && bd >= 0) {
 				switch (list[ns].info.name_type) {
 				case MLX5_PHYS_PORT_NAME_TYPE_UPLINK:
@@ -2790,13 +2814,26 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 					list[ns].info.mpesw_owner = mpesw;
 					ns++;
 					break;
+				case MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL:
+					list[ns].mpesw_port = mpesw;
+					list[ns].info.mpesw_owner = mpesw;
+					/* Spawn the device if and only if it matches. */
+					if (mlx5_dev_matches(list[ns].dpdk_dev,
+							     list[ns].info.parent_dev_bus_name,
+							     list[ns].info.parent_dev_name))
+						ns++;
+					break;
 				default:
 					break;
 				}
 				continue;
 			}
-			if (!ret && (list[ns].info.representor ^
-				     list[ns].info.master))
+			if (!ret && list[ns].info.name_type == MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL) {
+				if (mlx5_dev_matches(list[ns].dpdk_dev,
+						     list[ns].info.parent_dev_bus_name,
+						     list[ns].info.parent_dev_name))
+					ns++;
+			} else if (!ret && (list[ns].info.representor ^ list[ns].info.master))
 				ns++;
 		}
 	} else {
@@ -2824,8 +2861,9 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			list[ns].phys_port = 1;
 			list[ns].phys_dev_name = ibv_match[i]->name;
 			list[ns].eth_dev = NULL;
-			list[ns].pci_dev = pci_dev;
+			list[ns].pci_dev = owner_pci_dev;
 			list[ns].cdev = cdev;
+			list[ns].dpdk_dev = dev;
 			list[ns].pf_bond = -1;
 			list[ns].mpesw_port = MLX5_MPESW_PORT_INVALID;
 			list[ns].ifindex = 0;
@@ -2872,7 +2910,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			}
 			ret = -1;
 			if (nl_route >= 0)
-				ret = mlx5_nl_switch_info(nl_route,
+				ret = mlx5_nl_switch_info(cdev, nl_route,
 							  list[ns].ifindex,
 							  &list[ns].info);
 			if (ret || (!list[ns].info.representor &&
@@ -2885,6 +2923,11 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 				ret = mlx5_sysfs_switch_info(list[ns].ifindex,
 							     &list[ns].info);
 			}
+			/* Allow usage of associated devices only for VIRTUAL devlink ports. */
+			if (!ret &&
+			    list[ns].info.name_type != MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL &&
+			    cdev->dev != dev)
+				continue;
 			if (!ret && (list[ns].info.representor ^
 				     list[ns].info.master)) {
 				ns++;
@@ -2921,7 +2964,12 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			list[0].info.representor = 0;
 		}
 	}
-	MLX5_ASSERT(ns);
+	if (ns == 0) {
+		DRV_LOG(ERR, "Unable to match any IB port to probed device");
+		rte_errno = ENOENT;
+		ret = -rte_errno;
+		goto exit;
+	}
 	/* Calculate number of uplinks and host PFs for each matched IB device. */
 	calc_nb_uplinks_hpfs(ibv_match, nd, list, ns);
 	/*
@@ -2934,7 +2982,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 		if (eth_da.nb_ports == 0 && ns > 0) {
 			if (list[0].pf_bond >= 0 && list[0].info.representor)
 				DRV_LOG(WARNING, "Representor on Bonding device should use pf#vf# syntax: %s",
-					pci_dev->device.devargs->args);
+					dev->devargs->args);
 			eth_da.nb_ports = 1;
 			eth_da.ports[0] = list[0].info.port_name;
 		}
@@ -2946,8 +2994,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 	for (i = 0; i != ns; ++i) {
 		uint32_t restore;
 
-		list[i].eth_dev = mlx5_dev_spawn(cdev->dev, &list[i], &eth_da,
-						 mkvlist);
+		list[i].eth_dev = mlx5_dev_spawn(&list[i], &eth_da, mkvlist);
 		if (!list[i].eth_dev) {
 			if (rte_errno != EBUSY && rte_errno != EEXIST)
 				break;
@@ -2955,7 +3002,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			continue;
 		}
 		restore = list[i].eth_dev->data->dev_flags;
-		rte_eth_copy_pci_info(list[i].eth_dev, pci_dev);
+		rte_eth_copy_pci_info(list[i].eth_dev, list[i].pci_dev);
 		/**
 		 * Each representor has a dedicated interrupts vector.
 		 * rte_eth_copy_pci_info() assigns PF interrupts handle to
@@ -3070,21 +3117,22 @@ mlx5_os_parse_eth_devargs(struct rte_device *dev,
  */
 static int
 mlx5_os_pci_probe(struct mlx5_common_device *cdev,
+		  struct rte_device *dev,
 		  struct mlx5_kvargs_ctrl *mkvlist)
 {
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(cdev->dev, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
 	struct rte_eth_devargs eth_da = { .nb_ports = 0 };
 	int ret = 0;
 	uint16_t p;
 
-	ret = mlx5_os_parse_eth_devargs(cdev->dev, &eth_da);
+	ret = mlx5_os_parse_eth_devargs(dev, &eth_da);
 	if (ret != 0)
 		return ret;
 
 	if (eth_da.nb_ports > 0) {
 		/* Iterate all port if devargs pf is range: "pf[0-1]vf[...]". */
 		for (p = 0; p < eth_da.nb_ports; p++) {
-			ret = mlx5_os_pci_probe_pf(cdev, &eth_da,
+			ret = mlx5_os_pci_probe_pf(cdev, dev, &eth_da,
 						   eth_da.ports[p], mkvlist);
 			if (ret) {
 				DRV_LOG(INFO, "Probe of PCI device " PCI_PRI_FMT " "
@@ -3098,7 +3146,7 @@ mlx5_os_pci_probe(struct mlx5_common_device *cdev,
 			}
 		}
 	} else {
-		ret = mlx5_os_pci_probe_pf(cdev, &eth_da, 0, mkvlist);
+		ret = mlx5_os_pci_probe_pf(cdev, dev, &eth_da, 0, mkvlist);
 	}
 	return ret;
 }
@@ -3106,6 +3154,7 @@ mlx5_os_pci_probe(struct mlx5_common_device *cdev,
 /* Probe a single SF device on auxiliary bus, no representor support. */
 static int
 mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
+			struct rte_device *dev,
 			struct mlx5_kvargs_ctrl *mkvlist)
 {
 	struct rte_eth_devargs eth_da = { .nb_ports = 0 };
@@ -3113,11 +3162,16 @@ mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
 		.pf_bond = -1,
 		.mpesw_port = MLX5_MPESW_PORT_INVALID,
 	};
-	struct rte_device *dev = cdev->dev;
 	struct rte_auxiliary_device *adev = RTE_BUS_DEVICE(dev, *adev);
 	struct rte_eth_dev *eth_dev;
 	int ret = 0;
 
+	if (cdev->dev != dev) {
+		DRV_LOG(ERR, "Invalid device %s used to probe common device %s",
+			dev->name, cdev->dev->name);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
 	/* Parse ethdev devargs. */
 	ret = mlx5_os_parse_eth_devargs(dev, &eth_da);
 	if (ret != 0)
@@ -3133,8 +3187,9 @@ mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
 	}
 	spawn.ifindex = ret;
 	spawn.cdev = cdev;
+	spawn.dpdk_dev = dev;
 	/* Spawn device. */
-	eth_dev = mlx5_dev_spawn(dev, &spawn, &eth_da, mkvlist);
+	eth_dev = mlx5_dev_spawn(&spawn, &eth_da, mkvlist);
 	if (eth_dev == NULL)
 		return -rte_errno;
 	/* Post create. */
@@ -3165,7 +3220,7 @@ mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
  */
 int
 mlx5_os_net_probe(struct mlx5_common_device *cdev,
-		  struct rte_device *dev __rte_unused,
+		  struct rte_device *dev,
 		  struct mlx5_kvargs_ctrl *mkvlist)
 {
 	int ret;
@@ -3184,10 +3239,10 @@ mlx5_os_net_probe(struct mlx5_common_device *cdev,
 			strerror(rte_errno));
 		return -rte_errno;
 	}
-	if (mlx5_dev_is_pci(cdev->dev))
-		return mlx5_os_pci_probe(cdev, mkvlist);
+	if (mlx5_dev_is_pci(dev))
+		return mlx5_os_pci_probe(cdev, dev, mkvlist);
 	else
-		return mlx5_os_auxiliary_probe(cdev, mkvlist);
+		return mlx5_os_auxiliary_probe(cdev, dev, mkvlist);
 }
 
 /**
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 615b2ff943..9dc3402e22 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3881,7 +3881,7 @@ mlx5_net_remove(struct mlx5_common_device *cdev)
 	uint16_t port_id;
 	int ret = 0;
 
-	RTE_ETH_FOREACH_DEV_OF(port_id, cdev->dev) {
+	MLX5_ETH_FOREACH_SIBLING(port_id, cdev) {
 		/*
 		 * mlx5_dev_close() is not registered to secondary process,
 		 * call the close function explicitly for secondary process.
@@ -3999,6 +3999,7 @@ static struct mlx5_class_driver mlx5_net_driver = {
 	.probe = mlx5_os_net_probe,
 	.remove = mlx5_net_remove,
 	.probe_again = 1,
+	.probe_associated = 1,
 	.intr_lsc = 1,
 	.intr_rmv = 1,
 };
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index e4ebdd4c2f..de969c0b2e 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -234,6 +234,7 @@ struct mlx5_dev_spawn_data {
 	const char *phys_dev_name; /**< Name of physical device. */
 	struct rte_eth_dev *eth_dev; /**< Associated Ethernet device. */
 	struct rte_pci_device *pci_dev; /**< Backend PCI device. */
+	struct rte_device *dpdk_dev; /**< Backend DPDK device. */
 	struct mlx5_common_device *cdev; /**< Backend common device. */
 	struct mlx5_bond_info *bond_info;
 };
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index f41724725c..115b67ffdf 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -472,6 +472,8 @@ mlx5_representor_id_encode(const struct mlx5_switch_info *info,
 		type = RTE_ETH_REPRESENTOR_PF;
 		pf = info->mpesw_owner;
 		break;
+	case MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL:
+		return UINT16_MAX;
 	case MLX5_PHYS_PORT_NAME_TYPE_PFSF:
 		type = RTE_ETH_REPRESENTOR_SF;
 		break;
@@ -507,10 +509,13 @@ mlx5_representor_info_count_one(struct mlx5_priv *priv)
 	case MLX5_PHYS_PORT_NAME_TYPE_PFSF:
 		/* FALLTHROUGH */
 	case MLX5_PHYS_PORT_NAME_TYPE_UNKNOWN:
-		/* FALLTHROUGH */
-	default:
 		return 1;
+	case MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL:
+		return 0;
 	}
+
+	/* Suppress "control reaches end of non-void function" warning without adding "default". */
+	return 0;
 }
 
 static unsigned int
@@ -606,6 +611,10 @@ mlx5_representor_info_fill_one(struct mlx5_priv *priv,
 		range->id_end = range->id_base;
 		snprintf(range->name, sizeof(range->name), "pf%dvf", range->pf);
 		break;
+	case MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL:
+		/* Rejected by mlx5_representor_info_count_one() */
+		MLX5_ASSERT(false);
+		break;
 	}
 
 	info->nb_ranges += count;
diff --git a/drivers/net/mlx5/mlx5_mac.c b/drivers/net/mlx5/mlx5_mac.c
index 8cbaaf67dd..2ee8580f14 100644
--- a/drivers/net/mlx5/mlx5_mac.c
+++ b/drivers/net/mlx5/mlx5_mac.c
@@ -177,10 +177,12 @@ mlx5_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 	 * need to skip the special cases:
 	 * - HPF on BlueField,
 	 * - SF representors,
-	 * - uplink ports when running in MPESW mode.
+	 * - uplink ports when running in MPESW mode,
+	 * - VIRTUAL switch ports (nested E-Switch).
 	 */
 	if (priv->representor && !mlx5_is_hpf(dev) && !mlx5_is_sf_repr(dev) &&
-	    !priv->mpesw_uplink) {
+	    !priv->mpesw_uplink &&
+	    priv->port_info.type != MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL) {
 		DRV_LOG(DEBUG, "VF represented by port %u setting primary MAC address",
 			dev->data->port_id);
 		if (priv->pf_bond >= 0) {
-- 
2.43.0

