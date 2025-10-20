Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD21ECCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8248942E6E;
	Mon, 20 Oct 2025 18:44:18 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id B0F0F42670
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:57 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023130.outbound.protection.outlook.com [52.101.72.130])
 by mx-outbound47-33.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8cno0CPs0ctC+eV5jZrcq52B+kzER70ysRhzAmMmtA/3kXNK3PDopsZitjMkPW8YzLAlEMNgixa7kEocLpMJQt4t+vq13t1jK5ct5q2EnvqHOFEeXT/WOnHBJO2VtVSQ9xjYIP8JhyO+X6CNWGItNYsbOP2PUnrJ40mQSITA7I1WLSycktO0mwq1QJ9qVlO8u9po0hKpGbSowr/R66Hk+VsL8A8jNDj6uEJ+BE89S1rwjyA5thouN1rPVCSHFhu4XXDymtnFNUkqLjYRz4O0B5qPEkOnHSUQAuGUeJgoZeZ/Fw5xgqwNrnfp5lH5hspJ1VHYT02yaYN2AT8Tzvi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5bEyqFU0mz4bkzU+d2wVlmJCDa+gvl5V07VkEmeZZs=;
 b=qFMwcvPecK23E/A8rJEvA72pmKN5zGPAnYrNY8F4o4UvF/iWie2XPly9AHaJFteY69BGzI5aGRhMXYK8ydDY83ZdVKmq4WJJsovJiGSj4KZFGEN2BS+jlu9gT3gNwuvx4pS49gFEfyJ5ZZVYkuHljP7ahQdf/AWAWIKS1l2iDH79ruvq+KQRwISEFD3u6yV1Lk5qL+PBF/SHITRCdx7oI9hr8ij9iac0G0r6rRIrfUD6B5w4E8mTkTrAYDlIhUlXPzYciP+HIIPHUm13TSneIYLqdnvC4bEvsi8EK0ODfjuj8jjeIeGEykFe9mnnw/up17PCFiK54dZfD8D4Sk51OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5bEyqFU0mz4bkzU+d2wVlmJCDa+gvl5V07VkEmeZZs=;
 b=kWDlLcrRabW+eX2KZxLDGBxC3BUYvUnV4JnrzHZbZbuKwM8PYjns4NH3mskHnHr+59E0n6bOx9OHdkfwN1jJuASeo6SM0MmV8rpaCz3pqm4IcHxlA6A9kybCvhNGaVVf/5FAJYt7vy6gJKWeVlxCvEYUVLpGMxCkDn/pL6wK86M=
Received: from DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) by GV1P190MB2089.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:150:1a3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.6; Mon, 20 Oct
 2025 16:43:53 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::16) by DUZPR01CA0018.outlook.office365.com
 (2603:10a6:10:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:53
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 18/21] net/ntnic: make flow lock local
Date: Mon, 20 Oct 2025 18:43:27 +0200
Message-ID: <20251020164336.283664-19-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|GV1P190MB2089:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4b1c1f0-184b-45c8-65d5-08de0ff7dae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Su4pZuOK3eo/JKnb6uCVm+hWpqV+erQGrPvN08J0fcv4dgY9mncnj9S67H8r?=
 =?us-ascii?Q?oKINFTOe+tM/wnsYhnkKuXcV9DdX0uMqcOymXeARJQ7M89XgLEAz8MZZXgve?=
 =?us-ascii?Q?+AIDTGwfTOp4qxs/mkIXOb/CpmRAI4BiyLfXEW7KHsFcogLVhLSZYMyDhArM?=
 =?us-ascii?Q?IoW6vifY/twTbwt5jSRoHYPP01SwcdVdu7kVWVuC9Ea/YXZKd9lS88uO6YC2?=
 =?us-ascii?Q?lMXXADoruDm2agX66SnvkP+XWeZm7dPGtE+GSLNMo+XzZ4Fq2YTf70hyjLXF?=
 =?us-ascii?Q?cMu7PHPEMWUd2laKYXqKVRSDMN9DbSPZnlErZblDm8W/32Zp16iyRbDlT+SE?=
 =?us-ascii?Q?JVY4gIf6jNSza2GpNk99GuZv0xb50RcKcSqmlrdFLVxvEghkBUCBD6aJxw6a?=
 =?us-ascii?Q?OgDFSwU8OJneoD8H+YUdeI9dGpUSykMIIMy247BFa41JProKDvJJkBFV8zVw?=
 =?us-ascii?Q?oHW9iiYQ9L5Gx4vmFfEHhltoV+FhM0YaVbjNxhFEHk5YHJdP5OscJ9RJd94O?=
 =?us-ascii?Q?1DiY9oMe8Gdey80T7mPIheCb+atk6fOQOy/6rw1Mo6Sju8NNlegA5zAeCL5g?=
 =?us-ascii?Q?8lYiooy7CgrJcI2wSlvjK6wsAYkRWyMHHipa762xtSRfLlYaYfbV5sp2jmVl?=
 =?us-ascii?Q?7vJQ2kKyVKFg4W1iknAEEww+snEQpyNMNpYSn+NgH8R2mPb41GhPCzrvCo9u?=
 =?us-ascii?Q?+UNYl9GAjWJK0hLQoFtvF4pvRAblLg10lvy9OkU6IkN6lUJT/FeyrYa5RL3v?=
 =?us-ascii?Q?csxCVNsnVZO0t4HQ5s9xw6xXL0zEvYCsikvihbh98mprnSLKvyP2y4CeVUXQ?=
 =?us-ascii?Q?PwSwBmZCafCCNT54l3p94BxwANfMJqTHa3E1kgOpxII36uAe2wrrCNlNhDG5?=
 =?us-ascii?Q?B/L7DsgFPSWJCOScDr+NT4EiiIaww7NDQqHlE938ArUObc0BsDMQgfb97roq?=
 =?us-ascii?Q?PBc4aa8nmkmlxkLN1a5U0JTMpoqcrMgcE2mNnr5gZiIE9T6rLGAf3pWVgvX+?=
 =?us-ascii?Q?Xrp+oiKE8xQQaCzHp0ecTutEVwCy9X12OuVkGq5FRgH/gAGylYuBo/J0CwKo?=
 =?us-ascii?Q?jaZhcFj1hGUiKTOvQB2O/DPHoNKkaqEzUdeDfWlnF9SzHMuRYjgbE4V6mn1f?=
 =?us-ascii?Q?QwGqsFiN9MeptIMscK60Dk3bgtciz1DgUl7Gn3typZeP4rNFk9LiXlXejzIV?=
 =?us-ascii?Q?0ljJUb2HmQFcK9StlHGByTD2qJSCp+NphCin9stGARt6cRA27fzljJVv2KDb?=
 =?us-ascii?Q?sqbvcgZ4xJrp2qPJ0so7b9hnt4bgDYdy9wwvAA94fejeBSnF45IBV7l6pZv1?=
 =?us-ascii?Q?260n85eB7r2j7qH1djCp545jW9Odwvv7tpetlhIq3Q2rNxNdEQqJyXAUPTEf?=
 =?us-ascii?Q?rKeum4tEMqsW9kMgb5xBmE8NVrDxGW/s5ofbyBtFwm4ve8zq7MRqDFsZ/gFE?=
 =?us-ascii?Q?X0yV9O17M1nRJvdqGDN3IaQDW1FJ1IUPoF48EmRygbClbtRZ3E3cab58fLjC?=
 =?us-ascii?Q?zs2RjSuJ4VQGBfnlEIdMnQ3IMT0XaYPIf2ieRBPgdb7f40C1zHvpWXOn2t5C?=
 =?us-ascii?Q?53+xsTSmo6AJ1T6ijwI=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8qr4k5aV7U1W9ilwhLYxmKUctJtfvf4QyhlNFVOWG2s43G8mODkocIjaVSs8yF4TIiMpqL5kFyG4CK/09C5gikQFWgsijD5/XYWSxOjd+xrSrka8eqir/Ma1t3fn/ERDEa7NLvmgSBHt6/oznanNob+UanWdhVAllMwVWXON1qrMk8ZfklZabimdkIKv01zwZh9ywtZM5v6wxAixTGEhkxMRTxrSMxGP/EAG6a8oakoNva/XFMMU4x6S3dZRIq8jpAIIhLaLtYIzDD3z/w64r6Eq3Jamn593palk8BfVtgx5AcV50S+/cuBghQYFwruNJbengSWCTK7hMuul4Intjl0o8oLCqvIAQJXjVoWUX3MwML270Kg4O3iTXD0zj60JbimTp8IKtUsEoZZmROEsxNx0m7jCzPltglq2IDeyiqQWCiNq5wd2/G+zw4iXymXM1GTmdHE/jCaExtUIv3dIcHQMj2kqTmyuxu7749HvqqUaRC+d8F5Xhrnu7/Hh17C7DXw0bfimwPck/xZoT4cJ0xd3cGgfhgY8Ab1PYTe3QlxGh4ZB3tyma50v/LsCdhoVKQJzdBVvlnPRlDN5DFjfkDnUDZmlevlW0pGwPe28H63zRQWkPEh6EiVoa23ZaezsQtf35nQSvjwd9/MEg3M6mgQxablmaimFnQnai831Atg=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:53.5279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b1c1f0-184b-45c8-65d5-08de0ff7dae2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB2089
X-BESS-ID: 1760978636-312065-25061-118147-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.72.130
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGJpZAVgZQ0NIozczcIDUx1d
 TA0ig10cLEwNw8ydDI3Nw4MckkNclAqTYWAHy/7G5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan19-131.eu-central-1b.ess.aws.cudaops.com]
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

