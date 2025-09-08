Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C874ECAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 14:18:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64E374065A;
	Mon,  8 Sep 2025 16:17:55 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 5E515402E5
 for <dev@dpdk.org>; Mon,  8 Sep 2025 16:17:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020122.outbound.protection.outlook.com
 [52.101.84.122]) by mx-outbound45-224.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 14:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmtMeNlk2lH9nKE5KNOIdRLSJzFjdHzaU7Q6L8HMJT2cnVH28Bffkc6rbJ0fdfGn7QZ9S9vYDnd8BQGRzHWW9b5PIKchz2fZpgF2I06NB+aLQpX62b2PoZor593cEkj5uBqWurSPyqxg719uJc51AMd5LGQ+GVSEBe+FhHfoLBBIY+eQqkNjnUA7cCg7jQHzsHJ99UpCx5BPhHrkd5KrEOVzTer9fYCx2bhPsBfdsApmdBYlYb9SEQiKXRijkII4W9NZ1Y4bzhq8boGXCj0GErG8sU2nQKUZsVES1TzRSrx0c1OiPhtQyolzEmCk4hiR1cixNvkqBNPJAP49PI17kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krNabf5tRpQuvZTJ6Qz9xjP8TfevE8/qVQnHF+pbKno=;
 b=C/vxarGSAgRBQsos0MTF3oLEUJkRt8sj9JYlMMPiQZUTtm+CHF4rBgP24JjpiHORxFwgJPz95JnncPTJ5QRV5STY8Mtt0kw/vlHuu6fX4TGUUe5L0K0NSQkK7+c3oip0wOYANKFjAYEO0FKhJXr9hUeIdY0SFiCYdzOSNhaBnMmvd4LrRZTM0hn+Ab+bb/GA1OAzOko/SO//QZZsR3Y8dWBmpo7bMsh0Aid+YMewGXU5pMkOsx9ivLAPT/KIG5T4xJjUjYOUbkkDx4jdDlaTDujMZaWJ04f4nQv5nTQIfj7YcPmogciImZmqxJsVBC2tcPeRnMSspZIPiiauR7N/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krNabf5tRpQuvZTJ6Qz9xjP8TfevE8/qVQnHF+pbKno=;
 b=GXjkXehNm2iMtOdB2inrIs31+nXIPcpRkUGB1TOCtpnJNOxWggWYRhWUHc7JB0+fnHMqIXK9LfSfz9itzObyPn8JAfC/JtEUfa8BFFtRSdpzqEBnBU3d9SWdDoe1itsWMGY8fzpgeF57XgVBXbOX+gEeEf8b21LnCHoaNYi1lvY=
Received: from AS8PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:20b:311::14)
 by AS4P190MB1709.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:17:49 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::95) by AS8PR05CA0009.outlook.office365.com
 (2603:10a6:20b:311::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 14:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 14:17:49
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 3/7] net/ntnic: migrate statistic thread to service
Date: Mon,  8 Sep 2025 16:17:35 +0200
Message-ID: <20250908141740.1312268-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908141740.1312268-1-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|AS4P190MB1709:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 402d80b0-e6b1-4512-0ba4-08ddeee27db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GjyuQ8fg/9sVWTuRK/MXexFXoE+NwHJGlEeayTz9WCq5WpoDd51SXMv3skGL?=
 =?us-ascii?Q?KH1jjat6gtaCtehoQAxZhLgTgLuATMscotHCG0IoJheoMloPahdOK6PyZNCa?=
 =?us-ascii?Q?ssOX59niAaybkExObG5OAf0hK49CWAjhkEfcqEiZTItrVbpx6qsWXKva4jmO?=
 =?us-ascii?Q?iyu+kNYl9W+ELIGneLpYd7vC3zkZND6HmvHXDYB9sL55HS9rVSwwzmcgC1Ce?=
 =?us-ascii?Q?gmn5FJXH8kxI/H8T0XvyGkmefOpECTZimU7j9EJvngLGw3c/nBghIZPtlloD?=
 =?us-ascii?Q?ob3kFIjQos1KxCralfqkuPZKOq6Bba+SSJJihbiiiSWdDO5l3Iy9d7ncnLNb?=
 =?us-ascii?Q?6TyzmQI1Gx+6/shnTEeI7HX4oWrGrazmjbiLFbSALHihHHh1dzAyaS0NwpVd?=
 =?us-ascii?Q?eF1n2ib6Cmug9D/2tSTF9faRKd4xYZM9x9qFqmc0Mivhp43Mr4TbYSsgpmiR?=
 =?us-ascii?Q?T4E4wHIfULxBcfP6S8a/X+skvT+5lK4n03IOLt2bDoPVmvBGFG0NMKebMUu4?=
 =?us-ascii?Q?od1gDnJjU6TK3hc+Y5c4/i+kdtiamPvOs5RTj+fO/q0FpUSWN1QyzpyV69+P?=
 =?us-ascii?Q?yitC9AaZrzB9erDTS4NEK/7aSPK1/Hufy8TzKYfqxEHUFvo9fsmCk+Gg+FA4?=
 =?us-ascii?Q?sX9ARyFrZ/FG+RGqCvRhkIfZf+cnkHaaqhoOnhcA8gsCzosLNQnwGOcWqS8M?=
 =?us-ascii?Q?ORT+9l4EIyzraPqHhFtZkDAB53j6HwNFr/pRddwpxrdpmQFsJ1VFRZl4ZAmh?=
 =?us-ascii?Q?qPWwV1P1M+UxYhF2qnpeHiaAVhHiJkwI1YAniIhrbsGCrbZZBnz9obTpiNZ3?=
 =?us-ascii?Q?2YLTWBRzNPOUnZgNy/iLZxHWdQn0mgQyu0ERJK2eQ+/+cyG3utshWPCeE8S7?=
 =?us-ascii?Q?y3wxJ7ULTFiEnyVLl1CyBaIpWqkNl3HbyZ4RKDzbK4s+Rxsi9xjm+iYNVAiW?=
 =?us-ascii?Q?HI6ZkE2zRZLid3/jM29Knmd34kumNYOcoJH4NzxXiFZh3QBUtyI98KkoK7Dg?=
 =?us-ascii?Q?5At1lITJ4/KOKfUcDZ5vvKYQ4hHZveetWy5Xnojph9uMjZgWpwv8Tj7ZuHiB?=
 =?us-ascii?Q?pzCJXuwVy29Qz4W2O5Yj8DfK2SH07Cui4yeaN0BC7ZR0QA3z2hOpp+sAgRuT?=
 =?us-ascii?Q?3yphg1cQeLPk/XF8z/n6iQyfN3+xuXYJxfyvU2s+j6rft+4EN2AkcVVt0qYl?=
 =?us-ascii?Q?JLlpLBYMSY3sROWJgaQcj1UT2TpevNouCGVLQeIwJ32v3ziQhbX2JhvYFRkj?=
 =?us-ascii?Q?vxPgMbEFVkDwSkCxTxEIuyd68okMvLOcRDzHDAj9XPFrT52bUpaCYtrKZHG5?=
 =?us-ascii?Q?eR8+oZ7Ucr94jFRyxDR+oI/9zmFD9evEgUYvi1ENCR2QX3zLBZp+spgeaeH2?=
 =?us-ascii?Q?xFjokCLMS3WIERSmlRwy8bU2bgkaxMuMTuUv/ncUQlZuuGwjoCzennFZX+0L?=
 =?us-ascii?Q?eNV/mdt/Qpkb5VvRCN6pEvofE+vPYzbsndE8ImBg8/2yGp9pzvkSDCwIbY44?=
 =?us-ascii?Q?07JJAd9eDkS2RYW87zwWj7Rs/JpC56eTQskw?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 87+z8BldDMteL/zlr3uYtXcUPnb8WnvYSqYNI+fpDjusEzIf5NQgTJjRS2OphMzgICB+FjldYxHpRccAp9Zx3+5IHOxAIHADngXoHzBjKvwQvqO+k7TiLRM4pEWXiM78WjHNfdFrOMBg0ImHadFgDqvifiLsofarrOe8NU5ucR+2dLB4cInhVJ7O0zjqKovW8xa5aWRMKIERgqmKadmJN/nHGSKbmyU8BKHGRPJ4sl+gL8PwEZQk7NJjy/gkDEZWdVj0tm7366sdH7Htw3aSiStgjupVaEIErwnkIa7CQno+x1GQkqiaprJbhxM5EoO1G2vg3tNxyIVTL24uXfkaakD8WWBkKew0kftlhWvcZBRimEE+/kq6uwao37JvEm10Edl0ACfjIXpv9uRa+xlrilit+4Iu9XxTnU0ytqtNTSIGtCxwGc7gitSJZsRC8fsc+7NxN/zNQyePpfJpQqiLBU6lxjWpnDkPNgJRtRwkIlUlNjOhq5i8KhO9HwtdyKiLdywR06VlImpJDXg6mVYag2gGW471Ct1FOpsND6RLhDgk6WAaHVLpWJAJmSjJS0etGxr2wVbk/lH4E5bPCBgrIQSRmXz5RP8vpksPR2KUPF8MDqo6FY2uRDyrklCwGEUXOK+TnsyWKQfsRenLUvAJxg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:17:49.4626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402d80b0-e6b1-4512-0ba4-08ddeee27db7
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1709
X-BESS-ID: 1757341071-311744-22019-3577-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.84.122
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuamBpZAVgZQMNXYwtjY3DI5yc
 zMKNHC0MzAyNIgJdXILCU5MdnIxDxZqTYWAOjECDNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267336 [from 
 cloudscan16-49.eu-central-1b.ess.aws.cudaops.com]
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

