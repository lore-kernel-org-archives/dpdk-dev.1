Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B8CC3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0590D406BC;
	Mon,  5 May 2025 09:14:14 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id E435240E03
 for <dev@dpdk.org>; Mon,  5 May 2025 09:14:12 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 mx-outbound45-79.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBnSi1Tyc54hKKhBjCoSBD3vpNARFO2r2UWHj06e5Q9Xzf9ytkQpa7kPKYx5iHfLbqTs1PZ7SptSAku1qCf4zq+Tyvh+eAo76WPe/JMLymk5cV7PTHkTTs96gz0RPh9c2SCH957siw/8sB9Ghbtrj0gMcM8EiQhrcde6hQ5emsQm8Mf9o9jMW22bAL7+YLJW/b+9Cf1hoN0sgTxNuCsME6RgzRqpzR4uspRgzrUltPAg1Sb1gzO05HIElceOdR4eFEqXdERBZICuDNQh604zpb4YTC+ABRHP4eYB4h8aAVabcctUgco2R94s/rmaAwrDrpDy1dbXdJdF/gxb25Z33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzV8KBtjlmStGTisTQ1DG7CQubTRMmoMcJy1qHaQtQE=;
 b=mKiDkL/pDn9Un6oBUDQ0+bTK9b8yDMKlGS9op/a0ChUOk//b/zGsZtXsTGAbkI8hLPgHj3CxSB4cGOFUQAISJw+c5i8OaCtSG5RL8DW3ySHVouRWJiee28fKdeVSrglgfBS2oO6A3h4/jKeYiJDgfzHSf3cQZ9kkzhZSIeuy5eZU8Iy0/h+uFy64SK8CCAYCSL8B7B49UDJRBYG43aaQDCGWWU4IzOThJ9VCMNR1fSnGj8za7W6Pa/90C/ld77TZfP/D2QKmkfoF+uq5MbY414dnNv2wjcKIGc4oilhOdWXEehr0LT4nY9D6ORc+XLx+q6mkwHUkWKgGljYqIkvY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzV8KBtjlmStGTisTQ1DG7CQubTRMmoMcJy1qHaQtQE=;
 b=Qv10kUO9m617M4paLULN1sxkqX5xMhjafDU7Ej/Z3vZkLq0/YZHIZiIMADx4cyNAVhNYO+16fMQBk9eyQv4iZxuD9h2+kINHrMtZzsGTFxNt1HaZ9jWcdvvqBxJPYieXEuTQczWu3mCvRiWJYZmVJ2X+1nNsdEy+GiA1a4/R1cs=
Received: from DU7P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::33)
 by DU0P190MB2025.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 07:13:20 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::b6) by DU7P191CA0019.outlook.office365.com
 (2603:10a6:10:54e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:19
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 10/26] net/ntnic: remove usless expressions
Date: Mon,  5 May 2025 09:12:50 +0200
Message-ID: <20250505071309.586015-11-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|DU0P190MB2025:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a922b425-6587-4c39-3869-08dd8ba450a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LkanXjYFroy3nCuD9nuh6cYSOF+1PZ7Q0rJD1GOpi5hcoaBOtWtBCKzm6kTD?=
 =?us-ascii?Q?05isumgCGppa3AcSkk7A9smq6bXyHJYee3Cm/e2zjMTabyc37t+KG/iHJnKC?=
 =?us-ascii?Q?k4DlFCbGQ//6cJcVpr0C8qWAseNuhYmwap8Y/Y0Gl4+o20eELoCgbKa36/Io?=
 =?us-ascii?Q?KsSehK3C6BfPxEFkCWbykgRwvGuzX0jFEvFngJ4sIOQfRLpihzro+mgD6Bdu?=
 =?us-ascii?Q?XItBYEqwBNEo8Jef4yw5WYOYEhtP8vy2MgP+gWTWY+95zD6T1hXp3OZRSO+l?=
 =?us-ascii?Q?2JSGchbkETOx0oeWuw2YUZGloaSybRDGbiFjkoSOacigGrH1TlWuvWVoCHNM?=
 =?us-ascii?Q?prY8xKze0s/xkaQ5hY9zHy5282JBGRRWDhvvkZyR77y+TcBmxQpfAwIGmhR6?=
 =?us-ascii?Q?SaehyE+l2Xh9B9aSnqTrVivM9TnBALfKeO+bHL6CU4oGJ3eRkm11maLxturS?=
 =?us-ascii?Q?bZSbDb+NkGFed20/PQxsY5O8Lym+KOujiCZ9jSYEBUQYCXZSSQBjeI1cTO+M?=
 =?us-ascii?Q?7PZmRzzngRCWqPcREQII6vAM6vgIHlYjlnkqw4n2mR9KY29zMQ7/xUzeeY1E?=
 =?us-ascii?Q?vQQxCBu9kA9GLhVPkrzhAj2vTqay47fLzFhKflTQqI5lS4BBXJovHBPq8jRx?=
 =?us-ascii?Q?AXAYzPy3JDCNE8xaUXD5KdZejFPNs0cWWSwncn+o0K4zP4MUGIcfjYSvjSfE?=
 =?us-ascii?Q?9yGaXejCKssvq0H4b0PK2+4jkJalKjfMWLnKW+di10JG7y/id/BcsT61oiUH?=
 =?us-ascii?Q?qIqwVNbXk4tIqxnvm1HGhFwtMI0vAl2S8O6m48EJHxSRlvUdeWXht1cyBxYs?=
 =?us-ascii?Q?1BmuColtYDo25uvuAtljZ0fzQejxkPeEp3WmHSpnGpYHIcp5IqQcISRS6AxM?=
 =?us-ascii?Q?q5NqZAGz9a5dF+fkpiCh0AHLA0UbAsu0wXYJA8YrLUIUMg14FRLjktTDEj9j?=
 =?us-ascii?Q?fdwQUcJxqtw5F0k5Noezo6i9bkq4cds8GfMWISrsok/N2K8B4DA6rIHt1L7C?=
 =?us-ascii?Q?4epCKmD6rmwFEnxhTQDR3c+sapbcS9feEXPtaKMq2ZpzJbGQ77sWuq2ectX7?=
 =?us-ascii?Q?2Onp7vIBopQ6c3TcUmwui1qTUuWtLvifCndsLcbVoACFMu0BdXtMq0CX1Jqk?=
 =?us-ascii?Q?vJ/ztnkq5/q36I/ysgOuNN00m77sX4B2FhvtetiHv2NL5xCMlA2Yq8EWE0Dk?=
 =?us-ascii?Q?sv3O2qMVim3bKAwLAh0wqYsfvFo4GnE4mfJCiQAn8fY7cO9P9L0xr21vlssS?=
 =?us-ascii?Q?5NnsbJxxE0WayBuJOz08wrgv4UYttpQV3RF7J6/N9tghlZ5SeYdbt/9mrOMe?=
 =?us-ascii?Q?/XYYq6UUyJUCg7SjAIINsKv8/fAaqx6a6NMRV1UBWyrMKC1GGrbMU528p1vp?=
 =?us-ascii?Q?OQlbaESat6BFW6ivn9g8z5wvUoM5TF63T7eTYaIpE4tkuSz9xj9ISAJeEnUm?=
 =?us-ascii?Q?vaiGrpa4tvHxA+TJB5ozcRDOJJCPSEEyxbvfpO44Vvd8oJGHrZC/Rlkw0w8L?=
 =?us-ascii?Q?ACyKtEP9wAAlkY0oD5NopHzeDx0s9nCs/aop?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZAKXqlYEvlDy2eSyAIHQtl3gEHltF6bdJLOxWf9P2JyE/6flnw4z5MA/QCaehLLMKmlthoNxtmx1XPpe3eVaaolouH1Rf8n+L/UUr7c3z8UXkhlQ8hlDEB4wx8oQF3/tn/v0ltZk3mr30O/XAFhXarNJB73fTSZfDA7i0Xe3KgUXdp02/FAlJX7orUKnxUj1+eYculk3vjpB5PyERfnGZRo3L8B+SqXSFK8fchGDYTNYCSSXEA5/f8Rqd/6TCkmQkRCF/4ES/ymUBMHjFADW8W56DP0DJd9UxgXu4YgRi3EH5gt63BgN1Upzune+VyBs2FJj4ZeVNB5UDGp+FiWEu3ZdFZU55ChTZpsqAjiMhoNbZ7z0lXuC/oPft7AmBybLEB6zNK7BH3D3pdhj4WZQOemLd2d1BFKVcGSloCFsDYcN/VnEernwo1a3ltXOSQc2D4v3TvL2s51lTsnGymItRHoWdvWJxIWS5d3gOPFtVDJ068rGFLsj1Qllqe9UdjmZQ+WKjtMvr/S8gzhGR6ow3zdNC0bLEyUAqQ/PP1U7yvNSE9jLxfwrz6TO6xmMkk0efVuKVSBfHO/F9CAr2bknwgbZoD5ppEVx+Sjovwp5V1XcO/DYfk3mAylfjTNdGeYSXjU3d8ir1MgZc25U3ge4xw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:19.8746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a922b425-6587-4c39-3869-08dd8ba450a9
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB2025
X-BESS-ID: 1746429202-311599-7744-352-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGpoYmQGYGUNQkxdIsNdEwyT
 jJPDEl0SjN0DjRwsww2cLS3CA5NdXMUKk2FgCQ5mn/QgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan20-254.eu-central-1b.ess.aws.cudaops.com]
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
index 156930bba8..920abd0221 100644
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

