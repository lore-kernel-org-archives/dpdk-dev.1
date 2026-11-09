Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464E606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LO9Wv/m0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B45C40A73;
	Mon,  9 Nov 2026 13:58:10 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 794214060C;
 Mon,  9 Nov 2026 13:58:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZavVIIQUhXd4HydT0Q4HeTblDmo2LSMU8IqD7uI84NBhGhMiy8rUVBovbBEhzFZuwSFvsnFQKq+2wxe6kV/lZ6biSDtnr54x7T/cqMuCMvvELqOrjzpa2MfWp05x2rGuYgxlkLr0xTV1miNGwxloB+a1ITPAi/PgVciP5MuHxLZPGaBe1+JxGbVTh3stjN3MEIaYM/n/3XP2Al84xLlQe4H4Q6+Jv9TnjDsBu7tCrLyu9rQKO45c+rYxjLPhOs8NG51MdJvFdyEPEEc2Fy5dJn/NKAqMkHoZU4uERHmylP28ZhZp4nz59Yz5cFIjwqW0MqXylUKqB8T/v+jdRDRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiNE8Bc2RZbJfAxSCW2vnBybHINuoB8j63j/Cs1YMcU=;
 b=PlTHJTC8nJx9Z2BTgrUbtSQzFmhRcJxsacSwNVe/mkir4egkfri4mBIK8Yhx0lWwcPO7jW58+n0WjwVwb91xez64VxyF88BsmUvLPyY6EgAGR/O7EmPPc2G79nvsyrIaM7bJemEIXoaQequkL9Hf/EmbyOojWXgsfd+of2r8nxjT+zu1ybAgofaCnOS1uknakIP1pOEMK73mBOXhYfqk0KISp0pQwnEGWVw74HLg0mC+xH/TEeaVr0H9yTRb91VHMaKI7Rxe1xQ3hGHmlp17p97bNvkybm9z/zoN0/pqLgbRYxfRogmw1SU6O8HixtKXtr9xClDKTuDVMgXxNglyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiNE8Bc2RZbJfAxSCW2vnBybHINuoB8j63j/Cs1YMcU=;
 b=LO9Wv/m0cLIlWhHLI5kIXtV63Rqa8c2NBpPIXd7QFm2Rs8cFGTQEKpt7E96fa0XK0kW2MYRsJSrwJsqIYyL3YI2DlmBG6To+s0Wo6HYRCU963SXh940H1py60gHj4E0F/l5uvBkUNy+9Xvx28yfEjqaWAjahE4DSutR0yxiF70NnMRW0pQCooi1fCfWH9JIVuwD2sn5HVCz7JOlkXR8ObnpmnMO67JrGeGiLWqpDmpmMfdbT7NlLrQOADMzTEeFlcp5DSGjyczC0n+JRYO/8QXhbbKuHkgs8y9Rh2VwCAXknO9ZLVvhlwjKnwZSO1wx935CnL7pEx8wSjb0Ge+RxnA==
Received: from CH5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:1f4::9)
 by AT6PR12MB026552.namprd12.prod.outlook.com (2603:10b6:170:116::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:58:03 +0000
Received: from DM3PEPF000265B1.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::36) by CH5PR04CA0024.outlook.office365.com
 (2603:10b6:610:1f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:58:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM3PEPF000265B1.mail.protection.outlook.com (10.167.23.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 12:58:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 04:57:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 04:57:46 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport; Mon, 9 Nov
 2026 04:57:44 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <viacheslavo@nvidia.com>, <bingz@nvidia.com>, <orika@nvidia.com>,
 <suanmingm@nvidia.com>, <matan@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: report HWS counter pool allocation failure
Date: Mon, 9 Nov 2026 14:57:40 +0200
Message-ID: <20261109125740.4034743-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109125740.4034743-1-mkashani@nvidia.com>
References: <20261109125740.4034743-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B1:EE_|AT6PR12MB026552:EE_
X-MS-Office365-Filtering-Correlation-Id: bc98f793-5847-489f-e6d2-08df3e61172b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|6133799003|10067099003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021135927099003|261021121427099003|56012099006|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jCZcoMCBzEIemv3wtkUJcuWWy7jD8Y7Ob8l4a1Of8Jxs+1QJMO660WZPrWeP7Jxbfzh7wSq7x6bL2nvYnxzy26c4jpBBcLVU6AYp97l8jzULoW0dcW9CNkfllSjzE1Ms1xWMQVZfGp97Fs0ETlCUmlm+zzfS9a4eUeUnPWHWPp9Z2f1O1jfgY+UrrEt+bhFmXIAIimRXb3tCPLwWVP4u70V052jTnftf9jmKLxt0FmWSdFmrwiji0W0Kgv6pLJHblCPUjypsVzOzZdlFbPbrVnrd6QBhwZzAIEbHpSXOkgU/gRFr1GPeNVK4gYDTKYJsr0WRrv7ZY51TxhGE56fc3MXZkBB1zIYkYWhMj3Fw6N8dKjTjO6dmPyQmmZsbW2vveVXKF1GxuGCzOSEJrNJvMCftzOGIOuBGN84HQm9URgSA2SeN4o/8MG4u456Iq6wq/o8vKS9Gzm/LvAZOEks84fnXTxLkAdDUeYfDj2KpkUE3NyI+geT9MF7X67hsYEJnb0fRfUgYX7xa3bvTmsqquN4FGZM2WEpVGcAds5z0NnYtlSySeCzW1/OUtnA8WkaMfPTLh/kCEMPLFtXgajwDlHgjBd99agX8JwBXppulPVy/1dhag7T0+Hkua5DGBnU6JN7xCfplsQ/C0hYStmvUO9S0zBdFfG9Zm4xa8mHCqWpbAk6f0UzpzM4FvphwrqzsLH3wP2dkdkojyr8qsD05vg==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021135927099003)(261021121427099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QyvBK6vkz4eRXaJMK0i4oHKI68S9SgCkmRPVhfXKfi5yLQOJ8nPqYdw6wnGMFiCvhGOF4s7/NonQQozUGipwprDs8moQFKpji/TeLhBGb0C38TejAmaGFhZvUOFOdsMhjzzIZx5Eq+kKJxbag6OIS5m/pc1WBZhBxcwN91cavs//XT1H/AeGsKncAP+xh4HfmCeTdFpAKI5f4YBxLfVlHF2fLDXdgjBrWhgZAiOafSayy+w+VS7OmkeoD6LfsV06TSdOeq1b2KlD3Tz53EfFt9+tSCr6DZWnuLDx1Jj3el0dwOTrk/O3BmdcXOGCD3M1d8IESJu8AyOL277EcPH+0ErUrgf9OSJhQy0ZhZRYrcqSWYw4QGVYFdzzHzr7nUSjfcGLe41bZj2FREcQHHGM6GjOLSLEzQjaOLTHVB/1PCruSWgnTYr/2cPuedmvjyAE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:58:03.0023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc98f793-5847-489f-e6d2-08df3e61172b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB026552
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

Non-template HWS pre-allocates half of the device counter capacity
from hugepage memory. When that allocation fails, the PMD replaced
the specific error with "counters pool not initialized".

Log the failing allocation and return the original error. Document
that this pre-allocation can exhaust hugepages, and that the
application can reserve more hugepages or configure fewer counters.

Fixes: 4d368e1da3a4 ("net/mlx5: support flow counter action for HWS")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst        | 10 ++++++++++
 drivers/net/mlx5/mlx5_flow_hw.c | 11 ++++-------
 drivers/net/mlx5/mlx5_hws_cnt.c | 20 ++++++++++++++++++--
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 45d1a25ec18..64cd09c9944 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -2992,6 +2992,16 @@ With :ref:`HW steering <mlx5_hws>`:
    - Linux kernel >= 6.4 and rdma-core >= 60.0 for upstream drivers/libraries or,
    - DOCA >= 3.2.0 for drivers/libraries provided by NVIDIA.
 
+#. The non-template API pre-allocates half of the NIC counter capacity
+   from hugepage memory when the first ``COUNT`` action is created.
+   Other allocations, such as large mbuf pools, can use up the hugepage
+   heap first. Counter creation then fails.
+
+   Reserve more hugepages, or call ``rte_flow_configure()`` with a
+   smaller ``nb_counters`` before creating the first ``COUNT`` action.
+   An explicit configuration allocates only the requested number of
+   counters.
+
 
 .. _mlx5_age:
 
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 8b74f66770b..481b01a21e3 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -12768,13 +12768,10 @@ flow_hw_action_handle_validate(struct rte_eth_dev *dev, uint32_t queue,
 		}
 		break;
 	case RTE_FLOW_ACTION_TYPE_COUNT:
-		if (!priv->hws_cpool) {
-			if (flow_hw_allocate_actions(dev, MLX5_FLOW_ACTION_COUNT,
-						     error))
-				return rte_flow_error_set
-					(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					 NULL, "counters pool not initialized");
-		}
+		if (!priv->hws_cpool)
+			return flow_hw_allocate_actions(dev,
+							MLX5_FLOW_ACTION_COUNT,
+							error);
 		break;
 	case RTE_FLOW_ACTION_TYPE_CONNTRACK:
 		if (priv->hws_ctpool == NULL) {
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index d6f713fd9bd..c2aa75c865e 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -31,8 +31,11 @@ __hws_cnt_id_load(struct mlx5_hws_cnt_pool *cpool)
 
 	cnt_arr = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO,
 			      cnt_num * sizeof(cnt_id_t), 0, SOCKET_ID_ANY);
-	if (cnt_arr == NULL)
+	if (cnt_arr == NULL) {
+		DRV_LOG(ERR, "Failed to allocate counter ID array: %zu bytes.",
+			cnt_num * sizeof(cnt_id_t));
 		return -ENOMEM;
+	}
 	/*
 	 * Counter ID order is important for tracking the max number of in used
 	 * counter for querying, which means counter internal index order must
@@ -290,6 +293,8 @@ mlx5_hws_cnt_raw_data_alloc(struct mlx5_dev_ctx_shared *sh, uint32_t n,
 	mng->raw = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO, sz, pgsz,
 			SOCKET_ID_ANY);
 	if (mng->raw == NULL) {
+		DRV_LOG(ERR, "Failed to allocate raw counter memory: %zu bytes.",
+			sz);
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 				   NULL, "failed to allocate raw counters memory");
@@ -469,6 +474,9 @@ mlx5_hws_cnt_pool_init(struct mlx5_dev_ctx_shared *sh,
 				 sizeof(struct mlx5_hws_cnt) * cnt_num,
 				 0, SOCKET_ID_ANY);
 	if (cntp->pool == NULL) {
+		DRV_LOG(ERR,
+			"Failed to allocate counter pool: %zu bytes for %" PRIu64 " counters.",
+			sizeof(struct mlx5_hws_cnt) * (size_t)cnt_num, cnt_num);
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 				   "failed to allocate counter pool context");
@@ -773,8 +781,12 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 		goto error;
 	}
 	ret = __hws_cnt_id_load(cpool);
-	if (ret != 0)
+	if (ret != 0) {
+		rte_flow_error_set(error, ENOMEM,
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "failed to allocate counter ID array");
 		goto error;
+	}
 	/*
 	 * Bump query gen right after pool create so the
 	 * pre-loaded counters can be used directly
@@ -805,6 +817,10 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	return 0;
 error:
 	MLX5_ASSERT(ret);
+	DRV_LOG(ERR, "Port %u failed to create counter pool for %u counters: %s",
+		dev->data->port_id, nb_counters,
+		(error != NULL && error->message != NULL) ?
+		error->message : "unspecified error");
 	mlx5_hws_cnt_pool_destroy(priv->sh, cpool);
 	priv->hws_cpool = NULL;
 	return ret;
-- 
2.25.1

