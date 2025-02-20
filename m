Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9535AC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:07:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF77D40ED6;
	Thu, 20 Feb 2025 23:04:49 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id EAB9D4066F
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:35 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 mx-outbound8-89.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF13gQtZ8AGt94jdzTbNTgntUT0XkYmNfvE4V6ULWkirYS1Yq844/ttsAAgQBi6wpUeUBidGZxgq89Acm33JPJWlHOSxcB0H3joR5XmJERnHfwYlxrC0iSPj0iqHHCw3lK0hHT5SSBvvsY1ICXN3IbRwUOWSPdNvIAA75uMma51/R+vmXU2Ws5WBW2jgcirEXXjXnqFRbtJgudSlouzB07Da7HvQHrqlxLv/WGEFbN6cHxxKYQQDmnRbH/NPLVDrHBvKrbT1xAmPj4/9Qg26A5aD+JKJ10UV4oOWIh0oFErE5xwXefIEEiFKzwHmi8dcdA7ESt4McDAaS+lXjy6Opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st1c1l5mCf4s8cGf6m88wLteIeCrKrXkSmJtgpIvuvI=;
 b=i9XFhKCN54i3IHryZWZI+zMFWmohlVr+DiCu5hh70RYn6ZAK+FWXXr5ZoheVBECSyiIKltb/Wik0R/Czjlph0eLzKIBYixPLsDJ+/y3MfBCd7sKTDl2n1IZSty7T1hTJI5/9GT7H8qUU/4KDOPjvvri1mXQcwDn8iuT/SOt20tHPPuDiceIBOnN4Lk5Drx80wfAEWUR62KzfmTbegk0BHIJ3iQpn/Lki5zozOyNO3l6KgJ8qJWme9FElm/2qElifXBkJ7iPq2GLuaMxm7l9IeJ8GlApvY8moVzW0Nxgqu0ozV9MZYaNlNMKmfnKfWdfS8acrJJFUhyPMwKDJVlUnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st1c1l5mCf4s8cGf6m88wLteIeCrKrXkSmJtgpIvuvI=;
 b=R3ki7c0rEDmzIz+dQkaVHng2rG+x3iEvY7V344ikaRFf1eTr/Qq3Yx/RIUg0gyV0GZTdYYaNZC+PYzS0CwKkL0QPDU2LSRplsGxU/jJ93u9AQng9ChQJPiBmdv+ZH1HAnEwcg+xG7SvUBfY6PDz+gfr0PofEemXhpW2pd09IbEo=
Received: from CWLP265CA0505.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::14)
 by DBAP190MB1016.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:32 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::3e) by CWLP265CA0505.outlook.office365.com
 (2603:10a6:400:18b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:31 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 25/32] net/ntnic: add SPI v3 support for FPGA
Date: Thu, 20 Feb 2025 23:03:49 +0100
Message-ID: <20250220220406.3925597-26-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DBAP190MB1016:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cec2d209-6e95-4c04-f365-08dd51fa8dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?arKeDu7uvxACDWM4x2iamGNZ7kvAhBZDUzuIsUeVaR2lblw9shWYpeXEJpyB?=
 =?us-ascii?Q?tyVjta4MyCV1iRLW57BLN1WIPO4g4duvYVV+vhu2HZkOCtCE+Jn5Us9zF3iY?=
 =?us-ascii?Q?HnHczi2IFu/dA5fPmf8X1v39mvFyI4vmYljD86Oze+SpVSsyMJjYulprabh/?=
 =?us-ascii?Q?2MLZuhybJsgVbQjI5FT/fVB4QW7dUESGtRPlMIq4dvDnVluj+OcLYD5sKH0V?=
 =?us-ascii?Q?jQaPTNMo5hM6aJB8HVCX3fvQoSZJ3RRNFjXUlmGnWwQI3OP6Ic+NagygSOqI?=
 =?us-ascii?Q?BbOB7gEXyhpe6LCs7ojsCgav8dlKY1tZSgqbFLZkWHqq8M0CjQU8vFCSQDBb?=
 =?us-ascii?Q?FpemWMWTX9iJlGYtqZleY7A1H6qTn6hPFxfNx4TxJkFfVly6yJQ2NevQL7yz?=
 =?us-ascii?Q?GXnpSJWIy3FzMw1KjzyaCM/ogdWCQmspvYX87RK4p4E02N4VF+kkfJh806FX?=
 =?us-ascii?Q?ZHjQ70ACzn69KDxf+tZLlzLtBDJ0BL8Q/w3bnHjPTl7g/rsx9PcYRD3cuAFW?=
 =?us-ascii?Q?IprgTtHofz6D3MvS0QG3UyxXRw4kYKd5QZSi4y1jSSe+SVXEp2vd7Xjtckim?=
 =?us-ascii?Q?8OYIrWv1F2H9rXbxPyg83tErp23LqZkMBJ4/RRU/5nTbcxIoMeHwDp7Rj60F?=
 =?us-ascii?Q?vsnt45nJpP8MKfR2JkJBLvlj9ZXTD7jydpfDl/9tD7n7jTI0n3w1bvVI0K9d?=
 =?us-ascii?Q?lZu3BjKDHjPgAxnYNdBxqagh93V6wxtLA+slW2Fg/3Fq8igrwK/DlzAiTNTy?=
 =?us-ascii?Q?CDCKo+xAee8QmD7/pyW8FoBtCwJ0l5O7vd/7JIKaa+6vd6bCQSd0RYtermAz?=
 =?us-ascii?Q?Tuxd0dAkHG62rovA1KpAhyr8MlzKWC6bGieK3N+R8pRhgId0ydP8eFUl7QLK?=
 =?us-ascii?Q?pKh7uaczYQT87s0fuuchS4KDZkFQ/HqcIP6e/YYW9ijJNs3rih2ZR+T2q3Po?=
 =?us-ascii?Q?QxSEwao26hdJ14/HRYsSP2Jlwz1aBFo5I4EkyBLldSwav/oRW+nnewo43qtG?=
 =?us-ascii?Q?r8UDTowBOHYTDxc7b2sQ767fbGH30WAv84nP6+flFrLvIde5zfJZ14vZzVrx?=
 =?us-ascii?Q?/XANLo62YvqCcE4PJeHKupPiZDW//amFgs60Yf1cTS66M3P6w3wJ37yTX7+7?=
 =?us-ascii?Q?Iwng81tbccJHAnqy1E/+vhbiY1zdriNaC7eEORYie1klUXaXeSnlluPulcTO?=
 =?us-ascii?Q?Lr+7Z3cAraO3Ayh+nyK6qBTF8mxQdM28VbclHHf4Qu/bQt6JoVi0KMy6thTG?=
 =?us-ascii?Q?oytAyPuS3CivTztAr6R+WXKPKLWwfaNK8ZyVXlR/6Z/IbXDOA8VHyh03QkSd?=
 =?us-ascii?Q?1hcgl737xcV8Xii+9EuNFI7kfmfgXUvM2cbJkKB7XJHz22k1Rvovww1ltlHI?=
 =?us-ascii?Q?F1yq221KM7vWF/3oWlfaf62XXXZcPw0TMXOZ/CD9WS0avaezIH65N185zQbF?=
 =?us-ascii?Q?bnLltJa9yipqsbhfSnGLtsTvpUks83xdhVks0wJKdQY93DgGV46o4Wp2ffLg?=
 =?us-ascii?Q?3dYRGsLvcu+Qqhs=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nieijcLckLWDA6hdpnGxSmDRgjR4akS3n4Wp/yFOlCmA4Qkoe4QJa+XQhC9fY96HblrPlsAvwVWxlGoB9Vu/uw7HskWqe1VSrJiX2SXxe8ka+MLHbVRV232+kdRvA0u8QIDejcUXmHKi5xsQ2jzobLv3s9sYtElCYt7u+FXDDzPekpkQvI5qf6ezoQ+1D9DufpLz3Qi2xsFFpg+sxE/u5crDOpG5l4PShkijd9/UczpaHZA4yInxcB3ghY7Kj5sc01/jO4VfRya6iJuZ7uqSzHLuQKipM6hfRqcGABzwzxzsr8mhAMPXkJv7MfSw9XmGyyRUdUyO/QwL+Vt9ep4up3rCsNB5BjVcQs+F2WSQa2HJvrQVlPWGyX2A9zBR91RJsSgHSEUXAOF+YKKsu1/vAMD8FBelLV6ZvEXNTAilNiiFssyR855O071vzCNYgLwy070m0LVyX4z8kPXblYHzQIR2G15bQ6sfI55HT0RPDCoR62WJb1fj0/dRi2Vs55S6XsdZHfYiVbI5eZUaKpMRrvxG7Lv8KUTaqQ0nGD23aLrrASNJdhGfOKxe7S+ygTM8rCSckZOd8wR8vj+FjlPoTouylcjhHdMtpo83cCtkSn2uhe0a0ofL/gddAmr2fCpu4+LL+D5jBPf6x7sTpaL9LJ6CNnkdThiTIT8tRg6LdJo=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:31.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec2d209-6e95-4c04-f365-08dd51fa8dd0
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB1016
X-BESS-ID: 1740089073-302137-23554-14697-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGpibGQGYGUDTFzDApxcTEMD
 HV2CLVONHM0tQsNSk52dTU3NDcONE0Sak2FgC5FQXiQgAAAA==
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan21-197.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND
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

- Implement nthw_spi_v3 module with initialization, transfer, and
utility functions.
- Add nthw_spim and nthw_spis modules for SPI primary and secondary
interfaces.
- Include SPI v3 header files and update meson build configuration.
- Implement AVR probe function to retrieve and log AVR information.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/meson.build                 |   3 +
 .../net/ntnic/nthw/core/include/nthw_fpga.h   |   2 +
 .../net/ntnic/nthw/core/include/nthw_spi_v3.h | 107 +++++
 .../net/ntnic/nthw/core/include/nthw_spim.h   |  58 +++
 .../net/ntnic/nthw/core/include/nthw_spis.h   |  63 +++
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |   2 +
 drivers/net/ntnic/nthw/core/nthw_fpga.c       | 444 ++++++++++++++++++
 drivers/net/ntnic/nthw/core/nthw_spi_v3.c     | 358 ++++++++++++++
 drivers/net/ntnic/nthw/core/nthw_spim.c       | 113 +++++
 drivers/net/ntnic/nthw/core/nthw_spis.c       | 121 +++++
 10 files changed, 1271 insertions(+)
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spim.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spis.h
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_spi_v3.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_spim.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_spis.c

diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 9885d4efbf..7e326a3e1d 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -69,6 +69,9 @@ sources = files(
         'nthw/core/nthw_rmc.c',
         'nthw/core/nthw_sdc.c',
         'nthw/core/nthw_si5340.c',
+        'nthw/core/nthw_spim.c',
+        'nthw/core/nthw_spis.c',
+        'nthw/core/nthw_spi_v3.c',
         'nthw/stat/nthw_stat.c',
         'nthw/flow_api/flow_api.c',
         'nthw/flow_api/flow_group.c',
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
index 8b1d548a25..418aea8277 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
@@ -18,6 +18,8 @@ int nthw_fpga_shutdown(struct fpga_info_s *p_fpga_info);
 
 int nthw_fpga_get_param_info(struct fpga_info_s *p_fpga_info, nthw_fpga_t *p_fpga);
 
+int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no);
+
 int nthw_fpga_iic_scan(nthw_fpga_t *p_fpga, const int n_instance_no_begin,
 	const int n_instance_no_end);
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h b/drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
new file mode 100644
index 0000000000..66b1f7f45d
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
@@ -0,0 +1,107 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef __NT4GA_SPI_V3__
+#define __NT4GA_SPI_V3__
+
+#include "nthw_spis.h"
+#include "nthw_spim.h"
+
+/* Must include v1.x series. The first v1.0a only had 248 bytes of storage. v2.0x have 255 */
+#define MAX_AVR_CONTAINER_SIZE (248)
+
+enum avr_opcodes {
+	__AVR_OP_NOP = 0,	/* v2 NOP command */
+	/* version handlers */
+	AVR_OP_VERSION = 1,
+	AVR_OP_SPI_VERSION = 2,	/* v2.0+ command Get protocol version */
+	AVR_OP_SYSINFO = 3,
+	/* Ping handlers */
+	AVR_OP_PING = 4,
+	AVR_OP_PING_DELAY = 5,
+	/* i2c handlers */
+	AVR_OP_I2C_READ = 9,
+	AVR_OP_I2C_WRITE = 10,
+	AVR_OP_I2C_RANDOM_READ = 11,
+	/* VPD handlers */
+	AVR_OP_VPD_READ = 19,
+	AVR_OP_VPD_WRITE = 20,
+	/* SENSOR handlers */
+	AVR_OP_SENSOR_FETCH = 28,
+	/* The following command are only relevant to V3 */
+	AVR_OP_SENSOR_MON_CONTROL = 42,
+	AVR_OP_SENSOR_MON_SETUP = 43,
+	/* special version handler */
+	AVR_OP_SYSINFO_2 = 62,
+};
+
+#define GEN2_AVR_IDENT_SIZE (20)
+#define GEN2_AVR_VERSION_SIZE (50)
+
+#define GEN2_PN_SIZE (13)
+#define GEN2_PBA_SIZE (16)
+#define GEN2_SN_SIZE (10)
+#define GEN2_BNAME_SIZE (14)
+#define GEN2_PLATFORM_SIZE (72)
+#define GEN2_VPD_SIZE_TOTAL                                                                       \
+	(1 + GEN2_PN_SIZE + GEN2_PBA_SIZE + GEN2_SN_SIZE + GEN2_BNAME_SIZE + GEN2_PLATFORM_SIZE + \
+	 2)
+
+typedef struct vpd_eeprom_s {
+	uint8_t psu_hw_version;	/* Hw revision - MUST NEVER ne overwritten. */
+	/* Vital Product Data: P/N   (13bytes ascii 0-9) */
+	uint8_t vpd_pn[GEN2_PN_SIZE];
+	/* Vital Product Data: PBA   (16bytes ascii 0-9) */
+	uint8_t vpd_pba[GEN2_PBA_SIZE];
+	/* Vital Product Data: S/N   (10bytes ascii 0-9) */
+	uint8_t vpd_sn[GEN2_SN_SIZE];
+	/* Vital Product Data: Board Name (10bytes ascii) (e.g. "ntmainb1e2" or "ntfront20b1") */
+	uint8_t vpd_board_name[GEN2_BNAME_SIZE];
+	/*
+	 * Vital Product Data: Other (72bytes of MAC addresses or other stuff.. (gives up to 12 mac
+	 * addresses)
+	 */
+	uint8_t vpd_platform_section[GEN2_PLATFORM_SIZE];
+	/* CRC16 checksum of all of above. This field is not included in the checksum */
+	uint16_t crc16;
+} vpd_eeprom_t;
+
+typedef struct {
+	uint8_t psu_hw_revision;
+	char board_type[GEN2_BNAME_SIZE + 1];
+	char product_id[GEN2_PN_SIZE + 1];
+	char pba_id[GEN2_PBA_SIZE + 1];
+	char serial_number[GEN2_SN_SIZE + 1];
+	uint8_t product_family;
+	uint32_t feature_mask;
+	uint32_t invfeature_mask;
+	uint8_t no_of_macs;
+	uint8_t mac_address[6];
+	uint16_t custom_id;
+	uint8_t user_id[8];
+} board_info_t;
+
+struct tx_rx_buf {
+	uint16_t size;
+	void *p_buf;
+};
+
+struct nthw_spi_v3 {
+	int m_time_out;
+	int mn_instance_no;
+	nthw_spim_t *mp_spim_mod;
+	nthw_spis_t *mp_spis_mod;
+};
+
+typedef struct nthw_spi_v3 nthw_spi_v3_t;
+typedef struct nthw_spi_v3 nthw_spi_v3;
+
+nthw_spi_v3_t *nthw_spi_v3_new(void);
+int nthw_spi_v3_init(nthw_spi_v3_t *p, nthw_fpga_t *p_fpga, int n_instance_no);
+
+int nthw_spi_v3_transfer(nthw_spi_v3_t *p, uint16_t opcode, struct tx_rx_buf *tx_buf,
+	struct tx_rx_buf *rx_buf);
+
+#endif	/* __NT4GA_SPI_V3__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_spim.h b/drivers/net/ntnic/nthw/core/include/nthw_spim.h
new file mode 100644
index 0000000000..70a49ab627
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_spim.h
@@ -0,0 +1,58 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef __NTHW_SPIM_H__
+#define __NTHW_SPIM_H__
+
+#include "nthw_fpga.h"
+
+struct nthw_spim {
+	nthw_fpga_t *mp_fpga;
+	nthw_module_t *mp_mod_spim;
+	int mn_instance;
+
+	nthw_register_t *mp_reg_srr;
+	nthw_field_t *mp_fld_srr_rst;
+
+	nthw_register_t *mp_reg_cr;
+	nthw_field_t *mp_fld_cr_loop;
+	nthw_field_t *mp_fld_cr_en;
+	nthw_field_t *mp_fld_cr_txrst;
+	nthw_field_t *mp_fld_cr_rxrst;
+
+	nthw_register_t *mp_reg_sr;
+	nthw_field_t *mp_fld_sr_done;
+	nthw_field_t *mp_fld_sr_txempty;
+	nthw_field_t *mp_fld_sr_rxempty;
+	nthw_field_t *mp_fld_sr_txfull;
+	nthw_field_t *mp_fld_sr_rxfull;
+	nthw_field_t *mp_fld_sr_txlvl;
+	nthw_field_t *mp_fld_sr_rxlvl;
+
+	nthw_register_t *mp_reg_dtr;
+	nthw_field_t *mp_fld_dtr_dtr;
+
+	nthw_register_t *mp_reg_drr;
+	nthw_field_t *mp_fld_drr_drr;
+
+	nthw_register_t *mp_reg_cfg;
+	nthw_field_t *mp_fld_cfg_pre;
+
+	nthw_register_t *mp_reg_cfg_clk;
+	nthw_field_t *mp_fld_cfg_clk_mode;
+};
+
+typedef struct nthw_spim nthw_spim_t;
+typedef struct nthw_spim nthw_spim;
+
+nthw_spim_t *nthw_spim_new(void);
+int nthw_spim_init(nthw_spim_t *p, nthw_fpga_t *p_fpga, int n_instance);
+
+uint32_t nthw_spim_reset(nthw_spim_t *p);
+uint32_t nthw_spim_enable(nthw_spim_t *p, bool b_enable);
+uint32_t nthw_spim_get_tx_fifo_empty(nthw_spim_t *p, bool *pb_empty);
+uint32_t nthw_spim_write_tx_fifo(nthw_spim_t *p, uint32_t n_data);
+
+#endif	/* __NTHW_SPIM_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_spis.h b/drivers/net/ntnic/nthw/core/include/nthw_spis.h
new file mode 100644
index 0000000000..978f239dd0
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_spis.h
@@ -0,0 +1,63 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef __NTHW_SPIS_H__
+#define __NTHW_SPIS_H__
+
+#include "nthw_fpga.h"
+
+struct nthw_spis {
+	nthw_fpga_t *mp_fpga;
+	nthw_module_t *mp_mod_spis;
+	int mn_instance;
+
+	nthw_register_t *mp_reg_srr;
+	nthw_field_t *mp_fld_srr_rst;
+
+	nthw_register_t *mp_reg_cr;
+	nthw_field_t *mp_fld_cr_loop;
+	nthw_field_t *mp_fld_cr_en;
+	nthw_field_t *mp_fld_cr_txrst;
+	nthw_field_t *mp_fld_cr_rxrst;
+	nthw_field_t *mp_fld_cr_debug;
+
+	nthw_register_t *mp_reg_sr;
+	nthw_field_t *mp_fld_sr_done;
+	nthw_field_t *mp_fld_sr_txempty;
+	nthw_field_t *mp_fld_sr_rxempty;
+	nthw_field_t *mp_fld_sr_txfull;
+	nthw_field_t *mp_fld_sr_rxfull;
+	nthw_field_t *mp_fld_sr_txlvl;
+	nthw_field_t *mp_fld_sr_rxlvl;
+	nthw_field_t *mp_fld_sr_frame_err;
+	nthw_field_t *mp_fld_sr_read_err;
+	nthw_field_t *mp_fld_sr_write_err;
+
+	nthw_register_t *mp_reg_dtr;
+	nthw_field_t *mp_fld_dtr_dtr;
+
+	nthw_register_t *mp_reg_drr;
+	nthw_field_t *mp_fld_drr_drr;
+
+	nthw_register_t *mp_reg_ram_ctrl;
+	nthw_field_t *mp_fld_ram_ctrl_adr;
+	nthw_field_t *mp_fld_ram_ctrl_cnt;
+
+	nthw_register_t *mp_reg_ram_data;
+	nthw_field_t *mp_fld_ram_data_data;
+};
+
+typedef struct nthw_spis nthw_spis_t;
+typedef struct nthw_spis nthw_spis;
+
+nthw_spis_t *nthw_spis_new(void);
+int nthw_spis_init(nthw_spis_t *p, nthw_fpga_t *p_fpga, int n_instance);
+
+uint32_t nthw_spis_reset(nthw_spis_t *p);
+uint32_t nthw_spis_enable(nthw_spis_t *p, bool b_enable);
+uint32_t nthw_spis_get_rx_fifo_empty(nthw_spis_t *p, bool *pb_empty);
+uint32_t nthw_spis_read_rx_fifo(nthw_spis_t *p, uint32_t *p_data);
+
+#endif	/* __NTHW_SPIS_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index ff29101e61..73feaa4ebd 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -65,6 +65,8 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	nthw_prm_nt400dxx_periph_rst(p_fpga_info->mp_nthw_agx.p_prm, 0);
 	nt_os_wait_usec(10000);
 
+	res = nthw_fpga_avr_probe(p_fpga, 0);
+
 	if (res != 0)
 		return res;
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index e54a210c9f..3166a2ba51 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -14,6 +14,7 @@
 #include "nthw_fpga_mod_str_map.h"
 
 #include "nthw_tsm.h"
+#include "nthw_spi_v3.h"
 
 #include <arpa/inet.h>
 
@@ -151,6 +152,449 @@ int nthw_fpga_silabs_detect(nthw_fpga_t *p_fpga, const int n_instance_no, const
 	return res;
 }
 
+/*
+ * Calculate CRC-16-CCITT of passed data
+ * CRC-16-CCITT ^16 + ^12 + ^5 + 1 (0x1021) (X.25, HDLC, XMODEM, Bluetooth,
+ *   SD, many others; known as CRC-CCITT)
+ */
+static uint16_t crc16(uint8_t *buffer, size_t length)
+{
+	uint16_t seed = 0;
+
+	while (length--) {
+		seed = (uint16_t)(seed >> 8 | seed << 8);
+		seed = (uint16_t)(seed ^ *buffer++);
+		seed = (uint16_t)(seed ^ (seed & 0xff) >> 4);
+		seed = (uint16_t)(seed ^ seed << 8 << 4);
+		seed = (uint16_t)(seed ^ (seed & 0xff) << 4 << 1);
+	}
+
+	return seed;
+}
+
+int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no)
+{
+	struct fpga_info_s *p_fpga_info = p_fpga->p_fpga_info;
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	nthw_spi_v3_t *p_avr_spi;
+	int res = -1;
+
+	p_avr_spi = nthw_spi_v3_new();
+
+	if (p_avr_spi) {
+		struct avr_vpd_info_s {
+			/* avr info */
+			uint32_t n_avr_spi_version;
+			uint8_t n_avr_fw_ver_major;
+			uint8_t n_avr_fw_ver_minor;
+			uint8_t n_avr_fw_ver_micro;
+			uint8_t a_avr_fw_ver_str[50];
+			uint8_t a_avr_fw_plat_id_str[20];
+
+			/* vpd_eeprom_t */
+			uint8_t psu_hw_version;
+			uint8_t vpd_pn[GEN2_PN_SIZE];
+			uint8_t vpd_pba[GEN2_PBA_SIZE];
+			uint8_t vpd_sn[GEN2_SN_SIZE];
+			uint8_t vpd_board_name[GEN2_BNAME_SIZE];
+			uint8_t vpd_platform_section[GEN2_PLATFORM_SIZE];
+
+			/* board_info_t aka vpd_platform_section: */
+			uint32_t product_family;/* uint8_t 1: capture, 2: Inline, 3: analysis */
+			uint32_t feature_mask;	/* Bit 0: OC192 capable */
+			uint32_t invfeature_mask;
+			uint8_t no_of_macs;
+			uint8_t mac_address[6];
+			uint16_t custom_id;
+			uint8_t user_id[8];
+			/*
+			 * Reserved NT operations to monitor the reprogram count of user_id with
+			 * vpduser
+			 */
+			uint16_t user_id_erase_write_count;
+
+			/*
+			 * AVR_OP_SYSINFO: struct version_sysinfo_request_container
+			 * Which version of the sysinfo container to retrieve. Set to zero to fetch
+			 * latest. Offset zero of latest always contain an uint8_t version info
+			 */
+			uint8_t sysinfo_container_version;
+
+			/* AVR_OP_SYSINFO: struct AvrLibcVersion */
+			/* The constant __AVR_LIBC_VERSION__ */
+			uint32_t sysinfo_avr_libc_version;
+
+			/* AVR_OP_SYSINFO: struct AvrLibcSignature */
+			uint8_t sysinfo_signature_0;	/* The constant SIGNATURE_0 */
+			uint8_t sysinfo_signature_1;	/* The constant SIGNATURE_1 */
+			uint8_t sysinfo_signature_2;	/* The constant SIGNATURE_2 */
+
+			/* AVR_OP_SYSINFO: struct AvrOs */
+			uint8_t sysinfo_spi_version;	/* SPI command layer version */
+			/*
+			 * Hardware revision. Locked to eeprom address zero. Is also available via
+			 * VPD read opcode (prior to v1.4b, this is required)
+			 */
+			uint8_t sysinfo_hw_revision;
+			/*
+			 * Number of ticks/second (Note: Be aware this may become zero if timer
+			 * module is rewritten to a tickles system!)
+			 */
+			uint8_t sysinfo_ticks_per_second;
+			uint32_t sysinfo_uptime;/* Uptime in seconds since last AVR reset */
+			uint8_t sysinfo_osccal;	/* OSCCAL value */
+
+			/*
+			 * Meta data concluded/calculated from req/reply
+			 */
+			bool b_feature_mask_valid;
+			bool b_crc16_valid;
+			uint16_t n_crc16_stored;
+			uint16_t n_crc16_calced;
+			uint64_t n_mac_val;
+		};
+
+		struct avr_vpd_info_s avr_vpd_info;
+		struct tx_rx_buf tx_buf;
+		struct tx_rx_buf rx_buf;
+		char rx_data[MAX_AVR_CONTAINER_SIZE];
+		uint32_t u32;
+
+		memset(&avr_vpd_info, 0, sizeof(avr_vpd_info));
+
+		nthw_spi_v3_init(p_avr_spi, p_fpga, n_instance_no);
+
+		/* AVR_OP_SPI_VERSION */
+		tx_buf.size = 0;
+		tx_buf.p_buf = NULL;
+		rx_buf.size = sizeof(u32);
+		rx_buf.p_buf = &u32;
+		u32 = 0;
+		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SPI_VERSION, &tx_buf, &rx_buf);
+		avr_vpd_info.n_avr_spi_version = u32;
+		NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER: %d", p_adapter_id_str, n_instance_no,
+			avr_vpd_info.n_avr_spi_version);
+
+		/* AVR_OP_VERSION */
+		tx_buf.size = 0;
+		tx_buf.p_buf = NULL;
+		rx_buf.size = sizeof(rx_data);
+		rx_buf.p_buf = &rx_data;
+		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_VERSION, &tx_buf, &rx_buf);
+
+		avr_vpd_info.n_avr_fw_ver_major = rx_data[0];
+		avr_vpd_info.n_avr_fw_ver_minor = rx_data[1];
+		avr_vpd_info.n_avr_fw_ver_micro = rx_data[2];
+		NT_LOG(DBG, NTHW, "%s: AVR%d: FW_VER: %c.%c.%c", p_adapter_id_str, n_instance_no,
+			avr_vpd_info.n_avr_fw_ver_major, avr_vpd_info.n_avr_fw_ver_minor,
+			avr_vpd_info.n_avr_fw_ver_micro);
+
+		memcpy(avr_vpd_info.a_avr_fw_ver_str, &rx_data[0 + 3],
+			sizeof(avr_vpd_info.a_avr_fw_ver_str));
+		NT_LOG(DBG, NTHW, "%s: AVR%d: FW_VER_STR: '%.*s'", p_adapter_id_str,
+			n_instance_no, (int)sizeof(avr_vpd_info.a_avr_fw_ver_str),
+			avr_vpd_info.a_avr_fw_ver_str);
+
+		memcpy(avr_vpd_info.a_avr_fw_plat_id_str, &rx_data[0 + 3 + 50],
+			sizeof(avr_vpd_info.a_avr_fw_plat_id_str));
+		NT_LOG(DBG, NTHW, "%s: AVR%d: FW_HW_ID_STR: '%.*s'", p_adapter_id_str,
+			n_instance_no, (int)sizeof(avr_vpd_info.a_avr_fw_plat_id_str),
+			avr_vpd_info.a_avr_fw_plat_id_str);
+
+		snprintf(p_fpga_info->nthw_hw_info.hw_plat_id_str,
+			sizeof(p_fpga_info->nthw_hw_info.hw_plat_id_str), "%s",
+			(char *)avr_vpd_info.a_avr_fw_plat_id_str);
+		p_fpga_info->nthw_hw_info
+		.hw_plat_id_str[sizeof(p_fpga_info->nthw_hw_info.hw_plat_id_str) - 1] = 0;
+
+		/* AVR_OP_SYSINFO_2 */
+		tx_buf.size = 0;
+		tx_buf.p_buf = NULL;
+		rx_buf.size = sizeof(rx_data);
+		rx_buf.p_buf = &rx_data;
+		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SYSINFO_2, &tx_buf, &rx_buf);
+
+		if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 && rx_buf.size >= 16) {
+			if (rx_buf.size != 16) {
+				NT_LOG(WRN, NTHW,
+					"%s: AVR%d: SYSINFO2: reply is larger than expected: %04X %04X",
+					p_adapter_id_str, n_instance_no, rx_buf.size, 16);
+
+			} else {
+				NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO2: OK: res=%d sz=%d",
+					p_adapter_id_str, n_instance_no, res, rx_buf.size);
+			}
+
+			avr_vpd_info.sysinfo_container_version = rx_data[0];
+			NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO_REQ_VER: %d", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.sysinfo_container_version);
+
+			memcpy(&avr_vpd_info.sysinfo_avr_libc_version, &rx_data[0 + 1],
+				sizeof(avr_vpd_info.sysinfo_avr_libc_version));
+			NT_LOG(DBG, NTHW, "%s: AVR%d: LIBC_VER: %d", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.sysinfo_avr_libc_version);
+
+			avr_vpd_info.sysinfo_signature_0 = rx_data[5];
+			avr_vpd_info.sysinfo_signature_1 = rx_data[6];
+			avr_vpd_info.sysinfo_signature_2 = rx_data[7];
+			NT_LOG(DBG, NTHW, "%s: AVR%d: SIGNATURE: %02x%02x%02x", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.sysinfo_signature_0,
+				avr_vpd_info.sysinfo_signature_1, avr_vpd_info.sysinfo_signature_2);
+
+			avr_vpd_info.sysinfo_spi_version = rx_data[8];
+			NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER: %d", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.sysinfo_spi_version);
+
+			avr_vpd_info.sysinfo_hw_revision = rx_data[9];
+			NT_LOG(DBG, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.sysinfo_hw_revision);
+
+			avr_vpd_info.sysinfo_ticks_per_second = rx_data[10];
+			NT_LOG(DBG, NTHW, "%s: AVR%d: TICKS_PER_SEC: %d", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.sysinfo_ticks_per_second);
+
+			memcpy(&avr_vpd_info.sysinfo_uptime, &rx_data[11],
+				sizeof(avr_vpd_info.sysinfo_uptime));
+			NT_LOG(DBG, NTHW, "%s: AVR%d: UPTIME: %d", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.sysinfo_uptime);
+
+			avr_vpd_info.sysinfo_osccal = rx_data[15];
+			NT_LOG(DBG, NTHW, "%s: AVR%d: OSCCAL: %d", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.sysinfo_osccal);
+
+			{
+				bool b_spi_ver_match = (avr_vpd_info.n_avr_spi_version ==
+						avr_vpd_info.sysinfo_spi_version);
+				(void)b_spi_ver_match;
+				NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER_TST: %s (%d %d)",
+					p_adapter_id_str, n_instance_no,
+					(b_spi_ver_match ? "OK" : "MISMATCH"),
+					avr_vpd_info.n_avr_spi_version,
+					avr_vpd_info.sysinfo_spi_version);
+			}
+
+			/* SYSINFO2: if response: only populate hw_id not hw_id_emulated */
+			p_fpga_info->nthw_hw_info.hw_id = avr_vpd_info.sysinfo_hw_revision;
+
+		} else {
+			/* AVR_OP_SYSINFO */
+			tx_buf.size = 0;
+			tx_buf.p_buf = NULL;
+			rx_buf.size = sizeof(rx_data);
+			rx_buf.p_buf = &rx_data;
+			res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SYSINFO, &tx_buf, &rx_buf);
+
+			if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 && rx_buf.size >= 16) {
+				if (rx_buf.size != 16) {
+					NT_LOG(WRN, NTHW,
+						"%s: AVR%d: SYSINFO: reply is larger than expected: %04X %04X",
+						p_adapter_id_str, n_instance_no, rx_buf.size, 16);
+
+				} else {
+					NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO: OK: res=%d sz=%d",
+						p_adapter_id_str, n_instance_no, res, rx_buf.size);
+				}
+
+				avr_vpd_info.sysinfo_container_version = rx_data[0];
+				NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO_REQ_VER: %d",
+					p_adapter_id_str, n_instance_no,
+					avr_vpd_info.sysinfo_container_version);
+
+				memcpy(&avr_vpd_info.sysinfo_avr_libc_version, &rx_data[0 + 1],
+					sizeof(avr_vpd_info.sysinfo_avr_libc_version));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: LIBC_VER: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.sysinfo_avr_libc_version);
+
+				avr_vpd_info.sysinfo_signature_0 = rx_data[5];
+				avr_vpd_info.sysinfo_signature_1 = rx_data[6];
+				avr_vpd_info.sysinfo_signature_2 = rx_data[7];
+				NT_LOG(DBG, NTHW, "%s: AVR%d: SIGNATURE: %02x%02x%02x",
+					p_adapter_id_str, n_instance_no,
+					avr_vpd_info.sysinfo_signature_0,
+					avr_vpd_info.sysinfo_signature_1,
+					avr_vpd_info.sysinfo_signature_2);
+
+				avr_vpd_info.sysinfo_spi_version = rx_data[8];
+				NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.sysinfo_spi_version);
+
+				avr_vpd_info.sysinfo_hw_revision = rx_data[9];
+				NT_LOG(DBG, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.sysinfo_hw_revision);
+				NT_LOG(INF, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.sysinfo_hw_revision);
+
+				avr_vpd_info.sysinfo_ticks_per_second = rx_data[10];
+				NT_LOG(DBG, NTHW, "%s: AVR%d: TICKS_PER_SEC: %d",
+					p_adapter_id_str, n_instance_no,
+					avr_vpd_info.sysinfo_ticks_per_second);
+
+				memcpy(&avr_vpd_info.sysinfo_uptime, &rx_data[11],
+					sizeof(avr_vpd_info.sysinfo_uptime));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: UPTIME: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.sysinfo_uptime);
+
+				avr_vpd_info.sysinfo_osccal = rx_data[15];
+				NT_LOG(DBG, NTHW, "%s: AVR%d: OSCCAL: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.sysinfo_osccal);
+
+				{
+					bool b_spi_ver_match = (avr_vpd_info.n_avr_spi_version ==
+							avr_vpd_info.sysinfo_spi_version);
+					(void)b_spi_ver_match;
+					NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER_TST: %s (%d %d)",
+						p_adapter_id_str, n_instance_no,
+						(b_spi_ver_match ? "OK" : "MISMATCH"),
+						avr_vpd_info.n_avr_spi_version,
+						avr_vpd_info.sysinfo_spi_version);
+				}
+
+				p_fpga_info->nthw_hw_info.hw_id = avr_vpd_info.sysinfo_hw_revision;
+				p_fpga_info->nthw_hw_info.hw_id_emulated =
+					avr_vpd_info.sysinfo_hw_revision;
+
+			} else {
+				NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO: NA: res=%d sz=%d",
+					p_adapter_id_str, n_instance_no, res, rx_buf.size);
+			}
+		}
+
+		/* AVR_OP_VPD_READ */
+		tx_buf.size = 0;
+		tx_buf.p_buf = NULL;
+		rx_buf.size = sizeof(rx_data);
+		rx_buf.p_buf = &rx_data;
+		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_VPD_READ, &tx_buf, &rx_buf);
+
+		if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 &&
+			rx_buf.size >= GEN2_VPD_SIZE_TOTAL) {
+			avr_vpd_info.n_crc16_calced = crc16(rx_buf.p_buf, rx_buf.size - 2);
+			memcpy(&avr_vpd_info.n_crc16_stored, &rx_data[rx_buf.size - 2],
+				sizeof(avr_vpd_info.n_crc16_stored));
+			NT_LOG(DBG, NTHW, "%s: AVR%d: VPD_CRC: %04X %04X", p_adapter_id_str,
+				n_instance_no, avr_vpd_info.n_crc16_stored,
+				avr_vpd_info.n_crc16_calced);
+
+			avr_vpd_info.b_crc16_valid =
+				(avr_vpd_info.n_crc16_stored == avr_vpd_info.n_crc16_calced);
+			NT_LOG(DBG, NTHW, "%s: AVR%d: CRC_TST: %s", p_adapter_id_str,
+				n_instance_no, (avr_vpd_info.b_crc16_valid ? "OK" : "ERROR"));
+
+			if (avr_vpd_info.b_crc16_valid) {
+				memcpy(&avr_vpd_info.psu_hw_version, &rx_data[0],
+					sizeof(avr_vpd_info.psu_hw_version));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: PSU_HW_VER: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.psu_hw_version);
+
+				memcpy(&avr_vpd_info.vpd_pn, &rx_data[0 + 1],
+					sizeof(avr_vpd_info.vpd_pn));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: PN: '%.*s'", p_adapter_id_str,
+					n_instance_no, GEN2_PN_SIZE, avr_vpd_info.vpd_pn);
+
+				memcpy(&avr_vpd_info.vpd_pba, &rx_data[0 + 1 + GEN2_PN_SIZE],
+					sizeof(avr_vpd_info.vpd_pba));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: PBA: '%.*s'", p_adapter_id_str,
+					n_instance_no, GEN2_PBA_SIZE, avr_vpd_info.vpd_pba);
+
+				memcpy(&avr_vpd_info.vpd_sn,
+					&rx_data[0 + 1 + GEN2_PN_SIZE + GEN2_PBA_SIZE],
+					sizeof(avr_vpd_info.vpd_sn));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: SN: '%.*s", p_adapter_id_str,
+					n_instance_no, GEN2_SN_SIZE, avr_vpd_info.vpd_sn);
+
+				memcpy(&avr_vpd_info.vpd_board_name,
+					&rx_data[0 + 1 + GEN2_PN_SIZE + GEN2_PBA_SIZE +
+						GEN2_SN_SIZE],
+					sizeof(avr_vpd_info.vpd_board_name));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: BN: '%.*s'", p_adapter_id_str,
+					n_instance_no, GEN2_BNAME_SIZE,
+					avr_vpd_info.vpd_board_name);
+
+				union mac_u {
+					uint8_t a_u8[8];
+					uint16_t a_u16[4];
+					uint32_t a_u32[2];
+					uint64_t a_u64[1];
+				} mac;
+
+				/* vpd_platform_section */
+				uint8_t *p_vpd_board_info =
+					(uint8_t *)(&rx_data[1 + GEN2_PN_SIZE + GEN2_PBA_SIZE +
+					GEN2_SN_SIZE + GEN2_BNAME_SIZE]);
+				memcpy(&avr_vpd_info.product_family, &p_vpd_board_info[0],
+					sizeof(avr_vpd_info.product_family));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: PROD_FAM: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.product_family);
+
+				memcpy(&avr_vpd_info.feature_mask, &p_vpd_board_info[0 + 4],
+					sizeof(avr_vpd_info.feature_mask));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_VAL: 0x%08X",
+					p_adapter_id_str, n_instance_no, avr_vpd_info.feature_mask);
+
+				memcpy(&avr_vpd_info.invfeature_mask, &p_vpd_board_info[0 + 4 + 4],
+					sizeof(avr_vpd_info.invfeature_mask));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_INV: 0x%08X",
+					p_adapter_id_str, n_instance_no,
+					avr_vpd_info.invfeature_mask);
+
+				avr_vpd_info.b_feature_mask_valid =
+					(avr_vpd_info.feature_mask ==
+						~avr_vpd_info.invfeature_mask);
+				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_TST: %s", p_adapter_id_str,
+					n_instance_no,
+					(avr_vpd_info.b_feature_mask_valid ? "OK" : "ERROR"));
+
+				memcpy(&avr_vpd_info.no_of_macs, &p_vpd_board_info[0 + 4 + 4 + 4],
+					sizeof(avr_vpd_info.no_of_macs));
+				NT_LOG(DBG, NTHW, "%s: AVR%d: NUM_MACS: %d", p_adapter_id_str,
+					n_instance_no, avr_vpd_info.no_of_macs);
+
+				memcpy(&avr_vpd_info.mac_address,
+					&p_vpd_board_info[0 + 4 + 4 + 4 + 1],
+					sizeof(avr_vpd_info.mac_address));
+				NT_LOG(DBG, NTHW,
+					"%s: AVR%d: MAC_ADDR: %02x:%02x:%02x:%02x:%02x:%02x",
+					p_adapter_id_str, n_instance_no,
+					avr_vpd_info.mac_address[0], avr_vpd_info.mac_address[1],
+					avr_vpd_info.mac_address[2], avr_vpd_info.mac_address[3],
+					avr_vpd_info.mac_address[4], avr_vpd_info.mac_address[5]);
+
+				mac.a_u64[0] = 0;
+				memcpy(&mac.a_u8[2], &avr_vpd_info.mac_address,
+					sizeof(avr_vpd_info.mac_address));
+				{
+					const uint32_t u1 = ntohl(mac.a_u32[0]);
+
+					if (u1 != mac.a_u32[0]) {
+						const uint32_t u0 = ntohl(mac.a_u32[1]);
+						mac.a_u32[0] = u0;
+						mac.a_u32[1] = u1;
+					}
+				}
+
+				avr_vpd_info.n_mac_val = mac.a_u64[0];
+				NT_LOG(DBG, NTHW, "%s: AVR%d: MAC_U64: %012" PRIX64 "",
+					p_adapter_id_str, n_instance_no, avr_vpd_info.n_mac_val);
+			}
+
+			p_fpga_info->nthw_hw_info.vpd_info.mn_mac_addr_count =
+				avr_vpd_info.no_of_macs;
+			p_fpga_info->nthw_hw_info.vpd_info.mn_mac_addr_value =
+				avr_vpd_info.n_mac_val;
+			memcpy(p_fpga_info->nthw_hw_info.vpd_info.ma_mac_addr_octets,
+				avr_vpd_info.mac_address,
+				ARRAY_SIZE(p_fpga_info->nthw_hw_info.vpd_info.ma_mac_addr_octets));
+
+		} else {
+			NT_LOG(ERR, NTHW, "%s:%u: res=%d", __func__, __LINE__, res);
+			NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO2: NA: res=%d sz=%d",
+				p_adapter_id_str, n_instance_no, res, rx_buf.size);
+		}
+	}
+
+	return res;
+}
+
 /*
  * NT200A02, NT200A01-HWbuild2
  */
diff --git a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
new file mode 100644
index 0000000000..0b611462a0
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
@@ -0,0 +1,358 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_fpga.h"
+
+#include "nthw_spi_v3.h"
+
+#include <arpa/inet.h>
+
+#undef SPI_V3_DEBUG_PRINT
+
+nthw_spi_v3_t *nthw_spi_v3_new(void)
+{
+	nthw_spi_v3_t *p = malloc(sizeof(nthw_spi_v3_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_spi_v3_t));
+
+	return p;
+}
+
+static int nthw_spi_v3_set_timeout(nthw_spi_v3_t *p, int time_out)
+{
+	p->m_time_out = time_out;
+	return 0;
+}
+
+/*
+ * Wait until Tx data have been sent after they have been placed in the Tx FIFO.
+ */
+static int wait_for_tx_data_sent(nthw_spim_t *p_spim_mod, uint64_t time_out)
+{
+	int result;
+	bool empty;
+	uint64_t start_time;
+	uint64_t cur_time;
+	start_time = nt_os_get_time_monotonic_counter();
+
+	while (true) {
+		nt_os_wait_usec(1000);	/* Every 1ms */
+
+		result = nthw_spim_get_tx_fifo_empty(p_spim_mod, &empty);
+
+		if (result != 0) {
+			NT_LOG(WRN, NTHW, "nthw_spim_get_tx_fifo_empty failed");
+			return result;
+		}
+
+		if (empty)
+			break;
+
+		cur_time = nt_os_get_time_monotonic_counter();
+
+		if ((cur_time - start_time) > time_out) {
+			NT_LOG(WRN, NTHW, "%s: Timed out", __func__);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Wait until Rx data have been received.
+ */
+static int wait_for_rx_data_ready(nthw_spis_t *p_spis_mod, uint64_t time_out)
+{
+	int result;
+	bool empty;
+	uint64_t start_time;
+	uint64_t cur_time;
+	start_time = nt_os_get_time_monotonic_counter();
+
+	/* Wait for data to become ready in the Rx FIFO */
+	while (true) {
+		nt_os_wait_usec(10000);	/* Every 10ms */
+
+		result = nthw_spis_get_rx_fifo_empty(p_spis_mod, &empty);
+
+		if (result != 0) {
+			NT_LOG(WRN, NTHW, "nthw_spis_get_rx_empty failed");
+			return result;
+		}
+
+		if (!empty)
+			break;
+
+		cur_time = nt_os_get_time_monotonic_counter();
+
+		if ((cur_time - start_time) > time_out) {
+			NT_LOG(WRN, NTHW, "%s: Timed out", __func__);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+#ifdef SPI_V3_DEBUG_PRINT
+static void dump_hex(uint8_t *p_data, uint16_t count)
+{
+	int i;
+	int j = 0;
+	char tmp_str[128];
+
+	for (i = 0; i < count; i++) {
+		sprintf(&tmp_str[j * 3], "%02X ", *(p_data++));
+		j++;
+
+		if (j == 16 || i == count - 1) {
+			tmp_str[j * 3 - 1] = '\0';
+			NT_LOG(DBG, NTHW, "    %s", tmp_str);
+			j = 0;
+		}
+	}
+}
+
+#endif
+
+int nthw_spi_v3_init(nthw_spi_v3_t *p, nthw_fpga_t *p_fpga, int n_instance_no)
+{
+	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
+	uint32_t result;
+
+	p->mn_instance_no = n_instance_no;
+
+	nthw_spi_v3_set_timeout(p, 1);
+
+	/* Initialize SPIM module */
+	p->mp_spim_mod = nthw_spim_new();
+
+	result = nthw_spim_init(p->mp_spim_mod, p_fpga, n_instance_no);
+
+	if (result != 0)
+		NT_LOG(ERR, NTHW, "%s: nthw_spis_init failed: %d", p_adapter_id_str, result);
+
+	/* Initialize SPIS module */
+	p->mp_spis_mod = nthw_spis_new();
+
+	result = nthw_spis_init(p->mp_spis_mod, p_fpga, n_instance_no);
+
+	if (result != 0)
+		NT_LOG(ERR, NTHW, "%s: nthw_spim_init failed: %d", p_adapter_id_str, result);
+
+	/* Reset SPIM and SPIS modules */
+	result = nthw_spim_reset(p->mp_spim_mod);
+
+	if (result != 0)
+		NT_LOG(ERR, NTHW, "%s: nthw_spim_reset failed: %d", p_adapter_id_str, result);
+
+	result = nthw_spis_reset(p->mp_spis_mod);
+
+	if (result != 0)
+		NT_LOG(ERR, NTHW, "%s: nthw_spis_reset failed: %d", p_adapter_id_str, result);
+
+	return result;
+}
+
+/*
+ * Send Tx data using the SPIM module and receive any data using the SPIS module.
+ * The data are sent and received being wrapped into a SPI v3 container.
+ */
+int nthw_spi_v3_transfer(nthw_spi_v3_t *p, uint16_t opcode, struct tx_rx_buf *tx_buf,
+	struct tx_rx_buf *rx_buf)
+{
+	const uint16_t max_payload_rx_size = rx_buf->size;
+	int result = 0;
+
+#pragma pack(push, 1)
+	union {
+		uint32_t raw;
+
+		struct {
+			uint16_t opcode;
+			uint16_t size;
+		};
+	} spi_tx_hdr;
+
+	union {
+		uint32_t raw;
+
+		struct {
+			uint16_t error_code;
+			uint16_t size;
+		};
+	} spi_rx_hdr;
+
+#pragma pack(pop)
+
+#ifdef SPI_V3_DEBUG_PRINT
+	NT_LOG_DBG(DBG, NTHW, "Started");
+#endif
+
+	/* Disable transmission from Tx FIFO */
+	result = nthw_spim_enable(p->mp_spim_mod, false);
+
+	if (result != 0) {
+		NT_LOG(WRN, NTHW, "nthw_spim_enable failed");
+		return result;
+	}
+
+	/* Enable SPIS module */
+	result = nthw_spis_enable(p->mp_spis_mod, true);
+
+	if (result != 0) {
+		NT_LOG(WRN, NTHW, "nthw_spis_enable failed");
+		return result;
+	}
+
+	/* Put data into Tx FIFO */
+	spi_tx_hdr.opcode = opcode;
+	spi_tx_hdr.size = tx_buf->size;
+
+#ifdef SPI_V3_DEBUG_PRINT
+	NT_LOG(DBG, NTHW, "Opcode=0x%04X tx_bufSize=0x%04X rx_bufSize=0x%04X", opcode,
+		tx_buf->size, rx_buf->size);
+
+#endif	/* SPI_V3_DEBUG_PRINT */
+
+	result = nthw_spim_write_tx_fifo(p->mp_spim_mod, htonl(spi_tx_hdr.raw));
+
+	if (result != 0) {
+		NT_LOG(WRN, NTHW, "nthw_spim_write_tx_fifo failed");
+		return result;
+	}
+
+	{
+		uint8_t *tx_data = (uint8_t *)tx_buf->p_buf;
+		uint16_t tx_size = tx_buf->size;
+		uint16_t count;
+		uint32_t value;
+
+		while (tx_size > 0) {
+			if (tx_size > 4) {
+				count = 4;
+
+			} else {
+				count = tx_size;
+				value = 0;
+			}
+
+			memcpy(&value, tx_data, count);
+
+			result = nthw_spim_write_tx_fifo(p->mp_spim_mod, htonl(value));
+
+			if (result != 0) {
+				NT_LOG(WRN, NTHW, "nthw_spim_write_tx_fifo failed");
+				return result;
+			}
+
+			tx_size = (uint16_t)(tx_size - count);
+			tx_data += count;
+		}
+	}
+
+	/* Enable Tx FIFO */
+	result = nthw_spim_enable(p->mp_spim_mod, true);
+
+	if (result != 0) {
+		NT_LOG(WRN, NTHW, "nthw_spim_enable failed");
+		return result;
+	}
+
+	result = wait_for_tx_data_sent(p->mp_spim_mod, p->m_time_out);
+
+	if (result != 0)
+		return result;
+
+#ifdef SPI_V3_DEBUG_PRINT
+	NT_LOG(DBG, NTHW, "%s: SPI header and payload data have been sent", __func__);
+#endif
+
+	{
+		/* Start receiving data */
+		uint16_t rx_size =
+			sizeof(spi_rx_hdr.raw);	/* The first data to read is the header */
+		uint8_t *rx_data = (uint8_t *)rx_buf->p_buf;
+		bool rx_hdr_read = false;
+
+		rx_buf->size = 0;
+
+		while (true) {
+			uint16_t count;
+			uint32_t value;
+
+			if (!rx_hdr_read) {	/* Read the header */
+				result = wait_for_rx_data_ready(p->mp_spis_mod, p->m_time_out);
+
+				if (result != 0)
+					return result;
+
+				result = nthw_spis_read_rx_fifo(p->mp_spis_mod, &spi_rx_hdr.raw);
+
+				if (result != 0) {
+					NT_LOG(WRN, NTHW, "nthw_spis_read_rx_fifo failed");
+					return result;
+				}
+
+				spi_rx_hdr.raw = ntohl(spi_rx_hdr.raw);
+				rx_size = spi_rx_hdr.size;
+				rx_hdr_read = true;	/* Next time read payload */
+
+#ifdef SPI_V3_DEBUG_PRINT
+				NT_LOG(DBG, NTHW,
+					"  spi_rx_hdr.error_code = 0x%04X, spi_rx_hdr.size = 0x%04X",
+					spi_rx_hdr.error_code, spi_rx_hdr.size);
+#endif
+
+				if (spi_rx_hdr.error_code != 0) {
+					result = -1;	/* NT_ERROR_AVR_OPCODE_RETURNED_ERROR; */
+					break;
+				}
+
+				if (rx_size > max_payload_rx_size) {
+					result = 1;	/* NT_ERROR_AVR_RX_BUFFER_TOO_SMALL; */
+					break;
+				}
+
+			} else {/* Read the payload */
+				count = (uint16_t)(rx_size < 4U ? rx_size : 4U);
+
+				if (count == 0)
+					break;
+
+				result = wait_for_rx_data_ready(p->mp_spis_mod, p->m_time_out);
+
+				if (result != 0)
+					return result;
+
+				result = nthw_spis_read_rx_fifo(p->mp_spis_mod, &value);
+
+				if (result != 0) {
+					NT_LOG(WRN, NTHW, "nthw_spis_read_rx_fifo failed");
+					return result;
+				}
+
+				value = ntohl(value);	/* Convert to host endian */
+				memcpy(rx_data, &value, count);
+				rx_buf->size = (uint16_t)(rx_buf->size + count);
+				rx_size = (uint16_t)(rx_size - count);
+				rx_data += count;
+			}
+		}
+	}
+
+#ifdef SPI_V3_DEBUG_PRINT
+	NT_LOG(DBG, NTHW, "  RxData: %d", rx_buf->size);
+	dump_hex(rx_buf->p_buf, rx_buf->size);
+	NT_LOG(DBG, NTHW, "%s:  Ended: %d", __func__, result);
+#endif
+
+	return result;
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_spim.c b/drivers/net/ntnic/nthw/core/nthw_spim.c
new file mode 100644
index 0000000000..d30c11d0ff
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_spim.c
@@ -0,0 +1,113 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_register.h"
+
+#include "nthw_spim.h"
+
+nthw_spim_t *nthw_spim_new(void)
+{
+	nthw_spim_t *p = malloc(sizeof(nthw_spim_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_spim_t));
+
+	return p;
+}
+
+int nthw_spim_init(nthw_spim_t *p, nthw_fpga_t *p_fpga, int n_instance)
+{
+	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
+	nthw_module_t *mod = nthw_fpga_query_module(p_fpga, MOD_SPIM, n_instance);
+
+	if (p == NULL)
+		return mod == NULL ? -1 : 0;
+
+	if (mod == NULL) {
+		NT_LOG(ERR, NTHW, "%s: SPIM %d: no such instance", p_adapter_id_str, n_instance);
+		return -1;
+	}
+
+	p->mp_fpga = p_fpga;
+	p->mn_instance = n_instance;
+	p->mp_mod_spim = mod;
+
+	/* SPIM is a primary communication channel - turn off debug by default */
+	nthw_module_set_debug_mode(p->mp_mod_spim, 0x00);
+
+	p->mp_reg_srr = nthw_module_get_register(p->mp_mod_spim, SPIM_SRR);
+	p->mp_fld_srr_rst = nthw_register_get_field(p->mp_reg_srr, SPIM_SRR_RST);
+
+	p->mp_reg_cr = nthw_module_get_register(p->mp_mod_spim, SPIM_CR);
+	p->mp_fld_cr_loop = nthw_register_get_field(p->mp_reg_cr, SPIM_CR_LOOP);
+	p->mp_fld_cr_en = nthw_register_get_field(p->mp_reg_cr, SPIM_CR_EN);
+	p->mp_fld_cr_txrst = nthw_register_get_field(p->mp_reg_cr, SPIM_CR_TXRST);
+	p->mp_fld_cr_rxrst = nthw_register_get_field(p->mp_reg_cr, SPIM_CR_RXRST);
+
+	p->mp_reg_sr = nthw_module_get_register(p->mp_mod_spim, SPIM_SR);
+	p->mp_fld_sr_done = nthw_register_get_field(p->mp_reg_sr, SPIM_SR_DONE);
+	p->mp_fld_sr_txempty = nthw_register_get_field(p->mp_reg_sr, SPIM_SR_TXEMPTY);
+	p->mp_fld_sr_rxempty = nthw_register_get_field(p->mp_reg_sr, SPIM_SR_RXEMPTY);
+	p->mp_fld_sr_txfull = nthw_register_get_field(p->mp_reg_sr, SPIM_SR_TXFULL);
+	p->mp_fld_sr_rxfull = nthw_register_get_field(p->mp_reg_sr, SPIM_SR_RXFULL);
+	p->mp_fld_sr_txlvl = nthw_register_get_field(p->mp_reg_sr, SPIM_SR_TXLVL);
+	p->mp_fld_sr_rxlvl = nthw_register_get_field(p->mp_reg_sr, SPIM_SR_RXLVL);
+
+	p->mp_reg_dtr = nthw_module_get_register(p->mp_mod_spim, SPIM_DTR);
+	p->mp_fld_dtr_dtr = nthw_register_get_field(p->mp_reg_dtr, SPIM_DTR_DTR);
+
+	p->mp_reg_drr = nthw_module_get_register(p->mp_mod_spim, SPIM_DRR);
+	p->mp_fld_drr_drr = nthw_register_get_field(p->mp_reg_drr, SPIM_DRR_DRR);
+
+	p->mp_reg_cfg = nthw_module_get_register(p->mp_mod_spim, SPIM_CFG);
+	p->mp_fld_cfg_pre = nthw_register_get_field(p->mp_reg_cfg, SPIM_CFG_PRE);
+
+	p->mp_reg_cfg_clk = nthw_module_query_register(p->mp_mod_spim, SPIM_CFG_CLK);
+	p->mp_fld_cfg_clk_mode = nthw_register_query_field(p->mp_reg_cfg, SPIM_CFG_CLK_MODE);
+
+	return 0;
+}
+
+uint32_t nthw_spim_reset(nthw_spim_t *p)
+{
+	nthw_register_update(p->mp_reg_srr);
+	nthw_field_set_val32(p->mp_fld_srr_rst, 0x0A);	/* 0x0A hardcoded value - see doc */
+	nthw_register_flush(p->mp_reg_srr, 1);
+
+	return 0;
+}
+
+uint32_t nthw_spim_enable(nthw_spim_t *p, bool b_enable)
+{
+	nthw_field_update_register(p->mp_fld_cr_en);
+
+	if (b_enable)
+		nthw_field_set_all(p->mp_fld_cr_en);
+
+	else
+		nthw_field_clr_all(p->mp_fld_cr_en);
+
+	nthw_field_flush_register(p->mp_fld_cr_en);
+
+	return 0;
+}
+
+uint32_t nthw_spim_write_tx_fifo(nthw_spim_t *p, uint32_t n_data)
+{
+	nthw_field_set_val_flush32(p->mp_fld_dtr_dtr, n_data);
+	return 0;
+}
+
+uint32_t nthw_spim_get_tx_fifo_empty(nthw_spim_t *p, bool *pb_empty)
+{
+	assert(pb_empty);
+
+	*pb_empty = nthw_field_get_updated(p->mp_fld_sr_txempty) ? true : false;
+
+	return 0;
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_spis.c b/drivers/net/ntnic/nthw/core/nthw_spis.c
new file mode 100644
index 0000000000..3c34dec936
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_spis.c
@@ -0,0 +1,121 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_register.h"
+
+#include "nthw_spis.h"
+
+nthw_spis_t *nthw_spis_new(void)
+{
+	nthw_spis_t *p = malloc(sizeof(nthw_spis_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_spis_t));
+
+	return p;
+}
+
+int nthw_spis_init(nthw_spis_t *p, nthw_fpga_t *p_fpga, int n_instance)
+{
+	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
+	nthw_module_t *mod = nthw_fpga_query_module(p_fpga, MOD_SPIS, n_instance);
+
+	if (p == NULL)
+		return mod == NULL ? -1 : 0;
+
+	if (mod == NULL) {
+		NT_LOG(ERR, NTHW, "%s: SPIS %d: no such instance", p_adapter_id_str, n_instance);
+		return -1;
+	}
+
+	p->mp_fpga = p_fpga;
+	p->mn_instance = n_instance;
+	p->mp_mod_spis = mod;
+
+	/* SPIS is a primary communication channel - turn off debug by default */
+	nthw_module_set_debug_mode(p->mp_mod_spis, 0x00);
+
+	p->mp_reg_srr = nthw_module_get_register(p->mp_mod_spis, SPIS_SRR);
+	p->mp_fld_srr_rst = nthw_register_get_field(p->mp_reg_srr, SPIS_SRR_RST);
+
+	p->mp_reg_cr = nthw_module_get_register(p->mp_mod_spis, SPIS_CR);
+	p->mp_fld_cr_loop = nthw_register_get_field(p->mp_reg_cr, SPIS_CR_LOOP);
+	p->mp_fld_cr_en = nthw_register_get_field(p->mp_reg_cr, SPIS_CR_EN);
+	p->mp_fld_cr_txrst = nthw_register_get_field(p->mp_reg_cr, SPIS_CR_TXRST);
+	p->mp_fld_cr_rxrst = nthw_register_get_field(p->mp_reg_cr, SPIS_CR_RXRST);
+	p->mp_fld_cr_debug = nthw_register_get_field(p->mp_reg_cr, SPIS_CR_DEBUG);
+
+	p->mp_reg_sr = nthw_module_get_register(p->mp_mod_spis, SPIS_SR);
+	p->mp_fld_sr_done = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_DONE);
+	p->mp_fld_sr_txempty = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_TXEMPTY);
+	p->mp_fld_sr_rxempty = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_RXEMPTY);
+	p->mp_fld_sr_txfull = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_TXFULL);
+	p->mp_fld_sr_rxfull = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_RXFULL);
+	p->mp_fld_sr_txlvl = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_TXLVL);
+	p->mp_fld_sr_rxlvl = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_RXLVL);
+	p->mp_fld_sr_frame_err = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_FRAME_ERR);
+	p->mp_fld_sr_read_err = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_READ_ERR);
+	p->mp_fld_sr_write_err = nthw_register_get_field(p->mp_reg_sr, SPIS_SR_WRITE_ERR);
+
+	p->mp_reg_dtr = nthw_module_get_register(p->mp_mod_spis, SPIS_DTR);
+	p->mp_fld_dtr_dtr = nthw_register_get_field(p->mp_reg_dtr, SPIS_DTR_DTR);
+
+	p->mp_reg_drr = nthw_module_get_register(p->mp_mod_spis, SPIS_DRR);
+	p->mp_fld_drr_drr = nthw_register_get_field(p->mp_reg_drr, SPIS_DRR_DRR);
+
+	p->mp_reg_ram_ctrl = nthw_module_get_register(p->mp_mod_spis, SPIS_RAM_CTRL);
+	p->mp_fld_ram_ctrl_adr = nthw_register_get_field(p->mp_reg_ram_ctrl, SPIS_RAM_CTRL_ADR);
+	p->mp_fld_ram_ctrl_cnt = nthw_register_get_field(p->mp_reg_ram_ctrl, SPIS_RAM_CTRL_CNT);
+
+	p->mp_reg_ram_data = nthw_module_get_register(p->mp_mod_spis, SPIS_RAM_DATA);
+	p->mp_fld_ram_data_data = nthw_register_get_field(p->mp_reg_ram_data, SPIS_RAM_DATA_DATA);
+
+	return 0;
+}
+
+uint32_t nthw_spis_reset(nthw_spis_t *p)
+{
+	nthw_register_update(p->mp_reg_srr);
+	nthw_field_set_val32(p->mp_fld_srr_rst, 0x0A);	/* 0x0A hardcoded value - see doc */
+	nthw_register_flush(p->mp_reg_srr, 1);
+
+	return 0;
+}
+
+uint32_t nthw_spis_enable(nthw_spis_t *p, bool b_enable)
+{
+	nthw_field_update_register(p->mp_fld_cr_en);
+
+	if (b_enable)
+		nthw_field_set_all(p->mp_fld_cr_en);
+
+	else
+		nthw_field_clr_all(p->mp_fld_cr_en);
+
+	nthw_field_flush_register(p->mp_fld_cr_en);
+
+	return 0;
+}
+
+uint32_t nthw_spis_get_rx_fifo_empty(nthw_spis_t *p, bool *pb_empty)
+{
+	assert(pb_empty);
+
+	*pb_empty = nthw_field_get_updated(p->mp_fld_sr_rxempty) ? true : false;
+
+	return 0;
+}
+
+uint32_t nthw_spis_read_rx_fifo(nthw_spis_t *p, uint32_t *p_data)
+{
+	assert(p_data);
+
+	*p_data = nthw_field_get_updated(p->mp_fld_drr_drr);
+
+	return 0;
+}
-- 
2.45.0

