Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0869CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 763B3427A1;
	Mon, 20 Oct 2025 18:37:01 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 54E5540DDC
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:45 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023081.outbound.protection.outlook.com [40.107.159.81])
 by mx-outbound44-20.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdr4Q2tHu9fqXR9+g6YjVfW/WZ2lGoTT1eA8j1WBlsXLgwB9jf5vvJ/w6gPSlzs8WqKWqyAcq9nFxXHgnuO1ZK/MeLeK99GROrBMeYG9QvTThXVRD2mThNwZfxOc4E8j8kPQ59xIocZLi8wetLA2W4FmEnCdD5EPcY564XnnZViheUgyhTc2bDR56KIPkaI5gWIZDnHDKYUwFVwE7RI9PZpr5UAF0l1PcrpTSQKn79bA+MQIfw+Ft5dxtaCRQ87XD8DWkRb+Qw0UjK4AME7/mTVhkjz9++VAKSGqr48M25tD5VI/Sct1SBScPHST+rBPOY+y5sBbdnRbNO7e4/y93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXxbKbN1hoQIdQKywNuyv2AooPim27ylMC5LjrVycOU=;
 b=njh5aaMyqZR73zt6fybllrrOiv0oi/oBPtU27F7x2ey2F+KVqpRgkafgvSPBfxyvksIINuS/t5/7e/857F+1MJlzPRQSeR+GWiJhBEuVR0u8UlYEtSY4FfcW5WYjJVjA/efekamsG9UV7pTgOtBDa3Jx9Ua0T9U2czIpbbvUj4INO9ax4XIX2v/vTuWE7W6eh0cHDjAmql6kV16TZblezUZ4tg8Hw3gm5/X94qz/5Gg7tqA+T/0oV7ecTcTJGD2YQdr4VJ7mfjCj9z/Y1HJnlCKn7FJDbAGOsRQtVtRSptPm8JOMEhY8eSZo+U17JDxE8EOLk/9n0IJNYS2GD2lW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXxbKbN1hoQIdQKywNuyv2AooPim27ylMC5LjrVycOU=;
 b=F6Ww4+9XGZpiDJIFfdSTjVknOf7y7ucOp6NQ0bIeVqSHYxD1X6mvtyRm+DKO9S1VusCyQIQ1pfbCNhKvJyVPaou0Q1Gniow007ammzCHE+2g92Z/whpnrsiAt0H+SB/XoUcrjgkhKIDZNXZ6YO/maALxj3uNp+nQWB64sWJOh4c=
Received: from AS4P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::8)
 by DBAP190MB0904.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:42 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::a0) by AS4P191CA0020.outlook.office365.com
 (2603:10a6:20b:5d9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:41
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 22/24] net/ntnic: rename ops init functions
Date: Mon, 20 Oct 2025 18:36:13 +0200
Message-ID: <20251020163620.282312-23-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DBAP190MB0904:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 31c67e3c-dc49-4d33-9215-08de0ff6d9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hPH15OCjVroDJwXnk246SHhtqauPszmc/orsQYfxsqe+IDK3dKBs3QiiCK7q?=
 =?us-ascii?Q?KcinHd4hIli/SjtEwJckxbGiQu9b5tbMaeBJlNp2QS5pE6JUEYbYfKDuvXLo?=
 =?us-ascii?Q?ceUgWrnKobUSQzfBHcVS88GDgaUpgVAGnX+6A41DeAUR4wSm/hGOQp02gZoa?=
 =?us-ascii?Q?ZBJKlaSz1CGZ7vniIvsyD/t52NP0AQMf4yXf6TEw1lA+bWf5/qcWSastlzxW?=
 =?us-ascii?Q?qmIiI6j7jpmClyfHjyePvBWFIV+uI947tWSUV2AgYWOOlZSS0+5OgS+tj2lW?=
 =?us-ascii?Q?AymeeTfgmB0Op2UDBRhSepv2iQwrYcRwbm1GsAs8ZoMksB9CS3sS28czkjia?=
 =?us-ascii?Q?ymNEx+5BwfH6ZW0Cah/CsCTg6YMTEO8Lo2AIzGFq75PocqX+3hm2bvenniOK?=
 =?us-ascii?Q?T619wTXFCVtI+gVScUgcX+0G2NVMMjPJnsHi5vNXkrltAtfuG9fUpGNNXht3?=
 =?us-ascii?Q?ssf5rNomqDAn3C5Ti13AzR3KqwHVAj8P1U3MtOBnkZmfudfquXJWuc0TN+br?=
 =?us-ascii?Q?xnYBNJYdOjCFmDLyphw+68JllN6kYcpg7oZd5ZGMxhyEZUnG6sjIVaqFuapl?=
 =?us-ascii?Q?weQMJqEQS+0zIpA88yLWBaQc7mQfMy6UwBTg1aVw/y+w/eRKIzlHyu0p+aLh?=
 =?us-ascii?Q?sVv8MwYCS2frT0jjUpSzM0mmayunIV64j6cE/4tatVRdC56LKdZqOjauSeOn?=
 =?us-ascii?Q?ZrTbf6d6UoHXMbsRkh+QmZzbllBtj30KpXmk0a1FFxaBTMbT5ZXo07KfHVXF?=
 =?us-ascii?Q?/sM4aYdGz5mpixYTKIFnqtlQdM7BCrFCAPOPqo/1Lh3pJdHBo+ZVy36bCJam?=
 =?us-ascii?Q?CRBdD1LoZa5bb2Dh8AATIL+7hplyma2VbZ3dNLK2za4dx17H3ZuucEb+q0dx?=
 =?us-ascii?Q?jVxd+5dbsKli7aoWh6xJ78bcUOQvcNVeVTFfQRBj1i5u2g0CMAH3Y/3tat5s?=
 =?us-ascii?Q?i+4cQMLT6chWqXPalQle3nK8N1in4JZUV+oMuZ+Kq3jQD5peTF+pXhqsfiK2?=
 =?us-ascii?Q?03lxpCq90ULHVHEeCf/BqcjOXuViiDUdabIHZCXLxx0YTYm0oY9D8kTsZGom?=
 =?us-ascii?Q?OFq+FfpDYtLDOipFDzHhWxzZxAmH4ihHo1iEhlW1kjtYvZHt9Sb1orN3WBSp?=
 =?us-ascii?Q?wxKZQjEuuTJDOyWCnEathP0wyLaddjOokE5OXwyy9DcpY5sQAq974jjFzQvG?=
 =?us-ascii?Q?/w/9MLlAlEWMxl3DoGnf7SAmmWajuoXxItzyPc04xC6BAIh5FtNO9C9WZ+rE?=
 =?us-ascii?Q?+XRhjYZViRpzdJJVj2vwzWWIQktoEmsiXfaEBLGd94Q4hzxs//LLB/3T2TkF?=
 =?us-ascii?Q?5IPCb9dtUoXMRo6nqJ8yJsRxmNl4+1EjRGEGx/UDpNSZBLQLuDB7sjAqDwTH?=
 =?us-ascii?Q?u0+ryTQz1OtNHyZwclzX+Uxl8LgONp/Zcb4ZrQvx61SdknSOcCq6PxAjyk3F?=
 =?us-ascii?Q?vmPcx1JEUnnQAmNecOdI1gMksDo6uHLkv7tU1W0Ox4dxlh4ogS8zefPvAtZh?=
 =?us-ascii?Q?UZ+iQJniI4jNgMvuKD86QusC/J33S0jckcm2IKljhjyAerbCAyAoTFOA3Zro?=
 =?us-ascii?Q?kXxQ8Nd/orxqFOXMecU=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6kEGyXybTMVkiJJ7MqFXdFqnDkapxwTnKhnJfr3S1OfZIRjxKjucFW0ov7jxwfEaW2CY4nPwdWwbvn6LjrISrxxaMLQtTk6bHNjpTODKspYhdJpX4+wV1Z6lIRNMXOhB6DHoNkR98yisbtNYrkV90AImR/Z1YdQmpWPHJ5dwgRkyX+MtrZDgqLiPDQu0IEpcHpz4kde3MMdyLjx3nuyIzhkIS0AFoPLaLZlDPFrYyASOwG9K6VUvDl9psZ0MpLftel1pJDn6ib91Wrr3E3l4oGE4KLw2ky8ysZBQV4lWBJPztcBWiLWa5sp50iuAzA6NvjSY6PufZZPnQ4tvybW0h4jVQZ3VYdVDo8T6ZNzekIeqZY6rw4dINni1ly763Trv18z0A/G6AholXeWO3n+OS3hENnK2Eszxwbr5ljR7KyjNATQsYVVTZOokQH7DP125/HWlcDk7dhqIuFkhf/4NLeffidIBolggI2J4JVDK3/6/lYSrQR5jhJx4wnjNUSeqbWeeE0LYEwzzcUdo2I7f7ZHG6cItTFvu57WwSvgbcTFutp1q64uKcZD0/diM9Rym1XYUTfJQPdbspOQCb+iGQUM7EiEWR3loIU/cEFWRK5Zm2cuIUAC8wr327EcgyuoOi4in2bEqPx+dwF8mW43gj+tn/aFqTMfJAWC0LyUKG9E=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:41.9514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c67e3c-dc49-4d33-9215-08de0ff6d9a8
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0904
X-BESS-ID: 1760978204-311284-32702-8206-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.159.81
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmJkYGQGYGUNTMwDDZzNLIzD
 DRNC3VwNDQ2DTVKNHcwNjQNMXQ1NQ4Sak2FgDkwaprQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan19-157.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

Add prefix nthw_ to ops init function to follow the naming convention.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c  |  2 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c        |  2 +-
 .../net/ntnic/nthw/core/include/nthw_fpga.h    |  4 ++--
 .../clock_profiles/nthw_fpga_clk9563.c         |  2 +-
 .../nthw/core/nt200a0x/nthw_fpga_nt200a0x.c    |  2 +-
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c    |  2 +-
 .../nt200a0x/reset/nthw_fpga_rst_nt200a0x.c    |  2 +-
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c    |  2 +-
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c    |  2 +-
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c    |  2 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c        |  4 ++--
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c  |  2 +-
 drivers/net/ntnic/ntnic_mod_reg.c              | 18 +++++++++---------
 drivers/net/ntnic/ntnic_mod_reg.h              | 18 +++++++++---------
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c  |  2 +-
 15 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index 0f7e1f2b00..57b5b147f8 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -593,7 +593,7 @@ static struct nt4ga_stat_ops ops = {
 	.nt4ga_stat_collect = nt4ga_stat_collect
 };
 
-void nt4ga_stat_ops_init(void)
+void nthw_stat_ops_init(void)
 {
 	NT_LOG_DBGX(DBG, NTNIC, "Stat module was initialized");
 	nthw_reg_nt4ga_stat_ops(&ops);
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 1387bb4148..36ecf0d0ec 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -35,7 +35,7 @@ static struct link_ops_s link_agx_100g_ops = {
 	.link_init = nt4ga_agx_link_100g_ports_init,
 };
 
-void link_agx_100g_init(void)
+void nthw_link_agx_100g_ops_init(void)
 {
 	nthw_reg_agx_100g_link_ops(&link_agx_100g_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
index 9838ad3c07..532d19d6b8 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
@@ -34,7 +34,7 @@ struct nt200a0x_ops {
 
 void nthw_reg_nt200a0x_ops(struct nt200a0x_ops *ops);
 struct nt200a0x_ops *nthw_get_nt200a0x_ops(void);
-void nt200a0x_ops_init(void);
+void nthw_nt200a0x_ops_init(void);
 
 struct nt400dxx_ops {
 	int (*nthw_fpga_nt400dxx_init)(struct fpga_info_s *p_fpga_info);
@@ -42,6 +42,6 @@ struct nt400dxx_ops {
 
 void nthw_reg_nt400dxx_ops(struct nt400dxx_ops *ops);
 struct nt400dxx_ops *nthw_get_nt400dxx_ops(void);
-void nt400dxx_ops_init(void);
+void nthw_nt400dxx_ops_init(void);
 
 #endif	/* __NTHW_FPGA_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
index eeca816899..91c9795956 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
@@ -33,7 +33,7 @@ static struct clk9563_ops ops = { .get_n_data_9563_si5340_nt200a02_u23_v5 =
 			get_p_data_9563_si5340_nt200a02_u23_v5
 };
 
-void clk9563_ops_init(void)
+void nthw_clk9563_ops_init(void)
 {
 	nthw_reg_clk9563_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
index 371177c14f..20bacf8988 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
@@ -69,7 +69,7 @@ static int nthw_fpga_nt200a0x_init(struct fpga_info_s *p_fpga_info)
 
 static struct nt200a0x_ops nt200a0x_ops = { .nthw_fpga_nt200a0x_init = nthw_fpga_nt200a0x_init };
 
-void nt200a0x_ops_init(void)
+void nthw_nt200a0x_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "NT200A0X OPS INIT");
 	nthw_reg_nt200a0x_ops(&nt200a0x_ops);
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index f3a28e801e..c99c9ecbe6 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -233,7 +233,7 @@ static int nthw_fpga_rst9563_init(struct fpga_info_s *p_fpga_info,
 
 static struct rst9563_ops rst9563_ops = { .nthw_fpga_rst9563_init = nthw_fpga_rst9563_init };
 
-void rst9563_ops_init(void)
+void nthw_rst9563_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "RST9563 OPS INIT");
 	nthw_reg_rst9563_ops(&rst9563_ops);
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
index 4a2fca5f19..39345369ef 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
@@ -575,7 +575,7 @@ static struct rst_nt200a0x_ops rst_nt200a0x_ops = { .nthw_fpga_rst_nt200a0x_init
 			nthw_fpga_rst_nt200a0x_reset
 };
 
-void rst_nt200a0x_ops_init(void)
+void nthw_rst_nt200a0x_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "RST NT200A0X OPS INIT");
 	nthw_reg_rst_nt200a0x_ops(&rst_nt200a0x_ops);
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 1f87e36d08..cc4bee9d4d 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -213,7 +213,7 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 static struct nt400dxx_ops nt400dxx_ops = { .nthw_fpga_nt400dxx_init = nthw_fpga_nt400dxx_init };
 
-void nt400dxx_ops_init(void)
+void nthw_nt400dxx_ops_init(void)
 {
 	nthw_reg_nt400dxx_ops(&nt400dxx_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index 36d2c46fc6..38614e9365 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -371,7 +371,7 @@ static struct rst9574_ops rst9574_ops = {
 	.nthw_fpga_rst9574_setup = nthw_fpga_rst9574_setup,
 };
 
-void rst9574_ops_init(void)
+void nthw_rst9574_ops_init(void)
 {
 	nthw_reg_rst9574_ops(&rst9574_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 67c562627d..90d0680b99 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -421,7 +421,7 @@ static struct rst_nt400dxx_ops rst_nt400dxx_ops = {
 	.nthw_fpga_rst_nt400dxx_reset = nthw_fpga_rst_nt400dxx_reset
 };
 
-void rst_nt400dxx_ops_init(void)
+void nthw_rst_nt400dxx_ops_init(void)
 {
 	nthw_reg_rst_nt400dxx_ops(&rst_nt400dxx_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 0e1f686b4f..24cfb6c284 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -565,7 +565,7 @@ void nthw_reg_nt200a0x_ops(struct nt200a0x_ops *ops)
 struct nt200a0x_ops *nthw_get_nt200a0x_ops(void)
 {
 	if (nt200a0x_ops == NULL)
-		nt200a0x_ops_init();
+		nthw_nt200a0x_ops_init();
 	return nt200a0x_ops;
 }
 
@@ -579,6 +579,6 @@ void nthw_reg_nt400dxx_ops(struct nt400dxx_ops *ops)
 struct nt400dxx_ops *nthw_get_nt400dxx_ops(void)
 {
 	if (nt400dxx_ops == NULL)
-		nt400dxx_ops_init();
+		nthw_nt400dxx_ops_init();
 	return nt400dxx_ops;
 }
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 5a0ef125be..813ac04481 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1289,7 +1289,7 @@ static const struct ntnic_filter_ops ntnic_filter_ops = {
 	.poll_statistics = poll_statistics,
 };
 
-void ntnic_filter_init(void)
+void nthw_filter_ops_init(void)
 {
 	nthw_reg_filter_ops(&ntnic_filter_ops);
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 67ba694e25..00eb07f848 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -50,7 +50,7 @@ void nthw_reg_filter_ops(const struct ntnic_filter_ops *ops)
 const struct ntnic_filter_ops *nthw_get_filter_ops(void)
 {
 	if (ntnic_filter_ops == NULL)
-		ntnic_filter_init();
+		nthw_filter_ops_init();
 
 	return ntnic_filter_ops;
 }
@@ -82,7 +82,7 @@ void nthw_reg_agx_100g_link_ops(struct link_ops_s *ops)
 const struct link_ops_s *nthw_get_agx_100g_link_ops(void)
 {
 	if (link_agx_100g_ops == NULL)
-		link_agx_100g_init();
+		nthw_link_agx_100g_ops_init();
 	return link_agx_100g_ops;
 }
 
@@ -110,7 +110,7 @@ void nthw_reg_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops)
 const struct nt4ga_stat_ops *nthw_get_nt4ga_stat_ops(void)
 {
 	if (nt4ga_stat_ops == NULL)
-		nt4ga_stat_ops_init();
+		nthw_stat_ops_init();
 
 	return nt4ga_stat_ops;
 }
@@ -139,7 +139,7 @@ void nthw_reg_clk9563_ops(struct clk9563_ops *ops)
 struct clk9563_ops *nthw_get_clk9563_ops(void)
 {
 	if (clk9563_ops == NULL)
-		clk9563_ops_init();
+		nthw_clk9563_ops_init();
 	return clk9563_ops;
 }
 
@@ -153,7 +153,7 @@ void nthw_reg_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops)
 struct rst_nt200a0x_ops *nthw_get_rst_nt200a0x_ops(void)
 {
 	if (rst_nt200a0x_ops == NULL)
-		rst_nt200a0x_ops_init();
+		nthw_rst_nt200a0x_ops_init();
 	return rst_nt200a0x_ops;
 }
 
@@ -167,7 +167,7 @@ void nthw_reg_rst9563_ops(struct rst9563_ops *ops)
 struct rst9563_ops *nthw_get_rst9563_ops(void)
 {
 	if (rst9563_ops == NULL)
-		rst9563_ops_init();
+		nthw_rst9563_ops_init();
 	return rst9563_ops;
 }
 
@@ -188,7 +188,7 @@ void nthw_reg_rst9574_ops(struct rst9574_ops *ops)
 struct rst9574_ops *nthw_get_rst9574_ops(void)
 {
 	if (rst9574_ops == NULL)
-		rst9574_ops_init();
+		nthw_rst9574_ops_init();
 
 	return rst9574_ops;
 }
@@ -203,7 +203,7 @@ void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops)
 struct rst_nt400dxx_ops *nthw_get_rst_nt400dxx_ops(void)
 {
 	if (rst_nt400dxx_ops == NULL)
-		rst_nt400dxx_ops_init();
+		nthw_rst_nt400dxx_ops_init();
 
 	return rst_nt400dxx_ops;
 }
@@ -286,7 +286,7 @@ void nthw_reg_xstats_ops(struct ntnic_xstats_ops *ops)
 struct ntnic_xstats_ops *nthw_get_xstats_ops(void)
 {
 	if (ntnic_xstats_ops == NULL)
-		ntnic_xstats_ops_init();
+		nthw_xstats_ops_init();
 
 	return ntnic_xstats_ops;
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 2ed2286911..b534b09234 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -141,7 +141,7 @@ struct ntnic_filter_ops {
 
 void nthw_reg_filter_ops(const struct ntnic_filter_ops *ops);
 const struct ntnic_filter_ops *nthw_get_filter_ops(void);
-void ntnic_filter_init(void);
+void nthw_filter_ops_init(void);
 
 struct link_ops_s {
 	int (*link_init)(struct adapter_info_s *p_adapter_info, nthw_fpga_t *p_fpga);
@@ -153,7 +153,7 @@ void nthw_link_100g_init(void);
 
 void nthw_reg_agx_100g_link_ops(struct link_ops_s *ops);
 const struct link_ops_s *nthw_get_agx_100g_link_ops(void);
-void link_agx_100g_init(void);
+void nthw_link_agx_100g_ops_init(void);
 
 struct port_ops {
 	bool (*get_nim_present)(struct adapter_info_s *p, int port);
@@ -220,7 +220,7 @@ struct nt4ga_stat_ops {
 
 void nthw_reg_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops);
 const struct nt4ga_stat_ops *nthw_get_nt4ga_stat_ops(void);
-void nt4ga_stat_ops_init(void);
+void nthw_stat_ops_init(void);
 
 struct adapter_ops {
 	int (*init)(struct adapter_info_s *p_adapter_info);
@@ -240,7 +240,7 @@ struct clk9563_ops {
 
 void nthw_reg_clk9563_ops(struct clk9563_ops *ops);
 struct clk9563_ops *nthw_get_clk9563_ops(void);
-void clk9563_ops_init(void);
+void nthw_clk9563_ops_init(void);
 
 struct rst_nt200a0x_ops {
 	int (*nthw_fpga_rst_nt200a0x_init)(struct fpga_info_s *p_fpga_info,
@@ -251,7 +251,7 @@ struct rst_nt200a0x_ops {
 
 void nthw_reg_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops);
 struct rst_nt200a0x_ops *nthw_get_rst_nt200a0x_ops(void);
-void rst_nt200a0x_ops_init(void);
+void nthw_rst_nt200a0x_ops_init(void);
 
 struct rst9563_ops {
 	int (*nthw_fpga_rst9563_init)(struct fpga_info_s *p_fpga_info,
@@ -260,7 +260,7 @@ struct rst9563_ops {
 
 void nthw_reg_rst9563_ops(struct rst9563_ops *ops);
 struct rst9563_ops *nthw_get_rst9563_ops(void);
-void rst9563_ops_init(void);
+void nthw_rst9563_ops_init(void);
 
 struct rst9574_ops {
 	int (*nthw_fpga_rst9574_init)(struct fpga_info_s *p_fpga_info,
@@ -271,7 +271,7 @@ struct rst9574_ops {
 
 void nthw_reg_rst9574_ops(struct rst9574_ops *ops);
 struct rst9574_ops *nthw_get_rst9574_ops(void);
-void rst9574_ops_init(void);
+void nthw_rst9574_ops_init(void);
 
 struct rst_nt400dxx_ops {
 	int (*nthw_fpga_rst_nt400dxx_init)(struct fpga_info_s *p_fpga_info);
@@ -280,7 +280,7 @@ struct rst_nt400dxx_ops {
 
 void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops);
 struct rst_nt400dxx_ops *nthw_get_rst_nt400dxx_ops(void);
-void rst_nt400dxx_ops_init(void);
+void nthw_rst_nt400dxx_ops_init(void);
 
 struct flow_backend_ops {
 	const struct flow_api_backend_ops *(*nthw_bin_flow_backend_init)(nthw_fpga_t *p_fpga,
@@ -593,6 +593,6 @@ struct ntnic_xstats_ops {
 
 void nthw_reg_xstats_ops(struct ntnic_xstats_ops *ops);
 struct ntnic_xstats_ops *nthw_get_xstats_ops(void);
-void ntnic_xstats_ops_init(void);
+void nthw_xstats_ops_init(void);
 
 #endif	/* __NTNIC_MOD_REG_H__ */
diff --git a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
index 1ebf1b8eb5..ab3f144fa2 100644
--- a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
+++ b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
@@ -819,7 +819,7 @@ static struct ntnic_xstats_ops ops = {
 	.nthw_xstats_get_by_id = nthw_xstats_get_by_id
 };
 
-void ntnic_xstats_ops_init(void)
+void nthw_xstats_ops_init(void)
 {
 	NT_LOG_DBGX(DBG, NTNIC, "xstats module was initialized");
 	nthw_reg_xstats_ops(&ops);
-- 
2.45.0

