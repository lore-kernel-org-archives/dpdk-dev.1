Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3769CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:36:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913BE40669;
	Mon, 20 Oct 2025 18:36:37 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 96F53402D3
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:32 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020094.outbound.protection.outlook.com [52.101.84.94])
 by mx-outbound44-20.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2X5pgNtBBh5QGUflxfT0q3zlPfvPtfXrFT4V7O4eVILkL0YZC0HSXefZ8kKhVoJljBfH5IbfRyr/CuJXKKH9agTFqDsltTAetyICkGyHPUQ/1IrhfEkbuq3dCtEDLG54wGm+HOrsRUxLby2pCL6ZaqvyvmCl4qrutcr4MrY9YNtg4adYcBlJhf6Olr54CjQK9n2BW5vYdcCiykrRWkifOGOd33Sf7nTvhQeSbLNxdDHRt3P9LESCVYQ/Gk8ksgzOEktlz29uN122WqBmyKwf145Z/S4WqIQVDPeqqIJ6B1+J5xIQ8FrF4cVqqlXSPt0A/9jcIiDED5dLNGG3oFVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krNabf5tRpQuvZTJ6Qz9xjP8TfevE8/qVQnHF+pbKno=;
 b=P8TuIdpaHd/pw4kAPokHvA5VqCS/L+qstbqD307qMCLJ72GUofYv4LaXr0MIMudaQxW+/aCqF+Q3O7VO8ibVNpD1uykOvTxoTfYA15bfkgJQQBwa2F69utbSnrUHSZHVD8WOdxsLRnnSRJMjRGdyERcWEoZRyvsuu1cxhgcHvLAYLa5oi566Xoe47NMPodIY6eqCK2yTqOeFFJmaMBVW6/wO4FczM9yxEKIhTfeuOT7NpQCpiQqAKWxX7cr4HNPykqNr5L66JysiPZ+m6AdwhssocVMNIze7+mbVqDQNCA95sr5v7i76CMBSp2B0pVFeFSSA5xFCZ1da9DF2G6SwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krNabf5tRpQuvZTJ6Qz9xjP8TfevE8/qVQnHF+pbKno=;
 b=KjJn3wjrF6xvJaP8jNUjzBI6jN4PvaLbI5tvrLqAyuW4nfnafIAjMlbSfXo3EjfpJR4aKe6nrKU13yBF2gF62XgNrGfU2ajjO6OjdWhmo0E8brpiqBvcAHPQY5cgMgNduKCYx2FG3kKDx3NosB/26sU/Kp+/5lP2OKt2c9xt1r0=
Received: from AS4P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::16)
 by VI0P190MB2108.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:248::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:29 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::62) by AS4P191CA0030.outlook.office365.com
 (2603:10a6:20b:5d9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:36:20 +0000
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
Subject: [PATCH v1 03/24] net/ntnic: migrate statistic thread to service
Date: Mon, 20 Oct 2025 18:35:54 +0200
Message-ID: <20251020163620.282312-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VI0P190MB2108:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6dff3dfd-f13e-4ff4-37f9-08de0ff6d1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DXdIdDTrZ451HUqK4aYxS2bjQkBN7UnXK1+Zz9kOwm2NBTClrn4RCQfNejuY?=
 =?us-ascii?Q?+wjdgKjtUEnCEZMW/SzoIJqsQzXHu4n6EI33TjSKHFXi/JRfnV1WfFoskgVb?=
 =?us-ascii?Q?5M4BCs2GfMednRgH73SNSWPCgqReMh2ySEWyQsdbZrzRHv7ZS1BADnNK9xE+?=
 =?us-ascii?Q?5HdxuvWzMaV26IwJjW7oYWKkRz1PR6cwZNV4gmXHDwaxtSxhnju4GB403Kby?=
 =?us-ascii?Q?R0nC3kq9hRK4y/uyzuR9D5w9koKBi1ZHuOokImtib32LzSroIjAy9aYd8yHL?=
 =?us-ascii?Q?imf+WWnv6IyomN5zoCJxBVO/uq5WtqUOcpFrc96Eo5FV9BzoC6W/gaRYo0JK?=
 =?us-ascii?Q?gs7Y2Kdp9J0w3rrNZURS33S8fjyNzSQARVpOhk74dQ5j7Oz1PfzAYGDxey0p?=
 =?us-ascii?Q?BMkQOLjyVT0U79Aj0CdaSJvHPUkh2l3Fp/RD33z5ePrF/am0Rqtpjnb3dIV9?=
 =?us-ascii?Q?5cTCLft7W7as2RdUYDT7nYkJ9Mkv2kYLgRi5aKmRePoRQH+R8EKkj3EIUN9m?=
 =?us-ascii?Q?eoZngxYhBJ2whmVV8ZxIqHeeHyeqcnR06nC5TmtTZRJtHSSxtMCodCTPOvLH?=
 =?us-ascii?Q?2Wsj/YLHLfEA0Vq6xyrEFOjzxLN5h9tQ+rM1cCmvloAWb59s9T4eH/bzFn8P?=
 =?us-ascii?Q?PmbswzyY2IyO3DHIKFbicRp3UxuvmZIJYKLMrMsMm509RUKl+DcOO2UpCbaa?=
 =?us-ascii?Q?dLY3wCYhheG3ei7foXkvY/k2IhLFxItd+isL1rq8f6pWVstqJRtJMU1Pe3Ud?=
 =?us-ascii?Q?pGOIJk/Q3T88Fk3lnWMB9bqF4KhvlQ61Lo356JmJKI0m3WeCHehdBTQ6yWKx?=
 =?us-ascii?Q?O1TeARI4wlirrdOvNrezE1ZNzjZRh8yA3nUy0xqdDPjIK/yYnRUUhsoBIgnd?=
 =?us-ascii?Q?fEJrS1HvqCjYBZ76+l4JFEj+gH3FvkwGxK3GHha4c5vuuncTeiS2veOffI4g?=
 =?us-ascii?Q?UH1OD3xYZYY1kmEUjoDCvUWCYpuqzkAy/wKzNUG/CJtGD4yfjCIw7YAmFgKT?=
 =?us-ascii?Q?WZuC3n/HgD/ApXOS5EWZFEQ0TW+ZxsoYHW9FSbHvY0eRGGTVft+lnWRfAv0d?=
 =?us-ascii?Q?2qEMen15t7yIbe0lCCg+G9qnpoqGzRC07++Kv46dlk1F6cEi4TzJL9egmNnW?=
 =?us-ascii?Q?upK2DuidsqNwnowT1YIf7OcxZ1+pw4easUQ5f23dVNOceQlh/ZWhnlekekm1?=
 =?us-ascii?Q?dkRD8tu4+N2Oy0aQR594GYZedDpFSGnPMuZXUvRVKwqY44z3TMaeVySgun2T?=
 =?us-ascii?Q?3bFJu5OJ6YKeFn6G9VI5EDc5bo0QmWF/hpKcqfYvnpGLqaJ85EgfUtgeuuGA?=
 =?us-ascii?Q?VubrDXkV3nbMUkfSjGA4DqU9ob3LMjnRYDHR6u5ba7glq+KqqEl3J3beXyyJ?=
 =?us-ascii?Q?CyYxQUVTIp/U/VllzkzyxaRe65vQUtkPvoUt2u2u+5otzBTvatCTP7i+4hLk?=
 =?us-ascii?Q?VCH/epp2zVYPO6LZNQun+8jkoLNeKSoS4sfRiODY2qGpSLX1NQlfbxRnD9eu?=
 =?us-ascii?Q?LGvP/KSkXI4iCW6uE8jUIIdB40OW4s0UeB6Qxv+25hPPtiqGNA0lH+zj17f6?=
 =?us-ascii?Q?eRYTMquxN30Qw+8j4ng=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JrbW8YcolEL+3hYu+y7XOj7oUNW0XTPSON25D7qr7soMjhobk65TvYXE72xf44fRcR1MK5WGPcS2KrPYfs6SkXwEGbOA/kaX0sGkVzo1cwOgqLbcqqZ5sO64F5qO5EKXIQpKCYICA83fjwAMmLUA3TeqIpC9xjsSWgWKcVZuPNx8bN2gap3FD2yH3KhXhWTAvboEsvk19yD6Zj6DTroTFh0iLntnJhv8HeU8cvrYs/TQC+tLK0kNuvddXB9nQ71APZBdvSimIUtFygImJMIf6kqKDuV/dRR3llLhkXEp2B2Lmv2BllNX0hp/Hr7W5hEVQZK2wq4L/B6ECHkdcdECSTKixwmEYmm/NZfzTMUtlwwssGDMHs7Q+VnPbs2Th1sTeqmvG2nM0GbFq2Z7ZXYrhbhx68zBeiwV/0Ol0RIU+ZDyclidrMD5QaZeF1IW3SksN+5L1CT5W2w1rLY6GhzX6hGOw6neFF+6A4enErL5KdTHbkIE5QBQ644TAL4D31oBinplh1olWh3xpKw6twHVUbDtXOh7vQAuD3GgswGD6U2QSLx3440xxREtZD6aGlRmyv2TzF5CdqI1RnXBPziIclAYVO/VCWhBdFourx7PyKTIhCFIu1yAJEafR/BmB+IP6GKGoKUWYFbawItBagFUfLVXB6V5JzN3W+cFgvrx5cw=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:28.9777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dff3dfd-f13e-4ff4-37f9-08de0ff6d1e3
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2108
X-BESS-ID: 1760978191-311284-32701-8202-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.84.94
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuamBpZAVgZQMNXYwtjY3DI5yc
 zMKNHC0MzAyNIgJdXILCU5MdnIxDxZqTYWAOjECDNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan16-189.eu-central-1b.ess.aws.cudaops.com]
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

