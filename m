Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A69CCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 10:11:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BCB74060F;
	Mon,  6 Oct 2025 12:11:20 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by mails.dpdk.org (Postfix) with ESMTP id C7E43402B1;
 Mon,  6 Oct 2025 12:11:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrDXZr15X73JCDw/Mv4fyH9mLv+1NalaGAzH9HJY7jtHylmJE+MQVCeSSU5nubO2YuZCAYO+NQScn7I7enqkK43OmlA0pNAHfe/H8l0JgRCIcHd+6004Tm4wjw2XViIG+P8Dm3JvVKb4O5oF4usG83R8flCHCLybbScn9QNy4bKswCTkX5kAdoEAkn7+q12lc5GZZ4LZItQ48X9nt1QSZv17bUnl80EN7YsNHQzBIZE8XWrb5ng/2IlkGllJtzt+WbaaUKdcV7ZUTq4EJqxg0JTyM8S4+H5jcJUrd4Vs7pX7L67EuNmZGYVXnv36l5ViO5bDCw1sifmS4iIdyFwdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHLVQcUccvah0u+HChXeA1OeCjTTOhmFF84lp/2T5sw=;
 b=RzSX3c/XlscCF48j0qbfJfSZnIZ940XYg99wVtf+c7U7RStpUl+J3S1Hi6SDca5QzdyX8/K2gyVmV2Oc39OwlsNwRpYc20a8PdY0fcj18Gzx5HCzTo41/Br76UGmtbE+ZlSzjsnZXVq3lT7kYnxHyBsrk7OHbRCRgwcS0BqjhKK7kzS+4/7ZNp6fCJlhtJFPgYcogo/zbKfkjs2URTx3K2SEUwAzfNsATMcCBcaRBqG2TM/Bt+BaWxhnMuNTrKHXivp60VUTHZnuAZMsEpK2Iu/WomWSM5q7c4TWJuFfKk4rBg+0EnY6cTIcJy0HEBZr2Gxv8zQMca2XRJtDtP/hKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=smartsharesystems.com smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHLVQcUccvah0u+HChXeA1OeCjTTOhmFF84lp/2T5sw=;
 b=CCdl5kG5+Wk4LZi+tRQH3FgJ7OaFdfDKTNXgWiolyWwGGkCy45gJ+Ou/6PEQUGZOoas4+ov5YxBdrNU6AurR+ipr1rGnS4dx40ucMB/cO+ufd9+NC7MUl8hh64iaBP7PeDVFPCC2bu/J0ktoPWeALnsEjsFt0HesyUYSgjKuLLw=
Received: from BN1PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:e1::33)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:11:12 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::61) by BN1PR12CA0028.outlook.office365.com
 (2603:10b6:408:e1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:11:12 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:11:11 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <mb@smartsharesystems.com>, <david.marchand@redhat.com>,
 <ktraynor@redhat.com>, <thomas@monjalon.net>,
 <konstantin.ananyev@huawei.com>, <konstantin.v.ananyev@yandex.ru>,
 <bruce.richardson@intel.com>, <maxime.coquelin@redhat.com>,
 <aconole@redhat.com>, <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, <ciara.power@intel.com>, <stable@dpdk.org>
Subject: [PATCH] examples/l3fwd-power: fix telemetry command registration
Date: Mon, 6 Oct 2025 10:10:58 +0000
Message-ID: <20251006101058.191495-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ef814c-bd59-4a26-c53d-08de04c0ad6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iz9VwkcZG527uKY6H0u8uoLUDfn+6VTAU55wIYrFQefV0qQID7upsYGTzaoE?=
 =?us-ascii?Q?6gfY9D3SM+BWqz6xaEdFD3MUeHgDX/BRhXddqAdQB9gIqVc26RenfzWa821J?=
 =?us-ascii?Q?B4pk7tqebF1TJ5BDCKMUEvkCBqM8EE0QdWnJT2KDjf5nhOaeG4W8fjP69Win?=
 =?us-ascii?Q?ZE+ZI9i7oAmtl1qr/FDCQ0KWRFrBUSOyBzP+0FSOjnanuRD7ExGp9fTYnCoE?=
 =?us-ascii?Q?k1YHseg0Eb2yUElU+g5CBzcv9fOxs4lNKZ3oXI/hWQ/eaL86l0Ca+X/i88NQ?=
 =?us-ascii?Q?2y0u4fY4zD//sezMs7pk6ySHYlBhnFyO/6r7o5A02Pz32v23RnIHFofhc/JG?=
 =?us-ascii?Q?72+QvydiQLINgvBwiSPfghLlLf0KP3MH3JS2SOvsSibIRINRMPWXj96UFtgl?=
 =?us-ascii?Q?88x0mVYwpeOy17hTIkAtx0ThdxJuy4h1OzwhU4/cWFp7Gh85+sZwrNJKnz0M?=
 =?us-ascii?Q?cDOdxr9OmV/TDzof+m4yeQebPGFnWm/rKbB23mtQrpd5H7bYCJXea00hyaEL?=
 =?us-ascii?Q?w0ipDcql1F6dYkskAyt8grOxvYe3+a+zGWJC/79qqq2AnB2lPiufjPtlJOHY?=
 =?us-ascii?Q?AmH2NRtgMk0pLC58zggg1gZ91c8MyrdNNwP2QqlepFajIZLFuR3TvQfzJK6q?=
 =?us-ascii?Q?kKadsAQI4J2eBdQbkWl+cnailGoWyFwcYf2HfiOQaow1J3ZCtFoR9wq6uN26?=
 =?us-ascii?Q?yysRA9nA4hz7ZYmUOuXvurzFSNAEClMIklC5/+QFVf/2Rl1PWYnZICqRuesy?=
 =?us-ascii?Q?dLKI4CHd0xJiwZXkQ9RoNx2p27tNljXzCmZVPjVnWG4CDPaUW3h+73uNdOcG?=
 =?us-ascii?Q?ylhMaA34uTir+PyyH0dCL49tLC+reB5tYfLDKF9YSj1wtu0foI/VEQ3vb/8L?=
 =?us-ascii?Q?5QC2GDDbMWbimSnbGS5Q52Tj3tuhWVe4EXFCLJxemz85SYj088hPLjFNAdjb?=
 =?us-ascii?Q?XtbuCct0Q2SWbEA7EjDTg5QEevabzR2GwCXD1Rjee6b1Xktyy7RLw9P7QH3d?=
 =?us-ascii?Q?LIp0+Y3PawgA6pCgVdPUhMJvaPIa7yROKL88f37BuHdgDEbbml1nAO7+lyg/?=
 =?us-ascii?Q?FJl5tO55jbN98e8Q/j5QlB3en7AIqyODeZtpz0yiTDFyT3v4OSV7OBEwXVS1?=
 =?us-ascii?Q?WsvZ15k3GLGB12vZxLOrWQEKr9Sjq4+7jJfwm73RhYG4e1lUcu/KjoXsA5/Y?=
 =?us-ascii?Q?QC103r6u9kGC7kZSAJ6cbOo5sYgheh1MERsImxrZQICc+qIZ6sxRCbKuh3W2?=
 =?us-ascii?Q?aHCOq8msWIKsYRQCBvg3eOdaiKnsRHOc+97QvymO7DOU4AznGN195bWun0nR?=
 =?us-ascii?Q?Nal/pAlcAitVTxzJp+xwBebupmTrGBGTqfj2YSxThTp7uX8pmnPgOnS80Nd2?=
 =?us-ascii?Q?7lviEzb/2IKOjHlSr9r6uJtIeifN8XCMhZT3l3LIaSd5SrUKe2UPlEoM3NuR?=
 =?us-ascii?Q?LCPjNEG22olSuT2/Xc8Sg+8vQmzveHS9tRU+v6298xaQqzZHEaf0swi/3K3/?=
 =?us-ascii?Q?eo8xsqkbyJVI02FQ2x6Wki78Nxuw3NX90UEzvf5bj7yfnVUsj9YG8hCdihmw?=
 =?us-ascii?Q?WGIibnU93e35pB3nbc2PwlgoLc8HQ9z8GMr6XcVN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:11:12.2575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ef814c-bd59-4a26-c53d-08de04c0ad6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
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

Telemetry command registration fails if the command name contains
characters other than alphanumeric, underscore (_), and forward
slash (/).

The l3fwd-power example previously used "/l3fwd-power/stats"
as telemetry command, which includes a hyphen (-) and causes
registration failure.

This patch fixes the issue by replacing the hyphen with an
underscore, changing the command to "/l3fwd_power/stats"

Fixes: a35919a1139b ("examples/l3fwd-power: use new telemetry")
Cc: ciara.power@intel.com
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/l3fwd-power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index e27b8531b5..f9ce9e6698 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2910,7 +2910,7 @@ main(int argc, char **argv)
 			rte_spinlock_init(&stats[lcore_id].telemetry_lock);
 		}
 		rte_timer_init(&telemetry_timer);
-		rte_telemetry_register_cmd("/l3fwd-power/stats",
+		rte_telemetry_register_cmd("/l3fwd_power/stats",
 				handle_app_stats,
 				"Returns global power stats. Parameters: None");
 		rte_eal_mp_remote_launch(main_telemetry_loop, NULL,
-- 
2.43.0

