Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E3CA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 11:46:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B3DB402F1;
	Tue, 26 Aug 2025 13:46:46 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by mails.dpdk.org (Postfix) with ESMTP id 54DDC40611
 for <dev@dpdk.org>; Tue, 26 Aug 2025 13:46:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwwoEWG3RIBNkHC3BAb/hO9iPFxoFuQa+tHmRZUwOgQP9teCqmDCdOTExMuLdTuimYlmcZFkqja9E2ZgNJhAQY06K6bdfff4Rm6cRY1MuumbbAKT2ghuoLJnxUQvl+obC1IW1PgOQtN2sOaC/YV4nf6g84Ez8RfItXa5Z7CbibHvRPozaGbJVKHeMuRWOh7CIh7jEo8x5DlD2cF8Dm/nveG8dvVSCVKB2sEu2dR5JXM0sTm7xog7YBGs+ldER9jxoFEtkqO+qM3+7tEII/NAQJrHc12qQOrwJA55sVyRoCafFPKdQzYSx+VI9jzZ4vFUreuD+e01KSwTcU0ve0I4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKPm446a247oMfORxfJQklF3Qzf5k2kb7s/IGiGOAfk=;
 b=Qkhy07ayXEw9w4DAeDH04f8wBCzdcmQO8ZC5GY7QQ8VeHDc1gobKcujmpwj0m3C0iI4mNtdKR8hIcgzlxWuFlQb4ozxy/tMG9aU6/K3iOZl5DZ2FA8mvWaqSBAtzE18oI3MPk+1buadws33ooihl8EDy0X2GmEjMsnbYKSJfqlQgYKoZIy0P/citWsgFG5Y5uG4iMZgPPCpGTXHclGdj3nT+kbuvj1sGKVjDGp29QpqtX6UQt+C4SeRRrniRwHYVCUbsKu8MPAtZZBPEnlVMH1uHjvdKObOG3IgP0GFyHDKaD4aQROdem3cnYsxNr+lGRx68Lk539nPk+S6D24yKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKPm446a247oMfORxfJQklF3Qzf5k2kb7s/IGiGOAfk=;
 b=OGP4tCct++6erngqFKQ+DCdzntysaBL2HYZ8G+QhY6QJTnX0ydX4qW0+3oq/X5olaAoU2/okna7ymhh/ItICR6MadVPyY8eAhff+av6jMbSuDQH9zRqytkO/Xft/yf9F1VDgj9msq9AmFZXbSmN+lUfByJ/n1RBZbYkMcrq6dwIAwT/joXf4FmD12VwDrLArBh3W6FvUGrNGVwp2SsKTCqYtr4DjjiHpgRmIXO7Ef93EMTkzpgHRv3ivh1nvyH++AojVSm9enZGb997PSiFsSMMasbqU2Dv3RwO9TiLYwyXBvERCgvR4CcvoOEudzGLFPEltBhsssLdAsgXRnG4O1A==
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by SA5PPFF1E6547B5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 11:46:37 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:254:cafe::6c) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Tue,
 26 Aug 2025 11:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Tue, 26 Aug 2025 11:46:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 04:46:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 04:46:25 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 04:46:23 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 1/4] net/mlx5: add driver event callbacks
Date: Tue, 26 Aug 2025 14:45:52 +0300
Message-ID: <20250826114556.10068-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250826114556.10068-1-mkashani@nvidia.com>
References: <20250826114556.10068-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|SA5PPFF1E6547B5:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fc4e81-17ea-49bf-bea8-08dde49636dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?65U4B9DRQUV5yMm155YMBA90rU1DrPpWbyhhGZqclhuI1GwJ7XieV1wl8gxg?=
 =?us-ascii?Q?0qghLQsHMN8pY0w+XsmqiQNt/f+O56GrxT0aisGmOaBCr4QyvH++Oabj8U+P?=
 =?us-ascii?Q?gWYZB1ygAfLnmwZdX7danzWg/sBlLvUR3+gYCGadK5h+Gc52f47adPxPFrA5?=
 =?us-ascii?Q?JfmJPrYyaPpdT6DhqFr4gqQos4C0epL4YrtDW7r79p6iWTe8ryh7Fu6DZ0Wt?=
 =?us-ascii?Q?tiyhZJNiHnF3ju3OJdCkiAi3JGT3N4rFyhERAKtzsyLWjx18xtTSLRlQEBN6?=
 =?us-ascii?Q?P50cpQZNl87XNpblWpQhD6nmyvfjWeorN2dc22GNqrmLwu5YIbR41V/85bv4?=
 =?us-ascii?Q?0SyTGqWE/AAp1HTkeaZ9QPwwpvU6WkoP+gOLQ5uQvr+Vl9T0rci7BvdRdf+T?=
 =?us-ascii?Q?iXvoa0pqMsF+x+41Q5z3chjwwK+LCXDHxqPd8SwAMvRpHEE5F9DRdcRCXd9+?=
 =?us-ascii?Q?33CijN4nm0c+c/1+9ibeN9rCOk/OtiCtq/MY+dxs92sh8A3s5DdcK4/HvXct?=
 =?us-ascii?Q?Ce6sTna0WQI0Mra22Q7FpZrFMs6wtH01pRX3uvHY1644qtxWnbEyvaUrLsyy?=
 =?us-ascii?Q?WPJ6o5FQhcqY1pWOAeiPncrlEkvQsJ+CVn2n2eMdQSa0cOyUzqFdCWPzpJ3t?=
 =?us-ascii?Q?IL72i68lZt00rJis8pkVa3QO3gBzRzI2iD0M5ryXbLzOhfVqLTK0wIiwXjez?=
 =?us-ascii?Q?lcNMZd1RaymbHfFCKkQQ23WjRrPdbvV1gvClfUHRPn0TjdiEK8LW2LnGAooK?=
 =?us-ascii?Q?kIypnc21+7ts2Bk4RWWW6OUOQIKy8tkeAQhLZQLAleqNfo2fuBaFzCVDS1Rw?=
 =?us-ascii?Q?/CFprRSLAzUcPuhFlCdP74in2/IrLmoHUsUZKTzCbcTJvAkOv4niIzXPIuVS?=
 =?us-ascii?Q?8MV629iTprUDR9Sbim+dMxQYbs6MeX9JcPeM5ECo0hbw0Wq5S/TIhRyRZT1h?=
 =?us-ascii?Q?lUHbBppt52MsA6/YlYM45USt4uSsHWxBypHWP9Vt8rLg6StYdz1HXYOYxyjp?=
 =?us-ascii?Q?/dNIWnGQ8jDZhz4muoCaRqUzD7TjL2prd+1Wnm33Ib5GWPDWQ1SfNgWpeaWS?=
 =?us-ascii?Q?FfLoQDyfl5RU9kFa89DQ1dVW1kD7GGj8KUUzLQpx8aDuuMvYLj+OUY0aZDms?=
 =?us-ascii?Q?vLj3V7ajZl8lLL22yApDakwKOJxkuSVoMzvim5+mhL+WV5H+JYO2GQQ4Bah2?=
 =?us-ascii?Q?DVUKcKxzs/RR3wgabZMuMUhda2kqNRFOR53GP+8MO6HU/oK6HLysG9Sf/fBg?=
 =?us-ascii?Q?8a376E8qQt4QGnvCtOrDh/DWbCovmW0Q/ygs1BrlsEDiE7gQwYB89lOZa0Th?=
 =?us-ascii?Q?cEvNtMJxsPWCYs7pgK8qu4yGyOxkozVCxVTxeGwzn/T20bpH2fyjmBOJFa4w?=
 =?us-ascii?Q?onUJMzPhOBc5U8TrAtWXd11f5nxCCtQ5ZUpWqelS/gfM7hoAXYtYa8RLGMzf?=
 =?us-ascii?Q?D7aS/FXNBRRsGIHmJpxfe20JUME76LrPxAMr6bdUYjYXacAwTNw8EBzoknVh?=
 =?us-ascii?Q?3uKuqsaJMgwXTOh2fmDvjGFxtTeKgGF+J8ZH?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:46:37.2547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fc4e81-17ea-49bf-bea8-08dde49636dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF1E6547B5
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

From: Dariusz Sosnowski <dsosnowski@nvidia.com>

mlx5 PMD is a bifurcated driver,
which means that instead of communicating with HW directly
using UIO or VFIO, the driver uses existing kernel and
userspace APIs for that purpose.

One specific area of this usage is creation and configuration
of Rx and Tx queues. This is achieved through mlx5dv_devx_*
family of APIs exposed by rdma-core.
They allow userspace processes to access NIC FW securely.

It is theoretically possible for other libraries or
applications built on top of rdma-core to use Rx and Tx queues
created by DPDK for example in HW offloading set up outside of DPDK.
For example library/application can set up an offloaded flow rule
which will direct the traffic to DPDK queue.

Such use case cannot be achieved right now, because neither DPDK
nor mlx5 PMD expose the identifiers of Rx and Tx queues
created through DevX.

This patch addresses such use case,
by adding new functions to mlx5 PMD private API:

- rte_pmd_mlx5_driver_event_cb_register()
- rte_pmd_mlx5_driver_event_cb_unregister()

These allow external users to register custom callbacks,
which will be called whenever mlx5 PMD performs
some operation (driver event) on a managed HW object,
which was allocated through DevX.
At the moment the following driver events are supported:

- Rx queue creation,
- Tx queue destruction,
- Rx queue creation,
- Tx queue destruction.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/meson.build         |   1 +
 drivers/net/mlx5/mlx5_devx.c         |  17 ++
 drivers/net/mlx5/mlx5_driver_event.c | 300 +++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_driver_event.h |  18 ++
 drivers/net/mlx5/rte_pmd_mlx5.h      | 136 ++++++++++++
 5 files changed, 472 insertions(+)
 create mode 100644 drivers/net/mlx5/mlx5_driver_event.c
 create mode 100644 drivers/net/mlx5/mlx5_driver_event.h

diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index f16fe181930..d67fb0969f8 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -18,6 +18,7 @@ headers = files('rte_pmd_mlx5.h')
 sources = files(
         'mlx5.c',
         'mlx5_devx.c',
+        'mlx5_driver_event.c',
         'mlx5_ethdev.c',
         'mlx5_flow.c',
         'mlx5_flow_aso.c',
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 10bd93c29a4..673c9f3902f 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -20,6 +20,7 @@
 
 #include "mlx5.h"
 #include "mlx5_common_os.h"
+#include "mlx5_driver_event.h"
 #include "mlx5_tx.h"
 #include "mlx5_rx.h"
 #include "mlx5_utils.h"
@@ -239,6 +240,12 @@ mlx5_rxq_devx_obj_release(struct mlx5_rxq_priv *rxq)
 
 	if (rxq_obj == NULL)
 		return;
+	/*
+	 * Notify external users that Rx queue will be destroyed.
+	 * Skip notification for not started queues and internal drop queue.
+	 */
+	if (rxq->ctrl->started && rxq != rxq->priv->drop_queue.rxq)
+		mlx5_driver_event_notify_rxq_destroy(rxq);
 	if (rxq_obj->rxq_ctrl->is_hairpin) {
 		if (rxq_obj->rq == NULL)
 			return;
@@ -612,6 +619,8 @@ mlx5_rxq_obj_hairpin_new(struct mlx5_rxq_priv *rxq)
 		return -rte_errno;
 	}
 create_rq_set_state:
+	/* Notify external users that Rx queue was created. */
+	mlx5_driver_event_notify_rxq_create(rxq);
 	priv->dev_data->rx_queue_state[idx] = RTE_ETH_QUEUE_STATE_HAIRPIN;
 	return 0;
 }
@@ -691,6 +700,8 @@ mlx5_rxq_devx_obj_new(struct mlx5_rxq_priv *rxq)
 		}
 		rxq_ctrl->wqn = rxq->devx_rq.rq->id;
 	}
+	/* Notify external users that Rx queue was created. */
+	mlx5_driver_event_notify_rxq_create(rxq);
 	priv->dev_data->rx_queue_state[rxq->idx] = RTE_ETH_QUEUE_STATE_STARTED;
 	return 0;
 error:
@@ -1440,6 +1451,8 @@ mlx5_txq_obj_hairpin_new(struct rte_eth_dev *dev, uint16_t idx)
 		rte_errno = errno;
 		return -rte_errno;
 	}
+	/* Notify external users that Tx queue was created. */
+	mlx5_driver_event_notify_txq_create(txq_ctrl);
 	return 0;
 }
 
@@ -1670,6 +1683,8 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 		priv->consec_tx_mem.cq_cur_off += txq_data->cq_mem_len;
 	ppriv->uar_table[txq_data->idx] = sh->tx_uar.bf_db;
 	dev->data->tx_queue_state[idx] = RTE_ETH_QUEUE_STATE_STARTED;
+	/* Notify external users that Tx queue was created. */
+	mlx5_driver_event_notify_txq_create(txq_ctrl);
 	return 0;
 error:
 	ret = rte_errno; /* Save rte_errno before cleanup. */
@@ -1689,6 +1704,8 @@ void
 mlx5_txq_devx_obj_release(struct mlx5_txq_obj *txq_obj)
 {
 	MLX5_ASSERT(txq_obj);
+	/* Notify external users that Tx queue will be destroyed. */
+	mlx5_driver_event_notify_txq_destroy(txq_obj->txq_ctrl);
 	if (txq_obj->txq_ctrl->is_hairpin) {
 		if (txq_obj->sq) {
 			claim_zero(mlx5_devx_cmd_destroy(txq_obj->sq));
diff --git a/drivers/net/mlx5/mlx5_driver_event.c b/drivers/net/mlx5/mlx5_driver_event.c
new file mode 100644
index 00000000000..cad1f875180
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_driver_event.c
@@ -0,0 +1,300 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 NVIDIA Corporation & Affiliates
+ */
+
+#include "mlx5_driver_event.h"
+
+#include <sys/queue.h>
+
+#include <eal_export.h>
+
+#include "mlx5.h"
+#include "mlx5_rx.h"
+#include "mlx5_tx.h"
+#include "rte_pmd_mlx5.h"
+
+/*
+ * Macro serving as a longest possible "queue_info" string generated as part of driver event
+ * callback. Used to derive the correct size of the static buffer, so the dynamic allocation
+ * can be skipped during callback.
+ */
+#define MAX_QUEUE_INFO ( \
+	"lro_timeout=" RTE_STR(UINT32_MAX) "," \
+	"max_lro_msg_size=" RTE_STR(UINT32_MAX) "," \
+	"td=" RTE_STR(UINT32_MAX) "," \
+	"lpbk=1")
+
+static char queue_info_buf[sizeof(MAX_QUEUE_INFO)];
+
+struct registered_cb {
+	LIST_ENTRY(registered_cb) list;
+	rte_pmd_mlx5_driver_event_callback_t cb;
+	const void *opaque;
+};
+
+LIST_HEAD(, registered_cb) cb_list_head = LIST_HEAD_INITIALIZER(cb_list_head);
+
+static const char *
+generate_rx_queue_info(struct mlx5_rxq_priv *rxq)
+{
+	struct mlx5_priv *priv = rxq->priv;
+	uint32_t max_lro_msg_size = 0;
+	uint32_t lro_timeout = 0;
+	uint32_t lpbk = 0;
+	uint32_t td = 0;
+	int ret __rte_unused;
+
+	if (rxq->ctrl->rxq.lro) {
+		lro_timeout = priv->config.lro_timeout;
+		max_lro_msg_size = priv->max_lro_msg_size / MLX5_LRO_SEG_CHUNK_SIZE;
+	}
+
+	if (rxq->ctrl->is_hairpin)
+		td = priv->sh->td->id;
+	else
+		td = priv->sh->tdn;
+
+	lpbk = !!priv->dev_data->dev_conf.lpbk_mode;
+
+	ret = snprintf(queue_info_buf, sizeof(queue_info_buf),
+		 "lro_timeout=%u,max_lro_msg_size=%u,td=%u,lpbk=%u",
+		 lro_timeout, max_lro_msg_size, td, lpbk);
+	/*
+	 * queue_info_buf is set up to accommodate maximum possible values.
+	 * As a result, snprintf should always succeed here.
+	 */
+	MLX5_ASSERT(ret >= 0);
+
+	return queue_info_buf;
+}
+
+static void
+fill_rxq_info(struct mlx5_rxq_priv *rxq,
+	      struct rte_pmd_mlx5_driver_event_cb_queue_info *queue,
+	      enum rte_pmd_mlx5_driver_event_cb_type event)
+{
+	/* It is assumed that port is started so all control structs should be initialized. */
+	MLX5_ASSERT(rxq != NULL);
+	MLX5_ASSERT(rxq->ctrl != NULL);
+
+	queue->dpdk_queue_id = rxq->idx;
+	if (rxq->ctrl->is_hairpin) {
+		MLX5_ASSERT(rxq->ctrl->obj != NULL && rxq->ctrl->obj->rq != NULL);
+		queue->hw_queue_id = rxq->ctrl->obj->rq->id;
+	} else {
+		MLX5_ASSERT(rxq->devx_rq.rq != NULL);
+		queue->hw_queue_id = rxq->devx_rq.rq->id;
+	}
+	if (event == RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_CREATE)
+		queue->queue_info = generate_rx_queue_info(rxq);
+}
+
+static void
+notify_rxq_event(struct mlx5_rxq_priv *rxq,
+		 enum rte_pmd_mlx5_driver_event_cb_type event)
+{
+	struct rte_pmd_mlx5_driver_event_cb_info cb_info = {
+		.event = event,
+	};
+	struct registered_cb *r;
+	uint16_t port_id;
+
+	MLX5_ASSERT(rxq != NULL);
+	MLX5_ASSERT(event == RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_CREATE ||
+		    event == RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_DESTROY);
+
+	if (LIST_EMPTY(&cb_list_head))
+		return;
+
+	port_id = rxq->priv->dev_data->port_id;
+	fill_rxq_info(rxq, &cb_info.queue, event);
+
+	LIST_FOREACH(r, &cb_list_head, list)
+		r->cb(port_id, &cb_info, r->opaque);
+}
+
+void
+mlx5_driver_event_notify_rxq_create(struct mlx5_rxq_priv *rxq)
+{
+	notify_rxq_event(rxq, RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_CREATE);
+}
+
+void
+mlx5_driver_event_notify_rxq_destroy(struct mlx5_rxq_priv *rxq)
+{
+	notify_rxq_event(rxq, RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_DESTROY);
+}
+
+static void
+fill_txq_info(struct mlx5_txq_ctrl *txq_ctrl,
+	      struct rte_pmd_mlx5_driver_event_cb_queue_info *queue)
+{
+	/* It is assumed that port is started so all control structs should be initialized. */
+	MLX5_ASSERT(txq_ctrl != NULL);
+	MLX5_ASSERT(txq_ctrl->obj != NULL);
+
+	queue->dpdk_queue_id = txq_ctrl->txq.idx;
+	if (txq_ctrl->is_hairpin) {
+		MLX5_ASSERT(txq_ctrl->obj->sq != NULL);
+		queue->hw_queue_id = txq_ctrl->obj->sq->id;
+	} else {
+		MLX5_ASSERT(txq_ctrl->obj->sq_obj.sq != NULL);
+		queue->hw_queue_id = txq_ctrl->obj->sq_obj.sq->id;
+	}
+}
+
+static void
+notify_txq_event(struct mlx5_txq_ctrl *txq_ctrl,
+		 enum rte_pmd_mlx5_driver_event_cb_type event)
+{
+	struct rte_pmd_mlx5_driver_event_cb_info cb_info = {
+		.event = event,
+	};
+	struct registered_cb *r;
+	uint16_t port_id;
+
+	MLX5_ASSERT(txq_ctrl != NULL);
+	MLX5_ASSERT(event == RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_CREATE ||
+		    event == RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_DESTROY);
+
+	if (LIST_EMPTY(&cb_list_head))
+		return;
+
+	port_id = txq_ctrl->priv->dev_data->port_id;
+	fill_txq_info(txq_ctrl, &cb_info.queue);
+
+	LIST_FOREACH(r, &cb_list_head, list)
+		r->cb(port_id, &cb_info, r->opaque);
+}
+
+void
+mlx5_driver_event_notify_txq_create(struct mlx5_txq_ctrl *txq_ctrl)
+{
+	notify_txq_event(txq_ctrl, RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_CREATE);
+}
+
+void
+mlx5_driver_event_notify_txq_destroy(struct mlx5_txq_ctrl *txq_ctrl)
+{
+	notify_txq_event(txq_ctrl, RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_DESTROY);
+}
+
+static void
+notify_existing_queues(uint16_t port_id,
+		       rte_pmd_mlx5_driver_event_callback_t cb,
+		       void *opaque)
+{
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+	struct mlx5_priv *priv = (struct mlx5_priv *)dev->data->dev_private;
+	unsigned int i;
+
+	/* Stopped port does not have any queues. */
+	if (!dev->data->dev_started)
+		return;
+
+	for (i = 0; i < priv->rxqs_n; ++i) {
+		struct mlx5_rxq_priv *rxq = mlx5_rxq_get(dev, i);
+		struct rte_pmd_mlx5_driver_event_cb_info cb_info = {
+			.event = RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_CREATE,
+		};
+
+		/* Port is started and only known queues are iterated on. All should be there. */
+		MLX5_ASSERT(rxq != NULL);
+
+		fill_rxq_info(rxq, &cb_info.queue, cb_info.event);
+		cb(port_id, &cb_info, opaque);
+	}
+
+	for (i = 0; i < priv->txqs_n; ++i) {
+		struct mlx5_txq_ctrl *txq_ctrl = mlx5_txq_get(dev, i);
+		struct rte_pmd_mlx5_driver_event_cb_info cb_info = {
+			.event = RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_CREATE,
+		};
+
+		/* Port is started and only known queues are iterated on. All should be there. */
+		MLX5_ASSERT(txq_ctrl != NULL);
+
+		fill_txq_info(txq_ctrl, &cb_info.queue);
+		cb(port_id, &cb_info, opaque);
+
+		/* mlx5_txq_get() increments a ref count on Tx queue. Need to decrement. */
+		mlx5_txq_release(dev, i);
+	}
+}
+
+static void
+notify_existing_devices(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
+{
+	uint16_t port_id;
+
+	/*
+	 * Whenever there is at least one available port,
+	 * it means that EAL was initialized and ports were probed.
+	 * Logging library should be available, so it is safe to use DRV_LOG.
+	 */
+	MLX5_ETH_FOREACH_DEV(port_id, NULL)
+		notify_existing_queues(port_id, cb, opaque);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_driver_event_cb_register, 25.11)
+int
+rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
+{
+	struct registered_cb *r;
+
+	if (cb == NULL)
+		return -EINVAL;
+
+	LIST_FOREACH(r, &cb_list_head, list) {
+		if (r->cb == cb)
+			return -EEXIST;
+	}
+
+	r = calloc(1, sizeof(*r));
+	if (r == NULL)
+		return -ENOMEM;
+
+	r->cb = cb;
+	r->opaque = opaque;
+
+	notify_existing_devices(cb, opaque);
+
+	LIST_INSERT_HEAD(&cb_list_head, r, list);
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_driver_event_cb_unregister, 25.11)
+int
+rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb)
+{
+	struct registered_cb *r;
+	bool found = false;
+
+	if (cb == NULL)
+		return -EINVAL;
+
+	LIST_FOREACH(r, &cb_list_head, list) {
+		if (r->cb == cb) {
+			found = true;
+			break;
+		}
+	}
+	if (!found)
+		return 0;
+
+	LIST_REMOVE(r, list);
+	free(r);
+
+	return 0;
+}
+
+RTE_FINI(rte_pmd_mlx5_driver_event_cb_cleanup) {
+	struct registered_cb *r;
+
+	while (!LIST_EMPTY(&cb_list_head)) {
+		r = LIST_FIRST(&cb_list_head);
+		LIST_REMOVE(r, list);
+		free(r);
+	}
+}
diff --git a/drivers/net/mlx5/mlx5_driver_event.h b/drivers/net/mlx5/mlx5_driver_event.h
new file mode 100644
index 00000000000..ff4ce6e186f
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_driver_event.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef RTE_PMD_MLX5_DRIVER_EVENT_H_
+#define RTE_PMD_MLX5_DRIVER_EVENT_H_
+
+/* Forward declarations. */
+struct mlx5_rxq_priv;
+struct mlx5_txq_ctrl;
+
+void mlx5_driver_event_notify_rxq_create(struct mlx5_rxq_priv *rxq);
+void mlx5_driver_event_notify_rxq_destroy(struct mlx5_rxq_priv *rxq);
+
+void mlx5_driver_event_notify_txq_create(struct mlx5_txq_ctrl *txq_ctrl);
+void mlx5_driver_event_notify_txq_destroy(struct mlx5_txq_ctrl *txq_ctrl);
+
+#endif /* RTE_PMD_MLX5_DRIVER_EVENT_H_ */
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index fdd2f658887..da8d4b1c83c 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -5,7 +5,10 @@
 #ifndef RTE_PMD_PRIVATE_MLX5_H_
 #define RTE_PMD_PRIVATE_MLX5_H_
 
+#include <stdint.h>
+
 #include <rte_compat.h>
+#include <rte_per_lcore.h>
 
 /**
  * @file
@@ -415,6 +418,139 @@ __rte_experimental
 int
 rte_pmd_mlx5_txq_dump_contexts(uint16_t port_id, uint16_t queue_id, const char *filename);
 
+/** Type of mlx5 driver event for which custom callback is called. */
+enum rte_pmd_mlx5_driver_event_cb_type {
+	/** Called after HW Rx queue is created. */
+	RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_CREATE,
+	/** Called before HW Rx queue will be destroyed. */
+	RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_DESTROY,
+	/** Called after HW Tx queue is created. */
+	RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_CREATE,
+	/** Called before HW Tx queue will be destroyed. */
+	RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_DESTROY,
+};
+
+/** Information about the queue for which driver event is being called. */
+struct rte_pmd_mlx5_driver_event_cb_queue_info {
+	/** DPDK queue index. */
+	uint16_t dpdk_queue_id;
+	/** HW queue identifier (DevX object ID). */
+	uint32_t hw_queue_id;
+	/**
+	 * Low-level HW configuration of the port related to the queue.
+	 * This configuration is presented as a string
+	 * with "key=value" pairs, separated by commas.
+	 * This string is owned by mlx5 PMD and should not be freed by the user,
+	 * and should be copied to the memory owned by the user.
+	 *
+	 * For RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_CREATE this will contain:
+	 *
+	 * - lro_timeout - Configured timeout of LRO session in microseconds.
+	 *   Set to 0 if LRO is not configured.
+	 * - max_lro_msg_size - Maximum size of a single LRO message.
+	 *   Provided in granularity of 256 bytes.
+	 *   Set to 0 if LRO is not configured.
+	 * - td - Identifier of transport domain allocated from HW (DevX object ID).
+	 * - lbpk - Set to 1 if loopback is enabled on the given queue
+	 *
+	 * For all other events, this field will be set to NULL.
+	 */
+	const char *queue_info;
+};
+
+/** Information related to a driver event. */
+struct rte_pmd_mlx5_driver_event_cb_info {
+	/** Type of the driver event for which the callback is called. */
+	enum rte_pmd_mlx5_driver_event_cb_type event;
+	union {
+		/**
+		 * Information about the queue for which driver event is being called.
+		 *
+		 * This union variant is valid for the following events:
+		 *
+		 * - RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_CREATE
+		 * - RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_RXQ_DESTROY
+		 * - RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_CREATE
+		 * - RTE_PMD_MLX5_DRIVER_EVENT_CB_TYPE_TXQ_DESTROY
+		 */
+		struct rte_pmd_mlx5_driver_event_cb_queue_info queue;
+	};
+};
+
+/** Prototype of the callback called on mlx5 driver events. */
+typedef void (*rte_pmd_mlx5_driver_event_callback_t)(uint16_t port_id,
+		const struct rte_pmd_mlx5_driver_event_cb_info *info,
+		const void *opaque);
+
+
+/**
+ * Register mlx5 driver event callback.
+ *
+ * mlx5 PMD configures HW through interfaces exposed by rdma-core and mlx5 kernel driver.
+ * Any HW object created this way may be used by other libraries or applications.
+ * This function allows application to register a custom callback which will be called
+ * whenever mlx5 PMD performs some operation (driver event) on a managed HW objects.
+ * #rte_pmd_mlx5_driver_event_cb_type defines exposed driver events.
+ *
+ * This function can be called multiple times with different callbacks.
+ * mlx5 PMD will register all of them and all of them will be called for triggered driver events.
+ *
+ * This function can be called:
+ *
+ * - before or after #rte_eal_init (potentially in a constructor function as well),
+ * - before or after any mlx5 port is probed.
+ *
+ * If this function is called when mlx5 ports (at least one) exist,
+ * then provided callback will be immediately called for all applicable driver events,
+ * for all existing mlx5 ports.
+ *
+ * This function is lock-free and it is assumed that it won't be called concurrently
+ * with other functions from ethdev API used to configure any of the mlx5 ports.
+ * It is the responsibility of the application to enforce this.
+ *
+ * Registered callbacks might be called during control path configuration triggered
+ * by DPDK API. It is the user's responsibility to prevent
+ * calling more configurations by the DPDK API from the callback itself.
+ *
+ * mlx5 PMD registers a destructor (through #RTE_FINI)
+ * which will unregister all known callbacks.
+ *
+ * @param[in] cb
+ *   Pointer to callback.
+ * @param[in] opaque
+ *   Opaque pointer which will be passed as an argument to @p cb on each event.
+ *
+ * @return
+ *   - 0 if callback was successfully registered.
+ *   - (-EINVAL) if @p cb is NULL.
+ *   - (-EEXIST) if @p cb was already registered.
+ *   - (-ENOMEM) if failed to allocate memory for callback entry.
+ */
+__rte_experimental
+int
+rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque);
+
+/**
+ * Unregister driver event callback.
+ *
+ * Unregisters a mlx5 driver event callback which was previously registered
+ * through #rte_pmd_mlx5_driver_event_cb_unregister.
+ *
+ * This function is lock-free and it is assumed that it won't be called concurrently
+ * with other functions from ethdev API used to configure any of the mlx5 ports.
+ * It is the responsibility of the application to enforce this.
+ *
+ * @param[in] cb
+ *   Pointer to callback.
+ *
+ * @return
+ *   - 0 if callback was successfully unregistered or if no such callback was registered.
+ *   - (-EINVAL) if @p cb is NULL.
+ */
+__rte_experimental
+int
+rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.21.0

