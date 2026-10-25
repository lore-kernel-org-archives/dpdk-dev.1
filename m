Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B3606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f4zzmb8/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4B2640613;
	Sun, 25 Oct 2026 09:17:12 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by mails.dpdk.org (Postfix) with ESMTPS id F133940269;
 Sun, 25 Oct 2026 09:17:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWWZtC8JNhkIlk5e4GCXtB/MndcIhYrcRvu3T57tNlV4ZOJ0JE6MXSU4iQSTeLLPBypwDHwSA0T9uRWc8xa3Qh/wWqceVKRl6obJzjGS7dOdhYV0SYFbHAxDtwo/Pi2g7rqA8RCdLP56zl6UcCil/WU0LnjLDih/rC4mISSJSvLxiGk9QXYGlnkTdarMpjQhSNflLt45yHRhmv0MAlKslxhI9GGEmPOqbXllJ2lA0dQfj8jUaS54Kz0RO7/98nF0wfMYd9CO/vWZ6r9S7z+QDGcF5IsuRVd6z+ZrCAligtzaJqHoGzI9wf3TFSKcdqIYuP0MJakq2/zkONQHWsTikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBGcdGDrKHR6w4IXWBr6NkvCXIJvNCF4ztu2dN7Xzxw=;
 b=nmJJlbu1dG1B9rd2iXLyp8W6zMi1AxkaxCHEjs4Y/jvlO1AqGTcLrh5WfbftAh64bjU1dhsw91B/S42FBMHnWUCTa6w24/X9j8zVZVlcT+9co6tIPT3v3Pebajam3Fxu85BESpMs+MfiweOUvvKn5M3ACsrp16XXnUJAMSHylH+R1C6iDI4ZBY1bNGlHaCwES9gefegLrB5F6GgLxavc9f+2nWSrHlCOct01ZcH/Wtw2OEBwRFv5AysWWE9PrTE58RBPuQ7c0ohYupY/W7UGmAWCuEkovttNCscJSGbD3KvwaT0IgYLE+iRVvDW/1tb+4E8leSnIqxRppBWudJgHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBGcdGDrKHR6w4IXWBr6NkvCXIJvNCF4ztu2dN7Xzxw=;
 b=f4zzmb8/D40JtQPCK00mdXYyyDBBlFJ2Uv5VDQLZKX53T1J/oqBr5Xpiu6R2F2rmupq1T9bPNMkcquROBtpgSvP2YuoAj1KYXW7aX1lbmKy2w91nMraNTTCr3pCGAMA5yNHhtgPnnCIys9ysQfr+bbcZGrmEkWIZC907DVwu7yU2Xtl7vwO7G3BG5AqGPzPDgdMvtlbTGzNKSHzSewl7OaWV5aDdk6HLlzXAKkNHebWY1K1g/q1TzveV92rHAz42p2Fzy+0b+FIShEqnZTukrQJM3r9/heATntDgluAUdIOWgHL213GfYbQYaE31fbjEEDh0UOTstdkAayoriMAwXQ==
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 08:17:04 +0000
Received: from MN1PEPF000793FD.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::94) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun,
 25 Oct 2026 08:17:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF000793FD.mail.protection.outlook.com (10.167.249.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 08:17:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 25 Oct
 2026 01:16:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 25 Oct
 2026 01:16:44 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Sun, 25 Oct 2026 01:16:42 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>
CC: <dev@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 2/2] vdpa/mlx5: fix RQT attributes memory leak
Date: Sun, 25 Oct 2026 10:16:39 +0200
Message-ID: <20261025081639.2746665-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261025081639.2746665-1-mkashani@nvidia.com>
References: <20261025081639.2746665-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FD:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff650b4-e97a-49fb-b480-08df327059d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006|261021123027099003|261021121427099003|10067099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: s94J1GYCzP8gTpTuWJdFfaWFQQawiUtVgBCzeAp+RYOk++r0JYT6fZRrKQ6dLYdffZcml2hcULEjnRt2NRP/Qq3xJ85e/igvjSo1uAAhLlwtj9gK8T96yS/+f2286iBNgYZkOOhqgAZPZAGKM/6fTzzhNs+LWZkdHVYHNR+SDGQ2lm2oXRgZEpVx3mb0wOpvrOGr/Kk/dWfZ5Ft0TCg9l3sir0Huf16JmlZta0ajvm1Lr2tVUxzyTEDcmv94F9gVaTtqWtn6Bj+8LRvfIdOv04r1nw2zH7tagvNPa0evV6atHr9CMPD6TFSLBB5tY9t0e0cuO0552jqL0kk74723Dwocu0MFRH4zQmF+2IIXca9WcRY0bCZDfQkqxqyG6Ua+jXXitq6b5iZ+fNY/sn09LCx7sH7eA6YcoZAPSH9xPkAU5QzKSJm7bGyRO4XHZvcGNG1ZydspryG0WiaYe3uJrrlMffOY5jOcXKNMMhWl6NFnxL7gBCL/hQsVEeAKg/owGl60+CLMGzrwEbz53WHsUZfHUEpwRb7hOC9bPezYmPysdRBdTpM51zy/EBxzd3nLqBWnL4SMBeuEUqOUtCfJheNTEMjnUHrCXckmdgTmbJlzXWdvEO6Uie8PR8s6vKAGK49yXp7aroCyAq/T8qxf9r1I0pgxITBZ8dNWufxUWjcD8l8VFkdPM91WvuskgFERQ5/LisTQAiA37B0L9Q3I1A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J8CwDcESbQAqun+oXelplLa4JvKbfyO2B4HcukQpQU1FDmNet8TAQLVxyb0+LzmjAeP1bNXr8UDhTJ1w9eVS46aHF2ljPMiABja5M7MuCNlIQ3g8UEbY0QUNiOyprGU0R3F7YVeTUTWcG1huOEp555O+DDiPR8zSea3u80Yki4r7/Z1wMmrV+uzx33T7aE/08BhRuEUrdSLdIveJCluPwHsskuqz22kgED6aM0ZGb2B65P4frsD/ATxPbVXRz0WjADOFmLJ9NmbDIrTF5Q74rr2h7DOq+PQ/log5MdOcJY/Rd4ZCR1/wD0aVQy6JmEVwZfzDpqqlrAWMTjfn3MqF8fvmq9FngXtTVatkLU9mCMhESjIqd0Fho/l70f0CmUSIOj1XqRUxcVCgRUHD0im/BLNOwx/r815SgNiUcf32vtxHuDOqLESbuRB0ot+kOYr6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 08:17:03.3057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff650b4-e97a-49fb-b480-08df327059d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928
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

mlx5_vdpa_rqt_prepare() allocates RQT attributes with rte_zmalloc() but
returns without freeing them when no enabled receive queue is found
(k == 0). Every steering update that hits this path leaks the
allocation.

Free attr before returning on the no-enabled-RQ path.

Fixes: 9f09b1ca15c5 ("vdpa/mlx5: recreate a virtq becoming enabled")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/vdpa/mlx5/mlx5_vdpa_steer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_steer.c b/drivers/vdpa/mlx5/mlx5_vdpa_steer.c
index b1bca7f0f7d..5dd9ca40ebc 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_steer.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_steer.c
@@ -85,9 +85,11 @@ mlx5_vdpa_rqt_prepare(struct mlx5_vdpa_priv *priv, bool is_dummy)
 			k++;
 		}
 	}
-	if (k == 0)
+	if (k == 0) {
 		/* No enabled RQ to configure for RSS. */
+		rte_free(attr);
 		return 0;
+	}
 	num = (int)k;
 	for (j = 0; k != rqt_n; ++k, ++j)
 		attr->rq_list[k] = attr->rq_list[j];
-- 
2.25.1

