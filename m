Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD7CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F12440647;
	Fri, 19 Sep 2025 11:20:17 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0CAAF402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:15 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023138.outbound.protection.outlook.com [52.101.72.138])
 by mx-outbound16-38.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGLDqeyXTBzEHaVHY5zr555VcJF1SgK/Cnh/JXNvD4y4wMZGW9wjMY6JBID2CHGgpjQYDpF41+ojM0CcxCY0LoIAg0zMbs9+tey1dQCfugKaTSC7uoYFGRLyxqiTQ5OQAJkl6jIMkKLoDnSrTf5eaRAB138HLAUR95D/XlJrbB+k+B0WWutDNIO3FDGbAzwNMngY5AD5WtpuYx6JK/I6Id+s9+FCyxwZEQUtjOhTiCG6GF6SmIF1R7Kz7I01Xg6OasR9WqydTWg9PiuG3t9nMkjgmPgLaVRiaZ/6X6U0Ps4fpeyFaNWQAHWQax5gQs6lvqheQLZN2HwOD4F7I9D4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkiATlRxRUh5knldX9AmrmwWu1aS8ZsMde0agNplMqk=;
 b=qY/8zOQV2aE9aRrD/7oBbOfeZKN8vZ5+JzFEE7DeFbSlcGjIItKl4j8MWgwpASkSzTuJlFJfg2+rPystI8U5O1rRoLpw30XEUuHlm02TP45VyUu/ocA8WheRlLQ073YOz8JyKYEbZQM7sgK4FTIiBKR0LLzXS/042E2Zj+qqbzz0XG5fOAlMdI+ZlADe8DglLTkYDCxPs+SHABzfP57qd9HocIzNt2LeRrpQiG+V1FKtJTBGDEFV9I+7Btvkq4yJmkKS2kgJWmGD9OC5A+cOzsl7o7kl5Pfufd58/n35HryciatTwglO5mP4C7714HT9UQaO6poTKdOcurRGc6NMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkiATlRxRUh5knldX9AmrmwWu1aS8ZsMde0agNplMqk=;
 b=hJ9Fh7DLEqrnuitqVkHwNibJ8GNUilN/AADeJ12lReRe7qfvQI+sXLqc0RyHqwx50sIr/UIQ2jXvNeKqgUTiL3Cayrq9JV5MHhhtIVhWoaGY+OB5cV2r3MSaAKC/PcyksBn8yzAz4GdcsCbl07Z5m0XZmEnOT+mY7W0k97iFASA=
Received: from DU2PR04CA0339.eurprd04.prod.outlook.com (2603:10a6:10:2b4::18)
 by DB9P190MB2492.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 09:20:12 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::e0) by DU2PR04CA0339.outlook.office365.com
 (2603:10a6:10:2b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 09:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:11 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 00/16] refactoring naming the for exported symbols
Date: Fri, 19 Sep 2025 11:14:45 +0200
Message-ID: <20250919091504.1548351-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|DB9P190MB2492:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0fe8ef7f-cc6f-4794-8b37-08ddf75dbc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q50Xsy/1fCBWfBciEkpVUU3MGpODW8zMlTTPXVFw899hlc54aiIZE8AXACho?=
 =?us-ascii?Q?FsBdxpRzQj3o498rSd3aPbsfb6st7Q50xQK7Do3MEX36XHh3y3F5jQroGdnl?=
 =?us-ascii?Q?mXEWdcisRrzoF42ooon6zU5Lg83rcw420xrrFAKahEo5mLdvQRRPSvaTxIRn?=
 =?us-ascii?Q?qOrtE3Dambwlml/EblM6B5JDuCJHbV8MTTzl39asf4M2EXkK8Xq1I0os6qRW?=
 =?us-ascii?Q?JQNIQRQvTM7drCR3IHBTTJCS3YCYZzr/otmlMr0/0NJQmC7GCWuJecs4jDLy?=
 =?us-ascii?Q?R8Ao5VwFEEm8FDgpZjIgPoeghoeazWiUeNLypem7QKqwnXMmsVUi1DDn2AHO?=
 =?us-ascii?Q?zjtl+P7EnwWHMYozuMWM0KHlmUzrIWbMLSVeEkEMQyoTBDlobf321Mu0lVbF?=
 =?us-ascii?Q?f8RNmhG4gvtnqsG0byy3mLsOquZm22yqGH5SyOzu2Cllv6LVN9yTyMrApaku?=
 =?us-ascii?Q?VOotPat/fvbfSzKP2bZ12e2frBmmfchoMh5aoVh7LOn8HqUAib4DT5qkC25Z?=
 =?us-ascii?Q?v4UZ/QuC7Yc+9O1aZIGjp3DM1RsqPf7XSpb0Rb5oVmuIdNhRttkg2m90ZGyB?=
 =?us-ascii?Q?3qlCDzLqWMpHA5kqOazJgGcbUjOj6bv+43g1yNZEY+y2PCKcABbqDBFrk9E7?=
 =?us-ascii?Q?8mpP7eJlKKrdpZU571WnE30FUY2TCo6te0xhLlSxMrAMA3Xs1VecQK06OBW3?=
 =?us-ascii?Q?UTbHQjivyWeZnA3i76nsCC9NGSHv1j3v7aMqnz0ImtacYGS9I3E4SCxJs9Ht?=
 =?us-ascii?Q?yCHE8Eh+QXVx7mw2OXWuYOU55EWDlJRj03vXJwYnvieuJiisyaehlr1cdRNV?=
 =?us-ascii?Q?BxMgAFsfu7OpAytzBipaFwSJpAcXCqGzxGUis5qzy6l+Terjg2z+E0EDZEFC?=
 =?us-ascii?Q?qdo6S1WEzUU1bMfbBloPLL3anZn/gjoNaBXpVaJyKlBKZLzfVErvRRiqRiby?=
 =?us-ascii?Q?bzRHDTbvCsC4db60V+B0DScAzzF7jsQSUx3966eT3w64IqiL/NY4m5Vs8H/O?=
 =?us-ascii?Q?1B1XW256hyLIJI723OWC3JcLyMkYdkhEgyPD99PvlAGbFulE8NSV35UZ3yOG?=
 =?us-ascii?Q?0k/88E7ShwKnV8t0VMX4aaU15gAuWhrQMeXPhFsxhqrkDtrH0fniD6o5C/VL?=
 =?us-ascii?Q?9A+sjVRARg42XS7YsQaLC61ccO+CKHwh+BWHXX1toeivoUNjKa7g4s7EjBwo?=
 =?us-ascii?Q?dO7BH6UzOxVAAIiDtftTGJ2CfhsOCE4eiN5lIunSr8HiP71RytromH3w2O7T?=
 =?us-ascii?Q?1nXx63ZUAvxe1uRbEbiRqFagDunRS5YQT0lx2N91LH0kxh0OKrq+AviWpCWe?=
 =?us-ascii?Q?05qyPy9FD/ngLqtKV0zbV7jVj1+kdGYPdg7pqWr0E5sHIXEicWmShkMKxqmG?=
 =?us-ascii?Q?RW587DhEd5tNCW3gvWC4BpqX7KCxoXDdEJBPP34D2uNGesXYB8vdz0Il4h3m?=
 =?us-ascii?Q?FUnAccHtr1oVd+ESMhRwbx9A7+zl6afIRAdEYz3Gh3LwNVFF4njFsSclPxmq?=
 =?us-ascii?Q?YbNJvzrvCY4u1arqNqoYCADWMeU3tto2rmZG?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JMW7Cpp5T6LVvC5g0s/JNKUdh1GR2vz86lr7w+ChDuVE56iJ2Ln86TUZLRCu6fyleqUoYtTUknzJQ0LITMJ/WEXzKkGzi4IU5rf8dWTJd2GFFgk+o9ZZPdOTo7lYuKFYqxpnKUqPjq2ZEswkv9v0xNzvhl84s8vHQkex70SZGFksSHc3ShSfqVFZ8WB7hX/bCGBmmexZEvHzC+z4hryIrqHl9JZCHENdnWfM5abbGlcq4SkWpmuMGSqArdOQPcl9E7df4S+qP0vbNdCgkMZFytwUJAOnXib573lTxiTPX16k/Y6kzBexqD80lQ4AwobTd+NZQwfbXhUUgoFpETO3t01wh41/m3vw+Evc99tEv/GCHgYlXAH8VCmrejkBOzzJq54OoHuw5wLWr6K5ViOno6ZYEHlmLonei+DRz3ErT2tOK++yjYOrcXiFj+WfEEuZnZDkPrEmXrUZkyPoMYVEvQ3vE5MDj1OBExVZUusNaS92x/q3T5pEDkV2Qu6O8n9YPaWa7TfVRBK8dGJrVFtAEwbvPcAyeB68/CeJRmDlPCx6PUY8JieAr8pURxgolfOLn3L7lDKblK5vW71oTwD991mwvq7YBQeE3Gbxl/1CwO84Qh31SOljTaAIPXpC1vCl7xEYNbAMCVq8r8VgzqQACw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:11.6924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe8ef7f-cc6f-4794-8b37-08ddf75dbc3a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB2492
X-BESS-ID: 1758273613-304134-7645-1085-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.72.138
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubm5iZAVgZQ0MQsJdnCwjTZMN
 XELC3R1NzIIM0s2cLYJCnN0MzEzMxMqTYWALqKr0VBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan19-240.eu-central-1b.ess.aws.cudaops.com]
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

This patch series dedicates to align the naming if the exported symbols in order to avoid
potential conflicts with other application and libraries.
The main change is to add the prefix "nthw_".

Serhii Iliushyk (16):
  net/ntnic: single file function as static
  net/ntnic: remove unused functions
  net/ntnic: move nthw_ to prefix
  net/ntnic: change prefix hw_ to prefix nthw_
  net/ntnic: modify prefix flow_ with prefix nthw_
  net/ntnic: change prefix flm_ to prefix nthw_flm_
  net/ntnic: change prefix nt_ to prefix nthw_
  net/ntnic: change prefix ntlog_ to prefix nthw_log
  net/ntnic: change prefix km_ to prefix nthw_km_
  net/ntnic: change prefix set_ to prefix nthw_set_
  net/ntnic: rename common hash and flow functions
  net/ntnic: rename register ops function
  net/ntnic: rename get ops functions
  net/ntnic: rename ops_init functions
  net/ntnic: rename nim agx setup function
  net/ntnic: rename table id functions

 drivers/net/ntnic/adapter/nt4ga_adapter.c     |   14 +-
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |   10 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |   54 +-
 drivers/net/ntnic/include/create_elements.h   |    9 -
 drivers/net/ntnic/include/flow_api.h          |   10 +-
 drivers/net/ntnic/include/flow_api_engine.h   |   18 +-
 drivers/net/ntnic/include/hw_mod_backend.h    |  281 ++--
 drivers/net/ntnic/include/ntnic_dbs.h         |   22 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |   14 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       |   22 +-
 drivers/net/ntnic/link_mgmt/nt4ga_link.c      |    2 +-
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
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      |   86 --
 .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |    5 -
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |   51 +-
 drivers/net/ntnic/nthw/core/nthw_rpf.c        |   14 -
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |    2 +-
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
 .../profile_inline/flow_api_profile_inline.c  |  596 ++++----
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
 drivers/net/ntnic/ntnic_ethdev.c              |  108 +-
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |   49 +-
 drivers/net/ntnic/ntnic_mod_reg.c             |   96 +-
 drivers/net/ntnic/ntnic_mod_reg.h             |  142 +-
 drivers/net/ntnic/ntnic_vfio.c                |   18 +-
 drivers/net/ntnic/ntnic_vfio.h                |   12 +-
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c |    4 +-
 drivers/net/ntnic/ntutil/nt_util.c            |   73 +-
 drivers/net/ntnic/ntutil/nt_util.h            |   21 +-
 118 files changed, 4434 insertions(+), 4887 deletions(-)

-- 
2.45.0

