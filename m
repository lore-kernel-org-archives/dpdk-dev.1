Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF20C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:52:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C60440DDE;
	Wed, 30 Apr 2025 15:49:43 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id D6B9A40671
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:29 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2234.outbound.protection.outlook.com [104.47.51.234]) by
 mx-outbound8-212.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky1wY/jEZp2+Y3v3drNl1PD9TFZXehMU07CDpsk5grIZzpJE9o+u7NxnuSvVfz+LQMPOI07O8pr0PXEcYuRJ4hjr0rWH8Pu+WWDwbPgS/TFVb988M+kpqJHqwGSmrj3Jt9veiZipbiACfaozDuBr07Eo3lmO99yGkWJ32zVwKop3xo35qv/SlHzev9OG3GaGOw6YFZcCxlXCoT4LdrbZTxnTIoK2LZ1piHCvUgk/XcWX9/0jT8FB6M++bBk8gODqgtb3XYeRuvW4BFbSB01kukFIIpPP8jkHc+S4tpnroxM08spdty8oUKdnS0CgipeSOIXznUIt/S6Q70IWrzlsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfgpUhKD8qDVEOs+kMqyGBGu+2DtQWu4sBWkp+8O7uk=;
 b=CXBoAjaSkNKSoimapJ+JJuXmYOidLLMHXfi8VMZzsvAgKHx0ytFOtud5/7sCyOEfToVduDocq0RATrZAJPvWVGrxFRpntK/VYsLxVMC+dbG23G0GR04KW4rrduKrM9xn4krKUG4O7okhKrGds8qqYo+VWPUhG63MwKp6mFG3dBNVLDni6K/Uz0jMSYFXWXCYiz/nu7LdBsiA1sxRAitJbVF+tyT5aMh6OCwrlOwF1iTF7dg0jZKvwxwKolfGMu7V9ziYwTDUgtZJQ+7KEKtInC5jr9W51QV8anxy+W2ATa7QILDfmMn0a9EKWiO2iBQAjsrjt7zKdZoskVkFdjNJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfgpUhKD8qDVEOs+kMqyGBGu+2DtQWu4sBWkp+8O7uk=;
 b=iGwUr8ubKh+2gZQ2b0mDJWcW2kICAca+1mvhSzmneUZ1zkKwLOCYr1y+x2AN/Q+9GFL1WBo2b0wjTS7kesR7J6soHxKRRHY5kFeQ54PP1Rbfve+JmTLyPP9xn+MbfyJdFbAF9n4tbwZuVNRx9J2A33QVVrsnRRvzhnuwdacYZyo=
Received: from AM9P193CA0008.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::13)
 by GV1P190MB2193.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:49:22 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::fd) by AM9P193CA0008.outlook.office365.com
 (2603:10a6:20b:21e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:21 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 21/25] net/ntnic: remove unnecessary void cast
Date: Wed, 30 Apr 2025 15:48:33 +0200
Message-ID: <20250430134840.402553-22-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|GV1P190MB2193:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 766555af-0e7c-4627-ccf8-08dd87edcf9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7PBvOLdvVVAr/G75qU9S87TmxWHTd7za+71klNmVN9tHxT6pN+EJ6GAdKusX?=
 =?us-ascii?Q?XrwmdW6AKDchUgrD2/smRrU2yC4IEHCPnt2REzEZ5eX48k3PW5N17fnv8Io1?=
 =?us-ascii?Q?KjCNA1Jk4hrqo9SNtgq3AX8bmocoW+ZxtaXKGL83olOpHoh+m25lf44DK/fe?=
 =?us-ascii?Q?LrM8Cj3Gy53fD6VjQ+DsTqewcTg+mweEoF0kW6lDF3tAEXD1EGURpW3irHE3?=
 =?us-ascii?Q?vO+fiSIfXO3feBqEX5Y7Rn4IyupK6hM0YdNqodNGxF8n/5EVvR45YxDb6BUK?=
 =?us-ascii?Q?aBCkBgFYRRZSBAyLmHQSt0pDYj3fl1ggDRR980mhruVGi2szgjZjEVoAD5Kd?=
 =?us-ascii?Q?/dv5u/X+s0P+x5tpObeIXe/9w99nhBu4eq+6Cq+dTkN82kute/36acG/8GoG?=
 =?us-ascii?Q?Tv6cbtlb7tV7aERagHFkC/lAhjlO5yCQI+wbwIesS2VfWb80WI5K00tv+Xv9?=
 =?us-ascii?Q?F4g++QXAScJ4y9FSfog26HVyOjwsOuPzvv9+g5Y0IbN5xnnMWSjZBkRf42b+?=
 =?us-ascii?Q?Vyu47rKOxnnFKASGY45GLpNLyLP/fzELPUquMu1E4Y0Waib43DRne83IdEJI?=
 =?us-ascii?Q?+N3XachW8ZgwD7g4ZkMUBr9LpEH7oim8GrhJkFK1PyuspRrrbhi5/YQJ4JJA?=
 =?us-ascii?Q?lDCIzloapx00i/o/thutff2fjhrvvu2mqQXQ/wTjz9j3HSOiaBh4ipUkk4rc?=
 =?us-ascii?Q?LkOZ1Vlzo4lr1YP0+i+Pqw7r7uJy2w+UDQ/O72j1DqA+0GsXo+BsWh7w2wQm?=
 =?us-ascii?Q?BwUyERWGVsGgF8lxLs+KupCwSjsR1Rhzgj7u9qBOVGwKaAKa6qkXuaSYZYuB?=
 =?us-ascii?Q?b8pKjZNNLzYDbEAHwqHP+3vQsoACz3AZHKA5quTBi1Gyrfib1NvUA4H/X7oV?=
 =?us-ascii?Q?KxJediKtHRX58Nxmz5+LerHYBxBNC0ixSOeBkNH5qwDSbaxxYM1jrCoWWvQ7?=
 =?us-ascii?Q?UGtaMoGAIQjc44MIEQP6mD2HtPFo+JCSaq1AIliK2S91m5ATvdSRPi511+0/?=
 =?us-ascii?Q?L5L509+oQl9UYdqDRmGzZX+Rqnjf2SRAQ8jCZSPt6dfKpX3j2rKH/r90K0rp?=
 =?us-ascii?Q?nvbNWM6WMK8xKrB8VZ/P5ofAltvJhkorHhSpmvaDCPdl5t0AO+DRqMm90GqF?=
 =?us-ascii?Q?/ycQp+33pNISY7zCP1Laq21u1N7y1SwOh3AP74AP7nNzfFv/XXxQYt0LnBPn?=
 =?us-ascii?Q?iSiiHOTTSjKQQUYpxpQwDG2I8syt0H3veWsqKSVRPvH+9mvGjvQmwa5OiQ4Y?=
 =?us-ascii?Q?ZM/NWwJvZa5+4vm7RzfKNone7orgKpd1tBptvnkLvwc52uLH8HSdYA3ZDCtN?=
 =?us-ascii?Q?5QSyWEbAAwXqs0lpt0B9AIG4CYNuBXNqB3JoqIfIT258fs9gR5NbFzK/gp/0?=
 =?us-ascii?Q?NocJBmVW/H0WusGK4T1u7U1kY++Q6g7JVR7ylxH9tiTnLdt4Xq6oUTF69Jr/?=
 =?us-ascii?Q?i3Hgw9kPKT2c5WbSk6TBvrD8OB6Z5/PjIGF3BxOvi8t38b36a7UilmyD9v/I?=
 =?us-ascii?Q?3W9J/Dup2ngO9HArm71qmS7tLEkPvS3Erfp8?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: skze0cYu/uG7Qd51p3oLBMMp9lrAuIKNgWDrRagvO5vt4CDIzTN7m502EIAPPBqSz9+1fsJRMcWKfaonAtw4BIuJLcb2ok3NGlWMaChgBUXyGWNYvHzbfUGZ3b4iLa2X1eVjpxDAzFXXDeTLk968x4zu2H0NjcfoUYaUyKCmzqTNMnTQjqbm2v1vm4t77o6pD3TShSEWNazrKuh2aCk5ECRZVNyTx7QU4y37LhUSpuAq6IjxMtHawIkz2t+KChCUB+vLCLDx0Cl/KUVuA/0H8RRZpDecRP2klGMybcoyfUaNIfzsRPiBU++yMRC5SFAv507FKL4MgIlsI5yTwbrhtZqaqrgxdUPF2rEyMwdN4JM5o+qiGUUY0sErX2dNnEGCfRkWZyEvXqRUQrRu3qkd73ZVbg1vIPuj4t1mb99y0npXGOMgDxKveQxRQKje1V8ZMzENcaTv2THU7uVP0oWmV0Tr9OtiAq5ACRPb81qBSXJggPMmRbovUExcrxCk5axx4W2gDYKjwXnGkGPlbMBrzxdId1ioc7avRETs9edZ+nNHX471g6G9ieJC/IlObZwy5HVjf1v4MowbsSZk0dWBMGZhApq2kOip2HIxFFvy345GOd/TrYETgFNQ1omivZS7aTwAwS/uJp5BRsWPdncueQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:21.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766555af-0e7c-4627-ccf8-08dd87edcf9c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB2193
X-BESS-ID: 1746020966-302260-7739-9121-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.234
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGhsZmQGYGUNQixdQ4Jc3EMt
 E0xTjRMNkkKS3JxNLc0MLEMM0kycTYRKk2FgAgmjIaQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan19-232.eu-central-1b.ess.aws.cudaops.com]
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
index e46e93e347..d15e1fd13b 100644
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

