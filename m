Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF4C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:49:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C2E14028E;
	Wed, 30 Apr 2025 15:49:15 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 1128640279
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:14 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 mx-outbound8-212.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKVFBLq6yqTOYbM11BHqIKixB+67wOCEuQq34FuIODToPftdiDZf0JYNEbX1pAAuGOO1aiAtrS8Wnv315k8nNmJYZTqwLu62pBpvvc+cMWvKrdbjLbuZRbvWTqDVxQKvhPpaA4AXLqKZLmyv7BAU2qAoCi+iDEHTUgvqgFcs1+hZ2i1gtjjRgp31C7+3adj1uGiHZ6CrKwu16PRSHQ0k48C+wCgUAwSafuEzOCr4TDTxdQCmIs2iE/n/4iaHuMZg2f6rJFrV3ZPB6FKaO7J8nwo3BVfBg2YxgS1OUk7m24fE8iARDpT7yvZjBzvlUTXD4WyofbNMRCVSLP/8Dw3geA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OGqkwAz2e6QoaY2PtpQtXOqWWq9A8t1MkYP1SLm0XU=;
 b=A7+Q8aaOZ9n6nYAnZ/wySgcNLQgZkL5oDObIhc0QMwnRgHIKAcjPoMvffoi0spXRln+ezX9crY0xK342c6T8o6OsxF8Y0CA9fkmhCjvpjWvVqhETC6w+0PIH44Oj+6rvMPqIQc2cR80VbMThMhpYaAVx2sp0FXq/25HOoPyGE+Hls0we7Ue2C8+bhrHuuA4mT4sfTwYYmu05ga5Oqvn3KvgP/Rv/OyhxcfS9kcQ24wkZSmPeUIa0ARz6WGkkz4VVRaKjHzQSYTTdek7Tpq2Ez3Tt3hGM/qBLPqEAIais+jL/aAVb2kF8BU1iIYess127okcRz7tVmvX5udJo7E5uOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OGqkwAz2e6QoaY2PtpQtXOqWWq9A8t1MkYP1SLm0XU=;
 b=FZxcmWuXJdGuSMpSjdiMfgS1JgQ8yZB1AI0ne3IxYGbqETzqtn0woeXekDmhWYOetwG9Ko5WvcEsNsNL2TwILIKiFaCqvJMdte1F4MChDMpK7ad6vtltkG6u56YrFfLxyOqcbtw+d1fw/Lsz3H2MqIm+e+l4FfeNxv0NxtO8gOI=
Received: from AM9P193CA0012.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::17)
 by AS4P190MB1949.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:514::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:49:06 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::e7) by AM9P193CA0012.outlook.office365.com
 (2603:10a6:20b:21e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:04 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 00/25] net/ntnic: fixes and improvements
Date: Wed, 30 Apr 2025 15:48:12 +0200
Message-ID: <20250430134840.402553-1-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS4P190MB1949:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ab298e84-1e96-47a7-597c-08dd87edc546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aS2ekeQ1AbRdR3WBkKZ1f9Bcvi3yUMvLOfRmpPZqEfEe5kId78JybkR1YhKN?=
 =?us-ascii?Q?uElMgbBH+XgOkiqN+VpYsi72V6YcWsG1bMK+v/HVUaq8e6AR3PZ6Dbuo3vSN?=
 =?us-ascii?Q?YgMeUtSLMNHUdFSLFaxjOLMPwVNjvIqhMMiE+C7WsPJH7eCewmtdduFxaVNb?=
 =?us-ascii?Q?zOi+PiFS3PkkunMC2x6HiP4RBvDSoG/3svi62PQQED5rE27mOg7rTRCeS0sU?=
 =?us-ascii?Q?T0kGtu/QCbhr1S8NJCSZKQ52pm8/vBIB9ZmO1KHzBCGElQUrdwOpqqeasLqd?=
 =?us-ascii?Q?KJMSOhjyB35cejqDPR+fl3Yxbcv6CFz+JZVf6UEJw4UVp853vCQ3AcQErA8x?=
 =?us-ascii?Q?q4mz12LWWGf7fJN39SPgiCNHoz2U5O970ZmyTiURU+cA0ky8kZWoRWiNhAbl?=
 =?us-ascii?Q?AnueQGW6imlLd6lKGk+Mag6pCKgNaQiNGHqjCX3z/lNLF0Q4KTgloM9D2Ew5?=
 =?us-ascii?Q?7CxL8rq/4WoGtfD42Mnbw3pAWlKrkxDhbiuhbdW+z2MkiUh9bzsi731BkNZE?=
 =?us-ascii?Q?dBuSuocMFrkI7SXXREYKM161s8WDyX8KgvQv0hXpEXuNgU6UhFjFdovhgrNK?=
 =?us-ascii?Q?7HwyWmtvgwFhYGzU5QTtye7lK2+GvLwTZ/mdwwlvC5jPPNGPKdzX8DZCOy0A?=
 =?us-ascii?Q?ivJF/CXlWuYgwseC+yEZPkOVjrB2WuuSPd4e8GCCml7Sg5BRDBG8NRUSBnmb?=
 =?us-ascii?Q?C4CisocrPbVfpNmod+4vKmbbzqWnjgXqqQyH+HzrHimlmQpqg74BY+pqLkmN?=
 =?us-ascii?Q?CZr9JQ++L8d1e/3gZJ40Fj/hplzoiho7qgGYqqBsf6oPnG0zqJ5PWmAk2vMT?=
 =?us-ascii?Q?Cg3WUrZqcX+vsv17BGkZKVge3Kl9umtCybg1QtrRwHbDBSar/25scVwaeV7R?=
 =?us-ascii?Q?TmipkitJcRA17j7DcwBAbL0sUAkgsrfZKKp1o2oQlk/8z8g+Xy9ACo5riCRS?=
 =?us-ascii?Q?4HrFQS5SOrfELS9ZympEP5R9bVei5R1u30r9SBsK0BTb9rsCgxHBZ8G2NczP?=
 =?us-ascii?Q?3L+RQndnmaqs1JQ8fq7TkXoDu2sC/QoM5JYDXammXYJcIV8Fu2qBYowfl8Hj?=
 =?us-ascii?Q?o7otJ2GjBl1xNUKGoosTYCTa4ko/T8pDV2Vwtntl5l0NgN9Z/4yk7uI8wjv2?=
 =?us-ascii?Q?hBpN8BROesBnRh9s5j1Okykou7Sj0kZGuSb8z4bu4+Uilj8wOzyw51jI5vv8?=
 =?us-ascii?Q?rw5bX1nvd4VOi8qQyMSbT69uaKvNEqcLLoDiy3KXpPnAqXBKkxLgWeIp0wrG?=
 =?us-ascii?Q?ZNnaiPq1+dHO/KhGNH9QtlM2/NyhDeIMZsl+QyM9a/Z9vIuRrhBNW4weJpkI?=
 =?us-ascii?Q?5EFfr0xfA0AcBN8HzHa4YP50T7nDIPQE+tjlwhWqblaNVjZvQSNM8tE5sgIx?=
 =?us-ascii?Q?EAG4MK3MeS0ffUbyy8gXYJcVtZjGjpj5a9Egnl8K+5Kpkk7Flc9V7cJT09Ie?=
 =?us-ascii?Q?Zd1PJv8Had9QuF0X3dLCJyBzNwnVBSXmTSKCvwwcmZhUpiY8Fq168g=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: krwHhVGZ4wBys5VHW2ID0MasaJrp5JYDaAkXugbPAfiVCelI3z6V2yNaHnz7cR7E/rbGzeS4TR01v+AKxaZro3gGJSSSKjmXYD5/swMVsf7qe1REbkx9FqMUm8Zu1z0EH82VDPIkKQtRbbXvTmT2ML/70algGku0AtI57J7v7y+T0BuXRZhYUw+YXkumza5QQQ93y2MlgL7Mfqu4Lymm/Mm9yXrkAVM2UhEN30J9iUVF3ubbd7OWnCL0rI0e5FIb7FKbnMOddxpK7yMIc6gN2rvLzHETJWDRbXNyo2SmRgKne8db9QyVhgI1WV0pxYWODDvsPlMM5Atr8XPxu6EnoJbP0yjYuKxnWKHQU+ZnSDq7F5VewjkvMtPEhY+w5cfwocgoVlwMrVrz8yXgpEDZ40P/ErXb57vmqBBlSuvSN+kdwRAe7c5tZvtQtMfHBJhtuHcCxwL5iPiqgXve29Rd0rP3Q4wnUBa3/0OrF/atdCqgbceFrbcIstQIR8tze30Xpbr5AfFjrLMUiWncysqSgYlyRdd16GwAN0CI+o0uxIHYB+cXZhit4EWcD2+HAu8HCZ26MI/uhnEkP5rDizj+Wd2pdMNb5hBGlf9xIsisKWartKO8jGe56GE0692ErGgFq/nyDw3zxyv5gQPhEAAnVw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:04.1461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab298e84-1e96-47a7-597c-08dd87edc546
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1949
X-BESS-ID: 1746020948-302260-7745-9108-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqZGRhZAVgZQMNHcwNDC0DDVIs
 00MdE4xSzRwNzc3MLQNMnUyNIsJSlRqTYWABJtn4RBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan9-176.eu-central-1a.ess.aws.cudaops.com]
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

Oleksandr Kolomeiets (7):
  net/ntnic: remove usage of the variable-length arrays
  net/ntnic: handle string truncations when using strlcpy
  net/ntnic: replace pragma pack with DPDK defined macros
  net/ntnic: remove extra memset
  net/ntnic: include all queues into statistics
  net/ntnic: avoid misleading variable names
  net/ntnic: apply packing to the structure

 drivers/net/ntnic/adapter/nt4ga_adapter.c     |   7 +-
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |   4 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  12 +-
 drivers/net/ntnic/include/flow_api_engine.h   |   2 +-
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
 .../nthw/flow_api/hw_mod/hw_mod_backend.c     |   3 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c   |   3 -
 .../profile_inline/flow_api_hw_db_inline.c    |  95 +++---
 .../profile_inline/flow_api_profile_inline.c  |  93 +++---
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
 drivers/net/ntnic/ntnic_ethdev.c              | 121 +++----
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  64 ++--
 drivers/net/ntnic/ntnic_vfio.c                |   1 -
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c |   9 +-
 56 files changed, 420 insertions(+), 654 deletions(-)

-- 
2.47.1

