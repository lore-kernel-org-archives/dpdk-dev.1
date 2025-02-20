Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A44C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FD6440EE6;
	Thu, 20 Feb 2025 23:04:57 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8DEE340E1E
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:40 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 mx-outbound21-132.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGvx472+EYafb04m6XNkpzcVgTsax2TJPytRFdMPl0R92yuw8T33Rv+cTuCBgYPE+rcTxyfBZrbJQwDfxh3tToWdNRkzJt1fdk9cmnEuwhqwYTmFvanVqtJJKt6v0zW9T9ABW3WgsNJk8CK6GCGNqZQoWLC4e1JWbHuGlHzRGlgXAuXIV4SFsqr9xtiPSTuoVpgAtcnhTBZjC3GXWa2cfAmKDjUIakqw6pPy+6ouxHDhMkzvLAawehRp4ieEiPczUlE7luEe2oyxTZYKXPgMZS/9uLeVlHsVoa6p6Q6vTLwDQ/49OcT2FvnKhbdp3tUeklq+uJgUfR9Q4CTde6ITtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPxrKmhAGgoQZBP65Cm7nqAzJktkrR1xg8rpruGEnZo=;
 b=Fs5nNZopgfEcWDUH4XXg8AxqEmvoji4V/Jj9LDr6/WGP7fSDqeCmOciVpNsebXzRwEq5AxOD77/PDBgK33K36HUjNS0CZaJ9aoUyIgCujl3iQsKcZVAckrAbEC6wrDF7jd6+xYQDJQyiPJrepo/vpYZvVoD8P68Go61zmj7Zvcs7i8qokf/o7eBAVIR46SpGAIj1UX0U2C7mmgwlIU4NinKOHg3qrkEep8QPmYKXoaZpltPHtGlTos9YBeRFgZ/nTYju0uCZlH0pku9t+Yc/I54siurnnZnrngTOUhTL0Qgp3ab56kqztnoTsiTMVVurjY77Ev/5ZOdyV+o3EefSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPxrKmhAGgoQZBP65Cm7nqAzJktkrR1xg8rpruGEnZo=;
 b=jHzoHYdHfWVsd67WFLgQAgQGUGGIn7+LjemKVts9ePtGWS/2c/bYml6i4e8HSD/80/kQs+p6t8PV5o3RGEn2J140vrnNk8RMSmtPCBLRKIZsO2aX0ucuC8vXwtp71nUBTTM1GX4kSnQ2xdyFmj7iE39WMqoR8S2NmiJJQWJK0D8=
Received: from CWLP265CA0505.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::14)
 by AS4P190MB1949.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:514::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 22:04:37 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::f7) by CWLP265CA0505.outlook.office365.com
 (2603:10a6:400:18b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:37 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 31/32] net/ntnic: init IGAM and config PLL for FPGA
Date: Thu, 20 Feb 2025 23:03:55 +0100
Message-ID: <20250220220406.3925597-32-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AS4P190MB1949:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f9d2970-ab4d-4a7f-82ba-08dd51fa90e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4Ug/YThtE0SMGtw6Cz1iSYTPWI0pHDI8vTFYOiHmmcF7ulA0kvli/ncPNAc?=
 =?us-ascii?Q?f/V0OW1TlxSbfMFRZXqLH/d9uibbHYI11z4SmxEgJMfMJaGhlNy0CrH8lyLP?=
 =?us-ascii?Q?pP+NlHtnY1OuhUWlDBXp8WC2/x+AoIqnkkCAPjfsQ0RoM0lG3RVsvAGHgveF?=
 =?us-ascii?Q?etNHmi+dqoztLLB7xu6iCPdj9OKljmYk8eCrlmgrfIK440r9n++O8TXKlK7/?=
 =?us-ascii?Q?fGvJf7WUTpIfsb9sGO5g5fDg5tz99YMUCE5xp3odZ1DXopzGfeo87RJr4eL3?=
 =?us-ascii?Q?S0PyrmzJdx0yut8Z4xGaMa9Al9gna2OKSDsyeXVAI0RhFom5Ps3CEy+/1Q1U?=
 =?us-ascii?Q?jTjtxRC/r3CRSQKGLYM7GluaZV6tggCS6qcMBkJe+bN31JNx+3JfLn3JIQXd?=
 =?us-ascii?Q?RsAot0IT/A5AYywmjODsEg5K8cJi2Bxp6KVVRfYuDGxlBm5qDtwH0VS6DTAm?=
 =?us-ascii?Q?iIkDjCVFbgEVMpo6djf1hacq5D94PoTWoLM/fv0V1ZDk3NaZYcc1Q26Jdfyn?=
 =?us-ascii?Q?uukWLqYv/ghfeEIvpe/iZbSaNOI0X5gbNaS6C29jt61lsa62Bw9MkbZomUE2?=
 =?us-ascii?Q?SY0TSOXmqloZS6ZJ2QlXr9T7SgHcPzDprVlQgYyTuX6oruTAMvLTJ5o7FvUz?=
 =?us-ascii?Q?QRehtv3kxpstlKrJPlNLMBt9xjpyk62yfIRHmBEBYiI5PcbEmCYXgGmbuxZm?=
 =?us-ascii?Q?seKtrHs6gexDfxeaPDUhaLirZh5StIZs4RElvj8fzL9QgtHGIaGqgRtvqyQl?=
 =?us-ascii?Q?b/DwzdGaaZk4amfLVxTP/6Vv7uGt+2gicc4GpC3hDA0Gs7J06IiwUfhyxoeH?=
 =?us-ascii?Q?o/tzDsJnHlsp86u+4aW071FdqJXblAAc9pChZRQtXzIUGzAEYxZ1MigjVz9G?=
 =?us-ascii?Q?M4kwnP0IyQXXYr3Vsxeiea6Ods7fu18xemHoiJVJCG/vMXbIVligHCxi3v2u?=
 =?us-ascii?Q?TECngkYFcMHZ+Csry6wfVwsvg2E17eZygATM6mgOdmLkXAD18QTXCf97Iu5N?=
 =?us-ascii?Q?7QpeXlFslUK4jBtaFkPY7d5DHbH13bgH9LDBDkJ/C3eeXMCPGLHPYm47x7Nq?=
 =?us-ascii?Q?T4NHpjDu+2gKr3bmEMBmcEG0e+y8DOxOo+OTOkIg4hm1Q7quSPIMobRkSNbN?=
 =?us-ascii?Q?r35l1rIsIuZSI/THYa/UdAQYUM8HvAfmRuwbSoaZqNmZXP7YfG0k/HquRRoC?=
 =?us-ascii?Q?eIbEie1+vpWcE+p4Vr4jhOq2HXqGekHginkHmbQtLOMedVZW5SLJTfQpGKb6?=
 =?us-ascii?Q?vYC0SzdMl8ISZM96QI8l3k66gHurh8Dx3AUVu5v5Cc6euhJFbIe0WlXokgvx?=
 =?us-ascii?Q?0GiscG0DfLX0WMlqBQf2ozKfpzstI5+emKeI9pjXgHRqvZXFrDqG/zRWGRPM?=
 =?us-ascii?Q?Mo9aOfd6k6I9K8rZ4wJHAlKj+QQ71i/jXoOh1HUnJ3s6gKq/6+GlH596bZMZ?=
 =?us-ascii?Q?IHkq4mxmSv1/p2OhTXOzb44qzUTo1WrbWPiDOdqVVsLlJefflLNoq2OAHiSD?=
 =?us-ascii?Q?yVTrfuxF4FYK7v4=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nkD4whYjRREeDhRWUBu2lmJsUs21zvkOy9MrkMclBPpRAZq6OxV3CYvTbpVa8iygNLYXH6sf0Y1LX0udO3bapwWOVdUReKcFtsOb72jpZCCl9YqOuXjiPqAzQ3G+a30e+hKpQoiC45eJkMAVtME3AA/t5qa5RNN13Du6BGejtzIaEi8oVfqD4iAY+4WS1H/CpEuwkgdeFzYXl9S5loSYwl6DLdU4He1qLLvi/TfwGlzv2+APHwlcDOH0pR/yKQ4PVzllaOP13M1G5ovF+H9fyAt408PJ0fQip5wcmbtybAn25uK6TO3rKRmpbb8tnPXUWRqP6fvl/vYpixp1UL72QdzXeFnFvzGh3y8lOsQ73x7wS0XE1YE4/MAuCRxCJE2bMIO7BhF+GxBUgh3NcYlK1R9Y/KjdfNLxGn0k2MclW6cq+5bSqE2OdCS+1xZJbHx7y+WPX8LMqqLPo5rN9wZmOIP0hxNFYVCa9N7BDpXUbZ0ddWteejau8Sny5plfPRoNfSJyJUzLWf1RMYWaYPVc8eIKyXP7iR4TJjyk3bSLURdg+DJljqsEMIRTp/eO+G2kBdVYkXSMSeWIrEF+LwR9I99Iq4mUyI6cuNgc6M1AvEEmbw0dZhNS2H+1KtOUmIbIxuZfjYb5yAW49T8SKuY4xfM300evRVbLzQnkd2/buNg=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:37.0215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9d2970-ab4d-4a7f-82ba-08dd51fa90e8
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1949
X-BESS-ID: 1740089078-305508-25329-16468-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmpkYmQGYGUDQpMcU00SQlJc
 kk1czQzDDVwtDMKNnC0szUzNjIMNXESKk2FgAN5FR3QgAAAA==
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan10-185.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_SC1_TG070          META: Custom Rule TG070 
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_SC1_TG070, BSF_RULE7568M, BSF_BESS_OUTBOUND
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

- Initialize IGAM module and check for its presence.
- Enable system PLL using IGAM and check for PLL lock status.
- Reset and configure TS PLL and check for lock status.
- Force HIF soft reset and de-assert platform reset.
- Enable RAB1 and RAB2 and perform RAB initialization and flush.
- Check system PLL readiness using PHY_TILE and handle PLL lock status.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../net/ntnic/nthw/core/include/nthw_hif.h    |   1 +
 .../net/ntnic/nthw/core/include/nthw_igam.h   |   3 +
 .../nthw/core/include/nthw_pcm_nt400dxx.h     |   4 +
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |   8 +
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   | 211 ++++++++++++++++++
 drivers/net/ntnic/nthw/core/nthw_hif.c        |  10 +
 drivers/net/ntnic/nthw/core/nthw_igam.c       |  31 +++
 .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |  24 ++
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |  61 +++++
 drivers/net/ntnic/nthw/nthw_drv.h             |   2 +
 10 files changed, 355 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/nthw_hif.h b/drivers/net/ntnic/nthw/core/include/nthw_hif.h
index deb9ed04e8..7d5e1f1310 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_hif.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_hif.h
@@ -135,6 +135,7 @@ void nthw_hif_delete(nthw_hif_t *p);
 int nthw_hif_init(nthw_hif_t *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int nthw_hif_trigger_sample_time(nthw_hif_t *p);
+int nthw_hif_force_soft_reset(nthw_hif_t *p);
 
 int nthw_hif_stat_req_enable(nthw_hif_t *p);
 int nthw_hif_stat_req_disable(nthw_hif_t *p);
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_igam.h b/drivers/net/ntnic/nthw/core/include/nthw_igam.h
index e78637a331..fed462cd34 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_igam.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_igam.h
@@ -33,5 +33,8 @@ typedef struct nt_igam nthw_igam;
 
 nthw_igam_t *nthw_igam_new(void);
 int nthw_igam_init(nthw_igam_t *p, nthw_fpga_t *p_fpga, int mn_igam_instance);
+uint32_t nthw_igam_read(nthw_igam_t *p, uint32_t address);
+void nthw_igam_write(nthw_igam_t *p, uint32_t address, uint32_t data);
+void nthw_igam_set_ctrl_forward_rst(nthw_igam_t *p, uint32_t value);
 
 #endif	/*  __NTHW_IGAM_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
index 23865f466b..47d2670cf5 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
@@ -32,5 +32,9 @@ typedef struct nthw_pcm_nt400_dxx nthw_pcm_nt400_dxx;
 
 nthw_pcm_nt400dxx_t *nthw_pcm_nt400dxx_new(void);
 int nthw_pcm_nt400dxx_init(nthw_pcm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_instance);
+void nthw_pcm_nt400dxx_set_ts_pll_recal(nthw_pcm_nt400dxx_t *p, uint32_t val);
+bool nthw_pcm_nt400dxx_get_ts_pll_locked_stat(nthw_pcm_nt400dxx_t *p);
+bool nthw_pcm_nt400dxx_get_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p);
+void nthw_pcm_nt400dxx_set_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p, uint32_t val);
 
 #endif	/* __NTHW_PCM_NT400DXX_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
index ba044a5091..c4ec100c23 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -142,7 +142,15 @@ void nthw_phy_tile_write_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 	uint32_t data);
 uint32_t nthw_phy_tile_get_port_status_reset_ack(nthw_phy_tile_t *p, uint8_t intf_no);
 uint32_t nthw_phy_tile_get_port_status_tx_lanes_stable(nthw_phy_tile_t *p, uint8_t intf_no);
+void nthw_phy_tile_set_sys_pll_set_rdy(nthw_phy_tile_t *p, uint32_t value);
+uint32_t nthw_phy_tile_get_sys_pll_get_rdy(nthw_phy_tile_t *p);
+uint32_t nthw_phy_tile_get_sys_pll_system_pll_lock(nthw_phy_tile_t *p);
+void nthw_phy_tile_set_sys_pll_en_ref_clk_fgt(nthw_phy_tile_t *p, uint32_t value);
+uint32_t nthw_phy_tile_get_sys_pll_ref_clk_fgt_enabled(nthw_phy_tile_t *p);
+void nthw_phy_tile_set_sys_pll_forward_rst(nthw_phy_tile_t *p, uint32_t value);
+void nthw_phy_tile_set_sys_pll_force_rst(nthw_phy_tile_t *p, uint32_t value);
 uint8_t nthw_phy_tile_get_no_intfs(nthw_phy_tile_t *p);
 void nthw_phy_tile_set_port_config_rst(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t value);
+bool nthw_phy_tile_use_phy_tile_pll_check(nthw_phy_tile_t *p);
 
 #endif	/* __NTHW_PHY_TILE_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 95394b9c8f..b93b0a829a 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -184,9 +184,13 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 {
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 	nthw_fpga_t *p_fpga = NULL;
+	int res = -1;
 
 	p_fpga = p_fpga_info->mp_fpga;
 
+	nthw_pcm_nt400dxx_t *p_pcm = p_fpga_info->mp_nthw_agx.p_pcm;
+	nthw_prm_nt400dxx_t *p_prm = p_fpga_info->mp_nthw_agx.p_prm;
+
 	assert(p_fpga_info);
 
 	NT_LOG(DBG, NTHW, "%s: %s: BEGIN", p_adapter_id_str, __PRETTY_FUNCTION__);
@@ -199,9 +203,216 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 		return -1;
 	}
 
+	nthw_phy_tile_t *p_phy_tile = p_fpga_info->mp_nthw_agx.p_phy_tile;
+
 	nthw_igam_t *p_igam = nthw_igam_new();
 	nthw_igam_init(p_igam, p_fpga, 0);
 
+	if (p_igam) {
+		if (!nthw_phy_tile_use_phy_tile_pll_check(p_fpga_info->mp_nthw_agx.p_phy_tile)) {
+			NT_LOG(DBG, NTHW, "%s: IGAM module present.", p_adapter_id_str);
+			uint32_t data;
+
+			p_fpga_info->mp_nthw_agx.p_igam = p_igam;
+
+			/*
+			 * (E) When the reference clock for the F-tile system PLL is started (and
+			 * stable) it must be enabled using the Intel Global Avalon Memory-Mapped
+			 * Mailbox (IGAM) module.
+			 */
+
+			nthw_igam_write(p_igam, 0xffff8, 0x90000000);
+
+			/* (F) Check that the system PLL is ready. */
+			for (int i = 1000; i >= 0; i--) {
+				nt_os_wait_usec(1000);
+				data = nthw_igam_read(p_igam, 0xffff4);
+
+				if (data == 0x80000000 || data == 0xA0000000) {
+					NT_LOG(INF,
+						NTHW,
+						"%s: All enabled system PLLs are locked. Response: %#08x",
+						p_adapter_id_str,
+						data);
+					break;
+				}
+
+				if (i == 0) {
+					NT_LOG(ERR,
+						NTHW,
+						"%s: Timeout waiting for all system PLLs to lock. Response: %#08x",
+						p_adapter_id_str,
+						data);
+					return -1;
+				}
+			}
+
+		} else {
+			nthw_igam_set_ctrl_forward_rst(p_igam,
+				0);	/* Ensure that the Avalon bus is not */
+			/* reset at every driver re-load. */
+			nt_os_wait_usec(1000000);
+			NT_LOG(DBG, NTHW, "%s: IGAM module not used.", p_adapter_id_str);
+		}
+
+	} else {
+		NT_LOG(DBG, NTHW, "%s: No IGAM module present.", p_adapter_id_str);
+	}
+
+	/*
+	 * (G) Reset TS PLL and select Time-of-Day clock (tod_fpga_clk). Source is either
+	 * from ZL clock device or SiTime tunable XO. NOTE that the PLL must be held in
+	 * RESET during clock switchover.
+	 */
+
+	if (p_fpga_info->mp_nthw_agx.tcxo_present && p_fpga_info->mp_nthw_agx.tcxo_capable) {
+		nthw_pcm_nt400dxx_set_ts_pll_recal(p_pcm, 1);
+		nt_os_wait_usec(1000);
+		nthw_pcm_nt400dxx_set_ts_pll_recal(p_pcm, 0);
+		nt_os_wait_usec(1000);
+	}
+
+	/* (I) Wait for TS PLL locked. */
+	for (int i = 1000; i >= 0; i--) {
+		nt_os_wait_usec(1000);
+
+		if (nthw_pcm_nt400dxx_get_ts_pll_locked_stat(p_pcm))
+			break;
+
+		if (i == 0) {
+			NT_LOG(ERR,
+				NTHW,
+				"%s: %s: Time out waiting for TS PLL locked",
+				p_adapter_id_str,
+				__func__);
+			return -1;
+		}
+	}
+
+	/* NT_RAB0_REG.PCM_NT400D1X.STAT.TS_PLL_LOCKED==1 */
+
+	/* (J) Set latched TS PLL locked. */
+	nthw_pcm_nt400dxx_set_ts_pll_locked_latch(p_pcm, 1);
+	/* NT_RAB0_REG.PCM_NT400D1X.LATCH.TS_PLL_LOCKED=1 */
+
+	/* (K) Ensure TS latched status bit is still set. */
+	if (!nthw_pcm_nt400dxx_get_ts_pll_locked_stat(p_pcm)) {
+		NT_LOG(ERR,
+			NTHW,
+			"%s: %s: TS latched status bit toggled",
+			p_adapter_id_str,
+			__func__);
+		return -1;
+	}
+
+	/* NT_RAB0_REG.PCM_NT400D1X.LATCH.TS_PLL_LOCKED==1 */
+
+	/*
+	 * At this point all system clocks and TS clocks are running.
+	 * Last thing to do before proceeding to product reset is to
+	 * de-assert the platform reset and enable the RAB buses.
+	 */
+
+	/* (K1) Force HIF soft reset. */
+	nthw_hif_t *p_nthw_hif = nthw_hif_new();
+	res = nthw_hif_init(p_nthw_hif, p_fpga, 0);
+
+	if (res == 0)
+		NT_LOG(DBG, NTHW, "%s: Hif module found", p_fpga_info->mp_adapter_id_str);
+
+	nt_os_wait_usec(1000);
+	nthw_hif_force_soft_reset(p_nthw_hif);
+	nt_os_wait_usec(1000);
+	nthw_hif_delete(p_nthw_hif);
+
+	/* (L) De-assert platform reset. */
+	nthw_prm_nt400dxx_platform_rst(p_prm, 0);
+
+	/*
+	 * (M) Enable RAB1 and RAB2.
+	 * NT_BAR_REG.RAC.RAB_INIT.RAB=0
+	 */
+	NT_LOG_DBGX(DBG, NTHW, "%s: RAB Init", p_adapter_id_str);
+	nthw_rac_rab_init(p_fpga_info->mp_nthw_rac, 0);
+	nthw_rac_rab_setup(p_fpga_info->mp_nthw_rac);
+
+	NT_LOG_DBGX(DBG, NTHW, "%s: RAB Flush", p_adapter_id_str);
+	nthw_rac_rab_flush(p_fpga_info->mp_nthw_rac);
+
+	/*
+	 * FPGAs with newer PHY_TILE versions must use PhyTile to check that system PLL is ready.
+	 * It has been added here after consultations with ORA since the test must be performed
+	 * after de-assertion of platform reset.
+	 */
+
+	if (nthw_phy_tile_use_phy_tile_pll_check(p_phy_tile)) {
+		/* Ensure that the Avalon bus is not reset at every driver re-load. */
+		nthw_phy_tile_set_sys_pll_forward_rst(p_phy_tile, 0);
+
+		nthw_phy_tile_set_sys_pll_set_rdy(p_phy_tile, 0x07);
+		NT_LOG_DBGX(DBG, NTHW, "%s: setSysPllSetRdy.", p_adapter_id_str);
+
+		/* (F) Check that the system PLL is ready. */
+		for (int i = 1000; i >= 0; i--) {
+			nt_os_wait_usec(1000);
+
+			if (nthw_phy_tile_get_sys_pll_get_rdy(p_phy_tile) &&
+				nthw_phy_tile_get_sys_pll_system_pll_lock(p_phy_tile)) {
+				break;
+			}
+
+			if (i == 500) {
+				nthw_phy_tile_set_sys_pll_force_rst(p_phy_tile, 1);
+				nt_os_wait_usec(1000);
+				nthw_phy_tile_set_sys_pll_force_rst(p_phy_tile, 0);
+				NT_LOG_DBGX(DBG,
+					NTHW,
+					"%s: setSysPllForceRst due to system PLL not ready.",
+					p_adapter_id_str);
+			}
+
+			if (i == 0) {
+				NT_LOG_DBGX(DBG,
+					NTHW,
+					"%s: Timeout waiting for all system PLLs to lock",
+					p_adapter_id_str);
+				return -1;
+			}
+		}
+
+		nt_os_wait_usec(100000);/* 100 ms */
+
+		uint32_t fgt_enable = 0x0d;	/* FGT 0, 2 & 3 */
+		nthw_phy_tile_set_sys_pll_en_ref_clk_fgt(p_phy_tile, fgt_enable);
+
+		for (int i = 1000; i >= 0; i--) {
+			nt_os_wait_usec(1000);
+
+			if (nthw_phy_tile_get_sys_pll_ref_clk_fgt_enabled(p_phy_tile) ==
+				fgt_enable) {
+				break;
+			}
+
+			if (i == 500) {
+				nthw_phy_tile_set_sys_pll_force_rst(p_phy_tile, 1);
+				nt_os_wait_usec(1000);
+				nthw_phy_tile_set_sys_pll_force_rst(p_phy_tile, 0);
+				NT_LOG_DBGX(DBG,
+					NTHW,
+					"%s: setSysPllForceRst due to FGTs not ready.",
+					p_adapter_id_str);
+			}
+
+			if (i == 0) {
+				NT_LOG_DBGX(DBG,
+					NTHW,
+					"%s: Timeout waiting for FGTs to lock",
+					p_adapter_id_str);
+				return -1;
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index 92a2348bbb..630262a7fc 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -202,6 +202,16 @@ int nthw_hif_init(nthw_hif_t *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
+int nthw_hif_force_soft_reset(nthw_hif_t *p)
+{
+	if (p->mp_fld_ctrl_fsr) {
+		nthw_field_update_register(p->mp_fld_ctrl_fsr);
+		nthw_field_set_flush(p->mp_fld_ctrl_fsr);
+	}
+
+	return 0;
+}
+
 int nthw_hif_trigger_sample_time(nthw_hif_t *p)
 {
 	nthw_field_set_val_flush32(p->mp_fld_sample_time, 0xfee1dead);
diff --git a/drivers/net/ntnic/nthw/core/nthw_igam.c b/drivers/net/ntnic/nthw/core/nthw_igam.c
index 5dc7e36c7b..385282298a 100644
--- a/drivers/net/ntnic/nthw/core/nthw_igam.c
+++ b/drivers/net/ntnic/nthw/core/nthw_igam.c
@@ -60,3 +60,34 @@ int nthw_igam_init(nthw_igam_t *p, nthw_fpga_t *p_fpga, int mn_igam_instance)
 
 	return 0;
 }
+
+uint32_t nthw_igam_read(nthw_igam_t *p, uint32_t address)
+{
+	nthw_register_update(p->mp_reg_base);
+	nthw_field_set_val32(p->mp_fld_base_cmd, 0);
+	nthw_field_set_val_flush32(p->mp_fld_base_ptr, address);
+
+	while (nthw_field_get_updated(p->mp_fld_base_busy) == 1)
+		nt_os_wait_usec(100);
+
+	return nthw_field_get_updated(p->mp_fld_data_data);
+}
+
+void nthw_igam_write(nthw_igam_t *p, uint32_t address, uint32_t data)
+{
+	nthw_field_set_val_flush32(p->mp_fld_data_data, data);
+	nthw_register_update(p->mp_reg_base);
+	nthw_field_set_val32(p->mp_fld_base_ptr, address);
+	nthw_field_set_val_flush32(p->mp_fld_base_cmd, 1);
+
+	while (nthw_field_get_updated(p->mp_fld_base_busy) == 1)
+		nt_os_wait_usec(100);
+}
+
+void nthw_igam_set_ctrl_forward_rst(nthw_igam_t *p, uint32_t value)
+{
+	if (p->mp_fld_ctrl_forward_rst) {
+		nthw_field_get_updated(p->mp_fld_ctrl_forward_rst);
+		nthw_field_set_val_flush32(p->mp_fld_ctrl_forward_rst, value);
+	}
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
index f32a277e86..e7be634a83 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
@@ -54,3 +54,27 @@ int nthw_pcm_nt400dxx_init(nthw_pcm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_in
 
 	return 0;
 }
+
+void nthw_pcm_nt400dxx_set_ts_pll_recal(nthw_pcm_nt400dxx_t *p, uint32_t val)
+{
+	if (p->mp_fld_ctrl_ts_pll_recal) {
+		nthw_field_update_register(p->mp_fld_ctrl_ts_pll_recal);
+		nthw_field_set_val_flush32(p->mp_fld_ctrl_ts_pll_recal, val);
+	}
+}
+
+bool nthw_pcm_nt400dxx_get_ts_pll_locked_stat(nthw_pcm_nt400dxx_t *p)
+{
+	return nthw_field_get_updated(p->mp_fld_stat_ts_pll_locked) != 0;
+}
+
+bool nthw_pcm_nt400dxx_get_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p)
+{
+	return nthw_field_get_updated(p->mp_fld_latch_ts_pll_locked) != 0;
+}
+
+void nthw_pcm_nt400dxx_set_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p, uint32_t val)
+{
+	nthw_field_update_register(p->mp_fld_latch_ts_pll_locked);
+	nthw_field_set_val_flush32(p->mp_fld_latch_ts_pll_locked, val);
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index f78d8263f5..0dc2784034 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -642,6 +642,11 @@ int nthw_phy_tile_init(nthw_phy_tile_t *p, nthw_fpga_t *p_fpga, int mn_phy_tile_
 	return 0;
 }
 
+bool nthw_phy_tile_use_phy_tile_pll_check(nthw_phy_tile_t *p)
+{
+	return nthw_module_is_version_newer(p->m_mod_phy_tile, 0, 8);
+}
+
 uint8_t nthw_phy_tile_get_no_intfs(nthw_phy_tile_t *p)
 {
 	switch (p->mac_pcs_mode) {
@@ -1172,6 +1177,62 @@ uint32_t nthw_phy_tile_get_port_status_tx_lanes_stable(nthw_phy_tile_t *p, uint8
 	return 1;
 }
 
+void nthw_phy_tile_set_sys_pll_set_rdy(nthw_phy_tile_t *p, uint32_t value)
+{
+	if (p->mp_fld_sys_pll_set_rdy) {
+		nthw_field_get_updated(p->mp_fld_sys_pll_set_rdy);
+		nthw_field_set_val_flush32(p->mp_fld_sys_pll_set_rdy, value);
+	}
+}
+
+uint32_t nthw_phy_tile_get_sys_pll_get_rdy(nthw_phy_tile_t *p)
+{
+	if (p->mp_fld_sys_pll_get_rdy)
+		return nthw_field_get_updated(p->mp_fld_sys_pll_get_rdy);
+
+	return 0;
+}
+
+uint32_t nthw_phy_tile_get_sys_pll_system_pll_lock(nthw_phy_tile_t *p)
+{
+	if (p->mp_fld_sys_pll_system_pll_lock)
+		return nthw_field_get_updated(p->mp_fld_sys_pll_system_pll_lock);
+
+	return 0;
+}
+
+void nthw_phy_tile_set_sys_pll_en_ref_clk_fgt(nthw_phy_tile_t *p, uint32_t value)
+{
+	if (p->mp_fld_sys_pll_en_ref_clk_fgt) {
+		nthw_field_get_updated(p->mp_fld_sys_pll_en_ref_clk_fgt);
+		nthw_field_set_val_flush32(p->mp_fld_sys_pll_en_ref_clk_fgt, value);
+	}
+}
+
+uint32_t nthw_phy_tile_get_sys_pll_ref_clk_fgt_enabled(nthw_phy_tile_t *p)
+{
+	if (p->mp_fld_sys_pll_ref_clk_fgt_enabled)
+		return nthw_field_get_updated(p->mp_fld_sys_pll_ref_clk_fgt_enabled);
+
+	return 0;
+}
+
+void nthw_phy_tile_set_sys_pll_forward_rst(nthw_phy_tile_t *p, uint32_t value)
+{
+	if (p->mp_fld_sys_pll_forward_rst) {
+		nthw_field_get_updated(p->mp_fld_sys_pll_forward_rst);
+		nthw_field_set_val_flush32(p->mp_fld_sys_pll_forward_rst, value);
+	}
+}
+
+void nthw_phy_tile_set_sys_pll_force_rst(nthw_phy_tile_t *p, uint32_t value)
+{
+	if (p->mp_fld_sys_pll_force_rst) {
+		nthw_field_get_updated(p->mp_fld_sys_pll_force_rst);
+		nthw_field_set_val_flush32(p->mp_fld_sys_pll_force_rst, value);
+	}
+}
+
 void nthw_phy_tile_set_port_config_rst(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t value)
 {
 	if (p->mp_fld_port_config_reset[intf_no]) {
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index 574dd663ea..e1a00c5ea5 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -17,6 +17,7 @@
 #include "nthw_phy_tile.h"
 #include "nthw_prm_nt400dxx.h"
 #include "nthw_pcm_nt400dxx.h"
+#include "nthw_igam.h"
 
 /*
  * Structs for controlling Agilex based NT400DXX adapter
@@ -31,6 +32,7 @@ typedef struct nthw_agx_s {
 	nthw_si5156_t *p_si5156;
 	nthw_prm_nt400dxx_t *p_prm;
 	nthw_pcm_nt400dxx_t *p_pcm;
+	nthw_igam_t *p_igam;
 	nthw_phy_tile_t *p_phy_tile;
 	nthw_rpf_t *p_rpf;
 	bool tcxo_present;
-- 
2.45.0

