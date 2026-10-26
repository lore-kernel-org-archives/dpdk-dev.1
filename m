Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A90606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hYBYpiw6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87FC2402B0;
	Mon, 26 Oct 2026 17:28:28 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 46432402B0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU8kf8G6Eje7Cotebo7ZbAIb0xcRRbXMFqKa+KagmQp+BzNDirBf3ny2wLFUdiT5gYU7WHy3+ycZ317B7QK4+G7FZYsAkp1PWmnVFJuV5B+4TMMCYS3iY+kFq3PByGUwWqdHqYO0T7UiyaUHdodIa1F7hn6ASIHPlsSX3y3s1kIIrD+uzQWpWmaLTh92H070BSeHmSYvP0+fuoKFOgjlIFo2j9yb3CSZ0H1PVecLy3zTgTHVmxCMuJmEvoBsx4GBTHDiTeJCE85+HYRDUeVVqaPAGGfdrsna0uzyP2SvPBO2k/kZBguBOJkV2TVEAslLdF2JmINwcX1IjX3M3BQi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7mtTx3iO8BecuBiDRpOTBSC3h9TlGMmKh7hDIK1eUw=;
 b=ktAKcSMZJ+53xpOz/gSiboCEKpwbhnv3Ua7VDptUgophc8O6he789z+0tc62L1CtHs4auOVuPTeR+qKSkLH32apzHnhGx8e/XvLzZdWzNu1Kqvr1LJm71RCHJxrc86eCUgDcc8W+eBMIC6YHk4TZPJ9NWM+efo8pX0U657GBKxpbXERD/SEexr6PmyrcpHEZvUrF/22n0H/8tvFikQ00ofLkCt8kbykEGFl9G/W1tMG+6/Enu/FlrV/XnWJQb1DiBPOUeKEpAQLHeKderRP7gQl6MsQGTAJT7lGWsJ2Vx2e4ZSdNNPXrkozi3RGXLWol9G5ICAWDy1RTs5lReIi2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7mtTx3iO8BecuBiDRpOTBSC3h9TlGMmKh7hDIK1eUw=;
 b=hYBYpiw6y9WIL+vggFLzRlQIPuHfyaLosf4+YDDVj9+Vl7wmsEQ1cvlgGRwEl7k2aLwKkx7NhxfxJME6fixS0G+OdDzXd/nxLIHQhlGD0Xxf7ux6B8xKQ6nwWFm3YsUzBzAhfvZ2ve6e3wgvISbrvWkC5ztQ1o6YM+jNz3NGgokqm5c7wUY9Bz8Wd7L6SF+/dxU1Qw4p+nPoUTWl7msNN5HzSKturBDj8h0HDUvRg5gtF2syJ8rR/IEzEwwAWE/RYsB+yP6R7MTslTCcU73ErsIkQwRw+2grf8fxzYCZyzanve0BAxzAIGpFDAUOEjaOOU84xntvt15ULiJ7Ix948g==
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:28:10 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::90) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 26
 Oct 2026 16:28:05 +0000
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
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:28:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:40 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:38 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 08/13] common/mlx5: query devlink port for netdevs
Date: Mon, 26 Oct 2026 17:27:04 +0100
Message-ID: <20261026162709.1292958-9-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: f953e9d1-3e50-4fb5-e7fe-08df337e1cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021130227099003|261021135927099003|261021123027099003|261021133027099003|261021121427099003|10067099003|56012099006|261026121527099003|3023799007|18002099003|22082099003|261026135527099003|11063799006|261026140227099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: JHv1Kxm2o/EV2o0omLX2jlfdpFu0Q2WL81qwfSleCTLGhWA5Pf8BAFJpCvzE08fBWdQm27tHSPnuRPSfje3OTwxKOu98X7VSCXBnOQx7OQUMNkdUYa5QwWyDZQwCaySp+ZVXqwwnnJ+7+9KUkqWCQ9mOUUyGXRvL9N0heaCKLRNNfZA9yyQLXy4srzpYxLTsOpP0nmlP1Z/XrPxg+XOtYx/Q2vgp5164khmHvsuCqSUsDuJSyzQ7OCQaaGU1JfKIJYUVLxNa/rheya8lPPuSZ4K//vBqSy2PlTZaxB9z6q10OgN1vdADNU0XF4Ekqi9gzmIY5p1FU3ifn6UwVubz/5+Nm0F+aMHaCCWUpLB8VwpzpUCeVhGC+m4P+D1qJ3FvTEZdTpIVmEkX8/OzE5J5be9KsubSQhK14n0c4Q8V6a+CacJlpe8TtpL2UfxC7iojQgpRdpSNvrO+Pa/c4XvWOJJO0DsyeDHGJCeHnDHvbnEQSXALNirp3qbX3N4wbUvSnTe2+dBswExtlfsKEkYaqeeHNPiWghOdLpajQxvatl9FHEL7j3hfFbqRPYX1VXaqekK0w7aapho3t41cEGPtkrN6pgLgVHZL7h4Pm6f39rBOMCAhiXCcsvu5XtiWptK+XUSmDaLVyEs0WRDF7bSSVZfzSUEqbq/9MZTrZGfhSRbS+66eV7sH9i6kP8e7eSGkRje8bQ7GvW12lKcgL7vmdA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021130227099003)(261021135927099003)(261021123027099003)(261021133027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(3023799007)(18002099003)(22082099003)(261026135527099003)(11063799006)(261026140227099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vsB6SN+B9XxmcGfO/JZ+D3CvWB7K93AwBo3YeqXQMfsAI1zUovs9iIIwNJ6C1apcKpNjcCB8s7GwWKFA/SOsJ7pjpRvBnHFIlbN5YRnual73JIe43Fu6SygdQDAVPSIs6lu1ceW0yaEYBp4iJQXtd0zWCM7kXKnU0uPj4Q/DxxxR4o9TBxDOHAGy/trbRmKBqBy3lpb3XmAImZvTGmaiSLBxwYeorA/3Ahsx2+WIToxUZ7DrimktIs3G9ss7jg5iplj6lzPYUxtjCMRrM7/9AaAlWmEuNHh4kU2JRGyWqfjjzEwrQolPp2Cuw96uAlJnjACEw6Sdcmb3qacUOCCSza3bxvRi1G1HBG6VP06P0OoPOhPM+j2S5leJc1D0fcy8Is/9VwBEOHGD58oyA08F5UOhNOCDxb9L06x4aOGCPYu1rGa7zbkaVlhIQJCsYXDb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:28:04.9607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f953e9d1-3e50-4fb5-e7fe-08df337e1cc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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

Representor matching in mlx5 driver is based on physical port name
(phys_port_name) reported by Linux kernel.
Port type and its location in the topology was derived from this name.
It is available only on representor netdevs.

As a result, when embedded switch is shared by netdevs
based on real VFs/SFs mlx5 driver is unable to deduce port's type.
As a replacement, flavour of a devlink port related to netdev
can be used.

This patch adds parsing of IFLA_DEVLINK_PORT attribute
to mlx5_netdev_info_get(). This info will be used in follow up patches
to query devlink port info.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/meson.build |  2 +
 drivers/common/mlx5/linux/mlx5_nl.c   | 67 ++++++++++++++++++++++++++-
 drivers/common/mlx5/linux/mlx5_nl.h   | 17 +++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 1b2104b48e..a69a8b77a0 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -158,6 +158,8 @@ has_sym_args = [
             'IFLA_PARENT_DEV_NAME' ],
         [ 'HAVE_IFLA_PARENT_DEV_BUS_NAME', 'linux/if_link.h',
             'IFLA_PARENT_DEV_BUS_NAME' ],
+        [ 'HAVE_IFLA_DEVLINK_PORT', 'linux/if_link.h',
+            'IFLA_DEVLINK_PORT' ],
         [ 'HAVE_RDMA_NL_NLDEV', 'rdma/rdma_netlink.h',
             'RDMA_NL_NLDEV' ],
         [ 'HAVE_RDMA_NLDEV_CMD_GET', 'rdma/rdma_netlink.h',
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 4eebec5223..786158fb99 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -119,6 +119,9 @@
 #ifndef HAVE_IFLA_PARENT_DEV_BUS_NAME
 #define IFLA_PARENT_DEV_BUS_NAME 57
 #endif
+#ifndef HAVE_IFLA_DEVLINK_PORT
+#define IFLA_DEVLINK_PORT 62
+#endif
 
 /*
  * Some Devlink defines may be missed in old kernel versions,
@@ -1385,6 +1388,64 @@ mlx5_nl_portnum(int nl, const char *name, struct mlx5_dev_info *dev_info)
 	return mlx5_dev_info_set_portnum(name, dev_info, &data);
 }
 
+static inline bool
+nla_ok(const struct nlattr *nla, const ssize_t len)
+{
+	return len >= NLA_HDRLEN &&
+	       nla->nla_len >= NLA_HDRLEN &&
+	       nla->nla_len <= len;
+}
+
+static inline struct nlattr *
+nla_next(struct nlattr *nla, ssize_t *len)
+{
+	ptrdiff_t off = NLA_ALIGN(nla->nla_len);
+
+	*len -= off;
+	return RTE_PTR_ADD(nla, off);
+}
+
+static void
+parse_ifla_devlink_port(void *payload, ssize_t len, struct mlx5_netdev_info *info)
+{
+	struct nlattr *nla = payload;
+	uint32_t *val;
+	size_t payload_len;
+	char *src;
+
+	while (nla_ok(nla, len)) {
+		payload_len = nla->nla_len - NLA_HDRLEN;
+
+		switch (nla->nla_type & NLA_TYPE_MASK) {
+		case DEVLINK_ATTR_BUS_NAME:
+			if (payload_len > 0 && payload_len < MLX5_NETDEV_INFO_NAME_MAX) {
+				src = RTE_PTR_ADD(nla, NLA_HDRLEN);
+				memcpy(info->devlink_port_bus_name, src, payload_len);
+				info->devlink_port_bus_name[payload_len] = 0;
+				info->flags |= MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_BUS_NAME;
+			}
+			break;
+		case DEVLINK_ATTR_DEV_NAME:
+			if (payload_len > 0 && payload_len < MLX5_NETDEV_INFO_NAME_MAX) {
+				src = RTE_PTR_ADD(nla, NLA_HDRLEN);
+				memcpy(info->devlink_port_dev_name, src, payload_len);
+				info->devlink_port_dev_name[payload_len] = 0;
+				info->flags |= MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_DEV_NAME;
+			}
+			break;
+		case DEVLINK_ATTR_PORT_INDEX:
+			if (payload_len < sizeof(uint32_t))
+				break;
+			val = RTE_PTR_ADD(nla, NLA_HDRLEN);
+			info->devlink_port_index = *val;
+			info->flags |= MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_INDEX;
+			break;
+		}
+
+		nla = nla_next(nla, &len);
+	}
+}
+
 static int
 mlx5_nl_netdev_info_cb(struct nlmsghdr *nh, void *arg)
 {
@@ -1409,7 +1470,7 @@ mlx5_nl_netdev_info_cb(struct nlmsghdr *nh, void *arg)
 		void *payload = RTA_DATA(ra);
 		unsigned int i;
 
-		switch (ra->rta_type) {
+		switch (ra->rta_type & NLA_TYPE_MASK) {
 		case IFLA_NUM_VF:
 			if (RTA_PAYLOAD(ra) < sizeof(uint32_t))
 				goto error;
@@ -1451,6 +1512,10 @@ mlx5_nl_netdev_info_cb(struct nlmsghdr *nh, void *arg)
 				info.flags |= MLX5_NETDEV_INFO_FLAG_PARENT_DEV_BUS_NAME;
 			}
 			break;
+		case IFLA_DEVLINK_PORT:
+			payload_len = RTA_PAYLOAD(ra);
+			parse_ifla_devlink_port(payload, payload_len, &info);
+			break;
 		}
 	}
 	*out = info;
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 39691569bc..5a9ccfbb7e 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -62,11 +62,17 @@ struct mlx5_nl_port_info {
 /* Maximum length of parent device bus name. */
 #define MLX5_PARENT_DEV_BUS_NAME_MAX 128
 
+/* Maximum length of a name stored inside netdev info */
+#define MLX5_NETDEV_INFO_NAME_MAX 128
+
 #define MLX5_NETDEV_INFO_FLAG_NUM_VF RTE_BIT32(0)
 #define MLX5_NETDEV_INFO_FLAG_PHYS_PORT_NAME RTE_BIT32(1)
 #define MLX5_NETDEV_INFO_FLAG_PHYS_SWITCH_ID RTE_BIT32(2)
 #define MLX5_NETDEV_INFO_FLAG_PARENT_DEV_NAME RTE_BIT32(3)
 #define MLX5_NETDEV_INFO_FLAG_PARENT_DEV_BUS_NAME RTE_BIT32(4)
+#define MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_BUS_NAME RTE_BIT32(5)
+#define MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_DEV_NAME RTE_BIT32(6)
+#define MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_INDEX RTE_BIT32(7)
 
 struct mlx5_netdev_info {
 	unsigned int ifindex; /* [in] */
@@ -76,8 +82,19 @@ struct mlx5_netdev_info {
 	uint64_t phys_switch_id; /* [out] */
 	char parent_dev_name[MLX5_PARENT_DEV_NAME_MAX]; /* [out] */
 	char parent_dev_bus_name[MLX5_PARENT_DEV_BUS_NAME_MAX]; /* [out] */
+	char devlink_port_bus_name[MLX5_NETDEV_INFO_NAME_MAX]; /* [out] */
+	char devlink_port_dev_name[MLX5_NETDEV_INFO_NAME_MAX]; /* [out] */
+	uint32_t devlink_port_index; /* [out] */
 };
 
+static inline bool
+mlx5_netdev_info_has_devlink_port(struct mlx5_netdev_info *info)
+{
+	return (info->flags & MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_BUS_NAME) &&
+	       (info->flags & MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_DEV_NAME) &&
+	       (info->flags & MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_INDEX);
+}
+
 __rte_internal
 int mlx5_nl_init(int protocol, int groups);
 __rte_internal
-- 
2.43.0

