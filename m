Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C86606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C4E1btr4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 689EE4060C;
	Mon,  9 Nov 2026 13:58:09 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by mails.dpdk.org (Postfix) with ESMTPS id 44DB340151;
 Mon,  9 Nov 2026 13:58:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrqRZ4BSyBpVEcz0TzvHNwfMom4+3kOIueWQucVkwU6WOq5epbc4tkfE/04KPHUATHOXti+aRdHHgvOJbEXCGbhtiddYJpVzwOIcSwfeeb1VzxjvIn845ElIu0zyhNspc062dU5cPvViFNqGcCuhmkih0CywD3t3L8xC5lbMPVZjoCMnLB2dPHqEYXXY4kH8OEkQimaqEBGFuGY1wlrjpdLYaNRooV/yhLFxt3aj2D39riHMHmrolCci7XLgKEMDpVUyuI2mfa/xOz0Qqb+O+Vx13iNlE7EptzODJB7TWDbht3EQwRujJXTlXZp1oFT27864FN3bFp4JW1CbMNj7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r637QfhfknuuxjDraOCtPZOZJtghAlpmBOwiXulNg0g=;
 b=xzaU91Sx4t66wlLehwP5NHUntwPoK2yp+f9HnXarSGKYMeQEhQPxoNT6ueEFQUNQvKe2uLoeq27p8RXUipu4pO6rV65TGDP2i5rxahIIWtbh8Rt5mIlynxZicpJonB1MqCct0+r9tiQBe+pBuUJeuHmzoRs0G2EbktOqPLpaGi7c+L2eX5PUcq7hWLLikIzwRip44pF3f6pnnSiBGmVRfPdp1t1g2PBRYDFQf8RmsJOhDmcnq2lWDd35kTc/oUW02ie4cTgcuvUdhxErWuApX5VvPcejR5mANb/NvL+DlTOZxb2ENn+52Io9Ir+sZEKyw8NCrGwXjBl1ar3rU1qx8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r637QfhfknuuxjDraOCtPZOZJtghAlpmBOwiXulNg0g=;
 b=C4E1btr4/MwT69xHkP+GbzpewR/+B4NPlN4yljzGg8GJKWhZWrIcWBQZQEZJZRM3XKc+rPg4k+UjmIBeV1HlzhSm93yVe6kKmRhcCYo1VW1xXQASHrSox8OmSpffyDF5a3IJSoSJjywLVqIMa+oFpCxVqd6zKBrqKEl0h3GFIyGR+V/NzcV5fTOlX34oUPdwWz7jYBOhFnNe4jsLrtWYZjZz+/E2+usFTJ9/IvaU1reATTYiTldTlHAYss6/rKEZ/FJspbwVVg04qe2HTGxuVSWMep0xEArgvpBn9KZ5EQERIyxJVUMHnVoQATPkbFfib2o4UCSNNUGUBJvFlD2YQA==
Received: from CH0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:610:b3::7)
 by IA0PPFB67404FBA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:57:58 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::5f) by CH0PR03CA0032.outlook.office365.com
 (2603:10b6:610:b3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:57:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 12:57:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 04:57:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 04:57:43 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport; Mon, 9 Nov
 2026 04:57:41 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <viacheslavo@nvidia.com>, <bingz@nvidia.com>, <orika@nvidia.com>,
 <suanmingm@nvidia.com>, <matan@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: [PATCH 1/2] net/mlx5: embed HWS counter pool name in the pool
Date: Mon, 9 Nov 2026 14:57:39 +0200
Message-ID: <20261109125740.4034743-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|IA0PPFB67404FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 145cdb79-6ce1-4270-ba9c-08df3e61144e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|10067099003|11063799006|261028144727099003|261102123227099003|261022105027099003|261021123027099003|56012099006|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: NbU7xQl1C70P+WjePQAwKi7yCOETJuWRZqNikDsAlVIVtE9NmB25LFW5KRscdthjU9Xm9kpDb8sC4e31CyhRY9YbItKgEFnep+lIWD4UueTt4HDsw9LonaRh0KHV1kT4As3wru5FPXjz1rVg4DD7WTEugatyQrv9t67EcvLZaJV/Dks+Z15lxiIIe+2hzY75bWCTh3DQZYikrrTCCBSz1sx8k00F51NaNKndX4dq7C1eegBuAnS4zyUphYwuQjVjgZPHU41v2mlWDGbVIBvph1X8/b7Y/vK06ALWKEPPkghNKXXnTSncvtrY2hiiqaZyP3YAsgHtAYux7aKG0a4oqsO6loeZ4vjn7tUchwh8BSGMV3fwm7JTrGbhnn3PlkDpjN3Bu7RxDFRJzer+Br/PxRKZaAnoNDNSSa1glcr72v7Z3wUiReOwHhcaghtiUH3gzDBnyhdCaejlsnoFuKg782z0wADL1rR3uat9AlSpzIUyn/OuW8RJVeTW4FeaQjwIGHWYMwX7yvwHsMfRSYAy2Ub1S1UVPgKJzXtIMnAeaGKnLiUavuWKRdRjw836dsls4joGCOPqFNw+QrLUic7BKxhDnaLgrj+WzfzUOY9DoL+oU5FNlShXM118LfwQPQftsVFsbm6lj0AFaL/05YIUGX1JE8VMInn90DuuHsyVI3kP7PczusqH6KWdwho14sPUlve633OP42B/t7BtrxW6wg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(56012099006)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6CYl4J21EXYTXge2BS701KD51umm/MGr+4byRSgR4v2WbFK2g0RbP9gNbHxidiXoAt/qu/NcHdZN114oi112VGThcApdq8EmvqpVCGpV72QiXSz09W08/D20MKvAwDcKbHkkiUVdmXzwaXvbf3G/L7FtsgfuBx/XgKgyWKydR/76FSn8F8o+HrISmvUgGF1O3VK8XO1I6GQcoUu/lzR/1ybDMA8xXuDel5US62DRKE77LYv07vPaMhceW4YNF1k8QKc2hKtoDa36mQUdRFDKMS0O+x0/ThI5Hm7NWRysVPJOzc/cL5c0XKMuosCEZ3sIOPrLfVfDesrw8URh3gwGgDGoQhCRzjS6RCgKF4XpnTsDjeJZfjwjuBsD8ZSy8qQzVI6PfPARTNb3tLuioTFW/C29yiWf3fICYQ8EP7kjoLaUcTWIroXd+0pMUEmO1HQr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:57:58.1803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145cdb79-6ce1-4270-ba9c-08df3e61144e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB67404FBA
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

The pool name is a small fixed string, but it was allocated separately
and the pointer was stored in the pool config. Destroy always freed
that pointer. The create error path freed it again, which logged
"Invalid memory".

Keep the name in the pool config. The string is copied with the config,
so create and destroy no longer allocate or free it.

Fixes: 9e34fcc81c00 ("net/mlx5: fix leak in HWS flow counter action")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.c | 13 ++-----------
 drivers/net/mlx5/mlx5_hws_cnt.h |  3 ++-
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index d0c4ead71b7..d6f713fd9bd 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -730,18 +730,11 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_hws_cache_param cparam = {0};
 	struct mlx5_hws_cnt_pool_cfg pcfg = {0};
-	char *mp_name;
 	int ret = 0;
 	size_t sz;
 
-	mp_name = mlx5_malloc(MLX5_MEM_ZERO, RTE_MEMZONE_NAMESIZE, 0, SOCKET_ID_ANY);
-	if (mp_name == NULL) {
-		ret = rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-					 "failed to allocate counter pool name prefix");
-		goto error;
-	}
-	snprintf(mp_name, RTE_MEMZONE_NAMESIZE, "MLX5_HWS_CNT_P_%x", dev->data->port_id);
-	pcfg.name = mp_name;
+	snprintf(pcfg.name, sizeof(pcfg.name), "MLX5_HWS_CNT_P_%x",
+		 dev->data->port_id);
 	pcfg.request_num = nb_counters;
 	pcfg.alloc_factor = HWS_CNT_ALLOC_FACTOR_DEFAULT;
 	if (chost) {
@@ -814,7 +807,6 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	MLX5_ASSERT(ret);
 	mlx5_hws_cnt_pool_destroy(priv->sh, cpool);
 	priv->hws_cpool = NULL;
-	mlx5_free(mp_name);
 	return ret;
 }
 
@@ -842,7 +834,6 @@ mlx5_hws_cnt_pool_destroy(struct mlx5_dev_ctx_shared *sh,
 		mlx5_hws_cnt_pool_dcs_free(cpool);
 		mlx5_hws_cnt_raw_data_free(cpool->raw_mng);
 	}
-	mlx5_free((void *)cpool->cfg.name);
 	mlx5_hws_cnt_pool_deinit(cpool);
 }
 
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.h b/drivers/net/mlx5/mlx5_hws_cnt.h
index 63a14f4f7a0..5a55820abec 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.h
+++ b/drivers/net/mlx5/mlx5_hws_cnt.h
@@ -5,6 +5,7 @@
 #ifndef _MLX5_HWS_CNT_H_
 #define _MLX5_HWS_CNT_H_
 
+#include <rte_memzone.h>
 #include <rte_ring.h>
 #include "mlx5_utils.h"
 #include "mlx5_flow.h"
@@ -87,7 +88,7 @@ struct mlx5_hws_cache_param {
 };
 
 struct mlx5_hws_cnt_pool_cfg {
-	char *name;
+	char name[RTE_MEMZONE_NAMESIZE];
 	uint32_t request_num;
 	uint32_t alloc_factor;
 	struct mlx5_hws_cnt_pool *host_cpool;
-- 
2.25.1

