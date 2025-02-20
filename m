Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A3C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D790840B90;
	Thu, 20 Feb 2025 23:04:26 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0DFB8409FA
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:21 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 mx-outbound21-132.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8yyCrub/IeeWjhA+CqA39V7kA9QaT9WnlCP3yTBbaHXUVdm8Rtch2NFLgQaJjF7QcFVXd5oyzowjPgQKqP2G3JhanbXTxIxkIfQalAUss+l+9Ls62hLqf5SW+Fopa8G5zR+hc5NxKcbuXJ8YZrhS63rwhw9PBEPInSXEs8WbAbkprNOt4NpeUBey2lnc4u3+tFTgcMLkHq5SXVi3qdRwnAKlKlHuICmD1TB6nTrXF6sljLQer0dfgQFW+bibsh96yU0J+SOlL2NNC0bkNMtZK7WVxMH+tW7foyNpQfytSgyxyw+dWHv94OLp9WmD/O95WY6gT3cAyDkNTzApE9Phw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCcUGvDUcbDkkVmpZfXr3VnJt+6RUajvImXoeZUn/Ps=;
 b=Pj8ExSoVOwalS3f267ob/bsdYtJcBw1BOr/31GHbAMMOnqkBAlmCqUxc9U7nnrVkT3cDxcvK0Uv2rAEQSfNvGmdC3qG6dl4NwMPLTi0Mv1RnEzJsYVomu0uO6o0Kg57Ih6ebwlAcLiuLxy9rFIM3E32lLTKDHxydfN/anhbwGcEuWyblc2r0WFXammi96mv564YTMKAtle21N7fXz8NOUKhPxqujdnP/KkuGAEX9MtiKOqNdh5hLc9dfg33UPk1YI575IPrl9aG7+3kphgxND1Vt36jydti3ppCo34VvPNrBtIKQ2/IBK15PcN8xDSc28mQMG7CnVTNWp7KIurj9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCcUGvDUcbDkkVmpZfXr3VnJt+6RUajvImXoeZUn/Ps=;
 b=lRZuGhLZQgft39207nRRMZQBm8FTvL/AJ/9ob2MVO38Bkm/YULWyH8hQ12D4ZkIUcl+mr6r9oDVus5n+vTh0eUlNiXYMo/GdGryWFKl66sAOAsD+GdFakv0gQWRBVF4mGrd3xcqLZSYBuHWHv5iZfuI3E7+4D1WcD5kf7gl3xRw=
Received: from CWLP265CA0497.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::15)
 by PA2P190MB2128.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:407::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:15 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::da) by CWLP265CA0497.outlook.office365.com
 (2603:10a6:400:18b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:15 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 05/32] net/ntnic: add host loopback init
Date: Thu, 20 Feb 2025 23:03:29 +0100
Message-ID: <20250220220406.3925597-6-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PA2P190MB2128:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3489d44b-5e49-450a-5f45-08dd51fa8402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h/iXoBQoEmP2G/yAxrPxUpE/XwSOG6iWwknbhL7bhc8DE4Vz8eYMfCeHNgx/?=
 =?us-ascii?Q?bAo9daiwkhcZWSrG1HYA2j3WrzaXvKW607r+Znr3e2Mr+Ps+PXIPThfqDPtT?=
 =?us-ascii?Q?sBA5sB91X/Pe6Pk3eSj2XCdl9SGI6GopL+fBDEMrHCZDcpIgqu0SgHwaBzmY?=
 =?us-ascii?Q?PFXlTlZzmCVwz+XEs0a4rwtBBGX0Ct+3I6t0s5vsZ02lSkiLr+Mki0dohm2x?=
 =?us-ascii?Q?+AyoMLPEFvXQekjWCjWzCsQ7RHCuHapRJEVhzDtOehRuw73Z+KczleS9AOSw?=
 =?us-ascii?Q?5HMKc14NWckxKdVBp/4alFurY0zqyPpG7P8BcpJa0Z2ulB0+0cceLrTlIN0x?=
 =?us-ascii?Q?filMsLJrXRrK2Z/D/KZBKvKzrtkqpbL/kZGH2cHSMiM854ADxs8I1W9Vjcsw?=
 =?us-ascii?Q?x6LOA66j4FBnvbPv999VXU5yyODHHelyQNQwminTA4TPkTv6JYZtyA6u1vdo?=
 =?us-ascii?Q?GIxEShqMNk5NW3jV6IkNKNcorJsFZQm2MAEhQX//EXya4BJO7+7rTQPCxmYL?=
 =?us-ascii?Q?G+vQ+Y9qBphp4pXHoCvKY2sf1zVuWLqjSMqYQvGubrSnrmFj9Rw4eM+P+UyN?=
 =?us-ascii?Q?sp8y1Yb2xY2hwephqPPAmdL9y2vNXpjVt1FaprCU6rmdp+inW9tSqNuYpvj2?=
 =?us-ascii?Q?+VS0N8C/apwNXS5LN5bKHF4Sh7lfqxYzHlFD/nFDsBscSHtTB9NAXNQFRDu4?=
 =?us-ascii?Q?EUSJN2vzl1gRSTb5qAGUbtRzWrGz6bvbhqwkOdtXn7x5ao8CGyjqKgF4yBD+?=
 =?us-ascii?Q?J1rhSOQTwfrD+s+xfAvHj8sAMMMw4wyhDSw4zCY7jaEzWzrH9dS/xwCPNVD4?=
 =?us-ascii?Q?SGqaMxlJ+zg77u/iCLGPOArVl/dkVCO+cbCwiYE28n1Td5AyPeheTYfO0a7a?=
 =?us-ascii?Q?Cpb2x0jpmq0x4WWQTm6s4Yz0PwuVqxaC3WtfuMTfbqOuYx4etrCloz7kCjwZ?=
 =?us-ascii?Q?mO+ZiaPUcBT6nH80bQ5465TglRqptHr6THWRh1JXiE3WQ6Q7QxoOLiPQ8GhD?=
 =?us-ascii?Q?LZlm008c3ZCHd2iW4AaawSr4H+CZfz0Unoq5zVeBv+dxAe5ru4ivdki4pBqE?=
 =?us-ascii?Q?yNyiCl23qUkeGRuOOWn5BJskV18fIHsp1lDJZfZ088rq8UvtP9iAdTD5NuWb?=
 =?us-ascii?Q?Pm0zmHov8jFZusEdbEBz9vDGbIwA3u6m7inF9vNpBXo/rgLezpGfLyPs3Uay?=
 =?us-ascii?Q?g8v3eJW2N8op5W3q1LDaIHFWNa/CHVLIaHiF44dwiXAePSw4bjvjA82/HfAO?=
 =?us-ascii?Q?n/pTMeLZkkSONwOFaxtYXUNfdCSOG74W4BcYlGn6U0MrmGotxZzte/7Xo8VA?=
 =?us-ascii?Q?cYCzshsdZndPQ+vQn+d2WWnzL43rtHKDY28VIQ0MQfBGJq3Wr6lpqqzJCyWu?=
 =?us-ascii?Q?CwufwQND7mBHxxif4wYrkL/A4aUCanx4MsN6t2U1bQ9E8KssCCug7hQqvdG/?=
 =?us-ascii?Q?bXmaffreadxQ73cex42VcGeynUYQwS4HT8qFPSQGXIhkBf8XsUZv5QZ9dFnO?=
 =?us-ascii?Q?siUAx3dqiGdwbNU=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +kroB9LciQURoirtslCk79AJzo9kss6+NH4DqhZuOu4SYO4E0XEuugQUsTZNo6BIwftBtU8cd7Q8HCRQ7wnyQc5D5SnY7Lpp1xt6hVud/StWkZmfhrM+EJFksJpXC1RJT2XWVg3TCPNtSJCnHRTEJ1K+6L3xBA0QP1ceAWCEZZB5p2Sv40NQvLIuECUBhH2t9ERGOiid1ckI/dfc5/lrRa+xOnX2ZfzF8l+UxuvM9ERu5vdNgLA2kRFu7nlikAhLd5uLEUaC71p5tC6Klhv84cNCfOhQ/vUdfd7DHyU7j06W4EFLDaN455TJf8+E/7KERf/uoWXF4do5Zi/k7vfwHG3qAB29KxFhqxn1NSSNrfXN5L9cxrjrsulk953GNsV3ETmevevQOPI4Z7f7rXGLRnC+THMHb3+yZ5WGMWoE4xe0kkVHdV3qenPEWUTBYOMEjsW9vRNWxrDqYWWEQZsXv2lS/8A2vRjmkCyvhkwYeaYGXm4fN6Yt68y13Tc2vdJDiMWoIDSsWRZVYNnKdKjBjGsoSAV/2QeGauXOK24J7xrR9ChgF/yX97PAX+zGoP+KLfHhhde+ZvesrSaDUaM60G8IabZ5csIui4Rnh7Cv5Vjya7H9Ns3eYvXhYKibOJmRRqPrMenihnw+XC4MrdUJuezf91sYMHVEyCP/rp0nH9s=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:15.3806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3489d44b-5e49-450a-5f45-08dd51fa8402
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2128
X-BESS-ID: 1740089060-305508-25328-16457-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbGxgZAVgZQ0DAx1cLAKC3FzN
 g8MdE0OTXZKM3ExMgkySTVxDjNKDFFqTYWAD14qrFBAAAA
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

Implement PHY line loopback configuration for Agilex FPGA

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 111 ++++++++++++++++++
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |   1 +
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |  28 +++++
 3 files changed, 140 insertions(+)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index a6455ee598..f3862b7fe3 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -14,6 +14,11 @@
 #include "nthw_gfg.h"
 #include "nthw_phy_tile.h"
 
+typedef enum {
+	LOOPBACK_HOST_NONE,
+	LOOPBACK_HOST
+} loopback_host_t;
+
 static int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info,
 	nthw_fpga_t *fpga);
 
@@ -29,6 +34,65 @@ void link_agx_100g_init(void)
 	register_agx_100g_link_ops(&link_agx_100g_ops);
 }
 
+/*
+ * Phy handling
+ */
+
+static void phy_rx_path_rst(adapter_info_t *drv, int port, bool reset)
+{
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+	NT_LOG(DBG, NTNIC, "Port %d: %s", port, reset ? "assert" : "deassert");
+	nthw_phy_tile_set_rx_reset(p, port, reset);
+}
+
+static void phy_tx_path_rst(adapter_info_t *drv, int port, bool reset)
+{
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+	NT_LOG(DBG, NTNIC, "Port %d: %s", port, reset ? "assert" : "deassert");
+	nthw_phy_tile_set_tx_reset(p, port, reset);
+}
+
+static void phy_reset_rx(adapter_info_t *drv, int port)
+{
+	phy_rx_path_rst(drv, port, true);
+	nt_os_wait_usec(10000);	/* 10ms */
+	phy_rx_path_rst(drv, port, false);
+	nt_os_wait_usec(10000);	/* 10ms */
+}
+
+static void phy_reset_tx(adapter_info_t *drv, int port)
+{
+	phy_tx_path_rst(drv, port, true);
+	nt_os_wait_usec(10000);	/* 10ms */
+	phy_tx_path_rst(drv, port, false);
+	nt_os_wait_usec(10000);	/* 10ms */
+}
+
+static int phy_set_host_loopback(adapter_info_t *drv, int port, loopback_host_t loopback)
+{
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+
+	switch (loopback) {
+	case LOOPBACK_HOST_NONE:
+		for (uint8_t lane = 0; lane < 4; lane++)
+			nthw_phy_tile_set_host_loopback(p, port, lane, false);
+
+		break;
+
+	case LOOPBACK_HOST:
+		for (uint8_t lane = 0; lane < 4; lane++)
+			nthw_phy_tile_set_host_loopback(p, port, lane, true);
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
@@ -81,6 +145,40 @@ static int swap_tx_rx_polarity(adapter_info_t *drv, int port, bool swap)
 	return -1;
 }
 
+static void
+set_loopback(struct adapter_info_s *p_adapter_info, int port, uint32_t mode, uint32_t last_mode)
+{
+	switch (mode) {
+	case 1:
+		NT_LOG(INF, NTNIC, "%s: Applying host loopback",
+			p_adapter_info->mp_port_id_str[port]);
+		phy_set_host_loopback(p_adapter_info, port, LOOPBACK_HOST);
+		swap_tx_rx_polarity(p_adapter_info, port, false);
+		break;
+
+	default:
+		switch (last_mode) {
+		case 1:
+			NT_LOG(INF, NTNIC, "%s: Removing host loopback",
+				p_adapter_info->mp_port_id_str[port]);
+			phy_set_host_loopback(p_adapter_info, port, LOOPBACK_HOST_NONE);
+			swap_tx_rx_polarity(p_adapter_info, port, true);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		break;
+	}
+
+	/* After changing the loopback the system must be properly reset */
+	phy_reset_rx(p_adapter_info, port);
+	phy_reset_tx(p_adapter_info, port);
+	nt_os_wait_usec(10000);	/* 10ms - arbitrary choice */
+}
+
 /*
  * Link state machine
  */
@@ -146,6 +244,19 @@ static void *_common_ptp_nim_state_machine(void *data)
 			if (is_port_disabled)
 				continue;
 
+			if (link_info->port_action[i].port_lpbk_mode != last_lpbk_mode[i]) {
+				set_loopback(drv,
+					i,
+					link_info->port_action[i].port_lpbk_mode,
+					last_lpbk_mode[i]);
+
+				if (link_info->port_action[i].port_lpbk_mode == 1)
+					link_state[i].link_up = true;
+
+				last_lpbk_mode[i] = link_info->port_action[i].port_lpbk_mode;
+				continue;
+			}
+
 			link_state[i].link_disabled = is_port_disabled;
 
 			if (!link_state[i].nim_present) {
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
index 930c897046..5577f95944 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -52,6 +52,7 @@ void nthw_phy_tile_set_tx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t l
 void nthw_phy_tile_set_rx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, bool invert);
 void nthw_phy_tile_set_host_loopback(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 	bool enable);
+void nthw_phy_tile_set_tx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset);
 void nthw_phy_tile_set_rx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset);
 
 uint32_t nthw_phy_tile_read_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index fd7a1e1214..6402e5caf3 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -64,6 +64,34 @@ void nthw_phy_tile_set_rx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset)
 	}
 }
 
+void nthw_phy_tile_set_tx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset)
+{
+	/* Reset is active low */
+	nthw_field_get_updated(p->mp_fld_port_config_tx_reset[intf_no]);
+
+	if (reset) {
+		nthw_field_clr_flush(p->mp_fld_port_config_tx_reset[intf_no]);
+
+		/* Wait for ack */
+		if (p->mp_fld_port_status_tx_reset_ackn[intf_no]) {
+			int32_t count = 1000;
+
+			do {
+				nt_os_wait_usec(1000);	/* 1ms */
+			} while (nthw_field_get_updated(p->mp_fld_port_status_tx_reset_ackn
+				[intf_no]) && (--count > 0));
+
+			if (count <= 0) {
+				NT_LOG(ERR, NTHW, "intf_no %u: Time-out waiting for TxResetAck",
+					intf_no);
+			}
+		}
+
+	} else {
+		nthw_field_set_flush(p->mp_fld_port_config_tx_reset[intf_no]);
+	}
+}
+
 uint32_t nthw_phy_tile_read_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 	uint32_t address)
 {
-- 
2.45.0

