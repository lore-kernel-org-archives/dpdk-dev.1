Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB49606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PRS++K1o
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F9384042E;
	Mon, 26 Oct 2026 17:27:56 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0]) by mails.dpdk.org (Postfix) with ESMTPS id 7F6CB402E8
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:27:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEeHHQPM4kgoVggJLnC6H4GSbJoEZUGqWxuJ72QAdS3/jpdWmXYguuZ+vBhEEnvFcx+2Yh++dGjk4Vjk0Wh1ft0I87CYq+BDIs3qn3k8CyQZJ6mU1iQ5w4Mxu8Y+6cjJr8AE6w/f9tYdoeDLnVUvTodqvz4qMmyx8KM3tGMU1ecEAxiwaOWOnafJntkgfUkISEbSwGrpoWpuDpCgajKSBYi2GnHZKZPGc65ipP+xnziIERc0KaZLDpNibJAftcaPUXj4fajarmtK7XUIbWnwEiV1wPX8qim1oM3XPJt6QWLZ3vjIdke8TN0zJHEaXgPu490mDI2JZYJbYfC4Ry7Wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR/z+J33nJgetvvTMu4SBhZH9mr9H0Cv3YmcscQwSuk=;
 b=orYr6VnZp/uwCnENRDSfNGLGT9gdJoTCX9KNBBon2QY5MFAlElG1YLowZgf5R1So8mfDAhm6N6fWDoE8mEXROS3sRl3smaGFswPinXGo+DAher4cK9KhRDAeYTZJEGTdT/IKT2JXTFmc69qEy1XUNoj7TsDk1MNaGoNNGb9aJlMnox+OaTtccNPF1a18PR3P/WDI03osQSOgWV2Mq2fFU35FR8vl7ZaE46pdPOdVEtaBAXQq05qh9mtEQzwm5dz1u9M3PlvcqLBtZIdK1jwHCLxdeMHpZK7qaP3Q1NHzCgIchLY2l3NxyEx2VPMl7XF1Sp+mAO1ifCDq1+/1RRWnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR/z+J33nJgetvvTMu4SBhZH9mr9H0Cv3YmcscQwSuk=;
 b=PRS++K1oYWJjuoTEL56G6bJAyVM3SdocEuRs4LotWjgmjWsHET9Vrigm3TqU0pYwJB5d7jHqfzM8hUdTO1x5VEcldzWNzer0TioiAKVyTC2hgvMHtYuhnQabP+dUFboj5iLKZ8fCbvVLFsdp2qIvGp6LV3LHsSdMxpuDo2TLmICvTlZoYVSGf6jAQbMYCPbafgdpr6FtHMAuSX8GmMkBxNUSxyjC4cZLsHu0wM/TrDVLBMw87rTmoNJc5XwPQ93LBfWaoUM8wl4JyFKBB++nUGzqgvpTpA3aaMPh5xpon4O43TuD2TRCI03lo0PHkvjbKhXUvzMCxM/Df7LboaFKdQ==
Received: from BN9PR03CA0373.namprd03.prod.outlook.com (2603:10b6:408:f7::18)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:27:44 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::3e) by BN9PR03CA0373.outlook.office365.com
 (2603:10b6:408:f7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.20 via Frontend Transport; Mon,
 26 Oct 2026 16:27:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:27:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:25 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:23 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 01/13] common/mlx5: rework IB port number query
Date: Mon, 26 Oct 2026 17:26:57 +0100
Message-ID: <20261026162709.1292958-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a18f748-3558-4a96-9418-08df337e1065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261026121527099003|11063799006|56012099006|261009223027099003|261022075727099003|261021123027099003|261022105027099003|10067099003|261021121427099003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: csbUCuCEoEvLLPa9eE7ZxGqWgWswp5i4tSAK56Kl8Nzl7+2lNwy2pEJqWDivUArw5DR+seha8R4iVYkXlMcgOvbZWsFAdErQ2vatE5vithAsAZqSpxSi+yxGa3Xw+I1N3CDGI3x31ze3IgtKGSJMnXt9esh0hg1plq9jtl0ez9/Iehjv9oJCw7bqJ2DhGJiAy5SSv3FyfeqpzguxS5/2a4WG8CMYRdjrvOKvGOyCP8RWngBlVywxAtKCOOH0JOWovha4ZnNY86HL99Emf1CNRcZnzeGCB62OjyreuAdpotvpCzDjDIXFP2TcV2DkNbz9AuLQ7nZUxdhxSv/hG3QBGqbM1ACtrUG2OXvcyoHvIu5GAhPS04kGp5D6EC6cExxPkGOh+AYO9rl/c9TM2/u8MTFNpRPg0xoB/XtV/8KlJk+dTiXawMhdi51nwfsUxX+11RRb+znMJR/CKa4QziBpWDDrqh8UCfnZ/nbuSXIZQG47lyCQcpr8tL7dmuv3d2uBY1Jk9QB7CdhYBisKMfbENIuPLQyXY1C7FtMsEzJVy59F2x1EVTRfMJepra6wh3Tto4KIInqXNArb0WeOGPNjPokX4IdOHnBBp/r/SAW6GA98xHIWDv3vbajHXIR2Zcr8rZx0eFtxeIBfZcH3TH3c6lbGrSD5jtk5n/IzF+c23pt7WhgCREDlHVsd+pXbUrIhOTGVGaVGA2dWEk1gCeHgUg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261026121527099003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(261022105027099003)(10067099003)(261021121427099003)(18002099003)(22082099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4iAgjWNg3hlWCnmweHBZ/jvigCePY2M3lvIDfxY+fTjRIue8MAaQF0m5QeQmeC5JQOOgJY8/2XLL/Bcy8zyj8O71L9Qejcq5VkQy2DNDxRkni7qztgGJKMMN9UIErLXxow5wNAN7MZ4JQYRqzoQ8BanZCptQm27FxMpuZxzmZ0xcoa0KczT0WVEz+72rxfiLio072nN5UwZ+aLWEE6OzW/tAfQ2Iqcx0GfHi/RwZzPkFd88l2NCEbc3/5zz1xQP/pBqKME2x+3ltUq0Em24Yd7ZcjstWXbPdDw2uDyvFogvFBpm6IwESc8eJCRT7xfAGM0QyfmgSmVF+W3OkUBMLMvUrG/bqj2fJgnFM1tZSvX/qyl1XRP/Mh4XkbiziWxv9QDqZLU4pT1NFCyQZK0USqTnhZlwt7O/vRTQAZVXPh3aS8K7E386AavprmkaBd/bt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:27:44.2085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a18f748-3558-4a96-9418-08df337e1065
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

mlx5_nl_portnum() function currently requires that
IB port to netdev info cache (mlx5_dev_info) is always provided.
Rework this function:

- Allow calling mlx5_nl_portnum() without cache.
- Extract cache fetch/update logic into separate functions.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 79 ++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 3fabcfaee0..1132e3fa5f 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -1275,15 +1275,60 @@ mlx5_nl_port_state(int nl, const char *name, uint32_t pindex, struct mlx5_dev_in
 	return (int)data.state;
 }
 
+static unsigned int
+mlx5_dev_info_get_portnum(const char *ibname, struct mlx5_dev_info *dev_info)
+{
+	if (dev_info == NULL ||
+	    !dev_info->probe_opt ||
+	    dev_info->port_num == 0 ||
+	    strcmp(ibname, dev_info->ibname) != 0)
+		return 0;
+
+	return dev_info->port_num;
+}
+
+static unsigned int
+mlx5_dev_info_set_portnum(const char *ibname,
+			  struct mlx5_dev_info *dev_info,
+			  const struct mlx5_nl_port_info *data)
+{
+	size_t size;
+
+	/* If cache is not available or probe optimization is not enabled, just return portnum. */
+	if (dev_info == NULL || !dev_info->probe_opt)
+		return data->portnum;
+
+	MLX5_ASSERT(data->flags & MLX5_NL_CMD_GET_IB_NAME);
+	MLX5_ASSERT(data->flags & MLX5_NL_CMD_GET_IB_INDEX);
+	MLX5_ASSERT(data->flags & MLX5_NL_CMD_GET_PORT_INDEX);
+	MLX5_ASSERT(strlen(dev_info->ibname) == 0);
+
+	dev_info->port_num = data->portnum;
+	dev_info->ibindex = data->ibindex;
+	snprintf(dev_info->ibname, MLX5_FS_NAME_MAX, "%s", ibname);
+	if (data->portnum > 1) {
+		size = (data->portnum + 1) * sizeof(struct mlx5_port_nl_info);
+		dev_info->port_info = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE, size,
+						  RTE_CACHE_LINE_SIZE,
+						  SOCKET_ID_ANY);
+		if (dev_info->port_info == NULL) {
+			memset(dev_info, 0, sizeof(*dev_info));
+			rte_errno = ENOMEM;
+			return 0;
+		}
+	}
+	return data->portnum;
+}
+
 /**
  * Get the number of physical ports of given IB device.
  *
- * @param nl
+ * @param[in] nl
  *   Netlink socket of the RDMA kind (NETLINK_RDMA).
  * @param[in] name
  *   IB device name.
- * @param[in] dev_info
- *   Cached mlx5 device info.
+ * @param[in,out] dev_info
+ *   Cached mlx5 device info. If NULL, netlink query is done and caching is skipped.
  *
  * @return
  *   A valid (nonzero) number of ports on success, 0 otherwise
@@ -1306,11 +1351,12 @@ mlx5_nl_portnum(int nl, const char *name, struct mlx5_dev_info *dev_info)
 		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP,
 	};
 	uint32_t sn = MLX5_NL_SN_GENERATE;
-	int ret, size;
+	unsigned int portnum;
+	int ret;
 
-	if (dev_info->probe_opt && dev_info->port_num &&
-	    !strcmp(name, dev_info->ibname))
-		return dev_info->port_num;
+	portnum = mlx5_dev_info_get_portnum(name, dev_info);
+	if (portnum > 0)
+		return portnum;
 
 	ret = mlx5_nl_send(nl, &req, sn);
 	if (ret < 0)
@@ -1328,24 +1374,7 @@ mlx5_nl_portnum(int nl, const char *name, struct mlx5_dev_info *dev_info)
 		rte_errno = EINVAL;
 		return 0;
 	}
-	if (!dev_info->probe_opt)
-		return data.portnum;
-	MLX5_ASSERT(!strlen(dev_info->ibname));
-	dev_info->port_num = data.portnum;
-	dev_info->ibindex = data.ibindex;
-	snprintf(dev_info->ibname, MLX5_FS_NAME_MAX, "%s", name);
-	if (data.portnum > 1) {
-		size = (data.portnum + 1) * sizeof(struct mlx5_port_nl_info);
-		dev_info->port_info = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE, size,
-						  RTE_CACHE_LINE_SIZE,
-						  SOCKET_ID_ANY);
-		if (dev_info->port_info == NULL) {
-			memset(dev_info, 0, sizeof(*dev_info));
-			rte_errno = ENOMEM;
-			return 0;
-		}
-	}
-	return data.portnum;
+	return mlx5_dev_info_set_portnum(name, dev_info, &data);
 }
 
 /**
-- 
2.43.0

