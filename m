Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBACCA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 09:10:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2788A40651;
	Fri, 29 Aug 2025 11:10:22 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by mails.dpdk.org (Postfix) with ESMTP id 38BF84060F
 for <dev@dpdk.org>; Fri, 29 Aug 2025 11:10:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJVBhor0H6E7b+K7g6u8mWOKP2YyEuEC6d6C0wCoG+qQ7RyZgcplsLjvoZlgGQBS84Srs5OfF4uoVpAGSjvl+K708tpcXT7t4sVCxUu3WSSykXxqzSVwJBNyOeNmM6XoAHtGgfWK2VFSNyTT/UHip3RyY0KWYS/zV8TQNUGo5u+RoYCElM0xqFKRQSbXCJChQTxQrpWAr8xAHon5Q05wKb43JjOdhqvz34JZFvMg7mItLH9gsCWWk18DolHydGp/BZA0shuDGz/zBwoBATx6S1Or88mWg9unHXHL16esAHnJxRmby7lzX4GL+uM0oYX6r6V0b1qoeUINiNEhBezLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI0i3W0QCxaiPu/owhErscwSgfm14Adm8ZzF7JaXxnM=;
 b=GnvpgDmLa5yfnQoF3B0eDkMjMQn6Um/VfjPS6RC/U1og6VE3hkjRyEOTKAvdpnSOpAdTAUFtoy8vm28j5qM811ihbW2ei8V/3m+Iboggaflrj+a2axCd/eL4TTo49HPhunnoD/KL3vg0N7eoJvgkn1ATDp9AdNeG8IPK4LKRcyDHrgNvHfFta3PMk9vIvgYDBfIJTZZ43HFCJoQcxkd9qLI4ZVXVYCFfndQ1RHoW22Sl7to92/2kWCGXUrVfX7jTtAZgr1L1G2hmjHFtgKMUgi65ZcZN4vaPheqVUz7dotV8T14Wi0rJGITDiCKSXhHkeskjYru0roAeyBJTrBT5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI0i3W0QCxaiPu/owhErscwSgfm14Adm8ZzF7JaXxnM=;
 b=dmN/962lYsZDxcYc/3511XZzDEC+js+CCKyC1N1+joWDyVTIu0hbmkgQOgnzmcLiImg9LKPk35QlQDKOyE5BDqNiVxaC3vre+lCCjawNmsKT1pUPJAWYNV69hE+3Qu5VwzNBsHXDjZQvMSiOLS+ejrjN/q6j9JBB1RgRjUYLiT2zJuH71u9ZmwIa/q03b1UNFs0ZYE3VjjIJP4AqZkNgkb9FTlrA+YvUWRH620uJzoNMRjkFLtDNHQGnKHRJrszTFpW2rsdDQFpQPlgEhNBG30zxShRQsyM23XAOrbS8fyKTlRuG8hz3OCgO3o3VCKUK+zqpIToErgF88UeQBIrQYA==
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 09:10:10 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f1) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 09:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Fri, 29 Aug 2025 09:10:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 02:09:53 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 02:09:50 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH V4 1/2] net/mlx5: update how MAC address bit-fields are used
Date: Fri, 29 Aug 2025 12:08:29 +0300
Message-ID: <20250829090830.1049176-2-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829090830.1049176-1-gavinl@nvidia.com>
References: <20250825141322.974335-3-gavinl@nvidia.com>
 <20250829090830.1049176-1-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: a19171da-a28c-44f4-5d69-08dde6dbda7f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0IqMYBM0SrpQ4ueK9IXVLAW7YLDv92WyIdyOqB00lGAmeX3SWPYt1J2qKgR+?=
 =?us-ascii?Q?B7dSqsj8vDIOxzLDC9frinIRIj32Im6UV7KmWaDSP3wV/rQy4gQKwlPdzhpo?=
 =?us-ascii?Q?Jt/BTMH/oCTnRbBEwxuNE4bva1hpIChe/fUwJLchHa2YMjgVTeKKBFLk/mh5?=
 =?us-ascii?Q?Z+cig/8VreYaHe6rfgEl9Cb7Yud5pMLOcDjNL+B8CAbtUc7y/2TSboc6CJ1u?=
 =?us-ascii?Q?pasTGpGxtPhWdkWtGVQBAaVzzK85Gqu2iUdJcAGn/57Jtuev9y7i5urs/fE/?=
 =?us-ascii?Q?Q4aSl3fsbV2ENGQ85nw8qhET96EKBZPTqJzS8Bu/Qchr/6L76fpWBnEFyDFb?=
 =?us-ascii?Q?Fg21+aKlokZe02s7TGf662L1+V/FA+l3Scf5IjXvKs7CI+n4wWMb0YF/nB9w?=
 =?us-ascii?Q?zbKKn/MUTLZ9XFFh/jxfkJHSotekVkjq3hLQGTz6ozgy7/QM2Wy/6Vi0YjJY?=
 =?us-ascii?Q?cGFpmX97HbkpwkzCm/sBxWjiLbDJgLmR4ELCMrMx0gzv1GJjuaTWFlgwIXCj?=
 =?us-ascii?Q?aFpmC7EvMrQ7YFpSVirZ9MU1FDZ83untGKLil2qgv/YSLByiiwz1vpTs688h?=
 =?us-ascii?Q?dS94eLdeXPJ2gilxyhOMufhl4t4b8QSOsoDx5dYT9r6E/+OpSxRqVQ1w9B7X?=
 =?us-ascii?Q?m894QBqRCePBFAWEh5Bt41EmaliJ8ZhD9fAPfvTX7Ds+bJliDMiS9WlGs0+H?=
 =?us-ascii?Q?FrhlWZCrOqJPkVL1ZCz5MXeGvSISECxRI4YVXQzA2CG+MEIhIjIfhcj2n1QB?=
 =?us-ascii?Q?C1QQO2GaF7ZL9xH/q3nqaghkgLJIgVl2NwoLKFdchloSbD9pr2ryvUprCMG2?=
 =?us-ascii?Q?boPkYPvkU0DNtgnRQg1YtnzSKNj85UoTtrQUnt7sfLDair+h43jiZiusoA6a?=
 =?us-ascii?Q?UhGJtKMVPOyG44aJBabiZH4Nbkp3XfSmFNDQM1MKenwLclFiwhfJUBJ0Wy79?=
 =?us-ascii?Q?gUYog2Z34TlEmAluerQvCmKY/kCEHs5OhdSJQ7SJLn9nQoG/f5q2rA6mkgbl?=
 =?us-ascii?Q?1XioPwUnA50zX17wBTAxAcbsxstILYa7ap5tk1X9x1nlVS7I3xGn90OBiQYm?=
 =?us-ascii?Q?RuNkuugvJCzCpaOAZH8LhaRbkOhXnMQoluJdTzjjm2GoigS1scvsWYKYSm96?=
 =?us-ascii?Q?nNbnzzSKtS2X9HD2TqN3Ii0VhrinlvoEWf5tuB5rjuQJOPhssX7EeFoqTHaO?=
 =?us-ascii?Q?L5PDrGS9SvqEWAR/ud6vDWN6e9KVvHrlCdZ3WdQOOXTz9V2o0MTvLkBOguBe?=
 =?us-ascii?Q?xlzKY0PUXYmSrxkxdfuUpRC5p03qfHToYukum65tBCzSydQuLp/6ddVY08m0?=
 =?us-ascii?Q?ADBsxomvkDrl+ilfXQByBDcp/IlDDFVcEOu0V7GilPUou1JVIhZkXrLFseq7?=
 =?us-ascii?Q?C4f0nsTizp1MApozgqXesf/fbX/LNzRqympJSIGhthhOwyTDkoAntDf/tDnr?=
 =?us-ascii?Q?cBaNdc6NCRda4why9CwPMPfAOUyBuQ/CMFqJg0oNG81Ssx/2gEBoyhgx4/kT?=
 =?us-ascii?Q?W008ANanjknu70jDxfzMP+viVrmoh9jo3wG6?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 09:10:09.3330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19171da-a28c-44f4-5d69-08dde6dbda7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707
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

Previously, mac_own was a bit-field indicating the MAC addresses owned by
the PMD, specifically marking those added to VFs by the PMD and allowing
them to be flushed during exit.

With this commit, the bit-field now applies to all MAC addresses added by
the PMD, including those for PF, VF, and SFs.

This patch does not introduce any changes in behavior; it continues to
flush only the MAC added for VF, just as before. It serves as preparation
for addressing the multicast MAC address issue.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 26 ++++++++++++--------------
 drivers/common/mlx5/linux/mlx5_nl.h |  8 ++++----
 drivers/net/mlx5/linux/mlx5_os.c    | 12 +++++++++---
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index dd69e229e3..1c2f15ad8a 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -721,8 +721,6 @@ mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
  *   Netlink socket file descriptor.
  * @param[in] iface_idx
  *   Net device interface index.
- * @param mac_own
- *   BITFIELD_DECLARE array to store the mac.
  * @param mac
  *   MAC address to register.
  * @param index
@@ -734,8 +732,7 @@ mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_add)
 int
 mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
-		     uint64_t *mac_own, struct rte_ether_addr *mac,
-		     uint32_t index)
+		     struct rte_ether_addr *mac, uint32_t index)
 {
 	int ret;
 
@@ -744,8 +741,6 @@ mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
 		MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
 		if (index >= MLX5_MAX_MAC_ADDRESSES)
 			return -EINVAL;
-
-		BITFIELD_SET(mac_own, index);
 	}
 	if (ret == -EEXIST)
 		return 0;
@@ -759,8 +754,6 @@ mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
  *   Netlink socket file descriptor.
  * @param[in] iface_idx
  *   Net device interface index.
- * @param mac_own
- *   BITFIELD_DECLARE array to store the mac.
  * @param mac
  *   MAC address to remove.
  * @param index
@@ -771,14 +764,13 @@ mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_remove)
 int
-mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx, uint64_t *mac_own,
+mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx,
 			struct rte_ether_addr *mac, uint32_t index)
 {
 	MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
 	if (index >= MLX5_MAX_MAC_ADDRESSES)
 		return -EINVAL;
 
-	BITFIELD_RESET(mac_own, index);
 	return mlx5_nl_mac_addr_modify(nlsk_fd, iface_idx, mac, 0);
 }
 
@@ -850,12 +842,14 @@ mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
  *   @p mac_addrs array size.
  * @param mac_own
  *   BITFIELD_DECLARE array to store the mac.
+ * @param vf
+ *   Flag for a VF device.
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_flush)
 void
 mlx5_nl_mac_addr_flush(int nlsk_fd, unsigned int iface_idx,
 		       struct rte_ether_addr *mac_addrs, int n,
-		       uint64_t *mac_own)
+		       uint64_t *mac_own, bool vf)
 {
 	int i;
 
@@ -865,9 +859,13 @@ mlx5_nl_mac_addr_flush(int nlsk_fd, unsigned int iface_idx,
 	for (i = n - 1; i >= 0; --i) {
 		struct rte_ether_addr *m = &mac_addrs[i];
 
-		if (BITFIELD_ISSET(mac_own, i))
-			mlx5_nl_mac_addr_remove(nlsk_fd, iface_idx, mac_own, m,
-						i);
+		if (BITFIELD_ISSET(mac_own, i)) {
+			if (vf)
+				mlx5_nl_mac_addr_remove(nlsk_fd,
+							iface_idx,
+							m, i);
+			BITFIELD_RESET(mac_own, i);
+		}
 	}
 }
 
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 26923a88fd..3f79a73c85 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -56,19 +56,19 @@ struct mlx5_nl_port_info {
 __rte_internal
 int mlx5_nl_init(int protocol, int groups);
 __rte_internal
-int mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx, uint64_t *mac_own,
+int mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
 			 struct rte_ether_addr *mac, uint32_t index);
 __rte_internal
 int mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx,
-			    uint64_t *mac_own, struct rte_ether_addr *mac,
-			    uint32_t index);
+			    struct rte_ether_addr *mac, uint32_t index);
 __rte_internal
 void mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
 			   struct rte_ether_addr *mac_addrs, int n);
 __rte_internal
 void mlx5_nl_mac_addr_flush(int nlsk_fd, unsigned int iface_idx,
 			    struct rte_ether_addr *mac_addrs, int n,
-			    uint64_t *mac_own);
+			    uint64_t *mac_own,
+			    bool vf);
 __rte_internal
 int mlx5_nl_promisc(int nlsk_fd, unsigned int iface_idx, int enable);
 __rte_internal
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 85b3fabaf5..dda51a138e 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3223,8 +3223,10 @@ mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 
 	if (vf)
 		mlx5_nl_mac_addr_remove(priv->nl_socket_route,
-					mlx5_ifindex(dev), priv->mac_own,
+					mlx5_ifindex(dev),
 					&dev->data->mac_addrs[index], index);
+	if (index < MLX5_MAX_MAC_ADDRESSES)
+		BITFIELD_RESET(priv->mac_own, index);
 }
 
 /**
@@ -3250,8 +3252,11 @@ mlx5_os_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 
 	if (vf)
 		ret = mlx5_nl_mac_addr_add(priv->nl_socket_route,
-					   mlx5_ifindex(dev), priv->mac_own,
+					   mlx5_ifindex(dev),
 					   mac, index);
+	if (!ret)
+		BITFIELD_SET(priv->mac_own, index);
+
 	return ret;
 }
 
@@ -3331,8 +3336,9 @@ void
 mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
+	const int vf = priv->sh->dev_cap.vf;
 
 	mlx5_nl_mac_addr_flush(priv->nl_socket_route, mlx5_ifindex(dev),
 			       dev->data->mac_addrs,
-			       MLX5_MAX_MAC_ADDRESSES, priv->mac_own);
+			       MLX5_MAX_MAC_ADDRESSES, priv->mac_own, vf);
 }
-- 
2.34.1

