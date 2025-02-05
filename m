Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F3CC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 039F040DDB;
	Wed,  5 Feb 2025 11:46:37 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 7D788406BC
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:24 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhkzkFb8sgeOf/ibkwuSBLpuBgwlMLXbBGoKV6fvBnZMekuMLBpjvs+bSjnmU3ZyKg4HieiWVyhKZzjrsIRhUyGkrUkt2fkTOj4Jbkz+cjuNHB6wb+3329UQY+1iN0L+1lJspmVHOwZAxqWSKe/kgxrXwoIiuQdtuwbQVxAgZPNC1OvDwHNJLBjXGiKXZMclnMBGMlEPSmobpJSk7TZAoRgU2aM2GScKGeWb+LVPiTqOb18AXdykJ9nZV2EMf0w/04Ihn9lYBlBRR+0uAVpeGP6Ja7+otT+5xAJ8xeq2fT+0gInhla2vpPBsTnZA7U6DZG+L0yPU5smTM6772Uopyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWFilX7BW7lAdqRr7iJiTyAxOUKtLFfxPoZyoYP/3Zo=;
 b=S2COmsm839BTSQ+P4dNEkbKrQQS7UgvqY/K02a/K0Tehnm6Qdah2ZEromGXCMatpwMnR6kVJ3UKJ8aAfhWUy0hro+JbYZBkUadDY7BKUfIfO4UGSP1rXHEkxwh8rKTno5vbnJ7AbGpFf88FHCfrdiMCUPHEzUIFcDhV1x09atMQuTntDJ/hGeC9kOQ+AyAmri3EaT58G2hy8anW/rzbE5v0sZNRd1l4bcgQbQhb9fV00++MFl0N5mHurjj4+fBUwC5IgLcXmdskLGm3ZIavYNfTy4bcGHcH00jwAj8fU2z0y5iT9jgCJDN2IfDzEwyt2q8PxX+iKS8DJPZ8v7S5hFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWFilX7BW7lAdqRr7iJiTyAxOUKtLFfxPoZyoYP/3Zo=;
 b=h69m6/8yNVWkI4Ojqg6YHth/x1JVcSMR/k1qQ20r2qTt4eFRLslh7m5iwOoEFl0LrtDBqiRl80hl2aIO1/PAAaEcvXMixjfH/f9dcauFKb4ef75YY80QmB2MBrRJjKy66qtXZEoqEXqJawUjIeHlG9TPuf17IuN3k1paUhL8H68=
Received: from CWLP265CA0338.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::14)
 by AM9P190MB1202.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:261::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 10:46:19 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::f3) by CWLP265CA0338.outlook.office365.com
 (2603:10a6:401:5a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:18
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 25/34] net/ntnic: refactor RSS implementation
Date: Wed,  5 Feb 2025 11:45:34 +0100
Message-ID: <20250205104548.1533554-26-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|AM9P190MB1202:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5743cdb9-2fa7-4cbf-fca6-08dd45d2528b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DdTb/FBo2ms7Wv6SmG1j1DF/gyEb6GhgtcipT5S/c6aLoPJ0I8CdZJFm30MD?=
 =?us-ascii?Q?nf6Q37PEfGySr57Ibz3GKevJ1tDTjEqHrDjhPg6GA3nYSjz/le97JYK4DeBf?=
 =?us-ascii?Q?HSKaJnaNhuDZQSHOFe33p4/fpSYT+uu+YrZ/+WmBfh0sraz9gPnCO7hz8Jyq?=
 =?us-ascii?Q?/9g+HfT5pVMHj6tw1F2OSf21s1AKefXGEJTrIx+lvTDDqp0MBSGqBz1x2FDK?=
 =?us-ascii?Q?dOMjmldh7rfxqDR7vkpuwIMkvmrs1OB7ASyuO02ONjX6AkkgWd5Q0FrQ3yqk?=
 =?us-ascii?Q?z0gC2cwkEoZh0M31dm4kBIeFEZIkJgJC5azc/3yjCdCXpltNvwXPFGxAf+w3?=
 =?us-ascii?Q?GlCLwmPaDTjYdA+V9fQefb5x9QTOouuu2n1PT5M6pklJw9MQCiTRL6nVs8Q4?=
 =?us-ascii?Q?qMgI8vqLAb2GC4cNl37AnlJjYpg16ow4yVITq8QOsn5UoUnBoXY8qdXBrWCG?=
 =?us-ascii?Q?0Z96DXIQdUBXtd/n+Xj/VMag+SUqFsxNhqCqjl+7tEEndsFNdY3lehHe52rJ?=
 =?us-ascii?Q?SYU+4uwL0zEHz4PFRSroddMmWjjByXrIBh2lx5SEqZLw7F/5qBL2hW6jK/pF?=
 =?us-ascii?Q?ruXsO26i9PiZYQBTTE00dk09G1HHFMOoC9eD4s4usUTnm98CP0fRmXJTDVJy?=
 =?us-ascii?Q?spXktXUjePvzAhH8eqr7SKV1g7M2UnfrD8MQ7Bb5nC3O+qQhNovGD3/v07p1?=
 =?us-ascii?Q?pY3r/DKFLLcoXo0oFHgYPwKD+m/VvHQwODLO3LYn5EEqjhjLtxYugMUztGDW?=
 =?us-ascii?Q?TWF7Z4GS4jehIcgPBo3PVOHGbQC7OrPWJ8uxI85RBEbT7YaNWmLugEqdLQCL?=
 =?us-ascii?Q?8oAQcavyeLNX8vFP4iO46nj4yV9aY6dKX+txiQYU8BGBsx9N+cqa1X5PepWr?=
 =?us-ascii?Q?oHkjXIdsu6JmcthKS69fYexXiIZGLFRax60SbdvIu0WMtgt7d/MJpORTC4Vx?=
 =?us-ascii?Q?ETUYYNZWXEqMJNx9i3ZcqS9+rKqFQ3ItJ+k1awxs84NX8TMKL1JUO6fiWTRT?=
 =?us-ascii?Q?6C7rRWjxp8lWsL2Rg8Bjh2A8rnGp9GcyE2EcO7pzwRnJol2XadFO9jACoVhE?=
 =?us-ascii?Q?EKIwMcSDhFtRbnloUO4NKzx7R6bBMBfQWy6SEMkMinwATodF7t/z5KnKklmj?=
 =?us-ascii?Q?fk8ynuWh1C+0tOglGWpa+/E+Ycj17T82UMfUAUEOZVIcQpft/tvgUVCGUCe2?=
 =?us-ascii?Q?8ABFd4lI73U+s1aTi8FpPor53TXPaUpl7dcaxZCFk8eG8SukXfpyNIkzZyTe?=
 =?us-ascii?Q?BfJKGaNupXD21MywFiDbz/uFJPmmRx22rIXThKjpWGgmbLmRCOeh7hsEcqzy?=
 =?us-ascii?Q?o2v6CSmtqpwR5jnIkZ18di1TUIivQxInfk7aGg/zfeQM2785efP8Mm0SbTmI?=
 =?us-ascii?Q?h5dthZbDUpPxlzZgxgLXKo7J0zRNS3IQAuHrtXYTDzzBnkgtYfYflYxeZ8dO?=
 =?us-ascii?Q?pa6XlqfS9/POuC+ZOCnWyi13BFx5KnHrw7manaMVwi/BNBWDuFeLle8+G95a?=
 =?us-ascii?Q?2dWhsprl/r4ROh4=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1SFlGIwT1bc6nxQga453H2f2NIUcUWHhrW7vegokr8Mc+dmBuT/6efvpjI/7cbDf/qEaRAh4L/e+XgEzjPqTxKy5mR2Kh/8BUOk805KrrhM5Vk8QiqXhEGcXs7Z6jbRNiI9b5aF6PAubl9EhEPsdE4z+M3kjWLmaRxtw3gLDaiYqdwVuETyxJ5wVIwl2dcJc8HRzcm5NM4A47/3rwBcu74Y8kP5LLTnbn8fbcxTjayl9PWDF2VFXYHbtyo9PmzG4EGCegj86Zg4fuBhOpXuh4cVS15iRtBWKxddqjlRVh9DPiKaQ8LbNB+AUBSERkQO2Sa+g0R92ykw61sIpc428iPSejdNJutOjBUSf5UudF4SY7s+Q5K3MwpC3YkPlzUzMlwMH2tbpn4gebxv5Fk7QInZA6wxYXefbxna0AgLG8g9R7jWWAYIkvWVLB9eUb5tg4gzOATAHBf7klBHi29VstMcX8JqAOlHxR319zfheRuYwbmxEno/uT33rze9cdHYZT/H0rrRHw7zROoeSc2seTnWFjvkBuo8al0PF7LvX+oLDQrRfToHsCZfRhVsgLD1elRv6tKgnzkrPJZkJq1dH+p1TiX2ZGPe3gFfYjv1NBlm85KfszlJlYiL60heaCtnH3UJc8XHPOAbDWFb4CfHcfQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:18.5426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5743cdb9-2fa7-4cbf-fca6-08dd45d2528b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1202
X-BESS-ID: 1738752381-306009-7776-626-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZGZhbmQGYGUNTIwsTELNHULM
 nYyNggMc0szSjRxCLZ2MQkKdnE3NAsWak2FgDnI9KSQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan10-166.eu-central-1a.ess.aws.cudaops.com]
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

Virtualization backward compatible RSS implementation is no longer
needed, thus RSS was refactored as follows:
* conversion of RTE_ETH_RSS fields into HSH registers was moved to
  separate files
* profile wrapper for RSS configuration was removed
* flow_nic_set_hasher(), to configure default 5-tuple hash, was
  replaced by call of hsh_set() with proper RTE_ETH_RSS*
  fields

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api.h          |   9 -
 drivers/net/ntnic/include/hw_mod_backend.h    |   6 -
 drivers/net/ntnic/meson.build                 |   1 +
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  63 --
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.c    | 661 +++++++++++++++
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.h    |  17 +
 .../profile_inline/flow_api_hw_db_inline.c    |   5 +-
 .../profile_inline/flow_api_profile_inline.c  | 782 +-----------------
 .../profile_inline/flow_api_profile_inline.h  |   4 -
 drivers/net/ntnic/ntnic_ethdev.c              |   3 +-
 drivers/net/ntnic/ntnic_mod_reg.h             |   6 -
 11 files changed, 695 insertions(+), 862 deletions(-)
 create mode 100644 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
 create mode 100644 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h

diff --git a/drivers/net/ntnic/include/flow_api.h b/drivers/net/ntnic/include/flow_api.h
index 0af766fe5b..9201b8a3ae 100644
--- a/drivers/net/ntnic/include/flow_api.h
+++ b/drivers/net/ntnic/include/flow_api.h
@@ -83,11 +83,6 @@ struct flow_eth_dev {
 	struct flow_eth_dev *next;
 };
 
-enum flow_nic_hash_e {
-	HASH_ALGO_ROUND_ROBIN = 0,
-	HASH_ALGO_5TUPLE,
-};
-
 /* registered NIC backends */
 struct flow_nic_dev {
 	uint8_t adapter_no;     /* physical adapter no in the host system */
@@ -234,10 +229,6 @@ void flow_nic_free_resource(struct flow_nic_dev *ndev, enum res_type_e res_type,
 int flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index);
 int flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index);
 
-int flow_nic_set_hasher(struct flow_nic_dev *ndev, int hsh_idx, enum flow_nic_hash_e algorithm);
-int flow_nic_set_hasher_fields(struct flow_nic_dev *ndev, int hsh_idx,
-	struct nt_eth_rss_conf rss_conf);
-
 int flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
 
 #endif
diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index 1941692ddf..4061d3f9e5 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -239,12 +239,6 @@ enum {
 	PROT_TUN_L4_ICMP = 4
 };
 
-
-enum {
-	HASH_HASH_NONE = 0,
-	HASH_5TUPLE = 8,
-};
-
 enum {
 	CPY_SELECT_DSCP_IPV4 = 0,
 	CPY_SELECT_DSCP_IPV6 = 1,
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 3c05ad1d87..bfc5ae5aa8 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -70,6 +70,7 @@ sources = files(
         'nthw/flow_api/flow_backend/flow_backend.c',
         'nthw/flow_api/flow_filter.c',
         'nthw/flow_api/flow_hasher.c',
+        'nthw/flow_api/flow_hsh_cfg.c',
         'nthw/flow_api/flow_kcc.c',
         'nthw/flow_api/flow_km.c',
         'nthw/flow_api/hw_mod/hw_mod_backend.c',
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index d25d1a3dd1..857051fe14 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -1009,55 +1009,6 @@ int sprint_nt_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t
 	return 0;
 }
 
-/*
- * Hash
- */
-
-int flow_nic_set_hasher(struct flow_nic_dev *ndev, int hsh_idx, enum flow_nic_hash_e algorithm)
-{
-	hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
-
-	switch (algorithm) {
-	case HASH_ALGO_5TUPLE:
-		/* need to create an IPv6 hashing and enable the adaptive ip mask bit */
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_LOAD_DIST_TYPE, hsh_idx, 0, 2);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_QW0_PE, hsh_idx, 0, DYN_FINAL_IP_DST);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_QW0_OFS, hsh_idx, 0, -16);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_QW4_PE, hsh_idx, 0, DYN_FINAL_IP_DST);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_QW4_OFS, hsh_idx, 0, 0);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_W8_PE, hsh_idx, 0, DYN_L4);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_W8_OFS, hsh_idx, 0, 0);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_W9_PE, hsh_idx, 0, 0);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_W9_OFS, hsh_idx, 0, 0);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_W9_P, hsh_idx, 0, 0);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_P_MASK, hsh_idx, 0, 1);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 0, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 1, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 2, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 3, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 4, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 5, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 6, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 7, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 8, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx, 9, 0);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_SEED, hsh_idx, 0, 0xffffffff);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_HSH_VALID, hsh_idx, 0, 1);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_HSH_TYPE, hsh_idx, 0, HASH_5TUPLE);
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_AUTO_IPV4_MASK, hsh_idx, 0, 1);
-
-		NT_LOG(DBG, FILTER, "Set IPv6 5-tuple hasher with adaptive IPv4 hashing");
-		break;
-
-	default:
-	case HASH_ALGO_ROUND_ROBIN:
-		/* zero is round-robin */
-		break;
-	}
-
-	return 0;
-}
-
 static int flow_dev_dump(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	uint16_t caller_id,
@@ -1074,19 +1025,6 @@ static int flow_dev_dump(struct flow_eth_dev *dev,
 	return profile_inline_ops->flow_dev_dump_profile_inline(dev, flow, caller_id, file, error);
 }
 
-int flow_nic_set_hasher_fields(struct flow_nic_dev *ndev, int hsh_idx,
-	struct nt_eth_rss_conf rss_conf)
-{
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
-
-	if (profile_inline_ops == NULL) {
-		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
-		return -1;
-	}
-
-	return profile_inline_ops->flow_nic_set_hasher_fields_inline(ndev, hsh_idx, rss_conf);
-}
-
 static int flow_get_aged_flows(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	void **context,
@@ -1324,7 +1262,6 @@ static const struct flow_filter_ops ops = {
 	 * Other
 	 */
 	 .hw_mod_hsh_rcp_flush = hw_mod_hsh_rcp_flush,
-	 .flow_nic_set_hasher_fields = flow_nic_set_hasher_fields,
 };
 
 void init_flow_filter(void)
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
new file mode 100644
index 0000000000..624d1a26d1
--- /dev/null
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
@@ -0,0 +1,661 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Napatech A/S
+ */
+
+#include "flow_hsh_cfg.h"
+
+#define RTE_ETH_RSS_UDP_COMBINED (RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+								  RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
+								  RTE_ETH_RSS_IPV6_UDP_EX)
+
+#define RTE_ETH_RSS_TCP_COMBINED (RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+								  RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+								  RTE_ETH_RSS_IPV6_TCP_EX)
+
+#define TOEPLITS_HSH_SIZE 9
+/*
+ * FPGA uses up to 10 32-bit words (320 bits) for hash calculation + 8 bits for L4 protocol number.
+ * Hashed data are split between two 128-bit Quad Words (QW)
+ * and two 32-bit Words (W), which can refer to different header parts.
+ */
+enum hsh_words_id {
+	HSH_WORDS_QW0     = 0,
+	HSH_WORDS_QW4,
+	HSH_WORDS_W8,
+	HSH_WORDS_W9,
+	HSH_WORDS_SIZE,
+};
+
+/* struct with details about hash QWs & Ws */
+struct hsh_words {
+	/*
+	 * index of W (word) or index of 1st word of QW (quad word)
+	 * is used for hash mask calculation
+	 */
+	uint8_t index;
+	enum hw_hsh_e pe;           /* offset to header part, e.g. beginning of L4 */
+	enum hw_hsh_e ofs;          /* relative offset in BYTES to 'pe' header offset above */
+	uint16_t bit_len;           /* max length of header part in bits to fit into QW/W */
+	bool free;                  /* only free words can be used for hsh calculation */
+};
+
+static enum hsh_words_id get_free_word(struct hsh_words *words, uint16_t bit_len)
+{
+	enum hsh_words_id ret = HSH_WORDS_SIZE;
+	uint16_t ret_bit_len = UINT16_MAX;
+	for (enum hsh_words_id i = HSH_WORDS_QW0; i < HSH_WORDS_SIZE; i++) {
+		if (words[i].free && bit_len <=
+			words[i].bit_len && words[i].bit_len <
+			ret_bit_len) {
+			ret = i;
+			ret_bit_len = words[i].bit_len;
+		}
+	}
+	return ret;
+}
+
+static int hsh_set_part(struct flow_nic_dev *ndev, int hsh_idx, struct hsh_words *words,
+	uint32_t pe, uint32_t ofs, int bit_len, bool toeplitz)
+{
+	int res = 0;
+
+	/* check if there is any free word, which can accommodate header part of given 'bit_len' */
+	enum hsh_words_id word = get_free_word(words, bit_len);
+
+	if (word == HSH_WORDS_SIZE) {
+		NT_LOG(ERR, FILTER, "Cannot add additional %d bits into hash", bit_len);
+		return -1;
+	}
+
+	words[word].free = false;
+
+	res |= hw_mod_hsh_rcp_set(&ndev->be, words[word].pe, hsh_idx, 0, pe);
+	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %d)", words[word].pe,
+		hsh_idx, pe);
+	res |= hw_mod_hsh_rcp_set(&ndev->be, words[word].ofs, hsh_idx, 0, ofs);
+	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %d)", words[word].ofs,
+		hsh_idx, ofs);
+
+
+	/* set HW_HSH_RCP_WORD_MASK based on used QW/W and given 'bit_len' */
+	int mask_bit_len = bit_len;
+	uint32_t mask = 0x0;
+	uint32_t toeplitz_mask[TOEPLITS_HSH_SIZE] = {0x0};
+	/* iterate through all words of QW */
+	uint16_t words_count = words[word].bit_len / 32;
+	for (uint16_t mask_off = 1; mask_off <= words_count; mask_off++) {
+		if (mask_bit_len >= 32) {
+			mask_bit_len -= 32;
+			mask = 0xffffffff;
+		} else if (mask_bit_len > 0) {
+			mask = 0xffffffff >> (32 - mask_bit_len) << (32 - mask_bit_len);
+			mask_bit_len = 0;
+		} else {
+			mask = 0x0;
+		}
+		/* reorder QW words mask from little to big endian */
+		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx,
+			words[word].index + words_count - mask_off, mask);
+		NT_LOG(DBG, FILTER,
+			"hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, %d, %d, 0x%08" PRIX32 ")",
+				hsh_idx, words[word].index + words_count - mask_off, mask);
+		toeplitz_mask[words[word].index + mask_off - 1] = mask;
+	}
+	if (toeplitz) {
+		NT_LOG(DBG, FILTER,
+			"Partial Toeplitz RSS key mask: %08" PRIX32 " %08" PRIX32 " %08" PRIX32
+			" %08" PRIX32 " %08" PRIX32 " %08" PRIX32 " %08" PRIX32 " %08" PRIX32
+			" %08" PRIX32 "",
+			toeplitz_mask[0], toeplitz_mask[1], toeplitz_mask[2], toeplitz_mask[3],
+			toeplitz_mask[4], toeplitz_mask[5], toeplitz_mask[6], toeplitz_mask[7],
+			toeplitz_mask[8]);
+		NT_LOG(DBG, FILTER, "                               MSB                                                                          LSB");
+	}
+	return res;
+}
+
+static __rte_always_inline bool all_bits_enabled(uint64_t hash_mask, uint64_t hash_bits)
+{
+	return (hash_mask & hash_bits) == hash_bits;
+}
+
+static __rte_always_inline void unset_bits(uint64_t *hash_mask, uint64_t hash_bits)
+{
+	*hash_mask &= ~hash_bits;
+}
+
+static __rte_always_inline void unset_bits_and_log(uint64_t *hash_mask, uint64_t hash_bits)
+{
+	char rss_buffer[4096];
+	uint16_t rss_buffer_len = sizeof(rss_buffer);
+
+	if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", *hash_mask & hash_bits) == 0)
+		NT_LOG(DBG, FILTER, "Configured RSS types:%s", rss_buffer);
+	unset_bits(hash_mask, hash_bits);
+}
+
+static __rte_always_inline void unset_bits_if_all_enabled(uint64_t *hash_mask, uint64_t hash_bits)
+{
+	if (all_bits_enabled(*hash_mask, hash_bits))
+		unset_bits(hash_mask, hash_bits);
+}
+
+int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_conf)
+{
+	uint64_t fields = rss_conf.rss_hf;
+
+	char rss_buffer[4096];
+	uint16_t rss_buffer_len = sizeof(rss_buffer);
+
+	if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", fields) == 0)
+		NT_LOG(DBG, FILTER, "Requested RSS types:%s", rss_buffer);
+
+	/*
+	 * configure all (Q)Words usable for hash calculation
+	 * Hash can be calculated from 4 independent header parts:
+	 *      | QW0           | Qw4           | W8| W9|
+	 * word | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
+	 */
+	struct hsh_words words[HSH_WORDS_SIZE] = {
+		{ 0, HW_HSH_RCP_QW0_PE, HW_HSH_RCP_QW0_OFS, 128, true },
+		{ 4, HW_HSH_RCP_QW4_PE, HW_HSH_RCP_QW4_OFS, 128, true },
+		{ 8, HW_HSH_RCP_W8_PE,  HW_HSH_RCP_W8_OFS,   32, true },
+		 /* not supported for Toeplitz */
+		{ 9, HW_HSH_RCP_W9_PE,  HW_HSH_RCP_W9_OFS,   32, true },
+	};
+
+	int res = 0;
+	res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
+	/* enable hashing */
+	res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_LOAD_DIST_TYPE, hsh_idx, 0, 2);
+
+	/* configure selected hash function and its key */
+	bool toeplitz = false;
+	switch (rss_conf.algorithm) {
+	case RTE_ETH_HASH_FUNCTION_DEFAULT:
+		/* Use default NTH10 hashing algorithm */
+		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TOEPLITZ, hsh_idx, 0, 0);
+		/* Use 1st 32-bits from rss_key to configure NTH10 SEED */
+		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_SEED, hsh_idx, 0,
+			rss_conf.rss_key[0] << 24 | rss_conf.rss_key[1] << 16 |
+				rss_conf.rss_key[2] << 8 | rss_conf.rss_key[3]);
+		break;
+	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
+		toeplitz = true;
+		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TOEPLITZ, hsh_idx, 0, 1);
+		uint8_t empty_key = 0;
+
+		/* Toeplitz key (always 40B) words have to be programmed in reverse order */
+		for (uint8_t i = 0; i <= (MAX_RSS_KEY_LEN - 4); i += 4) {
+			res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_K, hsh_idx, 9 - i / 4,
+				rss_conf.rss_key[i] << 24 | rss_conf.rss_key[i + 1] << 16 |
+				rss_conf.rss_key[i + 2] << 8 | rss_conf.rss_key[i + 3]);
+			NT_LOG(DBG, FILTER,
+				"hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_K, %d, %d, 0x%" PRIX32 ")",
+				hsh_idx, 9 - i / 4, rss_conf.rss_key[i] << 24 |
+				rss_conf.rss_key[i + 1] << 16 | rss_conf.rss_key[i + 2] << 8 |
+				rss_conf.rss_key[i + 3]);
+			empty_key |= rss_conf.rss_key[i] | rss_conf.rss_key[i + 1] |
+				rss_conf.rss_key[i + 2] | rss_conf.rss_key[i + 3];
+		}
+
+		if (empty_key == 0) {
+			NT_LOG(ERR, FILTER, "Toeplitz key must be configured. Key with all bytes set to zero is not allowed.");
+			return -1;
+		}
+		words[HSH_WORDS_W9].free = false;
+		NT_LOG(DBG, FILTER, "Toeplitz hashing is enabled thus W9 and P_MASK cannot be used.");
+		break;
+	default:
+		NT_LOG(ERR, FILTER, "Unknown hashing function %d requested", rss_conf.algorithm);
+		return -1;
+	}
+
+	/* indication that some IPv6 flag is present */
+	bool ipv6 = fields & (NT_ETH_RSS_IPV6_MASK);
+	/* store proto mask for later use at IP and L4 checksum handling */
+	uint64_t l4_proto_mask = fields &
+				(RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_NONFRAG_IPV4_UDP |
+				RTE_ETH_RSS_NONFRAG_IPV4_SCTP | RTE_ETH_RSS_NONFRAG_IPV4_OTHER |
+				RTE_ETH_RSS_NONFRAG_IPV6_TCP | RTE_ETH_RSS_NONFRAG_IPV6_UDP |
+				RTE_ETH_RSS_NONFRAG_IPV6_SCTP | RTE_ETH_RSS_NONFRAG_IPV6_OTHER |
+				RTE_ETH_RSS_IPV6_TCP_EX | RTE_ETH_RSS_IPV6_UDP_EX);
+
+	/* outermost headers are used by default, so innermost bit takes precedence if detected */
+	bool outer = (fields & RTE_ETH_RSS_LEVEL_INNERMOST) ? false : true;
+	unset_bits(&fields, RTE_ETH_RSS_LEVEL_MASK);
+
+	if (fields == 0) {
+		NT_LOG(ERR, FILTER, "RSS hash configuration 0x%" PRIX64 " is not valid.",
+			rss_conf.rss_hf);
+		return -1;
+	}
+
+	/* indication that IPv4 `protocol` or IPv6 `next header` fields shall be part of the hash */
+	bool l4_proto_hash = false;
+
+	/*
+	 * check if SRC_ONLY & DST_ONLY are used simultaneously;
+	 * According to DPDK, we shall behave like none of these bits is set
+	 */
+	unset_bits_if_all_enabled(&fields, RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY);
+	unset_bits_if_all_enabled(&fields, RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY);
+	unset_bits_if_all_enabled(&fields, RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY);
+
+	/* L2 */
+	if (fields & (RTE_ETH_RSS_ETH | RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY)) {
+		if (outer) {
+			if (fields & RTE_ETH_RSS_L2_SRC_ONLY) {
+				NT_LOG(DBG, FILTER, "Set outer src MAC hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L2,
+					6, 48, toeplitz);
+			} else if (fields & RTE_ETH_RSS_L2_DST_ONLY) {
+				NT_LOG(DBG, FILTER, "Set outer dst MAC hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L2,
+					0, 48, toeplitz);
+			} else {
+				NT_LOG(DBG, FILTER, "Set outer src & dst MAC hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L2,
+					0, 96, toeplitz);
+			}
+		} else {
+			if (fields & RTE_ETH_RSS_L2_SRC_ONLY) {
+				NT_LOG(DBG, FILTER, "Set inner src MAC hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L2,
+					6, 48, toeplitz);
+			} else if (fields & RTE_ETH_RSS_L2_DST_ONLY) {
+				NT_LOG(DBG, FILTER, "Set inner dst MAC hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L2,
+					0, 48, toeplitz);
+			} else {
+				NT_LOG(DBG, FILTER, "Set inner src & dst MAC hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L2,
+					0, 96, toeplitz);
+			}
+		}
+		unset_bits_and_log(&fields, RTE_ETH_RSS_ETH | RTE_ETH_RSS_L2_SRC_ONLY |
+			RTE_ETH_RSS_L2_DST_ONLY);
+	}
+
+	/*
+	 * VLAN support of multiple VLAN headers,
+	 * where S-VLAN is the first and C-VLAN the last VLAN header
+	 */
+	if (fields & RTE_ETH_RSS_C_VLAN) {
+		/*
+		 * use MPLS protocol offset, which points
+		 * just after ethertype with relative
+		 * offset -6 (i.e. 2 bytes
+		 * of ethertype & size + 4 bytes of VLAN header field)
+		 * to access last vlan header
+		 */
+		if (outer) {
+			NT_LOG(DBG, FILTER, "Set outer C-VLAN hasher.");
+			/*
+			 * use whole 32-bit 802.1a tag - backward compatible
+			 * with VSWITCH implementation
+			 */
+			res |= hsh_set_part(ndev, hsh_idx, words, DYN_MPLS,
+				-6, 32, toeplitz);
+		} else {
+			NT_LOG(DBG, FILTER, "Set inner C-VLAN hasher.");
+			/*
+			 * use whole 32-bit 802.1a tag - backward compatible
+			 * with VSWITCH implementation
+			 */
+			res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_MPLS,
+				-6, 32, toeplitz);
+		}
+		unset_bits_and_log(&fields, RTE_ETH_RSS_C_VLAN);
+	}
+
+	if (fields & RTE_ETH_RSS_S_VLAN) {
+		if (outer) {
+			NT_LOG(DBG, FILTER, "Set outer S-VLAN hasher.");
+			/*
+			 * use whole 32-bit 802.1a tag - backward compatible
+			 * with VSWITCH implementation
+			 */
+			res |= hsh_set_part(ndev, hsh_idx, words, DYN_FIRST_VLAN,
+				0, 32, toeplitz);
+		} else {
+			NT_LOG(DBG, FILTER, "Set inner S-VLAN hasher.");
+			/*
+			 * use whole 32-bit 802.1a tag - backward compatible
+			 * with VSWITCH implementation
+			 */
+			res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_VLAN,
+				0, 32, toeplitz);
+		}
+		unset_bits_and_log(&fields, RTE_ETH_RSS_S_VLAN);
+	}
+
+	/* L2 payload */
+	/* calculate hash of 128-bits of l2 payload;
+	 * Use MPLS protocol offset to address the beginning
+	 * of L2 payload even if MPLS header is not present
+	 */
+	if (fields & RTE_ETH_RSS_L2_PAYLOAD) {
+		uint64_t outer_fields_enabled = 0;
+		if (outer) {
+			NT_LOG(DBG, FILTER, "Set outer L2 payload hasher.");
+			res |= hsh_set_part(ndev, hsh_idx, words, DYN_MPLS,
+				0, 128, toeplitz);
+		} else {
+			NT_LOG(DBG, FILTER, "Set inner L2 payload hasher.");
+			res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_MPLS,
+				0, 128, toeplitz);
+			outer_fields_enabled = fields & RTE_ETH_RSS_GTPU;
+		}
+		/*
+		 * L2 PAYLOAD hashing overrides all L3 & L4 RSS flags.
+		 * Thus we can clear all remaining (supported)
+		 * RSS flags...
+		 */
+		unset_bits_and_log(&fields, NT_ETH_RSS_OFFLOAD_MASK);
+		/*
+		 * ...but in case of INNER L2 PAYLOAD we must process
+		 * "always outer" GTPU field if enabled
+		 */
+		fields |= outer_fields_enabled;
+	}
+
+	/* L3 + L4 protocol number */
+	if (fields & RTE_ETH_RSS_IPV4_CHKSUM) {
+		/* only IPv4 checksum is supported by DPDK RTE_ETH_RSS_* types */
+		if (ipv6) {
+			NT_LOG(ERR, FILTER, "RSS: IPv4 checksum requested with IPv6 header hashing!");
+			res = 1;
+		} else {
+			if (outer) {
+				NT_LOG(DBG, FILTER, "Set outer IPv4 checksum hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L3,
+					10, 16, toeplitz);
+			} else {
+				NT_LOG(DBG, FILTER, "Set inner IPv4 checksum hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L3,
+					10, 16, toeplitz);
+			}
+		}
+		/*
+		 * L3 checksum is made from whole L3 header, i.e. no need to process other
+		 * L3 hashing flags
+		 */
+		unset_bits_and_log(&fields, RTE_ETH_RSS_IPV4_CHKSUM | NT_ETH_RSS_IP_MASK);
+	}
+
+	if (fields & NT_ETH_RSS_IP_MASK) {
+		if (ipv6) {
+			if (outer) {
+				if (fields & RTE_ETH_RSS_L3_SRC_ONLY) {
+					NT_LOG(DBG, FILTER, "Set outer IPv6/IPv4 src hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_FINAL_IP_DST,
+						-16, 128, toeplitz);
+				} else if (fields & RTE_ETH_RSS_L3_DST_ONLY) {
+					NT_LOG(DBG, FILTER, "Set outer IPv6/IPv4 dst hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_FINAL_IP_DST,
+						0, 128, toeplitz);
+				} else {
+					NT_LOG(DBG, FILTER, "Set outer IPv6/IPv4 src & dst hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_FINAL_IP_DST,
+						-16, 128, toeplitz);
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_FINAL_IP_DST,
+						0, 128, toeplitz);
+				}
+			} else {
+				if (fields & RTE_ETH_RSS_L3_SRC_ONLY) {
+					NT_LOG(DBG, FILTER, "Set inner IPv6/IPv4 src hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words,
+						DYN_TUN_FINAL_IP_DST, -16, 128, toeplitz);
+				} else if (fields & RTE_ETH_RSS_L3_DST_ONLY) {
+					NT_LOG(DBG, FILTER, "Set inner IPv6/IPv4 dst hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words,
+						DYN_TUN_FINAL_IP_DST, 0, 128, toeplitz);
+				} else {
+					NT_LOG(DBG, FILTER, "Set inner IPv6/IPv4 src & dst hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words,
+						DYN_TUN_FINAL_IP_DST, -16, 128, toeplitz);
+					res |= hsh_set_part(ndev, hsh_idx, words,
+						DYN_TUN_FINAL_IP_DST, 0, 128, toeplitz);
+				}
+			}
+			/* check if fragment ID shall be part of hash */
+			if (fields & (RTE_ETH_RSS_FRAG_IPV4 | RTE_ETH_RSS_FRAG_IPV6)) {
+				if (outer) {
+					NT_LOG(DBG, FILTER, "Set outer IPv6/IPv4 fragment ID hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_ID_IPV4_6,
+						0, 32, toeplitz);
+				} else {
+					NT_LOG(DBG, FILTER, "Set inner IPv6/IPv4 fragment ID hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_ID_IPV4_6,
+						0, 32, toeplitz);
+				}
+			}
+			res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_AUTO_IPV4_MASK,
+				hsh_idx, 0, 1);
+		} else {
+			/* IPv4 */
+			if (outer) {
+				if (fields & RTE_ETH_RSS_L3_SRC_ONLY) {
+					NT_LOG(DBG, FILTER, "Set outer IPv4 src only hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_L3,
+						12, 32, toeplitz);
+				} else if (fields & RTE_ETH_RSS_L3_DST_ONLY) {
+					NT_LOG(DBG, FILTER, "Set outer IPv4 dst only hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_L3,
+						16, 32, toeplitz);
+				} else {
+					NT_LOG(DBG, FILTER, "Set outer IPv4 src & dst hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_L3,
+						12, 64, toeplitz);
+				}
+			} else {
+				if (fields & RTE_ETH_RSS_L3_SRC_ONLY) {
+					NT_LOG(DBG, FILTER, "Set inner IPv4 src only hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L3,
+						12, 32, toeplitz);
+				} else if (fields & RTE_ETH_RSS_L3_DST_ONLY) {
+					NT_LOG(DBG, FILTER, "Set inner IPv4 dst only hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L3,
+						16, 32, toeplitz);
+				} else {
+					NT_LOG(DBG, FILTER, "Set inner IPv4 src & dst hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L3,
+						12, 64, toeplitz);
+				}
+			}
+			/* check if fragment ID shall be part of hash */
+			if (fields & RTE_ETH_RSS_FRAG_IPV4) {
+				if (outer) {
+					NT_LOG(DBG, FILTER, "Set outer IPv4 fragment ID hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_ID_IPV4_6,
+						0, 16, toeplitz);
+				} else {
+					NT_LOG(DBG, FILTER, "Set inner IPv4 fragment ID hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_ID_IPV4_6,
+						0, 16, toeplitz);
+				}
+			}
+		}
+
+		/* check if L4 protocol type shall be part of hash */
+		if (l4_proto_mask)
+			l4_proto_hash = true;
+		unset_bits_and_log(&fields, NT_ETH_RSS_IP_MASK);
+	}
+
+	/* L4 */
+	if (fields & (RTE_ETH_RSS_PORT | RTE_ETH_RSS_L4_SRC_ONLY |
+		RTE_ETH_RSS_L4_DST_ONLY)) {
+		if (outer) {
+			if (fields & RTE_ETH_RSS_L4_SRC_ONLY) {
+				NT_LOG(DBG, FILTER, "Set outer L4 src hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L4,
+					0, 16, toeplitz);
+			} else if (fields & RTE_ETH_RSS_L4_DST_ONLY) {
+				NT_LOG(DBG, FILTER, "Set outer L4 dst hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L4,
+					2, 16, toeplitz);
+			} else {
+				NT_LOG(DBG, FILTER, "Set outer L4 src & dst hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L4,
+					0, 32, toeplitz);
+			}
+		} else {
+			if (fields & RTE_ETH_RSS_L4_SRC_ONLY) {
+				NT_LOG(DBG, FILTER, "Set inner L4 src hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L4,
+					0, 16, toeplitz);
+			} else if (fields & RTE_ETH_RSS_L4_DST_ONLY) {
+				NT_LOG(DBG, FILTER, "Set inner L4 dst hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L4,
+					2, 16, toeplitz);
+			} else {
+				NT_LOG(DBG, FILTER, "Set inner L4 src & dst hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L4,
+					0, 32, toeplitz);
+			}
+		}
+		l4_proto_hash = true;
+		unset_bits_and_log(&fields, RTE_ETH_RSS_PORT | RTE_ETH_RSS_L4_SRC_ONLY |
+			RTE_ETH_RSS_L4_DST_ONLY);
+	}
+
+	/* IPv4 protocol / IPv6 next header fields */
+	if (l4_proto_hash) {
+		/* NOTE: HW_HSH_RCP_P_MASK is not supported for
+		 *Toeplitz and thus one of SW0, SW4 or W8
+		 * must be used to hash on `protocol` field of IPv4 or
+		 * `next header` field of IPv6 header.
+		 */
+		if (outer) {
+			NT_LOG(DBG, FILTER, "Set outer L4 protocol type / next header hasher.");
+			if (toeplitz) {
+				if (ipv6)
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_L3, 6, 8,
+						toeplitz);
+				else
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_L3, 9, 8,
+						toeplitz);
+			} else {
+				res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_P_MASK,
+					hsh_idx, 0, 1);
+				res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TNL_P,
+					hsh_idx, 0, 0);
+			}
+		} else {
+			NT_LOG(DBG, FILTER, "Set inner L4 protocol type / next header hasher.");
+			if (toeplitz) {
+				if (ipv6) {
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L3, 6, 8,
+						toeplitz);
+				} else {
+					res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L3, 9, 8,
+						toeplitz);
+				}
+			} else {
+				res |= hw_mod_hsh_rcp_set(&ndev->be,
+					HW_HSH_RCP_P_MASK, hsh_idx, 0, 1);
+				res |= hw_mod_hsh_rcp_set(&ndev->be,
+					HW_HSH_RCP_TNL_P, hsh_idx, 0, 1);
+			}
+		}
+		l4_proto_hash = false;
+	}
+
+	/*
+	 * GTPU - for UPF use cases we always use TEID from outermost GTPU header
+	 * even if other headers are innermost
+	 */
+	if (fields & RTE_ETH_RSS_GTPU) {
+		NT_LOG(DBG, FILTER, "Set outer GTPU TEID hasher.");
+		res |= hsh_set_part(ndev, hsh_idx, words, DYN_L4_PAYLOAD, 4, 32, toeplitz);
+		unset_bits_and_log(&fields, RTE_ETH_RSS_GTPU);
+	}
+
+	/* Checksums */
+	/* only UDP, TCP and SCTP checksums are supported */
+	if (fields & RTE_ETH_RSS_L4_CHKSUM) {
+		switch (l4_proto_mask) {
+		case RTE_ETH_RSS_NONFRAG_IPV4_UDP:
+		case RTE_ETH_RSS_NONFRAG_IPV6_UDP:
+		case RTE_ETH_RSS_IPV6_UDP_EX:
+		case RTE_ETH_RSS_NONFRAG_IPV4_UDP | RTE_ETH_RSS_NONFRAG_IPV6_UDP:
+		case RTE_ETH_RSS_NONFRAG_IPV4_UDP | RTE_ETH_RSS_IPV6_UDP_EX:
+		case RTE_ETH_RSS_NONFRAG_IPV6_UDP | RTE_ETH_RSS_IPV6_UDP_EX:
+		case RTE_ETH_RSS_UDP_COMBINED:
+			if (outer) {
+				NT_LOG(DBG, FILTER, "Set outer UDP checksum hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L4, 6, 16,
+					toeplitz);
+			} else {
+				NT_LOG(DBG, FILTER, "Set inner UDP checksum hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L4, 6, 16,
+					toeplitz);
+			}
+			unset_bits_and_log(&fields, RTE_ETH_RSS_L4_CHKSUM | l4_proto_mask);
+			break;
+		case RTE_ETH_RSS_NONFRAG_IPV4_TCP:
+		case RTE_ETH_RSS_NONFRAG_IPV6_TCP:
+		case RTE_ETH_RSS_IPV6_TCP_EX:
+		case RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_NONFRAG_IPV6_TCP:
+		case RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_IPV6_TCP_EX:
+		case RTE_ETH_RSS_NONFRAG_IPV6_TCP | RTE_ETH_RSS_IPV6_TCP_EX:
+		case RTE_ETH_RSS_TCP_COMBINED:
+				if (outer) {
+					NT_LOG(DBG, FILTER, "Set outer TCP checksum hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words,
+						DYN_L4, 16, 16, toeplitz);
+				} else {
+					NT_LOG(DBG, FILTER, "Set inner TCP checksum hasher.");
+					res |= hsh_set_part(ndev, hsh_idx, words,
+						DYN_TUN_L4, 16, 16, toeplitz);
+				}
+				unset_bits_and_log(&fields, RTE_ETH_RSS_L4_CHKSUM | l4_proto_mask);
+				break;
+		case RTE_ETH_RSS_NONFRAG_IPV4_SCTP:
+		case RTE_ETH_RSS_NONFRAG_IPV6_SCTP:
+		case RTE_ETH_RSS_NONFRAG_IPV4_SCTP | RTE_ETH_RSS_NONFRAG_IPV6_SCTP:
+			if (outer) {
+				NT_LOG(DBG, FILTER, "Set outer SCTP checksum hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_L4, 8, 32,
+					toeplitz);
+			} else {
+				NT_LOG(DBG, FILTER, "Set inner SCTP checksum hasher.");
+				res |= hsh_set_part(ndev, hsh_idx, words, DYN_TUN_L4, 8, 32,
+					toeplitz);
+			}
+			unset_bits_and_log(&fields, RTE_ETH_RSS_L4_CHKSUM | l4_proto_mask);
+			break;
+		case RTE_ETH_RSS_NONFRAG_IPV4_OTHER:
+		case RTE_ETH_RSS_NONFRAG_IPV6_OTHER:
+		/* none or unsupported protocol was chosen */
+		case 0:
+			NT_LOG(ERR, FILTER, "L4 checksum hashing is supported only for UDP, TCP and SCTP protocols");
+			res = -1;
+			break;
+		/* multiple L4 protocols were selected */
+		default:
+			NT_LOG(ERR, FILTER, "L4 checksum hashing can be enabled just for one of UDP, TCP or SCTP protocols");
+			res = -1;
+			break;
+		}
+	}
+
+	if (fields || res != 0) {
+		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
+		if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", rss_conf.rss_hf) == 0) {
+			NT_LOG(ERR, FILTER, "RSS configuration%s is not supported for hash func %s.",
+				rss_buffer, (enum rte_eth_hash_function)toeplitz ?
+					"Toeplitz" : "NTH10");
+		} else {
+			NT_LOG(ERR, FILTER, "RSS configuration 0x%" PRIX64 " is not supported for hash func %s.",
+				rss_conf.rss_hf, (enum rte_eth_hash_function)toeplitz ?
+					"Toeplitz" : "NTH10");
+		}
+		return -1;
+	}
+
+	return res;
+}
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
new file mode 100644
index 0000000000..38901b3e8a
--- /dev/null
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
@@ -0,0 +1,17 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Napatech A/S
+ */
+
+#ifndef _FLOW_HSH_CFG_H_
+#define _FLOW_HSH_CFG_H_
+
+#include <rte_ethdev.h>
+
+#include "hw_mod_backend.h"
+#include "flow_api.h"
+
+int hsh_set(struct flow_nic_dev *ndev, int hsh_idx,
+	struct nt_eth_rss_conf rss_conf);
+
+#endif /* _FLOW_HSH_CFG_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index ffab643f56..22cbf61b60 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -2,13 +2,14 @@
  * Copyright(c) 2023 Napatech A/S
  */
 
+#include "rte_common.h"
 
 #include "hw_mod_backend.h"
 #include "flow_api_engine.h"
 
 #include "flow_api_hw_db_inline.h"
 #include "flow_api_profile_inline_config.h"
-#include "rte_common.h"
+#include "flow_hsh_cfg.h"
 
 #define HW_DB_INLINE_ACTION_SET_NB 512
 #define HW_DB_INLINE_MATCH_SET_NB 512
@@ -2844,7 +2845,7 @@ struct hw_db_hsh_idx hw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_ha
 	tmp_rss_conf.rss_hf = data->hash_mask;
 	memcpy(tmp_rss_conf.rss_key, data->key, MAX_RSS_KEY_LEN);
 	tmp_rss_conf.algorithm = data->func;
-	int res = flow_nic_set_hasher_fields(ndev, idx.ids, tmp_rss_conf);
+	int res = hsh_set(ndev, idx.ids, tmp_rss_conf);
 
 	if (res != 0) {
 		idx.error = 1;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 574e51c2fa..e5abd372bc 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -20,6 +20,7 @@
 
 #include "flow_api_profile_inline.h"
 #include "ntnic_mod_reg.h"
+#include "flow_hsh_cfg.h"
 #include <rte_spinlock.h>
 #include <rte_common.h>
 
@@ -44,12 +45,6 @@
 #define NT_VIOLATING_MBR_CFN 0
 #define NT_VIOLATING_MBR_QSL 1
 
-#define RTE_ETH_RSS_UDP_COMBINED                                                                  \
-	(RTE_ETH_RSS_NONFRAG_IPV4_UDP | RTE_ETH_RSS_NONFRAG_IPV6_UDP | RTE_ETH_RSS_IPV6_UDP_EX)
-
-#define RTE_ETH_RSS_TCP_COMBINED                                                                  \
-	(RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_NONFRAG_IPV6_TCP | RTE_ETH_RSS_IPV6_TCP_EX)
-
 #define NT_FLM_OP_UNLEARN 0
 #define NT_FLM_OP_LEARN 1
 
@@ -3809,116 +3804,6 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 	return NULL;
 }
 
-/*
- * FPGA uses up to 10 32-bit words (320 bits) for hash calculation + 8 bits for L4 protocol number.
- * Hashed data are split between two 128-bit Quad Words (QW)
- * and two 32-bit Words (W), which can refer to different header parts.
- */
-enum hsh_words_id {
-	HSH_WORDS_QW0 = 0,
-	HSH_WORDS_QW4,
-	HSH_WORDS_W8,
-	HSH_WORDS_W9,
-	HSH_WORDS_SIZE,
-};
-
-/* struct with details about hash QWs & Ws */
-struct hsh_words {
-	/*
-	 * index of W (word) or index of 1st word of QW (quad word)
-	 * is used for hash mask calculation
-	 */
-	uint8_t index;
-	enum hw_hsh_e pe;	/* offset to header part, e.g. beginning of L4 */
-	enum hw_hsh_e ofs;	/* relative offset in BYTES to 'pe' header offset above */
-	uint16_t bit_len;	/* max length of header part in bits to fit into QW/W */
-	bool free;	/* only free words can be used for hsh calculation */
-};
-
-static enum hsh_words_id get_free_word(struct hsh_words *words, uint16_t bit_len)
-{
-	enum hsh_words_id ret = HSH_WORDS_SIZE;
-	uint16_t ret_bit_len = UINT16_MAX;
-
-	for (enum hsh_words_id i = HSH_WORDS_QW0; i < HSH_WORDS_SIZE; i++) {
-		if (words[i].free && bit_len <= words[i].bit_len &&
-			words[i].bit_len < ret_bit_len) {
-			ret = i;
-			ret_bit_len = words[i].bit_len;
-		}
-	}
-
-	return ret;
-}
-
-static int flow_nic_set_hasher_part_inline(struct flow_nic_dev *ndev, int hsh_idx,
-	struct hsh_words *words, uint32_t pe, uint32_t ofs,
-	int bit_len, bool toeplitz)
-{
-	int res = 0;
-
-	/* check if there is any free word, which can accommodate header part of given 'bit_len' */
-	enum hsh_words_id word = get_free_word(words, bit_len);
-
-	if (word == HSH_WORDS_SIZE) {
-		NT_LOG(ERR, FILTER, "Cannot add additional %d bits into hash", bit_len);
-		return -1;
-	}
-
-	words[word].free = false;
-
-	res |= hw_mod_hsh_rcp_set(&ndev->be, words[word].pe, hsh_idx, 0, pe);
-	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %d)", words[word].pe,
-		hsh_idx, pe);
-	res |= hw_mod_hsh_rcp_set(&ndev->be, words[word].ofs, hsh_idx, 0, ofs);
-	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %d)", words[word].ofs,
-		hsh_idx, ofs);
-
-	/* set HW_HSH_RCP_WORD_MASK based on used QW/W and given 'bit_len' */
-	int mask_bit_len = bit_len;
-	uint32_t mask = 0x0;
-	uint32_t toeplitz_mask[9] = { 0x0 };
-	/* iterate through all words of QW */
-	uint16_t words_count = words[word].bit_len / 32;
-
-	for (uint16_t mask_off = 1; mask_off <= words_count; mask_off++) {
-		if (mask_bit_len >= 32) {
-			mask_bit_len -= 32;
-			mask = 0xffffffff;
-
-		} else if (mask_bit_len > 0) {
-			mask = 0xffffffff >> (32 - mask_bit_len) << (32 - mask_bit_len);
-			mask_bit_len = 0;
-
-		} else {
-			mask = 0x0;
-		}
-
-		/* reorder QW words mask from little to big endian */
-		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, hsh_idx,
-			words[word].index + words_count - mask_off, mask);
-		NT_LOG_DBGX(DBG, FILTER,
-			"hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_WORD_MASK, %d, %d, 0x%08" PRIX32
-			")",
-			hsh_idx, words[word].index + words_count - mask_off, mask);
-		toeplitz_mask[words[word].index + mask_off - 1] = mask;
-	}
-
-	if (toeplitz) {
-		NT_LOG(DBG, FILTER,
-			"Partial Toeplitz RSS key mask: %08" PRIX32 " %08" PRIX32 " %08" PRIX32
-			" %08" PRIX32 " %08" PRIX32 " %08" PRIX32 " %08" PRIX32 " %08" PRIX32
-			" %08" PRIX32 "",
-			toeplitz_mask[0], toeplitz_mask[1], toeplitz_mask[2], toeplitz_mask[3],
-			toeplitz_mask[4], toeplitz_mask[5], toeplitz_mask[6], toeplitz_mask[7],
-			toeplitz_mask[8]);
-		NT_LOG(DBG, FILTER,
-			"                               MSB                                                                          LSB");
-	}
-
-	return res;
-}
-
 /*
  * Public functions
  */
@@ -3982,8 +3867,16 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 
 		flow_nic_mark_resource_used(ndev, RES_PDB_RCP, 0);
 
-		/* Set default hasher recipe to 5-tuple */
-		flow_nic_set_hasher(ndev, 0, HASH_ALGO_5TUPLE);
+		/* Set default hasher recipe to 5-tuple:
+		 * RTE_ETH_RSS_IPV6 - enables hashing on both IPv4/IPv6 SA and DA
+		 * RTE_ETH_RSS_PORT - enables hashing on both L4 SP and DP and L4 protocol type
+		 */
+		struct nt_eth_rss_conf hsh_5_tuple = {
+			.rss_key = {},
+			.rss_hf = RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_PORT,
+			.algorithm = 0,
+		};
+		hsh_set(ndev, 0, hsh_5_tuple);
 		hw_mod_hsh_rcp_flush(&ndev->be, 0, 1);
 
 		flow_nic_mark_resource_used(ndev, RES_HSH_RCP, 0);
@@ -4580,658 +4473,6 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 	return -1;
 }
 
-static __rte_always_inline bool all_bits_enabled(uint64_t hash_mask, uint64_t hash_bits)
-{
-	return (hash_mask & hash_bits) == hash_bits;
-}
-
-static __rte_always_inline void unset_bits(uint64_t *hash_mask, uint64_t hash_bits)
-{
-	*hash_mask &= ~hash_bits;
-}
-
-static __rte_always_inline void unset_bits_and_log(uint64_t *hash_mask, uint64_t hash_bits)
-{
-	char rss_buffer[4096];
-	uint16_t rss_buffer_len = sizeof(rss_buffer);
-
-	if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", *hash_mask & hash_bits) == 0)
-		NT_LOG(DBG, FILTER, "Configured RSS types:%s", rss_buffer);
-
-	unset_bits(hash_mask, hash_bits);
-}
-
-static __rte_always_inline void unset_bits_if_all_enabled(uint64_t *hash_mask, uint64_t hash_bits)
-{
-	if (all_bits_enabled(*hash_mask, hash_bits))
-		unset_bits(hash_mask, hash_bits);
-}
-
-int flow_nic_set_hasher_fields_inline(struct flow_nic_dev *ndev, int hsh_idx,
-	struct nt_eth_rss_conf rss_conf)
-{
-	uint64_t fields = rss_conf.rss_hf;
-
-	char rss_buffer[4096];
-	uint16_t rss_buffer_len = sizeof(rss_buffer);
-
-	if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", fields) == 0)
-		NT_LOG(DBG, FILTER, "Requested RSS types:%s", rss_buffer);
-
-	/*
-	 * configure all (Q)Words usable for hash calculation
-	 * Hash can be calculated from 4 independent header parts:
-	 *      | QW0           | Qw4           | W8| W9|
-	 * word | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
-	 */
-	struct hsh_words words[HSH_WORDS_SIZE] = {
-		{ 0, HW_HSH_RCP_QW0_PE, HW_HSH_RCP_QW0_OFS, 128, true },
-		{ 4, HW_HSH_RCP_QW4_PE, HW_HSH_RCP_QW4_OFS, 128, true },
-		{ 8, HW_HSH_RCP_W8_PE, HW_HSH_RCP_W8_OFS, 32, true },
-		{
-			9, HW_HSH_RCP_W9_PE, HW_HSH_RCP_W9_OFS, 32,
-			true
-		},	/* not supported for Toeplitz */
-	};
-
-	int res = 0;
-	res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
-	/* enable hashing */
-	res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_LOAD_DIST_TYPE, hsh_idx, 0, 2);
-
-	/* configure selected hash function and its key */
-	bool toeplitz = false;
-
-	switch (rss_conf.algorithm) {
-	case RTE_ETH_HASH_FUNCTION_DEFAULT:
-		/* Use default NTH10 hashing algorithm */
-		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TOEPLITZ, hsh_idx, 0, 0);
-		/* Use 1st 32-bits from rss_key to configure NTH10 SEED */
-		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_SEED, hsh_idx, 0,
-			rss_conf.rss_key[0] << 24 | rss_conf.rss_key[1] << 16 |
-			rss_conf.rss_key[2] << 8 | rss_conf.rss_key[3]);
-		break;
-
-	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
-		toeplitz = true;
-		res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TOEPLITZ, hsh_idx, 0, 1);
-		uint8_t empty_key = 0;
-
-		/* Toeplitz key (always 40B) words have to be programmed in reverse order */
-		for (uint8_t i = 0; i <= (MAX_RSS_KEY_LEN - 4); i += 4) {
-			res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_K, hsh_idx, 9 - i / 4,
-					rss_conf.rss_key[i] << 24 |
-					rss_conf.rss_key[i + 1] << 16 |
-					rss_conf.rss_key[i + 2] << 8 |
-					rss_conf.rss_key[i + 3]);
-			NT_LOG_DBG(DBG, FILTER,
-				"hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_K, %d, %d, 0x%" PRIX32
-				")",
-				hsh_idx, 9 - i / 4,
-				rss_conf.rss_key[i] << 24 | rss_conf.rss_key[i + 1] << 16 |
-				rss_conf.rss_key[i + 2] << 8 | rss_conf.rss_key[i + 3]);
-			empty_key |= rss_conf.rss_key[i] | rss_conf.rss_key[i + 1] |
-				rss_conf.rss_key[i + 2] | rss_conf.rss_key[i + 3];
-		}
-
-		if (empty_key == 0) {
-			NT_LOG(ERR, FILTER,
-				"Toeplitz key must be configured. Key with all bytes set to zero is not allowed.");
-			return -1;
-		}
-
-		words[HSH_WORDS_W9].free = false;
-		NT_LOG(DBG, FILTER,
-			"Toeplitz hashing is enabled thus W9 and P_MASK cannot be used.");
-		break;
-
-	default:
-		NT_LOG(ERR, FILTER, "Unknown hashing function %d requested", rss_conf.algorithm);
-		return -1;
-	}
-
-	/* indication that some IPv6 flag is present */
-	bool ipv6 = fields & (NT_ETH_RSS_IPV6_MASK);
-	/* store proto mask for later use at IP and L4 checksum handling */
-	uint64_t l4_proto_mask = fields &
-		(RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_NONFRAG_IPV4_UDP |
-		RTE_ETH_RSS_NONFRAG_IPV4_SCTP | RTE_ETH_RSS_NONFRAG_IPV4_OTHER |
-		RTE_ETH_RSS_NONFRAG_IPV6_TCP | RTE_ETH_RSS_NONFRAG_IPV6_UDP |
-		RTE_ETH_RSS_NONFRAG_IPV6_SCTP | RTE_ETH_RSS_NONFRAG_IPV6_OTHER |
-		RTE_ETH_RSS_IPV6_TCP_EX | RTE_ETH_RSS_IPV6_UDP_EX);
-
-	/* outermost headers are used by default, so innermost bit takes precedence if detected */
-	bool outer = (fields & RTE_ETH_RSS_LEVEL_INNERMOST) ? false : true;
-	unset_bits(&fields, RTE_ETH_RSS_LEVEL_MASK);
-
-	if (fields == 0) {
-		NT_LOG(ERR, FILTER, "RSS hash configuration 0x%" PRIX64 " is not valid.",
-			rss_conf.rss_hf);
-		return -1;
-	}
-
-	/* indication that IPv4 `protocol` or IPv6 `next header` fields shall be part of the hash
-	 */
-	bool l4_proto_hash = false;
-
-	/*
-	 * check if SRC_ONLY & DST_ONLY are used simultaneously;
-	 * According to DPDK, we shall behave like none of these bits is set
-	 */
-	unset_bits_if_all_enabled(&fields, RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY);
-	unset_bits_if_all_enabled(&fields, RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY);
-	unset_bits_if_all_enabled(&fields, RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY);
-
-	/* L2 */
-	if (fields & (RTE_ETH_RSS_ETH | RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY)) {
-		if (outer) {
-			if (fields & RTE_ETH_RSS_L2_SRC_ONLY) {
-				NT_LOG(DBG, FILTER, "Set outer src MAC hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L2, 6, 48, toeplitz);
-
-			} else if (fields & RTE_ETH_RSS_L2_DST_ONLY) {
-				NT_LOG(DBG, FILTER, "Set outer dst MAC hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L2, 0, 48, toeplitz);
-
-			} else {
-				NT_LOG(DBG, FILTER, "Set outer src & dst MAC hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L2, 0, 96, toeplitz);
-			}
-
-		} else if (fields & RTE_ETH_RSS_L2_SRC_ONLY) {
-			NT_LOG(DBG, FILTER, "Set inner src MAC hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_L2, 6,
-				48, toeplitz);
-
-		} else if (fields & RTE_ETH_RSS_L2_DST_ONLY) {
-			NT_LOG(DBG, FILTER, "Set inner dst MAC hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_L2, 0,
-				48, toeplitz);
-
-		} else {
-			NT_LOG(DBG, FILTER, "Set inner src & dst MAC hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_L2, 0,
-				96, toeplitz);
-		}
-
-		unset_bits_and_log(&fields,
-			RTE_ETH_RSS_ETH | RTE_ETH_RSS_L2_SRC_ONLY |
-			RTE_ETH_RSS_L2_DST_ONLY);
-	}
-
-	/*
-	 * VLAN support of multiple VLAN headers,
-	 * where S-VLAN is the first and C-VLAN the last VLAN header
-	 */
-	if (fields & RTE_ETH_RSS_C_VLAN) {
-		/*
-		 * use MPLS protocol offset, which points just after ethertype with relative
-		 * offset -6 (i.e. 2 bytes
-		 * of ethertype & size + 4 bytes of VLAN header field) to access last vlan header
-		 */
-		if (outer) {
-			NT_LOG(DBG, FILTER, "Set outer C-VLAN hasher.");
-			/*
-			 * use whole 32-bit 802.1a tag - backward compatible
-			 * with VSWITCH implementation
-			 */
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_MPLS, -6,
-				32, toeplitz);
-
-		} else {
-			NT_LOG(DBG, FILTER, "Set inner C-VLAN hasher.");
-			/*
-			 * use whole 32-bit 802.1a tag - backward compatible
-			 * with VSWITCH implementation
-			 */
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_MPLS,
-				-6, 32, toeplitz);
-		}
-
-		unset_bits_and_log(&fields, RTE_ETH_RSS_C_VLAN);
-	}
-
-	if (fields & RTE_ETH_RSS_S_VLAN) {
-		if (outer) {
-			NT_LOG(DBG, FILTER, "Set outer S-VLAN hasher.");
-			/*
-			 * use whole 32-bit 802.1a tag - backward compatible
-			 * with VSWITCH implementation
-			 */
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-				DYN_FIRST_VLAN, 0, 32, toeplitz);
-
-		} else {
-			NT_LOG(DBG, FILTER, "Set inner S-VLAN hasher.");
-			/*
-			 * use whole 32-bit 802.1a tag - backward compatible
-			 * with VSWITCH implementation
-			 */
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_VLAN,
-				0, 32, toeplitz);
-		}
-
-		unset_bits_and_log(&fields, RTE_ETH_RSS_S_VLAN);
-	}
-	/* L2 payload */
-	/* calculate hash of 128-bits of l2 payload; Use MPLS protocol offset to address the
-	 * beginning of L2 payload even if MPLS header is not present
-	 */
-	if (fields & RTE_ETH_RSS_L2_PAYLOAD) {
-		uint64_t outer_fields_enabled = 0;
-
-		if (outer) {
-			NT_LOG(DBG, FILTER, "Set outer L2 payload hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_MPLS, 0,
-				128, toeplitz);
-
-		} else {
-			NT_LOG(DBG, FILTER, "Set inner L2 payload hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_MPLS,
-				0, 128, toeplitz);
-			outer_fields_enabled = fields & RTE_ETH_RSS_GTPU;
-		}
-
-		/*
-		 * L2 PAYLOAD hashing overrides all L3 & L4 RSS flags.
-		 * Thus we can clear all remaining (supported)
-		 * RSS flags...
-		 */
-		unset_bits_and_log(&fields, NT_ETH_RSS_OFFLOAD_MASK);
-		/*
-		 * ...but in case of INNER L2 PAYLOAD we must process
-		 * "always outer" GTPU field if enabled
-		 */
-		fields |= outer_fields_enabled;
-	}
-
-	/* L3 + L4 protocol number */
-	if (fields & RTE_ETH_RSS_IPV4_CHKSUM) {
-		/* only IPv4 checksum is supported by DPDK RTE_ETH_RSS_* types */
-		if (ipv6) {
-			NT_LOG(ERR, FILTER,
-				"RSS: IPv4 checksum requested with IPv6 header hashing!");
-			res = 1;
-
-		} else if (outer) {
-			NT_LOG(DBG, FILTER, "Set outer IPv4 checksum hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_L3, 10,
-				16, toeplitz);
-
-		} else {
-			NT_LOG(DBG, FILTER, "Set inner IPv4 checksum hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_L3,
-				10, 16, toeplitz);
-		}
-
-		/*
-		 * L3 checksum is made from whole L3 header, i.e. no need to process other
-		 * L3 hashing flags
-		 */
-		unset_bits_and_log(&fields, RTE_ETH_RSS_IPV4_CHKSUM | NT_ETH_RSS_IP_MASK);
-	}
-
-	if (fields & NT_ETH_RSS_IP_MASK) {
-		if (ipv6) {
-			if (outer) {
-				if (fields & RTE_ETH_RSS_L3_SRC_ONLY) {
-					NT_LOG(DBG, FILTER, "Set outer IPv6/IPv4 src hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words,
-						DYN_FINAL_IP_DST,
-						-16, 128, toeplitz);
-
-				} else if (fields & RTE_ETH_RSS_L3_DST_ONLY) {
-					NT_LOG(DBG, FILTER, "Set outer IPv6/IPv4 dst hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words,
-						DYN_FINAL_IP_DST, 0,
-						128, toeplitz);
-
-				} else {
-					NT_LOG(DBG, FILTER,
-						"Set outer IPv6/IPv4 src & dst hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words,
-						DYN_FINAL_IP_DST,
-						-16, 128, toeplitz);
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words,
-						DYN_FINAL_IP_DST, 0,
-						128, toeplitz);
-				}
-
-			} else if (fields & RTE_ETH_RSS_L3_SRC_ONLY) {
-				NT_LOG(DBG, FILTER, "Set inner IPv6/IPv4 src hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_FINAL_IP_DST, -16,
-					128, toeplitz);
-
-			} else if (fields & RTE_ETH_RSS_L3_DST_ONLY) {
-				NT_LOG(DBG, FILTER, "Set inner IPv6/IPv4 dst hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_FINAL_IP_DST, 0,
-					128, toeplitz);
-
-			} else {
-				NT_LOG(DBG, FILTER, "Set inner IPv6/IPv4 src & dst hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_FINAL_IP_DST, -16,
-					128, toeplitz);
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_FINAL_IP_DST, 0,
-					128, toeplitz);
-			}
-
-			/* check if fragment ID shall be part of hash */
-			if (fields & (RTE_ETH_RSS_FRAG_IPV4 | RTE_ETH_RSS_FRAG_IPV6)) {
-				if (outer) {
-					NT_LOG(DBG, FILTER,
-						"Set outer IPv6/IPv4 fragment ID hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words,
-						DYN_ID_IPV4_6, 0,
-						32, toeplitz);
-
-				} else {
-					NT_LOG(DBG, FILTER,
-						"Set inner IPv6/IPv4 fragment ID hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words,
-						DYN_TUN_ID_IPV4_6,
-						0, 32, toeplitz);
-				}
-			}
-
-			res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_AUTO_IPV4_MASK, hsh_idx, 0,
-				1);
-
-		} else {
-			/* IPv4 */
-			if (outer) {
-				if (fields & RTE_ETH_RSS_L3_SRC_ONLY) {
-					NT_LOG(DBG, FILTER, "Set outer IPv4 src only hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words, DYN_L3, 12,
-						32, toeplitz);
-
-				} else if (fields & RTE_ETH_RSS_L3_DST_ONLY) {
-					NT_LOG(DBG, FILTER, "Set outer IPv4 dst only hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words, DYN_L3, 16,
-						32, toeplitz);
-
-				} else {
-					NT_LOG(DBG, FILTER, "Set outer IPv4 src & dst hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words, DYN_L3, 12,
-						64, toeplitz);
-				}
-
-			} else if (fields & RTE_ETH_RSS_L3_SRC_ONLY) {
-				NT_LOG(DBG, FILTER, "Set inner IPv4 src only hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_L3, 12, 32,
-					toeplitz);
-
-			} else if (fields & RTE_ETH_RSS_L3_DST_ONLY) {
-				NT_LOG(DBG, FILTER, "Set inner IPv4 dst only hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_L3, 16, 32,
-					toeplitz);
-
-			} else {
-				NT_LOG(DBG, FILTER, "Set inner IPv4 src & dst hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_L3, 12, 64,
-					toeplitz);
-			}
-
-			/* check if fragment ID shall be part of hash */
-			if (fields & RTE_ETH_RSS_FRAG_IPV4) {
-				if (outer) {
-					NT_LOG(DBG, FILTER,
-						"Set outer IPv4 fragment ID hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words,
-						DYN_ID_IPV4_6, 0,
-						16, toeplitz);
-
-				} else {
-					NT_LOG(DBG, FILTER,
-						"Set inner IPv4 fragment ID hasher.");
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words,
-						DYN_TUN_ID_IPV4_6,
-						0, 16, toeplitz);
-				}
-			}
-		}
-
-		/* check if L4 protocol type shall be part of hash */
-		if (l4_proto_mask)
-			l4_proto_hash = true;
-
-		unset_bits_and_log(&fields, NT_ETH_RSS_IP_MASK);
-	}
-
-	/* L4 */
-	if (fields & (RTE_ETH_RSS_PORT | RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY)) {
-		if (outer) {
-			if (fields & RTE_ETH_RSS_L4_SRC_ONLY) {
-				NT_LOG(DBG, FILTER, "Set outer L4 src hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L4, 0, 16, toeplitz);
-
-			} else if (fields & RTE_ETH_RSS_L4_DST_ONLY) {
-				NT_LOG(DBG, FILTER, "Set outer L4 dst hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L4, 2, 16, toeplitz);
-
-			} else {
-				NT_LOG(DBG, FILTER, "Set outer L4 src & dst hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L4, 0, 32, toeplitz);
-			}
-
-		} else if (fields & RTE_ETH_RSS_L4_SRC_ONLY) {
-			NT_LOG(DBG, FILTER, "Set inner L4 src hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_L4, 0,
-				16, toeplitz);
-
-		} else if (fields & RTE_ETH_RSS_L4_DST_ONLY) {
-			NT_LOG(DBG, FILTER, "Set inner L4 dst hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_L4, 2,
-				16, toeplitz);
-
-		} else {
-			NT_LOG(DBG, FILTER, "Set inner L4 src & dst hasher.");
-			res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_TUN_L4, 0,
-				32, toeplitz);
-		}
-
-		l4_proto_hash = true;
-		unset_bits_and_log(&fields,
-			RTE_ETH_RSS_PORT | RTE_ETH_RSS_L4_SRC_ONLY |
-			RTE_ETH_RSS_L4_DST_ONLY);
-	}
-
-	/* IPv4 protocol / IPv6 next header fields */
-	if (l4_proto_hash) {
-		/* NOTE: HW_HSH_RCP_P_MASK is not supported for Toeplitz and thus one of SW0, SW4
-		 * or W8 must be used to hash on `protocol` field of IPv4 or `next header` field of
-		 * IPv6 header.
-		 */
-		if (outer) {
-			NT_LOG(DBG, FILTER, "Set outer L4 protocol type / next header hasher.");
-
-			if (toeplitz) {
-				if (ipv6) {
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words, DYN_L3, 6, 8,
-						toeplitz);
-
-				} else {
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words, DYN_L3, 9, 8,
-						toeplitz);
-				}
-
-			} else {
-				res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_P_MASK, hsh_idx, 0,
-					1);
-				res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TNL_P, hsh_idx, 0,
-					0);
-			}
-
-		} else {
-			NT_LOG(DBG, FILTER, "Set inner L4 protocol type / next header hasher.");
-
-			if (toeplitz) {
-				if (ipv6) {
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words, DYN_TUN_L3,
-						6, 8, toeplitz);
-
-				} else {
-					res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx,
-						words, DYN_TUN_L3,
-						9, 8, toeplitz);
-				}
-
-			} else {
-				res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_P_MASK, hsh_idx, 0,
-					1);
-				res |= hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_TNL_P, hsh_idx, 0,
-					1);
-			}
-		}
-
-		l4_proto_hash = false;
-	}
-
-	/*
-	 * GTPU - for UPF use cases we always use TEID from outermost GTPU header
-	 * even if other headers are innermost
-	 */
-	if (fields & RTE_ETH_RSS_GTPU) {
-		NT_LOG(DBG, FILTER, "Set outer GTPU TEID hasher.");
-		res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words, DYN_L4_PAYLOAD, 4, 32,
-			toeplitz);
-		unset_bits_and_log(&fields, RTE_ETH_RSS_GTPU);
-	}
-
-	/* Checksums */
-	/* only UDP, TCP and SCTP checksums are supported */
-	if (fields & RTE_ETH_RSS_L4_CHKSUM) {
-		switch (l4_proto_mask) {
-		case RTE_ETH_RSS_NONFRAG_IPV4_UDP:
-		case RTE_ETH_RSS_NONFRAG_IPV6_UDP:
-		case RTE_ETH_RSS_IPV6_UDP_EX:
-		case RTE_ETH_RSS_NONFRAG_IPV4_UDP | RTE_ETH_RSS_NONFRAG_IPV6_UDP:
-		case RTE_ETH_RSS_NONFRAG_IPV4_UDP | RTE_ETH_RSS_IPV6_UDP_EX:
-		case RTE_ETH_RSS_NONFRAG_IPV6_UDP | RTE_ETH_RSS_IPV6_UDP_EX:
-		case RTE_ETH_RSS_UDP_COMBINED:
-			if (outer) {
-				NT_LOG(DBG, FILTER, "Set outer UDP checksum hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L4, 6, 16, toeplitz);
-
-			} else {
-				NT_LOG(DBG, FILTER, "Set inner UDP checksum hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_L4, 6, 16,
-					toeplitz);
-			}
-
-			unset_bits_and_log(&fields, RTE_ETH_RSS_L4_CHKSUM | l4_proto_mask);
-			break;
-
-		case RTE_ETH_RSS_NONFRAG_IPV4_TCP:
-		case RTE_ETH_RSS_NONFRAG_IPV6_TCP:
-		case RTE_ETH_RSS_IPV6_TCP_EX:
-		case RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_NONFRAG_IPV6_TCP:
-		case RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_IPV6_TCP_EX:
-		case RTE_ETH_RSS_NONFRAG_IPV6_TCP | RTE_ETH_RSS_IPV6_TCP_EX:
-		case RTE_ETH_RSS_TCP_COMBINED:
-			if (outer) {
-				NT_LOG(DBG, FILTER, "Set outer TCP checksum hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L4, 16, 16, toeplitz);
-
-			} else {
-				NT_LOG(DBG, FILTER, "Set inner TCP checksum hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_L4, 16, 16,
-					toeplitz);
-			}
-
-			unset_bits_and_log(&fields, RTE_ETH_RSS_L4_CHKSUM | l4_proto_mask);
-			break;
-
-		case RTE_ETH_RSS_NONFRAG_IPV4_SCTP:
-		case RTE_ETH_RSS_NONFRAG_IPV6_SCTP:
-		case RTE_ETH_RSS_NONFRAG_IPV4_SCTP | RTE_ETH_RSS_NONFRAG_IPV6_SCTP:
-			if (outer) {
-				NT_LOG(DBG, FILTER, "Set outer SCTP checksum hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_L4, 8, 32, toeplitz);
-
-			} else {
-				NT_LOG(DBG, FILTER, "Set inner SCTP checksum hasher.");
-				res |= flow_nic_set_hasher_part_inline(ndev, hsh_idx, words,
-					DYN_TUN_L4, 8, 32,
-					toeplitz);
-			}
-
-			unset_bits_and_log(&fields, RTE_ETH_RSS_L4_CHKSUM | l4_proto_mask);
-			break;
-
-		case RTE_ETH_RSS_NONFRAG_IPV4_OTHER:
-		case RTE_ETH_RSS_NONFRAG_IPV6_OTHER:
-
-		/* none or unsupported protocol was chosen */
-		case 0:
-			NT_LOG(ERR, FILTER,
-				"L4 checksum hashing is supported only for UDP, TCP and SCTP protocols");
-			res = -1;
-			break;
-
-		/* multiple L4 protocols were selected */
-		default:
-			NT_LOG(ERR, FILTER,
-				"L4 checksum hashing can be enabled just for one of UDP, TCP or SCTP protocols");
-			res = -1;
-			break;
-		}
-	}
-
-	if (fields || res != 0) {
-		hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
-
-		if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", rss_conf.rss_hf) == 0) {
-			NT_LOG(ERR, FILTER,
-				"RSS configuration%s is not supported for hash func %s.",
-				rss_buffer,
-				(enum rte_eth_hash_function)toeplitz ? "Toeplitz" : "NTH10");
-
-		} else {
-			NT_LOG(ERR, FILTER,
-				"RSS configuration 0x%" PRIX64
-				" is not supported for hash func %s.",
-				rss_conf.rss_hf,
-				(enum rte_eth_hash_function)toeplitz ? "Toeplitz" : "NTH10");
-		}
-
-		return -1;
-	}
-
-	return res;
-}
-
 static void dump_flm_data(const uint32_t *data, FILE *file)
 {
 	for (unsigned int i = 0; i < 10; ++i) {
@@ -6020,7 +5261,6 @@ static const struct profile_inline_ops ops = {
 	.flow_destroy_profile_inline = flow_destroy_profile_inline,
 	.flow_flush_profile_inline = flow_flush_profile_inline,
 	.flow_actions_update_profile_inline = flow_actions_update_profile_inline,
-	.flow_nic_set_hasher_fields_inline = flow_nic_set_hasher_fields_inline,
 	.flow_get_aged_flows_profile_inline = flow_get_aged_flows_profile_inline,
 	/*
 	 * Stats
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
index 169f71ee68..be22c9bcd1 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
@@ -66,10 +66,6 @@ int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	uint32_t nb_contexts,
 	struct rte_flow_error *error);
 
-int flow_nic_set_hasher_fields_inline(struct flow_nic_dev *ndev,
-	int hsh_idx,
-	struct nt_eth_rss_conf rss_conf);
-
 /*
  * Stats
  */
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d1360cc925..9000264804 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -27,6 +27,7 @@
 #include "ntnic_vfio.h"
 #include "ntnic_mod_reg.h"
 #include "nt_util.h"
+#include "flow_hsh_cfg.h"
 #include "profile_inline/flm_age_queue.h"
 #include "profile_inline/flm_evt_queue.h"
 #include "rte_pmd_ntnic.h"
@@ -1672,7 +1673,7 @@ static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_r
 	tmp_rss_conf.algorithm = rss_conf->algorithm;
 
 	tmp_rss_conf.rss_hf = rss_conf->rss_hf;
-	int res = flow_filter_ops->flow_nic_set_hasher_fields(ndev, hsh_idx, tmp_rss_conf);
+	int res = hsh_set(ndev, hsh_idx, tmp_rss_conf);
 
 	if (res == 0) {
 		flow_filter_ops->hw_mod_hsh_rcp_flush(&ndev->be, hsh_idx, 1);
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 71861c6dea..8db4911262 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -355,10 +355,6 @@ struct profile_inline_ops {
 		struct flow_handle *flow, void *user_data,
 		struct rte_flow_error *error);
 
-	int (*flow_nic_set_hasher_fields_inline)(struct flow_nic_dev *ndev,
-		int hsh_idx,
-		struct nt_eth_rss_conf rss_conf);
-
 	/*
 	 * Stats
 	 */
@@ -467,8 +463,6 @@ struct flow_filter_ops {
 	/*
 	 * Other
 	 */
-	int (*flow_nic_set_hasher_fields)(struct flow_nic_dev *ndev, int hsh_idx,
-		struct nt_eth_rss_conf rss_conf);
 	int (*hw_mod_hsh_rcp_flush)(struct flow_api_backend_s *be, int start_idx, int count);
 
 	int (*flow_get_aged_flows)(struct flow_eth_dev *dev,
-- 
2.45.0

