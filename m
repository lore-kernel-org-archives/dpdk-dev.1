Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F73606A32E
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YMrq5Axh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B62840288;
	Fri, 30 Oct 2026 18:29:34 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by mails.dpdk.org (Postfix) with ESMTPS id 9B4C940285;
 Fri, 30 Oct 2026 18:29:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T276xhXWrxUNnAm9pCSB9ZqkOnywHLLufoi3c404o7uLgNsvyWriFFbTn4UbpFW3kTf1i+bY4pE4YpTwz6c/wWUHoomzlb85Bdt9s5WLw8O2Yq3udprOpXVS29rDOu1WxdJoQD+5bdWlIP6rqoUbH4Ijyw8RCta58WCJo1AVhWKmRCW1Pxih1ox8kKjpMDZK4HApXzLQyKHDZj6WpS1+wNGnRAqJCsF6Z4Kz57VXb7nl8GrshzT/p/KtATZ+e16EhV5+4rG9k4N5OMt98wFZf9+8t1+jMBi8bsPvu9M9OEFXCxpxmPIdcAOcD0B0xCUf/L3s5D1sYOBwP4/nvxV6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcS4vBANjxWMkOayZFhgttCQj45VlwEjVlSKoBVavpY=;
 b=mCDoW9B7YH4pAzUJ84NnWglsBkQoH77dBrmnzQX/BnZ/4Bz7GTt/rf4IzxDbNqs9kYAJdlB3SKp3JQ7wrjaLxq6MDsTPRwefkrVzy4j8TD84+0YUiIUfs3nGEyieqBEggOmEp/95C3PqeqyfrfoGu7zkqCMnzHJMb52/oAlFMCPhBU+MQyJtzCBMOFwnru+ThK70cB4Dg57HzY2Qkj5JMtsk1d9+a4qEYGY+/Uly0EC9Jw6vTzY2muLjrcDaxBDxwphvXS3o2urMKSFj9VRfnaipWqx7EZa52PXNL2h3ZDv6AuHtAXlTFHKPwQh/Kbxb22CJb2UdOY58fZmfXtmheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcS4vBANjxWMkOayZFhgttCQj45VlwEjVlSKoBVavpY=;
 b=YMrq5AxhdUIHN5AeKi5J1p+vHMD/2E3JcPeIlvwASHXJpnYVJYl7c3dNova4N2miMAheRp6z5gHcxQtgZk4YRWCAi88JXE4qJU+E7Gk+AScz0ZlDW/V0UWXqK5FwPDy+pjx2sHRZpZTYka47qS4FLBeFtNvvHT93yidySZbSl5ls/NcFYbWD/0LAfiPsylDRLhWkC35g0t9q5CMwMdbNNA/qb1njgKbcxRt22XfZQ75d9UNVMW0+pVpTF5wAvdc8iPFInlGBds40/bpB3z9ZAfZ2wKWBeqOynmzJ3wUPSLyMwU2ooaEAg2LTSdxPAVbornPQyReR3Cq6VL9Q3o58qQ==
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:29:25 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33c::4) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 17:29:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:29:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:29:03 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:59 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>,
 <stable@dpdk.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH v2 1/2] net/mlx5: fix link status query
Date: Fri, 30 Oct 2026 18:28:42 +0100
Message-ID: <20261030172843.2304296-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030172843.2304296-1-dsosnowski@nvidia.com>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
 <20261030172843.2304296-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA0PR12MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c588a5-1b6c-4d25-99e0-08df36ab580d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|4143699003|261028144727099003|261026140227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 3wHScGLtGBu8h1S2qTpXkbybCiDqQgIE0LEXUZp31ttJFQVednp4NLddgjSe07XzifnlJY6NLcQhncAkHcT5ecxR1wpjDdR9LHureDWiVR/bcJy4L3d2zO3Kdh/q5SvjBNAJBMRKSOC9bt8fB5BrmLuWnyqQvIAFewItdUIhs1yQbB5G7l2JOumZ1BNDt+v9FrEu8fmejygdJlzie1hrzDhs1jnUlQkEfDfW0Hwj1wI2nRsuu8LryoZ5ecsdSEETjW4vWpx85i3fsYdqSlL6HJhtTL7SVocROJWd0fnW0VBIFHk6Gc2UFDt2lPSoVcZOPztkwzzqyx5PF/6uCoYapk7IW9TdeLJXFI1ljeMq/oNyADzlnmpMS5uKLG7Jdn1M6bQUpOAcPXZOooOOtMvZLDllC8o6A0nLVpdmGcO/3cs69dx0TXlTBri+hyYfpBUW8AIcowkh90qvWytYCYGLFBCO3tmhU1wciRbMdmSY3rGW+B9BKmWD17dvd8o7UP2F7/lAIs4qmOPvbOTd0dsFjKc3Ai29zfAB1hphfNRIUCk9Pl0ZKhOpTplb7igzTbMDxt4OP25hxcKixo6aY2U9DVKNi1xb29o1Cv4jwTvFL9yWzii10kGk/5e4ANZ4QbQpjPdeTEU+EdwUvZ1uJXXcssdF9h2XFEvEH/IlY5aK5mrXtE53K+NJfuKtVlxCUvYQ1OimVhejE9JMOPGChZyK3A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(4143699003)(261028144727099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jKZA5UASwWF+xMkGQr2qo1FBXI0pznaV6SZbl0HUKypYrynll5hGxn70jiH7yes6OeZ6wiqE27lklkJI2zqvXLSWf0ygHitBREdbNqy3baEOK4a/mBGzbA9ePV+oQ0vyuqW9hmBgBGQQdlf0qdkwt9XJCr0f0lFMf/c5MzCAoke19NMUdyL7CCJQtCNdf6nBpwp8+BOWs1tFTWktMRgp8fQ+o51KNlVd6LELAssUkUT72GhiSMhfcYlgVZR8K5BQe3vRZOD32Qa5BoDpwHc1YEgzEI2T9qcwjAngSyNFfSzdstVFTwAeeV0bxSWazRftaApNo9nP0XTIiNGiLVACCSVCs1XQkUYGhsg0tcbXzuhIB3gYmM8D/wdpiqr656/vLifQd970429/007tevFjQJFxttzkZ1iUvuN3Id6oQHpMRtOLupPNBYPqvhHsKg+L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:29:25.3088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c588a5-1b6c-4d25-99e0-08df36ab580d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Querying link parameters in mlx5 driver is implemented using
either ETHTOOL_GLINKSETTINGS or ETHTOOL_GSET ioctl commands.
Link status reported by the above can be stale, due to a delay
introduced by Linux kernel's linkwatch mechanism.

This patch fixes that by reading link carrier status through
ETHTOOL_GLINK command. This ethtool command,
implemented by mlx5 since kernel 4.14, will always get
the current link status. It also flushes the pending link watch
events, so following ETHTOOL_GLINKSETTINGS/ETHTOOL_GSET will
return actual link carrier status.

Fixes: 17f95513adca ("net/mlx5: fix link status change detection")
Cc: dmitry.kozliuk@gmail.com
Cc: stable@dpdk.org

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 .mailmap                                |  1 +
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 46 ++++++++++++++++++++++---
 drivers/net/mlx5/mlx5.h                 |  1 +
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index c350b8f2b5..1723ef8fa7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -316,6 +316,7 @@ Congjie Zhou <zcjie0802@qq.com>
 Congwen Zhang <zhang.congwen@zte.com.cn>
 Conor Fogarty <conor.fogarty@intel.com>
 Conor Walsh <conor.walsh@intel.com>
+Cosmin Ratiu <cratiu@nvidia.com>
 Cristian Bidea <cristian.bidea@keysight.com>
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
 Cristian Sovaiala <cristian.sovaiala@nxp.com>
diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index f6394ebd19..f30fb6da5c 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -317,6 +317,40 @@ mlx5_find_master_dev(struct rte_eth_dev *dev)
 	return NULL;
 }
 
+/**
+ * Retrieve the carrier state of a device.
+ *
+ * The IFF_RUNNING flag reported by SIOCGIFFLAGS reflects the RFC 2863
+ * operational state, which the kernel only refreshes from its link watch
+ * work queue and which may therefore lag the actual carrier by up to a
+ * second. ETHTOOL_GLINK reports the carrier directly, and additionally
+ * flushes any link watch event still pending for the device.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   1 if the carrier is up, 0 otherwise.
+ *   Negative errno value is returned on error.
+ */
+int
+mlx5_link_carrier_get(struct rte_eth_dev *dev)
+{
+	struct ethtool_value ecmd = {
+		.cmd = ETHTOOL_GLINK,
+	};
+	struct ifreq ifr = {
+		.ifr_data = (void *)&ecmd,
+	};
+	int ret;
+
+	ret = mlx5_ifreq(dev, SIOCETHTOOL, &ifr);
+	if (ret != 0)
+		return ret;
+
+	return !!ecmd.data;
+}
+
 /**
  * DPDK callback to retrieve physical link information.
  *
@@ -347,9 +381,11 @@ mlx5_link_update_unlocked_gset(struct rte_eth_dev *dev,
 			dev->data->port_id, strerror(rte_errno));
 		return ret;
 	}
+	ret = mlx5_link_carrier_get(dev);
+	if (ret < 0)
+		return ret;
 	dev_link = (struct rte_eth_link) {
-		.link_status = ((ifr.ifr_flags & IFF_UP) &&
-				(ifr.ifr_flags & IFF_RUNNING)),
+		.link_status = ((ifr.ifr_flags & IFF_UP) && ret),
 	};
 	ifr = (struct ifreq) {
 		.ifr_data = (void *)&edata,
@@ -428,9 +464,11 @@ mlx5_link_update_unlocked_gs(struct rte_eth_dev *dev,
 			dev->data->port_id, strerror(rte_errno));
 		return ret;
 	}
+	ret = mlx5_link_carrier_get(dev);
+	if (ret < 0)
+		return ret;
 	dev_link = (struct rte_eth_link) {
-		.link_status = ((ifr.ifr_flags & IFF_UP) &&
-				(ifr.ifr_flags & IFF_RUNNING)),
+		.link_status = ((ifr.ifr_flags & IFF_UP) && ret),
 	};
 	ifr = (struct ifreq) {
 		.ifr_data = (void *)&gcmd,
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 7923125c5c..5ea49ca807 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2391,6 +2391,7 @@ int mlx5_get_mtu(struct rte_eth_dev *dev, uint16_t *mtu);
 int mlx5_set_mtu(struct rte_eth_dev *dev, uint16_t mtu);
 int mlx5_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
 int mlx5_link_update(struct rte_eth_dev *dev, int wait_to_complete);
+int mlx5_link_carrier_get(struct rte_eth_dev *dev);
 int mlx5_dev_get_flow_ctrl(struct rte_eth_dev *dev,
 			   struct rte_eth_fc_conf *fc_conf);
 int mlx5_dev_set_flow_ctrl(struct rte_eth_dev *dev,
-- 
2.43.0

