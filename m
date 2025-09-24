Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC9CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:44:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F50840DD5;
	Wed, 24 Sep 2025 16:42:34 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 05FE640BA4
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:17 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020093.outbound.protection.outlook.com [52.101.84.93])
 by mx-outbound13-221.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZVBWq4p6uRc6Tepu5wWB1pTluEGu0JD4tAFJivAZDbxkFdkJbOpC3sZNdyijMjRsffN2i0gaNeOHTDVDRWZ3+WezxzUObYgNglv3QnDoWcKnZWKfSVJJOExiVXDVfUCjyHXztgxOLDTJ4Oocn2aTnXQF8NgjAgFNrgDeeyRsWOlViKI0KUawJ2YbbDEXn7egfml+a0kAP3BGD2BpbTknRACwmBy1HjULCoPZmqBZ/li/2qjMemaDt51PELClk0F/FngRhuxKyfp6G27qu+GZDMuSC4F7iODusGQAL3x1icZnTHjxFv9zHCUalbqHtiUrSdJFwM2c8OJQDVwK7Gpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS8zvUWdqpFX8ssniW8zlkKdatz1gAS/qOgz92/SN4A=;
 b=N+01pHgdOiwhZP+GofJ95HzPP5ZpHJZt+XfrrntigWoeGaI0+Vpikf4Ok2we/jbaAapE3e6cocIYqrwCPVtfAHDmUWj9S9yOoT+8BqjgLV/79sDsnNHmSPbvlwmQUZ/rEc0rLFmJMXhmK8W1lBlc8GKLZIjOo1679S/dylSuHD1SfBUSZ2rCRBp3t6u3jSH7COObH7eDykAGgw6ORkd1x/9Q3aXeh5OsUBzZ1kv+Fq9GFg/EXCBsp4oNVrfkY4uBdcT0BqInkCllJ8ff4TzqWUY6MEnvoC6vHssp7zDxs/uJwVfpwqri4LTbHKZvrtY+os9f72CnR124IN3gJlm8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS8zvUWdqpFX8ssniW8zlkKdatz1gAS/qOgz92/SN4A=;
 b=lQHH4PmMmTFNekOh7oMUNURtGU+CG0Bbu/Kp4mGURvRjCo21Z7TOfGiTdS7jK8BEs1PBo1dGlPCJbjPcPmZi7Xss5n191fiC7jNFIGi+0ojc7sdKV3Jv6+NSbMYpeWwE2apn6luKPHTJhllj27lW8InvN7bC7R1W7On/EMtx9QI=
Received: from CWLP123CA0239.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::8)
 by DU0P190MB1729.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:341::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 14:42:13 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::e2) by CWLP123CA0239.outlook.office365.com
 (2603:10a6:400:19f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 14:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:12
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 18/24] net/ntnic: change prefix set to prefix nthw
Date: Wed, 24 Sep 2025 16:41:41 +0200
Message-ID: <20250924144152.53203-19-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DU0P190MB1729:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 958aef60-5be3-448e-786f-08ddfb788c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iq10OYnXf6aWwAIcRPW8cw3sUiViuBsctJnBpozRvaMgoMTXGEzw2j/Q1k+F?=
 =?us-ascii?Q?AXs5Xo6xJtVlWtPt3ZGgGoy967f8nmXaZltmb90RI2WXdG+ZxW2CLwJutP3w?=
 =?us-ascii?Q?GoHm/TlizR/Jhy6TXnrMuvx3G/Rm562SFQ4f4zPxABnU3t1aWhpGPe5HfhS0?=
 =?us-ascii?Q?6NpCVnFHrDkoNUcSjZIdJmIH+oE1zaf7o5fEUxGzoJXuNZyWy26WaZ4mVUaY?=
 =?us-ascii?Q?R66FjbDctWnhthTI/t0o2Rwl8QvqijYCJqmbr6YBczX21JTRZNX2lAK2xOME?=
 =?us-ascii?Q?RlCfhxNDkNtI2H+QK4HQHhCFSso82IkLuXsETWEtd2NN0XqdNA02W29rzzsM?=
 =?us-ascii?Q?++U4WazgZXXRy9zabW9k1kWrzjJthFt3ezH44WFUxtlEvgyZ13zvxOGqXRCc?=
 =?us-ascii?Q?tC6xbnfwrLVxrxIf7VyOHZFTZtkbDp5rbixKqAawA39CJL7T9MwMJMbgsqoZ?=
 =?us-ascii?Q?PFGOmloZ/vJLBT9WU46pB3okTgvNzYw1YX8qBJuZBJJCxjYV9gyNflmfpcH+?=
 =?us-ascii?Q?asfjtlFoqQaPyyYSJwP7GrMwB3/AFYSHIzsmN/NrU7rgQG2RVrfN261SnZy3?=
 =?us-ascii?Q?RSk5ubi0FPbhN+9JCyLKBCHHhxAOL1VY2ryK5UuxKsR0xsT9LYxsQCoVdxGm?=
 =?us-ascii?Q?Hbx2Khg30H7iP/IJ1BtTgLU4KZ86qnp+fWnHFFyTTOtvAuFU7n9Qp+ph+WX8?=
 =?us-ascii?Q?L3SsZ1GWXxsOX9wUtPgCHfEpd7WhnDBiw6QFhYWjGHyDogi8jZ2Zd65nxMmK?=
 =?us-ascii?Q?zagkSH49HI1/PDNrqXuCVc6Irsag6WA5yELN0+GEyBy8KSSDn720Uxx65oQE?=
 =?us-ascii?Q?M2Cyj+yYDrZIvculU8I0bKczyKqowOkGnCmYp6mDksdPLcPUF6pFPS3NG6ZJ?=
 =?us-ascii?Q?QoXeQsjnvW923YLMmPtuL+yXr9sMMLxTMH4Q51BW8ssoFRaYsfAjMf1I9mRp?=
 =?us-ascii?Q?irkI5Y8pPFupIFsGVCj754HCe3e8SZFlF2yYIrxy9WAxwQBd6PD/EUeMaoCJ?=
 =?us-ascii?Q?BamRaH1pBntIw5YXBF0/0Pnk9LdRcdELWBFSNmoi/KaFBrrRSuzMWfljpmGw?=
 =?us-ascii?Q?dtHzgtShlo1X/r5OEnb3/yo1iR6VOIt72GraM2g5M/FJiWhCSe05vcXSt2Nf?=
 =?us-ascii?Q?fc5FfIIadKTi2zlU2QTvAwlFCCXobPvIELvGMqcr3SvXXHvbmm7jshBRK4jo?=
 =?us-ascii?Q?rT8HYoiwURYXHjfZnC5el+4FDy6l+birKAJ5DUcVNmCZNxvKwgeK7G+eRA+X?=
 =?us-ascii?Q?khWg/09vObW/y6we4Sp1bwdK57+0e4D7Joq6O7VVyWhNTqtHuFSaPrOx9+Fu?=
 =?us-ascii?Q?9i28CENF7lfncMu/fHsoQEcLTLNgJh31lwhX1tPs6lu80L8/YdUiHthK0IN/?=
 =?us-ascii?Q?O1eboRcBUYEVOBwkZ4LZ8nka75DijdftRpuqLgU6XN+e2iCNP036IIy4ylGv?=
 =?us-ascii?Q?f/I11VaT42Ir4XyD5ugPUPimbdxVr11xE/weLMEeMs4IOzYbuyNGSJrrbkxe?=
 =?us-ascii?Q?cvKW/Gk4PPeYl1Kj+vP+CcKGM+m1XgOFSbc0?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uN0MjlATwaLa4+Df7lZvVGSWzJE3X2ZC1KGWqVhGem73T6mF+P1s1yVekgeoYVC/6fRyWWDkjqty6eD57oeOo+kQMSjKqJO9U9+GnTu1y0ukuiCS9KcPCe3RCNcHhrfufL3XfIKBblA+bjj22ysLDLjQ3DxSjuGLmoLNa2GynHnJWbeqZUJmOtQzgu2h0LfagAvGPUm5qUcIJ2PU3iAzPOO62IAdHA84U4sjoWmtC/ao5giPSWx7J//BmATT9Dwb9DQH5MSdtaZxgTOKwv2Ll/1SqB/lk8TE2C/pvIDXlfxcz6LanZzOJNXleNMxeP3v9IoGn6f3ZJgTo7EreKyiFGkykXN0lADtMyUx7gI3A7iGZdekHBLo6A6swInNx+K98EDZmU1QoTSSHh4NHGBYErZHC6AXnzK1MR9t1VkvLJiR6E723AlIZ6BjqTRHMxji/HGxMgATNnUYJNawt5Bx4Yf3u/Fp8xpiLbaoGkczQS6dDBDnA2FFpHc2IrV++YRvAcZVGlp8CCEWS9yH2BkgD4eMuoiQt/qbssQsJW3BWFkYcZQKnqmrXEIrDWAX988Eeoqy9Woh+5Fub8nQa4kNyLoSxAQCIjU2G2q4aygkQvCzaGA6aBMwV+S2VGE5mk70qz69F4EOMYxzfu26AAbWqQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:12.4521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958aef60-5be3-448e-786f-08ddfb788c55
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1729
X-BESS-ID: 1758724935-303549-7631-8104-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.84.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamBsbmQGYGUDQtMTXZJNE00T
 I11cg8OcUkLdHMPMnCxNIkySjV0ijFUKk2FgDWpK7iQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan22-49.eu-central-1b.ess.aws.cudaops.com]
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

