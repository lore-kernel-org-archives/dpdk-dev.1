Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D6FC28B2F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 09:33:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4314A402D2;
	Fri, 14 Mar 2025 10:33:51 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 1608340289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 10:33:50 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 mx-outbound8-255.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 14 Mar 2025 09:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiWMbPeTZPW480Tz6PUwkbIad9G/F+24ErvJJf0WjrmWPX7RWQhGO7Va+H1/gMJe1qB9SVeOYKv+rBL4C+V2WrxHoyDF1TckLlze594t2rlFn36Jb2mDCHQOzgVmDiG9lXhC99USeKijz/SQv9m7cut3UwgArDkhm/znvYD4VAquwDUuE40HWUZikZFcZNdmCZi43hieS5QvR8GQft3U4//KJfqV0Jne5oNvtkBztVE3ZlPDLkozTzl1JZJiNhRsadT0BVYh7ZaDMaF9WkCi9wwUd1Xivo8aJ/knzzN0D9rTKE8Q62evTIOQLgkXdPfNLPzsu/ouCSu8GA2MfQHFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7GanPVTDK9+4aZeb+wH1JezS78GSdDY8Lcb8CoGcvw=;
 b=rtMR3yTgurBAcuRUlYSUsOyTkz47d3FpgER4mY0aAEurcb3BTR/ODqzNmoV4kK8xI4fRP/awNtJcWDG4cKcAoa7+cjX2hGQgG7ZPGY4w2jsr9FycEtXiD1M/sLsI5zkmRQwaHHOu8Rt3A6A6NHeCw1CU+aMi2lSK+ZYqf2K6WMKXfvHaDZFD+P0RfMJAbvaoyOet+sFDrCOHopXqAJVkVHqxWwP3G1+m3uVETvqk5Ky8MM6gIfPGuIypmE2jeCVvIF+qrPgaijYwA1XM2cBWxRvaevnSBcAEBhI5LbixIueD5fvEstxbQOjKcty9afjk+TP23/ObntdxqL2xRtNGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7GanPVTDK9+4aZeb+wH1JezS78GSdDY8Lcb8CoGcvw=;
 b=LoebMfWgf/sBljB6QmDsU44W+RJQbZNNJQRsnJVU1hDDEtv8TPlQpu0F/OxveraqOiVA+ESiEwa6XYI9Hey0JixJvVx5SHNHNn4dI5A3R8YQSaFFb/svuBexoKk3Lcxxihwa235cgc6bunYViOm4rWMaY0uI1+8kQSFT2JfwizY=
Received: from DUZPR01CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::21) by AM8P190MB0914.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:1c4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 09:33:45 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::65) by DUZPR01CA0093.outlook.office365.com
 (2603:10a6:10:4bb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.23 via Frontend Transport; Fri,
 14 Mar 2025 09:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server id 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025
 09:33:44 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2] net/ntnic: fix incorrect initializations
Date: Fri, 14 Mar 2025 10:33:41 +0100
Message-ID: <20250314093342.1184399-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250313164204.858692-1-sil-plv@napatech.com>
References: <20250313164204.858692-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|AM8P190MB0914:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3ba0d6b6-e657-4a1d-d8a1-08dd62db5070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r0EQy9LjvhK17tIb1tnVADR2ec5YNSb0K0uiREfsxefep2FB85wVTECw7aL6?=
 =?us-ascii?Q?IC3hIWN0/1lPR6GgLiIBh0U6Tftk/a+byw4Zr6vPamz5iR7EZRw3ee7bhN2w?=
 =?us-ascii?Q?z2SKrdK2c+NlSttYZWUC2ff+yHD3gU5uytzi02aD2xIFpmiT+MWDVSuVl5jj?=
 =?us-ascii?Q?fw9ZV7271LlgLQG1koN3A2uR2cTxSgmrSObPp81hM4/GeR7fuVj3h/MyKQNJ?=
 =?us-ascii?Q?R4P+LUfnyF9QAbrbDfFSKr8a665HGkBdbw0N+YzPinXkKzJ2qV60MVjjEWnn?=
 =?us-ascii?Q?E202EkFyxGv+UawyFgU81Xlg7+Qacau5NzYerHKQkuXWUQIrid5NMhMD2O57?=
 =?us-ascii?Q?ls/wO0BP7+3XnPlvkPfO0p8GP+Qj8PjLdnluIbm+AGCLLJK/g04QWhb1Xw6g?=
 =?us-ascii?Q?pxLFMUvM+i13Sbvn3TxAaEv9eGV+OSGAu0mWkYCE6B4Xr9NLhVSOnypI3fsC?=
 =?us-ascii?Q?/2uM6nshyHNfTbNB8tMKRtpXnP1C1OM/dFxuJ047SSRSBVAN2iBPab0qGEEb?=
 =?us-ascii?Q?zmzv7v6ddgztBJcRzGg4ffRfFcMeoJhO7no5ugKVWmGmnuz0e51VOlznIxDR?=
 =?us-ascii?Q?Ut5BtnitPR/1EMg9dt38SkumTo04Hlj/ExWQYekun+z6wRzJ6PdOg1YGo083?=
 =?us-ascii?Q?8NzuoB3RN3ieay4AZngWmW9IrbBcNcL6h6P+iKKueUmIJXl/0FYYplzRD3su?=
 =?us-ascii?Q?D19AvDA7pPwhaRgJv2uXHQwakRI2oQku7IKwmm2Xkh0jtspGb6a6Xn8uQu7o?=
 =?us-ascii?Q?JFqF+/913T/ZmZmoXv+gc4PvGMuS6xb5EBS3ZX4aJlTLk+zNma60W2NAYjgy?=
 =?us-ascii?Q?p/S2CkFgMCT/H7dqY3Ru42RxLB6y8z09nnbpLx3wYRCluid19Q5SQiEBfhVu?=
 =?us-ascii?Q?xdWRr//xrxS4H098qMAA/MlmNuHHutzVQeK9M5P2aXP4t1o27Nb5SCmTjoYp?=
 =?us-ascii?Q?YGAKut4wtW1cacB3hLT0mF8GUmPRbT4fakQJBo+/PfFM14mWaY4KSr/Umzhl?=
 =?us-ascii?Q?r+GCXJ9n6bCIMAUsPZRBjonMdDiyvKmEot036ROBURSxDe74MU5KYY4oWnu5?=
 =?us-ascii?Q?sF+v05oLr7wawiT6MbvLebnJUXer4vG5b9420oGQ3AKEtBiRWulYj+GmQV6V?=
 =?us-ascii?Q?16TzMt0xg2O8rEvv1WM8IKa/jDlcBkbXRbB3tny+Ofzmou9eByRY8ryEnec8?=
 =?us-ascii?Q?tfh8viCNoU9sUroQO70Ru8ibnwBha8CwrnMEQUHMtwFrOsdrbZSoKFO7JSxq?=
 =?us-ascii?Q?TXNP6vSBpdIYclsWReJXriwWV50xuoSXpWxtpj25+vtrSX2I0qzaa/gI/csS?=
 =?us-ascii?Q?QuVx9c6rhnoaRujQctnHsYLU7GbpkKxZS0fHNk86PyrZSR9BaQhwuz9q5PFv?=
 =?us-ascii?Q?4L1v/4+okuWXDqNM5yRHTwO01Y8dhkPc4V7elQAu1DMKpLKc3YzQ0Z5sYBTX?=
 =?us-ascii?Q?EtNXWUbjtea9lqhFi63xjEPSDCJLmroxbbm2Wkwv2RlD4guVtS3y7qrM8QUM?=
 =?us-ascii?Q?OWWGYhUAb7RlH2Y=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BgGcptFFJM0wrCth5alZFiiZml2hpcSnExSxJ6BmGPsiex9/ofdm/QK+lZpVJG+i67z2qn1EJkr61/Mzpu5+VO2pmnXhZGJFykJqSKZwReXpDdncOUczRw7QwP6UoWRCk7PziOKnbMaCic/SfsryT2s8gBo6ohwBoTC1/vCdZLHDBzbcWiSWabIXnDOJsaKCu4uycl7+BmCAloYzAFCVcekx1G9/dOkEoWIkaDoQ9lqfiRstRxLMkkV4+Xxc1zU4AwTSK6OYbeYTKemUUPEMnI9hs8TtzSjZoiSCmrUSe96Pvkthj7kpiWfnrEXFAPdG+Ie2hLiXWpOPZtIeef13UrpFAj9MQshuC62mNvsUsvIAchL2p5BXB+PWidSz7nU/7rKOfMYwzx64qdOjzt1J9xM65wlnJfS2i2TsV3mvILlNVfCeA8ObKlZIJFA+eDutKXdm0D4urSriFet2dz8vPTBFxo8aNs1A2olh2HS/kmStLZVtngFrCKkbj73OxscjCtpPdA8f0USvw+6pQ33OchLEXeQxAhsJan87eT2OP/aIPiJyAgKshOichqqRG9lC6hwtC2uBS7VIHJVjUxfE9u5wDOHKiN9MgongK/bv6N0qXcTROnZpCKLNMJGRLV5MNPngrGj4C1cmci3lTPltgA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:33:44.1067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba0d6b6-e657-4a1d-d8a1-08dd62db5070
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0914
X-BESS-ID: 1741944826-302303-7669-2202-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.18.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGpiZAVgZQMNXMyCDN3CLZLN
 XCwsDIwtjEwMDSwNws2cDI1CDNJMVUqTYWAO4lisdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.263144 [from 
 cloudscan13-240.eu-central-1a.ess.aws.cudaops.com]
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
v2
* Remove ifdef wrapper
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c        | 16 +++++-----------
 .../net/ntnic/nthw/flow_filter/flow_nthw_flm.c   |  6 +++---
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index a9ae1fa3f8..889f47caab 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -85,14 +85,12 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 	fpga_info_t *fpga_info = &p_adapter_info->fpga_info;
 	hw_info_t *p_hw_info = &p_adapter_info->hw_info;
 
+	RTE_ASSERT(fpga_info);
+
 	/*
 	 * IMPORTANT: Most variables cannot be determined before nthw fpga model is instantiated
 	 * (nthw_fpga_init())
 	 */
-#ifdef RTE_ENABLE_ASSERT
-	int n_phy_ports = -1;
-	int n_nim_ports = -1;
-#endif
 	int res = -1;
 	nthw_fpga_t *p_fpga = NULL;
 
@@ -154,15 +152,11 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 		return res;
 	}
 
-#ifdef RTE_ENABLE_ASSERT
-	RTE_ASSERT(fpga_info);
+	RTE_ASSERT(fpga_info->n_phy_ports >= 1);
+	RTE_ASSERT(fpga_info->n_nims >= 1);
+
 	p_fpga = fpga_info->mp_fpga;
 	RTE_ASSERT(p_fpga);
-	n_phy_ports = fpga_info->n_phy_ports;
-	RTE_ASSERT(n_phy_ports >= 1);
-	n_nim_ports = fpga_info->n_nims;
-	RTE_ASSERT(n_nim_ports >= 1);
-#endif
 
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

