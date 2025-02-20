Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C60FC021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 911A9406B4;
	Thu, 20 Feb 2025 23:04:19 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id AB00440689
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:17 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 mx-outbound8-89.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtzS3w4/jONBUKe1G/63RqOneI+78nJr+VPQYoV5vBB7LUuoiCxjC6jQGJLdrQQ9myMlfaAqLTXJM4f3TjM0/EiRPD6jHkSYctEbuHljfxzDfR0wl6q6QjU5vZX1IJIqPIjcA+I/2mAJfblQXIh9g1wY6TgmCdVILXLQqJKvZTuzO0s5gE6Jh0i/rKd/bDTy+CJxx8dWVhoxO9Et5K87E7SwEtBUojsI6DVBRAwXvoiU2INSfhuRSfVVv8YXWguTCHVsnIYeQTfQWDEkpb33a/RxBOgnON83+hSfGZUilUq/LB0edPbbfz1MWiGEI7uO0ytYgcmCDqUVR3Ns5qIu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPpC/mnw2zI1ly2gMOorRBAGZ0UA8tpn3pzcEqyPG1w=;
 b=hREKVrkdiE0+i5LIkX53Z9POOHE/LqFajelhv8dWs6VoAiebh3rlMmTfMXSLBInJWWJ/M53DQK+ARUsF9bQcn6KAy6fEZKqlQoOsnblHvTeCr9BoerwJ/g3HCrrU0rgSYgMwYPbtKDGltljXGU50tEjXMlQ0Bt7UuTEI1CAHvOJYfraN48Wh0POAf23x3k+U+xvqTua+7w8QZY8tRFIrsnmOWfJt4sNEokOmXEP4PTzE61sca2qWgysMdKiibgO6XVHUH10ZcOmYfWO9jl14hh6oLvG9DI7MUsQwTetnrbKcIHvyv+BUkIw76ktJdn0m03AAq1QHpjgHeCW+arn7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPpC/mnw2zI1ly2gMOorRBAGZ0UA8tpn3pzcEqyPG1w=;
 b=ZzQhN7AAmUATKvOChcW4oKzPAl3g+BnmWrNMPMaoKUj+9xlxYPQ9sY4ROjbnjoqAMJWlxQrFZo9N9I1QqY4aJft+LoQDxS2fxLxJ0Rhjf06KQ+0jgVinHZ5nWi4S2C5XdZ2y5Iqpw5dN2YTURnocus+o7zUf+EFN2hEOLB65zw4=
Received: from CWLP265CA0509.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::8)
 by PA4P190MB1071.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:15 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::d1) by CWLP265CA0509.outlook.office365.com
 (2603:10a6:400:18b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:14 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 04/32] net/ntnic: add agx setup for port
Date: Thu, 20 Feb 2025 23:03:28 +0100
Message-ID: <20250220220406.3925597-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PA4P190MB1071:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 39310105-a8ec-4571-b2ca-08dd51fa8394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Hfaplvnl1Vlwc3CXsyybgzjQl0vlBXj0Tx6M6eR0Qm7JfnKx6TUxq0DE0cj?=
 =?us-ascii?Q?gdvWHNs7B+7lAEfEyPn9VtCDlcR6uWmY0k/QExZDdtmOztrfYbqx0cCQgHWo?=
 =?us-ascii?Q?k0dwobhSv7VQD5TlQrKenQaFAJ8ieE3JJLm+cq4kJ79MMVHXMDIduMXiOol8?=
 =?us-ascii?Q?NvTH6qB3J9yLo6YuQFqlEFHBUkmugkgeJ4cMWBfAJ6Cqc6FXfC1tkkA7GZfh?=
 =?us-ascii?Q?8BtwIkDjfeiSjyc+HYVDzfCtSg6YwjwgLLx7JGH67HuBCR527nwE3VbbBbKP?=
 =?us-ascii?Q?QrLr0uQNEqRFO/trVO+dVlyiQzEuCjLbjoOjQJChmatdl2zTgw6hgmCeV2T8?=
 =?us-ascii?Q?KkWOFYhX2ihAUxlj5BJGH1vGZHYqYZNR7srNcCkoGi4QdIBhRdm6IHtu5yIT?=
 =?us-ascii?Q?i3e/xbsPV9kdrUxpUV67FDE/xSZDxIevS/RpuB7xcNIiCwYBBel0YMXES7Oi?=
 =?us-ascii?Q?QcUUiUNh2LbUegyEMLL523PoNEUQJG6+6xUINGGqnvX+oifJ0Y+x8BBNn757?=
 =?us-ascii?Q?RI8rsVf2z0tqybnnnMnOnJ+SJQxqzzI6+GN5Bydxy3yZl3wRXePGBf6HwdGP?=
 =?us-ascii?Q?QEMMYX4dsDKWC4QTWONAgKSb2nUQHphZSnsdX2hf202078LkwCMsG7KZp1bC?=
 =?us-ascii?Q?N0fgOlGbytVGLmUr6gwhO16LDdhSuFsv4i0XqxKtfB+8KBaO2sFwgAoK6sou?=
 =?us-ascii?Q?Gp6AFK9vtPhKo62+0cPRAhLP7LRM/9FGz0XUm8Rqfa3YWqWc6Kv+LtueJimq?=
 =?us-ascii?Q?N85hjS/jwAy8jIzOdp3QvAmr0v7teNXcooL/KCYYQLJxvXF3J1l1rUSRWi9m?=
 =?us-ascii?Q?h8gS5HA+nVJATxgeyBKuVLde3F2Xb85cHKyp8h9yshkvaUxZBtdUJHLGJ0nh?=
 =?us-ascii?Q?ZigECwMATplHHiJ0iWnlilJYw2/g0hOaoqImxgX71NxVZWqccNyTO0q1LaOC?=
 =?us-ascii?Q?hLw3Lt83hRCdScS5nxJc6NIYrToIRT0VFLoyffKChkXSIdyinicZQjNsMZ8T?=
 =?us-ascii?Q?EAR0urQKT67G39PtVUkjMCfp40V3PgEr7cvvi+wJgzwEorLVzxKZv8V3qo6h?=
 =?us-ascii?Q?81yLeVwhx2bju9Mg4Ibws2TpmXcFecVxMTiazzgBdjPoKTZj06IL860dCqUg?=
 =?us-ascii?Q?8hG7ydtfwwSw9fD7hlHFwTRbZISf5QAtJhAddxUNEZEYNAfcJt70+gUY2H7H?=
 =?us-ascii?Q?R49f4l9BmUxGIHhXug+VEXBoQDXaMkO5mT/h7E2KbN6p29OlVpp2ONGV+oXZ?=
 =?us-ascii?Q?vKcmwsI0AA+1MujRdKqaH+d182L2oUZHMurvkB1hXbm3m2qzpqkv73KGUBR8?=
 =?us-ascii?Q?0U4pS/cKEbgp9qh6IGhYngsDFTedK+bfIJOg5euFW/1bgLmn3dAk+uQMYz5m?=
 =?us-ascii?Q?iKGQfD1+TElPeZGSuAJYaFEYZzVOCFEEZJp5fvCSjJZVe+2VWCwFo/ief68x?=
 =?us-ascii?Q?drk1mK20mlzRIBtfo7V9VNRGOJarmWk4gRPF4uI6xki+fFqlv3sbrM4IA9gK?=
 =?us-ascii?Q?H0JyBh/NKB2XfK8=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7Cp1FdQggY7TzJXRiGNh0KtDBIkvHGn6VVK56O9Y85PfeM/V3UTN47e8qLSU0dK1ZKE+SFHnkkBbfu1A+ffu6CZy2jU9LVPqH73cIl14ZLXPXFqhxYNKdbDzyU0r+4sv5J2TODGU5N0Svt1I/vQylLUTL5mqCV8WqUckPV+J8m4qS0TRZohy5Eg3yhmnaxQ0lu6NREnCxZdlbp+a0JnvLVUF3Ch3vWiQzDOyHSAhKjfA+tk17M8JvXv2wJkXjYQi6JcgLxAV+9qGLtSPvbMkLXXojdmBf8gDfOfJZYmBQ9jJ/JGuDGvfhLCDiYc31bpgjjYQoZ8oXdoJxBLOzajEvPLG6nmtrWEDM2I/sEQ5SkxCo+Ocs8eeRKwbV2+aC3gmkS/pyQGeuHIptZORnkayJSBkACZJ7Ut7NoZxyQZoAdCbXJrFf6pnn0Q7w85EWu94qH3io/vb8LbmCkLCeDegA6vr95sCeghgv2w7Sk9ZyVFM1hS0Lr9wBT4TRHRoXgdYic5eQEFaRxszsj7mrSiWiIhvTKYKCJAupYZc3Vp9aBZw0kOo2ZXO9FqKZJKDqZeW8h1cOlS/XbeogB2+Ogw0hBeKnOwqpwnRrYGEqs6vViiiMI/0UMVahSILRGxfbbyeYW+Grp3pbMiXahnEcxGjFiWwoZTHxFiQMIV/1cN7C/s=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:14.6462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39310105-a8ec-4571-b2ca-08dd51fa8394
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1071
X-BESS-ID: 1740089056-302137-23555-14688-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.110
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmpsYGQGYGUNTY0jzF1CAlxS
 zZ1MgsMSnFKMXEJMXAMsksOTk51cAoSak2FgB4gKXcQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan21-197.eu-central-1b.ess.aws.cudaops.com]
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

Initialize NIM and PHY settings for Agilex FPGA ports

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/include/ntnic_nim.h         |   5 +
 .../link_agx_100g/nt4ga_agx_link_100g.c       |  86 ++++++++-
 drivers/net/ntnic/meson.build                 |   1 +
 drivers/net/ntnic/nim/i2c_nim.c               |   8 +
 drivers/net/ntnic/nim/i2c_nim.h               |   3 +
 .../ntnic/nthw/core/include/nthw_pcal6416a.h  |  19 ++
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |  62 +++++++
 .../nthw/core/include/nthw_si5332_si5156.h    |  18 ++
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   | 173 ++++++++++++++++++
 drivers/net/ntnic/nthw/nthw_drv.h             |   8 +
 10 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_phy_tile.c

diff --git a/drivers/net/ntnic/include/ntnic_nim.h b/drivers/net/ntnic/include/ntnic_nim.h
index 58daa8435f..3e97a9a8b2 100644
--- a/drivers/net/ntnic/include/ntnic_nim.h
+++ b/drivers/net/ntnic/include/ntnic_nim.h
@@ -7,9 +7,12 @@
 #define _NTNIC_NIM_H_
 
 #include <stdint.h>
+#include "nthw_pcal6416a.h"
+#include "nthw_i2cm.h"
 
 typedef enum i2c_type {
 	I2C_HWIIC,
+	I2C_HWAGX
 } i2c_type_e;
 
 enum nt_port_type_e {
@@ -38,7 +41,9 @@ typedef struct nim_i2c_ctx {
 	union {
 		nthw_iic_t hwiic;	/* depends on *Fpga_t, instance number, and cycle time */
 		struct {
+			nthw_pcal6416a_t *p_io_nim;
 			nthw_i2cm_t *p_nt_i2cm;
+			nthw_pca9849_t *p_ca9849;
 			int mux_channel;
 		} hwagx;
 	};
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 9db32443fc..a6455ee598 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -12,6 +12,7 @@
 #include "ntnic_mod_reg.h"
 #include "nim_defines.h"
 #include "nthw_gfg.h"
+#include "nthw_phy_tile.h"
 
 static int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info,
 	nthw_fpga_t *fpga);
@@ -28,6 +29,58 @@ void link_agx_100g_init(void)
 	register_agx_100g_link_ops(&link_agx_100g_ops);
 }
 
+/*
+ * Utility functions
+ */
+
+static int swap_tx_rx_polarity(adapter_info_t *drv, int port, bool swap)
+{
+	/*
+	 * Mapping according to schematics
+	 * I: Inversion, N: Non-inversion
+	 *
+	 *  Port 0: PMA0/FGT0
+	 *  FPGA QSFP Tx Rx
+	 *  ---------------
+	 *  Q3C0 Ch4  I  I
+	 *  Q3C1 Ch2  I  I
+	 *  Q3C2 Ch1  I  N
+	 *  Q3C3 Ch3  I  I
+	 *
+	 *  Port 1: PMA1/FGT1
+	 *  FPGA QSFP Tx Rx
+	 *  ---------------
+	 *  Q2C0 Ch4  I  I
+	 *  Q2C1 Ch2  I  I
+	 *  Q2C2 Ch1  N  I
+	 *  Q2C3 Ch3  N  N
+	 */
+
+	bool rx_polarity_swap[2][4] = { { false, true, true, true }, { true, false, true, true } };
+	bool tx_polarity_swap[2][4] = { { false, false, true, true }, { true, true, true, true } };
+
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+
+	if (p) {
+		for (uint8_t lane = 0; lane < 4; lane++) {
+			if (swap) {
+				nthw_phy_tile_set_tx_pol_inv(p, port, lane,
+					tx_polarity_swap[port][lane]);
+				nthw_phy_tile_set_rx_pol_inv(p, port, lane,
+					rx_polarity_swap[port][lane]);
+
+			} else {
+				nthw_phy_tile_set_tx_pol_inv(p, port, lane, false);
+				nthw_phy_tile_set_rx_pol_inv(p, port, lane, false);
+			}
+		}
+
+		return 0;
+	}
+
+	return -1;
+}
+
 /*
  * Link state machine
  */
@@ -134,15 +187,18 @@ static uint32_t nt4ga_agx_link_100g_mon(void *data)
  */
 int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_fpga_t *fpga)
 {
-	(void)fpga;
+	fpga_info_t *fpga_info = &p_adapter_info->fpga_info;
 	nt4ga_link_t *nt4ga_link = &p_adapter_info->nt4ga_link;
 	const int adapter_no = p_adapter_info->adapter_no;
+	const int nb_ports = fpga_info->n_phy_ports;
 	int res = 0;
+	int i;
 
 	NT_LOG(DBG, NTNIC, "%s: Initializing ports", p_adapter_info->mp_adapter_id_str);
 
 	if (!nt4ga_link->variables_initialized) {
 		nthw_gfg_t *gfg_mod = p_adapter_info->nt4ga_link.u.var_a100g.gfg;
+		nim_i2c_ctx_t *nim_ctx = p_adapter_info->nt4ga_link.u.var_a100g.nim_ctx;
 		nthw_agx_t *p_nthw_agx = &p_adapter_info->fpga_info.mp_nthw_agx;
 
 		p_nthw_agx->p_rpf = nthw_rpf_new();
@@ -161,6 +217,34 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 				p_adapter_info->mp_adapter_id_str, res);
 			return res;
 		}
+
+		for (i = 0; i < nb_ports; i++) {
+			/* 2 + adapter port number */
+			const uint8_t instance = (uint8_t)(2U + i);
+			nim_agx_setup(&nim_ctx[i], p_nthw_agx->p_io_nim, p_nthw_agx->p_i2cm,
+				p_nthw_agx->p_pca9849);
+			nim_ctx[i].hwagx.mux_channel = i;
+			nim_ctx[i].instance = instance;	/* not used */
+			nim_ctx[i].devaddr = 0;	/* not used */
+			nim_ctx[i].regaddr = 0;	/* not used */
+			nim_ctx[i].type = I2C_HWAGX;
+
+			nthw_gfg_stop(&gfg_mod[adapter_no], i);
+
+			for (uint8_t lane = 0; lane < 4; lane++) {
+				nthw_phy_tile_set_host_loopback(p_nthw_agx->p_phy_tile, i, lane,
+					false);
+			}
+
+			swap_tx_rx_polarity(p_adapter_info, i, true);
+		}
+
+		nthw_rpf_set_ts_at_eof(p_nthw_agx->p_rpf, true);
+
+		if (res == 0) {
+			p_adapter_info->nt4ga_link.speed_capa = NT_LINK_SPEED_100G;
+			p_adapter_info->nt4ga_link.variables_initialized = true;
+		}
 	}
 
 	/*
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 68d7fdafd4..4799ebfb8e 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -55,6 +55,7 @@ sources = files(
         'nthw/core/nthw_iic.c',
         'nthw/core/nthw_mac_pcs.c',
         'nthw/core/nthw_pcie3.c',
+        'nthw/core/nthw_phy_tile.c',
         'nthw/core/nthw_rpf.c',
         'nthw/core/nthw_rmc.c',
         'nthw/core/nthw_sdc.c',
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index e6f7755ded..7dbbdb8873 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -795,3 +795,11 @@ int construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra)
 
 	return res;
 }
+
+void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
+	nthw_pca9849_t *p_ca9849)
+{
+	ctx->hwagx.p_nt_i2cm = p_nt_i2cm;
+	ctx->hwagx.p_ca9849 = p_ca9849;
+	ctx->hwagx.p_io_nim = p_io_nim;
+}
diff --git a/drivers/net/ntnic/nim/i2c_nim.h b/drivers/net/ntnic/nim/i2c_nim.h
index edb6dcf1b6..09837448c6 100644
--- a/drivers/net/ntnic/nim/i2c_nim.h
+++ b/drivers/net/ntnic/nim/i2c_nim.h
@@ -33,4 +33,7 @@ int nim_qsfp_plus_nim_set_tx_laser_disable(nim_i2c_ctx_t *ctx, bool disable, int
  */
 int construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra);
 
+void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
+	nthw_pca9849_t *p_ca9849);
+
 #endif	/* I2C_NIM_H_ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
new file mode 100644
index 0000000000..636d2beb85
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
@@ -0,0 +1,19 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+#ifndef __NTHW_PCAL6416A_H__
+#define __NTHW_PCAL6416A_H__
+
+#include <stdint.h>
+
+/*
+ * PCAL6416A I/O expander class
+ */
+
+struct nthw_pcal6416a {
+};
+
+typedef struct nthw_pcal6416a nthw_pcal6416a_t;
+
+#endif	/* __NTHW_PCAL6416A_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
new file mode 100644
index 0000000000..930c897046
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -0,0 +1,62 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef __NTHW_PHY_TILE_H__
+#define __NTHW_PHY_TILE_H__
+
+#include "nthw_fpga_model.h"
+
+struct nt_phy_tile {
+	nthw_fpga_t *mp_fpga;
+
+	int mn_phy_tile_instance;
+
+	int mn_fpga_version;
+	int mn_fpga_revision;
+
+	nthw_register_t *mp_reg_port_xcvr_base[2][4];
+	nthw_field_t *mp_fld_port_xcvr_base_ptr[2][4];
+	nthw_field_t *mp_fld_port_xcvr_base_busy[2][4];
+	nthw_field_t *mp_fld_port_xcvr_base_cmd[2][4];
+
+	nthw_field_t *mp_fld_port_xcvr_data_data[2][4];
+
+	nthw_register_t *mp_reg_port_eth_base[2];
+	nthw_field_t *mp_fld_port_eth_base_ptr[2];
+	nthw_field_t *mp_fld_port_eth_base_busy[2];
+	nthw_field_t *mp_fld_port_eth_base_cmd[2];
+
+	nthw_field_t *mp_fld_port_eth_data_data[2];
+
+	nthw_register_t *mp_reg_link_summary[2];
+	nthw_field_t *mp_fld_link_summary_nt_phy_link_state[2];
+	nthw_field_t *mp_fld_link_summary_ll_nt_phy_link_state[2];
+	nthw_field_t *mp_fld_link_summary_link_down_cnt[2];
+	nthw_field_t *mp_fld_link_summary_lh_remote_fault[2];
+
+	nthw_field_t *mp_fld_port_status_tx_reset_ackn[2];
+	nthw_field_t *mp_fld_port_status_rx_reset_ackn[2];
+
+	nthw_field_t *mp_fld_port_config_rx_reset[2];
+	nthw_field_t *mp_fld_port_config_tx_reset[2];
+
+	nthw_field_t *mp_fld_scratch_data;
+};
+
+typedef struct nt_phy_tile nthw_phy_tile_t;
+typedef struct nt_phy_tile nt_phy_tile;
+
+void nthw_phy_tile_set_tx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, bool invert);
+void nthw_phy_tile_set_rx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, bool invert);
+void nthw_phy_tile_set_host_loopback(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
+	bool enable);
+void nthw_phy_tile_set_rx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset);
+
+uint32_t nthw_phy_tile_read_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
+	uint32_t address);
+void nthw_phy_tile_write_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, uint32_t address,
+	uint32_t data);
+
+#endif	/* __NTHW_PHY_TILE_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
new file mode 100644
index 0000000000..fb44c62f12
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef __NTHW_SI5332_SI5156_H__
+#define __NTHW_SI5332_SI5156_H__
+
+/*
+ * PCA9849 I2c mux class
+ */
+
+struct nthw_pca9849 {
+};
+
+typedef struct nthw_pca9849 nthw_pca9849_t;
+
+#endif	/* __NTHW_SI5332_SI5156_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
new file mode 100644
index 0000000000..fd7a1e1214
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -0,0 +1,173 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "nt_util.h"
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_register.h"
+
+#include "nthw_phy_tile.h"
+#include "nthw_helper.h"
+
+static const uint32_t link_addr = 0x9003C;
+static const uint32_t phy_addr = 0x90040;
+/* CPI option flags */
+static const uint32_t cpi_set = 0x2000;	/* 1 << 13 */
+static const uint32_t cpi_in_reset = 0x4000;	/* 1 << 14 */
+static const uint32_t bit_cpi_assert = 0x8000;	/* 1 << 15 */
+/*
+ * Base Addresses for Avalon MM Secondary Components
+ * static const uint32_t ADDR_AVMM_DR_CTRL_INT                  =  0x10035000 << 0;
+ * static const uint32_t ADDR_GDR_P0_XCVR_RECONFIG_INT          =  0x00800000 << 0;
+ * static const uint32_t ADDR_GDR_P1_XCVR_RECONFIG_INT          =  0x00900000 << 0;
+ * static const uint32_t ADDR_GDR_P2_XCVR_RECONFIG_INT          =  0x00A00000 << 0;
+ * static const uint32_t ADDR_GDR_P3_XCVR_RECONFIG_INT          =  0x00B00000 << 0;
+ * static const uint32_t ADDR_GDR_P0_ETH_RECONFIG_INT           =  0x00000000 << 0;
+ * static const uint32_t ADDR_GDR_P1_ETH_RECONFIG_INT           =  0x00010000 << 0;
+ * static const uint32_t ADDR_GDR_P2_ETH_RECONFIG_INT           =  0x00020000 << 0;
+ * static const uint32_t ADDR_GDR_P3_ETH_RECONFIG_INT           =  0x00030000 << 0;
+ * static const uint32_t ADDR_GDR_PKT_CLIENT_CONFIG_INT         =  0x000100000 << 0;
+ * static const uint32_t ADDR_GDR_P0_25G_PKT_CLIENT_CONFIG_INT  =  0x000200000 << 0;
+ * static const uint32_t ADDR_GDR_P0_50G_PKT_CLIENT_CONFIG_INT  =  0x000300000 << 0;
+ *
+ * ETH AVMM USER SPACE Registers Address Map
+ */
+
+void nthw_phy_tile_set_rx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset)
+{
+	/* Reset is active low */
+	nthw_field_get_updated(p->mp_fld_port_config_rx_reset[intf_no]);
+
+	if (reset) {
+		nthw_field_clr_flush(p->mp_fld_port_config_rx_reset[intf_no]);
+
+		/* Wait for ack */
+		if (p->mp_fld_port_status_rx_reset_ackn[intf_no]) {
+			int32_t count = 1000;
+
+			do {
+				nt_os_wait_usec(1000);	/* 1ms */
+			} while (nthw_field_get_updated(p->mp_fld_port_status_rx_reset_ackn
+				[intf_no]) && (--count > 0));
+
+			if (count <= 0) {
+				NT_LOG(ERR, NTHW, "intf_no %u: Time-out waiting for RxResetAck",
+					intf_no);
+			}
+		}
+
+	} else {
+		nthw_field_set_flush(p->mp_fld_port_config_rx_reset[intf_no]);
+	}
+}
+
+uint32_t nthw_phy_tile_read_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
+	uint32_t address)
+{
+	nthw_register_update(p->mp_reg_port_xcvr_base[intf_no][lane]);
+	nthw_field_set_val32(p->mp_fld_port_xcvr_base_cmd[intf_no][lane], 0);
+	nthw_field_set_val_flush32(p->mp_fld_port_xcvr_base_ptr[intf_no][lane], address);
+
+	while (nthw_field_get_updated(p->mp_fld_port_xcvr_base_busy[intf_no][lane]) == 1)
+		nt_os_wait_usec(100);
+
+	return nthw_field_get_updated(p->mp_fld_port_xcvr_data_data[intf_no][lane]);
+}
+
+void nthw_phy_tile_write_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, uint32_t address,
+	uint32_t data)
+{
+	nthw_field_set_val_flush32(p->mp_fld_port_xcvr_data_data[intf_no][lane], data);
+	nthw_register_update(p->mp_reg_port_xcvr_base[intf_no][lane]);
+	nthw_field_set_val32(p->mp_fld_port_xcvr_base_ptr[intf_no][lane], address);
+	nthw_field_set_val_flush32(p->mp_fld_port_xcvr_base_cmd[intf_no][lane], 1);
+
+	while (nthw_field_get_updated(p->mp_fld_port_xcvr_base_busy[intf_no][lane]) == 1)
+		/* NT_LOG(INF, NTHW, "busy"); */
+		nt_os_wait_usec(100);
+}
+
+static uint32_t nthw_phy_tile_cpi_request(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
+	uint32_t data, uint8_t op_code, uint32_t cpi_assert,
+	uint32_t cpi_set_get)
+{
+	uint32_t cpi_cmd;
+	uint32_t value = 0;
+	uint32_t xcvr_instance = lane;
+	uint32_t lane_offset = 0;
+	uint32_t quad_lane = 0;
+
+	/* Find quad lane */
+	quad_lane = nthw_phy_tile_read_xcvr(p, intf_no, lane, 0xFFFFC) & 0x3;
+
+	xcvr_instance = lane;
+	lane_offset = (uint32_t)(lane << 20);
+
+	cpi_cmd = (data << 16) | cpi_assert | cpi_set_get | (quad_lane << 8) | op_code;
+
+	nthw_phy_tile_write_xcvr(p, intf_no, lane, link_addr + lane_offset, cpi_cmd);
+
+	nt_os_wait_usec(10000);
+
+	for (int i = 20; i > 0; i--) {
+		data = nthw_phy_tile_read_xcvr(p, intf_no, lane, phy_addr + lane_offset);
+
+		value =
+			nthw_field_get_updated(p->mp_fld_port_xcvr_data_data
+				[intf_no][xcvr_instance]);
+
+		if (((value & bit_cpi_assert) == cpi_assert) && ((value & cpi_in_reset) == 0))
+			break;
+
+		nt_os_wait_usec(10000);
+
+		if (i == 0)
+			NT_LOG(ERR, NTHW, "Time out");
+	}
+
+	return value;
+}
+
+static void nthw_phy_tile_write_attribute(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
+	uint8_t op_code, uint8_t data)
+{
+	/*
+	 * p->cpi_set_get = 0x2000 #bit13: (1: set, 0: get)
+	 * cpi_assert = 0x0000 #bit15: (1: assert, 0: deassert)
+	 */
+	nthw_phy_tile_cpi_request(p, intf_no, lane, data, op_code, bit_cpi_assert, cpi_set);
+	nthw_phy_tile_cpi_request(p, intf_no, lane, data, op_code, 0x0000, cpi_set);
+}
+
+void nthw_phy_tile_set_tx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, bool invert)
+{
+	nthw_phy_tile_write_attribute(p, intf_no, lane, 0x65, invert ? 1 : 0);
+	/*
+	 * NT_LOG(INF, NTHW, "setTxPolInv intf_no %d, lane %d, inv %d ", intf_no, lane, invert);
+	 * nthw_phy_tile_get_tx_pol_inv(p, intf_no, lane);
+	 */
+}
+
+void nthw_phy_tile_set_rx_pol_inv(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane, bool invert)
+{
+	nthw_phy_tile_write_attribute(p, intf_no, lane, 0x66, invert ? 1 : 0);
+	/*
+	 * NT_LOG(INF, NTHW, "setRxPolInv intf_no %d, lane %d, inv %d ", intf_no, lane, invert);
+	 * nthw_phy_tile_get_rx_pol_inv(p, intf_no, lane);
+	 */
+}
+
+void nthw_phy_tile_set_host_loopback(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
+	bool enable)
+{
+	nthw_phy_tile_set_rx_reset(p, intf_no, true);
+	nthw_phy_tile_write_attribute(p, intf_no, lane, 0x40, enable ? 0x06 : 0);
+	nthw_phy_tile_set_rx_reset(p, intf_no, false);
+	/*
+	 * NT_LOG(INF, NTHW, "setLoopback intf_no %d, lane %d, enable %d ",
+	 * intf_no, lane, enable);
+	 */
+}
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index 9dc839c83c..1fc8df52ce 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -9,12 +9,20 @@
 #include "nthw_core.h"
 #include "ntnic_dbs.h"
 
+#include "nthw_si5332_si5156.h"
+#include "nthw_pcal6416a.h"
+#include "nthw_phy_tile.h"
 #include "nthw_rpf.h"
+#include "nthw_phy_tile.h"
 
 /*
  * Structs for controlling Agilex based NT400DXX adapter
  */
 typedef struct nthw_agx_s {
+	nthw_i2cm_t *p_i2cm;
+	nthw_pca9849_t *p_pca9849;
+	nthw_pcal6416a_t *p_io_nim;	/* PCAL6416A I/O expander for controlling TS */
+	nthw_phy_tile_t *p_phy_tile;
 	nthw_rpf_t *p_rpf;
 } nthw_agx_t;
 
-- 
2.45.0

