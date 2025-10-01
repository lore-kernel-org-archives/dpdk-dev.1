Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2008CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E91B40667;
	Wed,  1 Oct 2025 17:10:26 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 10487400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:25 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021100.outbound.protection.outlook.com
 [52.101.65.100]) by mx-outbound22-252.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAdmQNN8ESBpgTF/9UOmFFkggfAunCkppjY+Qj2lmIKQx6FDeme8nGspIlAMHtaW3fLJa6OAmWbdcpMVrvysN+mMYftiJ05hYB6R9TxtgVnVaNV745nKhkZMomSE81rypkLecZ8hBpGfcMlnUcVqHRSqs91hLTa0vqJUgQewD9kzmgffIWgUYMAV7bpIgwleJjpsM7KrQ+a8RPU43vBCa8+U/3iNBKIFcchF8S7YrDVPCWbUAmgz66h1OAjca1n4dW24X/LP46N0cDv1KAdra+52gfVfr/T6YWhqg6OvWMAybaiXnXa/dD5J8usU721VwbQ/dJzo//EGvQY/ezrIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwqrRh57pRRGFl6Z63/QvoDYoJllrDVUj+dSSsQwBmg=;
 b=fgBlFib4boBjINMaDtoYyMiGUaiZRRZLBVhf1movtfnkvMcMd2K8ERfUdq2Y0ndU2WbrVD/LL62qvbXGEJXbtRi6SV33TVAk5X8Wzsvow9Ps56zLFm31pJII/fl92t4FzT8dBnooXlpAv6Y6ZA/obaENPgT+ejXAdrRkUXmG90LyCZ8eQjFoUCtVqi3gSeOuTbkFRD3EruoGs3mv+OpMoOFL2Q/RRSsL+QyjsHS0dewNOT3OLSyV1okoRn39fasoTDqNOQOkmjiQWuc9+wxcXUtpmdoBKcV4oSfZE7L23os/wjAKulUy5tIvP45WBB16oTNmuiVxwfGuzVPeGuC5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwqrRh57pRRGFl6Z63/QvoDYoJllrDVUj+dSSsQwBmg=;
 b=abBn9FOhKGs7ChkxdljxnmnxgwKkbWdTbUkBXVP3fB88YO44tCyS7MW8hmb+R/PVy5JSO9xIROIYy991MuwwYneVkXQY3OdEs/FxJp6Ki19BRkLULAzIpYlB1sc0jMAzIU3wopwV7/Q5LIKYjBXqM+gbkQKswYUri2RIjxjXPl8=
Received: from DB9PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:1d9::16)
 by AS4P190MB1903.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:512::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:10:22 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::1c) by DB9PR02CA0011.outlook.office365.com
 (2603:10a6:10:1d9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:21
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 00/20] Add NT400D11 support and new features
Date: Wed,  1 Oct 2025 17:09:42 +0200
Message-ID: <20251001151018.250671-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|AS4P190MB1903:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c5d29fb6-f40f-4b01-fe07-08de00fca43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WpUcJk+N0Bx5+kKomD+KGOtfphlKqtkADzkA4EBXLmow49sGBbrDQ5C0rI+R?=
 =?us-ascii?Q?0BvB/X3HMlmUPQZJBQzGgat8SCJNXnntjl54YA//0Mm+NSyMRTvpqi4nZZ2/?=
 =?us-ascii?Q?PPDzW+Z9fmcHWfzljMNfZJZsTghEJ7Zae+JrWfD2fuBK1iDS1zJCEQjmKjw/?=
 =?us-ascii?Q?RDdNcysOPefK13omA6R++kR0UDu+eApRpV+MYtnSGVWLkgW/3nvIVcYSKgrW?=
 =?us-ascii?Q?cupdk5z3YbnJ53ZKewf3L0crOcBJTOPiUFET2O8h2oH2ApiaVuhVEPDbbzO+?=
 =?us-ascii?Q?994q8WSpcP8ACxP59daBYrJnmHhRAQANwiiH4AwD6hRRm98M9mky3IPf8z3u?=
 =?us-ascii?Q?aTuUvqpQbdn+YnaeNyNZjAwzntd+zZD7QcYHw8zOYlolu7DJhtL81ssE2z3f?=
 =?us-ascii?Q?9h+xv1a0y5eA62n5JpXVpY8V8SyKt23n3/jU5iHza4aE87KOFlH0atVTL9gI?=
 =?us-ascii?Q?hSiafNoRQDmqHsJw1N6TJPiCqpyPiIKLQPvhsIpxdRoSSEyQsSjIM/qohZwI?=
 =?us-ascii?Q?z0j9cjtm8UcWTdv6/XnxkCmOQ4OC4Fgb+sgv4Y/nWkF+L+GEd0zPuBQZBNkF?=
 =?us-ascii?Q?Ze5C6PGip0gvLZe31cjQnybZsUbEIxGMPhylMGGBNJaIq0vtnHgFtie5xA+E?=
 =?us-ascii?Q?vtD8SUte2xO6AMiMjwXsn2xUQTUq8PxP7XGlignzv8TDZYJ8N9jPeIZi/xXu?=
 =?us-ascii?Q?QgTV17O1dd4CD50XnJ5uhUQfPH86Z9DlnvoLPLOnOdEd93U0/8pSl0rKrhoL?=
 =?us-ascii?Q?25O5jIkj2kkB98ECXFDHpxEyAjx6On2YJdsulsoyvvk4D2eg2mZBIEohgGzS?=
 =?us-ascii?Q?Crd+4r/thp92GD1J4Hde+Hm47axKcK9HEX70ZQGOw5xn43HyABjCj8lXtgdT?=
 =?us-ascii?Q?gIiQPjim8kta2VQj1IcCYuDB24QDxwH+7MHwvO4faAyJRQdWprRJgWXk5qeV?=
 =?us-ascii?Q?m7z6oe8BMoix7+GX++zo+VIY/XVLrK2D87GTypd3J/z56ZCAbFaEXQA11qTY?=
 =?us-ascii?Q?USSypiJWeO9hzHd9QZ1F16Z4Hr/fQYiyFfNsfdqm2klGAmj0m7Ivr7lSdZDZ?=
 =?us-ascii?Q?VzC5XxDb5taLl1L2ljp/XHmNJSmj2t2vFDtlfOZwVb3M+Q2CF3PP3KPV0GOx?=
 =?us-ascii?Q?eirkRLMsoTy99W/DcNCJTTVegD6K7z9IXNKOmUuvkQb8JD6lf49V1iiYQNts?=
 =?us-ascii?Q?jRRjFEvvTVeyHWrTUr6tcQl/GrmBkvuQCp6gl+cPeS1du5LJ2gVUgWuW1k6+?=
 =?us-ascii?Q?9iHzHdfNJu7roG27jednbE1x5bqYfGKreKuVScXq8eKsbAJlXI+GkugUR92z?=
 =?us-ascii?Q?fqeCrC09AgDLLV8n4l9qUJITsWHOI4ybNaTqKf2SfmV5nmcwcbYE3SP3GiAa?=
 =?us-ascii?Q?C/9Dex+Ksv3KgGFcbP/v2/shfbfqd8vEDQ2QxtPYjgFF4MDg7CGd7bb1pyPe?=
 =?us-ascii?Q?fMW4/umRTh1IFq+Z0GpirTWKm8/cIf2TMoy/4Y3iBIrdQyCzCj7ZmOadUeiK?=
 =?us-ascii?Q?so4QwqejUd1HvRPB9MnCFjHbWxkvQVrXW/eVT4YlLd+un/mDCUcrRmqBVE8a?=
 =?us-ascii?Q?QX+hT98cYuY0pt1wsQw=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2wEMlAXf5+hVyeNy/HTAD5GFYr8/acW0/b36eXo9ca0SGL435iMOva0A3UV08UVUd8/kXc5d+4zc61N6BsO9zdSDJINgdCmjE+ouYP36pqtAAAbYs6yfG2kI5P+wGU++1FEAVAvkcmLEg3pjqhuydpme8XzJwzGH7p+aCoet5bg/wnli3H9XUOQYjcdyGvNlAwW5ENAv7v2TUbbX1TZp0Fan99ycCGfZOt11VCaj47qUedeyXnQcguci5EoQepf9Z4d76VEy9mEGrHI7EouHNUeSnbmjMMNcLR8P9a1gW4198mODrDARkv0DUX+Q1ZhWUc5I8YXxIWGN+HRQxTeIf0EB2TLh7mzisaIjAU3gSBtRZJE1491LcJGNY1ROxgu+7+OA7yiki2B+KAFVxQc/l89kffu1HLm5ai2F76w0ZBYExAFBZJuqWGMDmY2uGuZrsY+Rw9yMuYE17G5/hk0ZAmHMr+50Kz5LXeD9V6RfGUHu6vgxhiUFgq5iCB2oe0Nb9qxzWL9ja+us3n1Nrsh7TDS0LHmpQuqbH/rjyqihugv076+pVbSDoy6oo99bLg4JUwhOTnhl2WvS7T9RlcAEZsdNFXU/9x28h+WVqc98sQrHN6iYpASjp7P3VpKIlX/J0/areh8QFsckiGaduBWCqg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:21.7973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d29fb6-f40f-4b01-fe07-08de00fca43c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1903
X-BESS-ID: 1759331423-305884-7641-4368-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.65.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGhgZAVgZQ0Cwx1cLSwCDJIN
 k8NTkp2djC2NzC2NLY3DIpxczIJNFAqTYWAOTQFPNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan14-203.eu-central-1a.ess.aws.cudaops.com]
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

This series of patches adds support for NT400D11 FPGA and implements
several new features including pattern matching on inner Ethernet and VLAN
headers, exception path handling, flow query with count action, flow pull,
and extends flow dump with MBR configuration

Serhii Iliushyk (19):
  net/ntnic: add stubs for init NT400D11
  net/ntnic: add reset setup for NT400D11
  net/ntnic: add reset init stage 0 for NT400D11
  net/ntnic: add reset init stage 1 for NT400D11
  net/ntnic: add reset init stage 2 for NT400D11
  net/ntnic: add reset init stage 3 and 4 for NT400D11
  net/ntnic: add reset init stage 5 for NT400D11
  net/ntnic: add reset init stage 6 for NT400D11
  net/ntnic: add reset init stage 7 for NT400D11
  net/ntnic: add reset init stage 8 for NT400D11
  net/ntnic: add fpga registers for NT400D11
  net/ntnic: add support pattern matching on inner ETH headers
  net/ntnic: add support pattern matching on inner VLAN header
  net/ntnic: add handling exception path option
  net/ntnic: add flow query with count action
  net/ntnic: add flow pull
  net/ntnic: extend flow dump with MBR configuration
  net/ntnic: rename hwlock
  net/ntnic: rename nt log types

Stephen Hemminger (1):
  net/ntnic: make flow lock local

 doc/guides/nics/features/ntnic.ini            |    1 +
 doc/guides/nics/ntnic.rst                     |   15 +
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |    3 +-
 drivers/net/ntnic/include/create_elements.h   |    2 -
 drivers/net/ntnic/include/flow_api_engine.h   |    2 +
 .../ntnic/include/stream_binary_flow_api.h    |    2 +-
 drivers/net/ntnic/meson.build                 |    2 +
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |   41 +
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   |  380 ++
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |    1 +
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |   15 +
 .../flow_api/profile_inline/flm_evt_queue.c   |   14 +
 .../flow_api/profile_inline/flm_evt_queue.h   |    1 +
 .../profile_inline/flow_api_hw_db_inline.c    |   54 +-
 .../profile_inline/flow_api_hw_db_inline.h    |    4 +-
 .../profile_inline/flow_api_profile_inline.c  |   94 +-
 .../profile_inline/flow_api_profile_inline.h  |    3 +
 .../flow_api_profile_inline_config.h          |   48 +
 drivers/net/ntnic/nthw/nthw_platform.c        |    3 +
 drivers/net/ntnic/nthw/nthw_platform_drv.h    |    2 +
 .../supported/nthw_fpga_9569_055_049_0000.c   | 3132 +++++++++++++++++
 .../nthw/supported/nthw_fpga_instances.c      |    3 +-
 .../nthw/supported/nthw_fpga_instances.h      |    1 +
 .../ntnic/nthw/supported/nthw_fpga_mod_defs.h |    1 +
 .../ntnic/nthw/supported/nthw_fpga_reg_defs.h |    1 +
 .../supported/nthw_fpga_reg_defs_rst9569.h    |   35 +
 drivers/net/ntnic/ntlog/ntlog.h               |   16 +-
 drivers/net/ntnic/ntnic_ethdev.c              |   44 +-
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |   85 +-
 drivers/net/ntnic/ntnic_mod_reg.c             |   15 +
 drivers/net/ntnic/ntnic_mod_reg.h             |   17 +
 31 files changed, 3976 insertions(+), 61 deletions(-)
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_9569_055_049_0000.c
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h

-- 
2.45.0

