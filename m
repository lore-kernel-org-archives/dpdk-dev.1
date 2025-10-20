Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C4CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:38:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 443B840E40;
	Mon, 20 Oct 2025 18:36:52 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id C9C7440A7F
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:42 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023085.outbound.protection.outlook.com
 [52.101.83.85]) by mx-outbound9-130.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck4Ktf2VIuyEC+DdI2GvSPO5Pxpcwu1czs95QnOscRhRkA87QCYbwCJzXmbeathEuIrzZZUnB3oEJJnHqF/dvvOC2LceeURetJxcnrtz8wPEpZ/k1H0r0bLfNkZ4eh64iUmqy4jY93URyB1msy+ThPYUeAyFsm7XP6zytFqqmOHXSQUTCHWCKtqnfokoN0cK99k8DOUWQvUPYnYVZ0ZplCFlFPSU0QBcdEqY5Mg4F9Bgkpv2/e8ONLXk2ErpCW6jGKOKp6Hs2JEj3dISoLE3ia4fzpQzhnh7/usqtLa4D1wNo0WHV8wvbUiKAH+YO5ivAe8iNwozKRDjiI7dFSb6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn418dZt87Mct0rllbuDsHiQGybUiNecxLfxzPTuAiw=;
 b=fAAmiDasFaiw+HIaV9EnuA1GKbdDaW88D5on4lVOA3oRym7uic/9U/w7ZzKxQz3/HSvxBbJWnd4JQsHW036VYYTLUBrO0TkUAFMvEhoTHNIDXQu43nnLRw0nnq1x5yB7YxVwHIsEkAoxwpoMESyhr5E4tmXBCsBdliltprJXDLBI7LbNYKSA5AYvJPIOhvMsqce/BIzM2GkeX9q3pgc3vJWH3GfHsefIcS/NZbWaSvcgjE/uId+9qlKWAtDYeJRSvaqJuUhdfDTD2KzJUpcJgZS5+i8EbifhmAEzMQf0XqG0tTuT50nUPcfMJ63vWX8qLuRLhX3u+rAToAFiHxbQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn418dZt87Mct0rllbuDsHiQGybUiNecxLfxzPTuAiw=;
 b=Aa+2/auAIKfG8YMzHT147KGCRFV428YWAXeSJWlXkF3TKM34wWnPaTEQWJuCMu9c2CmDmsnbO8SHy28idqxSvcgqJFHE1JGdUFErKlN12LsMulOiectAlFNNS6LayxLKcXM+qh0qEIRhTGL+9SyX5DOtrOketQIi+aTfcpFXaBQ=
Received: from AS4P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::20)
 by DBAP190MB0888.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Mon, 20 Oct
 2025 16:36:39 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::d0) by AS4P191CA0028.outlook.office365.com
 (2603:10a6:20b:5d9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:39
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 17/24] net/ntnic: change prefix km to prefix nthw
Date: Mon, 20 Oct 2025 18:36:08 +0200
Message-ID: <20251020163620.282312-18-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DBAP190MB0888:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc08996e-1caa-4a08-04fa-08de0ff6d7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J/f0FNulocMDZpQpHAKFqLrPhR/5/wj2fQRBpqKvEoLQKtYUxgrEWAX2UAgX?=
 =?us-ascii?Q?e8wprCfeo9cynvwRUT0j7TB3vYqj21j8fZELQ+bLbsaC+yYTpLPChLOF0WGO?=
 =?us-ascii?Q?kfwkGzrDpRTYSy74DNMdufXfIrZIUmMOxAeH+sXNS67s1+sdi0ToI7lRrP2R?=
 =?us-ascii?Q?Jhea/PTZ/SHit9I4oN05rGbvQ/jrV9yOtQO5HE37jqhH2TCX3hF0KtsTlsat?=
 =?us-ascii?Q?TCdFBGNMP853VrnEJG0G6Q+j8/Ya/n/frZdImMuIR0P3u9JAaJKqfVhW3lbZ?=
 =?us-ascii?Q?/gG0B2X+psREkvnfRm1lAFhS215THylUFEpKaThhROIU6hbd1zOFGEayfuTK?=
 =?us-ascii?Q?QmdXrkmTbmUtj1UMc1j9+qRhYGj/jAyoPH4rMoargckH6m6tOQUTYRbkt2e2?=
 =?us-ascii?Q?MY9HhY6oJaJpuxZxly+W0k2Ssu/oMLlTfOdTD13j7eqDum4ouz+Y/eJ14y1P?=
 =?us-ascii?Q?9LC4YnUCd2oCNBZo1nm2GBlO2EinC5CozSOti4Hmn2QOoMPaYYr/hC83/D31?=
 =?us-ascii?Q?nARkOCo9Kt6OXOdXdzQSCp/IyWxM9oey+yAcp8+yy0EMDAHEBw+SeI7r1GCY?=
 =?us-ascii?Q?amWjhuxeBSfiYDGtgYpOiYVVndpqIjbDAbNoFwPU4lfg4FaawoRQELVwQe+V?=
 =?us-ascii?Q?tzjQkjw6RySsvUiC9iWB9Yw91V3wlpeTL1kBvAfqBrLP4WcXthYfY1RTzK2/?=
 =?us-ascii?Q?HA2iGIMAaeHZgdDnYZ8FggO5267ZaVO4FzGu9JcV+tc8lO7wPO2IepnCP8xu?=
 =?us-ascii?Q?+bMYGD5IVDRDsn7uPa8DpreJppi28lT573f2Js3ZSdP/iRBx61fMeznur78D?=
 =?us-ascii?Q?xiuTyiMYJza1lLhkUcwPPMPA8JkTa8qETAk5jDS67y+wZ3T0g6Qezt854N6v?=
 =?us-ascii?Q?0zZqa1iaAYbE8PuRuuywuDsTXbFDABPRILGcbSntgBFi9E79NR78OssaiKTd?=
 =?us-ascii?Q?DDzuO52uFRI1P79Vu0K/flR+v3U7G9TbU5rpYoPJ8eXm6ULOgih5sFR229Rs?=
 =?us-ascii?Q?FQTxjlO7+mqxZk+Llfv/sA/mQx2cZjFxx//+JCzsQkGQfOOQ0vD7KcE/4NgX?=
 =?us-ascii?Q?NInxOcuFUpdJaxIVnYC+uCw/2E7f2iYay1Zmx0Q9WwpsMynaGpb+46XFVx8S?=
 =?us-ascii?Q?qW3UAj3lgcCRL+gMfGmij+9VldSBfrO6e6EqNpX6G4kjsSahFVbI/4dfLfQd?=
 =?us-ascii?Q?CYXU76bhGU6d4ZTJB/TsjjKfPEKVWu4wYeUK6ZeviIeen2NIFz9r5tixxLF9?=
 =?us-ascii?Q?Q3iQhiI/b2/PH95b1aUUy4Uv27W4Lh3MZ0+c29bvvy5cV0h8Os/a/p23r0Yk?=
 =?us-ascii?Q?pnXMkrQtril6b0+sMg8ceBjHAeMKqhbnbhjLdPxLAwagphYwmLw8jJAH9TyL?=
 =?us-ascii?Q?UOpuPsgsTHMV05O58i/fyemlKPneYpI2xDzV1l5MNzTzAC9aO4fd6IRHpM2a?=
 =?us-ascii?Q?NXP6tUiWAVKhSgO49nKT3tMP0fn/IUVmvLsTaJjMXVaGpQgB/6ycBNOwIodZ?=
 =?us-ascii?Q?YrgkJ6t2+51koZXX6JXNhCR3HIMAvOGHpGiOr8It5mJ2Cm1O9pYhgniCRkCG?=
 =?us-ascii?Q?2UcAVyjvILLp2AR25k0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4kUkPGVB1cir3XgVALyca+OAqMT9lRtBPb5jnNuz+S5BkJ+HNgqXgH56e5xJJ1kcg0z5rxytXOAHsooCsD/W5yJU0VXxnwUxxX3qnqXKgwEaaAP/0KV/l6xr/EFOnqH1h1tJ/IfpBGZMPIC6OC0FCIB24D1G87qgNFoR62yBnLRr7ST+yjE60rs+CgLhtIIbZPteC5ZRppKVbyl0gJEulC76x9bManYoCLcNpANwYjiXC7jOWJtjauqtXpATf+W2ZwQY1SbKRysKz/Zv/fXkOE8wVTjP885CiPNEtCvJhWCyTXhGvYW7ZqdsBv1cyPjrgEzCWhcU5f+nZ2DxbHEE0qgotn+P3kv0ljgl+ZTrp1Q3X9BKwjWGpkB9J//bhp1CCyGuaq3CsN65dHoAPKzcsKhmKaVZBYoI9k8wWsMKx2msAUFT3JBTmkneT1G4+YoWCce8YyEtzVnUeLKWrOC3h4h6WYbdJMh/EE8kFEyFWfezbFaxGrt4bUOTL8z8JHch8q6566N8xqrcc/FHQM4g0uz/dZOudbAVH3e/vJKfGFL1hqfgJIrXgf3T3G/l7arx3eCDZ3QURRysrNO5cwUlC1amSPfEzjQRnssoaJCQTXEWVYlxvBTVUBwHt67XEpZfW4OpaA7LXJmO9RdJAs+nyGPFk12kWD0yp4BL+Pql9Sc=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:39.0424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc08996e-1caa-4a08-04fa-08de0ff6d7e4
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0888
X-BESS-ID: 1760978200-302434-10215-72807-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.83.85
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGliamQGYGUNTcMNXQ0DDZKN
 U8LdnUwCg1yTIlLSXJINHAINXU1MTIXKk2FgBEKZrfQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-122.eu-central-1b.ess.aws.cudaops.com]
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

