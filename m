Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C685CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C56540E8A;
	Mon, 20 Oct 2025 18:44:09 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 90029406B8
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:48 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020140.outbound.protection.outlook.com [52.101.69.140])
 by mx-outbound16-221.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smTIQGfB4xyVCWvuZOdLbhGYs7hyxzFRQH809ZuvWnJiLDyPUOKSY4abZWW6aYWwVaKPACGrNcW57OQgmEJEZzwuI4NTIKwFcT9aEZO0zsFc1dAdweSsygYESX3CS5QQdvMo852MLxopKUO9fTIO6GBtqkfDQhavWg94BtB6jeB3h9ayQymkThLPkLT2dIhP4y4aC8mLiIdY1N5ZcU9olOUXfZZCI8X8wZelJaV9+e5Ffv4wThUOe51ikaJw2zwjyJ+ukrE2qhIai7Qg68Uzd67mR/SXB0Hp28PsXBAGguKHwhB8hvdIVdglNC42WnKVvCgpMORf7es1ndSoZEsuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g8YFpLbxsUhzG+zjo6X68g/v/MztfjZ3om3d1mt+Xg=;
 b=UJwam+1/Ngft+dq5mT42BOfrsgTsIpc6483NXKjpQhGp+NE5fdVdhKIxmKOE6HNyk1NKcJsw+mgiOpwEcFfUmAKed/z9kgnSYOflRs2BcGtO5My+IrKipsAeN9LJpO/NrJBjboCDbLVbu8B7Xl9rXeSSFzxWQtB9OdpNZz8ZJPyzRu0f4kYObJgg6mgzgIBLublqd2Isz3mkmLCBXA7xj1Oxw746aZ0PGRgaKHyCw3smOk4sjJ8fm6RQ8pgjWU+aviwoJrdXtofvf7j6GH7PL/HPov9oU3eC0x9w0ub8FLmozriFm7SfwUUh9RePgpoxygwr5t6sYGkuH3SyXA5fXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g8YFpLbxsUhzG+zjo6X68g/v/MztfjZ3om3d1mt+Xg=;
 b=ArG31+88sdXLtTL8foU8a5osD2EzzI8Vgi2ycV60BL3cKClTdQSpY+EWuy2E5s5lycOuMYo3skixGwVSHSavJzwv8u14p/jnfDQVra9PLKCQt1LfVgEfAJDFGBsj1HDmOjif8HM4YHOaJ471rC7IRMsuRV9gYW8ECCoxH92W7Vc=
Received: from DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) by AS8P190MB2005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:52f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:46 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::1b) by DUZPR01CA0020.outlook.office365.com
 (2603:10a6:10:46b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:45
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 09/21] net/ntnic: add reset init stage 7 for NT400D11
Date: Mon, 20 Oct 2025 18:43:18 +0200
Message-ID: <20251020164336.283664-10-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|AS8P190MB2005:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 109169d3-97c2-4d73-7d14-08de0ff7d64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3DTJ7/4008myHzUgnpOda/qKf8nrgng11QQCEyYo6HkjoVi76kP2sV6KtIXT?=
 =?us-ascii?Q?nGbl1///D85cBCC69VmfQ/s6vT9MQN05YgXiJILBAPBWT/sR4J5mITvJF/P8?=
 =?us-ascii?Q?wE84YJAi1Ldoju9X/wFkv6hj0db4uF4hhDkJiUDh8LPDs/k55yLFqLSxKnxy?=
 =?us-ascii?Q?qcxO4NxQstGevcOPlGAcvZ7VT4lmYqWQuz4LeXsDhxCnr0QbU4RQVmcVXhEg?=
 =?us-ascii?Q?0tOPNPvS0NIPy8dDXKCBq+qXq7hHAFcbVEHXE1zYUo5QIX0+rK5vn+CyI8or?=
 =?us-ascii?Q?ndvUtlO1iy36/NpJ/Nw0NIUFAfxRr1hHo6fz8dov2ho8C1BbdERnkQIfq0FW?=
 =?us-ascii?Q?7nuvpsl78zqgXbckf86tkxGtwnbHekOARwIsEwk0i4Sde3dDqoQsSnqOH8gM?=
 =?us-ascii?Q?SeYES+sNLMCjwy242YC2dFIlYeOU2QqGtHqnr4K0TOUEStZj3BXRb3x4/LML?=
 =?us-ascii?Q?glirf14E2yqPbdeTPb3QI89M0E/6L9Slgn1lVeefj+pS9hRoL4Xlysbo8UuL?=
 =?us-ascii?Q?h+FRzJ69qZvhERLMXNeqMN83BgsubeA1jgstQEFtBQyMUi5zcUem+P8Wgkt+?=
 =?us-ascii?Q?USOLtQSBSze+Ss8MLjxfznY7y4cQM8tq6vBY2Lnd+KUXE3jf4QJCax8AysQ8?=
 =?us-ascii?Q?NOTVbU9ApGRj9Aio/pvbADE2IHnT9xFY2X1AzCzPeR2LUxvDD7Gb34twkWmz?=
 =?us-ascii?Q?WlziPJ6z3qUesaKPJIN9rVtc+REmR8RQKSRTd4o6mr0B4pPH83/QwaL/PYCx?=
 =?us-ascii?Q?9Pc6yc7ErKGy52T9MYMyab19szduT5kalfwup+clqPzk/b8Ni3wCeEkXCJDi?=
 =?us-ascii?Q?c8sZqUylH2ZG9L7FnaTiKHsxfN8YCieAi/ruBL+vR/WptJwESFPAjZEo8Tai?=
 =?us-ascii?Q?oT9AcVbs+sWCBsgdyS/3zFG4W5hrtehCv8fufFPHxa+xXC5tyABG13HX1eOS?=
 =?us-ascii?Q?OoVrYfuFrrNyufImmrH9G1hFMJ3pX4bwIi12SysGr5lX6nQGxkRouKW/YEXU?=
 =?us-ascii?Q?F67RTKj6Ns1lFW5oH+Ax+PSQLy7D2wxKHyl0hqxakc/jaa2d2Fw/qrUlQsjH?=
 =?us-ascii?Q?ObrAtOk35R/oHTlpSfKKMgFTgKhiYJfkipkJBZL6KkcN8gi4lQW5yGd3ArzO?=
 =?us-ascii?Q?2vfCexAF1KWKbaToUEoSuXf4mZWEm85I0mbu8ePcwnl232cZz1bBNPPuCdg/?=
 =?us-ascii?Q?RsZlpVR4MVNsyICVMdp3sFwa3PXrOr6/DWceEoeR7fIMbJ9z48vr1ztBGSn/?=
 =?us-ascii?Q?Fb64kjcs238W/F/i1f4jS239rQ5GHqKEdTIABcLK0GIbM2q+LCWFLfPKJjUP?=
 =?us-ascii?Q?u3hp2y0rXHOVpV45cawy2qTYpx1Mui5Y4r4QDTxgYJeyjfgShnEcecethrHJ?=
 =?us-ascii?Q?JHMjvHv1ZEqNRbTDqBT+cnY0JWdUPN5rtPf8PdnEQh/JqKUdux0hgX5J5Tdh?=
 =?us-ascii?Q?67qtPjgVOuF3u8fiZMNr8/VU5wHi06oMjqjHIT5NFTkfc19QfaX2Y9Ev0f7u?=
 =?us-ascii?Q?Q39t1p1oH74mT2/aY2/U7TMimBa+ejRM1Bcm1Fv6XszQO0/tyibFxChJg91n?=
 =?us-ascii?Q?b6qWA17coL6SwL4GOSI=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G+NW5HG00wJnocHpsmnGFzwKkV5ixXnAdiLWh8IQ0cQHkEVCFXInP8EZJXEFkQ6ITMb+5FrhitBYczdRtUON5/VAH3IPWGYOu7JbU2UKYhqRnuJuumYJVn/v0V6Hl+p1jdeOBHzhxO6tj4lJ+GjNzUP8s9gjt26iR3oc3BNJB+d2fLW6wa7lOZp3C58AKKJ96Q6cjwCzdlC30Gc3mK6UcHkHBT1U/q9ljLt+qIA1c5Dj6uA2G5dA72OwVzTden/gUG1wy3BjSrCR2wLzp844MBgDri/fjAkDrrvVDPLuWi3/BNCH04Nd30NGjc2l8L0ERO8baXt5VS52oXVKvM6VLF1JBuJtQ206F9zZcs34A2iOlrD7+ufRncGUCqh1GPJlWBdepEkLWJWxCcJ/QrP9bjYTh7aXvxNNUHvVkv97abmSlFd7sdgjCeAyNajdYfWC86fep94wIHp5bUWbnAnIsOqV2g1EfUY4J9J6XOV7X5Nb/O/gJKVRz7PrGky0n2XaNHpT/pRSVN6vtopLMKdosZRpTsD7+HVppsLvcrHrqqeWwIeQ9v8KOApZA62WEG1SlTFhKdEqSMfOi56YtM9uJCUS3ZYZ5y6NRyG5e+K71Z4Vq+ORu8TzUDIWBQP+nvk20fdwilBIa4tcuCwh+YO4xt9j9VEWIvzTRY7fEgLBlA8=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:45.8638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 109169d3-97c2-4d73-7d14-08de0ff7d64f
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB2005
X-BESS-ID: 1760978627-304317-25453-11878-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.69.140
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYGJuZAVgZQ0DLZMtkk0cDcyM
 jYwNjA3NAi0dTYMNksxSDVMMkkzcJYqTYWADolv69BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan19-215.eu-central-1b.ess.aws.cudaops.com]
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

