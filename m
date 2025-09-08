Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A34CAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 14:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2CFD4067A;
	Mon,  8 Sep 2025 16:17:58 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 75BAD402E5
 for <dev@dpdk.org>; Mon,  8 Sep 2025 16:17:53 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021086.outbound.protection.outlook.com [52.101.70.86])
 by mx-outbound18-253.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 14:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU953MQ0Vbc5uTjQzr7grvbRLUAs5UnEeXWyptu+TkKBx84ubIhRr/7cT18xWqv9sR/UNHv7Ew94JbPTPQn38pMOfYVJhfuQLQ89qqh/Fs6pzupzQMc75UGlgHnzNoEu8GcEKeuLIlDgm9jQMa4ylkGreGi+3pxot0/SBOHHPTrwqeLkG1xnsH4yapyYEsNoB3xkRll+vlLFzd/Az4nuCNJW4RXTu6IVKfyU8ZbxQ+uZT9Hk5pQTkabl12yYZjyfs90/uPnWoCWSEM/RqVY8sLCMx0mNov+zf5YC3NBn2cgm3TkQariQTkKCq7JNoVp2qh2l+57mI2UEoVHsEVkd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LUpJU6M/gnwPdMUnKD7MmYF9/2kqth9oPK4faU0wYI=;
 b=icfMG6rTdqtRr+cQMEonJQ8LbFz3fZSl/k1fQa9nlIT+A4ok6JI7IdDqo7VKwHHjC9e6ktDSYYJ8znPLP7ayxevQVXfipCioUUmbFrh04QqM9TOPwk3FwgUqhzhX+UyQW0HM7/kseJkPfYP4GP1EsC309gKSeyuggiocx300bKjCeCYDDl0N2D9tUtdlG4s41xBtXiFWwZUy5REzDMVdo1ON8oDToMzB+1ewkZSyOyMf2/2JO7pucpmAtkRyQ5232ClfWL8Pt6gL9GLW/m7Fb4s/ZQ9/lfhUmRG1LwiPcOmuJZlgKef+mbJSxJuMzlEzZT8I+RsRvylmn/ZRw2c3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LUpJU6M/gnwPdMUnKD7MmYF9/2kqth9oPK4faU0wYI=;
 b=D+rC6DqPslB6nEVugLslH4VfO+vmXL0yPptO/v9lipaHrdbu6mImg1WwuMezjbXt1h5BHfQ8uTDnnG1AB/xdK7mIpliuhz9clGXl6f9wDRGMgKm007ebGt3XNoBLN6JeEDd6DmZNfqDsvmpmByp3s9IGlPgaCeDXDiyZ6+j1ti0=
Received: from AS8PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:20b:311::18)
 by PA2P190MB2130.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:418::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:17:48 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::7b) by AS8PR05CA0013.outlook.office365.com
 (2603:10a6:20b:311::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 14:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 14:17:48
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 2/7] net/ntnic: migrate flm update thread to service
Date: Mon,  8 Sep 2025 16:17:34 +0200
Message-ID: <20250908141740.1312268-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908141740.1312268-1-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|PA2P190MB2130:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b89ba6a-da5d-4727-0d58-08ddeee27d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EiP9V3DWcHavqzqhm6qdkymIXHvShXMncLCw1Lbv4ZVVNqe3JCHMA+jWM/cX?=
 =?us-ascii?Q?YClnfB/JOmREx/7lb+tU6gr3NbB/G13JzVAD2ZzI1zUWdU1XOJlL6wHqY7JP?=
 =?us-ascii?Q?kWPWZPP4qBMBoiTpAyx/PTDzjcjr6q6xSJyjvG0ynsKHq5RyoD7eXdkl0xa9?=
 =?us-ascii?Q?8mWHofN08PF8QUyvjjKnXAK1A4tAMw85m2NSeuDNLjWMZJ2rGVp71NK6nSf1?=
 =?us-ascii?Q?nx+mCuBgjOlmL/KRgDsrgOIe4v8472ER0UVNl56eSiOVHdncG9kuJkEKDWVl?=
 =?us-ascii?Q?CVA6sTUaASlsD2CrumxWD6PtAweDDIoMkAlISb7oK6HvG/1+GPGCZbyvo5W9?=
 =?us-ascii?Q?U69eANWjRRySPMsbEKmn7SK1Mtc/hZCDKevRQU6h76YJ1HglXCkAiFITO1TV?=
 =?us-ascii?Q?nv3lNdjJJXy3UKO0m8DDLC5u62q8HzX2Oi31eXEqpPmhq3ryi14YpWP1bewu?=
 =?us-ascii?Q?KTtT3HF/2eW+CKuzesu9BGnoc8asoLCZJst9TPCMGEp09u67r2cfM+Mu8j+v?=
 =?us-ascii?Q?BbmUHTpZzxl/Tgffgjep6RjAyeqpIkzDpUQTARE+spW8Jiv+QptLsqYASk1y?=
 =?us-ascii?Q?uqeUgCLtfzvqk74MPk+0q3goWBeNyCrz8I6cgOcqA4uNcVRlwjGgQ6ZDqubr?=
 =?us-ascii?Q?gUlQNnrYPzlP2xypjobfbAzKysQrTjWk4FJDvKZiym9prmT0azBbH1wVbfSD?=
 =?us-ascii?Q?YReWBb/92grg4s2On/2iHPGoKUXg0TwG+1aFGTdXLOt/QrR/yrbf5tA+RQs/?=
 =?us-ascii?Q?ZwMc1LCvJnsXoYnhZ3WTFuZrkfUgwJjp3JYUkQISCrRIfMJCB5JbV/NI1wW/?=
 =?us-ascii?Q?/PDYVx4YBVSthcDSZk9F9GJFUA9mIv7r9bh8TNHjoC4kFSTcZ4icEkZCqIEP?=
 =?us-ascii?Q?d3EuuCq8UWslUXrjQnyusjStroe8JWlDT1IxuAkF9qJdpOdS4fz/IYoF1KYm?=
 =?us-ascii?Q?OhGqz7AKt32V5sDsCVAj5rDoJ5nB445t7xjXFMlbQE2Es/TP4ekPqDY3lpoG?=
 =?us-ascii?Q?6EapvC95Fr+n+7A2+E8pr5fn4OJ+U04xjGL1c6E8cOSNQHx9lKer0Mpdr8vB?=
 =?us-ascii?Q?us0Ca+spFfDBKmpJxZVWE05bc3IDpuDrXiE0k/ECrrV34lzARDv8bh6jXhpB?=
 =?us-ascii?Q?uS0fIFQ8bijil6xMMZTqmdFi7BXSHH2BRMxu7/PTkUbyGctb+JoGU9IsPp7j?=
 =?us-ascii?Q?cj81TnV2MS5wt8deq2t5HM+P+wfXyKwcczrQwJtUI5aCft+hyoW0v1yNfjG6?=
 =?us-ascii?Q?VhDZxUXHoI7TAaxbp/a+xo7koq+xlRQufhB6jJ1naQqDJnHGTXoQzvmvG01c?=
 =?us-ascii?Q?u+5Rbz/rtOXY3vUmEzuNGTDykqLfgxvvA3kN63OsStTjMxmecUev3spKOUye?=
 =?us-ascii?Q?MyhrlBU/roegjP5hxajF+3A83plgoMqW2WWNTezJG8PIEPyYRH5Ev44Eh1rm?=
 =?us-ascii?Q?T80oT3NSjcTsrVNpvcit0jqHKQIWIoQTJLUva7ddeJtDa/nFL41I/To+/4T5?=
 =?us-ascii?Q?GHbfrJdJqM42WB4pUo4G5x9w2UTaNm0/op9s?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nJuJnizZrU69BLb8f3/kTPgDBGXDY75gQVsSU+87INhCuPIZuc5eSl9OlO+WYT5AWXhfNNNRcsE3lVrnqY0DdEu7nYG46ViKziONU+ebHSyjIN1/doC+aL4PKrwAs51Ah2Ju2VrZrf/CxbZN/QZQ2hY1k7mYGmeCz9o0GBF6s80cLtJ7uJ7UNxwMJbQznE4lSCrrUt/45QQUvh2+a5arjq97+Xt0UOkNXqaZGZBEx0CvtLF3fodwoJMyZq8fQbeHOV3DOMjKXHyXaqv5WjoE+irO/wIw4vpnQN3FOTI+5nTZt8ixxbLEBkwFCHeMFxwteovZ+C3zdkPcQJN+VWb9FaddAY4nZp/3RoGtjP/xWuJDvJejPZnkKRZN6QH6fpXREgSzXyiQRAEV6pQife5b5fAE5OSk3naNNMvbiKj8DbZP4hRKuERrRQuQEAySiyLqqJFNyUJ+HSQlcdxx2VRPLGR2o2IT+ro10Vsz+r76hy35ajfJmnBjausYfd6kFGZ6catD8LAmi5g/ENZrXB2IPU2cav2e+632dbrLLbBy9fqGjN8YTnYemuB2mZ5O8IpunjyG3x+SgTfxFhyFGdY2TBSDyFS5EKTBosMjtWeWQ8tgzVCR7+0Ah1inf7Kqhhsvkcto2nGErPLC2WpbiZ/Rug==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:17:48.5097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b89ba6a-da5d-4727-0d58-08ddeee27d26
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2130
X-BESS-ID: 1757341072-304861-7623-195-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.86
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmxkZAVgZQMCXVwjLZwsIoyc
 jEwsDMLNHSwCgtLSklydLQPC3J3DhNqTYWABDd39xBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267336 [from 
 cloudscan19-86.eu-central-1b.ess.aws.cudaops.com]
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

