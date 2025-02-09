Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0A8C02199
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 13:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 485F4402A1;
	Sun,  9 Feb 2025 14:48:40 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by mails.dpdk.org (Postfix) with ESMTP id DA14D40280
 for <dev@dpdk.org>; Sun,  9 Feb 2025 14:48:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S37EwcQGmWZc4lJaNzkRnjkApaB/el0ltWrG+ylKIJov+6NtbHy2ox6KDJMkMuTE0+iQYjG489sJBvmxflre3glhmdPtFVbhbWlmq0YMM7HwpEs6oVxA/qXOHe1Pf/LG3S71guINR19QK9Jb7NSBdlqS8scssFn/LJLoxhyA3dMMG2sMttnYQCnW1tSWd8d3CZ4GmcNzrRWn3vhQW/gKfpFCJQw3cfRs6kY01r8m6trLwD9KGS/zU4TUl6yGbV1fCweoXGI0oFDPVwvlJSvfK9412rpEf0JRO8jU0i/CmnaXZx+nPeZvd2eJaAEavYsKjPkD02MoK1stJ4EI9XDtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jjX8JUOdPphqqaJhzQTNZJI50P/D70GM6f1Mf5+gIE=;
 b=h7Z3DI0LLzTcrtJyL1udtIg2HIw/bGzqcw0TjZ0XToJpPq+jRO8P4UclLDVaq4t/2e9fsKrHcEqzsbB2puGFBg2PO+kO/dCn2vc3XOkrEe+zP8FUpiywUxzJvXMD+Cm/prESJzKthzvlTNAiHnV02Qt757g/sgyEO1DSORd1RaPOqSnrtWd3p3bFvsWCatJbewJ2+tkXPkSTpRw4sEy9hdCHTeQiWuOPNAyy3HLK3wmsGnQoLMx3tqOnsj2YqY6bq0oe0geiAKlbvv2aaB/UPd3GgHtEQn75CRkpAAFBquSK3hYgLA2QsmgbbVBQlgqLqssXe6ZDEZjWp4YPtoBXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jjX8JUOdPphqqaJhzQTNZJI50P/D70GM6f1Mf5+gIE=;
 b=m+IjmPjhY4CnqkM99llIqsZaWCpFE3T08aP7oAXsxo8a5Hf5/mRurS9Ncx09A6AvcCUjw455JHP77UuVOoNw1NLRRS9Eewlv8Ck2Swu0THYOfVSoizAgZ0qfycD5SFaSm7OEe1ZtezL8v/8OfqZnQUfTO45OZg7HmqM3SWlWLuPHp/JLfMTtqivGOqC4sAJLxDlJk+N30xBtU/3SSJjz1fke7PCGflb9tt6/xgVkTGLULizxRD9ks4McWPNhlDZk48ic+pRKbONuB8UKiDnlnDUrzltsVFrs32RkYknA1xUAgA9uvifnYPbOO7RcVtZN6LcmIzLLOCGq4cSx39hb7w==
Received: from CY5P221CA0117.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::11)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Sun, 9 Feb
 2025 13:48:35 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::a0) by CY5P221CA0117.outlook.office365.com
 (2603:10b6:930:1f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 13:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 13:48:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 05:48:24 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 9 Feb
 2025 05:48:22 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>
Subject: [PATCH] net/mlx5/hws: change error flow on matcher disconnect
Date: Sun, 9 Feb 2025 15:48:06 +0200
Message-ID: <20250209134806.263338-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4ea1c6-86f7-4d6b-d30b-08dd491072bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c3MPqpa3Uvt2h3uTJaVOzwswUx3RvFB3/lvnIXWkhGqEZtGOJSPZwHSgxfqw?=
 =?us-ascii?Q?mltXvK5QdVko99jmzDjIAAAmrbmZ/YdolhrdU8NWPUd82kwBt8fTsKPEapk3?=
 =?us-ascii?Q?OoJM/xFMvk8ATxnZC8GF7dHv+nViUurvkohKd8scjtUWJS2arfNGF1c8Py7C?=
 =?us-ascii?Q?k+cjS+a0ItOX9KCMrLVmiK84h62m/r+km3CZ0yX7hp8VtOPBPbFenIiZDPHT?=
 =?us-ascii?Q?WbnpOTmorlNiKThEQIQ6Yw2L8szXAkgHf+pIRxNy2JEisyQp8N4aflSwA8wG?=
 =?us-ascii?Q?JfLjc6uSvmUzBK7A8d8HxY6SfBB4RtTMJNX0nJE8rbWC763R7EdfnPBVgeSK?=
 =?us-ascii?Q?PPVS8DlTWps5Ba6V8uuHYhLuPFLobGJWPuZoY+n1ufWuzaWZKY0v82Y1Ow3t?=
 =?us-ascii?Q?/Pl6WSAvTB4vp9FpB4pD1TBFNg+05Ne3WsOjHrz8k6ZtGP67f2gFTd5pvyf1?=
 =?us-ascii?Q?gapIyIKsO98I3axFf5aReIxlwYFjTrcoUyWTQ4h6XjdVPxJkYWeGHLy8jX1J?=
 =?us-ascii?Q?LuNwdYKFhSd01UqhENAUScZNBQ4liiLUpXNu7qtNIU6vhj235mVGzpOXQ2Ma?=
 =?us-ascii?Q?8LGkCowtG6OM+4k7jELPDaQMgqCHXrzo3rorLpHk7/XcqaigU+deGAw17Pfp?=
 =?us-ascii?Q?neQMTNh2GEseFUOXFSimv2kXYaVyPDs1ZaBEWX4JTKTrBLRsk2styr4XOehL?=
 =?us-ascii?Q?ID7oxKqzVVzbBLK/o2NftAdq1TbEKc6rudvRj28P4xXzRM197UdQ1aRsdiAd?=
 =?us-ascii?Q?rZXQasU60RLm9jizqgNMwkiq+pZGFXSBdeYtyJyHZedQwKx06lquHeEHI3Ut?=
 =?us-ascii?Q?Uw82GLkwc6Z10DjO+06zfpNAoFaKZzyD7BQsBAWjAnKtqy0itVVYAaucbLVH?=
 =?us-ascii?Q?aVqCCpcq3EQZ9F/4O7fTmaZf1vv5ByKMOkT55A3zHRFqGkNAmpLNaDzFFrHX?=
 =?us-ascii?Q?GVtJDcvDgGRitInYIxWQvgbOlr+fpIUGEsH5wcblrtLN0iIASJ8G5xYRRkNH?=
 =?us-ascii?Q?Hza5TLeUvvc63pTJOwwUKRhqVszbz6Bbnj95vwXTYez5pM4dfhEpu+mhWfFN?=
 =?us-ascii?Q?bitPee0xNy/S0ik0NkfjpXRbWYh77iAvhbB3ycU8zmiEVnFAi6e0oMf64PAz?=
 =?us-ascii?Q?MuBK1Jpz+AfIdDvQ7NNTe+l/WvslKorbtK4Dv4Vql0IIkt1jwXVXuAEOHC1S?=
 =?us-ascii?Q?1UzMyFW1ztPEbB1OoM66sBl8XmHpZHQaVf26ADXrD8X1+e0oEJ6FAb7h/vGj?=
 =?us-ascii?Q?rLnNpZeWkEeaoiqPKSZukMUDV+Mrnbj8KnEUeb7bcSddRWc9lauy5xtvk5NZ?=
 =?us-ascii?Q?XKO2a+ypouLAmu+6ml66U6xNfsmMrqM3DBkw5iqALFdINxW83FUM4syB3EtQ?=
 =?us-ascii?Q?otRpBvyFElMpYEd1In76FFX5oYTSUOn2b2aZOcVeLcLLxTag4Zpw6F3hlJ34?=
 =?us-ascii?Q?SLn4ihpKk44MrYilB6RlfYaYitgfnd1n508IbY0fZ+zNI5Q3utTRzWFRtZRd?=
 =?us-ascii?Q?ehTUT9CKf3xY9Kc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 13:48:34.8666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4ea1c6-86f7-4d6b-d30b-08dd491072bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484
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

From: Itamar Gozlan <igozlan@nvidia.com>

Currently, when a firmware (FW) failure occurs during matcher error flow,
the system attempts to reconnect the matcher, leading to a segmentation
fault. This happens because the matcher is freed but remains in the list.

Example scenario:
Given matchers M1->M2->M3, if a FW failure occurs:
1. System tries to destroy M1 and fails
2. M1 remains in the list but is freed
3. When destroying M2, it attempts to remove itself and create M1->M3
4. This results in a segmentation fault as M1 is already freed

Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_matcher.c | 31 +++++++++++----------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_matcher.c b/drivers/net/mlx5/hws/mlx5dr_matcher.c
index 54460cc82b..c9922546fe 100644
--- a/drivers/net/mlx5/hws/mlx5dr_matcher.c
+++ b/drivers/net/mlx5/hws/mlx5dr_matcher.c
@@ -290,8 +290,8 @@ static int mlx5dr_matcher_connect(struct mlx5dr_matcher *matcher)
 
 static int mlx5dr_matcher_disconnect(struct mlx5dr_matcher *matcher)
 {
-	struct mlx5dr_matcher *tmp_matcher, *prev_matcher;
 	struct mlx5dr_table *tbl = matcher->tbl;
+	struct mlx5dr_matcher *tmp_matcher;
 	struct mlx5dr_devx_obj *prev_ft;
 	struct mlx5dr_matcher *next;
 	int ret;
@@ -302,13 +302,11 @@ static int mlx5dr_matcher_disconnect(struct mlx5dr_matcher *matcher)
 	}
 
 	prev_ft = tbl->ft;
-	prev_matcher = LIST_FIRST(&tbl->head);
 	LIST_FOREACH(tmp_matcher, &tbl->head, next) {
 		if (tmp_matcher == matcher)
 			break;
 
 		prev_ft = tmp_matcher->end_ft;
-		prev_matcher = tmp_matcher;
 	}
 
 	next = matcher->next.le_next;
@@ -322,21 +320,21 @@ static int mlx5dr_matcher_disconnect(struct mlx5dr_matcher *matcher)
 						   next->match_ste.rtc_0,
 						   next->match_ste.rtc_1);
 		if (ret) {
-			DR_LOG(ERR, "Failed to disconnect matcher");
-			goto matcher_reconnect;
+			DR_LOG(ERR, "Fatal: failed to disconnect matcher");
+			return ret;
 		}
 	} else {
 		ret = mlx5dr_table_connect_to_miss_table(tbl, tbl->default_miss.miss_tbl, true);
 		if (ret) {
-			DR_LOG(ERR, "Failed to disconnect last matcher");
-			goto matcher_reconnect;
+			DR_LOG(ERR, "Fatal: failed to disconnect last matcher");
+			return ret;
 		}
 	}
 
 	ret = mlx5dr_matcher_shared_update_local_ft(tbl);
 	if (ret) {
-		DR_LOG(ERR, "Failed to update local_ft in shared table");
-		goto matcher_reconnect;
+		DR_LOG(ERR, "Fatal: failed to update local_ft in shared table");
+		return ret;
 	}
 
 	/* Removing first matcher, update connected miss tables if exists */
@@ -344,25 +342,20 @@ static int mlx5dr_matcher_disconnect(struct mlx5dr_matcher *matcher)
 		ret = mlx5dr_table_update_connected_miss_tables(tbl);
 		if (ret) {
 			DR_LOG(ERR, "Fatal error, failed to update connected miss table");
-			goto matcher_reconnect;
+			return ret;
 		}
 	}
 
 	ret = mlx5dr_table_ft_set_default_next_ft(tbl, prev_ft);
 	if (ret) {
 		DR_LOG(ERR, "Fatal error, failed to restore matcher ft default miss");
-		goto matcher_reconnect;
+		return ret;
 	}
 
+	/* Failure to restore/modify FW results in a critical, unrecoverable error.
+	 * Error handling is not applicable in this fatal scenario.
+	 */
 	return 0;
-
-matcher_reconnect:
-	if (LIST_EMPTY(&tbl->head) || prev_matcher == matcher)
-		LIST_INSERT_HEAD(&matcher->tbl->head, matcher, next);
-	else
-		LIST_INSERT_AFTER(prev_matcher, matcher, next);
-
-	return ret;
 }
 
 static bool mlx5dr_matcher_supp_fw_wqe(struct mlx5dr_matcher *matcher)
-- 
2.45.2

