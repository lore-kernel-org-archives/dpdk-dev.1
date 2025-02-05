Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF44C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D253402E0;
	Wed,  5 Feb 2025 11:46:00 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id B8C99402B3
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:45:58 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNfEuJnDLL1D8yWD0lTKp6PvFTPAPJpPX3FW8dfWetZE/I9/rZYqnyG+uCqUHJJnUNE3ceYlxO0ao4ifB4Y6Z71q2k8ZesbTqQ/VdwKKTILeG701d53UOSplUDSZkw1fFDa9SWQoWFXmfKeM5i2E5RiVUSYlu7e2U63Y759baZurQcJJuVB/9ch3iQAPB1SL+PKcS0JphjqqATQMvd9RU6YqnytZ2lllp76VBi0tZcmF5sHN9HAgx/PzFiEbh1UXtu4nQbJldaErJ/vwyPpN+MT9L8a0hnR6vsbarSyljpy9qfuGweQ79uSfg4zh0ITo8jK82JAN5xW+wmL1IG8btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRG74nyhrXnPCZ5F+fkDo/6B79FhRMztI3CM2lXwvZA=;
 b=GF9peE3QANRXHbZ1awa1HsIhW1mzyz7Dc0TIGTqsMMhqphTh25hxBPTlv6k8rclvTuZ3euFD+L9wazTPru8LhfhcegJ5eDfSadCve9aBFlNZuhF7KOBOsUZBet7DYR1J0xm2G9n2ZugpRUyUmLubnf7svBXpkJRdT622AlLpMjyCa2jMKfYKrd53XQo1NuRgmAYshZ+oykKSdNGhao+LOwwdAaq9Z1tJ25CJuK4Kko1H8h3+i9yGmKwTP8WLUkxMd5ao9jjrUedmtFakL0J7zza5xv+D5hMrzekfadFCrDLJ1hbOX6gWMWcQsX5uN2/HiS1TAobl80+PMx44C2uq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRG74nyhrXnPCZ5F+fkDo/6B79FhRMztI3CM2lXwvZA=;
 b=mXrPpXjQkV7ywlpPRdgaFTRrtrrJbSNjrnsZOrKTb2T+Fkx0cLm9sfNkIukGL676N0HznCAsGO/dZNqk7iRIsQjPHyLffb9xwf0MztmrBjkd3RxKF/0Q7tHoIbWTx9o8tQIRjW6Uxv0Vt5kbNiFEShI7BK/5EzpjeSaLeApgP4Y=
Received: from CWLP265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::15)
 by DB9P190MB1865.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:37c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 10:45:53 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::9) by CWLP265CA0339.outlook.office365.com
 (2603:10a6:401:5a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Wed,
 5 Feb 2025 10:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:45:51
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 00/34] net/ntnic: bugfixes and refactoring
Date: Wed,  5 Feb 2025 11:45:09 +0100
Message-ID: <20250205104548.1533554-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250121170814.3252171-2-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB9P190MB1865:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 507ae150-decb-4dd6-56b4-08dd45d2428e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZjNXH1eQ8lrxnvUyQDPqPgtUMJM6sxQipFgPwI0sgIaqEd4aOVN4N7cR91iE?=
 =?us-ascii?Q?GeMHCAIT/FLfCH4YKD31rILhzyW3vCRuc+gY9MLIDX9sJk16pojP10YMBHBv?=
 =?us-ascii?Q?uxtAcYd+32+ykT8k70sRr5CKGHsQQ2h+Wj5pNHb5N39ZrfmXG4eqwTICeXKy?=
 =?us-ascii?Q?ctxvzOIjhnRmyn83gwFF/E4V3UToRwd6iFaqyttvGARMuJOslCPwQIfX7SCu?=
 =?us-ascii?Q?/KO9f3WnLAatjRScbAszx8u6G9fYAHlpIwQD6cTPEN9JfiaWUnpCzcd0iEPX?=
 =?us-ascii?Q?5ZToHpCte/0rTdA5LEcMpTRhrmKJZFpN2/L2kFmrWu88V/PlJfZvxVWbrAWK?=
 =?us-ascii?Q?GWooZoHCi5Cjt/Yq41DBv68Yq3fMyciKe6oVkfV9sxRZbkasgwoFzaIqX/tg?=
 =?us-ascii?Q?9n22cogHYBqlAW5X6LzQKOf7MSrWp6Clc/y1wwjYQ5pmX+jsAAq1QdA7j1AS?=
 =?us-ascii?Q?RupOwkHUQfmq6dN+aEvnIslZalLzGgZKzltMUnOPXnlUhe/EC1w/BPxkaiSX?=
 =?us-ascii?Q?FoGXC+2h4McHBX9kIa7fc5+UkUlbMIYpis4Ve6EtpOiAlNuPBHnamBAmbIRz?=
 =?us-ascii?Q?DXrTNrZcMn894bv/ndqtPgtAQZg3PskfSYLy6Y4S4fj5dAR+7pEEvSbS0rrD?=
 =?us-ascii?Q?wMEmCGa73j+NL3K97pY7hsgr4UAhj6uyCgP4RF258XMGve5NJEcb3Hw5an0A?=
 =?us-ascii?Q?YD3bZfoXR+Yt7pBYv6qLt8RD1Mp9N2/mA9Q/imf4KIK8fwcsIb0fgfnzVask?=
 =?us-ascii?Q?gQTrHXlDoQJvvgd0diCwP7ev6PTZfhozKNs8tJtg7CGD4iM6rIHKOLGU/TOW?=
 =?us-ascii?Q?wn+3THWBfzEBU3lk0ydY2ekyQgPjWQjTA8qfDznRf2f5km2WirYP9VNyKm5C?=
 =?us-ascii?Q?jrFNbiN32E4QqkqAy0lDpHhuLXAyC9ayGjE1PU6l9s6jXR27bgsx45Em+/HK?=
 =?us-ascii?Q?V3/qBwqJ5yGLHXU/9O00SkrtKbZIywrgMDJ92nqP2ceJdlJJLF/03HrQVixW?=
 =?us-ascii?Q?Sri72uBUqcArONU0/aDmzLApytA7ncWcouk9pFwAYY9WcG2OzABouEj4EwYe?=
 =?us-ascii?Q?49HsMngZhslPS/5A2m3l5MDwagPnudiFR/geEKf/paNz2L3yt9nBXPv1IW2p?=
 =?us-ascii?Q?loF+yZJqWViFX0QHWuxpMVe9MEKZnITlcPmhtVNjhQHUYd5X16eEJhWBgZ0D?=
 =?us-ascii?Q?mmhxHEtaJ+YObY+gFUhThOol1SA/QnTJtRH4p4WPb+pTZOFg+zaJBOrAGMyw?=
 =?us-ascii?Q?iqsCDTmoil8QCRUTRxavx7MzLrkhQmYQFcYfbOh3lmm+dOvK2ME94ScMCUdO?=
 =?us-ascii?Q?DtSirS0RZRZHWjCw4LLlAzaTkgzGEZmRfEKw4M1Bus+epjPzgWTOP09wqDOy?=
 =?us-ascii?Q?lQr3eSqqiS43jn6SLQhInfBV1ex/t1zdFeXif237QsHzFymH5sqDpmscQi9s?=
 =?us-ascii?Q?Wd6slhkYBqo=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8ly2QTd9U60gJe2DBY3joS/D5FK7Fq3eNI6q2F3RELU07DeiShUuXLnVGPj+EitoaRbYnqtxIrlX5v14hJmxLyZsHvI/pkF3XGugs2OWn2aSpRVlf8sZn9as1emrjzmZ3HuTb1MMyWs5UfOZEdTljV6dmrX8+FaRohJXcTIGKBY5dr318faBxeCal3TZL2pwu3p++9/hsmqnAokFmChT8AfTqVNwHvNHpmYp/cWpa4JSO/0QWZpvJ5D2CAOfHsmGofotCWALhe4vOe7curwlGlYnAgowre6NpX+wWYXGJYvEob/wIWVxn1iJmubr7muNz4UEh2tulo+EpLigLTpXE9tx/InfmQhUkNEPezt/sUC7bNJtk225NG+UKEPtJmqWi63oKcAZNedKNbF5ik/V8SDE4TA2kbk8vwmO2cSKKcCTYO2bkXSOAUDwM4h0KQAZ2yYqYi49UsagIDU7jq1WoSxJHlvYq345qRQWc/uv+KB8MDYGvKntCIRttrQuT9wUJEgLw4y2kW3RODKB4j44GOT2H+0W2jBf277mm0yeYxeY3EXyr4pmAzYwOBAnPWAnEdv8EmOKSROYGN6OQQDA2XcTvG8Pz+9UGVMopAQ2iYKuViQYewC8Dq1Tk6Z/5gHwNfmY+FX+PW9E2On/7Af6TQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:45:51.6208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507ae150-decb-4dd6-56b4-08dd45d2428e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1865
X-BESS-ID: 1738752355-306009-7766-577-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaWRpZAVgZQ0MjQJNksJck0MS
 XJwtDUKMkyzcIyySjNwCLFyDzZwshYqTYWAO5k73hBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan20-147.eu-central-1b.ess.aws.cudaops.com]
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

This patch set addresses fixing issues in the ntnic PMD driver.

Changes in this patch:

The issues detected by the Coverity Scan tool.
The problems that were detected by the internal tests.
Fix for Bug 1622: ntnic: using signals and threads:
https://bugs.dpdk.org/show_bug.cgi?id=1622.
  The handling of signals within the PMD driver was removed.
  For manipulation with all threads dedicated EAL API
    (rte_thread_create_internal_control) is used.
  Product by design requires usage of threads inside PMD driver.

Danylo Vodopianov (26):
  net/ntnic: fix index verification
  net/ntnic: add thread check return code
  net/ntnic: add return code handling
  net/ntnic: add array index verification
  net/ntnic: fix realloc memory leak
  net/ntnic: fix array index verification
  net/ntnic: add var definition transparently
  net/ntnic: add proper var freed
  net/ntnic: remove unused code
  net/ntnic: fix potentially overflow
  net/ntnic: add null checking
  net/ntnic: fix overflow issue
  net/ntnic: fix untrusted loop bound
  net/ntnic: add null checking
  net/ntnic: move null checking
  net/ntnic: fix var size
  net/ntnic: fix var overflow
  net/ntnic: remove unused code
  net/ntnic: remove convert error func
  net/ntnic: fix array verification
  net/ntnic: fix memory leak
  net/ntnic: remove unused code
  net/ntnic: refactor RSS implementation
  net/ntnic: fix age timeout recalculation into fpga unit
  net/ntnic: rework age event generation
  net/ntnic: fix group print

Oleksandr Kolomeiets (2):
  net/ntnic: remove extra address-of operator
  net/ntnic: remove extra check for null

Serhii Iliushyk (6):
  net/ntnic: extend module mapping
  net/ntnic: refactoring of the FPGA initialization
  net/ntnic: remove shutdown thread
  net/ntnic: add checks for action modify
  net/ntnic: add IFR DROP counter
  net/ntnic: remove tag EXPERIMENTAL

 MAINTAINERS                                   |   2 +-
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |  18 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  10 +-
 drivers/net/ntnic/include/create_elements.h   |   1 -
 drivers/net/ntnic/include/flow_api.h          |  10 +-
 drivers/net/ntnic/include/flow_api_engine.h   |   2 +
 drivers/net/ntnic/include/hw_mod_backend.h    |  24 +-
 drivers/net/ntnic/include/hw_mod_tpe_v3.h     |   5 +
 drivers/net/ntnic/include/ntnic_stat.h        |   9 +
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |   2 +-
 drivers/net/ntnic/meson.build                 |   1 +
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |  14 +-
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  83 +-
 .../nthw/flow_api/flow_backend/flow_backend.c |  28 +-
 drivers/net/ntnic/nthw/flow_api/flow_group.c  |  26 +
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.c    | 661 +++++++++++++
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.h    |  17 +
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c   |  14 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c   |  19 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c   |  18 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c   |  58 +-
 .../profile_inline/flow_api_hw_db_inline.c    |  29 +-
 .../profile_inline/flow_api_profile_inline.c  | 925 +++---------------
 .../profile_inline/flow_api_profile_inline.h  |   8 +-
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.c    |  32 +
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.h    |  15 +-
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |  10 +-
 drivers/net/ntnic/nthw/stat/nthw_stat.c       |   2 +
 .../nthw/supported/nthw_fpga_mod_str_map.c    |  24 +
 drivers/net/ntnic/ntnic_ethdev.c              |  69 +-
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 155 ++-
 drivers/net/ntnic/ntnic_mod_reg.h             |  11 +-
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c |  10 +-
 33 files changed, 1204 insertions(+), 1108 deletions(-)
 create mode 100644 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
 create mode 100644 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h

-- 
2.45.0

