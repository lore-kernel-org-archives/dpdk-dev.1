Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDDCC369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BFCF40659;
	Wed, 30 Apr 2025 15:49:24 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 90262402A1
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:17 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2040.outbound.protection.outlook.com [104.47.11.40]) by
 mx-outbound43-210.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hcz86rA94c4TaKDhNdJCoevqirPpevQbZONsdqhpAZf988K0uCVy52/DQSSgw9iAazmQM3YkvHNq8PCvsDctH4Usqqv1sTNkCpItsI7QARGHgkuvaDFnRrlGEh5sHQGZVZ7Y4CkP18CdGcqiJGQY6V872GXEuRrXYfkB9P8rSPp9FXoFTCockF9LG+Gleoykg0CI8sH5B0RMUfeKNTI8rvwJnhdRsfDhniktvrM11S7yrSnW8XV9E12p0BmXkqd1CsSHON4hzKvMwtVqL13zisSVwmgm8GS+cDamNDk1fSCpEmSLjiHTpq8YNm225dT+B3P05jaO9V3jaj7Z1MfJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANQ5X9KbEZROU+mU3ayIp16t4xaa/K4DWSeKyuA7fH4=;
 b=vIZ5wUgXNDu8dhieM7xEUV7MsuRksR43AIXBt3UGQznzFWSa8lwASrcNOPOAX/Dqn8aVHsttWa5R+DtA1U8sfwwGhWsnK7/+TkdQgV4/1LSZmtqAA9F9YiTbc7R4lKe+v1Uor7v4DWXVltbRIvHawpf2Ej/1sfNdQEeZZphylacmjYS3QJQbLQk20s4F+Z7SH25Pa8ZDJu3dvCrCF+Yjih/t2tbPolFwLbH+mHp0SLe79mUQyCF+CLsuZGZMvkox+/JP1bwebfZnQJdjzzlWwMnoPHtb5uVWUzDFA4fuC9AZRvOeraEy9pEiAfKOn9dBhe1KUkdAvSYICz+Ak7zb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANQ5X9KbEZROU+mU3ayIp16t4xaa/K4DWSeKyuA7fH4=;
 b=ah6zYrQcOkIaCIZ3Hv2nd78fN1aqskwVMyfDr0nQ/kcrEj9bW8sP1TB5XdMu2LnjtZB82AchXnB52p7hdFjN4Pa7s4EekPYV2rJHgpRz/AAWkenmqcfi7wI0wDkPL+J7uAZM6819rXTcYVGeYOYDZ8e5u6ubASawx/FN4N8Z/JY=
Received: from AM9P193CA0017.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::22)
 by PR3P190MB1004.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:84::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 13:49:12 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::a1) by AM9P193CA0017.outlook.office365.com
 (2603:10a6:20b:21e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 13:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:12 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 09/25] net/ntnic: remove usless expressions
Date: Wed, 30 Apr 2025 15:48:21 +0200
Message-ID: <20250430134840.402553-10-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|PR3P190MB1004:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e7f86293-4e21-4fa6-dc51-08dd87edc9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nbBcIYTb2CGVCBEWcYguD9eL6Y7YV32KnKXlrfCRzfyxnU3MEUKN5i1Lv/33?=
 =?us-ascii?Q?vcfqvYKYWTzlQsUYMNGS4gxhaDz9qz6txoE1LSjYI7ryyCaGSzg9PGtlOuRo?=
 =?us-ascii?Q?qmFhXz3CMnsCbGN5yEYw6LRqvFdXRBNbpNXOuC+Yv9D8MYErk6qgbwqwLQ2b?=
 =?us-ascii?Q?lwIgQp7Pd5xNBC/6skVd7ti4Oosh3zqqbjVXVbhaHusMBFcfVY9gYNpQU9ny?=
 =?us-ascii?Q?tzfyIJXPZIuw60U816stqoDlxlSDe5vrnFN1tdjrYClF4wf9tkrreEPRuoJG?=
 =?us-ascii?Q?Fv1VALnWfy++SIuNMl3hIp1yMiKEnXK94es4y5+lLfZB8UwHuDsFFOqZyMrH?=
 =?us-ascii?Q?9k+sjAcqTTiYKy05hpTx8UciXfhCWuUYmPJOg3lwyifI1uuPfXWR9I38prw7?=
 =?us-ascii?Q?VNnX0LjDazjRPCPir8GUap9mJKqfwIFhmhASA167vkTRDGT/gVN9IM1nfxQp?=
 =?us-ascii?Q?Fnxqq3BOU/quidnxlGC68rxjSVjFBfX66TZjBZKJ5GIdYzxE3lcpj+TDvXI7?=
 =?us-ascii?Q?srYrXg2BxGICu4ija5N7IRdVnEDHLwLPOk0AFA8GVbN8zLrg+FqP4vjg+FPW?=
 =?us-ascii?Q?qf7nirlhEhZvWZFvggPMMCn0ZeIJ/rnUfDDpBYmsCBnSKgCliBrS/tCYcKSp?=
 =?us-ascii?Q?oD3TV3YNLixoRp0baHiSVTc93UeOeFEV3Oca88FhgMSwh0b8Y7KnyWkOPQHo?=
 =?us-ascii?Q?FFAIyPK3ZDKneN7wak5IL2k0dXq7r2j3KuO8dCyViSEcV02ZobdhaJOHJZr/?=
 =?us-ascii?Q?kB/h0zFXIkvLM187PdWMkLPDkdld/SxWgOD0F7rWTyaPif8snsSaapUNuLqI?=
 =?us-ascii?Q?iv2meAaYPr1C3XDGutIA4boY3MQiiz98cPNpuyq/k6Gs1CG2SiBSF1/RPkVW?=
 =?us-ascii?Q?X/qP69xpb2+adQPlgnuAEj6gUUhG1sE4PWZLbTrJyMtSODMNEL4qvyMz9g1g?=
 =?us-ascii?Q?0H+pcxKOjfvu5s0d2P3crPtdLHMHDTu3ja6Apgk1adYls5fcQyWitCAjv/yK?=
 =?us-ascii?Q?VZojTusZcIQmMBMObJKFX3uE39YxyMoOr7zoS1cCDEX15vspdZhtMfN4cfus?=
 =?us-ascii?Q?qliL6dcobnxMPMTQ1rKKqB7KeZvpZESyoHjVRfULcgJJwdzCyqTxpAIZ7cve?=
 =?us-ascii?Q?Kd+pVqAy8d5BgSl5liUr+2LQeR4BVjPkyHGlbhX6UmYI6SeNHp2CFgYFvI6u?=
 =?us-ascii?Q?jERnAD/c+zJtLZzUubRdyUABLhcWKlkgQb3FTIOlmebubFYuHpwBvBtoBwPW?=
 =?us-ascii?Q?et/3Dq0FsJn4xz8WWAl66Nbz6zGSi5IQX3bKUmxh21QSLZSMLS8qStdlx0lu?=
 =?us-ascii?Q?vvJyPdNklnOvfhZqzO8uNUGtqvEO7cXeH5k4jnnkSRsdsm+pMbzVU1MoY4tr?=
 =?us-ascii?Q?+GzlnGwy6WLKyD7AkVBG0HCYkNbi4Q2yMZMyJc/sTQNxtN5MJVc1MUI3ioSn?=
 =?us-ascii?Q?79E8UGACOQNudY3Se8EThHf62LN3LeTllnKLGaISQJcz99NQwsuNQdxb25SP?=
 =?us-ascii?Q?m8ctUrExe4Lc06bKotS6KdpC53E+UsI/DaSH?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n2cRGE6ESLWi749o6NDCvnH2E7cnEFbFvuflCZdWaKI03uoMY3Ap9TsZjDxXDLyY+0zzntS8yDUeYYHfMXrKh4lqDGAqhJauZBJ48U63UWJnbXdtQWKi2KXyyXadX0p17gHjdSTFqLQm9/w1s+Vu+5UgEQELWB2CaBR3T91bRW6TB09ZuKYBroX1bELNObILj+aAtVGmZhPpsSwVbLWWXXwdy89qzEiqvMr41JiHeFusUyPPV8aZFfnR0jXsero1WWvVu0gGoAdR+vQNSrU8ZPUpx8WZUeLPAcH8juJ1pdo8yoDAkxo/KPh8+RiTdCqUWdrxEmzz/oc/yu6etWtBJoG9JGWrWfd8dAkwPWCZA5WDO14oUanif3/yLqmzUO/gCFddOrjqixBVjdPz02f43+9kk7VNYW4Vk4OiXRueeAe/VofKNi7qkkbCDzV3OLuQGf7EmgKPtCJpNaS7vD4AznHVmSRrFcIlW1NVo5aLk9s88kfbfYrBH2vIgl1zFoYDYaysgyGN+Cpmobi8ptmQX/uIEcT6kyYAPn33/6QKcwn4qP/WXXmsrU2mBbVvoBAkuKOd+56KiMLJ/nSfehFv1VKBbe2ACjD4shifIj1e9hrPglN0hjBPbh6QAbCmbE+bgeK3AUD2u9s22LX/y+NOzw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:12.0365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f86293-4e21-4fa6-dc51-08dd87edc9f5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB1004
X-BESS-ID: 1746020954-311218-7644-8866-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGpoYmQGYGUDTFKNkoxTAx0d
 DYyCDVMs3YMNks2cDE1MjQODXJ1NLAUKk2FgBR1tQJQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan14-251.eu-central-1a.ess.aws.cudaops.com]
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

simplify conditionals and remove redundant checks

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  3 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 16 +++++------
 drivers/net/ntnic/nim/i2c_nim.c               |  3 +-
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c   | 10 -------
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  3 +-
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |  2 +-
 drivers/net/ntnic/nthw/core/nthw_sdc.c        |  3 +-
 drivers/net/ntnic/nthw/core/nthw_tsm.c        |  6 ++--
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  3 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c   |  3 --
 .../profile_inline/flow_api_profile_inline.c  |  9 +-----
 drivers/net/ntnic/nthw/nthw_rac.c             |  7 -----
 drivers/net/ntnic/ntnic_ethdev.c              | 28 ++++++++-----------
 13 files changed, 28 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index cc09fdcc4a..c9a0580391 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -761,8 +761,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 */
 	if (irq_vector < 0) {
 		if (set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
-				TX_AM_ENABLE, host_id, 0,
-				irq_vector >= 0 ? 1 : 0) != 0) {
+				TX_AM_ENABLE, host_id, 0, 0) != 0) {
 			return NULL;
 		}
 	}
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index f1c17ea80a..4f6be900fd 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -1010,20 +1010,18 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 
 		nthw_rpf_set_ts_at_eof(p_nthw_agx->p_rpf, true);
 
-		if (res == 0) {
-			p_adapter_info->nt4ga_link.speed_capa = NT_LINK_SPEED_100G;
-			p_adapter_info->nt4ga_link.variables_initialized = true;
-		}
+
+		p_adapter_info->nt4ga_link.speed_capa = NT_LINK_SPEED_100G;
+		p_adapter_info->nt4ga_link.variables_initialized = true;
 	}
 
 	/*
 	 * Create state-machine thread
 	 */
-	if (res == 0) {
-		if (!monitor_task_is_running[adapter_no]) {
-			res = rte_thread_create(&monitor_tasks[adapter_no], NULL,
-					nt4ga_agx_link_100g_mon, p_adapter_info);
-		}
+
+	if (!monitor_task_is_running[adapter_no]) {
+		res = rte_thread_create(&monitor_tasks[adapter_no], NULL,
+				nt4ga_agx_link_100g_mon, p_adapter_info);
 	}
 
 	return res;
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 654e2dd80e..5e8eeb16a7 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -123,8 +123,7 @@ static int nim_read_write_data_lin(nim_i2c_ctx_p ctx, bool m_page_addressing, ui
 		 * Find out how much can be read from the current block in case of
 		 * single byte access
 		 */
-		if (multi_byte == 1)
-			max_seq_cnt = block_size - (lin_addr % block_size);
+		max_seq_cnt = block_size - (lin_addr % block_size);
 
 		if (m_page_addressing) {
 			if (lin_addr >= 128) {	/* Only page setup above this address */
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index ee2c2453e5..7b0c47e9b2 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -104,11 +104,6 @@ static int nthw_fpga_rst9563_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt2
 		nthw_register_get_field(p_curr_reg, RST9563_STAT_TS_MMCM_LOCKED);
 	p->mp_fld_stat_tsm_ref_mmcm_locked = NULL;	/* Field not present on 9563 */
 
-	if (!p->mp_fld_stat_tsm_ref_mmcm_locked) {
-		NT_LOG(DBG, NTHW, "%s: No RST9563_STAT_TSM_REF_MMCM_LOCKED found",
-			p_adapter_id_str);
-	}
-
 	nthw_register_update(p_curr_reg);
 
 	/* STICKY register field pointers */
@@ -126,11 +121,6 @@ static int nthw_fpga_rst9563_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt2
 	p->mp_fld_sticky_pci_sys_mmcm_unlocked = NULL;	/* Field not present on 9563 */
 	p->mp_fld_sticky_tsm_ref_mmcm_unlocked = NULL;	/* Field not present on 9563 */
 
-	if (!p->mp_fld_sticky_tsm_ref_mmcm_unlocked) {
-		NT_LOG(DBG, NTHW, "%s: No RST9563_STICKY_TSM_REF_MMCM_UNLOCKED found",
-			p_adapter_id_str);
-	}
-
 	nthw_register_update(p_curr_reg);
 
 	/* POWER register field pointers */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index d610e3a7cc..e7c9fec10d 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -184,8 +184,7 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 		/* reset specific */
 	switch (p_fpga_info->n_fpga_prod_id) {
 	case 9574:
-		if (rst9574_ops)
-			res = rst9574_ops->nthw_fpga_rst9574_init(p_fpga_info, &rst);
+		res = rst9574_ops->nthw_fpga_rst9574_init(p_fpga_info, &rst);
 
 		if (res) {
 			NT_LOG(ERR, NTHW,
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index eea220e40b..77400d2514 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -806,7 +806,7 @@ static uint32_t nthw_phy_tile_cpi_request(nthw_phy_tile_t *p, uint8_t intf_no, u
 
 	nt_os_wait_usec(10000);
 
-	for (int i = 20; i > 0; i--) {
+	for (int i = 20; i >= 0; i--) {
 		data = nthw_phy_tile_read_xcvr(p, intf_no, lane, phy_addr + lane_offset);
 
 		value =
diff --git a/drivers/net/ntnic/nthw/core/nthw_sdc.c b/drivers/net/ntnic/nthw/core/nthw_sdc.c
index fc73e6957c..ae967e5ed9 100644
--- a/drivers/net/ntnic/nthw/core/nthw_sdc.c
+++ b/drivers/net/ntnic/nthw/core/nthw_sdc.c
@@ -132,8 +132,7 @@ int nthw_sdc_get_states(nthw_sdc_t *p, uint64_t *pn_result_mask)
 	if (val != 0)
 		n_err_cnt++;
 
-	if (pn_result_mask)
-		*pn_result_mask = n_mask;
+	*pn_result_mask = n_mask;
 
 	return n_err_cnt;	/* 0 = all ok */
 }
diff --git a/drivers/net/ntnic/nthw/core/nthw_tsm.c b/drivers/net/ntnic/nthw/core/nthw_tsm.c
index b88dcb9b0b..a748c4e1ae 100644
--- a/drivers/net/ntnic/nthw/core/nthw_tsm.c
+++ b/drivers/net/ntnic/nthw/core/nthw_tsm.c
@@ -89,8 +89,7 @@ int nthw_tsm_get_ts(nthw_tsm_t *p, uint64_t *p_ts)
 
 	val = ((((uint64_t)n_ts_hi) << 32UL) | n_ts_lo);
 
-	if (p_ts)
-		*p_ts = val;
+	*p_ts = val;
 
 	return 0;
 }
@@ -108,8 +107,7 @@ int nthw_tsm_get_time(nthw_tsm_t *p, uint64_t *p_time)
 
 	val = ((((uint64_t)n_time_hi) << 32UL) | n_time_lo);
 
-	if (p_time)
-		*p_time = val;
+	*p_time = val;
 
 	return 0;
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 358ea3e4fa..90fc3f51a6 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -829,8 +829,7 @@ struct flow_nic_dev *nthw_flow_api_create(uint8_t adapter_no,
 
 err_exit:
 
-	if (ndev)
-		nthw_flow_api_done(ndev);
+	nthw_flow_api_done(ndev);
 
 	NT_LOG(DBG, FILTER, "ERR: %s", __func__);
 	return NULL;
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
index 69dec801f2..4babc30d2b 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
@@ -834,9 +834,6 @@ int hw_mod_flm_stat_get(struct flow_api_backend_s *be, enum hw_flm_e field, uint
 			break;
 
 		default: {
-			if (_VER_ < 18)
-				return UNSUP_FIELD;
-
 			switch (field) {
 			case HW_FLM_STAT_STA_DONE:
 				*value = be->flm.v25.sta_done->cnt;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 6bfa471321..c674531396 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -4267,8 +4267,6 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	RTE_ASSERT(dev);
 	RTE_ASSERT(fh);
 
-	int err = 0;
-
 	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	/* take flow out of ndev list - may not have been put there yet */
@@ -4318,11 +4316,6 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 		fh->fd = NULL;
 	}
 
-	if (err) {
-		NT_LOG(ERR, FILTER, "FAILED removing flow: %p", fh);
-		nthw_flow_nic_set_error(ERR_REMOVE_FLOW_FAILED, error);
-	}
-
 	free(fh);
 	fh = NULL;
 
@@ -4330,7 +4323,7 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	dev->ndev->be.iface->set_debug_mode(dev->ndev->be.be_dev, FLOW_BACKEND_DEBUG_MODE_NONE);
 #endif
 
-	return err;
+	return 0;
 }
 
 int flow_destroy_profile_inline(struct flow_eth_dev *dev, struct flow_handle *flow,
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index d6fdea2ddb..13813fe516 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -517,13 +517,6 @@ int nthw_rac_rab_read32_dma(nthw_rac_t *p, nthw_rab_bus_id_t bus_id, uint32_t ad
 		return -1;
 	}
 
-	if ((word_cnt + 3) > RAB_DMA_BUF_CNT) {
-		NT_LOG(ERR, NTHW,
-			"%s: Failed rab dma read length check - bus: %d addr: 0x%08X wordcount: %d",
-			p_adapter_id_str, bus_id, address, word_cnt);
-		return -1;
-	}
-
 	if (p->m_in_free < 3) {
 		/*
 		 * No more memory available.
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 87a0c3576b..e3ed22b89b 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1375,7 +1375,6 @@ eth_dev_set_link_up(struct rte_eth_dev *eth_dev)
 		return 0;
 
 	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
-	RTE_ASSERT(port == internals->n_intf_no);
 
 	port_ops->set_adm_state(p_adapter_info, port, true);
 
@@ -1401,7 +1400,6 @@ eth_dev_set_link_down(struct rte_eth_dev *eth_dev)
 		return 0;
 
 	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
-	RTE_ASSERT(port == internals->n_intf_no);
 
 	port_ops->set_link_status(p_adapter_info, port, false);
 
@@ -2201,25 +2199,23 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		NT_LOG(DBG, NTNIC, "Meter module is not initialized");
 
 	/* Initialize the queue system */
-	if (err == 0) {
-		sg_ops = get_sg_ops();
-
-		if (sg_ops != NULL) {
-			err = sg_ops->nthw_virt_queue_init(fpga_info);
+	sg_ops = get_sg_ops();
 
-			if (err != 0) {
-				NT_LOG(ERR, NTNIC,
-					"%s: Cannot initialize scatter-gather queues",
-					p_nt_drv->adapter_info.mp_adapter_id_str);
+	if (sg_ops != NULL) {
+		err = sg_ops->nthw_virt_queue_init(fpga_info);
 
-			} else {
-				NT_LOG(DBG, NTNIC, "%s: Initialized scatter-gather queues",
-					p_nt_drv->adapter_info.mp_adapter_id_str);
-			}
+		if (err != 0) {
+			NT_LOG(ERR, NTNIC,
+				"%s: Cannot initialize scatter-gather queues",
+				p_nt_drv->adapter_info.mp_adapter_id_str);
 
 		} else {
-			NT_LOG_DBGX(DBG, NTNIC, "SG module is not initialized");
+			NT_LOG(DBG, NTNIC, "%s: Initialized scatter-gather queues",
+				p_nt_drv->adapter_info.mp_adapter_id_str);
 		}
+
+	} else {
+		NT_LOG_DBGX(DBG, NTNIC, "SG module is not initialized");
 	}
 
 	/* Start ctrl, monitor, stat thread only for primary process. */
-- 
2.47.1

