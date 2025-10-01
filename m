Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378DACCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:13:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E9E6410E6;
	Wed,  1 Oct 2025 17:10:49 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id B724140EA5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:41 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023116.outbound.protection.outlook.com
 [40.107.159.116]) by mx-outbound22-252.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgsvo82eu67LWQcNSChZcTmgzGRf5rQ+F38KYcOom+3mD9qZo1uYODpNGqf2qdAh9yeLbcTARdUFKRU8s4/d2yHmc3KFiTrDeDFPcelk+jTqRin0ZB/jLjfK4DTuWPFOs51d7ieGvkv3ABeOc/Pm0a8UE9i0/pzX2/t+Cn7ok2kNjdhuku3Oj/mSJpMVltmrzGkMZHUdijSXM4nqyFiGkJcJQk3JijKuk5dmTv6P8mmqk3OTZIMtPCP8Zdz6W3EKtMkibp3KXbfBloxXkVmKEaHvOt7u24Mhs350Kf8B5DYP0aaIlQCDfJyoduDip/jl84t4EnjSKjkHYv0GvWk4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5bEyqFU0mz4bkzU+d2wVlmJCDa+gvl5V07VkEmeZZs=;
 b=tGlgn0R97QNJXcc6O19ljRULHOxI1SEwKr4p2hnt/oRspfRihkLijIfeCpT9SId4KYyDkxImVeQg/viENCtICd9AlJt0kORLAynwwyGfUdxqdOh1AStwGKy5L4QY6unqf9Kbz634aKPX/y7WW07f7447BPatkOAp3BOXE7cIwuPDrcW1e3Dvb8hZUXcE4Bw7hEAHw2sbs+lBHx/qXmU6hotHjybeoMz7Tl+ys+J3ivXdeqYJd5aUE0jvwxkKFJRsJbrHYaZA2Yqey2cxXuhcB4eKoPPpl2ym1D+vwNQz059cnDl/MlYRb67y3ZL3pRe+7c01XQ4hjEF+etxWDoDFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5bEyqFU0mz4bkzU+d2wVlmJCDa+gvl5V07VkEmeZZs=;
 b=ijkEAAZN8KnlHY6Xo1o37bVO5sitcuKGqFBxwlTDXo5rUaaPWT2O3hBX1DGYhSCKe0pp9jvXFsUnVAFohoiAyHp6DyQ6XQDOcpTaUU1nuZjMyQA7x8XUyLD48WVat27mgfwL87A+STJAPMUI0WToWyXAxUJw8QeXoYl8skUE92Q=
Received: from DB9PR02CA0014.eurprd02.prod.outlook.com (2603:10a6:10:1d9::19)
 by AM9P190MB1058.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:265::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 1 Oct
 2025 15:10:38 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::94) by DB9PR02CA0014.outlook.office365.com
 (2603:10a6:10:1d9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:37
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 18/20] net/ntnic: make flow lock local
Date: Wed,  1 Oct 2025 17:10:00 +0200
Message-ID: <20251001151018.250671-19-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|AM9P190MB1058:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: de36ae3b-3854-459e-5792-08de00fcadc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?swobQdrZFLKQh/bgXEiIqIU4pb4+iqcKml346bJAThs/svJblwpl9y3IHCwN?=
 =?us-ascii?Q?2/QlrJk12xalfenTLoqERC1eGzuFg2SYM/FoEOocdm0WBA9HfGkZrQAHgSTf?=
 =?us-ascii?Q?p35kWK3N8i3YE9Zv8qxo1GWVxeAGTrJHGOQbEknuhLBTBWBiUovFPcUqrRBg?=
 =?us-ascii?Q?WiSInplGXGFfgiiMi8GH4+5jLhYkqvRoWlG9nNh8dVsA71G82yRCnlY/Gf6q?=
 =?us-ascii?Q?hEKAYSXSddScbqaaE0fh0kx2VZyGCtZr+hECSqMVdJ+0oP413Zx7kDxpQrlE?=
 =?us-ascii?Q?sn9iqHx5VzEXAPRS3Na2xGGJaJzSoxq9hIEBKf1+MEoxwoTQM9ZgQsst/Axf?=
 =?us-ascii?Q?OYBhORc+0EfVKKfa6V5pA6TYzS34W1ede4rDm39hskjno/6ZdJWRnipe4Nxs?=
 =?us-ascii?Q?cH/sg5ktQVgUR/LXmflDCCLESIsdI26T98dE/NSVfXhFmuqgzGF8GvnkTOHe?=
 =?us-ascii?Q?yAu10Jaue1QeJtz5WI4EaiS65OCSJalg1EfBEFj4VNL6Psr7fnkbWrUYbCl0?=
 =?us-ascii?Q?MMr8K4h6pB++SbfRv1ORyQOguSJvfjh7grgK4r5yGTwxQShhOBaAVkh1LOjH?=
 =?us-ascii?Q?Zzx1hDxKr8kwu9hG81J/G4BoetJ2uacnLdVURWyL5k1+xqZ14vEl0ZSCI+3R?=
 =?us-ascii?Q?/eYo1cJHKZHuHhEu6NheRa9HDiOlRyy3inVHCMQdsN8KeKiANJPq3RAQ4FyE?=
 =?us-ascii?Q?3CscD2T9UEXmsP7GbM8SZdbv8pmqlqOYjuISQZ8zT8LIudTD037ZeqFxrqw5?=
 =?us-ascii?Q?gh/84cvhm/Q1TzZmDvg/A3AbDu25E9HPWNqvLs+pY9GEEb8ukdwnlIy4omsF?=
 =?us-ascii?Q?XzD9MvLMiEj8UE5E0W3z6MduDWrL8hu/IC7uptLLVYijW5k5i+w5voHsGYXi?=
 =?us-ascii?Q?MS32eQFXmgzmJlsAlLFgjmDeWXKmdfpKUbSd33nxqsnnn2i8Cxh3HBVwGy1M?=
 =?us-ascii?Q?PhtGfoes2vygjpKPaqVfIcjXp1EEQAk9M7rLdtaWEt4ahk7PNAVzSLlljmFb?=
 =?us-ascii?Q?eoVxKfAAjFLq+Oo7NZmGlZ3exKkjSjYR8WWKrq1+3DkFLQHJbanBWXFjcg93?=
 =?us-ascii?Q?LMOCr5lOWGM0tvM3Oeeo7zyN0DRtw5z3y68RNH1qxWDDN/u6fL09PN4It0zB?=
 =?us-ascii?Q?f+ENX6lkrwLhpZR6ySyI925qg2w/g5lRR2aXG7qnIjvxr2ePyvET3jxCp8/F?=
 =?us-ascii?Q?Q3FyZT2C4EmWEFCXtDb5KvthAH3bh8BSi9HO+/3wOOJG7nE2dv7M2CtATUHl?=
 =?us-ascii?Q?0zdJMCfDleSFw2IjHSdEKTH/A+5Y3wtmUXnC4DL0W2CMh8/yOgJV4xzi7DhT?=
 =?us-ascii?Q?hIPuAl93qe/rUPWYhBQ27be7p90jAhJzHTj/kjmysEdfc3OQ+yuj16bNO+uh?=
 =?us-ascii?Q?9ShrDsG+uGC4AzIWmkOpGXk6tchx1Y4IFh1p0SDuz7ckIJCfUtUkqhy46dyN?=
 =?us-ascii?Q?0y6wsvtkZcWBZMNwdNnveVxhiokcYY8d/C4YYFDEwSw9sJd8NPOQRgFub7Ed?=
 =?us-ascii?Q?9jF9DVmgVhgDTkB4E9IS69XHoEf8cHHe5F3R0feelmWjJrxTdC9xGF0QDANd?=
 =?us-ascii?Q?ruxB+HbPnfEQzdKfSm4=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ftvpcbw2HmVRHIWTEk2Hhky1owV/DHmnm0y+a/ahx1X3PR3dp5LBeEQc/HC45rjAgzNpv4iu68nBQ0z5NBDvDkFVCWp5VTuZQov9cYdzNk5gHUq18ICW2WPginFMISnagz+B42PU5qFi0GfFDJyaAFSwe3LmcLNerdxPq+SAgxTNGOPaCJYIFQjoIxRnSeFhfJa3mAxgTPgLJ9xUHuoQPrGkaIC4GKnXZlbDAr8Drt3/faheBm0b21dStRodjZO3NyUXRfA5MuinDq0v5JbSMzjXBCNPNpVehNmDKzwI9VpR/hsw3iUaTfL1lKN25Mss7r8Xy2Cpl53dhNe0YKr1Db4X187x5TTqC9O4wTWHfF3r6EFUXNwbY3nNfKYXsdhb8jLLmyH8/cf5DRpflAbC9MDPHkQPWJnqk1ktvxLWmjM6JCGww8EDNXRn6PcXVYRJKg38zkSHNlFG19DR5/y4LnQ9tTbmfWtoi/vt50dm478ZKns8onH9PHCLCHUA3lC9cSYc5LsR6dDRbEJ781n0zQQ8f3/7bqrM8tsxEMMk/JOf2q9uZPwkD25ThL2HQyXHvlREMdMfeIKsdKPW98B/73QsPkSc/iPpu4yPwwPuj7JuIZsA0QjaJ6ruKY2hK6b7K5v41Ob5w7hXQKBDJ9PGjQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:37.7792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de36ae3b-3854-459e-5792-08de00fcadc2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1058
X-BESS-ID: 1759331440-305884-7636-4395-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.159.116
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGJpZAVgZQ0NIozczcIDUx1d
 TA0ig10cLEwNw8ydDI3Nw4MckkNclAqTYWAHy/7G5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan23-248.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

From: Stephen Hemminger <stephen@networkplumber.org>

The variable flow_lock is only used in one file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/create_elements.h   | 2 --
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/include/create_elements.h b/drivers/net/ntnic/include/create_elements.h
index 7593ab4687..7d9d8d1d89 100644
--- a/drivers/net/ntnic/include/create_elements.h
+++ b/drivers/net/ntnic/include/create_elements.h
@@ -58,6 +58,4 @@ enum nt_rte_flow_item_type {
 	NT_RTE_FLOW_ITEM_TYPE_TUNNEL,
 };
 
-extern rte_spinlock_t flow_lock;
-
 #endif	/* __CREATE_ELEMENTS_H__ */
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 044f2e55d9..c1a05255ee 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -28,7 +28,7 @@
 
 static struct rte_flow nt_flows[MAX_RTE_FLOWS];
 
-rte_spinlock_t flow_lock = RTE_SPINLOCK_INITIALIZER;
+static rte_spinlock_t flow_lock = RTE_SPINLOCK_INITIALIZER;
 static struct rte_flow nt_flows[MAX_RTE_FLOWS];
 
 static int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size,
-- 
2.45.0

