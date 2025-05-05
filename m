Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE12C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:16:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25EC840A6E;
	Mon,  5 May 2025 09:15:30 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 14D3340677
 for <dev@dpdk.org>; Mon,  5 May 2025 09:15:29 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2108.outbound.protection.outlook.com [104.47.30.108]) by
 mx-outbound10-142.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLmAl1jNXCrbikvOQzv+fe+ADPbPzWV210fHg8PkvUyc6IHsp3/C1q6k9blDSxyrX2HKqIU6IjzlQfLDvpqxYMfMW0VQzx0UPlbQ7t8sgUWb8kjTHK8nscE0ju0Lfy7/8S1aCmyFzG/uoEm4M2svZFzAJTv3QH/AuZyL6t2U3gFy6SyP8ByBGLPA+tdkpdKhPQ22jmkqQZkbAKXo317FRy4rMYFKe8de3yMaqy7QNMkvZlizBb2rj61y7G5+BaEYJGHbRE+clyruwcK2ewxkv43xodnJ9oTdYSGlVRm1zhMVumH9Pg25fnm3OphsvUSf5t32ThNmlKQSHwaVJ3ApcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVEx7G7C+LsVi4HPn9KzN0CkPaFo1VyBOJ3IWV+tazs=;
 b=BtmRd5WOq8HbS/gazy/2hzWfZOuJCLJUAZVfI8ED1wzT6o+RQJmVlHcR1aojoc0+MRTr5fo/NNNZ3V0fUiBW1bV7u96ui1Q0re7TidcyOBlBktB8HD4cKs+gsFrecAZnkqJd3YU7ttDWsSSSpuX8c+FtF91we88U4HegQ0UbLj6+3/744dZTlt5o5ywJR5JMR/kDkY9Z173Ruw9gC6W1hTDrw51o8DSHky2ujQuxoK8k8VhoSOPBHN2P60LrleP+FiSGiE7+uLs7cDB/4STwzieGQ6WFhfNwasL21mPBAgzCmhH2Yrz4mW7uVAInpzHrPCSZVynfXJmnZq0BWrmF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVEx7G7C+LsVi4HPn9KzN0CkPaFo1VyBOJ3IWV+tazs=;
 b=dPuoTcmt32GV90vMwBXEeThDUxZn8hTiurqbyctm++NRYGFj9YFajV33euzqxluETWjqc/3U0J544Akvf6TzarWs0XF9tcaqXpOiARnRrwiU/p5AKZjIaotPLokmAdq/VTLtn5dJjISKZR2SjYj9OKJUyRSfsOHDdGzUbmplZto=
Received: from DU7P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::7) by
 PR3P190MB0890.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:93::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.25; Mon, 5 May 2025 07:13:25 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::c) by DU7P191CA0015.outlook.office365.com
 (2603:10a6:10:54e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:24
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 17/26] net/ntnic: enhance null checks and assertions
Date: Mon,  5 May 2025 09:12:57 +0200
Message-ID: <20250505071309.586015-18-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|PR3P190MB0890:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c1582671-af27-42e3-4c1c-08dd8ba453a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BtIy4kfHKe//haFjmhffTMa8YhjgzMgvGzm6ymNTFq2nE1h141v0Pk1+BN32?=
 =?us-ascii?Q?jXReUKVv3X/j09p2sJ88iXMfLwBi+5GErYgtBD8Rccp1wx4sxx8gUBgKvaQQ?=
 =?us-ascii?Q?/Tqt53W693LeGcPy/OEIor1cpOJlsSRwteozgR0wa/w3BYbQzm50K+++gagh?=
 =?us-ascii?Q?uf7+YSaNF3HQyhgPmbqSOrkdVFLWQt097IagSD1wL8pC/vAGHNzBzIRIpjAR?=
 =?us-ascii?Q?wPo46FbmM/Nw+hXkfQB+qrTBug0XDwLnlv7IQcxbir7F2rL3TYjdwXzvCAvF?=
 =?us-ascii?Q?yRZnsT+KTFQt277nZfrgBM1ECYX/D+ALru9yTMN+8RRlC1B0gmq8Q2po0BYQ?=
 =?us-ascii?Q?oqPtqx0bbexUPpZQawIowxmbMWvvIesNzSsQZ1JLl1N2xtq7ktjllBtdjFDt?=
 =?us-ascii?Q?mg7kRLEwLB7LzEd7BQb7Yh/vl6H/J1BiuseYQCSmMAyLSUHwtq1WopmtJJoB?=
 =?us-ascii?Q?fv0B6IpYjecSN/W0ylECMIuJojA3rllS64t00WSJeW3i6azU1fPx0BDPeEZU?=
 =?us-ascii?Q?4W4YGkOLbjGEsPReqTycvx2p/SQ/4/fPf4dXfvcPRba+wSETKj10ZPpkx8N9?=
 =?us-ascii?Q?VqEvEx534978bRD59nHC8BrOlif03gyQty/1eMtSK1m0v4PfI/Q24CzF57UN?=
 =?us-ascii?Q?ilzjxP3IottBarLgMaZwBqeKxG1DkiXcvjn0l6nOhx1bH+LT8loun/Rscn5y?=
 =?us-ascii?Q?cJfeoGEPo8TNPDZKzZg6HtoH4iWgGchr6ZkeJfqY+dfa9LgQffLREdQRFiIO?=
 =?us-ascii?Q?fGgCwcpegjhm0vAm+Trzvr2AH+eFzma2GoXOrL/42ulTRG9V0xQbsyqb3OYQ?=
 =?us-ascii?Q?BP8O/AXHvBP9MiWV2W6fmwfXE+qg8jEMgXGlL9nZyBztD6KcyFITKarrGOKE?=
 =?us-ascii?Q?k4ZdWuG/kv8x21Sok+cZTgh9DWd4lH8o9/wWMxYJUV+AMxTfuHxuQy6V4rbf?=
 =?us-ascii?Q?twatpydEcEpcr/yOZ4D6j/pNtDGcIJ0VAP4P9u3V5j4sn6yNQP/xiRICskh/?=
 =?us-ascii?Q?8LTJZk7HbPWgS+O9yAGPjqXvX7t8KyiAwRmVvj0KhTVq22qW9LP5A+K6zNEE?=
 =?us-ascii?Q?+DTqGU/SeubhPoK9fkxBOh4EABBkl5X5IHhQ4d3hlb4QPvudOXs411w0oP4r?=
 =?us-ascii?Q?LhGqwPko93G8RxP4iIKBY0sBmpRNRVflKiaN7+IwvOPBeQV25l4lUB0elk23?=
 =?us-ascii?Q?t7pFniaORXHLCyXQnFV5AcLKZaLGBt6ZZnAP2RgW/8D1HK3vf0zR2dpym4hd?=
 =?us-ascii?Q?OWplqKP+KGrl6cs9KDNiTMdr0vD/krgJLf1SGA611lHnHEGO9e3Tp4T6bxte?=
 =?us-ascii?Q?0ClEywo5U9F0To5B1lQpTd73e3z8r7100UXCsnhmJQcnOxWeZbzeQC775df5?=
 =?us-ascii?Q?wZ1MgVyL7FwKaKNH/bJBIZ2tHARWGvjh+hMunSiAXhdj5opg6MRjxM/p1IW6?=
 =?us-ascii?Q?zVUbmQqE8LnjmkPz+jIYfmLCXZOOvw2Qlhb9E4p655p7CIqnQAwyzYYPPtLn?=
 =?us-ascii?Q?uV3ncqbqAyuAqN+9cwKr8hpXkMdrkfGHBW4P?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fGpsIt3pu3/N06SPX5TQt8T9lGtOyP2SMEs3I2S68zdv7skP7VKZUqpIk8rJgF7Mj3HIBTrUTaMwcflJMz71xD7YSM+ebHpwomo57fyGL2S8u8UFSUUVpDnmujjfaANyLnME/0aco4VUFyrtBgGd8SS3W/OwsypOFCsmq4UmMfulE5lpNdDS68Erk84814EYJ7o6Jfv4ePYoJR1+cHpFuiSi8CmaWSIb/kqp6/fV2HFZgIx4uKPjnEJyTj8AGyAckr6SU+i7zSNcQJaDmHkZdlOcwvhCSQ8MnbL+i/nK/jcLS90ZKdNRcSTdAqzkW/WCzm5FGWnLdlATWTNBnICjmS2Fa7cWqPqNRsmr5QgYD0pxnx1O5UB5Yx2vLcwSAp6X+m+B6XJj5suKRDhQtb1LaPNlYekxwD6yAcs4J2YIJv+FoT0ITKjNkKFihGS42NEJBXLwfSEZNRAM3q6FXRaXDTGs7jclLfuRKAb5KPjDL3kZWg3LO0oUBB5ozIKH75NsdLInumS1FsVSC4wBmi0Qm3Rrvl7KLFOpxjPlzh0w8qktXQYyabIp5jXFwPfYiPSzLSf3J8zSaUmOUNHq7yCOicR5jWBe4IsGrWhVcXMMaajHRHGp2ppnEYgYJ4Vk5mkpPtEIhDTNcjpSCkCOFuVEcQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:24.8610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1582671-af27-42e3-4c1c-08dd8ba453a2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0890
X-BESS-ID: 1746429206-302702-7674-4869-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.30.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYmRhZAVgZQ0MjcONXIwsLIyM
 wsNSnV0iwlOdUgKdHc1NjY0tjIyNhEqTYWAJn3yy1BAAAA
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
index 920abd0221..d9088db4c0 100644
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

