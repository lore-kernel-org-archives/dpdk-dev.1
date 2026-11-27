Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2D606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SH/ktN6/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D689E402B2;
	Fri, 27 Nov 2026 10:09:58 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
 by mails.dpdk.org (Postfix) with ESMTPS id DEDBF40291;
 Fri, 27 Nov 2026 10:09:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDSxVrpwvsst8SN4CHeSShoEngNuuDWXE/2ZrERTdkWM4DeyFRT9gkeW8NNj9Gz4UiRyyQoqVIAK15pTyqpASZez73DTIe237IouWPaTB3vLmW6bnmfLUkNe0sTLEUCrX3Bao5DiCnGNYlbqyVZITscUYmO8RFzZ+liwLLwEDBZ/VfvKXX7yw6BiDX5+2l3gss6e7x7hQytJC7IZdGbA3CW0eudJ21Az6Mez7s7/IS5uU3VdxEa9idEngA8z8OSiZ+CjABKjhBMYf3FKP2JgwXRn1RwDQBmFT+WXIZnck5qLg8MTKLSNjTC/6iU79SnYn3u5iOsnMEcfavZvFrqFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcQAXSccK99PiBxxvU+tGFOsz57qnrI/RBht0CiIfj0=;
 b=vomRdEt/QZIIDUPER9mPEpyjiAezewCxl9tNh/L/04JHOmar9XcSihJEWGXC7C66D5Kj0y7FAGRiDQO83tcY+NrvbnIwPfZdCc8KRwqWRdo5aDDrr4GodV9x2yIutTk5XDSJFbIn+a+3o0+XyLUp9oasDI7GmjkJ6xtR99eSktB4w7CWSja3np/NXmkAiHki+8jVA83wxs5G09wrW6cGLtE5+AZhuJ5+RwSG7IX2DXpJqmP7uwyGs3JEB2W19zWOhGUvUCFN0S1U+CfI4wFNtmhKJW2iMe+7kgmA14wtVcPKiekXf7uTqtSg3asCsTfWATnSzlVksHHmws5V7MNhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcQAXSccK99PiBxxvU+tGFOsz57qnrI/RBht0CiIfj0=;
 b=SH/ktN6/+UZJIqAheMQEaYPe0aLVQw5664EZR7I/nfC4gUFSAABjh7O7YhOMH1A0vYlSg3Y5R5yEc5hP6B2rBir4npa6902AM1/xqBUjxep/6leUCd9jspbe8mpufHs40KfqUsuDZHzU3xjRysfgOGgNjVgh0ZJ8THLL4J6wRXD+LVSMPi27gjt2V9oXwRfQqIrfX/PiMil+p9tE1DtH65oox+A8N4EVhONmHZ/uzhONo059tGNAP/d6o16tlL9KGHSCHbZTQEnGxpwEbiXQBbEICJ7wzfa6kAn+WWbqsnG++c/5gCLogYK99bZavhYcxRPX1euOCAVZo+DVqlw7kg==
Received: from DS1P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::8) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 09:09:53 +0000
Received: from DS1PEPF0005344F.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::6f) by DS1P222CA0014.outlook.office365.com
 (2603:10b6:8:454::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 09:09:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0005344F.mail.protection.outlook.com (10.167.23.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 09:09:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 01:09:38 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 01:09:36 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: [PATCH] net/mlx4: fix unreachable code warnings
Date: Fri, 27 Nov 2026 10:09:22 +0100
Message-ID: <20261127090922.1353443-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344F:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfc984c-d492-4409-08c1-08df4c663277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|6133799003|261009223027099003|18002099003|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: QdvWnj6dqAVmzf7J6kNwMa9KLRM6me7BjBGKA3IYayAavDxXK0rgyPs4hRjRV2kdu7ZcSand7+7xFMkZWyolXPhvqsR36bvVSHPazqOuQptD/41Jg1hxgejzzivYOENQJL90q+idjG8DoTmsMh76EwSGifnPDTlkRVzkf/JD4ZOYRPXE87/3Z2B/EJVYtaSVLtFk+liRNb6Km0xo5Nevube+JLi9L2JaKVLtO4wtvF3aosgIOop6b/ck7Nl0YWnqBMfDTyrjD4aM6THmlyfj17nBBR7KwCqd+Tmo1/1aTFFAMSoiRlYUFutyW/VSVmOBCVq8K/s58i2s1H84aQ3MNspaaJzDZUVQ3C11RD3CwDfsqbxiohkNK3kdb2lrisCv+LPQ+0THgd7OBXJXrBZWCPr1lJs21/aEDPKspnpqesxHzQseQqUDw1HlZ8NfoMWxxvM4yR0gj8WBqguVOZ6H9bKJChXbEVw/UMicZ7ALItEAZmGTXosOntYON02AW2XbMcSeYch1wdeny+/5bA3fOzoZu/B73pZ4cVwIp7X1RjG5OlN9TEmdRCqKrXYrNfpHZ8OV3cmRxTOxb/k0HYwjPrl/DWULacazwE0iiG0mU+AMZEtqdaT7baOb8LigKknd+6hTIWW/0aP3s53WoRyzhyEqzCEnovGBqaKGouZd6b7y3DJx8ncs2yPPVYbtAzuR4JBC4xd+v2cjUT/kq+aUaw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(6133799003)(261009223027099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+Mem2MrxuVLNeLUZrQQ9PI27hD/kGjgr5NNoU+v2rlbJgtW668nJ9omuZeZQEzJn4kZ/b9s7157M6E9FKsTCY6NbwoLGYh/Tzs9W6Qrgf7LdJBklAhRR/kyvGNVI2CPrtg9eesquISFNJZZ+3jRH8koi4rbPr4WXt2ICR2YRymMNCvry7GjefEsxi7VrC0SYHQ6GR3OA47N1Zvxm9PoHB5pHTbmsvIrkiy/swCaVpWxQB38QhKN2QVZ4CRDxAYnofqhFDOFsv5G7PWQeFLBHJULbpwb9wMno3JYOMAAThI3T9PPPEa185x8TLWFMZWkwPMH0koqlGz2phTMeOG1jzUwN7bSvCp2KiV0FV2NXOEHBG8ZCZm7gDTG5BbInz6toQPQZvfoT1TZsxwXFJCvxeJRXcMwOUj3eDivtS8lilIBjVfy9TQR+aCdc7DSu3wm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:09:52.5652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfc984c-d492-4409-08c1-08df4c663277
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0005344F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
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

Building with clang and -Wunreachable-code generates warnings
on variable declarations inside switch block in mlx4_flow_prepare().
Move them up to silence the warnings.

Bugzilla ID: 2139
Fixes: 267d07dacdeb ("net/mlx4: tidy up flow rule handling code")
Fixes: 078b8b452e6b ("net/mlx4: add RSS flow rule action support")
Fixes: ac8d22de2394 ("ethdev: flatten RSS configuration in flow API")
Fixes: ef134c8daa08 ("net/mlx4: fix ignored RSS hash types")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx4/mlx4_flow.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mlx4/mlx4_flow.c b/drivers/net/mlx4/mlx4_flow.c
index b520664d95..f812884c34 100644
--- a/drivers/net/mlx4/mlx4_flow.c
+++ b/drivers/net/mlx4/mlx4_flow.c
@@ -747,6 +747,13 @@ mlx4_flow_prepare(struct mlx4_priv *priv,
 	}
 	/* Go over actions list. */
 	for (action = actions; action->type; ++action) {
+		const struct rte_flow_action_queue *queue;
+		const struct rte_flow_action_rss *rss;
+		const uint8_t *rss_key;
+		uint32_t rss_key_len;
+		uint64_t fields;
+		unsigned int i;
+
 		/* This one may appear anywhere multiple times. */
 		if (action->type == RTE_FLOW_ACTION_TYPE_VOID)
 			continue;
@@ -758,13 +765,6 @@ mlx4_flow_prepare(struct mlx4_priv *priv,
 		}
 		overlap = 1;
 		switch (action->type) {
-			const struct rte_flow_action_queue *queue;
-			const struct rte_flow_action_rss *rss;
-			const uint8_t *rss_key;
-			uint32_t rss_key_len;
-			uint64_t fields;
-			unsigned int i;
-
 		case RTE_FLOW_ACTION_TYPE_DROP:
 			flow->drop = 1;
 			break;
-- 
2.43.0

