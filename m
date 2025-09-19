Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF0CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:21:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F7D240B99;
	Fri, 19 Sep 2025 11:20:29 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id CCD7E406B8
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:23 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020072.outbound.protection.outlook.com [52.101.69.72])
 by mx-outbound12-166.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MomTTv4GUL/jVQKBsfQ1v6MXv39RfN2jWnzwf/Eby7cwv0ZylMFfxSPgy5Pj9c2ZYn93G6/GfEjyPoQd3CdFEJ83qX9CY6Rkk9NgBLuzBQXHNbes6kOIRkP0SqIL7u+IyVCVyHgKQm6h6CSnJzicBzgCCCHFvUJqps7J5ymLT1p8KqFZv4N7dfvE652de1k/zHwiuFgZ/Y8MIOx6JyG1HwIUcbJA9IHuFsodRtf0W6ya0QAuBpy0gc8PkruiLOJDXVcDyIScBoV/RKndsAp6zWnZlCyB5kDajATP/OYGwmb6P8NexOMzb+SlR/KVBSFXtIB9L9l/vSD15CedYXIiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS8zvUWdqpFX8ssniW8zlkKdatz1gAS/qOgz92/SN4A=;
 b=FOLUvDnTQL6wYf6KFtD3PdGqjzVwc2o7iyE03vwzzhbYDpFNXA4IDicsESkWyVpLiC5xxfpNdFq13EBJoWSOjMCNHrm6L8JF2SGUY1/5BfjzCCeFvFeF5LSd0A9j8SnfmIQcWXsvXOuIp9BH+HhpsG+1gb8wMuq2GV+mq8nzr+s8aMoPB9JDkXu+Ixurkb694jXaNz+EY91K1osrNqOckIuBdyHpP3VjuF68+ihDmddp9P4CN0RTKMAB6B9JmM3BZABLl4aNdig6XALpSKnLjXvb81Oc8QfhgJd0MD7wrbATE9zqP0Fl63Q3YY/zYemRAwTpDIAvtQqadq++TTV+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS8zvUWdqpFX8ssniW8zlkKdatz1gAS/qOgz92/SN4A=;
 b=dnSgKmZmqqhQSYTnW/69OAnPINtGP5Hu3bKIl7LlWOcZVUL98LI5edBZE+lMJcCDbV1iI7N/+8643cKDM6pNJ5+gBsWteAdjeruR5V7DHBsMDVc0EpZ8goA8dKyMCHol3Zh4KYuKqr8sfJuJpIjEx6bORyUZKr5nKSDCrrwDMNw=
Received: from DU2PR04CA0359.eurprd04.prod.outlook.com (2603:10a6:10:2b4::26)
 by PA3P190MB2311.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4d8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 09:20:20 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::f4) by DU2PR04CA0359.outlook.office365.com
 (2603:10a6:10:2b4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Fri,
 19 Sep 2025 09:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:20 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 10/16] net/ntnic: change prefix set_ to prefix nthw_set_
Date: Fri, 19 Sep 2025 11:14:55 +0200
Message-ID: <20250919091504.1548351-11-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|PA3P190MB2311:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bd036a0e-1b91-4a99-8c9b-08ddf75dc13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C+C3qk3jMMfLAAEOcumwAZfPcQZmjWrVpqOm39CdcTfMPWV3QqMLGE4DpNLE?=
 =?us-ascii?Q?SRFHXUfcMuhFmP3Rm2aiToPwAYKBSjNaCyH651+fxNoqTN4gR1TV0aXrQfo5?=
 =?us-ascii?Q?J2WcjYYp4P8hdWo0CNZbmA4OB+KCKK9JjJf66m6MfT47kgdE5IhCgQxOCQvq?=
 =?us-ascii?Q?gUEvD3U8A+YozNLIOicdSo9qVE8cFkkyKfa+sg90l9OViTtgXnmTkZTSUQir?=
 =?us-ascii?Q?wi1TJYuzH49NuARvyAURxActln//av+HHkDoqtdkP4IV21vKJC+Isp4QKJEd?=
 =?us-ascii?Q?ktYcxwv4UElZygbfg8D6JCYzp0vIkp6mjz6FXQVZDFQAgYXJ6Q+EkPyck5Km?=
 =?us-ascii?Q?JnIeGwjl33VU57fTHIBQLdLs+Z0yE3rJbmzzI43RiTCywwZaY3TFHz22q+CG?=
 =?us-ascii?Q?o2g0WWCtMxrpBBXXBO96SoMPomfF5G33uawNrHT2YCLN3fG45DPnvXhZA7pp?=
 =?us-ascii?Q?eML7eDuFZtR7oD0v2b9Ao64nL6GtC6HAnF7YbwDu8xk6c6Wo5NCzmdaw+vNe?=
 =?us-ascii?Q?x8bkw/RWwtv0t8T9ppTh0+hHfSspL0yoQ3K+2JosVUlgSpL94J80N1PCxmja?=
 =?us-ascii?Q?5fsDXaAoODuGgIJJsu3TeD0bpXDOEMJQKmpAfWt23kyYNAeQC1eSnT5T5LKG?=
 =?us-ascii?Q?012Y8tfhe7aRnwF8Y+9dChbxVODqtb6u8OfaZn4TTFBzNryLLCgn2UA2j9Bu?=
 =?us-ascii?Q?0WwY+wliHMzMuoKhm9c9SjXJq1Ka/p4yZQj0uoYcMP2HRFO3LK0Ghi9TbyNi?=
 =?us-ascii?Q?CISfkW+9ms5Jyc6JpFRnpeARpmyUPVIfTtkl/xCCkDfdKVe9eO8HW5kFb55w?=
 =?us-ascii?Q?hxNZ8DmPoju2fkcOpdDj03r7jM3IIQ7jhZKOLqoQWhSz3j/6Bkkph5SxAKof?=
 =?us-ascii?Q?jfnz1HeUa6JFS3tF1dmiINCp/hkUh5BrmCi20ZBbKlPge5xk93XRMXC1g3Or?=
 =?us-ascii?Q?5W7WQMfucMK3jXTYI6Wn/UZ0cCbxTzLveDrd+FLaxKlSG1DIexFHutv6mqWm?=
 =?us-ascii?Q?wGPr20FwZ4sJQkaLOkPx4Pt4Hm3xdecXrbhTDAO3k+J54IpaMXRbAuAOt5M+?=
 =?us-ascii?Q?TfKWFKnMDbMWeWkSwDF/5H2nXGUn7Fv6Hw9D4f2ACpBabI8C3I3bf5+uGfEP?=
 =?us-ascii?Q?f+qFYfkTzIv95WaXnyrOCkK7Y46jlOmOFnJ9YMOWAxqhwKyHLHZvi0wpwL5s?=
 =?us-ascii?Q?TJoFwbGGmpvXt0cdZ72rjQvwBIyNqFeqIhzY+gpNIcz3gbeSZRTjRX7LV+c/?=
 =?us-ascii?Q?QagQyjQnNvItYdf7sb9AeOVAx26IXQq8+3q0HyIRV7T1ojIdrRp9qifLE7ew?=
 =?us-ascii?Q?169PMsk37qEuOCg6xQoTbaXvEeP6U+AyaFgj2Qv+1jaNnTKOIBCG0+BxLscu?=
 =?us-ascii?Q?z7qVw1KrJVzY2jjJO2NgRtImDnQSRORRrzD7FRa7Qu9n0KiWAxtewlcjmfXk?=
 =?us-ascii?Q?Xos1D060W7q7y5ZbN6LXMm3K/hYsagi1uMZxD/YRN2hgCBK8uvsg17W75klQ?=
 =?us-ascii?Q?F5iVTNK6p5FC3DrY3fqEFWMPbwss46ydwPXq?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ro9myCWbEzLWlSg17sgX6SNupyjfOY4UR+7ZHMLts+xTpCvgqGmX1TM3nKE0KoC9FH+AKO5m0o38NanGzXbeYpn5B0Qltkrpfs9Oe/tIxt/F1hxg3HTDeg7AFj2aPa1I5yyPV492DAvOhmS4g95LkaZxxxlJCI71np+lup5jHc/7rYPauVaTy+yU0+6yHLmfvlXrKPVc4aKFIBnpQdummTZDnpmtxswpn4M1TDDq2R3T2OgAt6KYRgaMCpyrRka60TQZwh/KHkhP2FxQ9jHzoHCins/rek+Onuj+EJFBM348PTqGKtfxUdzqZHlOLZ+WWedg2sIjoii16xFJl/ngF3MpV1UkKqjAfN4W73YM/rYq4WdbUR6NgMZNNIR4x/7jam5H6FupDAhP/z6k3P7RpfPJbduTerDPnGlyKUpTvzXFWZAV7+45Wa2MRS2nTRpBFT6vUDs2TytPuAEF0d+92FIPsaejHNj5+CkeKz4DR8Drwawi/JyP4T9eZxcbrdo4IF5PvRs7boNFAiOuh50oZ83sGpyN2Dg9eK9IzNxXPvkz+013l9by20/7QyMMzFcIXTzFImAAWXDzQYTHXbjeCJfFvxi87qCHP0IoGF0sJJu+R94jw5fZ6ExoBbJbWsV/RwAd4KFqpOnCj24CPqequQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:20.0966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd036a0e-1b91-4a99-8c9b-08ddf75dc13c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P190MB2311
X-BESS-ID: 1758273621-303238-7630-1130-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.72
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamBsbmQGYGUDQtMTXZJNE00T
 I11cg8OcUkLdHMPMnCxNIkySjV0ijFUKk2FgDWpK7iQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan19-198.eu-central-1b.ess.aws.cudaops.com]
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

Change setter functions prefix from set_ to nthw_set_ for DBS module

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 50 +++++++++----------
 drivers/net/ntnic/include/ntnic_dbs.h         | 22 ++++----
 drivers/net/ntnic/nthw/dbs/nthw_dbs.c         | 22 ++++----
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 7b2e2e53fc..3257233545 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -198,7 +198,7 @@ static void dbs_init_tx_queue(nthw_dbs_t *p_nthw_dbs, uint32_t queue, uint32_t s
 		nthw_get_tx_init(p_nthw_dbs, &init, &dummy, &busy);
 	} while (busy != 0);
 
-	set_tx_init(p_nthw_dbs, start_idx, start_ptr, INIT_QUEUE, queue);
+	nthw_set_tx_init(p_nthw_dbs, start_idx, start_ptr, INIT_QUEUE, queue);
 
 	do {
 		nthw_get_tx_init(p_nthw_dbs, &init, &dummy, &busy);
@@ -221,14 +221,14 @@ static int nthw_virt_queue_init(struct fpga_info_s *p_fpga_info)
 	if (p_nthw_dbs == NULL)
 		return -1;
 
-	res = dbs_init(NULL, p_fpga, 0);/* Check that DBS exists in FPGA */
+	res = nthw_dbs_init(NULL, p_fpga, 0);/* Check that DBS exists in FPGA */
 
 	if (res) {
 		free(p_nthw_dbs);
 		return res;
 	}
 
-	res = dbs_init(p_nthw_dbs, p_fpga, 0);	/* Create DBS module */
+	res = nthw_dbs_init(p_nthw_dbs, p_fpga, 0);	/* Create DBS module */
 
 	if (res) {
 		free(p_nthw_dbs);
@@ -242,7 +242,7 @@ static int nthw_virt_queue_init(struct fpga_info_s *p_fpga_info)
 		txvq[i].usage = NTHW_VIRTQ_UNUSED;
 	}
 
-	dbs_reset(p_nthw_dbs);
+	nthw_dbs_reset(p_nthw_dbs);
 
 	for (i = 0; i < NT_DBS_RX_QUEUES_MAX; ++i)
 		dbs_init_rx_queue(p_nthw_dbs, i, 0, 0);
@@ -382,8 +382,8 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 * 3. Configure the DBS.RX_DR_DATA memory; good idea to initialize all
 	 * DBS_RX_QUEUES entries.
 	 */
-	if (set_rx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr, host_id, qs, header,
-			0) != 0) {
+	if (nthw_set_rx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr,
+		host_id, qs, header, 0) != 0) {
 		return NULL;
 	}
 
@@ -398,9 +398,9 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	int_enable = 0;
 	vec = 0;
 	istk = 0;
-	NT_LOG_DBGX(DBG, NTNIC, "set_rx_uw_data int=0 irq_vector=%i", irq_vector);
+	NT_LOG_DBGX(DBG, NTNIC, "nthw_set_rx_uw_data int=0 irq_vector=%i", irq_vector);
 
-	if (set_rx_uw_data(p_nthw_dbs, index,
+	if (nthw_set_rx_uw_data(p_nthw_dbs, index,
 			(uint64_t)used_struct_phys_addr,
 			host_id, qs, 0, int_enable, vec, istk) != 0) {
 		return NULL;
@@ -414,7 +414,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 *    at a later time (after we have enabled vfio interrupts in the kernel).
 	 */
 	if (irq_vector < 0) {
-		if (set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
+		if (nthw_set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
 				RX_AM_DISABLE, host_id, 0,
 				0) != 0) {
 			return NULL;
@@ -432,7 +432,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 *  good idea to initialize all DBS_RX_QUEUES entries.
 	 */
 	uint32_t enable = rx_deferred_start ? RX_AM_DISABLE : RX_AM_ENABLE;
-	if (set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, enable,
+	if (nthw_set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, enable,
 			host_id, 0, irq_vector >= 0 ? 1 : 0) != 0) {
 		return NULL;
 	}
@@ -520,7 +520,7 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 	/* Clear UW */
 	rxvq->used_struct_phys_addr = NULL;
 
-	if (set_rx_uw_data(p_nthw_dbs, rxvq->index, (uint64_t)rxvq->used_struct_phys_addr,
+	if (nthw_set_rx_uw_data(p_nthw_dbs, rxvq->index, (uint64_t)rxvq->used_struct_phys_addr,
 			rxvq->host_id, 0, PACKED(rxvq->vq_type), 0, 0, 0) != 0) {
 		return -1;
 	}
@@ -528,7 +528,7 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 	/* Disable AM */
 	rxvq->am_enable = RX_AM_DISABLE;
 
-	if (set_rx_am_data(p_nthw_dbs,
+	if (nthw_set_rx_am_data(p_nthw_dbs,
 			rxvq->index,
 			(uint64_t)rxvq->avail_struct_phys_addr,
 			rxvq->am_enable,
@@ -546,7 +546,7 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 	rxvq->avail_struct_phys_addr = NULL;
 	rxvq->host_id = 0;
 
-	if (set_rx_am_data(p_nthw_dbs,
+	if (nthw_set_rx_am_data(p_nthw_dbs,
 			rxvq->index,
 			(uint64_t)rxvq->avail_struct_phys_addr,
 			rxvq->am_enable,
@@ -558,7 +558,7 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 	/* Clear DR */
 	rxvq->desc_struct_phys_addr = NULL;
 
-	if (set_rx_dr_data(p_nthw_dbs,
+	if (nthw_set_rx_dr_data(p_nthw_dbs,
 			rxvq->index,
 			(uint64_t)rxvq->desc_struct_phys_addr,
 			rxvq->host_id,
@@ -602,7 +602,7 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 	/* Clear UW */
 	txvq->used_struct_phys_addr = NULL;
 
-	if (set_tx_uw_data(p_nthw_dbs, txvq->index, (uint64_t)txvq->used_struct_phys_addr,
+	if (nthw_set_tx_uw_data(p_nthw_dbs, txvq->index, (uint64_t)txvq->used_struct_phys_addr,
 			txvq->host_id, 0, PACKED(txvq->vq_type), 0, 0, 0,
 			txvq->in_order) != 0) {
 		return -1;
@@ -611,7 +611,7 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 	/* Disable AM */
 	txvq->am_enable = TX_AM_DISABLE;
 
-	if (set_tx_am_data(p_nthw_dbs,
+	if (nthw_set_tx_am_data(p_nthw_dbs,
 			txvq->index,
 			(uint64_t)txvq->avail_struct_phys_addr,
 			txvq->am_enable,
@@ -629,7 +629,7 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 	txvq->avail_struct_phys_addr = NULL;
 	txvq->host_id = 0;
 
-	if (set_tx_am_data(p_nthw_dbs,
+	if (nthw_set_tx_am_data(p_nthw_dbs,
 			txvq->index,
 			(uint64_t)txvq->avail_struct_phys_addr,
 			txvq->am_enable,
@@ -644,7 +644,7 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 	txvq->port = 0;
 	txvq->header = 0;
 
-	if (set_tx_dr_data(p_nthw_dbs,
+	if (nthw_set_tx_dr_data(p_nthw_dbs,
 			txvq->index,
 			(uint64_t)txvq->desc_struct_phys_addr,
 			txvq->host_id,
@@ -713,8 +713,8 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 * 3. Configure the DBS.TX_DR_DATA memory; good idea to initialize all
 	 *    DBS_TX_QUEUES entries.
 	 */
-	if (set_tx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr, host_id, qs, port,
-			header, 0) != 0) {
+	if (nthw_set_tx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr,
+			host_id, qs, port, header, 0) != 0) {
 		return NULL;
 	}
 
@@ -730,7 +730,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	vec = 0;
 	istk = 0;
 
-	if (set_tx_uw_data(p_nthw_dbs, index,
+	if (nthw_set_tx_uw_data(p_nthw_dbs, index,
 			(uint64_t)used_struct_phys_addr,
 			host_id, qs, 0, int_enable, vec, istk, in_order) != 0) {
 		return NULL;
@@ -740,7 +740,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 * 2. Configure the DBS.TX_AM_DATA memory and enable the queues you plan to use;
 	 *    good idea to initialize all DBS_TX_QUEUES entries.
 	 */
-	if (set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, TX_AM_DISABLE,
+	if (nthw_set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, TX_AM_DISABLE,
 			host_id, 0, irq_vector >= 0 ? 1 : 0) != 0) {
 		return NULL;
 	}
@@ -764,7 +764,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 */
 	if (irq_vector < 0) {
 		uint32_t enable = tx_deferred_start ? TX_AM_DISABLE : TX_AM_ENABLE;
-		if (set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
+		if (nthw_set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
 				enable, host_id, 0, 0) != 0) {
 			return NULL;
 		}
@@ -1127,12 +1127,12 @@ nthw_setup_mngd_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 
 static int nthw_switch_rx_virt_queue(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable)
 {
-	return set_rx_am_data_enable(p_nthw_dbs, index, enable);
+	return nthw_set_rx_am_data_enable(p_nthw_dbs, index, enable);
 }
 
 static int nthw_switch_tx_virt_queue(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable)
 {
-	return set_tx_am_data_enable(p_nthw_dbs, index, enable);
+	return nthw_set_tx_am_data_enable(p_nthw_dbs, index, enable);
 }
 
 static uint16_t nthw_get_rx_packets(struct nthw_virt_queue *rxvq,
diff --git a/drivers/net/ntnic/include/ntnic_dbs.h b/drivers/net/ntnic/include/ntnic_dbs.h
index c35a7cb99b..3de7206ccb 100644
--- a/drivers/net/ntnic/include/ntnic_dbs.h
+++ b/drivers/net/ntnic/include/ntnic_dbs.h
@@ -233,8 +233,8 @@ struct nthw_dbs_s {
 typedef struct nthw_dbs_s nthw_dbs_t;
 
 nthw_dbs_t *nthw_dbs_new(void);
-int dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance);
-void dbs_reset(nthw_dbs_t *p);
+int nthw_dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance);
+void nthw_dbs_reset(nthw_dbs_t *p);
 
 int nthw_set_rx_control(nthw_dbs_t *p,
 	uint32_t last_queue,
@@ -253,30 +253,30 @@ int nthw_set_tx_control(nthw_dbs_t *p,
 int nthw_set_rx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue);
 int nthw_get_rx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy);
-int set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
+int nthw_set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue);
 int nthw_get_tx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy);
 int nthw_set_rx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue);
 int nthw_get_rx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy);
 int nthw_set_tx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue);
 int nthw_get_tx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy);
-int set_rx_am_data(nthw_dbs_t *p,
+int nthw_set_rx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t enable,
 	uint32_t host_id,
 	uint32_t packed,
 	uint32_t int_enable);
-int set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
-int set_tx_am_data(nthw_dbs_t *p,
+int nthw_set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
+int nthw_set_tx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t enable,
 	uint32_t host_id,
 	uint32_t packed,
 	uint32_t int_enable);
-int set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
-int set_rx_uw_data(nthw_dbs_t *p,
+int nthw_set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
+int nthw_set_rx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -285,7 +285,7 @@ int set_rx_uw_data(nthw_dbs_t *p,
 	uint32_t int_enable,
 	uint32_t vec,
 	uint32_t istk);
-int set_tx_uw_data(nthw_dbs_t *p,
+int nthw_set_tx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -295,14 +295,14 @@ int set_tx_uw_data(nthw_dbs_t *p,
 	uint32_t vec,
 	uint32_t istk,
 	uint32_t in_order);
-int set_rx_dr_data(nthw_dbs_t *p,
+int nthw_set_rx_dr_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
 	uint32_t queue_size,
 	uint32_t header,
 	uint32_t packed);
-int set_tx_dr_data(nthw_dbs_t *p,
+int nthw_set_tx_dr_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
diff --git a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
index da64dbab48..25989d170b 100644
--- a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
+++ b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
@@ -76,7 +76,7 @@ nthw_dbs_t *nthw_dbs_new(void)
 	return p;
 }
 
-int dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	nthw_module_t *mod = nthw_fpga_query_module(p_fpga, MOD_DBS, n_instance);
 
@@ -369,7 +369,7 @@ static int dbs_reset_tx_control(nthw_dbs_t *p)
 	return 0;
 }
 
-void dbs_reset(nthw_dbs_t *p)
+void nthw_dbs_reset(nthw_dbs_t *p)
 {
 	int i;
 	dbs_reset_rx_control(p);
@@ -462,7 +462,7 @@ int nthw_get_rx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *b
 	return 0;
 }
 
-int set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
+int nthw_set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue)
 {
 	if (p->mp_reg_tx_init_val) {
@@ -601,7 +601,7 @@ static void flush_rx_am_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_rx_avail_monitor_data, 1);
 }
 
-int set_rx_am_data(nthw_dbs_t *p,
+int nthw_set_rx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t enable,
@@ -618,7 +618,7 @@ int set_rx_am_data(nthw_dbs_t *p,
 	return 0;
 }
 
-int set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
+int nthw_set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
 {
 	if (!p->mp_reg_rx_avail_monitor_data)
 		return -ENOTSUP;
@@ -673,7 +673,7 @@ static void flush_tx_am_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_tx_avail_monitor_data, 1);
 }
 
-int set_tx_am_data(nthw_dbs_t *p,
+int nthw_set_tx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t enable,
@@ -690,7 +690,7 @@ int set_tx_am_data(nthw_dbs_t *p,
 	return 0;
 }
 
-int set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
+int nthw_set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
 {
 	if (!p->mp_reg_tx_avail_monitor_data)
 		return -ENOTSUP;
@@ -796,7 +796,7 @@ static void flush_rx_uw_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_rx_used_writer_data, 1);
 }
 
-int set_rx_uw_data(nthw_dbs_t *p,
+int nthw_set_rx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -923,7 +923,7 @@ static void flush_tx_uw_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_tx_used_writer_data, 1);
 }
 
-int set_tx_uw_data(nthw_dbs_t *p,
+int nthw_set_tx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -1019,7 +1019,7 @@ static void flush_rx_dr_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_rx_descriptor_reader_data, 1);
 }
 
-int set_rx_dr_data(nthw_dbs_t *p,
+int nthw_set_rx_dr_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -1121,7 +1121,7 @@ static void flush_tx_dr_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_tx_descriptor_reader_data, 1);
 }
 
-int set_tx_dr_data(nthw_dbs_t *p,
+int nthw_set_tx_dr_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
-- 
2.45.0

