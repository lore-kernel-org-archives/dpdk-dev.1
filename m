Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE8C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 10:20:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 134EA40653;
	Tue,  1 Jul 2025 12:20:41 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 8BE634064E
 for <dev@dpdk.org>; Tue,  1 Jul 2025 12:20:38 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021096.outbound.protection.outlook.com [52.101.70.96])
 by mx-outbound11-108.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 01 Jul 2025 10:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPKretEJ3DS4LVbtiZ8UDfP9nXdeq4MD/v3juudCsnean5HvRtEqgLt/2f0KcHFyRiajwj6O1B4/5Mh/CIfRyj2gf0pzbHns0j80637AiJWYXFcdU8NOPZFBTxM4jwEi8N+aYnEhVHH/92ouIUES5F6bdXkzhVWtaH1iYnULQGTyvySc/7S7dQSr0w9ABLd+UynfUenlk1QIuRNgblMvbLT9ek9hPYn6uBWxombQZkcAfEoCZbE0Rkle0mV5wYGgQmHhJLccElK1pLemyxJGK9f5wrZGmCZQ2IJ+/T3lAii9kFL6dDBB/IX2+k6orxhIi4oUV0ufSJXPsLcy94NQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3myCrqKU+bhwBlT6m19GaOTZR723MxaPBMJB8rAsyB8=;
 b=AAF0bYEMNKE4XIL56D74a1inqNto/DV/79gjYuNSyReOHs8we0nEzhQZYkjzZLRCgWk7S3LEKBaj4/eSGsyG6XCQYPvzoLrM+iWDc4AGJ5oCfEXDh3aTzw0V+KtJy5LtYkYcDOV5rQkTDt3k6gLiuqTzAq/tZ6uvs7p3q1BBj4R1Awz0V1E3srsvMjVVoF/F75wXdMnVWmLxHEakczRG0hsTJ/yuP2uV0nm/nwkNeZ+C68blp/IJo2TqWd/5+tmBW+RgIW29gkAOhfTjH99W1kZSpjYc4hvnsJyPpV5PT+JL4lxNweahJ+HuZ4OtrCT0nDrtbLLpyk8lxir0xe5ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3myCrqKU+bhwBlT6m19GaOTZR723MxaPBMJB8rAsyB8=;
 b=jRUK14c3ky/UIv9RGnVhuQvA/8+DAUVzPltx+O+ddfrfsm3Jqgu8q6T2QE6WTa3xt0nV+IUXAibQ1cY2r858rRwqS9fDvZGEj4yADbMSAIzcpFmlK/F8wEv80OuSa+WRZq7SXpBqsG7jQVMRI1zCLB5uE+FsroxmgzqSadWEYQQ=
Received: from DU2P251CA0017.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::16)
 by AS4P190MB1806.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 10:20:32 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::72) by DU2P251CA0017.outlook.office365.com
 (2603:10a6:10:230::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 10:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server id 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 10:20:32
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Oleksandr Kolomeiets <okl-plv@napatech.com>
Subject: [PATCH v2 2/3] net/ntnic: implement deferred start for Rx/Tx queues
Date: Tue,  1 Jul 2025 12:20:26 +0200
Message-ID: <20250701102027.3525524-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250701102027.3525524-1-sil-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
 <20250701102027.3525524-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|AS4P190MB1806:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e750113-6e0a-473f-e873-08ddb888e946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w10WSmbgbBIVBi8xO7aOHykkkPvSJEGrMEG5RsvRA3rgduXZrkKfko7NwPWy?=
 =?us-ascii?Q?7au+R1uDSHqD2HBufHA5C5AsiDonfPDPjLMnhyVgn1LdqtB5ylqtx3znOHiQ?=
 =?us-ascii?Q?9qg5x+qSXmMTWQKd+Ku/NV8168PJBE/b+zzOMirRwHkz7ab1emh2i7839zJ0?=
 =?us-ascii?Q?D2gCE1Gwc5/3QA/5zn+nIyxQFBI6ebb5EgMeNd+ZYuhdpQu1YolkaFts+8Wb?=
 =?us-ascii?Q?OYkAp/5AJ0cA7X5GVNfSXrEcbYlD0pjwrawwGk0EOpP8o5Yi9XP+YztDp2pq?=
 =?us-ascii?Q?RWJDcfffpiaKWxbTGlzdBCvbU+lXDcv5NvQ5ikb9h2xguBo5TECa5i2/FIpz?=
 =?us-ascii?Q?sk3aPMgTcDIS2gogsVURRCehQRJQKPl1eP9Vt/2GsZKUCC7EXB8drQ4aw2W0?=
 =?us-ascii?Q?hgmE+i6UpYPsey5dedTb7is86LI9hMeUMjpw4Uc/JzAgb5Bo84S6zTKMMMJ9?=
 =?us-ascii?Q?5N5iBBrMJDtqJcaOMqVISop3IwpVFFnWCxLIBZAVjyYbdMDiFW9dTREUaf9N?=
 =?us-ascii?Q?Xw+nxTjaU1sIxeTFzx9WbKyUp8lvbY0iLQXAguXs5hLj+3d/Veh9v77Z+GKp?=
 =?us-ascii?Q?iA4387rNiclCHWz+JWLKxJVf47d58oLGBWDdlCm9kTQmPADhdgOq5if45RYe?=
 =?us-ascii?Q?PenAx69D5k+99MH2gu9Xb35/j2B6oPONz68dmsoBEdIYTnAnOkvrvXVigvy4?=
 =?us-ascii?Q?tQ+wiKtC0BHzBJ1OvV5jhbN9M5eUBz5DKaScogSKHANqd1DsntQMWuLGkKSj?=
 =?us-ascii?Q?/nyG8JdF0lVfd9LlRQTymnf6d3wcaYIuSrOio/cOhLMLtQCRNQTpjcFfn/Wi?=
 =?us-ascii?Q?HYgsseIAg19r/5cR+XBuNbm/08MGwkCzCaAugXEYe19mc8M9LKRhIM5LhOfS?=
 =?us-ascii?Q?uU8EPSW6rFujVSFSCipmytPSzRE+2M+9krXEEv99FMZ9Oa0R/OmZG+IF61KI?=
 =?us-ascii?Q?Ct0pe+ex99sb3WBY/FSZl6slWB1l+yBjCRSv5LxkiILOEFVF+Cg1WRq3xDYO?=
 =?us-ascii?Q?pTdSY3AKFFP4GDoEqtsR4glfZAkIRTS8tOsuS3eSThnRf4IP+nsmUlSRCr3z?=
 =?us-ascii?Q?17Lsvk8fkxQTxIQYkB6fy2NLKF6rn1hs6OPQv+DIPV823r6Lp+uq4JBxCCu9?=
 =?us-ascii?Q?gUskigktLSz1sGd2cFosthP8M00mKdBEhShsI1oZt7ZjIwt3GuUDzrC4eHih?=
 =?us-ascii?Q?o1gFLMtfDDeBv6xLLwLhZ3CFl42LlrTxft5aeXII8VvXNUboLijMh8Ipe4We?=
 =?us-ascii?Q?UFl3MMQI8Ssbmkw5+QuzDEW8axsaHNfe1z7YWu8H/kx3Xh3W1J8Nfv35NRu5?=
 =?us-ascii?Q?cq7TvTxLUEsFAsZ6FjB7ZMwzTCnMFF+64OFh3LtBjACPl5Nl3GQx+RotBSR6?=
 =?us-ascii?Q?ujxhMI3s4kLq1DzSK4TPpq1khLB3GctEdwYOb6+xCaUJt1b90+7UMZST7/he?=
 =?us-ascii?Q?Wvmc1wMcchwRTQtZ3GsHC4e1qdB5+IfBDUtE1wTj1vYMaZmdI+vv7TIg/B0y?=
 =?us-ascii?Q?Ry5yVVtrwFQK8vPwF1U5zd/cgGFXiqdoniEr?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4id6O8bug2CWRN/p7N7DzeGKkS0miHXqwLKzJ2uMmCYJmOLGRgY5fVZRWB+8EFrw0BW9eHAGICDbwqzSBF7mVVd2W/oAtrkifiEc/xB5+UyKm7L5vO4uuYL6dhsyLMdfRUnlyKz7gqHf/BWTizUTqPwVe90dAgF/c3l2tfJY6qM4Yljv4N/+frYAauH6jGvWnXVA5zZF8Zv2oH+AVCjvbWoLlCu4asDy2Ne1UZnhAO8qh/UuPCtZcEuATlSubrxfFWuTXpwg3/uJ2pNcYVTsDUziZ9RxpdC1KC2ZJh/FwHRRTHKKN15m0mtLHO1xsI6++Clgug8pf7yCqhQ62NtePIj6+z//rg0oAp7PJpEifEarE06/nzL1fYfr7hMFTiRrty6ZiutVzB/tz6f0/woxN31Ivm1Jk42313Yy6cm2VbJ/Ivk4RPr63eJghdOnFfWH1jshXJnbEWary31+trJaP3hebQoprJ9ItYrg9vgofzpYKVh87MZgbzf7LxH+0u7WxujHU2Hg4v9QdqrAcERDk5H0pW/QusOSVY/M4+nQfT82/4sM9uHG6n9SKj/nc0SMSVMJeW1iYzKPP4UJCvoECYGoFkQElJjWMFHaiEcIuPlmtnrEhFlzaHMudb5Odg/c39mDN+De1yBCzQXEgBWERw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:20:32.3533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e750113-6e0a-473f-e873-08ddb888e946
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1806
X-BESS-ID: 1751365234-302924-7630-5894-1
X-BESS-VER: 2019.1_20250616.1856
X-BESS-Apparent-Source-IP: 52.101.70.96
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGhkYWQGYGUNQoMTktyTjZyM
 TYIDHNyCjR0NjA0Cg51cwoxTLV3MDYWKk2FgCfPvBUQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265646 [from 
 cloudscan17-124.eu-central-1b.ess.aws.cudaops.com]
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

From: Oleksandr Kolomeiets <okl-plv@napatech.com>

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
2.45.0

