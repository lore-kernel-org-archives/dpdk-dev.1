Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F4C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A2540A6E;
	Mon,  5 May 2025 09:13:44 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id A0465406BA
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:40 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 mx-outbound16-191.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WisytuUM1elnhmjR6zTrH81hWDzb5SoA1vv9DvSn75y++vdtyC8KcBZKrXur47GD5/tUqnDiDLD6Bpf+r/TsagEYvwIKHBZFmrPUXADaDRZMEyd3/FbwnkOkgms0xILY9YRfx4NgvDe2Jz1ZZslo8VA4/kHGzeEsVIICbj5HnsyL2ntNOwcbW4pMrfYl3z2ADs1MJdeGFh3ziyVL51pWwUrL/hoTeFwVpl2+hFqF4ZGhAV4xFzgiBfr7FvKl+zdApCa0KwOCd6IbIzQ1P7dZW42c/TiFAr1WDYDyAbi5UlRvzPYrN9vG5SMuwhybnJ1ryCwhH52Ej/SqHZZs4WmGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O9U8OoIAByOXqZAYHaByOJ3UK+Oh0ltokxgUa6IjZA=;
 b=G7isGETF3BX0mulTKCl8mYwaQbhFXAFjbqThrt427FX5D8gLnG3Rmt7bvakR5v07GG9voatriyoCTLOmpSj0G2DOoRhXWw8lvucCskHq86KtNGAacz5uoPPdXcX4/lmcyVL9uecyw3PbQ3+cnWNq9l3a744XT7FmAbkKJepMcqd27v/kqEI378l7pfNZdWAGMIsAABIdwm342EKo7gLfIA/LA/WHScWEiYZVyUjptzOpSOJ3IPPtbUEYwcMfDh8jOYlmLFu3Imo5PvhQQIoq+zdy5g1lfJRuwZTTNwO5Gv6T0hcfBiutzqhDueQGxl+N/xSb5U5g+2SbNbHd7RGEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O9U8OoIAByOXqZAYHaByOJ3UK+Oh0ltokxgUa6IjZA=;
 b=SXqR1ud+Oj2Hw9Wgp7f4FxvcmApJ6r/U6kqyzdejS30FcgDqyltCTCjmKfoF4jpQdiY3D1k4iHUM198a8myZZrEO9K6huGCcLoztLxJw9Ps1oXId7TnIlRicb0dzZxa5fyz2zBoC7ScBUTyNd4Bdy/u/hGoCXOxoZQHa2Mhcg+o=
Received: from DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) by AM9P190MB1139.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:265::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 07:13:29 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::d4) by DUZPR01CA0328.outlook.office365.com
 (2603:10a6:10:4ba::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:29
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 23/26] net/ntnic: remove unnecessary memset
Date: Mon,  5 May 2025 09:13:03 +0200
Message-ID: <20250505071309.586015-24-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AM9P190MB1139:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d234ec84-e5fa-4896-8a98-08dd8ba45631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8F3hC36IFYhS39tAKmdACWpxcJPhOOFtOgX58L+rl8b56X9gj+ZjvwfO0puu?=
 =?us-ascii?Q?9Pfm+WFbKFNde8Wmh3yoHWJIcmKNHLhxAeoKidBnqveI7eQiNgjMxPGxalol?=
 =?us-ascii?Q?woVjpkEqk01Zjf4O/5C3lciTUCCqyDf8sRd2yxwgYjZqJ5db8SKc0rt3+S6M?=
 =?us-ascii?Q?l6/tl+STfN9Io3zYiczN6Kha2veOvIJY81nX+T8xpL9w+Npv53DRIO+AzW8T?=
 =?us-ascii?Q?7E8s0eNtHqB9CMgyf4y56QTFgNx0ZYH75y5peZevznEUqARkvNfKd7hnui32?=
 =?us-ascii?Q?YyFn4unFR/JojRW3AGzYrCfzaUhLVPNeIuOJ4on/2UxQWftsgiit+elsbR8u?=
 =?us-ascii?Q?JKmv0COodijDHeOq/tM/BhpUzHLW6fKe6x03xx5m7hK+Ky+wslcG9Ear36rJ?=
 =?us-ascii?Q?6zyLx8pcJx3+dDHhgQS5QVANtr1VDkHyn4C6h5Fg7+5jR08MEhsf8OumSPn6?=
 =?us-ascii?Q?B5D8mm6v4zcbMwYsg0fw9y2DpXjzn9MMVlmqvHeJ6cT/hC/HjCWJ/AFwwQXb?=
 =?us-ascii?Q?Lp0XvYunf1qwB3kWsQNs0R4OO9ufxGISZrgBrS41OoAR7CLvC6s+jP6m3WXJ?=
 =?us-ascii?Q?Qx+LHDEvhOrhM4Gcof52chTUGWZw5GCwztGHzTlCh/heOjYBm7R/q8fM0sgt?=
 =?us-ascii?Q?WqUw2rAdP0tiE8B3/RzaKaSopCRgyIvuwK1UzeYfdmCmTvQVIxjz4FLNNxbu?=
 =?us-ascii?Q?uxWg6GfFc5oYgN/WmhxySvMVG4oxq9FjKnYxSnEN1QjeuZ9kVnOBIn3cPxBN?=
 =?us-ascii?Q?cyxC2CPtZistvh/bp/Qk0VdY6MVjshc/8gkxddASC6ciW8xHPKEPbNbFPn2o?=
 =?us-ascii?Q?tAilR4oxgZUY8cjTxwWajTAD27UePm+hkEUR1Daa6KfjGolMwDdjcwFWEUIT?=
 =?us-ascii?Q?/Uj/TIrgJ2u+we0APlLt0E/QuWlAsmdrhB42bSmrlq76A/gFD3EOBVdqAp11?=
 =?us-ascii?Q?bgBPl9SmLfzgM/nhvnsN5Nf3ZItb5QmBUF7Br2eihNsydSdEM+B2E4r5PzZk?=
 =?us-ascii?Q?tdyG7ik9NlfvGNyg4Jbiy2c8FljsFJxhM+0BD2H2OeLSDu3fmYk/rslX9H80?=
 =?us-ascii?Q?/IicznGgI4BplF49z5EzJ5B/sQ4iCHP/Pu2E0uZ458TpG3ZkAH82dQePgS0q?=
 =?us-ascii?Q?7iZoCh7sPj7zrj5Qke2B7JIgE0+fQoO9qUnz7CJryrqMnhQhY4/JNNpfKOb7?=
 =?us-ascii?Q?/cm6icdZ37bkK1YUOK+1DOt3FQ8AkuKPxgVUFnGbLHMcewQRdq1/EpGugu0S?=
 =?us-ascii?Q?VNtLsr3q78kActBIkUiIQu+vULKMhwbdkHaqOf6GVAF1v/K0gWX7CyR1IUqW?=
 =?us-ascii?Q?KxnDsYwhUJy3DLYeY1Np/q2wx1MZ3kIVN57akKfaxGQS6E8NMbGSOSxWkEKJ?=
 =?us-ascii?Q?NzZ4jLeZaHPrgLRdEmDjr1Kre0kc4SC/lURVX1lGe/8Y+Ml+t+/jTH9A/ARw?=
 =?us-ascii?Q?PldJ7e48khV2awb5vXwnzSc3CeXPIlPal4x4XHTLoAJFpkhLPRsbn11mtq/0?=
 =?us-ascii?Q?uFR4vYEICkxX3zZdGreYf2ODhckGvCwHkhDN?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NBuO/0s/qe/sez4MGqnmpJCpIeGXGmv1Nwo3vpiMlgRl3L6YuhJW0eigthAgU2qXGqP0D3NDudibcXQ7AXkUyx5Q6FdI4Zayk8Ot5csIyKXMHOJ8rAo3mKCjWEtTFYyMPvcQMZMg2DsTnB+bg/iBRPf8pWKOpawtK6BI/t+ziabcsNHvb3G6fL4Cpz3j2wADg5N979B7KijQHFlS3dXG9XyVTkYcAbPYM7+rJQLM3R7tVrMXE0+dd9tV2m3KMteRIIc+JFBUS1Asn95ONQU6FY2yFhdC/HEBPrd2FTLjgxrLLeWKoSwzJ1ivhFvWUdNnSMEcm+Mu5WJYzGtiod+Wen7p8OMZKl6Wh6UPwaKwUmI8LEF7bUXhmH0cOv+21mog0AKraO37Dvq+Vmvzgn2sdh0qEpWgI4uO3ZDy+AnxZ319Cya0ClCa+t2cPOrqqk2yV5TTX09S0zEkD/R6OP8ItXAA/7LQ1gM/Fj8SS/Q/iBGaXXJrUrguUoD6kJDpwllPAjKOr7rJpMHTeJiScDx2hUebL8/JtcwSwa+VugXnOMk1E1VbCrDAagvvCKB5Mg+tvo7kIIVkm8KS1+cSh9vuFT5PcxJYj3/7z54aT1BqMfTYFCsAbb6RSVKcwzDfF+AvoATTOKngFlMupgDz+ZvhXA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:29.1555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d234ec84-e5fa-4896-8a98-08dd8ba45631
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1139
X-BESS-ID: 1746429210-304287-9867-4797-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYGxiZAVgZQMDnNItEkNdHA0N
 DELDE52cQ0JSXR0tDMIs0o1dTYxNxEqTYWAIkbugBBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan18-156.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Calling memset before free() has no effect and will be flagged
by security parsing tools as a potential bug. None of these data
structures have sensitive information.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/core/nthw_hif.c         | 5 +----
 drivers/net/ntnic/nthw/core/nthw_iic.c         | 5 +----
 drivers/net/ntnic/nthw/core/nthw_pcie3.c       | 5 +----
 drivers/net/ntnic/nthw/core/nthw_rpf.c         | 5 +----
 drivers/net/ntnic/nthw/core/nthw_sdc.c         | 5 +----
 drivers/net/ntnic/nthw/core/nthw_si5340.c      | 5 +----
 drivers/net/ntnic/nthw/model/nthw_fpga_model.c | 1 -
 7 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index ddb875f625..f2d6f372b0 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -23,10 +23,7 @@ nthw_hif_t *nthw_hif_new(void)
 
 void nthw_hif_delete(nthw_hif_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_hif_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_hif_init(nthw_hif_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_iic.c b/drivers/net/ntnic/nthw/core/nthw_iic.c
index f84eb7eeb2..a96d878f25 100644
--- a/drivers/net/ntnic/nthw/core/nthw_iic.c
+++ b/drivers/net/ntnic/nthw/core/nthw_iic.c
@@ -253,10 +253,7 @@ int nthw_iic_init(nthw_iic_t *p, nthw_fpga_t *p_fpga, int n_iic_instance,
 
 void nthw_iic_delete(nthw_iic_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_iic_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_iic_set_retry_params(nthw_iic_t *p, const int n_poll_delay, const int n_bus_ready_retry,
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcie3.c b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
index 5928f81629..bad1c31e35 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcie3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
@@ -24,10 +24,7 @@ nthw_pcie3_t *nthw_pcie3_new(void)
 
 void nthw_pcie3_delete(nthw_pcie3_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_pcie3_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_pcie3_init(nthw_pcie3_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_rpf.c b/drivers/net/ntnic/nthw/core/nthw_rpf.c
index 1ed4d7b4e0..d5c19e312b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_rpf.c
+++ b/drivers/net/ntnic/nthw/core/nthw_rpf.c
@@ -22,10 +22,7 @@ nthw_rpf_t *nthw_rpf_new(void)
 
 void nthw_rpf_delete(nthw_rpf_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_rpf_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_rpf_init(nthw_rpf_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_sdc.c b/drivers/net/ntnic/nthw/core/nthw_sdc.c
index ae967e5ed9..a7242a8a67 100644
--- a/drivers/net/ntnic/nthw/core/nthw_sdc.c
+++ b/drivers/net/ntnic/nthw/core/nthw_sdc.c
@@ -22,10 +22,7 @@ nthw_sdc_t *nthw_sdc_new(void)
 
 void nthw_sdc_delete(nthw_sdc_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_sdc_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_sdc_init(nthw_sdc_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5340.c b/drivers/net/ntnic/nthw/core/nthw_si5340.c
index 05cadc0bf4..ceaa58e0f7 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5340.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5340.c
@@ -44,10 +44,7 @@ int nthw_si5340_init(nthw_si5340_t *p, nthw_iic_t *p_nthw_iic, uint8_t n_iic_add
 
 void nthw_si5340_delete(nthw_si5340_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_si5340_t));
-		free(p);
-	}
+	free(p);
 }
 
 /*
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index fbaf0c2d6d..0838527716 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -183,7 +183,6 @@ nthw_fpga_mgr_t *nthw_fpga_mgr_new(void)
 
 void nthw_fpga_mgr_delete(nthw_fpga_mgr_t *p)
 {
-	memset(p, 0, sizeof(nthw_fpga_mgr_t));
 	free(p);
 }
 
-- 
2.47.1

