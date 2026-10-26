Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C8606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i0mZVm+S
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07847402A3;
	Mon, 26 Oct 2026 16:58:52 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by mails.dpdk.org (Postfix) with ESMTPS id 34B3040275;
 Mon, 26 Oct 2026 16:58:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+ljN7PhJUx5Z0JSpG6ybJBZhry4cO0gKDHc3IyCNopLPLDI8xxvMQbZCMI7iodAG3dECQCrboGOisRB/BK9nr+p/acQlfBKcGVWeGXFGh1M80JXEakt4+IcACflIcHm3jTSYRiMUhC2Z8nJ1OYk9qLh/FM//w+b7l9kOuh+WUQ8Om5k/peqB4Rl85DCn0KISLKawm0cPpYeH6U0jVSYvmQP29Ee5fox3ys79ttpm7Pkpa1PSEBiqyUY6r/YBCTt7WGV8lfYrz8jAbp/g8KjjnGPbQdml5BJEZ1kV800YeoecOujJeJTGLsg8xTGDXKgNccKMpglONpx6Vu3Nx13sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4I8g25kZ5Uo0wCfTkkuoPLuoinGXjzHwx0IPxx2oHU=;
 b=KvBF8ZYT7ycZtPYyVtNp2YKkiYEFK1LtJ3A7s2QT0R3WMm/Fgi9VUKDLqmFrD7BPPbkPj327NFI71Gk5RXiit7DTYcXH+W+cM8yWkFdbth9OmxluxQkAGd2WoqFY/Xqz7IN5hW3YICa0kqX1g0B0kaWILlQttVLbKWvixbzuvAY0GAYBVnpdcwSOhKEnXi0adkdlCv9W2SjHXTAQ8mhmSLy6uqvHYEBKuvaLTL5VI1/gJDfnuZQx0V9UCQ5Sm3B+TVKo84Y4JLXRB+jjiP5vX6kyGa8PRTLCNPsT/W2wP0w3QMLhGMx8xBWsd7uJLuwghXOGXMmag3oZKQADcEIBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4I8g25kZ5Uo0wCfTkkuoPLuoinGXjzHwx0IPxx2oHU=;
 b=i0mZVm+SbuSuMFHyXexl+5j9Xh7hjiy7nRJ0RNU4GG4aXeHYl3X70mbDKOd8Smk0U4C9CSIbbhpo3sDfcSx8kpxjKTyUU6LekMepE0TUky23tIl55DDde9I6IHWVjI4Mt8D0n5cEPby0+e7zZ/XUvqLEMIvBSjO7711SsP1UsOvM7VVErWdwLNr6oM423eWh2In1g+kGgg7NATdEWjHRGx0rf5+ShQOVCogegq22y7D/AXrSnYzt50kXsYe+AyThF0gWeaf97Gt8PW0Sx5omPro7+D3Ema8VeMcGW6JzhWFKn6nTuSGBUfWTbpm01nsVrM+BP832QHLZpO9D2u/Irw==
Received: from CH0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:610:cd::33)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 15:58:43 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::7e) by CH0PR03CA0118.outlook.office365.com
 (2603:10b6:610:cd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 15:58:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 15:58:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 08:58:21 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 08:58:18 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Tal Shnaiderman
 <talshn@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix LSC interrupt device flags
Date: Mon, 26 Oct 2026 16:58:05 +0100
Message-ID: <20261026155805.1288318-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: b5da7fdb-9c93-48cb-068a-08df337a0297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|261026140227099003|56012099006|11063799006|261021123027099003|261021135927099003|261022105027099003|261021121427099003|261009223027099003|10067099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info: D7soxtfqEvbn6kCEGSK6hk0bI7ZbPQVUQdAeY3xk7sIRWyzz1UjOkDVRhBGJpm17ca0rZpxXg/uadyoxo8dddJMgu/pB+LNkAh9gDYvAA672K/jZPdRcfWbTLUb6aQogMwweCejm6DCojTaS2g2Qtz57QxvcA8Eksoj0NE3LFXq3OSPH1upB8G4gTqwhKwHFW7ALqITTXpnbdHmUcb+8l50lOeZI9iwZivdL5P6GQSciBXVoFgmA3eFb5jJ4tMaBkLNIUoufq7o/nXf8S/k1bGJrv+tAIzf/ZjMMe3KWeuxPAplJxAnC9+hAb5O651JJYuZ7XTLVsdQYQD/HV7t+WperJ5fFftf4mweoPdXyayb9Rx6pQMGYY1oR9YK/YchYyF1V4HacG2eNGcxUzBBCHtHv58frtyWLQCFR5KU5jEKIO/UnHMG7ret7lpW63eSFV9mf+c5LDBNZP2wZC4gmGPczuzke6EGP4XvuMxIXl8IoG0ikPSWMe5nAcLVNFgXK/NcnzPOAfqNmUGYuAwxUxrir57jElhEa5/78dLdgtoTZ138/WSAOQLWkB2i/XxeoD4mqX57+PNR/X0JQ3Z/bYXYrfsps707SKdKRsQBgFVsKTTtuSwnwQIrMzDQ0gb6aAihy1xRH7sPwSmNU6sfcC9PVSg92bPSxW2xg0EXWaXddeba4TPfvHaLOFrU6CflHnX/uBaJvqYKp9YKYpxMKfQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(261026140227099003)(56012099006)(11063799006)(261021123027099003)(261021135927099003)(261022105027099003)(261021121427099003)(261009223027099003)(10067099003)(261026121527099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ffrHWuZMfxS/8Acrqy1OyvijWycJX0+0jYxG6J/uGiZkBNYJbYJOBjcDPOsaDyNbK/LNo6cCA6bhZDyCdRO9zVdeYvwL4/RZsJWDnl6mtZbVXtXxyZkcCclGspmX/QIHB+Vvjs/d6arfurx70XH4/X52++nY2ifn6Zj8XSn6kw9U5NwDPgXTRxy8Mle6YOJI9/biEn/ETdxHn74E2RQD7onrN3CeMdKdLKwcQox5tzo3lWQJANBGFpLS0VGeh2TtiupqLN073BgcXxR8a8Jg0s3F1yzXMAF/YMmzSJxvbwNMw7eW1iXG+grnTXG5nipVHEwFbmwxkdzUVdtowi2K09Hxpb6CUW4E4k/3gUlLu4R9HcUMcUL9GI18ksOn25VSm9RYUQRbZGqM5eh5jSLNLlu+/3arqEDhyVyK8nH6cEhEoO0VPat/Qd9nzBiiBYT1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:58:43.0815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5da7fdb-9c93-48cb-068a-08df337a0297
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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

mlx5 networking driver supports LSC interrupts only on Linux.
Driver falsely reported RTE_ETH_DEV_INTR_LSC in its device flags
on Windows.

This patch fixes the device flags and updates the documentation.

Fixes: 93f4ece91a1f ("net/mlx5: spawn ethdev ports on Windows")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst           | 1 +
 drivers/net/mlx5/linux/mlx5_os.h   | 2 ++
 drivers/net/mlx5/mlx5.c            | 2 +-
 drivers/net/mlx5/windows/mlx5_os.h | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c7bb6eb182..11b33f89f8 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1107,6 +1107,7 @@ Port/Queue Feature                        Linux   Windows
 :ref:`statistics <mlx5_net_stats>`          X        P
 link flow control (pause frame)             X
 Rx interrupt                                X
+Link state interrupt                        X
 :ref:`shared Rx queue <mlx5_shared_rx>`     X
 :ref:`Rx threshold <mlx5_rx_threshold>`     X        X
 :ref:`Rx drop delay <mlx5_drop>`            X        X
diff --git a/drivers/net/mlx5/linux/mlx5_os.h b/drivers/net/mlx5/linux/mlx5_os.h
index 4d073048fb..9deef72527 100644
--- a/drivers/net/mlx5/linux/mlx5_os.h
+++ b/drivers/net/mlx5/linux/mlx5_os.h
@@ -8,6 +8,8 @@
 
 #include <net/if.h>
 
+#define MLX5_NET_INTR_LSC_SUPPORTED (1)
+
 /* Maximal data of sendmsg message(in bytes). */
 #define MLX5_SENDMSG_MAX 64
 
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 19491b9dc9..a04884fb4b 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3959,7 +3959,7 @@ static struct mlx5_class_driver mlx5_net_driver = {
 	.probe = mlx5_os_net_probe,
 	.remove = mlx5_net_remove,
 	.probe_again = 1,
-	.intr_lsc = 1,
+	.intr_lsc = MLX5_NET_INTR_LSC_SUPPORTED,
 	.intr_rmv = 1,
 };
 
diff --git a/drivers/net/mlx5/windows/mlx5_os.h b/drivers/net/mlx5/windows/mlx5_os.h
index 57d147bd8c..c5b7008053 100644
--- a/drivers/net/mlx5/windows/mlx5_os.h
+++ b/drivers/net/mlx5/windows/mlx5_os.h
@@ -7,6 +7,8 @@
 
 #include "mlx5_win_ext.h"
 
+#define MLX5_NET_INTR_LSC_SUPPORTED (0)
+
 #define MLX5_NAMESIZE MLX5_FS_NAME_MAX
 
 enum mlx5_sw_parsing_offloads {
-- 
2.43.0

