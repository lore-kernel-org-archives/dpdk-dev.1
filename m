Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF469CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:06:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80D8940677;
	Mon,  8 Sep 2025 13:05:22 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 548FF4065A
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:18 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021136.outbound.protection.outlook.com [52.101.70.136])
 by mx-outbound18-209.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 11:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ibuyixlwwqt75z6DdE7RWEuhUvbMy0JxR9XZr/SR7cnGC3+WaSM/pH7IfuTcdtPti/iWyxqtXtZxuiTOV9xUOpB7ncVPs8ci+zmwecAOlrTmrteipr5kwgIVYRwHw+wnmqisggbiah4C1r7LukkgtirGRb9ZwcmdknZlWL6a7lNtRfYBS1vJ9Ys43N5ZJY9bWAMZ5JAKK5T/+SgHxa27WpzMyr76VNypHPie6dWJxuMduYopicxOZZZKqzW1OCWDEYCdkVg8W81cki3+vqwxhJfaZeiuv3wsKoxOI2o9G17rn7PYFFUX148CTkoKSyopMe1l+sQP6/XvFcp6eK1t+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LUpJU6M/gnwPdMUnKD7MmYF9/2kqth9oPK4faU0wYI=;
 b=pO615KF5q5f1qgsnzikcraGCZ3yCX5bquhNNT5I5NpeB+PAQnXw2kOZabFi6xOXwjCo8QSk+52sn85rsmLYUkHevIBiO6o5RerwBiEa6a7iuUSRUnau/5W/vQkXKSm1Mwwxe23XBuZ3K7yXKuK0TrMnpCJOUE8TOVKRI9cGScr4jelWu9IRm63HXtoTcrFOUHMjcvGGSHjJ0j/e8Ghx1vnCf6c+rQijZ2SNO78ApnEA7OmcTkJS1udyrL0fuSnUXSkGKAcQtLaYUqTrYJAz/BYJ7mzN7sO1xB3FiDS8+3YrMWSc1zmHCgF7QrqfIgbuz1qh6Ex+bo3wyFnP+/FO+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LUpJU6M/gnwPdMUnKD7MmYF9/2kqth9oPK4faU0wYI=;
 b=TRJH0S9huhTMPsVALJSqcX8oFCsiA0F5RGNmiQspuPH545c62Z2mZotL3kyefOVkwq7kz8TnJ9WvhWJ0DhjS6E7JseKPYKJZdI+Z9ROlbnSSWkHCsJZyObgXN4SVPhYDKuz4JQ3P+dRcCkZnxk9Nu+OrReSu6NiRprOOUB3iAnU=
Received: from DU2PR04CA0333.eurprd04.prod.outlook.com (2603:10a6:10:2b4::25)
 by GV1P190MB2169.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:05:11 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::bd) by DU2PR04CA0333.outlook.office365.com
 (2603:10a6:10:2b4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:05:11
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 2/7] net/ntnic: migrate flm update thread to service
Date: Mon,  8 Sep 2025 13:04:40 +0200
Message-ID: <20250908110446.1071964-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908110446.1071964-1-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|GV1P190MB2169:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 577366ec-4c6d-46c4-b65e-08ddeec7945e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lHzyC0hH3xv+08qjXk+noGGenbb/JGyBbewsyO6Gpjt+AO/qWm60b1pj/bWG?=
 =?us-ascii?Q?sDbp/n3Y/KjOuAnAa4hSHF/eByVeZk/gnCcujcQROE8WzieIHqJSITKt961e?=
 =?us-ascii?Q?LtSEeO4wB4srbmIvnsqqrD0zGgF8++c7dNK1BEISb0EW2k3c9rmgPBaa9KML?=
 =?us-ascii?Q?IJ4RRO0YXA+XIkjJkAmzDbe9CoAUjQFTPDjTbsHYAO1HIS9Aw31YWkxxc2LX?=
 =?us-ascii?Q?2q/7I0x+XV2NDXaQkrMAhQBgGzkcMoVJwsXRu0MdybZZskcJMkuwaQ98+Oef?=
 =?us-ascii?Q?1vBBXwUbSWckW3mxDzgv+noQQ57FPnvRVOa2O/WT152RLuWGzJ9FzFbCww5n?=
 =?us-ascii?Q?dK+EMd2vYZ240TtMGUx1S8uT4zUcotBeWi4tugvtbS+6fAmHw6ppTTumYYzg?=
 =?us-ascii?Q?FrA6htuqMS0bBSvBXssvS2BGWrOgJPDVxbHc1NmXsK+jhApSnJeIHxPc9Nye?=
 =?us-ascii?Q?JiVdmFxGX8UuCjMcFGuLzV2p0fLS6PaCWAanYJTYHU5PGWNg3Z2TucardTYK?=
 =?us-ascii?Q?9KGhuCOpMb0Ocqdda7WPRVB9wSm92qU63PF3L7k5vEZkgSM54M6b/UpmC1S1?=
 =?us-ascii?Q?6Ucjk10sVidDV8G8yaOus+yjRTm83FWVQR07gXFknstoZ5T2AGdhgw/FwLQw?=
 =?us-ascii?Q?yl/sXTQfmz0ojGf9HIafrcyjMWBdXjhphIOGUr9a3NkuVLfFfSreYC9qs/UV?=
 =?us-ascii?Q?clgk8KkmHyCFWgw2kSXcf+kOVbpIbVjxXGA15WwRb2WuThN3xReM3tThS4vX?=
 =?us-ascii?Q?Hf5pxbgc3F1v7gMIzGzNymOg4uFV6mbS70TNRSUbXgbYzZbrdwk+wWw8/F+n?=
 =?us-ascii?Q?lTJO39qPElpZ3OB0tCu8/dT0KozGL1eORhxzgJ2i4YDURFlTAvgBtOnl72Cn?=
 =?us-ascii?Q?zlZmBALU7g6MmTOangiE7bkK3tn1A22WMGoIn3WRBxlPZy91+jkCQi5m9/MK?=
 =?us-ascii?Q?gwwl/l9Vr0yt47nmaBxY7AqlSaP0/QRvI1Mg0CrPq8UV44VobkAipFpvSLpC?=
 =?us-ascii?Q?uxf4x2DTxOVWK8PFltbJYooS1ijzhL/gpRZ2iT/yomUU6sbMoO59K7k4Ltqu?=
 =?us-ascii?Q?acW0AdvPzarmo0F2lNnd4DjkabCxADVgYUBH5AfWKO/mIPmeUayFRXsMXhom?=
 =?us-ascii?Q?dcNVV8k1qx3AMTgLrXM6goG48N4CNqq6g7gifGbRMRInNkWHGI1vB/YAdUgG?=
 =?us-ascii?Q?6Nj3y7mYdjN2Jcr0My34t3i/ooTGdxJjTUMQxH8YZQUapslToHahlwls3vQJ?=
 =?us-ascii?Q?fSIxLh0wDvl9OCPZ+hlOf9w4AosxbqRbz5Chc3PdSX+w6rGcMbb5ptaVN4CQ?=
 =?us-ascii?Q?Syow33bpSi3xU/7dCv+239PZxddSXHBAGLz2CCcZD2ioQmdnPpqayJsjkJv4?=
 =?us-ascii?Q?+/9OiwC5R0zgewQ6TvBmE0nR0X6388PNGFjZfFEQPWvMHgqJfEf5uOZSk63D?=
 =?us-ascii?Q?1dnVLGHWOxToQ663F+ILnZX5ynAnDcNOfMw7tXlUJrkYbX6PrB/QESFseyxM?=
 =?us-ascii?Q?wgPkBn0PPK2Rk+e3REdmKEyo+MuOv/RAXK0T?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qfJMVej7ZXSNmlbMak/GfW0ldJZ+0Wt0/8NE2M+TOJTU15t4DW36qjjj9Kiy/c3z/2RcItMVp4rY+YyyxGgwUSGynfrZgrCT6wzTveAbH+au6+coyF6fJF31R6XhT7QjDpMmYqSFAUeZovhDWrUk2aIHtkCMzMU2QototfzXQ6Gc7FStQ2PjG3mrV2MoqIxSJ+//nqa5Iazve0h/2q7ka1AVyAUauyl/vr2E8gok8rs7Y22gCtzYJG3Van0ZfRf2y5OeVJHCFusCNOnojKJPHHdlg9vMyT4A96cBTSYf2BC3mnZJQuy+MbRxAxF6/PoYTwQpF2otAUmxkBE7EkMPahy5Q8xXX7vNWh++clGB856bQ1oYKtOha1iGnEWgRui+zcOPVia4y+A9hzxgfehwq4PyCaTEJZvCCbXjASHzAhK9FZ0zMhLGXV+3Ylqbd/6AvUm7YLdtSsImXmkarHgkci3w8I7aLbaK3QjCmbBVsS/IM4+ZOp+Nu/HTI6rnYzYyzJokbCykYe2kHRrUAFEM4Jyas5l/fgyjWgLEWgh8xWwFUngU7p62j6emeHpwuezrcLQ421bPEYdGHrCqzrpMceRUycly+nz2XF0btsd0BWmQzKGy7YTxFVaNj2TvMr7k+4gH9VrPKr2gJmQQ7F93wg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:11.0176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577366ec-4c6d-46c4-b65e-08ddeec7945e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB2169
X-BESS-ID: 1757329517-304817-7669-3951-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.136
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmxkZAVgZQMCXVwjLZwsIoyc
 jEwsDMLNHSwCgtLSklydLQPC3J3DhNqTYWABDd39xBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267333 [from 
 cloudscan15-122.eu-central-1a.ess.aws.cudaops.com]
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

This commit adds the FLM update service to the NTNIC PMD.
The service is responsible for handling creating/destroying flows.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/ntdrv_4ga.h         |  1 -
 drivers/net/ntnic/ntnic_ethdev.c              | 67 ++++++++++++-------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 17 +++++
 drivers/net/ntnic/ntutil/nt_service.c         |  4 +-
 drivers/net/ntnic/rte_pmd_ntnic.h             |  3 +-
 5 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ntnic/include/ntdrv_4ga.h b/drivers/net/ntnic/include/ntdrv_4ga.h
index 78cf10368a..35afcd546c 100644
--- a/drivers/net/ntnic/include/ntdrv_4ga.h
+++ b/drivers/net/ntnic/include/ntdrv_4ga.h
@@ -15,7 +15,6 @@ typedef struct ntdrv_4ga_s {
 	char *p_drv_name;
 
 	volatile bool b_shutdown;
-	rte_thread_t flm_thread;
 	rte_spinlock_t stat_lck;
 	rte_thread_t stat_thread;
 	rte_thread_t port_event_thread;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 79ef9e7e7c..c114017db8 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -31,6 +31,7 @@
 #include "profile_inline/flm_age_queue.h"
 #include "profile_inline/flm_evt_queue.h"
 #include "rte_pmd_ntnic.h"
+#include "nt_service.h"
 
 const rte_thread_attr_t thread_attr = { .priority = RTE_THREAD_PRIORITY_NORMAL };
 #define THREAD_CREATE(a, b, c) rte_thread_create(a, &thread_attr, b, c)
@@ -1546,7 +1547,7 @@ drv_deinit(struct drv_s *p_drv)
 	THREAD_JOIN(p_nt_drv->stat_thread);
 
 	if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
-		THREAD_JOIN(p_nt_drv->flm_thread);
+		nthw_service_del(RTE_NTNIC_SERVICE_FLM_UPDATE);
 		profile_inline_ops->flm_free_queues();
 		THREAD_JOIN(p_nt_drv->port_event_thread);
 		/* Free all local flm event queues */
@@ -1980,40 +1981,46 @@ THREAD_FUNC port_event_thread_fn(void *context)
 }
 
 /*
- * Adapter flm stat thread
+ * Adapter flm update service
  */
-THREAD_FUNC adapter_flm_update_thread_fn(void *context)
+static int adapter_flm_update_service(void *context)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	static struct flow_eth_dev *dev;
+	static const struct profile_inline_ops *profile_inline_ops;
 
-	if (profile_inline_ops == NULL) {
-		NT_LOG(ERR, NTNIC, "%s: profile_inline module uninitialized", __func__);
-		return THREAD_RETURN;
-	}
+	struct nt_service *flm_update_srv = nthw_service_get_info(RTE_NTNIC_SERVICE_FLM_UPDATE);
+	RTE_ASSERT(flm_update_srv != NULL);
 
-	struct drv_s *p_drv = context;
+	if (!NT_SERVICE_GET_STATE(flm_update_srv)) {
+		struct drv_s *p_drv = context;
+		RTE_ASSERT(p_drv != NULL);
 
-	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
-	struct adapter_info_s *p_adapter_info = &p_nt_drv->adapter_info;
-	struct nt4ga_filter_s *p_nt4ga_filter = &p_adapter_info->nt4ga_filter;
-	struct flow_nic_dev *p_flow_nic_dev = p_nt4ga_filter->mp_flow_device;
+		struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
+		struct adapter_info_s *p_adapter_info = &p_nt_drv->adapter_info;
+		struct nt4ga_filter_s *p_nt4ga_filter = &p_adapter_info->nt4ga_filter;
+		struct flow_nic_dev *p_flow_nic_dev = p_nt4ga_filter->mp_flow_device;
 
-	NT_LOG(DBG, NTNIC, "%s: %s: waiting for port configuration",
-		p_adapter_info->mp_adapter_id_str, __func__);
+		NT_LOG(DBG, NTNIC, "%s: %s: waiting for port configuration",
+			p_adapter_info->mp_adapter_id_str, __func__);
 
-	while (p_flow_nic_dev->eth_base == NULL)
-		nt_os_wait_usec(1 * 1000 * 1000);
+		if (p_flow_nic_dev->eth_base == NULL)
+			return -1;
 
-	struct flow_eth_dev *dev = p_flow_nic_dev->eth_base;
+		dev = p_flow_nic_dev->eth_base;
 
-	NT_LOG(DBG, NTNIC, "%s: %s: begin", p_adapter_info->mp_adapter_id_str, __func__);
+		profile_inline_ops = get_profile_inline_ops();
+		RTE_ASSERT(profile_inline_ops != NULL);
 
-	while (!p_drv->ntdrv.b_shutdown)
-		if (profile_inline_ops->flm_update(dev) == 0)
-			nt_os_wait_usec(10);
+		NT_LOG(INF, NTNIC, "flm update service started on lcore %i",  rte_lcore_id());
+		flm_update_srv->lcore = rte_lcore_id();
+		NT_SERVICE_SET_STATE(flm_update_srv, true);
+		return 0;
+	}
 
-	NT_LOG(DBG, NTNIC, "%s: %s: end", p_adapter_info->mp_adapter_id_str, __func__);
-	return THREAD_RETURN;
+	if (profile_inline_ops->flm_update(dev) == 0)
+		nt_os_wait_usec(10);
+
+	return 0;
 }
 
 /*
@@ -2346,8 +2353,16 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 
 	if (profile_inline_ops != NULL && fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
 		profile_inline_ops->flm_setup_queues();
-		res = THREAD_CTRL_CREATE(&p_nt_drv->flm_thread, "ntnic-nt_flm_update_thr",
-			adapter_flm_update_thread_fn, (void *)p_drv);
+
+		struct rte_service_spec flm_update_spec = {
+			.name = "ntnic-flm_update_service",
+			.callback = adapter_flm_update_service,
+			.socket_id = SOCKET_ID_ANY,
+			.capabilities = RTE_SERVICE_CAP_MT_SAFE,
+			.callback_userdata = p_drv
+		};
+
+		res = nthw_service_add(&flm_update_spec, RTE_NTNIC_SERVICE_FLM_UPDATE);
 
 		if (res) {
 			NT_LOG_DBGX(ERR, NTNIC, "%s: error=%d",
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index fc06cf12c3..c6c448312f 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -6,6 +6,7 @@
 #include <rte_flow_driver.h>
 #include <rte_pci.h>
 #include <rte_version.h>
+#include <rte_pmd_ntnic.h>
 
 #include "ntlog.h"
 #include "nt_util.h"
@@ -13,6 +14,8 @@
 #include "ntnic_mod_reg.h"
 #include "ntos_system.h"
 #include "ntos_drv.h"
+#include "nt_service.h"
+#include "rte_service.h"
 
 #define MAX_RTE_FLOWS 8192
 
@@ -543,6 +546,13 @@ eth_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *flow, struct rte_
 		return -1;
 	}
 
+	struct nt_service *srv = nthw_service_get_info(RTE_NTNIC_SERVICE_FLM_UPDATE);
+
+	if (!srv || !NT_SERVICE_GET_STATE(srv) || !rte_service_runstate_get(srv->id))	{
+		NT_LOG(ERR, FILTER, "flm update service is not started. Flow cannot be destroyed");
+		return -1;
+	}
+
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
 	error->type = RTE_FLOW_ERROR_TYPE_NONE;
@@ -580,6 +590,13 @@ static struct rte_flow *eth_flow_create(struct rte_eth_dev *eth_dev,
 		return NULL;
 	}
 
+	struct nt_service *srv = nthw_service_get_info(RTE_NTNIC_SERVICE_FLM_UPDATE);
+
+	if (!srv || !NT_SERVICE_GET_STATE(srv) || !rte_service_runstate_get(srv->id))	{
+		NT_LOG(ERR, FILTER, "flm update service is not started. Flow cannot be created");
+		return NULL;
+	}
+
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
 	struct fpga_info_s *fpga_info = &internals->p_drv->ntdrv.adapter_info.fpga_info;
diff --git a/drivers/net/ntnic/ntutil/nt_service.c b/drivers/net/ntnic/ntutil/nt_service.c
index 4ef1233f12..86f709e401 100644
--- a/drivers/net/ntnic/ntutil/nt_service.c
+++ b/drivers/net/ntnic/ntutil/nt_service.c
@@ -12,8 +12,8 @@
 #define NT_SERVICE_UNKNOWN_ID (-1)
 
 static struct nt_service g_nt_services[RTE_NTNIC_SERVICE_MAX] = {
-	[0] = {
-		.tag = RTE_NTNIC_SERVICE_MAX,
+	[RTE_NTNIC_SERVICE_FLM_UPDATE] = {
+		.tag = RTE_NTNIC_SERVICE_FLM_UPDATE,
 		.id = NT_SERVICE_UNKNOWN_ID,
 		.lcore = RTE_MAX_LCORE,
 		.initialized = false,
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.h b/drivers/net/ntnic/rte_pmd_ntnic.h
index 7a491319fa..d6236dae32 100644
--- a/drivers/net/ntnic/rte_pmd_ntnic.h
+++ b/drivers/net/ntnic/rte_pmd_ntnic.h
@@ -41,7 +41,8 @@ enum rte_ntnic_event_type {
 };
 
 enum rte_ntnic_service_tag {
-	RTE_NTNIC_SERVICE_MAX = 1
+	RTE_NTNIC_SERVICE_FLM_UPDATE = 0,
+	RTE_NTNIC_SERVICE_MAX
 };
 
 /**
-- 
2.45.0

