Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0E9CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:43:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4F3940613;
	Mon, 20 Oct 2025 18:43:43 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id BBC67402B0
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021100.outbound.protection.outlook.com [52.101.70.100])
 by mx-outbound44-20.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djDgzjbkz50nSM+5ftYb38RWe96J/j51CKBEK9bJRDP2dosRu0CWS9qPmYtJ++lR+uGKemQt0sp7qvt5moD4afhNL/laefiasvblKalSlqg3QvmYQyStraviTx+BMQ5Le7k02joKfJZzb1AlPc7oGHaemIkPYwm6YdQNS6Q5dTxlzrMwZIdAVyS0k7g03jnhX0y2NZ4JGGuOmOmwbcLk8ybPI9SjPf7Htq0AesPZ5nJ7/5m4PAOfHBjDUg+ywElgC+Vz3AvunOwL5nvJhPltoIJyAJx2XDj/3+SjkP5vrd6YiNZ4m7+rvmHv4syxNggBtK9t3+NAmlrZVZFLv96zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8GHmHded8YaEOf9QVdA16JvWUgtR1/A8zrO0Doa7ps=;
 b=oypwL8nAm/YRliqwu0jCg0p27OTgsP1NHBSyT5hehPoPxdMbjwI0+Cvx5zBotCXhdmEXXf2xqaV+I1T7GK44JnsA+/3h0kvDG02/U0LrblYzoZymkiChfA4EqR6C4bWQxr3tk5q3Xok2+7ybhFZBCCpeya7WOYsNRHqgiNKeRyq/r7q7euusutgzDYWl1+r1N/evfXABiMRTJRFTAKf5xJinlpTE3UD6hsVPQ6yLaPBSl/U1CxVBPJ3k6++dHHLvy2d/SfIJLTOMhA6Hn+0gOnevthn65xkvlI9thUQ4AHsgiDBRzKQjW+Ou2cSSS0XGBk1uBTjQ5wfBDKjH34SFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8GHmHded8YaEOf9QVdA16JvWUgtR1/A8zrO0Doa7ps=;
 b=libbEU2IcR4nm5WyfcvCshwDOqH4VTf+3wvdSTkdvmGBa2AEa24+YuNjlSSzO41Rk9Agmzb6MH5A85/aXGa3FhtZIXWxlDPFvPJtRRlR25uUWkMyRYrdKL7IgE9jH/3/p8MQEHX4mehPkuQotuPbhpp975wNi0gWokhTnCTzdgM=
Received: from DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) by DB9P190MB2011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:39b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:40 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::a7) by DUZPR01CA0024.outlook.office365.com
 (2603:10a6:10:46b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:39
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 00/21] Add NT400D11 support and new features
Date: Mon, 20 Oct 2025 18:43:09 +0200
Message-ID: <20251020164336.283664-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-21-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DB9P190MB2011:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a1c86f42-b511-404b-07a8-08de0ff7d272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mExvNI2uMZqtUjI2TYrgDNAHdOK3nb2ijvUfsjh2EY2RVAY2OKZrepFlY0M4?=
 =?us-ascii?Q?kgGgIyKpt9lJbxSUNRR4LnOlVtiuG/fNKfxm/JmX1w8pUQAXm2MgvuH285Ze?=
 =?us-ascii?Q?KstAAA+o/L3Cm8gMq1L0mLx+n0Q9s8kXM4VdzY0SoAtyOg05fK8oleq+UzZ3?=
 =?us-ascii?Q?SHjeE/d+P/pmgYl7m7C+xEAEGhYsoVHr+XkWxPZDSxSjDJHExuRjLoQhp1Qy?=
 =?us-ascii?Q?8le621oPPgMfABUCDBA/ggB5EtyoLtL+vChsycrrImNC3JNWUlimf99q5kKv?=
 =?us-ascii?Q?M5GBQDI3rKgAAlCZUsmF0s9LlyOMK3J8uOZhTtZ1rGl7tGO6U9HarDD0Wo7C?=
 =?us-ascii?Q?5iSdGQpiTB/usr0xLuWD2e5okKqFKfdX84IBEe+TgSzqofjbcT9L/UWvaMPI?=
 =?us-ascii?Q?eDDhGR/W1DpN2Z1CvwMHLsvvExi1ZO4z1zSz7qupTlTX8B8HfKgYrAcPl6EF?=
 =?us-ascii?Q?Lkzn4hz6pk+HFY9AWKXFx0khbxPcPf7Bc4eRH76Pc/65dpCNT0hd4PbbOB4L?=
 =?us-ascii?Q?ysFYxLkYKI+ue1w6WvoPLiMzs6LRlrbSY7gb1NWU6W410lRckczATPoxltkz?=
 =?us-ascii?Q?vyj9/KFi/LhV6Hdxbl0zaE/iUQDygO+yrFtv79YocS/Llv3vB5MuhRMYqBGA?=
 =?us-ascii?Q?4g+47ZBKs9SaN+tFR2FQho8yh5hPEAyyWaYYLET/hxBSjzwH/5AJ6qUSvF7W?=
 =?us-ascii?Q?j95ucC3QdUEdvJVSzvPxjwMdrMUf5YfKYTfeBhYnks22KoShq4Y0hntZhlTU?=
 =?us-ascii?Q?eGwiJgJ4wIil+RbPQRlE3RVkucluCnQ1Xo19Z7wyDZfAzbXGP89uHTuVshnO?=
 =?us-ascii?Q?Z+aV9wriTzShQBcxwFl9s+bmkxgX7DiNnkroFljL/wRnkJ2yFCEdQRVvqPK1?=
 =?us-ascii?Q?rJeo1xb0QIV32ULLWWmsIN/BbYFCTQK+AiL6Y6+lsWDAprNQGUnPzfzZVTCp?=
 =?us-ascii?Q?F5C2YRCuyS+9LwF9KFwY6MJVevfqWTiU3Es1OcXC+U3CKRBbh91hhA/Bmppe?=
 =?us-ascii?Q?xwyjyjUA3nBl7vANKEMkqIeqjper/C+PT8M7BaXdUevMqU2EdkIrAd/6NcQx?=
 =?us-ascii?Q?X/r/p6OJ0ellpRZLVFr1GcVIX6tYnA6NBNEshs+amFaz3MV9hl7hB1JhpJ4g?=
 =?us-ascii?Q?EEB0UyqjbD5wOBncCUkRReJxYN+H7qrYR8O4xxi9vZzHb4mnDkqRDcbZkzji?=
 =?us-ascii?Q?UBvv23S/9ckdfkzJ+jWopKeVU9zwqIGeVyuXvLiSxCDQ8i7x/nQQhimT5Ng3?=
 =?us-ascii?Q?aKqvkVk8kuDpSYzoSiyISts4fx3PnAyGpMm8Mvnogl8gMhyIVxY3f7F2PgZb?=
 =?us-ascii?Q?nt/jNtFRvz9nOfLwOppGPk/6WpQW0vwMBkX0PoA7hWshC99OBWnuReubXMFJ?=
 =?us-ascii?Q?YCK47WoCZYrihca1AmokFet+R8JmuPN9BtdgB8XcM3/idSUwKMdp4UB9ANaA?=
 =?us-ascii?Q?Y9I8q4z6a9n6xL4MQEwpN+hIemkP2rrbpKh9/rSoahwMZUwDepfPCZKsemwb?=
 =?us-ascii?Q?AsN5OkIuPV4yrPyo5SP5rJIFbp6XC/3t2/1/qxtK6h+m5jPb1vokoTLYlMxt?=
 =?us-ascii?Q?3tyzftFz0ilmErjhQaY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uFr2LY3K+x59ih9zATHqWfSZ/Ca6x9SzOOu3mYc47zFG4bORH0te/QfihC9mest+mi9KlbCsQ8DLpKiojP47HGYIB6hvD1TE093+QvkYTvFMyP3zYkxLi8ll/rYTyzLJXg/4GulSwNKJGLcmDZED4sHMk1gH4lzy/TtUHt2UGxkvwnu77354C+XcA1OnS1TIeR8Q2SwQ4QLwR+zljsNT3s4FUTRo62ftNjeb+2ws2TWDwby5iqcpu7uS/ulDWn58WUd88khtFsnvXR8lKwQMzOSuSoxPgDNCpB4bXgDqSqBq1VSb1uqh1qzUXrsf/dtn+klA2cEJuq54Bd3y142tSgjdadtusY1NakS3LSzdmbnS2/QosVQ7VFtq2IusbHdIvGbxNye6HNW6mMqNIqXhwTBhqNDaJmt+XHVWxg+//e4qupWUlg+JSMVUU6Eh8cNRk+R2/B+r4tV0MKBhTPzelwrtv9oHvm0zZkJ7dVCmkqRjhbcF/cUviD5Sn3lccqUqKem+gd3gK60bImQw6WGPHr+gbVUiRr/iI3C9K+wGcRJKaXmSlbum2wyXhTmdXAHUBCybRuDKww6G0zjD9XcWtg+N5tfILPohVDAucwTsbl03H33LYG0hfvqf6OM9XWCIufAm6bRQmEGgHwWO4AcdcAzqp7ESdT96aEiB9NqY6eo=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:39.3711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c86f42-b511-404b-07a8-08de0ff7d272
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB2011
X-BESS-ID: 1760978621-311284-32702-8330-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.70.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGpkZAVgZQ0DI1OcncJMU0KS
 3VyNzcwtDC0CjVwCjZ1NIiydLSMjFVqTYWABzKG8NBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan18-109.eu-central-1b.ess.aws.cudaops.com]
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

Serhii Iliushyk (20):
  net/ntnic: add stubs for init NT400D11
  net/ntnic: add reset setup for NT400D11
  net/ntnic: add reset initi stage 0 for NT400D11
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
  net/ntnic: fix potential name conflict

Stephen Hemminger (1):
  net/ntnic: make flow lock local

 doc/guides/nics/features/ntnic.ini            |    1 +
 doc/guides/nics/ntnic.rst                     |   15 +
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |    3 +-
 drivers/net/ntnic/include/create_elements.h   |    2 -
 drivers/net/ntnic/include/flow_api_engine.h   |    2 +
 .../ntnic/include/stream_binary_flow_api.h    |    4 +-
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
 drivers/net/ntnic/ntnic_ethdev.c              |   48 +-
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |   91 +-
 drivers/net/ntnic/ntnic_mod_reg.c             |   15 +
 drivers/net/ntnic/ntnic_mod_reg.h             |   17 +
 31 files changed, 3982 insertions(+), 67 deletions(-)
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_9569_055_049_0000.c
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h

-- 
2.45.0

