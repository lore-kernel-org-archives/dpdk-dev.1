Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB70606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P3oREGa1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D367E40275;
	Sun, 25 Oct 2026 09:17:09 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by mails.dpdk.org (Postfix) with ESMTPS id C910D40269;
 Sun, 25 Oct 2026 09:17:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttigFAmkhRE47jH38CEtMAuaEch/oex9JoXr8SIFkXUp0cao0efF2OxuXf9EopgcDGd/sCCa7lRv45XuMSZwd2OpqJPsncfmDMjLWaZZ6bPfjKEITIT4M0RRGMNY3PjbX71rhXAPAL9wbG+aahlkwwNZmTRnBzp9jUJfBv8avmwHzI4j3DjEdMiHTY8OWzNUug5nBzOmPYFG9LimKtE9o6hYVl+orTywOY7zG0sWI0kHWpU1i41aTU9ULaMgXX6icfPAuXLzpOrQz5yvkSLTyE3Gze5bck4qajyUKD1ibcwf9EbkbTHlD/4elhFpOGlGmX91TZG6tWn+zLWwpewN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov5MoVkpr7wTcBaD9+q89n+I7sAN8gqlyTw40k93uTg=;
 b=uMrMjx0JkP7BAn5tnEuuM2ZrKpfeK6f0m3uoR7yhjOt+URBS/HfpS0gTP4FptW2p14v3tmcRQnCeXDPCW5u+7M3QGn8lxRoi5avIahsLNxJvg5XIg6bSSGNsNreIeZosKFpIw+jvKIxsMjT+9zXnBbGcr9LQ/mn6cENX39bX6bs1MLJp3c3wqo+SUezJD3M7+RvGZDaDC8RieH4+RaNVAJxxl7DPfRsdHOsNOOX5P2A7DvjU98qsaghpwvaCi8boqhYQ2z4Y4/qqi0rVjc/aNhvqENEwkQa7zi6JptCoFBuY5EZMnz1TW8zbi/0T1DxojsHZ54VT0jPfH3RehIPNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov5MoVkpr7wTcBaD9+q89n+I7sAN8gqlyTw40k93uTg=;
 b=P3oREGa1NOQYi2uqr7vEScX9NwyvEpAD/ubFTt/Xd5XMtKd+jW2RZnGEtCog4ONQJ9vfPtselYWoZaqqe+VJub012yR1u0Rj12gXyc7xuFKUjt9A+LufMyZiOSE0m0TMMh8x9bTisku6K48rIM+w3ZOfN1ZrBDVHbjG8TZ+aj3wpqjUf38Bu9y0wJp/rhYZDBvZwMLF5Cf/9ZEmluo1zWNPK2s8NH7kk2yRtL5u+uKI64+3T66ODmBhFZGPCIBZ/MlHt09eZpdy818Lf7y91CjUFHDVdlZaTSvLrbA6wyriKX4c0mNjbJcv2qSm6b1v9iroZm4ZKMLnv8zc/gpjKIQ==
Received: from CH2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:610:4f::15)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 08:17:02 +0000
Received: from MN1PEPF000793FB.namprd05.prod.outlook.com
 (2603:10b6:610:4f:cafe::5c) by CH2PR18CA0005.outlook.office365.com
 (2603:10b6:610:4f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 08:17:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF000793FB.mail.protection.outlook.com (10.167.249.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 08:17:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 25 Oct
 2026 01:16:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 25 Oct
 2026 01:16:42 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Sun, 25 Oct 2026 01:16:40 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>
CC: <dev@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 1/2] vdpa/mlx5: fix RSS flow leak on steering update failure
Date: Sun, 25 Oct 2026 10:16:38 +0200
Message-ID: <20261025081639.2746665-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FB:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 96254a10-4611-48be-ebe2-08df32705934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|18002099003|56012099006|11063799006|261021121427099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: dZACXbI190gXkjlMFjm5ZGMgxLF2a34aO15CwIFQ5zMF1qqv8UjWoQBA8RY0Y4lOGF6h3TgbRXsb8bulPLYWN3O1kvteBOeQPKH56REPu0gsX9AMc8aAm+5gUJonl/XYoxulm/S9MOT0kKpk6SXLLWg2VQDP0e90BjAcP/YVFbOjP8k4h369QXJd0rMf049QzPZcTBYX166ho/gFdO8W8/+XYha9qHjJDeop0rkWeIxHy7T0OeSFm21tMVQxIySN0iaJAv6Z887VZ9AiL5Oj4HXjy257IrVZUml86IS1BYtQXZgcO46rw7sUELeAdbweaUU6zLBzUvXzjgXg/czjwdViB5+j+SxUlxH4P10VjP60JYI8VFiLFOqWhnH1bWRYg0czvRKeeM1ANMY3+x09dN/bU3EVgB+PHpyOWtGWiM8BuakEBKG0o+PPgwZVDTQpYtJ64oBGdqb6Q1JLxR6qlnoa9HU039Kf84TpwRWdrBBBFuYMg2ZLG9PeX1j86NgNDTxEioNPcgA/KTXgqzAlnm9T8IkXnhY9vZVgOdvlCYFboqIWNTMV/RVhomO4a+vejMWfVQpZyRzotSzpzYgjrI0XGBr+ICjHJYFV7BEMmvDeBU8YNGMNjURHYPBUyLJV+4mpoFsq+5AQAUISWaBLtyr1r9k3tYrk6xPrgNYcjgan9oIFbBBkIJQm3hY046LKl+aJ9pta2sJ+/qlfb1EUUQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IM0ZZNXNsFCiKb2NjsAfcfZ/FS/tT6VnoaVBZRAHefs1BtExfmJOaplBaz7Wugu58GdFa1HEtXeChyLcd3Ee50WgQG70NdNJ0yy5RsClquK9HZJUakvLTCTn1nRBeQybdSOtrrsxxU037sgH0BbB61TlkFoLdgpuFKwB/Dtg4I3T6Lrf2hHN6qhOXFWQM/29aQJI2tu+HHfw0chsvNam45kDe2lIsu7kNFxukF+gB/z7m9zmHyVnYHJ8C4p0MCiHf2ANxGDOOMq5xo7GU1z4DYRjO6ZH/Os4Te1MV1dIHucSL55LXdszmE+Wj4XrYx+Kh6KDaedAN0otgWdjbhXZjhNuMj1ciw3VX1XwoPPgRd3B8MZcFBdW6Or9Q/XOPOPFBZZjfSyZUP4Sam/pVMbSVeIYysTosBeB/FMxkcR+smRIIWSEPB0bdkEtbN5GSWBQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 08:17:02.2871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96254a10-4611-48be-ebe2-08df32705934
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

mlx5_vdpa_steer_update() calls mlx5_vdpa_rss_flows_create() which, on
failure, leaves behind any RSS steering objects (matcher, TIR, TIR
action, flow) it managed to create before the error, relying on the
caller to release them.

mlx5_vdpa_steer_setup() honors that contract by calling
mlx5_vdpa_steer_unset() on its error path, but mlx5_vdpa_virtq_enable()
only logs a warning and continues when mlx5_vdpa_steer_update() fails.
As a result, every failed steering update triggered from the virtq
enable/disable path leaks the partially created software-steering
objects. Over many reconfiguration cycles this exhausts the kernel
software-steering (DR) resources and later probes fail with
"Failed to create Rx domain".

Free the partial RSS flows in mlx5_vdpa_steer_update() itself so that
all callers are covered regardless of how they handle the return value.
mlx5_vdpa_rss_flows_destroy() checks each object for NULL, so the
subsequent steer_unset() on the steer_setup() error path stays a safe
no-op.

Fixes: 9f09b1ca15c5 ("vdpa/mlx5: recreate a virtq becoming enabled")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/vdpa/mlx5/mlx5_vdpa_steer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_steer.c b/drivers/vdpa/mlx5/mlx5_vdpa_steer.c
index c2e0a17ace2..b1bca7f0f7d 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_steer.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_steer.c
@@ -255,6 +255,7 @@ mlx5_vdpa_steer_update(struct mlx5_vdpa_priv *priv, bool is_dummy)
 		ret = mlx5_vdpa_rss_flows_create(priv);
 		if (ret) {
 			DRV_LOG(ERR, "Cannot create RSS flows.");
+			mlx5_vdpa_rss_flows_destroy(priv);
 			pthread_mutex_unlock(&priv->steer_update_lock);
 			return -1;
 		}
-- 
2.25.1

