Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA9C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B53DB406B8;
	Mon,  5 May 2025 09:13:38 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9BA614069F
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:37 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2112.outbound.protection.outlook.com [104.47.11.112]) by
 mx-outbound18-65.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oor27XBunh78HOLqr2k3fri6i520MeQoTlLbOn4/8kcZZmdH00CxQUTQnc4lPLGnLU8qS5BQ+9B6nspUPU2G6AydirAWnU6NMHGh/PuJNAVGgbOnUpaphshbV7izyegsHU3nSbs24QIy04G28mLruB4I5FmgcwwrJffR3UU1rdLzI2ccKQI4+DSrSxFPlYxoJsslTNK1jZKem3Ut7j3ctiwOZDzaGXCaINGO9G5WpvKha0incEcQNZRM4NfVtMwVQ1cceVFxxbGjzo7ENoMPLwlSMCZpMeLS0w0KJf4fcjWBPExmdh9fKv1dzW9IdQOXCRwktsuZQHniDxpo8oJr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRFwW56uHXui7Nk2WwYlKLZ4T5icEtbSOmuwikrfuvQ=;
 b=rRMxlxw4pu+3zeklK861KeQbsKhQ8HQh3STxpYEz2kLWO8lnM0GmLLgY7jTRZ+/v5adQT/LascQPUy+mIs6jtQM7hXf4goj/QoVGzgb2tbVDn7q9bxqDnUHRI8veXxJopeG5Zviq+yJ9FdYHkDQLOZaBjtoIVXDfmwWyvFT462svya8cp4CdlkRM1bSxQCuTxQIHH/2sRWYLUzcpMEyF4rBoZatIYMwkaSGI5i3iPCYIXQnnwz40NUl93W9pUm/6jypfdmam8HSPd4bGyg8Lv4RJwDW1Lm1GaYgbp993oOg80f3FWNHZBsyDHUO6nvOZFW8mDw+oC3RtJC1LTVwpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRFwW56uHXui7Nk2WwYlKLZ4T5icEtbSOmuwikrfuvQ=;
 b=UMnU5VMxFV40/k4WuZozeoFeTupZVrcnWINtRUA2jkdAd1tlEzErW0RkPYxvwRbO8FKN9hkHCCurAv4h3een+6Qpenu70L2mi6ON1vs58xbQQorehAChT80oFDSGATjzthJ4MsioMW4COrdOh+N7KVUfbFRqtwus27TFhVetRK8=
Received: from DUZPR01CA0318.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::7) by AM9P190MB1250.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:272::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:28 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::f4) by DUZPR01CA0318.outlook.office365.com
 (2603:10a6:10:4ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:27
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 22/26] net/ntnic: remove unnecessary void cast
Date: Mon,  5 May 2025 09:13:02 +0200
Message-ID: <20250505071309.586015-23-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AM9P190MB1250:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2aae1950-3e98-4ac0-1f96-08dd8ba45557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MGrHueCBbFMgUYObfMisCzKqntv7SyAloGpbt9KTpsR+FQDLXFvCoMVQqg/+?=
 =?us-ascii?Q?1uK6NqtJ2tN/56HbedZbRlCzq8Jo9GxSYV/JrKhLeH2wTPrCKFS0wckqG9vH?=
 =?us-ascii?Q?AsJauMDC3MJN0xt/SVNX0fFkpmB1VnUV4qBUiGTrujRgCsmcQay/uCrpsBjq?=
 =?us-ascii?Q?g4TGtBFL+Jsz90WaksdDgighOo4SbpzG+Mr/SkfedzCBXrkMY8h22AyXEnNX?=
 =?us-ascii?Q?BGWr3OHkLzmYGfK72eKA3cP9NKmhzDbPHEo5dZbixtd+mqGYVktUMYt+2bzr?=
 =?us-ascii?Q?D8C9DcTNE137NIMNV9dW7zfMVpctjh2qyaMD4LMHKv6vwpoZhLI78wKmjFmq?=
 =?us-ascii?Q?InMMb7ukZrqMMBtDkxSfqXdObrWT/53H4ul1pkVf2n0axefFqewM2MGZ0cR+?=
 =?us-ascii?Q?tc7nNQFRexM+QzX/2mQS/2X/0D/AnFY9qiZXzg3zmtok067el8C/g6TBXHJI?=
 =?us-ascii?Q?FHJKXZpqUPvnVAuDBrfFz2v9voGbFWdo65kOFSEbDb4p1AAYw0vTmNZUSoWX?=
 =?us-ascii?Q?QlRyF/a5rOa3TUChztEmv/A67Y3+ZuRQmIhfHB0a4dj4LBLfu4j7E5dLTmLF?=
 =?us-ascii?Q?xHqRBlxqlD4YOdiw/5reD9tKBuPekuYubyOqsRrCt8/NLAcFiZVqOQ1EaxCh?=
 =?us-ascii?Q?LOOZu5aJtGG/JazoAJ/QlBTxxPJf5mywvpHcUUytD2b0ICh6fjUWo4Qx/L/K?=
 =?us-ascii?Q?NYctLxnAcGUh1kM0kT4RKopeCjAAxUhCa5k6oiMEYqCr0TuY0HkzLev26ftz?=
 =?us-ascii?Q?pDtZ/GT/gZxyzRDCSXsqBS+RRxHq6U0dynWMnjUiPI65YyeXYmScRKxdCaP6?=
 =?us-ascii?Q?uRaIuAk+LkYK2O0/qoAq/p7hjphNix9KqRF5GA7SHKgg4AsuhQ2lMNvB45IK?=
 =?us-ascii?Q?DoCl0ryCD6iTLzCAfF0ioebFuLpL64t7LwR8vUA1QQaVFG87LRA4kxeB22S9?=
 =?us-ascii?Q?BRTTH/s6wJ40Jxu4uAu44/mBs8L5kGeouiFqv1lhy13ZCIcissnycxzAyj/s?=
 =?us-ascii?Q?mJYMcDgfE008QHreDwgyMUqSOrMwv6Tpou48ONb68CeADdoWvgRE+aDEAjlP?=
 =?us-ascii?Q?0QLoNkZ9Ciplxt0nZT7xdY4pEhd5WJUE+pK1TCNmBuuOLZFD012B7aml8Z53?=
 =?us-ascii?Q?4Vfr5prPwVsXQkMcQltJInedqwRdxk3VW3Mx2pi1xdN6dmkPdfRG6oh0wOgf?=
 =?us-ascii?Q?TXY1GVVBWCKKaM3vp5tirD4WsO5b25VvcO+AnCIepPOJo8Da1//RVtoXQCjV?=
 =?us-ascii?Q?19+xYgKtB+xkrb9GI9NYbTW8EdLm3TlKj+wzkjpl5RgXv3hdqKf+RD9Eaoqg?=
 =?us-ascii?Q?9wgilogzUZpdvauVd6AjU6D62d39oxsTFnIDegt+pnAM5hmoa/8/tXFZ19p9?=
 =?us-ascii?Q?eOSqD9aMWWUxGq+9Xm1n8zWWuCDCRhUdPlVbO85SJRemdnxsgI9jC5DaUyc7?=
 =?us-ascii?Q?Y/ouSMta6GJditwHW5/lN/Po2WYbV44H8oYSHywNLmpuYKFiOiVTDeqIV+Nd?=
 =?us-ascii?Q?eSWdUhrz7MFtW2vLue3d/6vVGzn2gvhJ2wXv?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sGODIJcbVPd0EQe09VnxuSqvGfRhEgDvxh1z/5kfKbAQQ7jWPQzljC5JXhuWvNVIr6kiTEIQ8pWGEvT17i9B90KjWMCnap/RNE+4xVrCTZlW5X3CDqMUGJ1DvHtbUl22aoLxIyYcJF9RIjw0WXgLfajw7l1Krjk2w0vE1Y9qQIz6W+zrcK68nhVTiwfbXIJA+H7JZTXGldJ7dNU8sObAj7KcrI2Xts7d0+gq21OAOkhsyJ/NCvKHBe4l3QsZry+A/bYr/dKc6al5eKxmaRVZXzRS/oKxrud1jroccC9kbdjGzPwVdVTAlaeVyLJ+vnidv514PZ6E4z3XEGe+U2Naun3qpqU+awoAqd8hXKfMTHGjCSPunnihmMKIGwfOQjUqloQRe2w7efmAT/Y3pv066cgzkcQbJmwQfp6khdce8pg0xS7oSiVKK5/aw68zMD8s2t1MkfOylGIRGXub/IJikDW+Gi7ck9MnNo7g7NapfXNy/gpYbCs908zTPRmc7WC58uf2Y7V0KoQZ47Mcao+0Yw8C64Vxoct3CsQCVhFjdFy0HkbkO8gais/B3f0yCaCKqPI7AAIzi9/Am5CSSoDZAwFVDrSg6M2PbHMJhTknXy2XKcyTDsdKCAsyirff61GG1Rtf4+TndypGNuv/Nqc32g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:27.7241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aae1950-3e98-4ac0-1f96-08dd8ba45557
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1250
X-BESS-ID: 1746429210-304673-7668-382-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGhsZmQGYGUDQ52STRKDXJMi
 XR0iQpMcU0ydIsNS3VMMk4zczMxMIoSak2FgAC5t0oQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan22-193.eu-central-1b.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

There is no need to cast memset to void.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nim/i2c_nim.c                       | 2 +-
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c    | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c    | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c    | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c    | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c    | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c    | 2 +-
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c   | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c     | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c    | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c    | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c | 4 ++--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c | 4 ++--
 drivers/net/ntnic/ntnic_ethdev.c                      | 2 +-
 17 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index c6fa75e13a..66729e3ab4 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -304,7 +304,7 @@ static int qsfp_nim_state_build(nim_i2c_ctx_t *ctx, sfp_nim_state_t *state)
 	RTE_ASSERT(ctx && state);
 	RTE_ASSERT(ctx->nim_id != NT_NIM_UNKNOWN && "Nim is not initialized");
 
-	(void)memset(state, 0, sizeof(*state));
+	memset(state, 0, sizeof(*state));
 
 	switch (ctx->nim_id) {
 	case 12U:
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
index 23139b0305..d60dae6912 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
@@ -18,7 +18,7 @@ struct cat_nthw *cat_nthw_new(void)
 	struct cat_nthw *p = malloc(sizeof(struct cat_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -26,7 +26,7 @@ struct cat_nthw *cat_nthw_new(void)
 void cat_nthw_delete(struct cat_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
index 945d46415c..4ad169b943 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
@@ -22,7 +22,7 @@ struct csu_nthw *csu_nthw_new(void)
 	struct csu_nthw *p = malloc(sizeof(struct csu_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -30,7 +30,7 @@ struct csu_nthw *csu_nthw_new(void)
 void csu_nthw_delete(struct csu_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
index a56d3c5038..372f735c2b 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
@@ -20,7 +20,7 @@ struct flm_nthw *flm_nthw_new(void)
 	struct flm_nthw *p = malloc(sizeof(struct flm_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -28,7 +28,7 @@ struct flm_nthw *flm_nthw_new(void)
 void flm_nthw_delete(struct flm_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
index 2559f2ec77..14ad74396f 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
@@ -22,7 +22,7 @@ struct hfu_nthw *hfu_nthw_new(void)
 	struct hfu_nthw *p = malloc(sizeof(struct hfu_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -30,7 +30,7 @@ struct hfu_nthw *hfu_nthw_new(void)
 void hfu_nthw_delete(struct hfu_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
index ab9c793e3a..f8cfa94a15 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
@@ -23,7 +23,7 @@ struct hsh_nthw *hsh_nthw_new(void)
 	struct hsh_nthw *p = malloc(sizeof(struct hsh_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -31,7 +31,7 @@ struct hsh_nthw *hsh_nthw_new(void)
 void hsh_nthw_delete(struct hsh_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
index 418dd41a53..78835654dc 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
@@ -22,7 +22,7 @@ struct ifr_nthw *ifr_nthw_new(void)
 	struct ifr_nthw *p = malloc(sizeof(struct ifr_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
index 2db4411c9e..f945f33fff 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
@@ -23,7 +23,7 @@ struct info_nthw *info_nthw_new(void)
 	struct info_nthw *p = malloc(sizeof(struct info_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -31,7 +31,7 @@ struct info_nthw *info_nthw_new(void)
 void info_nthw_delete(struct info_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
index 57471ef430..10450b3600 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
@@ -32,7 +32,7 @@ struct km_nthw *km_nthw_new(void)
 	struct km_nthw *p = malloc(sizeof(struct km_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -40,7 +40,7 @@ struct km_nthw *km_nthw_new(void)
 void km_nthw_delete(struct km_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
index 80dc8c14c4..132ee14baf 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
@@ -23,7 +23,7 @@ struct pdb_nthw *pdb_nthw_new(void)
 	struct pdb_nthw *p = malloc(sizeof(struct pdb_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -31,7 +31,7 @@ struct pdb_nthw *pdb_nthw_new(void)
 void pdb_nthw_delete(struct pdb_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
index cf4dc2c8eb..d2c7130f2e 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
@@ -23,7 +23,7 @@ struct qsl_nthw *qsl_nthw_new(void)
 	struct qsl_nthw *p = malloc(sizeof(struct qsl_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -31,7 +31,7 @@ struct qsl_nthw *qsl_nthw_new(void)
 void qsl_nthw_delete(struct qsl_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
index 99245bddaf..1bb69e740f 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
@@ -22,7 +22,7 @@ struct rpp_lr_nthw *rpp_lr_nthw_new(void)
 	struct rpp_lr_nthw *p = malloc(sizeof(struct rpp_lr_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -30,7 +30,7 @@ struct rpp_lr_nthw *rpp_lr_nthw_new(void)
 void rpp_lr_nthw_delete(struct rpp_lr_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
index 78cee7ebea..f5030d1997 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
@@ -23,7 +23,7 @@ struct slc_lr_nthw *slc_lr_nthw_new(void)
 	struct slc_lr_nthw *p = malloc(sizeof(struct slc_lr_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -31,7 +31,7 @@ struct slc_lr_nthw *slc_lr_nthw_new(void)
 void slc_lr_nthw_delete(struct slc_lr_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
index 0ecdeb8893..bb7b9c2946 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
@@ -22,7 +22,7 @@ struct tx_cpy_nthw *tx_cpy_nthw_new(void)
 	struct tx_cpy_nthw *p = malloc(sizeof(struct tx_cpy_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -31,7 +31,7 @@ void tx_cpy_nthw_delete(struct tx_cpy_nthw *p)
 {
 	if (p) {
 		free(p->m_writers);
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
index 3ac44c6743..2409875a5a 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
@@ -22,7 +22,7 @@ struct tx_ins_nthw *tx_ins_nthw_new(void)
 	struct tx_ins_nthw *p = malloc(sizeof(struct tx_ins_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -30,7 +30,7 @@ struct tx_ins_nthw *tx_ins_nthw_new(void)
 void tx_ins_nthw_delete(struct tx_ins_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
index 9dfcaa99c7..b787c38ee2 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
@@ -22,7 +22,7 @@ struct tx_rpl_nthw *tx_rpl_nthw_new(void)
 	struct tx_rpl_nthw *p = malloc(sizeof(struct tx_rpl_nthw));
 
 	if (p)
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 
 	return p;
 }
@@ -30,7 +30,7 @@ struct tx_rpl_nthw *tx_rpl_nthw_new(void)
 void tx_rpl_nthw_delete(struct tx_rpl_nthw *p)
 {
 	if (p) {
-		(void)memset(p, 0, sizeof(*p));
+		memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index fa43067adf..c2a507675c 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1256,7 +1256,7 @@ eth_set_mc_addr_list(struct rte_eth_dev *eth_dev,
 			mc_addrs[i] = mc_addr_set[i];
 
 		else
-			(void)memset(&mc_addrs[i], 0, sizeof(mc_addrs[i]));
+			memset(&mc_addrs[i], 0, sizeof(mc_addrs[i]));
 
 	return 0;
 }
-- 
2.47.1

