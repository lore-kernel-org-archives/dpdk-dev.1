Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF1C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6734F40E31;
	Thu, 20 Feb 2025 23:04:46 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id AA55D40BA6
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:33 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2049.outbound.protection.outlook.com [104.47.11.49]) by
 mx-outbound21-132.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk4eYZH5N5O6TOijCp59KcyvT350fTF9Kkpl6rlK3fAaZ07ElZEXb68c9IspNXaTNAigR7SlHe52ctrxhcYKQFWx3Tj/XwR3vqYUu7PVlKFr8uopcoOvu9NPXgGPB5TFXFfcLaPG8ZDlVIknN4seuq6kC0X+tOTWbYO2Ev/e2M0HjbeLzn1lEs6Ak21dVDbJHR0oD1VdFdA39lmJFYxPepXwObXxTtSokLsZ7yqgRaokSipJrbuMGeVEoe2xatP58IoKqD+EM1u0bLy5dfa6sFNrIZON5rAx1FWVG37MenEMYHtuo/UkNKG3ZYaSbFAYxWY5Id132tOAWmAE+X0VJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzlDUaYy5TcPPlV13dHlm+qnOn3v7PrGWsT+n1dHo9A=;
 b=BzlTdo8JHNEDT+IEuWKpLKAnGANs4C51SXBb6ezN9DqhEuudHH2GEikAFNLl0Tm8vqdouNYrQ3T1K/2EN29xEOes4a/eJxjuIfT2bdsCAYFtEb5mmjZSLPbHDdLDUbMIXv1REcFNyUgC8nJ/Kso2d/+BS0NsVhGHm+Fw+B0uEfdAY3EIEFTNbIfvwYqliwZxHtQ4YyQI0xNI2bWYZwtiQ8XjmXzj4ryFDYQhjyVl9j0TPllQRAxlqdHL5zmAH8UZxK1nBRWh9B91EtRzfHd0fiRE0eNp0A/vzPJE1w6gDOijWWlj8I0k/Md2nVmw3WuBJlPTW7akqLKEjZyR4vrZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzlDUaYy5TcPPlV13dHlm+qnOn3v7PrGWsT+n1dHo9A=;
 b=obltRu1e3yPvScGrGpIc1iRcMlXyoEDHDC3wq/PWN7IjH7+dWOAhddFlxD66utK6GSjoN+GAnjUtqPHLj8Uo6aKJ7C/+SV7eWx6gn7NvzSXgxYBW1PiC+gC1w1eoy9YO/YZqBS1BUTaJfmSf2vdxOYTp/uJqGVuDOaLKG+uiQCA=
Received: from CWLP265CA0498.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::12)
 by AM7P190MB0789.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:117::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 22:04:31 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::1e) by CWLP265CA0498.outlook.office365.com
 (2603:10a6:400:18b::12) with Microsoft SMTP Server (version=TLS1_3,
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
 22:04:30 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 24/32] net/ntnic: add nt400d13 PRM module reset
Date: Thu, 20 Feb 2025 23:03:48 +0100
Message-ID: <20250220220406.3925597-25-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM7P190MB0789:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c91df777-6460-4ef6-f9ef-08dd51fa8d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qCRCz9PFQrgb7W0p2r72L0yhPcH5GA2L2aRCIs7SzJWa7exdfBDYJBMsRZfg?=
 =?us-ascii?Q?xrGSqnuwyeLB5r0aqRxaGGATG+PGJfhsLlZ3FIVGhC52INxS6pt8b0+I/Exo?=
 =?us-ascii?Q?7OtFjkoX0rvtVuc3B0DcAUAzbf2B46AU6QkCm7SZX8Rm7kh8GUnwSh8nywQ6?=
 =?us-ascii?Q?bOO9cS15JjbxwWc/t/R9bxQsmLLMO3YB+oBlbI0yxD27cJZb/P2C8HuD2w9D?=
 =?us-ascii?Q?Hh+wTHIhK2uVyDn15xLino5HRmz/+M2ijy1b45Gcn5wJ74w5d2HAZslVl40G?=
 =?us-ascii?Q?mrL0GmpMjP5qtXSnfLSSSITQFuJeNwyyM+I9nHCRXA3wqQPqMnHY6EkZaBew?=
 =?us-ascii?Q?HymSDPATa9Ft4BwxjBnbZVcMOs5E6m5afszVYJmurCrmjr67+2PHT39LECxg?=
 =?us-ascii?Q?1BdstIqLbKFGYQWgSrakjmioBUko3kO/MoZoOF5a5qUIKEt+YEwAABDRjLED?=
 =?us-ascii?Q?QOMOnaNQCCsfOoXfVZuEAdIyXt/i9gHPPW845wtmzFk/FAp8yhTRcAuFcCLe?=
 =?us-ascii?Q?xkz4S4mV8H8D4BC4onSxGLSFJO9klMJ2NnRfEzdYp8fYiZTLOQDjEPda71FT?=
 =?us-ascii?Q?19CqFzgjmtqRdlviWL9Pf57VRllVQuCLsOwIbaPS6VZj5EVEkPk0zxUZZUXK?=
 =?us-ascii?Q?bp8Yw852JglkkPTN8PI23eBuWCbVgDF2iXACwI7KfvG/4uCk0aGGcjU+GzWC?=
 =?us-ascii?Q?0R16/ljDdCRmBdlIJrnm5fLdKcwqMFgr7ZwhtItE9GfnFbrAYwcP26L+/N1n?=
 =?us-ascii?Q?9FIQrMwEm/vxB7L8+t9A2kbq+Vlf5TYjslynGBAXFgTfS6a/N/8qGYLvIN05?=
 =?us-ascii?Q?tOrXRV4Z52e7/S/xGlC5hS90mnge2QNaN00klJfia21VpujGV4ExMUaBMZwo?=
 =?us-ascii?Q?5SD848xR3g8uN8sn6csTH7tb4py/wa8ZnKth8xky5KvrMr2I6SkyeQS8X57L?=
 =?us-ascii?Q?86JFQTDQ9Beu6BKjjgELsDYNIQmmiKRYgGqfNcyEXBAXIYQheney1paWRQOu?=
 =?us-ascii?Q?iZQOGuyXoazVqZwtIhEfPp7srPsPzzTwFtFPCZGQpnt/sGQ7t/ZDA3BkeKVh?=
 =?us-ascii?Q?s6xFlZgglvlycglSSCZL6/2skYUYbAm//07pn46F7XCdZDmVjLVEIdgtVzsg?=
 =?us-ascii?Q?yfkEeupokSTLnAIvxuIPfX1vhMlz2eCoVgbqW49f+1EYwyQ0dmgfoanGrzMJ?=
 =?us-ascii?Q?sXmINnqWS7vTNtQ9T7hC66bhil72dGHlGtkMY0Z22z0yWE1svsuUbI6JS/ih?=
 =?us-ascii?Q?8iM7gSfIVjFQnjEirs6C+DMe+F/JqFEWzS6dyPM5TbpHypwIXuKhTlntbMPr?=
 =?us-ascii?Q?hUNmQvWwSR9ykePBKPDTNI9Fk+8LfjoT8LuZ+HqAjRSL9nQIIhIn8iMpACXP?=
 =?us-ascii?Q?FBxzTnsluOuauPYtBWjZyL6/kVWZddLyD3t1BCs1W8o2b1CcBf8rguYz8Hpk?=
 =?us-ascii?Q?sVGhjM7nFOukXrvODU7kcPSgQ7phZBPbPV2gNj6HX4sO+PscmupjgtO/j5zK?=
 =?us-ascii?Q?a7eT5vguml9SpAo=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M5ugnI8Dqf94co0xTDerkXgbcJk+cgykjgG8Ru1reGjVbhgV9PDNdFbxILKC6UtEwKX+lTBluAFFhG3IwehsG/chHvpRJ7pBcJswpCUgwpytW3Vggxm6JqdZxqjZrb92x3EcCJ5x6SIhITO3UmJIbbIDP2+1HeADGiFvmjtGu93FoPdb+BwARODt/gtS6Mj3kR9Ughb3fSPf0tfR0dydguNcLdMJC4H4v2s80e/0PVuR1H0fDWAMa4885AID8UzSnYnsuIXj3HtGBKAz1nag+KPUoy0rpTbEeflAAGLvfdEYJjo43oh9VNmB6BeAPFFgDQRQPJ/VO8FhSRFSFCR2mRI7DgMoDulWhRUH+enI2F1cnyW1jDvAG6PMQr4PJd51imNLoNZZ99KALUycfFI0gI0HRngBwO/Cw+Ut0F7nePbRf+pLVsWNZ1gWfvy3RMdGtfla/eMczBmR84eBsJJ6YaJdIsoiDvaJp27kS1WzwvRVgNbcIrX1MzElB+zvIZrodw48BQbfkIGCytuCw1eKIwSyp/V/rtookFOrDdcxxxfCf+fb1lgPWRhfOHVXD5dyVjDuFKIzLSZLdDHWiTGk5YxIufABc2Kf7udR1Cqn3MnVodYAhvueOgqqD4e2urH8fiu/R7so9CgW2lDAS4lSjuhlamYCKWKbskKIZ2ht77Y=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:30.8027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91df777-6460-4ef6-f9ef-08dd51fa8d35
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0789
X-BESS-ID: 1740089072-305508-25334-16465-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.49
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWZqZAVgZQMDkxKcnU2CzNJN
 kg0dzEMik5JTXRwjw52SAt1czM2NhMqTYWABN4oMVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-102.eu-central-1b.ess.aws.cudaops.com]
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

Reset platform and peripherals for PRM initialization.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h |  2 ++
 .../core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c    | 13 +++++++++++++
 drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c     | 12 ++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h b/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
index 09bfd79249..53692145b7 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
@@ -26,5 +26,7 @@ typedef struct nt_prm_nt400dxx nt_prm_nt400dxx;
 
 nthw_prm_nt400dxx_t *nthw_prm_nt400dxx_new(void);
 int nthw_prm_nt400dxx_init(nthw_prm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_instance);
+void nthw_prm_nt400dxx_periph_rst(nthw_prm_nt400dxx_t *p, uint32_t val);
+void nthw_prm_nt400dxx_platform_rst(nthw_prm_nt400dxx_t *p, uint32_t val);
 
 #endif	/* NTHW_PRM_NT400DXX_H_ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 4d74db88de..ff29101e61 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -52,6 +52,19 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	p_fpga_info->mp_nthw_agx.p_prm = nthw_prm_nt400dxx_new();
 	res = nthw_prm_nt400dxx_init(p_fpga_info->mp_nthw_agx.p_prm, p_fpga, 0);
 
+	if (res != 0)
+		return res;
+
+	/* (b1) Reset platform. It is released later */
+	nthw_prm_nt400dxx_platform_rst(p_fpga_info->mp_nthw_agx.p_prm, 1);
+	nt_os_wait_usec(10000);
+
+	/* (C) Reset peripherals and release the reset */
+	nthw_prm_nt400dxx_periph_rst(p_fpga_info->mp_nthw_agx.p_prm, 1);
+	nt_os_wait_usec(10000);
+	nthw_prm_nt400dxx_periph_rst(p_fpga_info->mp_nthw_agx.p_prm, 0);
+	nt_os_wait_usec(10000);
+
 	if (res != 0)
 		return res;
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c b/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
index b1910fdbd5..286bda43f8 100644
--- a/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
@@ -41,3 +41,15 @@ int nthw_prm_nt400dxx_init(nthw_prm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_in
 	p->mp_fld_rst_platform = nthw_register_get_field(p->mp_reg_rst, PRM_NT400DXX_RST_PLATFORM);
 	return 0;
 }
+
+void nthw_prm_nt400dxx_periph_rst(nthw_prm_nt400dxx_t *p, uint32_t val)
+{
+	nthw_field_update_register(p->mp_fld_rst_periph);
+	nthw_field_set_val_flush32(p->mp_fld_rst_periph, val);
+}
+
+void nthw_prm_nt400dxx_platform_rst(nthw_prm_nt400dxx_t *p, uint32_t val)
+{
+	nthw_field_update_register(p->mp_fld_rst_platform);
+	nthw_field_set_val_flush32(p->mp_fld_rst_platform, val);
+}
-- 
2.45.0

