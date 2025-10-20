Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFC1CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0E3B410D4;
	Mon, 20 Oct 2025 18:43:55 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 1E6754067A
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020120.outbound.protection.outlook.com [52.101.69.120])
 by mx-outbound9-130.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8kwlFTG8gK+TmgzCzCbMeWEKtjh35t3knftle+k5WdJeLBTO9/Ue/FZy7JElhKs7yKSoID2Tda3mRKOj+JH09Y6EorcOkATeo1YvnHStHp4mbnOzVLd1wY0HeXyJGhyzWnKNF7Ky8v7VYheY8jutitRBqMSm6Lz4dMvmDhQOF+AOed/ANULl0S1AKmkDJHKcgg5gdan49iyfPj/or2bIY8iDI1KlHSDpe9zb2bmRfeA6sfiLgwHSqF1eyHOhwi0pRV3JMwK3HoaLzHYJSLjONq4mNXKSrNFwCSeU/jjUGKPa4OnykzdPRj5BXTgV+lW3C435x412zE+qLCE7ulRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPUgpG1AIJLMHXU8KQLhh+71EG9EpwJsYAeq4+9AGw0=;
 b=nX/3ITpmn3nA1L0i8rYZr9VaBVHpZ9Hgk3nUgmLIvWqd7099cqKYQHoKc8pZzg3hFN3/obA3lt0nDcXVABYBwsIZQ2R+X5fB6GWCQhvKA0RZdsEbHH6wWR9oy+vAknIH7kQFRbdR78tA7xrDNQ8lj5da/TQw4zLz+cEvElB3Zb548T+VMNg6ktRr+/f/K0KQ7lF8RJjMBUxBcHkoDWEKfscHUm9dJCcdsZCAI1NI3Wxlg8URW4dQidpqjYApqLb6bMm5+35Otb0dR8BGiag6WETk5zv7UK2uaqzflBE25f7FlhvctipnlzI8Ydiw+p4wzxNlyMZK7Kp9ECvs3pX/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPUgpG1AIJLMHXU8KQLhh+71EG9EpwJsYAeq4+9AGw0=;
 b=aB9VxPTn0g+0TomZp0AyUGJyyOe2JYsg4vn1meOySFPN/ToqflnQAa1XFSOONeoDudS1bjMW2L0KJ/MQJjUwuaugO4kCAhPEdt/eRQXQh9eTrSo+sLXUOZL6JdcYJ2pVVbsjYBOPHjz8cxOsSnTCN7GJ90JbeDmaQm8C5WJEQrk=
Received: from DUZPR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::10) by AS1P190MB1752.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:44 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::c) by DUZPR01CA0019.outlook.office365.com
 (2603:10a6:10:46b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:44
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 07/21] net/ntnic: add reset init stage 5 for NT400D11
Date: Mon, 20 Oct 2025 18:43:16 +0200
Message-ID: <20251020164336.283664-8-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|AS1P190MB1752:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 25c557be-48d6-4430-c491-08de0ff7d5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xb8w/d3bBbhZx4kC59IC18OX+6YuF9vGNB70nSX+eS/PnaureBi+Snav5JvW?=
 =?us-ascii?Q?w4kaluHzJk9dhCzn05j1TyPiriXHvM/+rj1lDSBxTOaZmIvcVLm1qRQhsPAl?=
 =?us-ascii?Q?MPkmeoxzvwZRjSBIPLRhePOn1EySGAjhvWQIOO0FDdp6GoCO/AMghTha+qve?=
 =?us-ascii?Q?5CYhZqAHlppoI6kwco6ecyWV1vzIeKX0s8d6ua9C+Zl/RYeOF5cSEVrFW5Nl?=
 =?us-ascii?Q?6biiEMk1Z6ZWLefTcx3SrwwjCDkvznzS364ATRtsmRff3NfUU/8pH9vxJsTc?=
 =?us-ascii?Q?4WffPTeBx3dctUl/6+eV9u9qIb0s4nWUw5gzXwQ3pRdZgeNH1gui56HbFfuM?=
 =?us-ascii?Q?J67n50KhEWLyYqT7DKii5etr1OnEKZ5/VzbzbYd1BU5bvS+prnMoE9OuKrXj?=
 =?us-ascii?Q?1r9WCs1PhFQHC7l6HB4As7lVFJScEW1UMfXMTJ8jb0VBuy7z58d0n+4kOISG?=
 =?us-ascii?Q?xUdoWSI58yoxSTg8gNO5zCSADWW2DtN5/wWF93sZqnBRJqr0yAQE2MKyF0Uh?=
 =?us-ascii?Q?SDbZ0DdOXh6KMi/OvoT+6z9rR1TqjzkfkiD0EUj/7sGvh9DiHrP5y95sFypd?=
 =?us-ascii?Q?igY6pXMUWteQGlQckrwm8C9KHgHe0H6Em4hIU8J603ZvXVrdqhmKjTQ1fiMW?=
 =?us-ascii?Q?y6UMeQTtLbUoDCp02QPmbmXnaewIZje2YdCiXJxQSyfQugTNEAcwkjU34hEj?=
 =?us-ascii?Q?CvqRlBZsI/y63XrE2T2ahMPCjUOR6Q8LcQWJO5Jqdq5jmptmzVW5nOHeINmo?=
 =?us-ascii?Q?Wa9L8l6oMH4yNzlDlAWk6kO362auoI/lcJMZZI7atlx9FA9UfUsjlRaNsnDl?=
 =?us-ascii?Q?XjmsCt/Gn/LBgmwCf+Qe9T+g10V/sA+fcxca8KeZqUefWi6ltx5iF5v0LczK?=
 =?us-ascii?Q?g3nQ9T7tNBXE8bieAz+bDebdDpE8qPo7LCsFUwrZfhEj0Rb04ENrgKStd5/y?=
 =?us-ascii?Q?ne9okRciCjTWPl/n/juB/W8gYDmvlOoMc+uPASkh+CkupgcxMDwZ3VWACHE7?=
 =?us-ascii?Q?8IUlexQsHIKHdUaE3m//VT3cYn5KDRMVCL0vGJNDXHe2ItTE9OeiK9wPkb74?=
 =?us-ascii?Q?nx2apHJ7jwIvoxHo4tP+wDjrA/3MNObfpyvuXNn1KpVL0budHPmgZ4oes2nU?=
 =?us-ascii?Q?HQwoNh3yKOAYSZ6Q0JFh7TTwcLqPJJ9rWkvR0f7mGc8pQEoeGWR3DF59MWqo?=
 =?us-ascii?Q?HWeckvyouUxdZhTntar0Rz/SwWqAjpHX4YG7l/6ULdyUapcF6n//UUaCs2bM?=
 =?us-ascii?Q?ac26CTM5ZB1Lr2tt3lmoa+lRqcd7FeQfJJ9KtlYsdRkdEh+2aLejeAFXPh8e?=
 =?us-ascii?Q?PQrIumOiEyJ57Swy4mkhyVDYKAWNRelK3JrYUXkND5Vs/erZovnoi8TeY51A?=
 =?us-ascii?Q?KndWti8PsGXxZ/xQciQ+FgQvhKAEbkBfmhK46v/KSbdm+HalWm6AoVEWRz+f?=
 =?us-ascii?Q?U03EBh8ZebVEOFiOzZwFtp5r5zyLq9cF1U6ZzYk9wAUx5doiAxBc2Tu2Nq/M?=
 =?us-ascii?Q?oHdys4O5ZN9EObu15SNwW+GmiekRypbGjmQO+utrq5NTMg1fKICQQach5os2?=
 =?us-ascii?Q?u1ckuXAzppjh5voEQeQ=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r5okAYavVt8gMwvuhVT40Y5GjW6V81QO87CwVu2AKRtmzJyfEkLAJXuFb9vmbqzeOuU+Yh+LTXb8FrrBl4BSdEB2WhJ+Zju9YWE3tv6O+xM8ICEl+z7d6oonKqCODsqA6ii/0ncJSLnuS2j0V+xrbmxaKty+n8SK7bsdQgxXO1MdB7P7Jof/1tgMXQK8vu0n8jFVgxKk3iiqwj7k3nt7Yv5ciI0lIYxivWxtLaalPDD2F1Lj222I45NelExkjCc60FU2fNGAszS8m1KwoL+o5KMXDLTU7Kgvv/CPZAhDBsqr5Iceh34XDKrXEqVzcvgg7Qz1ePkw4rSNMNVszERkAgwxvTEtdIqzXe9HFD+BMf0a5S7aeH+2ZK4lst9gEpYktATCEUqpib0meC3K+b2j2SCERjA1tjnp94UUAHlYQHhT8N2lqj9QR2scAgICoGqYxKQIafyMuV0eNxaA2b8698yVGVxqVrJSY6ts9AXRtuGkONXcuS/xtu/v81a4o1vpf1kfhMRmR3Bdn3IEj0kr3DYXD2D7AgaQKNrKQzoIUFe9Rvwx6WHqQicurjMSDRuS8icnsctUar+ohLI9Xz8LJzE2WhPwBMLdTscsURf8SjxC5KkWyX4yCDTgU02UUf50SH0ePUgauoIHEWY99QCLlogGbEmIbpbXZ9TcQ84xYG0=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:44.7549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c557be-48d6-4430-c491-08de0ff7d5a6
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1752
X-BESS-ID: 1760978626-302434-10209-72925-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.69.120
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGRsZAVgZQMNU00cQgNdnEKD
 E52SQ1zTDN2MjUyNgk2TjR2MLYKMVCqTYWAIB5tq9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan9-254.eu-central-1a.ess.aws.cudaops.com]
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

add PHY_FTILE reset.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 62 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index e416e739da..d8c1dc4529 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -79,11 +79,26 @@ static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, u
 	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
 }
 
+static bool nthw_fpga_rst9569_get_phy_ftile_rst(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_rst_phy_ftile) != 0;
+}
+
 static bool nthw_fpga_rst9569_get_ddr4_calib_complete_stat(struct nthw_fpga_rst_nt400dxx *const p)
 {
 	return nthw_field_get_updated(p->p_fld_stat_ddr4_calib_complete) != 0;
 }
 
+static bool nthw_fpga_rst9569_get_phy_ftile_rst_done_stat(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_stat_phy_ftile_rst_done) != 0;
+}
+
+static bool nthw_fpga_rst9569_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
+}
+
 static void nthw_fpga_rst9569_set_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p,
 	uint32_t val)
 {
@@ -134,9 +149,33 @@ static int nthw_fpga_rst9569_wait_ddr4_calibration_complete(struct fpga_info_s *
 	return 0;
 }
 
-static bool nthw_fpga_rst9569_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
+static int nthw_fpga_rst9569_wait_phy_ftile_rst_done(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
-	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	uint32_t complete;
+	uint32_t timeout;
+
+	/* 5: wait until PHY_FTILE reset done */
+	NT_LOG(DBG, NTHW, "%s: %s: PHY FTILE RESET done", p_adapter_id_str, __func__);
+	timeout = 50000;/* initial timeout must be set to 5 sec. */
+
+	do {
+		complete = nthw_fpga_rst9569_get_phy_ftile_rst_done_stat(p_rst);
+
+		if (!complete)
+			nthw_os_wait_usec(100);
+
+		timeout--;
+
+		if (timeout == 0) {
+			NT_LOG(ERR, NTHW, "%s: %s: Timeout waiting for PHY FTILE RESET to be done",
+				p_adapter_id_str, __func__);
+			return -1;
+		}
+	} while (!complete);
+
+	return 0;
 }
 
 static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
@@ -187,6 +226,25 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 			p_adapter_id_str, __func__);
 	}
 
+	bool success = true;
+
+	do {
+		/* Only wait for ftile rst done if ftile is indeed in reset. */
+		if (nthw_fpga_rst9569_get_phy_ftile_rst(p_rst)) {
+			/* (5) Wait until PHY_FTILE reset done */
+			NT_LOG_DBGX(DBG, NTHW, "%s: Wait until PHY_FTILE reset done",
+				p_adapter_id_str);
+			res = nthw_fpga_rst9569_wait_phy_ftile_rst_done(p_fpga_info, p_rst);
+
+			if (res) {
+				NT_LOG(ERR, NTHW, "%s: PHY_FTILE reset done failed",
+					p_adapter_id_str);
+				return res;
+			}
+		}
+
+	} while (!success);
+
 
 	return 0;
 }
-- 
2.45.0

