Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FE7C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54EE940B9D;
	Wed, 30 Apr 2025 15:49:36 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id AA47340612
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:23 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2105.outbound.protection.outlook.com [104.47.30.105]) by
 mx-outbound8-212.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2mFQKhwxjIW545RGRKE3axVsfGgGEWRzt1qILsUhlb78FXoJ/WPKaINNorL6wAvql5vAWqAhgz2+1AwsocNagrjzjBzcJv3GiL/KIYCvKTKoYStKZHs4E+m8eXytGCribZxDCYU3b7TtqV/x2aa2fKlDe5x4Ggkul7xFZYzfFl8c+Evm65WfngUWdIhmDp1nk1zcSDEMObypFhpv0Gh1oN7A6fOOweyGGcCTUeLEsbFEsJcAU+h5O91Fzo+iVg8X83qdkaQEHd1ziSJ0bxKk+H9scod8IOYuHeE3xhT1+nalwbdbv3w5OWNNEf7AjVlXOzkYoHgoHASUPofPv/nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Huer0LzS8T7AClFVoIt6w7akMiM2hfD9kxUY2zbClMg=;
 b=ECpYZXv8vUCGAz5sT0C/W4B0VoFTiIGO4juPYEZBi6szBOsvdTivJs8AtUWzqUSgm7OtLIQxExshjM9oCPQuBQ0HlCAdySkgBqirk9rcIBp+p+H/j5gc9hSTyFKysT/n7MsVP2mvOGfZg9o61jVvua1wZ++MaIidmAefCdT4MEmlGKYlCO+94dO+E1eJBqcxKhIzoN3MkmacD8ggE90aMBnVWxeG/89dp6S2/2Fcl/hRLobC2bogdWGosNueaxjKMuYTiTV9ukG6pkXK3bCuY4NW9K9qhcjhJ3LEh2ZMdzvNHZG4g2LFslBvsn3sFm+KQgaVHit9hDhqJRxaEPbwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Huer0LzS8T7AClFVoIt6w7akMiM2hfD9kxUY2zbClMg=;
 b=RWe9ygYovTF+PioNg/UsIqrrNfSObbrg7OiGvzVyRFhC0z9Zer4D1OgKIQ6vEUsREdeKsFFgKqGjWrJdI5l1kwHcMHXNRHzM+rDn5sdACpsY46c9Fv/uAvWqeEYX5nrLITsOguCg4hjTTGJV4h3TMa1K6qigFcIjPt2apglmX5Q=
Received: from AM9P193CA0005.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::10)
 by VI0P190MB2062.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:18 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::65) by AM9P193CA0005.outlook.office365.com
 (2603:10a6:20b:21e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 13:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:17 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 16/25] net/ntnic: enhance null checks and assertions
Date: Wed, 30 Apr 2025 15:48:28 +0200
Message-ID: <20250430134840.402553-17-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|VI0P190MB2062:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 232b93ce-2043-4274-a0f3-08dd87edcd60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ifBJGszI7gsTKmELVdFsL5OXVJfM3i9G0qa2MXPA0bUMnp+FD8ipuHCcnPql?=
 =?us-ascii?Q?FHld4i/LNAvqG8dhycx4Pv0jjye1+CQVuLexx/v+Z3aRTsDA8ESKmG65a4yU?=
 =?us-ascii?Q?701oPFW3ZNX4eoE72hQr5Grr0h3bbBLQdFT435yV51bgZwHL1YZl7riem9cj?=
 =?us-ascii?Q?tOfgJqKdQyWQZLaLQ+9J2kzPu7fUrMSTcZwiTImiKafsTmCTkl0sMkz9cyKe?=
 =?us-ascii?Q?KrY+ZlY5P20L++FD/sth1wiK+AlyKHTBd5YNx5z+qlPD0UUTBVOEj+9wxCrP?=
 =?us-ascii?Q?go040jP2MQ40V6PKUz+IQG54vUY+HcGiCdAMM9Mnk9g4d/WnzbtW7SVua1Er?=
 =?us-ascii?Q?7ZBv2hdG0shhMcoCgrn1Gy8H2weE8emxl7YCzFpMF5U7NU4vhQC2QxQ+4AB9?=
 =?us-ascii?Q?AssnBKOpsRxbtGAC0OgIQyA8B3a1hJZQOb3w1dn1t2KymH8+SuoMtT5nO7d1?=
 =?us-ascii?Q?bLANKw3Rk40GmH7nkk2P1THOIuq9FDreQ+EcYZEAbweDwjHwillJHVoiQtDt?=
 =?us-ascii?Q?OBQ9vlVWQXMmIGn60doFA4DHhp4HcHTHGFMuzuuInJRs3RLcqmHYlodLwEmi?=
 =?us-ascii?Q?Btuve9uR8vfnLBmaE/ElKh+TrfnrZkGUaUpCCwM9aWwol64jLViz+VesGjWD?=
 =?us-ascii?Q?DV7rbN+Be4/oztjhpsiCZvdwDQGbPu6DVAqpfzSdsR3bBYHzc1I0hXEGP1IJ?=
 =?us-ascii?Q?2MV6sxlH2b4AaiisFFMDNgbVOyz5Qwl8UaPmxGLjgZ2s3xbG9DAnrYCsNXbY?=
 =?us-ascii?Q?3GUsX2GdwqHDNJRtCF7JsECL1qFTp82PFLutPDqZoD4wXT3qW09txLdcujuh?=
 =?us-ascii?Q?PV0uPKTIlh0S5W0T9FEvQka1XAPfqhKCSMcsVhNI4heRFPwsnsikdIcLO+Cu?=
 =?us-ascii?Q?XiPpqSl70Us4z70RJVd8M0L+xa7IfhJ1JwyDIVOtcmF6dYre8v9xGb6BodY3?=
 =?us-ascii?Q?QI5FHGjLoPZ8bBlLCVTv5bNZoDTvaOHyk7drvHpBwFjgW1oERNiDa41u76Mr?=
 =?us-ascii?Q?d0Ovlsbo5Tz1zMsvF8HH/QbGf8DI7bLZIPWtjuhILaIxAeW+4yVEt+M6p+hv?=
 =?us-ascii?Q?sW7wGNtPvyYMPIWKG4yXP7qlsHUqCY3CVqomA50VF61tP8L6sRuZqmRtTJdC?=
 =?us-ascii?Q?bvnGk0fFb+2iyQY4Dm5it97NHG2eJ/90Jh8hi+0Dbg1CUhYpniItNaBgymNV?=
 =?us-ascii?Q?WGPBFlfai5VDkmz1+2evee3a2MqIX80oDDFiZGLi3/aG2hmQVMgjG6fhPCSO?=
 =?us-ascii?Q?HcMvcDk30AtiW0bcXimUGcYn9e+g5ydj9gjouQjfN7R1+1FhUsaEMI5X3k/A?=
 =?us-ascii?Q?2onexbazDKsH8uekO3S11wz9yx2vAQ9Mm0k5/p8b/OQZE7GjfwUtKCIzeYD6?=
 =?us-ascii?Q?ZiEOiX7GiguOEdApu2gkM+SQd3XmIPOtCiGfkH0AWVyEDqn5zuawfHYI60ty?=
 =?us-ascii?Q?zKWk9aGpe2prLX3mKkaXbXllSyD1iLnA015ojbvEX/Q+FBzR09Er45oYM/Hm?=
 =?us-ascii?Q?0OCtQVTH8DejeAXdze+0MEPHO2bDt87gn+Nn?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rKAxPRjRj8OSj0+5alHaNHRqjVOfFivbSdP8OrpIdizbsVw+KlTk6dTuwaNBJBk3lwgSKyCcgriIZXwaZadjYtnlOSooTnuQNyGJjOdEx4LdTCnbTKAhz1ZtNvU8rBeASp2jJVyxbajzkun3tWzatAaq1+/aa1CreJt6isTj2GDUTspPsziUSKwkpTMou5x0W2ez5DwkRpVd02CcuQ0bSPx613a5UApBnt0sYF6XtQD/nI6RJBmeM1mvaMVsiLUEgLWgGwIJ6jpf37wniD0fX/0gNaSnjChPIKBnZyBBcVSchwyZd4gl3RJweGbpDaX3aNE5WWK1g/G/X9+xQyfMzowfXZOXgX9sH2T802Ks8ltWj+QzWicvmGZ5qkBAJrcqjPU9DahFM/gOA3X8V7aX2gvd3DutyadLiKKmpXpm6M3OmWYuF1MlRupdfhbIFJtIbrhiQgVBzdmbVBv5gpiA64s6u9FfJ9J/g/mzjfwvbF6g6mqFqYehuwEWqslCDO2PD+QkQvhVouLZeZD8jk+cnRg46cAlxxP19VI8m0Xv7IZ33docFhvn+oLakyGP7AMU4MFLffhnFw4gf1wMDLK+C94EXPHMLBQcK/cG/m/mEXK/9QLBW+nkbo/KfiYZLhHt8N6wD6F4cnpmyIS1IyWtOA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:17.7726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232b93ce-2043-4274-a0f3-08dd87edcd60
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2062
X-BESS-ID: 1746020960-302260-7739-9117-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.30.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYmRhZAVgZQMCXNzDLN3MDcKM
 XMONk82SIt0cTIMjHNyMTEyNw8NTFRqTYWAJCT0exBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan22-217.eu-central-1b.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Avoid usage before check

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c     |  4 ++--
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c         |  4 ++--
 .../net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c   |  2 +-
 .../link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c     |  3 ++-
 .../nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c |  4 ++--
 drivers/net/ntnic/nthw/core/nthw_fpga.c               |  3 +--
 drivers/net/ntnic/ntnic_ethdev.c                      |  5 +++++
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c         | 11 ++++++-----
 8 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index 0ea40fdf42..ff83ba69f7 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -246,7 +246,7 @@ static int nt4ga_stat_collect_cap_v1_stats(struct adapter_info_s *p_adapter_info
 	(void)p_adapter_info;
 	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
 
-	if (flow_filter_ops == NULL)
+	if (flow_filter_ops == NULL || p_nt4ga_stat == NULL)
 		return -1;
 
 	nthw_stat_t *p_nthw_stat = p_nt4ga_stat->mp_nthw_stat;
@@ -256,7 +256,7 @@ static int nt4ga_stat_collect_cap_v1_stats(struct adapter_info_s *p_adapter_info
 	const int n_tx_ports = p_nt4ga_stat->mn_tx_ports;
 	int c, h, p;
 
-	if (!p_nthw_stat || !p_nt4ga_stat)
+	if (p_nthw_stat == NULL)
 		return -1;
 
 	if (p_nthw_stat->mn_stat_layout_version < 6) {
diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index c9a0580391..bb775c052c 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -592,11 +592,11 @@ static int nthw_release_mngd_rx_virt_queue(struct nthw_virt_queue *rxvq)
 
 static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 {
-	nthw_dbs_t *p_nthw_dbs = txvq->mp_nthw_dbs;
-
 	if (txvq == NULL)
 		return -1;
 
+	nthw_dbs_t *p_nthw_dbs = txvq->mp_nthw_dbs;
+
 	/* Clear UW */
 	txvq->used_struct_phys_addr = NULL;
 
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index 43b3c5a41f..ed9dabe27c 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -256,11 +256,11 @@ static int _create_nim(adapter_info_t *drv, int port, bool enable)
 	nim_i2c_ctx_t *nim_ctx;
 	sfp_nim_state_t nim;
 	nt4ga_link_t *link_info = &drv->nt4ga_link;
-	nthw_mac_pcs_t *mac_pcs = &link_info->u.var100g.mac_pcs100g[port];
 
 	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
 	RTE_ASSERT(link_info->variables_initialized);
 
+	nthw_mac_pcs_t *mac_pcs = &link_info->u.var100g.mac_pcs100g[port];
 	gpio_phy = &link_info->u.var100g.gpio_phy[port];
 	nim_ctx = &link_info->u.var100g.nim_ctx[port];
 
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 4f6be900fd..64db55f6e9 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -519,11 +519,12 @@ static int create_nim(adapter_info_t *drv, int port, bool enable)
 	const uint8_t valid_nim_id = NT_NIM_QSFP28;
 	sfp_nim_state_t nim;
 	nt4ga_link_t *link_info = &drv->nt4ga_link;
-	nim_i2c_ctx_t *nim_ctx = &link_info->u.nim_ctx[port];
 
 	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
 	RTE_ASSERT(link_info->variables_initialized);
 
+	nim_i2c_ctx_t *nim_ctx = &link_info->u.nim_ctx[port];
+
 	if (!enable) {
 		phy_reset_rx(drv, port);
 		phy_reset_tx(drv, port);
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 237c19bb95..d9c4281eeb 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -182,6 +182,8 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 {
+	RTE_ASSERT(p_fpga_info);
+
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 	nthw_fpga_t *p_fpga = NULL;
 	int res = -1;
@@ -191,8 +193,6 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 	nthw_pcm_nt400dxx_t *p_pcm = p_fpga_info->mp_nthw_agx.p_pcm;
 	nthw_prm_nt400dxx_t *p_prm = p_fpga_info->mp_nthw_agx.p_prm;
 
-	RTE_ASSERT(p_fpga_info);
-
 	NT_LOG(DBG, NTHW, "%s: %s: BEGIN", p_adapter_id_str, __PRETTY_FUNCTION__);
 
 	/* Create Phy Tile module */
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 47f4b4e7b1..b74a1607fd 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -343,6 +343,7 @@ int nthw_fpga_si5340_clock_synth_init_fmt2(nthw_fpga_t *p_fpga, const uint8_t n_
 
 int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 {
+	RTE_ASSERT(p_fpga_info);
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 
 	nthw_hif_t *p_nthw_hif = NULL;
@@ -359,8 +360,6 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 
 	int res = 0;
 
-	RTE_ASSERT(p_fpga_info);
-
 	{
 		const uint64_t n_fpga_ident = nthw_fpga_read_ident(p_fpga_info);
 		const uint32_t n_fpga_build_time = nthw_fpga_read_buildtime(p_fpga_info);
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index e3ed22b89b..a8ea7ee140 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -332,6 +332,11 @@ eth_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_info
 
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
+	if (internals == NULL) {
+		NT_LOG(ERR, NTNIC, "PMD-specific private data not initialized");
+		return -1;
+	}
+
 	const int n_intf_no = internals->n_intf_no;
 	struct adapter_info_s *p_adapter_info = &internals->p_drv->ntdrv.adapter_info;
 
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 551979cf0f..5757c7c13c 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -478,11 +478,6 @@ static int convert_flow(struct rte_eth_dev *eth_dev,
 	struct rte_flow_error *error)
 {
 	struct pmd_internals *internals = eth_dev->data->dev_private;
-	struct fpga_info_s *fpga_info = &internals->p_drv->ntdrv.adapter_info.fpga_info;
-
-	error->type = RTE_FLOW_ERROR_TYPE_NONE;
-	error->message = "none";
-	uint32_t queue_offset = 0;
 
 	if (!internals) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
@@ -490,6 +485,12 @@ static int convert_flow(struct rte_eth_dev *eth_dev,
 		return -1;
 	}
 
+	struct fpga_info_s *fpga_info = &internals->p_drv->ntdrv.adapter_info.fpga_info;
+
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
+	uint32_t queue_offset = 0;
+
 	if (internals->type == PORT_TYPE_OVERRIDE && internals->vpq_nb_vq > 0) {
 		/*
 		 * The queues coming from the main PMD will always start from 0
-- 
2.47.1

