Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EA4C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:05:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FE0B40DCE;
	Thu, 20 Feb 2025 23:04:30 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id DECED4066F
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:22 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2236.outbound.protection.outlook.com [104.47.51.236]) by
 mx-outbound21-132.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DheV141uF5owv/a9gPIyGcog0BHa2l5q0EaZwgZAFw8OCqkcWGN9c8psbo7j4+EYBZAGCXJIwQ/ton8dvqt7gqKZz6zzS7wnl45Xi+xLhrtxN4dhNYSSVfT797zhUGrg7mTMSlbQ9nOFxUPP5j6xpBY9fUfZENL4ONK93s99kPHSvfBU03BfYMCLUqGEJanTZ4TW9EhuC9DZMIYey/rs3IRIMKbMsfR+Zr2JY4v4MMmkRfMzqi2L2KfXZXxrZV87CKnjd3xjleDphKGf0/g9wFG4YoJVNaHZ0EXwJ9BL2YQNVWywP7EANcv0ua+kr44XZK22r9bEyBKYqV4dnWEG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPnVTkEVwW2HnZHefINjW3x8PWnACe0nSiONVwF4V90=;
 b=hxa+9/4r2Zl9kIlb2yppC2oGPjySxpkVCt3F9p9RCv9eGnAET2OwRAUwH+h5fBuAPjQp5GXZzDSyPyI4g0zp22Lfk+65r41XS3DErpniwato0seyr1QWJC2LSqGTAXiyEx4yQgRMW6IGOr7Pt/hkcf73+HuAnYLrlmyAm/4B4lklW3+Cs0/LSop4ZH8wCWv/36ZJ3eWB65yT4eB21621JSfn8MlrrGG3nmg/Rz4Rqhkz5Tjy7QQS2poSzXAMjJIB3nPzNQAYttxtd1ktTj5HcsuFUgGNc9DhQTr1znDvIQq+zifDMQR1iSAawJN+jKFoV2YTe4tok9GXDTBAtRBtpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPnVTkEVwW2HnZHefINjW3x8PWnACe0nSiONVwF4V90=;
 b=jf0GP5jbyqPLyL3l7Xd2aYzUEWMBXMw3f/yWTO+PDZyTzAlNZL6iRdIC7ZuemVvfrxpmmDwyO9BtByqm9CyAApJ1jYeemG2k4fGD4RNGmwrIGdMofGf+NW03S3/TgcLFhyxugadaC8ajerMkN8Ptdk2J/OWKWCSDxqxADjOTiSU=
Received: from CWLP265CA0497.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::15)
 by GV1P190MB2110.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:17d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:17 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::86) by CWLP265CA0497.outlook.office365.com
 (2603:10a6:400:18b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:17 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 08/32] net/ntnic: add port post init
Date: Thu, 20 Feb 2025 23:03:32 +0100
Message-ID: <20250220220406.3925597-9-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|GV1P190MB2110:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b9000cf4-434f-403e-daf9-08dd51fa8541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bXfp10KbM18DpsPhIy6BsIE0tRNWsYoSnH0TbHc7HL0b02kuZFpRgEZmmPmh?=
 =?us-ascii?Q?9k1TS49oQRTePpfGKAmveKn29TpUPJOxLnkgDFPbeKA807kuH4EX3TSp1CfD?=
 =?us-ascii?Q?BOEB1EXUy0mgnjMRDoRrcN2kk9NNVqYt6ovgVc6YJ8HW/v8ryiDgoqKYYyhG?=
 =?us-ascii?Q?LJCjLhcD/t9zSXU5lexJWHSbLUTWNddG73xSH/QJGHH/Rlny8W0obQfVbKzo?=
 =?us-ascii?Q?pLmWOA2Wtj7VxjljIS8lUS2j99GjKXBmYt/XNdpjlsVhDX9nHfwhu5BmDBT9?=
 =?us-ascii?Q?HdE6aNC3jnAMv+hCvbATp90FTBhPrXclR9+nm2P419aMl2dbacoSsVO0Vl1a?=
 =?us-ascii?Q?J4pCASbewJZ8kOV0uyRE+szbtDreK8P8RG71Jk/GWZy0fRCocsZ6X+AAMdXC?=
 =?us-ascii?Q?CxCyZ2OsZqw2x+z41jP4LII0Ud0IhNNGeSnSklMXWmRQqQhONNUS59DRbOAF?=
 =?us-ascii?Q?HxZGaJYOgsOwNrigvyB/qMVWbGrleiCqSdpuTECRfxG+hKc74AvuupXmfbiW?=
 =?us-ascii?Q?dE6gW2NAAC0WTK84W0WR0SnQZ970oinFaRFtkg4YF2FIqFC2pMyJuV1UrO1o?=
 =?us-ascii?Q?COzeHYPLypJ7To6go+0EKrIOXMMJHAnyCyL2x6OM+bZcZo2yCfwMmSBdAxF+?=
 =?us-ascii?Q?PGU++fROppd3IhYYw6XmgawL1lRuxURXkywln5EXCzLYHjpQKYn1nibv26Tg?=
 =?us-ascii?Q?uFDtM/fPwrV4jdt5veutQErOaYDOX+v0LXmVSKVn07qZLOF+VS6SK4n02ZiR?=
 =?us-ascii?Q?UC8fUh8KIfyyw7phvikHm3jzEH61Q1meD8Dr6w44xq72z4tNqAhEwBKHayHf?=
 =?us-ascii?Q?2i2rut9Egdf2s7eu6M5wID80MtYp2d9wG3hr+wPzIuqRNEk7M9AwMra0HG3e?=
 =?us-ascii?Q?2qXRpUNfZooQRYYgwh6bIrvMe1BMuD25VFQkOWe3O+9lNbLd1Ra1QgwFb8Zj?=
 =?us-ascii?Q?cttghfFuQvgO3bl6gw/DK32IgxQA01VBZHcQw8MvS54BhCOAcJs/pP13a8ap?=
 =?us-ascii?Q?3Vv14jpNWi5j42+0X6TQ5T0HSKEl4e/H79268/Nw3NBcnkuW9baZGtVp023C?=
 =?us-ascii?Q?NWbwFXAvf+XCqdgaAge15vIaSs0/aFuBPJtECXnF1SmT0VTGevNqj6kCUPUy?=
 =?us-ascii?Q?hEoxWmBzWUVqllgjY26x6TDr/qGyAS8tS+yNxaJQTlJvXxtVwebGjGtgbDwI?=
 =?us-ascii?Q?bfk9wbsi5g0m+i9LyXMfcTUA7bjjdQQMnAEX3i3jeLcTCNM0YroidbllFydE?=
 =?us-ascii?Q?QK2Mv/eVMvS8JG1hQdwpHU8HAurCNFMbIA3HtSZawVpPH8nhloxSDrabpPPi?=
 =?us-ascii?Q?6XU5K+RXIf9QOvkB9zz8EEbb4lzpVYC6eY7C9CgYr0QSyFIIQ2Xed2+9rbPF?=
 =?us-ascii?Q?6lnxlnC9OCFCp2N7wubvixSTeCHFdoX66uBJG6hZZYf+PZ3nYkdsuZ5GGjqj?=
 =?us-ascii?Q?9xkivT41l6ZpRLU2tlEmazxbwiK2k7BqFi7A7nTIK2A0VFhDNU1qvpWInJK7?=
 =?us-ascii?Q?B4qT061uVr0vdTI=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pZsbSuak7Y9dSV/O3AyK7Q11Dq2+8JCtCSZJibHxSngdymdrylrz1VWXhSOQRrU1eZw5IzAStJAcYokBgDvoznGFl509VPC1r8TH7fdLFGoAMRv0Hn+T0tcQz9HS1YCuSjX3JMJ5ef8pAGWkgexMHD59QlsfTPaFOCz9WgVUHIz2QADfNYZjbqANpTJh/Z8p1OtCt8kIfuFRPWpm0rgiwa3gIyyuEuyPVPJ/r0OfKVL8+azBc7c/ejroUsLYio5k2rw9Nqf07ffXNT7Juc3bW3XmtrSf1f0RwObLgh0AGcJI5kijkUROTGXgG55D0TRtZzxglrnL1akyWK/xRAOHc+bsOhrwM8gWt+uFd+q6+YdMna8Qs0lZBvndP98PUoWBnOu/8FgjhEztAvhAmF0VnnNuKUSP8c/3PQa/Jh2PBcOOZ0cu7l4zl0gfqvr3I2xISNaLFyws2ap/pmYr6CbAF5WcoTqs7iMBhmuZphE0wddUoN5w+OKKYQR8T6NDcc3VXmMMsmFmIkZEmQzqVq89RXlf5LAhrpR9Lt96Xs9TIaYEtUWnRcU5hlUdqKtiWBENq/MROX2E5hieMdUNS+z9unf4T55aShZ9PefIPZ9Ctu+6hE/aM5VtXe1QXexmmlz8OXvDXcCBTrLvlfdXKjx0HuFQZtecIZ1LOFu48hydO7Y=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:17.4587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9000cf4-434f-403e-daf9-08dd51fa8541
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB2110
X-BESS-ID: 1740089061-305508-25332-16458-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.51.236
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkamxgZGQGYGUNQ00TDRyNjU2N
 DUwiIlydAs0dw80TLN1NLMNDUpLSXJVKk2FgChcgIGQgAAAA==
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan21-197.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 1.00 BSF_SC7_GK0121_1       META: Custom rule BSF_SC7_GK0121_1 
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC7_GK0121_1
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

Configure FEC and TX equalization for 100G NIM on Agilex FPGA

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 122 ++++++++
 drivers/net/ntnic/nim/i2c_nim.c               |  80 +++++
 drivers/net/ntnic/nim/i2c_nim.h               |   3 +
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |  25 ++
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   | 295 ++++++++++++++++++
 5 files changed, 525 insertions(+)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 6593c90ca5..fe2acef612 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -372,6 +372,121 @@ static int create_nim(adapter_info_t *drv, int port, bool enable)
 	return res;
 }
 
+static int nim_ready_100_gb(adapter_info_t *p_info, int port)
+{
+	nt4ga_link_t *link_info = &p_info->nt4ga_link;
+	nim_i2c_ctx_t *nim_ctx = &link_info->u.nim_ctx[port];
+	nthw_phy_tile_t *p_phy_tile = p_info->fpga_info.mp_nthw_agx.p_phy_tile;
+
+	bool disable_fec_by_port_type = (nim_ctx->port_type == NT_PORT_TYPE_QSFP28_LR4);
+	bool enable_fec = nim_ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena &&
+		!disable_fec_by_port_type;
+
+	NT_LOG(DBG, NTNIC, "Port %s: DisableFec = %d", p_info->mp_port_id_str[port], !enable_fec);
+	/*
+	 * FecAutonegotiation at 100G is not supported for Napatech adapters and therefore
+	 * not relevant at this speed
+	 */
+
+	/* Adjust NIM power level */
+	if (nim_ctx->pwr_level_req > 4) {
+		qsfp28_set_high_power(nim_ctx);
+		nim_ctx->pwr_level_cur = nim_ctx->pwr_level_req;
+	}
+
+	/* enable_fec is what the end result should be, now find out if it's possible */
+	if (enable_fec) {
+		if (qsfp28_set_fec_enable(nim_ctx, true, false)) {
+			/* Prefer NIM media FEC since the NIM is assumed to know the right FEC */
+			NT_LOG(DBG, NTNIC, "Port %s: NIM media FEC enabled",
+				p_info->mp_port_id_str[port]);
+
+			/* The NIM has been set to FEC on the media side so turn FPGA FEC off */
+			if (nthw_phy_tile_configure_fec(p_phy_tile, port, true)) {
+				NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC disabled",
+					p_info->mp_port_id_str[port]);
+
+			} else {
+				NT_LOG(DBG, NTNIC,
+					"Port %s: FPGA does not support disabling of FEC",
+					p_info->mp_port_id_str[port]);
+				return 1;
+			}
+
+		} else if (qsfp28_set_fec_enable(nim_ctx, false, false)) {
+			/* The NIM does not support FEC at all so turn FPGA FEC on instead */
+			/* This is relevant to SR4 modules */
+			NT_LOG(DBG, NTNIC, "Port %s: No NIM FEC", p_info->mp_port_id_str[port]);
+			nthw_phy_tile_configure_fec(p_phy_tile, port, false);
+			NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC enabled",
+				p_info->mp_port_id_str[port]);
+
+		} else if (qsfp28_set_fec_enable(nim_ctx, true, true)) {
+			/* This probably not a likely scenario */
+			nthw_phy_tile_configure_fec(p_phy_tile, port, false);
+			NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC enabled",
+				p_info->mp_port_id_str[port]);
+			NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC terminated, NIM media FEC enabled",
+				p_info->mp_port_id_str[port]);
+
+		} else {
+			NT_LOG(ERR, NTNIC, "Port %s: Could not enable FEC",
+				p_info->mp_port_id_str[port]);
+			return 1;
+		}
+
+	} else if (qsfp28_set_fec_enable(nim_ctx, false, false)) {
+		/* The NIM does not support FEC at all - this is relevant to LR4 modules */
+		NT_LOG(DBG, NTNIC, "Port %s: No NIM FEC", p_info->mp_port_id_str[port]);
+
+		if (nthw_phy_tile_configure_fec(p_phy_tile, port, true)) {
+			NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC disabled",
+				p_info->mp_port_id_str[port]);
+
+		} else {
+			NT_LOG(ERR, NTNIC, "Port %s: FPGA does not support disabling of FEC",
+				p_info->mp_port_id_str[port]);
+			return 1;
+		}
+
+	} else if (qsfp28_set_fec_enable(nim_ctx, false, true)) {
+		nthw_phy_tile_configure_fec(p_phy_tile, port, false);
+		/* This probably not a likely scenario */
+		NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC enabled", p_info->mp_port_id_str[port]);
+		NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC terminated, NIM media FEC disabled",
+			p_info->mp_port_id_str[port]);
+
+	} else {
+		NT_LOG(ERR, NTNIC, "Port %s: Could not disable FEC",
+			p_info->mp_port_id_str[port]);
+		return 1;
+	}
+
+	if (port == 0) {
+		/* setTxEqualization(uint8_t intf_no, uint8_t lane, uint32_t pre_tap2,
+		 * uint32_t main_tap, uint32_t pre_tap1, uint32_t post_tap1)
+		 */
+		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 0, 0, 44, 2, 9);
+		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 1, 0, 44, 2, 9);
+		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 2, 0, 44, 2, 9);
+		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 3, 0, 44, 2, 9);
+
+	} else {
+		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 0, 0, 44, 2, 9);
+		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 1, 0, 44, 2, 9);
+		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 2, 0, 44, 2, 9);
+		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 3, 0, 44, 2, 9);
+	}
+
+	/*
+	 * Perform a full reset. If the RX is in reset from the start this sequence will
+	 * take it out of reset and this is necessary in order to read block/lane lock
+	 * in getLinkState()
+	 */
+	phy_reset_rx(p_info, port);
+	return 0;
+}
+
 /*
  * Initialize one 100 Gbps port.
  */
@@ -424,6 +539,13 @@ static int _port_init(adapter_info_t *p_info, nthw_fpga_t *fpga, int port)
 
 	NT_LOG(DBG, NTNIC, "%s: NIM initialized", p_info->mp_port_id_str[port]);
 
+	res = nim_ready_100_gb(p_info, port);
+
+	if (res) {
+		NT_LOG(WRN, NTNIC, "%s: NIM failed to get ready", p_info->mp_port_id_str[port]);
+		return res;
+	}
+
 	phy_reset_rx(p_info, port);
 	return res;
 }
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index f3cca9e555..892e1b58b7 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -192,6 +192,13 @@ static int read_data_lin(nim_i2c_ctx_p ctx, uint16_t lin_addr, uint16_t length,
 			NIM_READ);
 }
 
+static int write_data_lin(nim_i2c_ctx_p ctx, uint16_t lin_addr, uint16_t length, void *data)
+{
+	/* Wrapper for using Mutex for QSFP TODO */
+	return nim_read_write_data_lin(ctx, page_addressing(ctx->nim_id), lin_addr, length, data,
+		NIM_WRITE);
+}
+
 /* Read and return a single byte */
 static uint8_t read_byte(nim_i2c_ctx_p ctx, uint16_t addr)
 {
@@ -802,6 +809,79 @@ int construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra)
 	return res;
 }
 
+/*
+ * Enables high power according to SFF-8636 Rev 2.7, Table 6-9, Page 35:
+ * When set (= 1b) enables Power Classes 5 to 7 in Byte 129 to exceed 3.5W.
+ * When cleared (= 0b), modules with power classes 5 to 7 must dissipate less
+ * than 3.5W (but are not required to be fully functional). Default 0.
+ */
+void qsfp28_set_high_power(nim_i2c_ctx_p ctx)
+{
+	const uint16_t addr = 93;
+	uint8_t data;
+
+	/* Enable high power class; Set Page 00h, Byte 93 bit 2 to 1 */
+	read_data_lin(ctx, addr, sizeof(data), &data);
+	data |= (1 << 2);
+	write_data_lin(ctx, addr, sizeof(data), &data);
+}
+
+/*
+ * Enable FEC on media and/or host side. If the operation could be carried out
+ * return true. For some modules media side FEC is enabled but cannot be changed
+ *  while others allow changing the FEC state.
+ * For LR4 modules write operations (which are also not necessary) to the control
+ *  register must be avoided as this introduces I2C errors on NT200A01.
+ */
+
+bool qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool host_side_fec)
+{
+	/*
+	 * If the current FEC state does not match the wanted and the FEC cannot be
+	 * controlled then the operation cannot be carried out
+	 */
+	if (ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena != media_side_fec &&
+		!ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ctrl)
+		return false;
+
+	if (ctx->specific_u.qsfp.specific_u.qsfp28.host_side_fec_ena != host_side_fec &&
+		!ctx->specific_u.qsfp.specific_u.qsfp28.host_side_fec_ctrl)
+		return false;
+
+	/*
+	 * If the current media and host side FEC state matches the wanted states then
+	 * no need to do more
+	 */
+	if (ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena == media_side_fec &&
+		ctx->specific_u.qsfp.specific_u.qsfp28.host_side_fec_ena == host_side_fec)
+		return true;
+
+	/*
+	 * SFF-8636, Rev 2.10a TABLE 6-29 Optional Channel Control)
+	 * (Page 03h, Bytes 230-241)
+	 */
+	const uint16_t addr = 230 + 3 * 128;
+	uint8_t data = 0;
+	read_data_lin(ctx, addr, sizeof(data), &data);
+
+	if (media_side_fec)
+		data &= (uint8_t)(~(1 << 6));
+
+	else
+		data |= (uint8_t)(1 << 6);
+
+	if (host_side_fec)
+		data |= (uint8_t)(1 << 7);
+
+	else
+		data &= (uint8_t)(~(1 << 7));
+
+	write_data_lin(ctx, addr, sizeof(data), &data);
+	ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena = media_side_fec;
+	ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena = host_side_fec;
+	return true;
+}
+
 void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
 	nthw_pca9849_t *p_ca9849)
 {
diff --git a/drivers/net/ntnic/nim/i2c_nim.h b/drivers/net/ntnic/nim/i2c_nim.h
index 09837448c6..888b709135 100644
--- a/drivers/net/ntnic/nim/i2c_nim.h
+++ b/drivers/net/ntnic/nim/i2c_nim.h
@@ -33,6 +33,9 @@ int nim_qsfp_plus_nim_set_tx_laser_disable(nim_i2c_ctx_t *ctx, bool disable, int
  */
 int construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra);
 
+void qsfp28_set_high_power(nim_i2c_ctx_p ctx);
+bool qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool host_side_fec);
+
 void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
 	nthw_pca9849_t *p_ca9849);
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
index 5577f95944..c810f55c0d 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -34,15 +34,34 @@ struct nt_phy_tile {
 	nthw_field_t *mp_fld_link_summary_nt_phy_link_state[2];
 	nthw_field_t *mp_fld_link_summary_ll_nt_phy_link_state[2];
 	nthw_field_t *mp_fld_link_summary_link_down_cnt[2];
+	nthw_field_t *mp_fld_link_summary_lh_received_local_fault[2];
 	nthw_field_t *mp_fld_link_summary_lh_remote_fault[2];
 
+	nthw_field_t *mp_fld_port_status_rx_hi_ber[2];
+	nthw_field_t *mp_fld_port_status_rx_am_lock[2];
 	nthw_field_t *mp_fld_port_status_tx_reset_ackn[2];
 	nthw_field_t *mp_fld_port_status_rx_reset_ackn[2];
 
+	nthw_field_t *mp_fld_port_config_reset[2];
 	nthw_field_t *mp_fld_port_config_rx_reset[2];
 	nthw_field_t *mp_fld_port_config_tx_reset[2];
 
+	nthw_field_t *mp_fld_port_comp_rx_compensation[2];
+
+	nthw_register_t *mp_reg_dyn_reconfig_base;
+	nthw_field_t *mp_fld_dyn_reconfig_base_ptr;
+	nthw_field_t *mp_fld_dyn_reconfig_base_busy;
+	nthw_field_t *mp_fld_dyn_reconfig_base_cmd;
+
+	nthw_register_t *mp_reg_dyn_reconfig_data;
+	nthw_field_t *mp_fld_dyn_reconfig_data_data;
+
 	nthw_field_t *mp_fld_scratch_data;
+
+	nthw_register_t *mp_reg_dr_cfg_status;
+	nthw_field_t *mp_fld_dr_cfg_status_curr_profile_id;
+	nthw_field_t *mp_fld_dr_cfg_status_in_progress;
+	nthw_field_t *mp_fld_dr_cfg_status_error;
 };
 
 typedef struct nt_phy_tile nthw_phy_tile_t;
@@ -52,9 +71,15 @@ void nthw_phy_tile_set_tx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t l
 void nthw_phy_tile_set_rx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, bool invert);
 void nthw_phy_tile_set_host_loopback(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 	bool enable);
+void nthw_phy_tile_set_tx_equalization(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
+	uint32_t pre_tap2, uint32_t main_tap, uint32_t pre_tap1,
+	uint32_t post_tap1);
 void nthw_phy_tile_set_tx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset);
 void nthw_phy_tile_set_rx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset);
 
+uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address);
+void nthw_phy_tile_write_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address, uint32_t data);
+bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enable);
 uint32_t nthw_phy_tile_read_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 	uint32_t address);
 void nthw_phy_tile_write_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, uint32_t address,
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index 6402e5caf3..42e2782f99 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -14,10 +14,15 @@
 
 static const uint32_t link_addr = 0x9003C;
 static const uint32_t phy_addr = 0x90040;
+static const uint32_t tx_eq_addr = 0x47830;
 /* CPI option flags */
 static const uint32_t cpi_set = 0x2000;	/* 1 << 13 */
 static const uint32_t cpi_in_reset = 0x4000;	/* 1 << 14 */
 static const uint32_t bit_cpi_assert = 0x8000;	/* 1 << 15 */
+static const uint32_t dyn_rcfg_dr_trigger_reg;
+static const uint32_t dyn_rcfg_dr_next_profile_0_reg = 0x4;
+static const uint32_t dyn_rcfg_dr_next_profile_1_reg = 0x8;
+static const uint32_t dyn_rcfg_dr_next_profile_2_reg = 0xc;
 /*
  * Base Addresses for Avalon MM Secondary Components
  * static const uint32_t ADDR_AVMM_DR_CTRL_INT                  =  0x10035000 << 0;
@@ -35,6 +40,21 @@ static const uint32_t bit_cpi_assert = 0x8000;	/* 1 << 15 */
  *
  * ETH AVMM USER SPACE Registers Address Map
  */
+static const uint32_t eth_soft_csr1 = 0x200;
+static const uint32_t eth_soft_csr2 = 0x204;
+static const uint32_t eth_soft_csr3 = 0x208;
+
+static void nthw_phy_tile_set_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset)
+{
+	/* Reset is active low */
+	nthw_field_get_updated(p->mp_fld_port_config_reset[intf_no]);
+
+	if (reset)
+		nthw_field_clr_flush(p->mp_fld_port_config_reset[intf_no]);
+
+	else
+		nthw_field_set_flush(p->mp_fld_port_config_reset[intf_no]);
+}
 
 void nthw_phy_tile_set_rx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset)
 {
@@ -118,6 +138,38 @@ void nthw_phy_tile_write_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 		nt_os_wait_usec(100);
 }
 
+static uint32_t nthw_phy_tile_read_dyn_reconfig(nthw_phy_tile_t *p, uint32_t address)
+{
+	nthw_register_update(p->mp_reg_dyn_reconfig_base);
+	nthw_field_set_val32(p->mp_fld_dyn_reconfig_base_cmd, 0);
+	nthw_field_set_val_flush32(p->mp_fld_dyn_reconfig_base_ptr, address);
+
+	while (nthw_field_get_updated(p->mp_fld_dyn_reconfig_base_busy) == 1)
+		nt_os_wait_usec(100);
+
+	uint32_t value = nthw_field_get_updated(p->mp_fld_dyn_reconfig_data_data);
+	/*
+	 * NT_LOG(INF, NTHW, "nthw_phy_tile_read_dyn_reconfig address %0x value,
+	 * %0x", address, value);
+	 */
+	return value;
+	/* return nthw_field_get_updated(p->mp_fld_dyn_reconfig_data_data); */
+}
+
+static void nthw_phy_tile_write_dyn_reconfig(nthw_phy_tile_t *p, uint32_t address, uint32_t data)
+{
+	nthw_register_update(p->mp_reg_dyn_reconfig_data);
+	nthw_field_set_val_flush32(p->mp_fld_dyn_reconfig_data_data, data);
+
+	nthw_register_update(p->mp_reg_dyn_reconfig_base);
+	nthw_field_set_val32(p->mp_fld_dyn_reconfig_base_ptr, address);
+	nthw_field_set_val_flush32(p->mp_fld_dyn_reconfig_base_cmd, 1);
+
+	while (nthw_field_get_updated(p->mp_fld_dyn_reconfig_base_busy) == 1)
+		/* NT_LOG(INF, NTHW, "busy"); */
+		nt_os_wait_usec(100);
+}
+
 static uint32_t nthw_phy_tile_cpi_request(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 	uint32_t data, uint8_t op_code, uint32_t cpi_assert,
 	uint32_t cpi_set_get)
@@ -199,3 +251,246 @@ void nthw_phy_tile_set_host_loopback(nthw_phy_tile_t *p, uint8_t intf_no, uint8_
 	 * intf_no, lane, enable);
 	 */
 }
+
+void nthw_phy_tile_set_tx_equalization(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
+	uint32_t pre_tap2, uint32_t main_tap, uint32_t pre_tap1,
+	uint32_t post_tap1)
+{
+	uint32_t data = (pre_tap2 << 16) + (main_tap << 10) + (pre_tap1 << 5) + (post_tap1);
+	NT_LOG(DBG, NTHW,
+		"intf_no %u: setTxEq lane %u, pre_tap2 %u, main_tap %u, pre_tap1 %u, post_tap1 %u data %x",
+		intf_no, lane, pre_tap2, main_tap, pre_tap1, post_tap1, data);
+	nthw_phy_tile_write_xcvr(p, intf_no, lane, tx_eq_addr + 0x8000U * lane, data);
+}
+
+static bool nthw_phy_tile_read_fec_enabled_by_scratch(nthw_phy_tile_t *p, uint8_t intf_no)
+{
+	bool fec_enabled = false;
+
+	if (p->mp_fld_scratch_data) {
+		fec_enabled =
+			!((nthw_field_get_updated(p->mp_fld_scratch_data) >> (intf_no)) & 0x1);
+	}
+
+	/*
+	 * log(INF,"intf_no: %d FEC state read from inverted port specificscratch register
+	 * value %u ", intf_no,fec_enabled);
+	 */
+	return fec_enabled;
+}
+
+static void nthw_phy_tile_write_fec_enabled_by_scratch(nthw_phy_tile_t *p, uint8_t intf_no,
+	bool fec_enabled)
+{
+	const uint8_t mask = intf_no == 0U ? 0xf0U : 0xfU;
+	const uint8_t status_other_port =
+		(uint8_t)(nthw_field_get_updated(p->mp_fld_scratch_data) & mask);
+	const uint8_t disablebit = (uint8_t)(1U << (4 * intf_no));
+	const uint8_t val =
+		fec_enabled ? status_other_port : (uint8_t)(status_other_port | disablebit);
+	/*  NT_LOG(INF, NTHW, "intf_no: %u write ScratchFEC value %u", intf_no, val); */
+	nthw_field_set_val_flush32(p->mp_fld_scratch_data, val);
+}
+
+uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address)
+{
+	nthw_register_update(p->mp_reg_port_eth_base[intf_no]);
+	nthw_field_set_val32(p->mp_fld_port_eth_base_cmd[intf_no], 0);
+	nthw_field_set_val_flush32(p->mp_fld_port_eth_base_ptr[intf_no], address);
+
+	while (nthw_field_get_updated(p->mp_fld_port_eth_base_busy[intf_no]) == 1)
+		nt_os_wait_usec(100);
+
+	return nthw_field_get_updated(p->mp_fld_port_eth_data_data[intf_no]);
+}
+
+void nthw_phy_tile_write_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address, uint32_t data)
+{
+	nthw_field_set_val_flush32(p->mp_fld_port_eth_data_data[intf_no], data);
+	nthw_register_update(p->mp_reg_port_eth_base[intf_no]);
+	nthw_field_set_val32(p->mp_fld_port_eth_base_ptr[intf_no], address);
+	nthw_field_set_val_flush32(p->mp_fld_port_eth_base_cmd[intf_no], 1);
+
+	while (nthw_field_get_updated(p->mp_fld_port_eth_base_busy[intf_no]) == 1)
+		/* NT_LOG(INF, NTHW, "busy"); */
+		nt_os_wait_usec(100);
+}
+
+bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enable)
+{
+	/*
+	 * FPGA must have the Dynamic Reconfig register for FEC configuration to work.
+	 * Previous versions of the FPGA enable FEC statically.
+	 */
+	if (!p->mp_reg_dyn_reconfig_base)
+		return false;
+
+	/*
+	 * NT_LOG(INF, NTHW, "void nthw_phy_tile_configure_fec(intf_no %u, enable %u)",
+	 * intf_no, enable);
+	 */
+
+	/* Available DR profiles related to FEC */
+	/* Used as end symbol in profile sequence fed to NIOS processor - not really a profile. */
+	const uint32_t neutral_dr_profile = 0;
+
+	/* DR Fec profiles port 0*/
+	const uint32_t intf_no0_with_fec_dr_profile = 1;
+	const uint32_t intf_no0_no_fec_dr_profile = 2;
+
+	/* DR Fec profiles port 1 */
+	const uint32_t intf_no1_with_fec_dr_profile = 3;
+	const uint32_t intf_no1_no_fec_dr_profile = 4;
+
+	const uint32_t fec_profile_none = 0x00;
+	const uint32_t fec_profile_cl91 = 0x02;
+
+	uint32_t original_dr_profile_id = 0x00;
+	uint32_t destination_dr_profile_id = 0x00;
+	uint32_t final_fec_profile = 0x00;
+
+	if (intf_no == 0) {
+		original_dr_profile_id =
+			enable ? intf_no0_no_fec_dr_profile : intf_no0_with_fec_dr_profile;
+		destination_dr_profile_id =
+			enable ? intf_no0_with_fec_dr_profile : intf_no0_no_fec_dr_profile;
+
+	} else if (intf_no == 1) {
+		original_dr_profile_id =
+			enable ? intf_no1_no_fec_dr_profile : intf_no1_with_fec_dr_profile;
+		destination_dr_profile_id =
+			enable ? intf_no1_with_fec_dr_profile : intf_no1_no_fec_dr_profile;
+	}
+
+	final_fec_profile = enable ? fec_profile_cl91 : fec_profile_none;
+
+	/*
+	 * These steps are copied from a code example provided by Intel: ftile_eth_dr_test.tcl
+	 * Step 6: Program DUT soft CSR
+	 * The CSR registers are reset by the FPGA reset sequence so
+	 * they need to be set every time the driver is restarted.
+	 * This is why we perform step 6 first before step 1.
+	 */
+	uint32_t current_fec_profile = nthw_phy_tile_read_eth(p, intf_no, eth_soft_csr2);
+
+	if (current_fec_profile != final_fec_profile) {
+		nthw_phy_tile_set_reset(p, intf_no, true);
+		nthw_phy_tile_set_tx_reset(p, intf_no, true);
+		NT_LOG(DBG, NTHW, "intf_no %u: Program DUT soft CSR", intf_no);
+		/* Select profile */
+		nthw_phy_tile_write_eth(p, intf_no, eth_soft_csr1, 0x00);
+
+		/* Select FEC-Mode */
+		nthw_phy_tile_write_eth(p, intf_no, eth_soft_csr2,
+			(0 << 9) + (0 << 6) + (0 << 3) + (final_fec_profile << 0));
+
+		nt_os_wait_usec(10000);
+		nthw_phy_tile_set_reset(p, intf_no, false);
+		nthw_phy_tile_set_tx_reset(p, intf_no, false);
+
+		NT_LOG(DBG, NTHW, "intf_no %u: Register eth_soft_csr1 profile_sel: 0x%2.2x",
+			intf_no, nthw_phy_tile_read_eth(p, intf_no, eth_soft_csr1));
+		NT_LOG(DBG, NTHW, "intf_no %u: Register eth_soft_csr2 fec_mode:    0x%2.2x",
+			intf_no, nthw_phy_tile_read_eth(p, intf_no, eth_soft_csr2));
+		NT_LOG(DBG, NTHW, "intf_no %u: Register eth_soft_csr3 sel:         0x%2.2x",
+			intf_no, nthw_phy_tile_read_eth(p, intf_no, eth_soft_csr3));
+	}
+
+	/*
+	 * The FEC profile applied with Dynamic Reconfiguration is persistent through
+	 * a driver restart. Additionally, the operation is not idempotent, meaning that
+	 * the operations must only be performed when actual reconfiguration is necessary.
+	 * We use a persistent scratch register provided by the FPGA to store the FEC
+	 * state since we have not been able to get any of the methods suggested
+	 * by Intel to function properly.
+	 */
+	if (nthw_phy_tile_read_fec_enabled_by_scratch(p, intf_no) == enable)
+		return true;
+
+	/* Step 1: Wait for DR NIOS to be ready */
+	NT_LOG(DBG, NTHW, "intf_no %u: Step 1 Wait for DR NIOS", intf_no);
+
+	while ((nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_trigger_reg) & 0x02) != 0x02)
+		nt_os_wait_usec(10000);
+
+	/* Step 2: Triggering Reconfiguration */
+	NT_LOG(DBG, NTHW, "intf_no %u: Step 2: Triggering Reconfiguration", intf_no);
+
+	nthw_phy_tile_set_reset(p, intf_no, true);
+	nthw_phy_tile_set_rx_reset(p, intf_no, true);
+	nthw_phy_tile_set_tx_reset(p, intf_no, true);
+	nt_os_wait_usec(10000);
+
+	/* Disable original profile */
+	nthw_phy_tile_write_dyn_reconfig(p, dyn_rcfg_dr_next_profile_0_reg,
+		(1U << 18) + (0U << 15) + original_dr_profile_id);
+	nt_os_wait_usec(10000);
+	NT_LOG(DBG, NTHW, "intf_no %u: dyn_rcfg_dr_next_profile_0_reg: %#010x", intf_no,
+		nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_next_profile_0_reg));
+
+	nthw_phy_tile_write_dyn_reconfig(p, dyn_rcfg_dr_next_profile_1_reg,
+		(1U << 15) + destination_dr_profile_id + (0U << 31) +
+		(neutral_dr_profile << 16));
+	/*
+	 * Enable profile 2 and terminate dyn reconfig by
+	 * setting next profile to 0 and deactivate it
+	 */
+	nt_os_wait_usec(10000);
+	NT_LOG(DBG, NTHW, "intf_no %u: dyn_rcfg_dr_next_profile_1_reg: %#010x", intf_no,
+		nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_next_profile_1_reg));
+
+	/*
+	 * We do not know if this neutral profile is necessary.
+	 * It is done in the example design and INTEL has not
+	 * answered our question if it is necessary or not.
+	 */
+	nthw_phy_tile_write_dyn_reconfig(p, dyn_rcfg_dr_next_profile_2_reg,
+		(0U << 15) + neutral_dr_profile + (0U << 31) +
+		(neutral_dr_profile << 16));
+	nt_os_wait_usec(10000);
+	NT_LOG(DBG, NTHW, "intf_no %u: dyn_rcfg_dr_next_profile_2_reg: %#010x", intf_no,
+		nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_next_profile_2_reg));
+
+	nt_os_wait_usec(10000);
+
+	/* Step 3: Trigger DR interrupt */
+	NT_LOG(DBG, NTHW, "intf_no %u: Step 3: Trigger DR interrupt", intf_no);
+	nthw_phy_tile_write_dyn_reconfig(p, dyn_rcfg_dr_trigger_reg, 0x00000001);
+
+	nt_os_wait_usec(1000000);
+
+	/* Step 4: Wait for interrupt Acknowledge */
+	NT_LOG(DBG, NTHW, "intf_no %u: Step 4: Wait for interrupt Acknowledge", intf_no);
+
+	while ((nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_trigger_reg) & 0x01) != 0x00)
+		nt_os_wait_usec(10000);
+
+	nt_os_wait_usec(10000);
+
+	/* Step 5: Wait Until DR config is done */
+	NT_LOG(DBG, NTHW, "intf_no %u: Step 5: Wait Until DR config is done", intf_no);
+
+	while ((nthw_phy_tile_read_dyn_reconfig(p, dyn_rcfg_dr_trigger_reg) & 0x02) != 0x02)
+		nt_os_wait_usec(10000);
+
+	nt_os_wait_usec(1000000);
+
+	/* Write Fec status to scratch register */
+	nthw_phy_tile_write_fec_enabled_by_scratch(p, intf_no, enable);
+
+	nt_os_wait_usec(1000000);
+
+	nthw_phy_tile_set_reset(p, intf_no, false);
+	nthw_phy_tile_set_tx_reset(p, intf_no, false);
+	nthw_phy_tile_set_rx_reset(p, intf_no, false);
+
+	nthw_register_update(p->mp_reg_dr_cfg_status);
+	NT_LOG(DBG, NTHW, "intf_no %u: DrCfgStatusCurrPofileId: %u", intf_no,
+		nthw_field_get_val32(p->mp_fld_dr_cfg_status_curr_profile_id));
+	NT_LOG(DBG, NTHW, "intf_no %u: DrCfgStatusInProgress:  %u", intf_no,
+		nthw_field_get_val32(p->mp_fld_dr_cfg_status_in_progress));
+	NT_LOG(DBG, NTHW, "intf_no %u: DrCfgStatusError: %u", intf_no,
+		nthw_field_get_val32(p->mp_fld_dr_cfg_status_error));
+
+	return true;
+}
-- 
2.45.0

