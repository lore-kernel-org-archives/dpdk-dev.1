Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3AACAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5D3540E4B;
	Wed,  1 Oct 2025 17:10:37 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 65C7240E2A
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:33 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020120.outbound.protection.outlook.com [52.101.69.120])
 by mx-outbound22-252.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMaMuZYSkdi2SkxSGlFRhVKg4TKnjkBx8FtekogApb45Qv1BZcbxJXURvGb7YrHV0Zrt6vYZaNbOTVnpT4udp4/dnTta5tAlWC/EBCL5GButvjXl7WlMLkuoCsx57ToXRe8qEPBcij0xafuGFazT0+bKo0g9qO/R3oU+nWOATGf9ZA1Gf/oWWwrO8kwW+l7EcfaNQUlab60Pff/TnoeyL4GL+UR5AgsxY9Ax9e58tDiA6waC4mIbuI2BAh+vB16LwPBcLraN5OUheAl5NkZnxsTH+2hercqUI3RUSJq8/dsu0GleMkoY94kHpGM/3O1/JT//Iws9fxtnr5Z1bmUQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g8YFpLbxsUhzG+zjo6X68g/v/MztfjZ3om3d1mt+Xg=;
 b=MABBFO0XgP9AmwCw2NyERX0m2ETmvr45kCwL6TtG7dipYrtgXhFDZFVP61bqPmnyZHz9MkqewGZGfUzJOkojnprb/MC8fMmoOodzd/Q33Pypn9cDCfg7EeTNzL96P5n7PikAZ91eYbvVdQOgey1Ps935I5RQIBm7yY4MATFET5Ku1UKEnd4el8tQOCdKEEU50olatBZftPZROeDN5bAGT/CLHQK+9ekgzPOVxMMLfDX9/uK3n3/zCQPpFiEZlq8LGgOmx9ABEpVjh2pVgSCK1+KeduyhKDfificM4YydHoiNZUubLe/TaKPxiz6yJifnfnyOQdiof6zJMX+GN6hPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g8YFpLbxsUhzG+zjo6X68g/v/MztfjZ3om3d1mt+Xg=;
 b=PFPyfX6RfRSMDH/BLc7IqyikfGZm0G065vL3s0qOCGc7OrOv7tPy+in3MUS+iFUZgJY+tSJz6TCtgLFZibkeSANdO0T3LlwR4SbGaK94tznMqOdpJNOx4VMd6L62dmnsiph7ZS4f4d/+2mW22G4aFmhfrPXxz2phuRHv9gk0ffE=
Received: from DB9PR02CA0007.eurprd02.prod.outlook.com (2603:10a6:10:1d9::12)
 by VI0P190MB2235.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:10:29 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::2a) by DB9PR02CA0007.outlook.office365.com
 (2603:10a6:10:1d9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 15:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:29
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 09/20] net/ntnic: add reset init stage 7 for NT400D11
Date: Wed,  1 Oct 2025 17:09:51 +0200
Message-ID: <20251001151018.250671-10-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|VI0P190MB2235:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d399bc7b-b731-4a2a-97df-08de00fca8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ajs+racfxE3bfOc5dTX8W0Vfnvum5KSjbq5uZ8kho4pEucygM5XF0L+3GrFh?=
 =?us-ascii?Q?uLUxV+mQkUxF4eDJUAaw9v2JjUybqTOE59piLlYnHrmc3eUGDRToN8LeM0Me?=
 =?us-ascii?Q?JqHo12+vJuqv8ARCjoE5CweFL+4v+DkLX5lQbMJp46Aonny3GWY4wKGCOx2z?=
 =?us-ascii?Q?F0ciyidDPHBjMivvdVsOhrhb8+ue/xvyP69mPo7aIerlCUqIViMY1PJQofKh?=
 =?us-ascii?Q?cpSM1HW7d+Is0qQycLY9+TglbfTeR6eISMWigwvnfPn+VE82dEsTtnNjqMo/?=
 =?us-ascii?Q?sDSYI42adThiNpps8TEQKf2KdIb2DTz8TuSXIYvCzpN8h+om4yf4WuV4OIt6?=
 =?us-ascii?Q?KYwlsc+jNn0yDKmbL8KbtnzuGvVeQoi3/WOUsrwu3VSxQqBFTzs5ViFlLk25?=
 =?us-ascii?Q?r1XLV3hKVWvqB6I8aYS56a+Jl0fRiHt5P1TU8DPrsTVrJnZbd8eKbyrkkOPV?=
 =?us-ascii?Q?tpuThi12lV1vEKnvhVqblvhuyBx4KGpZUd+fftGhJayb9gSmN7r5iFv1RRlB?=
 =?us-ascii?Q?m3BPXljQ6y1/0jM/X8tfXpyKmbHlBZREwnJBuPsSnF4794hXVM97kMz7SG8H?=
 =?us-ascii?Q?/kD4Nye/l3csS+ruX0VAHpUpp5omy2lZGMQW+HHZtb8D/n/mPIf21qVHAJW/?=
 =?us-ascii?Q?VS80o+4PzdmdQSbjuC9Y5PqkINfSZi0J2sLEMmb8WYrCK1dr62h/Eid4DWJp?=
 =?us-ascii?Q?zHBgUaMw3YZsQLiB/U3NO2YBZXKieSB4TD3WWRFJtl1EBbvBD+xMLxw4BMKC?=
 =?us-ascii?Q?7ABZ1B9ev59++SBXrAL0MJolo82HNYN+IH2EAePoae6y6VyeTJHtU+MecbUf?=
 =?us-ascii?Q?twsUI3oB8Nc+reVWy9YDPjZCkca1W+uQ5cS2Ui+ddiA9IUaflO+GR/nIDfdb?=
 =?us-ascii?Q?waW9PC5yKIZSuFuGTr628TWZ3pseN/M+b/iNHmIssGN7vMkN1Bx+oMDVcbDw?=
 =?us-ascii?Q?6HdsaAIEh4C3nPWXFckqvQlZBM1S7zGulXbTxoPUPE3YimaQX+OSsUA1MGRN?=
 =?us-ascii?Q?3EWdzUoVxElYhy7zDi070iHCjmiKeppNkrx/iuzamfshsPRrUPzYsjsThc5C?=
 =?us-ascii?Q?86Iz9h+V8oguSragLb8PwcHJnmR6zGveehNVf0R9ODNNsywR9eEOf1aidoe+?=
 =?us-ascii?Q?rVKUzIA2z/mEclXFjvKhpIXg2dAyTrMtuXZYAEro1OKR+LFTRKteQhnb3EE+?=
 =?us-ascii?Q?KnIhBZmeUSegPa75buv/uBOzueaoI6ZA5gqNNHpDaIP25hx4hDeCrThO5Wp+?=
 =?us-ascii?Q?VDLiq+vOgsrvrxEHZDUbB6xu5IlFfQ5x+8UPBBYAL9QyiXS/nW4a+Zr4M2cC?=
 =?us-ascii?Q?64qlJV5OwRRKLIjZiMen96nYSFEEpeDEkot9WCV/OirzNexQIh6LfV7ir6pF?=
 =?us-ascii?Q?axZn+JoMybkMO71cI8PMyDv7FLs65AnddAe487vWNfd4Tqz2CgB+KpglqdmC?=
 =?us-ascii?Q?HPIWFZz5e/qkR7yFKJLDmGRAP0w4O7758giTLXzTfJUljDglkXWcAVZMODHL?=
 =?us-ascii?Q?w5SzYab8ucRIzfCYe09Zu2jqDox5qqtgkxK/7lNY9d/KW5CVRZycNa0mhV1C?=
 =?us-ascii?Q?LSUeBcOTyFiEExPsQTQ=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CqZOg60Zn5NL6QucWW5q478grCwZFwh18C2u8WXEpnFk/NSWGJc2BoIsCgZOtMUug9fmTl6mWXXDrtNckDHFRg4iAEMQMAKE03oy72J43mWd4TCo2dsjI8gKxfX/HHKDhBCRTWdiFBhXdObKcNMVShDVSihPkcg5E/vkcgOXnTbM3gUph4NHKqopyCpTGWCtgFONqndFVxqp/CJwP+lVTuJO6GUdcX5p7TccDU+SbxK/CbYFnCJGI291OQ1gemP8lpmNlEQhVT8cJHIFHEfoZBmdq/TaHJQLGhMeyXR8DQKUPJOruNnDDwd9i4FKqPOMF72nLE1fHn8/ZFIBr7UYAn45udjcZAv7ioWtQ9eWLEcEMrpAsoT2fnYrTHhns6ErsnA6JkLDczusdwsbuKngDznSWn1lbjmWRKFgVVVtGW1eIO2sFiGycaJkumvveEJf9ZMZGgkCZm9SUpXUpelBeHxW0/jh8X0HEBWVZsIRpdIATkk4OxThH7S+fFxK6ca4Kknh6ktHafH/eHh/4+0KlJuimKpliN6NdRGIRdnE+DP5RX9TOlXNCXKwANwXsHBErg6fBAXnPpT26nh4PloEtx60mWeMcCST79g3WzZqUrSAepEHUddmV873FBTwYA7BsW60SUoviUnm4/cn3A8x2g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:29.6428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d399bc7b-b731-4a2a-97df-08de00fca8e9
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2235
X-BESS-ID: 1759331432-305884-7641-4379-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.120
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYGJuZAVgZQ0DLZMtkk0cDcyM
 jYwNjA3NAi0dTYMNksxSDVMMkkzcJYqTYWADolv69BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan14-203.eu-central-1a.ess.aws.cudaops.com]
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

add waiting while PHY_FTILE ready.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 90 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 5ddf0a093e..29e32ffb22 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -100,6 +100,11 @@ static bool nthw_fpga_rst9569_get_phy_ftile_rst_done_stat(struct nthw_fpga_rst_n
 	return nthw_field_get_updated(p->p_fld_stat_phy_ftile_rst_done) != 0;
 }
 
+static bool nthw_fpga_rst9569_get_phy_ftile_rdy_stat(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_stat_phy_ftile_rdy) != 0;
+}
+
 static bool nthw_fpga_rst9569_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
 {
 	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
@@ -155,6 +160,40 @@ static int nthw_fpga_rst9569_wait_ddr4_calibration_complete(struct fpga_info_s *
 	return 0;
 }
 
+static int nthw_fpga_rst9569_wait_phy_ftile_rdy(struct fpga_info_s *p_fpga_info,
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
+		complete = nthw_fpga_rst9569_get_phy_ftile_rdy_stat(p_rst);
+
+		if (!complete) {
+			nthw_os_wait_usec(100);
+
+		} else {
+			NT_LOG(DBG, NTHW, "%s: PHY FTILE ready, margin to timeout %u",
+				p_adapter_id_str, timeout);
+		}
+
+		timeout--;
+
+		if (timeout == 0) {
+			NT_LOG_DBGX(ERR, NTHW, "%s: Timeout waiting for PHY FTILE ready",
+				p_adapter_id_str);
+			return -1;
+		}
+	} while (!complete);
+
+	return 0;
+}
+
 static int nthw_fpga_rst9569_wait_phy_ftile_rst_done(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -232,7 +271,8 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 			p_adapter_id_str, __func__);
 	}
 
-	bool success = true;
+	int tries = 0;
+	bool success = false;
 
 	do {
 		/* Only wait for ftile rst done if ftile is indeed in reset. */
@@ -256,8 +296,54 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 
 		nthw_os_wait_usec(10000);
 
-	} while (!success);
+		/* (7) Wait until PHY_FTILE ready */
+		if (nthw_fpga_rst9569_wait_phy_ftile_rdy(p_fpga_info, p_rst) == -1) {
+			if (++tries >= 5) {
+				/* Give up */
+				NT_LOG_DBGX(ERR, NTHW, "%s: PHY_TILE not ready after %u attempts",
+					p_adapter_id_str, tries);
+				return res;
+			}
 
+			/* Try to recover with as little effort as possible */
+			nthw_phy_tile_t *p_phy_tile = p_fpga_info->mp_nthw_agx.p_phy_tile;
+
+			for (uint8_t i = 0; i < nthw_phy_tile_get_no_intfs(p_phy_tile); i++) {
+				/* Also consider TX_PLL_LOCKED == 0 */
+				if (!nthw_phy_tile_get_port_status_tx_lanes_stable(p_phy_tile,
+					i)) {
+					success = false;
+					NT_LOG_DBGX(WRN, NTHW,
+						"%s: PHY_TILE Intf %u TX_LANES_STABLE == FALSE",
+						p_adapter_id_str, i);
+
+					/* Active low */
+					nthw_phy_tile_set_port_config_rst(p_phy_tile, i, 0);
+					int32_t count = 1000;
+
+					do {
+						nthw_os_wait_usec(1000);
+					} while
+					(!nthw_phy_tile_get_port_status_reset_ack(p_phy_tile, i) &&
+						(--count > 0));
+
+					if (count <= 0) {
+						NT_LOG(ERR, NTHW,
+							"%s: IntfNo %u: Time-out waiting for PortStatusResetAck",
+							p_adapter_id_str, i);
+					}
+
+					/* Active low */
+					nthw_phy_tile_set_port_config_rst(p_phy_tile, i, 1);
+					nthw_os_wait_usec(20000);
+				}
+			}
+
+		} else {
+			NT_LOG_DBGX(DBG, NTHW, "%s: PHY_TILE ready", p_adapter_id_str);
+			success = true;
+		}
+	} while (!success);
 
 	return 0;
 }
-- 
2.45.0

