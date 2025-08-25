Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B40CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 14:15:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC0FE402DC;
	Mon, 25 Aug 2025 16:15:05 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by mails.dpdk.org (Postfix) with ESMTP id 46670402DC
 for <dev@dpdk.org>; Mon, 25 Aug 2025 16:15:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVvmVj2Uxhq/sX9e0WfHjdj1ppTqQPFed8VN9p4OKittHQGPsi3D1Ytomj8T8VdrUzeC5Z3SXN+Ciq4X8qpNJded3otOTKaj7zq+UNHMxPe6/mNhYF/42DYWZkfSy2lhgr3Jivj/Iir3tygFDPDXEmwXiQHABt3+bUJLG9t4ufLXWkOO1KKAVtwVERArWl4GHvC3dj+fPTbzHMWQ+0NfGMh61SBtPJOz4DnslUKI1aDEnNOkkusepBex+/0Tk15zsm2WyULKOKdVTvLXxxie51twgtiAabNGECuaALSQ6fuQ2jh883EJ3ewjnr2HE7XGtXAgbQ72z7B0iAp5unbFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gBrudSa/yZLU8W+Q6Bjfqqgcs/Ql0YseHRnQNTDWl0=;
 b=ExU7k1Oe51qIo1blm51z84QiXLVPT/LrtQ5huBk1iCWB8YI/0TeMwFMSMWH0dUcG8IbitAvMvTgm11vxZATYZGjvvMRETNiS5VpOYfsFZiz0TnZWhI55bCsjJuTuEn5iFaK+GtDblr3GZPH2xg6c/lGTmuwCRQ4VmBq2vQKTiYmDhaE38fWxastVVwTf0WRGHSay/gIOp7DkdUBt7hU/J1ecK13tJxq7lGlDon+nGuYkR/N07i8PyFhXrwb/tU5RFadxREan+sIiwpE+H2PBXTK0O+/93urxmBYRqIPTk4R7NrRRtOgdhZ1d/1U8J0EfGTmBlRoKs4OwaK5ftpttFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gBrudSa/yZLU8W+Q6Bjfqqgcs/Ql0YseHRnQNTDWl0=;
 b=lUu9M2HdEh5rHlkKq6wZGbF8LyVU8Gcn6npsUMGZUMu+xcHrXK4K3hQDyjdfkCKgh2iZhpvGAgAuld/6t4XbDdEV09ZO/VRAPBSrYxdNX5HJtu+KnzDii8Cduu/Of0WaeX3yQDsQKtBEM7UPF+ZpDE05n2NiVowSqtt0TspVOzXNHGzrqLyBVyhNNYDQFDyje9kmTJlRqUoZmEFWz19hLKfHItllSGVoFBKPOZTiLbJqfM5j/Dp3Iacf4J+7IoaM5szeiX4mNvrKpEHC/DaOUZ7oQbnXn1s2lWvadMeJmvaOw5kwBrLLarq/0xiQ2TzQpof7r7N3Q8oLC/zamCP4GQ==
Received: from CH0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:610:e7::34)
 by CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 14:15:00 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::ab) by CH0PR03CA0239.outlook.office365.com
 (2603:10b6:610:e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 14:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:15:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:14:42 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:14:39 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH V3 1/2] net/mlx5: update how MAC address bit-fields are used
Date: Mon, 25 Aug 2025 17:13:21 +0300
Message-ID: <20250825141322.974335-2-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825141322.974335-1-gavinl@nvidia.com>
References: <20250825141322.974335-1-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CY1PR12MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 924e90f1-361d-4ce9-1432-08dde3e1c703
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AppGavivo9llI6K4hsrVEhhB+05R77sYn+grmze8rxO/A/Jpvo7pKu696a7Y?=
 =?us-ascii?Q?xQgzPBBr87sCkxUw6PloHDatTZnj9MG6s+Fhd7t/T08iFBJvjHxLNxfw1Zsd?=
 =?us-ascii?Q?c9I53DLsChoisEOH/TzThczqu8y7kKItK76wP50vfo//bteYqVD7yJCecqEg?=
 =?us-ascii?Q?MUw4VLRjhQkQS0ljLc4mbKfDZIsvp0oCMYDsfr/8EmGGgcl0ODSrECp7NwRB?=
 =?us-ascii?Q?WSn9cy86079rCTaZ813rG6oWFQcd/JiOFuzhsUxl4PFedbgc1cSnWDZxzTka?=
 =?us-ascii?Q?bgdiuBM/WZ4/r8DPr9WRJaSufZ7ZJI2XaI7MsyjTKv4SGX/+Nbc7euLRU34h?=
 =?us-ascii?Q?hfBmhFW4DJx+wMn559l6cxkrbA/jV5oFs6If3mY8R2NdElS1mAVqT6TEJbTm?=
 =?us-ascii?Q?CRXxy0qnLuhcI4L/+uoxsA3PnLeS2vzusawQgkDFjwxAB47Qbvs5mfplnAXN?=
 =?us-ascii?Q?Lf9Ieub35uGpGKYQxMJBIBygODndH/nUzv4JojsMZ1Ne7tHyABSzTV6EPHkp?=
 =?us-ascii?Q?WMGSAtZSzTeFtsWeANIInT3whzyBvKq0smnAPEQxEgvmoaPbUr0veEXVkfKw?=
 =?us-ascii?Q?tlTm1v4zkXRyPTWvNVlQK6vn9syL+V/ClbMPkLtENN/TdLIa86IgWhHEZCdW?=
 =?us-ascii?Q?KlCDgF0dnVxtHtD+dljR4SAnqtHYv2hgih/JNNsJcZeFTa/1+/YAIrJxfvAF?=
 =?us-ascii?Q?ubxGMfGURxVhxDfWbvxpjcaiaDbnsXnsJjwfS9liwbGaXPHwN5cylZoMw1qn?=
 =?us-ascii?Q?sznPpcxyMchFMGoBIZuqJ4u6AlNPjGBDuuMPpcFBGip3N6qiX/Xr6Uc1jHPD?=
 =?us-ascii?Q?L+tkvSXUqWI5POAHvrOLPIjk33qNpfw73EzVBtYZPtKxYQJYYYq26Xt2Dxfk?=
 =?us-ascii?Q?qRBWhk/fyTFID6MVbqczztXdlJPGy9lqBZq2rcnzxFlIUyTDLo34vf9NBdny?=
 =?us-ascii?Q?MaUzZlR+cB6xWv59WxmUxuOfn6oYJpkEvyiYwMVmlW2SL0cEmFpRKPgsWD2X?=
 =?us-ascii?Q?DJDDUQgYcGYWRilLt9IA0QXEisL9HtPXBUJRProV6U9uAE4eN7HtuiHuztfg?=
 =?us-ascii?Q?t+oFNLoF0cTmgyuBCz2ofsNPy4F+F/MjwBVK+HhaGfnDxJ43kUOBpRMxho+W?=
 =?us-ascii?Q?wVohTsjy0nNJzNF6K0xWH/LDJQcDkN6ACndSvmxc+5GXxBTjbKZTtqNlC4Oj?=
 =?us-ascii?Q?OKYpuWPTIGADa8bHJwOEZVuSwEij4wCOhPE4MzIE+nTISmW1BIYZHXxrscyc?=
 =?us-ascii?Q?2d+ZBrLU8kAWvSdf3llKoqLos94mLS6PG3ydYl7xssNXVkG69+ybX2N93zW4?=
 =?us-ascii?Q?aGU1wamFQObRXwQet93lpXJuulKqCQJnIQE1i1ZGEduvn+uNMY+WLUXqyJyi?=
 =?us-ascii?Q?yNZdl9KGXOfSLsYwG+MhkAPp+5z3/V/XXNFv/fvPPq5fYSMAe/Unz+lRkWr3?=
 =?us-ascii?Q?eHdTSSiEs7iTZ2lNM12EYZWWiezbRcApQOw79R1GLhHUo/GpIQBW7KsKhocs?=
 =?us-ascii?Q?vUd/E9zMSrW4jkJ/DpJLL21ICLW+GxT1SnPI?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:15:00.0967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924e90f1-361d-4ce9-1432-08dde3e1c703
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583
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
the PMD, including those for PF, VF, and SFs. The process for flushing MAC
addresses added to VFs by the PMD remains unchanged.

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

