Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B1C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3B144067C;
	Mon,  5 May 2025 09:14:08 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id CF5514067C
 for <dev@dpdk.org>; Mon,  5 May 2025 09:14:07 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 mx-outbound45-79.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOGnPWF/vhnesqki+/JuYLJiD8XAoz5UzvSFDqx5U0ygM1k3GyOxJsGJmnIdb2WMRQkN0o4sf75AFO8gaAYLnog/FWgLAzLr7LVqIcoC7MbiyWPfw9KTWk7R9+zfhPhfm/YrG8ZAp4LT4F87AhCcUT6UDybSjDjoRgReliRnsukxfpuUEBbuSM0WNGXIoRmTbAxI1IVH7p/hiu3bp6kqYEL4hG7XbFXkHUbpkEraZTHrULIi9d6lDRSAGjewaU+t6TspXWk+aYZD8cS66A2+hMcWYY/CYRpC0bK4T37SQhPM/pHyFb0mg5BZP3yWXKQPWU5XcBxoObg5czjaItS7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve8F8+aaU2oJtSlKNVauokq/p17708lGS9U6ev6ryjA=;
 b=Fk2DjXzIPubwk8jG5F/AJk+DprDUnWRVythS2D10UngZ0RhQcQHz/dUD21GuuDphAM9QfL2XIF8c6ctOOX3xw/m5XQRMSduy4x3ybna8fggIco2pWCImUgEydp43FrcB+SKSO+xqA5hlKloOFXHMS41/CNow7KLb97ejFFn4zcT4whDLLD4HPt/wrflMvyHQWYzBtQpMe9NDMm4eWEPl3r4D0eNve8JZOsjMGmLiKy04rOevHX4kUvSHQ2RobBEI4bqwVxdMqGAamVV7y9/T9XGA517p1P+mMT7me7zZQnKysdhgbqHgmq9cSvb5A51NhskDN8jCVzM+cqrKGSvZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve8F8+aaU2oJtSlKNVauokq/p17708lGS9U6ev6ryjA=;
 b=Eqs4YMi1xkVl4nPRyn+mqCQMy6cIqp2C8arYBNPJdVzKIvEOboU3VTRQTaLa4hsq+eDXg3d0vQOVmNiUNxCa39ERzIRntemZB/kkiJdGZ2G36gv8Z5PXkaY5M+4L6Jbkn841LJ/xpVpItrDQCR+2vxUwZ5WhGheDtzlvpdxQWxI=
Received: from DU7P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::23)
 by AS4P190MB1901.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:510::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 07:13:20 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::70) by DU7P191CA0012.outlook.office365.com
 (2603:10a6:10:54e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:20
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 11/26] net/ntnic: remove unused code
Date: Mon,  5 May 2025 09:12:51 +0200
Message-ID: <20250505071309.586015-12-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AS4P190MB1901:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35497f56-562c-43f8-7a36-08dd8ba4510a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z9pwrT22/xv1xB2+5S1Et39PbnHCe/qFPnnNY21Cw5wm43fd4kECAS/61SCr?=
 =?us-ascii?Q?ZK8L3jAo0m4a2YCTTEtHRRMBb6uog38lk9NU8NNMpcrPzw/jlM0QYMVCY5ML?=
 =?us-ascii?Q?IwRQ56ry5kXxE09eWzmnQd+L7T2cvuWj0kivMxHcsmSV1JUfzBMZI75CksuL?=
 =?us-ascii?Q?9KvMQeo7e0j6c/9kXEWmeEJw7NJI6aWNZCZYpkxRS9Xj2G98smuSXFUcmvSU?=
 =?us-ascii?Q?IGfs7vFTpl2vZx7Y3BuuCnuWsJ5st+/15L8OHZIROsM5H57WtvkOY6ei+n38?=
 =?us-ascii?Q?TkGnUd0ecLIyUjcmLjmGnr2MSPDBUAacUQG6UqnTa3RHeupvOJsGA8+D/3vY?=
 =?us-ascii?Q?Qb2OXcpjPjZmEzca5Iv5niPjHOl5fiCSDOg2iRotojIS/qiwbnvjeNuFp/BF?=
 =?us-ascii?Q?b5Kau50Yv/ZCuEm3PCokFfhHgvOaRl/klhuqrzBg6p/xw7IrlT7ltiCnT3hu?=
 =?us-ascii?Q?dHgcGbIGJ91176/eTdjxQtRitQFXvEjCsaAmZwPAxkPKlWXSt2xevt+2u+Un?=
 =?us-ascii?Q?AY1GhjxmRqugEZLrgwaBUiowvqafDwwj5tKzUCa472FmkB1rz7gM5J52nWXC?=
 =?us-ascii?Q?R/gyeEWrv8IkR5c6qGyjwn6YNSwtIm2pwEVwR9Y6+tAjBuNnMFam3njvXuU5?=
 =?us-ascii?Q?htXkDDkYxpO84K7mN4Y/HJ2MdoxJvPgHnbPGwGEgOkTVNSD2RfjUPePQ7w40?=
 =?us-ascii?Q?ZTh+u6egPEzFwQLuEfgMTJh2X2+En0yT7WvBPbKawI7bm+XI+G8JVRPkM+gg?=
 =?us-ascii?Q?TzZdmhxWG5IpZe2UIUzHY+BnQtaUi+9eszOZr7337cWCWmcAKy3J7wzQpEIY?=
 =?us-ascii?Q?8/s4PZ901slEz5EzZHpTdOAo7l0xCtTYHoYspOAGvrIq3yorEu3qIVXSL4eK?=
 =?us-ascii?Q?PWA74jvReqUiC+fGw/BFXExZFhKxovj40i+u8fy7+8uH9wu8aJcZ+Zv7m2SQ?=
 =?us-ascii?Q?JxEL8V396rXZYEdMLn7rAJoe45hi+mQ+VW0Nl8jltj2YgrdMDL4vP9BtlU1/?=
 =?us-ascii?Q?Y8Thym6+FctPz7QNoaMMYhlnqZkGmz336CixN0Vfqbc1tBnmt7O9sulRtvNX?=
 =?us-ascii?Q?SwwWHSdJyiUBvw+sKZkva4oJ5Xp5hRkKExXn5iEoc/SOMr0E0Jd2v4hA7tAc?=
 =?us-ascii?Q?PJPDkbh5vH3prCmksSOfi0riKi/aeVhx5YkPnNeQ5bJmpKMWoMM5ESevO3M4?=
 =?us-ascii?Q?KSvkA/ikCoVVIDU/cvaLQd4MZvluZefTJw8RCO1vT4D6HyrYtD3MGV4YxBgS?=
 =?us-ascii?Q?wSRiVpzO8u2aT4Ksix1y+/+a7A3Itk0/6K4P4MzmhScz1T8FeOsrLzKgxeu2?=
 =?us-ascii?Q?qohd1rsc+pxPxbW71XhanmLyDbFNaLQLxNBLDn2QXQ4/pg5nliNNHfDk+rdk?=
 =?us-ascii?Q?7Lk3lVUorAvymI02paF8wxP/s5hKcUeq6q8RIW0ADObLmRAiKMzOCxzT3e9i?=
 =?us-ascii?Q?hVRm/VTB2l7G1fmh/Hj6U+r5HuGWO7q3qpNb9nkdrCauDddY1/LjbNm4e2Hn?=
 =?us-ascii?Q?mkb57DFV+mMRRzizi6a/l/bzb8QCc9Aj7ZIZ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vykXy5eEYDvx+H46kQgikglhKe7edAiN5tpBrbtWgOkV6pajOsbtv8nTdH4xBMCz7b5kpO30qe217RukS1Xms2A2iFkfYGo7UhgBZnTamU7DHDNKjkcxWrtI1g2sThPqetMbyxVhghvVpnzJDPwxFRSWx15PMEGJNyUMKqTy6QrjrnV4Yb37y4zvogE71AUZd7fFZvf4IvnwhYN12sCQt9G/JEg/r29mwwC+vcSxUTZBoZsK9QOZySUOd8q/+BRvPl1lMoeZJoGNleJgQpi/eTyop75ES4j0if4zlkPS9Q76ASQ6Wcg6u/NCl7gn81N7ubMd/d8dvIJ5w5tSrWtK66MyImjRiIXGB6sPmqt1mTc0r22GjfKclxhgIywfBurXv9QWdN63ujDalmcm6jB8QhNBkkYIs9+UiW5PzJn9t3qkA9mdV4h8Xld/GNuZKIw39TFCiKmEiWnlGnyVuHh1zvh4woFKgfR8s+ESyEnjI37bSctXk2vmo8x3ZmyTtbf/uJzK2aNpwX2yjvT0K4Nre33JJiEJ+Ug8kqnmgs3A6cSiPRLNjbMx4iooFrxTJEuZsTS+2wnmeGhR8uh6PruLwbB/dqx8N+32ZzJXtmoT2LFsuIh64SFBFSvXgnV6NRheNrAIZOROXm8Depn9LzWuSA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:20.5120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35497f56-562c-43f8-7a36-08dd8ba4510a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1901
X-BESS-ID: 1746429202-311599-7746-352-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGhkYGQGYGUNQ8JTklMSU5yc
 IozTDV3NzSIMXE0NgyJdnAzNTMKNE0Wak2FgAgC46PQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan18-155.eu-central-1b.ess.aws.cudaops.com]
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

Remove unused CRC calculation and simplify AVR probe logging.
The condition is always false.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/core/nthw_fpga.c | 299 +-----------------------
 1 file changed, 11 insertions(+), 288 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 8831eeb4d3..485e912912 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -152,26 +152,6 @@ int nthw_fpga_silabs_detect(nthw_fpga_t *p_fpga, const int n_instance_no, const
 	return res;
 }
 
-/*
- * Calculate CRC-16-CCITT of passed data
- * CRC-16-CCITT ^16 + ^12 + ^5 + 1 (0x1021) (X.25, HDLC, XMODEM, Bluetooth,
- *   SD, many others; known as CRC-CCITT)
- */
-static uint16_t crc16(uint8_t *buffer, size_t length)
-{
-	uint16_t seed = 0;
-
-	while (length--) {
-		seed = (uint16_t)(seed >> 8 | seed << 8);
-		seed = (uint16_t)(seed ^ *buffer++);
-		seed = (uint16_t)(seed ^ (seed & 0xff) >> 4);
-		seed = (uint16_t)(seed ^ seed << 8 << 4);
-		seed = (uint16_t)(seed ^ (seed & 0xff) << 4 << 1);
-	}
-
-	return seed;
-}
-
 int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no)
 {
 	struct fpga_info_s *p_fpga_info = p_fpga->p_fpga_info;
@@ -314,150 +294,15 @@ int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no)
 		rx_buf.p_buf = &rx_data;
 		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SYSINFO_2, &tx_buf, &rx_buf);
 
-		if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 && rx_buf.size >= 16) {
-			if (rx_buf.size != 16) {
-				NT_LOG(WRN, NTHW,
-					"%s: AVR%d: SYSINFO2: reply is larger than expected: %04X %04X",
-					p_adapter_id_str, n_instance_no, rx_buf.size, 16);
-
-			} else {
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO2: OK: res=%d sz=%d",
-					p_adapter_id_str, n_instance_no, res, rx_buf.size);
-			}
-
-			avr_vpd_info.sysinfo_container_version = rx_data[0];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO_REQ_VER: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_container_version);
-
-			memcpy(&avr_vpd_info.sysinfo_avr_libc_version, &rx_data[0 + 1],
-				sizeof(avr_vpd_info.sysinfo_avr_libc_version));
-			NT_LOG(DBG, NTHW, "%s: AVR%d: LIBC_VER: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_avr_libc_version);
-
-			avr_vpd_info.sysinfo_signature_0 = rx_data[5];
-			avr_vpd_info.sysinfo_signature_1 = rx_data[6];
-			avr_vpd_info.sysinfo_signature_2 = rx_data[7];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: SIGNATURE: %02x%02x%02x", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_signature_0,
-				avr_vpd_info.sysinfo_signature_1, avr_vpd_info.sysinfo_signature_2);
-
-			avr_vpd_info.sysinfo_spi_version = rx_data[8];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_spi_version);
-
-			avr_vpd_info.sysinfo_hw_revision = rx_data[9];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_hw_revision);
-
-			avr_vpd_info.sysinfo_ticks_per_second = rx_data[10];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: TICKS_PER_SEC: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_ticks_per_second);
-
-			memcpy(&avr_vpd_info.sysinfo_uptime, &rx_data[11],
-				sizeof(avr_vpd_info.sysinfo_uptime));
-			NT_LOG(DBG, NTHW, "%s: AVR%d: UPTIME: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_uptime);
-
-			avr_vpd_info.sysinfo_osccal = rx_data[15];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: OSCCAL: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_osccal);
-
-			{
-				bool b_spi_ver_match = (avr_vpd_info.n_avr_spi_version ==
-						avr_vpd_info.sysinfo_spi_version);
-				(void)b_spi_ver_match;
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER_TST: %s (%d %d)",
-					p_adapter_id_str, n_instance_no,
-					(b_spi_ver_match ? "OK" : "MISMATCH"),
-					avr_vpd_info.n_avr_spi_version,
-					avr_vpd_info.sysinfo_spi_version);
-			}
-
-			/* SYSINFO2: if response: only populate hw_id not hw_id_emulated */
-			p_fpga_info->nthw_hw_info.hw_id = avr_vpd_info.sysinfo_hw_revision;
-
-		} else {
-			/* AVR_OP_SYSINFO */
-			tx_buf.size = 0;
-			tx_buf.p_buf = NULL;
-			rx_buf.size = sizeof(rx_data);
-			rx_buf.p_buf = &rx_data;
-			res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SYSINFO, &tx_buf, &rx_buf);
-
-			if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 && rx_buf.size >= 16) {
-				if (rx_buf.size != 16) {
-					NT_LOG(WRN, NTHW,
-						"%s: AVR%d: SYSINFO: reply is larger than expected: %04X %04X",
-						p_adapter_id_str, n_instance_no, rx_buf.size, 16);
-
-				} else {
-					NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO: OK: res=%d sz=%d",
-						p_adapter_id_str, n_instance_no, res, rx_buf.size);
-				}
-
-				avr_vpd_info.sysinfo_container_version = rx_data[0];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO_REQ_VER: %d",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.sysinfo_container_version);
-
-				memcpy(&avr_vpd_info.sysinfo_avr_libc_version, &rx_data[0 + 1],
-					sizeof(avr_vpd_info.sysinfo_avr_libc_version));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: LIBC_VER: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_avr_libc_version);
-
-				avr_vpd_info.sysinfo_signature_0 = rx_data[5];
-				avr_vpd_info.sysinfo_signature_1 = rx_data[6];
-				avr_vpd_info.sysinfo_signature_2 = rx_data[7];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SIGNATURE: %02x%02x%02x",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.sysinfo_signature_0,
-					avr_vpd_info.sysinfo_signature_1,
-					avr_vpd_info.sysinfo_signature_2);
-
-				avr_vpd_info.sysinfo_spi_version = rx_data[8];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_spi_version);
-
-				avr_vpd_info.sysinfo_hw_revision = rx_data[9];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_hw_revision);
-				NT_LOG(INF, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_hw_revision);
-
-				avr_vpd_info.sysinfo_ticks_per_second = rx_data[10];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: TICKS_PER_SEC: %d",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.sysinfo_ticks_per_second);
-
-				memcpy(&avr_vpd_info.sysinfo_uptime, &rx_data[11],
-					sizeof(avr_vpd_info.sysinfo_uptime));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: UPTIME: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_uptime);
-
-				avr_vpd_info.sysinfo_osccal = rx_data[15];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: OSCCAL: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_osccal);
-
-				{
-					bool b_spi_ver_match = (avr_vpd_info.n_avr_spi_version ==
-							avr_vpd_info.sysinfo_spi_version);
-					(void)b_spi_ver_match;
-					NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER_TST: %s (%d %d)",
-						p_adapter_id_str, n_instance_no,
-						(b_spi_ver_match ? "OK" : "MISMATCH"),
-						avr_vpd_info.n_avr_spi_version,
-						avr_vpd_info.sysinfo_spi_version);
-				}
-
-				p_fpga_info->nthw_hw_info.hw_id = avr_vpd_info.sysinfo_hw_revision;
-				p_fpga_info->nthw_hw_info.hw_id_emulated =
-					avr_vpd_info.sysinfo_hw_revision;
+		/* AVR_OP_SYSINFO */
+		tx_buf.size = 0;
+		tx_buf.p_buf = NULL;
+		rx_buf.size = sizeof(rx_data);
+		rx_buf.p_buf = &rx_data;
+		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SYSINFO, &tx_buf, &rx_buf);
 
-			} else {
-				NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO: NA: res=%d sz=%d",
-					p_adapter_id_str, n_instance_no, res, rx_buf.size);
-			}
-		}
+		NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO: NA: res=%d sz=%d",
+				p_adapter_id_str, n_instance_no, res, rx_buf.size);
 
 		/* AVR_OP_VPD_READ */
 		tx_buf.size = 0;
@@ -466,132 +311,10 @@ int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no)
 		rx_buf.p_buf = &rx_data;
 		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_VPD_READ, &tx_buf, &rx_buf);
 
-		if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 &&
-			rx_buf.size >= GEN2_VPD_SIZE_TOTAL) {
-			avr_vpd_info.n_crc16_calced = crc16(rx_buf.p_buf, rx_buf.size - 2);
-			memcpy(&avr_vpd_info.n_crc16_stored, &rx_data[rx_buf.size - 2],
-				sizeof(avr_vpd_info.n_crc16_stored));
-			NT_LOG(DBG, NTHW, "%s: AVR%d: VPD_CRC: %04X %04X", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.n_crc16_stored,
-				avr_vpd_info.n_crc16_calced);
-
-			avr_vpd_info.b_crc16_valid =
-				(avr_vpd_info.n_crc16_stored == avr_vpd_info.n_crc16_calced);
-			NT_LOG(DBG, NTHW, "%s: AVR%d: CRC_TST: %s", p_adapter_id_str,
-				n_instance_no, (avr_vpd_info.b_crc16_valid ? "OK" : "ERROR"));
-
-			if (avr_vpd_info.b_crc16_valid) {
-				memcpy(&avr_vpd_info.psu_hw_version, &rx_data[0],
-					sizeof(avr_vpd_info.psu_hw_version));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: PSU_HW_VER: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.psu_hw_version);
-
-				memcpy(&avr_vpd_info.vpd_pn, &rx_data[0 + 1],
-					sizeof(avr_vpd_info.vpd_pn));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: PN: '%.*s'", p_adapter_id_str,
-					n_instance_no, GEN2_PN_SIZE, avr_vpd_info.vpd_pn);
-
-				memcpy(&avr_vpd_info.vpd_pba, &rx_data[0 + 1 + GEN2_PN_SIZE],
-					sizeof(avr_vpd_info.vpd_pba));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: PBA: '%.*s'", p_adapter_id_str,
-					n_instance_no, GEN2_PBA_SIZE, avr_vpd_info.vpd_pba);
-
-				memcpy(&avr_vpd_info.vpd_sn,
-					&rx_data[0 + 1 + GEN2_PN_SIZE + GEN2_PBA_SIZE],
-					sizeof(avr_vpd_info.vpd_sn));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SN: '%.*s", p_adapter_id_str,
-					n_instance_no, GEN2_SN_SIZE, avr_vpd_info.vpd_sn);
-
-				memcpy(&avr_vpd_info.vpd_board_name,
-					&rx_data[0 + 1 + GEN2_PN_SIZE + GEN2_PBA_SIZE +
-						GEN2_SN_SIZE],
-					sizeof(avr_vpd_info.vpd_board_name));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: BN: '%.*s'", p_adapter_id_str,
-					n_instance_no, GEN2_BNAME_SIZE,
-					avr_vpd_info.vpd_board_name);
-
-				union mac_u {
-					uint8_t a_u8[8];
-					uint16_t a_u16[4];
-					uint32_t a_u32[2];
-					uint64_t a_u64[1];
-				} mac;
-
-				/* vpd_platform_section */
-				uint8_t *p_vpd_board_info =
-					(uint8_t *)(&rx_data[1 + GEN2_PN_SIZE + GEN2_PBA_SIZE +
-					GEN2_SN_SIZE + GEN2_BNAME_SIZE]);
-				memcpy(&avr_vpd_info.product_family, &p_vpd_board_info[0],
-					sizeof(avr_vpd_info.product_family));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: PROD_FAM: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.product_family);
-
-				memcpy(&avr_vpd_info.feature_mask, &p_vpd_board_info[0 + 4],
-					sizeof(avr_vpd_info.feature_mask));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_VAL: 0x%08X",
-					p_adapter_id_str, n_instance_no, avr_vpd_info.feature_mask);
-
-				memcpy(&avr_vpd_info.invfeature_mask, &p_vpd_board_info[0 + 4 + 4],
-					sizeof(avr_vpd_info.invfeature_mask));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_INV: 0x%08X",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.invfeature_mask);
-
-				avr_vpd_info.b_feature_mask_valid =
-					(avr_vpd_info.feature_mask ==
-						~avr_vpd_info.invfeature_mask);
-				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_TST: %s", p_adapter_id_str,
-					n_instance_no,
-					(avr_vpd_info.b_feature_mask_valid ? "OK" : "ERROR"));
-
-				memcpy(&avr_vpd_info.no_of_macs, &p_vpd_board_info[0 + 4 + 4 + 4],
-					sizeof(avr_vpd_info.no_of_macs));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: NUM_MACS: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.no_of_macs);
-
-				memcpy(&avr_vpd_info.mac_address,
-					&p_vpd_board_info[0 + 4 + 4 + 4 + 1],
-					sizeof(avr_vpd_info.mac_address));
-				NT_LOG(DBG, NTHW,
-					"%s: AVR%d: MAC_ADDR: %02x:%02x:%02x:%02x:%02x:%02x",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.mac_address[0], avr_vpd_info.mac_address[1],
-					avr_vpd_info.mac_address[2], avr_vpd_info.mac_address[3],
-					avr_vpd_info.mac_address[4], avr_vpd_info.mac_address[5]);
-
-				mac.a_u64[0] = 0;
-				memcpy(&mac.a_u8[2], &avr_vpd_info.mac_address,
-					sizeof(avr_vpd_info.mac_address));
-				{
-					const uint32_t u1 = ntohl(mac.a_u32[0]);
-
-					if (u1 != mac.a_u32[0]) {
-						const uint32_t u0 = ntohl(mac.a_u32[1]);
-						mac.a_u32[0] = u0;
-						mac.a_u32[1] = u1;
-					}
-				}
-
-				avr_vpd_info.n_mac_val = mac.a_u64[0];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: MAC_U64: %012" PRIX64 "",
-					p_adapter_id_str, n_instance_no, avr_vpd_info.n_mac_val);
-			}
-
-			p_fpga_info->nthw_hw_info.vpd_info.mn_mac_addr_count =
-				avr_vpd_info.no_of_macs;
-			p_fpga_info->nthw_hw_info.vpd_info.mn_mac_addr_value =
-				avr_vpd_info.n_mac_val;
-			memcpy(p_fpga_info->nthw_hw_info.vpd_info.ma_mac_addr_octets,
-				avr_vpd_info.mac_address,
-				ARRAY_SIZE(p_fpga_info->nthw_hw_info.vpd_info.ma_mac_addr_octets));
-
-		} else {
-			NT_LOG(ERR, NTHW, "%s:%u: res=%d", __func__, __LINE__, res);
-			NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO2: NA: res=%d sz=%d",
-				p_adapter_id_str, n_instance_no, res, rx_buf.size);
-		}
+		NT_LOG(ERR, NTHW, "%s:%u: res=%d", __func__, __LINE__, res);
+		NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO2: NA: res=%d sz=%d",
+			p_adapter_id_str, n_instance_no, res, rx_buf.size);
 	}
-
 	return res;
 }
 
-- 
2.47.1

