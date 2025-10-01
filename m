Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D2CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:10:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B223A40E18;
	Wed,  1 Oct 2025 17:10:29 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4E0C040B8D
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:27 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020089.outbound.protection.outlook.com [52.101.69.89])
 by mx-outbound40-101.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2kPdYyk60qMUcmKz6pP70VEO3ZVuXU2y3yYv6c5sfygDimucyKel+RaONuc8Tf10zqPf+0flSiZKVuHV+Ao+JkpfYGG/iBH2hV+zpTcerd0B3KKN0PMNY/SW5ZIzFY42nGq1FKZ3wNKCsMeQOGn9mxAKLXjFCVuLbRSEADLaABQm55kHaU431HbrwGMubM/ycX1uVBSG1a0BOuJowpGd7GLaO1Zie/dhVr2hoQrvNqbVKZjcGwq3LGOX8holwQhdTrHIgjjFEgk0sxNXKe29+gavKJVJt4NLfaxXK+w/QOA9p8lOODI/Rw5lL2jk7ZeS2v/N6kGDEnwBteD8S090g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QheQmFWV5ZBLCrdmDd17jobeq9tgE8ENnqvqWlZxJk=;
 b=m0DGNympitLl8SyJJyC/aUj+4Yu0Ngr4Ok1p40FewJxXybGW91/dX+psO7K/WEy0WGKWU3DjbW3QPNWqcB6O6AJuK1Zp9XYsLArQK41PD60yGIZUgLkC4y/0BdO2QTbW9D+fDJUy1f1kTVku+5KCJt1mYCVJ9SLVOhalUA9H3G7qkLTTcOP7bc9en0gbagVvnOUBw+jqV+9/J0I1ci/Y/GUuKzmV992O0izPRjd77GK8yISBqpAXhyRIKa14m/5d567gdWdFxQA0O8hDnGhXfOTgeLqYwoCOoR3ugqD9qNKCJ5Lfpmh3vXh9dNgWMS3pIhN+PvimUBSTh+NcLSmg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QheQmFWV5ZBLCrdmDd17jobeq9tgE8ENnqvqWlZxJk=;
 b=D0x9jOXS8jL7B84/Nzv/dYvwQ2b9wkRyKWfXvbuRb4q29IAWtOCNJD9rC1y0am9D9Q0vHc2DolukBR5PsxXNYTVmfWZpdOnvhY4DFnP6c5HMfvjTnLEN9j2tG8fMkN5VMUY3OhAYkKjVP49Xpzp2Ue0uRQUiEnaiTWqEqV8gUAg=
Received: from DB9PR02CA0004.eurprd02.prod.outlook.com (2603:10a6:10:1d9::9)
 by PA1P190MB2291.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:10:25 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::74) by DB9PR02CA0004.outlook.office365.com
 (2603:10a6:10:1d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:25
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 04/20] net/ntnic: add reset init stage 1 for NT400D11
Date: Wed,  1 Oct 2025 17:09:46 +0200
Message-ID: <20251001151018.250671-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|PA1P190MB2291:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4872c6d2-a090-4a75-e1cf-08de00fca62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kpt1yphQnKsoBSeEUa3gtrkKh2Qy/tFovuIcOcID8olDtUXfY+VszaCK10hO?=
 =?us-ascii?Q?kEJ6LbZpZQusv6pFJk10iY23AYKbhW4ptZu91BqVCIcW/QLzM2V59LdXTKLi?=
 =?us-ascii?Q?eCxJmHOdx7HIrnGRjz+w0rTX/0upnCE1wgJnM2HjVexKU/d1+Dar5OQJmC5I?=
 =?us-ascii?Q?LZLX0qsDY74OOaz0fUhaxbVJ3woe179AVVEymktXHrcbtzRRAx0ZiePDCHzW?=
 =?us-ascii?Q?aEVyXHYsXkc4vJ+lIhYvGvj8PACXcZcd97Azy3kSU7f7CwDG3pR7IDuYhIVs?=
 =?us-ascii?Q?vlt7DS6WYprsryAeSQvVBm+5k9SY2w59NSVwaV2HbriucJyaCtJDEhfsM6uh?=
 =?us-ascii?Q?WM/FS2USCoYgC5oO1aKuZxh1XlCWnUHxtbb2vL9aYAtRm5Ika+P7BYMDVs2P?=
 =?us-ascii?Q?XDo4t59ajdygMksZ0O6Oeqkf1XkhuM5Y5B0jYweThQFZJhFcSuw1C1h0V5am?=
 =?us-ascii?Q?FeaKmAlJVpp7LlcmHvKsD746ZdCfnjM7zo8umydzddNUa4kEm+92bYySKXV4?=
 =?us-ascii?Q?zR89cKT547jrlv3luw38sjwCQaKifzlTv2TKp/4RFW8R+y/XaaIRUNc43A9E?=
 =?us-ascii?Q?WJT/lMSL7nInuEsJQCJCaC9hRMIDOo3TTX1dFPsRh0pmTbmQfxCnM4iWDgRd?=
 =?us-ascii?Q?lYJmDCi63TyaFuqW/t/g/g87YKQmw44TpVJny2JMiPRNzvUrYeKidC5CB0d2?=
 =?us-ascii?Q?x2Nap++4JkSvQqXEF+cV2ErfZZ3xAx1/w4FhcVEfg2e3W/Ef+e5aJB/XOCAz?=
 =?us-ascii?Q?35KNwcVXB63SeVx7S5Ki5EIwta3vhC2UAZU9R5MCmJLxtrh7TaYBxHjK0iN7?=
 =?us-ascii?Q?TVxhoOuBZXs1/HSyH0kDqLfI61KI6ctA1DwOxRXsMmjDVmDw3m5jhBuSGNeR?=
 =?us-ascii?Q?+GuFQnw3I/z0wqB2vGEp3dkw4EpBaSVHkDowkbefz6a2irClKavfTA0TT2nO?=
 =?us-ascii?Q?+i7fs/SjY3qd5P2QdcOcSfnNioRWDV6TOnLZgz1fTn2J1en+vqLS7//DuH3D?=
 =?us-ascii?Q?S9cDV/63BS4oy/Cshh5EE3eyJiRKy6HFHKOJ6YpCgsij5M2n7I+duK8xhuWa?=
 =?us-ascii?Q?ZcX991L2MKOC2AeTOh6a7fBL2hbmeQKuDvWGAljs5wZYvZx3HWYgznOtnMS3?=
 =?us-ascii?Q?HsIxtgapf7eZxh4VS4wKX+C4fsWpHsImi2yM1c91er4JYKUmQzSZgDVnvTKo?=
 =?us-ascii?Q?GDjhB6NQTipiRHYtJs2GfylP1wIp7W37I1vxCzz/HH9gx/Vn5Lr363OxCCgp?=
 =?us-ascii?Q?5V/nlvB1u8QmZYKRpFzljYy+yE1iaSYEg39CBvq6ONEtDhrhqEBekoRz+bgY?=
 =?us-ascii?Q?Vi4G6p98XFRP+W9zvFWkP3w+xnvhD3HNkVije5xUCIPNyTmO5bbm1A7JmX9j?=
 =?us-ascii?Q?i0DqBdzB59Iy3yvQRKwouhvzvKGMCKkLokMe9iFgXFx98z/QTn5Cv4847sR+?=
 =?us-ascii?Q?0Y7f8ObMib/lBiIQTjsfw9PZr/Y1QoMhqnaM9yqzHanm9dumjLgWnM/jBQEt?=
 =?us-ascii?Q?FNFfJBidojV70G3+wL6J3uJ6rVtzxZ+uwE/jkplulnAYSxL4K0GU2seblw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w4TzJqIc9Dr1K8aGfPrGDD6Y985Vh/oJdCTN80l2GPzKJ8I7rEMkPLpPEHrkTufs6v/VOtKlwOp9M2vweFw4fTn8BX2K/K59pmifxrf1FMjLiTDxY0e1g8c9qwj3nVPxqbzTl3Zg0buKXkfW1M9SwpptnwrjJo5RpneR+BucIlkCzTN3o2po2IGuEVvfYCZ0laA4xAfX1JIC2lxQoZL9PBibls5Yex07DT/2isPdovT1rhrViLY5//bpzjPf6CuxjxsdZinuxjrWw0fSWcAQurmvS/zWQXVSEQabj4duEWh8S1XQ5kMMIpOHSI2HtmHT8PvwqJcfbKy3wCjNPX6IDNf5uJoZKr0rkHq3HvuvlRzSG8NhinL1//zrV5hyKWq4Gw878ZSkG7xrswv7FUTgEUFsnHH8yU6GMr08bFUgqNojXqnuzKlqA0Ho9QzB8sZscxyyZ6Nh3pIfTyfR7dlSAxoJfoxrRuh1vqvSHKsinxnqBIFtVC/ZGdlBCXmEqdF6gG+94CIj6R4BM5ts4NPVx3A2Mu//1sktYd5tvaXYTdz0ptjBVsmhAtcNFxMSGawBJlAWbvs4t4DbvX48XLvTQWWqgjzuFUW6kZp93DFrUvjtufT9oMGV4d1R4+ae5KKRbNEBFCkHGnjqxom+p1GI3g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:25.0586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4872c6d2-a090-4a75-e1cf-08de00fca62d
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P190MB2291
X-BESS-ID: 1759331426-310341-7711-4260-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.89
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmFmZAVgZQ0CI5KS3R0sQoyS
 zZxNTCIDHJ0CzRzMTA3Dwx0cLcKNVcqTYWAOACkYRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan19-113.eu-central-1b.ess.aws.cudaops.com]
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

add De-assert DDR4 reset.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 6a6660cabe..4205e539b9 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -73,6 +73,12 @@ static void nthw_fpga_rst9569_set_default_rst_values(struct nthw_fpga_rst_nt400d
 	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, 1);
 }
 
+static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_ddr4);
+	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
+}
+
 static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -85,6 +91,15 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 	NT_LOG_DBGX(DBG, NTHW, "%s: RST defaults", p_adapter_id_str);
 	nthw_fpga_rst9569_set_default_rst_values(p_rst);
 
+	/*
+	 * Wait a while before waiting for deasserting ddr4 reset
+	 */
+	nthw_os_wait_usec(2000);
+
+	/* (1) De-assert DDR4 reset: */
+	NT_LOG_DBGX(DBG, NTHW, "%s: De-asserting DDR4 reset", p_adapter_id_str);
+	nthw_fpga_rst9569_ddr4_rst(p_rst, 0);
+
 	return 0;
 }
 
-- 
2.45.0

