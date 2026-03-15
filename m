Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2498D58B0A
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Mar 2026 08:36:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF68A4025D;
	Sun, 15 Mar 2026 09:36:58 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by mails.dpdk.org (Postfix) with ESMTP id 015164013F;
 Sun, 15 Mar 2026 09:36:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTlSayiRLRVKh3ThSlH4IqooFrZMKf5kMqDLDlL6tpedovuYenvdfjihOKuZaf5bslpAmVxIR0E/SRRp5/3qQyhe/77gpBI0ubr9GPNbm5Eqw9FyJFZCi3x457annTT0Uzvu6RtB9HXIOqYvVzlAkSb2OEXuu7OuzvVScT3ijUcHKI+ATRKZqonUIFRaAZv1SILxUfmJelShiiNxYyMu7b7Yc5sEzZVMDldh4SxFBX6JRBXMNjbCQwFbmi47A+lvkrPAPhYKgaysIzEScUM3On4qXHYbeOSASvNTrHDJsorVHwQ/3hDoBPS6KSnLkTwACWU3wVf3gAcagjHtKgdnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE47sS4sOdspYoQ5p+f7mh3w/LL7pnoqFcsGI+4M0d0=;
 b=RYHPU4B/a/7KiEfqbz2qjunh6rtxMznGTgsfhGccKHWyw2pyed6GE2A7P0JfQP6WI+uJK+qiVJ7XRgPfX+DtdkVpJ2v3cxdPV80J/7LAg7TrTLJ5vjmQjvv37lAJFf/gxMO7b1d69CydM+4YOoNMazS1JN2d96TUT3GyW8rtjUei2k1p5FPm31vL4Bxtvp3LEmvvtpWySxb5xcuu9iOj4cxWcEzmBHZZUSaPAt8nJmZJ6HTxaANQdyGup/HohNyGIBqyTjMiTJfR3nLv0GIGnuTjV9GN7Krp6dJjqW/JVZX8OJI73DJxuwmWc8sscju2c8APMZ3GEzrdZb706hJt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE47sS4sOdspYoQ5p+f7mh3w/LL7pnoqFcsGI+4M0d0=;
 b=bGJnUB+FqOu/tB69M421+EQ87Zh0OAwJif6Z/OAWl0gu2cJkHQhIkZFizDI+mf9bgxiBUexCr93luWwcu2pBZMc3iELGToHVzO/eFKLIZ7yGDYH0364wbXsldPrpuxtD+l27WcTqJafZe/X1mQfA24i7A0VpBFjdN1gi23MZ4rHwnm2kL7VtYFhiJfQealeYB2K1alyXVr0pR4flDhKmeYbW0MsQwcdK6BEgbKVPs/BkEgTXWfyZ9JWlPI1WRoRcqlilqGJ4w60JGK9dWya1rgXcHZ2E1ztBeNvsxFTidavokF6rTGQUgh6wH6sXaMXhfnMu/Ts3wRCCbRBcfNO1mQ==
Received: from CH5P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::19)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.10; Sun, 15 Mar
 2026 08:36:53 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:1f2:cafe::b3) by CH5P221CA0006.outlook.office365.com
 (2603:10b6:610:1f2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.22 via Frontend Transport; Sun,
 15 Mar 2026 08:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Sun, 15 Mar 2026 08:36:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Mar
 2026 01:36:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 15 Mar 2026 01:36:42 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Mar 2026 01:36:39 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Li Zhang <lizh@nvidia.com>
Subject: [PATCH] net/mlx5: fix meter ASO action leak on release to pool
Date: Sun, 15 Mar 2026 10:36:36 +0200
Message-ID: <20260315083636.93386-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a3af39-5f09-4028-76e3-08de826e0264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: aHnC4mLF0qUkLFCaG152lH77g5ccTHXEPN3Afz5ADxRNI1LSUNmY/zLgXAhgF0IG+ctd7T4BPlcG/yPkDJQeM7LVUshWUAqY2z3CzxzyeiKTSYoYKGTWeCvYPudFHh2TPfjKBueFpgwMA97Tnpc39dToNqZlxgcpGk1VxazoG67lGhuK3xWprGErxlqQ6wpQP4XF4CPmM7DrM2482sEMwD5wR7tp4n6mCQEDrLTjk3qrT92M17i+4Xudw6BSGULInoHb320QAk6d7nOyJ1CEtbe5OJzGVvwZeIsMvcWKlpXVyzAdhBd6Ltu7qbSG2zJ8h9yuVGumNGyhG9iNgndtnBZZSOzP269KmqGamEoxt57PSp1kr96ZOKNxzv7YWVQC6WzRNN8L2svlMQhqMOFqXwR3DBhUE5gwcOn8NmU0dpssKeWbt8OOpy4ATCBSXgwj8KXyLFQA9NlkcrgDH1NkcxbBqtODDK26a0h4VHgie483OEDdmegPgXCNntH2QwJweGF51Upn0a2JQqp28QT2JbXhhwEB746HppR7WnKBCPXp4WIOk5m2OgwMg4o37kcdD7tXqFBj+Y5J7mG+ZolbOb1V6Ad+4W0jqCDk3xNbLSDi2cb23oHTTGMIXnJGgGo+6wGq4wkkYW3ViWqhrE4DLIV30akBN+pgUnPpvjxtVluR8ry1uetMVg5NXoKidsJN44jg2Jre9cnSiF7UpAFvxbURCqOv5JdINKd+Bh0sCo/BQK5DX3Bswp8viBpid7zk9phF3b7E1hbcuZx1qX53Xg==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YnB1Of1EhIv1ljyHdY+I2p6HdJYHTJgQG4aIhLjulmRn95OKKIuFHpeKfnMOHNCXTXjw/6l7hWe0SI7nTZxQpuXoLUtS72GLvYS5qQMLHQIfTHkiZ5sdaQZvoS7CKDGKkAyfa5Eb3yBBEJqfajo8Oujobjs0z++JvInjqJMT8PSvFdwJ6dsIwryb9bsuIH30MEcfob+1b56nLx8FHHNrdl+LOICBrie1MzyIACe0DWZ0Iv2VSo1F+C2VhwjX7bMX0Hc+oqLlFpz+VZwreDuGWmh+809FegQTBS/UsZ0UGrSNC8Rftj2LcTVsZnotEiZc2lAeqnyN6XCyWss9O8yw9OyCET8q5toW46AaoJhMeVUnOGjg+zdRiGWklOfxRK96KTrJTvO+BRxMELc5YlDAXW0DL3O5qFA8J6EgZAGOPApCkHvuwRABU69FqMFDlErA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 08:36:52.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a3af39-5f09-4028-76e3-08de826e0264
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
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

flow_dv_aso_mtr_release_to_pool() uses memset to zero the entire
mlx5_flow_meter_info struct when returning a meter to the free pool.
This erases the meter_action_g and meter_action_y pointers without
calling destroy_flow_action on the underlying DR ASO actions.

The leak compounds on repeated meter create/destroy cycles because
the caching check in flow_dv_mtr_alloc() — if (!fm.meter_action_g) —
always sees NULL and allocates a new action every time instead of
reusing the existing one.
At shutdown, mlx5_aso_flow_mtrs_mng_close() also skips destruction
since the pointers are already NULL.

Fixed by saving and restoring meter_action_g and meter_action_y across
the memset so the cached actions survive pool recycling and are
properly destroyed only at shutdown.

Fixes: e6100c7b6226 ("net/mlx5: add flow meter pool to manage meter object")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index d1bed18077..32e75b063f 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -7286,10 +7286,16 @@ flow_dv_aso_mtr_release_to_pool(struct rte_eth_dev *dev, uint32_t mtr_idx)
 	struct mlx5_aso_mtr_pools_mng *pools_mng =
 				&priv->sh->mtrmng->pools_mng;
 	struct mlx5_aso_mtr *aso_mtr = mlx5_aso_meter_by_idx(priv, mtr_idx);
+	void *meter_action_g;
+	void *meter_action_y;
 
 	MLX5_ASSERT(aso_mtr);
 	rte_spinlock_lock(&pools_mng->mtrsl);
+	meter_action_g = aso_mtr->fm.meter_action_g;
+	meter_action_y = aso_mtr->fm.meter_action_y;
 	memset(&aso_mtr->fm, 0, sizeof(struct mlx5_flow_meter_info));
+	aso_mtr->fm.meter_action_g = meter_action_g;
+	aso_mtr->fm.meter_action_y = meter_action_y;
 	aso_mtr->state = ASO_METER_FREE;
 	LIST_INSERT_HEAD(&pools_mng->meters, aso_mtr, next);
 	rte_spinlock_unlock(&pools_mng->mtrsl);
-- 
2.34.1

