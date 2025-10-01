Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA1ECCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5490440E39;
	Wed,  1 Oct 2025 17:10:36 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 2E79E40E01
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:33 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023106.outbound.protection.outlook.com
 [40.107.162.106]) by mx-outbound22-252.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk75TNgD0SVahdOXOl4Zh05TLUgwAqT1VCH50eztV6lN8Cw7jtxNANQS0gGdp7oLjzYXBwzyTDA9W6pgEPy91zACEeVjJCJ1jVveWKVAIUnEy5Kp0gsGuwzKKGCKTN3En7P15xVvY7oQdM4dyLaPKrf0Nljkexck0Ak7Fj0CJiOtOrDT7/ylAaQ1eD+YLhjaQrcu+FrGIsEY0A6P/2ka7f9i9dAnA4OLXdTrptXI2qif+pJtWkJUBM4ZRixs6Sj8SRhTLVinar5qpKixO2U6MoYZ6n/g7pqUfOVcr8jK76VEjtyGz07e8Yu7H9EDL2rOWLMOkoGnB1Ttso9uiZjrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWwWprbEBRSOxORP4LRNj7gxqAU5zUKefrBbHXYrBTM=;
 b=gu0rAkWf8c/E4Ewvf6s5uBgwd4+kxITVJNFNLY50zaeTIxnm0Z+K71jUBxEN5sv38MG+cUQuBIPyDH0X5oN8If+Z8UQC00xDta8lelX73pFFD9+65livGdKLLK5GpuY1PxMCy51k+TnqYEqnaVO7Q1EGFta3ChfUhIvXP+wX+FN3laCb4laLlWiWjwwvy/1WIfvfF/5DRc7mCqu6FzHW71LsWa3ugArhFNQiLmG14ch1iEqoXJWH0WFXw183JtcrnUL2DhXoz2y1WkKElyeIVCnW3DqfNcBUFP2SiQX9xQDZOZ7jVo80YM8UVgaW+N/QAFvju9CaIwG0Q/kfCXYHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWwWprbEBRSOxORP4LRNj7gxqAU5zUKefrBbHXYrBTM=;
 b=m/Gj1OCI/mgdZNYFRyGOg51CYUTC7OXRkF/f2412fBi3XNVbZMZadOrvWks4Z/usHj9o4AP3fLGKrr5spbT8dT69iW7JgphCxjdydSaW3jz+GBr7dtGvZuNosjN04MpoyyZCCge9E+sVzW7Ow5tB8bjTFAEDrrSCQmlnRKgZsB0=
Received: from DB9PR02CA0024.eurprd02.prod.outlook.com (2603:10a6:10:1d9::29)
 by DB9P190MB1353.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 1 Oct
 2025 15:10:30 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::6c) by DB9PR02CA0024.outlook.office365.com
 (2603:10a6:10:1d9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 15:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:30
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 10/20] net/ntnic: add reset init stage 8 for NT400D11
Date: Wed,  1 Oct 2025 17:09:52 +0200
Message-ID: <20251001151018.250671-11-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|DB9P190MB1353:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d5d8bff4-8526-4908-d71f-08de00fca963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?POHo5yRrK4CeA+3r7E8J16Jox6k9oN14heygbAtaKVJgRZGO+/kuU78PkaU1?=
 =?us-ascii?Q?8LJYziID5HxttHfyNUbg1VFqKM749VLFg9C6rTeua69CvHBRX6TevCkyCKn3?=
 =?us-ascii?Q?LDP/Ya+ZkFudSZn+ph/y3L8e5MOSVgyVD6qeaNkmvWF10oyaTrtHG1t9nFKO?=
 =?us-ascii?Q?Z0WsfA//XFbjX5PZjG4OWJ5N92l4EU/HnfHO7IEonledk/ZLbbTnsQ7L/RaS?=
 =?us-ascii?Q?436ulikff2tp8fl+LUkKXq7NF3BENT7yzNnkcbZ7gco6aS3GxqY3BWyFlJVR?=
 =?us-ascii?Q?9yk5IINCyWi+rFauPM0l0mwGJ8jx5xHz58R5BSXHMDQB/OQoVnnqo7Yse40t?=
 =?us-ascii?Q?VrTxae7gIxH0eE2Ea6g9y5FKsxgJNgY/Nxqh6+ZfNhus1QnT04Vb0zFoQ07B?=
 =?us-ascii?Q?W56Qj8P1M9wKyeTs1EwSqNMWXqKoeNXaj+R7KwB/czc9SV6uKqUjCogUFhUI?=
 =?us-ascii?Q?d4EW6rKK+34jOZTaVjL1LHujJUXMQwpr0M5mkPvI43ka4NWZDu8qWTehTYBz?=
 =?us-ascii?Q?0XqRy2HHdC/vLMePQYA8742fULooYe33bEaaRH/UdvNHBoqP8dw2IBLZfNkt?=
 =?us-ascii?Q?L0VnhS7bbaleSdfVCBDlsO1/K0M9aPRHv+d94cdCUduFHMXD46I3xrYfdb38?=
 =?us-ascii?Q?rStclKQ9+T9pYCo8mNRv9H6cp1MIgjg8f0reNxUwGaMPSl5tLq6lHor3Et4k?=
 =?us-ascii?Q?eG6a+fP1wSfdrIbvmtwH/7vFTMrBDQqGl1Zgel576+N3trKqfKC9DGZBBTa+?=
 =?us-ascii?Q?eBEhvzkter1x654hHnuQnW+9HA0QLVTp7lZgqdV07kIkoqKrn1ssMCpmVDwR?=
 =?us-ascii?Q?2PfzDEwHGxD138ukDVxW4KB61Jb4AHSozasWS2ZyLgJCpL8IjiI69QBKceQX?=
 =?us-ascii?Q?ZyeW/FbYxlcwft8hra3SdIAQMSjL89BoWW82wPhfdQRj8+lqTqUeIpWfEJKR?=
 =?us-ascii?Q?zVc/G6oHofeOBAH7G59BbY9ChH9o2pcUHecWlTQbQRbtXDMa55Y0AHDbo0g+?=
 =?us-ascii?Q?QQ+J3CMUv4VOHOFBcI6thqUfsCXhCK6OU0+nOB83dT1tsnWQGUZTsXrl7i23?=
 =?us-ascii?Q?IVlAO62+b16uGVJ4wruEvQTaHXwpUjonxDCXOxEtigVMXfigTKn/K3SEJNIS?=
 =?us-ascii?Q?YUVOO17pfjT0BzsjqZpJpHw9oZGxEdpsbdG2r+H/52N2JtGuptBO0Z+BDFou?=
 =?us-ascii?Q?IJn0YWQQcMIez5Wn4nZjTkQ/o4mnTjju7IOh1usDXaQYWyfPHG4W3xjjQjZn?=
 =?us-ascii?Q?0gE2jH3yD/6PvjfEnu3YzMIgAcXZHbJCfSg7bLnBAigVC6fZoUH4NBoE/lMN?=
 =?us-ascii?Q?M3VL6QDYPGBRoCRVs7t2v5RALxEbnsV82aHxtiApzfU9+PCyeSF1sj2vwzfy?=
 =?us-ascii?Q?FTBCkPiXQTVXgCDmNjTGV7Xqi3i0kEwILPah1exppp3gOvgGvdSJN1UsxFvV?=
 =?us-ascii?Q?Mdwh0KV/QUqY60KZMnK983B4rT1oUmyiDp88OZG+MqUaqR+Z5iPGnfaSguSz?=
 =?us-ascii?Q?rOAw/nRzFHGwBjXc2kjE9ABO2djxILx3kOe2CLHKtlopjlWCxL7T+8qIvvBz?=
 =?us-ascii?Q?wwiJN1IcGO7Ht+GioVQ=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C+RV+6K3tBhrBKUEaQk+YCxumdRjRlW6HNbcQUKv5N2Ii46bOVholTcr1+JVo/E1fVYkNSMdJZMhTuYT3MZPdh6zjivt378E8J7kDuaoDyXnJYwA9YxzDDf9M1ZeGBZ9v8lpc/R4hKLLt2Wo/2ZI0pSuis65Co2rlusnPO4AXWYKoD/ifgcY9YU0rs/m0enHJVZO5nSgelscmjpKxd94u/q9AmSfzaecMhgdUYSF4ir/q0d9549fGSisd9Qn0zkp6xCkqreVaKZs6rw7+bO/UGCPPBbJ0v4c/ge1pvBSVUQI45hZwT7nzMXR064JPvvS14lx/JtnsRB6rm75BvOJjn3cL612O3zG7h05gKYR1kr6ock5RvWFclCvZqKEgoiEZ/xoxyUqITo2qOysbr+D921S6JoecwXtXA13d8DSgH4QzRST6+a46H6MUu1doY/mRFt6rdyX8+nwJEmZFz4eTQo1nc0plmPPkg020iAw0LVD5a+VuktaZ5DqPvfaLR9/LSy6bYB+zq44jfK3gdUuVACBzGP8H8Cqd4dPpKyFXBm8aN96dh/+TOipRJ5YTXm1GHUGyE5ahCKxy4YwcW8en0hhVDmm3tMFEgfN/YT3eFuIeizXqMVoU6u2ZTXXZjGdTsebDFai58TF0YNKhpCdYA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:30.4485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d8bff4-8526-4908-d71f-08de00fca963
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1353
X-BESS-ID: 1759331432-305884-7636-4378-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.162.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGRuZAVgZQMNUgLcXAwtDI3M
 DM0DI1yTQ1OSXZ3MjANDEJyDEzNlOqjQUA7qZbe0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan15-63.eu-central-1a.ess.aws.cudaops.com]
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

add De-assert SYS reset

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 29e32ffb22..f2b064f054 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -73,6 +73,12 @@ static void nthw_fpga_rst9569_set_default_rst_values(struct nthw_fpga_rst_nt400d
 	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, 1);
 }
 
+static void nthw_fpga_rst9569_sys_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_sys);
+	nthw_field_set_val_flush32(p->p_fld_rst_sys, val);
+}
+
 static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
 {
 	nthw_field_update_register(p->p_fld_rst_ddr4);
@@ -345,6 +351,10 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 		}
 	} while (!success);
 
+	/* (8) De-assert SYS reset: */
+	NT_LOG(DBG, NTHW, "%s: %s: De-asserting SYS reset", p_adapter_id_str, __func__);
+	nthw_fpga_rst9569_sys_rst(p_rst, 0);
+
 	return 0;
 }
 
-- 
2.45.0

