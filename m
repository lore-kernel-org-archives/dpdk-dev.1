Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE3CCCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:38:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70E0D40E41;
	Mon, 20 Oct 2025 18:36:53 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id B8B0140A7D
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:42 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023080.outbound.protection.outlook.com
 [40.107.162.80]) by mx-outbound9-130.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN7kUz7u/Clu2coBSHOQlqKyOi4yCEhfH/BObnywPRHCsxNgOCFzfIOjD0f6uB5D6IEclXniEtiXkoeNJSPEGpadg9UEhkvmk3QZQ2p0DV0+WdTUMpvVcR/BnQZ7JRWejdtHLrYhGDqHftgT9uLv7kG3EANXtGbIUearhZYKaIksD1z4LqQxnJEFl3EOSa+0War2nwoJuXCFPTJpkP/jBp4iaINfQzEojojrsr+IuzPPMNNphkrF0IANeBVFhGWPRrndP26dh29Tu/Bqg8SP+wo/BrWIQnU+lHmSoZfHxHEz+JOHTGXW3x69IoQmmXPXfHknuEk4Aw5OH8bmWb2SWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZonLSyb53XOFBoD3zPS7EAdfbf5DaiAO6WpvagFyL8=;
 b=aYMVuICcWnZK79Rpfj8KF0BYapO2fLy0ne106tPylAvGTXg8U8oYWax8zJJaLLWVYAN88zAeamlFMahiF0b8LW/kzcioXsaFglrGV9HxfvuCff/7bwjyuYMxOozo+cXcezgWN9fcRgp14NtO+cahrTGhzxOBW46ukVdGocw42DZ9o4P1Ix4Pma1OvyAcCqzlXw1FJcLUULKq78mqz0/8xO73tDo2urlR0HS7FqstUQUsV1FJNXbRGKZAEL0bcSHjkN8463/slKTQmze8PlzpI7AIlwKH7etuOGoy0GPIzi8aaPdY2g4v95mslQbNxtQeTeoyvmOgItugXJP7WKbG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZonLSyb53XOFBoD3zPS7EAdfbf5DaiAO6WpvagFyL8=;
 b=VP9ZJF0Z6Eez+JJtwl6qU46BH07TI0LbF02BN3e7f5UKq+eRwG114ELrPk6kxLB4HM9SuP0I80FjwXopF5xnhyHb6uXoYmP3RAAJdAvdb1hBFzZKZKPUwX46ZpticcUWpz/5ecX78HDkc4Jk/OHhqxUM9nG/91ZBaYwgUBkxJyU=
Received: from AS4P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::13)
 by AM8P190MB0961.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1de::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Mon, 20 Oct
 2025 16:36:37 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::bd) by AS4P191CA0022.outlook.office365.com
 (2603:10a6:20b:5d9::13) with Microsoft SMTP Server (version=TLS1_3,
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
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:37
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 15/24] net/ntnic: change prefix nt to prefix nthw
Date: Mon, 20 Oct 2025 18:36:06 +0200
Message-ID: <20251020163620.282312-16-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|AM8P190MB0961:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cda4fbb0-35ad-4a8a-b655-08de0ff6d715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xa7Cx/byjyAKQdHvEsD762arrCCYGUmt9GJTM6Tap4OTsRh1HdmBfvTB/At4?=
 =?us-ascii?Q?juyGGz84hv0cdIN6JoMwC96uxlUE6j2G628YIUZ2EYSOsHg7gKprcH/IB5bx?=
 =?us-ascii?Q?9bEYJCorOi1WbB/04OadG5BaFvMqRvPQqYtlw1r1BmgrP/pbLox3pT3VyQyk?=
 =?us-ascii?Q?ikZAi7T6SoYAF02cpwdJSlGM9RFo9SrPzWC6iLVA4ig8esOx4rMVidDuxV+N?=
 =?us-ascii?Q?M9vHBnKIf45ZR84xeD3oreCxzxQ02QC71KtWsGPYe8cuf9SpLsgK19vaUg3V?=
 =?us-ascii?Q?ymBcC+7sj8bF5oTZ01S0RbJRhzieW2iIbPhUyT9/KlmvEHFqZoRPoNPVK40x?=
 =?us-ascii?Q?9n1W1FYpDwKpeSupA+0MndRSKL0VwUKeT+QOLZdQzaDJaZXI3yGGcXoUa2Ng?=
 =?us-ascii?Q?3Fx7wTO1ZuJYDtnkMLQblzBWzck9A0xdYfUt1KXA0YxhP4oyFhDsRxrwxD2j?=
 =?us-ascii?Q?CZd5JUY0XWR3SElQEEjqYELpNO/ClJGcahFPMF0jKRfTRWRc8OsLuLQn1xyQ?=
 =?us-ascii?Q?tBEtxqx6bHgywLcG4/a9McAwKB9V2w+rJmAC+KrkRExMBYRpmjwgiwX7W+ay?=
 =?us-ascii?Q?VeVmdMKDYLj4Z8jW13qg1jrARjBvnFr2BSUPj9tci6g1YG5dZi5OKQm6MI3P?=
 =?us-ascii?Q?HpptdwHLYO5jSR2VaD1R3LDYBJpEMJvc9nmJ0LJuQRn4cfmrjHmPk/Ivuazv?=
 =?us-ascii?Q?lTsSOpPLImUfRd3++aZkSYlAwiF/AzORc1YUfk5fSkBvMhG7aJwOIgIc6mjq?=
 =?us-ascii?Q?pJaofiIyjGYg/5XZfxRGYRjcGOssagCs4M95Ps75BXg8UV8lzxLF/S1ltXK8?=
 =?us-ascii?Q?bYhTTn3FRNyFkXe9gm4gpxhpBfyOJ01uIVz0pOKmymVtNi0dnJD73I6L5IuK?=
 =?us-ascii?Q?kBmc4NO+eCJHATllzstMhMsIOBIpc7QeS0sODJwVL1ddaCIWig6SxAjjTTz6?=
 =?us-ascii?Q?0441Js5MuJjqr+kxzLLfPFE477knXVtx4WOIhOQY0P/zPla0/dUIIweBDcV0?=
 =?us-ascii?Q?qIq9R834e5uDZmLzrHLV29wY8tKkzoWCILeRe/ejTGtTmSd/Bo4i+Xo4k8Ur?=
 =?us-ascii?Q?VibZMqTwzCiDdVefKhWSrfJYjI66rpbbiyApeJF/c1QHzrO2ZU8QXhL8vwsa?=
 =?us-ascii?Q?HpuATZ/xwGbjw7dlcSCe0p/axNrakY2EWLhc2EDwyzI05fJsR+tIsdNQsXMK?=
 =?us-ascii?Q?5/y/D2yTwvMgsjlVGLaHREsaTexyBHm44RN8TnpkXiZivPtGU6FF16XnY1gC?=
 =?us-ascii?Q?H0WD2u63jqm5FO9gUbmJZKRW0te/W9K75kaBiOzMXWq2t376A4CthHGUugYn?=
 =?us-ascii?Q?okK8I0hjZGWhNE98ZVOhbuHi6Cnjgo4b+suCc8Q+Q+Fli3XYQN8DKU8GmTs1?=
 =?us-ascii?Q?3nVlC7eX3GFPeSe3FegKgYv1Pf+Za4hBQTnWIh2/jkVhE0xsu/waXmLMprpS?=
 =?us-ascii?Q?P7tgWjV73qsTMazsTcqgk0JTmncR6rWFQrpPbUX369lsaE2YFL2+3+vyMdvn?=
 =?us-ascii?Q?1Re1asHEEPojxCDM/Miilwxuro+60aL/WVvLYLMNIvp1BrMP9YatExsE0TS6?=
 =?us-ascii?Q?UnzGCbsn33D3o+RmDsc=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LhbSus0F+LFLnHMYFrlRITSf0tDhj29PJN6+daRmcklza/35YY65d7+ue/xZgHzp7zZsBivATSYbNAtN3rhZGM8+egeUuEay8gHRU1K4UtOCl0/cc28ZFBNbKyRCmK3Q9vV0EOI5wSzkY/3nsqG48PL0F4kd1hGk3RJ/ZcUCikkGQhqIFhEIDSTXMaQW0j1Fb4nsWv19inUTppopy78R5iNb215kTGBmYkNtwA9sy7H3aYBU9I9kCJsd5bv9B0D/UlI5yhrHLwKzkVSnicq6a3AZrt0SyLQ1I6D1fvt/Jq/nghX8VLF9jofa8yUJuUuV77tORHyiiaOZx8KDDJDpWpYH5NKDy9ZcHWZ0xFyh3a6dnNjrzN7lzMhMFbWA+RgwPeLrJXp1Hi2QwoTIbOf4QnqNe2Q6UvNp3uKXRUJn0RLMwdbNjSaOscNb2kUgl0FxgEviy0DLm89mcrzODTyn/TViXVnZ/rvI+D/0nFdOmzx15ny9h3YCbI/FLFqI+Fb2+JLWrcTv/TbQZWFWzMY0LUEexYQKw2O3y8+kWUzD+yKpfhy5SHelK7cnSu4ZdlRP7qC/Zgb/S0OFtPdkt6+nug2SpKbqu6VnyOh8wSD9i7kJetUAS2SyjxDXjM2gAXDB5TitjJZu0NPZcifKpYudh1x2SzVQ8/CElPAkCjl1ZEM=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:37.6951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda4fbb0-35ad-4a8a-b655-08de0ff6d715
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0961
X-BESS-ID: 1760978199-302434-10211-72806-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.162.80
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaWBkaWQGYGUNQsLTExyTw1Jc
 nMPNEyOdUYyExNsjC1TExMTbEwM7FUqo0FADnGYk9CAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan18-209.eu-central-1b.ess.aws.cudaops.com]
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

change prefix nt_ to prefix nthw_ to specify that this is related to
Napatech hardware.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |  2 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  2 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     | 12 ++---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 16 +++----
 drivers/net/ntnic/nim/i2c_nim.c               |  4 +-
 .../nt200a0x/reset/nthw_fpga_rst_nt200a0x.c   |  2 +-
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   | 18 ++++----
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   | 32 ++++++-------
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |  2 +-
 drivers/net/ntnic/nthw/core/nthw_i2cm.c       |  4 +-
 drivers/net/ntnic/nthw/core/nthw_igam.c       |  4 +-
 drivers/net/ntnic/nthw/core/nthw_iic.c        |  2 +-
 drivers/net/ntnic/nthw/core/nthw_mac_pcs.c    |  6 +--
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   | 46 +++++++++----------
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |  2 +-
 drivers/net/ntnic/nthw/core/nthw_si5340.c     |  4 +-
 drivers/net/ntnic/nthw/core/nthw_spi_v3.c     | 12 ++---
 .../profile_inline/flow_api_profile_inline.c  | 18 ++++----
 .../net/ntnic/nthw/model/nthw_fpga_model.c    |  2 +-
 drivers/net/ntnic/nthw/nthw_rac.c             |  8 ++--
 drivers/net/ntnic/ntnic_ethdev.c              | 42 +++++++++--------
 drivers/net/ntnic/ntnic_vfio.c                | 16 +++----
 drivers/net/ntnic/ntnic_vfio.h                | 10 ++--
 drivers/net/ntnic/ntutil/nt_util.c            | 22 ++++-----
 drivers/net/ntnic/ntutil/nt_util.h            | 18 ++++----
 25 files changed, 154 insertions(+), 152 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index ff83ba69f7..9d0d77dcc8 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -128,7 +128,7 @@ static int nt4ga_stat_setup(struct adapter_info_s *p_adapter_info)
 		int numa_node = p_adapter_info->fpga_info.numa_node;
 
 		/* FPGA needs a 16K alignment on Statistics */
-		p_dma = nt_dma_alloc(n_stat_size, 0x4000, numa_node);
+		p_dma = nthw_dma_alloc(n_stat_size, 0x4000, numa_node);
 
 		if (!p_dma) {
 			NT_LOG_DBGX(ERR, NTNIC, "p_dma alloc failed");
diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 107fe91394..7b2e2e53fc 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -485,7 +485,7 @@ static int dbs_wait_hw_queue_shutdown(struct nthw_virt_queue *vq, int rx)
 
 	if (err) {
 		if (err == -ENOTSUP) {
-			nt_os_wait_usec(200000);
+			nthw_os_wait_usec(200000);
 			return 0;
 		}
 
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index 21e95d84bd..2c7a88aed9 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -50,9 +50,9 @@ static int _reset_rx(adapter_info_t *drv, nthw_mac_pcs_t *mac_pcs)
 	(void)drv;
 
 	nthw_mac_pcs_rx_path_rst(mac_pcs, true);
-	nt_os_wait_usec(10000);	/* 10ms */
+	nthw_os_wait_usec(10000);	/* 10ms */
 	nthw_mac_pcs_rx_path_rst(mac_pcs, false);
-	nt_os_wait_usec(10000);	/* 10ms */
+	nthw_os_wait_usec(10000);	/* 10ms */
 
 	return 0;
 }
@@ -110,7 +110,7 @@ static void _set_loopback(struct adapter_info_s *p_adapter_info,
 	/* After changing the loopback the system must be properly reset */
 	_reset_rx(p_adapter_info, mac_pcs);
 
-	nt_os_wait_usec(10000);	/* 10ms - arbitrary choice */
+	nthw_os_wait_usec(10000);	/* 10ms - arbitrary choice */
 
 	if (!nthw_mac_pcs_is_rx_path_rst(mac_pcs)) {
 		nthw_mac_pcs_reset_bip_counters(mac_pcs);
@@ -286,14 +286,14 @@ static int _create_nim(adapter_info_t *drv, int port, bool enable)
 	 */
 	NT_LOG(DBG, NTNIC, "%s: Performing NIM reset", drv->mp_port_id_str[port]);
 	nthw_gpio_phy_set_reset(gpio_phy, (uint8_t)port, true);
-	nt_os_wait_usec(100000);/* pause 0.1s */
+	nthw_os_wait_usec(100000);/* pause 0.1s */
 	nthw_gpio_phy_set_reset(gpio_phy, (uint8_t)port, false);
 
 	/*
 	 * Wait a little after a module has been inserted before trying to access I2C
 	 * data, otherwise the module will not respond correctly.
 	 */
-	nt_os_wait_usec(1000000);	/* pause 1.0s */
+	nthw_os_wait_usec(1000000);	/* pause 1.0s */
 
 	if (!_nim_is_present(gpio_phy, (uint8_t)port)) {
 		NT_LOG(DBG, NTNIC, "%s: NIM module is no longer absent!",
@@ -650,7 +650,7 @@ static int _common_ptp_nim_state_machine(void *data)
 	}	/* end-for */
 
 	if (rte_service_runstate_get(adapter_mon_srv->id))
-		nt_os_wait_usec(5 * 100000U);	/* 5 x 0.1s = 0.5s */
+		nthw_os_wait_usec(5 * 100000U);	/* 5 x 0.1s = 0.5s */
 
 	return 0;
 }
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index c8b7912e26..b700a9e76e 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -93,17 +93,17 @@ static void phy_tx_path_rst(adapter_info_t *drv, int port, bool reset)
 static void phy_reset_rx(adapter_info_t *drv, int port)
 {
 	phy_rx_path_rst(drv, port, true);
-	nt_os_wait_usec(10000);	/* 10ms */
+	nthw_os_wait_usec(10000);	/* 10ms */
 	phy_rx_path_rst(drv, port, false);
-	nt_os_wait_usec(10000);	/* 10ms */
+	nthw_os_wait_usec(10000);	/* 10ms */
 }
 
 static void phy_reset_tx(adapter_info_t *drv, int port)
 {
 	phy_tx_path_rst(drv, port, true);
-	nt_os_wait_usec(10000);	/* 10ms */
+	nthw_os_wait_usec(10000);	/* 10ms */
 	phy_tx_path_rst(drv, port, false);
-	nt_os_wait_usec(10000);	/* 10ms */
+	nthw_os_wait_usec(10000);	/* 10ms */
 }
 
 static int phy_set_host_loopback(adapter_info_t *drv, int port, loopback_host_t loopback)
@@ -499,7 +499,7 @@ set_loopback(struct adapter_info_s *p_adapter_info, int port, uint32_t mode, uin
 	/* After changing the loopback the system must be properly reset */
 	phy_reset_rx(p_adapter_info, port);
 	phy_reset_tx(p_adapter_info, port);
-	nt_os_wait_usec(10000);	/* 10ms - arbitrary choice */
+	nthw_os_wait_usec(10000);	/* 10ms - arbitrary choice */
 }
 
 static void port_disable(adapter_info_t *drv, int port)
@@ -547,14 +547,14 @@ static int create_nim(adapter_info_t *drv, int port, bool enable)
 
 	NT_LOG(DBG, NTNIC, "%s: Performing NIM reset", drv->mp_port_id_str[port]);
 	nim_set_reset(nim_ctx, (uint8_t)port, true);
-	nt_os_wait_usec(100000);/*  pause 0.1s */
+	nthw_os_wait_usec(100000);/*  pause 0.1s */
 	nim_set_reset(nim_ctx, (uint8_t)port, false);
 
 	/*
 	 * Wait a little after a module has been inserted before trying to access I2C
 	 * data, otherwise the module will not respond correctly.
 	 */
-	nt_os_wait_usec(1000000);	/* pause 1.0s */
+	nthw_os_wait_usec(1000000);	/* pause 1.0s */
 
 	res = nthw_construct_and_preinit_nim(nim_ctx, NULL);
 
@@ -941,7 +941,7 @@ static int _common_ptp_nim_state_machine(void *data)
 	}
 
 	if (rte_service_runstate_get(adapter_mon_srv->id))
-		nt_os_wait_usec(5 * 100000U);	/*  5 x 0.1s = 0.5s */
+		nthw_os_wait_usec(5 * 100000U);	/*  5 x 0.1s = 0.5s */
 
 	return 0;
 }
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 4fd882b8c9..a394b4c5d4 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -704,7 +704,7 @@ static void qsfp28_wait_for_ready_after_reset(nim_i2c_ctx_p ctx)
 	 * Probably because access to the paged address space is required.
 	 */
 	if (!init_complete_flag_present) {
-		nt_os_wait_usec(500000);
+		nthw_os_wait_usec(500000);
 		return;
 	}
 
@@ -724,7 +724,7 @@ static void qsfp28_wait_for_ready_after_reset(nim_i2c_ctx_p ctx)
 			break;
 		}
 
-		nt_os_wait_usec(100000);/* 100 ms */
+		nthw_os_wait_usec(100000);/* 100 ms */
 		count++;
 	}
 }
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
index cc6f7d13b5..34527b0cca 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
@@ -197,7 +197,7 @@ static int nthw_fpga_rst_nt200a0x_wait_sdc_calibrated(nthw_fpga_t *p_fpga,
 		 * reset DDR and perform calibration retry
 		 */
 		nthw_field_set_flush(p->mp_fld_rst_ddr4);	/* Reset DDR PLL */
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 		nthw_field_clr_flush(p->mp_fld_rst_ddr4);
 
 		n_retry_cnt++;
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index 8cad9fac5a..28769e3aa5 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -150,7 +150,7 @@ static int nthw_fpga_rst9574_wait_ddr4_calibration_complete(struct fpga_info_s *
 		complete = nthw_fpga_rst9574_get_ddr4_calib_complete_stat(p_rst);
 
 		if (!complete)
-			nt_os_wait_usec(100);
+			nthw_os_wait_usec(100);
 
 		timeout--;
 
@@ -187,7 +187,7 @@ static int nthw_fpga_rst9574_wait_phy_ftile_rdy(struct fpga_info_s *p_fpga_info,
 		complete = nthw_fpga_rst9574_get_phy_ftile_rdy_stat(p_rst);
 
 		if (!complete) {
-			nt_os_wait_usec(100);
+			nthw_os_wait_usec(100);
 
 		} else {
 			NT_LOG(DBG, NTHW, "%s: PHY FTILE ready, margin to timeout %u",
@@ -221,7 +221,7 @@ static int nthw_fpga_rst9574_wait_phy_ftile_rst_done(struct fpga_info_s *p_fpga_
 		complete = nthw_fpga_rst9574_get_phy_ftile_rst_done_stat(p_rst);
 
 		if (!complete)
-			nt_os_wait_usec(100);
+			nthw_os_wait_usec(100);
 
 		timeout--;
 
@@ -251,7 +251,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	/*
 	 * Wait a while before waiting for deasserting ddr4 reset
 	 */
-	nt_os_wait_usec(2000);
+	nthw_os_wait_usec(2000);
 
 	/* (1) De-RTE_ASSERT DDR4 reset: */
 	NT_LOG(DBG, NTHW, "%s: %s: De-asserting DDR4 reset", p_adapter_id_str, __func__);
@@ -261,7 +261,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	 * Wait a while before waiting for calibration complete, since calibration complete
 	 * is true while ddr4 is in reset
 	 */
-	nt_os_wait_usec(2000);
+	nthw_os_wait_usec(2000);
 
 	/* (2) Wait until DDR4 calibration complete */
 	res = nthw_fpga_rst9574_wait_ddr4_calibration_complete(p_fpga_info, p_rst);
@@ -273,7 +273,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	nthw_fpga_rst9574_set_ddr4_calib_complete_latch(p_rst, 1);
 
 	/* Wait for phy to settle.*/
-	nt_os_wait_usec(20000);
+	nthw_os_wait_usec(20000);
 
 	/* (4) Ensure all latched status bits are still set: */
 	if (!nthw_fpga_rst9574_get_ddr4_calib_complete_latch(p_rst)) {
@@ -301,7 +301,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 			__func__);
 		nthw_fpga_rst9574_phy_ftile_rst(p_rst, 0);
 
-		nt_os_wait_usec(10000);
+		nthw_os_wait_usec(10000);
 		/* (7) Wait until PHY_FTILE ready */
 		if (nthw_fpga_rst9574_wait_phy_ftile_rdy(p_fpga_info, p_rst) != -1) {
 			success = true;
@@ -331,7 +331,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 				int32_t count = 1000;
 
 				do {
-					nt_os_wait_usec(1000);
+					nthw_os_wait_usec(1000);
 				} while (!nthw_phy_tile_get_port_status_reset_ack(p_phy_tile, i) &&
 					(--count > 0));
 
@@ -343,7 +343,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 
 				/* Active low */
 				nthw_phy_tile_set_port_config_rst(p_phy_tile, i, 1);
-				nt_os_wait_usec(20000);
+				nthw_os_wait_usec(20000);
 			}
 		}
 
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index d9c4281eeb..d158135c17 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -58,13 +58,13 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 	/* (b1) Reset platform. It is released later */
 	nthw_prm_nt400dxx_platform_rst(p_fpga_info->mp_nthw_agx.p_prm, 1);
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 
 	/* (C) Reset peripherals and release the reset */
 	nthw_prm_nt400dxx_periph_rst(p_fpga_info->mp_nthw_agx.p_prm, 1);
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 	nthw_prm_nt400dxx_periph_rst(p_fpga_info->mp_nthw_agx.p_prm, 0);
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 
 	res = nthw_fpga_avr_probe(p_fpga, 0);
 
@@ -155,7 +155,7 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 	/* Enable power supply to NIMs */
 	nthw_pcal6416a_write(p_fpga_info->mp_nthw_agx.p_io_nim, 8, 1);
-	nt_os_wait_usec(100000);/* 100ms */
+	nthw_os_wait_usec(100000);/* 100ms */
 
 	/* Check that power supply turned on. Warn if it didn't. */
 	uint8_t port_power_ok;
@@ -225,7 +225,7 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 
 			/* (F) Check that the system PLL is ready. */
 			for (int i = 1000; i >= 0; i--) {
-				nt_os_wait_usec(1000);
+				nthw_os_wait_usec(1000);
 				data = nthw_igam_read(p_igam, 0xffff4);
 
 				if (data == 0x80000000 || data == 0xA0000000) {
@@ -251,7 +251,7 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 			nthw_igam_set_ctrl_forward_rst(p_igam,
 				0);	/* Ensure that the Avalon bus is not */
 			/* reset at every driver re-load. */
-			nt_os_wait_usec(1000000);
+			nthw_os_wait_usec(1000000);
 			NT_LOG(DBG, NTHW, "%s: IGAM module not used.", p_adapter_id_str);
 		}
 
@@ -267,14 +267,14 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 
 	if (p_fpga_info->mp_nthw_agx.tcxo_present && p_fpga_info->mp_nthw_agx.tcxo_capable) {
 		nthw_pcm_nt400dxx_set_ts_pll_recal(p_pcm, 1);
-		nt_os_wait_usec(1000);
+		nthw_os_wait_usec(1000);
 		nthw_pcm_nt400dxx_set_ts_pll_recal(p_pcm, 0);
-		nt_os_wait_usec(1000);
+		nthw_os_wait_usec(1000);
 	}
 
 	/* (I) Wait for TS PLL locked. */
 	for (int i = 1000; i >= 0; i--) {
-		nt_os_wait_usec(1000);
+		nthw_os_wait_usec(1000);
 
 		if (nthw_pcm_nt400dxx_get_ts_pll_locked_stat(p_pcm))
 			break;
@@ -320,9 +320,9 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 	if (res == 0)
 		NT_LOG(DBG, NTHW, "%s: Hif module found", p_fpga_info->mp_adapter_id_str);
 
-	nt_os_wait_usec(1000);
+	nthw_os_wait_usec(1000);
 	nthw_hif_force_soft_reset(p_nthw_hif);
-	nt_os_wait_usec(1000);
+	nthw_os_wait_usec(1000);
 	nthw_hif_delete(p_nthw_hif);
 
 	/* (L) De-RTE_ASSERT platform reset. */
@@ -354,7 +354,7 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 
 		/* (F) Check that the system PLL is ready. */
 		for (int i = 1000; i >= 0; i--) {
-			nt_os_wait_usec(1000);
+			nthw_os_wait_usec(1000);
 
 			if (nthw_phy_tile_get_sys_pll_get_rdy(p_phy_tile) &&
 				nthw_phy_tile_get_sys_pll_system_pll_lock(p_phy_tile)) {
@@ -363,7 +363,7 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 
 			if (i == 500) {
 				nthw_phy_tile_set_sys_pll_force_rst(p_phy_tile, 1);
-				nt_os_wait_usec(1000);
+				nthw_os_wait_usec(1000);
 				nthw_phy_tile_set_sys_pll_force_rst(p_phy_tile, 0);
 				NT_LOG_DBGX(DBG,
 					NTHW,
@@ -380,13 +380,13 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 			}
 		}
 
-		nt_os_wait_usec(100000);/* 100 ms */
+		nthw_os_wait_usec(100000);/* 100 ms */
 
 		uint32_t fgt_enable = 0x0d;	/* FGT 0, 2 & 3 */
 		nthw_phy_tile_set_sys_pll_en_ref_clk_fgt(p_phy_tile, fgt_enable);
 
 		for (int i = 1000; i >= 0; i--) {
-			nt_os_wait_usec(1000);
+			nthw_os_wait_usec(1000);
 
 			if (nthw_phy_tile_get_sys_pll_ref_clk_fgt_enabled(p_phy_tile) ==
 				fgt_enable) {
@@ -395,7 +395,7 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 
 			if (i == 500) {
 				nthw_phy_tile_set_sys_pll_force_rst(p_phy_tile, 1);
-				nt_os_wait_usec(1000);
+				nthw_os_wait_usec(1000);
 				nthw_phy_tile_set_sys_pll_force_rst(p_phy_tile, 0);
 				NT_LOG_DBGX(DBG,
 					NTHW,
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index f9e8f90e8a..f9ae466383 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -537,7 +537,7 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 			NT_LOG(DBG, NTHW, "%s: TSM time: %016" PRIX64 " %016" PRIX64 "\n",
 				p_adapter_id_str, n_time, n_ts);
 
-			nt_os_wait_usec(1000);
+			nthw_os_wait_usec(1000);
 		}
 	}
 #endif
diff --git a/drivers/net/ntnic/nthw/core/nthw_i2cm.c b/drivers/net/ntnic/nthw/core/nthw_i2cm.c
index 353fb3f82a..1b98fa4ca3 100644
--- a/drivers/net/ntnic/nthw/core/nthw_i2cm.c
+++ b/drivers/net/ntnic/nthw/core/nthw_i2cm.c
@@ -102,7 +102,7 @@ int nthw_i2cm_init(nthw_i2cm_t *p, nthw_fpga_t *p_fpga, int n_i2c_instance)
 		NT_I2C_CMD_STOP | NT_I2C_CMD_NACK);
 
 	NT_LOG(INF, NTHW, "%s: %s  init done", p_adapter_id_str, __PRETTY_FUNCTION__);
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 
 	/* Initialize mutex */
 	rte_spinlock_init(&p->i2cmmutex);
@@ -118,7 +118,7 @@ static bool nthw_i2cm_ready(nthw_i2cm_t *p, bool wait_for_ack)
 		uint32_t status = nthw_field_get_updated(p->mp_fld_cmd_status_cmd_status);
 		uint32_t ready = (status & flags) == 0U;
 		/* MUST have a short break to avoid time-outs, even if ready == true */
-		nt_os_wait_usec(SLEEP_USECS);
+		nthw_os_wait_usec(SLEEP_USECS);
 
 		if (ready)
 			return true;
diff --git a/drivers/net/ntnic/nthw/core/nthw_igam.c b/drivers/net/ntnic/nthw/core/nthw_igam.c
index 385282298a..4a672daeb3 100644
--- a/drivers/net/ntnic/nthw/core/nthw_igam.c
+++ b/drivers/net/ntnic/nthw/core/nthw_igam.c
@@ -68,7 +68,7 @@ uint32_t nthw_igam_read(nthw_igam_t *p, uint32_t address)
 	nthw_field_set_val_flush32(p->mp_fld_base_ptr, address);
 
 	while (nthw_field_get_updated(p->mp_fld_base_busy) == 1)
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 
 	return nthw_field_get_updated(p->mp_fld_data_data);
 }
@@ -81,7 +81,7 @@ void nthw_igam_write(nthw_igam_t *p, uint32_t address, uint32_t data)
 	nthw_field_set_val_flush32(p->mp_fld_base_cmd, 1);
 
 	while (nthw_field_get_updated(p->mp_fld_base_busy) == 1)
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 }
 
 void nthw_igam_set_ctrl_forward_rst(nthw_igam_t *p, uint32_t value)
diff --git a/drivers/net/ntnic/nthw/core/nthw_iic.c b/drivers/net/ntnic/nthw/core/nthw_iic.c
index 7a2247e371..17b7c1a079 100644
--- a/drivers/net/ntnic/nthw/core/nthw_iic.c
+++ b/drivers/net/ntnic/nthw/core/nthw_iic.c
@@ -14,7 +14,7 @@
 #define I2C_TRANSMIT_WR (0x00)
 #define I2C_TRANSMIT_RD (0x01)
 
-#define I2C_WAIT_US(x) nt_os_wait_usec(x)
+#define I2C_WAIT_US(x) nthw_os_wait_usec(x)
 
 /*
  * Minimum timing values for I2C for a Marvel 88E11111 Phy.
diff --git a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
index 4a7b7b9549..b6c1a9a702 100644
--- a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
+++ b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
@@ -588,11 +588,11 @@ void nthw_mac_pcs_set_fec(nthw_mac_pcs_t *p, bool enable)
 	/* Both Rx and Tx must be reset for new FEC state to become active */
 	nthw_mac_pcs_rx_path_rst(p, true);
 	nthw_mac_pcs_tx_path_rst(p, true);
-	nt_os_wait_usec(10000);	/* 10ms */
+	nthw_os_wait_usec(10000);	/* 10ms */
 
 	nthw_mac_pcs_rx_path_rst(p, false);
 	nthw_mac_pcs_tx_path_rst(p, false);
-	nt_os_wait_usec(10000);	/* 10ms */
+	nthw_os_wait_usec(10000);	/* 10ms */
 }
 
 bool nthw_mac_pcs_get_fec_bypass(nthw_mac_pcs_t *p)
@@ -740,7 +740,7 @@ void nthw_mac_pcs_set_receiver_equalization_mode(nthw_mac_pcs_t *p, uint8_t mode
 	nthw_field_set_val32(p->mp_field_gty_ctl_rx_equa_rst2, 1);
 	nthw_field_set_val_flush32(p->mp_field_gty_ctl_rx_equa_rst3, 1);
 
-	nt_os_wait_usec(1000);	/* 1ms */
+	nthw_os_wait_usec(1000);	/* 1ms */
 
 	nthw_field_set_val32(p->mp_field_gty_ctl_rx_equa_rst0, 0);
 	nthw_field_set_val32(p->mp_field_gty_ctl_rx_equa_rst1, 0);
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index 5e8055f0e3..8a7236d94f 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -683,7 +683,7 @@ void nthw_phy_tile_set_rx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset)
 			int32_t count = 1000;
 
 			do {
-				nt_os_wait_usec(1000);	/* 1ms */
+				nthw_os_wait_usec(1000);	/* 1ms */
 			} while (nthw_field_get_updated(p->mp_fld_port_status_rx_reset_ackn
 				[intf_no]) && (--count > 0));
 
@@ -711,7 +711,7 @@ void nthw_phy_tile_set_tx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset)
 			int32_t count = 1000;
 
 			do {
-				nt_os_wait_usec(1000);	/* 1ms */
+				nthw_os_wait_usec(1000);	/* 1ms */
 			} while (nthw_field_get_updated(p->mp_fld_port_status_tx_reset_ackn
 				[intf_no]) && (--count > 0));
 
@@ -734,7 +734,7 @@ uint32_t nthw_phy_tile_read_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t la
 	nthw_field_set_val_flush32(p->mp_fld_port_xcvr_base_ptr[intf_no][lane], address);
 
 	while (nthw_field_get_updated(p->mp_fld_port_xcvr_base_busy[intf_no][lane]) == 1)
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 
 	return nthw_field_get_updated(p->mp_fld_port_xcvr_data_data[intf_no][lane]);
 }
@@ -749,7 +749,7 @@ void nthw_phy_tile_write_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 
 	while (nthw_field_get_updated(p->mp_fld_port_xcvr_base_busy[intf_no][lane]) == 1)
 		/* NT_LOG(INF, NTHW, "busy"); */
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 }
 
 static uint32_t nthw_phy_tile_read_dyn_reconfig(nthw_phy_tile_t *p, uint32_t address)
@@ -759,7 +759,7 @@ static uint32_t nthw_phy_tile_read_dyn_reconfig(nthw_phy_tile_t *p, uint32_t add
 	nthw_field_set_val_flush32(p->mp_fld_dyn_reconfig_base_ptr, address);
 
 	while (nthw_field_get_updated(p->mp_fld_dyn_reconfig_base_busy) == 1)
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 
 	uint32_t value = nthw_field_get_updated(p->mp_fld_dyn_reconfig_data_data);
 	/*
@@ -781,7 +781,7 @@ static void nthw_phy_tile_write_dyn_reconfig(nthw_phy_tile_t *p, uint32_t addres
 
 	while (nthw_field_get_updated(p->mp_fld_dyn_reconfig_base_busy) == 1)
 		/* NT_LOG(INF, NTHW, "busy"); */
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 }
 
 static uint32_t nthw_phy_tile_cpi_request(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
@@ -803,7 +803,7 @@ static uint32_t nthw_phy_tile_cpi_request(nthw_phy_tile_t *p, uint8_t intf_no, u
 
 	nthw_phy_tile_write_xcvr(p, intf_no, lane, link_addr + lane_offset, cpi_cmd);
 
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 
 	for (int i = 20; i >= 0; i--) {
 		data = nthw_phy_tile_read_xcvr(p, intf_no, lane, phy_addr + lane_offset);
@@ -815,7 +815,7 @@ static uint32_t nthw_phy_tile_cpi_request(nthw_phy_tile_t *p, uint8_t intf_no, u
 		if (((value & bit_cpi_assert) == cpi_assert) && ((value & cpi_in_reset) == 0))
 			break;
 
-		nt_os_wait_usec(10000);
+		nthw_os_wait_usec(10000);
 
 		if (i == 0)
 			NT_LOG(ERR, NTHW, "Time out");
@@ -961,7 +961,7 @@ static uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint
 	nthw_field_set_val_flush32(p->mp_fld_port_eth_base_ptr[intf_no], address);
 
 	while (nthw_field_get_updated(p->mp_fld_port_eth_base_busy[intf_no]) == 1)
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 
 	return nthw_field_get_updated(p->mp_fld_port_eth_data_data[intf_no]);
 }
@@ -976,7 +976,7 @@ static void nthw_phy_tile_write_eth(nthw_phy_tile_t *p, uint8_t intf_no,
 
 	while (nthw_field_get_updated(p->mp_fld_port_eth_base_busy[intf_no]) == 1)
 		/* NT_LOG(INF, NTHW, "busy"); */
-		nt_os_wait_usec(100);
+		nthw_os_wait_usec(100);
 }
 
 bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enable)
@@ -1047,7 +1047,7 @@ bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enabl
 		nthw_phy_tile_write_eth(p, intf_no, eth_soft_csr2,
 			(0 << 9) + (0 << 6) + (0 << 3) + (final_fec_profile << 0));
 
-		nt_os_wait_usec(10000);
+		nthw_os_wait_usec(10000);
 		nthw_phy_tile_set_reset(p, intf_no, false);
 		nthw_phy_tile_set_tx_reset(p, intf_no, false);
 
@@ -1074,7 +1074,7 @@ bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enabl
 	NT_LOG(DBG, NTHW, "intf_no %u: Step 1 Wait for DR NIOS", intf_no);
 
 	while ((nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_trigger_reg) & 0x02) != 0x02)
-		nt_os_wait_usec(10000);
+		nthw_os_wait_usec(10000);
 
 	/* Step 2: Triggering Reconfiguration */
 	NT_LOG(DBG, NTHW, "intf_no %u: Step 2: Triggering Reconfiguration", intf_no);
@@ -1082,12 +1082,12 @@ bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enabl
 	nthw_phy_tile_set_reset(p, intf_no, true);
 	nthw_phy_tile_set_rx_reset(p, intf_no, true);
 	nthw_phy_tile_set_tx_reset(p, intf_no, true);
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 
 	/* Disable original profile */
 	nthw_phy_tile_write_dyn_reconfig(p, dyn_rcfg_dr_next_profile_0_reg,
 		(1U << 18) + (0U << 15) + original_dr_profile_id);
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 	NT_LOG(DBG, NTHW, "intf_no %u: dyn_rcfg_dr_next_profile_0_reg: %#010x", intf_no,
 		nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_next_profile_0_reg));
 
@@ -1098,7 +1098,7 @@ bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enabl
 	 * Enable profile 2 and terminate dyn reconfig by
 	 * setting next profile to 0 and deactivate it
 	 */
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 	NT_LOG(DBG, NTHW, "intf_no %u: dyn_rcfg_dr_next_profile_1_reg: %#010x", intf_no,
 		nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_next_profile_1_reg));
 
@@ -1110,38 +1110,38 @@ bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enabl
 	nthw_phy_tile_write_dyn_reconfig(p, dyn_rcfg_dr_next_profile_2_reg,
 		(0U << 15) + neutral_dr_profile + (0U << 31) +
 		(neutral_dr_profile << 16));
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 	NT_LOG(DBG, NTHW, "intf_no %u: dyn_rcfg_dr_next_profile_2_reg: %#010x", intf_no,
 		nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_next_profile_2_reg));
 
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 
 	/* Step 3: Trigger DR interrupt */
 	NT_LOG(DBG, NTHW, "intf_no %u: Step 3: Trigger DR interrupt", intf_no);
 	nthw_phy_tile_write_dyn_reconfig(p, dyn_rcfg_dr_trigger_reg, 0x00000001);
 
-	nt_os_wait_usec(1000000);
+	nthw_os_wait_usec(1000000);
 
 	/* Step 4: Wait for interrupt Acknowledge */
 	NT_LOG(DBG, NTHW, "intf_no %u: Step 4: Wait for interrupt Acknowledge", intf_no);
 
 	while ((nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_trigger_reg) & 0x01) != 0x00)
-		nt_os_wait_usec(10000);
+		nthw_os_wait_usec(10000);
 
-	nt_os_wait_usec(10000);
+	nthw_os_wait_usec(10000);
 
 	/* Step 5: Wait Until DR config is done */
 	NT_LOG(DBG, NTHW, "intf_no %u: Step 5: Wait Until DR config is done", intf_no);
 
 	while ((nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_trigger_reg) & 0x02) != 0x02)
-		nt_os_wait_usec(10000);
+		nthw_os_wait_usec(10000);
 
-	nt_os_wait_usec(1000000);
+	nthw_os_wait_usec(1000000);
 
 	/* Write Fec status to scratch register */
 	nthw_phy_tile_write_fec_enabled_by_scratch(p, intf_no, enable);
 
-	nt_os_wait_usec(1000000);
+	nthw_os_wait_usec(1000000);
 
 	nthw_phy_tile_set_reset(p, intf_no, false);
 	nthw_phy_tile_set_tx_reset(p, intf_no, false);
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
index 537d58afb7..22c2c74a4d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
@@ -42,7 +42,7 @@ int nthw_pca9849_set_channel(nthw_pca9849_t *p, uint8_t channel)
 			return res;
 
 		p->m_current_channel = channel;
-		nt_os_wait_usec(10000);
+		nthw_os_wait_usec(10000);
 	}
 
 	return 0;
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5340.c b/drivers/net/ntnic/nthw/core/nthw_si5340.c
index 27f8653c9b..02674c06f2 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5340.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5340.c
@@ -121,7 +121,7 @@ static int nthw_si5340_cfg(nthw_si5340_t *p, const void *p_data, int data_cnt,
 
 		if (addr == 0x0006) {
 			/* Wait 300ms before continuing. See NT200E3-2-PTP_U23_Si5340_adr0_v2.h */
-			nt_os_wait_usec(300000);
+			nthw_os_wait_usec(300000);
 		}
 
 		nthw_si5340_write(p, addr, value);
@@ -167,7 +167,7 @@ static int nthw_si5340_config(nthw_si5340_t *p, const void *p_data, int data_cnt
 			break;
 		}
 
-		nt_os_wait_usec(1000000);	/* 1 sec */
+		nthw_os_wait_usec(1000000);	/* 1 sec */
 	}
 
 	if (!success) {
diff --git a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
index a995b1fb6e..afa037756e 100644
--- a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
@@ -39,10 +39,10 @@ static int wait_for_tx_data_sent(nthw_spim_t *p_spim_mod, uint64_t time_out)
 	bool empty;
 	uint64_t start_time;
 	uint64_t cur_time;
-	start_time = nt_os_get_time_monotonic_counter();
+	start_time = nthw_os_get_time_monotonic_counter();
 
 	while (true) {
-		nt_os_wait_usec(1000);	/* Every 1ms */
+		nthw_os_wait_usec(1000);	/* Every 1ms */
 
 		result = nthw_spim_get_tx_fifo_empty(p_spim_mod, &empty);
 
@@ -54,7 +54,7 @@ static int wait_for_tx_data_sent(nthw_spim_t *p_spim_mod, uint64_t time_out)
 		if (empty)
 			break;
 
-		cur_time = nt_os_get_time_monotonic_counter();
+		cur_time = nthw_os_get_time_monotonic_counter();
 
 		if ((cur_time - start_time) > time_out) {
 			NT_LOG(WRN, NTHW, "%s: Timed out", __func__);
@@ -74,11 +74,11 @@ static int wait_for_rx_data_ready(nthw_spis_t *p_spis_mod, uint64_t time_out)
 	bool empty;
 	uint64_t start_time;
 	uint64_t cur_time;
-	start_time = nt_os_get_time_monotonic_counter();
+	start_time = nthw_os_get_time_monotonic_counter();
 
 	/* Wait for data to become ready in the Rx FIFO */
 	while (true) {
-		nt_os_wait_usec(10000);	/* Every 10ms */
+		nthw_os_wait_usec(10000);	/* Every 10ms */
 
 		result = nthw_spis_get_rx_fifo_empty(p_spis_mod, &empty);
 
@@ -90,7 +90,7 @@ static int wait_for_rx_data_ready(nthw_spis_t *p_spis_mod, uint64_t time_out)
 		if (!empty)
 			break;
 
-		cur_time = nt_os_get_time_monotonic_counter();
+		cur_time = nthw_os_get_time_monotonic_counter();
 
 		if ((cur_time - start_time) > time_out) {
 			NT_LOG(WRN, NTHW, "%s: Timed out", __func__);
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 1a78933b7f..6fc496e16a 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -197,7 +197,7 @@ static int flow_mtr_create_meter(struct flow_eth_dev *dev,
 			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
-		nt_os_wait_usec(1);
+		nthw_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
 				nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
@@ -255,7 +255,7 @@ static int flow_mtr_probe_meter(struct flow_eth_dev *dev, uint8_t caller_id, uin
 			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
-		nt_os_wait_usec(1);
+		nthw_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
 				nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
@@ -295,7 +295,7 @@ static int flow_mtr_destroy_meter(struct flow_eth_dev *dev, uint8_t caller_id, u
 			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
-		nt_os_wait_usec(1);
+		nthw_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
 				nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
@@ -348,7 +348,7 @@ static int flm_mtr_adjust_stats(struct flow_eth_dev *dev, uint8_t caller_id, uin
 			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
-		nt_os_wait_usec(1);
+		nthw_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
 				nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
@@ -644,7 +644,7 @@ static int flm_sdram_calibrate(struct flow_nic_dev *ndev)
 		if (fail_value != 0)
 			break;
 
-		nt_os_wait_usec(1);
+		nthw_os_wait_usec(1);
 	}
 
 	if (!success) {
@@ -685,7 +685,7 @@ static int flm_sdram_reset(struct flow_nic_dev *ndev, int enable)
 			break;
 		}
 
-		nt_os_wait_usec(1);
+		nthw_os_wait_usec(1);
 	}
 
 	if (!success) {
@@ -709,7 +709,7 @@ static int flm_sdram_reset(struct flow_nic_dev *ndev, int enable)
 			break;
 		}
 
-		nt_os_wait_usec(1);
+		nthw_os_wait_usec(1);
 	}
 
 	if (!success) {
@@ -976,7 +976,7 @@ static int flm_flow_programming(struct flow_handle *fh, uint32_t flm_op)
 			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
-		nt_os_wait_usec(1);
+		nthw_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
 			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
@@ -5274,7 +5274,7 @@ struct flow_handle *nthw_flow_async_create_profile_inline(struct flow_eth_dev *d
 
 		} else {
 			do {
-				nt_os_wait_usec(1);
+				nthw_os_wait_usec(1);
 				status = atomic_load(&pattern_action_pair->status);
 			} while (status == CELL_STATUS_INITIALIZING);
 
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 9e269eb69f..b9d03b4982 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -1060,7 +1060,7 @@ static int nthw_field_wait_cond32(const nthw_field_t *p, enum nthw_field_match e
 		if (n_poll_iterations <= 0)
 			return -1;
 
-		nt_os_wait_usec(n_poll_interval);
+		nthw_os_wait_usec(n_poll_interval);
 	}
 
 	return 0;
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index 33e0caa581..4845c2b0c9 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -326,7 +326,7 @@ int nthw_rac_rab_setup(nthw_rac_t *p)
 
 	const struct fpga_info_s *const p_fpga_info = p->mp_fpga->p_fpga_info;
 	uint32_t n_dma_buf_size = 2L * RAB_DMA_BUF_CNT * sizeof(uint32_t);
-	const size_t align_size = nt_util_align_size(n_dma_buf_size);
+	const size_t align_size = nthw_util_align_size(n_dma_buf_size);
 	int numa_node = p_fpga_info->numa_node;
 	uint64_t dma_addr;
 	uint32_t buf;
@@ -334,10 +334,10 @@ int nthw_rac_rab_setup(nthw_rac_t *p)
 	if (!p->m_dma) {
 		struct nt_dma_s *vfio_dma;
 		/* FPGA needs Page alignment (4K) */
-		vfio_dma = nt_dma_alloc(align_size, 0x1000, numa_node);
+		vfio_dma = nthw_dma_alloc(align_size, 0x1000, numa_node);
 
 		if (vfio_dma == NULL) {
-			NT_LOG(ERR, NTNIC, "nt_dma_alloc failed");
+			NT_LOG(ERR, NTNIC, "nthw_dma_alloc failed");
 			return -1;
 		}
 
@@ -418,7 +418,7 @@ static int nthw_rac_rab_dma_wait(nthw_rac_t *p)
 	uint32_t i;
 
 	for (i = 0; i < RAB_DMA_WAIT; i++) {
-		nt_os_wait_usec_poll(1);
+		nthw_os_wait_usec_poll(1);
 
 		if ((p->m_dma_out_buf[p->m_dma_out_ptr_rd] & completion) == completion)
 			break;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index c580684a84..1c26411da8 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -281,11 +281,12 @@ eth_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete __rte_unused)
 		nt_link_speed_t port_link_speed =
 			port_ops->get_link_speed(p_adapter_info, n_intf_no);
 		eth_dev->data->dev_link.link_speed =
-			nt_link_speed_to_eth_speed_num(port_link_speed);
+			nthw_link_speed_to_eth_speed_num(port_link_speed);
 
 		nt_link_duplex_t nt_link_duplex =
 			port_ops->get_link_duplex(p_adapter_info, n_intf_no);
-		eth_dev->data->dev_link.link_duplex = nt_link_duplex_to_eth_duplex(nt_link_duplex);
+		eth_dev->data->dev_link.link_duplex =
+			nthw_link_duplex_to_eth_duplex(nt_link_duplex);
 
 	} else {
 		eth_dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
@@ -355,7 +356,7 @@ eth_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_info
 
 		const uint32_t nt_port_speed_capa =
 			port_ops->get_link_speed_capabilities(p_adapter_info, n_intf_no);
-		dev_info->speed_capa = nt_link_speed_capa_to_eth_speed_capa(nt_port_speed_capa);
+		dev_info->speed_capa = nthw_link_speed_capa_to_eth_speed_capa(nt_port_speed_capa);
 	}
 
 	return 0;
@@ -785,7 +786,8 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 	uint64_t tot_alloc_size = 0x100000 + (uint64_t)buf_size * (uint64_t)num_descr;
 
 	void *virt =
-		rte_malloc_socket("VirtQDescr", tot_alloc_size, nt_util_align_size(tot_alloc_size),
+		rte_malloc_socket("VirtQDescr", tot_alloc_size,
+			nthw_util_align_size(tot_alloc_size),
 			eth_dev->data->numa_node);
 
 	if (!virt)
@@ -820,7 +822,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 		if (!virt)
 			return -1;
 
-		res = nt_vfio_dma_map(vf_num, virt, &iova_addr, size);
+		res = nthw_vfio_dma_map(vf_num, virt, &iova_addr, size);
 
 		NT_LOG(DBG, NTNIC, "VFIO MMAP res %i, vf_num %i", res, vf_num);
 
@@ -862,7 +864,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 			return -1;
 		}
 
-		res = nt_vfio_dma_map(vf_num, virt_addr, &iova_addr, size);
+		res = nthw_vfio_dma_map(vf_num, virt_addr, &iova_addr, size);
 
 		NT_LOG(DBG, NTNIC,
 			"VFIO MMAP res %i, virt %p, iova %016"
@@ -887,7 +889,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 		return 0;
 	}	/* End of: no optimal IOMMU mapping available */
 
-	res = nt_vfio_dma_map(vf_num, virt, &iova_addr, ONE_G_SIZE);
+	res = nthw_vfio_dma_map(vf_num, virt, &iova_addr, ONE_G_SIZE);
 
 	if (res != 0) {
 		NT_LOG(ERR, NTNIC, "VFIO MMAP FAILED! res %i, vf_num %i", res, vf_num);
@@ -948,7 +950,7 @@ static int deallocate_hw_virtio_queues(struct hwq_s *hwq)
 
 	void *virt = hwq->virt_queues_ctrl.virt_addr;
 
-	int res = nt_vfio_dma_unmap(vf_num, hwq->virt_queues_ctrl.virt_addr,
+	int res = nthw_vfio_dma_unmap(vf_num, hwq->virt_queues_ctrl.virt_addr,
 			(uint64_t)hwq->virt_queues_ctrl.phys_addr, hwq->virt_queues_ctrl.len);
 
 	if (res != 0) {
@@ -959,7 +961,7 @@ static int deallocate_hw_virtio_queues(struct hwq_s *hwq)
 	if (hwq->pkt_buffers_ctrl.virt_addr != NULL &&
 			hwq->pkt_buffers_ctrl.phys_addr != NULL &&
 			hwq->pkt_buffers_ctrl.len > 0) {
-		int res = nt_vfio_dma_unmap(vf_num,
+		int res = nthw_vfio_dma_unmap(vf_num,
 				hwq->pkt_buffers_ctrl.virt_addr,
 				(uint64_t)hwq->pkt_buffers_ctrl.phys_addr,
 				hwq->pkt_buffers_ctrl.len);
@@ -1414,7 +1416,7 @@ eth_dev_start(struct rte_eth_dev *eth_dev)
 				break;
 			}
 
-			nt_os_wait_usec(100 * 1000);
+			nthw_os_wait_usec(100 * 1000);
 		}
 
 		if (internals->lpbk_mode) {
@@ -1532,7 +1534,7 @@ drv_deinit(struct drv_s *p_drv)
 	 * 1 second to give the services a chance to see the termonation.
 	 */
 	clear_pdrv(p_drv);
-	nt_os_wait_usec(1000000);
+	nthw_os_wait_usec(1000000);
 
 	/* stop statistics service */
 	nthw_service_del(RTE_NTNIC_SERVICE_STAT);
@@ -1995,7 +1997,7 @@ static int port_event_service(void *context)
 			}
 
 			if (do_wait)
-				nt_os_wait_usec(10);
+				nthw_os_wait_usec(10);
 
 			count++;
 			do_wait = true;
@@ -2043,7 +2045,7 @@ static int adapter_flm_update_service(void *context)
 	}
 
 	if (profile_inline_ops->flm_update(dev) == 0)
-		nt_os_wait_usec(10);
+		nthw_os_wait_usec(10);
 
 	return 0;
 }
@@ -2081,7 +2083,7 @@ static int adapter_stat_service(void *context)
 		return 0;
 	}
 
-	nt_os_wait_usec(10 * 1000);
+	nthw_os_wait_usec(10 * 1000);
 
 	nthw_stat_trigger(p_nthw_stat);
 
@@ -2089,7 +2091,7 @@ static int adapter_stat_service(void *context)
 
 	while (rte_service_runstate_get(stat_srv->id) &&
 		(*p_nthw_stat->mp_timestamp == (uint64_t)-1)) {
-		nt_os_wait_usec(1 * 100);
+		nthw_os_wait_usec(1 * 100);
 
 		if ((++loop & 0x3fff) == 0) {
 			if (p_nt4ga_stat->mp_nthw_rpf) {
@@ -2148,7 +2150,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		/* Return statement is not necessary here to allow traffic processing by SW  */
 	}
 
-	nt_vfio_init();
+	nthw_vfio_init();
 	const struct port_ops *port_ops = get_port_ops();
 
 	if (port_ops == NULL) {
@@ -2271,7 +2273,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 	}
 
 	/* Setup VFIO context */
-	int vfio = nt_vfio_setup(pci_dev);
+	int vfio = nthw_vfio_setup(pci_dev);
 
 	if (vfio < 0) {
 		NT_LOG_DBGX(ERR, NTNIC, "%s: vfio_setup error %d",
@@ -2622,7 +2624,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 
 	/* let running services end Rx and Tx activity */
 	if (sg_ops != NULL) {
-		nt_os_wait_usec(1 * 1000 * 1000);
+		nthw_os_wait_usec(1 * 1000 * 1000);
 
 		while (internals) {
 			for (i = internals->nb_tx_queues - 1; i >= 0; i--) {
@@ -2647,7 +2649,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 		rte_eth_dev_release_port(eth_dev);
 	}
 
-	nt_vfio_remove(EXCEPTION_PATH_HID);
+	nthw_vfio_remove(EXCEPTION_PATH_HID);
 	return 0;
 }
 
@@ -2698,7 +2700,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	 * flooding by OVS from multiple virtual port services - no need to be precise
 	 */
 	uint64_t now_rtc = rte_get_tsc_cycles();
-	nt_os_wait_usec(10 * 1000);
+	nthw_os_wait_usec(10 * 1000);
 	rte_tsc_freq = 100 * (rte_get_tsc_cycles() - now_rtc);
 
 	NT_LOG_DBGX(DBG, NTNIC, "leave: ret=%d", ret);
diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index b1e807d6fa..187829d287 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -47,7 +47,7 @@ vfio_get(int vf_num)
 
 /* External API */
 int
-nt_vfio_setup(struct rte_pci_device *dev)
+nthw_vfio_setup(struct rte_pci_device *dev)
 {
 	int ret;
 	char devname[RTE_DEV_NAME_MAX_LEN] = { 0 };
@@ -123,7 +123,7 @@ nt_vfio_setup(struct rte_pci_device *dev)
 }
 
 int
-nt_vfio_remove(int vf_num)
+nthw_vfio_remove(int vf_num)
 {
 	struct vfio_dev *vfio;
 
@@ -141,7 +141,7 @@ nt_vfio_remove(int vf_num)
 }
 
 int
-nt_vfio_dma_map(int vf_num, void *virt_addr, uint64_t *iova_addr, uint64_t size)
+nthw_vfio_dma_map(int vf_num, void *virt_addr, uint64_t *iova_addr, uint64_t size)
 {
 	uint64_t gp_virt_base;
 	uint64_t gp_offset;
@@ -189,7 +189,7 @@ nt_vfio_dma_map(int vf_num, void *virt_addr, uint64_t *iova_addr, uint64_t size)
 }
 
 int
-nt_vfio_dma_unmap(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size)
+nthw_vfio_dma_unmap(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size)
 {
 	uint64_t gp_virt_base;
 	struct vfio_dev *vfio;
@@ -225,10 +225,10 @@ nt_vfio_dma_unmap(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size
 }
 
 void
-nt_vfio_init(void)
+nthw_vfio_init(void)
 {
-	struct nt_util_vfio_impl s = { .vfio_dma_map = nt_vfio_dma_map,
-		       .vfio_dma_unmap = nt_vfio_dma_unmap
+	struct nt_util_vfio_impl s = { .vfio_dma_map = nthw_vfio_dma_map,
+		       .vfio_dma_unmap = nthw_vfio_dma_unmap
 	};
-	nt_util_vfio_init(&s);
+	nthw_util_vfio_init(&s);
 }
diff --git a/drivers/net/ntnic/ntnic_vfio.h b/drivers/net/ntnic/ntnic_vfio.h
index e070e9460c..72f8165a48 100644
--- a/drivers/net/ntnic/ntnic_vfio.h
+++ b/drivers/net/ntnic/ntnic_vfio.h
@@ -11,17 +11,17 @@
 #include <ethdev_pci.h>
 
 void
-nt_vfio_init(void);
+nthw_vfio_init(void);
 
 int
-nt_vfio_setup(struct rte_pci_device *dev);
+nthw_vfio_setup(struct rte_pci_device *dev);
 int
-nt_vfio_remove(int vf_num);
+nthw_vfio_remove(int vf_num);
 
 int
-nt_vfio_dma_map(int vf_num, void *virt_addr, uint64_t *iova_addr, uint64_t size);
+nthw_vfio_dma_map(int vf_num, void *virt_addr, uint64_t *iova_addr, uint64_t size);
 int
-nt_vfio_dma_unmap(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size);
+nthw_vfio_dma_unmap(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size);
 
 /* Find device (PF/VF) number from device address */
 #endif	/* _NTNIC_VFIO_H_ */
diff --git a/drivers/net/ntnic/ntutil/nt_util.c b/drivers/net/ntnic/ntutil/nt_util.c
index 18133570bb..2401aee3dc 100644
--- a/drivers/net/ntnic/ntutil/nt_util.c
+++ b/drivers/net/ntnic/ntutil/nt_util.c
@@ -17,35 +17,35 @@
 static struct nt_util_vfio_impl vfio_cb;
 
 /* uses usleep which schedules out the calling service */
-void nt_os_wait_usec(int val)
+void nthw_os_wait_usec(int val)
 {
 	rte_delay_us_sleep(val);
 }
 
 /* spins in a waiting loop calling pause asm instruction uses RDTSC - precise wait */
-void nt_os_wait_usec_poll(int val)
+void nthw_os_wait_usec_poll(int val)
 {
 	rte_delay_us(val);
 }
 
-uint64_t nt_os_get_time_monotonic_counter(void)
+uint64_t nthw_os_get_time_monotonic_counter(void)
 {
 	return rte_get_timer_cycles();
 }
 
 /* Allocation size matching minimum alignment of specified size */
-uint64_t nt_util_align_size(uint64_t size)
+uint64_t nthw_util_align_size(uint64_t size)
 {
 	uint64_t alignment_size = 1ULL << rte_log2_u64(size);
 	return alignment_size;
 }
 
-void nt_util_vfio_init(struct nt_util_vfio_impl *impl)
+void nthw_util_vfio_init(struct nt_util_vfio_impl *impl)
 {
 	vfio_cb = *impl;
 }
 
-struct nt_dma_s *nt_dma_alloc(uint64_t size, uint64_t align, int numa)
+struct nt_dma_s *nthw_dma_alloc(uint64_t size, uint64_t align, int numa)
 {
 	int res;
 	struct nt_dma_s *vfio_addr;
@@ -65,7 +65,7 @@ struct nt_dma_s *nt_dma_alloc(uint64_t size, uint64_t align, int numa)
 		return NULL;
 	}
 
-	res = vfio_cb.vfio_dma_map(0, addr, &vfio_addr->iova, nt_util_align_size(size));
+	res = vfio_cb.vfio_dma_map(0, addr, &vfio_addr->iova, nthw_util_align_size(size));
 
 	if (res != 0) {
 		rte_free(addr);
@@ -75,7 +75,7 @@ struct nt_dma_s *nt_dma_alloc(uint64_t size, uint64_t align, int numa)
 	}
 
 	vfio_addr->addr = (uint64_t)addr;
-	vfio_addr->size = nt_util_align_size(size);
+	vfio_addr->size = nthw_util_align_size(size);
 
 	NT_LOG(DBG, GENERAL,
 		"VFIO DMA alloc addr=%" PRIX64 ", iova=%" PRIX64
@@ -86,7 +86,7 @@ struct nt_dma_s *nt_dma_alloc(uint64_t size, uint64_t align, int numa)
 }
 
 /* NOTE: please note the difference between RTE_ETH_SPEED_NUM_xxx and RTE_ETH_LINK_SPEED_xxx */
-int nt_link_speed_to_eth_speed_num(enum nt_link_speed_e nt_link_speed)
+int nthw_link_speed_to_eth_speed_num(enum nt_link_speed_e nt_link_speed)
 {
 	int eth_speed_num = RTE_ETH_SPEED_NUM_NONE;
 
@@ -131,7 +131,7 @@ int nt_link_speed_to_eth_speed_num(enum nt_link_speed_e nt_link_speed)
 	return eth_speed_num;
 }
 
-uint32_t nt_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa)
+uint32_t nthw_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa)
 {
 	uint32_t eth_speed_capa = 0;
 
@@ -162,7 +162,7 @@ uint32_t nt_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa)
 	return eth_speed_capa;
 }
 
-int nt_link_duplex_to_eth_duplex(enum nt_link_duplex_e nt_link_duplex)
+int nthw_link_duplex_to_eth_duplex(enum nt_link_duplex_e nt_link_duplex)
 {
 	int eth_link_duplex = 0;
 
diff --git a/drivers/net/ntnic/ntutil/nt_util.h b/drivers/net/ntnic/ntutil/nt_util.h
index 39a4956187..c889d07a10 100644
--- a/drivers/net/ntnic/ntutil/nt_util.h
+++ b/drivers/net/ntnic/ntutil/nt_util.h
@@ -32,16 +32,16 @@
 #define PCIIDENT_PRINT_STR "%04x:%02x:%02x.%x"
 #define BDF_TO_PCIIDENT(dom, bus, dev, fnc) (((dom) << 16) | ((bus) << 8) | ((dev) << 3) | (fnc))
 
-uint64_t nt_os_get_time_monotonic_counter(void);
-void nt_os_wait_usec(int val);
-void nt_os_wait_usec_poll(int val);
+uint64_t nthw_os_get_time_monotonic_counter(void);
+void nthw_os_wait_usec(int val);
+void nthw_os_wait_usec_poll(int val);
 
 static inline int min(int a, int b)
 {
 	return (a < b) ? a : b;
 }
 
-uint64_t nt_util_align_size(uint64_t size);
+uint64_t nthw_util_align_size(uint64_t size);
 
 struct nt_dma_s {
 	uint64_t iova;
@@ -54,17 +54,17 @@ struct port_link_speed {
 	int link_speed;
 };
 
-struct nt_dma_s *nt_dma_alloc(uint64_t size, uint64_t align, int numa);
+struct nt_dma_s *nthw_dma_alloc(uint64_t size, uint64_t align, int numa);
 struct nt_util_vfio_impl {
 	int (*vfio_dma_map)(int vf_num, void *virt_addr, uint64_t *iova_addr, uint64_t size);
 	int (*vfio_dma_unmap)(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size);
 };
 
-void nt_util_vfio_init(struct nt_util_vfio_impl *impl);
+void nthw_util_vfio_init(struct nt_util_vfio_impl *impl);
 
-int nt_link_speed_to_eth_speed_num(enum nt_link_speed_e nt_link_speed);
-uint32_t nt_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa);
-int nt_link_duplex_to_eth_duplex(enum nt_link_duplex_e nt_link_duplex);
+int nthw_link_speed_to_eth_speed_num(enum nt_link_speed_e nt_link_speed);
+uint32_t nthw_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa);
+int nthw_link_duplex_to_eth_duplex(enum nt_link_duplex_e nt_link_duplex);
 
 int nthw_string_to_u32(const char *key_str __rte_unused, const char *value_str, void *extra_args);
 
-- 
2.45.0

