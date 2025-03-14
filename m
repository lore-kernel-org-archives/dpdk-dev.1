Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A1C28B2F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 09:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DC27402D2;
	Fri, 14 Mar 2025 10:26:43 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 62DA340289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 10:26:42 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 mx-outbound8-255.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 14 Mar 2025 09:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9C89sumtxlGy89tORY0DwrawIX+xXiKRBmH1gCQWlxe64mv2L/VojwH3ZtWCQ9SmIsXJGY1Izpd5EOVtC2taSEYzVIpuuc43qX8jhTXEse9o0IpiBuSwiMhH/Wl5xVhgIf+hLnRhfKg5rJZfTRhdzIfocoG2DQxTxMatl+KY9sN0RILYa+0PSbhiD5XZQiRIFP4YILMYNeg+Rdj8S3WcB6OGX8F2eHvqNgV1RQGj0F+K5gbC2V3xwseJWJ7sGqcgNBHZ+lkREuEzGEU3ZkiphnTiqS0TP7MX3XuTdniD65/p3NtuTMkx5VGOBbwMgXeIXDxFkitXpzvSEcAKmHEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7GanPVTDK9+4aZeb+wH1JezS78GSdDY8Lcb8CoGcvw=;
 b=GLPBr7oZLRqj+H9kaY1soXB9q4IyrOyt6TpAh1882R82h7KHWhSoWN4OzEKX6HrOjYK8s1vA96m6CFqLJSueW+mlQltd+BLiRVC5j//ti2vpSMb/u+KG8MNqakyrE1g/InRGtCqu2ZYYiQ1Mct1+xbEfZdnEIGJ7ulsPuN65uehj/OvfNvxim2CPdiuaFzyURHOAhARRdnWHV58LHIdLM61KuQWmP1xF5rHpqzvJ7ryK8JzFe8Th/sWLYQSXU9TqNTz4mKsf7dEV25YeOXnNNRSLHCWZr70RLbrwL3fgUdPMpOG5dRm3OPGWWIKTkQUG+Rn/0Gcd7CeE+3fBrYVg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7GanPVTDK9+4aZeb+wH1JezS78GSdDY8Lcb8CoGcvw=;
 b=VAyzJUDvlqZ6RobCi1K9g0D6yTalt5EHgTIKEO8n9R9z2GcBG2x/2tbdAewaWwQPXxsfrTOzQpH/pGomt+AvjljWRD8KNkzAe8S3NXL2R8Gn3RnL8Id8ebORy6Y84ZJLMWchjELycdXu9hfvWnqz+Ud0oO3ML6rQrgGGe8tC8Os=
Received: from DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) by GVXP190MB2146.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:150:1e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 09:26:34 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::e7) by DUZPR01CA0098.outlook.office365.com
 (2603:10a6:10:4bb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Fri,
 14 Mar 2025 09:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server id 15.20.8511.15 via Frontend Transport; Fri, 14 Mar 2025
 09:26:34 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2] net/ntnic: fix incorrect initializations
Date: Fri, 14 Mar 2025 10:26:31 +0100
Message-ID: <20250314092632.1184059-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|GVXP190MB2146:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 58fbd5b9-626b-492e-97c9-08dd62da5040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?34+J5Z8yhYp77LfoFalyaIDGyL+08pPYkLVAkJPF2z0j/Lz+vZHj6IjWrqmF?=
 =?us-ascii?Q?4/HDQ0/s7936QOvIR54B9dM50sNsq+4IKzNpod1JOR6NI8llOI5h+79jfw3K?=
 =?us-ascii?Q?tpVTkSoj4t7xrgry0xbakGGizSPNviZMV2Rh8R2n8XZynEERbnkQEGjDE6kb?=
 =?us-ascii?Q?EvgkH8/iw7vuFAD2C4/gaoG7AqZ0t/RkntfMfNmhCVqs4WIC+1dV6IPu9+F7?=
 =?us-ascii?Q?YtVnwun7uhaWOfZm+eyT0kzKuH1c1FIwylUlwWQsGEzN3tXztifoqkWLKauP?=
 =?us-ascii?Q?pZGJXEHIzLem2He+/yNEIreXvl7WmjO60Ipllo68YDcAgMSuk3JVb/oWtCv8?=
 =?us-ascii?Q?CpZXUkzPHZczgKWhexoRukmv7+eRF9oXuCoRPIKyNHl23yCVb6f6WQfaM0TV?=
 =?us-ascii?Q?pHtIJPLH4m7BYzT0R4AIi6mXlBSH3zeOEqoBJElnsRvDsvEj+Z7QmEGt3Fh8?=
 =?us-ascii?Q?gznhoUbcrZvnfF+SbMOIDy3ARl9d/GXicqiTOjM/y4XTwKOlnO/q2wa1ak+B?=
 =?us-ascii?Q?24VNa0BfogfLzaQlsEEolfcWmDi67TM4FiSq4TaYP1F00kv7C7vev8ZapfSz?=
 =?us-ascii?Q?m262qYXkHQ5r5bKjNxPNVo7W1ceqwwnaoMMFwBM/jj/zhp47ntrR3j64r+rb?=
 =?us-ascii?Q?eNxg5YnY06etTbfVCpz0Bv5Wl8Q7ArM2BZQHWcynmrX1ZcQWKLW32ZUar8jz?=
 =?us-ascii?Q?k21efs9Z5Z3k7OtbIaP2MUZc36l7+uTIiOxFGXAm5IjiOUSWkA5suX+YnPRl?=
 =?us-ascii?Q?/IiCTlqkRoz3QTPDQzpSa63zTCNlWqC68tAof8+pb67F7xomC2Kh0+txI8BG?=
 =?us-ascii?Q?e/6/sYbrVeqRScRkdkFQ+5cokqJBiwmLj7m1bliMdzqJvdNlAJ0C43toEZbY?=
 =?us-ascii?Q?NRvVpDh95FZ7X11hYzOcEuOyI2csi86i533e7p9iOEbOxWcR5QwENAok/IfJ?=
 =?us-ascii?Q?l7D3OdrU2xYpHUX/LsSfInTf8stwRU05mcmoMt8HL8tK1Q5FfVIU676ojs50?=
 =?us-ascii?Q?CJyYUZ1aFke3DSQuo8rZ6D9+vuBtPd7SRNPRZj5Mn7IniqOLisAZ4cuBTTN+?=
 =?us-ascii?Q?YuNb/JfQJP3TmfwVCgX3v8DR/3RVtH3akqy9PkB4Dz7oUkln8o5nqZqFY1Yr?=
 =?us-ascii?Q?AX7ex3dY+hbQ3ZY8POjgVOPgjJK/nCioKaw1uRepqP9p+uSMSXJN4206RmSH?=
 =?us-ascii?Q?w8kSiIPKHLny23rGnSe0/Y6UXrbmJ2CqqBbKW14fpQvDsziE5BUilYg/ew6B?=
 =?us-ascii?Q?N0m3DLdS/j5sk1Fcbhz4h4hf07YRHBXFSvhV3zWgfdmF9jKykURF44xAaPMS?=
 =?us-ascii?Q?iro4m3W2Tau7jIOUnFEsSgc1x+aygiiCGRFuzah/BbOZRYO0J+tGBfT/WnTY?=
 =?us-ascii?Q?7ggHy7cFljQn6rfKEPsFv1/n6ER8KiiK4HZ+iXI/XPGtSaFF1PiL6+0D4QjD?=
 =?us-ascii?Q?Ey4EYtmrVkeLsTHOQKFPlPCiv9fBZSvN+/OlWANji5Cj9O6x0RwARg9/JOSJ?=
 =?us-ascii?Q?FP1JCcv0KqT1kv8=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Bm8AXDYLynpXqDhYQzoW1YetbVM88UZ/ygeGTfZQz3lj7DW1EFWEbEEKWCVvEafLfVLflzAQ+q3X+2NauZmgyR5y43jcDC7PPTHz8dUbGvCMawHp0NhVJbbFqo1/pSzT5E/4k05Ga/ifx+cDUpAaOVINTVq3xzNs3rEejredjwPh3S1DxldgLgCdhcENfGbIw83taH5PozwO2rdBNPQXmb5SC1fjD93GDQaRo5nfmxpXD2EPdIEJJDlq91uRAMNhkn2MkkTe8YFt5PO9mQHjgj/car4PzXZSDcIeImo92lt/YtXWeu+qtAt5uZXCOC4YvmBQHaz/o30DBhBGx+KQabujJ9tqBpmVtjsamX1afJJszzbCoLJ3XIfWLuh0DnbbPWUEI36gVLD3n52EvsPwRRgXJtgmDy73VOyRh2PXkUysclQ9qJVwpoozcffzqgYg+UN85EVRS54SZJfgt60aR//YL9qj+AJihgsTwnYccLo2GvrusBO9/y+OvbZuTq4MUIps4eNwPq4jLcShcJ6y6KZagMK2LUXaFuRXcvhvUfppBJf1dT3zcDq5jwBnQWlwGeMwubRSjTemlMM+DhgFlW161toNO6yPZ7VcaBX9GU9s9FZX8gSXlKz8yP1zxYgLUpntcqHDKKJtAMu3CuIpUw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:26:34.2937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fbd5b9-626b-492e-97c9-08dd62da5040
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2146
X-BESS-ID: 1741944399-302303-7674-1495-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.17.108
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

