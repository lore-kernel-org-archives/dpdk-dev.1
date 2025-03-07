Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE1C28B2E
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 21:52:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D18C440EE3;
	Fri,  7 Mar 2025 22:52:15 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id AF6D140EDC
 for <dev@dpdk.org>; Fri,  7 Mar 2025 22:52:13 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 mx-outbound18-33.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 07 Mar 2025 21:52:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrPNJhdUCADDSYOPlGHT9Q6FFaccbLBF35IAAP8YYSiu6lhoZxSsSkKNwzZiski60k4QlNr6vT28m5PsUfYlUdE1XXP15GqFARwJ7eTa2a7AiYsZESD0CePsrx9cLxypmailp9oZfB2z4NPmHcc5GC2RwSeGR8QOXRRJ+H9uOoDLhFnWHXLD5FBD+aTtANfdlrQ9vuLFcPkuPuU852g0lMRvJX8bqkkPjcvH/z2S1HO3KDkk6kMSMaw87Fw8i8XBJKLVd/PRjkfxyLdUu+Ww5KFOFpZf6GNo6TwA0QOlS+jHI5EyBA669/JA4p/KyIBHK5xCPCAm6YKJW1fvtNG/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHjg6KksMcW7IHPpx0sl/XQh8yaGvHksr5pr8cvvr/I=;
 b=cycUIi6iksh3J2rhJm7KEpFhVBu3jmRmmNaD+rv78RE0Zp2gPI7Fpw+komKuI0JUAdTqmOO6ESAuMhM7trwEFCaIOw9BjV1yRxUzM5jBpWQ5lEGHQ6pSZVXCPK+gopIxM5U6iK9dDB1S7yq27p0Erk6Lyz8BYL/nm+m+p/lsUDl9yrC1ozg9DwzJelWwoKlmpZpsN/sf5Wc1n3JkoTlaUi7ADHCTdH4RIwWDkU4DDRspcJkoERnYlLp7e71mEtRpG1RK0/cCg+vE1StPsJ+LhpZNdOp0zrhobmpjVRnUrXg8E3XrN5/Ouh0LCowlRaTU52+q0FyD3GHhlp7Nt25uiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHjg6KksMcW7IHPpx0sl/XQh8yaGvHksr5pr8cvvr/I=;
 b=IMhNtmryDS1rFKUfn0gQ/p4IIcIg8nToLLQB8mSwo1laaozV56kiAL6wRTqnaHCmwYDG3iYSnZHTgamko8czuHbcejKWobeAXEVGMLBD4vAm8EE+lskWk15K+hdAKuRflK+Lzly9O9n1qLo+DZcik2rfn/NizjlzRe63JD1/nY4=
Received: from PR3P191CA0031.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::6) by
 PA4P190MB1182.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 21:52:01 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:102:55:cafe::4f) by PR3P191CA0031.outlook.office365.com
 (2603:10a6:102:55::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 21:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server id 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 21:52:01
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 5/5] net/ntnic: add nthw prefix function names
Date: Fri,  7 Mar 2025 22:51:35 +0100
Message-ID: <20250307215136.3110019-6-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250307215136.3110019-1-sil-plv@napatech.com>
References: <20250307215136.3110019-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|PA4P190MB1182:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a3b8fa8-073a-46d6-329c-08dd5dc24ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BusNeTXBIq6lx4IzT9UaoWIAGA0vMyFGBotwiFCkeM8ETNOBzrzIENuNTfMh?=
 =?us-ascii?Q?SSF6PZpTXCkTaDkkBpV3KLOOAc+JVII7yt1FuqbD0GXuHukFJpCfU2ZQSLka?=
 =?us-ascii?Q?z4g+rRSCcEKUvbddD2jZZeCc8VLn341lOky7wmSMG+FNDtNQqUGyNdxwLsPg?=
 =?us-ascii?Q?AJ3t+higVlk+5PXfNYebDwg2Hl+DbphLf3pTTIsjdGLenOmr+dkXXTO+Z64j?=
 =?us-ascii?Q?Zaf8R98Z7gjd34qdl0zb8q4F+YmSvynUEOi2hepSr1phpTCRIn3zaJQ/BJ2u?=
 =?us-ascii?Q?im5kK8jl1iF35yXa7EjiNyxK/WL7DXeCdAOMcuq91ye8O+pIpphB5VxFa8iG?=
 =?us-ascii?Q?U4dJHbHa4+ypj4IP5xyGOZNUkvVj8FaHoHUElfyKGX8Q43SaBUS1QyKSAWlq?=
 =?us-ascii?Q?4QOxtZ9uJ2MFGeToWh+nrQQsbvfnion4kjFZu9Z6/VfBX1JuVv3SftjtLADT?=
 =?us-ascii?Q?7tcMuZYCDGjl99D3+kLbl7VQFS4yXrsyAkd2qdRAo1yOC1oyieSlw1E2gI/L?=
 =?us-ascii?Q?sL3w7dBZZLwT+CKKC1OfuCAo6t1J2IOJht8Pu+fAMnYPpqVTXYIgFA3BYX87?=
 =?us-ascii?Q?0f0SU7z5SiqURrilKgxzSXvOkZ7w3JzQKvQSKEzPkZgc4lSJH01n3eHQ0gY/?=
 =?us-ascii?Q?etIWAf1uTrrUxe7VbUNtR653fsj2HQY2AqbepOm5GWZWE5/Q352II0inIJvY?=
 =?us-ascii?Q?QUIV1loqRi1AlXyoM/4naJ40WVTciVFhdgAVdRTrLSGt4EQNlOsoq28mQ/vP?=
 =?us-ascii?Q?eN6eRnJk27NtkQM7Z3mQYl6lwAmP7rhhe30Pf5c/lSkA4na0zRSIFf2pQj93?=
 =?us-ascii?Q?9b7BNyY96AH0ffJHBDB9/y1HOgvJA3a/RivqTukjvH3J0eKJVEWkLw8iHYkL?=
 =?us-ascii?Q?6372siGdjXXLqdtN62aZyo6ce8HEuMj6V2Uoq78g7OeSNCwgVfXA2no6Uf7Z?=
 =?us-ascii?Q?afhMXhp/3DDRmMK2bFt3cpItJSsuJyHxPtrJug0tJr+J/ofI+g663FNeEFOd?=
 =?us-ascii?Q?flnVCDRKze1x0PmLqHeZponIAKqkgHK6CFYK1KGz5LyNooU6slitmG+GNcJT?=
 =?us-ascii?Q?ABvzgegB2SbK1y7G1mchl6pEDGvdwUPgf237zeHPtSX5Sd9b0Yop2x3ewtkZ?=
 =?us-ascii?Q?ixZOz+Ly1TZEvet4NPiyhk5Fs28clTTg1HYi8Wy8XQ8QRLLKsJZai55Z4NN9?=
 =?us-ascii?Q?J8jQ3fLgvpovZ8CVwxfjneZbIdaqKzcsILdhg6puEIeAJMvoSkUx7heMoyT3?=
 =?us-ascii?Q?MLD8RRzaHVA+RhZZcU/+2IXwfAWptivtIFXV7ACN9fHWVGhi1cleV9YTRojQ?=
 =?us-ascii?Q?ac3ftCBWaEYCIU9c/gEXrzZHI2TRjFDyc2hh+TXtV0yh4licOg+eOA3cb8rK?=
 =?us-ascii?Q?7FNa6N5VKQT3whHmKxiNZhLvqX+h4nIL10nalhpCY7jZcm79mtnuOrRwDcT1?=
 =?us-ascii?Q?f6w8PtDKYvcO9VsjKXd2C5wUzvZif9iKqztsqDL5boOCNWlxdSlX4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mcgUmgiUzF8oR4U5gUSN4swoWZO9n9AuJPEkW1iCJhIWcSGBOQflXVQxFFud8BjWYAgZK59z2LjXRdhe8YdgdtP2+Ea50tzGRxUgZHpx7jpi5phPchBJXLzQTyNtoYbv84OXOGaYz35Dq8wV12svJo/7pe+Zt6O0JDnGrtVV6XDV1New/0aH7ah58+GN/sCJRoSAC3G1M2bCIP41myGVAEb+3Gf4W6MHmdtmRwfjDg2Ekxnh2nLu8F0nc3YBC1znlZd8oCnVwe8Oav2GXjTpYLLmXJNnicos36evtHUhxmKeN1b4ugMri1ZJQFwYgr6GhXpaD8b1VZAFU/Tl3g6WdqWvoAFSxnclzYLWJwRydbV1NOR+h2k6ckNyCi+XkaAqYxlOIQY/o/WRSz3Dc2DXHr89C3al5jiyvU5FpROmZfElfhXcQ8oJbtcWixxfXhgfE+pMlMV7T+DlTusgMfrKvly8wxx71EwJSyB9ugsvTjLeMXGL7D0VJvCvlB93wgj3jt/Js3DhkpcXm7IZTv4TNcpt2Ll3dwBMpz8nfdGD0y47q64SlzGeupfGZ9k88REIgOXBUi5swovoILSQKuI6kpcnAI+qEZd7D79HOnF1xJgcga/sHApBrBxLSOmriH/Vc4YXvHrogIS0uCTpbyV4wQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:52:01.4795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3b8fa8-073a-46d6-329c-08dd5dc24ac4
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1182
X-BESS-ID: 1741384324-304641-7657-45499-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.17.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGpoamhkB2BlA4zSzRPDUl2c
 Q4OTnVyMjCLNUoyTDN2DItJdXcEihspFQbCwBmbz4gQwAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262990 [from 
 cloudscan15-48.eu-central-1a.ess.aws.cudaops.com]
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

Add nthw prefix to functions with abstract names
to avoid exposing global symbols

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |   6 +-
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |   6 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  32 +--
 drivers/net/ntnic/include/create_elements.h   |   8 +-
 drivers/net/ntnic/include/flow_api.h          |  18 +-
 drivers/net/ntnic/include/flow_api_engine.h   |  10 +-
 drivers/net/ntnic/include/flow_filter.h       |   6 +-
 drivers/net/ntnic/include/hw_mod_backend.h    |  10 +-
 drivers/net/ntnic/include/ntnic_dbs.h         |  18 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |  23 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       |  31 +-
 drivers/net/ntnic/link_mgmt/nt4ga_link.c      |   4 +-
 drivers/net/ntnic/nim/i2c_nim.c               |  16 +-
 drivers/net/ntnic/nim/i2c_nim.h               |  12 +-
 drivers/net/ntnic/nthw/dbs/nthw_dbs.c         |  18 +-
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  48 ++--
 .../ntnic/nthw/flow_api/flow_api_nic_setup.h  |   8 +-
 .../nthw/flow_api/flow_backend/flow_backend.c |   8 +-
 drivers/net/ntnic/nthw/flow_api/flow_filter.c |  12 +-
 drivers/net/ntnic/nthw/flow_api/flow_group.c  |  10 +-
 drivers/net/ntnic/nthw/flow_api/flow_hasher.c |   4 +-
 drivers/net/ntnic/nthw/flow_api/flow_hasher.h |   4 +-
 drivers/net/ntnic/nthw/flow_api/flow_km.c     |   4 +-
 .../nthw/flow_api/hw_mod/hw_mod_backend.c     |  10 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c   |   6 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c   |   5 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c   |   4 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_km.c    |   4 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c   |   4 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c   |   4 +-
 .../nthw/flow_api/hw_mod/hw_mod_slc_lr.c      |   4 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c   |   4 +-
 .../flow_api/profile_inline/flm_evt_queue.c   |  12 +-
 .../flow_api/profile_inline/flm_evt_queue.h   |   8 +-
 .../profile_inline/flow_api_hw_db_inline.c    |  24 +-
 .../profile_inline/flow_api_profile_inline.c  | 268 +++++++++---------
 .../net/ntnic/nthw/ntnic_meter/ntnic_meter.c  |   2 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  12 +-
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  44 +--
 drivers/net/ntnic/ntnic_mod_reg.c             |  18 +-
 drivers/net/ntnic/ntnic_mod_reg.h             |  29 +-
 drivers/net/ntnic/ntutil/nt_util.c            |   4 +-
 drivers/net/ntnic/ntutil/nt_util.h            |   4 +-
 43 files changed, 404 insertions(+), 382 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 95692d666d..a9ae1fa3f8 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -168,7 +168,7 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 	nt4ga_filter_t *p_filter = &p_adapter_info->nt4ga_filter;
 
 	if (flow_filter_ops != NULL) {
-		res = flow_filter_ops->flow_filter_init(p_fpga, &p_filter->mp_flow_device,
+		res = flow_filter_ops->nthw_flow_filter_init(p_fpga, &p_filter->mp_flow_device,
 				p_adapter_info->adapter_no);
 
 		if (res != 0) {
@@ -266,7 +266,7 @@ static int nt4ga_adapter_deinit(struct adapter_info_s *p_adapter_info)
 	nt4ga_filter_t *p_filter = &p_adapter_info->nt4ga_filter;
 
 	if (flow_filter_ops != NULL) {
-		res = flow_filter_ops->flow_filter_done(p_filter->mp_flow_device);
+		res = flow_filter_ops->nthw_flow_filter_done(p_filter->mp_flow_device);
 
 		if (res != 0) {
 			NT_LOG(ERR, NTNIC, "Cannot deinitialize filter");
@@ -309,7 +309,7 @@ static const struct adapter_ops ops = {
 	.show_info = nt4ga_adapter_show_info,
 };
 
-void adapter_init(void)
+void nthw_adapter_init(void)
 {
 	register_adapter_ops(&ops);
 }
diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index 2f1e12f891..0ea40fdf42 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -558,11 +558,13 @@ static int nt4ga_stat_collect_cap_v1_stats(struct adapter_info_s *p_adapter_info
 	}
 
 	/* Update and get FLM stats */
-	flow_filter_ops->flow_get_flm_stats(ndev, (uint64_t *)p_nt4ga_stat->mp_stat_structs_flm,
+	flow_filter_ops->nthw_flow_get_flm_stats(ndev,
+		(uint64_t *)p_nt4ga_stat->mp_stat_structs_flm,
 		sizeof(struct flm_counters_v1) / sizeof(uint64_t));
 
 	/* Update and get IFR stats */
-	flow_filter_ops->flow_get_ifr_stats(ndev, (uint64_t *)p_nt4ga_stat->mp_stat_structs_ifr,
+	flow_filter_ops->nthw_flow_get_ifr_stats(ndev,
+		(uint64_t *)p_nt4ga_stat->mp_stat_structs_ifr,
 		p_nt4ga_stat->mn_ifr_counters - 1);
 
 	/*
diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 6ee3beb7bd..69cd184680 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -177,13 +177,13 @@ static void dbs_init_rx_queue(nthw_dbs_t *p_nthw_dbs, uint32_t queue, uint32_t s
 	uint32_t dummy;
 
 	do {
-		get_rx_init(p_nthw_dbs, &init, &dummy, &busy);
+		nthw_get_rx_init(p_nthw_dbs, &init, &dummy, &busy);
 	} while (busy != 0);
 
-	set_rx_init(p_nthw_dbs, start_idx, start_ptr, INIT_QUEUE, queue);
+	nthw_set_rx_init(p_nthw_dbs, start_idx, start_ptr, INIT_QUEUE, queue);
 
 	do {
-		get_rx_init(p_nthw_dbs, &init, &dummy, &busy);
+		nthw_get_rx_init(p_nthw_dbs, &init, &dummy, &busy);
 	} while (busy != 0);
 }
 
@@ -195,13 +195,13 @@ static void dbs_init_tx_queue(nthw_dbs_t *p_nthw_dbs, uint32_t queue, uint32_t s
 	uint32_t dummy;
 
 	do {
-		get_tx_init(p_nthw_dbs, &init, &dummy, &busy);
+		nthw_get_tx_init(p_nthw_dbs, &init, &dummy, &busy);
 	} while (busy != 0);
 
 	set_tx_init(p_nthw_dbs, start_idx, start_ptr, INIT_QUEUE, queue);
 
 	do {
-		get_tx_init(p_nthw_dbs, &init, &dummy, &busy);
+		nthw_get_tx_init(p_nthw_dbs, &init, &dummy, &busy);
 	} while (busy != 0);
 }
 
@@ -250,18 +250,18 @@ static int nthw_virt_queue_init(struct fpga_info_s *p_fpga_info)
 	for (i = 0; i < NT_DBS_TX_QUEUES_MAX; ++i)
 		dbs_init_tx_queue(p_nthw_dbs, i, 0, 0);
 
-	set_rx_control(p_nthw_dbs, LAST_QUEUE, RX_AM_DISABLE, RX_AM_POLL_SPEED, RX_UW_DISABLE,
+	nthw_set_rx_control(p_nthw_dbs, LAST_QUEUE, RX_AM_DISABLE, RX_AM_POLL_SPEED, RX_UW_DISABLE,
 		RX_UW_POLL_SPEED, RX_Q_DISABLE);
-	set_rx_control(p_nthw_dbs, LAST_QUEUE, RX_AM_ENABLE, RX_AM_POLL_SPEED, RX_UW_ENABLE,
+	nthw_set_rx_control(p_nthw_dbs, LAST_QUEUE, RX_AM_ENABLE, RX_AM_POLL_SPEED, RX_UW_ENABLE,
 		RX_UW_POLL_SPEED, RX_Q_DISABLE);
-	set_rx_control(p_nthw_dbs, LAST_QUEUE, RX_AM_ENABLE, RX_AM_POLL_SPEED, RX_UW_ENABLE,
+	nthw_set_rx_control(p_nthw_dbs, LAST_QUEUE, RX_AM_ENABLE, RX_AM_POLL_SPEED, RX_UW_ENABLE,
 		RX_UW_POLL_SPEED, RX_Q_ENABLE);
 
-	set_tx_control(p_nthw_dbs, LAST_QUEUE, TX_AM_DISABLE, TX_AM_POLL_SPEED, TX_UW_DISABLE,
+	nthw_set_tx_control(p_nthw_dbs, LAST_QUEUE, TX_AM_DISABLE, TX_AM_POLL_SPEED, TX_UW_DISABLE,
 		TX_UW_POLL_SPEED, TX_Q_DISABLE);
-	set_tx_control(p_nthw_dbs, LAST_QUEUE, TX_AM_ENABLE, TX_AM_POLL_SPEED, TX_UW_ENABLE,
+	nthw_set_tx_control(p_nthw_dbs, LAST_QUEUE, TX_AM_ENABLE, TX_AM_POLL_SPEED, TX_UW_ENABLE,
 		TX_UW_POLL_SPEED, TX_Q_DISABLE);
-	set_tx_control(p_nthw_dbs, LAST_QUEUE, TX_AM_ENABLE, TX_AM_POLL_SPEED, TX_UW_ENABLE,
+	nthw_set_tx_control(p_nthw_dbs, LAST_QUEUE, TX_AM_ENABLE, TX_AM_POLL_SPEED, TX_UW_ENABLE,
 		TX_UW_POLL_SPEED, TX_Q_ENABLE);
 
 	return 0;
@@ -464,10 +464,10 @@ static int dbs_wait_on_busy(struct nthw_virt_queue *vq, uint32_t *idle, int rx)
 
 	do {
 		if (rx)
-			err = get_rx_idle(p_nthw_dbs, idle, &queue, &busy);
+			err = nthw_get_rx_idle(p_nthw_dbs, idle, &queue, &busy);
 
 		else
-			err = get_tx_idle(p_nthw_dbs, idle, &queue, &busy);
+			err = nthw_get_tx_idle(p_nthw_dbs, idle, &queue, &busy);
 	} while (!err && busy);
 
 	return err;
@@ -492,10 +492,10 @@ static int dbs_wait_hw_queue_shutdown(struct nthw_virt_queue *vq, int rx)
 
 	do {
 		if (rx)
-			err = set_rx_idle(p_nthw_dbs, 1, vq->index);
+			err = nthw_set_rx_idle(p_nthw_dbs, 1, vq->index);
 
 		else
-			err = set_tx_idle(p_nthw_dbs, 1, vq->index);
+			err = nthw_set_tx_idle(p_nthw_dbs, 1, vq->index);
 
 		if (err)
 			return -1;
@@ -1424,7 +1424,7 @@ static struct sg_ops_s sg_ops = {
 	.nthw_virt_queue_init = nthw_virt_queue_init
 };
 
-void sg_init(void)
+void nthw_sg_init(void)
 {
 	NT_LOG(INF, NTNIC, "SG ops initialized");
 	register_sg_ops(&sg_ops);
diff --git a/drivers/net/ntnic/include/create_elements.h b/drivers/net/ntnic/include/create_elements.h
index f0b9410cb9..dac2cd7cc9 100644
--- a/drivers/net/ntnic/include/create_elements.h
+++ b/drivers/net/ntnic/include/create_elements.h
@@ -60,11 +60,11 @@ enum nt_rte_flow_item_type {
 
 extern rte_spinlock_t flow_lock;
 
-int interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_flow_item *out);
-int create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr);
-int create_match_elements(struct cnv_match_s *match, const struct rte_flow_item items[],
+int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_flow_item *out);
+int nthw_create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr);
+int nthw_create_match_elements(struct cnv_match_s *match, const struct rte_flow_item items[],
 	int max_elem);
-int create_action_elements_inline(struct cnv_action_s *action,
+int nthw_create_action_elements_inline(struct cnv_action_s *action,
 	const struct rte_flow_action actions[],
 	int max_elem,
 	uint32_t queue_offset);
diff --git a/drivers/net/ntnic/include/flow_api.h b/drivers/net/ntnic/include/flow_api.h
index 5ffdf90012..f80414a185 100644
--- a/drivers/net/ntnic/include/flow_api.h
+++ b/drivers/net/ntnic/include/flow_api.h
@@ -27,7 +27,7 @@ struct hw_mod_resource_s {
 /*
  * Device Management API
  */
-int flow_delete_eth_dev(struct flow_eth_dev *eth_dev);
+int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev);
 
 /**
  * A structure used to configure the Receive Side Scaling (RSS) feature
@@ -167,7 +167,7 @@ enum flow_nic_err_msg_e {
 	ERR_MSG_END
 };
 
-void flow_nic_set_error(enum flow_nic_err_msg_e msg, struct rte_flow_error *error);
+void nthw_flow_nic_set_error(enum flow_nic_err_msg_e msg, struct rte_flow_error *error);
 
 /*
  * Resources
@@ -219,17 +219,17 @@ extern const char *dbg_res_descr[];
 #define flow_nic_is_resource_used(_ndev, res_type, index)                                         \
 	(!!flow_nic_is_bit_set((_ndev)->res[res_type].alloc_bm, index))
 
-int flow_nic_alloc_resource(struct flow_nic_dev *ndev, enum res_type_e res_type,
+int nthw_flow_nic_alloc_resource(struct flow_nic_dev *ndev, enum res_type_e res_type,
 	uint32_t alignment);
 
-int flow_nic_alloc_resource_config(struct flow_nic_dev *ndev, enum res_type_e res_type,
+int nthw_flow_nic_alloc_resource_config(struct flow_nic_dev *ndev, enum res_type_e res_type,
 	unsigned int num, uint32_t alignment);
-void flow_nic_free_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int idx);
+void nthw_flow_nic_free_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int idx);
 
-int flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index);
-int flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index);
+int nthw_flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index);
+int nthw_flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index);
 
-int flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
-int flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count);
+int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
+int nthw_flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count);
 
 #endif
diff --git a/drivers/net/ntnic/include/flow_api_engine.h b/drivers/net/ntnic/include/flow_api_engine.h
index 262317002f..859c76656a 100644
--- a/drivers/net/ntnic/include/flow_api_engine.h
+++ b/drivers/net/ntnic/include/flow_api_engine.h
@@ -420,12 +420,12 @@ void kcc_free_ndev_resource_management(void **handle);
 /*
  * Group management
  */
-int flow_group_handle_create(void **handle, uint32_t group_count);
-int flow_group_handle_destroy(void **handle);
+int nthw_flow_group_handle_create(void **handle, uint32_t group_count);
+int nthw_flow_group_handle_destroy(void **handle);
 
-int flow_group_translate_get(void *handle, uint8_t owner_id, uint8_t port_id, uint32_t group_in,
-	uint32_t *group_out);
-int flow_group_translate_get_orig_group(void *handle, uint32_t translated_group,
+int nthw_flow_group_translate_get(void *handle, uint8_t owner_id, uint8_t port_id,
+	uint32_t group_in, uint32_t *group_out);
+int nthw_flow_group_translate_get_orig_group(void *handle, uint32_t translated_group,
 	uint32_t *group_orig);
 
 #endif  /* _FLOW_API_ENGINE_H_ */
diff --git a/drivers/net/ntnic/include/flow_filter.h b/drivers/net/ntnic/include/flow_filter.h
index 01777f8c9f..f325e680fb 100644
--- a/drivers/net/ntnic/include/flow_filter.h
+++ b/drivers/net/ntnic/include/flow_filter.h
@@ -9,8 +9,8 @@
 #include "flow_api.h"
 #include "nthw_fpga_model.h"
 
-int flow_filter_init(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device, int adapter_no);
-int flow_filter_done(struct flow_nic_dev *dev);
-int flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
+int nthw_flow_filter_init(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device, int adapter_no);
+int nthw_flow_filter_done(struct flow_nic_dev *dev);
+int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
 
 #endif  /* __FLOW_FILTER_HPP__ */
diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index 594bdab2a6..fcf9ebef8e 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -29,8 +29,8 @@
 struct flow_api_backend_s;
 struct common_func_s;
 
-void *callocate_mod(struct common_func_s *mod, int sets, ...);
-void zero_module_cache(struct common_func_s *mod);
+void *nthw_callocate_mod(struct common_func_s *mod, int sets, ...);
+void nthw_zero_module_cache(struct common_func_s *mod);
 
 #define ALL_ENTRIES -1000
 #define ALL_BANK_ENTRIES -1001
@@ -1164,8 +1164,8 @@ struct flow_api_backend_s {
 	unsigned int max_queues;
 };
 
-int flow_api_backend_init(struct flow_api_backend_s *dev, const struct flow_api_backend_ops *iface,
-	void *be_dev);
-int flow_api_backend_done(struct flow_api_backend_s *dev);
+int nthw_flow_api_backend_init(struct flow_api_backend_s *dev,
+	const struct flow_api_backend_ops *iface, void *be_dev);
+int nthw_flow_api_backend_done(struct flow_api_backend_s *dev);
 
 #endif  /* _HW_MOD_BACKEND_H_ */
diff --git a/drivers/net/ntnic/include/ntnic_dbs.h b/drivers/net/ntnic/include/ntnic_dbs.h
index d70a7c445e..247ae76d98 100644
--- a/drivers/net/ntnic/include/ntnic_dbs.h
+++ b/drivers/net/ntnic/include/ntnic_dbs.h
@@ -236,30 +236,30 @@ nthw_dbs_t *nthw_dbs_new(void);
 int dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance);
 void dbs_reset(nthw_dbs_t *p);
 
-int set_rx_control(nthw_dbs_t *p,
+int nthw_set_rx_control(nthw_dbs_t *p,
 	uint32_t last_queue,
 	uint32_t avail_monitor_enable,
 	uint32_t avail_monitor_speed,
 	uint32_t used_write_enable,
 	uint32_t used_write_speed,
 	uint32_t rx_queue_enable);
-int set_tx_control(nthw_dbs_t *p,
+int nthw_set_tx_control(nthw_dbs_t *p,
 	uint32_t last_queue,
 	uint32_t avail_monitor_enable,
 	uint32_t avail_monitor_speed,
 	uint32_t used_write_enable,
 	uint32_t used_write_speed,
 	uint32_t tx_queue_enable);
-int set_rx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
+int nthw_set_rx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue);
-int get_rx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy);
+int nthw_get_rx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy);
 int set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue);
-int get_tx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy);
-int set_rx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue);
-int get_rx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy);
-int set_tx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue);
-int get_tx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy);
+int nthw_get_tx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy);
+int nthw_set_rx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue);
+int nthw_get_rx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy);
+int nthw_set_tx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue);
+int nthw_get_tx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy);
 int set_rx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index ce52c79f43..dde185c62f 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -304,28 +304,28 @@ static int _create_nim(adapter_info_t *drv, int port, bool enable)
 		return -1;
 	}
 
-	res = construct_and_preinit_nim(nim_ctx, NULL);
+	res = nthw_construct_and_preinit_nim(nim_ctx, NULL);
 
 	if (res)
 		return res;
 
-	res = nim_state_build(nim_ctx, &nim);
+	res = nthw_nim_state_build(nim_ctx, &nim);
 
 	if (res)
 		return res;
 
 	NT_LOG(DBG, NTHW, "%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
-		drv->mp_port_id_str[port], nim_ctx->nim_id, nim_id_to_text(nim_ctx->nim_id), nim.br,
-		nim_ctx->vendor_name, nim_ctx->prod_no, nim_ctx->serial_no);
+		drv->mp_port_id_str[port], nim_ctx->nim_id, nthw_nim_id_to_text(nim_ctx->nim_id),
+		nim.br, nim_ctx->vendor_name, nim_ctx->prod_no, nim_ctx->serial_no);
 
 	/*
 	 * Does the driver support the NIM module type?
 	 */
 	if (nim_ctx->nim_id != valid_nim_id) {
 		NT_LOG(ERR, NTHW, "%s: The driver does not support the NIM module type %s",
-			drv->mp_port_id_str[port], nim_id_to_text(nim_ctx->nim_id));
+			drv->mp_port_id_str[port], nthw_nim_id_to_text(nim_ctx->nim_id));
 		NT_LOG(DBG, NTHW, "%s: The driver supports the NIM module type %s",
-			drv->mp_port_id_str[port], nim_id_to_text(valid_nim_id));
+			drv->mp_port_id_str[port], nthw_nim_id_to_text(valid_nim_id));
 		return -1;
 	}
 
@@ -371,7 +371,7 @@ static int _port_init(adapter_info_t *drv, nthw_fpga_t *fpga, int port)
 
 	/*
 	 * Phase 1. Pre-state machine (`port init` functions)
-	 * 1.1) nt4ga_adapter::port_init()
+	 * 1.1) nt4ga_adapter::nthw_port_init()
 	 */
 
 	/* No adapter set-up here, only state variables */
@@ -597,7 +597,7 @@ static int _common_ptp_nim_state_machine(void *data)
 					continue;
 				}
 
-				if (nim_state_build(&nim_ctx[i], &new_state)) {
+				if (nthw_nim_state_build(&nim_ctx[i], &new_state)) {
 					NT_LOG(ERR, NTNIC, "%s: Cannot read basic NIM data",
 						drv->mp_port_id_str[i]);
 					continue;
@@ -607,8 +607,9 @@ static int _common_ptp_nim_state_machine(void *data)
 				NT_LOG(DBG, NTNIC,
 					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
 					drv->mp_port_id_str[i], nim_ctx->nim_id,
-					nim_id_to_text(nim_ctx->nim_id), (unsigned int)new_state.br,
-					nim_ctx->vendor_name, nim_ctx->prod_no, nim_ctx->serial_no);
+					nthw_nim_id_to_text(nim_ctx->nim_id),
+					(unsigned int)new_state.br, nim_ctx->vendor_name,
+					nim_ctx->prod_no, nim_ctx->serial_no);
 
 				(void)_link_state_build(drv, &mac_pcs[i], &gpio_phy[i], i,
 					&link_state[i], is_port_disabled);
@@ -725,7 +726,7 @@ static struct link_ops_s link_100g_ops = {
 	.link_init = nt4ga_link_100g_ports_init,
 };
 
-void link_100g_init(void)
+void nthw_link_100g_init(void)
 {
 	register_100g_link_ops(&link_100g_ops);
 }
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 06ee7e2b95..d27ceeea88 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -554,12 +554,12 @@ static int create_nim(adapter_info_t *drv, int port, bool enable)
 	 */
 	nt_os_wait_usec(1000000);	/* pause 1.0s */
 
-	res = construct_and_preinit_nim(nim_ctx, NULL);
+	res = nthw_construct_and_preinit_nim(nim_ctx, NULL);
 
 	if (res)
 		return res;
 
-	res = nim_state_build(nim_ctx, &nim);
+	res = nthw_nim_state_build(nim_ctx, &nim);
 
 	if (res)
 		return res;
@@ -568,17 +568,17 @@ static int create_nim(adapter_info_t *drv, int port, bool enable)
 	nim_ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena = true;
 
 	NT_LOG(DBG, NTHW, "%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
-		drv->mp_port_id_str[port], nim_ctx->nim_id, nim_id_to_text(nim_ctx->nim_id), nim.br,
-		nim_ctx->vendor_name, nim_ctx->prod_no, nim_ctx->serial_no);
+		drv->mp_port_id_str[port], nim_ctx->nim_id, nthw_nim_id_to_text(nim_ctx->nim_id),
+		nim.br, nim_ctx->vendor_name, nim_ctx->prod_no, nim_ctx->serial_no);
 
 	/*
 	 * Does the driver support the NIM module type?
 	 */
 	if (nim_ctx->nim_id != valid_nim_id) {
 		NT_LOG(ERR, NTHW, "%s: The driver does not support the NIM module type %s",
-			drv->mp_port_id_str[port], nim_id_to_text(nim_ctx->nim_id));
+			drv->mp_port_id_str[port], nthw_nim_id_to_text(nim_ctx->nim_id));
 		NT_LOG(DBG, NTHW, "%s: The driver supports the NIM module type %s",
-			drv->mp_port_id_str[port], nim_id_to_text(valid_nim_id));
+			drv->mp_port_id_str[port], nthw_nim_id_to_text(valid_nim_id));
 		return -1;
 	}
 
@@ -612,13 +612,13 @@ static int nim_ready_100_gb(adapter_info_t *p_info, int port)
 
 	/* Adjust NIM power level */
 	if (nim_ctx->pwr_level_req > 4) {
-		qsfp28_set_high_power(nim_ctx);
+		nthw_qsfp28_set_high_power(nim_ctx);
 		nim_ctx->pwr_level_cur = nim_ctx->pwr_level_req;
 	}
 
 	/* enable_fec is what the end result should be, now find out if it's possible */
 	if (enable_fec) {
-		if (qsfp28_set_fec_enable(nim_ctx, true, false)) {
+		if (nthw_qsfp28_set_fec_enable(nim_ctx, true, false)) {
 			/* Prefer NIM media FEC since the NIM is assumed to know the right FEC */
 			NT_LOG(DBG, NTNIC, "Port %s: NIM media FEC enabled",
 				p_info->mp_port_id_str[port]);
@@ -635,7 +635,7 @@ static int nim_ready_100_gb(adapter_info_t *p_info, int port)
 				return 1;
 			}
 
-		} else if (qsfp28_set_fec_enable(nim_ctx, false, false)) {
+		} else if (nthw_qsfp28_set_fec_enable(nim_ctx, false, false)) {
 			/* The NIM does not support FEC at all so turn FPGA FEC on instead */
 			/* This is relevant to SR4 modules */
 			NT_LOG(DBG, NTNIC, "Port %s: No NIM FEC", p_info->mp_port_id_str[port]);
@@ -643,7 +643,7 @@ static int nim_ready_100_gb(adapter_info_t *p_info, int port)
 			NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC enabled",
 				p_info->mp_port_id_str[port]);
 
-		} else if (qsfp28_set_fec_enable(nim_ctx, true, true)) {
+		} else if (nthw_qsfp28_set_fec_enable(nim_ctx, true, true)) {
 			/* This probably not a likely scenario */
 			nthw_phy_tile_configure_fec(p_phy_tile, port, false);
 			NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC enabled",
@@ -657,7 +657,7 @@ static int nim_ready_100_gb(adapter_info_t *p_info, int port)
 			return 1;
 		}
 
-	} else if (qsfp28_set_fec_enable(nim_ctx, false, false)) {
+	} else if (nthw_qsfp28_set_fec_enable(nim_ctx, false, false)) {
 		/* The NIM does not support FEC at all - this is relevant to LR4 modules */
 		NT_LOG(DBG, NTNIC, "Port %s: No NIM FEC", p_info->mp_port_id_str[port]);
 
@@ -671,7 +671,7 @@ static int nim_ready_100_gb(adapter_info_t *p_info, int port)
 			return 1;
 		}
 
-	} else if (qsfp28_set_fec_enable(nim_ctx, false, true)) {
+	} else if (nthw_qsfp28_set_fec_enable(nim_ctx, false, true)) {
 		nthw_phy_tile_configure_fec(p_phy_tile, port, false);
 		/* This probably not a likely scenario */
 		NT_LOG(DBG, NTNIC, "Port %s: FPGA FEC enabled", p_info->mp_port_id_str[port]);
@@ -906,7 +906,7 @@ static void *_common_ptp_nim_state_machine(void *data)
 					continue;
 				}
 
-				if (nim_state_build(&nim_ctx[i], &new_state)) {
+				if (nthw_nim_state_build(&nim_ctx[i], &new_state)) {
 					NT_LOG(ERR, NTNIC, "%s: Cannot read basic NIM data",
 						drv->mp_port_id_str[i]);
 					continue;
@@ -916,8 +916,9 @@ static void *_common_ptp_nim_state_machine(void *data)
 				NT_LOG(DBG, NTNIC,
 					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
 					drv->mp_port_id_str[i], nim_ctx->nim_id,
-					nim_id_to_text(nim_ctx->nim_id), (unsigned int)new_state.br,
-					nim_ctx->vendor_name, nim_ctx->prod_no, nim_ctx->serial_no);
+					nthw_nim_id_to_text(nim_ctx->nim_id),
+					(unsigned int)new_state.br, nim_ctx->vendor_name,
+					nim_ctx->prod_no, nim_ctx->serial_no);
 				link_state[i].lh_nim_absent = false;
 				NT_LOG(DBG, NTNIC, "%s: NIM module initialized",
 					drv->mp_port_id_str[i]);
diff --git a/drivers/net/ntnic/link_mgmt/nt4ga_link.c b/drivers/net/ntnic/link_mgmt/nt4ga_link.c
index 4dc1c3d467..5ddbb9f1fd 100644
--- a/drivers/net/ntnic/link_mgmt/nt4ga_link.c
+++ b/drivers/net/ntnic/link_mgmt/nt4ga_link.c
@@ -153,7 +153,7 @@ static int nt4ga_port_tx_power(struct adapter_info_s *p, int port, bool disable)
 		nim_i2c_ctx_t *nim_ctx = &link_info->u.var100g.nim_ctx[port];
 
 		if (!nim_ctx->specific_u.qsfp.rx_only) {
-			if (nim_qsfp_plus_nim_set_tx_laser_disable(nim_ctx, disable, -1) != 0)
+			if (nthw_nim_qsfp_plus_nim_set_tx_laser_disable(nim_ctx, disable, -1) != 0)
 				return 1;
 		}
 	}
@@ -208,7 +208,7 @@ static const struct port_ops ops = {
 	.tx_power = nt4ga_port_tx_power,
 };
 
-void port_init(void)
+void nthw_port_init(void)
 {
 	register_port_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 3706aaa045..654e2dd80e 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -328,12 +328,12 @@ static int qsfp_nim_state_build(nim_i2c_ctx_t *ctx, sfp_nim_state_t *state)
 	return res;
 }
 
-int nim_state_build(nim_i2c_ctx_t *ctx, sfp_nim_state_t *state)
+int nthw_nim_state_build(nim_i2c_ctx_t *ctx, sfp_nim_state_t *state)
 {
 	return qsfp_nim_state_build(ctx, state);
 }
 
-const char *nim_id_to_text(uint8_t nim_id)
+const char *nthw_nim_id_to_text(uint8_t nim_id)
 {
 	switch (nim_id) {
 	case 0x0:
@@ -356,7 +356,7 @@ const char *nim_id_to_text(uint8_t nim_id)
 /*
  * Disable laser for specific lane or all lanes
  */
-int nim_qsfp_plus_nim_set_tx_laser_disable(nim_i2c_ctx_p ctx, bool disable, int lane_idx)
+int nthw_nim_qsfp_plus_nim_set_tx_laser_disable(nim_i2c_ctx_p ctx, bool disable, int lane_idx)
 {
 	uint8_t value;
 	uint8_t mask;
@@ -419,7 +419,7 @@ static int qsfpplus_read_basic_data(nim_i2c_ctx_t *ctx)
 	const char *yes_no[2] = { "No", "Yes" };
 	(void)yes_no;
 	NT_LOG(DBG, NTNIC, "Instance %d: NIM id: %s (%d)", ctx->instance,
-		nim_id_to_text(ctx->nim_id), ctx->nim_id);
+		nthw_nim_id_to_text(ctx->nim_id), ctx->nim_id);
 
 	/* Read DMI options */
 	if (nim_read_write_data_lin(ctx, pg_addr, QSFP_DMI_OPTION_LIN_ADDR, sizeof(options),
@@ -788,7 +788,7 @@ static int qsfp28_preinit(nim_i2c_ctx_p ctx, int8_t lane_idx)
 	return res;
 }
 
-int construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra)
+int nthw_construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra)
 {
 	int res = i2c_nim_common_construct(ctx);
 
@@ -803,7 +803,7 @@ int construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra)
 
 	default:
 		res = 1;
-		NT_LOG(ERR, NTHW, "NIM type %s is not supported.", nim_id_to_text(ctx->nim_id));
+		NT_LOG(ERR, NTHW, "NIM type %s is not supported", nthw_nim_id_to_text(ctx->nim_id));
 	}
 
 	return res;
@@ -815,7 +815,7 @@ int construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra)
  * When cleared (= 0b), modules with power classes 5 to 7 must dissipate less
  * than 3.5W (but are not required to be fully functional). Default 0.
  */
-void qsfp28_set_high_power(nim_i2c_ctx_p ctx)
+void nthw_qsfp28_set_high_power(nim_i2c_ctx_p ctx)
 {
 	const uint16_t addr = 93;
 	uint8_t data;
@@ -834,7 +834,7 @@ void qsfp28_set_high_power(nim_i2c_ctx_p ctx)
  *  register must be avoided as this introduces I2C errors on NT200A01.
  */
 
-bool qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool host_side_fec)
+bool nthw_qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool host_side_fec)
 {
 	/*
 	 * If the current FEC state does not match the wanted and the FEC cannot be
diff --git a/drivers/net/ntnic/nim/i2c_nim.h b/drivers/net/ntnic/nim/i2c_nim.h
index 888b709135..61dfedaa4f 100644
--- a/drivers/net/ntnic/nim/i2c_nim.h
+++ b/drivers/net/ntnic/nim/i2c_nim.h
@@ -16,25 +16,25 @@ typedef struct sfp_nim_state {
  * Builds an nim state for the port implied by `ctx`, returns zero
  * if successful, and non-zero otherwise. SFP and QSFP nims are supported
  */
-int nim_state_build(nim_i2c_ctx_t *ctx, sfp_nim_state_t *state);
+int nthw_nim_state_build(nim_i2c_ctx_t *ctx, sfp_nim_state_t *state);
 
 /*
  * Returns a type name such as "SFP/SFP+" for a given NIM type identifier,
  * or the string "ILLEGAL!".
  */
-const char *nim_id_to_text(uint8_t nim_id);
+const char *nthw_nim_id_to_text(uint8_t nim_id);
 
-int nim_qsfp_plus_nim_set_tx_laser_disable(nim_i2c_ctx_t *ctx, bool disable, int lane_idx);
+int nthw_nim_qsfp_plus_nim_set_tx_laser_disable(nim_i2c_ctx_t *ctx, bool disable, int lane_idx);
 
 /*
  * This function tries to classify NIM based on it's ID and some register reads
  * and collects information into ctx structure. The @extra parameter could contain
  * the initialization argument for specific type of NIMS.
  */
-int construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra);
+int nthw_construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra);
 
-void qsfp28_set_high_power(nim_i2c_ctx_p ctx);
-bool qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool host_side_fec);
+void nthw_qsfp28_set_high_power(nim_i2c_ctx_p ctx);
+bool nthw_qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool host_side_fec);
 
 void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
 	nthw_pca9849_t *p_ca9849);
diff --git a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
index 41fd55a466..aed52f67f5 100644
--- a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
+++ b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
@@ -403,7 +403,7 @@ void dbs_reset(nthw_dbs_t *p)
 	}
 }
 
-int set_rx_control(nthw_dbs_t *p,
+int nthw_set_rx_control(nthw_dbs_t *p,
 	uint32_t last_queue,
 	uint32_t avail_monitor_enable,
 	uint32_t avail_monitor_speed,
@@ -421,7 +421,7 @@ int set_rx_control(nthw_dbs_t *p,
 	return 0;
 }
 
-int set_tx_control(nthw_dbs_t *p,
+int nthw_set_tx_control(nthw_dbs_t *p,
 	uint32_t last_queue,
 	uint32_t avail_monitor_enable,
 	uint32_t avail_monitor_speed,
@@ -439,7 +439,7 @@ int set_tx_control(nthw_dbs_t *p,
 	return 0;
 }
 
-int set_rx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
+int nthw_set_rx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue)
 {
 	if (p->mp_reg_rx_init_val) {
@@ -454,7 +454,7 @@ int set_rx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t
 	return 0;
 }
 
-int get_rx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy)
+int nthw_get_rx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy)
 {
 	*init = nthw_field_get_val32(p->mp_fld_rx_init_init);
 	*queue = nthw_field_get_val32(p->mp_fld_rx_init_queue);
@@ -477,7 +477,7 @@ int set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t
 	return 0;
 }
 
-int get_tx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy)
+int nthw_get_tx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy)
 {
 	*init = nthw_field_get_val32(p->mp_fld_tx_init_init);
 	*queue = nthw_field_get_val32(p->mp_fld_tx_init_queue);
@@ -485,7 +485,7 @@ int get_tx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy)
 	return 0;
 }
 
-int set_rx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue)
+int nthw_set_rx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue)
 {
 	if (!p->mp_reg_rx_idle)
 		return -ENOTSUP;
@@ -496,7 +496,7 @@ int set_rx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue)
 	return 0;
 }
 
-int get_rx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy)
+int nthw_get_rx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy)
 {
 	if (!p->mp_reg_rx_idle)
 		return -ENOTSUP;
@@ -507,7 +507,7 @@ int get_rx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy)
 	return 0;
 }
 
-int set_tx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue)
+int nthw_set_tx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue)
 {
 	if (!p->mp_reg_tx_idle)
 		return -ENOTSUP;
@@ -518,7 +518,7 @@ int set_tx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue)
 	return 0;
 }
 
-int get_tx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy)
+int nthw_get_tx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy)
 {
 	if (!p->mp_reg_tx_idle)
 		return -ENOTSUP;
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 0bee86c573..1455a1e508 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -147,7 +147,7 @@ static const struct {
 static_assert(RTE_DIM(err_msg) == ERR_MSG_END,
 	"The list of error messages is not fully completed.");
 
-void flow_nic_set_error(enum flow_nic_err_msg_e msg, struct rte_flow_error *error)
+void nthw_flow_nic_set_error(enum flow_nic_err_msg_e msg, struct rte_flow_error *error)
 {
 	RTE_ASSERT(msg < ERR_MSG_NO_MSG);
 
@@ -162,7 +162,7 @@ void flow_nic_set_error(enum flow_nic_err_msg_e msg, struct rte_flow_error *erro
  * Resources
  */
 
-int flow_nic_alloc_resource(struct flow_nic_dev *ndev, enum res_type_e res_type,
+int nthw_flow_nic_alloc_resource(struct flow_nic_dev *ndev, enum res_type_e res_type,
 	uint32_t alignment)
 {
 	for (unsigned int i = 0; i < ndev->res[res_type].resource_count; i += alignment) {
@@ -176,7 +176,7 @@ int flow_nic_alloc_resource(struct flow_nic_dev *ndev, enum res_type_e res_type,
 	return -1;
 }
 
-int flow_nic_alloc_resource_config(struct flow_nic_dev *ndev, enum res_type_e res_type,
+int nthw_flow_nic_alloc_resource_config(struct flow_nic_dev *ndev, enum res_type_e res_type,
 	unsigned int num, uint32_t alignment)
 {
 	unsigned int idx_offs;
@@ -204,12 +204,12 @@ int flow_nic_alloc_resource_config(struct flow_nic_dev *ndev, enum res_type_e re
 	return -1;
 }
 
-void flow_nic_free_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int idx)
+void nthw_flow_nic_free_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int idx)
 {
 	flow_nic_mark_resource_unused(ndev, res_type, idx);
 }
 
-int flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
+int nthw_flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
 {
 	NT_LOG(DBG, FILTER, "Reference resource %s idx %i (before ref cnt %i)",
 		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
@@ -222,7 +222,7 @@ int flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, i
 	return 0;
 }
 
-int flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
+int nthw_flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
 {
 	NT_LOG(DBG, FILTER, "De-reference resource %s idx %i (before ref cnt %i)",
 		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
@@ -232,7 +232,7 @@ int flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type,
 	ndev->res[res_type].ref[index]--;
 
 	if (!ndev->res[res_type].ref[index])
-		flow_nic_free_resource(ndev, res_type, index);
+		nthw_flow_nic_free_resource(ndev, res_type, index);
 
 	return !!ndev->res[res_type].ref[index];/* if 0 resource has been freed */
 }
@@ -386,7 +386,7 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 
 	/* Delete all eth-port devices created on this NIC device */
 	while (ndev->eth_base) {
-		flow_delete_eth_dev(ndev->eth_base);
+		nthw_flow_delete_eth_dev(ndev->eth_base);
 		ndev->eth_base = NULL;
 	}
 
@@ -437,7 +437,7 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 
 }
 
-int flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
+int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 {
 	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
 
@@ -633,7 +633,7 @@ static struct flow_eth_dev *flow_get_eth_dev(uint8_t adapter_no, uint8_t port_no
 	if (eth_dev) {
 		NT_LOG(DBG, FILTER, "Re-opening existing NIC port device: NIC DEV: %i Port %i",
 			adapter_no, port_no);
-		flow_delete_eth_dev(eth_dev);
+		nthw_flow_delete_eth_dev(eth_dev);
 		eth_dev = NULL;
 	}
 
@@ -728,8 +728,8 @@ static struct flow_eth_dev *flow_get_eth_dev(uint8_t adapter_no, uint8_t port_no
 	return NULL;	/* Error exit */
 }
 
-struct flow_nic_dev *flow_api_create(uint8_t adapter_no, const struct flow_api_backend_ops *be_if,
-	void *be_dev)
+struct flow_nic_dev *nthw_flow_api_create(uint8_t adapter_no,
+	const struct flow_api_backend_ops *be_if, void *be_dev)
 {
 	(void)adapter_no;
 
@@ -752,7 +752,7 @@ struct flow_nic_dev *flow_api_create(uint8_t adapter_no, const struct flow_api_b
 	 */
 	be_if->set_debug_mode(be_dev, FLOW_BACKEND_DEBUG_MODE_NONE);
 
-	if (flow_api_backend_init(&ndev->be, be_if, be_dev) != 0)
+	if (nthw_flow_api_backend_init(&ndev->be, be_if, be_dev) != 0)
 		goto err_exit;
 
 	ndev->adapter_no = adapter_no;
@@ -831,13 +831,13 @@ struct flow_nic_dev *flow_api_create(uint8_t adapter_no, const struct flow_api_b
 err_exit:
 
 	if (ndev)
-		flow_api_done(ndev);
+		nthw_flow_api_done(ndev);
 
 	NT_LOG(DBG, FILTER, "ERR: %s", __func__);
 	return NULL;
 }
 
-int flow_api_done(struct flow_nic_dev *ndev)
+int nthw_flow_api_done(struct flow_nic_dev *ndev)
 {
 	NT_LOG(DBG, FILTER, "FLOW API DONE");
 
@@ -848,7 +848,7 @@ int flow_api_done(struct flow_nic_dev *ndev)
 		for (int i = 0; i < RES_COUNT; i++)
 			done_resource_elements(ndev, i);
 
-		flow_api_backend_done(&ndev->be);
+		nthw_flow_api_backend_done(&ndev->be);
 		list_remove_flow_nic(ndev);
 		free(ndev);
 	}
@@ -856,7 +856,7 @@ int flow_api_done(struct flow_nic_dev *ndev)
 	return 0;
 }
 
-void *flow_api_get_be_dev(struct flow_nic_dev *ndev)
+void *nthw_flow_api_get_be_dev(struct flow_nic_dev *ndev)
 {
 	if (!ndev) {
 		NT_LOG(DBG, FILTER, "ERR: %s", __func__);
@@ -1213,7 +1213,7 @@ static int flow_async_destroy(struct flow_eth_dev *dev, uint32_t queue_id,
 	return profile_inline_ops->flow_async_destroy_profile_inline(dev, queue_id, op_attr, flow,
 			user_data, error);
 }
-int flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
+int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 {
 	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
 
@@ -1226,7 +1226,7 @@ int flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 	return -1;
 }
 
-int flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count)
+int nthw_flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count)
 {
 	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
 
@@ -1242,8 +1242,8 @@ int flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_c
 }
 
 static const struct flow_filter_ops ops = {
-	.flow_filter_init = flow_filter_init,
-	.flow_filter_done = flow_filter_done,
+	.nthw_flow_filter_init = nthw_flow_filter_init,
+	.nthw_flow_filter_done = nthw_flow_filter_done,
 	/*
 	 * Device Management API
 	 */
@@ -1256,8 +1256,8 @@ static const struct flow_filter_ops ops = {
 	.flow_flush = flow_flush,
 	.flow_actions_update = flow_actions_update,
 	.flow_dev_dump = flow_dev_dump,
-	.flow_get_flm_stats = flow_get_flm_stats,
-	.flow_get_ifr_stats = flow_get_ifr_stats,
+	.nthw_flow_get_flm_stats = nthw_flow_get_flm_stats,
+	.nthw_flow_get_ifr_stats = nthw_flow_get_ifr_stats,
 	.flow_get_aged_flows = flow_get_aged_flows,
 
 	/*
@@ -1280,7 +1280,7 @@ static const struct flow_filter_ops ops = {
 	 .hw_mod_hsh_rcp_flush = hw_mod_hsh_rcp_flush,
 };
 
-void init_flow_filter(void)
+void nthw_init_flow_filter(void)
 {
 	register_flow_filter_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h b/drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h
index eeb070c569..656751bbf4 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h
@@ -12,9 +12,9 @@
 /*
  * Flow capable NIC backend - creating flow api instance for adapter nr (backend)
  */
-struct flow_nic_dev *flow_api_create(uint8_t adapter_no, const struct flow_api_backend_ops *be_if,
-	void *be_dev);
-int flow_api_done(struct flow_nic_dev *dev);
-void *flow_api_get_be_dev(struct flow_nic_dev *dev);
+struct flow_nic_dev *nthw_flow_api_create(uint8_t adapter_no,
+	const struct flow_api_backend_ops *be_if, void *be_dev);
+int nthw_flow_api_done(struct flow_nic_dev *dev);
+void *nthw_flow_api_get_be_dev(struct flow_nic_dev *dev);
 
 #endif  /* __FLOW_API_NIC_SETUP_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
index 64ef5b345a..360cbc155a 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
@@ -65,7 +65,7 @@ static struct backend_dev_s {
 			mod##_nthw_set_debug_mode((inst), 0);                                     \
 	} while (0)
 
-const struct flow_api_backend_ops *bin_flow_backend_init(nthw_fpga_t *p_fpga, void **be_dev);
+const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpga, void **be_dev);
 static void bin_flow_backend_done(void *be_dev);
 
 static int set_debug_mode(void *be_dev, enum debug_mode_e mode)
@@ -2097,7 +2097,7 @@ const struct flow_api_backend_ops flow_be_iface = {
 	tpe_csu_rcp_flush,
 };
 
-const struct flow_api_backend_ops *bin_flow_backend_init(nthw_fpga_t *p_fpga, void **dev)
+const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpga, void **dev)
 {
 	uint8_t physical_adapter_no = (uint8_t)p_fpga->p_fpga_info->adapter_no;
 
@@ -2271,11 +2271,11 @@ static void bin_flow_backend_done(void *dev)
 }
 
 static const struct flow_backend_ops ops = {
-	.bin_flow_backend_init = bin_flow_backend_init,
+	.nthw_bin_flow_backend_init = nthw_bin_flow_backend_init,
 	.bin_flow_backend_done = bin_flow_backend_done,
 };
 
-void flow_backend_init(void)
+void nthw_flow_backend_init(void)
 {
 	register_flow_backend_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_filter.c b/drivers/net/ntnic/nthw/flow_api/flow_filter.c
index 9704109454..a4a95746e8 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_filter.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_filter.c
@@ -7,7 +7,7 @@
 #include "ntnic_mod_reg.h"
 #include "flow_api_nic_setup.h"
 
-int flow_filter_init(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device, int adapter_no)
+int nthw_flow_filter_init(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device, int adapter_no)
 {
 	void *be_dev = NULL;
 	struct flow_nic_dev *flow_nic;
@@ -21,9 +21,9 @@ int flow_filter_init(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device, i
 
 	NT_LOG(DBG, FILTER, "Initializing flow filter api");
 	const struct flow_api_backend_ops *iface =
-		flow_backend_ops->bin_flow_backend_init(p_fpga, &be_dev);
+		flow_backend_ops->nthw_bin_flow_backend_init(p_fpga, &be_dev);
 
-	flow_nic = flow_api_create((uint8_t)adapter_no, iface, be_dev);
+	flow_nic = nthw_flow_api_create((uint8_t)adapter_no, iface, be_dev);
 
 	if (!flow_nic) {
 		*p_flow_device = NULL;
@@ -34,11 +34,11 @@ int flow_filter_init(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device, i
 	return 0;
 }
 
-int flow_filter_done(struct flow_nic_dev *dev)
+int nthw_flow_filter_done(struct flow_nic_dev *dev)
 {
-	void *be_dev = flow_api_get_be_dev(dev);
+	void *be_dev = nthw_flow_api_get_be_dev(dev);
 
-	int res = flow_api_done(dev);
+	int res = nthw_flow_api_done(dev);
 
 	if (be_dev) {
 		const struct flow_backend_ops *flow_backend_ops = get_flow_backend_ops();
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_group.c b/drivers/net/ntnic/nthw/flow_api/flow_group.c
index d1fa0193e1..6e010c1b9e 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_group.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_group.c
@@ -25,7 +25,7 @@ struct group_handle_s {
 	struct group_lookup_entry_s *lookup_entries;
 };
 
-int flow_group_handle_create(void **handle, uint32_t group_count)
+int nthw_flow_group_handle_create(void **handle, uint32_t group_count)
 {
 	struct group_handle_s *group_handle;
 
@@ -40,7 +40,7 @@ int flow_group_handle_create(void **handle, uint32_t group_count)
 	return *handle != NULL ? 0 : -1;
 }
 
-int flow_group_handle_destroy(void **handle)
+int nthw_flow_group_handle_destroy(void **handle)
 {
 	if (*handle) {
 		struct group_handle_s *group_handle = (struct group_handle_s *)*handle;
@@ -55,8 +55,8 @@ int flow_group_handle_destroy(void **handle)
 	return 0;
 }
 
-int flow_group_translate_get(void *handle, uint8_t owner_id, uint8_t port_id, uint32_t group_in,
-	uint32_t *group_out)
+int nthw_flow_group_translate_get(void *handle, uint8_t owner_id, uint8_t port_id,
+	uint32_t group_in, uint32_t *group_out)
 {
 	struct group_handle_s *group_handle = (struct group_handle_s *)handle;
 	uint32_t *table_ptr;
@@ -100,7 +100,7 @@ int flow_group_translate_get(void *handle, uint8_t owner_id, uint8_t port_id, ui
 	return 0;
 }
 
-int flow_group_translate_get_orig_group(void *handle, uint32_t translated_group,
+int nthw_flow_group_translate_get_orig_group(void *handle, uint32_t translated_group,
 	uint32_t *group_orig)
 {
 	struct group_handle_s *group_handle = (struct group_handle_s *)handle;
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hasher.c b/drivers/net/ntnic/nthw/flow_api/flow_hasher.c
index 86dfc16e79..b5945831c8 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hasher.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hasher.c
@@ -126,7 +126,7 @@ static uint32_t calc16(const uint32_t key[16])
 	return x;
 }
 
-uint32_t gethash(struct hasher_s *hsh, const uint32_t key[16], int *result)
+uint32_t nthw_gethash(struct hasher_s *hsh, const uint32_t key[16], int *result)
 {
 	uint64_t val;
 	uint32_t res;
@@ -145,7 +145,7 @@ uint32_t gethash(struct hasher_s *hsh, const uint32_t key[16], int *result)
 	return res;
 }
 
-int init_hasher(struct hasher_s *hsh, int banks, int nb_records)
+int nthw_init_hasher(struct hasher_s *hsh, int banks, int nb_records)
 {
 	hsh->banks = banks;
 	hsh->cam_records_bw = (int)(log2(nb_records - 1) + 1);
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hasher.h b/drivers/net/ntnic/nthw/flow_api/flow_hasher.h
index 15de8e9933..631a12a8d9 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hasher.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hasher.h
@@ -15,7 +15,7 @@ struct hasher_s {
 	int cam_bw;
 };
 
-int init_hasher(struct hasher_s *hsh, int _banks, int nb_records);
-uint32_t gethash(struct hasher_s *hsh, const uint32_t key[16], int *result);
+int nthw_init_hasher(struct hasher_s *hsh, int _banks, int nb_records);
+uint32_t nthw_gethash(struct hasher_s *hsh, const uint32_t key[16], int *result);
 
 #endif	/* _FLOW_HASHER_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_km.c b/drivers/net/ntnic/nthw/flow_api/flow_km.c
index 5f6b5f98a9..e7ba07d7db 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_km.c
@@ -93,7 +93,7 @@ void km_attach_ndev_resource_management(struct km_flow_def_s *km, void **handle)
 		(struct tcam_distrib_s *)((char *)km->cam_dist + CAM_ENTRIES + sizeof(uint32_t));
 
 	km->hsh = (struct hasher_s *)((char *)km->tcam_dist + TCAM_ENTRIES);
-	init_hasher(km->hsh, km->be->km.nb_cam_banks, km->be->km.nb_cam_records);
+	nthw_init_hasher(km->hsh, km->be->km.nb_cam_banks, km->be->km.nb_cam_records);
 }
 
 void km_free_ndev_resource_management(void **handle)
@@ -859,7 +859,7 @@ static int km_write_data_to_cam(struct km_flow_def_s *km)
 	RTE_ASSERT(km->cam_dist);
 
 	/* word list without info set */
-	gethash(km->hsh, km->entry_word, val);
+	nthw_gethash(km->hsh, km->entry_word, val);
 
 	for (uint32_t i = 0; i < km->be->km.nb_cam_banks; i++) {
 		/* if paired we start always on an even address - reset bit 0 */
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
index fbc53a3e30..299b9b913a 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
@@ -32,7 +32,7 @@ static const struct {
 };
 #define MOD_COUNT (ARRAY_SIZE(module))
 
-void *callocate_mod(struct common_func_s *mod, int sets, ...)
+void *nthw_callocate_mod(struct common_func_s *mod, int sets, ...)
 {
 #define MAX_SETS 38
 	void *base = NULL;
@@ -84,12 +84,12 @@ void *callocate_mod(struct common_func_s *mod, int sets, ...)
 	return base;
 }
 
-void zero_module_cache(struct common_func_s *mod)
+void nthw_zero_module_cache(struct common_func_s *mod)
 {
 	memset(mod->base, 0, mod->alloced_size);
 }
 
-int flow_api_backend_init(struct flow_api_backend_s *dev,
+int nthw_flow_api_backend_init(struct flow_api_backend_s *dev,
 	const struct flow_api_backend_ops *iface,
 	void *be_dev)
 {
@@ -121,7 +121,7 @@ int flow_api_backend_init(struct flow_api_backend_s *dev,
 			FILTER,
 			"ERROR: Initialization of NIC module failed : [ %s ]",
 			module[mod].name);
-		flow_api_backend_done(dev);
+		nthw_flow_api_backend_done(dev);
 		NT_LOG(ERR,
 			FILTER,
 			"*************** Failed to create Binary Flow API *******************");
@@ -137,7 +137,7 @@ int flow_api_backend_init(struct flow_api_backend_s *dev,
 	return 0;
 }
 
-int flow_api_backend_done(struct flow_api_backend_s *dev)
+int nthw_flow_api_backend_done(struct flow_api_backend_s *dev)
 {
 	for (unsigned int mod = 0; mod < MOD_COUNT; mod++)
 		module[mod].free(dev);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
index 985c821312..abe09bfad2 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
@@ -110,7 +110,7 @@ int hw_mod_cat_alloc(struct flow_api_backend_s *be)
 	case 18:
 		be->cat.cts_num = 11;
 
-		if (!callocate_mod((struct common_func_s *)&be->cat, 12, &be->cat.v18.cfn,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->cat, 12, &be->cat.v18.cfn,
 				be->cat.nb_cat_funcs, sizeof(struct cat_v18_cfn_s),
 				&be->cat.v18.kce, (be->cat.nb_cat_funcs / 8),
 				sizeof(struct cat_v18_kce_s), &be->cat.v18.kcs,
@@ -140,7 +140,7 @@ int hw_mod_cat_alloc(struct flow_api_backend_s *be)
 	case 21:
 		be->cat.cts_num = 11;
 
-		if (!callocate_mod((struct common_func_s *)&be->cat, 12, &be->cat.v21.cfn,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->cat, 12, &be->cat.v21.cfn,
 				be->cat.nb_cat_funcs, sizeof(struct cat_v21_cfn_s),
 				&be->cat.v21.kce, (be->cat.nb_cat_funcs / 8),
 				sizeof(struct cat_v21_kce_s), &be->cat.v21.kcs,
@@ -233,7 +233,7 @@ static int cfn_reset(struct flow_api_backend_s *be, int i)
 int hw_mod_cat_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
-	zero_module_cache((struct common_func_s *)(&be->cat));
+	nthw_zero_module_cache((struct common_func_s *)(&be->cat));
 
 	NT_LOG(DBG, FILTER, "INIT CAT CFN");
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
index 5cf8264909..69dec801f2 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
@@ -106,7 +106,8 @@ int hw_mod_flm_alloc(struct flow_api_backend_s *be)
 
 	switch (_VER_) {
 	case 25:
-		if (!callocate_mod((struct common_func_s *)&be->flm, 38, &be->flm.v25.control, 1,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->flm, 38,
+				&be->flm.v25.control, 1,
 				sizeof(struct flm_v25_control_s), &be->flm.v25.status, 1,
 				sizeof(struct flm_v25_status_s), &be->flm.v25.load_bin, 1,
 				sizeof(struct flm_v25_load_bin_s), &be->flm.v25.load_pps, 1,
@@ -175,7 +176,7 @@ void hw_mod_flm_free(struct flow_api_backend_s *be)
 int hw_mod_flm_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
-	zero_module_cache((struct common_func_s *)(&be->flm));
+	nthw_zero_module_cache((struct common_func_s *)(&be->flm));
 
 	NT_LOG(DBG, FILTER, "INIT FLM");
 	hw_mod_flm_control_set(be, HW_FLM_CONTROL_SPLIT_SDRAM_USAGE, 0x10);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
index d19e72e323..9821247ebb 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
@@ -45,7 +45,7 @@ int hw_mod_hsh_alloc(struct flow_api_backend_s *be)
 
 	switch (_VER_) {
 	case 5:
-		if (!callocate_mod((struct common_func_s *)&be->hsh, 1, &be->hsh.v5.rcp,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->hsh, 1, &be->hsh.v5.rcp,
 				be->hsh.nb_rcp, sizeof(struct hsh_v5_rcp_s)))
 			return -1;
 
@@ -71,7 +71,7 @@ void hw_mod_hsh_free(struct flow_api_backend_s *be)
 int hw_mod_hsh_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
-	zero_module_cache((struct common_func_s *)(&be->hsh));
+	nthw_zero_module_cache((struct common_func_s *)(&be->hsh));
 
 	NT_LOG(DBG, FILTER, "INIT HSH RCP");
 	return hw_mod_hsh_rcp_flush(be, 0, be->hsh.nb_rcp);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
index b8a30671c3..e1c97f62f5 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
@@ -84,7 +84,7 @@ int hw_mod_km_alloc(struct flow_api_backend_s *be)
 		be->km.nb_km_rcp_mask_a_word_size = 12;
 		be->km.nb_km_rcp_mask_b_word_size = 6;
 
-		if (!callocate_mod((struct common_func_s *)&be->km, 5, &be->km.v7.rcp,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->km, 5, &be->km.v7.rcp,
 				be->km.nb_categories, sizeof(struct km_v7_rcp_s),
 				&be->km.v7.cam, be->km.nb_cam_banks * be->km.nb_cam_records,
 				sizeof(struct km_v7_cam_s), &be->km.v7.tcam,
@@ -119,7 +119,7 @@ int hw_mod_km_reset(struct flow_api_backend_s *be)
 	uint32_t tcam_v_set[3] = { 0x00000000, 0x00000000, 0x00000000 };
 
 	/* Zero entire cache area */
-	zero_module_cache((struct common_func_s *)(&be->km));
+	nthw_zero_module_cache((struct common_func_s *)(&be->km));
 
 	NT_LOG(DBG, FILTER, "INIT KM RCP");
 	hw_mod_km_rcp_flush(be, 0, ALL_ENTRIES);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
index 147a06ac2b..4e8bd73d90 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
@@ -34,7 +34,7 @@ int hw_mod_pdb_alloc(struct flow_api_backend_s *be)
 
 	switch (_VER_) {
 	case 9:
-		if (!callocate_mod((struct common_func_s *)&be->pdb, 2, &be->pdb.v9.rcp,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->pdb, 2, &be->pdb.v9.rcp,
 				be->pdb.nb_pdb_rcp_categories, sizeof(struct pdb_v9_rcp_s),
 				&be->pdb.v9.config, 1, sizeof(struct pdb_v9_config_s)))
 			return -1;
@@ -62,7 +62,7 @@ int hw_mod_pdb_reset(struct flow_api_backend_s *be)
 {
 	int err = 0;
 	/* Zero entire cache area */
-	zero_module_cache((struct common_func_s *)(&be->hsh));
+	nthw_zero_module_cache((struct common_func_s *)(&be->hsh));
 
 	NT_LOG(DBG, FILTER, "INIT PDB RCP");
 	err |= hw_mod_pdb_rcp_flush(be, 0, ALL_ENTRIES);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
index 70fe97a298..261cb84dc2 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
@@ -45,7 +45,7 @@ int hw_mod_qsl_alloc(struct flow_api_backend_s *be)
 
 	switch (_VER_) {
 	case 7:
-		if (!callocate_mod((struct common_func_s *)&be->qsl, 4, &be->qsl.v7.rcp,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->qsl, 4, &be->qsl.v7.rcp,
 				be->qsl.nb_rcp_categories, sizeof(struct qsl_v7_rcp_s),
 				&be->qsl.v7.qst, be->qsl.nb_qst_entries,
 				sizeof(struct qsl_v7_qst_s), &be->qsl.v7.qen, QSL_QEN_ENTRIES,
@@ -75,7 +75,7 @@ void hw_mod_qsl_free(struct flow_api_backend_s *be)
 int hw_mod_qsl_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
-	zero_module_cache((struct common_func_s *)(&be->qsl));
+	nthw_zero_module_cache((struct common_func_s *)(&be->qsl));
 
 	NT_LOG(DBG, FILTER, "INIT QSL RCP");
 	hw_mod_qsl_rcp_flush(be, 0, ALL_ENTRIES);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
index 30e5e38690..4741a2e310 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
@@ -23,7 +23,7 @@ int hw_mod_slc_lr_alloc(struct flow_api_backend_s *be)
 
 	switch (_VER_) {
 	case 2:
-		if (!callocate_mod((struct common_func_s *)&be->slc_lr, 1, &be->slc_lr.v2.rcp,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->slc_lr, 1, &be->slc_lr.v2.rcp,
 				be->max_categories, sizeof(struct slc_lr_v2_rcp_s)))
 			return -1;
 
@@ -48,7 +48,7 @@ void hw_mod_slc_lr_free(struct flow_api_backend_s *be)
 int hw_mod_slc_lr_reset(struct flow_api_backend_s *be)
 {
 	/* Zero entire cache area */
-	zero_module_cache((struct common_func_s *)(&be->slc_lr));
+	nthw_zero_module_cache((struct common_func_s *)(&be->slc_lr));
 
 	NT_LOG(DBG, FILTER, "INIT SLC LR RCP");
 	return hw_mod_slc_lr_rcp_flush(be, 0, be->max_categories);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
index 0df5b9cf00..b2915efce5 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
@@ -69,7 +69,7 @@ int hw_mod_tpe_alloc(struct flow_api_backend_s *be)
 
 	switch (_VER_) {
 	case 3:
-		if (!callocate_mod((struct common_func_s *)&be->tpe, 11, &be->tpe.v3.rpp_rcp,
+		if (!nthw_callocate_mod((struct common_func_s *)&be->tpe, 11, &be->tpe.v3.rpp_rcp,
 				be->tpe.nb_rcp_categories, sizeof(struct tpe_v1_rpp_v0_rcp_s),
 				&be->tpe.v3.rpp_ifr_rcp, be->tpe.nb_ifr_categories,
 				sizeof(struct tpe_v2_rpp_v1_ifr_rcp_s), &be->tpe.v3.ifr_rcp,
@@ -120,7 +120,7 @@ int hw_mod_tpe_reset(struct flow_api_backend_s *be)
 	int err = 0;
 
 	/* Zero entire cache area */
-	zero_module_cache((struct common_func_s *)(&be->tpe));
+	nthw_zero_module_cache((struct common_func_s *)(&be->tpe));
 
 	NT_LOG(DBG, FILTER, "INIT TPE");
 	err |= hw_mod_tpe_rpp_rcp_flush(be, 0, ALL_ENTRIES);
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
index 3e00a78277..42da580235 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
@@ -70,7 +70,7 @@ static void flm_inf_sta_queue_free(uint8_t port, uint8_t caller)
 	rte_ring_free(q);
 }
 
-void flm_inf_sta_queue_free_all(uint8_t caller)
+void nthw_flm_inf_sta_queue_free_all(uint8_t caller)
 {
 	int count = 0;
 
@@ -212,7 +212,7 @@ static struct rte_ring *flm_evt_queue_create(uint8_t port, uint8_t caller)
 	return q;
 }
 
-int flm_sta_queue_put(uint8_t port, bool remote, struct flm_status_event_s *obj)
+int nthw_flm_sta_queue_put(uint8_t port, bool remote, struct flm_status_event_s *obj)
 {
 	struct rte_ring **stat_q = remote ? stat_q_remote : stat_q_local;
 
@@ -232,7 +232,7 @@ int flm_sta_queue_put(uint8_t port, bool remote, struct flm_status_event_s *obj)
 	return 0;
 }
 
-void flm_inf_queue_put(uint8_t port, bool remote, struct flm_info_event_s *obj)
+void nthw_flm_inf_queue_put(uint8_t port, bool remote, struct flm_info_event_s *obj)
 {
 	int ret;
 
@@ -253,7 +253,7 @@ void flm_inf_queue_put(uint8_t port, bool remote, struct flm_info_event_s *obj)
 	}
 }
 
-int flm_inf_queue_get(uint8_t port, bool remote, struct flm_info_event_s *obj)
+int nthw_flm_inf_queue_get(uint8_t port, bool remote, struct flm_info_event_s *obj)
 {
 	int ret;
 
@@ -269,7 +269,7 @@ int flm_inf_queue_get(uint8_t port, bool remote, struct flm_info_event_s *obj)
 
 			if (flm_evt_queue_create(port, FLM_INFO_LOCAL) != NULL) {
 				/* Recursive call to get data */
-				return flm_inf_queue_get(port, remote, obj);
+				return nthw_flm_inf_queue_get(port, remote, obj);
 			}
 		}
 
@@ -283,7 +283,7 @@ int flm_inf_queue_get(uint8_t port, bool remote, struct flm_info_event_s *obj)
 
 		if (flm_evt_queue_create(port, FLM_INFO_REMOTE) != NULL) {
 			/* Recursive call to get data */
-			return flm_inf_queue_get(port, remote, obj);
+			return nthw_flm_inf_queue_get(port, remote, obj);
 		}
 	}
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
index ee8175cf25..1be02c6750 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
@@ -47,9 +47,9 @@ enum {
 #define FLM_EVT_ELEM_SIZE sizeof(struct flm_info_event_s)
 #define FLM_STAT_ELEM_SIZE sizeof(struct flm_status_event_s)
 
-void flm_inf_sta_queue_free_all(uint8_t caller);
-void flm_inf_queue_put(uint8_t port, bool remote, struct flm_info_event_s *obj);
-int flm_inf_queue_get(uint8_t port, bool remote, struct flm_info_event_s *obj);
-int flm_sta_queue_put(uint8_t port, bool remote, struct flm_status_event_s *obj);
+void nthw_flm_inf_sta_queue_free_all(uint8_t caller);
+void nthw_flm_inf_queue_put(uint8_t port, bool remote, struct flm_info_event_s *obj);
+int nthw_flm_inf_queue_get(uint8_t port, bool remote, struct flm_info_event_s *obj);
+int nthw_flm_sta_queue_put(uint8_t port, bool remote, struct flm_status_event_s *obj);
 
 #endif	/* _FLM_EVT_QUEUE_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index 278be8b180..a016c82458 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -431,7 +431,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 
 			if (data->jump) {
 				uint32_t group_orig = 0;
-				if (flow_group_translate_get_orig_group(ndev->group_handle,
+				if (nthw_flow_group_translate_get_orig_group(ndev->group_handle,
 					data->jump, &group_orig) < 0)
 					fprintf(file, "    Jumps to %d (encoded)\n", data->jump);
 				else
@@ -447,7 +447,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 
 			if (data->contains_jump) {
 				uint32_t group_orig = 0;
-				if (flow_group_translate_get_orig_group(ndev->group_handle,
+				if (nthw_flow_group_translate_get_orig_group(ndev->group_handle,
 					data->jump, &group_orig) < 0)
 					fprintf(file, "    Jumps to %d (encoded)\n", data->jump);
 
@@ -1795,7 +1795,7 @@ struct hw_db_qsl_idx hw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_ha
 		}
 	}
 
-	res = flow_nic_alloc_resource(ndev, RES_QSL_RCP, 1);
+	res = nthw_flow_nic_alloc_resource(ndev, RES_QSL_RCP, 1);
 
 	if (res < 0) {
 		qsl_idx.error = 1;
@@ -1805,10 +1805,10 @@ struct hw_db_qsl_idx hw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_ha
 	qsl_idx.ids = res & 0xff;
 
 	if (data->table_size > 0) {
-		res = flow_nic_alloc_resource_config(ndev, RES_QSL_QST, data->table_size, 1);
+		res = nthw_flow_nic_alloc_resource_config(ndev, RES_QSL_QST, data->table_size, 1);
 
 		if (res < 0) {
-			flow_nic_deref_resource(ndev, RES_QSL_RCP, qsl_idx.ids);
+			nthw_flow_nic_deref_resource(ndev, RES_QSL_RCP, qsl_idx.ids);
 			qsl_idx.error = 1;
 			return qsl_idx;
 		}
@@ -1870,7 +1870,7 @@ void hw_db_inline_qsl_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_
 	(void)db_handle;
 
 	if (!idx.error && idx.ids != 0)
-		flow_nic_ref_resource(ndev, RES_QSL_RCP, idx.ids);
+		nthw_flow_nic_ref_resource(ndev, RES_QSL_RCP, idx.ids);
 }
 
 void hw_db_inline_qsl_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_qsl_idx idx)
@@ -1880,7 +1880,7 @@ void hw_db_inline_qsl_deref(struct flow_nic_dev *ndev, void *db_handle, struct h
 	if (idx.error || idx.ids == 0)
 		return;
 
-	if (flow_nic_deref_resource(ndev, RES_QSL_RCP, idx.ids) == 0) {
+	if (nthw_flow_nic_deref_resource(ndev, RES_QSL_RCP, idx.ids) == 0) {
 		const int table_size = (int)db->qsl[idx.ids].data.table_size;
 
 		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_PRESET_ALL, idx.ids, 0x0);
@@ -1892,7 +1892,7 @@ void hw_db_inline_qsl_deref(struct flow_nic_dev *ndev, void *db_handle, struct h
 			for (int i = 0; i < (int)table_size; ++i) {
 				hw_mod_qsl_qst_set(&ndev->be, HW_QSL_QST_PRESET_ALL,
 					table_start + i, 0x0);
-				flow_nic_free_resource(ndev, RES_QSL_QST, table_start + i);
+				nthw_flow_nic_free_resource(ndev, RES_QSL_QST, table_start + i);
 			}
 
 			hw_mod_qsl_qst_flush(&ndev->be, table_start, table_size);
@@ -2245,7 +2245,7 @@ struct hw_db_tpe_ext_idx hw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, voi
 		return idx;
 	}
 
-	rpl_rpl_index = flow_nic_alloc_resource_config(ndev, RES_TPE_RPL, rpl_rpl_length, 1);
+	rpl_rpl_index = nthw_flow_nic_alloc_resource_config(ndev, RES_TPE_RPL, rpl_rpl_length, 1);
 
 	if (rpl_rpl_index < 0) {
 		idx.error = 1;
@@ -2303,7 +2303,7 @@ void hw_db_inline_tpe_ext_deref(struct flow_nic_dev *ndev, void *db_handle,
 			uint32_t rpl_zero[] = { 0, 0, 0, 0 };
 			hw_mod_tpe_rpl_rpl_set(&ndev->be, HW_TPE_RPL_RPL_VALUE, rpl_rpl_index + i,
 				rpl_zero);
-			flow_nic_free_resource(ndev, RES_TPE_RPL, rpl_rpl_index + i);
+			nthw_flow_nic_free_resource(ndev, RES_TPE_RPL, rpl_rpl_index + i);
 		}
 
 		hw_mod_tpe_rpl_rpl_flush(&ndev->be, rpl_rpl_index, rpl_rpl_length);
@@ -2900,7 +2900,7 @@ void hw_db_inline_hsh_deref(struct flow_nic_dev *ndev, void *db_handle, struct h
 			hw_mod_hsh_rcp_flush(&ndev->be, idx.ids, 1);
 
 			memset(&db->hsh[idx.ids].data, 0x0, sizeof(struct hw_db_inline_hsh_data));
-			flow_nic_free_resource(ndev, RES_HSH_RCP, idx.ids);
+			nthw_flow_nic_free_resource(ndev, RES_HSH_RCP, idx.ids);
 		}
 
 		db->hsh[idx.ids].ref = 0;
@@ -3003,7 +3003,7 @@ void hw_db_inline_scrub_deref(struct flow_nic_dev *ndev, void *db_handle,
 
 			memset(&db->scrub[idx.ids].data, 0x0,
 				sizeof(struct hw_db_inline_scrub_data));
-			flow_nic_free_resource(ndev, RES_SCRUB_RCP, idx.ids);
+			nthw_flow_nic_free_resource(ndev, RES_SCRUB_RCP, idx.ids);
 		}
 
 		db->scrub[idx.ids].ref = 0;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 1e2836de68..6824b35463 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -466,7 +466,7 @@ static void flm_mtr_read_inf_records(struct flow_eth_dev *dev, uint32_t *data, u
 					stat_data.id = mtr_id;
 					stat_data.timestamp = inf_data->ts;
 					stat_data.cause = inf_data->cause;
-					flm_inf_queue_put(port, remote_caller, &stat_data);
+					nthw_flm_inf_queue_put(port, remote_caller, &stat_data);
 				}
 			}
 
@@ -527,7 +527,7 @@ static void flm_mtr_read_sta_records(struct flow_eth_dev *dev, uint32_t *data, u
 				.learn_failed = sta_data->lfs,
 			};
 
-			flm_sta_queue_put(port, remote_caller, &data);
+			nthw_flm_sta_queue_put(port, remote_caller, &data);
 		}
 	}
 }
@@ -1075,7 +1075,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 	*num_queues = 0;
 
 	if (action == NULL) {
-		flow_nic_set_error(ERR_FAILED, error);
+		nthw_flow_nic_set_error(ERR_FAILED, error);
 		NT_LOG(ERR, FILTER, "Flow actions missing");
 		return -1;
 	}
@@ -1100,7 +1100,8 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 				if (*num_dest_port > 0) {
 					NT_LOG(ERR, FILTER,
 						"Multiple port_id actions for one flow is not supported");
-					flow_nic_set_error(ERR_ACTION_MULTIPLE_PORT_ID_UNSUPPORTED,
+					nthw_flow_nic_set_error(
+						ERR_ACTION_MULTIPLE_PORT_ID_UNSUPPORTED,
 						error);
 					return -1;
 				}
@@ -1109,13 +1110,13 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 
 				if (fd->dst_num_avail == MAX_OUTPUT_DEST) {
 					NT_LOG(ERR, FILTER, "Too many output destinations");
-					flow_nic_set_error(ERR_OUTPUT_TOO_MANY, error);
+					nthw_flow_nic_set_error(ERR_OUTPUT_TOO_MANY, error);
 					return -1;
 				}
 
 				if (port >= dev->ndev->be.num_phy_ports) {
 					NT_LOG(ERR, FILTER, "Phy port out of range");
-					flow_nic_set_error(ERR_OUTPUT_INVALID, error);
+					nthw_flow_nic_set_error(ERR_OUTPUT_INVALID, error);
 					return -1;
 				}
 
@@ -1181,7 +1182,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					NT_LOG(ERR, FILTER,
 						"ERROR: RSS hash key length %u exceeds maximum value %u",
 						rss->key_len, MAX_RSS_KEY_LEN);
-					flow_nic_set_error(ERR_RSS_TOO_LONG_KEY, error);
+					nthw_flow_nic_set_error(ERR_RSS_TOO_LONG_KEY, error);
 					return -1;
 				}
 
@@ -1269,7 +1270,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					NT_LOG(ERR, FILTER,
 						"ERROR: - Number of METER actions exceeds %d.",
 						MAX_FLM_MTRS_SUPPORTED);
-					flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+					nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 					return -1;
 				}
 
@@ -1293,7 +1294,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 				if (encap_decap_order != 1) {
 					NT_LOG(ERR, FILTER,
 						"ERROR: - RAW_ENCAP must follow RAW_DECAP.");
-					flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+					nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 					return -1;
 				}
 
@@ -1301,7 +1302,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					encap->item_count < 2) {
 					NT_LOG(ERR, FILTER,
 						"ERROR: - RAW_ENCAP data/size invalid.");
-					flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+					nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 					return -1;
 				}
 
@@ -1396,7 +1397,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					NT_LOG(ERR, FILTER,
 						"ERROR: - Encapsulation with %d vlans not supported.",
 						(int)fd->tun_hdr.nb_vlans);
-					flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+					nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 					return -1;
 				}
 
@@ -1425,14 +1426,14 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 				if (encap_decap_order != 0) {
 					NT_LOG(ERR, FILTER,
 						"ERROR: - RAW_ENCAP must follow RAW_DECAP.");
-					flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+					nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 					return -1;
 				}
 
 				if (decap->item_count < 2) {
 					NT_LOG(ERR, FILTER,
 						"ERROR: - RAW_DECAP must decap something.");
-					flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+					nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 					return -1;
 				}
 
@@ -1489,14 +1490,14 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 				if (modify_field->src.field != RTE_FLOW_FIELD_VALUE) {
 					NT_LOG(ERR, FILTER,
 						"MODIFY_FIELD only src type VALUE is supported.");
-					flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+					nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 					return -1;
 				}
 
 				if (modify_field->dst.level > 2) {
 					NT_LOG(ERR, FILTER,
 						"MODIFY_FIELD only dst level 0, 1, and 2 is supported.");
-					flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+					nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 					return -1;
 				}
 
@@ -1505,14 +1506,16 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					if (modify_field->operation != RTE_FLOW_MODIFY_SUB) {
 						NT_LOG(ERR, FILTER,
 							"MODIFY_FIELD only operation SUB is supported for TTL/HOPLIMIT.");
-						flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+						nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED,
+							error);
 						return -1;
 					}
 
 					if (fd->ttl_sub_enable) {
 						NT_LOG(ERR, FILTER,
 							"MODIFY_FIELD TTL/HOPLIMIT resource already in use.");
-						flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+						nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED,
+							error);
 						return -1;
 					}
 
@@ -1527,7 +1530,8 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					if (modify_field->operation != RTE_FLOW_MODIFY_SET) {
 						NT_LOG(ERR, FILTER,
 							"MODIFY_FIELD only operation SET is supported in general.");
-						flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+						nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED,
+							error);
 						return -1;
 					}
 
@@ -1536,7 +1540,8 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 						NT_LOG(ERR, FILTER,
 							"MODIFY_FIELD exceeded maximum of %u MODIFY_FIELD actions.",
 							dev->ndev->be.tpe.nb_cpy_writers);
-						flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+						nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED,
+							error);
 						return -1;
 					}
 
@@ -1626,7 +1631,8 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					default:
 						NT_LOG(ERR, FILTER,
 							"MODIFY_FIELD dst type is not supported.");
-						flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+						nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED,
+							error);
 						return -1;
 					}
 
@@ -1636,7 +1642,8 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					if (modify_field_use_flag & modify_field_use_flags) {
 						NT_LOG(ERR, FILTER,
 							"MODIFY_FIELD dst type hardware resource already used.");
-						flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+						nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED,
+							error);
 						return -1;
 					}
 
@@ -1675,7 +1682,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 		default:
 			NT_LOG(ERR, FILTER, "Invalid or unsupported flow action received - %i",
 				action[aidx].type);
-			flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
+			nthw_flow_nic_set_error(ERR_ACTION_UNSUPPORTED, error);
 			return -1;
 		}
 	}
@@ -1710,7 +1717,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 	memset(key_def, 0x0, sizeof(struct flm_flow_key_def_s));
 
 	if (elem == NULL) {
-		flow_nic_set_error(ERR_FAILED, error);
+		nthw_flow_nic_set_error(ERR_FAILED, error);
 		NT_LOG(ERR, FILTER, "Flow items missing");
 		return -1;
 	}
@@ -1774,7 +1781,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 
 	if (qw_free < 0) {
 		NT_LOG(ERR, FILTER, "Key size too big. Out of QW resources.");
-		flow_nic_set_error(ERR_FAILED, error);
+		nthw_flow_nic_set_error(ERR_FAILED, error);
 		return -1;
 	}
 
@@ -1798,7 +1805,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 				if (any_count > 0) {
 					NT_LOG(ERR, FILTER,
 						"Tunneled L2 ethernet not supported");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -1815,7 +1822,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					if (qw_counter >= 2) {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 
@@ -1884,7 +1891,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					if (sw_counter >= 2) {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 
@@ -1925,7 +1932,8 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 				if (implicit_vlan_vid > 0) {
 					NT_LOG(ERR, FILTER,
 						"Multiple VLANs not supported for implicit VLAN patterns.");
-					flow_nic_set_error(ERR_MATCH_INVALID_OR_UNSUPPORTED_ELEM,
+					nthw_flow_nic_set_error(
+						ERR_MATCH_INVALID_OR_UNSUPPORTED_ELEM,
 						error);
 					return -1;
 				}
@@ -1977,7 +1985,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 				} else {
 					NT_LOG(ERR, FILTER,
 						"Key size too big. Out of SW-QW resources.");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2014,7 +2022,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					ipv4_mask->hdr.hdr_checksum != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested IPv4 field not support by running SW version.");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2041,7 +2049,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					if (qw_counter >= 2) {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of QW resources.");
-						flow_nic_set_error(ERR_FAILED,
+						nthw_flow_nic_set_error(ERR_FAILED,
 							error);
 						return -1;
 					}
@@ -2080,7 +2088,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					if (sw_counter >= 2) {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 
@@ -2101,7 +2109,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					if (sw_counter >= 2) {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 
@@ -2122,7 +2130,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					if (sw_counter >= 2) {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 
@@ -2171,7 +2179,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					ipv6_mask->hdr.hop_limits != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested IPv6 field not support by running SW version");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2179,7 +2187,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					if (qw_counter >= 2) {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 
@@ -2215,7 +2223,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					if (qw_counter >= 2) {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 
@@ -2292,7 +2300,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					} else {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 				}
@@ -2330,7 +2338,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					udp_mask->hdr.dgram_cksum != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested UDP field not support by running SW version");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2384,7 +2392,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					} else {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 				}
@@ -2424,7 +2432,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 				if (sctp_mask->hdr.tag != 0 || sctp_mask->hdr.cksum != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested SCTP field not support by running SW version");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2478,7 +2486,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					} else {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 				}
@@ -2522,7 +2530,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					icmp_mask->hdr.icmp_seq_nb != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested ICMP field not supported by running SW version");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2577,7 +2585,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					} else {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 				}
@@ -2621,7 +2629,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 				if (icmp_mask->checksum != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested ICMP6 field not supported by running SW version");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2676,7 +2684,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					} else {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 				}
@@ -2724,7 +2732,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					tcp_mask->hdr.tcp_urp != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested TCP field not support by running SW version");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2778,7 +2786,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					} else {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 				}
@@ -2813,7 +2821,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					gtp_mask->msg_type != 0 || gtp_mask->plen != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested GTP field not support by running SW version");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2869,7 +2877,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					} else {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 				}
@@ -2897,7 +2905,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					gtp_psc_mask->ext_hdr_len != 0) {
 					NT_LOG(ERR, FILTER,
 						"Requested GTP PSC field is not supported by running SW version");
-					flow_nic_set_error(ERR_FAILED, error);
+					nthw_flow_nic_set_error(ERR_FAILED, error);
 					return -1;
 				}
 
@@ -2953,7 +2961,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					} else {
 						NT_LOG(ERR, FILTER,
 							"Key size too big. Out of SW-QW resources.");
-						flow_nic_set_error(ERR_FAILED, error);
+						nthw_flow_nic_set_error(ERR_FAILED, error);
 						return -1;
 					}
 				}
@@ -2982,7 +2990,7 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 		default:
 			NT_LOG(ERR, FILTER, "Invalid or unsupported flow request: %d",
 				(int)elem[eidx].type);
-			flow_nic_set_error(ERR_MATCH_INVALID_OR_UNSUPPORTED_ELEM, error);
+			nthw_flow_nic_set_error(ERR_MATCH_INVALID_OR_UNSUPPORTED_ELEM, error);
 			return -1;
 		}
 	}
@@ -3266,7 +3274,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	if (cot_idx.error) {
 		NT_LOG(ERR, FILTER, "Could not reference COT resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		return -1;
 	}
 
@@ -3277,7 +3285,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	if (qsl_idx.error) {
 		NT_LOG(ERR, FILTER, "Could not reference QSL resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		return -1;
 	}
 
@@ -3288,7 +3296,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	if (hsh_idx.error) {
 		NT_LOG(ERR, FILTER, "Could not reference HSH resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		return -1;
 	}
 
@@ -3307,7 +3315,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 		if (slc_lr_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference SLC LR resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			return -1;
 		}
 	}
@@ -3330,7 +3338,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 		if (tpe_ext_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference TPE EXT resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			return -1;
 		}
 
@@ -3394,7 +3402,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	if (tpe_idx.error) {
 		NT_LOG(ERR, FILTER, "Could not reference TPE resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		return -1;
 	}
 
@@ -3406,7 +3414,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	if (scrub_idx.error) {
 		NT_LOG(ERR, FILTER, "Could not reference FLM SCRUB resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		return -1;
 	}
 
@@ -3429,7 +3437,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	if (action_set_idx.error) {
 		NT_LOG(ERR, FILTER, "Could not reference Action Set resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		return -1;
 	}
 
@@ -3446,7 +3454,7 @@ static int setup_flow_flm_actions(struct flow_eth_dev *dev,
 
 	if (flm_ft_idx.error) {
 		NT_LOG(ERR, FILTER, "Could not reference FLM FT resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		return -1;
 	}
 
@@ -3517,7 +3525,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 		if (flm_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference FLM RPC resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 
@@ -3535,7 +3543,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 		/* Program flow */
 		if (convert_fh_to_fh_flm(fh, packet_data, flm_idx.id1 + 2, flm_ft, flm_rpl_ext_ptr,
 				flm_scrub, attr->priority & 0x3) != 0) {
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 		flm_flow_programming(fh, NT_FLM_OP_LEARN);
@@ -3553,7 +3561,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 		/* SCRUB/AGE action is not supported for group 0 */
 		if (fd->age.timeout != 0 || fd->age.context != NULL) {
 			NT_LOG(ERR, FILTER, "Action AGE is not supported for flow in group 0");
-			flow_nic_set_error(ERR_ACTION_AGE_UNSUPPORTED_GROUP_0, error);
+			nthw_flow_nic_set_error(ERR_ACTION_AGE_UNSUPPORTED_GROUP_0, error);
 			goto error_out;
 		}
 
@@ -3575,7 +3583,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			/* Group 0 supports only modify action for TTL/Hop limit. */
 			if (fd->modify_field_count > 0) {
 				NT_LOG(ERR, FILTER, "Unsupported MODIFY ACTION for group 0");
-				flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+				nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 				goto error_out;
 			}
 
@@ -3592,7 +3600,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 			if (cot_idx.error) {
 				NT_LOG(ERR, FILTER, "Could not reference COT resource");
-				flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+				nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 				goto error_out;
 			}
 
@@ -3605,7 +3613,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 			if (qsl_idx.error) {
 				NT_LOG(ERR, FILTER, "Could not reference QSL resource");
-				flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+				nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 				goto error_out;
 			}
 
@@ -3618,7 +3626,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 			if (hsh_idx.error) {
 				NT_LOG(ERR, FILTER, "Could not reference HSH resource");
-				flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+				nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 				goto error_out;
 			}
 
@@ -3641,7 +3649,8 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 				if (tpe_idx.error) {
 					NT_LOG(ERR, FILTER, "Could not reference TPE resource");
-					flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+					nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION,
+						error);
 					goto error_out;
 				}
 			}
@@ -3655,7 +3664,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 		if (action_set_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference Action Set resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 
@@ -3686,7 +3695,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 		if (cat_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference CAT resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 
@@ -3698,7 +3707,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 			if (km_key_create(&fd->km, fh->port_id)) {
 				NT_LOG(ERR, FILTER, "KM creation failed");
-				flow_nic_set_error(ERR_MATCH_FAILED_BY_HW_LIMITS, error);
+				nthw_flow_nic_set_error(ERR_MATCH_FAILED_BY_HW_LIMITS, error);
 				goto error_out;
 			}
 
@@ -3738,23 +3747,26 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 					found_flow->flm_db_idx_counter);
 
 				if (other_km_rcp_data == NULL ||
-					flow_nic_ref_resource(dev->ndev, RES_KM_CATEGORY,
+					nthw_flow_nic_ref_resource(dev->ndev, RES_KM_CATEGORY,
 					other_km_rcp_data->rcp)) {
 					NT_LOG(ERR, FILTER,
 						"Could not reference existing KM RCP resource");
-					flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+					nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION,
+						error);
 					goto error_out;
 				}
 
 				km_rcp_data.rcp = other_km_rcp_data->rcp;
 			} else {
 				/* Alloc new KM RCP */
-				int rcp = flow_nic_alloc_resource(dev->ndev, RES_KM_CATEGORY, 1);
+				int rcp = nthw_flow_nic_alloc_resource(dev->ndev,
+					RES_KM_CATEGORY, 1);
 
 				if (rcp < 0) {
 					NT_LOG(ERR, FILTER,
 						"Could not reference KM RCP resource (flow_nic_alloc)");
-					flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+					nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION,
+						error);
 					goto error_out;
 				}
 
@@ -3770,7 +3782,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 		if (km_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference KM RCP resource (db_inline)");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 
@@ -3786,7 +3798,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 		if (km_ft_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference KM FT resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 
@@ -3795,7 +3807,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			if (identical_km_entry_ft >= 0 && identical_km_entry_ft != km_ft_idx.id1) {
 				NT_LOG(ERR, FILTER,
 					"Identical KM matches cannot have different KM FTs");
-				flow_nic_set_error(ERR_MATCH_FAILED_BY_HW_LIMITS, error);
+				nthw_flow_nic_set_error(ERR_MATCH_FAILED_BY_HW_LIMITS, error);
 				goto error_out;
 			}
 
@@ -3831,7 +3843,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 		if (match_set_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference Match Set resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 
@@ -3848,7 +3860,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 
 		if (flm_ft_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference FLM FT resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 
@@ -4054,7 +4066,7 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 		flm_shared_stats->size = FLM_MTR_STAT_SIZE;
 		flm_shared_stats->shared = UINT8_MAX;
 
-		if (flow_group_handle_create(&ndev->group_handle, ndev->be.flm.nb_categories))
+		if (nthw_flow_group_handle_create(&ndev->group_handle, ndev->be.flm.nb_categories))
 			goto err_exit0;
 
 		if (hw_db_inline_create(ndev, &ndev->hw_db_handle))
@@ -4079,14 +4091,14 @@ int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 	if (ndev->flow_mgnt_prepared) {
 		flm_sdram_reset(ndev, 0);
 
-		flow_nic_free_resource(ndev, RES_KM_FLOW_TYPE, 0);
-		flow_nic_free_resource(ndev, RES_KM_CATEGORY, 0);
+		nthw_flow_nic_free_resource(ndev, RES_KM_FLOW_TYPE, 0);
+		nthw_flow_nic_free_resource(ndev, RES_KM_CATEGORY, 0);
 
 		hw_mod_flm_rcp_set(&ndev->be, HW_FLM_RCP_PRESET_ALL, 0, 0);
 		hw_mod_flm_rcp_flush(&ndev->be, 0, 1);
-		flow_nic_free_resource(ndev, RES_FLM_FLOW_TYPE, 0);
-		flow_nic_free_resource(ndev, RES_FLM_FLOW_TYPE, 1);
-		flow_nic_free_resource(ndev, RES_FLM_RCP, 0);
+		nthw_flow_nic_free_resource(ndev, RES_FLM_FLOW_TYPE, 0);
+		nthw_flow_nic_free_resource(ndev, RES_FLM_FLOW_TYPE, 1);
+		nthw_flow_nic_free_resource(ndev, RES_FLM_RCP, 0);
 
 		for (uint32_t i = 0; i < UINT8_MAX; ++i) {
 			struct flm_flow_mtr_handle_s *handle = ndev->flm_mtr_handle;
@@ -4100,39 +4112,39 @@ int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 
 		free(ndev->flm_mtr_handle);
 
-		flow_group_handle_destroy(&ndev->group_handle);
+		nthw_flow_group_handle_destroy(&ndev->group_handle);
 		ntnic_id_table_destroy(ndev->id_table_handle);
 
 		hw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PRESET_ALL, 0, 0, 0);
 		hw_mod_cat_cfn_flush(&ndev->be, 0, 1);
 		hw_mod_cat_cot_set(&ndev->be, HW_CAT_COT_PRESET_ALL, 0, 0);
 		hw_mod_cat_cot_flush(&ndev->be, 0, 1);
-		flow_nic_free_resource(ndev, RES_CAT_CFN, 0);
+		nthw_flow_nic_free_resource(ndev, RES_CAT_CFN, 0);
 
 		hw_mod_qsl_rcp_set(&ndev->be, HW_QSL_RCP_PRESET_ALL, 0, 0);
 		hw_mod_qsl_rcp_flush(&ndev->be, 0, 1);
-		flow_nic_free_resource(ndev, RES_QSL_RCP, 0);
+		nthw_flow_nic_free_resource(ndev, RES_QSL_RCP, 0);
 
 		hw_mod_slc_lr_rcp_set(&ndev->be, HW_SLC_LR_RCP_PRESET_ALL, 0, 0);
 		hw_mod_slc_lr_rcp_flush(&ndev->be, 0, 1);
-		flow_nic_free_resource(ndev, RES_SLC_LR_RCP, 0);
+		nthw_flow_nic_free_resource(ndev, RES_SLC_LR_RCP, 0);
 
 		hw_mod_tpe_reset(&ndev->be);
-		flow_nic_free_resource(ndev, RES_TPE_RCP, 0);
-		flow_nic_free_resource(ndev, RES_TPE_EXT, 0);
-		flow_nic_free_resource(ndev, RES_TPE_RPL, 0);
+		nthw_flow_nic_free_resource(ndev, RES_TPE_RCP, 0);
+		nthw_flow_nic_free_resource(ndev, RES_TPE_EXT, 0);
+		nthw_flow_nic_free_resource(ndev, RES_TPE_RPL, 0);
 
 		hw_mod_pdb_rcp_set(&ndev->be, HW_PDB_RCP_PRESET_ALL, 0, 0);
 		hw_mod_pdb_rcp_flush(&ndev->be, 0, 1);
-		flow_nic_free_resource(ndev, RES_PDB_RCP, 0);
+		nthw_flow_nic_free_resource(ndev, RES_PDB_RCP, 0);
 
 		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, 0, 0, 0);
 		hw_mod_hsh_rcp_flush(&ndev->be, 0, 1);
-		flow_nic_free_resource(ndev, RES_HSH_RCP, 0);
+		nthw_flow_nic_free_resource(ndev, RES_HSH_RCP, 0);
 
 		hw_mod_flm_scrub_set(&ndev->be, HW_FLM_SCRUB_PRESET_ALL, 0, 0);
 		hw_mod_flm_scrub_flush(&ndev->be, 0, 1);
-		flow_nic_free_resource(ndev, RES_SCRUB_RCP, 0);
+		nthw_flow_nic_free_resource(ndev, RES_SCRUB_RCP, 0);
 
 		hw_db_inline_destroy(ndev->hw_db_handle);
 
@@ -4173,7 +4185,7 @@ struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev __rte_un
 	if (attr_local.group > 0)
 		forced_vlan_vid_local = 0;
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	struct nic_flow_def *fd = allocate_nic_flow_def();
 
@@ -4195,18 +4207,18 @@ struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev __rte_un
 
 	/* Translate group IDs */
 	if (fd->jump_to_group != UINT32_MAX &&
-		flow_group_translate_get(dev->ndev->group_handle, caller_id_local, dev->port,
+		nthw_flow_group_translate_get(dev->ndev->group_handle, caller_id_local, dev->port,
 		fd->jump_to_group, &fd->jump_to_group)) {
 		NT_LOG(ERR, FILTER, "ERROR: Could not get group resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		goto err_exit;
 	}
 
 	if (attr_local.group > 0 &&
-		flow_group_translate_get(dev->ndev->group_handle, caller_id_local, dev->port,
+		nthw_flow_group_translate_get(dev->ndev->group_handle, caller_id_local, dev->port,
 		attr_local.group, &attr_local.group)) {
 		NT_LOG(ERR, FILTER, "ERROR: Could not get group resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		goto err_exit;
 	}
 
@@ -4255,7 +4267,7 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 
 	int err = 0;
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	/* take flow out of ndev list - may not have been put there yet */
 	if (fh->type == FLOW_HANDLE_TYPE_FLM)
@@ -4289,7 +4301,7 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 				fh->flm_db_idx_counter);
 
 			if (other_km_rcp_data != NULL &&
-				flow_nic_deref_resource(dev->ndev, RES_KM_CATEGORY,
+				nthw_flow_nic_deref_resource(dev->ndev, RES_KM_CATEGORY,
 				(int)other_km_rcp_data->rcp) == 0) {
 				hw_mod_km_rcp_set(&dev->ndev->be, HW_KM_RCP_PRESET_ALL,
 					(int)other_km_rcp_data->rcp, 0, 0);
@@ -4306,7 +4318,7 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 
 	if (err) {
 		NT_LOG(ERR, FILTER, "FAILED removing flow: %p", fh);
-		flow_nic_set_error(ERR_REMOVE_FLOW_FAILED, error);
+		nthw_flow_nic_set_error(ERR_REMOVE_FLOW_FAILED, error);
 	}
 
 	free(fh);
@@ -4327,7 +4339,7 @@ int flow_destroy_profile_inline(struct flow_eth_dev *dev, struct flow_handle *fl
 	if (flow && flow->type == FLOW_HANDLE_TYPE_FLM && flow->flm_async)
 		return flow_async_destroy_profile_inline(dev, 0, NULL, flow, NULL, error);
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	if (flow) {
 		/* Delete this flow */
@@ -4345,7 +4357,7 @@ int flow_flush_profile_inline(struct flow_eth_dev *dev,
 {
 	int err = 0;
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	/*
 	 * Delete all created FLM flows from this eth device.
@@ -4394,12 +4406,12 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 
 	int group = (int)flow->flm_kid - 2;
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	if (flow->type != FLOW_HANDLE_TYPE_FLM) {
 		NT_LOG(ERR, FILTER,
 			"Flow actions update not supported for group 0 or default flows");
-		flow_nic_set_error(ERR_MATCH_INVALID_OR_UNSUPPORTED_ELEM, error);
+		nthw_flow_nic_set_error(ERR_MATCH_INVALID_OR_UNSUPPORTED_ELEM, error);
 		return -1;
 	}
 
@@ -4447,7 +4459,7 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 
 		if (flm_data == NULL) {
 			NT_LOG(ERR, FILTER, "Could not retrieve FLM RPC resource");
-			flow_nic_set_error(ERR_MATCH_INVALID_OR_UNSUPPORTED_ELEM, error);
+			nthw_flow_nic_set_error(ERR_MATCH_INVALID_OR_UNSUPPORTED_ELEM, error);
 			goto error_out;
 		}
 
@@ -4458,7 +4470,7 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 
 		if (flm_idx.error) {
 			NT_LOG(ERR, FILTER, "Could not reference FLM RPC resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			goto error_out;
 		}
 
@@ -4559,7 +4571,7 @@ int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	struct rte_flow_error *error)
 {
 	(void)dev;
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	unsigned int queue_size = flm_age_queue_get_size(caller_id);
 
@@ -4607,7 +4619,7 @@ int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 	FILE *file,
 	struct rte_flow_error *error)
 {
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	rte_spinlock_lock(&dev->ndev->mtx);
 
@@ -4802,7 +4814,7 @@ int flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	(void)caller_id;
 	int res = 0;
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 	memset(port_info, 0, sizeof(struct rte_flow_port_info));
 
 	port_info->max_nb_aging_objects = dev->nb_aging_objects;
@@ -4824,7 +4836,7 @@ int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	(void)queue_attr;
 	int res = 0;
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	if (port_attr->nb_aging_objects > 0) {
 		if (dev->nb_aging_objects > 0) {
@@ -4903,7 +4915,7 @@ struct flow_pattern_template *flow_pattern_template_create_profile_inline(struct
 
 	struct nic_flow_def *fd = allocate_nic_flow_def();
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	if (fd == NULL) {
 		error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
@@ -4932,7 +4944,7 @@ int flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct rte_flow_error *error)
 {
 	(void)dev;
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	free(pattern_template->fd);
 	free(pattern_template);
@@ -4955,7 +4967,7 @@ flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 
 	struct nic_flow_def *fd = allocate_nic_flow_def();
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	if (fd == NULL) {
 		error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
@@ -4973,13 +4985,13 @@ flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 	/* Translate group IDs */
 	if (fd->jump_to_group != UINT32_MAX) {
 		rte_spinlock_lock(&dev->ndev->mtx);
-		res = flow_group_translate_get(dev->ndev->group_handle, caller_id,
+		res = nthw_flow_group_translate_get(dev->ndev->group_handle, caller_id,
 				dev->port, fd->jump_to_group, &fd->jump_to_group);
 		rte_spinlock_unlock(&dev->ndev->mtx);
 
 		if (res) {
 			NT_LOG(ERR, FILTER, "ERROR: Could not get group resource");
-			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 			free(fd);
 			return NULL;
 		}
@@ -4999,7 +5011,7 @@ int flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct rte_flow_error *error)
 {
 	(void)dev;
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	free(actions_template->fd);
 	free(actions_template);
@@ -5014,7 +5026,7 @@ struct flow_template_table *flow_template_table_create_profile_inline(struct flo
 	struct flow_actions_template *actions_templates[], uint8_t nb_actions_templates,
 	struct rte_flow_error *error)
 {
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	struct flow_template_table *template_table = calloc(1, sizeof(struct flow_template_table));
 
@@ -5055,14 +5067,14 @@ struct flow_template_table *flow_template_table_create_profile_inline(struct flo
 
 	rte_spinlock_lock(&dev->ndev->mtx);
 	int res =
-		flow_group_translate_get(dev->ndev->group_handle, caller_id, dev->port,
+		nthw_flow_group_translate_get(dev->ndev->group_handle, caller_id, dev->port,
 			template_table->attr.group, &template_table->attr.group);
 	rte_spinlock_unlock(&dev->ndev->mtx);
 
 	/* Translate group IDs */
 	if (res) {
 		NT_LOG(ERR, FILTER, "ERROR: Could not get group resource");
-		flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+		nthw_flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
 		goto error_out;
 	}
 
@@ -5084,7 +5096,7 @@ int flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_template_table *template_table,
 	struct rte_flow_error *error)
 {
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	const uint32_t nb_cells =
 		template_table->nb_pattern_templates * template_table->nb_actions_templates;
@@ -5139,7 +5151,7 @@ struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
 	uint32_t packet_mask[10];
 	struct flm_flow_key_def_s key_def;
 
-	flow_nic_set_error(ERR_SUCCESS, error);
+	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	struct nic_flow_def *fd = malloc(sizeof(struct nic_flow_def));
 
@@ -5324,7 +5336,7 @@ int flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_i
 
 	if (flm_flow_programming(flow, NT_FLM_OP_UNLEARN)) {
 		NT_LOG(ERR, FILTER, "FAILED to destroy flow: %p", flow);
-		flow_nic_set_error(ERR_REMOVE_FLOW_FAILED, error);
+		nthw_flow_nic_set_error(ERR_REMOVE_FLOW_FAILED, error);
 		return -1;
 	}
 
diff --git a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
index 33593927a4..66cc02a865 100644
--- a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
+++ b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
@@ -476,7 +476,7 @@ static struct meter_ops_s meter_ops = {
 	.eth_mtr_ops_get = eth_mtr_ops_get,
 };
 
-void meter_init(void)
+void nthw_meter_init(void)
 {
 	NT_LOG(DBG, NTNIC, "Meter ops initialized");
 	register_meter_ops(&meter_ops);
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 4cdc49abc8..9a6667b3be 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1439,9 +1439,9 @@ drv_deinit(struct drv_s *p_drv)
 		profile_inline_ops->flm_free_queues();
 		THREAD_JOIN(p_nt_drv->port_event_thread);
 		/* Free all local flm event queues */
-		flm_inf_sta_queue_free_all(FLM_INFO_LOCAL);
+		nthw_flm_inf_sta_queue_free_all(FLM_INFO_LOCAL);
 		/* Free all remote flm event queues */
-		flm_inf_sta_queue_free_all(FLM_INFO_REMOTE);
+		nthw_flm_inf_sta_queue_free_all(FLM_INFO_REMOTE);
 		/* Free all aged flow event queues */
 		flm_age_queue_free_all();
 	}
@@ -1824,7 +1824,7 @@ THREAD_FUNC port_event_thread_fn(void *context)
 				/* Local FLM statistic events */
 				struct flm_info_event_s data;
 
-				if (flm_inf_queue_get(port_no, FLM_INFO_LOCAL, &data) == 0) {
+				if (nthw_flm_inf_queue_get(port_no, FLM_INFO_LOCAL, &data) == 0) {
 					if (eth_dev && eth_dev->data &&
 						eth_dev->data->dev_private) {
 						struct ntnic_flm_statistic_s event_data;
@@ -2072,7 +2072,8 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 
 		if (kvargs_count != 0) {
 			RTE_ASSERT(kvargs_count == 1);
-			res = rte_kvargs_process(kvlist, ETH_DEV_NTHW_RXQUEUES_ARG, &string_to_u32,
+			res = rte_kvargs_process(kvlist, ETH_DEV_NTHW_RXQUEUES_ARG,
+					&nthw_string_to_u32,
 					&nb_rx_queues);
 
 			if (res < 0) {
@@ -2096,7 +2097,8 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 
 		if (kvargs_count != 0) {
 			RTE_ASSERT(kvargs_count == 1);
-			res = rte_kvargs_process(kvlist, ETH_DEV_NTHW_TXQUEUES_ARG, &string_to_u32,
+			res = rte_kvargs_process(kvlist, ETH_DEV_NTHW_TXQUEUES_ARG,
+					&nthw_string_to_u32,
 					&nb_tx_queues);
 
 			if (res < 0) {
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index f548421ce3..1beba22b9d 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -28,7 +28,7 @@ static struct rte_flow nt_flows[MAX_RTE_FLOWS];
 rte_spinlock_t flow_lock = RTE_SPINLOCK_INITIALIZER;
 static struct rte_flow nt_flows[MAX_RTE_FLOWS];
 
-int interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_flow_item *out)
+int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_flow_item *out)
 {
 	int hdri = 0;
 	int pkti = 0;
@@ -246,7 +246,7 @@ int interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_fl
 	return hdri + 1;
 }
 
-int create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr)
+int nthw_create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr)
 {
 	memset(&attribute->attr, 0x0, sizeof(struct rte_flow_attr));
 
@@ -258,7 +258,7 @@ int create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr)
 	return 0;
 }
 
-int create_match_elements(struct cnv_match_s *match, const struct rte_flow_item items[],
+int nthw_create_match_elements(struct cnv_match_s *match, const struct rte_flow_item items[],
 	int max_elem)
 {
 	int eidx = 0;
@@ -308,7 +308,7 @@ int create_match_elements(struct cnv_match_s *match, const struct rte_flow_item
 	return (type >= 0) ? 0 : -1;
 }
 
-int create_action_elements_inline(struct cnv_action_s *action,
+int nthw_create_action_elements_inline(struct cnv_action_s *action,
 	const struct rte_flow_action actions[],
 	int max_elem,
 	uint32_t queue_offset)
@@ -402,8 +402,8 @@ int create_action_elements_inline(struct cnv_action_s *action,
 				const struct rte_flow_action_raw_decap *decap =
 					(const struct rte_flow_action_raw_decap *)actions[aidx]
 					.conf;
-				int item_count = interpret_raw_data(decap->data, NULL, decap->size,
-					action->decap.items);
+				int item_count = nthw_interpret_raw_data(decap->data, NULL,
+					decap->size, action->decap.items);
 
 				if (item_count < 0)
 					return item_count;
@@ -418,8 +418,8 @@ int create_action_elements_inline(struct cnv_action_s *action,
 				const struct rte_flow_action_raw_encap *encap =
 					(const struct rte_flow_action_raw_encap *)actions[aidx]
 					.conf;
-				int item_count = interpret_raw_data(encap->data, encap->preserve,
-					encap->size, action->encap.items);
+				int item_count = nthw_interpret_raw_data(encap->data,
+					encap->preserve, encap->size, action->encap.items);
 
 				if (item_count < 0)
 					return item_count;
@@ -499,19 +499,19 @@ static int convert_flow(struct rte_eth_dev *eth_dev,
 		queue_offset = internals->vpq[0].id;
 	}
 
-	if (create_attr(attribute, attr) != 0) {
+	if (nthw_create_attr(attribute, attr) != 0) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR, NULL, "Error in attr");
 		return -1;
 	}
 
-	if (create_match_elements(match, items, MAX_ELEMENTS) != 0) {
+	if (nthw_create_match_elements(match, items, MAX_ELEMENTS) != 0) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
 			"Error in items");
 		return -1;
 	}
 
 	if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
-		if (create_action_elements_inline(action, actions,
+		if (nthw_create_action_elements_inline(action, actions,
 			MAX_ACTIONS, queue_offset) != 0) {
 			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 				"Error in actions");
@@ -716,7 +716,7 @@ static int eth_flow_actions_update(struct rte_eth_dev *eth_dev,
 				queue_offset = dev_private->vpq[0].id;
 			}
 
-			if (create_action_elements_inline(&action, actions, MAX_ACTIONS,
+			if (nthw_create_action_elements_inline(&action, actions, MAX_ACTIONS,
 					queue_offset) != 0) {
 				rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 					"Error in actions");
@@ -873,7 +873,7 @@ static struct rte_flow_pattern_template *eth_flow_pattern_template_create(struct
 
 	uint16_t caller_id = get_caller_id(dev->data->port_id);
 
-	if (create_match_elements(&match, pattern, MAX_ELEMENTS) != 0) {
+	if (nthw_create_match_elements(&match, pattern, MAX_ELEMENTS) != 0) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
 			"Error in pattern");
 		return NULL;
@@ -943,14 +943,16 @@ static struct rte_flow_actions_template *eth_flow_actions_template_create(struct
 		if (internals->type == PORT_TYPE_OVERRIDE && internals->vpq_nb_vq > 0)
 			queue_offset = internals->vpq[0].id;
 
-		if (create_action_elements_inline(&action, actions, MAX_ACTIONS, queue_offset) !=
-			0) {
+		if (nthw_create_action_elements_inline(&action, actions,
+				MAX_ACTIONS,
+				queue_offset) != 0) {
 			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 				"Error in actions");
 			return NULL;
 		}
 
-		if (create_action_elements_inline(&mask, masks, MAX_ACTIONS, queue_offset) != 0) {
+		if (nthw_create_action_elements_inline(&mask, masks,
+				MAX_ACTIONS, queue_offset) != 0) {
 			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 				"Error in masks");
 			return NULL;
@@ -1081,7 +1083,7 @@ static struct rte_flow *eth_flow_async_create(struct rte_eth_dev *dev, uint32_t
 	struct cnv_action_s action = { 0 };
 	struct cnv_match_s match = { 0 };
 
-	if (create_match_elements(&match, pattern, MAX_ELEMENTS) != 0) {
+	if (nthw_create_match_elements(&match, pattern, MAX_ELEMENTS) != 0) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
 			"Error in pattern");
 		return NULL;
@@ -1093,8 +1095,8 @@ static struct rte_flow *eth_flow_async_create(struct rte_eth_dev *dev, uint32_t
 		if (internals->type == PORT_TYPE_OVERRIDE && internals->vpq_nb_vq > 0)
 			queue_offset = internals->vpq[0].id;
 
-		if (create_action_elements_inline(&action, actions, MAX_ACTIONS, queue_offset) !=
-			0) {
+		if (nthw_create_action_elements_inline(&action, actions,
+				MAX_ACTIONS, queue_offset) != 0) {
 			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 				"Error in actions");
 			return NULL;
@@ -1285,7 +1287,7 @@ static const struct rte_flow_ops dev_flow_ops = {
 	.template_table_destroy = eth_flow_template_table_destroy,
 };
 
-void dev_flow_init(void)
+void nthw_dev_flow_init(void)
 {
 	register_dev_flow_ops(&dev_flow_ops);
 }
@@ -1295,7 +1297,7 @@ static struct rte_flow_fp_ops async_dev_flow_ops = {
 	.async_destroy = eth_flow_async_destroy,
 };
 
-void dev_fp_flow_init(void)
+void nthw_dev_fp_flow_init(void)
 {
 	register_dev_fp_flow_ops(&async_dev_flow_ops);
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 054b343fe7..8dc6e48182 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -15,7 +15,7 @@ void register_sg_ops(struct sg_ops_s *ops)
 const struct sg_ops_s *get_sg_ops(void)
 {
 	if (sg_ops == NULL)
-		sg_init();
+		nthw_sg_init();
 	return sg_ops;
 }
 
@@ -32,7 +32,7 @@ void register_meter_ops(struct meter_ops_s *ops)
 const struct meter_ops_s *get_meter_ops(void)
 {
 	if (meter_ops == NULL)
-		meter_init();
+		nthw_meter_init();
 
 	return meter_ops;
 }
@@ -65,7 +65,7 @@ void register_100g_link_ops(struct link_ops_s *ops)
 const struct link_ops_s *get_100g_link_ops(void)
 {
 	if (link_100g_ops == NULL)
-		link_100g_init();
+		nthw_link_100g_init();
 	return link_100g_ops;
 }
 
@@ -96,7 +96,7 @@ void register_port_ops(const struct port_ops *ops)
 const struct port_ops *get_port_ops(void)
 {
 	if (port_ops == NULL)
-		port_init();
+		nthw_port_init();
 	return port_ops;
 }
 
@@ -125,7 +125,7 @@ void register_adapter_ops(const struct adapter_ops *ops)
 const struct adapter_ops *get_adapter_ops(void)
 {
 	if (adapter_ops == NULL)
-		adapter_init();
+		nthw_adapter_init();
 	return adapter_ops;
 }
 
@@ -211,7 +211,7 @@ struct rst_nt400dxx_ops *get_rst_nt400dxx_ops(void)
 const struct flow_backend_ops *get_flow_backend_ops(void)
 {
 	if (flow_backend_ops == NULL)
-		flow_backend_init();
+		nthw_flow_backend_init();
 
 	return flow_backend_ops;
 }
@@ -241,7 +241,7 @@ void register_flow_filter_ops(const struct flow_filter_ops *ops)
 const struct flow_filter_ops *get_flow_filter_ops(void)
 {
 	if (flow_filter_ops == NULL)
-		init_flow_filter();
+		nthw_init_flow_filter();
 
 	return flow_filter_ops;
 }
@@ -256,7 +256,7 @@ void register_dev_fp_flow_ops(const struct rte_flow_fp_ops *ops)
 const struct rte_flow_fp_ops *get_dev_fp_flow_ops(void)
 {
 	if (dev_fp_flow_ops == NULL)
-		dev_fp_flow_init();
+		nthw_dev_fp_flow_init();
 
 	return dev_fp_flow_ops;
 }
@@ -271,7 +271,7 @@ void register_dev_flow_ops(const struct rte_flow_ops *ops)
 const struct rte_flow_ops *get_dev_flow_ops(void)
 {
 	if (dev_flow_ops == NULL)
-		dev_flow_init();
+		nthw_dev_flow_init();
 
 	return dev_flow_ops;
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 9b3650da89..9d14bebd7a 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -115,7 +115,7 @@ struct sg_ops_s {
 
 void register_sg_ops(struct sg_ops_s *ops);
 const struct sg_ops_s *get_sg_ops(void);
-void sg_init(void);
+void nthw_sg_init(void);
 
 /* Meter ops section */
 struct meter_ops_s {
@@ -124,7 +124,7 @@ struct meter_ops_s {
 
 void register_meter_ops(struct meter_ops_s *ops);
 const struct meter_ops_s *get_meter_ops(void);
-void meter_init(void);
+void nthw_meter_init(void);
 
 /*
  *
@@ -143,7 +143,7 @@ struct link_ops_s {
 
 void register_100g_link_ops(struct link_ops_s *ops);
 const struct link_ops_s *get_100g_link_ops(void);
-void link_100g_init(void);
+void nthw_link_100g_init(void);
 
 void register_agx_100g_link_ops(struct link_ops_s *ops);
 const struct link_ops_s *get_agx_100g_link_ops(void);
@@ -203,7 +203,7 @@ struct port_ops {
 
 void register_port_ops(const struct port_ops *ops);
 const struct port_ops *get_port_ops(void);
-void port_init(void);
+void nthw_port_init(void);
 
 struct nt4ga_stat_ops {
 	int (*nt4ga_stat_init)(struct adapter_info_s *p_adapter_info);
@@ -225,7 +225,7 @@ struct adapter_ops {
 
 void register_adapter_ops(const struct adapter_ops *ops);
 const struct adapter_ops *get_adapter_ops(void);
-void adapter_init(void);
+void nthw_adapter_init(void);
 
 struct clk9563_ops {
 	const int *(*get_n_data_9563_si5340_nt200a02_u23_v5)(void);
@@ -277,14 +277,14 @@ struct rst_nt400dxx_ops *get_rst_nt400dxx_ops(void);
 void rst_nt400dxx_ops_init(void);
 
 struct flow_backend_ops {
-	const struct flow_api_backend_ops *(*bin_flow_backend_init)(nthw_fpga_t *p_fpga,
+	const struct flow_api_backend_ops *(*nthw_bin_flow_backend_init)(nthw_fpga_t *p_fpga,
 		void **be_dev);
 	void (*bin_flow_backend_done)(void *be_dev);
 };
 
 void register_flow_backend_ops(const struct flow_backend_ops *ops);
 const struct flow_backend_ops *get_flow_backend_ops(void);
-void flow_backend_init(void);
+void nthw_flow_backend_init(void);
 
 struct profile_inline_ops {
 	/*
@@ -445,9 +445,9 @@ const struct profile_inline_ops *get_profile_inline_ops(void);
 void profile_inline_init(void);
 
 struct flow_filter_ops {
-	int (*flow_filter_init)(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device,
+	int (*nthw_flow_filter_init)(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device,
 		int adapter_no);
-	int (*flow_filter_done)(struct flow_nic_dev *dev);
+	int (*nthw_flow_filter_done)(struct flow_nic_dev *dev);
 	/*
 	 * Device Management API
 	 */
@@ -487,8 +487,9 @@ struct flow_filter_ops {
 		const struct rte_flow_action action[],
 		struct rte_flow_error *error);
 
-	int (*flow_get_flm_stats)(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
-	int (*flow_get_ifr_stats)(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count);
+	int (*nthw_flow_get_flm_stats)(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
+	int (*nthw_flow_get_ifr_stats)(struct flow_nic_dev *ndev, uint64_t *data,
+		uint8_t port_count);
 
 	/*
 	 * Other
@@ -554,15 +555,15 @@ struct flow_filter_ops {
 
 void register_dev_fp_flow_ops(const struct rte_flow_fp_ops *ops);
 const struct rte_flow_fp_ops *get_dev_fp_flow_ops(void);
-void dev_fp_flow_init(void);
+void nthw_dev_fp_flow_init(void);
 
 void register_dev_flow_ops(const struct rte_flow_ops *ops);
 const struct rte_flow_ops *get_dev_flow_ops(void);
-void dev_flow_init(void);
+void nthw_dev_flow_init(void);
 
 void register_flow_filter_ops(const struct flow_filter_ops *ops);
 const struct flow_filter_ops *get_flow_filter_ops(void);
-void init_flow_filter(void);
+void nthw_init_flow_filter(void);
 
 struct ntnic_xstats_ops {
 	int (*nthw_xstats_get_names)(nt4ga_stat_t *p_nt4ga_stat,
diff --git a/drivers/net/ntnic/ntutil/nt_util.c b/drivers/net/ntnic/ntutil/nt_util.c
index 38d8de4e29..df382e7a24 100644
--- a/drivers/net/ntnic/ntutil/nt_util.c
+++ b/drivers/net/ntnic/ntutil/nt_util.c
@@ -181,7 +181,7 @@ uint32_t nt_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa)
 }
 
 /* Converts link speed provided in Mbps to NT specific definitions.*/
-nt_link_speed_t convert_link_speed(int link_speed_mbps)
+nt_link_speed_t nthw_convert_link_speed(int link_speed_mbps)
 {
 	switch (link_speed_mbps) {
 	case 10:
@@ -234,7 +234,7 @@ int nt_link_duplex_to_eth_duplex(enum nt_link_duplex_e nt_link_duplex)
 	return eth_link_duplex;
 }
 
-int string_to_u32(const char *key_str __rte_unused, const char *value_str, void *extra_args)
+int nthw_string_to_u32(const char *key_str __rte_unused, const char *value_str, void *extra_args)
 {
 	if (!value_str || !extra_args)
 		return -1;
diff --git a/drivers/net/ntnic/ntutil/nt_util.h b/drivers/net/ntnic/ntutil/nt_util.h
index f2eccf3501..5be84be9c3 100644
--- a/drivers/net/ntnic/ntutil/nt_util.h
+++ b/drivers/net/ntnic/ntutil/nt_util.h
@@ -66,9 +66,9 @@ void nt_util_vfio_init(struct nt_util_vfio_impl *impl);
 
 int nt_link_speed_to_eth_speed_num(enum nt_link_speed_e nt_link_speed);
 uint32_t nt_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa);
-nt_link_speed_t convert_link_speed(int link_speed_mbps);
+nt_link_speed_t nthw_convert_link_speed(int link_speed_mbps);
 int nt_link_duplex_to_eth_duplex(enum nt_link_duplex_e nt_link_duplex);
 
-int string_to_u32(const char *key_str __rte_unused, const char *value_str, void *extra_args);
+int nthw_string_to_u32(const char *key_str __rte_unused, const char *value_str, void *extra_args);
 
 #endif	/* NTOSS_SYSTEM_NT_UTIL_H */
-- 
2.45.0

