Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98C4C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 06:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCDD840A4B;
	Tue,  5 Aug 2025 08:38:21 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by mails.dpdk.org (Postfix) with ESMTP id A620F402E3;
 Tue,  5 Aug 2025 08:38:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk1GXtp8DSx1YZkMq3mH83Z7+ydpd0rkta739fnejTDWZeSCvK7mswadHHXaaz145hTm5Up+SbgIU4p65oB5tvLideNO1o04lt88I3+KJgHEo/rqLl5fA77cQn5UlTBSctmKL3F4F9jsdeHjoI4pPJnIrZbzHNwZuuyd4kJIhXCriyu6OM1ysm2RA3uHFcXWZyRHUhDwuslb9DKkWcYPe+KfwqKlrWzocPdWXIs8h2hU29QVjpWob0biLKSFu816IltLgYLyTarDmUeYk4y22dpkhcJ3HXaU88F1X5tmKPpzGU4hjDN5JL/5rO/g5/jVP5xGuX6b3kDHfsCIN7U4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0fa9s8be/Ac2VAP+f2OZVtcvNlofBZ8ADaw545SMuk=;
 b=S6X+X5FAaP6EL7mlM+FAAB+Q5LK9QLE5isgHQsKpw2saSpJTUJfK498x8B6IcAkKnO0qHFJ5Wl9bC0RqvH+zzEBYBjmliupQ13+Onqq9z++nzD4SfYhN4Ui4GlSI/14yUfGC0JBgvjVS8g+h8qAIcV1XQXljzAW3jA9dZzA9NNYtjDopvH85QZGUIoD/y8eku5tp8GKP8GJUi21TJO7FbDA9Pa/P+1dFs69HdLadJUxKo4tRks1Q/sPuwiScic+6R9lS8pdZuIrTRLGilRuENCodMuhlr1EH504fSbmpDdkaog7pUNAKQmVbsJigLo6nm9aI6fbG8YB7CNJq+Uf43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0fa9s8be/Ac2VAP+f2OZVtcvNlofBZ8ADaw545SMuk=;
 b=q3wtv5Ig9tqCGPRZMSRl21AGbq5CBJwv+n/0X5RdH4wO6+rsHv9V1WF5ELEr4eqkbIKx7nCOj6nebAayMn3bjdZp45ZmoIobJoliaV9a8nJ+JZc8ySkGkyLClIPaSk8xrhnGUzlnnSgkuQ3B/zaIBlFIualoDBlQiDUJ+ZRsPsGFHX0C2jgHSl5adGf7zGwzdaQ4dzBe3e8/aDplR0+Lruw1TOmzIwd2lPUasDyBCEI/ukwapdb6wHLRqFRnKR6d8RgPYwzTZASL49Z3U5pU1Xu/8dsuYY3AnJX1p+vZ/sZ2NYpOSCj+L/CC6w/tSHfrtOl9+4EwlKAksZFoVWUNdg==
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 06:38:17 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2f) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.11 via Frontend Transport; Tue,
 5 Aug 2025 06:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 06:38:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 23:38:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 4 Aug 2025 23:38:06 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 4 Aug 2025 23:38:03 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <suanmingm@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Kai Ji <kai.ji@intel.com>, Michal Kobylinski
 <michalx.kobylinski@intel.com>, Slawomir Mrozowicz
 <slawomirx.mrozowicz@intel.com>, Marcin Kerlin <marcinx.kerlin@intel.com>,
 Piotr Azarewicz <piotr.azarewicz@intel.com>, Declan Doherty
 <declan.doherty@intel.com>
Subject: [PATCH] app/crypto-perf: fix plaintext size exceeds buffer size
Date: Tue, 5 Aug 2025 09:38:00 +0300
Message-ID: <20250805063800.225231-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbf0e60-efd0-4b42-a904-08ddd3eaa91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v0rtyvQhK9CII/ulaIX3yTk6VHxfSREfTEN4KvOI2gl9TZhTut2Kga9ljcTn?=
 =?us-ascii?Q?zq6+kiHQX/IZTY0zCPg0ug0EElrkpdjpIBXNL9np0jhsw+pqMgP8m+QETiGp?=
 =?us-ascii?Q?VbNVV61PRv6zqCrnvfsau2hUheN0IFdP3eWMZkaAhZLI+qla8F4Q3LAGDvL6?=
 =?us-ascii?Q?VIJo63FdzzhS3oEAj1NR4OI/9llYFHx3+oOYLRFnQ9jWAGQ0vl9jzjf9gg0k?=
 =?us-ascii?Q?Jv18BqKnsFD5uJlZineJKFeF19AqTzYjp6WnXSgCpiDYtAwrrmXfGpzjaXIm?=
 =?us-ascii?Q?vTU2FOFdGnGVlXFcJ86VQIlYNoSBi4gpD7+p06emQVUbzqtZVUtNYNYgnSCZ?=
 =?us-ascii?Q?zOHLMIMi6YoWkuh9fE5sQPjmUMoHjnHVaO17bWApL0RlS7nj0Nur1l0fiHHP?=
 =?us-ascii?Q?73u//1/AJaF9J/MW2BNAZPQdl5UGc9h3Sg0R4Z2Xmd/JaI6EAHTRhOFReiJk?=
 =?us-ascii?Q?ISMuOOyoTWAKS0lCTvHFGf+dYN/dPF4KRgxKsisLJ7yp+g5LdXgfCQ2vKvo2?=
 =?us-ascii?Q?NwwndkRS95QiunwrFijBGaugqF+HMgOHbyiLr5SgoQX4TqTdmB+/ClCpZFwa?=
 =?us-ascii?Q?Q4B8kB7EWaRbhqQTiLL8p+0Imb8iGFrh0E3iCOmgeNwy/vURZmg7BFtxWAVz?=
 =?us-ascii?Q?ITZI1hCNZJkr4RAnXldeNNCiBG5klqwCI6auE7hGNxFNMc2y6d/nmS4O4wXN?=
 =?us-ascii?Q?FUJZhQN4KdxtJOxjL0m+hwS4FDPwJtUaDo0Qft1UM8WO+fRluGsow4EnOzzo?=
 =?us-ascii?Q?6p74xmPvU7PPcovlcxcDPRFTjmL3W/A+Faj42DnNJyzOhuJXqaao9FdMEr3z?=
 =?us-ascii?Q?rk/DC1Fx3+zR82gtyZypoVtIcbc+ZrNbMkpS6eN5PQEYr+LNmOvekb+r82qU?=
 =?us-ascii?Q?8pv38x/OI0Ti3kMHaGpsxjqaHGYZf10ca/s2qfmhaGrhCla5JL07xwECQ60s?=
 =?us-ascii?Q?9RMWV+nPH2zAbFPiU2J8FziNvwvOZ63L6vxUMkQBWmI8u8v3IepnJ9gGdNRU?=
 =?us-ascii?Q?GrEUkZ+7SyZ9WEHPvqKGsCrb4LDnKZvbPg9JLLG0oGVNuSA+H2GcGz4JuS4/?=
 =?us-ascii?Q?s/95GmzOMT8YUDJUUq83afqPnOfSBqCLfYzVzyg/RdFEJ6TkB0MWQ7fFKU+q?=
 =?us-ascii?Q?XIiBbGBRoq3AWsRlPFAeNNmUEmWk3MDOvIdJPVaXqRSWIGTYgKiCq027c7/n?=
 =?us-ascii?Q?xq21SpM4p+SRhptpgxi2wBurUdhRtoDrIZG2pdctbmgd64EvlMQT9+x5CnRz?=
 =?us-ascii?Q?X9Y/zGmYp9/bM1WeHpB0f+fgTky7oQ7j2GOYzgg/6tY4QZBNlLZDj2V/JIgt?=
 =?us-ascii?Q?kB3QrZSPA1l1szI9n+a9VfVZEsoM4dOq14BZLhrMdV1BZ8T4ZuSSX6GDCxIZ?=
 =?us-ascii?Q?59QjzaOYc8HwTQ+Cb39i/VxUeMD0h2pbGjbxHomDT/kW2S4OHpFRn7yRTU0o?=
 =?us-ascii?Q?1PDJDxtUxOfVR7H0Km9ATGQ6ay8t97VtPv9CZgTPbXghgWNqadwLxRz3IbIZ?=
 =?us-ascii?Q?OTg7sv0+HiUP3TIyNyYcp07BWFFvRSf57dQ/?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 06:38:16.8938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbf0e60-efd0-4b42-a904-08ddd3eaa91b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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

When test vector plaintext exceeds buffer size, only the first
max_buffer_size bytes are processed, causing incorrect digest
verification (computed vs expected mismatch).

This patch fixes this issue by checking that the plaintext size is
larger than the buffer size and returns an error with a log.

Fixes: f8be1786b1b8 ("app/crypto-perf: introduce performance test application")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-crypto-perf/cperf_test_vector_parsing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/app/test-crypto-perf/cperf_test_vector_parsing.c b/app/test-crypto-perf/cperf_test_vector_parsing.c
index 737d61d4af..04ca9cf019 100644
--- a/app/test-crypto-perf/cperf_test_vector_parsing.c
+++ b/app/test-crypto-perf/cperf_test_vector_parsing.c
@@ -308,6 +308,12 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 	if (strstr(key_token, "plaintext")) {
 		rte_free(vector->plaintext.data);
 		vector->plaintext.data = data;
+
+		if (opts->test == CPERF_TEST_TYPE_VERIFY && data_length > opts->max_buffer_size) {
+			printf("Global plaintext larger than buffer_sz\n");
+			return -1;
+		}
+
 		if (tc_found)
 			vector->plaintext.length = data_length;
 		else {
-- 
2.34.1

