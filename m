Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14D5C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:13:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BAD04066D;
	Mon,  5 May 2025 09:13:26 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id C2A1240674
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:24 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2113.outbound.protection.outlook.com [104.47.30.113]) by
 mx-outbound14-199.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMys2ZA5l/l2dnI3rSaVAzMVPaI+9da3o7FDA0Sq2jKhMEQLMHUXsj+iBOkvbaSlcFuBHB8OZeH2g33evItphOJ+7zlLpWEPQEDwkpwHJrx4Vby4TUGbOOgAP8tz4fHhLnKKlQFUoJYAIH7EbwwQ2VHTh5ykvxLG9ovaxh0QNH3w1II8rwTPUvxV5vGkahzCsIXnc3mD2JWQUylMF7TjwU7jB8Q39pcrJT33qXSahiIgZvuqVBSGn+hoBitbZnlIOFLZmUHmq/QjrEcw9A6tVxsNi8FAinpNkrpSC2Lp4WzbEKQoUmXR2ONajgjC+161c2PJG3K3U9A4OWFa3EFfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K93QF84pd+kgoiuNylO1CbY26fVyGxNMcynipv6WM1w=;
 b=aYyVolxurj4KOMZkD5D/HDh3+3H65YBom2WouzDdKyQO0QkyXtsnKchQ5VCZ/ejaKxvL7W/EtUmOaOO9oV2ydgXiaqUp7onCKQcwRNhIkVP1rG/snLrvYlkHSP1gAG7akTrbP2bnMwvwvlv6n7WFk6xFDzsmwWfQReaQgW7ezty93OfRdZSoFKZPX2umLkUZD4Af+V+ORDGWLtexyPRQQIse1gVEPTWsZ/ke90g0x0T8YZTEItfgPy5uxEzjgXmShqQSqvH6saFnRs/BAMWF5u50Kg+i9IK3e5Qa15wGCEblTg1etOUny9A0Wit7M6p4ovo6FB0TUXoectkDACg7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K93QF84pd+kgoiuNylO1CbY26fVyGxNMcynipv6WM1w=;
 b=gZ7trqA8kZm5mT7x7o5zvq35aJxEurNCWYAjoNKIIAKMn1lC0pZXHpUcC2wjW/Hs4Im6H67icPo+gUw4NFdyG3VrjZ2HIV83INuUkJEdoxM1NVWbTTw/1fM6j+R0N83UlF6odsOMQH6Tt5YlUEPpPogI79G1l/GGVDAdKAhUack=
Received: from DU7P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::30)
 by DB9P190MB1986.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:399::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 07:13:11 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::ae) by DU7P191CA0020.outlook.office365.com
 (2603:10a6:10:54e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:10
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 00/26] net/ntnic: fixes and improvements
Date: Mon,  5 May 2025 09:12:40 +0200
Message-ID: <20250505071309.586015-1-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|DB9P190MB1986:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b9ec6a30-0c19-48bb-5e8b-08dd8ba44b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7QatETs2ADUwXyCTVjwzMkkgj1ecAGJdima8ZJWV+DAfmiMMSotCGK9s+nfZ?=
 =?us-ascii?Q?94/gUbjzOJcsXjTJus9024Q9GDcNEuoIgxnK08PJND149Rjq6ZLOFU5lMpny?=
 =?us-ascii?Q?KJ6qHWXzfgZhWR2tZ8LJzLWvju5BVEhX+hkyJIY+/wPKUHottN48SM39DZAT?=
 =?us-ascii?Q?V4ONVc3x+D4Cmkq3WT4IJZGStbr37xKMFReT9D6aUpLY/Wvc84xlmaFAd7uw?=
 =?us-ascii?Q?A/UzeBq1rA64mufjHFCX8u1vuHxkE0qGzCIvTwW6ydE0QcGPZpsrtfrezgYN?=
 =?us-ascii?Q?6DA3im5+mbe9+kzRtBdIkzbKG/fry60uiL0AQFKS5Xok7gNsuciyi9Kg+YSM?=
 =?us-ascii?Q?1tUXsXpyymOpCWkEVDSoctWFy77KFeoXlHICCuRPcuYnc+FBrn6uhYjh5qfZ?=
 =?us-ascii?Q?2ItQPEnWtNhNh48xMNi7bPYRDvCQwu65lEAE0SwUpJyOoOZKVIi6JnDOBgbt?=
 =?us-ascii?Q?QQ2mTVtF7hPZKf0xDYHAqp1JETg6F57KZ1DPLJZhfbsqHNP3TU7PEWSFrj6l?=
 =?us-ascii?Q?6TrwATAfzQX/aD5pYjPUy70C/EkMTGdzQqlAj1p93XVU1EhfJY/7HGC0CWBi?=
 =?us-ascii?Q?IYbqcCwI82O7SCPpD1DCCA5Rs1DF0ihMy8rMhyormJwyR096tYqEYZusSK6N?=
 =?us-ascii?Q?vaUqnlrqepkwSA/0kR+bEbslvsPoYq+tTN4/LKYu+iiP8nY85/f6fOYfpLMy?=
 =?us-ascii?Q?7I0syYbUBoC63xcPNosce0inG2rhCVxBq3Nxz0oA0IXXc1QsoqbpsxhFRwvK?=
 =?us-ascii?Q?8d2x1sNTfKPMJmpv+M+XoYLnQ+er+wVmWN1B/jBkKQvsefgsVOXyGD338Vgk?=
 =?us-ascii?Q?Y/cVDslcdQtQb9x5+qUObZ/GsIVFiEWvpZ7JtL/CLk+x7E7e5D4UeAyPTzwF?=
 =?us-ascii?Q?wGjA+yMxUdsrzXH9FLcc87tVvY5jU7wI+QhLfKDDbL24vbGOOyG5xkn3F745?=
 =?us-ascii?Q?6QeUEhnpnDYOtvO23+2fFiagSQ6giGRZgyjdMzmyAMAMARSaEWi/2aK193WZ?=
 =?us-ascii?Q?QqC7NyspUtMVPeyu6oAFo1cRorm6NmW05a1oLrO7+zPt5sb3pCbrWTxg4T4f?=
 =?us-ascii?Q?eWdtQ3UE0g8e8e3rMhwtAY3J9pJIROopdZ93u8p0mrZfeA75JDNowz9CWltX?=
 =?us-ascii?Q?hZ+VS3V4gNZWeYTWED4KH2yW/skj3z4/2jChb8WZ/JUIckr3SmL3/unEGGLJ?=
 =?us-ascii?Q?7Qm5DzJwoUm/X3GaCWYMctY9EnEI+Eqtg6reJeN6Q5hGcpTeM0YGhMPyuqNi?=
 =?us-ascii?Q?W160drR++58YyiHnkCr3DqW5xnY6UYU+qWsjG9ZJGukGGGgTJMKfkiStaMYK?=
 =?us-ascii?Q?sxpsD2BqIfbPG0UrHeyaPBOPmnW2h8bvlyCGasmWkfaDylf7fWuxCsdwhcKG?=
 =?us-ascii?Q?djHauWA5VUBkxq109Kk29Qdhxi+aGZV+h9y8rUxYPrY6BzBx6u/mMAYjq9dz?=
 =?us-ascii?Q?HqQN6pdGQCVaHI4ZyBR33dWNp4J00+HUbXdPWZXrjZIA3Sey3WUqFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4nKr58Ff9iCvmdZ/GFWId8ebwCcIA4la9KcWJoFy/3K/KnRQeDdRY7sC4oUEy2GWv7fnnLk8k3xYNFOZpC1l/EG3aSqF69n601wS1RBaqoQ5mK+R5xqsCTcePI0tBV6mArL5quwx2425LtvtymGVYBU8yhJVvzHZKsCKrv7g+XFwHJhZMbV6q7+2KBIJb1ZSZMCQTXOXsA60jpUBmCfyH6XQMVeXnHHaf5whTGOpcgkOhXTzQ+0/DnQRb2FBnDF1GZrE83JaRnGM/GAWOI9aYApDPwlofSc5azD3y1Y/vjGhr56fEVDzli3uozpR98XkIpAmMyAI42HEuRYjuhGvWxNBgTxlzpSSLj8O5RTD9nxz3o1V3nwcXEj/fV/hYHNx/tjR8wQ39fPGLcOGvhXELIz7Sb57JguS17tw1LF1PmeffVIUTKZAyGxi0RJH9JoYr44sEi0uVmDSsdN7v1bNTkN9SFigsOUZtqRV56E6UIG05MjhzNhPhju54FGrdefDwk2aFiMe35sBqU6RXyndyK8aH67CgYChu49ThJIPYXEHXYcls8LyRKUB8n4P6PJYSNOo4YPPAfIfeE0QvYpUjOYes5Y7BOKT5f2b1QGdqavRxgJTWKjo4wLjs2Xlk9XCT+Vxq/JI1h0zFgh/1UTS+g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:10.5169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ec6a30-0c19-48bb-5e8b-08dd8ba44b34
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1986
X-BESS-ID: 1746429194-303783-7663-377-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.30.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamZoZAVgZQ0Cg5Jc0kKdEwyd
 TY1MQ4xdTYONUwMdXYINHMPDk1ySxVqTYWAJQcaqdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan10-84.eu-central-1a.ess.aws.cudaops.com]
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

* Fix issues detected by static code analyzers CoverityScan and PVS studio
    - PVS studio: https://inbox.dpdk.org/dev/CAOaVG170qdNxDFsTjCvJhZafY-Fs8e98xPBa3q8U--WX+K_Qvw@mail.gmail.com/1-a.txt
* Fix requested issues mentioned here https://inbox.dpdk.org/dev/20250222134157.73763253@hermes.local/
    - Removed unnecessary casts to (void) in memset calls for better readability.
    - Added null checks for pointers in various functions to prevent potential dereferencing of null pointers.
    - Enhanced logging messages to provide clearer context
    - Updated error handling to ensure proper return values when encountering invalid states.
    - Refactored code to improve consistency in variable naming ('if_index' to 'n_intf_no')
    - Ensured that memory is properly initialized and freed
* Fix ring queue usage and concurrency problem.
---
v2:
* replace direct access to atomic variables with RTE's load and store.
* put space between RTE_ATOMIC macro and variable name.
* rename alloced_size to allocated_size.
* rename num_queues_alloced to num_queues_allocated.

Danylo Vodopianov (18):
  net/ntnic: improve logging format specifiers
  net/ntnic: remove usless expressions
  net/ntnic: remove unused code
  net/ntnic: remove usless part of conditional expression
  net/ntnic: add error logging for hsh
  net/ntnic: add explicitly specificator
  net/ntnic: add handle memory allocation failures
  net/ntnic: remove redundant initialization
  net/ntnic: enhance null checks and assertions
  net/ntnic: add return value check
  net/ntnic: remove redundant assignments and branching
  net/ntnic: rework array usage
  net/ntnic: avoid divide by zero
  net/ntnic: remove unnecessary void cast
  net/ntnic: remove unnecessary memset
  net/ntnic: add null verification
  net/ntnic: avoid possible deadlock
  net/ntnic: fix operation with rte ring queue

Oleksandr Kolomeiets (8):
  net/ntnic: remove usage of the variable-length arrays
  net/ntnic: handle string truncations when using strlcpy
  net/ntnic: replace pragma pack with DPDK defined macros
  net/ntnic: remove extra memset
  net/ntnic: include all queues into statistics
  net/ntnic: avoid misleading variable names
  net/ntnic: apply packing to the structure
  net/ntnic: correct misspelled variable names

 drivers/net/ntnic/adapter/nt4ga_adapter.c     |   7 +-
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |   4 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  12 +-
 drivers/net/ntnic/include/flow_api_engine.h   |   2 +-
 drivers/net/ntnic/include/hw_mod_backend.h    |   2 +-
 drivers/net/ntnic/include/hw_mod_flm_v25.h    |  14 +-
 drivers/net/ntnic/include/ntnic_virt_queue.h  |   4 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |   6 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       |  63 ++--
 drivers/net/ntnic/meson.build                 |   2 -
 drivers/net/ntnic/nim/i2c_nim.c               |   7 +-
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c   |  11 -
 .../nt200a0x/reset/nthw_fpga_rst_nt200a0x.c   |   9 +
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |   3 +-
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |   4 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c       | 306 +-----------------
 drivers/net/ntnic/nthw/core/nthw_hif.c        |  10 +-
 drivers/net/ntnic/nthw/core/nthw_iic.c        |   7 +-
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      |   5 +-
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |   5 +-
 drivers/net/ntnic/nthw/core/nthw_rpf.c        |   5 +-
 drivers/net/ntnic/nthw/core/nthw_sdc.c        |   8 +-
 drivers/net/ntnic/nthw/core/nthw_si5340.c     |   5 +-
 drivers/net/ntnic/nthw/core/nthw_spi_v3.c     |  17 +-
 drivers/net/ntnic/nthw/core/nthw_tsm.c        |   6 +-
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  10 +-
 drivers/net/ntnic/nthw/flow_api/flow_group.c  |  17 +-
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.c    |   8 +-
 .../net/ntnic/nthw/flow_api/flow_id_table.c   |   3 +-
 drivers/net/ntnic/nthw/flow_api/flow_km.c     |  10 +-
 .../nthw/flow_api/hw_mod/hw_mod_backend.c     |   5 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c   |   3 -
 .../profile_inline/flow_api_hw_db_inline.c    |  95 +++---
 .../profile_inline/flow_api_profile_inline.c  |  98 +++---
 .../ntnic/nthw/flow_filter/flow_nthw_cat.c    |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_flm.c    |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.c    |   2 +-
 .../ntnic/nthw/flow_filter/flow_nthw_info.c   |   4 +-
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |   7 +-
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |   4 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |   4 +-
 .../net/ntnic/nthw/model/nthw_fpga_model.c    |  11 +-
 drivers/net/ntnic/nthw/nthw_rac.c             |  32 +-
 .../net/ntnic/nthw/ntnic_meter/ntnic_meter.c  |   6 +
 drivers/net/ntnic/nthw/stat/nthw_stat.c       |   5 +-
 drivers/net/ntnic/ntnic_ethdev.c              | 131 ++++----
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  64 ++--
 drivers/net/ntnic/ntnic_vfio.c                |   1 -
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c |   9 +-
 57 files changed, 430 insertions(+), 663 deletions(-)

-- 
2.47.1

