Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA00C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1656B40E13;
	Thu, 20 Feb 2025 23:04:41 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 8304140DD2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:31 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agqA0RXv/Vz2ESlSFbbxh4KjZkDtWmHPdlpTCYyms19ZCeXwGfKgTOCUIhKGfZMR/KAvM6JEmiGw/8iHQxjvSTH/DQUnbvJzNRI+OvcFHswL8iUKkQw8eJ7t/ywaNgUgAlElH0FuxpjhGOOJx2giqVqXkXVu38zUX4YXa4IxpIj6phxA/H+Hrw4GY5x46qwlFWEqOsYLKQB58Q0uxrYgC/iKeeLIiWc/5nNasQRDv8lMTgPr2gI13FzfMoHG6SR3FJGvPrBd8oorxYtGmVwRKL1rdCDvJJeGU98BD+nhJ5J6MHadlcBfmGei/xi5jWMk7944wot6psBOXvXsEhMjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7ICxblWr0ouLy6kn81vJDI17fzpEm+mOSTCpV9ceEE=;
 b=WBTn/sF1Qv+QzgmJb6Y7SyWqDT8GbZBc2ogOApmeJCJoVsYl+NhK0Jj8izPXe9dny5iE7bjdzPLtULGPPfeELcUNI4CuvfW/cYcbNQVxWatTzRM9/GesYLGpFfRfrYVbG3FBapXbr98bOsL2D5L5PUWKwkG6kbRvcETpkCybwu9+YL7pRu/ZeUpoCHH+8DlV8cZVHhSCdFD1fdvSJOrYTyiGSoGHIUVmLX+80sReu8k2K7EjyjbMvOcRkHPagk6Se8VvQ2PNdVBtY/ueb5xNwbbkCORr1l4XXAXOs5zIRmcJK/bSuBOHHXs3UxrfYJ9EDaQSY/iG51HTrkSxAnq1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7ICxblWr0ouLy6kn81vJDI17fzpEm+mOSTCpV9ceEE=;
 b=ZFaa2MRftCTUSrQpYCtKbptS1HJ+WmdepxbYiHbnScOOvGhUlI9pq9Fdqpp4r4XBTkEx1mo7NJ2yumIb/1Xg1vS1KwjauL8RhnXCxtA9g9LZc/zPLHfZ+aFPFbsfge2aSFm419FgxkfChp2kspyEbJukkbRqvi9I4phgdrrRqr0=
Received: from CWLP265CA0502.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::16)
 by GVXP190MB2180.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:27 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::f7) by CWLP265CA0502.outlook.office365.com
 (2603:10a6:400:18b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:26 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 19/32] net/ntnic: add PHY ftile reset
Date: Thu, 20 Feb 2025 23:03:43 +0100
Message-ID: <20250220220406.3925597-20-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|GVXP190MB2180:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b0ed69da-ae6b-4002-ed6d-08dd51fa8ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AJnSk5kcZxnvXriY+EX5oA9vBkTNRSbpGtJOs1DTFxwWLcCvN72rLUddgncR?=
 =?us-ascii?Q?Py1pnHp8a5r5hIws+Yl0GZdgGeg6dNxaHhqCWYKjE4y4MaH9UgMOESchrui1?=
 =?us-ascii?Q?a53WHRdMfp85hnt5HUCw3UZ8S9jPj9IpBWdKZSRIWaHw8/ix9cCT+TwaAB81?=
 =?us-ascii?Q?m9qMb3g4cYWHN2/NzzaaDwLmVU6hMY64Fl0HnkoYrpyaBXsQfNMhfLU+aC/P?=
 =?us-ascii?Q?wN06md5tnFACbfFUxJPV5TlSdi7QVeSytmfXuYVBp6NG+Bj1AgQ9FFPQbYlf?=
 =?us-ascii?Q?xR1SfVik3BYgYc1/8JOp7EE62QuZEShXksKKENrcATlG95F4HCDdO4r/xmG3?=
 =?us-ascii?Q?Zqvr+/zSRbbUn6DiBfxHtgot5FXYI55d8ZTt/bQryKXSCaCjPTKt9lnt7yAN?=
 =?us-ascii?Q?905DvpE0TbAvvtOgzuRkDN26YUnBep2pFBeXcbXpj+xm2tUZArNOT7IZf4O+?=
 =?us-ascii?Q?wVNFVRK/MKnBKO3v5bieXQCWw5g5NeDr2ypZWRGIkxpyhoTAKeM6CdnjWeC8?=
 =?us-ascii?Q?n7ou/sVExFrzCOXlEEasDQwHTVB2A+ozmb0ye3uBUtHbunPFD37HE/McUSvK?=
 =?us-ascii?Q?5kUpOHMpMenG3j8RBAsKqjakIPCbxP8mLl5AgqKQzFOs1+Wpjz27/h4/Tp69?=
 =?us-ascii?Q?x2MPWlt+woWaypBS/3jnLcBDnd6jZ74EmQDi6FP9Ko2fN2IFG2HgbBK+pt5V?=
 =?us-ascii?Q?yqlSluPdP+kJhzRwL0Vp4cq+st2lSh65JUHMyGgCPsZeTlgOPlDds0Tc1175?=
 =?us-ascii?Q?eaUij6yZezsItd/ILxNIIZDRpgfGDYnTTZwrZqd9gkORMKVVPVVD12Sb/Osu?=
 =?us-ascii?Q?DljUydAAtA539URizENb/x9TBt7Wcww8aUNqtKgzmjiieOhTqP+aG9ycLQEO?=
 =?us-ascii?Q?uvESXLvxiI0ExGeC27NC3njN23WRgvfbSy+pf5QdPj8F0b9HVyjkB0w3Kj1c?=
 =?us-ascii?Q?457jz6h2uPQfxH26J+12e6UHtnV9KcSxWmPOmXBSa2f7VgVKVyGAH1l8bfQ1?=
 =?us-ascii?Q?UwPL7HqGfA7Fvg6xPTTh3mSfkoSnICdFkeENgbwdU4rE+eHYEIdWD3bkvaC2?=
 =?us-ascii?Q?B8EbRSP0SQ7GSBosdsg7T6FmnmvVDRrp9REWF3uep8ScTUp4G//R9+mAR0Z/?=
 =?us-ascii?Q?LiZ2eURZLn0+mKXImSdwfxG61ehiG+iJZUZNb4iDPyrIk29YXgE2irRk3iOg?=
 =?us-ascii?Q?cnTlCU7KMuokOowlSEWJuOV/spggLlLgt/8GrYW9IiWUGVJmVIFj1i86CRnv?=
 =?us-ascii?Q?AKIWbyP9D7gVUgmL6Ye58zZ2nNWXXXRTxlpwaWAZJbogg2g57O6q9S3XCqBf?=
 =?us-ascii?Q?19wtDrTDE/X2653vz2YzY3LPntZVNDQd/dgjHx75d61v/VINEhsc/+znPGhI?=
 =?us-ascii?Q?DWwlDrdnMGDC+2aFbEEq/F0t4ums/3RKo+hVbs6YnE8yl6fvjj6gCajJ+O9V?=
 =?us-ascii?Q?IknWQVGaqJMgL0zvKtnfC+qJCEKnzBG4mCfjT8yBZvQCqCaWSC7POhIQfBqh?=
 =?us-ascii?Q?pMFNvpwKDox00HY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f0R9YXIjwJNgjkTCjtBnrkyZRRKyw9puT2F1y2WS1jLy21grEBvdpCnhCLgEwmo4KpapEkPky45UiBnAG07OPe1Hgjrw4U1qtyT8S+AS8klQiidt3lOzon2sGQq7D0kNaVzWySJJUqOWksMQgcRkV3omM+MfjMSHeKvzTpxZiqdUHDvluKq4FegTRfYz+LlVTlzYxYJe/3qOs0uI1Fq6We7uWDH8A8thrfsVHgI5HOO3N7nBNRoZGNjSCwWklCqACIHBw9zC2yoNyalZ0pBe0NBp9QZ7RlAQniB0HxIDVDAWMG8xzXnYQy2fatOYIU8TUnifY3GfxWr5V+8dYDtX0oDK381Ohq4X304SH7v0/PLZ3NCf+md+QMz32NcjrsrD1SeFTp8/8OYpWUKZK2Y11Q50b2uigV0Hj1lvuPQoMG9nYJfwOmuBNV0x0FJd+MXzvW+NtPl4/mvRXVHOp4b/LGb3IYmv4IaDpqnWQsVEVZTd1fNw1gqmJEBmBe8+yAnOfLS1OyI10SBeSx3u2mpWgs6JkP/tD5xyudrv6c8SwQCoVWLHbUPG5Vy+U0APjGZjNFQnLNrhSfjmpKwwXTkmqzcl1ZDPbiBKyDq6vOO7aTtzLfa50cQoUpn22Fh6weueoQrmBCs/zhbBFJ7Am2ZOQKZ3rnZZ6bMen3GkKaxwYd8=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:26.7089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ed69da-ae6b-4002-ed6d-08dd51fa8ac2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2180
X-BESS-ID: 1740089070-312005-29066-14097-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpbm5iZAVgZQ0CgxzTzVwszEKN
 k0LcnMMNXSIC3ZMCnJOMU0MSUlKcVCqTYWAJpCso9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-233.eu-central-1b.ess.aws.cudaops.com]
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

Add reset functions and reset procedure for module PHY FTILE

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |  12 ++
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   | 161 ++++++++++++++++++
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |  38 +++++
 3 files changed, 211 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
index f84aef44a9..68d8455b8d 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -8,6 +8,10 @@
 
 #include "nthw_fpga_model.h"
 
+enum mac_pcs_mode_e {
+	MAC_PCS_MODE_2X100
+};
+
 struct nt_phy_tile {
 	nthw_fpga_t *mp_fpga;
 
@@ -16,6 +20,8 @@ struct nt_phy_tile {
 	int mn_fpga_version;
 	int mn_fpga_revision;
 
+	enum mac_pcs_mode_e mac_pcs_mode;
+
 	nthw_register_t *mp_reg_port_xcvr_base[2][4];
 	nthw_field_t *mp_fld_port_xcvr_base_ptr[2][4];
 	nthw_field_t *mp_fld_port_xcvr_base_busy[2][4];
@@ -39,6 +45,8 @@ struct nt_phy_tile {
 
 	nthw_field_t *mp_fld_port_status_rx_hi_ber[2];
 	nthw_field_t *mp_fld_port_status_rx_am_lock[2];
+	nthw_field_t *mp_fld_port_status_reset_ackn[2];
+	nthw_field_t *mp_fld_port_status_tx_lanes_stable[2];
 	nthw_field_t *mp_fld_port_status_tx_reset_ackn[2];
 	nthw_field_t *mp_fld_port_status_rx_reset_ackn[2];
 
@@ -93,5 +101,9 @@ uint32_t nthw_phy_tile_read_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t la
 	uint32_t address);
 void nthw_phy_tile_write_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, uint32_t address,
 	uint32_t data);
+uint32_t nthw_phy_tile_get_port_status_reset_ack(nthw_phy_tile_t *p, uint8_t intf_no);
+uint32_t nthw_phy_tile_get_port_status_tx_lanes_stable(nthw_phy_tile_t *p, uint8_t intf_no);
+uint8_t nthw_phy_tile_get_no_intfs(nthw_phy_tile_t *p);
+void nthw_phy_tile_set_port_config_rst(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t value);
 
 #endif	/* __NTHW_PHY_TILE_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index 27d60d1448..b1bbe28709 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -79,17 +79,44 @@ static void nthw_fpga_rst9574_set_default_rst_values(struct nthw_fpga_rst_nt400d
 	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, 1);
 }
 
+static void nthw_fpga_rst9574_sys_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_sys);
+	nthw_field_set_val_flush32(p->p_fld_rst_sys, val);
+}
+
 static void nthw_fpga_rst9574_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
 {
 	nthw_field_update_register(p->p_fld_rst_ddr4);
 	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
 }
 
+static void nthw_fpga_rst9574_phy_ftile_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_phy_ftile);
+	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, val);
+}
+
+static bool nthw_fpga_rst9574_get_phy_ftile_rst(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_rst_phy_ftile) != 0;
+}
+
 static bool nthw_fpga_rst9574_get_ddr4_calib_complete_stat(struct nthw_fpga_rst_nt400dxx *const p)
 {
 	return nthw_field_get_updated(p->p_fld_stat_ddr4_calib_complete) != 0;
 }
 
+static bool nthw_fpga_rst9574_get_phy_ftile_rst_done_stat(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_stat_phy_ftile_rst_done) != 0;
+}
+
+static bool nthw_fpga_rst9574_get_phy_ftile_rdy_stat(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_stat_phy_ftile_rdy) != 0;
+}
+
 static bool nthw_fpga_rst9574_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
 {
 	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
@@ -145,6 +172,69 @@ static int nthw_fpga_rst9574_wait_ddr4_calibration_complete(struct fpga_info_s *
 	return 0;
 }
 
+static int nthw_fpga_rst9574_wait_phy_ftile_rdy(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
+{
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	uint32_t complete;
+	uint32_t timeout;
+
+	/* 5: wait until PHY_FTILE reset done */
+	NT_LOG(DBG, NTHW, "%s: %s: PHY FTILE ready", p_adapter_id_str, __func__);
+	timeout = 50000;/* initial timeout must be set to 5 sec. */
+
+	do {
+		complete = nthw_fpga_rst9574_get_phy_ftile_rdy_stat(p_rst);
+
+		if (!complete) {
+			nt_os_wait_usec(100);
+
+		} else {
+			NT_LOG(DBG, NTHW, "%s: PHY FTILE ready, margin to timeout %u",
+				p_adapter_id_str, timeout);
+		}
+
+		timeout--;
+
+		if (timeout == 0) {
+			NT_LOG(ERR, NTHW, "%s: %s: Timeout waiting for PHY FTILE ready",
+				p_adapter_id_str, __func__);
+			return -1;
+		}
+	} while (!complete);
+
+	return 0;
+}
+
+static int nthw_fpga_rst9574_wait_phy_ftile_rst_done(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
+{
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	uint32_t complete;
+	uint32_t timeout;
+
+	/* 5: wait until PHY_FTILE reset done */
+	NT_LOG(DBG, NTHW, "%s: %s: PHY FTILE RESET done", p_adapter_id_str, __func__);
+	timeout = 50000;/* initial timeout must be set to 5 sec. */
+
+	do {
+		complete = nthw_fpga_rst9574_get_phy_ftile_rst_done_stat(p_rst);
+
+		if (!complete)
+			nt_os_wait_usec(100);
+
+		timeout--;
+
+		if (timeout == 0) {
+			NT_LOG(ERR, NTHW, "%s: %s: Timeout waiting for PHY FTILE RESET to be done",
+				p_adapter_id_str, __func__);
+			return -1;
+		}
+	} while (!complete);
+
+	return 0;
+}
+
 static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -191,6 +281,77 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 			p_adapter_id_str, __func__);
 	}
 
+	int32_t tries = 0;
+	bool success = false;
+
+	do {
+		/* Only wait for ftile rst done if ftile is indeed in reset. */
+		if (nthw_fpga_rst9574_get_phy_ftile_rst(p_rst)) {
+			/* (5) Wait until PHY_FTILE reset done */
+			NT_LOG(DBG, NTHW, "%s: %s: Wait until PHY_FTILE reset done",
+				p_adapter_id_str, __func__);
+			res = nthw_fpga_rst9574_wait_phy_ftile_rst_done(p_fpga_info, p_rst);
+
+			if (res)
+				return res;
+		}
+
+		/* (6) De-assert PHY_FTILE reset: */
+		NT_LOG(DBG, NTHW, "%s: %s: De-asserting PHY_FTILE reset", p_adapter_id_str,
+			__func__);
+		nthw_fpga_rst9574_phy_ftile_rst(p_rst, 0);
+
+		nt_os_wait_usec(10000);
+		/* (7) Wait until PHY_FTILE ready */
+		if (nthw_fpga_rst9574_wait_phy_ftile_rdy(p_fpga_info, p_rst) != -1) {
+			success = true;
+			continue;
+		}
+
+		if (++tries >= 5) {
+			/* Give up */
+			NT_LOG(ERR, NTHW, "%s: %s: PHY_TILE not ready after %u attempts",
+				p_adapter_id_str, __func__, tries);
+			return res;
+		}
+
+		/* Try to recover with as little effort as possible */
+		nthw_phy_tile_t *p_phy_tile = p_fpga_info->mp_nthw_agx.p_phy_tile;
+
+		for (uint8_t i = 0; i < nthw_phy_tile_get_no_intfs(p_phy_tile); i++) {
+			/* Also consider TX_PLL_LOCKED == 0 */
+			if (!nthw_phy_tile_get_port_status_tx_lanes_stable(p_phy_tile, i)) {
+				success = false;
+				NT_LOG(WRN, NTHW,
+					"%s: %s: PHY_TILE Intf %u TX_LANES_STABLE == FALSE",
+					p_adapter_id_str, __func__, i);
+
+				/* Active low */
+				nthw_phy_tile_set_port_config_rst(p_phy_tile, i, 0);
+				int32_t count = 1000;
+
+				do {
+					nt_os_wait_usec(1000);
+				} while (!nthw_phy_tile_get_port_status_reset_ack(p_phy_tile, i) &&
+					(--count > 0));
+
+				if (count <= 0) {
+					NT_LOG(ERR, NTHW, "%s: %s: IntfNo %u: "
+					"Time-out waiting for PortStatusResetAck",
+					p_adapter_id_str, __func__, i);
+				}
+
+				/* Active low */
+				nthw_phy_tile_set_port_config_rst(p_phy_tile, i, 1);
+				nt_os_wait_usec(20000);
+			}
+		}
+
+	} while (!success);
+
+	/* (8) De-assert SYS reset: */
+	NT_LOG(DBG, NTHW, "%s: %s: De-asserting SYS reset", p_adapter_id_str, __func__);
+	nthw_fpga_rst9574_sys_rst(p_rst, 0);
 
 	return 0;
 }
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index b057e9e88c..a8c2d03be9 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -44,6 +44,17 @@ static const uint32_t eth_soft_csr1 = 0x200;
 static const uint32_t eth_soft_csr2 = 0x204;
 static const uint32_t eth_soft_csr3 = 0x208;
 
+uint8_t nthw_phy_tile_get_no_intfs(nthw_phy_tile_t *p)
+{
+	switch (p->mac_pcs_mode) {
+	case MAC_PCS_MODE_2X100:
+		return 2;
+
+	default:
+		return 0;
+	}
+}
+
 static void nthw_phy_tile_set_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset)
 {
 	/* Reset is active low */
@@ -543,3 +554,30 @@ bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enabl
 
 	return true;
 }
+
+uint32_t nthw_phy_tile_get_port_status_reset_ack(nthw_phy_tile_t *p, uint8_t intf_no)
+{
+	if (p->mp_fld_port_status_reset_ackn[intf_no]) {
+		return nthw_field_get_updated(p->mp_fld_port_status_reset_ackn[intf_no]) == 0
+			? 1
+			: 0;    /* Inverted */
+	}
+
+	return 1;
+}
+
+uint32_t nthw_phy_tile_get_port_status_tx_lanes_stable(nthw_phy_tile_t *p, uint8_t intf_no)
+{
+	if (p->mp_fld_port_status_tx_lanes_stable[intf_no])
+		return nthw_field_get_updated(p->mp_fld_port_status_tx_lanes_stable[intf_no]);
+
+	return 1;
+}
+
+void nthw_phy_tile_set_port_config_rst(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t value)
+{
+	if (p->mp_fld_port_config_reset[intf_no]) {
+		nthw_field_get_updated(p->mp_fld_port_config_reset[intf_no]);
+		nthw_field_set_val_flush32(p->mp_fld_port_config_reset[intf_no], value);
+	}
+}
-- 
2.45.0

