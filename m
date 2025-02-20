Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A734BC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:04:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7857040615;
	Thu, 20 Feb 2025 23:04:14 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id CF57040609
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:11 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2168.outbound.protection.outlook.com [104.47.51.168]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeUVKVT1FnvlHrZ5z2NsHSbDigezpa7WlZs4sxM+KxC4Pu83QD5eC2RscQ+uoOHuGgoHkazPX83euDHzWWjuEOw35lNTTBvpelzJE6/obgdpsee2z83L+/RGRx0VpQSiBLxYMYr3YWXHFSBDYGBrJ5wOxQRz/Ulxe1Z1XNYxFarKQvSGqtWrSG1K1008BnTIrGzBQkBj5PCqyPSj1MTIU33j9P03qYBzf00lDdOb5bUH2Jgbrx3+ZYFQUvbLew7BD76n0590RdIVM166onoSqjUSYvjnAIGl57gXnjZW01w4h2B714kM+WRnM7qH2+NYNVjhfD1KeDK43ZIG+cMmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1LQ7CPjpZ7aPbbu2edm7daY+TI0c6eD+4M9GLjjaws=;
 b=tPEjiMsfGybi3cyQNIahTplMoBDcNyKtASBXxoPu21ktks2Y6WEGPoUw+d/jfnP81TkMtsLY4V31/UEWggaF9cixDh2gsSmhXVsbVyOwbhWnmeKFR0DY472W/ZCk0ThNn3xw5IlhI5DVCDJYD52aRK2juZCWwSVvmy0d3NnYvQ/PYXOiQK87u1L0hh3HH6JyoUHko1dE8hHuFnuWFjx0/x+SvfJoh3fCT0kfPblSVz1KzspfLpJ9QNPLL6iJ5wuOH/D5UZkAvPXoUgXBFpQxpACWK6OUylgHVDZNtQ0HMxltvAe28XYdRpq75/s/1CjHA8bjum68ms20jY0ruZRJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1LQ7CPjpZ7aPbbu2edm7daY+TI0c6eD+4M9GLjjaws=;
 b=c/ihZW4Q8Nrz+gnFbum89LPE5BveBXwWsHIUM+lnefnMs0vWPtntD+r14sFdBRm9AqSQgZn5oYOiXp5AynBjlemIURF8ukkNcqafk5ea4KOyeneEWdQCjqu/G22BtiIUX+x5kAuF5uF58T735MxiBqGj2ItN1pXXzpltFCUjAc4=
Received: from CWLP265CA0496.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::17)
 by DU4P190MB2149.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:55d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 22:04:09 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::43) by CWLP265CA0496.outlook.office365.com
 (2603:10a6:400:18b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 22:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:08 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 00/32] add new adapter NT400D13
Date: Thu, 20 Feb 2025 23:03:24 +0100
Message-ID: <20250220220406.3925597-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DU4P190MB2149:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e386018-de46-4dc2-c659-08dd51fa7ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0KAR1m9F72A2H/9Cap8mlcE3JSZN8amAE/GKxKBjDxf6tKc2br3e/t1UFzRF?=
 =?us-ascii?Q?6dG4NE2O09xRHNfwXTzMhsJDClWz7udPtBoOlvn6wcR70UkwWxJTRN97L8bV?=
 =?us-ascii?Q?d18xXxnk5440qxIQCAUHjeNqpBg5uuU1M4PrEaWZIX+ejXOOqQBXfa6q26bV?=
 =?us-ascii?Q?Gm7y+Q2Ce+SFZGQpS7Cc5DIRRbHDzOaUg6S6rCTgXpN/pbZnWrH3S+Lp2aCa?=
 =?us-ascii?Q?PEXCU0EBL783kU2Bs7stvxcHJvCSIFXXG2hQ19/xQlNGRyQW4zhwYFhDiE9q?=
 =?us-ascii?Q?aufFoLjEGXj5QqPTMNsGroi524NfM8YX8PbrdE7Zt6k8MQ2gqtLwpgUO7onj?=
 =?us-ascii?Q?eRlUTqxgy/yQTFBf+GEb9cBO5bqcbp3v7qxR5R4SlgqS9wJuU/Z4URcAW/Cf?=
 =?us-ascii?Q?5pffzXcjvyyj63jl/ss3dmFK9pk6SQ72PvH/a3QVhVg2NvGSWxG4JpYZ2vNN?=
 =?us-ascii?Q?uwRHN3ZXsgp76NJss8uS5AuaRDErsopoEMCYNV4in+TRJqfyXrxgMMSr2FvL?=
 =?us-ascii?Q?Xrv9YsOKfDCF9awc4rTc71yhWz7LrIoa7R4Q4h4jHN//6ykcZteKh1cTzlgQ?=
 =?us-ascii?Q?jMiWCXawVjYI4vTK3DVaUxPLn/lbh+Se3mImGBp+XPS6HrXmBTCp9xzHzfG6?=
 =?us-ascii?Q?mPke7U01z1mrj9lIVwmniDl2DQRJWCu3SXXbW59CZu5l0YYQ6VD5QSNXjitA?=
 =?us-ascii?Q?WsHt1XeDfZAhmtCkSFpfZr6k4Guj4/IKdVPghp0sAbPGlKRkgIA88z6F9yI9?=
 =?us-ascii?Q?8o3Ehjd9LxqDcFtZXRwl2dsvgl3V0wkrP/LfnnLuncQl+oQit1GG9JQfuDbt?=
 =?us-ascii?Q?vPmuIiKlQGW2YnQ7sJNKAJX956Fyuk+2xQEZBV7wglQkpPRQOmc/pxNmASPP?=
 =?us-ascii?Q?hFF3rtfHrHpecA6UJjuSb8FsWN5YHjZSIc/CTVjdolMntpxhx/bCqieHqKMF?=
 =?us-ascii?Q?dgMllRybUSeuDSWEqW4Q1pPW003/KCrV2rdr8qqI818nWh8VINK8Nz2Xr9lr?=
 =?us-ascii?Q?D3nGjcjjz/irQ8bDPY0pYE19pMpvdNU8BKhHB60Aa9aqboOMfCMktHs4hrxu?=
 =?us-ascii?Q?URGejz5qvQ4yppfMbnMcd+AFkr/qTm+tbDqgI0tOAsMcfgLXr/IewjjBiuUI?=
 =?us-ascii?Q?rU/WOzxOw+65mJKzfaDODP/rlDZtGJZ4A4sZGZOoKGwNoARsV5BFcHpLp/Kz?=
 =?us-ascii?Q?JrsKzduv3NIxPe6qspFCcwaVWnG6sDzPXRZ4yrXTVkMjJptJGCz7y7sg0oqW?=
 =?us-ascii?Q?CXNkHH2achqN7Sux7BmvHyyPkPGjAHSIL4962CkKJfJL9ErKr+/Sn8/y41pr?=
 =?us-ascii?Q?8QeXIg0dLsCtSVbvjcvpiU1TOjH8zoGfCzJ8Khmi+WOoU9mNitSr+bhCxGAQ?=
 =?us-ascii?Q?+RYK5qrmgUjcCf1/3i940Xr+YLehJ3DS7dn159+/+J547+26gPOVo5EtPaCW?=
 =?us-ascii?Q?Zuc9u0BLOil9Ka7BFUn5eUOMCsJbrPxpmJyhWTRhv5TWuWkfXBjKwYGO5x4k?=
 =?us-ascii?Q?jKR63zCOpkD2nqY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Og0WFnX/oSu+CQOj04KF2+S6wYIag+GsnfEV/Fnrf+eY2JVFCc2cJbH54wVka2BAg3ESvwFbsnXuHW3OEjZsViQXAsxELIJ7s6XCD0j8d6fmYkv16id34W8F7zXDkXlxa5USaFWU7eDKnigDz5nZSSW1SxLnP7IRKhdt/fg03FzqNYfS2ebL8rnQVW/8eLCECqJWmbuTCQ3HNplPio4ZhR5HKxndpJ5DYbDcbqk+C961XQE4/ckZCIAh0UkEWvTl3olyWvLoQykvCg37KcduSNLKcM2Ls1s73A9MU8BXlTmaQNg6xI9qDt5+IaNXhO5zWR7ycKU9I96XE6/j9Y+7805w7aJGE4MRxzkckwg57SQ4S6UXR8ZuPIjr1xy3Dtyd3TztnOx4qyla7na62oj4SWaGymYP/JxDtZam/uOpNyM/8m8v+tmnSZqyCCuN+A6vmjD/BdrrgOSymGITH9BV7QvAcxXO1AaYpp0ZwvqXAQkkjlsNQkTB9DRgo45lwtujltmmAeiFW+RSsyzdHgnPZ5H9KEIGvYXSzV55U46V7W5J1AqW5qPcbfEFoHQGub83bI8bRdQSt1bUREcS6ATwcSh/JkW7DHkecJlfitAanJmYBn6+zcQsUiKA98Nlv1g925wZpzwswb/50rZrfrUHWQvHVr3F3hK6hYyQgXRBS6I=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:08.6461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e386018-de46-4dc2-c659-08dd51fa7ffe
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P190MB2149
X-BESS-ID: 1740089050-312005-29062-14080-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.51.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaG5uZAVgZQMMnCNNUwyTjRxC
 jFMtHIODEt0dgszdzIwDjV3MTEwNRAqTYWAA7eusRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan15-44.eu-central-1a.ess.aws.cudaops.com]
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

This patchset adds support for the new adapter NT400D13.

Danylo Vodopianov (23):
  net/ntnic: add link agx 100g
  net/ntnic: add link state machine
  net/ntnic: add rpf and gfg init
  net/ntnic: add agx setup for port
  net/ntnic: add host loopback init
  net/ntnic: add line loopback init
  net/ntnic: add 100 gbps port init
  net/ntnic: add port post init
  net/ntnic: add nim low power API
  net/ntnic: add link handling API
  net/ntnic: add port init to the state machine
  net/ntnic: add port disable API
  net/ntnic: add nt400d13 pcm init
  net/ntnic: add HIF clock test
  net/ntnic: add nt400d13 PRM module init
  net/ntnic: add nt400d13 PRM module reset
  net/ntnic: add SPI v3 support for FPGA
  net/ntnic: add i2cm init
  net/ntnic: add pca init
  net/ntnic: add pcal init
  net/ntnic: add reset PHY init
  net/ntnic: add igam module init
  net/ntnic: init IGAM and config PLL for FPGA

Serhii Iliushyk (9):
  net/ntnic: add minimal initialization new NIC NT400D13
  net/ntnic: add minimal reset FPGA
  net/ntnic: add FPGA modules and registers
  net/ntnic: add setup for fpga reset
  net/ntnic: add default reset setting for NT400D13
  net/ntnic: add DDR calibration to reset stage
  net/ntnic: add PHY ftile reset
  net/ntnic: add clock init
  net/ntnic: revert untrusted loop bound

 doc/guides/nics/ntnic.rst                     |    7 +-
 doc/guides/rel_notes/release_25_03.rst        |    4 +
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |    9 +
 drivers/net/ntnic/include/nt4ga_link.h        |    7 +
 drivers/net/ntnic/include/nthw_gfg.h          |   33 +
 drivers/net/ntnic/include/ntnic_nim.h         |    5 +
 .../include/ntnic_nthw_fpga_rst_nt400dxx.h    |   34 +
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 1029 ++++++
 drivers/net/ntnic/meson.build                 |   16 +
 drivers/net/ntnic/nim/i2c_nim.c               |  158 +-
 drivers/net/ntnic/nim/i2c_nim.h               |    6 +
 ...00D13_U62_Si5332-GM2-RevD-1_V5-Registers.h |  425 +++
 .../net/ntnic/nthw/core/include/nthw_fpga.h   |   10 +
 .../net/ntnic/nthw/core/include/nthw_gmf.h    |    2 +
 .../net/ntnic/nthw/core/include/nthw_hif.h    |    4 +
 .../net/ntnic/nthw/core/include/nthw_i2cm.h   |    3 +
 .../net/ntnic/nthw/core/include/nthw_igam.h   |   40 +
 .../ntnic/nthw/core/include/nthw_pca9532.h    |   25 +
 .../ntnic/nthw/core/include/nthw_pcal6416a.h  |   33 +
 .../nthw/core/include/nthw_pcm_nt400dxx.h     |   40 +
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |  156 +
 .../nthw/core/include/nthw_prm_nt400dxx.h     |   32 +
 .../nthw/core/include/nthw_si5332_si5156.h    |   63 +
 .../net/ntnic/nthw/core/include/nthw_spi_v3.h |  107 +
 .../net/ntnic/nthw/core/include/nthw_spim.h   |   58 +
 .../net/ntnic/nthw/core/include/nthw_spis.h   |   63 +
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  220 ++
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   |  377 ++
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |  427 +++
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |  464 +++
 drivers/net/ntnic/nthw/core/nthw_gfg.c        |  340 ++
 drivers/net/ntnic/nthw/core/nthw_gmf.c        |   41 +
 drivers/net/ntnic/nthw/core/nthw_hif.c        |   92 +
 drivers/net/ntnic/nthw/core/nthw_i2cm.c       |  139 +
 drivers/net/ntnic/nthw/core/nthw_igam.c       |   93 +
 drivers/net/ntnic/nthw/core/nthw_pca9532.c    |   60 +
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |  103 +
 .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |   80 +
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   | 1242 +++++++
 .../net/ntnic/nthw/core/nthw_prm_nt400dxx.c   |   55 +
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |  142 +
 drivers/net/ntnic/nthw/core/nthw_spi_v3.c     |  358 ++
 drivers/net/ntnic/nthw/core/nthw_spim.c       |  113 +
 drivers/net/ntnic/nthw/core/nthw_spis.c       |  121 +
 drivers/net/ntnic/nthw/nthw_drv.h             |   31 +
 drivers/net/ntnic/nthw/nthw_platform.c        |    3 +
 drivers/net/ntnic/nthw/nthw_platform_drv.h    |    2 +
 .../supported/nthw_fpga_9574_055_049_0000.c   | 3124 +++++++++++++++++
 .../nthw/supported/nthw_fpga_instances.c      |    5 +-
 .../nthw/supported/nthw_fpga_instances.h      |    1 +
 .../ntnic/nthw/supported/nthw_fpga_mod_defs.h |   11 +
 .../nthw/supported/nthw_fpga_mod_str_map.c    |   11 +
 .../ntnic/nthw/supported/nthw_fpga_reg_defs.h |   11 +
 .../nthw/supported/nthw_fpga_reg_defs_igam.h  |   32 +
 .../supported/nthw_fpga_reg_defs_pci_ta.h     |   33 +
 .../nthw_fpga_reg_defs_pcm_nt400dxx.h         |   29 +
 .../nthw/supported/nthw_fpga_reg_defs_pdi.h   |   49 +
 .../supported/nthw_fpga_reg_defs_phy_tile.h   |  213 ++
 .../nthw_fpga_reg_defs_prm_nt400dxx.h         |   26 +
 .../nthw/supported/nthw_fpga_reg_defs_rfd.h   |   38 +
 .../supported/nthw_fpga_reg_defs_rst9574.h    |   35 +
 .../nthw/supported/nthw_fpga_reg_defs_spim.h  |   76 +
 .../nthw/supported/nthw_fpga_reg_defs_spis.h  |   51 +
 .../nthw/supported/nthw_fpga_reg_defs_tint.h  |   28 +
 drivers/net/ntnic/ntnic_ethdev.c              |    1 +
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |    2 +-
 drivers/net/ntnic/ntnic_mod_reg.c             |   47 +
 drivers/net/ntnic/ntnic_mod_reg.h             |   25 +
 68 files changed, 10709 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ntnic/include/nthw_gfg.h
 create mode 100644 drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h
 create mode 100644 drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
 create mode 100644 drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_igam.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spim.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spis.h
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_gfg.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_igam.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_pca9532.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_phy_tile.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_spi_v3.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_spim.c
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_spis.c
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_9574_055_049_0000.c
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_igam.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_ta.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcm_nt400dxx.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdi.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_phy_tile.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_prm_nt400dxx.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rfd.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9574.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spim.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spis.h
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tint.h

-- 
2.45.0

