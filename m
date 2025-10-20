Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C100CCCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F19240649;
	Mon, 20 Oct 2025 18:36:34 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id D967A400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:31 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022076.outbound.protection.outlook.com [52.101.66.76])
 by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xah2KeR1a16MqhgFq+2o8o/9PNq1cOZRtpmMM5ElTqXpqfUmIED0M2udIHlrTT6uXOJ5uiaEN96uqiFVyrm7eSFuR26smzei81kr51ZKXDfMZ+cvYPuPZaMuB1hVPVt9T+mxnwEU+Bvct444PTwIMdhyurZEbvl50sf0LJXanu7mW2PtIZ7WmivQvk78twFEW0Ac2QbiOfoZ2DHswvbtFS5Do0aXXRsjH+fKQoaVshuZ34YtGMVGhznxf20P28R+5VxAQPUZpzC5EpizLgu6eDPXtvBnacEDxiJjp3wTPbS8bmFnPm1f4UJA3vwf+BMRoYnI2yQzOGe831Da/Xo/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LUpJU6M/gnwPdMUnKD7MmYF9/2kqth9oPK4faU0wYI=;
 b=RnXE2Pg0mHVKJqeUbS+y3B2QXR+fhPcyLNrRwLYD1I8XtFX7S4X8UPbnb4HgBnfajBvnNiIWWz8cX4dgqtKrxPQUL5phb89eBlOsBZGS1526lWwF/hmwc7KN1620v8quJbwlPznAjHsHUMbPoVMN7hzDQVhkuBlRSekdl/8c0A7cqXKJESDeEe8TYbCTZRLDYRt0Y/fdQhWKgOU9m6vX3soaRx6uh81MyxqkQIOPeTiT+XiUp/3fa533tH7rwLWDAayi6tcgAQEQi+Ulxv5hqyLcrluB0mUrrypDQobhw8d7+qGcSiCK1JTwcgWKuOcLdNZaLdR4ob7lfrAZCGKJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LUpJU6M/gnwPdMUnKD7MmYF9/2kqth9oPK4faU0wYI=;
 b=DhkHNJcn/dCjYvtNswtWWwg0md3jo4we2PIhoxdVHRZ1LxRGDy1U0lA6Z/khdrDTTne0UkOwC+5CtY0g/uiz6Ar2mKdOe/M1fhI6Ghdu7MpPT+Rj2WIbqUmt4/yiADHTpAIRNMGs6WkLaYUMBkgKptxX2RIe0kBLDuL5sNaVIRw=
Received: from AS4P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::13)
 by AM9P190MB1076.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:28 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::a) by AS4P191CA0022.outlook.office365.com
 (2603:10a6:20b:5d9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:28
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 02/24] net/ntnic: migrate flm update thread to service
Date: Mon, 20 Oct 2025 18:35:53 +0200
Message-ID: <20251020163620.282312-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|AM9P190MB1076:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4c7b300-0a17-40d9-52e0-08de0ff6d19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9JjxvAi9DMQmop3G3WDDYPnUK9XWNuxuOspRkHNsiJfKOsidKBc62qwTMldn?=
 =?us-ascii?Q?Gqjh4D1gmtNRJVK/CQ1AF+zhV3ljzDjbqeuadiviwqZMNyx86ITvA4tv8mTN?=
 =?us-ascii?Q?HCBP+pp0ZgHN/6H2FkrtdhgxyI/9bwP+p1bce4Q82C+a/0bjG2vU/efxIcvz?=
 =?us-ascii?Q?ymQGjTyzt04Ks1fLHN8pJS0U2aJ2GgUYB3PD7YgDDSruzt35YKaac1UYuQyL?=
 =?us-ascii?Q?BmQPYSxh+LIibXn9einwWw58GGIVBc8KNYn8Fkbow6bgYzjI3uAss1hydlsb?=
 =?us-ascii?Q?pcj3qcHqO/bBwVmhRgpP120knHeGus8iVv1xQQZrl0x0z6GO7P0Z2gZlhVkc?=
 =?us-ascii?Q?nv2tEs1Xxvv1VFD0L4ncNsXOjGThBfF9JHwJ4+22IYsmuocFEW1y7cb0Vnis?=
 =?us-ascii?Q?6tQ2MMgj0pzgOqv/51A4JzwC8T9zxHiwRceBzND0GyKvnMoz/TUciZg8aojI?=
 =?us-ascii?Q?leQSCWPQPn7CLX7jaDaB6A++X2Gld5nk41eEOiAHqNNps6a2X1TBRB4YWX7u?=
 =?us-ascii?Q?bqh6JKkFe+0xrzH8h4byNiQ81Is3JHNe8NJtCieX+CpN+S5NMcsbNwzjy5ML?=
 =?us-ascii?Q?woZ9e4YeOUQVoUtz5zcdj3jQUFKZ+8BVrxtf9k7Oj3qa3R64BW9siBYGDxu0?=
 =?us-ascii?Q?DclWf8W/B5h+CfYZ4Tv04tdOAsaevpUc5QirK5YM6Ii1xXPgT3IcxnNbxAue?=
 =?us-ascii?Q?Ve+fOQqGU3dqhKULoQXLjmq83x/9J8VdByVQVGj6G+rqRjUs3ZpJbPE212Bn?=
 =?us-ascii?Q?5dbqd0GOntjpshUAekFnOMOTt4V6RXQND7gBWCH+wUhIr4qiqurLkB/Eha1D?=
 =?us-ascii?Q?IGmRQSd8oEfbRWs8L6ivSm0fiiXMTjpoP9PtAL2NmU8nNU8Y3lZPFd5TtDST?=
 =?us-ascii?Q?WK+U5Us5x6teygPEKBl8pgATu2mODMWM/3Azl47fL691d9bVbLctpR8bonNy?=
 =?us-ascii?Q?sOqCZ4eWmTbmJ9Blr6o/XzkhypnFCQbPph7YWxZs4XH8WrL6n/OFMI95EC6M?=
 =?us-ascii?Q?kQBU/sEZMPGsc5dsxBvTWwLRegTzEBP7Tn0aIizSkVI46M0yUc3TwaxCSraw?=
 =?us-ascii?Q?7nUTylW3wFy1ll4E6VLSGgwXSbJRTlDG+1OejqLMsn7qepUuZZ/1STxWbwWL?=
 =?us-ascii?Q?DSloAqew4EWbJG2HttBnICCBuPh4kqPZHwmi7NVhWl6bFVEBZmjHf33YfQ99?=
 =?us-ascii?Q?U+SCl0gSEfO0CacPDNa2QaLFcAUqmWXZG81N+pDIh79euzEZ6hUzQflh6fOu?=
 =?us-ascii?Q?hQCxgDymDODglEarpDXFD9DEakUrgLFA+odfYZ+zrafFakO8fRd7B4A1fFds?=
 =?us-ascii?Q?yOtJLwtEIW0Ef71mIOaBtizubF5QkrPaYT+MjEtrcb/8Uo8u3kdyYkOGUzQs?=
 =?us-ascii?Q?XGF+Uq16PWhOlA4YmDtmSNMLPPqJ0qnRy4Qr7M2kxBGyrT5o6TCLfW4JS2GI?=
 =?us-ascii?Q?ST0/hU/75RC49WhMw7uq6KUq3ggQOVSQHodhLzu1i0TPzNZUbmvPPy4sAMt6?=
 =?us-ascii?Q?VbSCncw/khd2NNcCDKYq4zQJqhSQWjXFka4CIUz0V/c5yiP7bv511sA3log/?=
 =?us-ascii?Q?gtZ1pskbBl2tqc83zcA=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WmBs/heMVWmpjXWLtgWqeps0uFEvSPJsGO9CJ0wmQLa3IeUKBTmTv0H9hpiAX6NJFkLaF9anHnKHdMHC0FnLSllTCSC8FtIB7CoHoHICgbXHZmt+BHrCCsNrxl9+Js569yjD2iTG1N2QzBLGUEcB6dmivIG1fpSvptKYcgFsS/LMMca4TFcjHCEVYZkzubY+os0qfzUOTGTqhfWIcB57ccu+rlK0uvKDqjkxlytc0UMhWo8drNMt1RCJjtFXT+LduSl1cgVGLt4dZEBVAeqw+ZzMsmbsoiv0ANnSkzlv5XuM9eTjwNuNplo61qWvzyQrMWeUVKhnKUcqRf24UOJsYoq9CD/5pn+2BnMMDEV3ZtNyp4KBdw6RLCowqZ7ZDJ9jD8UdXTDykPgNxS+OlGfltzLCsPlIJmAnHxqS8m3vgFMF0rWGyIfWs2jOWqCJSbsow/9AbPiLHq1yynHZimHcX1207PfRPyj+ImklUiTezrn87y/ZIYXw7Ip4cid6RW68FEy6HLz3s/Rvna9zKch5S2ovsOiphRodyZ0z9W7RZh8RflrOl2Yb7IsyzqmlfWGhFkQjBjX0DCD4t0hr6tSBm73AYZZ3Td++6hRuDXl+K8tRcj2/UBOo8go6QKUdBxE1mysSoohybbuphiHJTUJqKoMqmIbyjOQi4qdm7mRrioc=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:28.5083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c7b300-0a17-40d9-52e0-08de0ff6d19b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1076
X-BESS-ID: 1760978190-303027-28476-63521-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.66.76
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmxkZAVgZQMCXVwjLZwsIoyc
 jEwsDMLNHSwCgtLSklydLQPC3J3DhNqTYWABDd39xBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan11-196.eu-central-1a.ess.aws.cudaops.com]
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

