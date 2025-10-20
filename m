Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEBACCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:36:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9CC040611;
	Mon, 20 Oct 2025 18:36:32 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 245DB400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:31 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021095.outbound.protection.outlook.com [52.101.65.95])
 by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgqjHNZ9ZEWY9CKwAyj8wddg4ogRKXVnBMGLCLvcfcEDw1U8bN1SPIPlss+vWp0yAK2x1QTy5ZQ1A/n4AWy8vaFcL95sRTk3HImufZaoQ/paFXROInzZHTeLRc5p/Xw8pPzEB6cTLpBdxHTHI+4JuD7YJ/vNNBMszJlKgSeLrN9yfkWziyI3FbfdsDrzDTcdgU9EuYlsy6zM2Mph7lgkkZD62HDBz/pEn8xIb8HRkdwe6iyebn5lXLj7cWm8M9SGMNYFTjV/Thm8tN6tU4SdoGdcxz6Bz/AxjE5fFx/1KSGjc+ExrD1pRwYQyWnjScOpNbtp6+7ETYcTkTHg9fdGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcYQWGRv0Q1LnBT0K8PuA/vm7aUlNEc0lAAd7bK5tYY=;
 b=LuhO5N9lrlBuS7/bSW8OU81gOUGwbRaKC6JwCz+VRmW9PI5mzrtnQZNJuDB02ejjm+aUYnFl9E8HO1wRi6kXzfGHrUa5YisZgxrZJNdfY/Cjd6f3zMDi1Bl+cd7DlLenoIuimzJ5wZT4fKJc9zk2z6nwydL6ed18DuoTC6bgJNRvhC/NwohuD4xDoeViRxNbF6eexThnUhD3Je1/MBIe/0bUvEP0LDlND+JxT7GI/w1fvxZ23zEjo9PVEhOjlVZKgKmt7soNqklDWMPQ3fnKKSbwt5Dgz3IvwXDeacnQ64/qKZXgsYHZoGFYGOr+8EWc748fuTKgskpc64nIYmd3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcYQWGRv0Q1LnBT0K8PuA/vm7aUlNEc0lAAd7bK5tYY=;
 b=Z9SmBwVW4lPeqDNvbjxmb5SIo2Cf2Xp1kePgM/w23re4GaeQP1wz8KVYFa7PenyN8AB/vdALRuHFhG/0R8TE0bJ4lnn3bL5XTHUR7YPOI5bU03G62KI7dTvAoVPw1gEjolJuR006hd4Ns04j3ZZwndd+BE3+rD5NxdtbEcr3YYw=
Received: from AS4P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::10)
 by VI2P190MB2238.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:27 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::f3) by AS4P191CA0027.outlook.office365.com
 (2603:10a6:20b:5d9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:26
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 00/24] Migrate threads to the DPDK service framework and
 refactor naming for exported symbols
Date: Mon, 20 Oct 2025 18:35:51 +0200
Message-ID: <20251020163620.282312-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908141740.1312268-2-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VI2P190MB2238:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2a06d9fb-fb63-4171-c8f4-08de0ff6d09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XBqL1G4sWGzLJkEtSRm5DjEttkI7KLLyhPQF0Rga/VCSi5DTNwf4ygL+8eI7?=
 =?us-ascii?Q?Qj+jgnMXiEN8azTgQrfDyp3T7mdbQTwdeCtn0RXn4z3z+sxnzrACWYp4qYtt?=
 =?us-ascii?Q?CpjEBUGoKdOYWaduNSh1v7H25qfvDyMD8Z0A2C821JMofhnOUZiu7QCQ1Xg9?=
 =?us-ascii?Q?cj1oWecxDRJMDBmQTBUI00sAz68TLARJQRu2ClvSt5srrTh+Mihk2Sn5J3dV?=
 =?us-ascii?Q?U6WvDLhk4BfXdEdLx4nHzHy9DwD9Y9OUXDkijNAnhSdRQuM9UpuUOjRSzK4c?=
 =?us-ascii?Q?JSvajW2kYZfMKnpwh7fnecg3SYdO/xf6gyUaZfQmXTY8lygV+d0ISIk657tf?=
 =?us-ascii?Q?/7M8wpUmau2fL9gxFbaOSZIZInrGwNjNiE8tne6XM1eMocTXSMKqu1A5Iodv?=
 =?us-ascii?Q?D/5Sx4fcrnWUA7BU+VYmAfPLBOjESFimZlarHX+zflP8xKlqu1BHqL6Oocxe?=
 =?us-ascii?Q?uUE0gfMes6Nuwnu3idZlNmPOYvC2HiJ0XlvvJvtmdtiKSCU3zZ+tTiRcENqS?=
 =?us-ascii?Q?74IzqEg/SB2EdFw3JGBURaDkZjmo1G8Qo0Vxt1XF007FWNsWu3sTaCoQc19z?=
 =?us-ascii?Q?ooAHReCeV5cGo/fW86A42ZLBGjCJvF667PW42rBDa/NjuNF9usB30Yy2kucg?=
 =?us-ascii?Q?zaTgcVhKFbX2gqkcd49gOHBqLPOMrNXXePvoTxcFgsbZD4lwddxNLI6Icml4?=
 =?us-ascii?Q?mQcUMR9vzkxQIeC/llubTm+AXsL2XbB1molLyiSntsw7aLsjn+qY5bk97Is0?=
 =?us-ascii?Q?2vTC8sXuQZmekploBAcQnHRUL5Nwaimwx7ACa0p6N3ZJIubfX4Mn+ZtLboO3?=
 =?us-ascii?Q?f1H1M59BtlVGiMJ6CZpM4GUh9qk7p/Zu2L6u2DU4Gcaq1jgbYmI8g4cFJUh3?=
 =?us-ascii?Q?w+X+oM+4BqofBgdIp6NF/yApfj54sPn56XvlzNTLNdy04APVlR3PaPpdNZUV?=
 =?us-ascii?Q?7f4BlmJ5+9SYJr3yeGybFUIXEC9Oa6zjkBlxM44UKV3LqY7fGX3F+LT43Fye?=
 =?us-ascii?Q?NKK/DYodziBaEzK5Kq7K1iNgDYMSyq+l6cxz+PSV9ThKxc01crQznhV9qSJs?=
 =?us-ascii?Q?SYAZmBKrPm+EVxcbH+c9PdJh0tiEe1FTA0U7e8wvV2iP0cTU/026L522bNjT?=
 =?us-ascii?Q?hRrjnPa7mAmdg+DCDFfpU1e/2eO5W26etb+zPksw2W75VEL+iJporn1j2CsB?=
 =?us-ascii?Q?N2tqnrZ+l+zxYQLAOBoEQrcasgCRyfzE64AwJvZ9t3VM3yznViXTiQs5JsvO?=
 =?us-ascii?Q?yZAr24/PCnoXu4yA57/8MWfDgj7zufaTpRriBmMGLog2tQ9iHY9wWuUIFvUZ?=
 =?us-ascii?Q?5kWnL8SnsjZCa9C/W3DvbXyWS8PwAvZt2lUG3ZzLqLYVfrU3WsLC/MSEQii4?=
 =?us-ascii?Q?1Alk4kbs94uiJc1h6YOwNLlFiDzwfIrhXCWAEDtyf7FhkQv736Yqhf21QlNW?=
 =?us-ascii?Q?X9KbPdVmJHkIgxR/I8uzJltjzmSoy7ZICovjsqf6vwJCjYKYRmRzJiQb+UAq?=
 =?us-ascii?Q?XOXk6cTvD6I8pYh3pD3dIUTwMCvq9iAtpe39PHJpkcqJsLgfIIJW0xN3i6BO?=
 =?us-ascii?Q?GrVtxAo8BpIymt2Ypuw=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m4UOJZHJR5gqjtUkSir/Tq92t8j7sHjDUIymGHT7UwZFREun51Jvp2o2Ik+USk/iNklAQLl9WELjS1DZE64hIM40gVRArpKr6tk4cldfDKSx2sGPj+MVLrH0VJunFy5z0Ue1wonmBv4woZzXR3avSNwE8w9qX0dfmLp5qZ4xz1KT3KNLDrW84WvZFZPeXqvD6KmpvFgmZaKwtJAsp5krTMbBy181o17M3C5rDHKukU1+7ddR6/CSkrbIBHOR7gpbrVy9YBqTDL0MnFKhWF0b+VXJJAQpYSAeW/ZiEX8XjfJcp+tY53W8obJKu9FQldIaAuxpyPRENJsAs3Vbgt/9e1lm9XdQN0yNniqD3jjsCO8w5dN2paMPbpR4yQabK9wXezBhY9aYBp/3uEfVgLfgpC27xuxaC72vJutbAM+iSKfgmCgEsFBD4qhhS0tuK3Pgqg1CGTbnOlAWNDrBRKN8wIJjJGY7i/74MCGEHgylVou3BYyyGFgBXOld5C/B54QXHWG1augFA2M+cbYPbHFRNoWflFfO/SOvm3w6Mzlt67uUfgnJ5pcaZk3qvRuhOHPvbUaPkwFs7vXLiPVXbui6t2f5pOw9GCzCNdzjT+nzoy+EflowBJoQlfqVsuDA/NwPwoQ4j9M2EQbxhbNt+FLohuqQubxIX+GUahyuOVoPJqI=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:26.8136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a06d9fb-fb63-4171-c8f4-08de0ff6d09c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P190MB2238
X-BESS-ID: 1760978189-303027-28482-63511-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.65.95
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGhgamQGYGUDQtySTJwDwpyd
 jEJMXU0CQxzcQ8zTDN0DTJ1MDUyNg4Wak2FgDVZvQiQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-174.eu-central-1b.ess.aws.cudaops.com]
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

