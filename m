Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60BB606A321
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gpYFyu/N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE5C94064E;
	Mon, 26 Oct 2026 17:27:58 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by mails.dpdk.org (Postfix) with ESMTPS id 5C2B940615
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:27:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7U2zZO1aFX2sRQ3GgRLVBWzK/fyT/wBYqfUj3bmcmTQ+8kNUV68U9fQa/5smAThiY3vE4EDAjJgA1aTi3SX5KzDiguYy/F45HWmw/OIXmpobenXQ53gBWmga360nnREk/NRDLw51xmigt+idlHVHS+Xl9QLgfzvtGuWAiFOOAAEp+yTSi7qO5b8Ashv19RFkLM7Fhb0vh5uEwbNdZCRCROHWLKoSro7ne1b861hO+zBw8IrGUSXIvnIlLJBRYv+liGZKA87b/Jx0zvBDVx9Kjs+pR9qyzqJ1aDvcsmDt/9Xp8kIagjSmjyUArMNalbWUfbF57I247Td7dQgLCbeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d5l/zRJvoJQS9VF9GpL+xTTImms8POdMqdH96hLx2U=;
 b=GyiCZA7dfzEB27FBb+WK/GBRsplHo7NMW21ocmXxOZ/zybpFrP3Osc14LKQBE7p7GG9XSpNirQQlQ48wtrCsK+H5kLd/0LtWxvAe1zpSEhNc8I+m1516pqpuQcBIGUXfGr2/OKtU58Vcp/ycs4+7TXKGKyrprCKSTflJtP8fKfFCp2X3Vu3dpXBF1VPXhSETJTxOW66lQ2As8oIRpf7SdtjSmUC+CJBPL20ET03uxO2LuV4M2IBZeIgf2FMc4l2jdMNkYG4ooN7BcDVlFSjVaOS3MUa6SaKiwyU6S1FKWLbYj4PT9BT1RhjbOs823eRhfZbThY7QzvDmLjmYMxmhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d5l/zRJvoJQS9VF9GpL+xTTImms8POdMqdH96hLx2U=;
 b=gpYFyu/NIC09PyrLvKewwcAIFDKh4A2iDSqV/Dk8Mi8cdKAMgEu7Su4ry9+zmlVYFRgO6Nr0bsXHph6PoCfIvFX1i0wFaU9l0hYC71g46CGIDG0cJRMRdqhNbO2LCbmFmTDd9gv/qxCctDvE6QayRU/nRWoTmiEIOXwe6b6p3lgLp4HemZW/p65m4dbtCC589hfn3WLBuiz0sdfiFBMYGKQ4MUWMWrb5VxpRZUqDtyll7I4tZFnWmaYpxswPW0unPmKqt25taDH/zcJMdIb6Gy5Nl9+7IQD5SVhRFHBsEt5EinOHUKu8wlhGzrMtgIi3lY7h39FT6Cj43VJOIKABfA==
Received: from DS1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::15) by
 SA5PPFE3F7EF2AE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 16:27:50 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:8:44b:cafe::5e) by DS1P222CA0023.outlook.office365.com
 (2603:10b6:8:44b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:27:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:27:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:27 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:25 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 02/13] common/mlx5: allow ifindex query without cache
Date: Mon, 26 Oct 2026 17:26:58 +0100
Message-ID: <20261026162709.1292958-3-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: de484614-10b8-4c50-4b78-08df337e13af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|10067099003|18002099003|22082099003|261026121527099003|56012099006|11063799006|261009223027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: C3bLNvUVnCtWLbXfD30BJ92xdR4C/gatOo4rl/jAOqp/7gZZm3XqDc7TxIuMpEEKxgmdQiIu8wEPf4k2YPJFF2e+1yrVXlKMgSgwkz6ytJZlllaxPjfJsHWqXU8TTblcUDD2p0xfp5xRU2lH7Ozgr0ZPbQHaIn5LJiMuJYf6dinb088L7a3yUQyGadqI32RWsywQFw3DpZlcki9uspY+zOEuKMzlFbJXFtudMyLXMiZbaRHjUS0AUnXnaBacDw7WyZbVEZPVuh4D9Ik5FiVgEdGnoVoUa/HJ54LjXwIU7w2CfPdCgNrh3Xw0853GFcKNNUmOTF0g8je07/V+ETBRtmR4pGII7loEYrVO1aNdpZPi6O6BJTAwTb14g0tYIADK5saYSdTFErv7f47BZhvfoanrj6x1pqJO+3AsdopTxHJVc+ZLedzjMwVx+QP2TSUSokuwlrD0y7GcYEJ0spbRONsq7jJ1aOekn//KMqLyjbarjFHCQsA8BkD8Bnyl1l1ncRu2JIQjLxMfq1/5VB2ZgXxhitAC+6N1JIT5juIeWAiPp6Q5dd0mobTCIZm4UK0JsfJSzXqE7gFzKseRRJFxiJuQP/mqjvlr9FGq5xt37uYk8xRIX6uvzeVg5bJUD5YYnFJpvs/EGSrpLxglEpBjX28sHeJBrb5Cws/NEtD7Y3vWSqYWMdHAI2z7fKtIuljgz8f1swdbKJedcPch/Hyybg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261026121527099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lc7RSCsqQcxXN4dzw8W3OFGTrj4YQYUkvzM4Y6/mmwq5fwQbjkKNBCbW7fQUV44YSOKHPLRhOLukcTE3FiLpc8ZiZGS74pnrayugv6iBsK45eDrAvxQwfcKQDdv3YWYffJotxNE1pGQeFErNDuGzei0Lkl74SLKBYmHmIbxHb/218hh/7460y95YKr9xqzzCsmHNbXaRvervbmTj92MijxlEhOHcTJDM+e5XhAuJ1Kyse3Jyb/fuy7K3DLh5Qt2mqanndPKx8DssOyGUQJ1yH7a1T7mEnUGLXvZvl3Sacwmgq352HtreFcbIGvASVPV2iduaI5HyZSSs5PhZh8BSzTcDZV8j5cohTJbvexaAGbimqs7ZSkFGYecMIY5GbO+gpENkYC0TIkpwPlem0wqWLBJs3hjvYiS1eYmrU2/hVdlVymGByCsg1rgdnJl68iwd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:27:49.7929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de484614-10b8-4c50-4b78-08df337e13af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE
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

Translating IB port to netdev ifindex requires that cache
on mlx5 common device is initialized and RDMA monitoring
is set up. Latter happens only when ethdev mlx5 port is spawned.

To enable usage of mlx5_nl_ifindex() inside common driver code,
allow calling it without cache.
If cache is not provided, netlink query will always be executed.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 1132e3fa5f..d4b40bec2c 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -1181,14 +1181,14 @@ mlx5_nl_port_info(int nl, uint32_t pindex, struct mlx5_nl_port_info *data)
  * when faced with port representors. Unfortunately it requires at least
  * Linux 4.17.
  *
- * @param nl
+ * @param[in] nl
  *   Netlink socket of the RDMA kind (NETLINK_RDMA).
  * @param[in] name
  *   IB device name.
  * @param[in] pindex
  *   IB device port index, starting from 1
- * @param[in] dev_info
- *   Cached mlx5 device information.
+ * @param[in,out] dev_info
+ *   Cached mlx5 device information. If NULL, netlink query is done and caching is skipped.
  * @return
  *   A valid (nonzero) interface index on success, 0 otherwise and rte_errno
  *   is set.
@@ -1206,6 +1206,9 @@ mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info
 			.flags = 0,
 	};
 
+	if (dev_info == NULL)
+		goto query_port_info;
+
 	if (dev_info->probe_opt && !strcmp(name, dev_info->ibname)) {
 		if (dev_info->port_info && pindex <= dev_info->port_num &&
 		    dev_info->port_info[pindex].valid) {
@@ -1222,8 +1225,9 @@ mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info
 		rte_errno = ENODEV;
 		return 0;
 	}
+query_port_info:
 	ret = mlx5_nl_port_info(nl, pindex, &data);
-	if (dev_info->probe_opt && !strcmp(dev_info->ibname, name)) {
+	if (dev_info != NULL && dev_info->probe_opt && !strcmp(dev_info->ibname, name)) {
 		if ((!ret || ret == -ENODEV) && dev_info->port_info &&
 		    pindex <= dev_info->port_num) {
 			if (!ret)
-- 
2.43.0

