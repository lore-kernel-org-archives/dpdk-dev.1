Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EE606B12D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=osyG8oSB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96086410F9;
	Tue,  3 Nov 2026 12:26:12 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by mails.dpdk.org (Postfix) with ESMTPS id 6A5DD410F9;
 Tue,  3 Nov 2026 12:26:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD7Jp5vh6n0biiYyl2/Jz47F7DicU5RXkUn39tTMh+xrMjABCWIqWveAaSQsu+IJs66Y1QImG1O9TVopvuTFwi4rDS9LD8HWKqF8QH6z29at5x50OX2/86MElO87/d5HAkUkyMeYSTCHLqPF8hj1oz57nIyWqZtXcLca2Q9ujne0FRVpyPpoIPNpAREezrCOYIaXsSufefxW+DEvCXnPbAPl9IbkLzvWgFkcnpLetu8EdbX8KATCnNG6+49JscCCVGrQdfCd0c1cgr44ELBHVt3XJ+586FfLDxs6bczgynEHTpSV0xEHga+Xu4ISibTnKxHeNIl4T0zsxYTSiyqE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EYD/UOgNlct6KwcedEMT5zHkCniEqtJmnRFLiLlA6A=;
 b=k9nJ/WckQGW8GqfD1hMRTwDFwu0ZK9Oro7/J1b4tvfaum7qdI9rj46pgsRrDDnav2ZKRDlQaJuqrehSqB+0BgjhOG1wufi2G/1iJnOOlafadNC46/LwAp8xYY+qcoGPZrtTzXvpFUjWe0Mbo5G95o9pBKLOH8QW7WXmj8Dr7sw/ct9Yb2NkM2K6ngYgQGbnNMs3E4XeuvOmkadHo90Ok0Eo99PiXbWC2mjuIb1ZH/D5ixcBbRIUYkHGpO+7OLCy9cf0n2naC0J1SfgDuygsL9Vl1Qo9SXgRX69Tl0lVzaVTODy8fB7fwIgesHsDdrHObp4nSed0pOMStgeTUgLT/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EYD/UOgNlct6KwcedEMT5zHkCniEqtJmnRFLiLlA6A=;
 b=osyG8oSBElTxUgRvm1I9e2qNEbZj0CKSRfNIw5t+LxGBlDjzxG2V1XbP+yLe8ncqgL/goDDQ/PHVWEUsuQzppnMFY6tyPtkPtNFwh3Wdru58KxM03WbnKGYaE78kFdvqndEoR/CkXbZ5mlCYuOSA0Yn/rYmyQ/p22mAWzz3XXjwGqCCmPHTb3IV/Lh6l7oUU9UioxAa8leqAayHmGj+NDH5nTOGG5S99UHBoQ3IMig7+p+SY0RPm7Qq7d2U5+C711iAzw4MrQ4xL5z3nYyWKrY82kACyax5uHY6mQWfjZS9h5Q1d6EwZ0xM8B89fIAscOj1HROv8r7coQ761FgNKMw==
Received: from CH0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:33::21)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 11:26:06 +0000
Received: from MN1PEPF000793FF.namprd05.prod.outlook.com
 (2603:10b6:610:33:cafe::5) by CH0PR08CA0016.outlook.office365.com
 (2603:10b6:610:33::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 11:26:05 +0000
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
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 11:26:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 03:25:44 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 03:25:31 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Tue, 3 Nov 2026 03:25:29 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <mkashani@nvidia.com>, <matan@nvidia.com>,
 <viacheslavo@nvidia.com>, <dsosnowski@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 2/2] common/mlx5: fix errno clobber on interrupt FD clear
Date: Tue, 3 Nov 2026 13:25:25 +0200
Message-ID: <20261103112525.3432332-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103112525.3432332-1-mkashani@nvidia.com>
References: <20261103112525.3432332-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FF:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 83089da4-fbeb-48dd-cf5e-08df399d401a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|18002099003|261102123227099003|22082099003|56012099006|11063799006|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 2SNtOIGfZ51zORKksr/8E+gqqYDlMYYvMvnVAGU/eHGDgKs660N958nfkyxhV/16OOmkcGCOGORQAi/4dFmYuw6n6yFpoi0hSU++JVY3sgEpoyxZDsYpBuUx45eTHQrVrpy+wt+lovmbr74kqVf1ldajxJoznjXA1380C1jQHahFJjn9Hj+C3T1EgUo9wxiVjtxZ/BEu33RXoQMTFIW2tqY4rIH4PyJmmtPbc4trdzJiaeOm2GpLwrsTPHbKEDEMCHZShC/5z9wuEIJAyvFL7ABgqYxZnCe2iCZM3lPUpGfo1Yr8j9+113USCFMxCQVKWP9eyPvFxrac5h4fUD115qpdRsYhgobg/CtCtYTjW8ruuCPojJ9taBgU+AvoVFiUWsHknSX6/2nz8X8lqpz4YZ7bWS5lfn6Yb962x6PQM/SVgj+Z38uNz0piluxPKiowXtDjxWzrqguuAtefENC3zojaG/ynr5S+4OwCtV/vhzOa1uN8TeKgTsQOdT6M2myIrtBEnw2NkSnVtPQPdaMrhQ8omW4I0y0oi14RAYbjoHAmhPntvFs5a0As6h+uLtzC8rKqCN0Qtj4OpxoLwJ4YdTPpYUqatLnU+H84VE+SBfelvJT64Ke/U8VxtY5/hV0RirgHF3CTMwemjaV/kvfVaKJ5924ZUJ0udoVWtSK9++y2O2IBkN80qr09L7Y3dbVWOBshgKv8yPWc2IYsDpJrFg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 366qv0tFGZpmf03EWRftbC+QalWK5Y1ZIqZPE+FhMnBcCPUngBYvNOHKO/7nb/EmQwMzFcMu8XqP1qfVEXRGSgV4yE+OxpXcx5Sg5W/KGjq9oHbNtXAQiSoNW8Cba8FkgGN8BOtcC8ezuwjURycywFtMPRc+3SMOo3lLQ6dt5HcdyiuGLBERr+e3rdaab8+f5QJqTYcN1gEuhGrTXIIsV/fvuOmB4XZA9rrnY9aV/lu11oiQYYwEoruQkCVEJhphRoYTU109h6RPG8dFn4UmqfwZeM4VfIvWc9IPZnIin9E7nB/aIIQK174NbcIdMV+ACQ/cUoXR8lF1lqkWZwax5NP6d8It6JkCVZ5bDGTOd0MvrGX8VwvXIjRY2ANBDKUu6JdFwpVManVUkZ9ptmsTgirxlW8KQwXkM7h4mB4urMgeTuedYGKgZMRqT86fg1Wb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 11:26:05.6377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83089da4-fbeb-48dd-cf5e-08df399d401a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
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

rte_intr_fd_set() can fail and replace rte_errno. Check the call
when clearing an interrupt fd, and restore the error that caused
handler creation to fail.

Coverity issue: 912881
Coverity issue: 912878
Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index b8a7c53e5f3..71d67b71e17 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -1108,7 +1108,13 @@ mlx5_os_interrupt_handler_create(int mode, bool set_fd_nonblock, int fd,
 	}
 	return tmp_intr_handle;
 err:
-	rte_intr_fd_set(tmp_intr_handle, -1);
+	if (tmp_intr_handle != NULL) {
+		int saved_errno = rte_errno;
+
+		if (rte_intr_fd_set(tmp_intr_handle, -1) != 0)
+			DRV_LOG(DEBUG, "failed to reset interrupt fd");
+		rte_errno = saved_errno;
+	}
 	rte_intr_instance_free(tmp_intr_handle);
 	return NULL;
 }
@@ -1185,7 +1191,8 @@ mlx5_os_interrupt_handler_destroy(struct rte_intr_handle *intr_handle,
 	if (rte_intr_fd_get(intr_handle) >= 0) {
 		mlx5_intr_callback_unregister(intr_handle, cb, cb_arg);
 		/* fd is not owned by the driver, only clear reference here. */
-		rte_intr_fd_set(intr_handle, -1);
+		if (rte_intr_fd_set(intr_handle, -1) != 0)
+			DRV_LOG(DEBUG, "failed to reset interrupt fd");
 	}
 	rte_intr_instance_free(intr_handle);
 }
-- 
2.25.1

