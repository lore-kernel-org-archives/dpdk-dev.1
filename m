Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66704CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6F594067D;
	Mon, 20 Oct 2025 18:43:47 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id A8CFA40654
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:43 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023083.outbound.protection.outlook.com [52.101.72.83])
 by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJmK8RlST7aPdpjbTvXkD4jFBLFF5uNjc+h4wQiWmxDcMph/UqySwu54nxwXr2cjRSBkkOIRNCTTO3Bzys0/CrNgN2ZBbKGf3WVY4z0uXw+tNb5+Gypq/3WGWPJ15ieRJON1XqLH7nxQK160ABRS4MvsYwCV9RPED5/MLPu03msbp8k3ifEBE2vWaBWnZbh4JZqNsDyxKtNbmJnIFL+5uBX2JTOiJML51Volx8eT561tlAlKM7TZssLvyFcxS4P/t9sLiL5/Ug6HDeYDfY04j0FModCNgxSMDoOezgUE/N/npdsAytxRyWMcKU6hapbihFQhmJQCgd7OXPRIolPxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dXc25lljN6+l4itacgZAQl9fOAV4GYy7u3jBMuOnns=;
 b=zWkgxBBc9w6XYgNNH/heR8mWtwKOgfsE1HWSM7wz2qCEaGaA9LtnXD5GMzcKeIvgPKVGj0VoxoLhYHxYi/eWhSeLA6hNba3o36vwdOSRFuKzWP+x0zEZjdGtOvNZqEetz6kKUcB4nW3fiTBJ3isaZ2tHR5iMIwp9Horn+9g5h8sCYJJhauOlYmiKsZq1ZIZqyXtMbo6FNkeahbGtRsx4dne0mBGdXPpgEOpjEr/cWgPcYb6Wb3TD2udQNZBW1xv/RQKaBbd5MPgM2Foq8kBfDN99/Jmn3Zdz+Y/DPTUxb1l25P1nR8nuGjWPUWPoxteW+/bi3BwhPlKk0h2i3uym0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dXc25lljN6+l4itacgZAQl9fOAV4GYy7u3jBMuOnns=;
 b=hv9+tdVsGxTMXXLPyg/lXX29RsVy4lYfw+eOMOWbquiupWcXgrmDRp5n2h/akht4tZKQG5DfR+c59Ogj5jD4gdaFh7ClsW0MzHoI4W09xLlIAmXB0MV1CzC+38TQs8mIYX2SwkPCaYmvUWjVlVL7gwncfzJIssar21GvfRCJzjs=
Received: from DUZPR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::14) by PR3P190MB0985.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:90::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 20 Oct
 2025 16:43:40 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::3d) by DUZPR01CA0027.outlook.office365.com
 (2603:10a6:10:46b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:40
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 01/21] net/ntnic: add stubs for init NT400D11
Date: Mon, 20 Oct 2025 18:43:10 +0200
Message-ID: <20251020164336.283664-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|PR3P190MB0985:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 81232a80-239e-40b3-17c6-08de0ff7d31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f7eJ1wG8/iqWRHhXfqlUravkS8Y9XMPf79T2uxbJT4XzH4Gihx8MfGi4F7mT?=
 =?us-ascii?Q?pd5VZBZXQ6DA5Fv0zTfWD4v8qdXnz4/yI5OGhO6EOF+KRDbkDBXJg+Grulyg?=
 =?us-ascii?Q?3mLsNzJ3ESC+S+2KA+wadx3tPHRlchcUotUCUPRGkkVOBPitZLAiNQdpEOQj?=
 =?us-ascii?Q?JOXceVYyK+TVWJoESvEv3EQFhFTvpRve7ksMBx0WpyQEc93zEV7qAgb2WyjL?=
 =?us-ascii?Q?75EvyRtE302aueYpsmo5EygwYyq7jK5aoV4GOjkYSEHt3Fv1ihKNbtROYLiy?=
 =?us-ascii?Q?P8FlPhCrdsM39mHt91ZJBZVC6j+viXEJxiTw8xnlRBq0d8MC1x9QI1VPIPv9?=
 =?us-ascii?Q?CQrfHh3x10rC/OKXOkj6KnQ3ozHFHEeiVTa7ROuH+03fmbCn/DgSzkKOn/h3?=
 =?us-ascii?Q?20MJyttCwVOperpE7mPTgu/KD0OXdiTfsBalaET7ncza1q1keAtg5aGnVdpV?=
 =?us-ascii?Q?VBu/ZRfEHoYSB4xwQZn4pYZ9DTl0YAvxSVk4oCXYncIGX7Z2J0BKvkxDylI7?=
 =?us-ascii?Q?b+nhZpJcwUQMGYNTW/za7QrZPDeJQ9jcg/1g+x4R3pJMTlc+k9sRVzdyWiFn?=
 =?us-ascii?Q?nJ1BYAvfB8kwhbzM5MRWjvs6kwO/yHIGApUekB/NFH1KtPGrCbXQTv6J8Glh?=
 =?us-ascii?Q?clMwzCMrEC2oCrcx4adUJR6mdPhu7rW4rDRRCWVK1NGsQJUPveGUfwlJjYkH?=
 =?us-ascii?Q?372uKjxm0QrrLxq4pOHIeeknOkHVCXXGEKLdOl51fQ3DyfQ7HbBBlwU7KHsE?=
 =?us-ascii?Q?esbVjM67hGxUfEv5JososEB4QMI4w98QyM/ciR/uIa/D3tefCz4uZph7EOVZ?=
 =?us-ascii?Q?pdqA0NebvL29i/Udi1swcZXi53qHB2rLT2PpHHqLMFNLQsAZTatPimvje5tf?=
 =?us-ascii?Q?DclfQRpTc9nZQ22U/AMSnMCW5QGll44nWV2eDQt7sfAY9m4mIwZOCTcRbGFy?=
 =?us-ascii?Q?gwLyqo3irsy8tVd/Ulgh62Dz2JQLAhaXgXUvRcuRWUs0Q/ILs/mA1RepOw6u?=
 =?us-ascii?Q?vFdyD8UwpMams4bq5k/vAzVeF3sIUa5DjZWPNcmn6ZT/9FVzx0RCh3LQRJVh?=
 =?us-ascii?Q?0w7UEiRvm8zbGcNXKBZvvw2tzA+RMPx3WqRDN647we017cSkdAQ5cGXC8TVW?=
 =?us-ascii?Q?aLOlhhrjuk9eFny+jbMAXopdpLrbJp5DTMukF9xAXOpwvN7mqbaGC1Uucj8r?=
 =?us-ascii?Q?5b1e1L1Ge38k8WZm2Z1doX4zS1vrQP6HFuWoveT2sSGaXWABwB81LpJ8VqC0?=
 =?us-ascii?Q?0pY7etxFqWfoQLtlIOktZu6uDUpmu+OrzLedZ/e2EFp3SGnhTcInf80Rv/Zl?=
 =?us-ascii?Q?xXPDb8LJdg1k6/lko3PKFOnpvufFZJQfiRcTveVz3SB4honHFnm1TWj3nsfi?=
 =?us-ascii?Q?EwPGmxNaZ44PKuTGWlseU1SydUfFVjaP0DP2dmsFcVvyoRCACaUO6UZSGpLs?=
 =?us-ascii?Q?EGjSeuZku4/84Ro7LNiAUH296k0P56mh0f3Tv/vHpHd+Rmr0sfNEDImLTCIG?=
 =?us-ascii?Q?NI742ZmKbBrxqtzR1HgruBlI8xzFhePjOHIFUOk8Hb8kXTa6KZdJzbfJ3C7V?=
 =?us-ascii?Q?zZtk2H6IlGP1QnMZGtQ=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pdc0D5JUOmZREp3NNgMHdU8g2ACVNWTXYyHazW5CZS8oyOCAIKi3BIhGmXoUd/CTptICqZYkdhjsd8Ed0xMfVS96W+Y/LFYDrN0jA1ZmlEj51DR7r0zzQ+JeqCE1dQeH/y9yfMFvddRYQ22GB062Y7NvfLnTTy5m1jIhlNnoCHpxi6AhsKy+bXkFRSQMppHB49uSGFa2sTvksCuxGdd77EZW/kGcAwkuxILRBveqQEeLrnZkO/GTS8Eo4WRmVBe6BxUrGikkqlg+1c1+59u6GGEAT2eHnf4fOAMwRynUUWe61bUrQ+//H9QnbmBDsi1TioDsnURaMp/1kjILLTr7+EoOxE3bdrsO+dwbvQJeWFjkfgaAhhWSiRZMGHfN0bHAxVu7w87VFV11pHK334YudVxK69pYKDpxeSbo2BivhZlwvhGnOvW200o+Y2QSLqM1BvTrovfO6lyV4/ZhNDfHEHfVqhgX6B5Z8TWChaS7rOX7TpeCdAhfdpTgXDy1CDUem4hcyM1WET3F0WjNJJmIcIbx6T+aZ7YaBM62rdoC6qiPR1FA3CqYTLpTI4pBxNrrIR3nhZySt+paVfcsyqXbA36fTR5+1cICRPlzQ+IwvMtrUpk5bql/zeFSCv7riJYsM9m3erX7/TI3CzcxGXZ7FUSCt3bgWYrhe+lgvGAwIlo=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:40.4935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81232a80-239e-40b3-17c6-08de0ff7d31c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0985
X-BESS-ID: 1760978622-303027-28475-63641-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.72.83
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpZG5uZAVgZQMMnQzMDc3CzV0s
 LSyNjQxNzYyNLU1CzNDMhISTIytlSqjQUA3fQY5kEAAAA=
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-181.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 0.01 BSF_SC7_SG0146_1       META: Custom rule SG0146_1 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC7_SG0146_1
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

Add stubs for NT400D11 init functions.
These stubs will be replaced with actual implementations in future commits.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/ntnic.rst                     |  6 +++
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  3 +-
 drivers/net/ntnic/meson.build                 |  1 +
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   | 41 +++++++++++++++++++
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 27 ++++++++++++
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |  1 +
 drivers/net/ntnic/nthw/nthw_platform.c        |  3 ++
 drivers/net/ntnic/nthw/nthw_platform_drv.h    |  2 +
 drivers/net/ntnic/ntnic_ethdev.c              |  1 +
 drivers/net/ntnic/ntnic_mod_reg.c             | 15 +++++++
 drivers/net/ntnic/ntnic_mod_reg.h             |  9 ++++
 11 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index a173eaa2ac..5375d89a2d 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -27,6 +27,10 @@ Supported NICs
 
     - FPGA ID 9563 (Inline Flow Management)
 
+- NT400D11 2x100G SmartNIC
+
+    - FPGA ID 9569 (Inline Flow Management)
+
 - NT400D13 2x100G SmartNIC
 
     - FPGA ID 9574 (Inline Flow Management)
@@ -34,6 +38,8 @@ Supported NICs
 All information about NT200A02 and NT400D13 can be found by links below:
 
 - https://www.napatech.com/products/nt200a02-smartnic-inline/
+- https://www.napatech.com/products/nt400d11-smartnic-programmable/
+- https://www.napatech.com/products/nt400d13-smartnic-programmable/
 - https://www.napatech.com/support/resources/data-sheets/link-inline-software-for-napatech/
 
 
diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 6d8547483f..4599f78e3f 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -172,10 +172,11 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 
 			res = link_ops->link_init(p_adapter_info, p_fpga);
 			break;
+		case 9569: /* NT400D11 (Intel Agilex FPGA) */
 		case 9574: /* NT400D13 (Intel Agilex FPGA) */
 			link_ops = nthw_get_agx_100g_link_ops();
 			if (link_ops == NULL) {
-				NT_LOG(ERR, NTNIC, "NT400D11 100G link module uninitialized");
+				NT_LOG(ERR, NTNIC, "NT400Dxx 100G link module uninitialized");
 				res = -1;
 				break;
 			}
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 785ac4836d..038c7d90f6 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -47,6 +47,7 @@ sources = files(
         'nthw/core/nt400dxx/nthw_fpga_nt400dxx.c',
         'nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c',
         'nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c',
+        'nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c',
         'nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c',
         'nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c',
         'nthw/core/nthw_fpga.c',
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index cc4bee9d4d..99b317d916 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -113,6 +113,7 @@ static int nthw_fpga_nt400dxx_init_sub_systems(struct fpga_info_s *p_fpga_info)
 static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 {
 	RTE_ASSERT(p_fpga_info);
+	struct rst9569_ops *rst9569_ops = NULL;
 	struct rst9574_ops *rst9574_ops = NULL;
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
@@ -123,6 +124,29 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	RTE_ASSERT(p_fpga);
 
 	switch (p_fpga_info->n_fpga_prod_id) {
+	case 9569:
+		rst9569_ops = nthw_get_rst9569_ops();
+
+		if (rst9569_ops == NULL) {
+			NT_LOG(ERR, NTHW, "%s: RST 9569 NOT INCLUDED", p_adapter_id_str);
+			return -1;
+		}
+
+		res = rst9569_ops->nthw_fpga_rst9569_setup();
+
+		if (res) {
+			NT_LOG(ERR,
+				NTHW,
+				"%s: %s: FPGA=%04d Failed to create reset module res=%d",
+				p_adapter_id_str,
+				__func__,
+				p_fpga_info->n_fpga_prod_id,
+				res);
+			return res;
+		}
+
+		break;
+
 	case 9574:
 		rst9574_ops = nthw_get_rst9574_ops();
 
@@ -183,6 +207,23 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 		/* reset specific */
 	switch (p_fpga_info->n_fpga_prod_id) {
+	case 9569:
+		if (rst9569_ops)
+			res = rst9569_ops->nthw_fpga_rst9569_init();
+
+		if (res) {
+			NT_LOG(ERR,
+				NTHW,
+				"%s: %s: FPGA=%04d - Failed to reset 9569 modules res=%d",
+				p_adapter_id_str,
+				__func__,
+				p_fpga_info->n_fpga_prod_id,
+				res);
+			return res;
+		}
+
+		break;
+
 	case 9574:
 		res = rst9574_ops->nthw_fpga_rst9574_init(p_fpga_info, &rst);
 
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
new file mode 100644
index 0000000000..3d1c09fe2d
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -0,0 +1,27 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Napatech A/S
+ */
+
+#include "ntnic_mod_reg.h"
+
+
+static int nthw_fpga_rst9569_setup(void)
+{
+	return 0;
+};
+
+static int nthw_fpga_rst9569_init(void)
+{
+	return 0;
+}
+
+static struct rst9569_ops rst9569_ops = {
+	.nthw_fpga_rst9569_init = nthw_fpga_rst9569_init,
+	.nthw_fpga_rst9569_setup = nthw_fpga_rst9569_setup,
+};
+
+void nthw_rst9569_ops_init(void)
+{
+	nthw_reg_rst9569_ops(&rst9569_ops);
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 24cfb6c284..7ec33aff2d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -440,6 +440,7 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 			res = nt200a0x_ops->nthw_fpga_nt200a0x_init(p_fpga_info);
 		break;
 
+	case NT_HW_ADAPTER_ID_NT400D11:
 	case NT_HW_ADAPTER_ID_NT400D13:
 		if (nt400dxx_ops != NULL)
 			res = nt400dxx_ops->nthw_fpga_nt400dxx_init(p_fpga_info);
diff --git a/drivers/net/ntnic/nthw/nthw_platform.c b/drivers/net/ntnic/nthw/nthw_platform.c
index 6f2582d6fe..83e1b38563 100644
--- a/drivers/net/ntnic/nthw/nthw_platform.c
+++ b/drivers/net/ntnic/nthw/nthw_platform.c
@@ -11,6 +11,9 @@ nthw_adapter_id_t nthw_platform_get_adapter_id(const uint16_t n_pci_device_id)
 	case NT_HW_PCI_DEVICE_ID_NT200A02:
 		return NT_HW_ADAPTER_ID_NT200A02;
 
+	case NT_HW_PCI_DEVICE_ID_NT400D11:
+		return NT_HW_ADAPTER_ID_NT400D11;
+
 	case NT_HW_PCI_DEVICE_ID_NT400D13:
 		return NT_HW_ADAPTER_ID_NT400D13;
 
diff --git a/drivers/net/ntnic/nthw/nthw_platform_drv.h b/drivers/net/ntnic/nthw/nthw_platform_drv.h
index db2bc05180..a861c8dd7b 100644
--- a/drivers/net/ntnic/nthw/nthw_platform_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_platform_drv.h
@@ -10,11 +10,13 @@
 
 #define NT_HW_PCI_VENDOR_ID (0x18f4)
 #define NT_HW_PCI_DEVICE_ID_NT200A02 (0x1C5)
+#define NT_HW_PCI_DEVICE_ID_NT400D11 (0x215)
 #define NT_HW_PCI_DEVICE_ID_NT400D13 (0x295)
 
 enum nthw_adapter_id_e {
 	NT_HW_ADAPTER_ID_UNKNOWN = 0,
 	NT_HW_ADAPTER_ID_NT200A02,
+	NT_HW_ADAPTER_ID_NT400D11,
 	NT_HW_ADAPTER_ID_NT400D13,
 };
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 42aa2d4095..01b3fe00ef 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -84,6 +84,7 @@ static const char *const valid_arguments[] = {
 
 static const struct rte_pci_id nthw_pci_id_map[] = {
 	{ RTE_PCI_DEVICE(NT_HW_PCI_VENDOR_ID, NT_HW_PCI_DEVICE_ID_NT200A02) },
+	{ RTE_PCI_DEVICE(NT_HW_PCI_VENDOR_ID, NT_HW_PCI_DEVICE_ID_NT400D11) },
 	{ RTE_PCI_DEVICE(NT_HW_PCI_VENDOR_ID, NT_HW_PCI_DEVICE_ID_NT400D13) },
 	{
 		.vendor_id = 0,
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 00eb07f848..ab29a2d816 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -193,6 +193,21 @@ struct rst9574_ops *nthw_get_rst9574_ops(void)
 	return rst9574_ops;
 }
 
+static struct rst9569_ops *rst9569_ops;
+
+void nthw_reg_rst9569_ops(struct rst9569_ops *ops)
+{
+	rst9569_ops = ops;
+}
+
+struct rst9569_ops *nthw_get_rst9569_ops(void)
+{
+	if (rst9569_ops == NULL)
+		nthw_rst9569_ops_init();
+
+	return rst9569_ops;
+}
+
 static struct rst_nt400dxx_ops *rst_nt400dxx_ops;
 
 void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops)
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index b534b09234..62f69d239d 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -269,6 +269,15 @@ struct rst9574_ops {
 		struct nthw_fpga_rst_nt400dxx *const p);
 };
 
+struct rst9569_ops {
+	int (*nthw_fpga_rst9569_init)(void);
+	int (*nthw_fpga_rst9569_setup)(void);
+};
+
+void nthw_reg_rst9569_ops(struct rst9569_ops *ops);
+struct rst9569_ops *nthw_get_rst9569_ops(void);
+void nthw_rst9569_ops_init(void);
+
 void nthw_reg_rst9574_ops(struct rst9574_ops *ops);
 struct rst9574_ops *nthw_get_rst9574_ops(void);
 void nthw_rst9574_ops_init(void);
-- 
2.45.0

