Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F8BC7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 11:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DDFC42EE6;
	Fri, 20 Jun 2025 13:27:39 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 0791C42ED8
 for <dev@dpdk.org>; Fri, 20 Jun 2025 13:27:36 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021091.outbound.protection.outlook.com
 [40.107.130.91]) by mx-outbound9-227.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Jun 2025 11:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZTEmTknWEFVBdBBPZq94aHm+zeOmYyPwD2qI+4t6YsvUqkjNOU51ZCx6Ie9WxGmx6Hj2jTdVANRa0oJ7dVBwTxbukvEZ6Nt72BqjG0LejF1Io58gGOqknWg+DSBSqPxV0a5rgLAZRsypR5iauwoPxo/7SlCCb6WppE5jylwOcYmVyOXiyLIXPbNLhuoY/p2aCGnXd+p7Vte4tl7OzxC7irDJtUPV7XjoO0m9nz2hNmMUOhwiqWC1ShCd5cQlPx5tmpD//7gsyCTMIO6lI874lLMU4Wx8B/3In6jpVcm0dqHn8t0BL+4jc1XBNq36zLgzKf5bu6A4TftoRZXfJKolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUTCpY4yZziIjbN55ZSG6cP1tCwFou85ePCtDpopvAA=;
 b=FeqY+3jPam3vWCTBrT8b2gjteDpFb3brCT9pl2O2PbmtGz5GcdsINKffygi7kWMT0I0x4h3GLz0CFX2/3F7MCJIkOhQ1Zgk0BUpdQoq8daKmZzz040wMjoX0Y9hJ3YQRgBbrwCQxvEDT33a9hTVdt13+41KHz7kC+FkkS9CSYeUaQWdGuK4P3mDQYD3NE19e+QB87kLU8DNDjKuqVtenH5grJSDReQQCV2gORMfaanspcZkYSQ8WeWiZHrcKyOJrJc/QWcy2jfyZBZ4Ree0Nt2eI8MgHOIbuLeRBf01Oly2tx/PSpFPx3KWcAt/HWgz3dYE/jzPlxLmtJ6LvYyTbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUTCpY4yZziIjbN55ZSG6cP1tCwFou85ePCtDpopvAA=;
 b=LV+v1tX9/ndYntCMKK1+LQUwbswEmMJ6J33R/EdNO4v+AmydZLvGskcKhdTHhhhAAG4MUZmHiDC/I+d9h5KFdZILNxqtgeuKj+bm68X5N6WTaRqgwbb+BoSLaM7q8r7tkBCFymtt0S+svcGXyl4kvxBCYH09usIQpNiZ9i/ZvK8=
Received: from DUZPR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::9) by PA4P190MB1264.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 11:27:33 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::f7) by DUZPR01CA0005.outlook.office365.com
 (2603:10a6:10:3c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 11:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server id 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025
 11:27:32 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 2/4] net/ntnic: implement deferred start for Rx/Tx queues
Date: Fri, 20 Jun 2025 13:27:05 +0200
Message-ID: <20250620112707.294596-3-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250620112707.294596-1-okl-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|PA4P190MB1264:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eba314cd-3958-4579-667c-08ddafed72be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qE/SBWGXnl59C/koEC2Z6hAszUgM74AkRBbFcOMyW5ad8hb4ZvIZBcqZrTqM?=
 =?us-ascii?Q?cLwBNT6uYIrDgjQl1S5qi4A/wlnAkMMmahDGRo/fOsi8exinzhDrXkjCjtlA?=
 =?us-ascii?Q?Ud/loaxyveJCIesJ/lvW/YzrU4wlIw2EBDGOXurUboHHEg0+vwMRTKDh07+W?=
 =?us-ascii?Q?ZMSsJdfA5vvULewUaLqHJi4l2AX1ircOsA4rO6Pa3WVbsfOh1MMUzCT9Xn3H?=
 =?us-ascii?Q?/2xI/5YTA95Ou53CuWXtDpkOCaIRoadh/gDf6iWEF9qOTka0Pxd8IgxvaZQs?=
 =?us-ascii?Q?tmiQ2J8W6mUzvBJZ1HpxHZyb9A1CTWRbkLpeY7ODxU8epT+Fow28DwABrUzL?=
 =?us-ascii?Q?sQX2xmEE9rKm78s6YXkWqOZPXLjUClVPGJDuDW0PW2zvgUcgn7R94BU/8Kmf?=
 =?us-ascii?Q?kP8Juk9UjRWptjv6flqYSdbsnwhYcRf9CApkMCJDyt3h/qxkDuoz7bBUIWeU?=
 =?us-ascii?Q?4J6z/RnmvSvaiKALlV8oGyv6zbjP1nWgsaWEE5v/a2MyYOZBMnprJsko33Nm?=
 =?us-ascii?Q?xa3uKpm8L0GHpn0lT2cDd6lV8n+2s8FCdMwztmgMPho5LZQKPFw28o8NFx6I?=
 =?us-ascii?Q?+P65eE2Mlhmr+kDVzA6EHFWprnIf1GzKZDgumaxY68cpKYYLix2oPPcDHjRq?=
 =?us-ascii?Q?ppTRszzyECb9OCgPnVuI1ikcJ1Bl4s751PrGl2Km4teISjNMEcXMhPGTZ8rl?=
 =?us-ascii?Q?vwWgG0nGMHXhkan1UG8Wj2wr34GHWllFm3FOu7x25e2B3+s6foj2O4nDmqkj?=
 =?us-ascii?Q?ktF3zS/Yr3V80403W0PECV226vZLKPfUa91PF5NWDMJaYlTA8CfhsSXwoGGl?=
 =?us-ascii?Q?Zm+a3kulDU7xDvqgEnocEIjKiGlY3hoRLRbUdlS/MpB5kfLUd47r/zpBA8z+?=
 =?us-ascii?Q?d5k20wwPNvMCYsiAV2O31hsjleoS21r210OL/MuGaR64yWsDLfNdGVXFJNSJ?=
 =?us-ascii?Q?bFAk5pgAtLola38DHwoU+wd4tJaXV0Az22gtWlmCMCkCXTcnzh8yIswsFI/X?=
 =?us-ascii?Q?6EkSDri4MnRiVVSuuJjX/vlMLgA2FYPKvi2FUMYhd7U7YalqS7bfIStzQQHK?=
 =?us-ascii?Q?l8FB+4vgukuVzcCnhpombdh2EI8OgLRD8Ue7cgG8d+cq+pWahWtIFkLF8MO+?=
 =?us-ascii?Q?JbF1iJox4OlK8tJeeTCGB95OKniMUgdfpjds5cdd7brHOpWJW4U/ZiuToCUe?=
 =?us-ascii?Q?han027kp5Z2YImoL6PVuJJw4oeAbr928bvKSLFrEScONv0en6WqB30ba9whY?=
 =?us-ascii?Q?9gBfnYxv/GEXOPaD8PY+Lp741eynMfXZur68ZnZQUkq72l8IbCLcI78n6Qmi?=
 =?us-ascii?Q?zIJnS+0KH7lD+R+dvqERsVR7PLIRoDhI5rn7HVyyARIRWprgZ7i4mvpMGGBa?=
 =?us-ascii?Q?O+ODsRU/kT0yYmtTM8x2Wfb1Vv3/6dA76qapVRYE7qsQ+SNK32Pf07EdcK4Q?=
 =?us-ascii?Q?z00l0UoeCA8M+BlRwX/Yx3iOCI+fTRXgRjCyk9y6rflQCNbub1qhtE/yJOB6?=
 =?us-ascii?Q?QfG3GvUCn6bjkeEbkfj8ARphqoB4AUMVZLaF?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /OXLknH70rmyBHD7ydHE2gEVSVfZrPcdLxr3T75iksDzERWsswo0qQDCUBmqiO++yulVBMywvsFXI07Z8SxfFRxw6E6ePE/rsR93GQgQ65BDKjhpE0P0hKB2vOpEeeDILm6TPnm2vzsO/XHzkgqwb716odi+TC6+bkXJicAvEMhyF1zIv63KZ1aEMw4us854MftQkjmLf7I7P/KnbiLYzuCcXZltwamyoqO8I3+RehxxRwBgiWrq2ao0QSOZQd1qmKtQNfTOXzXBDWufFJIKwROHA7BRN2kH7BXA6PMVkYyawCHfnpE/u3MFNGtK6PHHQ8q6Cg8JMJTrA1PL3v1dRNunBZpBLCZnxrF+AOkvG+mE1rrz5TIyFoMJWQItF4RiNuqtcOnFUlnrKMGBYyGMyAH1i9xoZsAlHrvkjYaKdAUxjb/Oj4XvAPbMzr9q/BuS1EBrQEfHSDFHKhQEPgh8SQx/s44MZRJpxsvF3C9LgMi9R6UqrLBApiw+ZwUQrc92VfrlEUhA/8taDQJZoYHfaDrxmH+2QJYPh6D1unO8vv6vsjco+uHFPJcHTwkG5HsSRY+lGHlARUULfVuivBCnK6874c62VRt5qi9iLzeocGUDKt5399JoZPYq/rFaCh9wXGM1K4h1iVS7R2UWEIIlfWqG2i5P0Ar1dV8ze+RopDI=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 11:27:32.2248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba314cd-3958-4579-667c-08ddafed72be
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1264
X-BESS-ID: 1750418854-302531-7650-16394-1
X-BESS-VER: 2019.1_20250611.1405
X-BESS-Apparent-Source-IP: 40.107.130.91
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGBubmQGYGUDTF3CDN1Ngk1T
 QpzcLcIiUxMSXRwjLVwsLYNNEwKcnEVKk2FgABaDN9QgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265470 [from 
 cloudscan11-156.eu-central-1a.ess.aws.cudaops.com]
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

Handle rx_deferred_start and tx_deferred_start flags
during configuration done in rx_queue_setup and tx_queue_setup,
so that marked queues do not start with dev_start.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 46 +++++++++++--------
 drivers/net/ntnic/include/ntos_drv.h          |  3 +-
 drivers/net/ntnic/ntnic_ethdev.c              | 22 +++++----
 drivers/net/ntnic/ntnic_mod_reg.h             | 12 +++--
 4 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 0b049a8559..107fe91394 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -369,7 +369,8 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	uint32_t host_id,
 	uint32_t header,
 	uint32_t vq_type,
-	int irq_vector)
+	int irq_vector,
+	uint8_t rx_deferred_start)
 {
 	uint32_t qs = dbs_qsize_log2(queue_size);
 	uint32_t int_enable;
@@ -430,7 +431,8 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 * 2. Configure the DBS.RX_AM_DATA memory and enable the queues you plan to use;
 	 *  good idea to initialize all DBS_RX_QUEUES entries.
 	 */
-	if (set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, RX_AM_ENABLE,
+	uint32_t enable = rx_deferred_start ? RX_AM_DISABLE : RX_AM_ENABLE;
+	if (set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, enable,
 			host_id, 0, irq_vector >= 0 ? 1 : 0) != 0) {
 		return NULL;
 	}
@@ -698,7 +700,8 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	uint32_t header,
 	uint32_t vq_type,
 	int irq_vector,
-	uint32_t in_order)
+	uint32_t in_order,
+	uint8_t tx_deferred_start)
 {
 	uint32_t int_enable;
 	uint32_t vec;
@@ -760,8 +763,9 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 *            kernel).
 	 */
 	if (irq_vector < 0) {
+		uint32_t enable = tx_deferred_start ? TX_AM_DISABLE : TX_AM_ENABLE;
 		if (set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
-				TX_AM_ENABLE, host_id, 0, 0) != 0) {
+				enable, host_id, 0, 0) != 0) {
 			return NULL;
 		}
 	}
@@ -794,7 +798,8 @@ nthw_setup_mngd_rx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 	uint32_t header,
 	struct nthw_memory_descriptor *p_virt_struct_area,
 	struct nthw_memory_descriptor *p_packet_buffers,
-	int irq_vector)
+	int irq_vector,
+	uint8_t rx_deferred_start)
 {
 	struct virtq_struct_layout_s virtq_struct_layout = dbs_calc_struct_layout(queue_size);
 
@@ -831,7 +836,7 @@ nthw_setup_mngd_rx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 		virtq_struct_layout.used_offset,
 		(char *)p_virt_struct_area->phys_addr +
 		virtq_struct_layout.desc_offset,
-		(uint16_t)queue_size, host_id, header, SPLIT_RING, irq_vector);
+		(uint16_t)queue_size, host_id, header, SPLIT_RING, irq_vector, rx_deferred_start);
 
 	rxvq[index].usage = NTHW_VIRTQ_MANAGED;
 
@@ -849,7 +854,8 @@ nthw_setup_mngd_tx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 	int irq_vector,
 	uint32_t in_order,
 	struct nthw_memory_descriptor *p_virt_struct_area,
-	struct nthw_memory_descriptor *p_packet_buffers)
+	struct nthw_memory_descriptor *p_packet_buffers,
+	uint8_t tx_deferred_start)
 {
 	struct virtq_struct_layout_s virtq_struct_layout = dbs_calc_struct_layout(queue_size);
 
@@ -889,7 +895,7 @@ nthw_setup_mngd_tx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 		(char *)p_virt_struct_area->phys_addr +
 		virtq_struct_layout.desc_offset,
 		(uint16_t)queue_size, host_id, port, virtual_port, header,
-		SPLIT_RING, irq_vector, in_order);
+		SPLIT_RING, irq_vector, in_order, tx_deferred_start);
 
 	txvq[index].usage = NTHW_VIRTQ_MANAGED;
 
@@ -977,7 +983,8 @@ nthw_setup_managed_rx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 	uint32_t header,
 	struct nthw_memory_descriptor *p_virt_struct_area,
 	struct nthw_memory_descriptor *p_packet_buffers,
-	int irq_vector)
+	int irq_vector,
+	uint8_t rx_deferred_start)
 {
 	struct pvirtq_struct_layout_s pvirtq_layout;
 	struct nthw_virt_queue *vq = &rxvq[index];
@@ -996,7 +1003,7 @@ nthw_setup_managed_rx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 		(void *)((uintptr_t)p_virt_struct_area->phys_addr +
 			pvirtq_layout.device_event_offset),
 		p_virt_struct_area->phys_addr, (uint16_t)queue_size, host_id,
-		header, PACKED_RING, irq_vector);
+		header, PACKED_RING, irq_vector, rx_deferred_start);
 
 	vq->usage = NTHW_VIRTQ_MANAGED;
 	return vq;
@@ -1013,7 +1020,8 @@ nthw_setup_managed_tx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 	int irq_vector,
 	uint32_t in_order,
 	struct nthw_memory_descriptor *p_virt_struct_area,
-	struct nthw_memory_descriptor *p_packet_buffers)
+	struct nthw_memory_descriptor *p_packet_buffers,
+	uint8_t tx_deferred_start)
 {
 	struct pvirtq_struct_layout_s pvirtq_layout;
 	struct nthw_virt_queue *vq = &txvq[index];
@@ -1030,7 +1038,7 @@ nthw_setup_managed_tx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 		(void *)((uintptr_t)p_virt_struct_area->phys_addr +
 			pvirtq_layout.device_event_offset),
 		p_virt_struct_area->phys_addr, (uint16_t)queue_size, host_id,
-		port, virtual_port, header, PACKED_RING, irq_vector, in_order);
+		port, virtual_port, header, PACKED_RING, irq_vector, in_order, tx_deferred_start);
 
 	vq->usage = NTHW_VIRTQ_MANAGED;
 	return vq;
@@ -1052,18 +1060,19 @@ nthw_setup_mngd_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	struct nthw_memory_descriptor *p_virt_struct_area,
 	struct nthw_memory_descriptor *p_packet_buffers,
 	uint32_t vq_type,
-	int irq_vector)
+	int irq_vector,
+	uint8_t rx_deferred_start)
 {
 	switch (vq_type) {
 	case SPLIT_RING:
 		return nthw_setup_mngd_rx_virt_queue_split(p_nthw_dbs, index, queue_size,
 				host_id, header, p_virt_struct_area,
-				p_packet_buffers, irq_vector);
+				p_packet_buffers, irq_vector, rx_deferred_start);
 
 	case PACKED_RING:
 		return nthw_setup_managed_rx_virt_queue_packed(p_nthw_dbs, index, queue_size,
 				host_id, header, p_virt_struct_area,
-				p_packet_buffers, irq_vector);
+				p_packet_buffers, irq_vector, rx_deferred_start);
 
 	default:
 		break;
@@ -1091,7 +1100,8 @@ nthw_setup_mngd_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	struct nthw_memory_descriptor *p_packet_buffers,
 	uint32_t vq_type,
 	int irq_vector,
-	uint32_t in_order)
+	uint32_t in_order,
+	uint8_t tx_deferred_start)
 {
 	switch (vq_type) {
 	case SPLIT_RING:
@@ -1099,14 +1109,14 @@ nthw_setup_mngd_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 				host_id, port, virtual_port, header,
 				irq_vector, in_order,
 				p_virt_struct_area,
-				p_packet_buffers);
+				p_packet_buffers, tx_deferred_start);
 
 	case PACKED_RING:
 		return nthw_setup_managed_tx_virt_queue_packed(p_nthw_dbs, index, queue_size,
 				host_id, port, virtual_port, header,
 				irq_vector, in_order,
 				p_virt_struct_area,
-				p_packet_buffers);
+				p_packet_buffers, tx_deferred_start);
 
 	default:
 		break;
diff --git a/drivers/net/ntnic/include/ntos_drv.h b/drivers/net/ntnic/include/ntos_drv.h
index f6ce442d17..cef3c5c277 100644
--- a/drivers/net/ntnic/include/ntos_drv.h
+++ b/drivers/net/ntnic/include/ntos_drv.h
@@ -69,7 +69,7 @@ struct __rte_cache_aligned ntnic_rx_queue {
 	nt_meta_port_type_t type;
 	uint32_t port;     /* Rx port for this queue */
 	enum fpga_info_profile profile;  /* Inline / Capture */
-
+	uint8_t rx_deferred_start;
 };
 
 struct __rte_cache_aligned ntnic_tx_queue {
@@ -89,6 +89,7 @@ struct __rte_cache_aligned ntnic_tx_queue {
 	unsigned long err_pkts;	/* Tx error packet stat */
 	int  enabled;  /* Enabling/disabling of this queue */
 	enum fpga_info_profile profile;  /* Inline / Capture */
+	uint8_t tx_deferred_start;
 };
 
 struct nt_mtr_profile {
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d961edb903..d875e7c236 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -995,7 +995,7 @@ static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 	uint16_t rx_queue_id,
 	uint16_t nb_rx_desc __rte_unused,
 	unsigned int socket_id __rte_unused,
-	const struct rte_eth_rxconf *rx_conf __rte_unused,
+	const struct rte_eth_rxconf *rx_conf,
 	struct rte_mempool *mb_pool)
 {
 	NT_LOG_DBGX(DBG, NTNIC, "Rx queue setup");
@@ -1029,7 +1029,8 @@ static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 
 	mbp_priv = rte_mempool_get_priv(rx_q->mb_pool);
 	rx_q->buf_size = (uint16_t)(mbp_priv->mbuf_data_room_size - RTE_PKTMBUF_HEADROOM);
-	rx_q->enabled = 1;
+	rx_q->enabled = !rx_conf->rx_deferred_start;
+	rx_q->rx_deferred_start = rx_conf->rx_deferred_start;
 
 	if (allocate_hw_virtio_queues(eth_dev, EXCEPTION_PATH_HID, &rx_q->hwq,
 			SG_NB_HW_RX_DESCRIPTORS, SG_HW_RX_PKT_BUFFER_SIZE) < 0)
@@ -1048,7 +1049,8 @@ static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 			&rx_q->hwq.virt_queues_ctrl,
 			rx_q->hwq.pkt_buffers,
 			SPLIT_RING,
-			-1);
+			-1,
+			rx_conf->rx_deferred_start);
 
 	NT_LOG(DBG, NTNIC, "(%" PRIu32 ") NTNIC RX OVS-SW queues successfully setup",
 		internals->port);
@@ -1060,7 +1062,7 @@ static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 	uint16_t tx_queue_id,
 	uint16_t nb_tx_desc __rte_unused,
 	unsigned int socket_id __rte_unused,
-	const struct rte_eth_txconf *tx_conf __rte_unused)
+	const struct rte_eth_txconf *tx_conf)
 {
 	const struct port_ops *port_ops = get_port_ops();
 
@@ -1141,9 +1143,11 @@ static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 			tx_q->hwq.pkt_buffers,
 			SPLIT_RING,
 			-1,
-			IN_ORDER);
+			IN_ORDER,
+			tx_conf->tx_deferred_start);
 
-	tx_q->enabled = 1;
+	tx_q->enabled = !tx_conf->tx_deferred_start;
+	tx_q->tx_deferred_start = tx_conf->tx_deferred_start;
 
 	NT_LOG(DBG, NTNIC, "(%" PRIu32 ") NTNIC TX OVS-SW queues successfully setup",
 		internals->port);
@@ -1365,10 +1369,12 @@ eth_dev_start(struct rte_eth_dev *eth_dev)
 	uint q;
 
 	for (q = 0; q < internals->nb_rx_queues; q++)
-		eth_rx_queue_start(eth_dev, q);
+		if (!internals->rxq_scg[q].rx_deferred_start)
+			eth_rx_queue_start(eth_dev, q);
 
 	for (q = 0; q < internals->nb_tx_queues; q++)
-		eth_tx_queue_start(eth_dev, q);
+		if (!internals->txq_scg[q].tx_deferred_start)
+			eth_tx_queue_start(eth_dev, q);
 
 	if (internals->type == PORT_TYPE_VIRTUAL || internals->type == PORT_TYPE_OVERRIDE) {
 		eth_dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 7f5bd5e0ec..26efec1c65 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -37,7 +37,8 @@ struct sg_ops_s {
 		uint32_t host_id,
 		uint32_t header,
 		uint32_t vq_type,
-		int irq_vector);
+		int irq_vector,
+		uint8_t rx_deferred_start);
 	struct nthw_virt_queue *(*nthw_setup_tx_virt_queue)(nthw_dbs_t *p_nthw_dbs,
 		uint32_t index,
 		uint16_t start_idx,
@@ -52,7 +53,8 @@ struct sg_ops_s {
 		uint32_t header,
 		uint32_t vq_type,
 		int irq_vector,
-		uint32_t in_order);
+		uint32_t in_order,
+		uint8_t tx_deferred_start);
 	struct nthw_virt_queue *(*nthw_setup_mngd_rx_virt_queue)(nthw_dbs_t *p_nthw_dbs,
 		uint32_t index,
 		uint32_t queue_size,
@@ -70,7 +72,8 @@ struct sg_ops_s {
 		 */
 		struct nthw_memory_descriptor *p_packet_buffers,
 		uint32_t vq_type,
-		int irq_vector);
+		int irq_vector,
+		uint8_t rx_deferred_start);
 	int (*nthw_release_mngd_rx_virt_queue)(struct nthw_virt_queue *rxvq);
 	struct nthw_virt_queue *(*nthw_setup_mngd_tx_virt_queue)(nthw_dbs_t *p_nthw_dbs,
 		uint32_t index,
@@ -92,7 +95,8 @@ struct sg_ops_s {
 		struct nthw_memory_descriptor *p_packet_buffers,
 		uint32_t vq_type,
 		int irq_vector,
-		uint32_t in_order);
+		uint32_t in_order,
+		uint8_t tx_deferred_start);
 	int (*nthw_release_mngd_tx_virt_queue)(struct nthw_virt_queue *txvq);
 	int (*nthw_switch_rx_virt_queue)(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable);
 	int (*nthw_switch_tx_virt_queue)(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable);
-- 
2.47.1

