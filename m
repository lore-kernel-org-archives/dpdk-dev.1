Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD5AC28B2E
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 21:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8527E40ED4;
	Fri,  7 Mar 2025 22:52:10 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id D604B40ED2
 for <dev@dpdk.org>; Fri,  7 Mar 2025 22:52:08 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2234.outbound.protection.outlook.com [104.47.11.234]) by
 mx-outbound8-45.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 07 Mar 2025 21:52:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWQPCRMSXGN5byNSJhYJ6r6/mQDLGrvp2AUmgjXXNbbgcmvxcdaXabZ/dJD+uQZZRneZ8Ius9Zz2hqHiHOVdZOTdXu/S83aEO2VEKe5dp8864o9C2nGMz+LXIbiVuoQQMkdLfJE5eRcHRoYkMnJg3n6EwFmkemmWbrVImdqk0T/08tHtvOtPFeiqCtRYLAg4THqp+N00UNcap6s5lwbGd9Y7Pyvsc07wVs/UpODMJFlMgXtAaPRYlP/wpX3RcZ+938gq0iBjooacONWCzXNLlAF5RpDgeUQ9jop4bZc4y5Yy469m4MytZTkABqyj2VcXOe9uMfgrC+RJz3ZIFx32NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4wW1soXh//ZTND15x3bcdn2XaA6EcG74AYIKgVqLV0=;
 b=nOWRh5yQDG1dacuU2zWfQOUtwqlyztnYF23Qrcj+lKqh/1GdKVLoyGK4uf7Ec1LLhO9fOiMuP2MsJLUfHqjngAEesNCcIpIivzVUXcTNqG2WqwNlXLrBzIAi3BBzL6BFOoMhakRY/rB++8uA9brQPT4I0656SWdadLpEaoLnfYE9wrs/cfoKZgC9+0dsjJUGbW1972NEJEEZZzw8GOaVFzHKVE5e4gy3KLD0gyjdfwV6SKFVWjZcaaeMoxhPJQJDwzWGvcZU/DR44TfTPxVLkBamy0+0jsLUTmlBX24pYOpkrWZsbSTdhACTnR8KkxGofFqXPJwf/oCS1+ohrb/kIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4wW1soXh//ZTND15x3bcdn2XaA6EcG74AYIKgVqLV0=;
 b=V9LqVPSX4FC5a+9AR+1LIKeXdFov00OgvDWEYa3tsPGkoFWBFttOZEObTQh4GXVyYGf2PwpupQm/lIGzVqCMTMTxE3nD+S6L/4dc0yQzQW8BT2QJ5zT0pDI6wiWfGHydaYAMN8qyW1QcGfVdj5GjBk02iOBXZIsaGN43VsXjfk4=
Received: from PR3P191CA0058.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::33)
 by AM9P190MB1138.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 21:52:00 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:102:55:cafe::89) by PR3P191CA0058.outlook.office365.com
 (2603:10a6:102:55::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 21:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server id 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 21:51:59
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 3/5] net/ntnic: replace assert with RTE assert
Date: Fri,  7 Mar 2025 22:51:33 +0100
Message-ID: <20250307215136.3110019-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250307215136.3110019-1-sil-plv@napatech.com>
References: <20250307215136.3110019-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|AM9P190MB1138:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8389b951-e840-416a-8c3d-08dd5dc249da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u5JFbmsFPDetb+K8pD12giYT6pkTgX1brc8rF+gTCdgL+L+L+qSzqk9Ak7FX?=
 =?us-ascii?Q?I6VqwuPjDO0rOKBv0c+FgY1hqCL/2jqFwnRDz1jCwUVCmSUUqLSj2udego44?=
 =?us-ascii?Q?pYixg4dDpoCRhBkAzEcK6L8FnBZU6d4kplQfVBrJyWmdp2cFrM5hfgj7Rq5I?=
 =?us-ascii?Q?lte4vXvckZx/6q6uPr+eew0EM0Nx5Yc02jvzgyZAAZL+9BB6g0NRLum8BZPY?=
 =?us-ascii?Q?AYY6CtV3KVwuAfjJ5eEIcbQG7qTxg2c1ovuSxK3g0ne8qgq+FzTVLYBkO+Nt?=
 =?us-ascii?Q?LkGDedlZZ7CCEnpZkqbZ7WRFY9Vy6WBeHROBdfHasgcqY5gZFis+HKcTNP7Z?=
 =?us-ascii?Q?Hk14VmlwjESTrFWyLHG1yM+fR3eHfrJw3N7k42kEE93mPN8uz9nWL+5Nj/LO?=
 =?us-ascii?Q?ApnU9EbboKotajUY3iMIhcrD/EHwuteVTtlj58vJgETPeLa2gWgcfJsv9XA5?=
 =?us-ascii?Q?orJeavapdVegb52p0vo46e7cDfMZdeS5rBghZH33AseSZ08ZFOK7D3uAWtI5?=
 =?us-ascii?Q?/9/sXKR85Y8PNLqFNlYquM7E6fT4jEOAY7URBGCERbMTOxeP6Gf6prW/P4pM?=
 =?us-ascii?Q?UjQj5+DMjkDqpBuKYy3+86adgUNIdGDFgJlATpilBP+h8Z+22kHFk7kIbSUL?=
 =?us-ascii?Q?clxvPk5BS616sVFRgEN1T9JkIks5HG6XuLyhmRsdfI62RDNWpmhGeUubf1Bf?=
 =?us-ascii?Q?6nWNhndOrbm+p8aK3WArJicQ1nox8RYyPvx/biAmCdJXzQRwPMH4Je5zqH7v?=
 =?us-ascii?Q?83WtEvrXya646VYbcx79WZgfiFSysoQthFjSgDDVxncK0Jqe1YDLbysZ5S5q?=
 =?us-ascii?Q?1fkhpTbRcrX0TCrXJC1ocgfiQYkGPulY81QlWgHvdq3BVXDvwEi+Jb4HvFOS?=
 =?us-ascii?Q?c+jPrBjJTENYc7/z0V8tVLsEYkwcveQhJqtaGcCAEfYrGwZA74I2SvIbvz0u?=
 =?us-ascii?Q?APsKkg0xj9+JsRTt8o/aTa2MhEZKafeUpcTSALan1//aIPa8Dd1FAVGcsOqL?=
 =?us-ascii?Q?PK21v87afwqUtJYgBlPjVhwL0HTjnSOvrUC63oh5Um1dvuaQZcZ5L8zIJ951?=
 =?us-ascii?Q?a9jqfM0hu7qF1DbYAr3ZV9wzuLo+KliDOgwEu57ATSC5OnILGV6Jx5TBEBLI?=
 =?us-ascii?Q?flMmPSzAGPlqRMvAujNPtxBfeSh/T1Wb0WmATIxkHDInN6P5Bt0I1XpfIDM5?=
 =?us-ascii?Q?Gb272t91S0XvTzpUOzzj5cMdBp4t/DM93xMVAI0Iox/1/r59dmU/v4uMP9mS?=
 =?us-ascii?Q?P4zoHU52j/Hxy0Hphim7aIjQLttQ2ybB3N6EyjuGNEpHrG1aFrcYRv8DyVN+?=
 =?us-ascii?Q?dODaB9HbhySBNoaB1X09uvGK1Q2c8CWn141u+fYPouLWSiLQPjvIkdnKneF/?=
 =?us-ascii?Q?kyeXeC06W2w08X5VsBOHcacYzJrYElj/uQaHgzJ9q3FSW25BXmvI36i4KRlH?=
 =?us-ascii?Q?QGmZflX8BYcCnH7pDBR7g9czdZZQY3h+VMlPOMGCnrRD9fuO53SgJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M27NNgDxENP2uai5GY77loMagYabf9sy/ZeYDJJPJttvAp/LpEV3fKBmFsACH6zChtSDzOgCnz57XndIIaEeOlEl9HawOaa1A76Yz+4XpL86tjPR65e8h5qTh6hKKyyeC8vqD+tfN0fOAb6gyZzZ1YlGUy+7J6DKfJIXmTrvDt6KxmFXdc8bQ+T5YtLvKoAxnuTOKwP10eqZvnaXbwEWSwqe8OHpo2GFZwUk443Wju94HPHlFofmBb/nN8iPNodBaq5+bJOxB748VJ8QJn/jmrPEuZyvtcOaZ/kjSPXKoYjnrJfDmhFU0mCEaeJ0L1cjb8ZSsNTVqN011CDBR8UQfVM8ZLYO/2egWDaTdjdgptGSGEQU9Qz0ARZShxSsMljKHPIenB3dljhZ0gMgNuMvaaTxfZ4P5hY/sGIhghMJkNmU4nWV1Fel8ef7w1ipIjFSmWzpSQvtdL9IY6qrJJ2Z+zwi8lu/ngHBYEEaLCES7UqlCz4gkkbffqfGRi88uiGQBrKCjMe/KbC27MY1okbRfLzQp8VZSJKIBFdp+/aYHm1nxYgIpHL21BZ8pkeY8sgYcFIHHqY0+StwyE8qaRIGgH43b9V8NTpWJWVu5zcMrWq3Fdz7qWutD8xnzDtN/YQIf0CrrNqS/kKea0kXPMbvMw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:51:59.7139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8389b951-e840-416a-8c3d-08dd5dc249da
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1138
X-BESS-ID: 1741384322-302093-7650-43352-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.11.234
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYWJuYGQGYGUNQg1dzMwNI0zT
 TZxCA52SI1ySAxLcXAJC0lMdHY1NwkUak2FgBpE/XmQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262990 [from 
 cloudscan17-38.eu-central-1b.ess.aws.cudaops.com]
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

Use RTE_ASSERT instead of direct calling asserts

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     | 14 ++-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  6 +-
 drivers/net/ntnic/include/flow_api.h          |  2 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     | 22 ++---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 20 ++--
 drivers/net/ntnic/nim/i2c_nim.c               |  6 +-
 .../nthw/core/nt200a0x/nthw_fpga_nt200a0x.c   |  2 +-
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c   |  6 +-
 .../nt200a0x/reset/nthw_fpga_rst_nt200a0x.c   | 12 +--
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  4 +-
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   | 18 ++--
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |  8 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |  8 +-
 drivers/net/ntnic/nthw/core/nthw_gfg.c        |  4 +-
 drivers/net/ntnic/nthw/core/nthw_gpio_phy.c   |  6 +-
 drivers/net/ntnic/nthw/core/nthw_hif.c        |  6 +-
 drivers/net/ntnic/nthw/core/nthw_iic.c        |  6 +-
 drivers/net/ntnic/nthw/core/nthw_mac_pcs.c    |  4 +-
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      |  2 +-
 drivers/net/ntnic/nthw/core/nthw_spim.c       |  2 +-
 drivers/net/ntnic/nthw/core/nthw_spis.c       |  4 +-
 drivers/net/ntnic/nthw/flow_api/flow_api.c    | 16 ++--
 .../nthw/flow_api/flow_backend/flow_backend.c |  2 +-
 drivers/net/ntnic/nthw/flow_api/flow_km.c     | 31 +++----
 .../nthw/flow_api/hw_mod/hw_mod_backend.c     |  7 +-
 .../flow_api/profile_inline/flm_evt_queue.c   |  1 -
 .../flow_api/profile_inline/flm_lrn_queue.c   |  3 +-
 .../profile_inline/flow_api_profile_inline.c  | 22 ++---
 .../ntnic/nthw/flow_filter/flow_nthw_cat.c    | 40 ++++----
 .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |  2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_flm.c    | 93 ++++++++++---------
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |  2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |  2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.c    | 18 ++--
 .../ntnic/nthw/flow_filter/flow_nthw_info.c   |  2 +-
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |  2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |  2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |  2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c | 22 ++---
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |  2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c | 16 ++--
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |  2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |  4 +-
 .../net/ntnic/nthw/model/nthw_fpga_model.c    | 58 ++++++------
 drivers/net/ntnic/nthw/nthw_rac.c             | 16 ++--
 drivers/net/ntnic/nthw/stat/nthw_stat.c       |  4 +-
 drivers/net/ntnic/ntnic_ethdev.c              | 18 ++--
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  2 +-
 drivers/net/ntnic/ntutil/nt_util.c            |  1 -
 49 files changed, 279 insertions(+), 275 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index fe9d397293..95692d666d 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -89,8 +89,10 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 	 * IMPORTANT: Most variables cannot be determined before nthw fpga model is instantiated
 	 * (nthw_fpga_init())
 	 */
+#ifdef RTE_ENABLE_ASSERT
 	int n_phy_ports = -1;
 	int n_nim_ports = -1;
+#endif
 	int res = -1;
 	nthw_fpga_t *p_fpga = NULL;
 
@@ -152,13 +154,15 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 		return res;
 	}
 
-	assert(fpga_info);
+#ifdef RTE_ENABLE_ASSERT
+	RTE_ASSERT(fpga_info);
 	p_fpga = fpga_info->mp_fpga;
-	assert(p_fpga);
+	RTE_ASSERT(p_fpga);
 	n_phy_ports = fpga_info->n_phy_ports;
-	assert(n_phy_ports >= 1);
+	RTE_ASSERT(n_phy_ports >= 1);
 	n_nim_ports = fpga_info->n_nims;
-	assert(n_nim_ports >= 1);
+	RTE_ASSERT(n_nim_ports >= 1);
+#endif
 
 	/* Nt4ga Init Filter */
 	nt4ga_filter_t *p_filter = &p_adapter_info->nt4ga_filter;
@@ -176,7 +180,7 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 	{
 		int i;
 		const struct link_ops_s *link_ops = NULL;
-		assert(fpga_info->n_fpga_prod_id > 0);
+		RTE_ASSERT(fpga_info->n_fpga_prod_id > 0);
 
 		for (i = 0; i < NUM_ADAPTER_PORTS_MAX; i++) {
 			/* Disable all ports. Must be enabled later */
diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index e1eccb647c..222a553684 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -207,7 +207,7 @@ static void dbs_init_tx_queue(nthw_dbs_t *p_nthw_dbs, uint32_t queue, uint32_t s
 
 static int nthw_virt_queue_init(struct fpga_info_s *p_fpga_info)
 {
-	assert(p_fpga_info);
+	RTE_ASSERT(p_fpga_info);
 
 	nthw_fpga_t *const p_fpga = p_fpga_info->mp_fpga;
 	nthw_dbs_t *p_nthw_dbs;
@@ -906,8 +906,8 @@ static int nthw_setup_managed_virt_queue_packed(struct nthw_virt_queue *vq,
 	int rx)
 {
 	/* page aligned */
-	assert(((uintptr_t)p_virt_struct_area->phys_addr & 0xfff) == 0);
-	assert(p_packet_buffers);
+	RTE_ASSERT(((uintptr_t)p_virt_struct_area->phys_addr & 0xfff) == 0);
+	RTE_ASSERT(p_packet_buffers);
 
 	/* clean canvas */
 	memset(p_virt_struct_area->virt_addr, 0,
diff --git a/drivers/net/ntnic/include/flow_api.h b/drivers/net/ntnic/include/flow_api.h
index 7f6aa82ee0..5ffdf90012 100644
--- a/drivers/net/ntnic/include/flow_api.h
+++ b/drivers/net/ntnic/include/flow_api.h
@@ -202,7 +202,7 @@ extern const char *dbg_res_descr[];
 		size_t _temp_index = (index);                                                     \
 		NT_LOG(DBG, FILTER, "mark resource used: %s idx %zu",                             \
 		       dbg_res_descr[_temp_res_type], _temp_index);                               \
-		assert(flow_nic_is_bit_set(_temp_ndev->res[_temp_res_type].alloc_bm,              \
+		RTE_ASSERT(flow_nic_is_bit_set(_temp_ndev->res[_temp_res_type].alloc_bm,          \
 					   _temp_index) == 0);                                    \
 		flow_nic_set_bit(_temp_ndev->res[_temp_res_type].alloc_bm, _temp_index);          \
 	} while (0)
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index 67dc0d01f6..ce52c79f43 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -144,7 +144,7 @@ static int _link_state_build(adapter_info_t *drv, nthw_mac_pcs_t *mac_pcs,
 		&lh_remote_fault, &lh_internal_local_fault,
 		&lh_received_local_fault);
 
-	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
 	state->nim_present = nthw_gpio_phy_is_module_present(gpio_phy, (uint8_t)port);
 	state->lh_nim_absent = !state->nim_present;
 	state->link_up = phy_link_state ? true : false;
@@ -177,7 +177,7 @@ static int _link_state_build(adapter_info_t *drv, nthw_mac_pcs_t *mac_pcs,
  */
 static bool _nim_is_present(nthw_gpio_phy_t *gpio_phy, uint8_t if_no)
 {
-	assert(if_no < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(if_no < NUM_ADAPTER_PORTS_MAX);
 
 	return nthw_gpio_phy_is_module_present(gpio_phy, if_no);
 }
@@ -258,8 +258,8 @@ static int _create_nim(adapter_info_t *drv, int port, bool enable)
 	nt4ga_link_t *link_info = &drv->nt4ga_link;
 	nthw_mac_pcs_t *mac_pcs = &link_info->u.var100g.mac_pcs100g[port];
 
-	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
-	assert(link_info->variables_initialized);
+	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(link_info->variables_initialized);
 
 	gpio_phy = &link_info->u.var100g.gpio_phy[port];
 	nim_ctx = &link_info->u.var100g.nim_ctx[port];
@@ -355,8 +355,8 @@ static int _port_init(adapter_info_t *drv, nthw_fpga_t *fpga, int port)
 
 	nthw_mac_pcs_t *mac_pcs;
 
-	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
-	assert(link_info->variables_initialized);
+	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(link_info->variables_initialized);
 
 	if (fpga && fpga->p_fpga_info) {
 		adapter_id = fpga->p_fpga_info->n_nthw_adapter_id;
@@ -444,7 +444,7 @@ static int _port_init(adapter_info_t *drv, nthw_fpga_t *fpga, int port)
 
 	} else {
 		NT_LOG(ERR, NTNIC, "Unhandled AdapterId/HwId: %02x_hwid%d", adapter_id, hw_id);
-		assert(0);
+		RTE_ASSERT(0);
 	}
 
 	_reset_rx(drv, mac_pcs);
@@ -494,7 +494,7 @@ static int _common_ptp_nim_state_machine(void *data)
 		goto NT4GA_LINK_100G_MON_EXIT;
 	}
 
-	assert(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
+	RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
 	nim_ctx = link_info->u.var100g.nim_ctx;
 	link_state = link_info->link_state;
 	mac_pcs = link_info->u.var100g.mac_pcs100g;
@@ -521,7 +521,7 @@ static int _common_ptp_nim_state_machine(void *data)
 				break;
 
 			/* Has the administrative port state changed? */
-			assert(!(disable_port && enable_port));
+			RTE_ASSERT(!(disable_port && enable_port));
 
 			if (disable_port) {
 				memset(&link_state[i], 0, sizeof(link_state[i]));
@@ -603,7 +603,7 @@ static int _common_ptp_nim_state_machine(void *data)
 					continue;
 				}
 
-				assert(new_state.br);	/* Cannot be zero if NIM is present */
+				RTE_ASSERT(new_state.br); /* Cannot be zero if NIM is present */
 				NT_LOG(DBG, NTNIC,
 					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
 					drv->mp_port_id_str[i], nim_ctx->nim_id,
@@ -669,7 +669,7 @@ static int nt4ga_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nth
 	/*
 	 * Initialize global variables
 	 */
-	assert(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
+	RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
 
 	if (res == 0 && !p_adapter_info->nt4ga_link.variables_initialized) {
 		nthw_mac_pcs_t *mac_pcs = p_adapter_info->nt4ga_link.u.var100g.mac_pcs100g;
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 3f59c4a6b8..06ee7e2b95 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -78,14 +78,14 @@ static void phy_get_link_state(adapter_info_t *drv,
 static void phy_rx_path_rst(adapter_info_t *drv, int port, bool reset)
 {
 	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
-	NT_LOG(DBG, NTNIC, "Port %d: %s", port, reset ? "assert" : "deassert");
+	NT_LOG(DBG, NTNIC, "Port %d: %s", port, reset ? "RTE_ASSERT" : "deassert");
 	nthw_phy_tile_set_rx_reset(p, port, reset);
 }
 
 static void phy_tx_path_rst(adapter_info_t *drv, int port, bool reset)
 {
 	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
-	NT_LOG(DBG, NTNIC, "Port %d: %s", port, reset ? "assert" : "deassert");
+	NT_LOG(DBG, NTNIC, "Port %d: %s", port, reset ? "RTE_ASSERT" : "deassert");
 	nthw_phy_tile_set_tx_reset(p, port, reset);
 }
 
@@ -246,7 +246,7 @@ static void nim_set_reset(struct nim_i2c_ctx *ctx, uint8_t nim_idx, bool reset)
 
 static bool nim_is_present(nim_i2c_ctx_p ctx, uint8_t nim_idx)
 {
-	assert(nim_idx < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(nim_idx < NUM_ADAPTER_PORTS_MAX);
 
 	nthw_pcal6416a_t *p = ctx->hwagx.p_io_nim;
 	uint8_t data = 0;
@@ -521,8 +521,8 @@ static int create_nim(adapter_info_t *drv, int port, bool enable)
 	nt4ga_link_t *link_info = &drv->nt4ga_link;
 	nim_i2c_ctx_t *nim_ctx = &link_info->u.nim_ctx[port];
 
-	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
-	assert(link_info->variables_initialized);
+	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(link_info->variables_initialized);
 
 	if (!enable) {
 		phy_reset_rx(drv, port);
@@ -722,8 +722,8 @@ static int _port_init(adapter_info_t *p_info, nthw_fpga_t *fpga, int port)
 	nthw_phy_tile_t *p_phy_tile = p_info->fpga_info.mp_nthw_agx.p_phy_tile;
 	nthw_rpf_t *p_rpf = p_info->fpga_info.mp_nthw_agx.p_rpf;
 
-	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
-	assert(link_info->variables_initialized);
+	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(link_info->variables_initialized);
 
 	link_info->link_info[port].link_speed = NT_LINK_SPEED_100G;
 	link_info->link_info[port].link_duplex = NT_LINK_DUPLEX_FULL;
@@ -794,7 +794,7 @@ static void *_common_ptp_nim_state_machine(void *data)
 		goto NT4GA_LINK_100G_MON_EXIT;
 	}
 
-	assert(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
+	RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
 
 	monitor_task_is_running[adapter_no] = 1;
 	memset(last_lpbk_mode, 0, sizeof(last_lpbk_mode));
@@ -828,7 +828,7 @@ static void *_common_ptp_nim_state_machine(void *data)
 			/*
 			 * Has the administrative port state changed?
 			 */
-			assert(!(disable_port && enable_port));
+			RTE_ASSERT(!(disable_port && enable_port));
 
 			if (disable_port) {
 				memset(&link_state[i], 0, sizeof(link_state[i]));
@@ -912,7 +912,7 @@ static void *_common_ptp_nim_state_machine(void *data)
 					continue;
 				}
 
-				assert(new_state.br);	/* Cannot be zero if NIM is present */
+				RTE_ASSERT(new_state.br); /* Cannot be zero if NIM is present */
 				NT_LOG(DBG, NTNIC,
 					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
 					drv->mp_port_id_str[i], nim_ctx->nim_id,
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 892e1b58b7..3706aaa045 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -302,8 +302,8 @@ static int qsfp_nim_state_build(nim_i2c_ctx_t *ctx, sfp_nim_state_t *state)
 {
 	int res = 0;	/* unused due to no readings from HW */
 
-	assert(ctx && state);
-	assert(ctx->nim_id != NT_NIM_UNKNOWN && "Nim is not initialized");
+	RTE_ASSERT(ctx && state);
+	RTE_ASSERT(ctx->nim_id != NT_NIM_UNKNOWN && "Nim is not initialized");
 
 	(void)memset(state, 0, sizeof(*state));
 
@@ -628,7 +628,7 @@ static void qsfpplus_set_speed_mask(nim_i2c_ctx_p ctx)
 
 static void qsfpplus_construct(nim_i2c_ctx_p ctx, int8_t lane_idx)
 {
-	assert(lane_idx < 4);
+	RTE_ASSERT(lane_idx < 4);
 	ctx->specific_u.qsfp.qsfp28 = false;
 	ctx->lane_idx = lane_idx;
 	ctx->lane_count = 4;
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
index 670bbd3f7e..bf7a2760a4 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
@@ -10,7 +10,7 @@
 
 static int nthw_fpga_nt200a0x_init(struct fpga_info_s *p_fpga_info)
 {
-	assert(p_fpga_info);
+	RTE_ASSERT(p_fpga_info);
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 	struct nthw_fpga_rst_nt200a0x rst;
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index 319b7bde52..ee2c2453e5 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -21,7 +21,7 @@ static int nthw_fpga_rst9563_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt2
 	nthw_module_t *p_mod_rst;
 	nthw_register_t *p_curr_reg;
 
-	assert(p);
+	RTE_ASSERT(p);
 	p->mn_fpga_product_id = n_fpga_product_id;
 	p->mn_fpga_version = n_fpga_version;
 	p->mn_fpga_revision = n_fpga_revision;
@@ -195,8 +195,8 @@ static int nthw_fpga_rst9563_clock_synth_init(nthw_fpga_t *p_fpga,
 static int nthw_fpga_rst9563_init(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt200a0x *p_rst)
 {
-	assert(p_fpga_info);
-	assert(p_rst);
+	RTE_ASSERT(p_fpga_info);
+	RTE_ASSERT(p_rst);
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 	(void)p_adapter_id_str;
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
index d35618c6ba..3528792845 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
@@ -224,7 +224,7 @@ static int nthw_fpga_rst_nt200a0x_reset(nthw_fpga_t *p_fpga,
 	NT_LOG_DBGX(DBG, NTHW, "%s: FPGA reset sequence: FPGA %04d-%02d-%02d @ HWId%d",
 		p_adapter_id_str, n_fpga_product_id, n_fpga_version, n_fpga_revision,
 		n_hw_id);
-	assert(n_fpga_product_id == p_fpga->mn_product_id);
+	RTE_ASSERT(n_fpga_product_id == p_fpga->mn_product_id);
 
 	/*
 	 * Reset all domains / modules except peripherals
@@ -296,7 +296,7 @@ static int nthw_fpga_rst_nt200a0x_reset(nthw_fpga_t *p_fpga,
 	nthw_field_update_register(p->mp_fld_ctrl_ts_clk_sel);
 	nthw_field_set_flush(p->mp_fld_ctrl_ts_clk_sel);
 
-	/* 4: De-assert sys reset, CORE and SYS MMCM resets */
+	/* 4: De-RTE_ASSERT sys reset, CORE and SYS MMCM resets */
 	NT_LOG(DBG, NTHW, "%s: De-asserting SYS, CORE and SYS MMCM resets", p_adapter_id_str);
 	nthw_field_update_register(p->mp_fld_rst_sys);
 	nthw_field_clr_flush(p->mp_fld_rst_sys);
@@ -353,7 +353,7 @@ static int nthw_fpga_rst_nt200a0x_reset(nthw_fpga_t *p_fpga,
 	nthw_field_clr_flush(p->mp_fld_rst_phy);
 
 	/*
-	 * 8: De-assert reset for remaining domains/modules resets except
+	 * 8: De-RTE_ASSERT reset for remaining domains/modules resets except
 	 * TS, PTP, PTP_MMCM and TS_MMCM
 	 */
 	NT_LOG(DBG, NTHW, "%s: De-asserting TMC RST", p_adapter_id_str);
@@ -408,7 +408,7 @@ static int nthw_fpga_rst_nt200a0x_reset(nthw_fpga_t *p_fpga,
 
 	/*
 	 * Timesync/PTP reset sequence
-	 * De-assert TS_MMCM reset
+	 * De-RTE_ASSERT TS_MMCM reset
 	 */
 	NT_LOG(DBG, NTHW, "%s: De-asserting TS MMCM RST", p_adapter_id_str);
 	nthw_field_clr_flush(p->mp_fld_rst_ts_mmcm);
@@ -437,7 +437,7 @@ static int nthw_fpga_rst_nt200a0x_reset(nthw_fpga_t *p_fpga,
 	if (p->mp_fld_sticky_pci_sys_mmcm_unlocked)
 		nthw_field_set_flush(p->mp_fld_sticky_pci_sys_mmcm_unlocked);
 
-	/* De-assert TS reset bit */
+	/* De-RTE_ASSERT TS reset bit */
 	NT_LOG(DBG, NTHW, "%s: De-asserting TS RST", p_adapter_id_str);
 	nthw_field_clr_flush(p->mp_fld_rst_ts);
 
@@ -513,7 +513,7 @@ static int nthw_fpga_rst_nt200a0x_reset(nthw_fpga_t *p_fpga,
 static int nthw_fpga_rst_nt200a0x_init(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt200a0x *p_rst)
 {
-	assert(p_fpga_info);
+	RTE_ASSERT(p_fpga_info);
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 	int res = -1;
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 121cedbb1f..d610e3a7cc 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -112,7 +112,7 @@ static int nthw_fpga_nt400dxx_init_sub_systems(struct fpga_info_s *p_fpga_info)
 
 static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 {
-	assert(p_fpga_info);
+	RTE_ASSERT(p_fpga_info);
 	struct rst9574_ops *rst9574_ops = NULL;
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
@@ -120,7 +120,7 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	int res = -1;
 
 	nthw_fpga_t *p_fpga = p_fpga_info->mp_fpga;
-	assert(p_fpga);
+	RTE_ASSERT(p_fpga);
 
 	switch (p_fpga_info->n_fpga_prod_id) {
 	case 9574:
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index b1bbe28709..8cad9fac5a 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -11,8 +11,8 @@
 
 static int nthw_fpga_rst9574_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt400dxx *const p)
 {
-	assert(p_fpga);
-	assert(p);
+	RTE_ASSERT(p_fpga);
+	RTE_ASSERT(p);
 
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	const int n_fpga_product_id = p_fpga->mn_product_id;
@@ -238,8 +238,8 @@ static int nthw_fpga_rst9574_wait_phy_ftile_rst_done(struct fpga_info_s *p_fpga_
 static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
-	assert(p_fpga_info);
-	assert(p_rst);
+	RTE_ASSERT(p_fpga_info);
+	RTE_ASSERT(p_rst);
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 	int res = -1;
@@ -253,7 +253,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	 */
 	nt_os_wait_usec(2000);
 
-	/* (1) De-assert DDR4 reset: */
+	/* (1) De-RTE_ASSERT DDR4 reset: */
 	NT_LOG(DBG, NTHW, "%s: %s: De-asserting DDR4 reset", p_adapter_id_str, __func__);
 	nthw_fpga_rst9574_ddr4_rst(p_rst, 0);
 
@@ -296,7 +296,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 				return res;
 		}
 
-		/* (6) De-assert PHY_FTILE reset: */
+		/* (6) De-RTE_ASSERT PHY_FTILE reset: */
 		NT_LOG(DBG, NTHW, "%s: %s: De-asserting PHY_FTILE reset", p_adapter_id_str,
 			__func__);
 		nthw_fpga_rst9574_phy_ftile_rst(p_rst, 0);
@@ -349,7 +349,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 
 	} while (!success);
 
-	/* (8) De-assert SYS reset: */
+	/* (8) De-RTE_ASSERT SYS reset: */
 	NT_LOG(DBG, NTHW, "%s: %s: De-asserting SYS reset", p_adapter_id_str, __func__);
 	nthw_fpga_rst9574_sys_rst(p_rst, 0);
 
@@ -359,8 +359,8 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 static int nthw_fpga_rst9574_init(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
-	assert(p_fpga_info);
-	assert(p_rst);
+	RTE_ASSERT(p_fpga_info);
+	RTE_ASSERT(p_rst);
 	int res = nthw_fpga_rst9574_product_reset(p_fpga_info, p_rst);
 
 	return res;
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index b93b0a829a..237c19bb95 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -13,7 +13,7 @@
 
 static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 {
-	assert(p_fpga_info);
+	RTE_ASSERT(p_fpga_info);
 	int res = -1;
 	nthw_fpga_t *p_fpga = NULL;
 
@@ -191,7 +191,7 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 	nthw_pcm_nt400dxx_t *p_pcm = p_fpga_info->mp_nthw_agx.p_pcm;
 	nthw_prm_nt400dxx_t *p_prm = p_fpga_info->mp_nthw_agx.p_prm;
 
-	assert(p_fpga_info);
+	RTE_ASSERT(p_fpga_info);
 
 	NT_LOG(DBG, NTHW, "%s: %s: BEGIN", p_adapter_id_str, __PRETTY_FUNCTION__);
 
@@ -310,7 +310,7 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 	/*
 	 * At this point all system clocks and TS clocks are running.
 	 * Last thing to do before proceeding to product reset is to
-	 * de-assert the platform reset and enable the RAB buses.
+	 * de-RTE_ASSERT the platform reset and enable the RAB buses.
 	 */
 
 	/* (K1) Force HIF soft reset. */
@@ -325,7 +325,7 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 	nt_os_wait_usec(1000);
 	nthw_hif_delete(p_nthw_hif);
 
-	/* (L) De-assert platform reset. */
+	/* (L) De-RTE_ASSERT platform reset. */
 	nthw_prm_nt400dxx_platform_rst(p_prm, 0);
 
 	/*
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 3166a2ba51..8831eeb4d3 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -75,7 +75,7 @@ int nthw_fpga_iic_scan(nthw_fpga_t *p_fpga, const int n_instance_no_begin,
 {
 	int i;
 
-	assert(n_instance_no_begin <= n_instance_no_end);
+	RTE_ASSERT(n_instance_no_begin <= n_instance_no_end);
 
 	for (i = n_instance_no_begin; i <= n_instance_no_end; i++) {
 		nthw_iic_t *p_nthw_iic = nthw_iic_new();
@@ -606,8 +606,8 @@ int nthw_fpga_si5340_clock_synth_init_fmt2(nthw_fpga_t *p_fpga, const uint8_t n_
 	nthw_iic_t *p_nthw_iic = nthw_iic_new();
 	nthw_si5340_t *p_nthw_si5340 = nthw_si5340_new();
 
-	assert(p_nthw_iic);
-	assert(p_nthw_si5340);
+	RTE_ASSERT(p_nthw_iic);
+	RTE_ASSERT(p_nthw_si5340);
 	nthw_iic_init(p_nthw_iic, p_fpga, 0, 8);/* I2C cycle time 125Mhz ~ 8ns */
 
 	nthw_si5340_init(p_nthw_si5340, p_nthw_iic, n_iic_addr);/* si5340_u23_i2c_addr_7bit */
@@ -636,7 +636,7 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 
 	int res = 0;
 
-	assert(p_fpga_info);
+	RTE_ASSERT(p_fpga_info);
 
 	{
 		const uint64_t n_fpga_ident = nthw_fpga_read_ident(p_fpga_info);
diff --git a/drivers/net/ntnic/nthw/core/nthw_gfg.c b/drivers/net/ntnic/nthw/core/nthw_gfg.c
index aa71624457..9cee45449b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_gfg.c
+++ b/drivers/net/ntnic/nthw/core/nthw_gfg.c
@@ -304,7 +304,7 @@ static int nthw_gfg_setup(nthw_gfg_t *p,
 		(size_t)n_intf_no >= ARRAY_SIZE(p->mpa_fld_ctrl_size) ||
 		n_intf_no >= ARRAY_SIZE(p->mpa_fld_stream_id_val) ||
 		(size_t)n_intf_no >= ARRAY_SIZE(p->mpa_fld_burst_size_val)) {
-		assert(false);
+		RTE_ASSERT(false);
 		return -1;
 	}
 
@@ -312,7 +312,7 @@ static int nthw_gfg_setup(nthw_gfg_t *p,
 		p->mpa_fld_ctrl_size[n_intf_no] == NULL ||
 		p->mpa_fld_stream_id_val[n_intf_no] == NULL ||
 		p->mpa_fld_burst_size_val[n_intf_no] == NULL) {
-		assert(false);
+		RTE_ASSERT(false);
 		return -1;
 	}
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_gpio_phy.c b/drivers/net/ntnic/nthw/core/nthw_gpio_phy.c
index 29bdddb514..0fa5b15f5b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_gpio_phy.c
+++ b/drivers/net/ntnic/nthw/core/nthw_gpio_phy.c
@@ -104,7 +104,7 @@ int nthw_gpio_phy_init(nthw_gpio_phy_t *p, nthw_fpga_t *p_fpga, int n_instance)
 bool nthw_gpio_phy_is_module_present(nthw_gpio_phy_t *p, uint8_t if_no)
 {
 	if (if_no >= ARRAY_SIZE(p->mpa_fields)) {
-		assert(false);
+		RTE_ASSERT(false);
 		return false;
 	}
 
@@ -115,7 +115,7 @@ bool nthw_gpio_phy_is_module_present(nthw_gpio_phy_t *p, uint8_t if_no)
 void nthw_gpio_phy_set_low_power(nthw_gpio_phy_t *p, uint8_t if_no, bool enable)
 {
 	if (if_no >= ARRAY_SIZE(p->mpa_fields)) {
-		assert(false);
+		RTE_ASSERT(false);
 		return;
 	}
 
@@ -131,7 +131,7 @@ void nthw_gpio_phy_set_low_power(nthw_gpio_phy_t *p, uint8_t if_no, bool enable)
 void nthw_gpio_phy_set_reset(nthw_gpio_phy_t *p, uint8_t if_no, bool enable)
 {
 	if (if_no >= ARRAY_SIZE(p->mpa_fields)) {
-		assert(false);
+		RTE_ASSERT(false);
 		return;
 	}
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index 630262a7fc..e1ca80046d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -300,7 +300,7 @@ int nthw_hif_stat_req_disable(nthw_hif_t *p)
 
 int nthw_hif_end_point_counters_sample(nthw_hif_t *p, struct nthw_hif_end_point_counters *epc)
 {
-	assert(epc);
+	RTE_ASSERT(epc);
 
 	/* Get stat rate and maintain rx/tx min/max */
 	nthw_hif_get_stat_rate(p, &epc->cur_tx, &epc->cur_rx, &epc->n_ref_clk_cnt,
@@ -341,7 +341,7 @@ int nthw_hif_read_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t *p_value)
 		break;
 
 	default:
-		assert(false);
+		RTE_ASSERT(false);
 		return -1;
 	}
 
@@ -384,7 +384,7 @@ int nthw_hif_write_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t value)
 		break;
 
 	default:
-		assert(false);
+		RTE_ASSERT(false);
 		return -1;
 	}
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_iic.c b/drivers/net/ntnic/nthw/core/nthw_iic.c
index 269754c24a..0d50721710 100644
--- a/drivers/net/ntnic/nthw/core/nthw_iic.c
+++ b/drivers/net/ntnic/nthw/core/nthw_iic.c
@@ -66,7 +66,7 @@ static int nthw_iic_reg_tx_fifo_write(nthw_iic_t *p, uint32_t data, bool start,
 
 static int nthw_iic_reg_read_i2c_rx_fifo(nthw_iic_t *p, uint8_t *p_data)
 {
-	assert(p_data);
+	RTE_ASSERT(p_data);
 
 	*p_data = (uint8_t)nthw_field_get_updated(p->mp_fld_rx_fifo_rxdata);
 
@@ -91,7 +91,7 @@ static int nthw_iic_reg_enable(nthw_iic_t *p)
 
 static int nthw_iic_reg_busbusy(nthw_iic_t *p, bool *pb_flag)
 {
-	assert(pb_flag);
+	RTE_ASSERT(pb_flag);
 
 	*pb_flag = nthw_field_get_updated(p->mp_fld_sr_bb) ? true : false;
 
@@ -100,7 +100,7 @@ static int nthw_iic_reg_busbusy(nthw_iic_t *p, bool *pb_flag)
 
 static int nthw_iic_reg_rxfifo_empty(nthw_iic_t *p, bool *pb_flag)
 {
-	assert(pb_flag);
+	RTE_ASSERT(pb_flag);
 
 	*pb_flag = nthw_field_get_updated(p->mp_fld_sr_rxfifo_empty) ? true : false;
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
index d0fee5dcd0..23ed96e04d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
+++ b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
@@ -44,7 +44,7 @@ int nthw_mac_pcs_init(nthw_mac_pcs_t *p, nthw_fpga_t *p_fpga, int n_instance)
 	p->mn_instance = n_instance;
 	p->mp_mod_mac_pcs = mod;
 
-	assert(n_instance >= 0 && n_instance <= 255);
+	RTE_ASSERT(n_instance >= 0 && n_instance <= 255);
 	nthw_mac_pcs_set_port_no(p, (uint8_t)n_instance);
 
 	{
@@ -131,7 +131,7 @@ int nthw_mac_pcs_init(nthw_mac_pcs_t *p, nthw_fpga_t *p_fpga, int n_instance)
 
 		} else {
 			/* Remember to add new product_ids */
-			assert(0);
+			RTE_ASSERT(0);
 		}
 
 		p_reg_pcs_config =
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcie3.c b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
index 5997ebb419..5928f81629 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcie3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
@@ -251,7 +251,7 @@ int nthw_pcie3_end_point_counters_sample_post(nthw_pcie3_t *p,
 	struct nthw_hif_end_point_counters *epc)
 {
 	NT_LOG_DBGX(DBG, NTHW);
-	assert(epc);
+	RTE_ASSERT(epc);
 	nthw_pcie3_get_stat_rate(p, &epc->cur_tx, &epc->cur_rx, &epc->n_ref_clk_cnt,
 		&epc->n_tags_in_use, &epc->cur_pci_nt_util,
 		&epc->cur_pci_xil_util);
diff --git a/drivers/net/ntnic/nthw/core/nthw_spim.c b/drivers/net/ntnic/nthw/core/nthw_spim.c
index d30c11d0ff..42c40400d3 100644
--- a/drivers/net/ntnic/nthw/core/nthw_spim.c
+++ b/drivers/net/ntnic/nthw/core/nthw_spim.c
@@ -105,7 +105,7 @@ uint32_t nthw_spim_write_tx_fifo(nthw_spim_t *p, uint32_t n_data)
 
 uint32_t nthw_spim_get_tx_fifo_empty(nthw_spim_t *p, bool *pb_empty)
 {
-	assert(pb_empty);
+	RTE_ASSERT(pb_empty);
 
 	*pb_empty = nthw_field_get_updated(p->mp_fld_sr_txempty) ? true : false;
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_spis.c b/drivers/net/ntnic/nthw/core/nthw_spis.c
index 3c34dec936..a6e0357cbc 100644
--- a/drivers/net/ntnic/nthw/core/nthw_spis.c
+++ b/drivers/net/ntnic/nthw/core/nthw_spis.c
@@ -104,7 +104,7 @@ uint32_t nthw_spis_enable(nthw_spis_t *p, bool b_enable)
 
 uint32_t nthw_spis_get_rx_fifo_empty(nthw_spis_t *p, bool *pb_empty)
 {
-	assert(pb_empty);
+	RTE_ASSERT(pb_empty);
 
 	*pb_empty = nthw_field_get_updated(p->mp_fld_sr_rxempty) ? true : false;
 
@@ -113,7 +113,7 @@ uint32_t nthw_spis_get_rx_fifo_empty(nthw_spis_t *p, bool *pb_empty)
 
 uint32_t nthw_spis_read_rx_fifo(nthw_spis_t *p, uint32_t *p_data)
 {
-	assert(p_data);
+	RTE_ASSERT(p_data);
 
 	*p_data = nthw_field_get_updated(p->mp_fld_drr_drr);
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 022d7a1c0e..0bee86c573 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -149,7 +149,7 @@ static_assert(RTE_DIM(err_msg) == ERR_MSG_END,
 
 void flow_nic_set_error(enum flow_nic_err_msg_e msg, struct rte_flow_error *error)
 {
-	assert(msg < ERR_MSG_NO_MSG);
+	RTE_ASSERT(msg < ERR_MSG_NO_MSG);
 
 	if (error) {
 		error->message = err_msg[msg].message;
@@ -213,7 +213,7 @@ int flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, i
 {
 	NT_LOG(DBG, FILTER, "Reference resource %s idx %i (before ref cnt %i)",
 		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
-	assert(flow_nic_is_resource_used(ndev, res_type, index));
+	RTE_ASSERT(flow_nic_is_resource_used(ndev, res_type, index));
 
 	if (ndev->res[res_type].ref[index] == (uint32_t)-1)
 		return -1;
@@ -226,8 +226,8 @@ int flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type,
 {
 	NT_LOG(DBG, FILTER, "De-reference resource %s idx %i (before ref cnt %i)",
 		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
-	assert(flow_nic_is_resource_used(ndev, res_type, index));
-	assert(ndev->res[res_type].ref[index]);
+	RTE_ASSERT(flow_nic_is_resource_used(ndev, res_type, index));
+	RTE_ASSERT(ndev->res[res_type].ref[index]);
 	/* deref */
 	ndev->res[res_type].ref[index]--;
 
@@ -520,7 +520,7 @@ int flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 static int init_resource_elements(struct flow_nic_dev *ndev, enum res_type_e res_type,
 	uint32_t count)
 {
-	assert(ndev->res[res_type].alloc_bm == NULL);
+	RTE_ASSERT(ndev->res[res_type].alloc_bm == NULL);
 	/* allocate bitmap and ref counter */
 	ndev->res[res_type].alloc_bm =
 		calloc(1, BIT_CONTAINER_8_ALIGN(count) + count * sizeof(uint32_t));
@@ -537,7 +537,7 @@ static int init_resource_elements(struct flow_nic_dev *ndev, enum res_type_e res
 
 static void done_resource_elements(struct flow_nic_dev *ndev, enum res_type_e res_type)
 {
-	assert(ndev);
+	RTE_ASSERT(ndev);
 
 	free(ndev->res[res_type].alloc_bm);
 }
@@ -598,7 +598,7 @@ static struct flow_eth_dev *flow_get_eth_dev(uint8_t adapter_no, uint8_t port_no
 		adapter_no, port_no, port_id, alloc_rx_queues, flow_profile);
 
 	if (MAX_OUTPUT_DEST < FLOW_MAX_QUEUES) {
-		assert(0);
+		RTE_ASSERT(0);
 		NT_LOG(ERR, FILTER,
 			"ERROR: Internal array for multiple queues too small for API");
 	}
@@ -821,7 +821,7 @@ struct flow_nic_dev *flow_api_create(uint8_t adapter_no, const struct flow_api_b
 
 	/* check all defined has been initialized */
 	for (int i = 0; i < RES_COUNT; i++)
-		assert(ndev->res[i].alloc_bm);
+		RTE_ASSERT(ndev->res[i].alloc_bm);
 
 	rte_spinlock_init(&ndev->mtx);
 	list_insert_flow_nic(ndev);
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
index 9f7ee5decb..64ef5b345a 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
@@ -1632,7 +1632,7 @@ static uint32_t tpe_get_version(void *be_dev)
 		return 3;
 	}
 
-	assert(false);
+	RTE_ASSERT(false);
 	return 0;
 }
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_km.c b/drivers/net/ntnic/nthw/flow_api/flow_km.c
index f79919cb81..5f6b5f98a9 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_km.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2023 Napatech A/S
  */
 
-#include <assert.h>
 #include <stdlib.h>
 
 #include "hw_mod_backend.h"
@@ -118,7 +117,7 @@ int km_add_match_elem(struct km_flow_def_s *km, uint32_t e_word[4], uint32_t e_m
 	}
 
 	if (word_len < 1 || word_len > 4) {
-		assert(0);
+		RTE_ASSERT(0);
 		return -1;
 	}
 
@@ -284,7 +283,7 @@ int km_key_create(struct km_flow_def_s *km, uint32_t port_id)
 		}
 	}
 
-	assert(next == km->num_ftype_elem);
+	RTE_ASSERT(next == km->num_ftype_elem);
 
 	km->key_word_size = idx;
 	km->port_id = port_id;
@@ -670,7 +669,7 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 			return -1;
 		}
 
-		assert((uint32_t)(km->tcam_start_bank + km->key_word_size) <=
+		RTE_ASSERT((uint32_t)(km->tcam_start_bank + km->key_word_size) <=
 			km->be->km.nb_tcam_banks);
 
 		for (int i = 0; i < km->key_word_size; i++) {
@@ -705,7 +704,7 @@ static int cam_populate(struct km_flow_def_s *km, int bank)
 	km->cam_dist[CAM_KM_DIST_IDX(bank)].km_owner = km;
 
 	if (cnt) {
-		assert(km->cam_paired);
+		RTE_ASSERT(km->cam_paired);
 
 		for (uint32_t i = 0; i < km->be->km.nb_cam_record_words && cnt; i++, cnt--) {
 			res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank,
@@ -738,7 +737,7 @@ static int cam_reset_entry(struct km_flow_def_s *km, int bank)
 	km->cam_dist[CAM_KM_DIST_IDX(bank)].km_owner = NULL;
 
 	if (cnt) {
-		assert(km->cam_paired);
+		RTE_ASSERT(km->cam_paired);
 
 		for (uint32_t i = 0; i < km->be->km.nb_cam_record_words && cnt; i++, cnt--) {
 			res |= hw_mod_km_cam_set(km->be, HW_KM_CAM_W0 + i, bank,
@@ -756,7 +755,7 @@ static int cam_reset_entry(struct km_flow_def_s *km, int bank)
 
 static int move_cuckoo_index(struct km_flow_def_s *km)
 {
-	assert(km->cam_dist[CAM_KM_DIST_IDX(km->bank_used)].km_owner);
+	RTE_ASSERT(km->cam_dist[CAM_KM_DIST_IDX(km->bank_used)].km_owner);
 
 	for (uint32_t bank = 0; bank < km->be->km.nb_cam_banks; bank++) {
 		/* It will not select itself */
@@ -806,7 +805,7 @@ static int move_cuckoo_index_level(struct km_flow_def_s *km_parent, int bank_idx
 {
 	struct km_flow_def_s *km = km_parent->cam_dist[bank_idx].km_owner;
 
-	assert(levels <= CUCKOO_MOVE_MAX_DEPTH);
+	RTE_ASSERT(levels <= CUCKOO_MOVE_MAX_DEPTH);
 
 	/*
 	 * Only move if same pairness
@@ -821,7 +820,7 @@ static int move_cuckoo_index_level(struct km_flow_def_s *km_parent, int bank_idx
 	if (levels <= 1)
 		return 0;
 
-	assert(cam_adr_list_len < CUCKOO_MOVE_MAX_DEPTH);
+	RTE_ASSERT(cam_adr_list_len < CUCKOO_MOVE_MAX_DEPTH);
 
 	cam_addr_reserved_stack[cam_adr_list_len++] = bank_idx;
 
@@ -845,7 +844,7 @@ static int move_cuckoo_index_level(struct km_flow_def_s *km_parent, int bank_idx
 			if (move_cuckoo_index(km))
 				return 1;
 
-			assert(0);
+			RTE_ASSERT(0);
 		}
 	}
 
@@ -856,8 +855,8 @@ static int km_write_data_to_cam(struct km_flow_def_s *km)
 {
 	int res = 0;
 	int val[MAX_BANKS];
-	assert(km->be->km.nb_cam_banks <= MAX_BANKS);
-	assert(km->cam_dist);
+	RTE_ASSERT(km->be->km.nb_cam_banks <= MAX_BANKS);
+	RTE_ASSERT(km->cam_dist);
 
 	/* word list without info set */
 	gethash(km->hsh, km->entry_word, val);
@@ -967,7 +966,7 @@ static int tcam_write_word(struct km_flow_def_s *km, int bank, int record, uint3
 	int rec_bit_shft = record % 32;
 	uint32_t rec_bit = (1 << rec_bit_shft);
 
-	assert((km->be->km.nb_tcam_bank_width + 31) / 32 <= 3);
+	RTE_ASSERT((km->be->km.nb_tcam_bank_width + 31) / 32 <= 3);
 
 	for (int byte = 0; byte < 4; byte++) {
 		uint8_t a = (uint8_t)((word >> (24 - (byte * 8))) & 0xff);
@@ -994,7 +993,7 @@ static int tcam_write_word(struct km_flow_def_s *km, int bank, int record, uint3
 	err |= hw_mod_km_tcam_flush(km->be, bank, ALL_BANK_ENTRIES);
 
 	if (err == 0) {
-		assert(km->tcam_dist[TCAM_DIST_IDX(bank, record)].km_owner == NULL);
+		RTE_ASSERT(km->tcam_dist[TCAM_DIST_IDX(bank, record)].km_owner == NULL);
 		km->tcam_dist[TCAM_DIST_IDX(bank, record)].km_owner = km;
 	}
 
@@ -1044,7 +1043,7 @@ static int tcam_reset_bank(struct km_flow_def_s *km, int bank, int record)
 	int rec_bit_shft = record % 32;
 	uint32_t rec_bit = (1 << rec_bit_shft);
 
-	assert((km->be->km.nb_tcam_bank_width + 31) / 32 <= 3);
+	RTE_ASSERT((km->be->km.nb_tcam_bank_width + 31) / 32 <= 3);
 
 	for (int byte = 0; byte < 4; byte++) {
 		for (int val = 0; val < 256; val++) {
@@ -1141,7 +1140,7 @@ int km_clear_data_match_entry(struct km_flow_def_s *km)
 			km->cam_dist[CAM_KM_DIST_IDX(km->bank_used)].km_owner = km->reference;
 
 			if (km->key_word_size + !!km->info_set > 1) {
-				assert(km->cam_paired);
+				RTE_ASSERT(km->cam_paired);
 				km->cam_dist[CAM_KM_DIST_IDX(km->bank_used) + 1].km_owner =
 					km->reference;
 			}
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
index a344d1a2f5..fbc53a3e30 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
@@ -4,6 +4,7 @@
  */
 
 #include "hw_mod_backend.h"
+#include "rte_debug.h"
 
 #include <stdlib.h>
 #include <string.h>
@@ -41,8 +42,8 @@ void *callocate_mod(struct common_func_s *mod, int sets, ...)
 	unsigned int total_bytes = 0;
 	int cnt, elem_size;
 
-	assert(sets <= MAX_SETS);
-	assert(sets > 0);
+	RTE_ASSERT(sets <= MAX_SETS);
+	RTE_ASSERT(sets > 0);
 
 	va_list args;
 	va_start(args, sets);
@@ -92,7 +93,7 @@ int flow_api_backend_init(struct flow_api_backend_s *dev,
 	const struct flow_api_backend_ops *iface,
 	void *be_dev)
 {
-	assert(dev);
+	RTE_ASSERT(dev);
 	dev->iface = iface;
 	dev->be_dev = be_dev;
 	dev->num_phy_ports = iface->get_nb_phy_port(be_dev);
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
index 7c825009ad..3e00a78277 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2024 Napatech A/S
  */
 
-#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
index 992b1659a8..f6cc09de9b 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2024 Napatech A/S
  */
 
-#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
 
@@ -25,7 +24,7 @@ void *flm_lrn_queue_create(void)
 		QUEUE_SIZE,
 		SOCKET_ID_ANY,
 		RING_F_MP_HTS_ENQ | RING_F_SC_DEQ);
-	assert(q != NULL);
+	RTE_ASSERT(q != NULL);
 	return q;
 }
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 2cd2eab5cb..1e2836de68 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -386,7 +386,7 @@ static int flm_mtr_adjust_stats(struct flow_eth_dev *dev, uint8_t caller_id, uin
 static void flm_setup_queues(void)
 {
 	flm_lrn_queue_arr = flm_lrn_queue_create();
-	assert(flm_lrn_queue_arr != NULL);
+	RTE_ASSERT(flm_lrn_queue_arr != NULL);
 }
 
 static void flm_free_queues(void)
@@ -774,7 +774,7 @@ struct flm_flow_key_def_s {
 static inline void set_key_def_qw(struct flm_flow_key_def_s *key_def, unsigned int qw,
 	unsigned int dyn, unsigned int ofs)
 {
-	assert(qw < 2);
+	RTE_ASSERT(qw < 2);
 
 	if (qw == 0) {
 		key_def->qw0_dyn = dyn & 0x7f;
@@ -789,7 +789,7 @@ static inline void set_key_def_qw(struct flm_flow_key_def_s *key_def, unsigned i
 static inline void set_key_def_sw(struct flm_flow_key_def_s *key_def, unsigned int sw,
 	unsigned int dyn, unsigned int ofs)
 {
-	assert(sw < 2);
+	RTE_ASSERT(sw < 2);
 
 	if (sw == 0) {
 		key_def->sw8_dyn = dyn & 0x7f;
@@ -3188,7 +3188,7 @@ static void setup_db_qsl_data(struct nic_flow_def *fd, struct hw_db_inline_qsl_d
 		qsl_data->drop = 1;
 
 	} else {
-		assert(fd->dst_num_avail < HW_DB_INLINE_MAX_QST_PER_QSL);
+		RTE_ASSERT(fd->dst_num_avail < HW_DB_INLINE_MAX_QST_PER_QSL);
 
 		uint32_t ports[fd->dst_num_avail];
 		uint32_t queues[fd->dst_num_avail];
@@ -3314,7 +3314,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	/* Setup TPE EXT */
 	if (fd->tun_hdr.len > 0) {
-		assert(fd->tun_hdr.len <= HW_DB_INLINE_MAX_ENCAP_SIZE);
+		RTE_ASSERT(fd->tun_hdr.len <= HW_DB_INLINE_MAX_ENCAP_SIZE);
 
 		struct hw_db_inline_tpe_ext_data tpe_ext_data = {
 			.size = fd->tun_hdr.len,
@@ -3339,7 +3339,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 	}
 
 	/* Setup TPE */
-	assert(fd->modify_field_count <= 6);
+	RTE_ASSERT(fd->modify_field_count <= 6);
 
 	struct hw_db_inline_tpe_data tpe_data = {
 		.insert_len = fd->tun_hdr.len,
@@ -3882,7 +3882,7 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 {
 	if (!ndev->flow_mgnt_prepared) {
 		/* Check static arrays are big enough */
-		assert(ndev->be.tpe.nb_cpy_writers <= MAX_CPY_WRITERS_SUPPORTED);
+		RTE_ASSERT(ndev->be.tpe.nb_cpy_writers <= MAX_CPY_WRITERS_SUPPORTED);
 		/* KM Flow Type 0 is reserved */
 		flow_nic_mark_resource_used(ndev, RES_KM_FLOW_TYPE, 0);
 		flow_nic_mark_resource_used(ndev, RES_KM_CATEGORY, 0);
@@ -4250,8 +4250,8 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *fh,
 	struct rte_flow_error *error)
 {
-	assert(dev);
-	assert(fh);
+	RTE_ASSERT(dev);
+	RTE_ASSERT(fh);
 
 	int err = 0;
 
@@ -4386,8 +4386,8 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_action action[],
 	struct rte_flow_error *error)
 {
-	assert(dev);
-	assert(flow);
+	RTE_ASSERT(dev);
+	RTE_ASSERT(flow);
 
 	uint32_t num_dest_port = 0;
 	uint32_t num_queues = 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
index d3213593e1..23139b0305 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
@@ -41,7 +41,7 @@ int cat_nthw_init(struct cat_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_CAT, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
@@ -401,43 +401,43 @@ void cat_nthw_cfn_ptc_tnl_l4(const struct cat_nthw *p, uint32_t val)
 
 void cat_nthw_cfn_ptc_cfp(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cfn_data_ptc_cfp);
+	RTE_ASSERT(p->mp_cfn_data_ptc_cfp);
 	nthw_field_set_val32(p->mp_cfn_data_ptc_cfp, val);
 }
 
 void cat_nthw_cfn_err_l3_cs(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cfn_data_err_l3_cs);
+	RTE_ASSERT(p->mp_cfn_data_err_l3_cs);
 	nthw_field_set_val32(p->mp_cfn_data_err_l3_cs, val);
 }
 
 void cat_nthw_cfn_err_l4_cs(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cfn_data_err_l4_cs);
+	RTE_ASSERT(p->mp_cfn_data_err_l4_cs);
 	nthw_field_set_val32(p->mp_cfn_data_err_l4_cs, val);
 }
 
 void cat_nthw_cfn_err_tnl_l3_cs(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cfn_data_err_tnl_l3_cs);
+	RTE_ASSERT(p->mp_cfn_data_err_tnl_l3_cs);
 	nthw_field_set_val32(p->mp_cfn_data_err_tnl_l3_cs, val);
 }
 
 void cat_nthw_cfn_err_tnl_l4_cs(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cfn_data_err_tnl_l4_cs);
+	RTE_ASSERT(p->mp_cfn_data_err_tnl_l4_cs);
 	nthw_field_set_val32(p->mp_cfn_data_err_tnl_l4_cs, val);
 }
 
 void cat_nthw_cfn_err_ttl_exp(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cfn_data_err_ttl_exp);
+	RTE_ASSERT(p->mp_cfn_data_err_ttl_exp);
 	nthw_field_set_val32(p->mp_cfn_data_err_ttl_exp, val);
 }
 
 void cat_nthw_cfn_err_tnl_ttl_exp(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cfn_data_err_tnl_ttl_exp);
+	RTE_ASSERT(p->mp_cfn_data_err_tnl_ttl_exp);
 	nthw_field_set_val32(p->mp_cfn_data_err_tnl_ttl_exp, val);
 }
 
@@ -518,7 +518,7 @@ void cat_nthw_cfn_km0_or(const struct cat_nthw *p, uint32_t val)
 
 void cat_nthw_cfn_km1_or(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cfn_data_km1_or);
+	RTE_ASSERT(p->mp_cfn_data_km1_or);
 	nthw_field_set_val32(p->mp_cfn_data_km1_or, val);
 }
 
@@ -638,25 +638,25 @@ void cat_nthw_cte_enable_pdb(const struct cat_nthw *p, uint32_t val)
 
 void cat_nthw_cte_enable_msk(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cte_data_msk);
+	RTE_ASSERT(p->mp_cte_data_msk);
 	nthw_field_set_val32(p->mp_cte_data_msk, val);
 }
 
 void cat_nthw_cte_enable_hst(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cte_data_hst);
+	RTE_ASSERT(p->mp_cte_data_hst);
 	nthw_field_set_val32(p->mp_cte_data_hst, val);
 }
 
 void cat_nthw_cte_enable_epp(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cte_data_epp);
+	RTE_ASSERT(p->mp_cte_data_epp);
 	nthw_field_set_val32(p->mp_cte_data_epp, val);
 }
 
 void cat_nthw_cte_enable_tpe(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_cte_data_tpe);
+	RTE_ASSERT(p->mp_cte_data_tpe);
 	nthw_field_set_val32(p->mp_cte_data_tpe, val);
 }
 
@@ -835,38 +835,38 @@ void cat_nthw_len_flush(const struct cat_nthw *p)
 
 void cat_nthw_kcc_select(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_kcc_addr);
+	RTE_ASSERT(p->mp_kcc_addr);
 	nthw_field_set_val32(p->mp_kcc_addr, val);
 }
 
 void cat_nthw_kcc_cnt(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_kcc_cnt);
+	RTE_ASSERT(p->mp_kcc_cnt);
 	nthw_field_set_val32(p->mp_kcc_cnt, val);
 }
 
 void cat_nthw_kcc_key(const struct cat_nthw *p, uint32_t *val)
 {
-	assert(p->mp_kcc_data_key);
+	RTE_ASSERT(p->mp_kcc_data_key);
 	nthw_field_set_val(p->mp_kcc_data_key, val, 2);
 }
 
 void cat_nthw_kcc_category(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_kcc_data_category);
+	RTE_ASSERT(p->mp_kcc_data_category);
 	nthw_field_set_val32(p->mp_kcc_data_category, val);
 }
 
 void cat_nthw_kcc_id(const struct cat_nthw *p, uint32_t val)
 {
-	assert(p->mp_kcc_data_id);
+	RTE_ASSERT(p->mp_kcc_data_id);
 	nthw_field_set_val32(p->mp_kcc_data_id, val);
 }
 
 void cat_nthw_kcc_flush(const struct cat_nthw *p)
 {
-	assert(p->mp_kcc_ctrl);
-	assert(p->mp_kcc_data);
+	RTE_ASSERT(p->mp_kcc_ctrl);
+	RTE_ASSERT(p->mp_kcc_data);
 	nthw_register_flush(p->mp_kcc_ctrl, 1);
 	nthw_register_flush(p->mp_kcc_data, 1);
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
index c1b73179a8..945d46415c 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
@@ -40,7 +40,7 @@ int csu_nthw_init(struct csu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_CSU, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
index 8855978349..9bae6a32c8 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "rte_debug.h"
 #include "ntlog.h"
 
 #include "nthw_drv.h"
@@ -42,7 +43,7 @@ int flm_nthw_init(struct flm_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_FLM, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
@@ -316,13 +317,13 @@ void flm_nthw_control_ris(const struct flm_nthw *p, uint32_t val)
 
 void flm_nthw_control_pds(const struct flm_nthw *p, uint32_t val)
 {
-	assert(p->mp_control_pds);
+	RTE_ASSERT(p->mp_control_pds);
 	nthw_field_set_val32(p->mp_control_pds, val);
 }
 
 void flm_nthw_control_pis(const struct flm_nthw *p, uint32_t val)
 {
-	assert(p->mp_control_pis);
+	RTE_ASSERT(p->mp_control_pis);
 	nthw_field_set_val32(p->mp_control_pis, val);
 }
 
@@ -683,7 +684,8 @@ int flm_nthw_buf_ctrl_update(const struct flm_nthw *p, uint32_t *lrn_free, uint3
 
 	if (ret == 0) {
 		nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
-		ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : (assert(0), -1);
+		ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
+		RTE_ASSERT(ret == -1);
 		rte_spinlock_unlock(&rac->m_mutex);
 
 		if (ret != 0)
@@ -732,7 +734,8 @@ int flm_nthw_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint
 			uint32_t dma_free = nthw_rac_rab_get_free(rac);
 
 			if (dma_free != RAB_DMA_BUF_CNT) {
-				assert(0);	/* alert developer that something is wrong */
+				RTE_ASSERT(0);	/* alert developer that something is wrong */
+				rte_spinlock_unlock(&rac->m_mutex);
 				return -1;
 			}
 
@@ -781,9 +784,8 @@ int flm_nthw_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint
 			/* Read buf ctrl */
 			nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
 
-			int ret = rac->m_dma_active ?
-				nthw_rac_rab_dma_commit(rac) :
-				(assert(0), -1);
+			int ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
+			RTE_ASSERT(ret == -1);
 			rte_spinlock_unlock(&rac->m_mutex);
 			if (ret != 0)
 				return -1;
@@ -844,7 +846,8 @@ int flm_nthw_inf_sta_data_update(const struct flm_nthw *p, uint32_t *inf_data,
 		}
 
 		nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
-		ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : (assert(0), -1);
+		ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
+		RTE_ASSERT(ret == -1);
 		rte_spinlock_unlock(&rac->m_mutex);
 
 		if (ret != 0)
@@ -940,7 +943,7 @@ void flm_nthw_stat_unl_ignore_update(const struct flm_nthw *p)
 
 void flm_nthw_stat_prb_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_prb_done_cnt);
+	RTE_ASSERT(p->mp_stat_prb_done_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_prb_done_cnt);
@@ -948,13 +951,13 @@ void flm_nthw_stat_prb_done_cnt(const struct flm_nthw *p, uint32_t *val, int get
 
 void flm_nthw_stat_prb_done_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_prb_done);
+	RTE_ASSERT(p->mp_stat_prb_done);
 	nthw_register_update(p->mp_stat_prb_done);
 }
 
 void flm_nthw_stat_prb_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_prb_ignore_cnt);
+	RTE_ASSERT(p->mp_stat_prb_ignore_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_prb_ignore_cnt);
@@ -962,7 +965,7 @@ void flm_nthw_stat_prb_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int g
 
 void flm_nthw_stat_prb_ignore_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_prb_ignore);
+	RTE_ASSERT(p->mp_stat_prb_ignore);
 	nthw_register_update(p->mp_stat_prb_ignore);
 }
 
@@ -1045,7 +1048,7 @@ void flm_nthw_stat_flows_update(const struct flm_nthw *p)
 
 void flm_nthw_stat_sta_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_sta_done_cnt);
+	RTE_ASSERT(p->mp_stat_sta_done_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_sta_done_cnt);
@@ -1053,13 +1056,13 @@ void flm_nthw_stat_sta_done_cnt(const struct flm_nthw *p, uint32_t *val, int get
 
 void flm_nthw_stat_sta_done_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_sta_done);
+	RTE_ASSERT(p->mp_stat_sta_done);
 	nthw_register_update(p->mp_stat_sta_done);
 }
 
 void flm_nthw_stat_inf_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_inf_done_cnt);
+	RTE_ASSERT(p->mp_stat_inf_done_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_inf_done_cnt);
@@ -1067,13 +1070,13 @@ void flm_nthw_stat_inf_done_cnt(const struct flm_nthw *p, uint32_t *val, int get
 
 void flm_nthw_stat_inf_done_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_inf_done);
+	RTE_ASSERT(p->mp_stat_inf_done);
 	nthw_register_update(p->mp_stat_inf_done);
 }
 
 void flm_nthw_stat_inf_skip_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_inf_skip_cnt);
+	RTE_ASSERT(p->mp_stat_inf_skip_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_inf_skip_cnt);
@@ -1081,13 +1084,13 @@ void flm_nthw_stat_inf_skip_cnt(const struct flm_nthw *p, uint32_t *val, int get
 
 void flm_nthw_stat_inf_skip_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_inf_skip);
+	RTE_ASSERT(p->mp_stat_inf_skip);
 	nthw_register_update(p->mp_stat_inf_skip);
 }
 
 void flm_nthw_stat_pck_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_pck_hit_cnt);
+	RTE_ASSERT(p->mp_stat_pck_hit_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_pck_hit_cnt);
@@ -1095,13 +1098,13 @@ void flm_nthw_stat_pck_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 
 void flm_nthw_stat_pck_hit_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_pck_hit);
+	RTE_ASSERT(p->mp_stat_pck_hit);
 	nthw_register_update(p->mp_stat_pck_hit);
 }
 
 void flm_nthw_stat_pck_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_pck_miss_cnt);
+	RTE_ASSERT(p->mp_stat_pck_miss_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_pck_miss_cnt);
@@ -1109,13 +1112,13 @@ void flm_nthw_stat_pck_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get
 
 void flm_nthw_stat_pck_miss_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_pck_miss);
+	RTE_ASSERT(p->mp_stat_pck_miss);
 	nthw_register_update(p->mp_stat_pck_miss);
 }
 
 void flm_nthw_stat_pck_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_pck_unh_cnt);
+	RTE_ASSERT(p->mp_stat_pck_unh_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_pck_unh_cnt);
@@ -1123,13 +1126,13 @@ void flm_nthw_stat_pck_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 
 void flm_nthw_stat_pck_unh_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_pck_unh);
+	RTE_ASSERT(p->mp_stat_pck_unh);
 	nthw_register_update(p->mp_stat_pck_unh);
 }
 
 void flm_nthw_stat_pck_dis_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_pck_dis_cnt);
+	RTE_ASSERT(p->mp_stat_pck_dis_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_pck_dis_cnt);
@@ -1137,13 +1140,13 @@ void flm_nthw_stat_pck_dis_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 
 void flm_nthw_stat_pck_dis_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_pck_dis);
+	RTE_ASSERT(p->mp_stat_pck_dis);
 	nthw_register_update(p->mp_stat_pck_dis);
 }
 
 void flm_nthw_stat_csh_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_csh_hit_cnt);
+	RTE_ASSERT(p->mp_stat_csh_hit_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_csh_hit_cnt);
@@ -1151,13 +1154,13 @@ void flm_nthw_stat_csh_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 
 void flm_nthw_stat_csh_hit_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_csh_hit);
+	RTE_ASSERT(p->mp_stat_csh_hit);
 	nthw_register_update(p->mp_stat_csh_hit);
 }
 
 void flm_nthw_stat_csh_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_csh_miss_cnt);
+	RTE_ASSERT(p->mp_stat_csh_miss_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_csh_miss_cnt);
@@ -1165,13 +1168,13 @@ void flm_nthw_stat_csh_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get
 
 void flm_nthw_stat_csh_miss_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_csh_miss);
+	RTE_ASSERT(p->mp_stat_csh_miss);
 	nthw_register_update(p->mp_stat_csh_miss);
 }
 
 void flm_nthw_stat_csh_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_csh_unh_cnt);
+	RTE_ASSERT(p->mp_stat_csh_unh_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_csh_unh_cnt);
@@ -1179,13 +1182,13 @@ void flm_nthw_stat_csh_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 
 void flm_nthw_stat_csh_unh_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_csh_unh);
+	RTE_ASSERT(p->mp_stat_csh_unh);
 	nthw_register_update(p->mp_stat_csh_unh);
 }
 
 void flm_nthw_stat_cuc_start_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_cuc_start_cnt);
+	RTE_ASSERT(p->mp_stat_cuc_start_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_cuc_start_cnt);
@@ -1193,13 +1196,13 @@ void flm_nthw_stat_cuc_start_cnt(const struct flm_nthw *p, uint32_t *val, int ge
 
 void flm_nthw_stat_cuc_start_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_cuc_start);
+	RTE_ASSERT(p->mp_stat_cuc_start);
 	nthw_register_update(p->mp_stat_cuc_start);
 }
 
 void flm_nthw_stat_cuc_move_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
-	assert(p->mp_stat_cuc_move_cnt);
+	RTE_ASSERT(p->mp_stat_cuc_move_cnt);
 
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_cuc_move_cnt);
@@ -1207,50 +1210,50 @@ void flm_nthw_stat_cuc_move_cnt(const struct flm_nthw *p, uint32_t *val, int get
 
 void flm_nthw_stat_cuc_move_update(const struct flm_nthw *p)
 {
-	assert(p->mp_stat_cuc_move);
+	RTE_ASSERT(p->mp_stat_cuc_move);
 	nthw_register_update(p->mp_stat_cuc_move);
 }
 
 void flm_nthw_scrub_select(const struct flm_nthw *p, uint32_t val)
 {
-	assert(p->mp_scrub_ctrl_adr);
+	RTE_ASSERT(p->mp_scrub_ctrl_adr);
 	nthw_field_set_val32(p->mp_scrub_ctrl_adr, val);
 }
 
 void flm_nthw_scrub_cnt(const struct flm_nthw *p, uint32_t val)
 {
-	assert(p->mp_scrub_ctrl_cnt);
+	RTE_ASSERT(p->mp_scrub_ctrl_cnt);
 	nthw_field_set_val32(p->mp_scrub_ctrl_cnt, val);
 }
 
 void flm_nthw_scrub_t(const struct flm_nthw *p, uint32_t val)
 {
-	assert(p->mp_scrub_data_t);
+	RTE_ASSERT(p->mp_scrub_data_t);
 	nthw_field_set_val32(p->mp_scrub_data_t, val);
 }
 
 void flm_nthw_scrub_r(const struct flm_nthw *p, uint32_t val)
 {
-	assert(p->mp_scrub_data_r);
+	RTE_ASSERT(p->mp_scrub_data_r);
 	nthw_field_set_val32(p->mp_scrub_data_r, val);
 }
 
 void flm_nthw_scrub_del(const struct flm_nthw *p, uint32_t val)
 {
-	assert(p->mp_scrub_data_del);
+	RTE_ASSERT(p->mp_scrub_data_del);
 	nthw_field_set_val32(p->mp_scrub_data_del, val);
 }
 
 void flm_nthw_scrub_inf(const struct flm_nthw *p, uint32_t val)
 {
-	assert(p->mp_scrub_data_inf);
+	RTE_ASSERT(p->mp_scrub_data_inf);
 	nthw_field_set_val32(p->mp_scrub_data_inf, val);
 }
 
 void flm_nthw_scrub_flush(const struct flm_nthw *p)
 {
-	assert(p->mp_scrub_ctrl);
-	assert(p->mp_scrub_data);
+	RTE_ASSERT(p->mp_scrub_ctrl);
+	RTE_ASSERT(p->mp_scrub_data);
 	nthw_register_flush(p->mp_scrub_ctrl, 1);
 	nthw_register_flush(p->mp_scrub_data, 1);
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
index 4a8b17101d..2559f2ec77 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
@@ -40,7 +40,7 @@ int hfu_nthw_init(struct hfu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_HFU, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
index 80ead2729a..ab9c793e3a 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
@@ -40,7 +40,7 @@ int hsh_nthw_init(struct hsh_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_HSH, n_instance);
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
index 45f2047916..418dd41a53 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
@@ -32,7 +32,7 @@ int ifr_nthw_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_IFR, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
@@ -81,13 +81,13 @@ int ifr_nthw_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 
 void ifr_nthw_rcp_select(const struct ifr_nthw *p, uint32_t val)
 {
-	assert(p->mp_rcp_addr);
+	RTE_ASSERT(p->mp_rcp_addr);
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
 void ifr_nthw_rcp_cnt(const struct ifr_nthw *p, uint32_t val)
 {
-	assert(p->mp_rcp_cnt);
+	RTE_ASSERT(p->mp_rcp_cnt);
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
@@ -117,27 +117,27 @@ void ifr_nthw_rcp_ipv6_drop(const struct ifr_nthw *p, uint32_t val)
 
 void ifr_nthw_rcp_mtu(const struct ifr_nthw *p, uint32_t val)
 {
-	assert(p->mp_rcp_data_mtu);
+	RTE_ASSERT(p->mp_rcp_data_mtu);
 	nthw_field_set_val32(p->mp_rcp_data_mtu, val);
 }
 
 void ifr_nthw_rcp_flush(const struct ifr_nthw *p)
 {
-	assert(p->mp_rcp_ctrl);
-	assert(p->mp_rcp_data);
+	RTE_ASSERT(p->mp_rcp_ctrl);
+	RTE_ASSERT(p->mp_rcp_data);
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
 
 void ifr_nthw_counters_select(const struct ifr_nthw *p, uint32_t val)
 {
-	assert(p->mp_counters_addr);
+	RTE_ASSERT(p->mp_counters_addr);
 	nthw_field_set_val32(p->mp_counters_addr, val);
 }
 
 void ifr_nthw_counters_cnt(const struct ifr_nthw *p, uint32_t val)
 {
-	assert(p->mp_counters_cnt);
+	RTE_ASSERT(p->mp_counters_cnt);
 	nthw_field_set_val32(p->mp_counters_cnt, val);
 }
 
@@ -149,7 +149,7 @@ void ifr_nthw_counters_drop(const struct ifr_nthw *p, uint32_t *val, int get)
 
 void ifr_nthw_counters_update(const struct ifr_nthw *p)
 {
-	assert(p->mp_counters_data);
+	RTE_ASSERT(p->mp_counters_data);
 	nthw_register_flush(p->mp_counters_ctrl, 1);
 	nthw_register_update(p->mp_counters_data);
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
index 8e0b24dd9a..2db4411c9e 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
@@ -38,7 +38,7 @@ void info_nthw_delete(struct info_nthw *p)
 
 int info_nthw_init(struct info_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	p->mp_fpga = p_fpga;
 	p->m_physical_adapter_no = (uint8_t)n_instance;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
index edc8f58759..57471ef430 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
@@ -50,7 +50,7 @@ int km_nthw_init(struct km_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_KM, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
index 4a9713965b..80dc8c14c4 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
@@ -40,7 +40,7 @@ int pdb_nthw_init(struct pdb_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_PDB, n_instance);
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
index c887fe25e2..cf4dc2c8eb 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
@@ -41,7 +41,7 @@ int qsl_nthw_init(struct qsl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_QSL, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
index e69a1ca823..12d9f27e20 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
@@ -40,7 +40,7 @@ int rpp_lr_nthw_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_RPP_LR, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
@@ -84,39 +84,39 @@ int rpp_lr_nthw_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 
 void rpp_lr_nthw_rcp_select(const struct rpp_lr_nthw *p, uint32_t val)
 {
-	assert(p->mp_rcp_addr);
+	RTE_ASSERT(p->mp_rcp_addr);
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
 void rpp_lr_nthw_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val)
 {
-	assert(p->mp_rcp_cnt);
+	RTE_ASSERT(p->mp_rcp_cnt);
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
 void rpp_lr_nthw_rcp_exp(const struct rpp_lr_nthw *p, uint32_t val)
 {
-	assert(p->mp_rcp_data_exp);
+	RTE_ASSERT(p->mp_rcp_data_exp);
 	nthw_field_set_val32(p->mp_rcp_data_exp, val);
 }
 
 void rpp_lr_nthw_rcp_flush(const struct rpp_lr_nthw *p)
 {
-	assert(p->mp_rcp_ctrl);
-	assert(p->mp_rcp_data);
+	RTE_ASSERT(p->mp_rcp_ctrl);
+	RTE_ASSERT(p->mp_rcp_data);
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
 
 void rpp_lr_nthw_ifr_rcp_select(const struct rpp_lr_nthw *p, uint32_t val)
 {
-	assert(p->mp_ifr_rcp_addr);
+	RTE_ASSERT(p->mp_ifr_rcp_addr);
 	nthw_field_set_val32(p->mp_ifr_rcp_addr, val);
 }
 
 void rpp_lr_nthw_ifr_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val)
 {
-	assert(p->mp_ifr_rcp_cnt);
+	RTE_ASSERT(p->mp_ifr_rcp_cnt);
 	nthw_field_set_val32(p->mp_ifr_rcp_cnt, val);
 }
 
@@ -146,14 +146,14 @@ void rpp_lr_nthw_ifr_rcp_ipv6_drop(const struct rpp_lr_nthw *p, uint32_t val)
 
 void rpp_lr_nthw_ifr_rcp_mtu(const struct rpp_lr_nthw *p, uint32_t val)
 {
-	assert(p->mp_ifr_rcp_data_mtu);
+	RTE_ASSERT(p->mp_ifr_rcp_data_mtu);
 	nthw_field_set_val32(p->mp_ifr_rcp_data_mtu, val);
 }
 
 void rpp_lr_nthw_ifr_rcp_flush(const struct rpp_lr_nthw *p)
 {
-	assert(p->mp_ifr_rcp_ctrl);
-	assert(p->mp_ifr_rcp_data);
+	RTE_ASSERT(p->mp_ifr_rcp_ctrl);
+	RTE_ASSERT(p->mp_ifr_rcp_data);
 	nthw_register_flush(p->mp_ifr_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_ifr_rcp_data, 1);
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
index e062a700eb..78cee7ebea 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
@@ -41,7 +41,7 @@ int slc_lr_nthw_init(struct slc_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_SLC_LR, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
index ee85a1c61b..0ecdeb8893 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
@@ -41,7 +41,7 @@ int tx_cpy_nthw_init(struct tx_cpy_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_TX_CPY, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
@@ -345,44 +345,44 @@ int tx_cpy_nthw_init(struct tx_cpy_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 
 void tx_cpy_nthw_writer_select(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
-	assert(index < p->m_writers_cnt);
+	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_ctrl_addr, val);
 }
 
 void tx_cpy_nthw_writer_cnt(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
-	assert(index < p->m_writers_cnt);
+	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_ctrl_cnt, val);
 }
 
 void tx_cpy_nthw_writer_reader_select(const struct tx_cpy_nthw *p, unsigned int index,
 	uint32_t val)
 {
-	assert(index < p->m_writers_cnt);
+	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_data_reader_select, val);
 }
 
 void tx_cpy_nthw_writer_dyn(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
-	assert(index < p->m_writers_cnt);
+	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_data_dyn, val);
 }
 
 void tx_cpy_nthw_writer_ofs(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
-	assert(index < p->m_writers_cnt);
+	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_data_ofs, val);
 }
 
 void tx_cpy_nthw_writer_len(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
-	assert(index < p->m_writers_cnt);
+	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_data_len, val);
 }
 
 void tx_cpy_nthw_writer_flush(const struct tx_cpy_nthw *p, unsigned int index)
 {
-	assert(index < p->m_writers_cnt);
+	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_register_flush(p->m_writers[index].mp_writer_ctrl, 1);
 	nthw_register_flush(p->m_writers[index].mp_writer_data, 1);
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
index 47af44945f..3ac44c6743 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
@@ -40,7 +40,7 @@ int tx_ins_nthw_init(struct tx_ins_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_TX_INS, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
index c40857db0f..9dfcaa99c7 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
@@ -40,7 +40,7 @@ int tx_rpl_nthw_init(struct tx_rpl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_TX_RPL, n_instance);
 
-	assert(n_instance >= 0 && n_instance < 256);
+	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
 	if (p == NULL)
 		return p_mod == NULL ? -1 : 0;
@@ -119,7 +119,7 @@ void tx_rpl_nthw_rcp_ext_prio(const struct tx_rpl_nthw *p, uint32_t val)
 
 void tx_rpl_nthw_rcp_eth_type_wr(const struct tx_rpl_nthw *p, uint32_t val)
 {
-	assert(p->mp_rcp_data_eth_type_wr);
+	RTE_ASSERT(p->mp_rcp_data_eth_type_wr);
 	nthw_field_set_val32(p->mp_rcp_data_eth_type_wr, val);
 }
 
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 9eaaeb550d..43841b2f7b 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -62,9 +62,9 @@ static int nthw_read_data(struct fpga_info_s *p_fpga_info, bool trc, int n_bus_t
 {
 	int rc = -1;
 
-	assert(p_fpga_info);
-	assert(p_data);
-	assert(len >= 1);
+	RTE_ASSERT(p_fpga_info);
+	RTE_ASSERT(p_data);
+	RTE_ASSERT(len >= 1);
 
 	switch (n_bus_type_id) {
 	case NTHW_FPGA_BUS_TYPE_BAR:
@@ -74,22 +74,22 @@ static int nthw_read_data(struct fpga_info_s *p_fpga_info, bool trc, int n_bus_t
 		break;
 
 	case NTHW_FPGA_BUS_TYPE_RAB0:
-		assert(p_fpga_info->mp_nthw_rac);
+		RTE_ASSERT(p_fpga_info->mp_nthw_rac);
 		rc = nthw_rac_rab_read32(p_fpga_info->mp_nthw_rac, trc, 0, addr, len, p_data);
 		break;
 
 	case NTHW_FPGA_BUS_TYPE_RAB1:
-		assert(p_fpga_info->mp_nthw_rac);
+		RTE_ASSERT(p_fpga_info->mp_nthw_rac);
 		rc = nthw_rac_rab_read32(p_fpga_info->mp_nthw_rac, trc, 1, addr, len, p_data);
 		break;
 
 	case NTHW_FPGA_BUS_TYPE_RAB2:
-		assert(p_fpga_info->mp_nthw_rac);
+		RTE_ASSERT(p_fpga_info->mp_nthw_rac);
 		rc = nthw_rac_rab_read32(p_fpga_info->mp_nthw_rac, trc, 2, addr, len, p_data);
 		break;
 
 	default:
-		assert(false);
+		RTE_ASSERT(false);
 		return -1;
 	}
 
@@ -101,9 +101,9 @@ static int nthw_write_data(struct fpga_info_s *p_fpga_info, bool trc, int n_bus_
 {
 	int rc = -1;
 
-	assert(p_fpga_info);
-	assert(p_data);
-	assert(len >= 1);
+	RTE_ASSERT(p_fpga_info);
+	RTE_ASSERT(p_data);
+	RTE_ASSERT(len >= 1);
 
 	switch (n_bus_type_id) {
 	case NTHW_FPGA_BUS_TYPE_BAR:
@@ -113,22 +113,22 @@ static int nthw_write_data(struct fpga_info_s *p_fpga_info, bool trc, int n_bus_
 		break;
 
 	case NTHW_FPGA_BUS_TYPE_RAB0:
-		assert(p_fpga_info->mp_nthw_rac);
+		RTE_ASSERT(p_fpga_info->mp_nthw_rac);
 		rc = nthw_rac_rab_write32(p_fpga_info->mp_nthw_rac, trc, 0, addr, len, p_data);
 		break;
 
 	case NTHW_FPGA_BUS_TYPE_RAB1:
-		assert(p_fpga_info->mp_nthw_rac);
+		RTE_ASSERT(p_fpga_info->mp_nthw_rac);
 		rc = nthw_rac_rab_write32(p_fpga_info->mp_nthw_rac, trc, 1, addr, len, p_data);
 		break;
 
 	case NTHW_FPGA_BUS_TYPE_RAB2:
-		assert(p_fpga_info->mp_nthw_rac);
+		RTE_ASSERT(p_fpga_info->mp_nthw_rac);
 		rc = nthw_rac_rab_write32(p_fpga_info->mp_nthw_rac, trc, 2, addr, len, p_data);
 		break;
 
 	default:
-		assert(false);
+		RTE_ASSERT(false);
 		return -1;
 	}
 
@@ -691,8 +691,8 @@ static int nthw_register_read_data(const nthw_register_t *p)
 			if (p->mp_owner->mp_owner)
 				p_fpga_info = p->mp_owner->mp_owner->p_fpga_info;
 
-			assert(p_fpga_info);
-			assert(p_data);
+			RTE_ASSERT(p_fpga_info);
+			RTE_ASSERT(p_data);
 
 			rc = nthw_read_data(p_fpga_info, trc, n_bus_type_id, addr, len, p_data);
 		}
@@ -716,8 +716,8 @@ static int nthw_register_write_data(const nthw_register_t *p, uint32_t cnt)
 			if (p->mp_owner->mp_owner)
 				p_fpga_info = p->mp_owner->mp_owner->p_fpga_info;
 
-			assert(p_fpga_info);
-			assert(p_data);
+			RTE_ASSERT(p_fpga_info);
+			RTE_ASSERT(p_data);
 
 			rc = nthw_write_data(p_fpga_info, trc, n_bus_type_id, addr, (len * cnt),
 				p_data);
@@ -733,8 +733,8 @@ void nthw_register_get_val(const nthw_register_t *p, uint32_t *p_data, uint32_t
 	if (len == (uint32_t)-1 || len > p->mn_len)
 		len = p->mn_len;
 
-	assert(len <= p->mn_len);
-	assert(p_data);
+	RTE_ASSERT(len <= p->mn_len);
+	RTE_ASSERT(p_data);
 
 	for (i = 0; i < len; i++)
 		p_data[i] = p->mp_shadow[i];
@@ -801,8 +801,8 @@ void nthw_register_make_dirty(nthw_register_t *p)
 
 void nthw_register_set_val(nthw_register_t *p, const uint32_t *p_data, uint32_t len)
 {
-	assert(len <= p->mn_len);
-	assert(p_data);
+	RTE_ASSERT(len <= p->mn_len);
+	RTE_ASSERT(p_data);
 
 	if (len == (uint32_t)-1 || len > p->mn_len)
 		len = p->mn_len;
@@ -824,7 +824,7 @@ void nthw_register_flush(const nthw_register_t *p, uint32_t cnt)
 		uint32_t *const p_data = p->mp_shadow;
 		uint32_t i;
 
-		assert(len * cnt <= 256);
+		RTE_ASSERT(len * cnt <= 256);
 
 		if (p->mn_debug_mode & NTHW_REG_DEBUG_ON_WRITE) {
 			uint32_t i = len * cnt;
@@ -960,7 +960,7 @@ void nthw_field_get_val(const nthw_field_t *p, uint32_t *p_data, uint32_t len)
 	} buf;
 
 	(void)len;
-	assert(len <= p->mn_words);
+	RTE_ASSERT(len <= p->mn_words);
 
 	/* handle front */
 	buf.w32[0] = p->mp_owner->mp_shadow[shadow_index++] & p->mn_front_mask;
@@ -969,7 +969,7 @@ void nthw_field_get_val(const nthw_field_t *p, uint32_t *p_data, uint32_t len)
 	for (i = 0; i < p->mn_body_length; i++) {
 		buf.w32[1] = p->mp_owner->mp_shadow[shadow_index++];
 		buf.w64 = buf.w64 >> (p->mn_first_bit);
-		assert(data_index < len);
+		RTE_ASSERT(data_index < len);
 		p_data[data_index++] = buf.w32[0];
 		buf.w64 = buf.w64 >> (32 - p->mn_first_bit);
 	}
@@ -1000,7 +1000,7 @@ void nthw_field_set_val(const nthw_field_t *p, const uint32_t *p_data, uint32_t
 	} buf;
 
 	(void)len;
-	assert(len == p->mn_words);
+	RTE_ASSERT(len == p->mn_words);
 
 	/* handle front */
 	buf.w32[0] = 0;
@@ -1014,7 +1014,7 @@ void nthw_field_set_val(const nthw_field_t *p, const uint32_t *p_data, uint32_t
 	/* handle body */
 	for (i = 0; i < p->mn_body_length; i++) {
 		buf.w64 = buf.w64 >> (p->mn_first_bit);
-		assert(data_index < len);
+		RTE_ASSERT(data_index < len);
 		buf.w32[1] = p_data[data_index++];
 		buf.w64 = buf.w64 >> (32 - p->mn_first_bit);
 		p->mp_owner->mp_shadow[shadow_index++] = buf.w32[0];
@@ -1095,7 +1095,7 @@ void nthw_field_set_val_flush32(const nthw_field_t *p, uint32_t val)
 
 void nthw_field_clr_all(const nthw_field_t *p)
 {
-	assert(p->mn_body_length == 0);
+	RTE_ASSERT(p->mn_body_length == 0);
 	nthw_field_set_val32(p, 0);
 }
 
@@ -1107,7 +1107,7 @@ void nthw_field_clr_flush(const nthw_field_t *p)
 
 void nthw_field_set_all(const nthw_field_t *p)
 {
-	assert(p->mn_body_length == 0);
+	RTE_ASSERT(p->mn_body_length == 0);
 	nthw_field_set_val32(p, ~0);
 }
 
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index ca6aba6db2..c22123d936 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -37,7 +37,7 @@ nthw_rac_t *nthw_rac_new(void)
 
 int nthw_rac_init(nthw_rac_t *p, nthw_fpga_t *p_fpga, struct fpga_info_s *p_fpga_info)
 {
-	assert(p_fpga_info);
+	RTE_ASSERT(p_fpga_info);
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_RAC, 0);
@@ -74,8 +74,8 @@ int nthw_rac_init(nthw_rac_t *p, nthw_fpga_t *p_fpga, struct fpga_info_s *p_fpga
 	p->mn_fld_rab_init_mask = nthw_field_get_mask(p->mp_fld_rab_init);
 
 	/* RAC_RAB_INIT_RAB reg/field sanity checks: */
-	assert(p->mn_fld_rab_init_mask == ((1UL << p->mn_fld_rab_init_bw) - 1));
-	assert(p->mn_fld_rab_init_bw == p->mn_param_rac_rab_interfaces);
+	RTE_ASSERT(p->mn_fld_rab_init_mask == ((1UL << p->mn_fld_rab_init_bw) - 1));
+	RTE_ASSERT(p->mn_fld_rab_init_bw == p->mn_param_rac_rab_interfaces);
 
 	p->mp_reg_dbg_ctrl = nthw_module_query_register(p->mp_mod_rac, RAC_DBG_CTRL);
 
@@ -309,8 +309,8 @@ int nthw_rac_rab_reset(nthw_rac_t *p)
 
 	NT_LOG(DBG, NTHW, "%s: NT_RAC_RAB_INTERFACES=%d (0x%02X)", p_adapter_id_str,
 		n_rac_rab_bus_count, n_rac_rab_bus_mask);
-	assert(n_rac_rab_bus_count);
-	assert(n_rac_rab_bus_mask);
+	RTE_ASSERT(n_rac_rab_bus_count);
+	RTE_ASSERT(n_rac_rab_bus_mask);
 
 	/* RAC RAB bus "flip/flip" reset first stage - new impl (ref RMT#37020) */
 	nthw_rac_rab_init(p, 0);
@@ -452,7 +452,7 @@ uint32_t nthw_rac_rab_get_free(nthw_rac_t *p)
 {
 	if (!p->m_dma_active) {
 		/* Expecting mutex not to be locked! */
-		assert(0);      /* alert developer that something is wrong */
+		RTE_ASSERT(0);      /* alert developer that something is wrong */
 		return -1;
 	}
 
@@ -469,7 +469,7 @@ int nthw_rac_rab_write32_dma(nthw_rac_t *p, nthw_rab_bus_id_t bus_id, uint32_t a
 		NT_LOG(ERR, NTHW,
 			"%s: Failed rab dma write length check - bus: %d addr: 0x%08X wordcount: %d - inBufFree: 0x%08X",
 			p_adapter_id_str, bus_id, address, word_cnt, p->m_in_free);
-		assert(0);      /* alert developer that something is wrong */
+		RTE_ASSERT(0);      /* alert developer that something is wrong */
 		return -1;
 	}
 
@@ -508,7 +508,7 @@ int nthw_rac_rab_read32_dma(nthw_rac_t *p, nthw_rab_bus_id_t bus_id, uint32_t ad
 		NT_LOG(ERR, NTHW,
 			"%s: Failed rab dma read length check - bus: %d addr: 0x%08X wordcount: %d - inBufFree: 0x%08X",
 			p_adapter_id_str, bus_id, address, word_cnt, p->m_in_free);
-		assert(0);      /* alert developer that something is wrong */
+		RTE_ASSERT(0);      /* alert developer that something is wrong */
 		return -1;
 	}
 
diff --git a/drivers/net/ntnic/nthw/stat/nthw_stat.c b/drivers/net/ntnic/nthw/stat/nthw_stat.c
index afa24fd3a9..ed30173bdc 100644
--- a/drivers/net/ntnic/nthw/stat/nthw_stat.c
+++ b/drivers/net/ntnic/nthw/stat/nthw_stat.c
@@ -259,7 +259,7 @@ int nthw_stat_init(nthw_stat_t *p, nthw_fpga_t *p_fpga, int n_instance)
 			p_adapter_id_str, n_module_version_packed64, p->mn_stat_layout_version);
 	}
 
-	assert(p->mn_stat_layout_version);
+	RTE_ASSERT(p->mn_stat_layout_version);
 
 	/* STA module 0.2+ adds IPF counters per port (Rx feature) */
 	if (n_module_version_packed64 >= VERSION_PACKED64(0, 2))
@@ -332,7 +332,7 @@ int nthw_stat_init(nthw_stat_t *p, nthw_fpga_t *p_fpga, int n_instance)
 int nthw_stat_set_dma_address(nthw_stat_t *p, uint64_t stat_dma_physical,
 	uint32_t *p_stat_dma_virtual)
 {
-	assert(p_stat_dma_virtual);
+	RTE_ASSERT(p_stat_dma_virtual);
 	p->mp_timestamp = NULL;
 
 	p->m_stat_dma_physical = stat_dma_physical;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 88f6b6af6b..4cdc49abc8 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1197,7 +1197,7 @@ eth_mac_addr_add(struct rte_eth_dev *eth_dev,
 {
 	struct rte_ether_addr *const eth_addrs = eth_dev->data->mac_addrs;
 
-	assert(index < NUM_MAC_ADDRS_PER_PORT);
+	RTE_ASSERT(index < NUM_MAC_ADDRS_PER_PORT);
 
 	if (index >= NUM_MAC_ADDRS_PER_PORT) {
 		const struct pmd_internals *const internals =
@@ -1366,8 +1366,8 @@ eth_dev_set_link_up(struct rte_eth_dev *eth_dev)
 	if (internals->type == PORT_TYPE_VIRTUAL || internals->type == PORT_TYPE_OVERRIDE)
 		return 0;
 
-	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
-	assert(port == internals->n_intf_no);
+	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(port == internals->n_intf_no);
 
 	port_ops->set_adm_state(p_adapter_info, port, true);
 
@@ -1392,8 +1392,8 @@ eth_dev_set_link_down(struct rte_eth_dev *eth_dev)
 	if (internals->type == PORT_TYPE_VIRTUAL || internals->type == PORT_TYPE_OVERRIDE)
 		return 0;
 
-	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
-	assert(port == internals->n_intf_no);
+	RTE_ASSERT(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	RTE_ASSERT(port == internals->n_intf_no);
 
 	port_ops->set_link_status(p_adapter_info, port, false);
 
@@ -1930,7 +1930,7 @@ THREAD_FUNC adapter_stat_thread_fn(void *context)
 
 	NT_LOG_DBGX(DBG, NTNIC, "%s: begin", p_adapter_id_str);
 
-	assert(p_nthw_stat);
+	RTE_ASSERT(p_nthw_stat);
 
 	while (!p_drv->ntdrv.b_shutdown) {
 		nt_os_wait_usec(10 * 1000);
@@ -2071,7 +2071,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		kvargs_count = rte_kvargs_count(kvlist, ETH_DEV_NTHW_RXQUEUES_ARG);
 
 		if (kvargs_count != 0) {
-			assert(kvargs_count == 1);
+			RTE_ASSERT(kvargs_count == 1);
 			res = rte_kvargs_process(kvlist, ETH_DEV_NTHW_RXQUEUES_ARG, &string_to_u32,
 					&nb_rx_queues);
 
@@ -2095,7 +2095,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		kvargs_count = rte_kvargs_count(kvlist, ETH_DEV_NTHW_TXQUEUES_ARG);
 
 		if (kvargs_count != 0) {
-			assert(kvargs_count == 1);
+			RTE_ASSERT(kvargs_count == 1);
 			res = rte_kvargs_process(kvlist, ETH_DEV_NTHW_TXQUEUES_ARG, &string_to_u32,
 					&nb_tx_queues);
 
@@ -2401,7 +2401,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		if (get_flow_filter_ops() != NULL) {
 			if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE &&
 				internals->flw_dev->ndev->be.tpe.ver >= 2) {
-				assert(nthw_eth_dev_ops.mtu_set == dev_set_mtu_inline ||
+				RTE_ASSERT(nthw_eth_dev_ops.mtu_set == dev_set_mtu_inline ||
 					nthw_eth_dev_ops.mtu_set == NULL);
 				nthw_eth_dev_ops.mtu_set = dev_set_mtu_inline;
 				dev_set_mtu_inline(eth_dev, MTUINITVAL);
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 43f45ebe34..f548421ce3 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1159,7 +1159,7 @@ static int poll_statistics(struct pmd_internals *internals)
 	if (!p_nt4ga_stat || if_index < 0 || if_index >= NUM_ADAPTER_PORTS_MAX)
 		return -1;
 
-	assert(rte_tsc_freq > 0);
+	RTE_ASSERT(rte_tsc_freq > 0);
 
 	rte_spinlock_lock(&hwlock);
 
diff --git a/drivers/net/ntnic/ntutil/nt_util.c b/drivers/net/ntnic/ntutil/nt_util.c
index 694ab7a3b3..38d8de4e29 100644
--- a/drivers/net/ntnic/ntutil/nt_util.c
+++ b/drivers/net/ntnic/ntutil/nt_util.c
@@ -7,7 +7,6 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <inttypes.h>
-#include <assert.h>
 
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
-- 
2.45.0

