Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C85606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rdJ+PY/k
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1E0B40678;
	Mon, 26 Oct 2026 17:27:59 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by mails.dpdk.org (Postfix) with ESMTPS id B27F540647
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:27:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS3eioUfTFdPUTKgLvR0fly1niq5c6tNgvZNkS4/hBpdzRaTabCVGWeNkblrNtxAGBKzXtx44zWUKNO85OTgn4LH9XPykddV8qM/n5IVkiwxt1hojgdCXr7IjSchwwBCLZDpbqxgVAipDHmpLrWZIBkQ4hfgN8KwcqkgIdzvSLg7Xu3dXFWACLHpHzDDKprtHrlJ3ndJAnyQgR6X3YMoVCXXYXEM3jZ7ZCylut16SbE1pUd8KhQ7PW6S9S0Az3Q8LLhOqHb+i2Dxb+Iu4NqrFXBnE5qXbk9n6oQ3XZUuMkM1ZWDZqUR/CwA0dBaqRJgHpTmYC4tP+1a1QnGElaKGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJEa3MwE06S7VMT38WB8/XI6yQy9b0ucvguT9ezJlos=;
 b=M6oD7MXR9dYq38tKoLt4BKQq+kUZAT9HImPNGv8Mq7yRtgpuYfOAEMpmawRrPUO/M3bF7r04qTAjbVMpOyEF0XUWlfGFSzPU8zyNpXPiORsJzMM0Uj3q/qoF6/kYP/3TQ0shaqU5Na1t+vprUMc4TjoOxPAUyq/Xs+aSzRZO1rVOe5U0Il8MtcvxiUzS3qV8tqH+M4sxOl2HuZwrwa41KIyIttUEe/DU1yJvJtmgNGnVDw4JbjteuhesK2YmdOd1KmC7GG8tj4k59IQSpA/2rG1XNCHe3Ylp+Y3aemM4iOte0qtpMEZdaJ06XDvFHkd1K8XHflRaUsLMCCTOpC+zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJEa3MwE06S7VMT38WB8/XI6yQy9b0ucvguT9ezJlos=;
 b=rdJ+PY/k/v6qhTH0oROBGhy59pnXKnPrM7Lyo3CH4/eERBb17yqRjGYMVxDs+82V7vZCZppkosHaG/oFnMYWT+wHrrgvV1f3Vl47ZXRIOHXzBzH0qMgIt6DADxkeKsh/oZwBUhpr8JvR1y/AJRE8cjMNz75tj8z+MyghLjBKxeJ6QkxVOkzOhH63O4ER2fjQ8DOvA2F0tAdKMDG+iGN8ZhJ+gr3Vh8mCOIbbgl7D6z71YSQbF8YKvVsnd2lIXeMLNkF/BLIwodJf3JNsrGgmt7/z+thBiaBrEvouhRZ8TEjsKWDBYnNA8x6lhzPH0sQ39WzdBTqnMQcqSqhHwA23TA==
Received: from CH0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:610:b1::31)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:27:51 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::12) by CH0PR13CA0026.outlook.office365.com
 (2603:10b6:610:b1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.6 via Frontend Transport; Mon, 26
 Oct 2026 16:27:50 +0000
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
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:27:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:30 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:27 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 03/13] common/mlx5: separate netdev info from switch info
Date: Mon, 26 Oct 2026 17:26:59 +0100
Message-ID: <20261026162709.1292958-4-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 54979360-aca8-47ca-1f25-08df337e13e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261026121527099003|56012099006|11063799006|261009223027099003|261021133027099003|261021130227099003|261021123027099003|261022115727099003|261021135927099003|261022075727099003|261022113327099003|261021121427099003|261022105027099003|10067099003|261026135527099003|22082099003|18002099003|6133799003|261026140227099003|3023799007|261026130827099003;
X-Microsoft-Antispam-Message-Info: xg9rrZZqesxPs/bKt20YCkpMHmuyvGGFLNcz/0Wga+jNLBLH0ctoLsRNseAeEdA5Ik7xvqHysEC1dIs5kY5xa/OzaS+knShOSqEPM/vjy4Yg374fYR6LOk3YV+Cy/eMj89peX5BzzaUxiMUQijnkwxfIWdvUwT4QtXs2iLMxi6x6y3NcxKZJOmU4o2s/0mbBEfWVqn8dchundq4/4ZaiS7avdyxL8gSkasuta3OgSejzEqaRX6w1mkmzwuRgOcRjeXGPodXg9WLSxuKU4T0AxtO9aZ8vlqUUe+bLw9BKeLCphIOROE/lRBOv5XyqkxnGt7tejVaPuxsgVQM0zzkhWfNYfdSEmKyqy9ABikTSjquogaajttXwlG8sBKUFDZImQ/wyx36FDUQgGHKY4nnomjmffBvPmKPjVxffn/8CNi2IknMUn9WLS3e7eaqTN/cn36oIy9IxvpuL4HkN4KSaKsIMdKd0uZAVcDWzJ6yKgdDw52p23TcTkDeesLJe8tW1yubh2LO0x74TEOEmAqdRNraVmzA+NWkosTGKSaVsaT/GhY4Dpl1WOQ6Au6Q1q2SDsjd2Lwi/USctoOsmk/OFRp3yEO1CXrICuRDPMAId0cKZBnbH0MMzeMG67SnoInhMqoK6xWjqwYcuJNpo9lJliECuSWy423RLGp7XaDIxi5Qwr9/nHOqUVUbq4/AYqnN5s2uuq2HY/5qdnW2Fu204UQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261026121527099003)(56012099006)(11063799006)(261009223027099003)(261021133027099003)(261021130227099003)(261021123027099003)(261022115727099003)(261021135927099003)(261022075727099003)(261022113327099003)(261021121427099003)(261022105027099003)(10067099003)(261026135527099003)(22082099003)(18002099003)(6133799003)(261026140227099003)(3023799007)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MUYaZ80URcZmqoJPbd5KI4V+5w4qZRMqhdwrTvkuDMSOfz6zmGg3N1t7LzJUbroAbNY4+RdhnmEm+N7skXunElLkxTRJcURnjJvEeHudHz2mxVb9xs6kMKmtGtjYvfY0Awp3DpWbxvB1cuHB4D3eu96yRUeedKnL3tBRRQLerNYx8S/iIpRokMEow5JosT5RxFWIPE65qENTF+drVfQ/uCjte6evDlZjM43Swqtwb/8hQtN6WGlOc355K6Flcc2gPDC/KqNqpH1JOsgj8hAR/Y3b30UOPC9p6tv5qty/edW1hNzKJ++h3oN7GRiyqWwffIqqQPnFUZudSKy3ISIJOalbH3Xz8WEButu/9/U0xbCp4lwJ4bz8bEO73qqMqHXmdfgBSuiJ48N36AmZLzqjFly/rVHZlHhMV4pLOgO5aYYaZ5f3l2Ets1e+rr5XVM7j
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:27:50.0853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54979360-aca8-47ca-1f25-08df337e13e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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

mlx5_nl_switch_info() is used to query information
about the Linux netdev relevant for NICs with embedded switch.
It calls and parses data from netlink directly.

Rework this function to allow more generic netlink calls
about Linux netdevs. Netlink call is moved to dedicated
function, mlx5_nl_netdev_info_get(), parametrized by ifindex.
Switch info is then filled in from returned netdev info.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 236 +++++++++++++++-------------
 drivers/common/mlx5/linux/mlx5_nl.h |  17 ++
 2 files changed, 143 insertions(+), 110 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index d4b40bec2c..eafae78883 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -32,8 +32,6 @@
 #define MLX5_SEND_BUF_SIZE 32768
 /* Receive buffer size for the Netlink socket */
 #define MLX5_RECV_BUF_SIZE 32768
-/* Maximal physical port name length. */
-#define MLX5_PHYS_PORT_NAME_MAX 128
 
 /** Parameters of VLAN devices created by driver. */
 #define MLX5_VMWA_VLAN_DEVICE_PFX "evmlx"
@@ -1381,6 +1379,111 @@ mlx5_nl_portnum(int nl, const char *name, struct mlx5_dev_info *dev_info)
 	return mlx5_dev_info_set_portnum(name, dev_info, &data);
 }
 
+static int
+mlx5_nl_netdev_info_cb(struct nlmsghdr *nh, void *arg)
+{
+	struct mlx5_netdev_info *out = arg;
+	struct mlx5_netdev_info info;
+	struct rtattr *ra;
+	int payload_len;
+	int off;
+	int len;
+
+	if (nh->nlmsg_type != RTM_NEWLINK)
+		goto error;
+
+	memset(&info, 0, sizeof(info));
+	info.ifindex = out->ifindex;
+
+	off = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	len = nh->nlmsg_len - off;
+	for (ra = RTE_PTR_ADD(nh, off);
+	     RTA_OK(ra, len);
+	     ra = RTA_NEXT(ra, len)) {
+		void *payload = RTA_DATA(ra);
+		unsigned int i;
+
+		switch (ra->rta_type) {
+		case IFLA_NUM_VF:
+			if (RTA_PAYLOAD(ra) < sizeof(uint32_t))
+				goto error;
+			info.num_vf = *(uint32_t *)payload;
+			info.flags |= MLX5_NETDEV_INFO_FLAG_NUM_VF;
+			break;
+		case IFLA_PHYS_PORT_NAME:
+			payload_len = RTA_PAYLOAD(ra);
+			/* Some kernels do not pad attributes with zero. */
+			if (payload_len > 0 && payload_len < MLX5_PHYS_PORT_NAME_MAX) {
+				memcpy(info.phys_port_name, payload, payload_len);
+				info.phys_port_name[payload_len] = '\0';
+				info.flags |= MLX5_NETDEV_INFO_FLAG_PHYS_PORT_NAME;
+			}
+			break;
+		case IFLA_PHYS_SWITCH_ID:
+			info.phys_switch_id = 0;
+			for (i = 0; i < RTA_PAYLOAD(ra); ++i) {
+				info.phys_switch_id <<= 8;
+				info.phys_switch_id |= ((uint8_t *)payload)[i];
+			}
+			info.flags |= MLX5_NETDEV_INFO_FLAG_PHYS_SWITCH_ID;
+			break;
+		}
+	}
+	*out = info;
+	return 0;
+error:
+	rte_errno = EINVAL;
+	return -rte_errno;
+}
+
+/**
+ * Query Linux netdev information through netlink.
+ *
+ * Information is queried only for a single interface, selected by ifindex field
+ * in @p info. flags field in @p info will be a bitmap of MLX5_NETDEV_INFO_FLAG_* flags.
+ * Each flag denotes that related field's value was returned by the kernel and can be used.
+ *
+ * @param[in] nl
+ *   Netlink socket file descriptor. Must be opened for NETLINK_ROUTE family.
+ * @param[in,out] info
+ *   Pointer to structure with netdev information.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise and rte_errno is set.
+ */
+int
+mlx5_nl_netdev_info_get(int nl, struct mlx5_netdev_info *info)
+{
+	struct {
+		struct nlmsghdr nh;
+		struct ifinfomsg info;
+		struct rtattr rta;
+		uint32_t extmask;
+	} req = {
+		.nh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(req.info) + RTA_LENGTH(sizeof(uint32_t))),
+			.nlmsg_type = RTM_GETLINK,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.info = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = info->ifindex,
+		},
+		.rta = {
+			.rta_type = IFLA_EXT_MASK,
+			.rta_len = RTA_LENGTH(sizeof(int32_t)),
+		},
+		.extmask = RTE_LE32(1),
+	};
+	uint32_t sn = MLX5_NL_SN_GENERATE;
+	int ret;
+
+	ret = mlx5_nl_send(nl, &req.nh, sn);
+	if (ret >= 0)
+		ret = mlx5_nl_recv(nl, sn, mlx5_nl_netdev_info_cb, info);
+	return ret;
+}
+
 /**
  * Analyze gathered port parameters via Netlink to recognize master
  * and representor devices for E-Switch configuration.
@@ -1434,88 +1537,6 @@ mlx5_nl_check_switch_info(bool num_vf_set,
 	}
 }
 
-/**
- * Process switch information from Netlink message.
- *
- * @param nh
- *   Pointer to Netlink message header.
- * @param arg
- *   Opaque data pointer for this callback.
- *
- * @return
- *   0 on success, a negative errno value otherwise and rte_errno is set.
- */
-static int
-mlx5_nl_switch_info_cb(struct nlmsghdr *nh, void *arg)
-{
-	struct mlx5_switch_info info = {
-		.master = 0,
-		.representor = 0,
-		.name_type = MLX5_PHYS_PORT_NAME_TYPE_NOTSET,
-		.port_name = 0,
-		.switch_id = 0,
-	};
-	size_t off = NLMSG_LENGTH(sizeof(struct ifinfomsg));
-	bool switch_id_set = false;
-	bool num_vf_set = false;
-	int len;
-
-	if (nh->nlmsg_type != RTM_NEWLINK)
-		goto error;
-	while (off < nh->nlmsg_len) {
-		struct rtattr *ra = (void *)((uintptr_t)nh + off);
-		void *payload = RTA_DATA(ra);
-		unsigned int i;
-
-		if (ra->rta_len > nh->nlmsg_len - off)
-			goto error;
-		switch (ra->rta_type) {
-		case IFLA_NUM_VF:
-			num_vf_set = true;
-			break;
-		case IFLA_PHYS_PORT_NAME:
-			len = RTA_PAYLOAD(ra);
-			/* Some kernels do not pad attributes with zero. */
-			if (len > 0 && len < MLX5_PHYS_PORT_NAME_MAX) {
-				char name[MLX5_PHYS_PORT_NAME_MAX];
-
-				/*
-				 * We can't just patch the message with padding
-				 * zero - it might corrupt the following items
-				 * in the message, we have to copy the string
-				 * by attribute length and pad the copied one.
-				 */
-				memcpy(name, payload, len);
-				name[len] = 0;
-				mlx5_translate_port_name(name, &info);
-			} else {
-				info.name_type =
-					MLX5_PHYS_PORT_NAME_TYPE_UNKNOWN;
-			}
-			break;
-		case IFLA_PHYS_SWITCH_ID:
-			info.switch_id = 0;
-			for (i = 0; i < RTA_PAYLOAD(ra); ++i) {
-				info.switch_id <<= 8;
-				info.switch_id |= ((uint8_t *)payload)[i];
-			}
-			switch_id_set = true;
-			break;
-		}
-		off += RTA_ALIGN(ra->rta_len);
-	}
-	if (switch_id_set) {
-		/* We have some E-Switch configuration. */
-		mlx5_nl_check_switch_info(num_vf_set, &info);
-	}
-	MLX5_ASSERT(!(info.master && info.representor));
-	memcpy(arg, &info, sizeof(info));
-	return 0;
-error:
-	rte_errno = EINVAL;
-	return -rte_errno;
-}
-
 /**
  * Get switch information associated with network interface.
  *
@@ -1534,35 +1555,30 @@ int
 mlx5_nl_switch_info(int nl, unsigned int ifindex,
 		    struct mlx5_switch_info *info)
 {
-	struct {
-		struct nlmsghdr nh;
-		struct ifinfomsg info;
-		struct rtattr rta;
-		uint32_t extmask;
-	} req = {
-		.nh = {
-			.nlmsg_len = NLMSG_LENGTH
-					(sizeof(req.info) +
-					 RTA_LENGTH(sizeof(uint32_t))),
-			.nlmsg_type = RTM_GETLINK,
-			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
-		},
-		.info = {
-			.ifi_family = AF_UNSPEC,
-			.ifi_index = ifindex,
-		},
-		.rta = {
-			.rta_type = IFLA_EXT_MASK,
-			.rta_len = RTA_LENGTH(sizeof(int32_t)),
-		},
-		.extmask = RTE_LE32(1),
+	struct mlx5_netdev_info netdev_info = {
+		.ifindex = ifindex,
 	};
-	uint32_t sn = MLX5_NL_SN_GENERATE;
+	bool num_vf_set;
 	int ret;
 
-	ret = mlx5_nl_send(nl, &req.nh, sn);
-	if (ret >= 0)
-		ret = mlx5_nl_recv(nl, sn, mlx5_nl_switch_info_cb, info);
+	ret = mlx5_nl_netdev_info_get(nl, &netdev_info);
+	if (ret < 0)
+		return ret;
+
+	memset(info, 0, sizeof(*info));
+
+	if (netdev_info.flags & MLX5_NETDEV_INFO_FLAG_PHYS_PORT_NAME)
+		mlx5_translate_port_name(netdev_info.phys_port_name, info);
+	else
+		info->name_type = MLX5_PHYS_PORT_NAME_TYPE_NOTSET;
+
+	num_vf_set = !!(netdev_info.flags & MLX5_NETDEV_INFO_FLAG_NUM_VF);
+
+	if (netdev_info.flags & MLX5_NETDEV_INFO_FLAG_PHYS_SWITCH_ID) {
+		info->switch_id = netdev_info.phys_switch_id;
+		mlx5_nl_check_switch_info(num_vf_set, info);
+	}
+
 	if (info->master && info->representor) {
 		DRV_LOG(ERR, "ifindex %u device is recognized as master"
 			     " and as representor", ifindex);
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 07a3b531b5..6446df1812 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -53,6 +53,21 @@ struct mlx5_nl_port_info {
 #define MLX5_NL_RDMA_NETDEV_ATTACH_EVENT (1)
 #define MLX5_NL_RDMA_NETDEV_DETACH_EVENT (2)
 
+/* Maximal physical port name length. */
+#define MLX5_PHYS_PORT_NAME_MAX 128
+
+#define MLX5_NETDEV_INFO_FLAG_NUM_VF RTE_BIT32(0)
+#define MLX5_NETDEV_INFO_FLAG_PHYS_PORT_NAME RTE_BIT32(1)
+#define MLX5_NETDEV_INFO_FLAG_PHYS_SWITCH_ID RTE_BIT32(2)
+
+struct mlx5_netdev_info {
+	unsigned int ifindex; /* [in] */
+	uint32_t flags; /* [out] */
+	uint32_t num_vf; /* [out] */
+	char phys_port_name[MLX5_PHYS_PORT_NAME_MAX]; /* [out] */
+	uint64_t phys_switch_id; /* [out] */
+};
+
 __rte_internal
 int mlx5_nl_init(int protocol, int groups);
 __rte_internal
@@ -119,4 +134,6 @@ int mlx5_nl_rdma_monitor_cap_get(int nl, uint8_t *cap);
 __rte_internal
 int mlx5_nl_get_mtu_bounds(int nl, unsigned int ifindex, uint16_t *min_mtu, uint16_t *max_mtu);
 
+int mlx5_nl_netdev_info_get(int nl, struct mlx5_netdev_info *info);
+
 #endif /* RTE_PMD_MLX5_NL_H_ */
-- 
2.43.0

