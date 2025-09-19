Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CAECAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E61640B9D;
	Fri, 19 Sep 2025 11:20:31 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 72622409FA
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:24 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023088.outbound.protection.outlook.com
 [52.101.83.88]) by mx-outbound16-38.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2GQFUa9VDrm5Idgo+esxGmTZaaKwrfIuQt+xIaIhR6OIKPsbYyYf2u/nrwYGQ4bpG6zFTD4JiReYtlB7hr9rCgiex7VGz9mRuxeAsFyBnDNx02QzjZdBN6vdBSH/qD8be3iKSg/w5R/At9l4JLMzmU/OBWhPgJnWvFUes8wWu8RH9gsQaJL+FRhz9ScHlAVytIa6SHsBYv+ogs/JJp2tPFZVGrfLWIWv6w9SS2WgtNTe9vziHz42Yq7nmoBuOOD0Qqy8mYGdkTB1cH2Wlehi9GCUTMOdaD7dw+VkRL5aRHODb85o0TlnVwor/UaK/oYRjVUpjNc8RTXPLLFUi6F2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn418dZt87Mct0rllbuDsHiQGybUiNecxLfxzPTuAiw=;
 b=R4sFJl84W2fIzzJf+jso3twiRAboak7HyrDb2Lz//8LJKPiDRP88tOajxami0ZZePOTUw57ajmNtwQ6KB6a56o669GsEJZdTbOYipZQ3nwdJkEf9KrSzwC0F1W9ukWyvdMN+mYPKLtiQJadUFZHI7UWstPzZgIOXDk00Jie3gJHHDqrMAVI7+RgmNhyjvlI8esuSDZSgo87kZt1v+W9OD5NgtgAMQ4w9I1EjZx44vlP90IslX/51GQa+DcZoGVHp33puCNYEk/zUywDDz5fayqMLIH9Z+trBCrdrB/VEhQRTiHM/cj1tIfcdbxljsROQQVqBDvFo/EQLSTQYpmzzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn418dZt87Mct0rllbuDsHiQGybUiNecxLfxzPTuAiw=;
 b=GvBGkLegMDCXZuHkEy59DQIxEKtUkTqMJ/xADaCvLsH1Gmjd15KcF0odvidYtv1gAdFUYPrXmMwK+mKSo/kdy2heBfj0tRUDf+g1mATQH4cFPsCY/CVQfy2KGZvqQOx3Y5nXZM2+WrTZ66jIlRRM+pET5LX+vHTMFzjAX41dPrA=
Received: from DU2PR04CA0340.eurprd04.prod.outlook.com (2603:10a6:10:2b4::12)
 by VI1P190MB0798.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:122::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 09:20:19 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::44) by DU2PR04CA0340.outlook.office365.com
 (2603:10a6:10:2b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 09:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:19 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 09/16] net/ntnic: change prefix km_ to prefix nthw_km_
Date: Fri, 19 Sep 2025 11:14:54 +0200
Message-ID: <20250919091504.1548351-10-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|VI1P190MB0798:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ccd3799-cebb-436b-5da5-08ddf75dc0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lk3PU0CTxvrK1GJIoCTTWzasAS4jffsITuMuoe5+e+URNtAhK2s/x+uVK8cP?=
 =?us-ascii?Q?OYKnFNsrb4K5sLiZHqf9wgfSFj1W0Emvos5a2g7zzAltMKAkB7/u4FGnjbeq?=
 =?us-ascii?Q?Qr8fMBqIGMJj3OcUWy2f88aO4OMVCNWXvSJ1ifrsgBG/hmACshpp6jjzDTc+?=
 =?us-ascii?Q?p+6yBeOQ3aIdUIwQERvPms9Cf8H0pefE4+XoKX1LXl0kkGTd97wKPXGqno35?=
 =?us-ascii?Q?i75XQ3jCpUkWbdWzAoYw2KlQNObSkE7xSfp7SJG3ttvevfiuF7vJxK6Y8xLl?=
 =?us-ascii?Q?8hR0UITVTfRcN+2Smpy9R0ol2iam4nbDTkeKTOdObJpt7nkVkD6xdHQLfaw1?=
 =?us-ascii?Q?gkqkHX0bY+ioBXQGnLQO5aMoUlMOHvFl9xbxkK7g18kOHkxxwweFq1zljDhl?=
 =?us-ascii?Q?8rKE8y+MZ/mn7ZPB7Oja2Yqm10FiFODMPDjskZ12/ylLOwP2xXDW2etP2zJk?=
 =?us-ascii?Q?e3XbkF7s4ahpTvEhYFM4kPDK0Htd+IOOu4OtjApoFudOwvqz00UpqPGD7cFL?=
 =?us-ascii?Q?pimAn1IYuDRX+/hjHwZbo0pmlyCAx0EMPfKqqBkgD02Ho/1wJOw2qmWDvvq+?=
 =?us-ascii?Q?fou2tZCaqKr0xODb0+NZOn8mW7qVMgWacC9pyvz6PK0PQP9VsjTCrPct20wQ?=
 =?us-ascii?Q?7cFhhse6f/WGret9BGvYHQsD8VDdzXbPMH1ZqD8K7xgt/3ASM8e3FNC+QP9I?=
 =?us-ascii?Q?xRSqjlZqf7o14JKYmKe+hdBSh6JcUNB0fCUcC6NgA0urvscjQq27cLWlP4KN?=
 =?us-ascii?Q?1wVSRfLDKDX5ktXeWTWNjiKSPMjDx85kvYX7jEOQJAHaKT5WvzjPdm3zeOUB?=
 =?us-ascii?Q?DgA+TZbsJCS+Bxxky21u7JUAR6ZFGJ2Ut4rchRqhLNYHUTPL7ptxpdGb9u7F?=
 =?us-ascii?Q?ruiSfp/cNjrdbsat+aooL3AvJo8dk6dxu1lx3RJeK7y6WBnQuUb7cecQBc00?=
 =?us-ascii?Q?sb+gIS+5tpO6oeP0Ze44oFpgZ8TRkvR4VahfqxaTXeMQPQh9g3jsM0w6HOa5?=
 =?us-ascii?Q?LkpyZpN4Dfk5C5U6fIotUMdnW5nZIEXr0KBY0AbWj468m6HuC7CEQZ5YYupE?=
 =?us-ascii?Q?ZfFAAys5Se9gkVROclxCYvxCYt/nIhq7dRNmE5OTU9i/H5991NBlBD3hErsT?=
 =?us-ascii?Q?VWqQmLLd7RfOsAJmNKYUEed42PKg1WLq/Nai0c3XWKqo7jy+kBCxB3qdAsmP?=
 =?us-ascii?Q?aghjfO2EDl8p/t458tmf/DzbvBQBf/LRbnx4HEhDtelj3c/lYNiEj+40qgUl?=
 =?us-ascii?Q?QtWcwv+vS8s0peKPuuZJqYnLLsjI+W6C1E7e8XwB8mo/Jr1fF9nHvxBW+wTF?=
 =?us-ascii?Q?isVIrIBtLOdnf4UBXzsFAPQBsqWB9y1P8h6RmVXJtg7jkGLwkkSuFx87vMo1?=
 =?us-ascii?Q?U5sFiVfU8aPgkD+YBSJrBeYZS4+ZG25VVe3lLF5uOCgsxmQcI+ZJXuRjTbEu?=
 =?us-ascii?Q?PMcWnmyonM3vB41bF830eTYwC6CxWAWkWsHINKe+jTnTeG12MoHQnnu/BWDa?=
 =?us-ascii?Q?dzS8kMU6p3VJcPG0hO2QQSmDU18J7xhEYvU5?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QudKhdv52JtaHoOKAllVEled9V24cgimYjDOi3PQ+oQO2Kb1qGiFFFMxEDw29YCqXg0P4Nb6PFyZy/xa5SLnNDN9z2hHqyskFqdaOU8lwmtEaLQA0reMTgIphCFCnUa9wkrLXlQCsDv89++XipQbKGqz0vCWdpqHfozAd1tqPjw83227fsg6r9i3tA52rg+wZtQYbFWLqrOZzt3RpZ2nH73RoGyCBOQXbK2poPb4YfW9WgJJiu7idQq84d9yvFKniCTjLHyPsJsJYx+lHO/uexYvegG/6AztJxykaSXdWjX2hpwzJe9Qr1F7Rl1Y+ZDJw5Qz5iYJWhRa5cI51Znid5T0Pzitpb1LXN1F5s79Yfw/shcGz3jybDDRoYB+QTkbTK4Ks3qWzFpfnj7SgOHh1oisbynvqsCl2PtOkYLOoigqO8JN2yu6FhG8+TsxX7any0CQ80p6EsN0fGjOVCx15zy6ZP0nxksikrEh4fKM1NuO2mnn3upWN5QAJFjJ8iI4anA64RJjr7qJLwL6wVMEY1S6ZTSGmuGekd83edG6f7eCuT3iBLU/KPweQbRnn/78kv1p0WglB3rPmWQh8YDym5jFNMvQP4juI6HVcK06j+mC7xH9r3uQTqdtJsT/0VmtCgMogRi14eFqVfoB3fbhLQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:19.1059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccd3799-cebb-436b-5da5-08ddf75dc0a6
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0798
X-BESS-ID: 1758273622-304134-7640-1097-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.83.88
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGliamQGYGUNTcMNXQ0DDZKN
 U8LdnUwCg1yTIlLSXJINHAINXU1MTIXKk2FgBEKZrfQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan19-240.eu-central-1b.ess.aws.cudaops.com]
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

