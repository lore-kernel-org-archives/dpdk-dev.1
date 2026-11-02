Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A6606A327
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K/OPxe2J
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5848540264;
	Mon,  2 Nov 2026 10:15:54 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 15FE04003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 10:15:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p00zH2kqIGC/9Xf9422qT8zWu5vbD8lOHMLEtu1rNSZg4HNBDEdoAPEppxdyf54FA4u3i4mwjpEhRA/fMwXKGNzFCMfwg4n7RyV+30JBxQmoAIurMS0SkcafblXuSUos5GNiwkxz8UbuBSS8bK4O0P/Uhl3Q36ybCgGJkml/K0OSXQtvvtP7x5FRE0f9t51n9cLRGHA0MxDNl9QcvIibTaxCPjT6rmwDQNcWCKtTw7L2aHocgAtaPYjKeGsHhBY3teAp/0UJM6hhG7LzeQPMhg98rv5lkW6GGI0fAzPJYgEg2IErnraXe8S0lW3KyuV+BSab2sgwkjdwkne4VP41xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJg3U/jzbsMEuCKeCbqfDtr8O4BHq10y3wums7Ez5CQ=;
 b=vfM74xgFik0+LJCJWAUCfvxApYcGuNqw4enTNNx7WYsgptnqEq+vgHs7b3T850jdcvBnxGCYQSR8eu/7dXMMYoiafH1eY2GtqxiIzSQj1Zzc3PWxoNFbt57FirymnNFD/t6MD4K1o2M5DMlchm+Dy1QyzCJ0CPPMagSf3NQv5WIPPvvHWcMTT5RTo1wa7g7n2PhAPJzmtXSpyRplDDJ3FQJeaaKuz75CaGyhZ5j9+8JEuZilusFk6DTrQUwI7Sq7p5/Su/GPpufiumeNBgPkvMxoRY1ZFUg2auhW/pSigBIcB+cGVd7p443c8FasuwmRBBXsqa/nf3cRIWkjy6KVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJg3U/jzbsMEuCKeCbqfDtr8O4BHq10y3wums7Ez5CQ=;
 b=K/OPxe2Jh0QT1m37XCobtVY8zlxlf16LFXEwl+DbBXdX/Ph5ebd94LiE6k5nrHYnxXPVMlnjAIPY66048nFP+KVsx9aXgT+d44sxBRTcxRz6KEqVh1sf23xXfjhnv/DcmU2L9tTB4yHRFfbUowUeZj9N5VYiA6qanqTKbTDOdibIcy5PLDM97ueiynGNF6MrTvo0stkj9fECg6gMOkCC8jdEuD80KsXjSpnO74DHBnDC5DRGbwretnQDD4CgS/i3j7lU8mcmTpPjn7Qt+b01sZ5MVpqJ5V3aTKjN1u6jZJ8g2j3z7CtClih+kcgICgr6RrQFkISvH2DmGh/xT33YbQ==
Received: from PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::11)
 by LV2PR12MB150617.namprd12.prod.outlook.com (2603:10b6:408:3a9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:15:47 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::5a) by PH7P221CA0034.outlook.office365.com
 (2603:10b6:510:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 09:15:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 09:15:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 01:15:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 01:15:29 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Mon, 2 Nov 2026 01:15:26 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Subject: [PATCH] doc: document mlx5 range matching limits
Date: Mon, 2 Nov 2026 11:15:26 +0200
Message-ID: <20261102091526.3263931-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|LV2PR12MB150617:EE_
X-MS-Office365-Filtering-Correlation-Id: 744a1d1d-d652-455a-3466-08df38c1e17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021135927099003|11063799006|56012099006|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2llZqf7bRfC/d2HPeqq1eZa6KkgROkfvPyRNllo3jhzE0IQZHheY1Q8eKK4XGw2Zn9aDfSPLQ8+O+b2iEc+NWPEZELcpuJLw+6ejlHsZWqhwS5wuh7NahwoN1tKviQ1294HyfkkeFAlsKpe4MUGc5YRk7fO8+NII4KlCW2oq9L2jutH7jGgIIHfoeXV+qaAmud0o4IdfeKCEuJdExNcBrUkhOhEt3cGvdniqg9fMY6+HsCII2I7gCO7hSHSpPCRr0FYb4rrB30vcqaLX4DTdYD6/YIOa0lAIY5BON9+9MgO1S+Xt1KAhNJw5dcE3WUWrALVc1rK/1hILOAzs4PgToFtj0RFecYeR8HxrNH7t+TTAqhyOh9kGFHJ17/j7McmBKWMgHKylnIGwTa1BNn4LCuUQxe448SsE4FiRN8GK9RTMqKIRujHd2/x3BqA19fdRDgWfLHyP095v4YiWlKXt2h/jhBh3U0trTT7u8++WOA58Asf6Ud2f1cMVN35avvqSHX40p8jWgfG3JjpAy6/ABSwW5WfFNbHLoo7bgz9PGqP1a2ix00ztpx+bqU8eBx2qGFdtbLl3xm+umgIBE9wPTXv1DlxaSrGC6Ab660wRbBxQyFY0OvaHwJweLbQHtp53snhnFwveERGbxebqmIP9YIGO4oD9ZxnJgULc+ELVrsgfzn0MzM+EG2THwCw7RZfbhB7DCMb4sjnNwv7/HETvhg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021135927099003)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z3za4iKQ9AAD1O133BCS37l2s5BcHMPInodzFfDhkKqL8fYZDFxDGF2/TG9znyxkGWZfX27kfCFvD69plnrXXEVcrOrTejqZXxmMspS7QOE8kRjqTcx1N/vr6rcJcLoFgteKHPiOK+4+LMBTE5AqGh2qndLCgyzA5Cw+4kaOYCR+D5Upz5f4e4MxaV/3NrfS9+RdGpcLu4V4ErLkCdiR/aWbmCmxHpktSRySNCa3znAtvDPQxhoOcAzxjCecMx3NpLqwMx6JidcgqvMVJWf+ysPLYSWIBuB57l9LkaNFcAvT5do8St0VaeWdCFxA6734lIYfBwMZkzHbtHDF6FI4/5hQ/suHRRWIs8ABKVZssY/BpOWrG6B96Fv+0NK5bSuKo49O7agT1oUZ0XhwvuonkhF8b7IVH0cY1Uv/6/PDBIpVVrfnauq+tGURu6zWO/UO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:15:47.2500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744a1d1d-d652-455a-3466-08df38c1e17c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB150617
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

Document that mlx5 supports at most four range-matched fields per pattern
template and that some field combinations have a lower limit. Describe how
unsupported combinations can be split across templates.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c7bb6eb182e..747692bbfe1 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1424,6 +1424,12 @@ than initially provided will be rejected.
 Limitations
 ^^^^^^^^^^^
 
+#. A pattern template supports at most four range-matched fields.
+   The exact limit depends on the protocol fields being matched,
+   so some combinations of three or four fields are not supported.
+   Split unsupported combinations across separate pattern templates
+   and template tables.
+
 #. With E-Switch enabled, ports which share the E-Switch domain
    should be started and stopped in a specific order:
 
-- 
2.25.1

