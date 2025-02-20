Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA9C021B4
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:04:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2693840A76;
	Thu, 20 Feb 2025 23:04:23 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4E27640653
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:19 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 mx-outbound21-132.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxTES88rzqfwFFjzhJ2dB6641iVRI+7vrQBf01OnqKFyqgrMUVRgqAvrXWo4TNBussuMWqsu8etAISjxj4ySRx+ZT9hCuxejOiA2qAkcMcWo2vIMPK4CfuuTSGiKcM5lj5QW+hRvuFeugIp9XXD91Remr91yhEn6UL9qejX2udk0HTwILF0By72CIZyAIHjbNzQOTv4lDLprOvnk3qE1TgN02l/0oDuamDbQK6XZ7rAH3rrweTrpKFZiprw12vZtMB2g1SjNHdEv4INxwx+rEWwWZZQ3TKe0xjyLoJpAnq35IO/mgCIr2260GBHUX2fAO/2hmLseb0boVkZBPjjdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhIE+VsUopdglG4jq4JfZm59hwrEMg1oGFOxyXPKuqI=;
 b=CcXHtr7skJemfRXA1EyG92xz9k1QMkwuxhgoLqBTcEN7lCygcJiJjcv26Wnf15+VoMcqSjaDtKEkfmfauWJ3fdhtm+v7GjaFmIr8jtn4yAYZ3Q1gO5dzDeRt1B2wDX86NEYNJp565xr1EqgkD6HfM/nf1cw7MKUSleRgIvciiL189wqMvhzr3pTcMuDLPnHyQhE8tTqo1xkjUHBbgv5X7hKCqIBzzWfcGEw0hGNq6v+g4cwhTtainqTkdn30c10tC9zeKMMLEgHchkFbmnRpUw0+7GgFHUhau1wynhkMOrFZkHc08POt/NzGzYXlr3mVEHJUcyrn69cRRWgttU8ixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhIE+VsUopdglG4jq4JfZm59hwrEMg1oGFOxyXPKuqI=;
 b=f8QKlfQLBPaUz+PKYx+fVCG2OAf5J1Xc8oCfCSHkpGhn9grnTKJEAOLJx5yMRxIP6wmV5Spu2jIOO6bMkP91GvrtnoQ+/HmGYOWj9lgV/wjkGd97/qwNAH1rb2ShGuwGyHvmhmvq5e6Cp/suxYBST/vL9Cq/POnXuyX+2xnIa08=
Received: from CWLP265CA0503.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::9)
 by AS8P190MB1911.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:524::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 22:04:16 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::46) by CWLP265CA0503.outlook.office365.com
 (2603:10a6:400:18b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 22:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:16 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 06/32] net/ntnic: add line loopback init
Date: Thu, 20 Feb 2025 23:03:30 +0100
Message-ID: <20250220220406.3925597-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AS8P190MB1911:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba320b18-4086-4453-6dfe-08dd51fa8472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8I+F1ohVibUw9hnbIDOpGfU7ZpvPEySNrcdK/1RtOEdtbSF+1s1+6pSpSP2T?=
 =?us-ascii?Q?JmDwjhvJN2sETeqnUDWnn6YpmyAfpriEPfKiFh74vzNkFMYDI3ttn5SIJfqI?=
 =?us-ascii?Q?c08QUXqvdC1DKCfBcJzfa5g3v7rEbQgRAvxodoUk2kHWoq0WevwNloIiRIn5?=
 =?us-ascii?Q?J6JUKqZqDXYnX2N4yhE8e1XqFfewBBvCKBGojJkHGbUJpHI/0Rg89IpDu+0U?=
 =?us-ascii?Q?MHCtqeJ1qTdmjFoAakv1MihIV1B2eEeZkpj0zMemM0Hnll3vHiAUPQ4hsfK5?=
 =?us-ascii?Q?ndjfBdU6ywfGAE3zhMRWc4zcbLo7K5YDEhwzKZ0PIDSj/EuVURe7EOpIceDE?=
 =?us-ascii?Q?ndb2bEYfjJtB+Y3OcHFrrh5KvpSeyQj8/r+0AR1pGZWu/beMzaulJuHt8S1K?=
 =?us-ascii?Q?a/uAlURVpBeN7RClaLJzM9ILqXNfDsXViKwFZhfy5EQVkPxgK/0s/DkHadg2?=
 =?us-ascii?Q?QhLcg53ppViXZkJR5rOXcGliFwJYBaPbIQ39xlREtPZbc7ZpnEHDyDWDYZwC?=
 =?us-ascii?Q?i4XoOMbln4szVhRv9+3IfKnCk9NDtt6y6HoZ1ZhuABxlFG3FeVONn+rCzHbE?=
 =?us-ascii?Q?YhX6DgnZF+UUBaBt1gKuksQAlbhM9gV3Mfc38SiVT9nkgS6eEYJlvi2vLLwp?=
 =?us-ascii?Q?LwUcys67kmD6AE6A77RP8MYgjZpoOlRLcu2Cu533Jq0Qlc8zvdnluLOsLzpI?=
 =?us-ascii?Q?q7mUODW+ikoIagiUqIxd+i6Zwx9MAnWxu/B2rd8fOo6nbw5W/dPLFGZmWM+H?=
 =?us-ascii?Q?2OryKkUJJHKD4sABIXqlrxQTBe1bU+vnLU68DcLqKWEMN/p4CMaUKx3Lg9mC?=
 =?us-ascii?Q?jGDCcHI+TQruOLskX1UkkNQswjXxoyQpomyKltRzHv4M+dtX19Ex8GlZDayp?=
 =?us-ascii?Q?eX0do4trQuLFNBvfwx1EGNt/49/5svvTh+7vCV7Y/0QEzuLJY5UAsDvEt17O?=
 =?us-ascii?Q?tlF1RWZwnf/PToNm/+AtO2HIwJ07wR/PCE0y2ODiIFx6ZwpcQizsPsJqiop2?=
 =?us-ascii?Q?nbxkGYETpnBW1C6+nbgZkuCbU+EP+RRLkV9zMff2kQrxbe806cHWBw56/etn?=
 =?us-ascii?Q?bPxbUJ7yY3d7czF/7usOeLA2d/ZKb3rMQQT6/yw1xcUuR7VV6FjB19JeV0zM?=
 =?us-ascii?Q?/lbHPUba/5zMVqKLKLtnCsmpkrxY4kZKACytq+0tVyVwtzhkRtop09u8wEnk?=
 =?us-ascii?Q?41yHCC4rkBqcmIKZNvi0O9cezwcfI1pOvQAkVUquD1t8hZG5YrzlpXHc4DMs?=
 =?us-ascii?Q?wK7zKPEmnQPDX9gKNdiAc1FlJJSL5fK4+nIXJlzOsXVwT7zJ+ZBIKXkI6qSN?=
 =?us-ascii?Q?LZ1Ng18JACYmJwfECaTzoRs8NS0Rn6lR3xXvpLa9Sjra0KAVpg65KkYvmQDK?=
 =?us-ascii?Q?R6/uWnVd+w4vc5b37x4/xeYe9MrbVPk5FGMQxgNGcVkE4HcaosC52k/X+l0o?=
 =?us-ascii?Q?qrFdh17xOptMBLZmUW2l+K+T9LaBZVJ6mDBOUBXVEOkSJraalmNJceiYum30?=
 =?us-ascii?Q?YrzEjyGZZgR201A=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kg9/gCLwCM3zvFsOZ2GVBylM8ZGa+zr6GoViTqcoGN5Gm8oCS48xzRaSUsNv809gkIfrx16pjHcG/VM4ygR/ZvKePbDPMd6xiz9VYyR1bvSpRZVQZJ+38MtPiZODqRIsW7rVk1LJ9Utwlfq3s8LAKkkLmSjLjcvBS5RfsxYALXaE0vwTlZDPPb1gRTX8HTJzAm8kOjCiQikWD2+hUYjb8pIW2ATBlwkWZvGmiI7fs9EsckVdewxxedJrRa3Nydmpvh7KcxLY6WRunFqql1C+xFLKnIUIsMK/adkmxmtpyWZ4d0DGK/z/ZPhlcMuAh8TuZlQEEoq7DHbffW3qd4sq63eiw7XyKoZi7Hl+xEBd1IClwvCnCiqOczvQjMv5Nivs7msD5awI1Q64Jdg737+FvBPSRilwl/cixojK0ODAmt+DoqAuvrrSEiI5mLyKMuSVJzSIrECTQ+aj7NHbvTDL85KP4UQUtb9spdp4kThqWrdxHhB+LNg1ue0+TXmKOt8fhm8oASeOaXEHcPFJrnPYgumovpkjiilcQa/w2yBeOo4jorUQiGLnvtwcqoxncZvpkQXdL0Gq7SXbCe74QPFtxmQwXQLFue6+N5qNiJCk6D6rhiTtaNdzhQW3xaqzVtt92VbMTrw/wCQRgUKnlxH0mqwuY3mKzslaMIutEZ6KbB0=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:16.0995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba320b18-4086-4453-6dfe-08dd51fa8472
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1911
X-BESS-ID: 1740089058-305508-25334-16456-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpaW5kZAVgZQMNXMxMDE2DzF0j
 zR0jTNxMAoKdnC1NI4NckwxcTIODVZqTYWABAFdQ9BAAAA
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Implement PHY host loopback configuration for Agilex FPGA

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 116 ++++++++++++++++++
 drivers/net/ntnic/meson.build                 |   1 +
 drivers/net/ntnic/nim/i2c_nim.c               |  70 +++++++++--
 .../nthw/core/include/nthw_si5332_si5156.h    |   6 +
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |  31 +++++
 5 files changed, 216 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index f3862b7fe3..9551dfdfdc 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -19,6 +19,11 @@ typedef enum {
 	LOOPBACK_HOST
 } loopback_host_t;
 
+typedef enum {
+	LOOPBACK_LINE_NONE,
+	LOOPBACK_LINE
+} loopback_line_t;
+
 static int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info,
 	nthw_fpga_t *fpga);
 
@@ -93,6 +98,105 @@ static int phy_set_host_loopback(adapter_info_t *drv, int port, loopback_host_t
 	return 0;
 }
 
+static int phy_set_line_loopback(adapter_info_t *drv, int port, loopback_line_t loopback)
+{
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+	uint32_t addr;
+
+	switch (loopback) {
+	case LOOPBACK_LINE_NONE:
+		for (uint8_t lane = 0; lane < 4; lane++) {
+			uint8_t quad_lane;
+
+			for (uint8_t fgt = 0; fgt < 4; fgt++) {
+				uint8_t quad_and_lane_no =
+					(uint8_t)nthw_phy_tile_read_xcvr(p, port, lane, 0xFFFFC);
+				quad_lane = quad_and_lane_no & 0x3;	/* bits[1:0] */
+
+				if (quad_lane == lane)
+					break;
+			}
+
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x41830u + (0x8000u * quad_lane),
+				0x03);
+
+			addr = nthw_phy_tile_read_xcvr(p, 0, 0, 0x41768u + (0x8000u * quad_lane)) |
+				(1u << 24u);
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x41768u + (0x8000u * quad_lane),
+				addr);
+
+			addr = nthw_phy_tile_read_xcvr(p, 0, 0, 0x41414u + (0x8000u * quad_lane)) &
+				~(1u << 29u);
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x41414u + (0x8000u * quad_lane),
+				addr);
+
+			addr = nthw_phy_tile_read_xcvr(p, 0, 0, 0x4141Cu + (0x8000u * quad_lane)) &
+				~(1u << 30u);
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x4141Cu + (0x8000u * quad_lane),
+				addr);
+
+			addr = nthw_phy_tile_read_xcvr(p, 0, 0, 0x41418u + (0x8000u * quad_lane)) &
+				~(1u << 31u);
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x41418u + (0x8000u * quad_lane),
+				addr);
+		}
+
+		break;
+
+	case LOOPBACK_LINE:
+		for (uint8_t lane = 0; lane < 4; lane++) {
+			uint8_t quad_lane;
+
+			for (uint8_t fgt = 0; fgt < 4; fgt++) {
+				uint8_t quad_and_lane_no =
+					(uint8_t)nthw_phy_tile_read_xcvr(p, port, lane, 0xFFFFC);
+				quad_lane = quad_and_lane_no & 0x3;	/* bits[1:0] */
+
+				if (quad_lane == lane)
+					break;
+			}
+
+			addr = nthw_phy_tile_read_xcvr(p, port, 0,
+					0x41830u + (0x8000u * quad_lane)) &
+				0u;
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x41830u + (0x8000u * quad_lane),
+				addr);
+
+			addr = nthw_phy_tile_read_xcvr(p, port, 0,
+					0x41768u + (0x8000u * quad_lane)) &
+				~(1u << 24u);
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x41768u + (0x8000u * quad_lane),
+				addr);
+
+			addr = nthw_phy_tile_read_xcvr(p, port, 0,
+					0x41414u + (0x8000u * quad_lane)) |
+				(1u << 29u);
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x41414u + (0x8000u * quad_lane),
+				addr);
+
+			addr = nthw_phy_tile_read_xcvr(p, port, 0,
+					0x4141Cu + (0x8000u * quad_lane)) |
+				(1u << 30u);
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x4141Cu + (0x8000u * quad_lane),
+				addr);
+
+			addr = nthw_phy_tile_read_xcvr(p, port, 0,
+					0x41418u + (0x8000u * quad_lane)) |
+				(1u << 31u);
+			nthw_phy_tile_write_xcvr(p, port, 0, 0x41418u + (0x8000u * quad_lane),
+				addr);
+		}
+
+		break;
+
+	default:
+		NT_LOG(ERR, NTNIC, "Port %d: Unhandled loopback value (%d)", port, loopback);
+		return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Utility functions
  */
@@ -156,6 +260,12 @@ set_loopback(struct adapter_info_s *p_adapter_info, int port, uint32_t mode, uin
 		swap_tx_rx_polarity(p_adapter_info, port, false);
 		break;
 
+	case 2:
+		NT_LOG(INF, NTNIC, "%s: Applying line loopback",
+			p_adapter_info->mp_port_id_str[port]);
+		phy_set_line_loopback(p_adapter_info, port, LOOPBACK_LINE);
+		break;
+
 	default:
 		switch (last_mode) {
 		case 1:
@@ -165,6 +275,12 @@ set_loopback(struct adapter_info_s *p_adapter_info, int port, uint32_t mode, uin
 			swap_tx_rx_polarity(p_adapter_info, port, true);
 			break;
 
+		case 2:
+			NT_LOG(INF, NTNIC, "%s: Removing line loopback",
+				p_adapter_info->mp_port_id_str[port]);
+			phy_set_line_loopback(p_adapter_info, port, LOOPBACK_LINE_NONE);
+			break;
+
 		default:
 			/* do nothing */
 			break;
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 4799ebfb8e..271115cdd3 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -56,6 +56,7 @@ sources = files(
         'nthw/core/nthw_mac_pcs.c',
         'nthw/core/nthw_pcie3.c',
         'nthw/core/nthw_phy_tile.c',
+        'nthw/core/nthw_si5332_si5156.c',
         'nthw/core/nthw_rpf.c',
         'nthw/core/nthw_rmc.c',
         'nthw/core/nthw_sdc.c',
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 7dbbdb8873..f3cca9e555 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -13,6 +13,12 @@
 #include "qsfp_registers.h"
 #include "nim_defines.h"
 
+int nim_agx_read_id(struct nim_i2c_ctx *ctx);
+static void nim_agx_read(struct nim_i2c_ctx *ctx, uint8_t dev_addr, uint8_t reg_addr,
+	uint8_t data_len, void *p_data);
+static void nim_agx_write(struct nim_i2c_ctx *ctx, uint8_t dev_addr, uint8_t reg_addr,
+	uint8_t data_len, void *p_data);
+
 #define NIM_READ false
 #define NIM_WRITE true
 #define NIM_PAGE_SEL_REGISTER 127
@@ -50,17 +56,17 @@ static int nim_read_write_i2c_data(nim_i2c_ctx_p ctx, bool do_write, uint16_t li
 		if (ctx->type == I2C_HWIIC) {
 			return nthw_iic_write_data(&ctx->hwiic, i2c_devaddr, a_reg_addr, seq_cnt,
 					p_data);
-
-		} else {
-			return 0;
 		}
 
-	} else if (ctx->type == I2C_HWIIC) {
-		return nthw_iic_read_data(&ctx->hwiic, i2c_devaddr, a_reg_addr, seq_cnt, p_data);
-
-	} else {
+		nim_agx_write(ctx, i2c_addr, a_reg_addr, seq_cnt, p_data);
 		return 0;
 	}
+
+	if (ctx->type == I2C_HWIIC)
+		return nthw_iic_read_data(&ctx->hwiic, i2c_devaddr, a_reg_addr, seq_cnt, p_data);
+
+	nim_agx_read(ctx, i2c_addr, a_reg_addr, seq_cnt, p_data);
+	return 0;
 }
 
 /*
@@ -216,7 +222,7 @@ static int i2c_nim_common_construct(nim_i2c_ctx_p ctx)
 		res = nim_read_id(ctx);
 
 	else
-		res = -1;
+		res = nim_agx_read_id(ctx);
 
 	if (res) {
 		NT_LOG(ERR, NTNIC, "Can't read NIM id.");
@@ -803,3 +809,51 @@ void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2c
 	ctx->hwagx.p_ca9849 = p_ca9849;
 	ctx->hwagx.p_io_nim = p_io_nim;
 }
+
+static void nim_agx_read(struct nim_i2c_ctx *ctx,
+	uint8_t dev_addr,
+	uint8_t reg_addr,
+	uint8_t data_len,
+	void *p_data)
+{
+	nthw_i2cm_t *p_nt_i2cm = ctx->hwagx.p_nt_i2cm;
+	nthw_pca9849_t *p_ca9849 = ctx->hwagx.p_ca9849;
+	uint8_t *data = (uint8_t *)p_data;
+
+	rte_spinlock_lock(&p_nt_i2cm->i2cmmutex);
+	nthw_pca9849_set_channel(p_ca9849, ctx->hwagx.mux_channel);
+
+	for (uint8_t i = 0; i < data_len; i++) {
+		nthw_i2cm_read(p_nt_i2cm, (uint8_t)(dev_addr >> 1), (uint8_t)(reg_addr + i), data);
+		data++;
+	}
+
+	rte_spinlock_unlock(&p_nt_i2cm->i2cmmutex);
+}
+
+static void nim_agx_write(struct nim_i2c_ctx *ctx,
+	uint8_t dev_addr,
+	uint8_t reg_addr,
+	uint8_t data_len,
+	void *p_data)
+{
+	nthw_i2cm_t *p_nt_i2cm = ctx->hwagx.p_nt_i2cm;
+	nthw_pca9849_t *p_ca9849 = ctx->hwagx.p_ca9849;
+	uint8_t *data = (uint8_t *)p_data;
+
+	rte_spinlock_lock(&p_nt_i2cm->i2cmmutex);
+	nthw_pca9849_set_channel(p_ca9849, ctx->hwagx.mux_channel);
+
+	for (uint8_t i = 0; i < data_len; i++) {
+		nthw_i2cm_write(p_nt_i2cm, (uint8_t)(dev_addr >> 1), (uint8_t)(reg_addr + i),
+			*data++);
+	}
+
+	rte_spinlock_unlock(&p_nt_i2cm->i2cmmutex);
+}
+
+int nim_agx_read_id(struct nim_i2c_ctx *ctx)
+{
+	nim_agx_read(ctx, 0xA0, 0, sizeof(ctx->nim_id), &ctx->nim_id);
+	return 0;
+}
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
index fb44c62f12..968d7eb74a 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
@@ -6,13 +6,19 @@
 #ifndef __NTHW_SI5332_SI5156_H__
 #define __NTHW_SI5332_SI5156_H__
 
+#include "nthw_i2cm.h"
 /*
  * PCA9849 I2c mux class
  */
 
 struct nthw_pca9849 {
+	nthw_i2cm_t *mp_nt_i2cm;
+	uint8_t m_current_channel;
+	uint8_t m_dev_address;
 };
 
 typedef struct nthw_pca9849 nthw_pca9849_t;
 
+int nthw_pca9849_set_channel(nthw_pca9849_t *p, uint8_t channel);
+
 #endif	/* __NTHW_SI5332_SI5156_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
new file mode 100644
index 0000000000..b5560e2990
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
@@ -0,0 +1,31 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include <pthread.h>
+#include "nt_util.h"
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_register.h"
+
+#include "nthw_si5332_si5156.h"
+
+int nthw_pca9849_set_channel(nthw_pca9849_t *p, uint8_t channel)
+{
+	int res;
+
+	if (p->m_current_channel != channel) {
+		uint8_t data = channel + 4;
+		res = nthw_i2cm_write(p->mp_nt_i2cm, p->m_dev_address, 0, data);
+
+		if (res)
+			return res;
+
+		p->m_current_channel = channel;
+		nt_os_wait_usec(10000);
+	}
+
+	return 0;
+}
-- 
2.45.0

