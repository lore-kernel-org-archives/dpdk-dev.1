Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B5606B125
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GpCpXIcN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B32F9402DC;
	Tue,  3 Nov 2026 12:26:09 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by mails.dpdk.org (Postfix) with ESMTPS id D0C77402C9;
 Tue,  3 Nov 2026 12:26:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4DFgi3j5+aBIqkwt4rMMmEnZxqurhsxxpUHqEdsKwnZ3VY1VaB/U/FXzUezJ02137DGGyhMXUov7Bd5Bv/fQB2arV5whRDXfZXbetHqLFjWqhQHmGWVuY3EpMeHFxOQEsrHGKF7mmC86xPe60/I2JJODuCXKarSfx3yYr3tFJ0T4LFimrKYwkib4pWLY2G5qVAI9o01yw/cXfo/fzKQxNptvobrRTs1FT79FagLKRq1TAI5NWQZnmAidwM9SASfFUggosm7IQTvTgFVZtKH1EHIZ0V9z/iFIm2vAMV5QO9krDMfD50JKKzR03L6BS9FDft8Lk4gbBChf2xxemkgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmABXtsfjIho4qMldpPXnxPLOqXr2Aiz0y27+EoRLn8=;
 b=dPCNfhHuBF8GObNLo2VNyskY/2hmmV7OcfAvF6gkFnFHgvSTYeLy1XPmQPcjBRZPta+eG8JJ4nbCe/Xx1ETAMOa2tF0Q7IHrim/RjweJlTcjVusO+5nS2MofJBawnyD/7L0OEglVjYN+RQqbiPnZJk33iH6J99XkP3MetGk/VIAIvCDfLSHRhzkmo+42DiHmHO8N7BuzDtODr+tHnVVCRhXEMzp5vgqHNClW366UVyTyG+hsfI3NdvqmkiEKXWIuVQV2U1wvkpqBmy2j/AJr1QlvlSj/IeVpOYL33WIn5+6+U53RySa1ADGe7PVs9/l7X32f+Qh51S/hLS5hkqCHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmABXtsfjIho4qMldpPXnxPLOqXr2Aiz0y27+EoRLn8=;
 b=GpCpXIcN5WfG4M5ypJyLOflcEWeTyUxGxDFObZvEOEd9bMJBEeAN7NMvh1Q3jkOBPxykuwDRK3s5NdGrWtUlHpS4B3a0+X7vwxRvVkBAd30x/qWRNeGMUi6zSR9JCF2KFLE3VPVE9W2vJruG/y0+yWJPnhwDUaGsFn0K9eTFMRlWb+qk+kfhsjMjCWK6W/nXMUwxvQ3g01gJK4jeG3duw7l+x6UwcCCJraL5uqA76UDMCG5dp2G1HErqeXGIOxLHaXoBRtBU7YmjFfr4PZFoJhAq1J5k7+FCM1gbYGNrssGgCE34aY+XP2mZaUiFLDlXooT2elRCw+yRX5XvHWtxTg==
Received: from CH0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:33::6)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 11:26:04 +0000
Received: from MN1PEPF000793FF.namprd05.prod.outlook.com
 (2603:10b6:610:33:cafe::84) by CH0PR08CA0001.outlook.office365.com
 (2603:10b6:610:33::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 11:26:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF000793FF.mail.protection.outlook.com (10.167.249.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 11:26:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 03:25:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 03:25:28 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Tue, 3 Nov 2026 03:25:26 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <mkashani@nvidia.com>, <matan@nvidia.com>,
 <viacheslavo@nvidia.com>, <dsosnowski@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 1/2] drivers: fix ASan ODR violation on glue symbols
Date: Tue, 3 Nov 2026 13:25:24 +0200
Message-ID: <20261103112525.3432332-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FF:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b7dd51-e38a-40af-baea-08df399d3eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261102130727099003|261021123027099003|261102123227099003|261021121427099003|261026121527099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: /n6hMb/PpVx3v3dLanVKl2Y5GvUYZcH+bDwx56CaQh/N1/GfFgQLVdNIvzKaIqtkFk0sn4fLP7xQ2MYS7cVzaUaH+HAfTnqxU7zr3KexMlDhbUmMERMFvq+6Unt5S2+25Df8s3ASRtTEe56QvOqJt5b6yBQrs9kTyKdYl45J14wEXNz/EKV2gXmdA7IyNnHl3b/ZjpfGzpsWthwMRVr4YPoZ7UN8SUbPvhsSOsaJukGj4CYISXZv7TGNBKKQK7UcBH3avT9fR3ZEuvPXMkgunkCVPm4dhEd7vQrcPBXDlbSqhD18cK7jbi1hhKSH2zIsJYTpN+HeU085KKEcYynIvvm/lcKH13W/awaVTXsOGXG8u5XYiCSupS+XaU4pQ44H184mKFlXymFSQOEY7y/6plRNU13cMoqjGufr8lqLOC2ikqdbOZERal/jBTqEmwubTg+D6P/M/conSqWtW7gZqa3EtBuIelB+GApROUkAcYt0V4pYbBWZyjNJsKS+rtz6m0++asovb+ZqejAlxMGIVn1big6vPE60KbeNnkE/cmNNKZvDR211GzIc2E7STiEuH22LIOZrIAMgHmRg+Eorz/8vnG2wwftRdU5trMKYjlGycOhgt40kcLJl2MPhBj9F33BXa/9n7GtAL3mrJnP/usTUxqOi0xHiCA3JTJC2wjPdWBzk7kT7OKvs/6TsdVGST1qFOPJZ1E9Bdry7HtLDwA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261102130727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261026121527099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MJc0epD50/VOQspkiypAacbQQd+niMB1sZ1YgdjZqISh8XlRZHDngQue3DWpXtyTOmp63GZud4fU6DxQheMyuAnS0LgGSqbA3KfOb3q09Q7vl1nzZHVbO9NydOuZRJIa9129UoULGwOy4Gk0LKrIM3zx3WaU3b+LU14D0HGHnhRoor1pfLQtifGgrqmDWhYZAxP233KtW/jqJsIzjduxC2ZesCuRoUFhBulQyersjOHOTJqRtTRKFKXmNyhFdVMUnPltUPTG5Q80eR6YbS4YNZExG2iQbPNEoPHtdbxET1ud4NTCbPRSfkKf+f1o+UN8SQ7Zsdm6TEzJOJqHrfeHO8kM5HHj5tF1jAYm2kX2M5mgFJanNX4yxLqUA83RJCfXWfLk2raQ3pMRCpuiHQt/f9q3eBNrXW9oud4byNsRsO1EetpQCs67WJL/XzY11TJj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 11:26:03.3030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b7dd51-e38a-40af-baea-08df399d3eb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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

With ibverbs linked by dlopen, a static PMD and its glue library
each define one global. net/mlx4 and librte_net_mlx4_glue both
define mlx4_glue. common/mlx5 and librte_common_mlx5_glue both
define mlx5_glue. This is not a clash between mlx4 and mlx5.

Only AddressSanitizer detects this collision. The linker keeps one
copy, so a normal process is unaffected. AddressSanitizer records
both definitions and aborts at startup.

Keep the name dlsym() looks up in the glue library. Point the PMD
at that table through a private symbol.

Fixes: a5e5af7f20b4 ("net/mlx4: fix build with -fno-common")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/linux/meson.build      |  2 +-
 drivers/common/mlx5/linux/mlx5_common_os.c |  4 ++--
 drivers/common/mlx5/linux/mlx5_glue.h      | 11 +++++++++++
 drivers/net/mlx4/meson.build               |  2 +-
 drivers/net/mlx4/mlx4.c                    |  2 +-
 drivers/net/mlx4/mlx4_glue.h               | 11 +++++++++++
 6 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 3767e7a69b6..038b76b8447 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -245,7 +245,7 @@ if dlopen_ibverbs
             dlopen_lib_name,
             dlopen_sources,
             include_directories: dlopen_includes,
-            c_args: cflags,
+            c_args: cflags + ['-DMLX5_GLUE_LIBRARY'],
             dependencies: libs,
             link_args: [
                 '-Wl,-export-dynamic',
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 903963670db..b8a7c53e5f3 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -28,8 +28,8 @@
 #include "mlx5_glue.h"
 
 #ifdef MLX5_GLUE
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue)
-const struct mlx5_glue *mlx5_glue;
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue_handle)
+const mlx5_glue_t *mlx5_glue;
 #endif
 
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_pci_addr)
diff --git a/drivers/common/mlx5/linux/mlx5_glue.h b/drivers/common/mlx5/linux/mlx5_glue.h
index 0610e7778e1..38292c1346d 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.h
+++ b/drivers/common/mlx5/linux/mlx5_glue.h
@@ -412,6 +412,17 @@ struct mlx5_glue {
 	int (*destroy_steering_anchor)(struct mlx5dv_steering_anchor *sa);
 };
 
+#if defined(RTE_IBVERBS_LINK_DLOPEN) && !defined(MLX5_GLUE_LIBRARY)
+/*
+ * The PMD keeps the address of the glue table in a private symbol. The glue
+ * library exports mlx5_glue for lookup with dlsym().
+ */
+typedef struct mlx5_glue mlx5_glue_t;
+
+extern const mlx5_glue_t *mlx5_glue_handle;
+#define mlx5_glue mlx5_glue_handle
+#else
 extern const struct mlx5_glue *mlx5_glue;
+#endif
 
 #endif /* MLX5_GLUE_H_ */
diff --git a/drivers/net/mlx4/meson.build b/drivers/net/mlx4/meson.build
index 1eb67f3c472..fdef57f6812 100644
--- a/drivers/net/mlx4/meson.build
+++ b/drivers/net/mlx4/meson.build
@@ -125,7 +125,7 @@ if dlopen_ibverbs
         dlopen_lib_name,
         dlopen_sources,
         include_directories: global_inc,
-        c_args: cflags,
+        c_args: cflags + ['-DMLX4_GLUE_LIBRARY'],
         dependencies: libs,
         link_args: [
         '-Wl,-export-dynamic',
diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index dbcd98d49f5..c5015bc03cb 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -50,7 +50,7 @@
 #include "mlx4_utils.h"
 
 #ifdef MLX4_GLUE
-const struct mlx4_glue *mlx4_glue;
+const mlx4_glue_t *mlx4_glue;
 #endif
 
 static const char *MZ_MLX4_PMD_SHARED_DATA = "mlx4_pmd_shared_data";
diff --git a/drivers/net/mlx4/mlx4_glue.h b/drivers/net/mlx4/mlx4_glue.h
index 96d5cb16b48..9209ce77cd5 100644
--- a/drivers/net/mlx4/mlx4_glue.h
+++ b/drivers/net/mlx4/mlx4_glue.h
@@ -83,6 +83,17 @@ struct mlx4_glue {
 				   void *attr);
 };
 
+#if defined(MLX4_GLUE) && !defined(MLX4_GLUE_LIBRARY)
+/*
+ * The PMD keeps the address of the glue table in a private symbol. The glue
+ * library exports mlx4_glue for lookup with dlsym().
+ */
+typedef struct mlx4_glue mlx4_glue_t;
+
+extern const mlx4_glue_t *mlx4_glue_handle;
+#define mlx4_glue mlx4_glue_handle
+#else
 extern const struct mlx4_glue *mlx4_glue;
+#endif
 
 #endif /* MLX4_GLUE_H_ */
-- 
2.25.1

