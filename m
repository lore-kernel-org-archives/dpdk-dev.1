Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CCDCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC774406BA;
	Wed, 24 Sep 2025 16:42:02 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 5DB9C406A2
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:00 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022116.outbound.protection.outlook.com
 [52.101.66.116]) by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAEBCHRyrlWskeH4wfxIqkq/Ix0yC7LsSj7GnTCMo/OdP1f5rtlazg/bzk05ze6vUKY0tGV3lNH8THrxqMcz6L2M7sNGCNM9+JIO7IDYcfIAKPCfWglahvzs04m2MLfKDF67c/c/Jx0DjlVDwX2wVtJov5hYypeGiaa4DAcL6G/FduVGN6/slW87H2N6RGxxPET1siyQjXlgVG480FnDtmCbYfx69GgEjqUOSN2FbCSN7f+1tgfro0R7oN2yZeljhUdWxWuafRqGWSpE8BpGCCgikGA32ZCEF3La+F8dQOh14bzj1M9b5Gs4ShCwQ0atRrkS7V4xvtoQJAdYbSPXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcYQWGRv0Q1LnBT0K8PuA/vm7aUlNEc0lAAd7bK5tYY=;
 b=fabD/3uxZO9NuaG188jVGCGs+KjwmiebGDrOalmECyJnlVFWEyeeNuUMruEx29WnoW03NJ6RswxfSMHESXdA/4AzVyXBQ6p761Kecs2RXLGsj+ISjv5f/9MrIfKXpH9xqDs+UziyE7sJeZ4haiiE8CDBR33Xl6N/9iKvf35JkS5+TA20sDYto7JEtiyPbfS5RmcoN8tTu7xZ5Ik84AB5SSV9hSDcL0rH/MydVYdWLrHX40tBidHS8qk+kBTdnx7t+GLtQkK2lqaeYhLaiBVkaqZXhyTWO8ulEgIq/RL1DKMpyEyL5rPbPDVrnb7TruhUqZbLZRpxGDeT7wU9LddtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcYQWGRv0Q1LnBT0K8PuA/vm7aUlNEc0lAAd7bK5tYY=;
 b=XHnwtOn3ISKNCh7AhDFXOlmuRd9PfiqQz5RB9MU5MkRChOZWyaq66kRC1NlIGsRo0AoLxGANkYD4Jd33gwsprwh8+T9FSRAGiDBJVQd3v4Hv3rJCURQmnfYeFDCpx9DYUIxbnJAinBLX94Gzh0ONmkC8ERSDvnc5W2kwB3T2AyM=
Received: from CWLP123CA0236.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::18)
 by AM0P190MB0625.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:41:56 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::ad) by CWLP123CA0236.outlook.office365.com
 (2603:10a6:400:19f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:41:55
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 00/24] Migrate threads to the DPDK service framework and
 refactor naming for exported symbols
Date: Wed, 24 Sep 2025 16:41:23 +0200
Message-ID: <20250924144152.53203-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908141740.1312268-2-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM0P190MB0625:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4e9de5b4-4ce6-4a81-5542-08ddfb788230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NK4yuaNd6fHQHOi0ga6fMOAvq/wBSfNHcmZsszNNHXHezGl7OdPCtgU3s9KN?=
 =?us-ascii?Q?3oj394tWmYLBxDPhipC+cjG8/YugYeJMQ/u7HtQEcDrIt23mLrDVDiAijLX/?=
 =?us-ascii?Q?MtB2qOWGJCn3l4AhuiSTdHyL+6aOyiJllB9E6uotRbr/bFyNbCYJXyvMuW5C?=
 =?us-ascii?Q?01hwHduqWjMfXtsRND/+GKKvmEp2DbWXzeb/3wU0ijQTr42RWY35UrUsUMI9?=
 =?us-ascii?Q?a4Lu0UZiIOrMlGvmNrDUmvroQtBbu9XDffNNuM7FxCMbs0ZNkzCX/Ve12B6t?=
 =?us-ascii?Q?r8+Qr2ZfgleolHpxaaLzzN9fSbUkVS2nWM0Ez54rxMwS1OGzpkaWhVYLW0Os?=
 =?us-ascii?Q?nyFm6oFQF8o2bjRiS3d67WmDLNpPJ8jY7AdX5mGRzPfpTaDcyLD4TNPNtXS6?=
 =?us-ascii?Q?Ur2ErMy7i3Ox2Zyzml3LqjZ/LAIOEDjDlgF6Sp0cw3+D89bMjSWDF2f9Sje9?=
 =?us-ascii?Q?BZVEb8322ue+66QPaH4wCjmAYeM2y13vye9NQPaVqjCdY3/obyY6rveqLEoV?=
 =?us-ascii?Q?6395ySoJkEU4doedEanXE2VytQPhZcAk7brp25zevPNBeeZ64UTPnrZLiSV2?=
 =?us-ascii?Q?BGBPXQFrZqXxoEz/AiZFlhz6k/BSZSWswgb5ch6BaXcQCAiZnXFpNFzE28fP?=
 =?us-ascii?Q?tltduzpvzRJlkaR5JJBDQjMzScvyGctIGo4qotDRc1ghXSDE72/GERm8PRJe?=
 =?us-ascii?Q?dqgH9DRAnWv3zVbwJQ2+mYS/4j8WJKyHuvpCCzCehuylfdirqKzzkIkw2G2v?=
 =?us-ascii?Q?+Z1l4g3SVgkKBxwvPR+tkka5OADYha8wyG45LhJ4NgBJfyHrVo1SsxYhsAzr?=
 =?us-ascii?Q?GMn2ZS1h7LHMclANKKb9WnUY9LJWJ7hLHj0QIbY1aJXaa2+2zP76Z6tBzpeo?=
 =?us-ascii?Q?W/UQj2flI6lTkajb3v9IIUTIPqnm0xd9y62dOh6xIXIIBMJGIFW5qn6OCBsI?=
 =?us-ascii?Q?359U+QSwvkhfVGX/EZ5s75714B4B/Y4GUsPg+QEwc8YTCCgvWG6pKHGVOjjB?=
 =?us-ascii?Q?aB/iaC4LYo7sw1u42x2CpjlDrY7dbzjz48kRrMC8ul3lqUI/qTGDuymJNH35?=
 =?us-ascii?Q?Yh3/PXSokjbuyHE8w/Tusp0m6qChCllkga0716a87MAkMcCeimMP/SseatXU?=
 =?us-ascii?Q?ZofP2TQd/BhcHsRc+3b7yvZQ2AvvsenMF8i8XUODLRSPVzlqFDEEXd5tO1FY?=
 =?us-ascii?Q?9Ug5jNMcYj9yxjjaq3kv1vzQQQvYVz3Pj98mh5RTtKxYwZcBUPLDhLpCJ5Ac?=
 =?us-ascii?Q?hlP6ocpeBfhonRrDIJSHRJjGz62/uWfcA5JSGyXKA0Ois6utlHEEzZDaRkHl?=
 =?us-ascii?Q?DBwQnaW5IvFrp7ow7Vfkp+UaZO7dCzZ3nlGPSHzdr5WnIsiUUqHlncm33iOO?=
 =?us-ascii?Q?k9A+0bxYtiiZhGwb3CXcwCXC3MHB/p6Z/YLVy8CZLK4CctkRrHQc2OJu8I+G?=
 =?us-ascii?Q?LA4cJMQUJayRKoFt0CO+Qjr7JR8lkeQfblEuEDRRhEdj42aWFc3x/OYp65MD?=
 =?us-ascii?Q?SMpBr0auuGa1tbJ5kLMlaFS6nBxIRp4wcKuZ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uuuBFv9JRSM14hqzHkXZQuhKwH7mvPDUa3CUcp41tNDB+wrqDJYlhpAQOnCL+KtVvb/KSXbWUdp/GoPacCx/+HlN5uMWNHL3Hbm5UZj6+F3aaO5QYIvBfMXmgMKup/NUDXJO5m3EQ3IwxrgFsH9VzfQyGp4GOxy94A9xpwKmMWc7ne9ULaZP9RPLhYDJ+OjTvJk15zibpqP2cEHNTwzo8eadCV6g9FVz7+6TcZQMObeWKhU3N1R8/11CF55B52vm+tNmsAqrrBInWOCGDKyPPxDEqkQKILB8lkYzwZA551vxQxbjXx4H/26HsodNCzdcqJgHQ3ct3R+IHTWCdnp07KD+OA3C/txoXbHxN7bp+1BwiGBE0K+oN36W1bVAnLq+2hTstiEuvo+Mw5axEAUwO+U0iuyAzjFj9jxXPnFuS5gT8LhxfagYBUSwtrQQgW5JbghmQ4gNpN+lSjD2jswgSYk5ztRBs1e3er/LQO2ivbQOdnzexwM+ntqne7Dv2xIsvFUz49iZAkZPpVVPWJYxTd382OspCTiI9mes+eiMpLeiAX1pKpnieKudHkWvh3g0P+K8SnoLe4nJBECpayWqLDNL2VBjSz35GVNIfHYikCmPnTjuwjBu4qwclSI6YpMt2JYkK9QZf7dauQCbGoXURQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:41:55.4245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9de5b4-4ce6-4a81-5542-08ddfb788230
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0625
X-BESS-ID: 1758724917-305664-7613-8003-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.116
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGhgamQGYGUDQtySTJwDwpyd
 jEJMXU0CQxzcQ8zTDN0DTJ1MDUyNg4Wak2FgDVZvQiQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan10-56.eu-central-1a.ess.aws.cudaops.com]
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

This modification provides better resource (CPU) management for NTNIC PMD.

The following threads are migrated:
        * FLM update thread
        * Statistic thread
        * Port event thread
        * Adapter monitoring thread
Additionally, a warning is added to inform users about the importance of
dedicating lcores to the DPDK service framework when using the NTNIC PMD.
The code is also cleaned up to use pthreads and rte_thread APIs.

After this patch series, an each application using NTNIC PMD should
dedicate at least five(5) cores for DPDK service framework to ensure
proper operation of the NTNIC PMD.

The service cores can be dedicated by EAL options:
        * s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores
        * S SERVICE CORELIST List of cores to run services on
Or with a special API by the application itself.
        * rte_pmd_ntnic_service_set_lcore to map a service to a specific lcore
        * rte_pmd_ntnic_service_get_id to get a service ID.

This patch series also includes aligning the naming of the exported symbols to avoid
potential conflicts with other applications and libraries.
The main change is to add the prefix "nthw_".

Serhii Iliushyk (24):
  net/ntnic: introduce service API for NTNIC PMD
  net/ntnic: migrate flm update thread to service
  net/ntnic: migrate statistic thread to service
  net/ntnic: migrate port event thread to service
  net/ntnic: migrate adapter mon thread to service
  net/ntnic: add warning about service cores
  net/ntnic: avoid using thread API
  net/ntnic: fix potential format overflow
  net/ntnic: single file function as static
  net/ntnic: remove unused functions
  net/ntnic: move nthw to prefix part
  net/ntnic: change prefix hw to prefix nthw
  net/ntnic: modify prefix flow with prefix nthw
  net/ntnic: change prefix flm to prefix nthw
  net/ntnic: change prefix nt to prefix nthw
  net/ntnic: change prefix ntlog to prefix nthw
  net/ntnic: change prefix km to prefix nthw
  net/ntnic: change prefix set to prefix nthw
  net/ntnic: rename common hash and flow functions
  net/ntnic: rename register ops function
  net/ntnic: rename get ops functions
  net/ntnic: rename ops init functions
  net/ntnic: rename nim agx setup function
  net/ntnic: rename table ID functions

 doc/guides/nics/ntnic.rst                     |  112 ++
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |   41 +-
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |   10 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |   54 +-
 .../net/ntnic/include/common_adapter_defs.h   |   15 -
 drivers/net/ntnic/include/create_elements.h   |    9 -
 drivers/net/ntnic/include/flow_api.h          |   10 +-
 drivers/net/ntnic/include/flow_api_engine.h   |   18 +-
 drivers/net/ntnic/include/hw_mod_backend.h    |  281 ++--
 drivers/net/ntnic/include/nt4ga_adapter.h     |    4 -
 drivers/net/ntnic/include/ntdrv_4ga.h         |    4 -
 drivers/net/ntnic/include/ntnic_dbs.h         |   22 +-
 drivers/net/ntnic/include/ntnic_stat.h        |    2 +-
 drivers/net/ntnic/include/ntos_drv.h          |    4 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |  315 ++--
 .../link_agx_100g/nt4ga_agx_link_100g.c       |  326 ++--
 drivers/net/ntnic/link_mgmt/nt4ga_link.c      |    2 +-
 drivers/net/ntnic/meson.build                 |    2 +
 drivers/net/ntnic/nim/i2c_nim.c               |   10 +-
 drivers/net/ntnic/nim/i2c_nim.h               |    2 +-
 .../net/ntnic/nthw/core/include/nthw_fpga.h   |   14 +-
 .../net/ntnic/nthw/core/include/nthw_hif.h    |   12 -
 .../net/ntnic/nthw/core/include/nthw_iic.h    |    9 -
 .../ntnic/nthw/core/include/nthw_mac_pcs.h    |    9 -
 .../net/ntnic/nthw/core/include/nthw_pcie3.h  |   13 -
 .../nthw/core/include/nthw_pcm_nt400dxx.h     |    1 -
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |    2 -
 .../net/ntnic/nthw/core/include/nthw_rpf.h    |    2 -
 .../net/ntnic/nthw/core/include/nthw_si5340.h |    2 -
 .../clock_profiles/nthw_fpga_clk9563.c        |    4 +-
 .../nthw/core/nt200a0x/nthw_fpga_nt200a0x.c   |    8 +-
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c   |    8 +-
 .../nt200a0x/reset/nthw_fpga_rst_nt200a0x.c   |    6 +-
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |    8 +-
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   |   22 +-
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |   36 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |   22 +-
 drivers/net/ntnic/nthw/core/nthw_hif.c        |   90 --
 drivers/net/ntnic/nthw/core/nthw_i2cm.c       |    4 +-
 drivers/net/ntnic/nthw/core/nthw_igam.c       |    4 +-
 drivers/net/ntnic/nthw/core/nthw_iic.c        |  240 +--
 drivers/net/ntnic/nthw/core/nthw_mac_pcs.c    |   67 +-
 drivers/net/ntnic/nthw/core/nthw_pca9532.c    |    2 -
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |    1 -
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      |   86 --
 .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |    5 -
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |   51 +-
 drivers/net/ntnic/nthw/core/nthw_rpf.c        |   14 -
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |    3 +-
 drivers/net/ntnic/nthw/core/nthw_si5340.c     |    6 +-
 drivers/net/ntnic/nthw/core/nthw_spi_v3.c     |   12 +-
 drivers/net/ntnic/nthw/dbs/nthw_dbs.c         |   22 +-
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  253 ++--
 .../nthw/flow_api/flow_backend/flow_backend.c | 1342 ++++++++---------
 drivers/net/ntnic/nthw/flow_api/flow_filter.c |    4 +-
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.c    |   46 +-
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.h    |    2 +-
 .../net/ntnic/nthw/flow_api/flow_id_table.c   |   10 +-
 .../net/ntnic/nthw/flow_api/flow_id_table.h   |   10 +-
 drivers/net/ntnic/nthw/flow_api/flow_kcc.c    |    2 +-
 drivers/net/ntnic/nthw/flow_api/flow_km.c     |  134 +-
 .../nthw/flow_api/hw_mod/hw_mod_backend.c     |   18 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c   |  356 ++---
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c   |   70 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c   |   14 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_km.c    |  107 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c   |   40 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c   |   32 +-
 .../nthw/flow_api/hw_mod/hw_mod_slc_lr.c      |   14 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c   |   80 +-
 .../flow_api/profile_inline/flm_age_queue.c   |   22 +-
 .../flow_api/profile_inline/flm_age_queue.h   |   20 +-
 .../flow_api/profile_inline/flm_lrn_queue.c   |   12 +-
 .../flow_api/profile_inline/flm_lrn_queue.h   |   12 +-
 .../profile_inline/flow_api_hw_db_inline.c    | 1138 +++++++-------
 .../profile_inline/flow_api_hw_db_inline.h    |   99 +-
 .../profile_inline/flow_api_profile_inline.c  |  598 ++++----
 .../profile_inline/flow_api_profile_inline.h  |   49 +-
 .../ntnic/nthw/flow_filter/flow_nthw_cat.c    |  230 +--
 .../ntnic/nthw/flow_filter/flow_nthw_cat.h    |  230 +--
 .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |   22 +-
 .../ntnic/nthw/flow_filter/flow_nthw_csu.h    |   24 +-
 .../ntnic/nthw/flow_filter/flow_nthw_flm.c    |  278 ++--
 .../ntnic/nthw/flow_filter/flow_nthw_flm.h    |  278 ++--
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |   58 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.h    |   58 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |   60 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.h    |   60 +-
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.c    |   30 +-
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.h    |   30 +-
 .../ntnic/nthw/flow_filter/flow_nthw_info.c   |   88 +-
 .../ntnic/nthw/flow_filter/flow_nthw_info.h   |   88 +-
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |  160 +-
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.h |  162 +-
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |   54 +-
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.h    |   56 +-
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |   68 +-
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.h    |   68 +-
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |   32 +-
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h |   32 +-
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |   28 +-
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.h |   28 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |   22 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h |   22 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |   20 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.h |   20 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |   42 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h |   46 +-
 .../net/ntnic/nthw/model/nthw_fpga_model.c    |  577 +++----
 .../net/ntnic/nthw/model/nthw_fpga_model.h    |   28 -
 drivers/net/ntnic/nthw/nthw_platform.c        |    2 +-
 drivers/net/ntnic/nthw/nthw_platform_drv.h    |    2 +-
 drivers/net/ntnic/nthw/nthw_rac.c             |   28 +-
 .../net/ntnic/nthw/ntnic_meter/ntnic_meter.c  |   20 +-
 .../nthw/supported/nthw_fpga_mod_str_map.c    |    2 +-
 .../nthw/supported/nthw_fpga_mod_str_map.h    |    2 +-
 drivers/net/ntnic/ntlog/ntlog.c               |    6 +-
 drivers/net/ntnic/ntlog/ntlog.h               |    6 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  617 ++++----
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |   66 +-
 drivers/net/ntnic/ntnic_mod_reg.c             |   96 +-
 drivers/net/ntnic/ntnic_mod_reg.h             |  142 +-
 drivers/net/ntnic/ntnic_vfio.c                |   18 +-
 drivers/net/ntnic/ntnic_vfio.h                |   12 +-
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c |    4 +-
 drivers/net/ntnic/ntutil/nt_service.c         |  127 ++
 drivers/net/ntnic/ntutil/nt_service.h         |   62 +
 drivers/net/ntnic/ntutil/nt_util.c            |   75 +-
 drivers/net/ntnic/ntutil/nt_util.h            |   21 +-
 drivers/net/ntnic/rte_pmd_ntnic.c             |  104 ++
 drivers/net/ntnic/rte_pmd_ntnic.h             |   26 +
 131 files changed, 5500 insertions(+), 5449 deletions(-)
 delete mode 100644 drivers/net/ntnic/include/common_adapter_defs.h
 create mode 100644 drivers/net/ntnic/ntutil/nt_service.c
 create mode 100644 drivers/net/ntnic/ntutil/nt_service.h
 create mode 100644 drivers/net/ntnic/rte_pmd_ntnic.c

-- 
2.45.0

