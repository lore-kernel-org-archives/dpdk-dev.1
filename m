Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D80CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D09840E20;
	Mon, 20 Oct 2025 18:36:51 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4E47B40A6E
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021075.outbound.protection.outlook.com [52.101.70.75])
 by mx-outbound16-221.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRjoKnjgNm2jeWm4Yc5HcBmzGHr8cGHlKQ7n5Lw8TRGd2DdcVkUKuEs/JpzEgFP1g9wQuMGBI1VlghcpK9HwYwIz6y/5APlgA0L4dM1dhn/eHYxS9nor1bNbkotFCULPdPMid9/jwl2wxBQXNRgy/eJ7jTYiwWw7Ok0RBK8lKE/tqF+R7U1CrF+5mgCo53Edz8tmfRSsESrS1DwIeg+tCNVLPNBm/TjT7E4gj0INTcT/qsxasmyVI3nea8hAoGtJ0umsEg9sHmcp2dioRGv6tSEZuZBgpCHCPhBeyt+gg8J73rcdu8hOYIm8qQBulqQlu5hnCH+v4Tiqhekduu0/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc8el/cyaveFUN0QSENGm9csHaGf52WGvtcvqsWc+Zw=;
 b=goog9MqkWwGQKr2wgaDkdGJyPp1dsGN4zh9xT6wGzvWQvjoRleTYkWLNxp9JSVsN26gRqWgvyKW1yd0vNEUOwj/gYA+2p+PgxribgXW/4ezz7/Dlpk2ndIla3DdJv7ilLLxHUvhgonF2T1COoQs6OwGgpu+AYucy7kClfDaeV9gasLc9sZbeB5X9roXJp9+fmNPFBHsRgEaG4XlMR7Rvw7v62kYQKRhEUDW059AAXqbv6AgXfgL/wi5ZTCrBktmJNm/hH5DO2Qhd2ApwsXqk7Cn2sAMtGF5+WhalFPoBWVK8CO/4pB5/6tLS1DlquQqLPRe56luoogngBoapMqYeMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc8el/cyaveFUN0QSENGm9csHaGf52WGvtcvqsWc+Zw=;
 b=RkA0vZpsFbNR99UssGb5Ssqdmj1TcmklM0yvE5q8QnjLUwc+r5qtMGBvsDSMaI/2S3uW+p/nYchPkw5KlOwr6QKG/oaG7aP33JcWvsD2wxRkt/Nsaz8B90kFLiugrJr9VjUZ7hZSnA6ZP2bw45mv3nVFpRXEX4Sc31x83Fg7tiw=
Received: from AS4P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::18)
 by AM9P190MB1314.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:268::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:40 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::dc) by AS4P191CA0024.outlook.office365.com
 (2603:10a6:20b:5d9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:40
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 19/24] net/ntnic: rename common hash and flow functions
Date: Mon, 20 Oct 2025 18:36:10 +0200
Message-ID: <20251020163620.282312-20-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|AM9P190MB1314:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d51cf047-213e-4cb7-e444-08de0ff6d8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D3JwE4uPrGTWlAS7CusgHjUYUG4d94xhgmlITWIDd0JLHtIYsgnDofU0WIIi?=
 =?us-ascii?Q?UHr0yV4KFDWWQnHRQmFCeaDUPWQ0pCvdhJy1+2OP3aFL+LIUFqUnhRNsyJjK?=
 =?us-ascii?Q?NlkJYZJJwIfdXicT7N0o8VUa65mpnpMOF/hTVkw6/XEyWZeTREZo9X29m+1r?=
 =?us-ascii?Q?ceRQ9y6H/7W0DKd2K4Zb+xqZA9ao2HXaM2uPlV3gOjAKJuWRJsrS8OtRirMz?=
 =?us-ascii?Q?LSV6GmLooV9jZzGEaY5a+s+rnH1qssK62i01iPOVasYsxkWdEwWQEAfXifuA?=
 =?us-ascii?Q?20rQMHqma3m2zoqDjtittfFhXSTRQ0gMqWzWTCfzgUoaZq/B3rsHprxARB3Q?=
 =?us-ascii?Q?rqO56ik1yFBCx5aWQ9G5lMbuM3vinzqSZp9d4WznWaLcQ1QRoWKRkjKVAG48?=
 =?us-ascii?Q?c4YEbb0Pdj52hYmoOynIlHkwRI2BFrOKtDczSjab5Ar4tqAPmJAQijx/K0JT?=
 =?us-ascii?Q?skx5yiRViqjkas7BJd5Q6QULQ6IgOofNlTslEioNwRHh7Vtq/9NrnVRDWVqS?=
 =?us-ascii?Q?E6nJP/uV5aAbH9cCjsOyzuFbOAUsmixA4Yi78nuX12MzGZK6I1TSRz9w6WOu?=
 =?us-ascii?Q?NpKcy4+CYyrKMHKHtQWlsOf1ZZkJepkP1FXowKeF5zVbWZt1wJP3P4rf3r/d?=
 =?us-ascii?Q?xGkoVj+wFuC3gIM/SI6XVVbP3lvq87cyVYbWsjJ6ysQAPVcnE+qZwEDW+ag6?=
 =?us-ascii?Q?AV8PFnwq4X7DVsD1Qu4p7XEmZuRCbPEILY0soT+Lu3BPvo3Qhcxd52siG+UH?=
 =?us-ascii?Q?WM3VC9BCa/zD00gYsRnN7sdUZlFbBFDqRz9XLTPOfQCZmj6aO1et6eQU4tR4?=
 =?us-ascii?Q?TZXh8aJLwY4/oJyX/pyD5ELzhL17/riYnl4r+kFY/toAHhnK6wLDHyOK+JX4?=
 =?us-ascii?Q?1BB4IX9SHgyk+1En20K/QBkQoXafw8TiSrUqqhfhM1hB8k7IwR2RTXTo3jg/?=
 =?us-ascii?Q?54F5pC2jvnpVmYPrm5ZdXrefjve3QMIUpjisXTqUF0Vl1Gk313mw8cDOEVbO?=
 =?us-ascii?Q?7iWo313JW2Nmw8mIFFu/khpxoRKTAYkQBrMk3OTdOCIZHaPtexZeeV5dTtyy?=
 =?us-ascii?Q?IrQ8D49SRg/9dOmzA7I0WHRHK2FGUcAtpz96Olq70EHKurm265PYdlx3oEuo?=
 =?us-ascii?Q?5KUi36C5p2f3DVXgfZsHpoVndgfQPAg7zRM9EQC7hFRRFr2bocLopDek8lzT?=
 =?us-ascii?Q?XIupj0yEIku+icAJfh8T1E3vJT9DqdMDIrMInptuGyh95TU7eSEBnb+4JQev?=
 =?us-ascii?Q?ADHT8pafKAmRlbw5RsWDN3IIyogtNCO5ffh8WRdn1YjaDAzIFxk+7XZF05Rv?=
 =?us-ascii?Q?zi1fXBmJmkZtjjHsP/NCk2EZt1FZIG6Wcpq2AZ15NEESC/is7iU+MLmDeNO2?=
 =?us-ascii?Q?+7sRosFZ6V+JE0atA7b1MpgejeOigqVdAhoOb7+inFWfOI0EC05xQYIoGW0z?=
 =?us-ascii?Q?A+c8UySUvKtZG+qomtJiqI0EwmmRhDTmrXOidQ7oYnvgoPWoHgIqZic8K5MB?=
 =?us-ascii?Q?1k1/G3qZVFKfzn+QVWo+IOfyR7KsKnXlNXNmqr5orcBUSYaS5+uud5lezWnK?=
 =?us-ascii?Q?VHFXFAL973+lq4k/DnU=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w63nD+LzgwvoaATgzY4yUhVHn0xoeNYVRbHiWoqDdMGYNw34we/yLfBy8ob0HqhZYwXeP8Zw3iu8QzWIJYZExczpqnovCWqvxUGZRq9mKr6u8OrIEt7LkH0pddm+5an5Qxki/I/Azvnnq/IShSR5fQWDZQwX176b2ioucflEv2qo8hXrKKvwTcrdjsgazPSYwO2RqAx+Vits9DZ57VBfTPWHYA1UnLA1MYJPYZ08x97WX5no6ck8LakBDlLi09VzZgHBrEsl5TTaAvMGtNP4eSo7G9pPES+BenrjiguAbELIsyKtZE9/aFgcAiFf4MJr/UZ2q+LHWV5Rkwygr61BwaxYRn88uRR3RNKNdA4a5NQEptPlM1QwQ3Kqu/1X6/cYuJ2jgWIYKNw+G3ExjI0XzvUPZuwEuQzUud6325B3k3Pav6QFfDJo+f4MQVPlODdhcDTI8g7JdXRFR0plJB33CG2w1pmPcyH8rcoIc4G3mUsRkbgKv+tlSJsnteoGmczKseqmjtO+nm1Vvl4qmuoGcNNTsywgfzeQ8bVRYyMIb4rv3s8EJmSVnEr0K8BSuXIz3CoSINrjwUZRuTQCHRgFgDichsG+MtcSrNKREcMuUl+nKrQD/RAN3K7gzXTLxMorMI1rHNYvb99zi2J1RpfqCFca7b17XOcMyfPQD9zwVY8=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:40.2891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51cf047-213e-4cb7-e444-08de0ff6d8a0
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1314
X-BESS-ID: 1760978201-304317-25455-11747-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.70.75
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGxpZGQGYGUNQsyTIp2cLCzM
 Is0SAxNdEixcTM3CjJINXSyMAozcjUTKk2FgCDDjbAQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-181.eu-central-1b.ess.aws.cudaops.com]
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

