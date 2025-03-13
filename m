Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D809C35FF1
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 18:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8574840653;
	Thu, 13 Mar 2025 19:29:33 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id C5100402C3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 19:29:32 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2104.outbound.protection.outlook.com [104.47.30.104]) by
 mx-outbound23-133.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Mar 2025 18:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otqHW+tX46zNb36z+W9ilr7JX1MK3SGTrLK0G4FA5Lx+7TOrxDNV4bMfC4UIZD6rCDXZRL+yuiBH2On+lDH3rLcoBU286qWQiex43jPcZMscYOpU1/bHpQJ0s0MQCN0mZ9zkytQi58FKO+Ep0P2ty3aPJR9LI9Ckfvzc+kZioMb0Ns0mCA2q1kSrIytNopB+2PRFWsPWcnetPRl61fB4ddg58vraRkZVBbtDcd2DHYmNXEhIiNVaHjKFrN7jy7mU9Ff91KJ5mrtNeBuHS1IDWL5VwEIoe0h3JRW6TSendo1abCrsg/qCNIqf6AkVEVebuV0B2FWesEudAaJYqwAvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bopu55uJEEYg7VNkxIu2sIhBHTuKaPeIUeeRY20H+fw=;
 b=oC/8OBNQVd3Bh068MUjSQRJnlZXsWX5Oqiw6cyEroV5jGeNKJyjYTSvvYNVor1RH9rX+zDBLE+vMwAKmg35kda7L7QVAX5wZu14BfFVpXYG2oGJGA+IJbTPqsu0YvZj/vPo9paZkKKOWY1vS0mhyxLxsFWqGO1FXCHNWgwoFQPy/dKIndLz9OCHOV/qGTt+/PayTxtuZroJwYQSvjpnTuLK+sGhwdXtuylVnf2cj0LvHNBuRFxplK/oFRx3e87ad1vYv9dpz9Y7QE69l6SiXcHkO362Rw21r2kQ8aMbw81DMw/Y1p202CM9UhTK1LJjpWznE3HP8JkYXiA9v7WAbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bopu55uJEEYg7VNkxIu2sIhBHTuKaPeIUeeRY20H+fw=;
 b=RanfDwS53m15mHvOtbaY+H+QDZ6Mncz+7FDM6JIripmrdp8EUZxNH5Seygwju+DXEsJJL8S1V30j2SU6k22TpqsnZCgZReqQpbBZRAY2QInlL0JCFQbOd/+Lvotj2Sj8yn99UHPHvk1YaXV/wKK2AmuhxWZmxBEuyNNR/O1CT7I=
Received: from AM5PR0101CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::22) by PA2P190MB2130.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:418::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:29:28 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:206:16:cafe::6b) by AM5PR0101CA0009.outlook.office365.com
 (2603:10a6:206:16::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 18:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server id 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 18:29:26
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1] net/ntnic: fix incorrect initializations
Date: Thu, 13 Mar 2025 19:28:59 +0100
Message-ID: <20250313182859.1180826-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|PA2P190MB2130:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9cbc31d1-7827-4f5b-8648-08dd625cfc36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zXrtmX0Pa7v5cnusCFqZAzgln/WpskHzf971E/V5UOBrpyodI/dhb3z06Nm2?=
 =?us-ascii?Q?Rfpuzu4iIqdKydSVR8jdbhQ0ws/qv4ZW+18nENFZoE+4MkiQsK8hY1xidFc4?=
 =?us-ascii?Q?Uyt4yk5KNAKdrNyBXtuhtQZdR7bg8JHRAhG+2vUBIEl7h4LcZQVpHgTkYRN2?=
 =?us-ascii?Q?jm1FrZgYpbPz0ReDgaK3BbbbCfCfcwpg3aejsCky3Q8wXsLBfbaENHHu6L3L?=
 =?us-ascii?Q?iXs8RNn9+vfApHwPdBraKqBfliWMAfSqu87b7FF26td4Z2W/M0EwYF/i9rd5?=
 =?us-ascii?Q?CCXHKuEw/aUZnGRFoEtyPNCRAI+259mF/BcTFfWmQ26uITX2hbHWaPC1qCJT?=
 =?us-ascii?Q?LcId/iXYxOm34Z9LUoSmNYjgFX3sQqP+GqsCnJ9R3iPKE9UOt7S/kRIx15bq?=
 =?us-ascii?Q?CaKW0oE1jADrLxf/Ox7uFKjBNe+KQSLsBmUSHvaxjf1KwPd8jNvRwHWcFCGJ?=
 =?us-ascii?Q?R1wErqH8CwWDcZqBkyZU2ChrMcQ6YJe/Ft9E7PjWJ/AKCqoHzPvcSh8uZXnj?=
 =?us-ascii?Q?1gXz3mHfdEiutcYPemeuoVfIov71RmBP3MP27hgNRxhFd0W7T1m5eAFSvySl?=
 =?us-ascii?Q?g8QSNL3/i0b/fMU0vPcUv2dx1fERXm2+tAg3dINZaAO4Q+My61iFCAq5BAkF?=
 =?us-ascii?Q?JasVbVClrieBxbv9o4HJpFuTqCDg9X7aOIpo4KCL9G+gCuKMAdIXfEMSqR9w?=
 =?us-ascii?Q?SwM9Rt7ntNzik0Rh3qrxDf+HTwxVUcq2Y5n8q958L+i/5RR3PVeBQRhb9VRK?=
 =?us-ascii?Q?e7HhatMU+fnaGW+HpYewwu0yD4pFjI4mNqucYxxiWJRcNypr9DwyaEEUeE/1?=
 =?us-ascii?Q?NYxYfzO1KGiq5c3bfypGfcj0KBCLFEcQiAXesX5bU/KNjQbJhbcRWBRBb/c6?=
 =?us-ascii?Q?Sfg2ZIcSZw03PTVHJi/1ncKpUl371nnQgtE5+jmk+YweEHmWkKKmSAlsPBBi?=
 =?us-ascii?Q?9n1+GHH56tGvQrD8FVHMiKm4O+wac93tj6ynlyJ1TjRgdM2UyYoedw423FoJ?=
 =?us-ascii?Q?+vuWnomVtG5QNCSLAoQeWOC4HzJz5olu7GfDSlzl5snw4Lc+xMfovdhPueXC?=
 =?us-ascii?Q?NtWPoNfb4UxI2n0QUDQ0H8d+6AT7nSz7fYua0zo1YuCPunTMSaUuDgK2ONQa?=
 =?us-ascii?Q?ikNBA/EQMJWKrSDQUbSidmCKuShwHAiVEzCl6vZqFtPKIWk7GhBQ8A5dXdpq?=
 =?us-ascii?Q?Mbo+NkYj1EVIH240FLWuKD8DAcNVW8hmS9rfWE94VPRBfedQK6UdlRyqerCq?=
 =?us-ascii?Q?jGjLhO1AwMETHEcQXn/Cg/ZPQJ+/i487jLrVyiznkTi38cLnzByFIruLazl6?=
 =?us-ascii?Q?d65dmtDFMXgbgHO0wEao8A0iGdoXw5OzSRMxhZXnwQz1MTSg7va2th7pSvHw?=
 =?us-ascii?Q?CswFTu8JOAyReZF29tadcQ6NJIr8CRt4C/2ZNa05MKTSxOPmbrBeN791Y4p0?=
 =?us-ascii?Q?5OGQa2qqjanevMW3unTnb7CVGJcOpzrE30TaLq2Tzg4YrzFPyQATXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: epMaaqX3scvRSqtq0yGBOUHudDjblMYlgWWIPmvvkj2LcybNGV5HSpLAY36LvdWFmN8YNgzdtIeeuBmbq6pLojQfY70vTJ/RtukwMfJDZs7tGphOpSYnOeFzlM4trnrVdUCqLRcEwD2VdDWjbh1GtkOsBbEVoZWeKu0BU16JvQfTI6pyJxx2FjF3AaUF19xAOggJ9J90cu3CdM0AfLE8ow27fcC0xkkKjunTaBZIBoEXexYEqUfpoHadBXbIYj3U8eoLg4ElKDhMu413eecfR2unve3oKXe3TqJj1rQ3HTCQOvWtYD4pUq2X9Gbzk/0qc7inQZdxVDM3zuEmdpRzjbZ/idD29QIaivTMHEPMcSWlL1Pjbpx7VpR3cw32IbrU8/ONZfXbCb1RpL8or9rB52IsB1PYvYBvxEUjc3VvO7i+xeJnzaIpdEJlCd+4+tRZF243EB5TNL5C090GrA3zDm0RVCgi/jEPdxWncRf2990A4doGpGluXhs071Vg+c/wXn3O8ccISKDYK62gI566WIeCh/DCTGS5DBm7DhZ8XZRst6cXhwahqPu4FE7poj+om1QsUfU89qESTRlhwdErpObreIuldXBJ/l9Gbb4SNU9yaYqEHyl6lu0zUsDjiZYkx82WCKXENCeVxuOiY9mt7Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:29:26.2860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbc31d1-7827-4f5b-8648-08dd625cfc36
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2130
X-BESS-ID: 1741890569-306021-7645-19862-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.30.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWxhZAVgZQMM3c1CIpJTU50d
 IgJc3U1MDU0iDJwsLINM082cDYzDhJqTYWAI1iVKFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.263128 [from 
 cloudscan22-173.eu-central-1b.ess.aws.cudaops.com]
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

Compiling without enabled RTE_ASSERT leads to an error during
initialization
Fix incorrect assert conditions

Fixes: ff04525d90d3 ("net/ntnic: replace assert with RTE assert")

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c          | 8 +++++---
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index a9ae1fa3f8..cb80c718c3 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -85,6 +85,8 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 	fpga_info_t *fpga_info = &p_adapter_info->fpga_info;
 	hw_info_t *p_hw_info = &p_adapter_info->hw_info;
 
+	RTE_ASSERT(fpga_info);
+
 	/*
 	 * IMPORTANT: Most variables cannot be determined before nthw fpga model is instantiated
 	 * (nthw_fpga_init())
@@ -155,15 +157,15 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 	}
 
 #ifdef RTE_ENABLE_ASSERT
-	RTE_ASSERT(fpga_info);
-	p_fpga = fpga_info->mp_fpga;
-	RTE_ASSERT(p_fpga);
 	n_phy_ports = fpga_info->n_phy_ports;
 	RTE_ASSERT(n_phy_ports >= 1);
 	n_nim_ports = fpga_info->n_nims;
 	RTE_ASSERT(n_nim_ports >= 1);
 #endif
 
+	p_fpga = fpga_info->mp_fpga;
+	RTE_ASSERT(p_fpga);
+
 	/* Nt4ga Init Filter */
 	nt4ga_filter_t *p_filter = &p_adapter_info->nt4ga_filter;
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
index 9bae6a32c8..a56d3c5038 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
@@ -685,7 +685,7 @@ int flm_nthw_buf_ctrl_update(const struct flm_nthw *p, uint32_t *lrn_free, uint3
 	if (ret == 0) {
 		nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
 		ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
-		RTE_ASSERT(ret == -1);
+		RTE_ASSERT(ret != -1);
 		rte_spinlock_unlock(&rac->m_mutex);
 
 		if (ret != 0)
@@ -785,7 +785,7 @@ int flm_nthw_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint
 			nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
 
 			int ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
-			RTE_ASSERT(ret == -1);
+			RTE_ASSERT(ret != -1);
 			rte_spinlock_unlock(&rac->m_mutex);
 			if (ret != 0)
 				return -1;
@@ -847,7 +847,7 @@ int flm_nthw_inf_sta_data_update(const struct flm_nthw *p, uint32_t *inf_data,
 
 		nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
 		ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
-		RTE_ASSERT(ret == -1);
+		RTE_ASSERT(ret != -1);
 		rte_spinlock_unlock(&rac->m_mutex);
 
 		if (ret != 0)
-- 
2.45.0

