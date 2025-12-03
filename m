Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8DD1269D
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 11:02:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2557402BD;
	Wed,  3 Dec 2025 12:02:24 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49]) by mails.dpdk.org (Postfix) with ESMTP id 50E1B402B7;
 Wed,  3 Dec 2025 12:02:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHIntpB1eSMUPYQLIqt/fELtx9EtQ51SNi4F5TdeMgqTLkt96IuOqxOg775r/tuqVQCiUKgVjfnZt3NhB+k0KnMeCWB3A4pR3MHTSdvXa1pPBLXpde1mOBifY/hbZ3WmyWsUQTqvM4WPKpQdwuBjI8zP4lipR8uIuEgTz2o2qpQyi2Hz4dDJ1Q5MORxrzDVy2Lz0pSKeY5YzInbJ8PjaBF2dQRVMQd8+vXWtYEilBWpHI89PdeCW7Ig9+iC2Pxi6zeSHS+tNAX9EWDse6lVQOJk3Gj4/bd3pUJCHWkWfYukIDYbc7xmgMfGkck3faA8oasn6OC/DUP4/rDEUBuvgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfVQg7LwmYx0vZ/k1L6ldemxvkxawKoov7Vy2z72Ilg=;
 b=PD5155Qrbe/4BJNZU1K9JfjTgitUCWGWkiDOOKAtkSNscO5N+RzAoOF0lGN5SztFUE4INXdiw4X/3j//r+RfVFKlZxuFve4MIZF/fOjTFValsxxEfkAHFWRFFf9nqkAxNHfH8EXpLLtBOTj1Wn8jt1sgxyEoB6d2ANpJTnexd7hRfm1+pOlwNQ/TQQDCum52HTz6RQsI40zjt1aRV9j9aT6eigZSYVoex/bD+XETuXlum/pqrsu8jm5NJUVqg+ggsIW4mNZSa4TcIpj9nfcAKOoQ20a2okq4ygsXc4ynC12haPhb0smCpaSRf8ma1aXNyDnrfxw1m0SJle/jWNrZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfVQg7LwmYx0vZ/k1L6ldemxvkxawKoov7Vy2z72Ilg=;
 b=XaLESbZ0+W6S5PuOSmf0VSo8WKuS8BJbsPBSjBm6NCVy7e2DdEV14RHzU1j/mdiCHoejnY4MOwOl/NdyVdcwuy6AeHO/zu9/ejDf4E1vOWeJIZLndpIZJo3Y+Oy5GCzQ2AdCOhN3TL30rDXMII1rNz11JVjv6fhCfJrBCLkVVUcgOOdS1OSmHCo2Uau3ztKJN5Wcu1/f30yIR6ZW+EA63kX1wpdH/FaAUQnkDP91CrMp7jAACdJBOL+8RYSdsK9h+h954gFTMW2K/2G51dch9Vf6iXqNd0B5DrP12zDPK8r069C5if1dbllQTpti1H0Ds/M29k1+qbWHbezBjmLMUQ==
Received: from BN9PR03CA0672.namprd03.prod.outlook.com (2603:10b6:408:10e::17)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 11:02:18 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::c3) by BN9PR03CA0672.outlook.office365.com
 (2603:10b6:408:10e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 11:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 11:02:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 03:02:02 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 03:02:02 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Dec 2025 03:02:00 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, <stable@dpdk.org>, Remy Horton
 <remy.horton@intel.com>
Subject: [PATCH] examples/ethtool: fix buffer size for pkt pool name
Date: Wed, 3 Dec 2025 13:01:57 +0200
Message-ID: <20251203110157.51471-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 5247d53d-3e05-4492-f1f3-08de325b6cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7/+rLdN5NzmTgIyNe0vHcynaGDRkkLrxc3onwsI9Im+7e8aBjTk9ByykQCeE?=
 =?us-ascii?Q?k9Ujos4szV6LaIKSDNXTkOs5l3lyYvB9ZAFg5vjKbYaDR0bkgGoRzMMG0ag9?=
 =?us-ascii?Q?5HlwWTnIjHpy3l3K+4wn7ZQMLZwkJwKW3s6IV/rmY193jBFdSrrENWm5yEmq?=
 =?us-ascii?Q?4gafTsmo2/hkqNC48OhFrOsNkSK7Nmle3C4DQNIf8T3uZd6Rgph+oV64xsjG?=
 =?us-ascii?Q?Iw5Cfvw4ypt783D/uCjLJO7jvYy33+Lt+97EdJLUpdaxGqTa0RE3yQkunUKG?=
 =?us-ascii?Q?UHRU1BR6l0o95QUUR9S8M7NdrG5xbWHKIdZi5cmeTHovg8tmzex/3P0oHmqo?=
 =?us-ascii?Q?1McAcABFTdBsP3gG2upBSTl4GS59LVwk8higXJfNA1QeFFfM8haSgxoJht9t?=
 =?us-ascii?Q?zQVrJZtUDZX/nKXeDm2nadOPzFMwmTfksZOPWAuYufMPvWBVrWnHXnpJD8c2?=
 =?us-ascii?Q?U2Q16r9c4ZCGxVyVfOCOnZlqqcyI4DUPsQSGL7/0mIx6IO97/8bZ2T+YIxwy?=
 =?us-ascii?Q?96yY/dUF3+FYirSZxU6nUNd1vLaYNhrTUXMCkyzIeBvmfkYLxz+zJ3mbn5Qf?=
 =?us-ascii?Q?1VUSiynpbTMMX/XrXs5JoY4jYyrc2zJNyKKH2IeLTVNUzhAharsDFuYCbd2Y?=
 =?us-ascii?Q?w7J7P73Y0xIQgHfsiFQBkgk7Q8/w3udfx0DH1sdod3Kwe0u1NwOmMmDmZP6d?=
 =?us-ascii?Q?U7zmLelSHiD0/JcTnLC1IikUI/xJuPwo3IuAeW2JCE+riPAU9hUG8gqqkwT5?=
 =?us-ascii?Q?jGWMWwCKQfzEhUIdb9BggfMByWXeYn9ASXyAyXUtEbcyF+kVVB6extT7BhZD?=
 =?us-ascii?Q?0h9jhuRC6/H2Nhe9+6RaDLhxthlKrFT7lbPZ43MV+tU8PKctJPDyEtEOV5QX?=
 =?us-ascii?Q?vlJOtGVvsGc+2bFGH3qL8SYGHjmGBX+JiqpsGhMcNvROr40qpTKtV26EpkNz?=
 =?us-ascii?Q?gw56SGWRvvEC6+pB9xQhWrgOwGfCelZ1xXp0+MzMYeGNSiB4g3PP8hV/POzo?=
 =?us-ascii?Q?wPYoXpoCdXnarJ5SYxkydwRPU32oYj/PgO09g4qUjZyQyAKGI9D7hz9ksn/9?=
 =?us-ascii?Q?0VvNN0rD6s4rM2gzgBtEzoAQ0V4vZE4IhxD9z01ywcuqC5GWEXtKOue1pGvB?=
 =?us-ascii?Q?Su6Bb9hKhceKhukHwAskkJipyX+IlqjtVcupDgS7UHuIu0WpVNztaPyPAlP8?=
 =?us-ascii?Q?cy2PTrbtJk+lU5REuRPzkLs1v/5v0oQ/JpuArKdQ3DStLNHz5eWIGbh4LmP7?=
 =?us-ascii?Q?WyKUGJu8MIORfzpyPZ8WeeyYHUGvGNT8uvlEUWkDp8cmLJMv0I8wiDd44wX8?=
 =?us-ascii?Q?tsEXDVfGnzG4c0tI7qH1NB6rSMqFG44mHYE025ZwxMEPSSvgm+wC5v67v5YS?=
 =?us-ascii?Q?tb6eU9DnIjIfu8msL8cKuyDklRjQHmxyC8V+eNF57QT/BGFOkeYhiDOhlf+N?=
 =?us-ascii?Q?owzHegUOgk+uQmPhDnmZ75Ns6mciD5Hjb4MZrh1xxLnVD97wAKb80XNlQYvy?=
 =?us-ascii?Q?Hg+xeYfpsmnzkfLUdEFCowc7bstyu+zOud1iUoIzLIg6wlgMYgh1r6YNVOiG?=
 =?us-ascii?Q?enPrZoVi8HK9NgV6qNU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 11:02:18.2430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5247d53d-3e05-4492-f1f3-08de325b6cee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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

Increase str_name buffer size from 16 to 32 bytes to fit the provided
format. The previous size was insufficient as the format
string "pkt_pool%i" can produce up to 19 bytes (8 for "pkt_pool",
up to 10 for integer value, and 1 for null terminator).

Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 examples/ethtool/ethtool-app/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index 1f011a9321..06605b4202 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -92,7 +92,7 @@ static void setup_ports(struct app_config *app_cfg, int cnt_ports)
 	int size_pktpool;
 	struct rte_eth_conf cfg_port;
 	struct rte_eth_dev_info dev_info;
-	char str_name[16];
+	char str_name[32];
 	uint16_t nb_rxd = PORT_RX_QUEUE_SIZE;
 	uint16_t nb_txd = PORT_TX_QUEUE_SIZE;
 	int ret;
@@ -112,7 +112,7 @@ static void setup_ports(struct app_config *app_cfg, int cnt_ports)
 		size_pktpool = dev_info.rx_desc_lim.nb_max +
 			dev_info.tx_desc_lim.nb_max + PKTPOOL_EXTRA_SIZE;
 
-		snprintf(str_name, 16, "pkt_pool%i", idx_port);
+		snprintf(str_name, sizeof(str_name), "pkt_pool%i", idx_port);
 		ptr_port->pkt_pool = rte_pktmbuf_pool_create(
 			str_name,
 			size_pktpool, PKTPOOL_CACHE,
-- 
2.34.1

