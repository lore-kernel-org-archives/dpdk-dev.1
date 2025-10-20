Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9155BCCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB13340E3A;
	Mon, 20 Oct 2025 18:43:53 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 9580340678
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:46 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022128.outbound.protection.outlook.com
 [52.101.66.128]) by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWXaZIeTdIyg5xdZ8Zx3ExNQOaCgzYV2VWBmX0/e1weu8OIx6gb7xeL/aUuPbwz1LOA5joPlfMFIvelELhKZHRrrL+uoM6xXB1KK489omBp0hz8BCmcivSytP7x8jv8eze9NQdYawis9JubqcUgX/x0dyOhghOc8hZet7uqO1BokrS6uqvuiD1ZWiC/UoAIeweaWwWzDxqdVzWfrWDuciDEFQyLzUHx3uY0IuKbnGjsujkK/FHV1L3c4H9ZY9mlTP8BmkV//LYuCISCR7wuaGcL5fay9GTdb0hQKSncmkN21+OVGK4M89XnrZfV+t/u2f89OeF8UN9P0boJfgbYXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfIuqlzGyEB7ZKeEtuoFeXC37nJjgOMmS1pX4Zes3cE=;
 b=SuOkNqD1GHD65duXm+7nG4XgJBuFYUbhAQVOciw0qZw8+na4GYfDglIJU3fCyTfmcwPc5A46vHHTUhLvHaro2+FeEp1jvtPjUHpCph1ZMOFm7iU0ZF+c2ciNF/lwyEJcUZyAp7dI+kV+6ylIoaNB0TKGWle9T7vOHfgnW5NkkxS0JXa9qaTnLvn6jZTmeW6I0zSexRMRBlp8cXDP7Ic16DF9DAC9nfgR+RFDwdjRlZNgINO3c5HRR0pkcS99jO90EzFfx3lf/vQLHCgzSjlerAkWbyVL9NBCFNUKYqefRupIL+VxFoSWqY6WSMahXMuoaDw0e4Pe5J79b01VqibOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfIuqlzGyEB7ZKeEtuoFeXC37nJjgOMmS1pX4Zes3cE=;
 b=P8BbCwwjxi/xMAqsSAyevLGin7ZkWggQc5edpJLbH5ezE7mVDHQB0CKBm7ubCvNVVmC4Z09K6BK5ZF0lz5aHop3RawXBMeyOzi7Ibd2I8Qyu9Bj+AH710DSie72trnMMSgLd+Jbc36bkWIBMMkOHVwgaBpgnFif3pTek7h+YRak=
Received: from DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) by AS8P190MB1886.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:509::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:44 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::dd) by DUZPR01CA0030.outlook.office365.com
 (2603:10a6:10:46b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:38 +0000
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
Subject: [PATCH v2 06/21] net/ntnic: add reset init stage 3 and 4 for NT400D11
Date: Mon, 20 Oct 2025 18:43:15 +0200
Message-ID: <20251020164336.283664-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|AS8P190MB1886:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 086523f8-a771-431c-f159-08de0ff7d546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vhroR1EigJ/RRMgasrA83UYdMWesHAU6OwBGHpa+qsEHleZcn7ziFeBJLoAa?=
 =?us-ascii?Q?16ASeUVGK0nWIiXcWcZsJzJ9zMeLbrPXGD8H7NJNCdjyzwl4YilwdeBL5Uly?=
 =?us-ascii?Q?j+5i7G9kNlJ3b7q7QgESTeq6cETky6ULPFPr8/uwe8OF+Y1fUf7sg9rAxN++?=
 =?us-ascii?Q?0sIbtswaDghJQOESBwsHK1PBXblflzyUYwjt6Ity5NmoTNPotS4eQQuZEN80?=
 =?us-ascii?Q?35qY9wtlyynXT79ToywBGvLNFTLcEdO4XUVSmpb6AqbdjMsQrUIhxkuutekW?=
 =?us-ascii?Q?ypfiXlknOqSFGCC/fJjKzLNzbqBLDd9oIyxmJ7903CTCx3+kkp9CxCrD/vQm?=
 =?us-ascii?Q?Ey7gh/wO8H8E2QE2yJI83BqOuBpRVhZJMNne/0yULFJH4UQza5TUpZdLisL3?=
 =?us-ascii?Q?TGaJhjUJ0hXKHJ8/U/ewvrb4sbv/rTVRmYI7bwkPfTseb1coYNpgY7qjKv0Y?=
 =?us-ascii?Q?nd0FIieYYF9R7QBquXndIlK/Bb2/LfSxzUZB1BM0peIR6/sdkHknHkGjsvRv?=
 =?us-ascii?Q?lFKmQnqrb/fEtIBTLsfinjVbpVe1TZxdVj732nfb//Zmu+AomA7B2mFq/z68?=
 =?us-ascii?Q?jxD9+DTPYUWh9yOVcKuH9/Q5rl8HB+1xzO+LwXscrb6Jwwhg9DFQW2pojC4M?=
 =?us-ascii?Q?4efnmXc/tLZivVqqs5WdCM1nTluiNdgVJR8W7j/MP3AjH7BCAfSoNv+PEvUk?=
 =?us-ascii?Q?hEOMYGzfpIt2sUc9E8znBJPs/nVI349K7mv/ZH6L9VNPVpq+gK5sF7PaXJsk?=
 =?us-ascii?Q?AiADXzDdMhmzGXexJhIkzoexoTioKT5p2PNK+tn4hav9zOKdi0kh690fwE60?=
 =?us-ascii?Q?Pdwm0Dhb/JCdY1vu1kjDQXGC97mYPDcGHNa5rCDUN77XGas1QXgx3H4+26te?=
 =?us-ascii?Q?u5OCzRo/sBWfg4bMlkSCq5YdjRjOV9wsCgu7NMYqybhvurFyrFjFTj+BOx3g?=
 =?us-ascii?Q?UGAEHeu8SWMI0pkwSvDfyz/kJfiTi4H6W+pXi62D+SKqV0I/0R4BebBZphdn?=
 =?us-ascii?Q?P1P82Cu4FNjga/Q+Wmg1lm3apmpSeJr/gEFurpRS63oGVe6iMj9uPCBUDMOO?=
 =?us-ascii?Q?bRQ9A0mNoTLnPFDdMa1YoKW6vXTb6hIHUzPBvFUSJWt1rUWw/WFWIxmCltwG?=
 =?us-ascii?Q?kxZvYtRh2xHlO9GHEFdn12kPgsjSM2et0b70DqMn8uCsPFyFUkBSOJAQ8wzZ?=
 =?us-ascii?Q?+pS77mb9lnwbLyXmD6AS/Z2OHN2Vqg4doaGUgMmyHP8ACRB/j6d0pQ5JqLVn?=
 =?us-ascii?Q?tDxKtgDVjQmBVK8LFnf37XJ8UAOGmglAtHG1XgBOj0c56i6mKvDzi4docERg?=
 =?us-ascii?Q?vYeBKQrhTPj66HmDHvEcZ7zNLmyCq4JqY1LrG686CUIJ4JdfWYwYFTjODg2p?=
 =?us-ascii?Q?q8xp72zrVFgKXHjnIrx1tA0CWb+144ec0HV/ZuvLO54+heCzrPfBDlsAdi3v?=
 =?us-ascii?Q?KuGRfqOfmwC6sjJ5ebi4GaM7OErWMUnR1Kv1v6B2qUWygKPTXh5cToai1V7f?=
 =?us-ascii?Q?UwdxH7cb8Lg8gnBp9MXayxNfr5TWCLsDSEb64htgQg6OolktRYkpegcLhw3o?=
 =?us-ascii?Q?m+gdGe4oikOnnomY/hs=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1ToqaOvuG/bg4u9FfYABmzml90iNqOM/LdcjdKWZi05wKn+TWcm+vwhqRzdy5zviM+yrJ7EB3KM0QhG8PbjXiBttsnQ7QquQHt5nEwPEnw+fqLe1F4BE5U7CUFTVNR8WL7WaTVFb3+q6GWnCkG9kXWiRTkE2vrQjfrC9rAO8/ZlO+hMhe4SL/od9KuaeI9UFs2BUJbQTVLnd+93x5/IO17AXwC0Dd7hVq8jtPDIn7GJxT3qwe+ORqwB/u4TRV+HtpDb+VAMgiAzcwMac9v0pM5b+S0IY0zgxubafMjdZ1wIVFoQ0MJrxO7Q58Z+5P6EW52ryYbiB8VAPwds1PdXC3YTqAiby73dE3zNDX71HTeK6HwgsmRTVeERTk2yERAAWijvDVhqzRdRxVBemhLMGYntjvxx7b26JL/ZlStV6MdocQYHy9MxcHS7tYJVgSX4UcjHkIeBR190JGOyLLr6dd+J5Dec+P/IieM+3I7uMcptMyQByaChPu8H0wPFWsUlw6Jz5Pgr9Jo56A331m5WfIdrJUMoIhHo59xr6YKtMtGHH2JoJ7iI/MbL5qRw6nFCtE+QKztFNCvgQKRehnxGt4KyjlIkvkcjfv9LrIX27+pjkLn9d35u+XDON1v43lF7RPkpXqAynF+VFFE04OtMIBUE5m6uOszlKbLZWJTgt6zA=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:44.1283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086523f8-a771-431c-f159-08de0ff7d546
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1886
X-BESS-ID: 1760978625-303027-28481-63649-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.66.128
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYG5kZAVgZQ0MQkydjALM3SJN
 nC0NjQLDk1zTTFItEi1djCzNwyzdhMqTYWAK09FW9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan18-209.eu-central-1b.ess.aws.cudaops.com]
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

add DDR4 calib complete latched bits.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 5e127ecc86..e416e739da 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -84,6 +84,13 @@ static bool nthw_fpga_rst9569_get_ddr4_calib_complete_stat(struct nthw_fpga_rst_
 	return nthw_field_get_updated(p->p_fld_stat_ddr4_calib_complete) != 0;
 }
 
+static void nthw_fpga_rst9569_set_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p,
+	uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_latch_ddr4_calib_complete);
+	nthw_field_set_val_flush32(p->p_fld_latch_ddr4_calib_complete, val);
+}
+
 static int nthw_fpga_rst9569_wait_ddr4_calibration_complete(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -127,6 +134,11 @@ static int nthw_fpga_rst9569_wait_ddr4_calibration_complete(struct fpga_info_s *
 	return 0;
 }
 
+static bool nthw_fpga_rst9569_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
+}
+
 static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -163,6 +175,18 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 		return res;
 	}
 
+	/* (3) Set DDR4 calib complete latched bits: */
+	nthw_fpga_rst9569_set_ddr4_calib_complete_latch(p_rst, 1);
+
+	/* Wait for phy to settle. */
+	nthw_os_wait_usec(20000);
+
+	/* (4) Ensure all latched status bits are still set: */
+	if (!nthw_fpga_rst9569_get_ddr4_calib_complete_latch(p_rst)) {
+		NT_LOG(ERR, NTHW, "%s: %s: DDR4 calibration complete has toggled",
+			p_adapter_id_str, __func__);
+	}
+
 
 	return 0;
 }
-- 
2.45.0

