Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A28CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:05:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A18D240652;
	Mon,  8 Sep 2025 13:05:17 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 1C74D40264
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:15 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021131.outbound.protection.outlook.com [52.101.70.131])
 by mx-outbound18-209.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 11:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg4f8o8QuTzpSfqcOShEB+ST+T8FcUsbansHAKh4dBXe20OqD4YIHAzVqWqDKGEzOedcT0SDw1q0df4u4alzvontU2xAuRw2ODCtJudWt9o2AGDLlCUykAsdkLLxWE0stu+wYk4WRmPGEEzsJjuPHEuV1kgc+/VoXa2oji7UiCksx5TYgZrxH1esD0nk5rQruLBcbOM7PGPHYGQm7uqBzzvwIHgAD5czxS6sSrgRWG5QW/5VY38rVjvCIK3p/wh/tqs2jARqJ4bM/CbhxHqoFwQ2x2vLIJRCBTH2pe3ELKwkrT16nrB+TSfle+D61+ec4Fl6cvV7qrol9PlxO6wqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krNabf5tRpQuvZTJ6Qz9xjP8TfevE8/qVQnHF+pbKno=;
 b=p45pd189liRpzV6nM+s6US0vfNZOhxtSeENGE10OTq4trzo5Af+XO0YL5/4XBoeIqIzPx6kPUHfp2U8ZRC+d7UDtW9bFrW2QPlKS5Xn9wnI6rx6OH7Nj7pQ2hkMokihmXEZi1aGNhebjBHS53py/XW0sxvhUuSYgJD5Z/PkwiRkFuzwj+ZkJ1A42HDxKNW+jltvsw2XH0dIFNIBGKJjAjVCmRjTJFQRjqOG6yWpdRj6Z47J6DO33xJVhRL2+L0UJQAMvjlsfehPelFZfqAyYeyvRZmT6bsPE2F4wPrL5hUJX00MO5aPaR2EMZZU71E46ZqmHiH7+MrLhb6OkqeES+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krNabf5tRpQuvZTJ6Qz9xjP8TfevE8/qVQnHF+pbKno=;
 b=apUIhIfX2yTFmy7jEl0YdiTDp2tDUH1JZeKPXpBdH1KEGRHKigx8D5ESPkX4oCcj2CqTiNOv9GLPg6Fyeiz5O97FOzABzgUQo5uxCE+89fEB7H4eLX9s68odD0X13ZccH1uHEdUOtR/S+pIz4BUXuvXEtL94sJaX6aYI3lbzxt4=
Received: from DU2PR04CA0360.eurprd04.prod.outlook.com (2603:10a6:10:2b4::28)
 by DU4P190MB2581.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:05:11 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::94) by DU2PR04CA0360.outlook.office365.com
 (2603:10a6:10:2b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:04:55 +0000
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
Subject: [PATCH v1 3/7] net/ntnic: migrate statistic thread to service
Date: Mon,  8 Sep 2025 13:04:41 +0200
Message-ID: <20250908110446.1071964-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908110446.1071964-1-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|DU4P190MB2581:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 84b25d03-890f-41ac-df88-08ddeec794c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cMvAXQ+eUBYvJEQDgDW+zNxSCukwYa8To1WP3zEZqnpOEB7R3iH7MBTT1/h3?=
 =?us-ascii?Q?IdsEDB3Mwb3ghNAruQFRUvVByQuXS6gFQRnLNtBHQqIZvng8lEkBefyUWbCm?=
 =?us-ascii?Q?W5tFYe92VBpHMiL3vkOlQhBLGJuU1QO8uc1J0aOpbZ/7s1H6gP4WeJ4KPGch?=
 =?us-ascii?Q?6/QyjPLSSOJsUs0iMdhAmQ0wLQ40RpOQdseFpPOZEK8ioZDY2nBdXuf3oSap?=
 =?us-ascii?Q?FYMSpQkaw9Dp4kt08I6W5wJxuSsSmmZjIiCj+QLNsLxIPPtrCh1m/NFNemwV?=
 =?us-ascii?Q?R9chHJvy86soe3iQWDud8WmaMF4CUy0W/37638DLmmcyG5qYifimR1FmU2iC?=
 =?us-ascii?Q?a7jtD7uadOcDgG/qUUsLe0j9OyzA3LzlkYlzC7/odCRtesCC0b47as/eaYN4?=
 =?us-ascii?Q?/3plzxU3i76twsICjIvJ8H4KX1GK/0xOxhzh7/k6wX/lGEdoc9haqZ8H4jqs?=
 =?us-ascii?Q?dACjPZ0/t04st9eZc4UP8HWS0KeYIZWeTQfnqCwX0Wpau4JptQTsCoNkodyo?=
 =?us-ascii?Q?/3f4Eb28BavFbjQUgfJmmCaEOtsLsLzJhlZfmTuWzjA+ZkZYXI6i570uxZYm?=
 =?us-ascii?Q?bj1kxrzVikLhj5Svt3GrYoHMvq52ZC8gMfVbO4tU0g5jwaZ+DFX8VYfujmYu?=
 =?us-ascii?Q?e97f0BabADTMsBvmmzcAc4zE7L9rl3BzfHhxYmXMRxKMiJ8jY4HUK/dmVBLd?=
 =?us-ascii?Q?eqz0hxq68Cm25+tXG5vq7DOwYkzmUMFZ0cRP6O8O0c376MzJRyXyt5N9BLom?=
 =?us-ascii?Q?d3gIn1FV7urg0xvx9VshzCsIETuTz7B413a5ZQursQ/niN6jOPdca/jFmZct?=
 =?us-ascii?Q?AQwYJk8uYyDlyPK2SNKY68VwLTiqjxY8U/tUoP7ffZNZ+sh/5BYFatDbZnNN?=
 =?us-ascii?Q?m11uAqu9N/SN5lj+0JcfWdoW6zT8RfjDkrjxpVYWPquzNF9npAa9+XRR1tft?=
 =?us-ascii?Q?z0J08UzItJrLf7/eALsHTjio7YiqjDJTgMrTJdUvPPdFONvpZT6G9qDkr8it?=
 =?us-ascii?Q?NE4RJEsk82jNy+8Y5VtZ9sb0LMdjFYsA7DneBuedNVcsjJNYdBso6yZFzvSo?=
 =?us-ascii?Q?26vGH7WI3lqPWu/mytsflVJhwwJb4xRxCgGuOmi9bsLf3+XuaOrxYrpKrDnn?=
 =?us-ascii?Q?4GvV2ndPDXaQ9lTTa6AzwYf9OWNThggKTJfC6idl1cfkPq+GbEFq/nMAboFO?=
 =?us-ascii?Q?80DfJ2C4wbS7rVgo5/u3xuR5CfRS9M4D8nPhQGbzktYAyxtzNrFqZaZ9qGoU?=
 =?us-ascii?Q?fvEpQ2zNZJM3pJtrVpVeItbkmyakmTx13h2EnO7gQTOdkzKkE3Iad8kpPZ7y?=
 =?us-ascii?Q?BvSAaN3IZphv/yxY5q+9cH1GMAAufR0AxVpMpXJN8pFaBIoF3J0v9Qj6yKHy?=
 =?us-ascii?Q?0TdlWnUu3ayBcRVkHJgATV009JPrt1uikyyMe+PGt38S6I9Mkk7VtlbvNQX/?=
 =?us-ascii?Q?rt/mF4MWFPMcYCsiV5YHKQj2hPxKbokzvIk0IqHFLzvW7j18pG8TPNEAgPx7?=
 =?us-ascii?Q?0X9+mZiPDOhXLl3x8eFx8+qw9G9dXu9hhOHK?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Uj2Rqa5BIBZQYoYgzo01dNOGrUl0x/1hffN62J9XeJb+X23pvzJ6/gK9zZS4aEpitoJ6HBia88dVAMSHG3uTRlM4Q4C94h+QeGREoNnmlGU0R21nEBuLZRsf3d2ekGvD5AWYqVd2qKc0fbFlPvzgH6+fE1S90cIS79y7RZHVGtAPObKnSt0b4fgCOIyvsz91SOYx6wbPjcx5F0Pllx9KickT1CjZRCy2X18y1bolticn5cWG489HHRo5WwVwN/tZziz5y7D46+4p3wQXwwqYzNByTYPtFAHiVHOTKS3h09e1eHSiJ7RxQRbYTVE4GNz+kb8uhWy0jZ2bZ7dLfbB3cUky/9QVySe/AfY7AIlwsIt/RAeysRsclx4aEDSAiLWkocyTScbkNsKI0cr5H9KWqQc1f55ueREOeA9PyNRouGkv92kppqnIz5D9vJN1TApOO9ppdcc0xcbWGWSxLZ+lvOSx1Uie1ks7h3d4V+GMG8R/RYIXclmyUVE79783DCZ7iSgyjYKdaRy/NXCzGlXAlUNMacXC5Hf/8UlNJf/0PizQvrO+K5KTNBIq5xfPsxW1oXAYL+u9GO0S5EW99KmniZOO3XpuwkV9tVFtd7e0uKiFf3yiKGdqyy/SFG2Ty1/GkAuffoj5YVpAENhb6p7GnA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:11.6932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b25d03-890f-41ac-df88-08ddeec794c5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P190MB2581
X-BESS-ID: 1757329513-304817-7662-4007-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.131
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuamBpZAVgZQMNXYwtjY3DI5yc
 zMKNHC0MzAyNIgJdXILCU5MdnIxDxZqTYWAOjECDNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267333 [from 
 cloudscan10-175.eu-central-1a.ess.aws.cudaops.com]
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

