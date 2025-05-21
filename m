Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76ABC54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 17:24:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC413427D3;
	Wed, 21 May 2025 19:24:15 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by mails.dpdk.org (Postfix) with ESMTP id A0B8040298;
 Wed, 21 May 2025 19:24:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PX2hljyPB26ssAoK5uwqEovB6mkF8schfHACQ4kbMKPieMHjKzyVH0iDuBMI1gFvkiC0tl2X+RRz5nofa9eDInxDeIwbkATRliyJhCsAarUx1IG6+gP3fzmATxgrHxLCXMMG/eb/zuw6riVgXHoVjdABK2gkcwejI/m18W0UtI0hvZvXeig+AF8dZJSIoSVc7YIKR/4HnB9qItRf+c5M9s8nPak6g8lnh2nGEPjJc3gvOn1QYjvBS28jk7UMvNvr6Kl0ihklQt7DaMqtXaK+tsXp4U1lVajhgQeq8IytbTKlj4OGmTh1n87r2yNbb/kyv6dBQnoyjQoK0t7KutasjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FFH2m6qRtLC4ddKasojFL+MnT6dViUJqZJSS62Jpvk=;
 b=ihutOuwDiFUOAvNicHHe41CXFmYSlfNJK7ZplyyVudOWLCNv7OBHsUq7gzYjGAt+sTzhecQvm5cFVqiUSHyPjyNqwXbXkszAzUmZE6PVPvGPOQ1FbScQdrcNzuArW9+thisOsQCADU8elWkv72tbigxesirVJZ8hxaOnK5eeVlAHspS5T3PncWXx62kESl110Y2EVymT5eRU9fooGRZPQQDeiK00H85g6xGCl7lsjtCPVtVI/319IrfKeKeke2u9cM9WXAnMfJH2KqWk205pgRXaZE04rX0UMcq+DPoT6iw0JaEau6p1+rChZZlVJXFSoq9KS5hZ9l//VFpWpzI/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FFH2m6qRtLC4ddKasojFL+MnT6dViUJqZJSS62Jpvk=;
 b=GfEfPTurrMk6p/zKFmXQOl7XUhBAAa04WAtZj3nnD83K95SGDy1BaKjb/i3BKmajogw/6GuplDfyHHPxuNRT5sh9P9/QZtEs6qKSPRIFIo1/yPSd1sYlE9KOhFwQzcULY7Yf68oF9Kax1/1/Sux/0Q136Q7VFdESLGxs2llR2FeXpiVSEADoerGT+knySr40u1K7fs9eestemKYDGvvx5LorN2Wsq4qvNu9OtxQcfD/mXiNXnM2/dHUG25XRgE6P+VRlKLN7XSWinwOCI0iunkd9LATEnrqEcyhEvztXkNtu+83ZHkrufBXfLUnazcZU1KmkBjTx/XRLTx0YtrmSTQ==
Received: from MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43) by
 BN7PPFD3499E3E3.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Wed, 21 May
 2025 17:24:11 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::89) by MW2PR16CA0030.outlook.office365.com
 (2603:10b6:907::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 17:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 17:24:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 10:23:55 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 10:23:52 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <dev@dpdk.org>, <jingjing.wu@intel.com>, <junfeng.guo@intel.com>,
 <xiaoyun.li@intel.com>
CC: <stable@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>
Subject: [PATCH] examples/ntb: fix the heap allocation check
Date: Wed, 21 May 2025 20:23:33 +0300
Message-ID: <20250521172333.12859-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 594e9937-1447-4af7-0cf6-08dd988c4d17
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q5hi06NuZld7M6EuxKsoydd+5WG8J9gQExLwZWZRxMFUZdz/GkMJaigN+FWs?=
 =?us-ascii?Q?eA0KPol0Xe7P7LE8+yxCB00Fm+bQTl0IWG2HCFWjUf6RZpCKMZOoOIuxRrFh?=
 =?us-ascii?Q?iO6ZfLcQI8WUNWBaAaawJo54NkHUqYQRuQFYIekpfvW48cvaZHrdtuqDxXUH?=
 =?us-ascii?Q?PJOPqkNdx+aP/fmtjNEfOSWHg56jyReGUEfuZGbuehvVL7X0lQKguWpmB8GA?=
 =?us-ascii?Q?/4KX7BWcs2MQz4xG+sAafl0yZUTuSjqhYVXuw+zwVN+eUZ+vGLNDFlz1TEaI?=
 =?us-ascii?Q?kYXmM0HDu08xL/HL/YolNP9rEZ71wDeUiTuM8RLWmWi2yP3gk38L+2AQn4z8?=
 =?us-ascii?Q?lb9fjdUr3ituHvIsmXKrY6ZGomhUnrbQ6DMEiTU6Or/A7/mnFbFsFWTY0vKC?=
 =?us-ascii?Q?XOL6Bk3Q36ydWqHDpQpFlzNfOXIepU42y93DJdAYblgEhSUehWlJMi4/Tam5?=
 =?us-ascii?Q?Hxv3q99XPkScBzdCjZ/9o+8wERoEoem842xxtQ5K5rXlkbtYEJtmBZM8esUR?=
 =?us-ascii?Q?+FlBacr0jH3ZKRewbhqSJRd4ziaO43yneGuyhvSipAwXqqRZOuHmr6GFVZ7d?=
 =?us-ascii?Q?cUdFt16U+wHQnAHpmf515/ej7gyBuJPMP8pMZ1g2UmAOcItZw5GNfsylDfT/?=
 =?us-ascii?Q?+3IyF+f1QvNU/2Q/SKGQsuGsSTxODOMVZrX10q0wKh+dA7+nqEFhp+qv1Fl5?=
 =?us-ascii?Q?XS1fxD8Zss2y/i+YlMesH/6WzOJtBRWlqC9scIqRM0bMZ3rClLeQGq5xGReF?=
 =?us-ascii?Q?EZbE4tpyFIMBr2FpCQxeF+U9ExMkra0epdIgchJCgtVo0twRkw3GbIOpM4G7?=
 =?us-ascii?Q?Xbi0LfcpGTmFUq/TxWYST6aZEz9KbRsXhIqjizUX0KUBnXzg6ylPLkQfBVlp?=
 =?us-ascii?Q?wgmGp0hRnhw5Ye5ofKM4l19CFh4024PkPmeW19DWva+PnhL1L+Pg9P03DI/B?=
 =?us-ascii?Q?77a/WQ1Tmb05BKVPewN6+J3ME/aZ+X2fgKYCQT/bB0iYTSPw1p7LaW/xArY/?=
 =?us-ascii?Q?lA6CTQ3yh91HuHMHUJ5ImArkgCbhNiJjB2h6Wz2b/a7npNtrH+ty/aE75goQ?=
 =?us-ascii?Q?MogrlboJAmRDjblHyKNhjFGvE1t3bmVTobIodJbMniNKva2W2dGIGcToxqIT?=
 =?us-ascii?Q?WnP7gQ7hkuwRuNFt1W7S7XRBI8sau4I9MV1kL4Wo4gaaxPFu6AZgjmDr+o9j?=
 =?us-ascii?Q?+tW7N5jDJEeIbxp3yz99cFSaGdomyZvU3XGdpDrjiJ2dZ3VqzCusUNiDKTfe?=
 =?us-ascii?Q?iIzTCIQRiO5Oj8uBzQXeaP5khvFL88CYcZmP+I3h7yuUUKSBRnnU/zGtArM8?=
 =?us-ascii?Q?kUFEe5nLJFaamzo/LEktmF9zr7Q3SxJxneoJ2ukNXnMl1mLLDrCw/eTU8Uf5?=
 =?us-ascii?Q?Q4dKakWQGTS59O6/C2gMznCFrBlBVN2QNgY7BJdmgoJKpfrWFQc2QHhomSWG?=
 =?us-ascii?Q?gctNBk/jq9DoYcVdYz1EHsGWJlbRRsv3c8E4Adqw27r2WgMQhGGPrMdUREN1?=
 =?us-ascii?Q?H+4zZSTe37WT+7nwopzhig4PpePh1+yP2Rdt?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 17:24:11.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594e9937-1447-4af7-0cf6-08dd988c4d17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3
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

In some rare case, the libc memory heap allocation may fail and
return NULL pointer. Before accessing the memory via the pointer,
the NULL pointer check should be done to ensure the code locates
in the safe side and no crash.

Some newer GCC version will check this by default and report warning
on this. Adding the NULL pointer check will help to get rid of such
warning.

Fixes: 5194299d6ef5 ("examples/ntb: support more functions")
Cc: xiaoyun.li@intel.com

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 examples/ntb/ntb_fwd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index 37d60208e3..bd4f038516 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -843,9 +843,20 @@ ntb_stats_display(void)
 		return;
 	}
 	ids = malloc(sizeof(uint32_t) * nb_ids);
+	if (ids == NULL) {
+		printf("Cannot allocate memory for statistics IDs\n");
+		free(xstats_names);
+		return;
+	}
 	for (i = 0; i < nb_ids; i++)
 		ids[i] = i;
 	values = malloc(sizeof(uint64_t) * nb_ids);
+	if (values == NULL) {
+		printf("Cannot allocate memory to save fetching values\n");
+		free(xstats_names);
+		free(ids);
+		return;
+	}
 	if (nb_ids != rte_rawdev_xstats_get(dev_id, ids, values, nb_ids)) {
 		printf("Error: Unable to get xstats\n");
 		free(xstats_names);
-- 
2.34.1

