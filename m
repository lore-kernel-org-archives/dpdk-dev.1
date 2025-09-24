Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FB6CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:44:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD8B840E2E;
	Wed, 24 Sep 2025 16:42:35 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0764E40DCE
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
 by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFUYzC2xmvspPgPODjtf8VXZ0ExEJq2/AIxyMGKdsu6Mhs20oGKwoOagIzlcSq5VB8QMEQMp4D6RNsYZA/LJ3hs2HDASykrLEGwJWgzaBf6DWetxhvjOBRinZvCpEbgxfdmZfjS+qt/YTb6xCRFQZUyQI+88X/myWZXpu3+7mpQ0/37qjwfBUbK9np+HS9ZmbmgElzaM3iOOWReijcMqPDUnxtGNlIg0Uk8V0ZxyaNauYl801F47Yg+HLhh45/SvAt9OMCjRKhmkLW2D2KLPKfmAQ25m/Vpx4eSNxlboJSADM0GqOe6y81RxkdS/HnyIAZzMQIr+am3JylW5iTSSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc8el/cyaveFUN0QSENGm9csHaGf52WGvtcvqsWc+Zw=;
 b=iiSTBQ+Xdfb8i3sNY2G3t1GmzI3quJJlxDoWuRKjmg+mHQPI6R2+r9mGTjWMB7Q48w62lbd6rJHGkp2NyDJX9v0ghCN/cXOn165Az5opY/UmpuzXfzCIDprwEyZEOdRi453yqXOyypuk0EOBz0/kQvOUwADBKm6/QnPKAIRwllAy1QInAfZ/vWrG2v6zF9yEvxNXoDQ3Wwclk1LsB7Zp5mBFbcbPW0T4Bl3RGB2McfeibMJ72zddSU7ObcZiqPWEmws3hBha3pdkqHMUCjakKsl2e6nL6ZNvuC74or6lSmGSHm3StbIx/mkWlggwgz/3xjcJ7Q2MxiROB1luGsCx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc8el/cyaveFUN0QSENGm9csHaGf52WGvtcvqsWc+Zw=;
 b=Klt8H07g2EdvKooazi+TPATdcvA34uCjGovMD1D5Gr3jGJCc+8Oxntc4vGswSAGL6km9Y/HWol06wYzJq+ENW2Zl+QM4LmK1g3DTTpU7h0miPlcmmZ7mL/cQAbRend537Kht+Of+04ekF4/FW6HuumEMzhxENN9XDqBrIRLZYCk=
Received: from CWLP123CA0234.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::9)
 by AS8P190MB1287.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:42:14 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::49) by CWLP123CA0234.outlook.office365.com
 (2603:10a6:400:19f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:14
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 19/24] net/ntnic: rename common hash and flow functions
Date: Wed, 24 Sep 2025 16:41:42 +0200
Message-ID: <20250924144152.53203-20-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS8P190MB1287:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9cb3fb5-bce0-4ad1-f2cd-08ddfb788d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CYa0ho1qJYPK1nIqQYaflVY2nbaJKeQfEBa7Nbdpnm6jQnoaglF0N6xlSB0v?=
 =?us-ascii?Q?Ftblw+tk3zlPxCeJp6x25lXbzpI+WWuGLXTbT18XraG0BEnqKJ2aIGGt2SBe?=
 =?us-ascii?Q?Uia//5+9RRUBODS8q+pHPAJlW4PalTGui59n6VjtETBgTNlu4lWKh4KV5bgW?=
 =?us-ascii?Q?D7fEryoXrEQzT3Z51m/IKo9Y+xBzeFQxNXFftk3kZXCxlGnhY7GCwaoU2xcJ?=
 =?us-ascii?Q?cr1DdlOBZ52YfW1bB/91ZIbKUpoKFL0eHr4yNio/Ky+1sDxnFC00aVadn2T0?=
 =?us-ascii?Q?firbgoonMwd5EKctzV4OxcnmKypxoeE9yqoyUwGJV9t/XPWt+0F1Vsgsv42t?=
 =?us-ascii?Q?BtTyxWcrIarsJH9ikWPC5ymDdbCWTmhZaqU7835xNPsWDmGtOEr5P+dlcgqZ?=
 =?us-ascii?Q?mxxF0/YFecPtCGag5OdqeQhcpXkaXlnAdvNa7AWXG9VvZV0COOY9f16ccHHf?=
 =?us-ascii?Q?H+pKhuamfT04GqIysfDYieHsZpG2yBkEPhA+A2pGW1HzGucLuTRaF2JSyp5k?=
 =?us-ascii?Q?L8C65dw4pkbNA+evKXlATzBg8J+t2gAM8TdPqT590Q+yOImFbrvqV00J2SZF?=
 =?us-ascii?Q?cIvKDMwK2/FygYNmlWa6gJmM7jUsxI4nkQ0cEaBCLBfLxTI0QACl0SzoEuXd?=
 =?us-ascii?Q?aVtvFJmGGmPCgCo/A9PTv3AcyquySDVGMRakZw5jwz385xLbJA4Gjn0W0Ibs?=
 =?us-ascii?Q?fQaNrQDkqObvayt4GyIR2JavBI9/MH/37s+gXZKE1Mc/ddvTRzea7YywkpT+?=
 =?us-ascii?Q?dCxfDgYsGVFbltPl2x1k6vj8XL3ZptC27gGoniMEruM+J4VavoYmcxUDy3Am?=
 =?us-ascii?Q?tZo4qVI5+AEO+x7bjgvJ5p16jv6IEqAyc+rOw7+s/z1zgbapmCmOgH/VS2Lz?=
 =?us-ascii?Q?//769UpQxQsMXuiLh9pRrdurRPBpsyCo66zGZw/OaTivLGXdAqHZ2iK+j/eq?=
 =?us-ascii?Q?zJC6QjoAK95O5XNe8hYHErOIwJCQ+Ctucym2SkKG4Szz4oqYLt5tBn5Lsde2?=
 =?us-ascii?Q?bNhs8F7dYW2O5AT7WElyi7JSLHTl7BHqL0KD6BdM44ytq+Ht0At65PbYK/sc?=
 =?us-ascii?Q?fg7+BC5JfD+T6dD76MrfZ6wPgAACYinl2GsUDAnLY8wSuvhwbcxCZPRkey/s?=
 =?us-ascii?Q?1mW8bvJphMl/cJ5hCkrj1KPlewci9NI+wcQ6MiDSJaeoOseZPhrMEWqLW8JK?=
 =?us-ascii?Q?+WsxG1VlWBU3tdgVYxKvWLlutvBfvuuh+0LW/x3qxd9lAMU4gEjlhsLTFjr7?=
 =?us-ascii?Q?TD9Ry8ugX+kwTCG+sGs1vCds7CMbiqYgimUCEELXS3Oa5IVOXZFwJRmSjjte?=
 =?us-ascii?Q?PX7u6VFFFpowbeNtOWYTjwjhTBqm68v7lk/EcHSdIeVyEjWnOVv9XuRQH2gH?=
 =?us-ascii?Q?HPRR2nehvs4qNMZodpcwRo0r9amor25VFHG1JwEbcSoL0PQ7plu/3LYtxLtN?=
 =?us-ascii?Q?NmcchONKSrhClIBEGNRxi5575GdqB80h9LDEs6DTt3TU3oYTSblX9CzNAHWG?=
 =?us-ascii?Q?41PSRR9Vs6q02CydFytur6s5KgLn3BYQfOSx?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CkhNay5X9lRWL8lTt/FeJUvoP+c8rXxdNPTmrCjxDS6O0kgApNEknmMqml2ZwlLpW9j0UJfVkykeNtXWbsWisGHXyPlQCA8mMbWscvJfQ8fHPqUfN8fualcXf3mok54rUXc1fWethwHxYFDfwK+GtWeQjo3tu55y3QIgKc5WiaDW9WmB5fWTqsu7Xg+KE+ulfFfRvqB1fo7tQrd4QSUC9XPrCboHnDSgHj7Ta8H1c79HisKJSFw6DDUYLJXE9ZPxVni6hIDncfPu0ESmMsJliWRwSFnrtp2iMxMrzPwKY5scRVJCZ/NFOxifj0RmyEf5NSsAoY0L9qha+RjJDeTDpXib1zgQmxhqCZ2nqQRIdm1Du3HzenOQN1jJAVJDQ+BNJCWAmttt7rnBm1biInF3zBqc6rMdN5rph5DLEq+KRlvVFB5glmATC0zCniMTbwZTA/vmRtJG3ZWz32QyFPv48xKId13vTDzCXQgx03MwnreFVTB0r4o+pjwgWS1FwgDfV3NlzQXkELMmfu8yE5XQVD7ugOvHe0fsjR5kdtcwJQXb9nFGJA5eFS3kfRvMgBX1f53R9KPeCDuCQk+zD/D78x53FG7Is7PZDWeQVtJyX8yxlx2GpSqMdgPYrNIdOwizTlLPtfKyeeOyeNxOIKeM8g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:14.3800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cb3fb5-bce0-4ad1-f2cd-08ddfb788d7b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1287
X-BESS-ID: 1758724935-305664-7609-8026-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGxpZGQGYGUNQsyTIp2cLCzM
 Is0SAxNdEixcTM3CjJINXSyMAozcjUTKk2FgCDDjbAQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan21-85.eu-central-1b.ess.aws.cudaops.com]
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

Rename common hash and flow functions to have consistent naming convention.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api.h                 |  8 ++++----
 drivers/net/ntnic/nthw/flow_api/flow_api.c           | 12 ++++++------
 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c       |  8 ++++----
 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h       |  2 +-
 .../flow_api/profile_inline/flow_api_hw_db_inline.c  |  4 ++--
 .../profile_inline/flow_api_profile_inline.c         |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c                     |  2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ntnic/include/flow_api.h b/drivers/net/ntnic/include/flow_api.h
index 582de3b281..869158258e 100644
--- a/drivers/net/ntnic/include/flow_api.h
+++ b/drivers/net/ntnic/include/flow_api.h
@@ -56,7 +56,7 @@ struct nt_eth_rss_conf {
 	enum rte_eth_hash_function algorithm;
 };
 
-int sprint_nt_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t hash_mask);
+int nthw_sprint_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t hash_mask);
 
 struct flow_eth_dev {
 	/* NIC that owns this port device */
@@ -171,7 +171,7 @@ void nthw_flow_nic_set_error(enum flow_nic_err_msg_e msg, struct rte_flow_error
  * Resources
  */
 
-extern const char *dbg_res_descr[];
+extern const char *nthw_dbg_res_descr[];
 
 #define flow_nic_set_bit(arr, x)                                                                  \
 	do {                                                                                      \
@@ -199,7 +199,7 @@ extern const char *dbg_res_descr[];
 		typeof(res_type) _temp_res_type = (res_type);                                     \
 		size_t _temp_index = (index);                                                     \
 		NT_LOG(DBG, FILTER, "mark resource used: %s idx %zu",                             \
-		       dbg_res_descr[_temp_res_type], _temp_index);                               \
+		       nthw_dbg_res_descr[_temp_res_type], _temp_index);                          \
 		RTE_ASSERT(flow_nic_is_bit_set(_temp_ndev->res[_temp_res_type].alloc_bm,          \
 					   _temp_index) == 0);                                    \
 		flow_nic_set_bit(_temp_ndev->res[_temp_res_type].alloc_bm, _temp_index);          \
@@ -210,7 +210,7 @@ extern const char *dbg_res_descr[];
 		typeof(res_type) _temp_res_type = (res_type);                                 \
 		size_t _temp_index = (index);                                                     \
 		NT_LOG(DBG, FILTER, "mark resource unused: %s idx %zu",                         \
-		       dbg_res_descr[_temp_res_type], _temp_index);                               \
+		       nthw_dbg_res_descr[_temp_res_type], _temp_index);                          \
 		flow_nic_unset_bit((_ndev)->res[_temp_res_type].alloc_bm, _temp_index);           \
 	} while (0)
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 4d1c9c8d7c..dee2ee137a 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -18,7 +18,7 @@
 		name, #name   \
 	}
 
-const char *dbg_res_descr[] = {
+const char *nthw_dbg_res_descr[] = {
 	[RES_QUEUE] = "RES_QUEUE",
 	[RES_CAT_CFN] = "RES_CAT_CFN",
 	[RES_CAT_COT] = "RES_CAT_COT",
@@ -41,7 +41,7 @@ const char *dbg_res_descr[] = {
 	[RES_INVALID] = "RES_INVALID",
 };
 
-static_assert(RTE_DIM(dbg_res_descr) == RES_END,
+static_assert(RTE_DIM(nthw_dbg_res_descr) == RES_END,
 	"The list of debug descriptions is not fully completed");
 
 static struct flow_nic_dev *dev_base;
@@ -212,7 +212,7 @@ void nthw_flow_nic_free_resource(struct flow_nic_dev *ndev, enum res_type_e res_
 int nthw_flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
 {
 	NT_LOG(DBG, FILTER, "Reference resource %s idx %i (before ref cnt %" PRIu32 ")",
-		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
+		nthw_dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
 	RTE_ASSERT(flow_nic_is_resource_used(ndev, res_type, index));
 
 	if (ndev->res[res_type].ref[index] == (uint32_t)-1)
@@ -225,7 +225,7 @@ int nthw_flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_ty
 int nthw_flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
 {
 	NT_LOG(DBG, FILTER, "De-reference resource %s idx %i (before ref cnt %" PRIu32 ")",
-		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
+		nthw_dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
 	RTE_ASSERT(flow_nic_is_resource_used(ndev, res_type, index));
 	RTE_ASSERT(ndev->res[res_type].ref[index]);
 	/* deref */
@@ -494,7 +494,7 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 
 	for (unsigned int i = 0; i < RES_COUNT; i++) {
 		int err = 0;
-		NT_LOG(DBG, FILTER, "RES state for: %s", dbg_res_descr[i]);
+		NT_LOG(DBG, FILTER, "RES state for: %s", nthw_dbg_res_descr[i]);
 
 		for (unsigned int ii = 0; ii < ndev->res[i].resource_count; ii++) {
 			int ref = ndev->res[i].ref[ii];
@@ -983,7 +983,7 @@ static struct rss_type_info rss_to_string[] = {
 	RSS_TO_STRING(RTE_ETH_RSS_L3_SRC_ONLY),
 };
 
-int sprint_nt_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t hash_mask)
+int nthw_sprint_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t hash_mask)
 {
 	if (str == NULL || str_len == 0)
 		return -1;
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
index 76ff79cbe1..9a7069194b 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
@@ -130,7 +130,7 @@ static __rte_always_inline void unset_bits_and_log(uint64_t *hash_mask, uint64_t
 	char rss_buffer[4096];
 	uint16_t rss_buffer_len = sizeof(rss_buffer);
 
-	if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", *hash_mask & hash_bits) == 0)
+	if (nthw_sprint_rss_mask(rss_buffer, rss_buffer_len, " ", *hash_mask & hash_bits) == 0)
 		NT_LOG(DBG, FILTER, "Configured RSS types:%s", rss_buffer);
 	unset_bits(hash_mask, hash_bits);
 }
@@ -141,14 +141,14 @@ static __rte_always_inline void unset_bits_if_all_enabled(uint64_t *hash_mask, u
 		unset_bits(hash_mask, hash_bits);
 }
 
-int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_conf)
+int nthw_hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_conf)
 {
 	uint64_t fields = rss_conf.rss_hf;
 
 	char rss_buffer[4096];
 	uint16_t rss_buffer_len = sizeof(rss_buffer);
 
-	if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", fields) == 0)
+	if (nthw_sprint_rss_mask(rss_buffer, rss_buffer_len, " ", fields) == 0)
 		NT_LOG(DBG, FILTER, "Requested RSS types:%s", rss_buffer);
 
 	/*
@@ -645,7 +645,7 @@ int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_c
 
 	if (fields || res != 0) {
 		nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
-		if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", rss_conf.rss_hf) == 0) {
+		if (nthw_sprint_rss_mask(rss_buffer, rss_buffer_len, " ", rss_conf.rss_hf) == 0) {
 			NT_LOG(ERR, FILTER, "RSS configuration%s is not supported for hash func %s.",
 				rss_buffer, (enum rte_eth_hash_function)toeplitz ?
 					"Toeplitz" : "NTH10");
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
index 38901b3e8a..124225c455 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
@@ -11,7 +11,7 @@
 #include "hw_mod_backend.h"
 #include "flow_api.h"
 
-int hsh_set(struct flow_nic_dev *ndev, int hsh_idx,
+int nthw_hsh_set(struct flow_nic_dev *ndev, int hsh_idx,
 	struct nt_eth_rss_conf rss_conf);
 
 #endif /* _FLOW_HSH_CFG_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index b1a2d9dfa3..5de4f6bae7 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -598,7 +598,7 @@ void nthw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struc
 			fprintf(file, "      %016lx\n", data->hash_mask);
 
 			/* convert hash mask to human readable RTE_ETH_RSS_* form if possible */
-			if (sprint_nt_rss_mask(str_buffer, rss_buffer_len, "\n      ",
+			if (nthw_sprint_rss_mask(str_buffer, rss_buffer_len, "\n      ",
 					data->hash_mask) == 0) {
 				fprintf(file, "    Hash mask flags:%s\n", str_buffer);
 			}
@@ -2830,7 +2830,7 @@ struct hw_db_hsh_idx nthw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_
 	tmp_rss_conf.rss_hf = data->hash_mask;
 	memcpy(tmp_rss_conf.rss_key, data->key, MAX_RSS_KEY_LEN);
 	tmp_rss_conf.algorithm = data->func;
-	int res = hsh_set(ndev, idx.ids, tmp_rss_conf);
+	int res = nthw_hsh_set(ndev, idx.ids, tmp_rss_conf);
 
 	if (res != 0) {
 		idx.error = 1;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index e0cdd12626..a1f9e3addf 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -3977,7 +3977,7 @@ int nthw_init_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 			.rss_hf = RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_PORT,
 			.algorithm = 0,
 		};
-		hsh_set(ndev, 0, hsh_5_tuple);
+		nthw_hsh_set(ndev, 0, hsh_5_tuple);
 		nthw_mod_hsh_rcp_flush(&ndev->be, 0, 1);
 
 		flow_nic_mark_resource_used(ndev, RES_HSH_RCP, 0);
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 1c26411da8..906e55de7c 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1770,7 +1770,7 @@ static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_r
 	tmp_rss_conf.algorithm = rss_conf->algorithm;
 
 	tmp_rss_conf.rss_hf = rss_conf->rss_hf;
-	int res = hsh_set(ndev, hsh_idx, tmp_rss_conf);
+	int res = nthw_hsh_set(ndev, hsh_idx, tmp_rss_conf);
 
 	if (res == 0) {
 		flow_filter_ops->nthw_mod_hsh_rcp_flush(&ndev->be, hsh_idx, 1);
-- 
2.45.0

