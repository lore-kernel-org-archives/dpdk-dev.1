Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EEBCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:42:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F30D40A75;
	Wed, 24 Sep 2025 16:42:05 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 41C92406B4
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:01 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021100.outbound.protection.outlook.com [52.101.70.100])
 by mx-outbound42-195.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVdbvZpjZoAkViByut+drMvvPu9hojkEm9ecsGAb+UWcaijHiC4qzCq4EgVb4njZNOCuTeBURnTJ2Vi/4fQpqcemLtlwr20MJsNFuHpOKaYJW++Uu7tQV44khQ/2dwMit34I/0ZnC3pdrhVtDAtU7vL5EtOzgXqtv98TZxeidUzuBb3fWrDG5M/yESEurSEE31vqddcmbmZpqIITSRkODB20iqTZAcRnJddWms4LfNADWT3CzCKOnqL+zAYkNkEeKeOaqZgqPj9Rl8ikSJGaT5qt6177JKGaVbC1gF2x3i3PemJaxlVlaekW6kM6egywe4TSAaqqlEPAgh4Z+xrutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krNabf5tRpQuvZTJ6Qz9xjP8TfevE8/qVQnHF+pbKno=;
 b=kdzAPsLx67mV6wdOXufcYvVRseuDhXdXH8zVj7zPgzTPpoXbnsNlo2ffPFmWLEF7g0ZuTQW33j7w4qgpX6mNehxs2/XNrF3c2B8zYGeKYF264juu6j/GWFPLtqHoH+BRidTxQuB/4UmIseUZfHaWrRTiIY6P1W5BmhWmW/aL425EHoq/TIV8J0EH7BCDsYu4uC2tio5F232rqD7yF7fUiemZUq59HnUkF32W6CpnHXH1ApFKz2IWUFnAWXoSxmLGG08EgoIWmDnEI0/tbEhMvdLAMisd2RyQy7mpvv8kN9tt5E3Sh2PETmrh30m2D6FFRxtU01a6trbw76usp2RRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krNabf5tRpQuvZTJ6Qz9xjP8TfevE8/qVQnHF+pbKno=;
 b=jJbIWE1G7Xzb/oxkY+c+6ijnm3V0aZwuoM1FMH1UUVT65cdWcDRGZ3JJh2rPC0dVigtkIpO/Q3kJKtuDAlL5V17DzeQU6AHjPrn91ZU9+D579eSqGHJvl7zK/rUuK+e0Jyh/vdO0eXRLoK6DS07+rYISAiPdRwnhCiFb09PniUM=
Received: from CWLP123CA0239.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::8)
 by DB9P190MB1050.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:41:59 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::27) by CWLP123CA0239.outlook.office365.com
 (2603:10a6:400:19f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 14:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:41:58
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 03/24] net/ntnic: migrate statistic thread to service
Date: Wed, 24 Sep 2025 16:41:26 +0200
Message-ID: <20250924144152.53203-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DB9P190MB1050:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9319bc85-a6c7-4a1f-a2a6-08ddfb78842c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T2oYgt54L5QA3X+W0Zk8yuazkwMG2VH3YZ9YSKLBBSnRVt5/SYk6ezFRg3sn?=
 =?us-ascii?Q?xyNaqxZuUz3YRqZ6TD+I+BhxpqgNRllLSGfAzz+43MtuubLviCSThSKq/tvR?=
 =?us-ascii?Q?pDNYicCwzIq0p91vledyPSi8bHeflX0t294W4x9JNRXzt0e3pZq+kc0JEriB?=
 =?us-ascii?Q?yplNL6cXg9jk3MBc/UFHzSIFOqOGgeX2syG+31twys0vTBr4xUXiFtfn9Flq?=
 =?us-ascii?Q?ata+zMF0eyx1YH7bldnw0VDYKfzqaZACpWNsk4XMUnBDfhav3XWbEv3jV+Jy?=
 =?us-ascii?Q?yCyUbkWYLZdruGWJS2SJ+Nl8QekS7y4P8U2eGSMIsnTrkys1xn1kJAqOnQoY?=
 =?us-ascii?Q?58ef1lrT1RKiEj9zK/oXLeT5WQRLkLQTzOYWmzrgsok3GVfM4ck6WEFOSqFg?=
 =?us-ascii?Q?uaHSDMIH614MamT6yzx9DDVabdrmvCx8cdoSLlbXz8ftCaElTcDC9+1d3I21?=
 =?us-ascii?Q?teZG4GNlvZf0zkgLGt2PMEfziWgDpeyU3V9a7wXvgmJApCYJAazCeKUTbSLp?=
 =?us-ascii?Q?m4yiTZT0Ot9hZV9GKbylkES+cNlf8zxPfR0HwIycUqIIucxfaf8pP/hl+pqB?=
 =?us-ascii?Q?XYDe4OHtPumUGzUb6egNF6Bth3TQcOniH9KyT4DywnT3TH4mvwniZeA5fiXC?=
 =?us-ascii?Q?l3fJwyENw22bwDalxgGZkRpuTsHh/qWSbLbjzmOcLayG6XbelXU7lFJpvDvE?=
 =?us-ascii?Q?Kvbn+LpwFB36OE5zke1h+fa9bBleHPUOHfdl1wnnj4ftMIMgGJYkOzSB2OZP?=
 =?us-ascii?Q?8qVgKjefsKPxvFXME9Ic4JdRY7HypH1gO1DIiOHP3mOsyoIH3y/QboB75ygm?=
 =?us-ascii?Q?4pdzeBQVt8CGXodDTLEJTJXQleEHW42y/eiANTi8ySgxDKzz8AZysrwot/+R?=
 =?us-ascii?Q?nobEJ57ZIyD01xFqd9D9qg1csZZJ8+GsRaPyotThFIkC24Vl3hib5Jikl89h?=
 =?us-ascii?Q?fkM7EKJYnFD9uMe0+2NGcMceWcu1bT7u5fTCh2E30QgMtYxr8LKXSYOh/eFs?=
 =?us-ascii?Q?TicdJKyBzLuZZLbCaGoK3QQzhX4x7TldeuZfpQYC5JsgSAS5JHmJR/tz6Iyx?=
 =?us-ascii?Q?oZgj5MdHXkUopclzhTRoMyoVq3bbu82d92H51pkS099TvUrhwA2G428ovPEe?=
 =?us-ascii?Q?8kvcyDJPT/mlR+rMrEjwueOCA1z99NTyXQhyDnVmndIuWH2CqrLNXr7dDOjn?=
 =?us-ascii?Q?rAkLzh+kGsAVOZYm26A3hP+mInkiUDZm5SX+uDsEX7/qhZFm0FSy29HzZS4e?=
 =?us-ascii?Q?HSGBbdRGMGXTB0SMUKIQ98pJjCnhNsAvTx2Ma3iPNI0N7LA4ZwImXKWGj16s?=
 =?us-ascii?Q?wevRRr3mG4qTyBSxrzCH1lsf1+xbW98MI+t0Lz76HToqmyEDpgrwmNJ/UdEp?=
 =?us-ascii?Q?pcdZg+uPC3Wl4yt1M65anWJzvh7uUJ4udWmd1hgYmzqtFyKJSG4CsZq1h9nF?=
 =?us-ascii?Q?BYmCpXlfs8relwHpkvvmidreVPIEF/cIjiSK45lMKIZNoVyUKMkMtk/ISYw9?=
 =?us-ascii?Q?YLZgx590Emtbe6PTUjVpGzVdG/iQH37WAQfT?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aqlXapRVOp6nWeSDYwRz4btmY8ng24CZvXrj3D/xMGoKFQEi7YAD+FLbSIbaLDx6vGmvewmMTbtY+LEo0zkPRNabM3L8n6cLoFlmRjBzU/mvv4X6NIxMuwd1SvgH0zIKU/czz/38XXiM99W1gGvuXsny8vy5CK1GYAB3sbUT9eqsadAnbpiE1RdLJB726d1mC/J4TdsOf7WUQN1Evv7tkB+wNGUwC4f3haGuJDOS6UPKk9QwhqmFxlvjHXlFcteht1oxe2qcV57LsrdSQdn5pwTT0Q64oDpIbyMVUJ3LEaocXaoz6U7d7vt53PXz4pfz0OnWw4cVdESDpkrllGMnMSKC04sxcELt0LURGGnwTblkGYN7kpH52nbTsWqd3NPVdg3mwtqeF1ywMjI/puUpSSU1PIJd/8cxqU903GDbvzumvsGU6lPJQF7x+gmdiQtMse3PbUo9t6+wKVqtY9tVoINPJ1HOSvvHeBwpa68Ylkd/J3WYgxzQxGxCmoWo+pjEYqV/hmKmXfaTgLvMEOqDMNb2S2SrqsPnOOEf5JK6sFdIkiIb4brXPDcwj6qqtPt5Eu4cL7dTEJGgv2rFV6bYUdbonpnxbgg9C+afjOWesgiivoTs42QOeRt5xNCKD35TartHvWr5pdauiAdw23YheQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:41:58.7627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9319bc85-a6c7-4a1f-a2a6-08ddfb78842c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1050
X-BESS-ID: 1758724920-310947-7723-8042-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuamBpZAVgZQMNXYwtjY3DI5yc
 zMKNHC0MzAyNIgJdXILCU5MdnIxDxZqTYWAOjECDNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan18-201.eu-central-1b.ess.aws.cudaops.com]
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

The statistic service is responsible for collecting statistics.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/ntdrv_4ga.h |   1 -
 drivers/net/ntnic/ntnic_ethdev.c      | 146 ++++++++++++++------------
 drivers/net/ntnic/ntutil/nt_service.c |   6 ++
 drivers/net/ntnic/rte_pmd_ntnic.h     |   1 +
 4 files changed, 84 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ntnic/include/ntdrv_4ga.h b/drivers/net/ntnic/include/ntdrv_4ga.h
index 35afcd546c..c143c0c2b6 100644
--- a/drivers/net/ntnic/include/ntdrv_4ga.h
+++ b/drivers/net/ntnic/include/ntdrv_4ga.h
@@ -16,7 +16,6 @@ typedef struct ntdrv_4ga_s {
 
 	volatile bool b_shutdown;
 	rte_spinlock_t stat_lck;
-	rte_thread_t stat_thread;
 	rte_thread_t port_event_thread;
 } ntdrv_4ga_t;
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index c114017db8..54c9e218bc 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1542,9 +1542,9 @@ drv_deinit(struct drv_s *p_drv)
 	clear_pdrv(p_drv);
 	nt_os_wait_usec(1000000);
 
-	/* stop statistics threads */
+	/* stop statistics service */
 	p_drv->ntdrv.b_shutdown = true;
-	THREAD_JOIN(p_nt_drv->stat_thread);
+	nthw_service_del(RTE_NTNIC_SERVICE_STAT);
 
 	if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
 		nthw_service_del(RTE_NTNIC_SERVICE_FLM_UPDATE);
@@ -2024,84 +2024,86 @@ static int adapter_flm_update_service(void *context)
 }
 
 /*
- * Adapter stat thread
+ * Adapter stat service
  */
-THREAD_FUNC adapter_stat_thread_fn(void *context)
+static int adapter_stat_service(void *context)
 {
-	const struct nt4ga_stat_ops *nt4ga_stat_ops = get_nt4ga_stat_ops();
+	static struct ntdrv_4ga_s *p_nt_drv;
+	static nt4ga_stat_t *p_nt4ga_stat;
+	static nthw_stat_t *p_nthw_stat;
+	static const struct nt4ga_stat_ops *nt4ga_stat_ops;
 
-	if (nt4ga_stat_ops == NULL) {
-		NT_LOG_DBGX(ERR, NTNIC, "Statistics module uninitialized");
-		return THREAD_RETURN;
-	}
+	struct nt_service *stat_srv = nthw_service_get_info(RTE_NTNIC_SERVICE_STAT);
+	RTE_ASSERT(stat_srv != NULL);
 
-	struct drv_s *p_drv = context;
+	if (!NT_SERVICE_GET_STATE(stat_srv)) {
+		struct drv_s *p_drv = context;
+		RTE_ASSERT(p_drv != NULL);
 
-	ntdrv_4ga_t *p_nt_drv = &p_drv->ntdrv;
-	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
-	nthw_stat_t *p_nthw_stat = p_nt4ga_stat->mp_nthw_stat;
-	const char *const p_adapter_id_str = p_nt_drv->adapter_info.mp_adapter_id_str;
-	(void)p_adapter_id_str;
+		nt4ga_stat_ops = get_nt4ga_stat_ops();
+		RTE_ASSERT(nt4ga_stat_ops != NULL);
 
-	if (!p_nthw_stat)
-		return THREAD_RETURN;
+		p_nt_drv = &p_drv->ntdrv;
+		p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
+		p_nthw_stat = p_nt4ga_stat->mp_nthw_stat;
 
-	NT_LOG_DBGX(DBG, NTNIC, "%s: begin", p_adapter_id_str);
+		if (!p_nthw_stat)
+			return 0;
 
-	RTE_ASSERT(p_nthw_stat);
+		NT_LOG(INF, NTNIC, "statistic service started on lcore %u",  rte_lcore_id());
+		stat_srv->lcore = rte_lcore_id();
+		NT_SERVICE_SET_STATE(stat_srv, true);
+		return 0;
+	}
 
-	while (!p_drv->ntdrv.b_shutdown) {
-		nt_os_wait_usec(10 * 1000);
-
-		nthw_stat_trigger(p_nthw_stat);
-
-		uint32_t loop = 0;
-
-		while ((!p_drv->ntdrv.b_shutdown) &&
-			(*p_nthw_stat->mp_timestamp == (uint64_t)-1)) {
-			nt_os_wait_usec(1 * 100);
-
-			if (rte_log_get_level(nt_log_ntnic) == RTE_LOG_DEBUG &&
-				(++loop & 0x3fff) == 0) {
-				if (p_nt4ga_stat->mp_nthw_rpf) {
-					NT_LOG(ERR, NTNIC, "Statistics DMA frozen");
-
-				} else if (p_nt4ga_stat->mp_nthw_rmc) {
-					uint32_t sf_ram_of =
-						nthw_rmc_get_status_sf_ram_of(p_nt4ga_stat
-							->mp_nthw_rmc);
-					uint32_t descr_fifo_of =
-						nthw_rmc_get_status_descr_fifo_of(p_nt4ga_stat
-							->mp_nthw_rmc);
-
-					uint32_t dbg_merge =
-						nthw_rmc_get_dbg_merge(p_nt4ga_stat->mp_nthw_rmc);
-					uint32_t mac_if_err =
-						nthw_rmc_get_mac_if_err(p_nt4ga_stat->mp_nthw_rmc);
-
-					NT_LOG(ERR, NTNIC, "Statistics DMA frozen");
-					NT_LOG(ERR, NTNIC, "SF RAM Overflow     : %08x",
-						sf_ram_of);
-					NT_LOG(ERR, NTNIC, "Descr Fifo Overflow : %08x",
-						descr_fifo_of);
-					NT_LOG(ERR, NTNIC, "DBG Merge           : %08x",
-						dbg_merge);
-					NT_LOG(ERR, NTNIC, "MAC If Errors       : %08x",
-						mac_if_err);
-				}
+	nt_os_wait_usec(10 * 1000);
+
+	nthw_stat_trigger(p_nthw_stat);
+
+	uint32_t loop = 0;
+
+	while (rte_service_runstate_get(stat_srv->id) &&
+		(*p_nthw_stat->mp_timestamp == (uint64_t)-1)) {
+		nt_os_wait_usec(1 * 100);
+
+		if ((++loop & 0x3fff) == 0) {
+			if (p_nt4ga_stat->mp_nthw_rpf) {
+				NT_LOG(DBG, NTNIC, "Statistics DMA frozen");
+
+			} else if (p_nt4ga_stat->mp_nthw_rmc) {
+				uint32_t sf_ram_of =
+					nthw_rmc_get_status_sf_ram_of(p_nt4ga_stat
+						->mp_nthw_rmc);
+				uint32_t descr_fifo_of =
+					nthw_rmc_get_status_descr_fifo_of(p_nt4ga_stat
+						->mp_nthw_rmc);
+
+				uint32_t dbg_merge =
+					nthw_rmc_get_dbg_merge(p_nt4ga_stat->mp_nthw_rmc);
+				uint32_t mac_if_err =
+					nthw_rmc_get_mac_if_err(p_nt4ga_stat->mp_nthw_rmc);
+
+				NT_LOG(DBG, NTNIC, "Statistics DMA frozen");
+				NT_LOG(DBG, NTNIC, "SF RAM Overflow     : %08x",
+					sf_ram_of);
+				NT_LOG(DBG, NTNIC, "Descr Fifo Overflow : %08x",
+					descr_fifo_of);
+				NT_LOG(DBG, NTNIC, "DBG Merge           : %08x",
+					dbg_merge);
+				NT_LOG(DBG, NTNIC, "MAC If Errors       : %08x",
+					mac_if_err);
 			}
 		}
+	}
 
-		/* Check then collect */
-		{
-			rte_spinlock_lock(&p_nt_drv->stat_lck);
-			nt4ga_stat_ops->nt4ga_stat_collect(&p_nt_drv->adapter_info, p_nt4ga_stat);
-			rte_spinlock_unlock(&p_nt_drv->stat_lck);
-		}
+	/* Check then collect */
+	{
+		rte_spinlock_lock(&p_nt_drv->stat_lck);
+		nt4ga_stat_ops->nt4ga_stat_collect(&p_nt_drv->adapter_info, p_nt4ga_stat);
+		rte_spinlock_unlock(&p_nt_drv->stat_lck);
 	}
 
-	NT_LOG_DBGX(DBG, NTNIC, "%s: end", p_adapter_id_str);
-	return THREAD_RETURN;
+	return 0;
 }
 
 static int
@@ -2371,9 +2373,15 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		}
 	}
 
-	rte_spinlock_init(&p_nt_drv->stat_lck);
-	res = THREAD_CTRL_CREATE(&p_nt_drv->stat_thread, "nt4ga_stat_thr", adapter_stat_thread_fn,
-			(void *)p_drv);
+	struct rte_service_spec stat_spec = {
+		.name = "ntnic-stat_collect_service",
+		.callback = adapter_stat_service,
+		.socket_id = SOCKET_ID_ANY,
+		.capabilities = RTE_SERVICE_CAP_MT_SAFE,
+		.callback_userdata = p_drv
+	};
+
+	res = nthw_service_add(&stat_spec, RTE_NTNIC_SERVICE_STAT);
 
 	if (res) {
 		NT_LOG(ERR, NTNIC, "%s: error=%d",
diff --git a/drivers/net/ntnic/ntutil/nt_service.c b/drivers/net/ntnic/ntutil/nt_service.c
index 86f709e401..c109b44483 100644
--- a/drivers/net/ntnic/ntutil/nt_service.c
+++ b/drivers/net/ntnic/ntutil/nt_service.c
@@ -18,6 +18,12 @@ static struct nt_service g_nt_services[RTE_NTNIC_SERVICE_MAX] = {
 		.lcore = RTE_MAX_LCORE,
 		.initialized = false,
 	},
+	[RTE_NTNIC_SERVICE_STAT] = {
+		.tag = RTE_NTNIC_SERVICE_STAT,
+		.id = NT_SERVICE_UNKNOWN_ID,
+		.lcore = RTE_MAX_LCORE,
+		.initialized = false,
+	},
 };
 
 inline struct nt_service *nthw_service_get_info(const enum rte_ntnic_service_tag tag)
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.h b/drivers/net/ntnic/rte_pmd_ntnic.h
index d6236dae32..6fe6541984 100644
--- a/drivers/net/ntnic/rte_pmd_ntnic.h
+++ b/drivers/net/ntnic/rte_pmd_ntnic.h
@@ -42,6 +42,7 @@ enum rte_ntnic_event_type {
 
 enum rte_ntnic_service_tag {
 	RTE_NTNIC_SERVICE_FLM_UPDATE = 0,
+	RTE_NTNIC_SERVICE_STAT = 1,
 	RTE_NTNIC_SERVICE_MAX
 };
 
-- 
2.45.0

