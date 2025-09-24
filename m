Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D72CCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:44:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 400C840E25;
	Wed, 24 Sep 2025 16:42:32 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 383ED40151
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:15 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023137.outbound.protection.outlook.com
 [40.107.159.137]) by mx-outbound13-221.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olI0wh7A/x0jVlM0kXV240xvPM016Zw0OfCgP4CzNBlnuiHm21NkEWRLZZFp0FxgcPz5veS01YAFSSKqMP9Y2KPMTGR/0n6Y2oyS2IfihgjRk45txoMCSIgG8soaJAtyckjkwRoE7WYXQAlBrmiFnAn480DUMQqjv9X/mbGikwSv9J3dvgE0k13oiD/PodA02+gIewlKzot8teE1NG80RxoxtZyrEcOezoNFICQw1eTodSnm4QszbSc1okveuRWvzh42BtNiKSbgH+hgXF9AFn1IjbSbflE+rl4bEo4PsPgVz8mJR5xeqCuKgkS7UEkOEcZp9IP0A8RC4srZzOYFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn418dZt87Mct0rllbuDsHiQGybUiNecxLfxzPTuAiw=;
 b=ee1US0z+mYFgz30fX1YEgmiYZFLcSDpyIPd0P74MZMxQbSbWwasyJd7TD2rHMzAU9X9IEy7wCw5bgmYyO5uHm+nCSh3oIXu579t6jEvOdAAZ/sT1OkaSyCodjtYhLax24NhsVV4iWdM+e3glLSfT8zNd9lzbRLwdstEAHc2ane4oy9OrythCQXOPMCKIrdQ0qbBnnBfekvgSC8LH9gUjMramWdlrA2P9XLdhtLDu7mp0+hgwTeV9bxCV9hPkEBI50juueB/hRpLyJ3Lx230gqbTILypIWbiZh7IAyLZSsk1gLozhPmGKgdzIX+kWaXqNDfvJjFDXnbgWxfTmxqq30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn418dZt87Mct0rllbuDsHiQGybUiNecxLfxzPTuAiw=;
 b=HpVXLMrhfnm0o4xBY5oXyYrbsf2Kt4qnes8+4g/oxsW5Z64Ws3Gl8m7vA9i2Gx+hgakUTBHyrMdRtN3Fg0BlELDj2Ts0iJxgoxaNQPBSl0L5S4SauESeBfubqtTyRqbs/OuBOr8AUqO7y9Ka/6zUf+Klo3MouS2B6W+jmKC4JXs=
Received: from CWLP123CA0224.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::12)
 by AS8P190MB1094.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2b7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:42:11 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::40) by CWLP123CA0224.outlook.office365.com
 (2603:10a6:400:19f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 14:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:11
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 17/24] net/ntnic: change prefix km to prefix nthw
Date: Wed, 24 Sep 2025 16:41:40 +0200
Message-ID: <20250924144152.53203-18-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS8P190MB1094:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a83a1a31-2bac-493f-a962-08ddfb788bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?br7Q0MXuKj1FQQaA2AXzSBFmZOQV4fIyX1uhlcurOnNZBIkCC6jswbXcJwMq?=
 =?us-ascii?Q?1kkqND5XUvL4UhMmx5XPz5TkNed51sUxaOMCLm9kKg7jKS5XvB7xESf5S7+l?=
 =?us-ascii?Q?ek1vqu9esZLnCb91krOPQETPsfKpfebuumge6QoOR0v1yO7P5WkdYvaPZdtM?=
 =?us-ascii?Q?dK4TbzwO7owhSzT9OfDzfpVeGZe2kQDb5snzeFiNdKqfCieQ7tpjPQ0qRPUh?=
 =?us-ascii?Q?GgXNmkhVB4LIiQqM+lZjfrcfDjPkyoy40HWD15Uhox7wtmeR9y5P+mpR1k4O?=
 =?us-ascii?Q?CUunWWTg1N8uT3u7b4W7YzNvHW1GZnVshuzFrBxDU5NU8AAQnodm/KiNkKH7?=
 =?us-ascii?Q?yApYv2TaCKbG+LO6QvTq2Kr6JSWwCKnKzIBtCebgDfxe7M9GlqSFfxCXpmOp?=
 =?us-ascii?Q?r7FDFNvkvRtKgoIIJSWDlCeKwKUJjyckzaOqrQ91OhKZhzF4Rlc+RSElwo0h?=
 =?us-ascii?Q?CFWya/wUF5LUoU6LEFrThiolu7rE3/PMB6SC3E1hIDo9Io/6CIBIf8051j4h?=
 =?us-ascii?Q?3R2gaxD0yuF0wiJMdkU5FTYpquA5Vo1ntKmgN5WT7tDwu8xkJgAEwjvOTbY0?=
 =?us-ascii?Q?IFJvJ0UAMEi+DIxMR6HHmFODWJ6NxAmFG1tTzWOoPDI2kUn//LNhg9vjidLE?=
 =?us-ascii?Q?iREFgzAnXHqgDp1gyyxAtGiywCeSz+vF/O7D+QhCzYm9CZkhXRyF4oDNAbwv?=
 =?us-ascii?Q?aX8tFc33pYiTQm6q8A9S911CLEp0GWCBVXoHWbXnLzEtmQMNfwBhGcpgwg8N?=
 =?us-ascii?Q?SOriEOcWySqiMxeKxq2nfq3zs+A/aZ6vfsFeMfHRgoZfNBfNBhuXb9bBq/44?=
 =?us-ascii?Q?POQeaRo/Pk2WhVkcwkzeKZ/MwjcYB0hNgXsHLzyvoNZl+s8IfeLW93uT/gN7?=
 =?us-ascii?Q?pF14RjMuC7WrXt3zwSWHTBv+QhV+dVI+gTwOyfmHamwZplRBrF2NVDaYjEOs?=
 =?us-ascii?Q?RdwgBkt7CPt6c6o2aYkiJbUTe+D3O+tHsZCsOrtJ0yVzUxvUh+zcztzEwpQA?=
 =?us-ascii?Q?Iyon3IzUklO/QXrvAeFQZCOxdJ9LmIlCRspSeYi0Z3K6O9ItiCcf1oJ299D4?=
 =?us-ascii?Q?yViJzgO23FN0jg5uKMki1Em/m9sGbR8yiBQtiWOVj1zIf32xOO+5T+HUg21w?=
 =?us-ascii?Q?GnqZNereC7vTUlIf83nzJxr7m/6Mj3bFcjFJ+533IaXx2I7bS3I6XWo6t+jN?=
 =?us-ascii?Q?eoB21beo7HE5f1aDc0FrHza0UeA22Ajk3ofUgosriNSaiLTW3iA8y+dgjdwf?=
 =?us-ascii?Q?CmcVLuCoErQkKSLXg0M+xkRupGsL7/anFjTrBO/QmEtJ58Kg5yZBafK2r2kq?=
 =?us-ascii?Q?hOi6Z0G+wc6ypsqBBvPefAijyuN/d+Dt3acNnq4JBHb04y+Aw7C3RqBgKKVA?=
 =?us-ascii?Q?4a+Slc3yZ55hVKmXsHuE/S/64J9+L6be+6CoBbBeUJCHfjn3Y5x+69diiqoO?=
 =?us-ascii?Q?r7H1QI+EgBIt//nX/yRN/ORfz8PI2iPhLwMkvnx3dMJwAzE/LHNUOQmjAol1?=
 =?us-ascii?Q?gKnU3cd72HtFmZwqKfqHvML3YphWqMB5JJWJ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SAB1FoZEcUMjNrt+lnfqpXTo8Nww8lz8u7I69QOwAE3QDxysYS0JLYsWusK2ekOXrGGsLz3PFBfa188nryl4H21TtLhO2YVfQcRH8BeDndvHtUGRWA7zbNuSjx4XfbnD2unwf5w2BB5ZYJm5JXOqfpk76iS6jlTw4U7qap8ft6KE6aBid7+JV8ESByowwKTCGBCiroZFNm+E8cASLYTg117CWE/BCGQT6ik9Q3lotqeAC+15mSUc6896mF/eW8UTAYg1f/8+QicJu5Z3CT5ngd/GWiA3WHNsSIdCeG1GPn9zpKI22TeCmqxpb1BGReoEPysNqJTK1bt5wbknwk7o951eZ56g3lZ6aM7eEKzzBN/aWdCxpNTVbX7MTQbnuvBpX1bDHmSpW88flfjX1KowvCBpD3k8RkkXtTvfKPjM1JWY9lGSHgPnqo3SP/C6gON4VyM1ISA1mzjSkqzQBUVa66x2n19dFXPSCxUdSYKsb+NSA2tDVoaTxOVvKr697inW8mzh/090SoHNnoLHmTkRTrdwSE30JfZC94dLU7mgKkrAMMC1Zj2s5QDvJU4bNFmvvlUH6fbFxHPpECDm5Gy4HsY2tCbYgh7qtbQuBa4oNVkXGIITjAnStsG1Z8HwDO1QwFl5u+6AVun0PSqAhvWhVQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:11.7780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83a1a31-2bac-493f-a962-08ddfb788bee
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1094
X-BESS-ID: 1758724933-303549-7631-8102-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.159.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGliamQGYGUNTcMNXQ0DDZKN
 U8LdnUwCg1yTIlLSXJINHAINXU1MTIXKk2FgBEKZrfQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan17-191.eu-central-1b.ess.aws.cudaops.com]
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

Change prefix km_ (key matcher) to prefix nthw_km_ for flow_api module.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api_engine.h   | 18 ++--
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  4 +-
 drivers/net/ntnic/nthw/flow_api/flow_kcc.c    |  2 +-
 drivers/net/ntnic/nthw/flow_api/flow_km.c     | 16 +--
 .../profile_inline/flow_api_profile_inline.c  | 99 ++++++++++---------
 5 files changed, 75 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ntnic/include/flow_api_engine.h b/drivers/net/ntnic/include/flow_api_engine.h
index 6401c79e3c..6a27ba8e12 100644
--- a/drivers/net/ntnic/include/flow_api_engine.h
+++ b/drivers/net/ntnic/include/flow_api_engine.h
@@ -396,26 +396,26 @@ struct flow_template_table {
 	uint16_t caller_id;
 };
 
-void km_attach_ndev_resource_management(struct km_flow_def_s *km, void **handle);
-void km_free_ndev_resource_management(void **handle);
+void nthw_km_attach_ndev_resource_management(struct km_flow_def_s *km, void **handle);
+void nthw_km_free_ndev_resource_management(void **handle);
 
-int km_add_match_elem(struct km_flow_def_s *km, uint32_t e_word[4], uint32_t e_mask[4],
+int nthw_km_add_match_elem(struct km_flow_def_s *km, uint32_t e_word[4], uint32_t e_mask[4],
 	uint32_t word_len, enum frame_offs_e start, int8_t offset);
 
-int km_key_create(struct km_flow_def_s *km, uint32_t port_id);
+int nthw_km_key_create(struct km_flow_def_s *km, uint32_t port_id);
 /*
  * Compares 2 KM key definitions after first collect validate and optimization.
  * km is compared against an existing km1.
  * if identical, km1 flow_type is returned
  */
-int km_key_compare(struct km_flow_def_s *km, struct km_flow_def_s *km1);
+int nthw_km_key_compare(struct km_flow_def_s *km, struct km_flow_def_s *km1);
 
-int km_rcp_set(struct km_flow_def_s *km, int index);
+int nthw_km_rcp_set(struct km_flow_def_s *km, int index);
 
-int km_write_data_match_entry(struct km_flow_def_s *km, uint32_t color);
-int km_clear_data_match_entry(struct km_flow_def_s *km);
+int nthw_km_write_data_match_entry(struct km_flow_def_s *km, uint32_t color);
+int nthw_km_clear_data_match_entry(struct km_flow_def_s *km);
 
-void kcc_free_ndev_resource_management(void **handle);
+void nthw_kcc_free_ndev_resource_mgmnt(void **handle);
 
 /*
  * Group management
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 4c7bb4a60a..4d1c9c8d7c 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -478,8 +478,8 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 
 	profile_inline_ops->nthw_done_flow_mgmnt_of_ndev_profile_inline(ndev);
 
-	km_free_ndev_resource_management(&ndev->km_res_handle);
-	kcc_free_ndev_resource_management(&ndev->kcc_res_handle);
+	nthw_km_free_ndev_resource_management(&ndev->km_res_handle);
+	nthw_kcc_free_ndev_resource_mgmnt(&ndev->kcc_res_handle);
 
 	ndev->flow_unique_id_counter = 0;
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_kcc.c b/drivers/net/ntnic/nthw/flow_api/flow_kcc.c
index e99e63d9f1..47311729ea 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_kcc.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_kcc.c
@@ -8,7 +8,7 @@
 #include "hw_mod_backend.h"
 #include "flow_api_engine.h"
 
-void kcc_free_ndev_resource_management(void **handle)
+void nthw_kcc_free_ndev_resource_mgmnt(void **handle)
 {
 	if (*handle) {
 		free(*handle);
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_km.c b/drivers/net/ntnic/nthw/flow_api/flow_km.c
index 1052773668..4ccd77895b 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_km.c
@@ -73,7 +73,7 @@ struct tcam_distrib_s {
 
 static int tcam_find_mapping(struct km_flow_def_s *km);
 
-void km_attach_ndev_resource_management(struct km_flow_def_s *km, void **handle)
+void nthw_km_attach_ndev_resource_management(struct km_flow_def_s *km, void **handle)
 {
 	/*
 	 * KM entries occupied in CAM - to manage the cuckoo shuffling
@@ -100,7 +100,7 @@ void km_attach_ndev_resource_management(struct km_flow_def_s *km, void **handle)
 	nthw_init_hasher(km->hsh, km->be->km.nb_cam_banks, km->be->km.nb_cam_records);
 }
 
-void km_free_ndev_resource_management(void **handle)
+void nthw_km_free_ndev_resource_management(void **handle)
 {
 	if (*handle) {
 		free(*handle);
@@ -110,7 +110,7 @@ void km_free_ndev_resource_management(void **handle)
 	*handle = NULL;
 }
 
-int km_add_match_elem(struct km_flow_def_s *km, uint32_t e_word[4], uint32_t e_mask[4],
+int nthw_km_add_match_elem(struct km_flow_def_s *km, uint32_t e_word[4], uint32_t e_mask[4],
 	uint32_t word_len, enum frame_offs_e start_id, int8_t offset)
 {
 	/* valid word_len 1,2,4 */
@@ -173,7 +173,7 @@ static int get_word(struct km_flow_def_s *km, uint32_t size, int marked[])
 	return -1;
 }
 
-int km_key_create(struct km_flow_def_s *km, uint32_t port_id)
+int nthw_km_key_create(struct km_flow_def_s *km, uint32_t port_id)
 {
 	/*
 	 * Create combined extractor mappings
@@ -377,7 +377,7 @@ int km_key_create(struct km_flow_def_s *km, uint32_t port_id)
 	return 0;
 }
 
-int km_key_compare(struct km_flow_def_s *km, struct km_flow_def_s *km1)
+int nthw_km_key_compare(struct km_flow_def_s *km, struct km_flow_def_s *km1)
 {
 	if (km->target != km1->target || km->num_ftype_elem != km1->num_ftype_elem ||
 		km->key_word_size != km1->key_word_size || km->info_set != km1->info_set)
@@ -473,7 +473,7 @@ int km_key_compare(struct km_flow_def_s *km, struct km_flow_def_s *km1)
 	return km1->flow_type;
 }
 
-int km_rcp_set(struct km_flow_def_s *km, int index)
+int nthw_km_rcp_set(struct km_flow_def_s *km, int index)
 {
 	int qw = 0;
 	int sw = 0;
@@ -1101,7 +1101,7 @@ static int tcam_reset_entry(struct km_flow_def_s *km)
 	return err;
 }
 
-int km_write_data_match_entry(struct km_flow_def_s *km, uint32_t color)
+int nthw_km_write_data_match_entry(struct km_flow_def_s *km, uint32_t color)
 {
 	int res = -1;
 
@@ -1125,7 +1125,7 @@ int km_write_data_match_entry(struct km_flow_def_s *km, uint32_t color)
 	return res;
 }
 
-int km_clear_data_match_entry(struct km_flow_def_s *km)
+int nthw_km_clear_data_match_entry(struct km_flow_def_s *km)
 {
 	int res = 0;
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 6fc496e16a..e0cdd12626 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -1725,7 +1725,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 		sw_mask[0] = 0x0fff;
 		sw_data[0] = implicit_vlan_vid & sw_mask[0];
 
-		km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1, DYN_FIRST_VLAN, 0);
+		nthw_km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1, DYN_FIRST_VLAN, 0);
 		set_key_def_sw(key_def, sw_counter, DYN_FIRST_VLAN, 0);
 		sw_counter += 1;
 
@@ -1874,7 +1874,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 
 					qw_mask[3] = ntohs(eth_mask->ether_type) << 16;
 
-					km_add_match_elem(&fd->km,
+					nthw_km_add_match_elem(&fd->km,
 						&qw_data[(size_t)(qw_counter * 4)],
 						&qw_mask[(size_t)(qw_counter * 4)], 4, DYN_L2, 0);
 					set_key_def_qw(key_def, qw_counter, DYN_L2, 0);
@@ -1897,7 +1897,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					sw_mask[0] = ntohs(eth_mask->ether_type) << 16;
 					sw_data[0] = ntohs(eth_spec->ether_type) << 16 & sw_mask[0];
 
-					km_add_match_elem(&fd->km, &sw_data[0],
+					nthw_km_add_match_elem(&fd->km, &sw_data[0],
 						&sw_mask[0], 1, DYN_L2, 12);
 					set_key_def_sw(key_def, sw_counter, DYN_L2, 12);
 					sw_counter += 1;
@@ -1944,7 +1944,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						ntohs(vlan_spec->eth_proto);
 					sw_data[0] &= sw_mask[0];
 
-					km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
+					nthw_km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
 						DYN_FIRST_VLAN, 2 + 4 * fd->vlans);
 					set_key_def_sw(key_def, sw_counter, DYN_FIRST_VLAN,
 						2 + 4 * fd->vlans);
@@ -1971,7 +1971,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					qw_data[2] &= qw_mask[2];
 					qw_data[3] &= qw_mask[3];
 
-					km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
+					nthw_km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
 						DYN_FIRST_VLAN, 2 + 4 * fd->vlans);
 					set_key_def_qw(key_def, qw_counter, DYN_FIRST_VLAN,
 						2 + 4 * fd->vlans);
@@ -2066,7 +2066,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					qw_data[2] = ntohl(ipv4_spec->hdr.src_addr) & qw_mask[2];
 					qw_data[3] = ntohl(ipv4_spec->hdr.dst_addr) & qw_mask[3];
 
-					km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
+					nthw_km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
 						any_count > 0 ? DYN_TUN_L3 : DYN_L3, 4);
 					set_key_def_qw(key_def, qw_counter, any_count > 0
 						? DYN_TUN_L3 : DYN_L3, 4);
@@ -2094,7 +2094,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					sw_mask[0] = ntohl(ipv4_mask->hdr.src_addr);
 					sw_data[0] = ntohl(ipv4_spec->hdr.src_addr) & sw_mask[0];
 
-					km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
+					nthw_km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
 						any_count > 0 ? DYN_TUN_L3 : DYN_L3, 12);
 					set_key_def_sw(key_def, sw_counter, any_count > 0
 						? DYN_TUN_L3 : DYN_L3, 12);
@@ -2115,7 +2115,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					sw_mask[0] = ntohl(ipv4_mask->hdr.dst_addr);
 					sw_data[0] = ntohl(ipv4_spec->hdr.dst_addr) & sw_mask[0];
 
-					km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
+					nthw_km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
 						any_count > 0 ? DYN_TUN_L3 : DYN_L3, 16);
 					set_key_def_sw(key_def, sw_counter, any_count > 0
 						? DYN_TUN_L3 : DYN_L3, 16);
@@ -2137,7 +2137,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					sw_data[0] = ipv4_spec->hdr.next_proto_id
 						<< 16 & sw_mask[0];
 
-					km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
+					nthw_km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
 						any_count > 0 ? DYN_TUN_L3 : DYN_L3, 8);
 					set_key_def_sw(key_def, sw_counter, any_count > 0
 						? DYN_TUN_L3 : DYN_L3, 8);
@@ -2208,7 +2208,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					qw_data[2] &= qw_mask[2];
 					qw_data[3] &= qw_mask[3];
 
-					km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
+					nthw_km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
 						any_count > 0 ? DYN_TUN_L3 : DYN_L3, 8);
 					set_key_def_qw(key_def, qw_counter, any_count > 0
 						? DYN_TUN_L3 : DYN_L3, 8);
@@ -2244,7 +2244,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					qw_data[2] &= qw_mask[2];
 					qw_data[3] &= qw_mask[3];
 
-					km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
+					nthw_km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
 						any_count > 0 ? DYN_TUN_L3 : DYN_L3, 24);
 					set_key_def_qw(key_def, qw_counter, any_count > 0
 						? DYN_TUN_L3 : DYN_L3, 24);
@@ -2259,8 +2259,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						sw_mask[0] = ipv6_mask->hdr.proto << 8;
 						sw_data[0] = ipv6_spec->hdr.proto << 8 & sw_mask[0];
 
-						km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0],
-							1, any_count > 0 ? DYN_TUN_L3 : DYN_L3, 4);
+						nthw_km_add_match_elem(&fd->km,
+							&sw_data[0], &sw_mask[0], 1,
+							any_count > 0 ? DYN_TUN_L3 : DYN_L3, 4);
 						set_key_def_sw(key_def, sw_counter, any_count > 0
 							? DYN_TUN_L3 : DYN_L3, 4);
 						sw_counter += 1;
@@ -2286,8 +2287,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						qw_data[2] &= qw_mask[2];
 						qw_data[3] &= qw_mask[3];
 
-						km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0],
-							4, any_count > 0 ? DYN_TUN_L3 : DYN_L3, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&qw_data[0], &qw_mask[0], 4,
+							any_count > 0 ? DYN_TUN_L3 : DYN_L3, 0);
 						set_key_def_qw(key_def, qw_counter, any_count > 0
 							? DYN_TUN_L3 : DYN_L3, 0);
 						qw_counter += 1;
@@ -2349,8 +2351,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 							<< 16) | ntohs(udp_spec->hdr.dst_port)) &
 							sw_mask[0];
 
-						km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0],
-							1, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&sw_data[0], &sw_mask[0], 1,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_sw(key_def, sw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						sw_counter += 1;
@@ -2378,8 +2381,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						qw_data[2] &= qw_mask[2];
 						qw_data[3] &= qw_mask[3];
 
-						km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0],
-							4, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&qw_data[0], &qw_mask[0], 4,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_qw(key_def, qw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						qw_counter += 1;
@@ -2443,8 +2447,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 							<< 16) | ntohs(sctp_spec->hdr.dst_port)) &
 							sw_mask[0];
 
-						km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0],
-							1, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&sw_data[0], &sw_mask[0], 1,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_sw(key_def, sw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						sw_counter += 1;
@@ -2472,8 +2477,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						qw_data[2] &= qw_mask[2];
 						qw_data[3] &= qw_mask[3];
 
-						km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0],
-							4, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&qw_data[0], &qw_mask[0], 4,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_qw(key_def, qw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						qw_counter += 1;
@@ -2541,7 +2547,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 							icmp_spec->hdr.icmp_code << 16;
 						sw_data[0] &= sw_mask[0];
 
-						km_add_match_elem(&fd->km, &sw_data[0],
+						nthw_km_add_match_elem(&fd->km, &sw_data[0],
 							&sw_mask[0], 1, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_sw(key_def, sw_counter,
@@ -2571,8 +2577,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						qw_data[2] &= qw_mask[2];
 						qw_data[3] &= qw_mask[3];
 
-						km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0],
-							4, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&qw_data[0], &qw_mask[0], 4,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_qw(key_def, qw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						qw_counter += 1;
@@ -2640,8 +2647,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 							icmp_spec->code << 16;
 						sw_data[0] &= sw_mask[0];
 
-						km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0],
-							1, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&sw_data[0], &sw_mask[0], 1,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 
 						set_key_def_sw(key_def, sw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
@@ -2670,8 +2678,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						qw_data[2] &= qw_mask[2];
 						qw_data[3] &= qw_mask[3];
 
-						km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0],
-							4, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&qw_data[0], &qw_mask[0], 4,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_qw(key_def, qw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						qw_counter += 1;
@@ -2743,8 +2752,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 							((ntohs(tcp_spec->hdr.src_port) << 16) |
 							ntohs(tcp_spec->hdr.dst_port)) & sw_mask[0];
 
-						km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0],
-							1, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&sw_data[0], &sw_mask[0], 1,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_sw(key_def, sw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						sw_counter += 1;
@@ -2772,8 +2782,9 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						qw_data[2] &= qw_mask[2];
 						qw_data[3] &= qw_mask[3];
 
-						km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0],
-							4, any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
+						nthw_km_add_match_elem(&fd->km,
+							&qw_data[0], &qw_mask[0], 4,
+							any_count > 0 ? DYN_TUN_L4 : DYN_L4, 0);
 						set_key_def_qw(key_def, qw_counter, any_count > 0
 							? DYN_TUN_L4 : DYN_L4, 0);
 						qw_counter += 1;
@@ -2832,7 +2843,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						sw_data[0] =
 							ntohl(gtp_spec->teid) & sw_mask[0];
 
-						km_add_match_elem(&fd->km, &sw_data[0],
+						nthw_km_add_match_elem(&fd->km, &sw_data[0],
 							&sw_mask[0], 1,
 							DYN_L4_PAYLOAD, 4);
 						set_key_def_sw(key_def, sw_counter,
@@ -2862,7 +2873,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						qw_data[2] &= qw_mask[2];
 						qw_data[3] &= qw_mask[3];
 
-						km_add_match_elem(&fd->km, &qw_data[0],
+						nthw_km_add_match_elem(&fd->km, &qw_data[0],
 							&qw_mask[0], 4,
 							DYN_L4_PAYLOAD, 4);
 						set_key_def_qw(key_def, qw_counter,
@@ -2916,7 +2927,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						sw_data[0] = ntohl(gtp_psc_spec->qfi) &
 							sw_mask[0];
 
-						km_add_match_elem(&fd->km, &sw_data[0],
+						nthw_km_add_match_elem(&fd->km, &sw_data[0],
 							&sw_mask[0], 1,
 							DYN_L4_PAYLOAD, 14);
 						set_key_def_sw(key_def, sw_counter,
@@ -2946,7 +2957,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 						qw_data[2] &= qw_mask[2];
 						qw_data[3] &= qw_mask[3];
 
-						km_add_match_elem(&fd->km, &qw_data[0],
+						nthw_km_add_match_elem(&fd->km, &qw_data[0],
 							&qw_mask[0], 4,
 							DYN_L4_PAYLOAD, 14);
 						set_key_def_qw(key_def, qw_counter,
@@ -3713,7 +3724,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 		if (fd->km.num_ftype_elem) {
 			struct flow_handle *flow = dev->ndev->flow_base, *found_flow = NULL;
 
-			if (km_key_create(&fd->km, fh->port_id)) {
+			if (nthw_km_key_create(&fd->km, fh->port_id)) {
 				NT_LOG(ERR, FILTER, "KM creation failed");
 				nthw_flow_nic_set_error(ERR_MATCH_FAILED_BY_HW_LIMITS, error);
 				goto error_out;
@@ -3725,7 +3736,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			while (flow) {
 				if (flow->type == FLOW_HANDLE_TYPE_FLOW &&
 					flow->fd->km.flow_type) {
-					int res = km_key_compare(&fd->km, &flow->fd->km);
+					int res = nthw_km_key_compare(&fd->km, &flow->fd->km);
 
 					if (res < 0) {
 						/* Flow rcp and match data is identical */
@@ -3743,7 +3754,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 				flow = flow->next;
 			}
 
-			km_attach_ndev_resource_management(&fd->km, &dev->ndev->km_res_handle);
+			nthw_km_attach_ndev_resource_management(&fd->km, &dev->ndev->km_res_handle);
 
 			if (found_flow != NULL) {
 				/* Reuse existing KM RCP */
@@ -3778,7 +3789,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 					goto error_out;
 				}
 
-				km_rcp_set(&fd->km, rcp);
+				nthw_km_rcp_set(&fd->km, rcp);
 				km_rcp_data.rcp = (uint32_t)rcp;
 			}
 		}
@@ -3832,7 +3843,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 			nthw_mod_km_rcp_flush(&dev->ndev->be, (int)km_rcp_data.rcp, 1);
 
-			km_write_data_match_entry(&fd->km, 0);
+			nthw_km_write_data_match_entry(&fd->km, 0);
 		}
 
 		/* Setup Match Set */
@@ -4298,7 +4309,7 @@ int nthw_flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 		NT_LOG(DBG, FILTER, "removing flow :%p", fh);
 
 		if (fh->fd->km.num_ftype_elem) {
-			km_clear_data_match_entry(&fh->fd->km);
+			nthw_km_clear_data_match_entry(&fh->fd->km);
 
 			const struct hw_db_inline_km_rcp_data *other_km_rcp_data =
 				nthw_db_inline_find_data(dev->ndev, dev->ndev->hw_db_handle,
-- 
2.45.0

