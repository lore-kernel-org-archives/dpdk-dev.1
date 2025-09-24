Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E27CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CB6140E54;
	Wed, 24 Sep 2025 16:42:43 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 98E4040E12
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:23 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021094.outbound.protection.outlook.com
 [40.107.130.94]) by mx-outbound13-221.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh3CniS8v9qSp0Jkw2q3Jov8Wy9DRvaDTMKn5LtSDiNgr0nv1Z5qVTtAPQb6EZOzeDZR+SvCTWPvNLPONz/xkbnell+VoEXSqj35yaO8VPXwyFR7zYb68ubgXvikVkFbLz0Qi3nCPqZCH5N3f+Fji9ls7QiB90oz8OJtord+1kCWV4XYnJTgdkf9WB2urJXFEXX/VDibn7SsONq3HzlKqf3axzkzZ66gCbKdOykNbbuasqNubYMvsvYgTh8YIFMMVsweAcU9ulmqGxMNCBeJfjBhzsZDL48hqOiTqMU/KUKIlIGeLQJgEIskXbFogGWIWXHc4Olq2KIajPCjz9kr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG6nrA0fTTGO4HSi8slnnK96QycA6aMsgtLawg9IKas=;
 b=tUxYL++bgL0P2CzcEtAW8BGSOtyKjKxM9nL3WNBjDxljmoeDIDN/EYvwpgFtqDCTpFDMc3f87ZLZP7Mjjol2U52M7EDa9kqP9C0KObiigpGk22lYCWmTVBs701c2g15z6VqZr01bHADKrUaHdWKSepgsUzq6zWThwxdkP6jIhNBu+cFuWWxjOem5siNNozYpY7iODtaXOkFZL227HcK7u+lJgsr8MdTmkxLFyB7kat+hVdCUemywCQBkZFbXBP9b4ZTqfXbfT7spYFAA6sd1bUdwAO63BmJt9BV+0gxGv+UcdKJ0TC+TVWaTbZh/xfaVBy6rHXrg498QEl4VGCE0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG6nrA0fTTGO4HSi8slnnK96QycA6aMsgtLawg9IKas=;
 b=Fbtz+AG3ns+CnDD+YQlpVGNZ/rtoLCXs//moT793gyyX48EYGCCYTklUM4t1v/5mh8NhPWkx3crJZAeV8eN+y7lzXRVruwm7gys99uVec79uhy/3zrGCntqVHJJ4wTRTOt/+7nC8lXC4KZxo0o0VJdvdHNspNVRW7yOTZo2V1co=
Received: from CWLP123CA0237.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::7)
 by DB8P190MB0587.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:122::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:42:08 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::e8) by CWLP123CA0237.outlook.office365.com
 (2603:10a6:400:19f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:08
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 12/24] net/ntnic: change prefix hw to prefix nthw
Date: Wed, 24 Sep 2025 16:41:35 +0200
Message-ID: <20250924144152.53203-13-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DB8P190MB0587:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4c48ee16-be74-4db6-d029-08ddfb7889d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EVuI3zWCG6v0HSVnEx9pWxmI8/joat0gcHnBjyo19VA9ZMKuWyARPl1p363p?=
 =?us-ascii?Q?HusDovlq66MRhYfpFihWhc/uE+gasZoNX6j3ru8yH4nhnnt7tTl1drDC+GSA?=
 =?us-ascii?Q?ZZ6SFiGQWm5MTPWOKUBX2pZ6vNWP9fsn/WvGHB3wO4FOV93vPzlJuUsBJvYr?=
 =?us-ascii?Q?IyM6y78AcjmV7gLZBWK7SD5nrrQmcuzfOfINd/1dph09dJIU4xsL90MjYKQK?=
 =?us-ascii?Q?5Y1tLp+J0irJsz7jQh7djz1fMWz6KDPszljBu4MOhkdTejUSXtyHrpSwSs/O?=
 =?us-ascii?Q?DP4V7s9zLOiNKuEMth8mk1VBS4NOEIPzmhsQ3vqH524X5cJqAj9MUzSQXdw+?=
 =?us-ascii?Q?vcLZfbSC0aDD207FKKPxjLHvhnClLVUCysw0P3YlVA/S6G+GWciswVJupdhz?=
 =?us-ascii?Q?7EjRj1bXxq1+KFOw3H2vsqNDi/b0vjaNm0bWvu8jZppGHPBI+An3IgbxzTG7?=
 =?us-ascii?Q?aKfaXfkIIqy7m1arJsriKdZXrm3nUtmDOb7YrdOH5yqqWnhXm3DEWJdD/Zpi?=
 =?us-ascii?Q?vuDVku3m6OvQyYeV+dEwUBcsxUt0mP8st9KYQOOGwYvFb63SxtH9hYyu+0ZP?=
 =?us-ascii?Q?mCot3diuSGZ++KjhtYo2RJreKESrydsWLRtwvja0iCGbe5047wNWXWjssili?=
 =?us-ascii?Q?GQ0w2fi7aOZv6m8tapDqmPwUabdPWk6sIwJ8E8YszWX/kGfxzfwPUt/iIPBg?=
 =?us-ascii?Q?2pe77K+yYaq0yKUn1oIqytfJJmqVqrXsbpyO2XVVWF32YVUERlaX5Y8S6NPo?=
 =?us-ascii?Q?CDJDCLFnnsRl3hQIcgOwj6e6vfsG9Evq/E47UZC4fEp8DKvjkMmqRnmao+V0?=
 =?us-ascii?Q?Zh/KG5ssu8NcK1dRG+WAalpENlWclQdkwRYeNx8HvqyJ1atuePBiPYTwV132?=
 =?us-ascii?Q?zjEZLChfPh4Ff0ofDcYCiqpOn8tthQTHd5rJ69raRzJvO3EzeNhjMgK9cf9t?=
 =?us-ascii?Q?/tRqX7cb2BZAYjU1gqvf+DhZRTe8m908IXJsfPzY/rQyyxjfy5uAEqbndQt4?=
 =?us-ascii?Q?LQ0Uc2akpfgDtdsmXTQRnT7AWkSqMprsphfVOQ47zF5J0/OIVOHDlbLV1vsd?=
 =?us-ascii?Q?Yw/nkf6P/XAaAiqBlNYyhjpevWhyT5qjXwIHpjTlQ3QrLCQbgKQf65s6ZCxU?=
 =?us-ascii?Q?K+C4glQQlAgoHnDV+0cWsna1yoLQcDSs2LRwHeyBBsoPmD5u+uPBOlKE96WX?=
 =?us-ascii?Q?13nDyUtq4zFb8R/KsKvQtM/XJr35hJHJdCle2jjub7sbPitPyPZl0jZG963m?=
 =?us-ascii?Q?OhMfBuggb2w3SFbP7ELmAtHcIF1k6f7SIH0daLm56WKQeEsylyj7B6yscSxt?=
 =?us-ascii?Q?dUnO5KGSSiPADP4ngfQbv/HnRcSaK1MRtrQc3+mhFv2PlmGokrwKL/7QPDi+?=
 =?us-ascii?Q?5UkDOdBFRgug80aobbdPUU2XAusfsEqVNQCFrwHqWBW70HIfk6swOzX9Ni7j?=
 =?us-ascii?Q?Nyq5j0XrXJWX3FOpUwcRpojMEU/1Cpcl3CWo75WKqLcCJn+8II+Dyr27FX4J?=
 =?us-ascii?Q?P98GO79neNh8CLkBIHN5PYSj2Fqg1MMBRxqm?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9put1wb4NOK0nOnCrGPtJXtK2dEbxu59Hik9YbojvwfkePb0aokIbhlihVjKGAPnHwc9YZ1sDznUk6ILZcKQQ02rY8P3YMCw6x71HjT/4TZ5vqKOMqGHdNdLnN/t7xEszk9AkPbNt1tqlRN3zZ9Y3drGxlC9N3pANOlr8RgVpla/5OTka5rtb2FqnSqUuwRTXBYgIONHXd4X5fSO2Cr/U3YNk5LGrdM9MrWW1/x0tmNChnXha7glqwjZl5nP0kr0BVVHUPHvZusgGhA0Oauhypv91X1tacv3k/y9+PxaDTNLaKHdedAqrnUabG2by9ODXul5SdQGJabz7jzTYHSMcyAW3Iptz+cwkDtwCl6FMk6QqCrpwKah0p4Ry75lye7aMNfJW9ZO+Qpah8hi+LHFxKDNBQf/dA0Ix+m0lH4Q6VSIYLA289bAL3Ck/HZSgmux604MDQysLN+bdNyAlkiSPsmeUPqGP0NJVaDDh5DnEKtupKnK/8p3qm/i5gu3leUN8PbuNJ5H4qLko9ZR6QvrK/U5ymeKYxu+yIgqyc4xx5lf3G3TRJjMrp+UBYDekn6O3nshSA/AKnqH829q2mJOdmacF4MiRsSuClrzxbm0JSxBnSfrJidE3ymA3vtBaONlhZrZoWtXL9+uiToedphLiQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:08.2473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c48ee16-be74-4db6-d029-08ddfb7889d3
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0587
X-BESS-ID: 1758724931-303549-7635-8086-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.130.94
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGZmbmFkB2BlDY0NLCyMw80T
 LFPMXCyMIo1TgpNSXZIM3A2Dg1NS3VwFSpNhYAHg3RoUMAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan21-109.eu-central-1b.ess.aws.cudaops.com]
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

Change all prefix hw_ to prefix nthw_ to specify that this is Napatech
hardware module.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/hw_mod_backend.h    | 266 +++----
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  26 +-
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.c    |  38 +-
 drivers/net/ntnic/nthw/flow_api/flow_km.c     | 118 +--
 .../nthw/flow_api/hw_mod/hw_mod_backend.c     |  18 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c   | 140 ++--
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c   |  70 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c   |  14 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_km.c    |  40 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c   |  14 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c   |  32 +-
 .../nthw/flow_api/hw_mod/hw_mod_slc_lr.c      |  14 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c   |  74 +-
 .../profile_inline/flow_api_hw_db_inline.c    | 675 +++++++++---------
 .../profile_inline/flow_api_hw_db_inline.h    |  46 +-
 .../profile_inline/flow_api_profile_inline.c  | 291 ++++----
 drivers/net/ntnic/ntnic_ethdev.c              |   2 +-
 drivers/net/ntnic/ntnic_mod_reg.h             |   2 +-
 18 files changed, 948 insertions(+), 932 deletions(-)

diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index 455bc7236e..8d938084e9 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -353,66 +353,66 @@ enum hw_cat_e {
 	/* 64 */ HW_CAT_CFN_ERR_TNL_TTL_EXP,
 };
 
-bool hw_mod_cat_present(struct flow_api_backend_s *be);
-int hw_mod_cat_alloc(struct flow_api_backend_s *be);
-void hw_mod_cat_free(struct flow_api_backend_s *be);
-int hw_mod_cat_reset(struct flow_api_backend_s *be);
-int hw_mod_cat_cfn_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_cat_cfn_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index, int word_off,
-	uint32_t value);
+bool nthw_mod_cat_present(struct flow_api_backend_s *be);
+int nthw_mod_cat_alloc(struct flow_api_backend_s *be);
+void nthw_mod_cat_free(struct flow_api_backend_s *be);
+int nthw_mod_cat_reset(struct flow_api_backend_s *be);
+int nthw_mod_cat_cfn_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_cat_cfn_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+	int index, int word_off, uint32_t value);
 /* KCE/KCS/FTE KM */
-int hw_mod_cat_kce_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_kce_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count);
-int hw_mod_cat_kce_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kce_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value);
-int hw_mod_cat_kce_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kce_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value);
-int hw_mod_cat_kcs_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_kcs_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count);
-int hw_mod_cat_kcs_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kcs_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value);
-int hw_mod_cat_kcs_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kcs_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value);
-int hw_mod_cat_fte_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_fte_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count);
-int hw_mod_cat_fte_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_fte_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value);
-int hw_mod_cat_fte_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_fte_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value);
 /* KCE/KCS/FTE FLM */
-int hw_mod_cat_kce_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_kce_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count);
-int hw_mod_cat_kce_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kce_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value);
-int hw_mod_cat_kce_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kce_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value);
-int hw_mod_cat_kcs_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_kcs_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count);
-int hw_mod_cat_kcs_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kcs_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value);
-int hw_mod_cat_kcs_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kcs_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value);
-int hw_mod_cat_fte_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_fte_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count);
-int hw_mod_cat_fte_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_fte_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value);
-int hw_mod_cat_fte_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_fte_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value);
 
-int hw_mod_cat_cte_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_cat_cte_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cte_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_cat_cte_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t value);
-int hw_mod_cat_cte_get(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cte_get(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t *value);
 
-int hw_mod_cat_cts_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_cat_cts_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cts_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_cat_cts_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t value);
-int hw_mod_cat_cts_get(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cts_get(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t *value);
 
-int hw_mod_cat_cot_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_cat_cot_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cot_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_cat_cot_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t value);
 
 struct km_func_s {
@@ -500,28 +500,28 @@ enum hw_km_e {
 	HW_KM_TCQ_BANK_MASK,
 	HW_KM_TCQ_QUAL
 };
-bool hw_mod_km_present(struct flow_api_backend_s *be);
-int hw_mod_km_alloc(struct flow_api_backend_s *be);
-void hw_mod_km_free(struct flow_api_backend_s *be);
-int hw_mod_km_reset(struct flow_api_backend_s *be);
-int hw_mod_km_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_km_rcp_set(struct flow_api_backend_s *be, enum hw_km_e field, int index, int word_off,
+bool nthw_mod_km_present(struct flow_api_backend_s *be);
+int nthw_mod_km_alloc(struct flow_api_backend_s *be);
+void nthw_mod_km_free(struct flow_api_backend_s *be);
+int nthw_mod_km_reset(struct flow_api_backend_s *be);
+int nthw_mod_km_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_km_rcp_set(struct flow_api_backend_s *be, enum hw_km_e field, int index, int word_off,
 	uint32_t value);
-int hw_mod_km_rcp_get(struct flow_api_backend_s *be, enum hw_km_e field, int index, int word_off,
+int nthw_mod_km_rcp_get(struct flow_api_backend_s *be, enum hw_km_e field, int index, int word_off,
 	uint32_t *value);
-int hw_mod_km_cam_flush(struct flow_api_backend_s *be, int start_bank, int start_record,
+int nthw_mod_km_cam_flush(struct flow_api_backend_s *be, int start_bank, int start_record,
 	int count);
-int hw_mod_km_cam_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
+int nthw_mod_km_cam_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
 	uint32_t value);
 
-int hw_mod_km_tcam_flush(struct flow_api_backend_s *be, int start_bank, int count);
-int hw_mod_km_tcam_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int byte,
+int nthw_mod_km_tcam_flush(struct flow_api_backend_s *be, int start_bank, int count);
+int nthw_mod_km_tcam_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int byte,
 	int byte_val, uint32_t *value_set);
-int hw_mod_km_tcam_get(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int byte,
+int nthw_mod_km_tcam_get(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int byte,
 	int byte_val, uint32_t *value_set);
-int hw_mod_km_tci_flush(struct flow_api_backend_s *be, int start_bank, int start_record,
+int nthw_mod_km_tci_flush(struct flow_api_backend_s *be, int start_bank, int start_record,
 	int count);
-int hw_mod_km_tci_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
+int nthw_mod_km_tci_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
 	uint32_t value);
 struct flm_func_s {
 	COMMON_FUNC_INFO_S;
@@ -641,55 +641,55 @@ enum hw_flm_e {
 	HW_FLM_SCRUB_INF,	/* module ver 0.24 */
 };
 
-bool hw_mod_flm_present(struct flow_api_backend_s *be);
-int hw_mod_flm_alloc(struct flow_api_backend_s *be);
-void hw_mod_flm_free(struct flow_api_backend_s *be);
-int hw_mod_flm_reset(struct flow_api_backend_s *be);
+bool nthw_mod_flm_present(struct flow_api_backend_s *be);
+int nthw_mod_flm_alloc(struct flow_api_backend_s *be);
+void nthw_mod_flm_free(struct flow_api_backend_s *be);
+int nthw_mod_flm_reset(struct flow_api_backend_s *be);
 
-int hw_mod_flm_control_flush(struct flow_api_backend_s *be);
-int hw_mod_flm_control_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value);
+int nthw_mod_flm_control_flush(struct flow_api_backend_s *be);
+int nthw_mod_flm_control_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value);
 
-int hw_mod_flm_status_update(struct flow_api_backend_s *be);
-int hw_mod_flm_status_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value);
+int nthw_mod_flm_status_update(struct flow_api_backend_s *be);
+int nthw_mod_flm_status_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value);
 
-int hw_mod_flm_scan_flush(struct flow_api_backend_s *be);
-int hw_mod_flm_scan_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value);
+int nthw_mod_flm_scan_flush(struct flow_api_backend_s *be);
+int nthw_mod_flm_scan_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value);
 
-int hw_mod_flm_load_bin_flush(struct flow_api_backend_s *be);
-int hw_mod_flm_load_bin_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value);
+int nthw_mod_flm_load_bin_flush(struct flow_api_backend_s *be);
+int nthw_mod_flm_load_bin_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value);
 
-int hw_mod_flm_prio_flush(struct flow_api_backend_s *be);
-int hw_mod_flm_prio_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value);
+int nthw_mod_flm_prio_flush(struct flow_api_backend_s *be);
+int nthw_mod_flm_prio_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value);
 
-int hw_mod_flm_pst_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_flm_pst_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
+int nthw_mod_flm_pst_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_flm_pst_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
 	uint32_t value);
 
-int hw_mod_flm_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_flm_rcp_set_mask(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
+int nthw_mod_flm_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_flm_rcp_set_mask(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
 	uint32_t *value);
-int hw_mod_flm_rcp_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
+int nthw_mod_flm_rcp_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
 	uint32_t value);
 
-int hw_mod_flm_buf_ctrl_update(struct flow_api_backend_s *be);
-int hw_mod_flm_buf_ctrl_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value);
+int nthw_mod_flm_buf_ctrl_update(struct flow_api_backend_s *be);
+int nthw_mod_flm_buf_ctrl_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value);
 
-int hw_mod_flm_stat_update(struct flow_api_backend_s *be);
-int hw_mod_flm_stat_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value);
+int nthw_mod_flm_stat_update(struct flow_api_backend_s *be);
+int nthw_mod_flm_stat_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value);
 
-int hw_mod_flm_lrn_data_set_flush(struct flow_api_backend_s *be, enum hw_flm_e field,
+int nthw_mod_flm_lrn_data_set_flush(struct flow_api_backend_s *be, enum hw_flm_e field,
 	const uint32_t *value, uint32_t records,
 	uint32_t *handled_records, uint32_t *inf_word_cnt,
 	uint32_t *sta_word_cnt);
-int hw_mod_flm_inf_sta_data_update_get(struct flow_api_backend_s *be, enum hw_flm_e field,
+int nthw_mod_flm_inf_sta_data_update_get(struct flow_api_backend_s *be, enum hw_flm_e field,
 	uint32_t *inf_value, uint32_t inf_size,
 	uint32_t *inf_word_cnt, uint32_t *sta_value,
 	uint32_t sta_size, uint32_t *sta_word_cnt);
 
-uint32_t hw_mod_flm_scrub_timeout_decode(uint32_t t_enc);
-uint32_t hw_mod_flm_scrub_timeout_encode(uint32_t t);
-int hw_mod_flm_scrub_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_flm_scrub_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
+uint32_t nthw_mod_flm_scrub_timeout_decode(uint32_t t_enc);
+uint32_t nthw_mod_flm_scrub_timeout_encode(uint32_t t);
+int nthw_mod_flm_scrub_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_flm_scrub_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
 	uint32_t value);
 
 struct hsh_func_s {
@@ -731,12 +731,12 @@ enum hw_hsh_e {
 	HW_HSH_RCP_K,
 	HW_HSH_RCP_AUTO_IPV4_MASK
 };
-bool hw_mod_hsh_present(struct flow_api_backend_s *be);
-int hw_mod_hsh_alloc(struct flow_api_backend_s *be);
-void hw_mod_hsh_free(struct flow_api_backend_s *be);
-int hw_mod_hsh_reset(struct flow_api_backend_s *be);
-int hw_mod_hsh_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_hsh_rcp_set(struct flow_api_backend_s *be, enum hw_hsh_e field, uint32_t index,
+bool nthw_mod_hsh_present(struct flow_api_backend_s *be);
+int nthw_mod_hsh_alloc(struct flow_api_backend_s *be);
+void nthw_mod_hsh_free(struct flow_api_backend_s *be);
+int nthw_mod_hsh_reset(struct flow_api_backend_s *be);
+int nthw_mod_hsh_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_hsh_rcp_set(struct flow_api_backend_s *be, enum hw_hsh_e field, uint32_t index,
 	uint32_t word_off, uint32_t value);
 
 struct qsl_func_s {
@@ -773,23 +773,23 @@ enum hw_qsl_e {
 	HW_QSL_UNMQ_DEST_QUEUE,
 	HW_QSL_UNMQ_EN,
 };
-bool hw_mod_qsl_present(struct flow_api_backend_s *be);
-int hw_mod_qsl_alloc(struct flow_api_backend_s *be);
-void hw_mod_qsl_free(struct flow_api_backend_s *be);
-int hw_mod_qsl_reset(struct flow_api_backend_s *be);
-int hw_mod_qsl_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_qsl_rcp_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+bool nthw_mod_qsl_present(struct flow_api_backend_s *be);
+int nthw_mod_qsl_alloc(struct flow_api_backend_s *be);
+void nthw_mod_qsl_free(struct flow_api_backend_s *be);
+int nthw_mod_qsl_reset(struct flow_api_backend_s *be);
+int nthw_mod_qsl_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_qsl_rcp_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t value);
-int hw_mod_qsl_qst_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_qsl_qst_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_qst_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_qsl_qst_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t value);
-int hw_mod_qsl_qen_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_qsl_qen_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_qen_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_qsl_qen_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t value);
-int hw_mod_qsl_qen_get(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_qen_get(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t *value);
-int hw_mod_qsl_unmq_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_qsl_unmq_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_unmq_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_qsl_unmq_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t value);
 
 struct slc_lr_func_s {
@@ -812,12 +812,12 @@ enum hw_slc_lr_e {
 	HW_SLC_LR_RCP_TAIL_OFS,
 	HW_SLC_LR_RCP_PCAP
 };
-bool hw_mod_slc_lr_present(struct flow_api_backend_s *be);
-int hw_mod_slc_lr_alloc(struct flow_api_backend_s *be);
-void hw_mod_slc_lr_free(struct flow_api_backend_s *be);
-int hw_mod_slc_lr_reset(struct flow_api_backend_s *be);
-int hw_mod_slc_lr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_slc_lr_rcp_set(struct flow_api_backend_s *be, enum hw_slc_lr_e field, uint32_t index,
+bool nthw_mod_slc_lr_present(struct flow_api_backend_s *be);
+int nthw_mod_slc_lr_alloc(struct flow_api_backend_s *be);
+void nthw_mod_slc_lr_free(struct flow_api_backend_s *be);
+int nthw_mod_slc_lr_reset(struct flow_api_backend_s *be);
+int nthw_mod_slc_lr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_slc_lr_rcp_set(struct flow_api_backend_s *be, enum hw_slc_lr_e field, uint32_t index,
 	uint32_t value);
 
 struct pdb_func_s {
@@ -855,12 +855,12 @@ enum hw_pdb_e {
 	HW_PDB_CONFIG_TS_FORMAT,
 	HW_PDB_CONFIG_PORT_OFS,
 };
-bool hw_mod_pdb_present(struct flow_api_backend_s *be);
-int hw_mod_pdb_alloc(struct flow_api_backend_s *be);
-void hw_mod_pdb_free(struct flow_api_backend_s *be);
-int hw_mod_pdb_reset(struct flow_api_backend_s *be);
-int hw_mod_pdb_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_pdb_rcp_set(struct flow_api_backend_s *be, enum hw_pdb_e field, uint32_t index,
+bool nthw_mod_pdb_present(struct flow_api_backend_s *be);
+int nthw_mod_pdb_alloc(struct flow_api_backend_s *be);
+void nthw_mod_pdb_free(struct flow_api_backend_s *be);
+int nthw_mod_pdb_reset(struct flow_api_backend_s *be);
+int nthw_mod_pdb_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_pdb_rcp_set(struct flow_api_backend_s *be, enum hw_pdb_e field, uint32_t index,
 	uint32_t value);
 
 struct tpe_func_s {
@@ -930,53 +930,53 @@ enum hw_tpe_e {
 	HW_TPE_CSU_RCP_INNER_L3_CMD,
 	HW_TPE_CSU_RCP_INNER_L4_CMD,
 };
-bool hw_mod_tpe_present(struct flow_api_backend_s *be);
-int hw_mod_tpe_alloc(struct flow_api_backend_s *be);
-void hw_mod_tpe_free(struct flow_api_backend_s *be);
-int hw_mod_tpe_reset(struct flow_api_backend_s *be);
+bool nthw_mod_tpe_present(struct flow_api_backend_s *be);
+int nthw_mod_tpe_alloc(struct flow_api_backend_s *be);
+void nthw_mod_tpe_free(struct flow_api_backend_s *be);
+int nthw_mod_tpe_reset(struct flow_api_backend_s *be);
 
-int hw_mod_tpe_rpp_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_rpp_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpp_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_rpp_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
-int hw_mod_tpe_rpp_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_rpp_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpp_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_rpp_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
-int hw_mod_tpe_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
-int hw_mod_tpe_ifr_counters_update(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_ifr_counters_update(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t *value);
 
-int hw_mod_tpe_ins_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_ins_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_ins_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_ins_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
-int hw_mod_tpe_rpl_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_rpl_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpl_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_rpl_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
-int hw_mod_tpe_rpl_ext_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_rpl_ext_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpl_ext_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_rpl_ext_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
-int hw_mod_tpe_rpl_rpl_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_rpl_rpl_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpl_rpl_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_rpl_rpl_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t *value);
 
-int hw_mod_tpe_cpy_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_cpy_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_cpy_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_cpy_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
-int hw_mod_tpe_hfu_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_hfu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_hfu_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_hfu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
-int hw_mod_tpe_csu_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_csu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_csu_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
+int nthw_mod_tpe_csu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
 enum debug_mode_e {
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 97594bd26d..dd25b51e14 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -418,19 +418,19 @@ static int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 	 * remove unmatched queue if setup in QSL
 	 * remove exception queue setting in QSL UNM
 	 */
-	hw_mod_qsl_unmq_set(&ndev->be, HW_QSL_UNMQ_DEST_QUEUE, eth_dev->port, 0);
-	hw_mod_qsl_unmq_set(&ndev->be, HW_QSL_UNMQ_EN, eth_dev->port, 0);
-	hw_mod_qsl_unmq_flush(&ndev->be, eth_dev->port, 1);
+	nthw_mod_qsl_unmq_set(&ndev->be, HW_QSL_UNMQ_DEST_QUEUE, eth_dev->port, 0);
+	nthw_mod_qsl_unmq_set(&ndev->be, HW_QSL_UNMQ_EN, eth_dev->port, 0);
+	nthw_mod_qsl_unmq_flush(&ndev->be, eth_dev->port, 1);
 
 	if (ndev->flow_profile == FLOW_ETH_DEV_PROFILE_INLINE) {
 		for (int i = 0; i < eth_dev->num_queues; ++i) {
 			uint32_t qen_value = 0;
 			uint32_t queue_id = (uint32_t)eth_dev->rx_queue[i].hw_id;
 
-			hw_mod_qsl_qen_get(&ndev->be, HW_QSL_QEN_EN, queue_id / 4, &qen_value);
-			hw_mod_qsl_qen_set(&ndev->be, HW_QSL_QEN_EN, queue_id / 4,
+			nthw_mod_qsl_qen_get(&ndev->be, HW_QSL_QEN_EN, queue_id / 4, &qen_value);
+			nthw_mod_qsl_qen_set(&ndev->be, HW_QSL_QEN_EN, queue_id / 4,
 				qen_value & ~(1U << (queue_id % 4)));
-			hw_mod_qsl_qen_flush(&ndev->be, queue_id / 4, 1);
+			nthw_mod_qsl_qen_flush(&ndev->be, queue_id / 4, 1);
 		}
 	}
 
@@ -678,14 +678,14 @@ static struct flow_eth_dev *flow_get_eth_dev(uint8_t adapter_no, uint8_t port_no
 			 * Init QSL UNM - unmatched - redirects otherwise discarded
 			 * packets in QSL
 			 */
-			if (hw_mod_qsl_unmq_set(&ndev->be, HW_QSL_UNMQ_DEST_QUEUE, eth_dev->port,
+			if (nthw_mod_qsl_unmq_set(&ndev->be, HW_QSL_UNMQ_DEST_QUEUE, eth_dev->port,
 				eth_dev->rx_queue[0].hw_id) < 0)
 				goto err_exit0;
 
-			if (hw_mod_qsl_unmq_set(&ndev->be, HW_QSL_UNMQ_EN, eth_dev->port, 1) < 0)
+			if (nthw_mod_qsl_unmq_set(&ndev->be, HW_QSL_UNMQ_EN, eth_dev->port, 1) < 0)
 				goto err_exit0;
 
-			if (hw_mod_qsl_unmq_flush(&ndev->be, eth_dev->port, 1) < 0)
+			if (nthw_mod_qsl_unmq_flush(&ndev->be, eth_dev->port, 1) < 0)
 				goto err_exit0;
 		}
 
@@ -699,10 +699,10 @@ static struct flow_eth_dev *flow_get_eth_dev(uint8_t adapter_no, uint8_t port_no
 			uint32_t qen_value = 0;
 			uint32_t queue_id = (uint32_t)eth_dev->rx_queue[i].hw_id;
 
-			hw_mod_qsl_qen_get(&ndev->be, HW_QSL_QEN_EN, queue_id / 4, &qen_value);
-			hw_mod_qsl_qen_set(&ndev->be, HW_QSL_QEN_EN, queue_id / 4,
+			nthw_mod_qsl_qen_get(&ndev->be, HW_QSL_QEN_EN, queue_id / 4, &qen_value);
+			nthw_mod_qsl_qen_set(&ndev->be, HW_QSL_QEN_EN, queue_id / 4,
 				qen_value | (1 << (queue_id % 4)));
-			hw_mod_qsl_qen_flush(&ndev->be, queue_id / 4, 1);
+			nthw_mod_qsl_qen_flush(&ndev->be, queue_id / 4, 1);
 		}
 	}
 
@@ -1276,7 +1276,7 @@ static const struct flow_filter_ops ops = {
 	/*
 	 * Other
 	 */
-	 .hw_mod_hsh_rcp_flush = hw_mod_hsh_rcp_flush,
+	 .nthw_mod_hsh_rcp_flush = nthw_mod_hsh_rcp_flush,
 };
 
 void nthw_init_flow_filter(void)
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
index b53252662b..76ff79cbe1 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
@@ -70,11 +70,11 @@ static int hsh_set_part(struct flow_nic_dev *ndev, int hsh_idx, struct hsh_words
 
 	words[word].free = false;
 
-	res |= hw_mod_hsh_rcp_set(&ndev->be, words[word].pe, hsh_idx, 0, pe);
-	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %" PRIu32 ")",
+	res |= nthw_mod_hsh_rcp_set(&ndev->be, words[word].pe, hsh_idx, 0, pe);
+	NT_LOG(DBG, FILTER, "nthw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %" PRIu32 ")",
 		(int)words[word].pe, hsh_idx, pe);
-	res |= hw_mod_hsh_rcp_set(&ndev->be, words[word].ofs, hsh_idx, 0, ofs);
-	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %" PRIu32 ")",
+	res |= nthw_mod_hsh_rcp_set(&ndev->be, words[word].ofs, hsh_idx, 0, ofs);
+	NT_LOG(DBG, FILTER, "nthw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %" PRIu32 ")",
 		(int)words[word].ofs, hsh_idx, ofs);
 
 
@@ -95,10 +95,10 @@ static int hsh_set_part(struct flow_nic_dev *ndev, int hsh_idx, struct hsh_words
 			mask = 0x0;
 		}
 		/* reorder QW words mask from little to big endian */
-		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx,
+		res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx,
 			words[word].index + words_count - mask_off, mask);
 		NT_LOG(DBG, FILTER,
-			"hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, %d, %d, 0x%08" PRIX32 ")",
+			"mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, %d, %d, 0x%08" PRIX32 ")",
 				hsh_idx, words[word].index + words_count - mask_off, mask);
 		toeplitz_mask[words[word].index + mask_off - 1] = mask;
 	}
@@ -166,33 +166,33 @@ int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_c
 	};
 
 	int res = 0;
-	res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
+	res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
 	/* enable hashing */
-	res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_LOAD_DIST_TYPE, hsh_idx, 0, 2);
+	res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_LOAD_DIST_TYPE, hsh_idx, 0, 2);
 
 	/* configure selected hash function and its key */
 	bool toeplitz = false;
 	switch (rss_conf.algorithm) {
 	case RTE_ETH_HASH_FUNCTION_DEFAULT:
 		/* Use default NTH10 hashing algorithm */
-		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TOEPLITZ, hsh_idx, 0, 0);
+		res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TOEPLITZ, hsh_idx, 0, 0);
 		/* Use 1st 32-bits from rss_key to configure NTH10 SEED */
-		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_SEED, hsh_idx, 0,
+		res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_SEED, hsh_idx, 0,
 			rss_conf.rss_key[0] << 24 | rss_conf.rss_key[1] << 16 |
 				rss_conf.rss_key[2] << 8 | rss_conf.rss_key[3]);
 		break;
 	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
 		toeplitz = true;
-		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TOEPLITZ, hsh_idx, 0, 1);
+		res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TOEPLITZ, hsh_idx, 0, 1);
 		uint8_t empty_key = 0;
 
 		/* Toeplitz key (always 40B) words have to be programmed in reverse order */
 		for (uint8_t i = 0; i <= (MAX_RSS_KEY_LEN - 4); i += 4) {
-			res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_K, hsh_idx, 9 - i / 4,
+			res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_K, hsh_idx, 9 - i / 4,
 				rss_conf.rss_key[i] << 24 | rss_conf.rss_key[i + 1] << 16 |
 				rss_conf.rss_key[i + 2] << 8 | rss_conf.rss_key[i + 3]);
 			NT_LOG(DBG, FILTER,
-				"hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_K, %d, %d, 0x%" PRIX32 ")",
+				"nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_K, %d, %d, 0x%" PRIX32 ")",
 				hsh_idx, 9 - i / 4, rss_conf.rss_key[i] << 24 |
 				rss_conf.rss_key[i + 1] << 16 | rss_conf.rss_key[i + 2] << 8 |
 				rss_conf.rss_key[i + 3]);
@@ -432,7 +432,7 @@ int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_c
 						0, 32, toeplitz);
 				}
 			}
-			res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_AUTO_IPV4_MASK,
+			res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_AUTO_IPV4_MASK,
 				hsh_idx, 0, 1);
 		} else {
 			/* IPv4 */
@@ -539,9 +539,9 @@ int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_c
 					res |= hsh_set_part(ndev, hsh_idx, words, DYN_L3, 9, 8,
 						toeplitz);
 			} else {
-				res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_P_MASK,
+				res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_P_MASK,
 					hsh_idx, 0, 1);
-				res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TNL_P,
+				res |= nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TNL_P,
 					hsh_idx, 0, 0);
 			}
 		} else {
@@ -555,9 +555,9 @@ int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_c
 						toeplitz);
 				}
 			} else {
-				res |= hw_mod_hsh_rcp_set(&ndev->be,
+				res |= nthw_mod_hsh_rcp_set(&ndev->be,
 					HW_HSH_RCP_P_MASK, hsh_idx, 0, 1);
-				res |= hw_mod_hsh_rcp_set(&ndev->be,
+				res |= nthw_mod_hsh_rcp_set(&ndev->be,
 					HW_HSH_RCP_TNL_P, hsh_idx, 0, 1);
 			}
 		}
@@ -644,7 +644,7 @@ int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_c
 	}
 
 	if (fields || res != 0) {
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
+		nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
 		if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", rss_conf.rss_hf) == 0) {
 			NT_LOG(ERR, FILTER, "RSS configuration%s is not supported for hash func %s.",
 				rss_buffer, (enum rte_eth_hash_function)toeplitz ?
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_km.c b/drivers/net/ntnic/nthw/flow_api/flow_km.c
index 9c76e8639c..1052773668 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_km.c
@@ -479,7 +479,7 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 	int sw = 0;
 	int swx = 0;
 
-	hw_mod_km_rcp_set(km->be, HW_KM_RCP_PRESET_ALL, index, 0, 0);
+	nthw_mod_km_rcp_set(km->be, HW_KM_RCP_PRESET_ALL, index, 0, 0);
 
 	/* set extractor words, offs, contrib */
 	for (int i = 0; i < km->num_ftype_elem; i++) {
@@ -490,24 +490,24 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 					/* SWX */
 					if (km->match_map[i]->extr_start_offs_id == SB_VNI) {
 						NT_LOG(DBG, FILTER, "Set KM SWX sel A - VNI");
-						hw_mod_km_rcp_set(km->be, HW_KM_RCP_SWX_CCH, index,
-							0, 1);
-						hw_mod_km_rcp_set(km->be, HW_KM_RCP_SWX_SEL_A,
+						nthw_mod_km_rcp_set(km->be,
+							HW_KM_RCP_SWX_CCH, index, 0, 1);
+						nthw_mod_km_rcp_set(km->be, HW_KM_RCP_SWX_SEL_A,
 							index, 0, SWX_SEL_ALL32);
 
 					} else if (km->match_map[i]->extr_start_offs_id ==
 						SB_MAC_PORT) {
 						NT_LOG(DBG, FILTER,
 							"Set KM SWX sel A - PTC + MAC");
-						hw_mod_km_rcp_set(km->be, HW_KM_RCP_SWX_SEL_A,
+						nthw_mod_km_rcp_set(km->be, HW_KM_RCP_SWX_SEL_A,
 							index, 0, SWX_SEL_ALL32);
 
 					} else if (km->match_map[i]->extr_start_offs_id ==
 						SB_KCC_ID) {
 						NT_LOG(DBG, FILTER, "Set KM SWX sel A - KCC ID");
-						hw_mod_km_rcp_set(km->be, HW_KM_RCP_SWX_CCH, index,
-							0, 1);
-						hw_mod_km_rcp_set(km->be, HW_KM_RCP_SWX_SEL_A,
+						nthw_mod_km_rcp_set(km->be,
+							HW_KM_RCP_SWX_CCH, index, 0, 1);
+						nthw_mod_km_rcp_set(km->be, HW_KM_RCP_SWX_SEL_A,
 							index, 0, SWX_SEL_ALL32);
 
 					} else {
@@ -523,11 +523,11 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 			} else {
 				if (sw == 0) {
 					/* DW8 */
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_DW8_DYN, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_DW8_DYN, index, 0,
 						km->match_map[i]->extr_start_offs_id);
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_DW8_OFS, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_DW8_OFS, index, 0,
 						km->match_map[i]->rel_offs);
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_DW8_SEL_A, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_DW8_SEL_A, index, 0,
 						DW8_SEL_FIRST32);
 					NT_LOG(DBG, FILTER,
 						"Set KM DW8 sel A: dyn: %i, offs: %i",
@@ -536,11 +536,11 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 
 				} else if (sw == 1) {
 					/* DW10 */
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_DW10_DYN, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_DW10_DYN, index, 0,
 						km->match_map[i]->extr_start_offs_id);
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_DW10_OFS, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_DW10_OFS, index, 0,
 						km->match_map[i]->rel_offs);
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_DW10_SEL_A, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_DW10_SEL_A, index, 0,
 						DW10_SEL_FIRST32);
 					NT_LOG(DBG, FILTER,
 						"Set KM DW10 sel A: dyn: %i, offs: %i",
@@ -558,24 +558,24 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 
 		case KM_USE_EXTRACTOR_QWORD:
 			if (qw == 0) {
-				hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_DYN, index, 0,
+				nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_DYN, index, 0,
 					km->match_map[i]->extr_start_offs_id);
-				hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_OFS, index, 0,
+				nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_OFS, index, 0,
 					km->match_map[i]->rel_offs);
 
 				switch (km->match_map[i]->word_len) {
 				case 1:
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_SEL_A, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_SEL_A, index, 0,
 						QW0_SEL_FIRST32);
 					break;
 
 				case 2:
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_SEL_A, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_SEL_A, index, 0,
 						QW0_SEL_FIRST64);
 					break;
 
 				case 4:
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_SEL_A, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW0_SEL_A, index, 0,
 						QW0_SEL_ALL128);
 					break;
 
@@ -589,24 +589,24 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 					km->match_map[i]->rel_offs, km->match_map[i]->word_len);
 
 			} else if (qw == 1) {
-				hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_DYN, index, 0,
+				nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_DYN, index, 0,
 					km->match_map[i]->extr_start_offs_id);
-				hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_OFS, index, 0,
+				nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_OFS, index, 0,
 					km->match_map[i]->rel_offs);
 
 				switch (km->match_map[i]->word_len) {
 				case 1:
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_SEL_A, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_SEL_A, index, 0,
 						QW4_SEL_FIRST32);
 					break;
 
 				case 2:
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_SEL_A, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_SEL_A, index, 0,
 						QW4_SEL_FIRST64);
 					break;
 
 				case 4:
-					hw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_SEL_A, index, 0,
+					nthw_mod_km_rcp_set(km->be, HW_KM_RCP_QW4_SEL_A, index, 0,
 						QW4_SEL_ALL128);
 					break;
 
@@ -633,7 +633,7 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 
 	/* set mask A */
 	for (int i = 0; i < km->key_word_size; i++) {
-		hw_mod_km_rcp_set(km->be, HW_KM_RCP_MASK_A, index,
+		nthw_mod_km_rcp_set(km->be, HW_KM_RCP_MASK_A, index,
 			(km->be->km.nb_km_rcp_mask_a_word_size - 1) - i,
 			km->entry_mask[i]);
 		NT_LOG(DBG, FILTER, "Set KM mask A: %08x", km->entry_mask[i]);
@@ -642,24 +642,24 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 	if (km->target == KM_CAM) {
 		/* set info - Color */
 		if (km->info_set) {
-			hw_mod_km_rcp_set(km->be, HW_KM_RCP_INFO_A, index, 0, 1);
+			nthw_mod_km_rcp_set(km->be, HW_KM_RCP_INFO_A, index, 0, 1);
 			NT_LOG(DBG, FILTER, "Set KM info A");
 		}
 
 		/* set key length A */
-		hw_mod_km_rcp_set(km->be, HW_KM_RCP_EL_A, index, 0,
+		nthw_mod_km_rcp_set(km->be, HW_KM_RCP_EL_A, index, 0,
 			km->key_word_size + !!km->info_set - 1);	/* select id is -1 */
 		/* set Flow Type for Key A */
 		NT_LOG(DBG, FILTER, "Set KM EL A: %i", km->key_word_size + !!km->info_set - 1);
 
-		hw_mod_km_rcp_set(km->be, HW_KM_RCP_FTM_A, index, 0, 1 << km->flow_type);
+		nthw_mod_km_rcp_set(km->be, HW_KM_RCP_FTM_A, index, 0, 1 << km->flow_type);
 
 		NT_LOG(DBG, FILTER, "Set KM FTM A - ft: %i", km->flow_type);
 
 		/* Set Paired - only on the CAM part though... TODO split CAM and TCAM */
 		if ((uint32_t)(km->key_word_size + !!km->info_set) >
 			km->be->km.nb_cam_record_words) {
-			hw_mod_km_rcp_set(km->be, HW_KM_RCP_PAIRED, index, 0, 1);
+			nthw_mod_km_rcp_set(km->be, HW_KM_RCP_PAIRED, index, 0, 1);
 			NT_LOG(DBG, FILTER, "Set KM CAM Paired");
 			km->cam_paired = 1;
 		}
@@ -682,9 +682,9 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 		}
 
 		/* Set BANK_A */
-		hw_mod_km_rcp_set(km->be, HW_KM_RCP_BANK_A, index, 0, bank_bm);
+		nthw_mod_km_rcp_set(km->be, HW_KM_RCP_BANK_A, index, 0, bank_bm);
 		/* Set Kl_A */
-		hw_mod_km_rcp_set(km->be, HW_KM_RCP_KL_A, index, 0, km->key_word_size - 1);
+		nthw_mod_km_rcp_set(km->be, HW_KM_RCP_KL_A, index, 0, km->key_word_size - 1);
 
 	} else {
 		return -1;
@@ -699,10 +699,10 @@ static int cam_populate(struct km_flow_def_s *km, int bank)
 	int cnt = km->key_word_size + !!km->info_set;
 
 	for (uint32_t i = 0; i < km->be->km.nb_cam_record_words && cnt; i++, cnt--) {
-		res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank, km->record_indexes[bank],
-			km->entry_word[i]);
-		res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_FT0 + i, bank, km->record_indexes[bank],
-			km->flow_type);
+		res |= nthw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank,
+				km->record_indexes[bank], km->entry_word[i]);
+		res |= nthw_mod_km_cam_set(km->be, HW_KM_CAM_FT0 + i, bank,
+				km->record_indexes[bank], km->flow_type);
 	}
 
 	km->cam_dist[CAM_KM_DIST_IDX(bank)].km_owner = km;
@@ -711,17 +711,18 @@ static int cam_populate(struct km_flow_def_s *km, int bank)
 		RTE_ASSERT(km->cam_paired);
 
 		for (uint32_t i = 0; i < km->be->km.nb_cam_record_words && cnt; i++, cnt--) {
-			res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank,
+			res |= nthw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank,
 				km->record_indexes[bank] + 1,
 				km->entry_word[km->be->km.nb_cam_record_words + i]);
-			res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_FT0 + i, bank,
+			res |= nthw_mod_km_cam_set(km->be, HW_KM_CAM_FT0 + i, bank,
 				km->record_indexes[bank] + 1, km->flow_type);
 		}
 
 		km->cam_dist[CAM_KM_DIST_IDX(bank) + 1].km_owner = km;
 	}
 
-	res |= hw_mod_km_cam_flush(km->be, bank, km->record_indexes[bank], km->cam_paired ? 2 : 1);
+	res |= nthw_mod_km_cam_flush(km->be, bank, km->record_indexes[bank],
+			km->cam_paired ? 2 : 1);
 
 	return res;
 }
@@ -732,10 +733,10 @@ static int cam_reset_entry(struct km_flow_def_s *km, int bank)
 	int cnt = km->key_word_size + !!km->info_set;
 
 	for (uint32_t i = 0; i < km->be->km.nb_cam_record_words && cnt; i++, cnt--) {
-		res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank, km->record_indexes[bank],
-			0);
-		res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_FT0 + i, bank, km->record_indexes[bank],
-			0);
+		res |= nthw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank,
+				km->record_indexes[bank], 0);
+		res |= nthw_mod_km_cam_set(km->be, HW_KM_CAM_FT0 + i, bank,
+				km->record_indexes[bank], 0);
 	}
 
 	km->cam_dist[CAM_KM_DIST_IDX(bank)].km_owner = NULL;
@@ -744,16 +745,17 @@ static int cam_reset_entry(struct km_flow_def_s *km, int bank)
 		RTE_ASSERT(km->cam_paired);
 
 		for (uint32_t i = 0; i < km->be->km.nb_cam_record_words && cnt; i++, cnt--) {
-			res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank,
+			res |= nthw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank,
 				km->record_indexes[bank] + 1, 0);
-			res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_FT0 + i, bank,
+			res |= nthw_mod_km_cam_set(km->be, HW_KM_CAM_FT0 + i, bank,
 				km->record_indexes[bank] + 1, 0);
 		}
 
 		km->cam_dist[CAM_KM_DIST_IDX(bank) + 1].km_owner = NULL;
 	}
 
-	res |= hw_mod_km_cam_flush(km->be, bank, km->record_indexes[bank], km->cam_paired ? 2 : 1);
+	res |= nthw_mod_km_cam_flush(km->be, bank, km->record_indexes[bank],
+			km->cam_paired ? 2 : 1);
 	return res;
 }
 
@@ -979,14 +981,16 @@ static int tcam_write_word(struct km_flow_def_s *km, int bank, int record, uint3
 		a = a & a_m;
 
 		for (int val = 0; val < 256; val++) {
-			err |= hw_mod_km_tcam_get(km->be, HW_KM_TCAM_T, bank, byte, val, all_recs);
+			err |= nthw_mod_km_tcam_get(km->be, HW_KM_TCAM_T,
+				bank, byte, val, all_recs);
 
 			if ((val & a_m) == a)
 				all_recs[rec_val] |= rec_bit;
 			else
 				all_recs[rec_val] &= ~rec_bit;
 
-			err |= hw_mod_km_tcam_set(km->be, HW_KM_TCAM_T, bank, byte, val, all_recs);
+			err |= nthw_mod_km_tcam_set(km->be, HW_KM_TCAM_T, bank,
+				byte, val, all_recs);
 
 			if (err)
 				break;
@@ -994,7 +998,7 @@ static int tcam_write_word(struct km_flow_def_s *km, int bank, int record, uint3
 	}
 
 	/* flush bank */
-	err |= hw_mod_km_tcam_flush(km->be, bank, ALL_BANK_ENTRIES);
+	err |= nthw_mod_km_tcam_flush(km->be, bank, ALL_BANK_ENTRIES);
 
 	if (err == 0) {
 		RTE_ASSERT(km->tcam_dist[TCAM_DIST_IDX(bank, record)].km_owner == NULL);
@@ -1021,11 +1025,11 @@ static int km_write_data_to_tcam(struct km_flow_def_s *km)
 	}
 
 	/* Write KM_TCI */
-	err |= hw_mod_km_tci_set(km->be, HW_KM_TCI_COLOR, km->tcam_start_bank, km->tcam_record,
+	err |= nthw_mod_km_tci_set(km->be, HW_KM_TCI_COLOR, km->tcam_start_bank, km->tcam_record,
 		km->info);
-	err |= hw_mod_km_tci_set(km->be, HW_KM_TCI_FT, km->tcam_start_bank, km->tcam_record,
+	err |= nthw_mod_km_tci_set(km->be, HW_KM_TCI_FT, km->tcam_start_bank, km->tcam_record,
 		km->flow_type);
-	err |= hw_mod_km_tci_flush(km->be, km->tcam_start_bank, km->tcam_record, 1);
+	err |= nthw_mod_km_tci_flush(km->be, km->tcam_start_bank, km->tcam_record, 1);
 
 	for (int i = 0; i < km->key_word_size && !err; i++) {
 		err = tcam_write_word(km, km->tcam_start_bank + i, km->tcam_record,
@@ -1051,13 +1055,13 @@ static int tcam_reset_bank(struct km_flow_def_s *km, int bank, int record)
 
 	for (int byte = 0; byte < 4; byte++) {
 		for (int val = 0; val < 256; val++) {
-			err = hw_mod_km_tcam_get(km->be, HW_KM_TCAM_T, bank, byte, val, all_recs);
+			err = nthw_mod_km_tcam_get(km->be, HW_KM_TCAM_T, bank, byte, val, all_recs);
 
 			if (err)
 				break;
 
 			all_recs[rec_val] &= ~rec_bit;
-			err = hw_mod_km_tcam_set(km->be, HW_KM_TCAM_T, bank, byte, val, all_recs);
+			err = nthw_mod_km_tcam_set(km->be, HW_KM_TCAM_T, bank, byte, val, all_recs);
 
 			if (err)
 				break;
@@ -1068,7 +1072,7 @@ static int tcam_reset_bank(struct km_flow_def_s *km, int bank, int record)
 		return err;
 
 	/* flush bank */
-	err = hw_mod_km_tcam_flush(km->be, bank, ALL_BANK_ENTRIES);
+	err = nthw_mod_km_tcam_flush(km->be, bank, ALL_BANK_ENTRIES);
 	km->tcam_dist[TCAM_DIST_IDX(bank, record)].km_owner = NULL;
 
 	NT_LOG(DBG, FILTER, "Reset TCAM bank %i, rec_val %i rec bit %08x", bank, rec_val,
@@ -1087,9 +1091,9 @@ static int tcam_reset_entry(struct km_flow_def_s *km)
 	}
 
 	/* Write KM_TCI */
-	hw_mod_km_tci_set(km->be, HW_KM_TCI_COLOR, km->tcam_start_bank, km->tcam_record, 0);
-	hw_mod_km_tci_set(km->be, HW_KM_TCI_FT, km->tcam_start_bank, km->tcam_record, 0);
-	hw_mod_km_tci_flush(km->be, km->tcam_start_bank, km->tcam_record, 1);
+	nthw_mod_km_tci_set(km->be, HW_KM_TCI_COLOR, km->tcam_start_bank, km->tcam_record, 0);
+	nthw_mod_km_tci_set(km->be, HW_KM_TCI_FT, km->tcam_start_bank, km->tcam_record, 0);
+	nthw_mod_km_tci_flush(km->be, km->tcam_start_bank, km->tcam_record, 1);
 
 	for (int i = 0; i < km->key_word_size && !err; i++)
 		err = tcam_reset_bank(km, km->tcam_start_bank + i, km->tcam_record);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
index 490ab2a45e..21aa49e952 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
@@ -18,17 +18,17 @@ static const struct {
 	int (*reset)(struct flow_api_backend_s *be);
 	bool (*present)(struct flow_api_backend_s *be);
 } module[] = {
-	{ "CAT", hw_mod_cat_alloc, hw_mod_cat_free, hw_mod_cat_reset, hw_mod_cat_present },
-	{ "KM", hw_mod_km_alloc, hw_mod_km_free, hw_mod_km_reset, hw_mod_km_present },
-	{ "FLM", hw_mod_flm_alloc, hw_mod_flm_free, hw_mod_flm_reset, hw_mod_flm_present },
-	{ "HSH", hw_mod_hsh_alloc, hw_mod_hsh_free, hw_mod_hsh_reset, hw_mod_hsh_present },
-	{ "QSL", hw_mod_qsl_alloc, hw_mod_qsl_free, hw_mod_qsl_reset, hw_mod_qsl_present },
+	{ "CAT", nthw_mod_cat_alloc, nthw_mod_cat_free, nthw_mod_cat_reset, nthw_mod_cat_present },
+	{ "KM", nthw_mod_km_alloc, nthw_mod_km_free, nthw_mod_km_reset, nthw_mod_km_present },
+	{ "FLM", nthw_mod_flm_alloc, nthw_mod_flm_free, nthw_mod_flm_reset, nthw_mod_flm_present },
+	{ "HSH", nthw_mod_hsh_alloc, nthw_mod_hsh_free, nthw_mod_hsh_reset, nthw_mod_hsh_present },
+	{ "QSL", nthw_mod_qsl_alloc, nthw_mod_qsl_free, nthw_mod_qsl_reset, nthw_mod_qsl_present },
 	{
-		"SLC LR", hw_mod_slc_lr_alloc, hw_mod_slc_lr_free, hw_mod_slc_lr_reset,
-		hw_mod_slc_lr_present
+		"SLC LR", nthw_mod_slc_lr_alloc, nthw_mod_slc_lr_free, nthw_mod_slc_lr_reset,
+		nthw_mod_slc_lr_present
 	},
-	{ "PDB", hw_mod_pdb_alloc, hw_mod_pdb_free, hw_mod_pdb_reset, hw_mod_pdb_present },
-	{ "TPE", hw_mod_tpe_alloc, hw_mod_tpe_free, hw_mod_tpe_reset, hw_mod_tpe_present },
+	{ "PDB", nthw_mod_pdb_alloc, nthw_mod_pdb_free, nthw_mod_pdb_reset, nthw_mod_pdb_present },
+	{ "TPE", nthw_mod_tpe_alloc, nthw_mod_tpe_free, nthw_mod_tpe_reset, nthw_mod_tpe_present },
 };
 #define MOD_COUNT (ARRAY_SIZE(module))
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
index e778c7568a..df9338052e 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
@@ -19,12 +19,12 @@ static int hw_mod_cat_kcs_flush(struct flow_api_backend_s *be, enum km_flm_if_se
 static int hw_mod_cat_fte_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int km_if_id, int start_idx, int count);
 
-bool hw_mod_cat_present(struct flow_api_backend_s *be)
+bool nthw_mod_cat_present(struct flow_api_backend_s *be)
 {
 	return be->iface->get_cat_present(be->be_dev);
 }
 
-int hw_mod_cat_alloc(struct flow_api_backend_s *be)
+int nthw_mod_cat_alloc(struct flow_api_backend_s *be)
 {
 	_VER_ = be->iface->get_cat_version(be->be_dev);
 	NT_LOG(DBG, FILTER, "CAT MODULE VERSION  %i.%i", VER_MAJOR(_VER_), VER_MINOR(_VER_));
@@ -175,7 +175,7 @@ int hw_mod_cat_alloc(struct flow_api_backend_s *be)
 	return 0;
 }
 
-void hw_mod_cat_free(struct flow_api_backend_s *be)
+void nthw_mod_cat_free(struct flow_api_backend_s *be)
 {
 	if (be->cat.base) {
 		free(be->cat.base);
@@ -185,52 +185,52 @@ void hw_mod_cat_free(struct flow_api_backend_s *be)
 
 static int cfn_reset(struct flow_api_backend_s *be, int i)
 {
-	int err = hw_mod_cat_cfn_set(be, HW_CAT_CFN_PRESET_ALL, i, 0, 0);
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_ISL, i, 0,
+	int err = nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PRESET_ALL, i, 0, 0);
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_ISL, i, 0,
 		0xffffffff);	/* accept both ISL or not ISL */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_CFP, i, 0,
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_CFP, i, 0,
 		0xffffffff);	/* accept both CFP or not CFP */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_MAC, i, 0, 0xffffffff);	/* accept all MACs */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_L2, i, 0, 0xffffffff);	/* accept all L2 prot */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_VNTAG, i, 0, 0xffffffff);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_VLAN, i, 0, 0xffffffff);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_MPLS, i, 0, 0xffffffff);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_L3, i, 0, 0xffffffff);	/* accept all L3 prot */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_FRAG, i, 0, 0xffffffff);	/* accept all fragments */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_IP_PROT, i, 0,
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_MAC, i, 0, 0xffffffff);	/* accept all MACs */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_L2, i, 0, 0xffffffff);	/* accept all L2 prot */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_VNTAG, i, 0, 0xffffffff);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_VLAN, i, 0, 0xffffffff);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_MPLS, i, 0, 0xffffffff);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_L3, i, 0, 0xffffffff);	/* accept all L3 prot */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_FRAG, i, 0, 0xffffffff); /* accept all fragments */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_IP_PROT, i, 0,
 		0xffffffff);	/* IP prot check disabled */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_L4, i, 0, 0xffffffff);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TUNNEL, i, 0, 0xffffffff);/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_L2, i, 0, 0xffffffff);/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_VLAN, i, 0, 0xffffffff);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_MPLS, i, 0, 0xffffffff);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_L3, i, 0, 0xffffffff);/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_FRAG, i, 0, 0xffffffff);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_IP_PROT, i, 0,
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_L4, i, 0, 0xffffffff);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TUNNEL, i, 0, 0xffffffff);/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_L2, i, 0, 0xffffffff);/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_VLAN, i, 0, 0xffffffff);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_MPLS, i, 0, 0xffffffff);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_L3, i, 0, 0xffffffff);/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_FRAG, i, 0, 0xffffffff);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_IP_PROT, i, 0,
 		0xffffffff);	/* inner IP prot check disabled */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_L4, i, 0, 0xffffffff);/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_CV, i, 0, 3);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_FCS, i, 0, 3);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TRUNC, i, 0,
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PTC_TNL_L4, i, 0, 0xffffffff);/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_CV, i, 0, 3);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_FCS, i, 0, 3);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TRUNC, i, 0,
 		0xffffffff);	/* accept all truncations */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_L3_CS, i, 0, 3);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_L4_CS, i, 0, 3);	/* accept all */
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_PM_OR_INV, i, 0, 1);
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_LC_INV, i, 0, 1);
-	hw_mod_cat_cfn_set(be, HW_CAT_CFN_KM0_OR, i, 0, 0xffffffff);	/* or all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_L3_CS, i, 0, 3);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_L4_CS, i, 0, 3);	/* accept all */
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_PM_OR_INV, i, 0, 1);
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_LC_INV, i, 0, 1);
+	nthw_mod_cat_cfn_set(be, HW_CAT_CFN_KM0_OR, i, 0, 0xffffffff);	/* or all */
 
 	if (_VER_ >= 21) {
-		hw_mod_cat_cfn_set(be, HW_CAT_CFN_KM1_OR, i, 0, 0xffffffff);	/* or all */
-		hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TNL_L3_CS, i, 0, 0xffffffff);	/* or all */
-		hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TNL_L4_CS, i, 0, 0xffffffff);	/* or all */
-		hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TTL_EXP, i, 0, 0xffffffff);	/* or all */
-		hw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TNL_TTL_EXP, i, 0, 0xffffffff);	/* or all */
+		nthw_mod_cat_cfn_set(be, HW_CAT_CFN_KM1_OR, i, 0, 0xffffffff);	/* or all */
+		nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TNL_L3_CS, i, 0, 0xffffffff);	/* or all */
+		nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TNL_L4_CS, i, 0, 0xffffffff);	/* or all */
+		nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TTL_EXP, i, 0, 0xffffffff);	/* or all */
+		nthw_mod_cat_cfn_set(be, HW_CAT_CFN_ERR_TNL_TTL_EXP, i, 0, 0xffffffff);	/* or all */
 	}
 
 	return err;
 }
 
-int hw_mod_cat_cfn_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_cat_cfn_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	switch (count) {
 	case ALL_ENTRIES:
@@ -734,8 +734,8 @@ static int hw_mod_cat_cfn_mod(struct flow_api_backend_s *be, enum hw_cat_e field
 	return 0;
 }
 
-int hw_mod_cat_cfn_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index, int word_off,
-	uint32_t value)
+int nthw_mod_cat_cfn_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+	int index, int word_off, uint32_t value)
 {
 	return hw_mod_cat_cfn_mod(be, field, index, word_off, &value, 0);
 }
@@ -794,13 +794,13 @@ static int hw_mod_cat_kce_flush(struct flow_api_backend_s *be, enum km_flm_if_se
 	return be->iface->cat_kce_flush(be->be_dev, &be->cat, km_if_idx, start_idx, count);
 }
 
-int hw_mod_cat_kce_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_kce_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count)
 {
 	return hw_mod_cat_kce_flush(be, if_num, 0, start_idx, count);
 }
 
-int hw_mod_cat_kce_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_kce_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count)
 {
 	return hw_mod_cat_kce_flush(be, if_num, 1, start_idx, count);
@@ -859,25 +859,25 @@ static int hw_mod_cat_kce_mod(struct flow_api_backend_s *be, enum hw_cat_e field
 	return 0;
 }
 
-int hw_mod_cat_kce_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kce_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value)
 {
 	return hw_mod_cat_kce_mod(be, field, if_num, 0, index, &value, 0);
 }
 
-int hw_mod_cat_kce_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kce_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value)
 {
 	return hw_mod_cat_kce_mod(be, field, if_num, 0, index, value, 1);
 }
 
-int hw_mod_cat_kce_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kce_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value)
 {
 	return hw_mod_cat_kce_mod(be, field, if_num, 1, index, &value, 0);
 }
 
-int hw_mod_cat_kce_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kce_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value)
 {
 	return hw_mod_cat_kce_mod(be, field, if_num, 1, index, value, 1);
@@ -906,13 +906,13 @@ static int hw_mod_cat_kcs_flush(struct flow_api_backend_s *be, enum km_flm_if_se
 	return be->iface->cat_kcs_flush(be->be_dev, &be->cat, km_if_idx, start_idx, count);
 }
 
-int hw_mod_cat_kcs_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_kcs_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count)
 {
 	return hw_mod_cat_kcs_flush(be, if_num, 0, start_idx, count);
 }
 
-int hw_mod_cat_kcs_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_kcs_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count)
 {
 	return hw_mod_cat_kcs_flush(be, if_num, 1, start_idx, count);
@@ -971,25 +971,25 @@ static int hw_mod_cat_kcs_mod(struct flow_api_backend_s *be, enum hw_cat_e field
 	return 0;
 }
 
-int hw_mod_cat_kcs_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kcs_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value)
 {
 	return hw_mod_cat_kcs_mod(be, field, if_num, 0, index, &value, 0);
 }
 
-int hw_mod_cat_kcs_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kcs_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value)
 {
 	return hw_mod_cat_kcs_mod(be, field, if_num, 0, index, value, 1);
 }
 
-int hw_mod_cat_kcs_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kcs_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value)
 {
 	return hw_mod_cat_kcs_mod(be, field, if_num, 1, index, &value, 0);
 }
 
-int hw_mod_cat_kcs_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_kcs_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value)
 {
 	return hw_mod_cat_kcs_mod(be, field, if_num, 1, index, value, 1);
@@ -1021,13 +1021,13 @@ static int hw_mod_cat_fte_flush(struct flow_api_backend_s *be, enum km_flm_if_se
 	return be->iface->cat_fte_flush(be->be_dev, &be->cat, km_if_idx, start_idx, count);
 }
 
-int hw_mod_cat_fte_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_fte_km_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count)
 {
 	return hw_mod_cat_fte_flush(be, if_num, 0, start_idx, count);
 }
 
-int hw_mod_cat_fte_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
+int nthw_mod_cat_fte_flm_flush(struct flow_api_backend_s *be, enum km_flm_if_select_e if_num,
 	int start_idx, int count)
 {
 	return hw_mod_cat_fte_flush(be, if_num, 1, start_idx, count);
@@ -1088,31 +1088,31 @@ static int hw_mod_cat_fte_mod(struct flow_api_backend_s *be, enum hw_cat_e field
 	return 0;
 }
 
-int hw_mod_cat_fte_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_fte_km_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value)
 {
 	return hw_mod_cat_fte_mod(be, field, if_num, 0, index, &value, 0);
 }
 
-int hw_mod_cat_fte_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_fte_km_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value)
 {
 	return hw_mod_cat_fte_mod(be, field, if_num, 0, index, value, 1);
 }
 
-int hw_mod_cat_fte_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_fte_flm_set(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t value)
 {
 	return hw_mod_cat_fte_mod(be, field, if_num, 1, index, &value, 0);
 }
 
-int hw_mod_cat_fte_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
+int nthw_mod_cat_fte_flm_get(struct flow_api_backend_s *be, enum hw_cat_e field,
 	enum km_flm_if_select_e if_num, int index, uint32_t *value)
 {
 	return hw_mod_cat_fte_mod(be, field, if_num, 1, index, value, 1);
 }
 
-int hw_mod_cat_cte_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_cat_cte_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->cat.nb_cat_funcs;
@@ -1158,19 +1158,19 @@ static int hw_mod_cat_cte_mod(struct flow_api_backend_s *be, enum hw_cat_e field
 	return 0;
 }
 
-int hw_mod_cat_cte_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cte_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_cat_cte_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_cat_cte_get(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cte_get(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t *value)
 {
 	return hw_mod_cat_cte_mod(be, field, index, value, 1);
 }
 
-int hw_mod_cat_cts_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_cat_cts_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	int addr_size = (_VER_ < 15) ? 8 : ((be->cat.cts_num + 1) / 2);
 
@@ -1224,19 +1224,19 @@ static int hw_mod_cat_cts_mod(struct flow_api_backend_s *be, enum hw_cat_e field
 	return 0;
 }
 
-int hw_mod_cat_cts_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cts_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_cat_cts_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_cat_cts_get(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cts_get(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t *value)
 {
 	return hw_mod_cat_cts_mod(be, field, index, value, 1);
 }
 
-int hw_mod_cat_cot_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_cat_cot_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->max_categories;
@@ -1335,7 +1335,7 @@ static int hw_mod_cat_cot_mod(struct flow_api_backend_s *be, enum hw_cat_e field
 	return 0;
 }
 
-int hw_mod_cat_cot_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
+int nthw_mod_cat_cot_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_cat_cot_mod(be, field, index, &value, 0);
@@ -1406,14 +1406,14 @@ static int hw_mod_cat_len_flush(struct flow_api_backend_s *be, int start_idx, in
 	return be->iface->cat_len_flush(be->be_dev, &be->cat, start_idx, count);
 }
 
-int hw_mod_cat_reset(struct flow_api_backend_s *be)
+int nthw_mod_cat_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
 	nthw_zero_module_cache((struct common_func_s *)(&be->cat));
 
 	NT_LOG(DBG, FILTER, "INIT CAT CFN");
 
-	if (hw_mod_cat_cfn_flush(be, 0, ALL_ENTRIES))
+	if (nthw_mod_cat_cfn_flush(be, 0, ALL_ENTRIES))
 		return -1;
 
 	if (_VER_ <= 18) {
@@ -1471,17 +1471,17 @@ int hw_mod_cat_reset(struct flow_api_backend_s *be)
 
 	NT_LOG(DBG, FILTER, "INIT CAT CTE");
 
-	if (hw_mod_cat_cte_flush(be, 0, ALL_ENTRIES))
+	if (nthw_mod_cat_cte_flush(be, 0, ALL_ENTRIES))
 		return -1;
 
 	NT_LOG(DBG, FILTER, "INIT CAT CTS");
 
-	if (hw_mod_cat_cts_flush(be, 0, ALL_ENTRIES))
+	if (nthw_mod_cat_cts_flush(be, 0, ALL_ENTRIES))
 		return -1;
 
 	NT_LOG(DBG, FILTER, "INIT CAT COT");
 
-	if (hw_mod_cat_cot_flush(be, 0, ALL_ENTRIES))
+	if (nthw_mod_cat_cot_flush(be, 0, ALL_ENTRIES))
 		return -1;
 
 	NT_LOG(DBG, FILTER, "INIT CAT CCT");
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
index 4babc30d2b..b2cb82daab 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
@@ -12,12 +12,12 @@
 #define _MOD_ "FLM"
 #define _VER_ be->flm.ver
 
-bool hw_mod_flm_present(struct flow_api_backend_s *be)
+bool nthw_mod_flm_present(struct flow_api_backend_s *be)
 {
 	return be->iface->get_flm_present(be->be_dev);
 }
 
-int hw_mod_flm_alloc(struct flow_api_backend_s *be)
+int nthw_mod_flm_alloc(struct flow_api_backend_s *be)
 {
 	int nb;
 	_VER_ = be->iface->get_flm_version(be->be_dev);
@@ -165,7 +165,7 @@ int hw_mod_flm_alloc(struct flow_api_backend_s *be)
 	return 0;
 }
 
-void hw_mod_flm_free(struct flow_api_backend_s *be)
+void nthw_mod_flm_free(struct flow_api_backend_s *be)
 {
 	if (be->flm.base) {
 		free(be->flm.base);
@@ -173,23 +173,23 @@ void hw_mod_flm_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_flm_reset(struct flow_api_backend_s *be)
+int nthw_mod_flm_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
 	nthw_zero_module_cache((struct common_func_s *)(&be->flm));
 
 	NT_LOG(DBG, FILTER, "INIT FLM");
-	hw_mod_flm_control_set(be, HW_FLM_CONTROL_SPLIT_SDRAM_USAGE, 0x10);
+	nthw_mod_flm_control_set(be, HW_FLM_CONTROL_SPLIT_SDRAM_USAGE, 0x10);
 
-	hw_mod_flm_control_flush(be);
-	hw_mod_flm_scrub_flush(be, 0, ALL_ENTRIES);
-	hw_mod_flm_scan_flush(be);
-	hw_mod_flm_rcp_flush(be, 0, ALL_ENTRIES);
+	nthw_mod_flm_control_flush(be);
+	nthw_mod_flm_scrub_flush(be, 0, ALL_ENTRIES);
+	nthw_mod_flm_scan_flush(be);
+	nthw_mod_flm_rcp_flush(be, 0, ALL_ENTRIES);
 
 	return 0;
 }
 
-int hw_mod_flm_control_flush(struct flow_api_backend_s *be)
+int nthw_mod_flm_control_flush(struct flow_api_backend_s *be)
 {
 	return be->iface->flm_control_flush(be->be_dev, &be->flm);
 }
@@ -289,12 +289,12 @@ static int hw_mod_flm_control_mod(struct flow_api_backend_s *be, enum hw_flm_e f
 	return 0;
 }
 
-int hw_mod_flm_control_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value)
+int nthw_mod_flm_control_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value)
 {
 	return hw_mod_flm_control_mod(be, field, &value, 0);
 }
 
-int hw_mod_flm_status_update(struct flow_api_backend_s *be)
+int nthw_mod_flm_status_update(struct flow_api_backend_s *be)
 {
 	return be->iface->flm_status_update(be->be_dev, &be->flm);
 }
@@ -356,12 +356,12 @@ static int hw_mod_flm_status_mod(struct flow_api_backend_s *be, enum hw_flm_e fi
 	return 0;
 }
 
-int hw_mod_flm_status_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value)
+int nthw_mod_flm_status_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value)
 {
 	return hw_mod_flm_status_mod(be, field, value, 1);
 }
 
-int hw_mod_flm_scan_flush(struct flow_api_backend_s *be)
+int nthw_mod_flm_scan_flush(struct flow_api_backend_s *be)
 {
 	return be->iface->flm_scan_flush(be->be_dev, &be->flm);
 }
@@ -391,12 +391,12 @@ static int hw_mod_flm_scan_mod(struct flow_api_backend_s *be, enum hw_flm_e fiel
 	return 0;
 }
 
-int hw_mod_flm_scan_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value)
+int nthw_mod_flm_scan_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value)
 {
 	return hw_mod_flm_scan_mod(be, field, &value, 0);
 }
 
-int hw_mod_flm_load_bin_flush(struct flow_api_backend_s *be)
+int nthw_mod_flm_load_bin_flush(struct flow_api_backend_s *be)
 {
 	return be->iface->flm_load_bin_flush(be->be_dev, &be->flm);
 }
@@ -426,12 +426,12 @@ static int hw_mod_flm_load_bin_mod(struct flow_api_backend_s *be, enum hw_flm_e
 	return 0;
 }
 
-int hw_mod_flm_load_bin_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value)
+int nthw_mod_flm_load_bin_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value)
 {
 	return hw_mod_flm_load_bin_mod(be, field, &value, 0);
 }
 
-int hw_mod_flm_prio_flush(struct flow_api_backend_s *be)
+int nthw_mod_flm_prio_flush(struct flow_api_backend_s *be)
 {
 	return be->iface->flm_prio_flush(be->be_dev, &be->flm);
 }
@@ -489,12 +489,12 @@ static int hw_mod_flm_prio_mod(struct flow_api_backend_s *be, enum hw_flm_e fiel
 	return 0;
 }
 
-int hw_mod_flm_prio_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value)
+int nthw_mod_flm_prio_set(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t value)
 {
 	return hw_mod_flm_prio_mod(be, field, &value, 0);
 }
 
-int hw_mod_flm_pst_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_flm_pst_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->flm.nb_pst_profiles;
@@ -550,13 +550,13 @@ static int hw_mod_flm_pst_mod(struct flow_api_backend_s *be, enum hw_flm_e field
 	return 0;
 }
 
-int hw_mod_flm_pst_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
+int nthw_mod_flm_pst_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_flm_pst_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_flm_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_flm_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->flm.nb_categories;
@@ -569,7 +569,7 @@ int hw_mod_flm_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count
 	return be->iface->flm_rcp_flush(be->be_dev, &be->flm, start_idx, count);
 }
 
-int hw_mod_flm_scrub_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_flm_scrub_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->flm.nb_scrub_profiles;
@@ -696,7 +696,7 @@ static int hw_mod_flm_rcp_mod(struct flow_api_backend_s *be, enum hw_flm_e field
 	return 0;
 }
 
-int hw_mod_flm_rcp_set_mask(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
+int nthw_mod_flm_rcp_set_mask(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
 	uint32_t *value)
 {
 	if (field != HW_FLM_RCP_MASK)
@@ -705,7 +705,7 @@ int hw_mod_flm_rcp_set_mask(struct flow_api_backend_s *be, enum hw_flm_e field,
 	return hw_mod_flm_rcp_mod(be, field, index, value, 0);
 }
 
-int hw_mod_flm_rcp_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
+int nthw_mod_flm_rcp_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
 	uint32_t value)
 {
 	if (field == HW_FLM_RCP_MASK)
@@ -714,7 +714,7 @@ int hw_mod_flm_rcp_set(struct flow_api_backend_s *be, enum hw_flm_e field, int i
 	return hw_mod_flm_rcp_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_flm_buf_ctrl_update(struct flow_api_backend_s *be)
+int nthw_mod_flm_buf_ctrl_update(struct flow_api_backend_s *be)
 {
 	return be->iface->flm_buf_ctrl_update(be->be_dev, &be->flm);
 }
@@ -754,17 +754,17 @@ static int hw_mod_flm_buf_ctrl_mod_get(struct flow_api_backend_s *be, enum hw_fl
 	return 0;
 }
 
-int hw_mod_flm_buf_ctrl_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value)
+int nthw_mod_flm_buf_ctrl_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value)
 {
 	return hw_mod_flm_buf_ctrl_mod_get(be, field, value);
 }
 
-int hw_mod_flm_stat_update(struct flow_api_backend_s *be)
+int nthw_mod_flm_stat_update(struct flow_api_backend_s *be)
 {
 	return be->iface->flm_stat_update(be->be_dev, &be->flm);
 }
 
-int hw_mod_flm_stat_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value)
+int nthw_mod_flm_stat_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint32_t *value)
 {
 	switch (_VER_) {
 	case 25:
@@ -899,7 +899,7 @@ int hw_mod_flm_stat_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint
 	return 0;
 }
 
-int hw_mod_flm_lrn_data_set_flush(struct flow_api_backend_s *be, enum hw_flm_e field,
+int nthw_mod_flm_lrn_data_set_flush(struct flow_api_backend_s *be, enum hw_flm_e field,
 	const uint32_t *value, uint32_t records,
 	uint32_t *handled_records, uint32_t *inf_word_cnt,
 	uint32_t *sta_word_cnt)
@@ -932,7 +932,7 @@ int hw_mod_flm_lrn_data_set_flush(struct flow_api_backend_s *be, enum hw_flm_e f
 	return ret;
 }
 
-int hw_mod_flm_inf_sta_data_update_get(struct flow_api_backend_s *be, enum hw_flm_e field,
+int nthw_mod_flm_inf_sta_data_update_get(struct flow_api_backend_s *be, enum hw_flm_e field,
 	uint32_t *inf_value, uint32_t inf_size,
 	uint32_t *inf_word_cnt, uint32_t *sta_value,
 	uint32_t sta_size, uint32_t *sta_word_cnt)
@@ -972,7 +972,7 @@ int hw_mod_flm_inf_sta_data_update_get(struct flow_api_backend_s *be, enum hw_fl
  * Note that this represents a lower bound on the timeout, depending on the flow
  * scanner interval and overall load, the timeout can be substantially longer.
  */
-uint32_t hw_mod_flm_scrub_timeout_decode(uint32_t t_enc)
+uint32_t nthw_mod_flm_scrub_timeout_decode(uint32_t t_enc)
 {
 	uint32_t t_bits_2_0 = t_enc & 0x07;
 	uint32_t t_bits_7_3 = (t_enc >> 3) & 0x1F;
@@ -985,7 +985,7 @@ uint32_t hw_mod_flm_scrub_timeout_decode(uint32_t t_enc)
 	return t_sec > UINT32_MAX ? UINT32_MAX : (uint32_t)t_sec;
 }
 
-uint32_t hw_mod_flm_scrub_timeout_encode(uint32_t t)
+uint32_t nthw_mod_flm_scrub_timeout_encode(uint32_t t)
 {
 	uint32_t t_enc = 0;
 
@@ -994,7 +994,7 @@ uint32_t hw_mod_flm_scrub_timeout_encode(uint32_t t)
 
 		do {
 			t_enc++;
-			t_dec = hw_mod_flm_scrub_timeout_decode(t_enc);
+			t_dec = nthw_mod_flm_scrub_timeout_decode(t_enc);
 		} while (t_enc <= 0xEF && t_dec < t);
 	}
 
@@ -1044,7 +1044,7 @@ static int hw_mod_flm_scrub_mod(struct flow_api_backend_s *be, enum hw_flm_e fie
 	return 0;
 }
 
-int hw_mod_flm_scrub_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
+int nthw_mod_flm_scrub_set(struct flow_api_backend_s *be, enum hw_flm_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_flm_scrub_mod(be, field, index, &value, 0);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
index 9821247ebb..a76cec5cfd 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
@@ -12,12 +12,12 @@
 #define _MOD_ "HSH"
 #define _VER_ be->hsh.ver
 
-bool hw_mod_hsh_present(struct flow_api_backend_s *be)
+bool nthw_mod_hsh_present(struct flow_api_backend_s *be)
 {
 	return be->iface->get_hsh_present(be->be_dev);
 }
 
-int hw_mod_hsh_alloc(struct flow_api_backend_s *be)
+int nthw_mod_hsh_alloc(struct flow_api_backend_s *be)
 {
 	int nb;
 	_VER_ = be->iface->get_hsh_version(be->be_dev);
@@ -60,7 +60,7 @@ int hw_mod_hsh_alloc(struct flow_api_backend_s *be)
 	return 0;
 }
 
-void hw_mod_hsh_free(struct flow_api_backend_s *be)
+void nthw_mod_hsh_free(struct flow_api_backend_s *be)
 {
 	if (be->hsh.base) {
 		free(be->hsh.base);
@@ -68,16 +68,16 @@ void hw_mod_hsh_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_hsh_reset(struct flow_api_backend_s *be)
+int nthw_mod_hsh_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
 	nthw_zero_module_cache((struct common_func_s *)(&be->hsh));
 
 	NT_LOG(DBG, FILTER, "INIT HSH RCP");
-	return hw_mod_hsh_rcp_flush(be, 0, be->hsh.nb_rcp);
+	return nthw_mod_hsh_rcp_flush(be, 0, be->hsh.nb_rcp);
 }
 
-int hw_mod_hsh_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_hsh_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->hsh.nb_rcp;
@@ -278,7 +278,7 @@ static int hw_mod_hsh_rcp_mod(struct flow_api_backend_s *be, enum hw_hsh_e field
 	return 0;
 }
 
-int hw_mod_hsh_rcp_set(struct flow_api_backend_s *be, enum hw_hsh_e field, uint32_t index,
+int nthw_mod_hsh_rcp_set(struct flow_api_backend_s *be, enum hw_hsh_e field, uint32_t index,
 	uint32_t word_off, uint32_t value)
 {
 	return hw_mod_hsh_rcp_mod(be, field, index, word_off, &value, 0);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
index a1b9abae66..81de05253f 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
@@ -17,12 +17,12 @@
 #define KM_RCP_MASK_D_A_SIZE 12	/* Mask for double size word extractors for DW8/DW10 */
 #define KM_RCP_MASK_B_SIZE 6
 
-bool hw_mod_km_present(struct flow_api_backend_s *be)
+bool nthw_mod_km_present(struct flow_api_backend_s *be)
 {
 	return be->iface->get_km_present(be->be_dev);
 }
 
-int hw_mod_km_alloc(struct flow_api_backend_s *be)
+int nthw_mod_km_alloc(struct flow_api_backend_s *be)
 {
 	int nb;
 	_VER_ = be->iface->get_km_version(be->be_dev);
@@ -106,7 +106,7 @@ int hw_mod_km_alloc(struct flow_api_backend_s *be)
 	return 0;
 }
 
-void hw_mod_km_free(struct flow_api_backend_s *be)
+void nthw_mod_km_free(struct flow_api_backend_s *be)
 {
 	if (be->km.base) {
 		free(be->km.base);
@@ -114,7 +114,7 @@ void hw_mod_km_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_km_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_km_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->km.nb_categories;
@@ -349,19 +349,20 @@ static int hw_mod_km_rcp_mod(struct flow_api_backend_s *be, enum hw_km_e field,
 	return 0;
 }
 
-int hw_mod_km_rcp_set(struct flow_api_backend_s *be, enum hw_km_e field, int index, int word_off,
+int nthw_mod_km_rcp_set(struct flow_api_backend_s *be, enum hw_km_e field, int index, int word_off,
 	uint32_t value)
 {
 	return hw_mod_km_rcp_mod(be, field, index, word_off, &value, 0);
 }
 
-int hw_mod_km_rcp_get(struct flow_api_backend_s *be, enum hw_km_e field, int index, int word_off,
+int nthw_mod_km_rcp_get(struct flow_api_backend_s *be, enum hw_km_e field, int index, int word_off,
 	uint32_t *value)
 {
 	return hw_mod_km_rcp_mod(be, field, index, word_off, value, 1);
 }
 
-int hw_mod_km_cam_flush(struct flow_api_backend_s *be, int start_bank, int start_record, int count)
+int nthw_mod_km_cam_flush(struct flow_api_backend_s *be, int start_bank,
+	int start_record, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->km.nb_cam_records * be->km.nb_cam_banks;
@@ -467,13 +468,13 @@ static int hw_mod_km_cam_mod(struct flow_api_backend_s *be, enum hw_km_e field,
 	return 0;
 }
 
-int hw_mod_km_cam_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
+int nthw_mod_km_cam_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
 	uint32_t value)
 {
 	return hw_mod_km_cam_mod(be, field, bank, record, &value, 0);
 }
 
-int hw_mod_km_tcam_flush(struct flow_api_backend_s *be, int start_bank, int count)
+int nthw_mod_km_tcam_flush(struct flow_api_backend_s *be, int start_bank, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->km.nb_tcam_banks * 4 * 256;
@@ -560,19 +561,20 @@ static int hw_mod_km_tcam_mod(struct flow_api_backend_s *be, enum hw_km_e field,
 	return 0;
 }
 
-int hw_mod_km_tcam_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int byte,
+int nthw_mod_km_tcam_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int byte,
 	int byte_val, uint32_t *value_set)
 {
 	return hw_mod_km_tcam_mod(be, field, bank, byte, byte_val, value_set, 0);
 }
 
-int hw_mod_km_tcam_get(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int byte,
+int nthw_mod_km_tcam_get(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int byte,
 	int byte_val, uint32_t *value_set)
 {
 	return hw_mod_km_tcam_mod(be, field, bank, byte, byte_val, value_set, 1);
 }
 
-int hw_mod_km_tci_flush(struct flow_api_backend_s *be, int start_bank, int start_record, int count)
+int nthw_mod_km_tci_flush(struct flow_api_backend_s *be, int start_bank,
+	int start_record, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->km.nb_tcam_banks * be->km.nb_tcam_bank_width;
@@ -624,7 +626,7 @@ static int hw_mod_km_tci_mod(struct flow_api_backend_s *be, enum hw_km_e field,
 	return 0;
 }
 
-int hw_mod_km_tci_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
+int nthw_mod_km_tci_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
 	uint32_t value)
 {
 	return hw_mod_km_tci_mod(be, field, bank, record, &value, 0);
@@ -646,7 +648,7 @@ static int hw_mod_km_tcq_flush(struct flow_api_backend_s *be, int start_bank,
 	return be->iface->km_tcq_flush(be->be_dev, &be->km, start_bank, start_record, count);
 }
 
-int hw_mod_km_reset(struct flow_api_backend_s *be)
+int nthw_mod_km_reset(struct flow_api_backend_s *be)
 {
 	uint32_t tcam_v_set[3] = { 0x00000000, 0x00000000, 0x00000000 };
 
@@ -654,11 +656,11 @@ int hw_mod_km_reset(struct flow_api_backend_s *be)
 	nthw_zero_module_cache((struct common_func_s *)(&be->km));
 
 	NT_LOG(DBG, FILTER, "INIT KM RCP");
-	hw_mod_km_rcp_flush(be, 0, ALL_ENTRIES);
+	nthw_mod_km_rcp_flush(be, 0, ALL_ENTRIES);
 
 	/* init CAM - all zero */
 	NT_LOG(DBG, FILTER, "INIT KM CAM");
-	hw_mod_km_cam_flush(be, 0, 0, ALL_ENTRIES);
+	nthw_mod_km_cam_flush(be, 0, 0, ALL_ENTRIES);
 
 	/* init TCAM - all zero */
 	NT_LOG(DBG, FILTER, "INIT KM TCAM");
@@ -667,14 +669,14 @@ int hw_mod_km_reset(struct flow_api_backend_s *be)
 		/* TCAM entries are cache controlled,
 		 * thus need to hard reset initially to sync cache with HW
 		 */
-		hw_mod_km_tcam_set(be, HW_KM_TCAM_BANK_RESET, i, 0, 0, tcam_v_set);
+		nthw_mod_km_tcam_set(be, HW_KM_TCAM_BANK_RESET, i, 0, 0, tcam_v_set);
 	}
 
-	hw_mod_km_tcam_flush(be, 0, ALL_ENTRIES);
+	nthw_mod_km_tcam_flush(be, 0, ALL_ENTRIES);
 
 	/* init TCI - all zero */
 	NT_LOG(DBG, FILTER, "INIT KM TCI");
-	hw_mod_km_tci_flush(be, 0, 0, ALL_ENTRIES);
+	nthw_mod_km_tci_flush(be, 0, 0, ALL_ENTRIES);
 
 	NT_LOG(DBG, FILTER, "INIT KM TCQ");
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
index c5357a98c5..8bfc5fa9a1 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
@@ -12,12 +12,12 @@
 #define _MOD_ "PDB"
 #define _VER_ be->pdb.ver
 
-bool hw_mod_pdb_present(struct flow_api_backend_s *be)
+bool nthw_mod_pdb_present(struct flow_api_backend_s *be)
 {
 	return be->iface->get_pdb_present(be->be_dev);
 }
 
-int hw_mod_pdb_alloc(struct flow_api_backend_s *be)
+int nthw_mod_pdb_alloc(struct flow_api_backend_s *be)
 {
 	int nb;
 	_VER_ = be->iface->get_pdb_version(be->be_dev);
@@ -50,7 +50,7 @@ int hw_mod_pdb_alloc(struct flow_api_backend_s *be)
 	return 0;
 }
 
-void hw_mod_pdb_free(struct flow_api_backend_s *be)
+void nthw_mod_pdb_free(struct flow_api_backend_s *be)
 {
 	if (be->pdb.base) {
 		free(be->pdb.base);
@@ -58,7 +58,7 @@ void hw_mod_pdb_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_pdb_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_pdb_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->pdb.nb_pdb_rcp_categories;
@@ -223,7 +223,7 @@ static int hw_mod_pdb_rcp_mod(struct flow_api_backend_s *be, enum hw_pdb_e field
 	return 0;
 }
 
-int hw_mod_pdb_rcp_set(struct flow_api_backend_s *be, enum hw_pdb_e field, uint32_t index,
+int nthw_mod_pdb_rcp_set(struct flow_api_backend_s *be, enum hw_pdb_e field, uint32_t index,
 	uint32_t value)
 {
 	return hw_mod_pdb_rcp_mod(be, field, index, &value, 0);
@@ -234,14 +234,14 @@ static int hw_mod_pdb_config_flush(struct flow_api_backend_s *be)
 	return be->iface->pdb_config_flush(be->be_dev, &be->pdb);
 }
 
-int hw_mod_pdb_reset(struct flow_api_backend_s *be)
+int nthw_mod_pdb_reset(struct flow_api_backend_s *be)
 {
 	int err = 0;
 	/* Zero entire cache area */
 	nthw_zero_module_cache((struct common_func_s *)(&be->hsh));
 
 	NT_LOG(DBG, FILTER, "INIT PDB RCP");
-	err |= hw_mod_pdb_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_pdb_rcp_flush(be, 0, ALL_ENTRIES);
 
 	NT_LOG(DBG, FILTER, "INIT PDB CONFIG");
 	err |= hw_mod_pdb_config_flush(be);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
index 261cb84dc2..c7c56ef94f 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
@@ -15,12 +15,12 @@
 #define QSL_QEN_ENTRIES 32
 #define QSL_QNMQ_ENTRIES 256
 
-bool hw_mod_qsl_present(struct flow_api_backend_s *be)
+bool nthw_mod_qsl_present(struct flow_api_backend_s *be)
 {
 	return be->iface->get_qsl_present(be->be_dev);
 }
 
-int hw_mod_qsl_alloc(struct flow_api_backend_s *be)
+int nthw_mod_qsl_alloc(struct flow_api_backend_s *be)
 {
 	int nb;
 	_VER_ = be->iface->get_qsl_version(be->be_dev);
@@ -64,7 +64,7 @@ int hw_mod_qsl_alloc(struct flow_api_backend_s *be)
 	return 0;
 }
 
-void hw_mod_qsl_free(struct flow_api_backend_s *be)
+void nthw_mod_qsl_free(struct flow_api_backend_s *be)
 {
 	if (be->qsl.base) {
 		free(be->qsl.base);
@@ -72,19 +72,19 @@ void hw_mod_qsl_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_qsl_reset(struct flow_api_backend_s *be)
+int nthw_mod_qsl_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
 	nthw_zero_module_cache((struct common_func_s *)(&be->qsl));
 
 	NT_LOG(DBG, FILTER, "INIT QSL RCP");
-	hw_mod_qsl_rcp_flush(be, 0, ALL_ENTRIES);
+	nthw_mod_qsl_rcp_flush(be, 0, ALL_ENTRIES);
 
 	NT_LOG(DBG, FILTER, "INIT QSL QST");
-	hw_mod_qsl_qst_flush(be, 0, ALL_ENTRIES);
+	nthw_mod_qsl_qst_flush(be, 0, ALL_ENTRIES);
 
 	NT_LOG(DBG, FILTER, "INIT QSL QEN");
-	hw_mod_qsl_qen_flush(be, 0, ALL_ENTRIES);
+	nthw_mod_qsl_qen_flush(be, 0, ALL_ENTRIES);
 
 	NT_LOG(DBG, FILTER, "INIT QSL UNMQ");
 	be->iface->qsl_unmq_flush(be->be_dev, &be->qsl, 0, 256);
@@ -92,7 +92,7 @@ int hw_mod_qsl_reset(struct flow_api_backend_s *be)
 	return 0;
 }
 
-int hw_mod_qsl_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_qsl_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->qsl.nb_rcp_categories;
@@ -206,13 +206,13 @@ static int hw_mod_qsl_rcp_mod(struct flow_api_backend_s *be, enum hw_qsl_e field
 	return 0;
 }
 
-int hw_mod_qsl_rcp_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_rcp_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t value)
 {
 	return hw_mod_qsl_rcp_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_qsl_qst_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_qsl_qst_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->qsl.nb_qst_entries;
@@ -286,13 +286,13 @@ static int hw_mod_qsl_qst_mod(struct flow_api_backend_s *be, enum hw_qsl_e field
 	return 0;
 }
 
-int hw_mod_qsl_qst_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_qst_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t value)
 {
 	return hw_mod_qsl_qst_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_qsl_qen_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_qsl_qen_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = QSL_QEN_ENTRIES;
@@ -336,19 +336,19 @@ static int hw_mod_qsl_qen_mod(struct flow_api_backend_s *be, enum hw_qsl_e field
 	return 0;
 }
 
-int hw_mod_qsl_qen_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_qen_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t value)
 {
 	return hw_mod_qsl_qen_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_qsl_qen_get(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_qen_get(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t *value)
 {
 	return hw_mod_qsl_qen_mod(be, field, index, value, 1);
 }
 
-int hw_mod_qsl_unmq_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_qsl_unmq_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = QSL_QNMQ_ENTRIES;
@@ -396,7 +396,7 @@ static int hw_mod_qsl_unmq_mod(struct flow_api_backend_s *be, enum hw_qsl_e fiel
 	return 0;
 }
 
-int hw_mod_qsl_unmq_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
+int nthw_mod_qsl_unmq_set(struct flow_api_backend_s *be, enum hw_qsl_e field, uint32_t index,
 	uint32_t value)
 {
 	return hw_mod_qsl_unmq_mod(be, field, index, &value, 0);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
index 4741a2e310..20ce217614 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
@@ -11,12 +11,12 @@
 #define _MOD_ "SLC_LR"
 #define _VER_ be->slc_lr.ver
 
-bool hw_mod_slc_lr_present(struct flow_api_backend_s *be)
+bool nthw_mod_slc_lr_present(struct flow_api_backend_s *be)
 {
 	return be->iface->get_slc_lr_present(be->be_dev);
 }
 
-int hw_mod_slc_lr_alloc(struct flow_api_backend_s *be)
+int nthw_mod_slc_lr_alloc(struct flow_api_backend_s *be)
 {
 	_VER_ = be->iface->get_slc_lr_version(be->be_dev);
 	NT_LOG(DBG, FILTER, "SLC LR MODULE VERSION  %i.%i", VER_MAJOR(_VER_), VER_MINOR(_VER_));
@@ -37,7 +37,7 @@ int hw_mod_slc_lr_alloc(struct flow_api_backend_s *be)
 	return 0;
 }
 
-void hw_mod_slc_lr_free(struct flow_api_backend_s *be)
+void nthw_mod_slc_lr_free(struct flow_api_backend_s *be)
 {
 	if (be->slc_lr.base) {
 		free(be->slc_lr.base);
@@ -45,16 +45,16 @@ void hw_mod_slc_lr_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_slc_lr_reset(struct flow_api_backend_s *be)
+int nthw_mod_slc_lr_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
 	nthw_zero_module_cache((struct common_func_s *)(&be->slc_lr));
 
 	NT_LOG(DBG, FILTER, "INIT SLC LR RCP");
-	return hw_mod_slc_lr_rcp_flush(be, 0, be->max_categories);
+	return nthw_mod_slc_lr_rcp_flush(be, 0, be->max_categories);
 }
 
-int hw_mod_slc_lr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_slc_lr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->max_categories;
@@ -161,7 +161,7 @@ static int hw_mod_slc_lr_rcp_mod(struct flow_api_backend_s *be, enum hw_slc_lr_e
 	return 0;
 }
 
-int hw_mod_slc_lr_rcp_set(struct flow_api_backend_s *be, enum hw_slc_lr_e field, uint32_t index,
+int nthw_mod_slc_lr_rcp_set(struct flow_api_backend_s *be, enum hw_slc_lr_e field, uint32_t index,
 	uint32_t value)
 {
 	return hw_mod_slc_lr_rcp_mod(be, field, index, &value, 0);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
index 1862d77350..b65e37ce7b 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
@@ -11,12 +11,12 @@
 #define _MOD_ "TPE"
 #define _VER_ be->tpe.ver
 
-bool hw_mod_tpe_present(struct flow_api_backend_s *be)
+bool nthw_mod_tpe_present(struct flow_api_backend_s *be)
 {
 	return be->iface->get_tpe_present(be->be_dev);
 }
 
-int hw_mod_tpe_alloc(struct flow_api_backend_s *be)
+int nthw_mod_tpe_alloc(struct flow_api_backend_s *be)
 {
 	int nb;
 	_VER_ = be->iface->get_tpe_version(be->be_dev);
@@ -107,7 +107,7 @@ int hw_mod_tpe_alloc(struct flow_api_backend_s *be)
 	return 0;
 }
 
-void hw_mod_tpe_free(struct flow_api_backend_s *be)
+void nthw_mod_tpe_free(struct flow_api_backend_s *be)
 {
 	if (be->tpe.base) {
 		free(be->tpe.base);
@@ -115,7 +115,7 @@ void hw_mod_tpe_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_tpe_reset(struct flow_api_backend_s *be)
+int nthw_mod_tpe_reset(struct flow_api_backend_s *be)
 {
 	int err = 0;
 
@@ -123,17 +123,17 @@ int hw_mod_tpe_reset(struct flow_api_backend_s *be)
 	nthw_zero_module_cache((struct common_func_s *)(&be->tpe));
 
 	NT_LOG(DBG, FILTER, "INIT TPE");
-	err |= hw_mod_tpe_rpp_rcp_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_ins_rcp_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_rpl_rcp_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_rpl_ext_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_rpl_rpl_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_cpy_rcp_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_hfu_rcp_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_csu_rcp_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_rpp_ifr_rcp_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_ifr_rcp_flush(be, 0, ALL_ENTRIES);
-	err |= hw_mod_tpe_ifr_counters_update(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_rpp_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_ins_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_rpl_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_rpl_ext_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_rpl_rpl_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_cpy_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_hfu_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_csu_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_rpp_ifr_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_ifr_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= nthw_mod_tpe_ifr_counters_update(be, 0, ALL_ENTRIES);
 
 	return err;
 }
@@ -142,7 +142,7 @@ int hw_mod_tpe_reset(struct flow_api_backend_s *be)
  * RPP_IFR_RCP
  */
 
-int hw_mod_tpe_rpp_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_rpp_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_ifr_categories;
@@ -197,7 +197,7 @@ static int hw_mod_tpe_rpp_ifr_rcp_mod(struct flow_api_backend_s *be, enum hw_tpe
 	return 0;
 }
 
-int hw_mod_tpe_rpp_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpp_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_rpp_ifr_rcp_mod(be, field, index, &value, 0);
@@ -207,7 +207,7 @@ int hw_mod_tpe_rpp_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e fiel
  * RPP_RCP
  */
 
-int hw_mod_tpe_rpp_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_rpp_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_rcp_categories;
@@ -290,7 +290,7 @@ static int hw_mod_tpe_rpp_rcp_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_rpp_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpp_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_rpp_rcp_mod(be, field, index, &value, 0);
@@ -300,7 +300,7 @@ int hw_mod_tpe_rpp_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
  * IFR_RCP
  */
 
-int hw_mod_tpe_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_ifr_categories;
@@ -355,7 +355,7 @@ static int hw_mod_tpe_ifr_rcp_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_ifr_rcp_mod(be, field, index, &value, 0);
@@ -365,7 +365,7 @@ int hw_mod_tpe_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
  * IFR_COUNTER
  */
 
-int hw_mod_tpe_ifr_counters_update(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_ifr_counters_update(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_ifr_categories;
@@ -402,7 +402,7 @@ static int hw_mod_tpe_ifr_counters_mod(struct flow_api_backend_s *be, enum hw_tp
 	return 0;
 }
 
-int hw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t *value)
 {
 	return hw_mod_tpe_ifr_counters_mod(be, field, index, value, 1);
@@ -412,7 +412,7 @@ int hw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e fie
  * INS_RCP
  */
 
-int hw_mod_tpe_ins_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_ins_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_rcp_categories;
@@ -503,7 +503,7 @@ static int hw_mod_tpe_ins_rcp_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_ins_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_ins_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_ins_rcp_mod(be, field, index, &value, 0);
@@ -513,7 +513,7 @@ int hw_mod_tpe_ins_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
  * RPL_RCP
  */
 
-int hw_mod_tpe_rpl_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_rpl_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_rcp_categories;
@@ -616,7 +616,7 @@ static int hw_mod_tpe_rpl_rcp_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_rpl_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpl_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_rpl_rcp_mod(be, field, index, &value, 0);
@@ -626,7 +626,7 @@ int hw_mod_tpe_rpl_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
  * RPL_EXT
  */
 
-int hw_mod_tpe_rpl_ext_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_rpl_ext_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_rpl_ext_categories;
@@ -713,7 +713,7 @@ static int hw_mod_tpe_rpl_ext_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_rpl_ext_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpl_ext_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_rpl_ext_mod(be, field, index, &value, 0);
@@ -723,7 +723,7 @@ int hw_mod_tpe_rpl_ext_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
  * RPL_RPL
  */
 
-int hw_mod_tpe_rpl_rpl_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_rpl_rpl_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_rpl_depth;
@@ -813,7 +813,7 @@ static int hw_mod_tpe_rpl_rpl_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_rpl_rpl_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_rpl_rpl_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t *value)
 {
 	return hw_mod_tpe_rpl_rpl_mod(be, field, index, value, 0);
@@ -823,7 +823,7 @@ int hw_mod_tpe_rpl_rpl_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
  * CPY_RCP
  */
 
-int hw_mod_tpe_cpy_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_cpy_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	const uint32_t cpy_size = be->tpe.nb_cpy_writers * be->tpe.nb_rcp_categories;
 
@@ -922,7 +922,7 @@ static int hw_mod_tpe_cpy_rcp_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_cpy_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_cpy_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_cpy_rcp_mod(be, field, index, &value, 0);
@@ -932,7 +932,7 @@ int hw_mod_tpe_cpy_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
  * HFU_RCP
  */
 
-int hw_mod_tpe_hfu_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_hfu_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_rcp_categories;
@@ -1099,7 +1099,7 @@ static int hw_mod_tpe_hfu_rcp_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_hfu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_hfu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_hfu_rcp_mod(be, field, index, &value, 0);
@@ -1109,7 +1109,7 @@ int hw_mod_tpe_hfu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
  * CSU_RCP
  */
 
-int hw_mod_tpe_csu_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
+int nthw_mod_tpe_csu_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->tpe.nb_rcp_categories;
@@ -1204,7 +1204,7 @@ static int hw_mod_tpe_csu_rcp_mod(struct flow_api_backend_s *be, enum hw_tpe_e f
 	return 0;
 }
 
-int hw_mod_tpe_csu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+int nthw_mod_tpe_csu_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value)
 {
 	return hw_mod_tpe_csu_rcp_mod(be, field, index, &value, 0);
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index 18d550a327..b1a2d9dfa3 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -138,9 +138,9 @@ struct hw_db_inline_resource_db {
 	} match_set[HW_DB_INLINE_MATCH_SET_NB];
 };
 
-int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
+int nthw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 {
-	/* Note: calloc is required for functionality in the hw_db_inline_destroy() */
+	/* Note: calloc is required for functionality in the nthw_db_inline_destroy() */
 	struct hw_db_inline_resource_db *db = calloc(1, sizeof(struct hw_db_inline_resource_db));
 
 	if (db == NULL)
@@ -150,7 +150,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->cot = calloc(db->nb_cot, sizeof(struct hw_db_inline_resource_db_cot));
 
 	if (db->cot == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -158,7 +158,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->qsl = calloc(db->nb_qsl, sizeof(struct hw_db_inline_resource_db_qsl));
 
 	if (db->qsl == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -166,7 +166,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->slc_lr = calloc(db->nb_slc_lr, sizeof(struct hw_db_inline_resource_db_slc_lr));
 
 	if (db->slc_lr == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -174,7 +174,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->tpe = calloc(db->nb_tpe, sizeof(struct hw_db_inline_resource_db_tpe));
 
 	if (db->tpe == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -182,7 +182,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->tpe_ext = calloc(db->nb_tpe_ext, sizeof(struct hw_db_inline_resource_db_tpe_ext));
 
 	if (db->tpe_ext == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -190,7 +190,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->cat = calloc(db->nb_cat, sizeof(struct hw_db_inline_resource_db_cat));
 
 	if (db->cat == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -200,7 +200,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->flm = calloc(db->nb_flm_rcp, sizeof(struct hw_db_inline_resource_db_flm_rcp));
 
 	if (db->flm == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -209,7 +209,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 			calloc(db->nb_flm_ft, sizeof(struct hw_db_inline_resource_db_flm_ft));
 
 		if (db->flm[i].ft == NULL) {
-			hw_db_inline_destroy(db);
+			nthw_db_inline_destroy(db);
 			return -1;
 		}
 
@@ -217,7 +217,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 			calloc(db->nb_cat, sizeof(struct hw_db_inline_resource_db_flm_match_set));
 
 		if (db->flm[i].match_set == NULL) {
-			hw_db_inline_destroy(db);
+			nthw_db_inline_destroy(db);
 			return -1;
 		}
 
@@ -225,7 +225,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 			sizeof(struct hw_db_inline_resource_db_flm_cfn_map));
 
 		if (db->flm[i].cfn_map == NULL) {
-			hw_db_inline_destroy(db);
+			nthw_db_inline_destroy(db);
 			return -1;
 		}
 	}
@@ -235,7 +235,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->km = calloc(db->nb_km_rcp, sizeof(struct hw_db_inline_resource_db_km_rcp));
 
 	if (db->km == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -244,7 +244,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 			sizeof(struct hw_db_inline_resource_db_km_ft));
 
 		if (db->km[i].ft == NULL) {
-			hw_db_inline_destroy(db);
+			nthw_db_inline_destroy(db);
 			return -1;
 		}
 	}
@@ -252,7 +252,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->cfn = calloc(db->nb_cat, sizeof(struct hw_db_inline_resource_db_cfn));
 
 	if (db->cfn == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -260,7 +260,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->hsh = calloc(db->nb_hsh, sizeof(struct hw_db_inline_resource_db_hsh));
 
 	if (db->hsh == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -268,7 +268,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	db->scrub = calloc(db->nb_scrub, sizeof(struct hw_db_inline_resource_db_scrub));
 
 	if (db->scrub == NULL) {
-		hw_db_inline_destroy(db);
+		nthw_db_inline_destroy(db);
 		return -1;
 	}
 
@@ -283,7 +283,7 @@ int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle)
 	return 0;
 }
 
-void hw_db_inline_destroy(void *db_handle)
+void nthw_db_inline_destroy(void *db_handle)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
 
@@ -319,7 +319,7 @@ void hw_db_inline_destroy(void *db_handle)
 	free(db);
 }
 
-struct hw_db_idx *hw_db_inline_find_idx(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_idx *nthw_db_inline_find_idx(struct flow_nic_dev *ndev, void *db_handle,
 	enum hw_db_idx_type type, struct hw_db_idx *idxs, uint32_t size)
 {
 	(void)ndev;
@@ -332,7 +332,7 @@ struct hw_db_idx *hw_db_inline_find_idx(struct flow_nic_dev *ndev, void *db_hand
 	return NULL;
 }
 
-void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct hw_db_idx *idxs,
+void nthw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct hw_db_idx *idxs,
 	uint32_t size, FILE *file)
 {
 	(void)ndev;
@@ -563,7 +563,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 			fprintf(file, "  FLM_RCP %" PRIu32 "\n", idxs[i].id1);
 			fprintf(file, "  SCRUB %" PRIu32 "\n", idxs[i].ids);
 			fprintf(file, "    Timeout: %" PRIu32 ", encoded timeout: %" PRIu32 "\n",
-				hw_mod_flm_scrub_timeout_decode(data->timeout), data->timeout);
+				nthw_mod_flm_scrub_timeout_decode(data->timeout), data->timeout);
 			break;
 		}
 
@@ -614,7 +614,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 	}
 }
 
-void hw_db_inline_dump_cfn(struct flow_nic_dev *ndev, void *db_handle, FILE *file)
+void nthw_db_inline_dump_cfn(struct flow_nic_dev *ndev, void *db_handle, FILE *file)
 {
 	(void)ndev;
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -627,7 +627,7 @@ void hw_db_inline_dump_cfn(struct flow_nic_dev *ndev, void *db_handle, FILE *fil
 				db->cfn[id].cfn_hw, db->cfn[id].priority);
 }
 
-const void *hw_db_inline_find_data(struct flow_nic_dev *ndev, void *db_handle,
+const void *nthw_db_inline_find_data(struct flow_nic_dev *ndev, void *db_handle,
 	enum hw_db_idx_type type, struct hw_db_idx *idxs, uint32_t size)
 {
 	(void)ndev;
@@ -715,13 +715,13 @@ static void hw_db_set_ft(struct flow_nic_dev *ndev, int type, int cfn_index, int
 
 	switch (type) {
 	case HW_DB_FT_TYPE_FLM:
-		hw_mod_cat_fte_flm_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST, fte_index,
-			&current_bm);
+		nthw_mod_cat_fte_flm_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+			fte_index, &current_bm);
 		break;
 
 	case HW_DB_FT_TYPE_KM:
-		hw_mod_cat_fte_km_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST, fte_index,
-			&current_bm);
+		nthw_mod_cat_fte_km_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+			fte_index, &current_bm);
 		break;
 
 	default:
@@ -733,15 +733,15 @@ static void hw_db_set_ft(struct flow_nic_dev *ndev, int type, int cfn_index, int
 	if (current_bm != final_bm) {
 		switch (type) {
 		case HW_DB_FT_TYPE_FLM:
-			hw_mod_cat_fte_flm_set(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+			nthw_mod_cat_fte_flm_set(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
 				fte_index, final_bm);
-			hw_mod_cat_fte_flm_flush(&ndev->be, KM_FLM_IF_FIRST, fte_index, 1);
+			nthw_mod_cat_fte_flm_flush(&ndev->be, KM_FLM_IF_FIRST, fte_index, 1);
 			break;
 
 		case HW_DB_FT_TYPE_KM:
-			hw_mod_cat_fte_km_set(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+			nthw_mod_cat_fte_km_set(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
 				fte_index, final_bm);
-			hw_mod_cat_fte_km_flush(&ndev->be, KM_FLM_IF_FIRST, fte_index, 1);
+			nthw_mod_cat_fte_km_flush(&ndev->be, KM_FLM_IF_FIRST, fte_index, 1);
 			break;
 
 		default:
@@ -761,7 +761,7 @@ static void hw_db_set_ft(struct flow_nic_dev *ndev, int type, int cfn_index, int
  * Note: QSL recipe 0 uses DISCARD in order to allow for exception paths (UNMQ)
  *       Consequently another QSL recipe with hard DROP is needed
  */
-int hw_db_inline_setup_mbr_filter(struct flow_nic_dev *ndev, uint32_t cat_hw_id, uint32_t ft,
+int nthw_db_inline_setup_mbr_filter(struct flow_nic_dev *ndev, uint32_t cat_hw_id, uint32_t ft,
 	uint32_t qsl_hw_id)
 {
 	(void)ft;
@@ -772,23 +772,23 @@ int hw_db_inline_setup_mbr_filter(struct flow_nic_dev *ndev, uint32_t cat_hw_id,
 	(void)offset;
 
 	/* QSL for traffic policing */
-	if (hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_DROP, qsl_hw_id, 0x3) < 0)
+	if (nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_DROP, qsl_hw_id, 0x3) < 0)
 		return -1;
 
-	if (hw_mod_qsl_rcp_flush(&ndev->be, qsl_hw_id, 1) < 0)
+	if (nthw_mod_qsl_rcp_flush(&ndev->be, qsl_hw_id, 1) < 0)
 		return -1;
 
 	/* Select and enable QSL recipe */
-	if (hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 1, qsl_hw_id))
+	if (nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 1, qsl_hw_id))
 		return -1;
 
-	if (hw_mod_cat_cts_flush(&ndev->be, offset * cat_hw_id, 6))
+	if (nthw_mod_cat_cts_flush(&ndev->be, offset * cat_hw_id, 6))
 		return -1;
 
-	if (hw_mod_cat_cte_set(&ndev->be, HW_CAT_CTE_ENABLE_BM, cat_hw_id, 0x8))
+	if (nthw_mod_cat_cte_set(&ndev->be, HW_CAT_CTE_ENABLE_BM, cat_hw_id, 0x8))
 		return -1;
 
-	if (hw_mod_cat_cte_flush(&ndev->be, cat_hw_id, 1))
+	if (nthw_mod_cat_cte_flush(&ndev->be, cat_hw_id, 1))
 		return -1;
 
 	/* KM: Match all FTs for look-up A */
@@ -803,26 +803,26 @@ int hw_db_inline_setup_mbr_filter(struct flow_nic_dev *ndev, uint32_t cat_hw_id,
 	hw_db_set_ft(ndev, HW_DB_FT_TYPE_FLM, cat_hw_id, HW_DB_FT_LOOKUP_KEY_C, ft, 1);
 
 	/* Make all CFN checks TRUE */
-	if (hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_SET_ALL_DEFAULTS, cat_hw_id, 0, 0))
+	if (nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_SET_ALL_DEFAULTS, cat_hw_id, 0, 0))
 		return -1;
 
-	if (hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cat_hw_id, 0, 0x1))
+	if (nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cat_hw_id, 0, 0x1))
 		return -1;
 
-	if (hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L3, cat_hw_id, 0, 0x0))
+	if (nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L3, cat_hw_id, 0, 0x0))
 		return -1;
 
-	if (hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_INV, cat_hw_id, 0, 0x1))
+	if (nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_INV, cat_hw_id, 0, 0x1))
 		return -1;
 
 	/* Final match: look-up_A == TRUE && look-up_C == TRUE */
-	if (hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_KM0_OR, cat_hw_id, 0, 0x1))
+	if (nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_KM0_OR, cat_hw_id, 0, 0x1))
 		return -1;
 
-	if (hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_KM1_OR, cat_hw_id, 0, 0x3))
+	if (nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_KM1_OR, cat_hw_id, 0, 0x3))
 		return -1;
 
-	if (hw_mod_cat_cfn_flush(&ndev->be, cat_hw_id, 1))
+	if (nthw_mod_cat_cfn_flush(&ndev->be, cat_hw_id, 1))
 		return -1;
 
 	return 0;
@@ -833,12 +833,12 @@ static void hw_db_inline_setup_default_flm_rcp(struct flow_nic_dev *ndev, int fl
 	uint32_t flm_mask[10];
 	memset(flm_mask, 0xff, sizeof(flm_mask));
 
-	hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, flm_rcp, 0x0);
-	hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_LOOKUP, flm_rcp, 1);
-	hw_mod_flm_rcp_set_mask(&ndev->be, HW_FLM_RCP_MASK, flm_rcp, flm_mask);
-	hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_KID, flm_rcp, flm_rcp + 2);
+	nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, flm_rcp, 0x0);
+	nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_LOOKUP, flm_rcp, 1);
+	nthw_mod_flm_rcp_set_mask(&ndev->be, HW_FLM_RCP_MASK, flm_rcp, flm_mask);
+	nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_KID, flm_rcp, flm_rcp + 2);
 
-	hw_mod_flm_rcp_flush(&ndev->be, flm_rcp, 1);
+	nthw_mod_flm_rcp_flush(&ndev->be, flm_rcp, 1);
 }
 
 
@@ -861,16 +861,16 @@ static void hw_db_copy_ft(struct flow_nic_dev *ndev, int type, int cfn_dst, int
 
 	switch (type) {
 	case HW_DB_FT_TYPE_FLM:
-		hw_mod_cat_fte_flm_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_fte_flm_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
 			fte_index_dst, &current_bm_dst);
-		hw_mod_cat_fte_flm_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_fte_flm_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
 			fte_index_src, &current_bm_src);
 		break;
 
 	case HW_DB_FT_TYPE_KM:
-		hw_mod_cat_fte_km_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_fte_km_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
 			fte_index_dst, &current_bm_dst);
-		hw_mod_cat_fte_km_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_fte_km_get(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
 			fte_index_src, &current_bm_src);
 		break;
 
@@ -885,15 +885,15 @@ static void hw_db_copy_ft(struct flow_nic_dev *ndev, int type, int cfn_dst, int
 	if (current_bm_dst != final_bm_dst) {
 		switch (type) {
 		case HW_DB_FT_TYPE_FLM:
-			hw_mod_cat_fte_flm_set(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+			nthw_mod_cat_fte_flm_set(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
 				fte_index_dst, final_bm_dst);
-			hw_mod_cat_fte_flm_flush(&ndev->be, KM_FLM_IF_FIRST, fte_index_dst, 1);
+			nthw_mod_cat_fte_flm_flush(&ndev->be, KM_FLM_IF_FIRST, fte_index_dst, 1);
 			break;
 
 		case HW_DB_FT_TYPE_KM:
-			hw_mod_cat_fte_km_set(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
+			nthw_mod_cat_fte_km_set(&ndev->be, HW_CAT_FTE_ENABLE_BM, KM_FLM_IF_FIRST,
 				fte_index_dst, final_bm_dst);
-			hw_mod_cat_fte_km_flush(&ndev->be, KM_FLM_IF_FIRST, fte_index_dst, 1);
+			nthw_mod_cat_fte_km_flush(&ndev->be, KM_FLM_IF_FIRST, fte_index_dst, 1);
 			break;
 
 		default:
@@ -938,118 +938,122 @@ static int hw_db_inline_filter_apply(struct flow_nic_dev *ndev,
 
 	/* Setup CAT.CFN */
 	{
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_SET_ALL_DEFAULTS, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_INV, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_SET_ALL_DEFAULTS, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_INV, cat_hw_id, 0, 0x0);
 
 		/* Protocol checks */
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_INV, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_ISL, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_CFP, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_MAC, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L2, cat_hw_id, 0, cat->ptc_mask_l2);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_VNTAG, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_VLAN, cat_hw_id, 0, cat->vlan_mask);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_MPLS, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L3, cat_hw_id, 0, cat->ptc_mask_l3);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_FRAG, cat_hw_id, 0,
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_INV, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_ISL, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_CFP, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_MAC, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L2, cat_hw_id, 0, cat->ptc_mask_l2);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_VNTAG, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_VLAN, cat_hw_id, 0, cat->vlan_mask);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_MPLS, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L3, cat_hw_id, 0, cat->ptc_mask_l3);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_FRAG, cat_hw_id, 0,
 			cat->ptc_mask_frag);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_IP_PROT, cat_hw_id, 0, cat->ip_prot);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L4, cat_hw_id, 0, cat->ptc_mask_l4);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TUNNEL, cat_hw_id, 0,
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_IP_PROT, cat_hw_id, 0, cat->ip_prot);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L4, cat_hw_id, 0, cat->ptc_mask_l4);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TUNNEL, cat_hw_id, 0,
 			cat->ptc_mask_tunnel);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L2, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_VLAN, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_MPLS, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L3, cat_hw_id, 0,
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L2, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_VLAN, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_MPLS, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L3, cat_hw_id, 0,
 			cat->ptc_mask_l3_tunnel);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_FRAG, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_IP_PROT, cat_hw_id, 0,
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_FRAG, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_IP_PROT, cat_hw_id, 0,
 			cat->ip_prot_tunnel);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L4, cat_hw_id, 0,
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L4, cat_hw_id, 0,
 			cat->ptc_mask_l4_tunnel);
 
 		/* Error checks */
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_INV, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_CV, cat_hw_id, 0, 0x1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_FCS, cat_hw_id, 0, 0x1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TRUNC, cat_hw_id, 0, 0x1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_L3_CS, cat_hw_id, 0, 0x1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_L4_CS, cat_hw_id, 0, 0x1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TNL_L3_CS, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TNL_L4_CS, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TTL_EXP, cat_hw_id, 0,
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_INV, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_CV, cat_hw_id, 0, 0x1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_FCS, cat_hw_id, 0, 0x1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TRUNC, cat_hw_id, 0, 0x1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_L3_CS, cat_hw_id, 0, 0x1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_L4_CS, cat_hw_id, 0, 0x1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TNL_L3_CS, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TNL_L4_CS, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TTL_EXP, cat_hw_id, 0,
 			cat->err_mask_ttl);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TNL_TTL_EXP, cat_hw_id, 0,
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ERR_TNL_TTL_EXP, cat_hw_id, 0,
 			cat->err_mask_ttl_tunnel);
 
 		/* MAC port check */
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_MAC_PORT, cat_hw_id, 0,
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_MAC_PORT, cat_hw_id, 0,
 			cat->mac_port_mask);
 
 		/* Pattern match checks */
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_CMP, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_DCT, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_EXT_INV, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_CMB, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_AND_INV, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_OR_INV, cat_hw_id, 0, -1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_INV, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_CMP, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_DCT, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_EXT_INV, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_CMB, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_AND_INV, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_OR_INV, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PM_INV, cat_hw_id, 0, -1);
 
 		/* Length checks */
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_LC, cat_hw_id, 0, 0x0);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_LC_INV, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_LC, cat_hw_id, 0, 0x0);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_LC_INV, cat_hw_id, 0, -1);
 
 		/* KM and FLM */
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_KM0_OR, cat_hw_id, 0, 0x1);
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_KM1_OR, cat_hw_id, 0, 0x3);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_KM0_OR, cat_hw_id, 0, 0x1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_KM1_OR, cat_hw_id, 0, 0x3);
 
-		hw_mod_cat_cfn_flush(&ndev->be, cat_hw_id, 1);
+		nthw_mod_cat_cfn_flush(&ndev->be, cat_hw_id, 1);
 	}
 
 	/* Setup CAT.CTS */
 	{
 		const int offset = ((int)ndev->be.cat.cts_num + 1) / 2;
 
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 0, cat_hw_id);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 0, 0);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 1, hsh_hw_id);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 1, qsl_hw_id);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 2, 0);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 2,
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 0,
+			cat_hw_id);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 0, 0);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 1,
+			hsh_hw_id);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 1,
+			qsl_hw_id);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 2, 0);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 2,
 			slc_lr_hw_id);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 3, 0);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 3, 0);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 4, 0);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 4, 0);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 5, tpe_hw_id);
-		hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 5, 0);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 3, 0);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 3, 0);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 4, 0);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 4, 0);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + 5,
+			tpe_hw_id);
+		nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + 5, 0);
 
-		hw_mod_cat_cts_flush(&ndev->be, offset * cat_hw_id, 6);
+		nthw_mod_cat_cts_flush(&ndev->be, offset * cat_hw_id, 6);
 	}
 
 	/* Setup CAT.CTE */
 	{
-		hw_mod_cat_cte_set(&ndev->be, HW_CAT_CTE_ENABLE_BM, cat_hw_id,
+		nthw_mod_cat_cte_set(&ndev->be, HW_CAT_CTE_ENABLE_BM, cat_hw_id,
 			0x001 | 0x004 | (qsl_hw_id ? 0x008 : 0) |
 			(slc_lr_hw_id ? 0x020 : 0) | 0x040 |
 			(tpe_hw_id ? 0x400 : 0));
-		hw_mod_cat_cte_flush(&ndev->be, cat_hw_id, 1);
+		nthw_mod_cat_cte_flush(&ndev->be, cat_hw_id, 1);
 	}
 
 	/* Setup CAT.KM */
 	{
 		uint32_t bm = 0;
 
-		hw_mod_cat_kcs_km_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cat_hw_id,
+		nthw_mod_cat_kcs_km_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cat_hw_id,
 			km_rcp);
-		hw_mod_cat_kcs_km_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id, 1);
+		nthw_mod_cat_kcs_km_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id, 1);
 
-		hw_mod_cat_kce_km_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_km_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cat_hw_id / 8, &bm);
-		hw_mod_cat_kce_km_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_km_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cat_hw_id / 8, bm | (1 << (cat_hw_id % 8)));
-		hw_mod_cat_kce_km_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id / 8, 1);
+		nthw_mod_cat_kce_km_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id / 8, 1);
 
 		hw_db_set_ft(ndev, HW_DB_FT_TYPE_KM, cat_hw_id, HW_DB_FT_LOOKUP_KEY_A, km_ft, 1);
 	}
@@ -1058,15 +1062,15 @@ static int hw_db_inline_filter_apply(struct flow_nic_dev *ndev,
 	{
 		uint32_t bm = 0;
 
-		hw_mod_cat_kcs_flm_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cat_hw_id,
+		nthw_mod_cat_kcs_flm_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cat_hw_id,
 			flm_rcp);
-		hw_mod_cat_kcs_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id, 1);
+		nthw_mod_cat_kcs_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id, 1);
 
-		hw_mod_cat_kce_flm_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_flm_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cat_hw_id / 8, &bm);
-		hw_mod_cat_kce_flm_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_flm_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cat_hw_id / 8, bm | (1 << (cat_hw_id % 8)));
-		hw_mod_cat_kce_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id / 8, 1);
+		nthw_mod_cat_kce_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id / 8, 1);
 
 		hw_db_set_ft(ndev, HW_DB_FT_TYPE_FLM, cat_hw_id, HW_DB_FT_LOOKUP_KEY_A, km_ft, 1);
 		hw_db_set_ft(ndev, HW_DB_FT_TYPE_FLM, cat_hw_id, HW_DB_FT_LOOKUP_KEY_C, flm_ft, 1);
@@ -1074,15 +1078,15 @@ static int hw_db_inline_filter_apply(struct flow_nic_dev *ndev,
 
 	/* Setup CAT.COT */
 	{
-		hw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, cat_hw_id, 0);
-		hw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_COLOR, cat_hw_id, cot->frag_rcp << 10);
-		hw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_KM, cat_hw_id,
+		nthw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, cat_hw_id, 0);
+		nthw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_COLOR, cat_hw_id, cot->frag_rcp << 10);
+		nthw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_KM, cat_hw_id,
 			cot->matcher_color_contrib);
-		hw_mod_cat_cot_flush(&ndev->be, cat_hw_id, 1);
+		nthw_mod_cat_cot_flush(&ndev->be, cat_hw_id, 1);
 	}
 
-	hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cat_hw_id, 0, 0x1);
-	hw_mod_cat_cfn_flush(&ndev->be, cat_hw_id, 1);
+	nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cat_hw_id, 0, 0x1);
+	nthw_mod_cat_cfn_flush(&ndev->be, cat_hw_id, 1);
 
 	return 0;
 }
@@ -1092,40 +1096,42 @@ static void hw_db_inline_filter_clear(struct flow_nic_dev *ndev,
 	int cat_hw_id)
 {
 	/* Setup CAT.CFN */
-	hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_SET_ALL_DEFAULTS, cat_hw_id, 0, 0x0);
-	hw_mod_cat_cfn_flush(&ndev->be, cat_hw_id, 1);
+	nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_SET_ALL_DEFAULTS, cat_hw_id, 0, 0x0);
+	nthw_mod_cat_cfn_flush(&ndev->be, cat_hw_id, 1);
 
 	/* Setup CAT.CTS */
 	{
 		const int offset = ((int)ndev->be.cat.cts_num + 1) / 2;
 
 		for (int i = 0; i < 6; ++i) {
-			hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cat_hw_id + i, 0);
-			hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cat_hw_id + i, 0);
+			nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A,
+				offset * cat_hw_id + i, 0);
+			nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B,
+				offset * cat_hw_id + i, 0);
 		}
 
-		hw_mod_cat_cts_flush(&ndev->be, offset * cat_hw_id, 6);
+		nthw_mod_cat_cts_flush(&ndev->be, offset * cat_hw_id, 6);
 	}
 
 	/* Setup CAT.CTE */
 	{
-		hw_mod_cat_cte_set(&ndev->be, HW_CAT_CTE_ENABLE_BM, cat_hw_id, 0);
-		hw_mod_cat_cte_flush(&ndev->be, cat_hw_id, 1);
+		nthw_mod_cat_cte_set(&ndev->be, HW_CAT_CTE_ENABLE_BM, cat_hw_id, 0);
+		nthw_mod_cat_cte_flush(&ndev->be, cat_hw_id, 1);
 	}
 
 	/* Setup CAT.KM */
 	{
 		uint32_t bm = 0;
 
-		hw_mod_cat_kcs_km_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cat_hw_id,
+		nthw_mod_cat_kcs_km_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cat_hw_id,
 			0);
-		hw_mod_cat_kcs_km_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id, 1);
+		nthw_mod_cat_kcs_km_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id, 1);
 
-		hw_mod_cat_kce_km_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_km_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cat_hw_id / 8, &bm);
-		hw_mod_cat_kce_km_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_km_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cat_hw_id / 8, bm & ~(1 << (cat_hw_id % 8)));
-		hw_mod_cat_kce_km_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id / 8, 1);
+		nthw_mod_cat_kce_km_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id / 8, 1);
 
 		for (int ft = 0; ft < (int)db->nb_km_ft; ++ft) {
 			hw_db_set_ft(ndev, HW_DB_FT_TYPE_KM, cat_hw_id, HW_DB_FT_LOOKUP_KEY_A, ft,
@@ -1137,15 +1143,15 @@ static void hw_db_inline_filter_clear(struct flow_nic_dev *ndev,
 	{
 		uint32_t bm = 0;
 
-		hw_mod_cat_kcs_flm_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cat_hw_id,
+		nthw_mod_cat_kcs_flm_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cat_hw_id,
 			0);
-		hw_mod_cat_kcs_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id, 1);
+		nthw_mod_cat_kcs_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id, 1);
 
-		hw_mod_cat_kce_flm_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_flm_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cat_hw_id / 8, &bm);
-		hw_mod_cat_kce_flm_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_flm_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cat_hw_id / 8, bm & ~(1 << (cat_hw_id % 8)));
-		hw_mod_cat_kce_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id / 8, 1);
+		nthw_mod_cat_kce_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cat_hw_id / 8, 1);
 
 		for (int ft = 0; ft < (int)db->nb_flm_ft; ++ft) {
 			hw_db_set_ft(ndev, HW_DB_FT_TYPE_FLM, cat_hw_id, HW_DB_FT_LOOKUP_KEY_A, ft,
@@ -1155,8 +1161,8 @@ static void hw_db_inline_filter_clear(struct flow_nic_dev *ndev,
 		}
 	}
 
-	hw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, cat_hw_id, 0);
-	hw_mod_cat_cot_flush(&ndev->be, cat_hw_id, 1);
+	nthw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, cat_hw_id, 0);
+	nthw_mod_cat_cot_flush(&ndev->be, cat_hw_id, 1);
 }
 
 static void hw_db_inline_filter_copy(struct flow_nic_dev *ndev,
@@ -1164,54 +1170,56 @@ static void hw_db_inline_filter_copy(struct flow_nic_dev *ndev,
 {
 	uint32_t val = 0;
 
-	hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_COPY_FROM, cfn_dst, 0, cfn_src);
-	hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cfn_dst, 0, 0x0);
-	hw_mod_cat_cfn_flush(&ndev->be, cfn_dst, 1);
+	nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_COPY_FROM, cfn_dst, 0, cfn_src);
+	nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cfn_dst, 0, 0x0);
+	nthw_mod_cat_cfn_flush(&ndev->be, cfn_dst, 1);
 
 	/* Setup CAT.CTS */
 	{
 		const int offset = ((int)ndev->be.cat.cts_num + 1) / 2;
 
 		for (int i = 0; i < offset; ++i) {
-			hw_mod_cat_cts_get(&ndev->be, HW_CAT_CTS_CAT_A, offset * cfn_src + i,
-				&val);
-			hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A, offset * cfn_dst + i, val);
-			hw_mod_cat_cts_get(&ndev->be, HW_CAT_CTS_CAT_B, offset * cfn_src + i,
-				&val);
-			hw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B, offset * cfn_dst + i, val);
+			nthw_mod_cat_cts_get(&ndev->be, HW_CAT_CTS_CAT_A,
+				offset * cfn_src + i, &val);
+			nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_A,
+				offset * cfn_dst + i, val);
+			nthw_mod_cat_cts_get(&ndev->be, HW_CAT_CTS_CAT_B,
+				offset * cfn_src + i, &val);
+			nthw_mod_cat_cts_set(&ndev->be, HW_CAT_CTS_CAT_B,
+				offset * cfn_dst + i, val);
 		}
 
-		hw_mod_cat_cts_flush(&ndev->be, offset * cfn_dst, offset);
+		nthw_mod_cat_cts_flush(&ndev->be, offset * cfn_dst, offset);
 	}
 
 	/* Setup CAT.CTE */
 	{
-		hw_mod_cat_cte_get(&ndev->be, HW_CAT_CTE_ENABLE_BM, cfn_src, &val);
-		hw_mod_cat_cte_set(&ndev->be, HW_CAT_CTE_ENABLE_BM, cfn_dst, val);
-		hw_mod_cat_cte_flush(&ndev->be, cfn_dst, 1);
+		nthw_mod_cat_cte_get(&ndev->be, HW_CAT_CTE_ENABLE_BM, cfn_src, &val);
+		nthw_mod_cat_cte_set(&ndev->be, HW_CAT_CTE_ENABLE_BM, cfn_dst, val);
+		nthw_mod_cat_cte_flush(&ndev->be, cfn_dst, 1);
 	}
 
 	/* Setup CAT.KM */
 	{
 		uint32_t bit_src = 0;
 
-		hw_mod_cat_kcs_km_get(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cfn_src,
+		nthw_mod_cat_kcs_km_get(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cfn_src,
 			&val);
-		hw_mod_cat_kcs_km_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cfn_dst,
+		nthw_mod_cat_kcs_km_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cfn_dst,
 			val);
-		hw_mod_cat_kcs_km_flush(&ndev->be, KM_FLM_IF_FIRST, cfn_dst, 1);
+		nthw_mod_cat_kcs_km_flush(&ndev->be, KM_FLM_IF_FIRST, cfn_dst, 1);
 
-		hw_mod_cat_kce_km_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_km_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cfn_src / 8, &val);
 		bit_src = (val >> (cfn_src % 8)) & 0x1;
 
-		hw_mod_cat_kce_km_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_km_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cfn_dst / 8, &val);
 		val &= ~(1 << (cfn_dst % 8));
 
-		hw_mod_cat_kce_km_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_km_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cfn_dst / 8, val | (bit_src << (cfn_dst % 8)));
-		hw_mod_cat_kce_km_flush(&ndev->be, KM_FLM_IF_FIRST, cfn_dst / 8, 1);
+		nthw_mod_cat_kce_km_flush(&ndev->be, KM_FLM_IF_FIRST, cfn_dst / 8, 1);
 
 		for (int ft = 0; ft < (int)db->nb_km_ft; ++ft) {
 			hw_db_copy_ft(ndev, HW_DB_FT_TYPE_KM, cfn_dst, cfn_src,
@@ -1223,23 +1231,23 @@ static void hw_db_inline_filter_copy(struct flow_nic_dev *ndev,
 	{
 		uint32_t bit_src = 0;
 
-		hw_mod_cat_kcs_flm_get(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cfn_src,
+		nthw_mod_cat_kcs_flm_get(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cfn_src,
 			&val);
-		hw_mod_cat_kcs_flm_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cfn_dst,
+		nthw_mod_cat_kcs_flm_set(&ndev->be, HW_CAT_KCS_CATEGORY, KM_FLM_IF_FIRST, cfn_dst,
 			val);
-		hw_mod_cat_kcs_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cfn_dst, 1);
+		nthw_mod_cat_kcs_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cfn_dst, 1);
 
-		hw_mod_cat_kce_flm_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_flm_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cfn_src / 8, &val);
 		bit_src = (val >> (cfn_src % 8)) & 0x1;
 
-		hw_mod_cat_kce_flm_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_flm_get(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cfn_dst / 8, &val);
 		val &= ~(1 << (cfn_dst % 8));
 
-		hw_mod_cat_kce_flm_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
+		nthw_mod_cat_kce_flm_set(&ndev->be, HW_CAT_KCE_ENABLE_BM, KM_FLM_IF_FIRST,
 			cfn_dst / 8, val | (bit_src << (cfn_dst % 8)));
-		hw_mod_cat_kce_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cfn_dst / 8, 1);
+		nthw_mod_cat_kce_flm_flush(&ndev->be, KM_FLM_IF_FIRST, cfn_dst / 8, 1);
 
 		for (int ft = 0; ft < (int)db->nb_flm_ft; ++ft) {
 			hw_db_copy_ft(ndev, HW_DB_FT_TYPE_FLM, cfn_dst, cfn_src,
@@ -1251,12 +1259,12 @@ static void hw_db_inline_filter_copy(struct flow_nic_dev *ndev,
 
 	/* Setup CAT.COT */
 	{
-		hw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_COPY_FROM, cfn_dst, cfn_src);
-		hw_mod_cat_cot_flush(&ndev->be, cfn_dst, 1);
+		nthw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_COPY_FROM, cfn_dst, cfn_src);
+		nthw_mod_cat_cot_flush(&ndev->be, cfn_dst, 1);
 	}
 
-	hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cfn_dst, 0, 0x1);
-	hw_mod_cat_cfn_flush(&ndev->be, cfn_dst, 1);
+	nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_ENABLE, cfn_dst, 0, 0x1);
+	nthw_mod_cat_cfn_flush(&ndev->be, cfn_dst, 1);
 }
 
 /*
@@ -1443,7 +1451,7 @@ static void hw_db_inline_match_set_ref(struct flow_nic_dev *ndev, void *db_handl
 }
 
 struct hw_db_match_set_idx
-hw_db_inline_match_set_add(struct flow_nic_dev *ndev, void *db_handle,
+nthw_db_inline_match_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_match_set_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -1554,7 +1562,7 @@ static void hw_db_inline_action_set_ref(struct flow_nic_dev *ndev, void *db_hand
 }
 
 struct hw_db_action_set_idx
-hw_db_inline_action_set_add(struct flow_nic_dev *ndev, void *db_handle,
+nthw_db_inline_action_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_action_set_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -1626,7 +1634,7 @@ static void hw_db_inline_cot_ref(struct flow_nic_dev *ndev __rte_unused, void *d
 		db->cot[idx.ids].ref += 1;
 }
 
-struct hw_db_cot_idx hw_db_inline_cot_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_cot_idx nthw_db_inline_cot_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_cot_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -1724,7 +1732,7 @@ static void hw_db_inline_qsl_ref(struct flow_nic_dev *ndev, void *db_handle,
 		nthw_flow_nic_ref_resource(ndev, RES_QSL_RCP, idx.ids);
 }
 
-struct hw_db_qsl_idx hw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_qsl_idx nthw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_qsl_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -1771,48 +1779,49 @@ struct hw_db_qsl_idx hw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_ha
 	memcpy(&db->qsl[qsl_idx.ids].data, data, sizeof(struct hw_db_inline_qsl_data));
 	db->qsl[qsl_idx.ids].qst_idx = qst_idx;
 
-	hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_PRESET_ALL, qsl_idx.ids, 0x0);
+	nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_PRESET_ALL, qsl_idx.ids, 0x0);
 
-	hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_DISCARD, qsl_idx.ids, data->discard);
-	hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_DROP, qsl_idx.ids, data->drop * 0x3);
-	hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_LR, qsl_idx.ids, data->retransmit * 0x3);
+	nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_DISCARD, qsl_idx.ids, data->discard);
+	nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_DROP, qsl_idx.ids, data->drop * 0x3);
+	nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_LR, qsl_idx.ids, data->retransmit * 0x3);
 
 	if (data->table_size == 0) {
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_LO, qsl_idx.ids, 0x0);
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_HI, qsl_idx.ids, 0x0);
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_IDX, qsl_idx.ids, 0x0);
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_MSK, qsl_idx.ids, 0x0);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_LO, qsl_idx.ids, 0x0);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_HI, qsl_idx.ids, 0x0);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_IDX, qsl_idx.ids, 0x0);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_MSK, qsl_idx.ids, 0x0);
 
 	} else {
 		const uint32_t table_start = qst_idx;
 		const uint32_t table_end = table_start + data->table_size - 1;
 
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_LO, qsl_idx.ids, table_start);
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_HI, qsl_idx.ids, table_end);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_LO, qsl_idx.ids, table_start);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_HI, qsl_idx.ids, table_end);
 
 		/* Toeplitz hash function uses TBL_IDX and TBL_MSK. */
 		uint32_t msk = queue_mask(table_end - table_start + 1);
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_IDX, qsl_idx.ids, table_start);
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_MSK, qsl_idx.ids, msk);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_IDX, qsl_idx.ids, table_start);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_TBL_MSK, qsl_idx.ids, msk);
 
 		for (uint32_t i = 0; i < data->table_size; ++i) {
-			hw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_PRESET_ALL, table_start + i, 0x0);
+			nthw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_PRESET_ALL,
+				table_start + i, 0x0);
 
-			hw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_TX_PORT, table_start + i,
+			nthw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_TX_PORT, table_start + i,
 				data->table[i].tx_port);
-			hw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_LRE, table_start + i,
+			nthw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_LRE, table_start + i,
 				data->table[i].tx_port_en);
 
-			hw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_QUEUE, table_start + i,
+			nthw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_QUEUE, table_start + i,
 				data->table[i].queue);
-			hw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_EN, table_start + i,
+			nthw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_EN, table_start + i,
 				data->table[i].queue_en);
 		}
 
-		hw_mod_qsl_qst_flush(&ndev->be, table_start, data->table_size);
+		nthw_mod_qsl_qst_flush(&ndev->be, table_start, data->table_size);
 	}
 
-	hw_mod_qsl_rcp_flush(&ndev->be, qsl_idx.ids, 1);
+	nthw_mod_qsl_rcp_flush(&ndev->be, qsl_idx.ids, 1);
 
 	return qsl_idx;
 }
@@ -1828,19 +1837,19 @@ static void hw_db_inline_qsl_deref(struct flow_nic_dev *ndev, void *db_handle,
 	if (nthw_flow_nic_deref_resource(ndev, RES_QSL_RCP, idx.ids) == 0) {
 		const int table_size = (int)db->qsl[idx.ids].data.table_size;
 
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_PRESET_ALL, idx.ids, 0x0);
-		hw_mod_qsl_rcp_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_PRESET_ALL, idx.ids, 0x0);
+		nthw_mod_qsl_rcp_flush(&ndev->be, idx.ids, 1);
 
 		if (table_size > 0) {
 			const int table_start = db->qsl[idx.ids].qst_idx;
 
 			for (int i = 0; i < (int)table_size; ++i) {
-				hw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_PRESET_ALL,
+				nthw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_PRESET_ALL,
 					table_start + i, 0x0);
 				nthw_flow_nic_free_resource(ndev, RES_QSL_QST, table_start + i);
 			}
 
-			hw_mod_qsl_qst_flush(&ndev->be, table_start, table_size);
+			nthw_mod_qsl_qst_flush(&ndev->be, table_start, table_size);
 		}
 
 		memset(&db->qsl[idx.ids].data, 0x0, sizeof(struct hw_db_inline_qsl_data));
@@ -1873,7 +1882,7 @@ static void hw_db_inline_slc_lr_ref(struct flow_nic_dev *ndev, void *db_handle,
 		db->slc_lr[idx.ids].ref += 1;
 }
 
-struct hw_db_slc_lr_idx hw_db_inline_slc_lr_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_slc_lr_idx nthw_db_inline_slc_lr_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_slc_lr_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -1905,10 +1914,10 @@ struct hw_db_slc_lr_idx hw_db_inline_slc_lr_add(struct flow_nic_dev *ndev, void
 	db->slc_lr[idx.ids].ref = 1;
 	memcpy(&db->slc_lr[idx.ids].data, data, sizeof(struct hw_db_inline_slc_lr_data));
 
-	hw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_HEAD_SLC_EN, idx.ids, data->head_slice_en);
-	hw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_HEAD_DYN, idx.ids, data->head_slice_dyn);
-	hw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_HEAD_OFS, idx.ids, data->head_slice_ofs);
-	hw_mod_slc_lr_rcp_flush(&ndev->be, idx.ids, 1);
+	nthw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_HEAD_SLC_EN, idx.ids, data->head_slice_en);
+	nthw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_HEAD_DYN, idx.ids, data->head_slice_dyn);
+	nthw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_HEAD_OFS, idx.ids, data->head_slice_ofs);
+	nthw_mod_slc_lr_rcp_flush(&ndev->be, idx.ids, 1);
 
 	return idx;
 }
@@ -1924,8 +1933,8 @@ static void hw_db_inline_slc_lr_deref(struct flow_nic_dev *ndev, void *db_handle
 	db->slc_lr[idx.ids].ref -= 1;
 
 	if (db->slc_lr[idx.ids].ref <= 0) {
-		hw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_PRESET_ALL, idx.ids, 0x0);
-		hw_mod_slc_lr_rcp_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_PRESET_ALL, idx.ids, 0x0);
+		nthw_mod_slc_lr_rcp_flush(&ndev->be, idx.ids, 1);
 
 		memset(&db->slc_lr[idx.ids].data, 0x0, sizeof(struct hw_db_inline_slc_lr_data));
 		db->slc_lr[idx.ids].ref = 0;
@@ -1980,7 +1989,7 @@ static void hw_db_inline_tpe_ref(struct flow_nic_dev *ndev, void *db_handle,
 		db->tpe[idx.ids].ref += 1;
 }
 
-struct hw_db_tpe_idx hw_db_inline_tpe_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_tpe_idx nthw_db_inline_tpe_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_tpe_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2013,98 +2022,98 @@ struct hw_db_tpe_idx hw_db_inline_tpe_add(struct flow_nic_dev *ndev, void *db_ha
 	memcpy(&db->tpe[idx.ids].data, data, sizeof(struct hw_db_inline_tpe_data));
 
 	if (data->insert_len > 0) {
-		hw_mod_tpe_rpp_rcp_set(&ndev->be, HW_TPE_RPP_RCP_EXP, idx.ids, data->insert_len);
-		hw_mod_tpe_rpp_rcp_flush(&ndev->be, idx.ids, 1);
-
-		hw_mod_tpe_ins_rcp_set(&ndev->be, HW_TPE_INS_RCP_DYN, idx.ids, 1);
-		hw_mod_tpe_ins_rcp_set(&ndev->be, HW_TPE_INS_RCP_OFS, idx.ids, 0);
-		hw_mod_tpe_ins_rcp_set(&ndev->be, HW_TPE_INS_RCP_LEN, idx.ids, data->insert_len);
-		hw_mod_tpe_ins_rcp_flush(&ndev->be, idx.ids, 1);
-
-		hw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_DYN, idx.ids, 1);
-		hw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_OFS, idx.ids, 0);
-		hw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_LEN, idx.ids, data->insert_len);
-		hw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_RPL_PTR, idx.ids, 0);
-		hw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_EXT_PRIO, idx.ids, 1);
-		hw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_ETH_TYPE_WR, idx.ids,
+		nthw_mod_tpe_rpp_rcp_set(&ndev->be, HW_TPE_RPP_RCP_EXP, idx.ids, data->insert_len);
+		nthw_mod_tpe_rpp_rcp_flush(&ndev->be, idx.ids, 1);
+
+		nthw_mod_tpe_ins_rcp_set(&ndev->be, HW_TPE_INS_RCP_DYN, idx.ids, 1);
+		nthw_mod_tpe_ins_rcp_set(&ndev->be, HW_TPE_INS_RCP_OFS, idx.ids, 0);
+		nthw_mod_tpe_ins_rcp_set(&ndev->be, HW_TPE_INS_RCP_LEN, idx.ids, data->insert_len);
+		nthw_mod_tpe_ins_rcp_flush(&ndev->be, idx.ids, 1);
+
+		nthw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_DYN, idx.ids, 1);
+		nthw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_OFS, idx.ids, 0);
+		nthw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_LEN, idx.ids, data->insert_len);
+		nthw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_RPL_PTR, idx.ids, 0);
+		nthw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_EXT_PRIO, idx.ids, 1);
+		nthw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_RPL_RCP_ETH_TYPE_WR, idx.ids,
 			data->calc_eth_type_from_inner_ip);
-		hw_mod_tpe_rpl_rcp_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_tpe_rpl_rcp_flush(&ndev->be, idx.ids, 1);
 	}
 
 	for (uint32_t i = 0; i < 6; ++i) {
 		if (data->writer[i].en) {
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_READER_SELECT,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_READER_SELECT,
 				idx.ids + db->nb_tpe * i,
 				data->writer[i].reader_select);
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_DYN,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_DYN,
 				idx.ids + db->nb_tpe * i, data->writer[i].dyn);
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_OFS,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_OFS,
 				idx.ids + db->nb_tpe * i, data->writer[i].ofs);
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_LEN,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_LEN,
 				idx.ids + db->nb_tpe * i, data->writer[i].len);
 
 		} else {
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_READER_SELECT,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_READER_SELECT,
 				idx.ids + db->nb_tpe * i, 0);
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_DYN,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_DYN,
 				idx.ids + db->nb_tpe * i, 0);
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_OFS,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_OFS,
 				idx.ids + db->nb_tpe * i, 0);
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_LEN,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_CPY_RCP_LEN,
 				idx.ids + db->nb_tpe * i, 0);
 		}
 
-		hw_mod_tpe_cpy_rcp_flush(&ndev->be, idx.ids + db->nb_tpe * i, 1);
+		nthw_mod_tpe_cpy_rcp_flush(&ndev->be, idx.ids + db->nb_tpe * i, 1);
 	}
 
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_WR, idx.ids, data->len_a_en);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_OUTER_L4_LEN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_WR, idx.ids, data->len_a_en);
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_OUTER_L4_LEN, idx.ids,
 		data->new_outer);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_POS_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_POS_DYN, idx.ids,
 		data->len_a_pos_dyn);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_POS_OFS, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_POS_OFS, idx.ids,
 		data->len_a_pos_ofs);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_ADD_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_ADD_DYN, idx.ids,
 		data->len_a_add_dyn);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_ADD_OFS, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_ADD_OFS, idx.ids,
 		data->len_a_add_ofs);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_SUB_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_A_SUB_DYN, idx.ids,
 		data->len_a_sub_dyn);
 
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_WR, idx.ids, data->len_b_en);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_POS_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_WR, idx.ids, data->len_b_en);
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_POS_DYN, idx.ids,
 		data->len_b_pos_dyn);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_POS_OFS, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_POS_OFS, idx.ids,
 		data->len_b_pos_ofs);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_ADD_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_ADD_DYN, idx.ids,
 		data->len_b_add_dyn);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_ADD_OFS, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_ADD_OFS, idx.ids,
 		data->len_b_add_ofs);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_SUB_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_B_SUB_DYN, idx.ids,
 		data->len_b_sub_dyn);
 
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_WR, idx.ids, data->len_c_en);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_POS_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_WR, idx.ids, data->len_c_en);
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_POS_DYN, idx.ids,
 		data->len_c_pos_dyn);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_POS_OFS, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_POS_OFS, idx.ids,
 		data->len_c_pos_ofs);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_ADD_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_ADD_DYN, idx.ids,
 		data->len_c_add_dyn);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_ADD_OFS, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_ADD_OFS, idx.ids,
 		data->len_c_add_ofs);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_SUB_DYN, idx.ids,
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_LEN_C_SUB_DYN, idx.ids,
 		data->len_c_sub_dyn);
 
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_TTL_WR, idx.ids, data->ttl_en);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_TTL_POS_DYN, idx.ids, data->ttl_dyn);
-	hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_TTL_POS_OFS, idx.ids, data->ttl_ofs);
-	hw_mod_tpe_hfu_rcp_flush(&ndev->be, idx.ids, 1);
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_TTL_WR, idx.ids, data->ttl_en);
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_TTL_POS_DYN, idx.ids, data->ttl_dyn);
+	nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_HFU_RCP_TTL_POS_OFS, idx.ids, data->ttl_ofs);
+	nthw_mod_tpe_hfu_rcp_flush(&ndev->be, idx.ids, 1);
 
-	hw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_CSU_RCP_OUTER_L3_CMD, idx.ids, 3);
-	hw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_CSU_RCP_OUTER_L4_CMD, idx.ids, 3);
-	hw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_CSU_RCP_INNER_L3_CMD, idx.ids, 3);
-	hw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_CSU_RCP_INNER_L4_CMD, idx.ids, 3);
-	hw_mod_tpe_csu_rcp_flush(&ndev->be, idx.ids, 1);
+	nthw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_CSU_RCP_OUTER_L3_CMD, idx.ids, 3);
+	nthw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_CSU_RCP_OUTER_L4_CMD, idx.ids, 3);
+	nthw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_CSU_RCP_INNER_L3_CMD, idx.ids, 3);
+	nthw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_CSU_RCP_INNER_L4_CMD, idx.ids, 3);
+	nthw_mod_tpe_csu_rcp_flush(&ndev->be, idx.ids, 1);
 
 	return idx;
 }
@@ -2121,25 +2130,25 @@ static void hw_db_inline_tpe_deref(struct flow_nic_dev *ndev, void *db_handle,
 
 	if (db->tpe[idx.ids].ref <= 0) {
 		for (uint32_t i = 0; i < 6; ++i) {
-			hw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_PRESET_ALL,
+			nthw_mod_tpe_cpy_rcp_set(&ndev->be, HW_TPE_PRESET_ALL,
 				idx.ids + db->nb_tpe * i, 0);
-			hw_mod_tpe_cpy_rcp_flush(&ndev->be, idx.ids + db->nb_tpe * i, 1);
+			nthw_mod_tpe_cpy_rcp_flush(&ndev->be, idx.ids + db->nb_tpe * i, 1);
 		}
 
-		hw_mod_tpe_rpp_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
-		hw_mod_tpe_rpp_rcp_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_tpe_rpp_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
+		nthw_mod_tpe_rpp_rcp_flush(&ndev->be, idx.ids, 1);
 
-		hw_mod_tpe_ins_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
-		hw_mod_tpe_ins_rcp_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_tpe_ins_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
+		nthw_mod_tpe_ins_rcp_flush(&ndev->be, idx.ids, 1);
 
-		hw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
-		hw_mod_tpe_rpl_rcp_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_tpe_rpl_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
+		nthw_mod_tpe_rpl_rcp_flush(&ndev->be, idx.ids, 1);
 
-		hw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
-		hw_mod_tpe_hfu_rcp_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_tpe_hfu_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
+		nthw_mod_tpe_hfu_rcp_flush(&ndev->be, idx.ids, 1);
 
-		hw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
-		hw_mod_tpe_csu_rcp_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_tpe_csu_rcp_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
+		nthw_mod_tpe_csu_rcp_flush(&ndev->be, idx.ids, 1);
 
 		memset(&db->tpe[idx.ids].data, 0x0, sizeof(struct hw_db_inline_tpe_data));
 		db->tpe[idx.ids].ref = 0;
@@ -2167,7 +2176,7 @@ static void hw_db_inline_tpe_ext_ref(struct flow_nic_dev *ndev, void *db_handle,
 		db->tpe_ext[idx.ids].ref += 1;
 }
 
-struct hw_db_tpe_ext_idx hw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_tpe_ext_idx nthw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_tpe_ext_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2213,18 +2222,18 @@ struct hw_db_tpe_ext_idx hw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, voi
 	db->tpe_ext[idx.ids].replace_ram_idx = rpl_rpl_index;
 	memcpy(&db->tpe_ext[idx.ids].data, data, sizeof(struct hw_db_inline_tpe_ext_data));
 
-	hw_mod_tpe_rpl_ext_set(&ndev->be, HW_TPE_RPL_EXT_RPL_PTR, idx.ids, rpl_rpl_index);
-	hw_mod_tpe_rpl_ext_set(&ndev->be, HW_TPE_RPL_EXT_META_RPL_LEN, idx.ids, data->size);
-	hw_mod_tpe_rpl_ext_flush(&ndev->be, idx.ids, 1);
+	nthw_mod_tpe_rpl_ext_set(&ndev->be, HW_TPE_RPL_EXT_RPL_PTR, idx.ids, rpl_rpl_index);
+	nthw_mod_tpe_rpl_ext_set(&ndev->be, HW_TPE_RPL_EXT_META_RPL_LEN, idx.ids, data->size);
+	nthw_mod_tpe_rpl_ext_flush(&ndev->be, idx.ids, 1);
 
 	for (int i = 0; i < rpl_rpl_length; ++i) {
 		uint32_t rpl_data[4];
 		memcpy(rpl_data, data->hdr32 + i * 4, sizeof(rpl_data));
-		hw_mod_tpe_rpl_rpl_set(&ndev->be, HW_TPE_RPL_RPL_VALUE, rpl_rpl_index + i,
+		nthw_mod_tpe_rpl_rpl_set(&ndev->be, HW_TPE_RPL_RPL_VALUE, rpl_rpl_index + i,
 			rpl_data);
 	}
 
-	hw_mod_tpe_rpl_rpl_flush(&ndev->be, rpl_rpl_index, rpl_rpl_length);
+	nthw_mod_tpe_rpl_rpl_flush(&ndev->be, rpl_rpl_index, rpl_rpl_length);
 
 	return idx;
 }
@@ -2243,17 +2252,17 @@ static void hw_db_inline_tpe_ext_deref(struct flow_nic_dev *ndev, void *db_handl
 		const int rpl_rpl_length = ((int)db->tpe_ext[idx.ids].data.size + 15) / 16;
 		const int rpl_rpl_index = db->tpe_ext[idx.ids].replace_ram_idx;
 
-		hw_mod_tpe_rpl_ext_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
-		hw_mod_tpe_rpl_ext_flush(&ndev->be, idx.ids, 1);
+		nthw_mod_tpe_rpl_ext_set(&ndev->be, HW_TPE_PRESET_ALL, idx.ids, 0);
+		nthw_mod_tpe_rpl_ext_flush(&ndev->be, idx.ids, 1);
 
 		for (int i = 0; i < rpl_rpl_length; ++i) {
 			uint32_t rpl_zero[] = { 0, 0, 0, 0 };
-			hw_mod_tpe_rpl_rpl_set(&ndev->be, HW_TPE_RPL_RPL_VALUE, rpl_rpl_index + i,
+			nthw_mod_tpe_rpl_rpl_set(&ndev->be, HW_TPE_RPL_RPL_VALUE, rpl_rpl_index + i,
 				rpl_zero);
 			nthw_flow_nic_free_resource(ndev, RES_TPE_RPL, rpl_rpl_index + i);
 		}
 
-		hw_mod_tpe_rpl_rpl_flush(&ndev->be, rpl_rpl_index, rpl_rpl_length);
+		nthw_mod_tpe_rpl_rpl_flush(&ndev->be, rpl_rpl_index, rpl_rpl_length);
 
 		memset(&db->tpe_ext[idx.ids].data, 0x0, sizeof(struct hw_db_inline_tpe_ext_data));
 		db->tpe_ext[idx.ids].ref = 0;
@@ -2292,7 +2301,7 @@ static int hw_db_inline_cat_compare(const struct hw_db_inline_cat_data *data1,
 		data1->ip_prot_tunnel == data2->ip_prot_tunnel;
 }
 
-struct hw_db_cat_idx hw_db_inline_cat_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_cat_idx nthw_db_inline_cat_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_cat_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2363,7 +2372,7 @@ static void hw_db_inline_km_ref(struct flow_nic_dev *ndev, void *db_handle, stru
 		db->km[idx.id1].ref += 1;
 }
 
-struct hw_db_km_idx hw_db_inline_km_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_km_idx nthw_db_inline_km_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_km_rcp_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2436,7 +2445,7 @@ static void hw_db_inline_km_ft_ref(struct flow_nic_dev *ndev, void *db_handle,
 	}
 }
 
-struct hw_db_km_ft hw_db_inline_km_ft_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_km_ft nthw_db_inline_km_ft_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_km_ft_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2533,7 +2542,7 @@ static void hw_db_inline_flm_ref(struct flow_nic_dev *ndev, void *db_handle,
 		db->flm[idx.id1].ref += 1;
 }
 
-struct hw_db_flm_idx hw_db_inline_flm_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_flm_idx nthw_db_inline_flm_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_rcp_data *data, int group)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2566,31 +2575,31 @@ struct hw_db_flm_idx hw_db_inline_flm_add(struct flow_nic_dev *ndev, void *db_ha
 			data->mask[9], data->mask[8], data->mask[7], data->mask[6],	/* QW0 */
 		};
 
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, idx.id1, 0x0);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_LOOKUP, idx.id1, 1);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, idx.id1, 0x0);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_LOOKUP, idx.id1, 1);
 
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW0_DYN, idx.id1, data->qw0_dyn);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW0_OFS, idx.id1, data->qw0_ofs);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW0_SEL, idx.id1, 0);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW4_DYN, idx.id1, data->qw4_dyn);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW4_OFS, idx.id1, data->qw4_ofs);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW0_DYN, idx.id1, data->qw0_dyn);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW0_OFS, idx.id1, data->qw0_ofs);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW0_SEL, idx.id1, 0);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW4_DYN, idx.id1, data->qw4_dyn);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_QW4_OFS, idx.id1, data->qw4_ofs);
 
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW8_DYN, idx.id1, data->sw8_dyn);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW8_OFS, idx.id1, data->sw8_ofs);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW8_SEL, idx.id1, 0);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW9_DYN, idx.id1, data->sw9_dyn);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW9_OFS, idx.id1, data->sw9_ofs);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW8_DYN, idx.id1, data->sw8_dyn);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW8_OFS, idx.id1, data->sw8_ofs);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW8_SEL, idx.id1, 0);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW9_DYN, idx.id1, data->sw9_dyn);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_SW9_OFS, idx.id1, data->sw9_ofs);
 
-		hw_mod_flm_rcp_set_mask(&ndev->be, HW_FLM_RCP_MASK, idx.id1, flm_mask);
+		nthw_mod_flm_rcp_set_mask(&ndev->be, HW_FLM_RCP_MASK, idx.id1, flm_mask);
 
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_KID, idx.id1, idx.id1 + 2);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_OPN, idx.id1, data->outer_prot ? 1 : 0);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_IPN, idx.id1, data->inner_prot ? 1 : 0);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_BYT_DYN, idx.id1, 0);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_BYT_OFS, idx.id1, -20);
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_TXPLM, idx.id1, UINT32_MAX);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_KID, idx.id1, idx.id1 + 2);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_OPN, idx.id1, data->outer_prot ? 1 : 0);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_IPN, idx.id1, data->inner_prot ? 1 : 0);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_BYT_DYN, idx.id1, 0);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_BYT_OFS, idx.id1, -20);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_TXPLM, idx.id1, UINT32_MAX);
 
-		hw_mod_flm_rcp_flush(&ndev->be, idx.id1, 1);
+		nthw_mod_flm_rcp_flush(&ndev->be, idx.id1, 1);
 	}
 
 	return idx;
@@ -2638,7 +2647,7 @@ static void hw_db_inline_flm_ft_ref(struct flow_nic_dev *ndev, void *db_handle,
 		db->flm[idx.id2].ft[idx.id1].ref += 1;
 }
 
-struct hw_db_flm_ft hw_db_inline_flm_ft_default(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_flm_ft nthw_db_inline_flm_ft_default(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_ft_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2673,7 +2682,7 @@ struct hw_db_flm_ft hw_db_inline_flm_ft_default(struct flow_nic_dev *ndev, void
 	return idx;
 }
 
-struct hw_db_flm_ft hw_db_inline_flm_ft_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_flm_ft nthw_db_inline_flm_ft_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_ft_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2776,7 +2785,7 @@ static void hw_db_inline_hsh_ref(struct flow_nic_dev *ndev, void *db_handle,
 		db->hsh[idx.ids].ref += 1;
 }
 
-struct hw_db_hsh_idx hw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_hsh_idx nthw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_hsh_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2832,7 +2841,7 @@ struct hw_db_hsh_idx hw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_ha
 	memcpy(&db->hsh[idx.ids].data, data, sizeof(struct hw_db_inline_hsh_data));
 	flow_nic_mark_resource_used(ndev, RES_HSH_RCP, idx.ids);
 
-	hw_mod_hsh_rcp_flush(&ndev->be, idx.ids, 1);
+	nthw_mod_hsh_rcp_flush(&ndev->be, idx.ids, 1);
 
 	return idx;
 }
@@ -2854,10 +2863,10 @@ static void hw_db_inline_hsh_deref(struct flow_nic_dev *ndev, void *db_handle,
 		 * it is not used by any flow
 		 */
 		if (idx.ids > 0) {
-			int res = hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL,
+			int res = nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL,
 				idx.ids, 0, 0x0);
 			NT_LOG(ERR, FILTER, "Failed to preset HSH RCP %u: %d", idx.ids, res);
-			hw_mod_hsh_rcp_flush(&ndev->be, idx.ids, 1);
+			nthw_mod_hsh_rcp_flush(&ndev->be, idx.ids, 1);
 
 			memset(&db->hsh[idx.ids].data, 0x0, sizeof(struct hw_db_inline_hsh_data));
 			nthw_flow_nic_free_resource(ndev, RES_HSH_RCP, idx.ids);
@@ -2888,7 +2897,7 @@ static void hw_db_inline_scrub_ref(struct flow_nic_dev *ndev, void *db_handle,
 		db->scrub[idx.ids].ref += 1;
 }
 
-struct hw_db_flm_scrub_idx hw_db_inline_scrub_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_flm_scrub_idx nthw_db_inline_scrub_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_scrub_data *data)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2924,11 +2933,11 @@ struct hw_db_flm_scrub_idx hw_db_inline_scrub_add(struct flow_nic_dev *ndev, voi
 		return idx;
 	}
 
-	int res = hw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_T, idx.ids, data->timeout);
-	res |= hw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_R, idx.ids,
+	int res = nthw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_T, idx.ids, data->timeout);
+	res |= nthw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_R, idx.ids,
 		NTNIC_SCANNER_TIMEOUT_RESOLUTION);
-	res |= hw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_DEL, idx.ids, SCRUB_DEL);
-	res |= hw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_INF, idx.ids, SCRUB_INF);
+	res |= nthw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_DEL, idx.ids, SCRUB_DEL);
+	res |= nthw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_INF, idx.ids, SCRUB_INF);
 
 	if (res != 0) {
 		idx.error = 1;
@@ -2939,7 +2948,7 @@ struct hw_db_flm_scrub_idx hw_db_inline_scrub_add(struct flow_nic_dev *ndev, voi
 	memcpy(&db->scrub[idx.ids].data, data, sizeof(struct hw_db_inline_scrub_data));
 	flow_nic_mark_resource_used(ndev, RES_SCRUB_RCP, idx.ids);
 
-	hw_mod_flm_scrub_flush(&ndev->be, idx.ids, 1);
+	nthw_mod_flm_scrub_flush(&ndev->be, idx.ids, 1);
 
 	return idx;
 }
@@ -2958,8 +2967,8 @@ static void hw_db_inline_scrub_deref(struct flow_nic_dev *ndev, void *db_handle,
 		/* NOTE: scrub id 0 is reserved for "default" timeout 0, which shall not be removed
 		 */
 		if (idx.ids > 0) {
-			hw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_T, idx.ids, 0);
-			hw_mod_flm_scrub_flush(&ndev->be, idx.ids, 1);
+			nthw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_T, idx.ids, 0);
+			nthw_mod_flm_scrub_flush(&ndev->be, idx.ids, 1);
 
 			memset(&db->scrub[idx.ids].data, 0x0,
 				sizeof(struct hw_db_inline_scrub_data));
@@ -2970,7 +2979,7 @@ static void hw_db_inline_scrub_deref(struct flow_nic_dev *ndev, void *db_handle,
 	}
 }
 
-void hw_db_inline_deref_idxs(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_idx *idxs,
+void nthw_db_inline_deref_idxs(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_idx *idxs,
 	uint32_t size)
 {
 	for (uint32_t i = 0; i < size; ++i) {
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
index e7f66dc075..b2bd2f6d2d 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
@@ -280,62 +280,62 @@ struct hw_db_inline_scrub_data {
 
 /**/
 
-int hw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle);
-void hw_db_inline_destroy(void *db_handle);
+int nthw_db_inline_create(struct flow_nic_dev *ndev, void **db_handle);
+void nthw_db_inline_destroy(void *db_handle);
 
-void hw_db_inline_deref_idxs(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_idx *idxs,
+void nthw_db_inline_deref_idxs(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_idx *idxs,
 	uint32_t size);
-const void *hw_db_inline_find_data(struct flow_nic_dev *ndev, void *db_handle,
+const void *nthw_db_inline_find_data(struct flow_nic_dev *ndev, void *db_handle,
 	enum hw_db_idx_type type, struct hw_db_idx *idxs, uint32_t size);
-struct hw_db_idx *hw_db_inline_find_idx(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_idx *nthw_db_inline_find_idx(struct flow_nic_dev *ndev, void *db_handle,
 	enum hw_db_idx_type type, struct hw_db_idx *idxs, uint32_t size);
-void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct hw_db_idx *idxs,
+void nthw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct hw_db_idx *idxs,
 	uint32_t size, FILE *file);
-void hw_db_inline_dump_cfn(struct flow_nic_dev *ndev, void *db_handle, FILE *file);
+void nthw_db_inline_dump_cfn(struct flow_nic_dev *ndev, void *db_handle, FILE *file);
 
 /**/
 
 struct hw_db_match_set_idx
-hw_db_inline_match_set_add(struct flow_nic_dev *ndev, void *db_handle,
+nthw_db_inline_match_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_match_set_data *data);
 struct hw_db_action_set_idx
-hw_db_inline_action_set_add(struct flow_nic_dev *ndev, void *db_handle,
+nthw_db_inline_action_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_action_set_data *data);
 /**/
 
-struct hw_db_cot_idx hw_db_inline_cot_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_cot_idx nthw_db_inline_cot_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_cot_data *data);
-struct hw_db_qsl_idx hw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_qsl_idx nthw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_qsl_data *data);
-struct hw_db_slc_lr_idx hw_db_inline_slc_lr_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_slc_lr_idx nthw_db_inline_slc_lr_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_slc_lr_data *data);
-struct hw_db_tpe_idx hw_db_inline_tpe_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_tpe_idx nthw_db_inline_tpe_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_tpe_data *data);
-struct hw_db_tpe_ext_idx hw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_tpe_ext_idx nthw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_tpe_ext_data *data);
-struct hw_db_hsh_idx hw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_hsh_idx nthw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_hsh_data *data);
 /**/
 
-struct hw_db_cat_idx hw_db_inline_cat_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_cat_idx nthw_db_inline_cat_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_cat_data *data);
 /**/
 
-struct hw_db_km_idx hw_db_inline_km_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_km_idx nthw_db_inline_km_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_km_rcp_data *data);
-struct hw_db_km_ft hw_db_inline_km_ft_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_km_ft nthw_db_inline_km_ft_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_km_ft_data *data);
 /**/
 
-struct hw_db_flm_idx hw_db_inline_flm_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_flm_idx nthw_db_inline_flm_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_rcp_data *data, int group);
-struct hw_db_flm_ft hw_db_inline_flm_ft_default(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_flm_ft nthw_db_inline_flm_ft_default(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_ft_data *data);
-struct hw_db_flm_ft hw_db_inline_flm_ft_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_flm_ft nthw_db_inline_flm_ft_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_ft_data *data);
-struct hw_db_flm_scrub_idx hw_db_inline_scrub_add(struct flow_nic_dev *ndev, void *db_handle,
+struct hw_db_flm_scrub_idx nthw_db_inline_scrub_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_scrub_data *data);
-int hw_db_inline_setup_mbr_filter(struct flow_nic_dev *ndev, uint32_t cat_hw_id, uint32_t ft,
+int nthw_db_inline_setup_mbr_filter(struct flow_nic_dev *ndev, uint32_t cat_hw_id, uint32_t ft,
 	uint32_t qsl_hw_id);
 
 #endif	/* _FLOW_API_HW_DB_INLINE_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 2291642ca9..71b9bcd3d7 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -94,7 +94,7 @@ static void *flm_lrn_queue_arr;
 
 static int flow_mtr_supported(struct flow_eth_dev *dev)
 {
-	return hw_mod_flm_present(&dev->ndev->be) && dev->ndev->be.flm.nb_variant == 2;
+	return nthw_mod_flm_present(&dev->ndev->be) && dev->ndev->be.flm.nb_variant == 2;
 }
 
 static uint64_t flow_mtr_meter_policy_n_max(void)
@@ -401,7 +401,7 @@ static uint32_t flm_lrn_update(struct flow_eth_dev *dev, uint32_t *inf_word_cnt,
 	uint32_t handled_records = 0;
 
 	if (r.num) {
-		if (hw_mod_flm_lrn_data_set_flush(&dev->ndev->be, HW_FLM_FLOW_LRN_DATA, r.p,
+		if (nthw_mod_flm_lrn_data_set_flush(&dev->ndev->be, HW_FLM_FLOW_LRN_DATA, r.p,
 			r.num, &handled_records, inf_word_cnt, sta_word_cnt))
 			NT_LOG(ERR, FILTER, "Flow programming failed");
 	}
@@ -546,7 +546,7 @@ static uint32_t flm_update(struct flow_eth_dev *dev)
 		if (sta_records > MAX_STA_DATA_RECORDS_PER_READ)
 			sta_records = MAX_STA_DATA_RECORDS_PER_READ;
 
-		hw_mod_flm_inf_sta_data_update_get(&dev->ndev->be, HW_FLM_FLOW_INF_STA_DATA,
+		nthw_mod_flm_inf_sta_data_update_get(&dev->ndev->be, HW_FLM_FLOW_INF_STA_DATA,
 			inf_data, inf_records * WORDS_PER_INF_DATA,
 			&inf_word_cnt, sta_data,
 			sta_records * WORDS_PER_STA_DATA,
@@ -564,9 +564,9 @@ static uint32_t flm_update(struct flow_eth_dev *dev)
 	if (flm_lrn_update(dev, &inf_word_cnt, &sta_word_cnt) != 0)
 		return 1;
 
-	hw_mod_flm_buf_ctrl_update(&dev->ndev->be);
-	hw_mod_flm_buf_ctrl_get(&dev->ndev->be, HW_FLM_BUF_CTRL_INF_AVAIL, &inf_word_cnt);
-	hw_mod_flm_buf_ctrl_get(&dev->ndev->be, HW_FLM_BUF_CTRL_STA_AVAIL, &sta_word_cnt);
+	nthw_mod_flm_buf_ctrl_update(&dev->ndev->be);
+	nthw_mod_flm_buf_ctrl_get(&dev->ndev->be, HW_FLM_BUF_CTRL_INF_AVAIL, &inf_word_cnt);
+	nthw_mod_flm_buf_ctrl_get(&dev->ndev->be, HW_FLM_BUF_CTRL_STA_AVAIL, &sta_word_cnt);
 
 	return inf_word_cnt + sta_word_cnt;
 }
@@ -626,15 +626,15 @@ static int flm_sdram_calibrate(struct flow_nic_dev *ndev)
 	uint32_t fail_value = 0;
 	uint32_t value = 0;
 
-	hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_PRESET_ALL, 0x0);
-	hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_SPLIT_SDRAM_USAGE, 0x10);
-	hw_mod_flm_control_flush(&ndev->be);
+	nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_PRESET_ALL, 0x0);
+	nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_SPLIT_SDRAM_USAGE, 0x10);
+	nthw_mod_flm_control_flush(&ndev->be);
 
 	/* Wait for ddr4 calibration/init done */
 	for (uint32_t i = 0; i < 1000000; ++i) {
-		hw_mod_flm_status_update(&ndev->be);
-		hw_mod_flm_status_get(&ndev->be, HW_FLM_STATUS_CALIB_SUCCESS, &value);
-		hw_mod_flm_status_get(&ndev->be, HW_FLM_STATUS_CALIB_FAIL, &fail_value);
+		nthw_mod_flm_status_update(&ndev->be);
+		nthw_mod_flm_status_get(&ndev->be, HW_FLM_STATUS_CALIB_SUCCESS, &value);
+		nthw_mod_flm_status_get(&ndev->be, HW_FLM_STATUS_CALIB_FAIL, &fail_value);
 
 		if (value & 0x80000000) {
 			success = 1;
@@ -666,19 +666,19 @@ static int flm_sdram_reset(struct flow_nic_dev *ndev, int enable)
 	 * Make sure no lookup is performed during init, i.e.
 	 * disable every category and disable FLM
 	 */
-	hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_ENABLE, 0x0);
-	hw_mod_flm_control_flush(&ndev->be);
+	nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_ENABLE, 0x0);
+	nthw_mod_flm_control_flush(&ndev->be);
 
 	for (uint32_t i = 1; i < ndev->be.flm.nb_categories; ++i)
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, i, 0x0);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, i, 0x0);
 
-	hw_mod_flm_rcp_flush(&ndev->be, 1, ndev->be.flm.nb_categories - 1);
+	nthw_mod_flm_rcp_flush(&ndev->be, 1, ndev->be.flm.nb_categories - 1);
 
 	/* Wait for FLM to enter Idle state */
 	for (uint32_t i = 0; i < 1000000; ++i) {
 		uint32_t value = 0;
-		hw_mod_flm_status_update(&ndev->be);
-		hw_mod_flm_status_get(&ndev->be, HW_FLM_STATUS_IDLE, &value);
+		nthw_mod_flm_status_update(&ndev->be);
+		nthw_mod_flm_status_get(&ndev->be, HW_FLM_STATUS_IDLE, &value);
 
 		if (value) {
 			success = 1;
@@ -696,13 +696,13 @@ static int flm_sdram_reset(struct flow_nic_dev *ndev, int enable)
 	success = 0;
 
 	/* Start SDRAM initialization */
-	hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_INIT, 0x1);
-	hw_mod_flm_control_flush(&ndev->be);
+	nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_INIT, 0x1);
+	nthw_mod_flm_control_flush(&ndev->be);
 
 	for (uint32_t i = 0; i < 1000000; ++i) {
 		uint32_t value = 0;
-		hw_mod_flm_status_update(&ndev->be);
-		hw_mod_flm_status_get(&ndev->be, HW_FLM_STATUS_INITDONE, &value);
+		nthw_mod_flm_status_update(&ndev->be);
+		nthw_mod_flm_status_get(&ndev->be, HW_FLM_STATUS_INITDONE, &value);
 
 		if (value) {
 			success = 1;
@@ -719,12 +719,12 @@ static int flm_sdram_reset(struct flow_nic_dev *ndev, int enable)
 	}
 
 	/* Set the INIT value back to zero to clear the bit in the SW register cache */
-	hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_INIT, 0x0);
-	hw_mod_flm_control_flush(&ndev->be);
+	nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_INIT, 0x0);
+	nthw_mod_flm_control_flush(&ndev->be);
 
 	/* Enable FLM */
-	hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_ENABLE, enable);
-	hw_mod_flm_control_flush(&ndev->be);
+	nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_ENABLE, enable);
+	nthw_mod_flm_control_flush(&ndev->be);
 
 	int nb_rpp_per_ps = ndev->be.flm.nb_rpp_clock_in_ps;
 	int nb_load_aps_max = ndev->be.flm.nb_load_aps_max;
@@ -735,8 +735,8 @@ static int flm_sdram_reset(struct flow_nic_dev *ndev, int enable)
 			(nb_load_aps_max * NTNIC_SCANNER_LOAD);
 	}
 
-	hw_mod_flm_scan_set(&ndev->be, HW_FLM_SCAN_I, scan_i_value);
-	hw_mod_flm_scan_flush(&ndev->be);
+	nthw_mod_flm_scan_set(&ndev->be, HW_FLM_SCAN_I, scan_i_value);
+	nthw_mod_flm_scan_flush(&ndev->be);
 
 	return 0;
 }
@@ -1666,11 +1666,11 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					memcpy_mask_if(&age_tmp, action[aidx].conf,
 					action_mask ? action_mask[aidx].conf : NULL,
 					sizeof(struct rte_flow_action_age));
-				fd->age.timeout = hw_mod_flm_scrub_timeout_encode(age->timeout);
+				fd->age.timeout = nthw_mod_flm_scrub_timeout_encode(age->timeout);
 				fd->age.context = age->context;
 				NT_LOG(DBG, FILTER,
 					"normalized timeout: %u, original timeout: %u, context: %p",
-					hw_mod_flm_scrub_timeout_decode(fd->age.timeout),
+					nthw_mod_flm_scrub_timeout_decode(fd->age.timeout),
 					age->timeout, fd->age.context);
 			}
 
@@ -3271,7 +3271,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 		.frag_rcp = empty_pattern ? fd->flm_mtu_fragmentation_recipe : 0,
 	};
 	struct hw_db_cot_idx cot_idx =
-		hw_db_inline_cot_add(dev->ndev, dev->ndev->hw_db_handle, &cot_data);
+		nthw_db_inline_cot_add(dev->ndev, dev->ndev->hw_db_handle, &cot_data);
 	local_idxs[(*local_idx_counter)++] = cot_idx.raw;
 
 	if (cot_idx.error) {
@@ -3282,7 +3282,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	/* Finalize QSL */
 	struct hw_db_qsl_idx qsl_idx =
-		hw_db_inline_qsl_add(dev->ndev, dev->ndev->hw_db_handle, qsl_data);
+		nthw_db_inline_qsl_add(dev->ndev, dev->ndev->hw_db_handle, qsl_data);
 	local_idxs[(*local_idx_counter)++] = qsl_idx.raw;
 
 	if (qsl_idx.error) {
@@ -3293,7 +3293,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	/* Setup HSH */
 	struct hw_db_hsh_idx hsh_idx =
-		hw_db_inline_hsh_add(dev->ndev, dev->ndev->hw_db_handle, hsh_data);
+		nthw_db_inline_hsh_add(dev->ndev, dev->ndev->hw_db_handle, hsh_data);
 	local_idxs[(*local_idx_counter)++] = hsh_idx.raw;
 
 	if (hsh_idx.error) {
@@ -3312,7 +3312,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 			.head_slice_ofs = fd->header_strip_end_ofs,
 		};
 		slc_lr_idx =
-			hw_db_inline_slc_lr_add(dev->ndev, dev->ndev->hw_db_handle, &slc_lr_data);
+			nthw_db_inline_slc_lr_add(dev->ndev, dev->ndev->hw_db_handle, &slc_lr_data);
 		local_idxs[(*local_idx_counter)++] = slc_lr_idx.raw;
 
 		if (slc_lr_idx.error) {
@@ -3334,7 +3334,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 		memcpy(tpe_ext_data.hdr8, fd->tun_hdr.d.hdr8, (fd->tun_hdr.len + 15) & ~15);
 
 		struct hw_db_tpe_ext_idx tpe_ext_idx =
-			hw_db_inline_tpe_ext_add(dev->ndev, dev->ndev->hw_db_handle,
+			nthw_db_inline_tpe_ext_add(dev->ndev, dev->ndev->hw_db_handle,
 			&tpe_ext_data);
 		local_idxs[(*local_idx_counter)++] = tpe_ext_idx.raw;
 
@@ -3398,7 +3398,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 	}
 
 	struct hw_db_tpe_idx tpe_idx =
-		hw_db_inline_tpe_add(dev->ndev, dev->ndev->hw_db_handle, &tpe_data);
+		nthw_db_inline_tpe_add(dev->ndev, dev->ndev->hw_db_handle, &tpe_data);
 
 	local_idxs[(*local_idx_counter)++] = tpe_idx.raw;
 
@@ -3411,7 +3411,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 	/* Setup SCRUB profile */
 	struct hw_db_inline_scrub_data scrub_data = { .timeout = fd->age.timeout };
 	struct hw_db_flm_scrub_idx scrub_idx =
-		hw_db_inline_scrub_add(dev->ndev, dev->ndev->hw_db_handle, &scrub_data);
+		nthw_db_inline_scrub_add(dev->ndev, dev->ndev->hw_db_handle, &scrub_data);
 	local_idxs[(*local_idx_counter)++] = scrub_idx.raw;
 
 	if (scrub_idx.error) {
@@ -3434,7 +3434,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 		.scrub = scrub_idx,
 	};
 	struct hw_db_action_set_idx action_set_idx =
-		hw_db_inline_action_set_add(dev->ndev, dev->ndev->hw_db_handle, &action_set_data);
+		nthw_db_inline_action_set_add(dev->ndev, dev->ndev->hw_db_handle, &action_set_data);
 	local_idxs[(*local_idx_counter)++] = action_set_idx.raw;
 
 	if (action_set_idx.error) {
@@ -3450,8 +3450,8 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 		.action_set = action_set_idx,
 	};
 	struct hw_db_flm_ft flm_ft_idx = empty_pattern
-		? hw_db_inline_flm_ft_default(dev->ndev, dev->ndev->hw_db_handle, &flm_ft_data)
-		: hw_db_inline_flm_ft_add(dev->ndev, dev->ndev->hw_db_handle, &flm_ft_data);
+		? nthw_db_inline_flm_ft_default(dev->ndev, dev->ndev->hw_db_handle, &flm_ft_data)
+		: nthw_db_inline_flm_ft_add(dev->ndev, dev->ndev->hw_db_handle, &flm_ft_data);
 	local_idxs[(*local_idx_counter)++] = flm_ft_idx.raw;
 
 	if (flm_ft_idx.error) {
@@ -3527,7 +3527,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 		};
 		memcpy(flm_data.mask, packet_mask, sizeof(uint32_t) * 10);
 		struct hw_db_flm_idx flm_idx =
-			hw_db_inline_flm_add(dev->ndev, dev->ndev->hw_db_handle, &flm_data,
+			nthw_db_inline_flm_add(dev->ndev, dev->ndev->hw_db_handle, &flm_data,
 			attr->group);
 		fh->db_idxs[fh->db_idx_counter++] = flm_idx.raw;
 
@@ -3601,7 +3601,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 				.frag_rcp = fd->flm_mtu_fragmentation_recipe,
 			};
 			struct hw_db_cot_idx cot_idx =
-				hw_db_inline_cot_add(dev->ndev, dev->ndev->hw_db_handle,
+				nthw_db_inline_cot_add(dev->ndev, dev->ndev->hw_db_handle,
 				&cot_data);
 			fh->db_idxs[fh->db_idx_counter++] = cot_idx.raw;
 			action_set_data.cot = cot_idx;
@@ -3614,7 +3614,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 			/* Finalize QSL */
 			struct hw_db_qsl_idx qsl_idx =
-				hw_db_inline_qsl_add(dev->ndev, dev->ndev->hw_db_handle,
+				nthw_db_inline_qsl_add(dev->ndev, dev->ndev->hw_db_handle,
 				&qsl_data);
 			fh->db_idxs[fh->db_idx_counter++] = qsl_idx.raw;
 			action_set_data.qsl = qsl_idx;
@@ -3627,7 +3627,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 			/* Setup HSH */
 			struct hw_db_hsh_idx hsh_idx =
-				hw_db_inline_hsh_add(dev->ndev, dev->ndev->hw_db_handle,
+				nthw_db_inline_hsh_add(dev->ndev, dev->ndev->hw_db_handle,
 				&hsh_data);
 			fh->db_idxs[fh->db_idx_counter++] = hsh_idx.raw;
 			action_set_data.hsh = hsh_idx;
@@ -3650,7 +3650,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 					.ttl_ofs = fd->ttl_sub_ipv4 ? 8 : 7,
 				};
 				struct hw_db_tpe_idx tpe_idx =
-					hw_db_inline_tpe_add(dev->ndev, dev->ndev->hw_db_handle,
+					nthw_db_inline_tpe_add(dev->ndev, dev->ndev->hw_db_handle,
 					&tpe_data);
 				fh->db_idxs[fh->db_idx_counter++] = tpe_idx.raw;
 				action_set_data.tpe = tpe_idx;
@@ -3665,7 +3665,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 		}
 
 		struct hw_db_action_set_idx action_set_idx =
-			hw_db_inline_action_set_add(dev->ndev, dev->ndev->hw_db_handle,
+			nthw_db_inline_action_set_add(dev->ndev, dev->ndev->hw_db_handle,
 			&action_set_data);
 
 		fh->db_idxs[fh->db_idx_counter++] = action_set_idx.raw;
@@ -3698,7 +3698,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			.ip_prot_tunnel = fd->tunnel_ip_prot,
 		};
 		struct hw_db_cat_idx cat_idx =
-			hw_db_inline_cat_add(dev->ndev, dev->ndev->hw_db_handle, &cat_data);
+			nthw_db_inline_cat_add(dev->ndev, dev->ndev->hw_db_handle, &cat_data);
 		fh->db_idxs[fh->db_idx_counter++] = cat_idx.raw;
 
 		if (cat_idx.error) {
@@ -3748,7 +3748,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			if (found_flow != NULL) {
 				/* Reuse existing KM RCP */
 				const struct hw_db_inline_km_rcp_data *other_km_rcp_data =
-					hw_db_inline_find_data(dev->ndev, dev->ndev->hw_db_handle,
+					nthw_db_inline_find_data(dev->ndev, dev->ndev->hw_db_handle,
 					HW_DB_IDX_TYPE_KM_RCP,
 					(struct hw_db_idx *)
 					found_flow->flm_db_idxs,
@@ -3784,7 +3784,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 		}
 
 		struct hw_db_km_idx km_idx =
-			hw_db_inline_km_add(dev->ndev, dev->ndev->hw_db_handle, &km_rcp_data);
+			nthw_db_inline_km_add(dev->ndev, dev->ndev->hw_db_handle, &km_rcp_data);
 
 		fh->db_idxs[fh->db_idx_counter++] = km_idx.raw;
 
@@ -3801,7 +3801,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			.action_set = action_set_idx,
 		};
 		struct hw_db_km_ft km_ft_idx =
-			hw_db_inline_km_ft_add(dev->ndev, dev->ndev->hw_db_handle, &km_ft_data);
+			nthw_db_inline_km_ft_add(dev->ndev, dev->ndev->hw_db_handle, &km_ft_data);
 		fh->db_idxs[fh->db_idx_counter++] = km_ft_idx.raw;
 
 		if (km_ft_idx.error) {
@@ -3823,14 +3823,14 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 			if (fd->km.target == KM_CAM) {
 				uint32_t ft_a_mask = 0;
-				hw_mod_km_rcp_get(&dev->ndev->be, HW_KM_RCP_FTM_A,
+				nthw_mod_km_rcp_get(&dev->ndev->be, HW_KM_RCP_FTM_A,
 					(int)km_rcp_data.rcp, 0, &ft_a_mask);
-				hw_mod_km_rcp_set(&dev->ndev->be, HW_KM_RCP_FTM_A,
+				nthw_mod_km_rcp_set(&dev->ndev->be, HW_KM_RCP_FTM_A,
 					(int)km_rcp_data.rcp, 0,
 					ft_a_mask | (1 << fd->km.flow_type));
 			}
 
-			hw_mod_km_rcp_flush(&dev->ndev->be, (int)km_rcp_data.rcp, 1);
+			nthw_mod_km_rcp_flush(&dev->ndev->be, (int)km_rcp_data.rcp, 1);
 
 			km_write_data_match_entry(&fd->km, 0);
 		}
@@ -3845,7 +3845,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			.priority = attr->priority & 0xff,
 		};
 		struct hw_db_match_set_idx match_set_idx =
-			hw_db_inline_match_set_add(dev->ndev, dev->ndev->hw_db_handle,
+			nthw_db_inline_match_set_add(dev->ndev, dev->ndev->hw_db_handle,
 			&match_set_data);
 		fh->db_idxs[fh->db_idx_counter++] = match_set_idx.raw;
 
@@ -3863,7 +3863,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 		};
 		struct hw_db_flm_ft flm_ft_idx =
-			hw_db_inline_flm_ft_add(dev->ndev, dev->ndev->hw_db_handle, &flm_ft_data);
+			nthw_db_inline_flm_ft_add(dev->ndev, dev->ndev->hw_db_handle, &flm_ft_data);
 		fh->db_idxs[fh->db_idx_counter++] = flm_ft_idx.raw;
 
 		if (flm_ft_idx.error) {
@@ -3880,12 +3880,12 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 error_out:
 
 	if (fh->type == FLOW_HANDLE_TYPE_FLM) {
-		hw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
+		nthw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
 			(struct hw_db_idx *)fh->flm_db_idxs,
 			fh->flm_db_idx_counter);
 
 	} else {
-		hw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
+		nthw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
 			(struct hw_db_idx *)fh->db_idxs, fh->db_idx_counter);
 	}
 
@@ -3915,25 +3915,25 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 		flow_nic_mark_resource_used(ndev, RES_FLM_RCP, 0);
 
 		/* COT is locked to CFN. Don't set color for CFN 0 */
-		hw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, 0, 0);
+		nthw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, 0, 0);
 
-		if (hw_mod_cat_cot_flush(&ndev->be, 0, 1) < 0)
+		if (nthw_mod_cat_cot_flush(&ndev->be, 0, 1) < 0)
 			goto err_exit0;
 
 		/* Initialize QSL with unmatched recipe index 0 - discard */
-		if (hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_DISCARD, 0, 0x1) < 0)
+		if (nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_DISCARD, 0, 0x1) < 0)
 			goto err_exit0;
 
-		if (hw_mod_qsl_rcp_flush(&ndev->be, 0, 1) < 0)
+		if (nthw_mod_qsl_rcp_flush(&ndev->be, 0, 1) < 0)
 			goto err_exit0;
 
 		flow_nic_mark_resource_used(ndev, RES_QSL_RCP, 0);
 
 		/* Initialize QST with default index 0 */
-		if (hw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_PRESET_ALL, 0, 0x0) < 0)
+		if (nthw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_PRESET_ALL, 0, 0x0) < 0)
 			goto err_exit0;
 
-		if (hw_mod_qsl_qst_flush(&ndev->be, 0, 1) < 0)
+		if (nthw_mod_qsl_qst_flush(&ndev->be, 0, 1) < 0)
 			goto err_exit0;
 
 		flow_nic_mark_resource_used(ndev, RES_QSL_QST, 0);
@@ -3946,13 +3946,13 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 
 		/* PDB setup Direct Virtio Scatter-Gather descriptor of 12 bytes for its recipe 0
 		 */
-		if (hw_mod_pdb_rcp_set(&ndev->be, HW_PDB_RCP_DESCRIPTOR, 0, 7) < 0)
+		if (nthw_mod_pdb_rcp_set(&ndev->be, HW_PDB_RCP_DESCRIPTOR, 0, 7) < 0)
 			goto err_exit0;
 
-		if (hw_mod_pdb_rcp_set(&ndev->be, HW_PDB_RCP_DESC_LEN, 0, 6) < 0)
+		if (nthw_mod_pdb_rcp_set(&ndev->be, HW_PDB_RCP_DESC_LEN, 0, 6) < 0)
 			goto err_exit0;
 
-		if (hw_mod_pdb_rcp_flush(&ndev->be, 0, 1) < 0)
+		if (nthw_mod_pdb_rcp_flush(&ndev->be, 0, 1) < 0)
 			goto err_exit0;
 
 		flow_nic_mark_resource_used(ndev, RES_PDB_RCP, 0);
@@ -3967,15 +3967,15 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 			.algorithm = 0,
 		};
 		hsh_set(ndev, 0, hsh_5_tuple);
-		hw_mod_hsh_rcp_flush(&ndev->be, 0, 1);
+		nthw_mod_hsh_rcp_flush(&ndev->be, 0, 1);
 
 		flow_nic_mark_resource_used(ndev, RES_HSH_RCP, 0);
 
 		/* Initialize SCRUB with default index 0, i.e. flow will never AGE-out */
-		if (hw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_PRESET_ALL, 0, 0) < 0)
+		if (nthw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_PRESET_ALL, 0, 0) < 0)
 			goto err_exit0;
 
-		if (hw_mod_flm_scrub_flush(&ndev->be, 0, 1) < 0)
+		if (nthw_mod_flm_scrub_flush(&ndev->be, 0, 1) < 0)
 			goto err_exit0;
 
 		flow_nic_mark_resource_used(ndev, RES_SCRUB_RCP, 0);
@@ -3984,7 +3984,7 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 		flow_nic_mark_resource_used(ndev, RES_CAT_CFN, NT_VIOLATING_MBR_CFN);
 		flow_nic_mark_resource_used(ndev, RES_QSL_RCP, NT_VIOLATING_MBR_QSL);
 
-		if (hw_db_inline_setup_mbr_filter(ndev, NT_VIOLATING_MBR_CFN,
+		if (nthw_db_inline_setup_mbr_filter(ndev, NT_VIOLATING_MBR_CFN,
 			NT_FLM_VIOLATING_MBR_FLOW_TYPE,
 			NT_VIOLATING_MBR_QSL) < 0)
 			goto err_exit0;
@@ -3997,54 +3997,54 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 			goto err_exit0;
 
 		/* Learn done status */
-		hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_LDS, 0);
+		nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_LDS, 0);
 		/* Learn fail status */
-		hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_LFS, 1);
+		nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_LFS, 1);
 		/* Learn ignore status */
-		hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_LIS, 1);
+		nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_LIS, 1);
 		/* Unlearn done status */
-		hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_UDS, 0);
+		nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_UDS, 0);
 		/* Unlearn ignore status */
-		hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_UIS, 0);
+		nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_UIS, 0);
 		/* Relearn done status */
-		hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_RDS, 0);
+		nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_RDS, 0);
 		/* Relearn ignore status */
-		hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_RIS, 0);
-		hw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_RBL, 4);
-		hw_mod_flm_control_flush(&ndev->be);
+		nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_RIS, 0);
+		nthw_mod_flm_control_set(&ndev->be, HW_FLM_CONTROL_RBL, 4);
+		nthw_mod_flm_control_flush(&ndev->be);
 
 		/* Set the sliding windows size for flm load */
 		uint32_t bin = (uint32_t)(((FLM_LOAD_WINDOWS_SIZE * 1000000000000ULL) /
 			(32ULL * ndev->be.flm.nb_rpp_clock_in_ps)) -
 			1ULL);
-		hw_mod_flm_load_bin_set(&ndev->be, HW_FLM_LOAD_BIN, bin);
-		hw_mod_flm_load_bin_flush(&ndev->be);
+		nthw_mod_flm_load_bin_set(&ndev->be, HW_FLM_LOAD_BIN, bin);
+		nthw_mod_flm_load_bin_flush(&ndev->be);
 
-		hw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_LIMIT0,
+		nthw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_LIMIT0,
 			0);	/* Drop at 100% FIFO fill level */
-		hw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_FT0, 1);
-		hw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_LIMIT1,
+		nthw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_FT0, 1);
+		nthw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_LIMIT1,
 			14);	/* Drop at 87,5% FIFO fill level */
-		hw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_FT1, 1);
-		hw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_LIMIT2,
+		nthw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_FT1, 1);
+		nthw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_LIMIT2,
 			10);	/* Drop at 62,5% FIFO fill level */
-		hw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_FT2, 1);
-		hw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_LIMIT3,
+		nthw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_FT2, 1);
+		nthw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_LIMIT3,
 			6);	/* Drop at 37,5% FIFO fill level */
-		hw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_FT3, 1);
-		hw_mod_flm_prio_flush(&ndev->be);
+		nthw_mod_flm_prio_set(&ndev->be, HW_FLM_PRIO_FT3, 1);
+		nthw_mod_flm_prio_flush(&ndev->be);
 
 		/* TODO How to set and use these limits */
 		for (uint32_t i = 0; i < ndev->be.flm.nb_pst_profiles; ++i) {
-			hw_mod_flm_pst_set(&ndev->be, HW_FLM_PST_BP, i,
+			nthw_mod_flm_pst_set(&ndev->be, HW_FLM_PST_BP, i,
 				NTNIC_FLOW_PERIODIC_STATS_BYTE_LIMIT);
-			hw_mod_flm_pst_set(&ndev->be, HW_FLM_PST_PP, i,
+			nthw_mod_flm_pst_set(&ndev->be, HW_FLM_PST_PP, i,
 				NTNIC_FLOW_PERIODIC_STATS_PKT_LIMIT);
-			hw_mod_flm_pst_set(&ndev->be, HW_FLM_PST_TP, i,
+			nthw_mod_flm_pst_set(&ndev->be, HW_FLM_PST_TP, i,
 				NTNIC_FLOW_PERIODIC_STATS_BYTE_TIMEOUT);
 		}
 
-		hw_mod_flm_pst_flush(&ndev->be, 0, ALL_ENTRIES);
+		nthw_mod_flm_pst_flush(&ndev->be, 0, ALL_ENTRIES);
 
 		ndev->id_table_handle = ntnic_id_table_create();
 
@@ -4077,7 +4077,7 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 		if (nthw_flow_group_handle_create(&ndev->group_handle, ndev->be.flm.nb_categories))
 			goto err_exit0;
 
-		if (hw_db_inline_create(ndev, &ndev->hw_db_handle))
+		if (nthw_db_inline_create(ndev, &ndev->hw_db_handle))
 			goto err_exit0;
 
 		ndev->flow_mgnt_prepared = 1;
@@ -4102,8 +4102,8 @@ int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 		nthw_flow_nic_free_resource(ndev, RES_KM_FLOW_TYPE, 0);
 		nthw_flow_nic_free_resource(ndev, RES_KM_CATEGORY, 0);
 
-		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, 0, 0);
-		hw_mod_flm_rcp_flush(&ndev->be, 0, 1);
+		nthw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, 0, 0);
+		nthw_mod_flm_rcp_flush(&ndev->be, 0, 1);
 		nthw_flow_nic_free_resource(ndev, RES_FLM_FLOW_TYPE, 0);
 		nthw_flow_nic_free_resource(ndev, RES_FLM_FLOW_TYPE, 1);
 		nthw_flow_nic_free_resource(ndev, RES_FLM_RCP, 0);
@@ -4123,38 +4123,38 @@ int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 		nthw_flow_group_handle_destroy(&ndev->group_handle);
 		ntnic_id_table_destroy(ndev->id_table_handle);
 
-		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PRESET_ALL, 0, 0, 0);
-		hw_mod_cat_cfn_flush(&ndev->be, 0, 1);
-		hw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, 0, 0);
-		hw_mod_cat_cot_flush(&ndev->be, 0, 1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PRESET_ALL, 0, 0, 0);
+		nthw_mod_cat_cfn_flush(&ndev->be, 0, 1);
+		nthw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, 0, 0);
+		nthw_mod_cat_cot_flush(&ndev->be, 0, 1);
 		nthw_flow_nic_free_resource(ndev, RES_CAT_CFN, 0);
 
-		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_PRESET_ALL, 0, 0);
-		hw_mod_qsl_rcp_flush(&ndev->be, 0, 1);
+		nthw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_PRESET_ALL, 0, 0);
+		nthw_mod_qsl_rcp_flush(&ndev->be, 0, 1);
 		nthw_flow_nic_free_resource(ndev, RES_QSL_RCP, 0);
 
-		hw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_PRESET_ALL, 0, 0);
-		hw_mod_slc_lr_rcp_flush(&ndev->be, 0, 1);
+		nthw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_PRESET_ALL, 0, 0);
+		nthw_mod_slc_lr_rcp_flush(&ndev->be, 0, 1);
 		nthw_flow_nic_free_resource(ndev, RES_SLC_LR_RCP, 0);
 
-		hw_mod_tpe_reset(&ndev->be);
+		nthw_mod_tpe_reset(&ndev->be);
 		nthw_flow_nic_free_resource(ndev, RES_TPE_RCP, 0);
 		nthw_flow_nic_free_resource(ndev, RES_TPE_EXT, 0);
 		nthw_flow_nic_free_resource(ndev, RES_TPE_RPL, 0);
 
-		hw_mod_pdb_rcp_set(&ndev->be, HW_PDB_RCP_PRESET_ALL, 0, 0);
-		hw_mod_pdb_rcp_flush(&ndev->be, 0, 1);
+		nthw_mod_pdb_rcp_set(&ndev->be, HW_PDB_RCP_PRESET_ALL, 0, 0);
+		nthw_mod_pdb_rcp_flush(&ndev->be, 0, 1);
 		nthw_flow_nic_free_resource(ndev, RES_PDB_RCP, 0);
 
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, 0, 0, 0);
-		hw_mod_hsh_rcp_flush(&ndev->be, 0, 1);
+		nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, 0, 0, 0);
+		nthw_mod_hsh_rcp_flush(&ndev->be, 0, 1);
 		nthw_flow_nic_free_resource(ndev, RES_HSH_RCP, 0);
 
-		hw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_PRESET_ALL, 0, 0);
-		hw_mod_flm_scrub_flush(&ndev->be, 0, 1);
+		nthw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_PRESET_ALL, 0, 0);
+		nthw_mod_flm_scrub_flush(&ndev->be, 0, 1);
 		nthw_flow_nic_free_resource(ndev, RES_SCRUB_RCP, 0);
 
-		hw_db_inline_destroy(ndev->hw_db_handle);
+		nthw_db_inline_destroy(ndev->hw_db_handle);
 
 #ifdef FLOW_DEBUG
 		ndev->be.iface->set_debug_mode(ndev->be.be_dev, FLOW_BACKEND_DEBUG_MODE_NONE);
@@ -4288,7 +4288,7 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 
 	NT_LOG(DBG, FILTER, "removing flow :%p", fh);
 	if (fh->type == FLOW_HANDLE_TYPE_FLM) {
-		hw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
+		nthw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
 			(struct hw_db_idx *)fh->flm_db_idxs,
 			fh->flm_db_idx_counter);
 
@@ -4301,7 +4301,7 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 			km_clear_data_match_entry(&fh->fd->km);
 
 			const struct hw_db_inline_km_rcp_data *other_km_rcp_data =
-				hw_db_inline_find_data(dev->ndev, dev->ndev->hw_db_handle,
+				nthw_db_inline_find_data(dev->ndev, dev->ndev->hw_db_handle,
 				HW_DB_IDX_TYPE_KM_RCP,
 				(struct hw_db_idx *)fh->flm_db_idxs,
 				fh->flm_db_idx_counter);
@@ -4309,14 +4309,14 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 			if (other_km_rcp_data != NULL &&
 				nthw_flow_nic_deref_resource(dev->ndev, RES_KM_CATEGORY,
 				(int)other_km_rcp_data->rcp) == 0) {
-				hw_mod_km_rcp_set(&dev->ndev->be, HW_KM_RCP_PRESET_ALL,
+				nthw_mod_km_rcp_set(&dev->ndev->be, HW_KM_RCP_PRESET_ALL,
 					(int)other_km_rcp_data->rcp, 0, 0);
-				hw_mod_km_rcp_flush(&dev->ndev->be, (int)other_km_rcp_data->rcp,
+				nthw_mod_km_rcp_flush(&dev->ndev->be, (int)other_km_rcp_data->rcp,
 					1);
 			}
 		}
 
-		hw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
+		nthw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
 			(struct hw_db_idx *)fh->db_idxs, fh->db_idx_counter);
 		free(fh->fd);
 		fh->fd = NULL;
@@ -4453,7 +4453,7 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 
 		/* Setup FLM RCP */
 		const struct hw_db_inline_flm_rcp_data *flm_data =
-			hw_db_inline_find_data(dev->ndev, dev->ndev->hw_db_handle,
+			nthw_db_inline_find_data(dev->ndev, dev->ndev->hw_db_handle,
 				HW_DB_IDX_TYPE_FLM_RCP,
 				(struct hw_db_idx *)flow->flm_db_idxs,
 				flow->flm_db_idx_counter);
@@ -4465,7 +4465,7 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 		}
 
 		struct hw_db_flm_idx flm_idx =
-			hw_db_inline_flm_add(dev->ndev, dev->ndev->hw_db_handle, flm_data, group);
+			nthw_db_inline_flm_add(dev->ndev, dev->ndev->hw_db_handle, flm_data, group);
 
 		local_idxs[local_idx_counter++] = flm_idx.raw;
 
@@ -4530,7 +4530,7 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 		/* Program flow */
 		flm_flow_programming(flow, NT_FLM_OP_RELEARN);
 
-		hw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
+		nthw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
 			(struct hw_db_idx *)flow->flm_db_idxs,
 			flow->flm_db_idx_counter);
 		memset(flow->flm_db_idxs, 0x0, sizeof(struct hw_db_idx) * RES_COUNT);
@@ -4547,7 +4547,8 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 
 error_out:
-	hw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle, (struct hw_db_idx *)local_idxs,
+	nthw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
+		(struct hw_db_idx *)local_idxs,
 		local_idx_counter);
 
 	rte_spinlock_unlock(&dev->ndev->mtx);
@@ -4630,7 +4631,7 @@ int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 				(int)flow->caller_id);
 			fprintf(file, "  FLM_DATA:\n");
 			dump_flm_data(flow->flm_data, file);
-			hw_db_inline_dump(dev->ndev, dev->ndev->hw_db_handle,
+			nthw_db_inline_dump(dev->ndev, dev->ndev->hw_db_handle,
 				(struct hw_db_idx *)flow->flm_db_idxs,
 				flow->flm_db_idx_counter, file);
 			fprintf(file, "  Context: %p\n", flow->context);
@@ -4638,7 +4639,7 @@ int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 		} else {
 			fprintf(file, "Port %d, caller %d, flow type FLOW\n", (int)dev->port_id,
 				(int)flow->caller_id);
-			hw_db_inline_dump(dev->ndev, dev->ndev->hw_db_handle,
+			nthw_db_inline_dump(dev->ndev, dev->ndev->hw_db_handle,
 				(struct hw_db_idx *)flow->db_idxs, flow->db_idx_counter,
 				file);
 		}
@@ -4646,7 +4647,7 @@ int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 	} else {
 		int max_flm_count = 1000;
 
-		hw_db_inline_dump_cfn(dev->ndev, dev->ndev->hw_db_handle, file);
+		nthw_db_inline_dump_cfn(dev->ndev, dev->ndev->hw_db_handle, file);
 
 		flow = dev->ndev->flow_base;
 
@@ -4654,7 +4655,7 @@ int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 			if (flow->caller_id == caller_id) {
 				fprintf(file, "Port %d, caller %d, flow type FLOW\n",
 					(int)dev->port_id, (int)flow->caller_id);
-				hw_db_inline_dump(dev->ndev, dev->ndev->hw_db_handle,
+				nthw_db_inline_dump(dev->ndev, dev->ndev->hw_db_handle,
 					(struct hw_db_idx *)flow->db_idxs,
 					flow->db_idx_counter, file);
 			}
@@ -4670,7 +4671,7 @@ int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 					(int)dev->port_id, (int)flow->caller_id);
 				fprintf(file, "  FLM_DATA:\n");
 				dump_flm_data(flow->flm_data, file);
-				hw_db_inline_dump(dev->ndev, dev->ndev->hw_db_handle,
+				nthw_db_inline_dump(dev->ndev, dev->ndev->hw_db_handle,
 					(struct hw_db_idx *)flow->flm_db_idxs,
 					flow->flm_db_idx_counter, file);
 				fprintf(file, "  Context: %p\n", flow->context);
@@ -4711,11 +4712,11 @@ int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	if (size < fields_cnt)
 		return -1;
 
-	hw_mod_flm_stat_update(&ndev->be);
+	nthw_mod_flm_stat_update(&ndev->be);
 
 	for (uint64_t i = 0; i < fields_cnt; ++i) {
 		uint32_t value = 0;
-		hw_mod_flm_stat_get(&ndev->be, fields[i], &value);
+		nthw_mod_flm_stat_get(&ndev->be, fields[i], &value);
 		data[i] = (fields[i] == HW_FLM_STAT_FLOWS || fields[i] == HW_FLM_LOAD_LPS ||
 				fields[i] == HW_FLM_LOAD_APS)
 			? value
@@ -4732,13 +4733,13 @@ int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	uint8_t port_count)
 {
 	/* IFR RCP 0 is reserved, port counters start from record 1 */
-	hw_mod_tpe_ifr_counters_update(&ndev->be, 1, port_count);
+	nthw_mod_tpe_ifr_counters_update(&ndev->be, 1, port_count);
 	uint8_t i = 0;
 
 	for (i = 0; i < port_count; ++i) {
 		uint8_t ifr_mtu_recipe = convert_port_to_ifr_mtu_recipe(i);
 		uint32_t drop_cnt = 0;
-		hw_mod_tpe_ifr_counters_get(&ndev->be, HW_TPE_IFR_COUNTERS_DROP, ifr_mtu_recipe,
+		nthw_mod_tpe_ifr_counters_get(&ndev->be, HW_TPE_IFR_COUNTERS_DROP, ifr_mtu_recipe,
 			&drop_cnt);
 		data[i] = data[i] + drop_cnt;
 	}
@@ -4779,29 +4780,29 @@ int flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu)
 	uint8_t ifr_mtu_recipe = convert_port_to_ifr_mtu_recipe(port);
 	struct flow_nic_dev *ndev = dev->ndev;
 
-	err |= hw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV4_EN, ifr_mtu_recipe,
+	err |= nthw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV4_EN, ifr_mtu_recipe,
 			ipv4_en_frag);
-	err |= hw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV6_EN, ifr_mtu_recipe,
+	err |= nthw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV6_EN, ifr_mtu_recipe,
 			ipv6_en_frag);
-	err |= hw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_MTU, ifr_mtu_recipe, mtu);
-	err |= hw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV4_DF_DROP, ifr_mtu_recipe,
+	err |= nthw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_MTU, ifr_mtu_recipe, mtu);
+	err |= nthw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV4_DF_DROP, ifr_mtu_recipe,
 			ipv4_action);
-	err |= hw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV6_DROP, ifr_mtu_recipe,
+	err |= nthw_mod_tpe_rpp_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV6_DROP, ifr_mtu_recipe,
 			ipv6_action);
 
-	err |= hw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV4_EN, ifr_mtu_recipe,
+	err |= nthw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV4_EN, ifr_mtu_recipe,
 			ipv4_en_frag);
-	err |= hw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV6_EN, ifr_mtu_recipe,
+	err |= nthw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV6_EN, ifr_mtu_recipe,
 			ipv6_en_frag);
-	err |= hw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_MTU, ifr_mtu_recipe, mtu);
-	err |= hw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV4_DF_DROP, ifr_mtu_recipe,
+	err |= nthw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_MTU, ifr_mtu_recipe, mtu);
+	err |= nthw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV4_DF_DROP, ifr_mtu_recipe,
 			ipv4_action);
-	err |= hw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV6_DROP, ifr_mtu_recipe,
+	err |= nthw_mod_tpe_ifr_rcp_set(&ndev->be, HW_TPE_IFR_RCP_IPV6_DROP, ifr_mtu_recipe,
 			ipv6_action);
 
 	if (err == 0) {
-		err |= hw_mod_tpe_rpp_ifr_rcp_flush(&ndev->be, ifr_mtu_recipe, 1);
-		err |= hw_mod_tpe_ifr_rcp_flush(&ndev->be, ifr_mtu_recipe, 1);
+		err |= nthw_mod_tpe_rpp_ifr_rcp_flush(&ndev->be, ifr_mtu_recipe, 1);
+		err |= nthw_mod_tpe_ifr_rcp_flush(&ndev->be, ifr_mtu_recipe, 1);
 	}
 
 	return err;
@@ -5121,7 +5122,7 @@ int flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
 		struct flow_template_table_cell *cell = &template_table->pattern_action_pairs[i];
 
 		if (cell->flm_db_idx_counter > 0) {
-			hw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
+			nthw_db_inline_deref_idxs(dev->ndev, dev->ndev->hw_db_handle,
 				(struct hw_db_idx *)cell->flm_db_idxs,
 				cell->flm_db_idx_counter);
 		}
@@ -5239,7 +5240,7 @@ struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
 				rte_spinlock_lock(&dev->ndev->mtx);
 
 				struct hw_db_idx *flm_ft_idx =
-					hw_db_inline_find_idx(dev->ndev, dev->ndev->hw_db_handle,
+					nthw_db_inline_find_idx(dev->ndev, dev->ndev->hw_db_handle,
 						HW_DB_IDX_TYPE_FLM_FT,
 						(struct hw_db_idx *)fh->flm_db_idxs,
 						fh->flm_db_idx_counter);
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 58be82b2d2..276a2dc8e1 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1771,7 +1771,7 @@ static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_r
 	int res = hsh_set(ndev, hsh_idx, tmp_rss_conf);
 
 	if (res == 0) {
-		flow_filter_ops->hw_mod_hsh_rcp_flush(&ndev->be, hsh_idx, 1);
+		flow_filter_ops->nthw_mod_hsh_rcp_flush(&ndev->be, hsh_idx, 1);
 		rte_memcpy(&ndev->rss_conf, &tmp_rss_conf, sizeof(struct nt_eth_rss_conf));
 
 	} else {
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 26efec1c65..2d5bebda2a 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -500,7 +500,7 @@ struct flow_filter_ops {
 	/*
 	 * Other
 	 */
-	int (*hw_mod_hsh_rcp_flush)(struct flow_api_backend_s *be, int start_idx, int count);
+	int (*nthw_mod_hsh_rcp_flush)(struct flow_api_backend_s *be, int start_idx, int count);
 
 	int (*flow_get_aged_flows)(struct flow_eth_dev *dev,
 		uint16_t caller_id,
-- 
2.45.0

