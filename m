Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF0FC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:07:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 053AD40EE3;
	Thu, 20 Feb 2025 23:04:55 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 3C34F40E12
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:39 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2240.outbound.protection.outlook.com [104.47.51.240]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcgyXXxhLF/xNO4AcnIzjoeWXwv0+fjAjDAa9DfTy2jjvCcYZrG90Wg5YCUDs1rBjLewTa3Jr0XHp9qqq6ywLQcON83m/W+RG2/XyQKibARhMLta0t7M4l8ywSJnRL5q0RL6vlXv/roYLkGsditUA4Bz56Lv1O1M0GE75JacIbFU30rRIMZCy4j9cMp9CjOGt6bBTUjZT9UGK/EqjQcnsXZZPSJxpA7p7i7soA5jmTdNaDVYNXdiVIWr/13G4bhMyezhmmg+/6fIsWtcBieLndNo2Mh8RIGDQWHJdk8udv+IYI1o9CbfwzTV1vPcWu0KZJ4fpDasnrsrA481H2D6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G961r3HzKZJOctbXMBei5as20iBa1ainuY9/frrK4U=;
 b=L/pAaEgFXwdtBaNbu3jCmBKP6zMbYXgvk6viqN16MSqiqF8Gv3K1FzWy0aTVxXcEZ8HKQcBd0BxDw7Cvv5wg4IEHCNlS5LseTmXG5uJ4duDwf+smMu0AOIOkVlG6a96rGDANTtk3lyJsFv/2DFP0Te2vCVzfLz0Se5vpyWzrl9AZI/L+pJUPYBuYCHZfwMuYU+S6CrnS5aeyDxXHeX3cR98er4lAtaHVrNNKrrKG/HDbgt8elQ4l27vOmcmwms6tptDlzzuVejthvWxMamRxDjg/aZJAnYHOUm9tQcTkl1pUrLy/mFDsGdzaCyA5fdW7iSIIZ73u/sur4WGbDJJWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G961r3HzKZJOctbXMBei5as20iBa1ainuY9/frrK4U=;
 b=Zm+sPmSKgmZpFyHF3Sii0Dv32zsda/CbnalgcWnXcCJZkloDoJWcXapvdV7W+j518qqRu/RTocTOsHiHpH9f8oIOVI/c/YrRlsESl5+LFcB8eu7yLKLR4wCGL8Ue6YkeAY40dsETqm2HBoCrogEZrKtZ3jo1kPTQD/QHzfuU3HY=
Received: from CWLP265CA0503.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::9)
 by PA4P190MB1325.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:108::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 22:04:35 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::aa) by CWLP265CA0503.outlook.office365.com
 (2603:10a6:400:18b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 22:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:35 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 29/32] net/ntnic: add reset PHY init
Date: Thu, 20 Feb 2025 23:03:53 +0100
Message-ID: <20250220220406.3925597-30-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PA4P190MB1325:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7630ea8a-d0ab-49df-b473-08dd51fa8ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7gZFmFHQkpz3ZakvoS9hSFOZnGg4gjIB/kg9hKoDfP78YBG9Cs/Dd+aSZi9B?=
 =?us-ascii?Q?UYYcFMeDBfCbd9XdJsdRmGnIE+QM7OYEY7VJrhjrTxlSQ/Uf17H0jO1erd+d?=
 =?us-ascii?Q?AquyoCw8TfZrau0/zg56uneN0mK2amZAqBYJBG2EQlK3rKCac5tUAkzMNKOf?=
 =?us-ascii?Q?LK8d6wJSD1adOWeKZfCJ6CgVvzhVyiPDEGXHO0GW6WtA4FKS7Ol6HGEph7lS?=
 =?us-ascii?Q?8wKgPbDazmpaO6AfYrlmFhOPqYvlvOL1jO4XKiPLvmB9geOv/83ydtUVXskD?=
 =?us-ascii?Q?ZVZpnz571lLMZKsC5CCccigMOLgz/BOuaax+GDAN6UOyJlGXL0ARNNlstEQo?=
 =?us-ascii?Q?Sw5aOq2B8pXarp1j1aWPqLyPDDXYaaZvz1P/bd/mrz6ODgfrXvHB8QVtzHw9?=
 =?us-ascii?Q?TXiiOnyBTCelHmy43BMhhMquXKVGh/oEemt0bxDTpFkcaa90T7AzFgaCDBvp?=
 =?us-ascii?Q?Tj9rUqSU1FpItiG7oAVeBxV+dQG2zgQH/AoorRD2Gtpa24Wq8uFnSw848+OY?=
 =?us-ascii?Q?Ff25keMW5XyR9rkHJD0lH8EwuYTOuh0qC7yZGTn+Jg5g6VBw88PrJkUu3NOY?=
 =?us-ascii?Q?KVlqElxZU+4e6Q7KLNRSy6BiECXMxfB9Ce3DsJtR2XoSIOv3sitRWOPW5oGj?=
 =?us-ascii?Q?KF87j3lgceeq0R+cHXnPjoj1Ki+12q4Bh8PhNPj2tCXtOaI2LB0xvo9mYyZZ?=
 =?us-ascii?Q?KWq3SHr4yIJjq/VTPekJkqgKR1aZu4S383nZ/g5KuAohzjwZ2jrPwTs7qUhm?=
 =?us-ascii?Q?Nk3Gps/meHkULYGuaNaltteldkOiEsdG03g+AcHwHlSp6wlsuMQXI5kBiJKU?=
 =?us-ascii?Q?5/LnfvhJ4tkAwVEpyRrwxqLD/mpu0NlyT0v/bP83riApOZH+ev/npN0O4dyQ?=
 =?us-ascii?Q?Qo71O5CQBdIrUnQ2T4mXP2nC8dz1uaacp4Pj3UX5YFbNzIPOqsONwgeL7Hwl?=
 =?us-ascii?Q?nfECV/OGCtinOTW0juTSRDLB9NrW/AY3baVIgH+JrzHqdOmpQimfPJ9ww05U?=
 =?us-ascii?Q?xwl3sya6VJrQVpX9w9OnJleYA8I8JM9ZPVwZ93rUKgAEQG2FdntZdeJRY3Ce?=
 =?us-ascii?Q?QWNwn5Ck9xElwqMgZnm+Wiy3PpSJVbCjbiIkiIm6DCdNOtgh9kJppiaYTRc+?=
 =?us-ascii?Q?lQoSmyYSDEAsGJ2SCqIy+hUvaW+llSODomsfw6ldUygx5FxLM89z9bFRTxfG?=
 =?us-ascii?Q?jaZNQYqTlvTOoDMNC9B7u31J2VjLx1AAeUetUTghveMrfvA4Jb1mieCkkvci?=
 =?us-ascii?Q?667sEwq1JFCCELj1VWicRjj81tBpeVtXmcNk1DtcpFuviyd1UZ9z9f/ULUnN?=
 =?us-ascii?Q?pkT2ZxR9buUifUUdBNwf3HOSgFkq+aSyv8fA4ErNlPpRsJsYZjgHxmrO1BRI?=
 =?us-ascii?Q?ESEAUo4OMUQoXFPDzBykGAtYYiLa5whKTxQq++g6R5BRWs3tikFLMLcoCiD7?=
 =?us-ascii?Q?fpcHABtDW0M74655umaAgzIflJ2uZm3yMLJyqOYVeo0fIdZr2BX1opydgpGR?=
 =?us-ascii?Q?cX6Qn5jhhD/aVy4=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LTnm4HwwgaMnB2QmLCPwax9Q31M1WDKHZlntJIfWf8cJyPHamuOmQNWYrF4PRYEguhAocTCLRNR9otjWD/pG9loDtqaE9x3aG70nDdpqoMLWutFWXALdfxAByqDViM4ISEGZ803twvo9TlpSBgRvH5f803quCNFkDuRcC2kuy8JBIhBQcLrRaCcEIS7rzDlFM8lZkH/if2ABChl0hJlmsHVgQs3bkLdYqiglh9Q79cInDOQ3eWr8hP53QqBFbBGNNrtBJ+UJ3QddXmoGIu2YK6uZzKU6kKpBi+W2c2U5I9ne7b4+phb9WYMgjMfa9wpWJkFypojrgfZAo4SYTQOShzoORpBJLSz5VrHxiy+wJfSJ6OXibtkYw9v79yGfe0IpsnMJTkqekUlMdu+mwfbnGjYMqifEXb9wh4pQW6970iBciLDjbALuCvuQaWtN6nPG2i9/JaN+qgf2ODYim7dNl4BJnvE7J49JqXfyZ6YIAhUeY7efROEPCwyfVRNHilDJ51ok+sun95tp/1NX0PqfV39F850Hcz7qzlycQ8rN6szbdDIHYk4qbXoAXn42ksR/mzON/B3Mt6YJKE3BeWIaOvekYLhfSpQ1eU1OumagzcHFEVBJkAxli3srhz1/C2PDacXl4b4opMxYl4IZPHsVyO1FG4LkmOgIwoGd1YomzRU=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:35.4434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7630ea8a-d0ab-49df-b473-08dd51fa8ff7
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1325
X-BESS-ID: 1740089077-312005-29062-14101-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.51.240
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaGhmbmQGYGUDTZLM3M2MQ4JT
 HN2Dg1KdXAxCDFJM3UxDg1zdwg2cDCUKk2FgBetdKdQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-233.eu-central-1b.ess.aws.cudaops.com]
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

Add initialization and logging for Phy Tile module.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |  39 ++
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |  16 +
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   | 598 ++++++++++++++++++
 3 files changed, 653 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
index 68d8455b8d..ba044a5091 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -9,12 +9,16 @@
 #include "nthw_fpga_model.h"
 
 enum mac_pcs_mode_e {
+	MAC_PCS_MODE_8x10_25,
+	MAC_PCS_MODE_2X40,
 	MAC_PCS_MODE_2X100
 };
 
 struct nt_phy_tile {
 	nthw_fpga_t *mp_fpga;
 
+	nthw_module_t *m_mod_phy_tile;
+
 	int mn_phy_tile_instance;
 
 	int mn_fpga_version;
@@ -27,6 +31,7 @@ struct nt_phy_tile {
 	nthw_field_t *mp_fld_port_xcvr_base_busy[2][4];
 	nthw_field_t *mp_fld_port_xcvr_base_cmd[2][4];
 
+	nthw_register_t *mp_reg_port_xcvr_data[2][4];
 	nthw_field_t *mp_fld_port_xcvr_data_data[2][4];
 
 	nthw_register_t *mp_reg_port_eth_base[2];
@@ -34,27 +39,44 @@ struct nt_phy_tile {
 	nthw_field_t *mp_fld_port_eth_base_busy[2];
 	nthw_field_t *mp_fld_port_eth_base_cmd[2];
 
+	nthw_register_t *mp_reg_port_eth_data[2];
 	nthw_field_t *mp_fld_port_eth_data_data[2];
 
 	nthw_register_t *mp_reg_link_summary[2];
 	nthw_field_t *mp_fld_link_summary_nt_phy_link_state[2];
 	nthw_field_t *mp_fld_link_summary_ll_nt_phy_link_state[2];
 	nthw_field_t *mp_fld_link_summary_link_down_cnt[2];
+	nthw_field_t *mp_fld_link_summary_ll_rx_block_lock[2];
+	nthw_field_t *mp_fld_link_summary_ll_rx_am_lock[2];
+	nthw_field_t *mp_fld_link_summary_lh_rx_high_bit_error_rate[2];
 	nthw_field_t *mp_fld_link_summary_lh_received_local_fault[2];
 	nthw_field_t *mp_fld_link_summary_lh_remote_fault[2];
 
+	nthw_register_t *mp_reg_port_status[2];
+	nthw_field_t *mp_fld_port_status_rx_pcs_fully_aligned[2];
 	nthw_field_t *mp_fld_port_status_rx_hi_ber[2];
+	nthw_field_t *mp_fld_port_status_rx_remote_fault[2];
+	nthw_field_t *mp_fld_port_status_rx_local_fault[2];
 	nthw_field_t *mp_fld_port_status_rx_am_lock[2];
 	nthw_field_t *mp_fld_port_status_reset_ackn[2];
 	nthw_field_t *mp_fld_port_status_tx_lanes_stable[2];
+	nthw_field_t *mp_fld_port_status_tx_pll_locked[2];
+	nthw_field_t *mp_fld_port_status_sys_pll_locked[2];
 	nthw_field_t *mp_fld_port_status_tx_reset_ackn[2];
 	nthw_field_t *mp_fld_port_status_rx_reset_ackn[2];
 
+	nthw_register_t *mp_reg_port_config[2];
+	nthw_field_t *mp_fld_port_config_dyn_reset;
 	nthw_field_t *mp_fld_port_config_reset[2];
 	nthw_field_t *mp_fld_port_config_rx_reset[2];
 	nthw_field_t *mp_fld_port_config_tx_reset[2];
+	nthw_field_t *mp_fld_port_config_nt_linkup_latency[2];
+	nthw_field_t *mp_fld_port_config_nt_force_linkdown[2];
+	nthw_field_t *mp_fld_port_config_nt_auto_force_linkdown[2];
 
+	nthw_register_t *mp_reg_port_comp[2];
 	nthw_field_t *mp_fld_port_comp_rx_compensation[2];
+	nthw_field_t *mp_fld_port_comp_tx_compensation[2];
 
 	nthw_register_t *mp_reg_dyn_reconfig_base;
 	nthw_field_t *mp_fld_dyn_reconfig_base_ptr;
@@ -64,17 +86,34 @@ struct nt_phy_tile {
 	nthw_register_t *mp_reg_dyn_reconfig_data;
 	nthw_field_t *mp_fld_dyn_reconfig_data_data;
 
+	nthw_register_t *mp_reg_scratch;
 	nthw_field_t *mp_fld_scratch_data;
 
+	nthw_register_t *mp_reg_dr_cfg;
+	nthw_field_t *mp_fld_reg_dr_cfg_features;
+	nthw_field_t *mp_fld_reg_dr_cfg_tx_flush_level;
+
 	nthw_register_t *mp_reg_dr_cfg_status;
 	nthw_field_t *mp_fld_dr_cfg_status_curr_profile_id;
 	nthw_field_t *mp_fld_dr_cfg_status_in_progress;
 	nthw_field_t *mp_fld_dr_cfg_status_error;
+
+	nthw_register_t *mp_reg_sys_pll;
+	nthw_field_t *mp_fld_sys_pll_set_rdy;
+	nthw_field_t *mp_fld_sys_pll_get_rdy;
+	nthw_field_t *mp_fld_sys_pll_system_pll_lock;
+	nthw_field_t *mp_fld_sys_pll_en_ref_clk_fgt;
+	nthw_field_t *mp_fld_sys_pll_disable_ref_clk_monitor;
+	nthw_field_t *mp_fld_sys_pll_ref_clk_fgt_enabled;
+	nthw_field_t *mp_fld_sys_pll_forward_rst;
+	nthw_field_t *mp_fld_sys_pll_force_rst;
 };
 
 typedef struct nt_phy_tile nthw_phy_tile_t;
 typedef struct nt_phy_tile nt_phy_tile;
 
+nthw_phy_tile_t *nthw_phy_tile_new(void);
+int nthw_phy_tile_init(nthw_phy_tile_t *p, nthw_fpga_t *p_fpga, int mn_phy_tile_instance);
 void nthw_phy_tile_set_tx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, bool invert);
 void nthw_phy_tile_set_rx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, bool invert);
 void nthw_phy_tile_set_host_loopback(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index c8fd37d0ff..35cbaea81e 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -181,7 +181,23 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 {
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	nthw_fpga_t *p_fpga = NULL;
+
+	p_fpga = p_fpga_info->mp_fpga;
+
 	assert(p_fpga_info);
+
+	NT_LOG(DBG, NTHW, "%s: %s: BEGIN", p_adapter_id_str, __PRETTY_FUNCTION__);
+
+	/* Create Phy Tile module */
+	p_fpga_info->mp_nthw_agx.p_phy_tile = nthw_phy_tile_new();
+
+	if (nthw_phy_tile_init(p_fpga_info->mp_nthw_agx.p_phy_tile, p_fpga, 0)) {
+		NT_LOG(ERR, NTHW, "%s: Failed to create Phy Tile Module", p_adapter_id_str);
+		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index a8c2d03be9..f78d8263f5 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -44,6 +44,604 @@ static const uint32_t eth_soft_csr1 = 0x200;
 static const uint32_t eth_soft_csr2 = 0x204;
 static const uint32_t eth_soft_csr3 = 0x208;
 
+nthw_phy_tile_t *nthw_phy_tile_new(void)
+{
+	nthw_phy_tile_t *p = malloc(sizeof(nthw_phy_tile_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_phy_tile_t));
+
+	return p;
+}
+
+int nthw_phy_tile_init(nthw_phy_tile_t *p, nthw_fpga_t *p_fpga, int mn_phy_tile_instance)
+{
+	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
+	nthw_module_t *mod = nthw_fpga_query_module(p_fpga, MOD_PHY_TILE, mn_phy_tile_instance);
+
+	if (p == NULL)
+		return mod == NULL ? -1 : 0;
+
+	if (mod == NULL) {
+		NT_LOG(ERR, NTHW, "%s: PHY_TILE %d: no such instance", p_adapter_id_str,
+			mn_phy_tile_instance);
+		return -1;
+	}
+
+	p->mp_fpga = p_fpga;
+	p->mn_phy_tile_instance = mn_phy_tile_instance;
+
+	p->m_mod_phy_tile = mod;
+
+	p->mn_fpga_revision = p_fpga->mn_fpga_revision;
+	p->mn_fpga_version = p_fpga->mn_fpga_version;
+
+	switch (p_fpga->mn_product_id) {
+	case 9569:
+	case 9574:
+		p->mac_pcs_mode = MAC_PCS_MODE_2X100;
+		break;
+
+	default:
+		NT_LOG_DBG(DBG, NTHW, "unknown product ID: %u", p_fpga->mn_product_id);
+		break;
+	}
+
+	/* Port 0 Base 0..3 */
+	p->mp_reg_port_xcvr_base[0][0] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_XCVR_0_BASE);
+	p->mp_fld_port_xcvr_base_ptr[0][0] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][0],
+			PHY_TILE_PORT_0_XCVR_0_BASE_PTR);
+	p->mp_fld_port_xcvr_base_busy[0][0] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][0],
+			PHY_TILE_PORT_0_XCVR_0_BASE_BUSY);
+	p->mp_fld_port_xcvr_base_cmd[0][0] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][0],
+			PHY_TILE_PORT_0_XCVR_0_BASE_CMD);
+
+	p->mp_reg_port_xcvr_base[0][1] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_XCVR_1_BASE);
+	p->mp_fld_port_xcvr_base_ptr[0][1] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][1],
+			PHY_TILE_PORT_0_XCVR_1_BASE_PTR);
+	p->mp_fld_port_xcvr_base_busy[0][1] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][1],
+			PHY_TILE_PORT_0_XCVR_1_BASE_BUSY);
+	p->mp_fld_port_xcvr_base_cmd[0][1] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][1],
+			PHY_TILE_PORT_0_XCVR_1_BASE_CMD);
+
+	p->mp_reg_port_xcvr_base[0][2] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_XCVR_2_BASE);
+	p->mp_fld_port_xcvr_base_ptr[0][2] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][2],
+			PHY_TILE_PORT_0_XCVR_2_BASE_PTR);
+	p->mp_fld_port_xcvr_base_busy[0][2] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][2],
+			PHY_TILE_PORT_0_XCVR_2_BASE_BUSY);
+	p->mp_fld_port_xcvr_base_cmd[0][2] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][2],
+			PHY_TILE_PORT_0_XCVR_2_BASE_CMD);
+
+	p->mp_reg_port_xcvr_base[0][3] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_XCVR_3_BASE);
+	p->mp_fld_port_xcvr_base_ptr[0][3] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][3],
+			PHY_TILE_PORT_0_XCVR_3_BASE_PTR);
+	p->mp_fld_port_xcvr_base_busy[0][3] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][3],
+			PHY_TILE_PORT_0_XCVR_3_BASE_BUSY);
+	p->mp_fld_port_xcvr_base_cmd[0][3] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[0][3],
+			PHY_TILE_PORT_0_XCVR_3_BASE_CMD);
+
+	/* Port 0 Data 0..3 */
+	p->mp_reg_port_xcvr_data[0][0] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_XCVR_0_DATA);
+	p->mp_fld_port_xcvr_data_data[0][0] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_data[0][0],
+			PHY_TILE_PORT_0_XCVR_0_DATA_DATA);
+
+	p->mp_reg_port_xcvr_data[0][1] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_XCVR_1_DATA);
+	p->mp_fld_port_xcvr_data_data[0][1] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_data[0][1],
+			PHY_TILE_PORT_0_XCVR_1_DATA_DATA);
+
+	p->mp_reg_port_xcvr_data[0][2] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_XCVR_2_DATA);
+	p->mp_fld_port_xcvr_data_data[0][2] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_data[0][2],
+			PHY_TILE_PORT_0_XCVR_2_DATA_DATA);
+
+	p->mp_reg_port_xcvr_data[0][3] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_XCVR_3_DATA);
+	p->mp_fld_port_xcvr_data_data[0][3] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_data[0][3],
+			PHY_TILE_PORT_0_XCVR_3_DATA_DATA);
+
+	/* Port 1 Base 0..3 */
+	p->mp_reg_port_xcvr_base[1][0] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_XCVR_0_BASE);
+	p->mp_fld_port_xcvr_base_ptr[1][0] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][0],
+			PHY_TILE_PORT_1_XCVR_0_BASE_PTR);
+	p->mp_fld_port_xcvr_base_busy[1][0] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][0],
+			PHY_TILE_PORT_1_XCVR_0_BASE_BUSY);
+	p->mp_fld_port_xcvr_base_cmd[1][0] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][0],
+			PHY_TILE_PORT_1_XCVR_0_BASE_CMD);
+
+	p->mp_reg_port_xcvr_base[1][1] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_XCVR_1_BASE);
+	p->mp_fld_port_xcvr_base_ptr[1][1] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][1],
+			PHY_TILE_PORT_1_XCVR_1_BASE_PTR);
+	p->mp_fld_port_xcvr_base_busy[1][1] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][1],
+			PHY_TILE_PORT_1_XCVR_1_BASE_BUSY);
+	p->mp_fld_port_xcvr_base_cmd[1][1] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][1],
+			PHY_TILE_PORT_1_XCVR_1_BASE_CMD);
+
+	p->mp_reg_port_xcvr_base[1][2] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_XCVR_2_BASE);
+	p->mp_fld_port_xcvr_base_ptr[1][2] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][2],
+			PHY_TILE_PORT_1_XCVR_2_BASE_PTR);
+	p->mp_fld_port_xcvr_base_busy[1][2] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][2],
+			PHY_TILE_PORT_1_XCVR_2_BASE_BUSY);
+	p->mp_fld_port_xcvr_base_cmd[1][2] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][2],
+			PHY_TILE_PORT_1_XCVR_2_BASE_CMD);
+
+	p->mp_reg_port_xcvr_base[1][3] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_XCVR_3_BASE);
+	p->mp_fld_port_xcvr_base_ptr[1][3] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][3],
+			PHY_TILE_PORT_1_XCVR_3_BASE_PTR);
+	p->mp_fld_port_xcvr_base_busy[1][3] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][3],
+			PHY_TILE_PORT_1_XCVR_3_BASE_BUSY);
+	p->mp_fld_port_xcvr_base_cmd[1][3] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_base[1][3],
+			PHY_TILE_PORT_1_XCVR_3_BASE_CMD);
+
+	/* Port 1 Data 0..3 */
+	p->mp_reg_port_xcvr_data[1][0] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_XCVR_0_DATA);
+	p->mp_fld_port_xcvr_data_data[1][0] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_data[1][0],
+			PHY_TILE_PORT_1_XCVR_0_DATA_DATA);
+
+	p->mp_reg_port_xcvr_data[1][1] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_XCVR_1_DATA);
+	p->mp_fld_port_xcvr_data_data[1][1] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_data[1][1],
+			PHY_TILE_PORT_1_XCVR_1_DATA_DATA);
+
+	p->mp_reg_port_xcvr_data[1][2] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_XCVR_2_DATA);
+	p->mp_fld_port_xcvr_data_data[1][2] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_data[1][2],
+			PHY_TILE_PORT_1_XCVR_2_DATA_DATA);
+
+	p->mp_reg_port_xcvr_data[1][3] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_XCVR_3_DATA);
+	p->mp_fld_port_xcvr_data_data[1][3] =
+		nthw_register_get_field(p->mp_reg_port_xcvr_data[1][3],
+			PHY_TILE_PORT_1_XCVR_3_DATA_DATA);
+
+	if (nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 3)) {
+		if (p->mac_pcs_mode == MAC_PCS_MODE_2X100 ||
+			p->mac_pcs_mode == MAC_PCS_MODE_8x10_25) {
+			/* DYN_RECONFIG */
+			p->mp_reg_dyn_reconfig_base =
+				nthw_module_get_register(p->m_mod_phy_tile,
+					PHY_TILE_DYN_RECONFIG_BASE);
+			p->mp_fld_dyn_reconfig_base_ptr =
+				nthw_register_get_field(p->mp_reg_dyn_reconfig_base,
+					PHY_TILE_DYN_RECONFIG_BASE_PTR);
+			p->mp_fld_dyn_reconfig_base_busy =
+				nthw_register_get_field(p->mp_reg_dyn_reconfig_base,
+					PHY_TILE_DYN_RECONFIG_BASE_BUSY);
+			p->mp_fld_dyn_reconfig_base_cmd =
+				nthw_register_get_field(p->mp_reg_dyn_reconfig_base,
+					PHY_TILE_DYN_RECONFIG_BASE_CMD);
+
+			p->mp_reg_dyn_reconfig_data =
+				nthw_module_get_register(p->m_mod_phy_tile,
+					PHY_TILE_DYN_RECONFIG_DATA);
+			p->mp_fld_dyn_reconfig_data_data =
+				nthw_register_get_field(p->mp_reg_dyn_reconfig_data,
+					PHY_TILE_DYN_RECONFIG_DATA_DATA);
+		}
+
+		/* Port 0 Eth Base */
+		p->mp_reg_port_eth_base[0] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_ETH_0_BASE);
+		p->mp_fld_port_eth_base_ptr[0] =
+			nthw_register_get_field(p->mp_reg_port_eth_base[0],
+				PHY_TILE_PORT_0_ETH_0_BASE_PTR);
+		p->mp_fld_port_eth_base_busy[0] =
+			nthw_register_get_field(p->mp_reg_port_eth_base[0],
+				PHY_TILE_PORT_0_ETH_0_BASE_BUSY);
+		p->mp_fld_port_eth_base_cmd[0] =
+			nthw_register_get_field(p->mp_reg_port_eth_base[0],
+				PHY_TILE_PORT_0_ETH_0_BASE_CMD);
+
+		/* Port 1 Eth Base */
+		p->mp_reg_port_eth_base[1] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_ETH_0_BASE);
+		p->mp_fld_port_eth_base_ptr[1] =
+			nthw_register_get_field(p->mp_reg_port_eth_base[1],
+				PHY_TILE_PORT_1_ETH_0_BASE_PTR);
+		p->mp_fld_port_eth_base_busy[1] =
+			nthw_register_get_field(p->mp_reg_port_eth_base[1],
+				PHY_TILE_PORT_1_ETH_0_BASE_BUSY);
+		p->mp_fld_port_eth_base_cmd[1] =
+			nthw_register_get_field(p->mp_reg_port_eth_base[1],
+				PHY_TILE_PORT_1_ETH_0_BASE_CMD);
+
+		/* Port 0 Eth Data */
+		p->mp_reg_port_eth_data[0] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_0_ETH_0_DATA);
+		p->mp_fld_port_eth_data_data[0] =
+			nthw_register_get_field(p->mp_reg_port_eth_data[0],
+				PHY_TILE_PORT_0_ETH_0_DATA_DATA);
+
+		/* Port 1 Eth Data 0..3 */
+		p->mp_reg_port_eth_data[1] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_1_ETH_0_DATA);
+		p->mp_fld_port_eth_data_data[1] =
+			nthw_register_get_field(p->mp_reg_port_eth_data[1],
+				PHY_TILE_PORT_1_ETH_0_DATA_DATA);
+	}
+
+	p->mp_reg_link_summary[0] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_LINK_SUMMARY_0);
+	p->mp_fld_link_summary_nt_phy_link_state[0] =
+		nthw_register_get_field(p->mp_reg_link_summary[0],
+			PHY_TILE_LINK_SUMMARY_0_NT_PHY_LINK_STATE);
+	p->mp_fld_link_summary_ll_nt_phy_link_state[0] =
+		nthw_register_get_field(p->mp_reg_link_summary[0],
+			PHY_TILE_LINK_SUMMARY_0_LL_PHY_LINK_STATE);
+	p->mp_fld_link_summary_link_down_cnt[0] =
+		nthw_register_get_field(p->mp_reg_link_summary[0],
+			PHY_TILE_LINK_SUMMARY_0_LINK_DOWN_CNT);
+	p->mp_fld_link_summary_ll_rx_block_lock[0] =
+		nthw_register_get_field(p->mp_reg_link_summary[0],
+			PHY_TILE_LINK_SUMMARY_0_LL_RX_BLOCK_LOCK);
+	p->mp_fld_link_summary_ll_rx_am_lock[0] =
+		nthw_register_get_field(p->mp_reg_link_summary[0],
+			PHY_TILE_LINK_SUMMARY_0_LL_RX_AM_LOCK);
+	p->mp_fld_link_summary_lh_rx_high_bit_error_rate[0] =
+		nthw_register_get_field(p->mp_reg_link_summary[0],
+			PHY_TILE_LINK_SUMMARY_0_LH_RX_HIGH_BIT_ERROR_RATE);
+	p->mp_fld_link_summary_lh_received_local_fault[0] =
+		nthw_register_get_field(p->mp_reg_link_summary[0],
+			PHY_TILE_LINK_SUMMARY_0_LH_RECEIVED_LOCAL_FAULT);
+	p->mp_fld_link_summary_lh_remote_fault[0] =
+		nthw_register_get_field(p->mp_reg_link_summary[0],
+			PHY_TILE_LINK_SUMMARY_0_LH_REMOTE_FAULT);
+
+	p->mp_reg_link_summary[1] =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_LINK_SUMMARY_1);
+	p->mp_fld_link_summary_nt_phy_link_state[1] =
+		nthw_register_get_field(p->mp_reg_link_summary[1],
+			PHY_TILE_LINK_SUMMARY_1_NT_PHY_LINK_STATE);
+	p->mp_fld_link_summary_ll_nt_phy_link_state[1] =
+		nthw_register_get_field(p->mp_reg_link_summary[1],
+			PHY_TILE_LINK_SUMMARY_1_LL_PHY_LINK_STATE);
+	p->mp_fld_link_summary_link_down_cnt[1] =
+		nthw_register_get_field(p->mp_reg_link_summary[1],
+			PHY_TILE_LINK_SUMMARY_1_LINK_DOWN_CNT);
+	p->mp_fld_link_summary_ll_rx_block_lock[1] =
+		nthw_register_get_field(p->mp_reg_link_summary[1],
+			PHY_TILE_LINK_SUMMARY_1_LL_RX_BLOCK_LOCK);
+	p->mp_fld_link_summary_ll_rx_am_lock[1] =
+		nthw_register_get_field(p->mp_reg_link_summary[1],
+			PHY_TILE_LINK_SUMMARY_1_LL_RX_AM_LOCK);
+	p->mp_fld_link_summary_lh_rx_high_bit_error_rate[1] =
+		nthw_register_get_field(p->mp_reg_link_summary[1],
+			PHY_TILE_LINK_SUMMARY_1_LH_RX_HIGH_BIT_ERROR_RATE);
+	p->mp_fld_link_summary_lh_received_local_fault[1] =
+		nthw_register_get_field(p->mp_reg_link_summary[1],
+			PHY_TILE_LINK_SUMMARY_1_LH_RECEIVED_LOCAL_FAULT);
+	p->mp_fld_link_summary_lh_remote_fault[1] =
+		nthw_register_get_field(p->mp_reg_link_summary[1],
+			PHY_TILE_LINK_SUMMARY_1_LH_REMOTE_FAULT);
+
+	if (nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 4)) {
+		p->mp_reg_port_status[0] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_STATUS_0);
+		p->mp_fld_port_status_rx_pcs_fully_aligned[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_RX_PCS_FULLY_ALIGNED);
+		p->mp_fld_port_status_rx_hi_ber[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_RX_HI_BER);
+		p->mp_fld_port_status_rx_remote_fault[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_RX_REMOTE_FAULT);
+		p->mp_fld_port_status_rx_local_fault[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_RX_LOCAL_FAULT);
+		p->mp_fld_port_status_rx_am_lock[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_RX_AM_LOCK);
+		p->mp_fld_port_status_reset_ackn[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_RESET_ACK_N);
+		p->mp_fld_port_status_tx_lanes_stable[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_TX_LANES_STABLE);
+		p->mp_fld_port_status_tx_pll_locked[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_TX_PLL_LOCKED);
+		p->mp_fld_port_status_sys_pll_locked[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_SYS_PLL_LOCKED);
+		p->mp_fld_port_status_tx_reset_ackn[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_TX_RESET_ACK_N);
+		p->mp_fld_port_status_rx_reset_ackn[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_0_RX_RESET_ACK_N);
+
+		p->mp_reg_port_status[1] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_STATUS_1);
+		p->mp_fld_port_status_rx_pcs_fully_aligned[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_RX_PCS_FULLY_ALIGNED);
+		p->mp_fld_port_status_rx_hi_ber[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_RX_HI_BER);
+		p->mp_fld_port_status_rx_remote_fault[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_RX_REMOTE_FAULT);
+		p->mp_fld_port_status_rx_local_fault[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_RX_LOCAL_FAULT);
+		p->mp_fld_port_status_rx_am_lock[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_RX_AM_LOCK);
+		p->mp_fld_port_status_reset_ackn[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_RESET_ACK_N);
+		p->mp_fld_port_status_tx_lanes_stable[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_TX_LANES_STABLE);
+		p->mp_fld_port_status_tx_pll_locked[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_TX_PLL_LOCKED);
+		p->mp_fld_port_status_sys_pll_locked[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_SYS_PLL_LOCKED);
+		p->mp_fld_port_status_tx_reset_ackn[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_TX_RESET_ACK_N);
+		p->mp_fld_port_status_rx_reset_ackn[1] =
+			nthw_register_get_field(p->mp_reg_port_status[1],
+				PHY_TILE_PORT_STATUS_1_RX_RESET_ACK_N);
+
+	} else {
+		p->mp_reg_port_status[0] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_STATUS);
+		p->mp_fld_port_status_rx_pcs_fully_aligned[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_PCS_FULLY_ALIGNED_0);
+		p->mp_fld_port_status_rx_hi_ber[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_HI_BER_0);
+		p->mp_fld_port_status_rx_remote_fault[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_REMOTE_FAULT_0);
+		p->mp_fld_port_status_rx_local_fault[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_LOCAL_FAULT_0);
+		p->mp_fld_port_status_rx_am_lock[0] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_AM_LOCK_0);
+
+		p->mp_fld_port_status_rx_pcs_fully_aligned[1] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_PCS_FULLY_ALIGNED_1);
+		p->mp_fld_port_status_rx_hi_ber[1] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_HI_BER_1);
+		p->mp_fld_port_status_rx_remote_fault[1] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_REMOTE_FAULT_1);
+		p->mp_fld_port_status_rx_local_fault[1] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_LOCAL_FAULT_1);
+		p->mp_fld_port_status_rx_am_lock[1] =
+			nthw_register_get_field(p->mp_reg_port_status[0],
+				PHY_TILE_PORT_STATUS_RX_AM_LOCK_1);
+
+		p->mp_fld_port_status_reset_ackn[0] = NULL;
+		p->mp_fld_port_status_tx_lanes_stable[0] = NULL;
+		p->mp_fld_port_status_tx_pll_locked[0] = NULL;
+		p->mp_fld_port_status_sys_pll_locked[0] = NULL;
+		p->mp_fld_port_status_tx_reset_ackn[0] = NULL;
+		p->mp_fld_port_status_rx_reset_ackn[0] = NULL;
+
+		p->mp_fld_port_status_reset_ackn[1] = NULL;
+		p->mp_fld_port_status_tx_lanes_stable[1] = NULL;
+		p->mp_fld_port_status_tx_pll_locked[1] = NULL;
+		p->mp_fld_port_status_sys_pll_locked[1] = NULL;
+		p->mp_fld_port_status_tx_reset_ackn[1] = NULL;
+		p->mp_fld_port_status_rx_reset_ackn[1] = NULL;
+	}
+
+	if (nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 4)) {
+		p->mp_reg_port_config[0] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_CONFIG_0);
+		p->mp_fld_port_config_reset[0] =
+			nthw_register_query_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_0_RST);
+		p->mp_fld_port_config_rx_reset[0] =
+			nthw_register_query_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_0_RX_RST);
+		p->mp_fld_port_config_tx_reset[0] =
+			nthw_register_query_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_0_TX_RST);
+		p->mp_fld_port_config_nt_linkup_latency[0] =
+			nthw_register_query_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_0_NT_LINKUP_LATENCY);
+		p->mp_fld_port_config_nt_force_linkdown[0] =
+			nthw_register_query_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_0_NT_FORCE_LINK_DOWN);
+
+		if (nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 10)) {
+			p->mp_fld_port_config_nt_auto_force_linkdown[0] =
+				nthw_register_query_field(p->mp_reg_port_config[0],
+					PHY_TILE_PORT_CONFIG_0_NT_AUTO_FORCE_LINK_DOWN);
+		}
+
+		p->mp_reg_port_config[1] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_CONFIG_1);
+		p->mp_fld_port_config_reset[1] =
+			nthw_register_query_field(p->mp_reg_port_config[1],
+				PHY_TILE_PORT_CONFIG_1_RST);
+		p->mp_fld_port_config_rx_reset[1] =
+			nthw_register_query_field(p->mp_reg_port_config[1],
+				PHY_TILE_PORT_CONFIG_1_RX_RST);
+		p->mp_fld_port_config_tx_reset[1] =
+			nthw_register_query_field(p->mp_reg_port_config[1],
+				PHY_TILE_PORT_CONFIG_1_TX_RST);
+		p->mp_fld_port_config_nt_linkup_latency[1] =
+			nthw_register_query_field(p->mp_reg_port_config[1],
+				PHY_TILE_PORT_CONFIG_1_NT_LINKUP_LATENCY);
+		p->mp_fld_port_config_nt_force_linkdown[1] =
+			nthw_register_query_field(p->mp_reg_port_config[1],
+				PHY_TILE_PORT_CONFIG_1_NT_FORCE_LINK_DOWN);
+
+		if (nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 10)) {
+			p->mp_fld_port_config_nt_auto_force_linkdown[1] =
+				nthw_register_query_field(p->mp_reg_port_config[1],
+					PHY_TILE_PORT_CONFIG_1_NT_AUTO_FORCE_LINK_DOWN);
+		}
+
+	} else {
+		p->mp_reg_port_config[0] =
+			nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_CONFIG);
+		p->mp_fld_port_config_dyn_reset =
+			nthw_register_query_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_DYN_RESET);
+		p->mp_fld_port_config_reset[0] =
+			nthw_register_query_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_RESET_0);
+		p->mp_fld_port_config_rx_reset[0] =
+			nthw_register_get_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_RX_RESET_0);
+		p->mp_fld_port_config_tx_reset[0] =
+			nthw_register_get_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_TX_RESET_0);
+		p->mp_fld_port_config_reset[1] =
+			nthw_register_query_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_RESET_1);
+		p->mp_fld_port_config_rx_reset[1] =
+			nthw_register_get_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_RX_RESET_1);
+		p->mp_fld_port_config_tx_reset[1] =
+			nthw_register_get_field(p->mp_reg_port_config[0],
+				PHY_TILE_PORT_CONFIG_TX_RESET_1);
+	}
+
+	p->mp_reg_port_comp[0] = nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_COMP_0);
+	p->mp_fld_port_comp_rx_compensation[0] =
+		nthw_register_get_field(p->mp_reg_port_comp[0],
+			PHY_TILE_PORT_COMP_0_RX_COMPENSATION);
+	p->mp_fld_port_comp_tx_compensation[0] =
+		nthw_register_get_field(p->mp_reg_port_comp[0],
+			PHY_TILE_PORT_COMP_0_TX_COMPENSATION);
+	p->mp_reg_port_comp[1] = nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_PORT_COMP_1);
+	p->mp_fld_port_comp_rx_compensation[1] =
+		nthw_register_get_field(p->mp_reg_port_comp[1],
+			PHY_TILE_PORT_COMP_1_RX_COMPENSATION);
+	p->mp_fld_port_comp_tx_compensation[1] =
+		nthw_register_get_field(p->mp_reg_port_comp[1],
+			PHY_TILE_PORT_COMP_1_TX_COMPENSATION);
+
+	p->mp_reg_scratch = nthw_module_query_register(p->m_mod_phy_tile, PHY_TILE_SCRATCH);
+
+	if (p->mp_reg_scratch) {
+		p->mp_fld_scratch_data =
+			nthw_register_query_field(p->mp_reg_scratch, PHY_TILE_SCRATCH_DATA);
+	}
+
+	if (nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 4)) {
+		p->mp_reg_dr_cfg = nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_DR_CFG);
+		p->mp_fld_port_config_dyn_reset =
+			nthw_register_get_field(p->mp_reg_dr_cfg, PHY_TILE_DR_CFG_DYN_RST);
+
+		if (!p->mp_reg_scratch) {
+			p->mp_fld_scratch_data =
+				nthw_register_get_field(p->mp_reg_dr_cfg, PHY_TILE_DR_CFG_SCRATCH);
+		}
+
+		p->mp_fld_reg_dr_cfg_features =
+			nthw_register_get_field(p->mp_reg_dr_cfg, PHY_TILE_DR_CFG_FEATURES);
+
+		if (nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 10)) {
+			p->mp_fld_reg_dr_cfg_tx_flush_level =
+				nthw_register_get_field(p->mp_reg_dr_cfg,
+					PHY_TILE_DR_CFG_TX_FLUSH_LEVEL);
+		}
+	}
+
+	p->mp_reg_dr_cfg_status =
+		nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_DR_CFG_STATUS);
+	p->mp_fld_dr_cfg_status_curr_profile_id =
+		nthw_register_get_field(p->mp_reg_dr_cfg_status,
+			PHY_TILE_DR_CFG_STATUS_CURR_PROFILE_ID);
+	p->mp_fld_dr_cfg_status_in_progress =
+		nthw_register_get_field(p->mp_reg_dr_cfg_status,
+			PHY_TILE_DR_CFG_STATUS_IN_PROGRESS);
+	p->mp_fld_dr_cfg_status_error =
+		nthw_register_get_field(p->mp_reg_dr_cfg_status, PHY_TILE_DR_CFG_STATUS_ERROR);
+
+	if (nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 7)) {
+		p->mp_reg_sys_pll = nthw_module_get_register(p->m_mod_phy_tile, PHY_TILE_SYS_PLL);
+		p->mp_fld_sys_pll_set_rdy =
+			nthw_register_get_field(p->mp_reg_sys_pll, PHY_TILE_SYS_PLL_SET_RDY);
+		p->mp_fld_sys_pll_get_rdy =
+			nthw_register_get_field(p->mp_reg_sys_pll, PHY_TILE_SYS_PLL_GET_RDY);
+		p->mp_fld_sys_pll_system_pll_lock =
+			nthw_register_get_field(p->mp_reg_sys_pll,
+				PHY_TILE_SYS_PLL_SYSTEMPLL_LOCK);
+		p->mp_fld_sys_pll_en_ref_clk_fgt =
+			nthw_register_get_field(p->mp_reg_sys_pll, PHY_TILE_SYS_PLL_EN_REFCLK_FGT);
+		p->mp_fld_sys_pll_disable_ref_clk_monitor =
+			nthw_register_get_field(p->mp_reg_sys_pll,
+				PHY_TILE_SYS_PLL_DISABLE_REFCLK_MONITOR);
+		p->mp_fld_sys_pll_ref_clk_fgt_enabled =
+			nthw_register_get_field(p->mp_reg_sys_pll,
+				PHY_TILE_SYS_PLL_REFCLK_FGT_ENABLED);
+		p->mp_fld_sys_pll_forward_rst =
+			nthw_register_get_field(p->mp_reg_sys_pll, PHY_TILE_SYS_PLL_FORWARD_RST);
+		p->mp_fld_sys_pll_force_rst =
+			nthw_register_get_field(p->mp_reg_sys_pll, PHY_TILE_SYS_PLL_FORCE_RST);
+
+	} else {
+		p->mp_fld_sys_pll_set_rdy = NULL;
+		p->mp_fld_sys_pll_get_rdy = NULL;
+		p->mp_fld_sys_pll_system_pll_lock = NULL;
+		p->mp_fld_sys_pll_en_ref_clk_fgt = NULL;
+		p->mp_fld_sys_pll_disable_ref_clk_monitor = NULL;
+		p->mp_fld_sys_pll_ref_clk_fgt_enabled = NULL;
+		p->mp_fld_sys_pll_forward_rst = NULL;
+		p->mp_fld_sys_pll_force_rst = NULL;
+	}
+
+	return 0;
+}
+
 uint8_t nthw_phy_tile_get_no_intfs(nthw_phy_tile_t *p)
 {
 	switch (p->mac_pcs_mode) {
-- 
2.45.0

