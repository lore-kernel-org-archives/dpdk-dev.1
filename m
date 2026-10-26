Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592C606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jhGo6CB1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62D2A406BB;
	Mon, 26 Oct 2026 17:28:19 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 342164069F
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmTktm2IqoCKQbnRxB6UzojDnhWPn87odt5f/12vUp3G36G74A2LGLp/3Vd2OXSN8kyO3mECFLYqEs5W8hvwCTLvDXjgFSvTDqd93GN2d4PWlDujOfPUkyVmz45xNZHMAKmchFPgpqvYXRwoUsieNlzfS2MLtUp0WHuIAZvIla/Hy2LdaK6JiybxWLZjuNzmmm6phpTsD0L1O//N4EosOPZYLo5iULtmhQW/2ptEy66FWK8pQzU05F2IKXdN3jJ7LDJK2S7JaIEneOk3iuk1LxyWhYJN2GRx/K97g3fSWyxEEixZ/tBSPtj9mjyhF7705swkUYtuG6KpppnOfE4Obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou7KL6TywAj3hg1bSAVCe3tQsURQjLn/lEGKZmLJHjg=;
 b=yVm4z77O6NhStDFZvPofjglmQLPwJs/g0U+cqIA5UqJ7QjQILYc2ZkAWgRzI45sPrHqQMs9B2TLLUnIAyXPRRDJExfw9S85Oj+PMB381YaY3/eWbPJAHfRLntyP0dbIsk88HnDdt5Zm7BKuTSxjVCZHPafddi3eHZJ8SUcH7AcFkyPn4b2iDYam04ACZTijbyYmszbGw3+EmT2eVZUGW7WX4yq5koddA8cga+A6n6a30q7EMLSEVCQzzIuEAIRJWFcbQoICXhqfCXtR/mlYStaOnV7k94JePkK428vjyzOjmF5+Ae8Kj5ypDOmg1ROgf7cyfXPcCHlLBEHJj+Z/5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou7KL6TywAj3hg1bSAVCe3tQsURQjLn/lEGKZmLJHjg=;
 b=jhGo6CB1lu+B5RDRKO12ERUyA916qKGCnGxDN98BISzLxxss+Xvngf9bcW9/Ruds4bG+qlALtFGb8FUbb+LyU1Cx9S0A/xin1AYAdgJVK7lqdvzpieJsDN87KnqG7XGFBihqLLLRu8aYaXj9K42np+GGTROhsuab+pS1/pdr9ac3dUCoS+pm7iuw01JUUlJdaR9HCrULy/AnGi7AyjhCn1xxosxVLYli9t3sUxb13QigDRp4NYlgy/YJyw7mmN9ZySBFXuGI+TR4LipaENhGYtJn0ku2rg4UtBy3sqWLXRNaKv64l+xYVwyEhb+7jeCNmuf9w5xKyBX15KQVoq9O5Q==
Received: from CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:28:10 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::4e) by CH2PR18CA0026.outlook.office365.com
 (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:28:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:28:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:43 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:40 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 09/13] common/mlx5: get devlink port by port index
Date: Mon, 26 Oct 2026 17:27:05 +0100
Message-ID: <20261026162709.1292958-10-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dde39d0-147d-4148-da26-08df337e1fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|261022075727099003|261021121427099003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: fdIrHUbTZG622MZWgXQW+1r9+2z8dvIPCQUXfsCUSf01iZ71Q5dpq2TVtd2QeqM+rRcEikI4PX3sGBFGrBH22YCSiQvqZdxApoQdWCSPsZh/fIQRtnY8Y8zFVng3FYiXz4lrI4kH8Aio330RjexWgfTfUIOtzP1+xvTDVwtWCOvs6XrVBvk6rtX0p1TA3MSo0OZ521/FUnBjfbBUMTzjT/zjzZbRecNOQbmwsZg+JAci4slLZCwXHfYRwijVCq1pW8x+Agu2H44oPgDHFN2UJbGV1u6rxlq7lUHHvCAjUFMaNDRWtVwh9NmMbSjB+Q91MEeEBlptO7UkJZlWW0CNnk2QNHRFfKCqyY0b5S34SqePHMfOEELkrLBUkZeQNR5McuvNjPaTAzP/TkrirVJIxsFJyM24Ms7XjAhSxhpfQb/KXkSYEm794J3ApASd2Vt4L/nfwRevVgTWSM0LWY9x2pDvwZfLRvfOcCIbdFtvg6u8coUTf8dGblSD7cP6C6DvtHIIdBfYJMZe1wKKtuSXEIxW3XtyPoM9ntNdQeZiscy4JhBeflFNeQniV3aMy5nT0ShhxZyuS4bfiJD+05ki4yASaRFKAiGaerth+EHNvqzy29zejso8QO1cYXi/XQBwsDY/BB7Mb2nzun5SlvPFu/yf+eVogEwnH9CU/4lbj4Vf0F/VlC8if3qaYmOxBLh4MR3O+qoECuLRHrjXth0ECA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oxb29hWO0aVcfngdEpzT7ckCfzamoulMMEWnjoYciahhBwsV7x8s19KIRIkGWOKRtZUKZbdEoAHNFfcRkrqzZQ62oZqx4FIJX372ROfLSUtonUD+LSW9e+7DOqtrpllI6sZnkcRoWtRZCUvm//b1gooHX/FO8+CGl6GEg5rjTA4hohHAtbYusBn1SrT1bazSNd1Ofqp/Hvp1Ldc0QunZPw87zEftqwG1fI7CMlANgzu5/nWXTIHZrZYY4zih5+hXe9WvYiO1FXrIaRZYgRMgY3UmjqRtYKp3evMoZjOjB2Lu7qayeOkQTtVcVNrL7n4d6tacbIfqkf0JYqb6EQRWllxbxXgucKfPKXVuq73+HH6iU114SQXES36loac/GM4JbidfVd2ePMpF62n0Y8a9jCcvOoEX5MXskrJWpjbIebeJhaX3fuinpMPqjqAHVXZK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:28:09.9779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dde39d0-147d-4148-da26-08df337e1fc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

Add mlx5_nl_devlink_port_info_get() which will query specific devlink
port by its:

- bus name
- device name
- port index

As of now, only port's flavour is parsed.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 91 +++++++++++++++++++++++++++++
 drivers/common/mlx5/linux/mlx5_nl.h | 19 ++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 786158fb99..e57007831c 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -190,6 +190,8 @@ static RTE_ATOMIC(uint32_t) atomic_sn;
 #define MLX5_NL_SN_GENERATE (rte_atomic_fetch_add_explicit(&atomic_sn, 1, \
 	rte_memory_order_relaxed) + 1)
 
+static void nl_attr_put(struct nlmsghdr *nlh, int type, const void *data, int alen);
+
 /**
  * Opens a Netlink socket.
  *
@@ -1573,6 +1575,95 @@ mlx5_nl_netdev_info_get(int nl, struct mlx5_netdev_info *info)
 	return ret;
 }
 
+static int
+mlx5_nl_devlink_port_info_get_cb(struct nlmsghdr *nh, void *arg)
+{
+	struct mlx5_devlink_port_info *out = arg;
+	struct mlx5_devlink_port_info info;
+	struct genlmsghdr *genlhdr;
+	struct nlattr *nla;
+	ssize_t len;
+
+	memset(&info, 0, sizeof(info));
+	info.bus_name = out->bus_name;
+	info.dev_name = out->dev_name;
+	info.index = out->index;
+
+	if (nh->nlmsg_len < NLMSG_LENGTH(GENL_HDRLEN))
+		goto error;
+
+	genlhdr = NLMSG_DATA(nh);
+	if (genlhdr->cmd != DEVLINK_CMD_PORT_NEW)
+		goto error;
+
+	nla = RTE_PTR_ADD(genlhdr, GENL_HDRLEN);
+	len = nh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
+	while (nla_ok(nla, len)) {
+		void *payload = RTE_PTR_ADD(nla, NLA_HDRLEN);
+		size_t payload_len = nla->nla_len - NLA_HDRLEN;
+
+		switch (nla->nla_type & NLA_TYPE_MASK) {
+		case DEVLINK_ATTR_PORT_FLAVOUR:
+			if (payload_len < sizeof(uint16_t))
+				break;
+			info.flavour = *(uint16_t *)payload;
+			info.flags |= MLX5_DEVLINK_PORT_INFO_FLAG_FLAVOUR;
+			break;
+		}
+
+		nla = nla_next(nla, &len);
+	}
+	*out = info;
+	return 0;
+error:
+	rte_errno = EINVAL;
+	return -rte_errno;
+}
+
+static int __rte_unused
+mlx5_nl_devlink_port_info_get(int nl, int family, struct mlx5_devlink_port_info *info)
+{
+	struct nlmsghdr *nlh;
+	struct genlmsghdr *genl;
+	uint8_t *buf;
+	size_t bus_name_len = strlen(info->bus_name) + 1;
+	size_t dev_name_len = strlen(info->dev_name) + 1;
+	size_t buf_size;
+	uint32_t sn = MLX5_NL_SN_GENERATE;
+	int ret;
+
+	buf_size = NLMSG_ALIGN(sizeof(struct nlmsghdr));
+	buf_size += NLMSG_ALIGN(sizeof(struct genlmsghdr));
+	buf_size += NLMSG_ALIGN(sizeof(struct nlattr) + bus_name_len);
+	buf_size += NLMSG_ALIGN(sizeof(struct nlattr) + dev_name_len);
+	buf_size += NLMSG_ALIGN(sizeof(struct nlattr) + sizeof(info->index));
+	buf = calloc(1, buf_size);
+	if (buf == NULL) {
+		rte_errno = ENOMEM;
+		return -rte_errno;
+	}
+
+	nlh = (struct nlmsghdr *)buf;
+	nlh->nlmsg_len = NLMSG_ALIGN(sizeof(struct nlmsghdr));
+	nlh->nlmsg_type = family;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+
+	genl = RTE_PTR_ADD(nlh, nlh->nlmsg_len);
+	genl->cmd = DEVLINK_CMD_PORT_GET;
+	genl->version = DEVLINK_GENL_VERSION;
+	nlh->nlmsg_len += NLMSG_ALIGN(sizeof(struct genlmsghdr));
+
+	nl_attr_put(nlh, DEVLINK_ATTR_BUS_NAME, info->bus_name, bus_name_len);
+	nl_attr_put(nlh, DEVLINK_ATTR_DEV_NAME, info->dev_name, dev_name_len);
+	nl_attr_put(nlh, DEVLINK_ATTR_PORT_INDEX, &info->index, sizeof(info->index));
+
+	ret = mlx5_nl_send(nl, nlh, sn);
+	if (ret >= 0)
+		ret = mlx5_nl_recv(nl, sn, mlx5_nl_devlink_port_info_get_cb, info);
+	free(buf);
+	return ret;
+}
+
 /**
  * Analyze gathered port parameters via Netlink to recognize master
  * and representor devices for E-Switch configuration.
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 5a9ccfbb7e..0a9aab6610 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -95,6 +95,25 @@ mlx5_netdev_info_has_devlink_port(struct mlx5_netdev_info *info)
 	       (info->flags & MLX5_NETDEV_INFO_FLAG_DEVLINK_PORT_INDEX);
 }
 
+#define MLX5_DEVLINK_PORT_INFO_FLAG_FLAVOUR RTE_BIT32(0)
+
+#define MLX5_DEVLINK_PORT_FLAVOUR_PHYSICAL (0)
+#define MLX5_DEVLINK_PORT_FLAVOUR_CPU (1)
+#define MLX5_DEVLINK_PORT_FLAVOUR_DSA (2)
+#define MLX5_DEVLINK_PORT_FLAVOUR_PCI_PF (3)
+#define MLX5_DEVLINK_PORT_FLAVOUR_PCI_VF (4)
+#define MLX5_DEVLINK_PORT_FLAVOUR_VIRTUAL (5)
+#define MLX5_DEVLINK_PORT_FLAVOUR_UNUSED (6)
+#define MLX5_DEVLINK_PORT_FLAVOUR_PCI_SF (7)
+
+struct mlx5_devlink_port_info {
+	const char *bus_name; /* [in] */
+	const char *dev_name; /* [in] */
+	uint32_t index; /* [in] */
+	uint32_t flags; /* [out] */
+	uint16_t flavour; /* [out] */
+};
+
 __rte_internal
 int mlx5_nl_init(int protocol, int groups);
 __rte_internal
-- 
2.43.0

