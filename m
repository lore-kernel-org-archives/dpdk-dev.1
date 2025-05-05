Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B683C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:14:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14C0B40A87;
	Mon,  5 May 2025 09:13:47 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1698E40A6E
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:42 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2173.outbound.protection.outlook.com [104.47.51.173]) by
 mx-outbound45-79.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwG50e3Ss+AEWL9/o5sQmp0U+7Bum+8346SSg8/cYFmyKi4b/oCqI/o+iJjHN5P7ZN+oPyM552774HjsEUqNwbOKw6yu9rzB/Nj0zQJ+FlcSQAZ9iC+eWfNsqhoLOpAGMQO66PI7UBWdQMclod4T6lfUHveIMdjULABdXS9nOxB7yOycP74/C4+3hk1/1KphAJOHsuMvpqRiaIOltdf/LbRBn8frh4TfDdtrhiRVgUCeLoisR0KOrWdN2X5kZeTfw6puG/ToDbAAkbzhKK8JwsJsTO5Xre/0/6nXxrRB8p+AtYHHq9VZC3tjYtF/vH1Y3/U1cSIscVFWzQ2G3gHnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W43BOKGIOibUscTbxJirEqbhWq1wapcOMO4vCPlMAo=;
 b=lEx8Bvq0HEPdZaxC2FCnHRyvuANA3Zwq7ESvZC/KelCDYb43ymOh5gMO9pnCAkIwhSD8l5YhclBeWlBpUM8gsSIuehkoQrkqA4CFKqgYr3YSj/n1NpOoYrvZ9rM79atsujYJ+88Y4c0DqXHQep852SRd9wNmbg0OwLfat4djbtKwSBWz8lWfJ6joVw0g7f5fGtk2elnvGxHQx4YYxdMTLBPtppwvQ2lpWW/cQ4Xu4bssSd/j/aZNOiYb0IqTN5Mai/N1FGtbLTehm2Xm0dWrK8T9CRzCrUb91XsPkMnFob335z7gSKNZIuUy+M9GAS7lR+gfTgekoDUyIIumGYkKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W43BOKGIOibUscTbxJirEqbhWq1wapcOMO4vCPlMAo=;
 b=iy04gVehxM3AsmrZFxvNU8XUTxoy6OmNYuRmHI3OnW4qp8MkBDiQWLV+yrn4hv+WkBae/LNLsejoYgfxiC4rIO9QBxXqx/S3PqLECNsDH9+9tF2MIb40cZL1NXqvmFjo6FTrGG7e1II6DbHSqz1yB0KtJkswrGHdtJkqeygq4CY=
Received: from DU7P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::16)
 by AM0P190MB0740.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:191::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:26 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::ca) by DU7P191CA0024.outlook.office365.com
 (2603:10a6:10:54e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:25
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 19/26] net/ntnic: remove redundant assignments and branching
Date: Mon,  5 May 2025 09:12:59 +0200
Message-ID: <20250505071309.586015-20-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AM0P190MB0740:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e6ad9d3b-3b02-435f-1b7b-08dd8ba45441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ztvP/cMl0ekOjYMpRjrytBKu5w2YEG8fL5Bhs0uxfdZo+v7ZQ363m4ktn1X?=
 =?us-ascii?Q?1td/Uxftp4lo7+rgVxBWAh+lcEHtOIhiEJlqaoC7UAePX41t0Vyij59Qy5N8?=
 =?us-ascii?Q?fAOD35zwNjSEGtUY0ymjlGi4fFw1hSSqRqVNVZp0CoUEm39ykBYSqBmPNvRI?=
 =?us-ascii?Q?jVgUz4VC/GaYrhSyPkFyShSrjyaMfblpNJsS3DrL/uosvEQlt5eZ+cq6t6b9?=
 =?us-ascii?Q?HjrvfdoQRjvoe9fiEJdggriwuNh4F0NDlApTfOwcclb1CWxYjniQEN84p2Rs?=
 =?us-ascii?Q?rc0e5FdabWkHCNKPY68BA0Oha9bvYc7gXl9TwDsZiipXW6+T2WbmX8BttzdX?=
 =?us-ascii?Q?cPOGRFP4fUTcDq6TbED8MmHi/bd6lOY/hV64kmCKnX7PiYaPmKIwCZ5pyCZO?=
 =?us-ascii?Q?JDAmW78J3JE4O9xY1vlMq8ZjotOMwEts9aWu6ztcJkv6+s9aOokdklQF0RQv?=
 =?us-ascii?Q?oii4l23ELYcviOCaDOErMweziyrn/KhwwFC0yv4yhNivG/EBmCKSrIfNhjeT?=
 =?us-ascii?Q?3ucCAhvyYaE9eBMMCnARo7stImd6sDJCe2gGBDcCxVQnXccUDEZ+hTkqxKKh?=
 =?us-ascii?Q?yxl4+WDuiaaMDwjhIyp1u0vwXUk9eEsgP7+0CANuwZjrYhvYxptJ4CiTpeqL?=
 =?us-ascii?Q?bARHNie7cvSY19og9LLmJOc73Z6bcLMLo9ukkX6ZAGYtuAKiQFGr95YTriJF?=
 =?us-ascii?Q?PO+y9xe/VpcslvKsH7G/L/dpHEnPWdf1MCydrdDwpvQQEZc1ReEu5WzRtSJS?=
 =?us-ascii?Q?SBiMd8JdapiJ8b+FZVkQg60kCApqVo9DateumHOPWL+LBFUKfD1F4XhD3/nS?=
 =?us-ascii?Q?fqdBUeHVQXKEzXoJ8KdyAQm2luRcduX6y65B//2FaO9cQ3wmh/dfD/Z0n7Oo?=
 =?us-ascii?Q?tuXJHRTxorcsJkCRrD3LLam1nvgZzXlYt2Zv9N0Ktxgd9nN7vhcMwYZOhWbJ?=
 =?us-ascii?Q?1nNMV8zMoPvtDTk7iJlKeaUzOoMugZc/PNmXFXZ0phOkMBsP3sVvgRkqbgw1?=
 =?us-ascii?Q?VEB7yRg2JBRUH7F4oO6IHo8kE3xN+NSbpy0zwhQMrp7ckirVQk2I8SvDbMea?=
 =?us-ascii?Q?eeiQWgPdq4bF1bRP2sqWYoT7hu+M4oEA9dy/D88WYmDdlfZtQYlkWfpZh0ZD?=
 =?us-ascii?Q?pTU35xJQzdeH+coPjFj70SGFVW5K5rZWWE/nPpArgQtbSOt10N69epyVJ6ka?=
 =?us-ascii?Q?FGiZFabIsCYM4yj+1a/jt/wxFc9i+Imsancbwx3e5KeNI6nbY6WZd/p00XAv?=
 =?us-ascii?Q?nRi8VXnHGdVWMR5S8/CxI10cD28qOw8RGNQLYcw1VowHuD1YEU3PyGg5nzcY?=
 =?us-ascii?Q?7x+CL+YWrX5voxD06MQ7MKSFDm4lFxVQbMJ55U8yXtTo7u9h8BntNoA4k1sV?=
 =?us-ascii?Q?iiu2l6W/6QL+G/6EC6pXODaKE68+n+PZp2RzdekgZAAklN0Adk2ODWpk2Ruv?=
 =?us-ascii?Q?1PK1DydFfAlGeUhkIZvjnjNEnFQ491TFKB9LocGuwJ2a2tgxmYA1I9kGDwS1?=
 =?us-ascii?Q?GRGm5RrEf2MJIlUPwyvhl5gH+oIh8ogCxkDc?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sJZbxu1+a4GumjBlw0fkreQGyGt5PnE2HrymzPMeLrLU1qNe4WEwY+/SsP0d02Z4sCm4d0OYT+MId+Sm/mqeh/8F3wJ+dUi06mqTpWo4JFmT1nSFFVxDWEJPRvTW131F08HSPCp2kXCb1kAyxZ4gq/zH22w94lG6+/irhWg5gS4Frbn70ksf0ZcX13HalP0LZoeo3HrzdRjR0XHKhcWc8GvGsh7BR74eVjg8LEDCPltkH/vrKWp7yLyF/th6mWQsnj0B8kHVoZUTf6Umm48rUe3n3IVoKzmMkbg250K+1MVkUiG2th3JVMrwVo9KNcestnWQihjs5DSpuuzfuXsasdgvInB07IxFOjTL9U+n3w2MHS2bAcG9RR6HVRpPnwlMQ7gkbUarKmzN+mGnEsyU5bFi8Dd5i8Bj20wy7TeV7HIOJ00WPPdQPHetMdSMdvkIQQj6EKy3aOUWeOAG0GUwEDN4DfB9784fl5ejCuXF8rlXz3yTQuPir5S76dgioGEpoGfJygFEjPW8MsCPHGuiaVPTEQ5MvjTd12XWRi7pGXeqo2n44+RVW6QgIaoJhYJNPhIMeqSYDDw59dJI+20/Kjo4elqBxANSZgTwtJGRlhJ6at6mVFuciA/KamCMruIiC3JisSW3iRnPhbIK+VZy9A==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:25.9034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ad9d3b-3b02-435f-1b7b-08dd8ba45441
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0740
X-BESS-ID: 1746429207-311599-7749-347-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZG5uZAVgZQ0MDIxNLAIMUs2T
 zZ0iQx2cLc3NDC0MDc1NwsOTnVIjVFqTYWADyLEINBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan19-189.eu-central-1b.ess.aws.cudaops.com]
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

Remove double if statement branching as far as it has the same fillings.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 22 ++++++-------------
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c   |  1 -
 drivers/net/ntnic/nthw/nthw_rac.c             |  3 ---
 drivers/net/ntnic/nthw/stat/nthw_stat.c       |  1 -
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 64db55f6e9..6d1d01d265 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -685,21 +685,13 @@ static int nim_ready_100_gb(adapter_info_t *p_info, int port)
 		return 1;
 	}
 
-	if (port == 0) {
-		/* setTxEqualization(uint8_t intf_no, uint8_t lane, uint32_t pre_tap2,
-		 * uint32_t main_tap, uint32_t pre_tap1, uint32_t post_tap1)
-		 */
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 0, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 1, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 2, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 3, 0, 44, 2, 9);
-
-	} else {
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 0, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 1, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 2, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 3, 0, 44, 2, 9);
-	}
+	/* setTxEqualization(uint8_t intf_no, uint8_t lane, uint32_t pre_tap2,
+	 * uint32_t main_tap, uint32_t pre_tap1, uint32_t post_tap1)
+	 */
+	nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 0, 0, 44, 2, 9);
+	nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 1, 0, 44, 2, 9);
+	nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 2, 0, 44, 2, 9);
+	nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 3, 0, 44, 2, 9);
 
 	/*
 	 * Perform a full reset. If the RX is in reset from the start this sequence will
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index 7b0c47e9b2..918ac71a43 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -59,7 +59,6 @@ static int nthw_fpga_rst9563_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt2
 	p->mp_fld_rst_mac_rx = nthw_register_get_field(p_curr_reg, RST9563_RST_MAC_RX);
 	p->mp_fld_rst_mac_tx = NULL;
 	p->mp_fld_rst_ptp = nthw_register_get_field(p_curr_reg, RST9563_RST_PTP);
-	p->mp_fld_rst_ptp = nthw_register_get_field(p_curr_reg, RST9563_RST_PTP);
 	p->mp_fld_rst_ts = nthw_register_get_field(p_curr_reg, RST9563_RST_TS);
 	p->mp_fld_rst_ptp_mmcm = nthw_register_get_field(p_curr_reg, RST9563_RST_PTP_MMCM);
 	p->mp_fld_rst_ts_mmcm = nthw_register_get_field(p_curr_reg, RST9563_RST_TS_MMCM);
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index 13813fe516..33e0caa581 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -93,9 +93,6 @@ int nthw_rac_init(nthw_rac_t *p, nthw_fpga_t *p_fpga, struct fpga_info_s *p_fpga
 	if (p->mp_reg_dbg_data)
 		p->mp_fld_dbg_data = nthw_register_query_field(p->mp_reg_dbg_data, RAC_DBG_DATA_D);
 
-	else
-		p->mp_reg_dbg_data = NULL;
-
 	p->mp_reg_rab_ib_data = nthw_module_get_register(p->mp_mod_rac, RAC_RAB_IB_DATA);
 	p->mp_fld_rab_ib_data = nthw_register_get_field(p->mp_reg_rab_ib_data, RAC_RAB_IB_DATA_D);
 
diff --git a/drivers/net/ntnic/nthw/stat/nthw_stat.c b/drivers/net/ntnic/nthw/stat/nthw_stat.c
index ed30173bdc..2ddef052a5 100644
--- a/drivers/net/ntnic/nthw/stat/nthw_stat.c
+++ b/drivers/net/ntnic/nthw/stat/nthw_stat.c
@@ -254,7 +254,6 @@ int nthw_stat_init(nthw_stat_t *p, nthw_fpga_t *p_fpga, int n_instance)
 		p->mn_stat_layout_version = 1;
 
 	} else {
-		p->mn_stat_layout_version = 0;
 		NT_LOG(ERR, NTHW, "%s: unknown module_version 0x%08lX layout=%d",
 			p_adapter_id_str, n_module_version_packed64, p->mn_stat_layout_version);
 	}
-- 
2.47.1

