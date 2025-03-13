Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08AFC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 16:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 861E84114B;
	Thu, 13 Mar 2025 17:42:16 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 8582541141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 17:42:15 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2111.outbound.protection.outlook.com [104.47.11.111]) by
 mx-outbound14-144.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Mar 2025 16:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6CadVYowp2MAa5339CS8QwKGW4+ZJXCT+SaVHjftIq89jCqJO/wiFdvkpF9aSjygWkBPLB9vmSvWjjC2DbMXGxi0Mz4GD+qnNsbsuvcUd53IiB/UwPpIEyuO6OsmzZdiSa58NUWOgOBnXAPx2B+KMDUjWjokt++/erIdhnOMNL4WjFDObdpqYke6omux9XH4CMJKIzrOyzuWHV/9yU//rt6sUsj2szepyFUI/0yH1iNifDGRvdJkRI/FIcdo8JNninUSGePTufOrmpbYeXUs2D/iyT/ogIvq9xqRhQLfC/gmssCt6nO/oCt/GnyOTWNczeB3YxPeIQXksYHGCzplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bopu55uJEEYg7VNkxIu2sIhBHTuKaPeIUeeRY20H+fw=;
 b=DFX1YMHeAc+H7XOLRJJzqkvV9EbNmBEns2uOcSHpiMlGFDgzBU1ONYpiKkoFZUYLKiirNvHML2Rt4QM6UItxD5o6AIT3BYITJy8/msveng7T6b2b7CGPaHNQiMcPVpBi9g94MTkjoRaFJeAuVBWGP9S0sMrGsEHZu2tUDpCcSXkYCShzRGdLv+fOXKYdvLtMsDh/oxtcL7S+P9lefLEc+O9IKZ04xd8+ChLAXIlCF3FwpDQguPNHBMQK1Oq2O1Dtth8xa5ql+wzbWiH10ytLEUN49PB+ou3gcvkNHyOPK7YEkVmuKy4fIqq7pSNpqp6sAEfq7xIyTz/DkYnV/wNmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bopu55uJEEYg7VNkxIu2sIhBHTuKaPeIUeeRY20H+fw=;
 b=Fb1Ja594I77AlQetf3pNbSsS+LGWP/VEqusB65zEcZmWLgiGj8yzFJAlUoOam8l9fAMeJdybrzPrSH5uKJRShooMXx6LbRS2j4F1CIrbrydMSMnxBr3x0YzOp/CDpuIkAIw7wap8iXRCBHgbfxfvg/0GcihPBMiTy7RABroQBAg=
Received: from PAZP264CA0017.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::22)
 by PA4P190MB1198.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 16:42:11 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:102:21:cafe::de) by PAZP264CA0017.outlook.office365.com
 (2603:10a6:102:21::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 16:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server id 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025
 16:42:10 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1] net/ntnic: fix incorrect initializations
Date: Thu, 13 Mar 2025 17:42:03 +0100
Message-ID: <20250313164204.858692-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|PA4P190MB1198:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88c66369-1815-44a4-1f2e-08dd624dffe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R8/wSAjHzh2EeE7id08dP9pUogD8qKAJQNZTg6Vnq3xfja8QUJw2yIlZWHav?=
 =?us-ascii?Q?eohhJ7awNiZqlSrPmJYWMvNsCIHDo4CsI1cpXREzA+H/qdRyhrG+mmZQUc6B?=
 =?us-ascii?Q?4zQFCu61mq+IrK+b+/axTp2B/QTREpRDbSrNtCb0sqIKWWYU+6sWKBGlUHfa?=
 =?us-ascii?Q?j/p5gPh5u79Cms81l4bwSD/y0NIms7ZLp2TStEB8opWZr0Y1p7akM1PF+m9T?=
 =?us-ascii?Q?aGj7Q1MvkLtXqu8WERo3WF/H8t1tQw8KCCJW3GrMyH+lgf6YxQBTt2DXn+2P?=
 =?us-ascii?Q?ZuUCAZqV73jpN74ej1dxbCi+q1dTkNo2p4cw39eux0szb3yguxh+ir/Ql3mY?=
 =?us-ascii?Q?PBQ5dL9rk4kGfgiKqYRBr0zJ9FAGuRreSmjkuvvwGTcsJ0C+zpw1tPg9TbsG?=
 =?us-ascii?Q?am29Y3nvpcguqlgsIDDV8w++iQWrclYUQ2sJJ1AvvcD5SUhvJ2LyTrNfqXgK?=
 =?us-ascii?Q?bTarwX7B7dwQzi1B4wVHnNwfsIzGfyXvFoh3iuzrDnjGvkT47R/woABqFjYk?=
 =?us-ascii?Q?8OPI/fpVYiylHGwjmQdi7Mt80RGbVmTVUgrTcA1em9qYpdVyKrM/i8sByv3F?=
 =?us-ascii?Q?0qJ6ILX1kbg/7vhlOrJ4ajhUN5ym1jfMHi3VFnEwRSsgjTDx+l5ThhHrJhpI?=
 =?us-ascii?Q?LZbV+wc8+mi1nTz+rRYsAvMNvtx9k0ZimgrH6s0+dK7vDguDF7VxYuMXEHwT?=
 =?us-ascii?Q?U45sBwePtGzlOXRKoVXCWmzqtuu4LCajsBpEVhANC69DVosAaq2kQUCqXWOO?=
 =?us-ascii?Q?09RR+ka8qycvPaPxeZTV8iFmAadwRiSF8GRUBnozejt/FNFx9lnfbZ2YAbYN?=
 =?us-ascii?Q?KWrM/IC6WecSxfuSAC0GFDLARbW/e1Rv+R2TSxmu4gtaVAJyNsznEkqrbRc7?=
 =?us-ascii?Q?//kFP1VLEPDFEfkLDP7NsBEq5XxHOzo5pGb6V5eOIBlrfPjoOSY6HwGqnWr9?=
 =?us-ascii?Q?tYxwa/NquZsTyIXsA9cT/JKBbxrfAwRhRAtgL/1XWgNjZY72rucihvZcev2i?=
 =?us-ascii?Q?o/Apv2zEmQR8+kuVL8PIhuhRmWubbQlX4VDzW4tpk6rayhqrEszqx4SD88GP?=
 =?us-ascii?Q?XKCJ6DS/PR3uhoIEhycLIe3Htpl0BxOsY1E3aZcuyNMN8ZS2dnbRjr7fRs+N?=
 =?us-ascii?Q?nG3ufpynsgpbxfP+b6QLhDRIb27Ea35L3lxv5UukElDcxU1pHQuTA0GAIrNE?=
 =?us-ascii?Q?4r30tBy3tvjOivmFKv/bvBIBpYU3rQdZCVPsfx7AC2pysw9yFC/eiTPyceao?=
 =?us-ascii?Q?Q/UQp7PyOOZY/9R4HKfZa8h/sg2vJhEeyiaZSDyj+NXN3njjPSJ9cctWifW4?=
 =?us-ascii?Q?oboz+JFhhSASZfDCyv82w+sVX2Rdnm0ePzXNljnMRRtB1gR59g6bLgCZp2Yp?=
 =?us-ascii?Q?lLdjIjVmT6wfA1Jk0X/LxB2KOvfdMHlqbbHLKTkDn0NTIEoCCTRiyuMP/a/Y?=
 =?us-ascii?Q?SKo0mwm63rRKfsiUXRCTenRBntYR7+bxZ+WnKTs/MLH0WJEbU6Kd5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3Wzpp9wU+bbIDLUTSlA5LZDfj/cMxjvLww3TZjTCq5OcOG8rnVdGSkOeEENQ2hNGyNcngEkppaCM7bBcgTdZHhmNmleSuh/BkUWCyY0qQwiKcLnPcExzSqqxfCkMyQ9E8FzGOklWMFdsK0hZPie52iM/Er5hBhvQPgLLsSLeJYicWfKtau3h8BA7ccHPyj3opT3gKVMDY8jEj4CKClO88nN72TBL4ySSBK3630pvffzFHLAPIeflQypga1UK05wc2tiQRSVv4SB1sbaHYYvs9b0Eh7GX/3+i4P6/HWZ7stPAwHxmhuhaqtOIpZH65wpcIeuv0ecgxc7dAGFwKaz5/x+PyfofCz0TIiWD2jM+B3yDqKKgw/LHujJiaXEmlJX54Lg4/bRzzBPu3AH4gWnaHa/mz1E/5ZQoKm73SNxb2kMvLYJsx5X4d00jsYsquFtJpAMqFIJZL5r9QMu+2pULrqpqLnndvTwsS76YWSYvuPMUN9BqA5MY9ROEsfNafinnrbUcanwD9M46O3B9IWWwi9za29asjCRQGnNmAT4FU+zrz9hYXKfHCfUERzZ1XxLfW9A4k/sJcwZjC0qH6+O0cOeFG3ZvdFShGLAXXYo/VTJqXg0CnuZQfMtcNupzSnWwh0ZpDwNQBZwifPTcJdu8rQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:42:10.0125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c66369-1815-44a4-1f2e-08dd624dffe5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1198
X-BESS-ID: 1741884132-303728-7662-13038-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.11.111
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWxhZAVgZQMM3c1CIpJTU50d
 IgJc3U1MDU0iDJwsLINM082cDYzDhJqTYWAI1iVKFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.263127 [from 
 cloudscan16-196.eu-central-1b.ess.aws.cudaops.com]
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

