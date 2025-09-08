Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCBACAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E592402EE;
	Mon,  8 Sep 2025 13:05:15 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id DFDE4400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021136.outbound.protection.outlook.com
 [40.107.130.136]) by mx-outbound18-209.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 11:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoRjyhypmbVcuYBJhTt1CHtAaX529gTkAAIj1+bzeSHPlltc8adxneNpPYHqnadvAdDg8cyNGKDowBDHjmmndx4R+FZef/5wk0ayhSZAXMoyUCWknSSJGoNRKDsWfKbt048Uxf6Qs7nSlMHuWWsV4EDvkH63rcVCg7zWBpE/MbOWXxEQG6jwNQ4DgTUBu8ChzWSHGE7mLiUB5y5fgh1R47jq7X7nMqc4HxmkGcGJmRFrCQxRmmk2tKM4N1qVZblczZUcdx7i02ny84DnI35hcbYSbO6dj3sQ6qhLfJBnS2vVIVMI/iwhzmfFj4Y/oyzzypxQeVlZoDYjKYWxzEd8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Phvc95OVk3Nrr6eLrPQnfo4SHBjDNG9jyEnfAN+JgZ0=;
 b=jFiEfyOUkH8+HQDhv4VU10CN16O8rXtIbLIR02ZXEXabMb2c0ZQhdTd7+zwxf9YMfOHGEyfODIHx4XYKF8yNhtKSPudusHdw68AZ7kchjTNJbxjeSoRbWAOG+C/A883e3dkah8kHQ39JQITvxAfe4Gm1vnYX65d7/9FQ+YTxARgx7hsT5VhwvM2RWizHvfb9YscFKcxjEw8rqkvrcZjBHvCbQKeaC2nLwpJaqeNop1SVmeyxeE9KAjhkbRlajEJ2GLFDWR5oe8DcL24TVc+8lUbv/Dg4udYwubHZZjoXB6GnNDvVDUa3vF7Bn6aQlukzfhajC7wtDFFTsTyO+hFJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phvc95OVk3Nrr6eLrPQnfo4SHBjDNG9jyEnfAN+JgZ0=;
 b=HcQEQeSSnjzXhWyOCCe8iLemA03nt+59uAWWLQOvab1oRsh5e9MDGOWWndNcWBWqk2ipUb0L8UmWaW8esvqxLBOlkhmtc45K9NGxWTIf+GEXPyXSEyvVbTYxskSK5ItMokxVQBbRHh69OD5O8VH1Lf9hhhFQsXkuegJnFqn3HS4=
Received: from DU2PR04CA0349.eurprd04.prod.outlook.com (2603:10a6:10:2b4::6)
 by DU0P190MB2337.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:05:10 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::3a) by DU2PR04CA0349.outlook.office365.com
 (2603:10a6:10:2b4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:05:09
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 0/7] migrate threads to DPDK service framework
Date: Mon,  8 Sep 2025 13:04:38 +0200
Message-ID: <20250908110446.1071964-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|DU0P190MB2337:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3dbffc51-fa77-4d16-bab2-08ddeec79389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pmK4GujhJ+/2FREY5NOSpkVS2W5dR/3X+Omnwd6YCGtJTrHVlb5xfWmYGaAx?=
 =?us-ascii?Q?1fZ3DFI+3xi+nrYWuR6XADFFoABt8DjuJkgi9JKX1R0b+wE8ghia9O+PLptt?=
 =?us-ascii?Q?oDxq5k99YdRuwoV5dyzdUmxaYe1B3hIcNDxpbCyfc51UGq0bzY0Ghu/HIWpW?=
 =?us-ascii?Q?JdzOD0GXuG9xnID/P4AaAPoHqjmCl3EodDxr496UhmStz/jjZJ9ZI6y4uRnC?=
 =?us-ascii?Q?0m8aQhvNrlcBrTnu0LDWqIvTPrhBLc8S2EtboEOQXokmkZWLsNl1d/RF9mFn?=
 =?us-ascii?Q?KqkTh6fP0DQe7MGJkResvGnT5aJ+h7I4AYHfGn4Gk0lROWt/VO/3ExNweHUg?=
 =?us-ascii?Q?bF5TQ+I5wUW7xpn0gkPOq+5d5hz8YvvVkGTW92DBUcQW0aVcYvgHXOm+fXAv?=
 =?us-ascii?Q?peYKAMFn/XdSAkjyUtVSEIBETMHt3oHNQ2sqIWu2WLOcRmmOze2F8Q2Ez5lp?=
 =?us-ascii?Q?Pf5Beb1OJuIsjXUhdyKLF4BZAN19Ey1BH6jbGlc32UeGAsr/fkPwzdvdqLB5?=
 =?us-ascii?Q?SJ9kIzWuxdclRdmcteMWaNSintzph2RIieoT4TMMRzg5cJh7zd3YcPtcOwcN?=
 =?us-ascii?Q?nzDrS4nOQysmsSqrZgxsJfdUyT052JlUz9hWyMv2FO7FhRX/h0SfrELqzTK1?=
 =?us-ascii?Q?ZeCs2DpAmJlDy2GY5pdkDRIfLRZ8nqHPoCuTVW2tX2PVkretosevvE1yNNzs?=
 =?us-ascii?Q?7goMvl9nSUIyrjxya5qMlq0318NH35KYggOpgWul1xmnsHDTlr3LjTMeu5yT?=
 =?us-ascii?Q?Y6AuvJ4NU968OrP7K0bmbZQkS/DijbYOhMXYl/+rolE/PXrUSoVoDoc5YzKR?=
 =?us-ascii?Q?sW2iFrRIIu9ezKRG1g/U8SLXhQ5sf7A3ZFnvkhrciQyeSQxeNjw8xp4lRzZ1?=
 =?us-ascii?Q?3Q770TjjOnGOpaurojM4qdE0L5fD9awoZsgFG7ASFGWvLxYu0jp39BSPf/9C?=
 =?us-ascii?Q?knjeuaImodtVCByqmVLDuzS6cgJxo+jcOBE+GXcR+AtdSOoCp+OTFuGBB4xY?=
 =?us-ascii?Q?tyJyDtcRpf9qPS3wH6GtLQsZE5mRB3vlEnlMBYrVilVeOFMe76DfUo/iT9Df?=
 =?us-ascii?Q?zAlYc/uUc7WBcMLVz7Q7glfWT4TF97cCIp1oLtpp5itAIq2ekS7xdp8T/lyP?=
 =?us-ascii?Q?8Xi/Ei0JtANqwJUAIzaPJr6fimRPYQWSCKD0mJX6/ipDOaV3URk/5ZlhB98E?=
 =?us-ascii?Q?avPu4M50ryEhPzVUXEtnrySDFVY0getJz/f33be+Fb9aV4Vc77gI5AfSBBYz?=
 =?us-ascii?Q?5x28h48nJboc5RpbVMw5IV1x1PfWcsj2b4WeEz8txItLDACeBhlF70X46EOT?=
 =?us-ascii?Q?Lkxfq9XwkAS+VByoFLlDZ73Z17Ks9cZ7EqyxeROG7w6UvqRS0vT60/19zI5l?=
 =?us-ascii?Q?yl640x5JRsbYBEkR4cX2BGRQcCZYCBUXU5J+4j0lk0/ScBZ8wdLxsmc8TMRN?=
 =?us-ascii?Q?xUInoJyCKpyeRT8AhwU8owZ5hrdc9fzuF7Z5D0LDe+JM2c2xvsF8RqEojVos?=
 =?us-ascii?Q?PkPVEIFEhYnFMB6wpp4OqYLrHt+moKUVtxOP?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wnYkaie6tRYmoHz/6jVo+/B4WSfu1HvCKTdCmTDPpNlZJdf6v0m4P4iB9juUqCaNl9whGthrwb9bL4uw/olIM9WBRG++8T0Xdm5WlnV/wHmysj0guAJxbiNDmvI8lnmUUuq/ovMpF//Na3elya6JSPZtS7J/W1G6+V6uxV0e/0vdNEv3RKR87wq+LJpWs1FNw3udDZoWlb+O0INYLQvQiHrvhf/IlVTFeHht6A9HClYDDvAHip91YCnaTUGmusjY/igSabljpPwqQEKIpSu0BNbjNXtjzlIT3np5cqO2IPuLfBe6v6xLsfi6lEEYW9lWkHMFyYEF9L3fV5OanzJm72vPp55P3lB1V77g+w43/aDzLuJ/LuPo4E+taIDMZZkkRUfkhkGcT8OTQb0BgIdgROOdV06m652Vozvm0cHGT15y9exhmNwij5Z9q1dcNhkGEJGYM0D2uFx+S6+bXjbEhsFSZh554l9s5oJphoiG/521/8mmG0dFTus5Els7F2r7TIfYoBFddzVVkP7guFDxaNucnfZse17iF6JxWcKfKyAfeVQlBTyUEe8u08ekMMhqfNH6RpMmI6XPmGZWAjgCqcuk9JEF1CRwvu4C+OoRsAWWoC1cOyhLuOYPnHyQmFRrcX4TV0t2HhyBpZmLSBJe4w==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:09.6025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbffc51-fa77-4d16-bab2-08ddeec79389
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB2337
X-BESS-ID: 1757329511-304817-7669-3942-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.130.136
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWFsZAVgZQ0MDc0CzZwiTR0t
 DENDnV0MLUwjLR0sDU2NIkydLMKNlcqTYWAMihIWVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267333 [from 
 cloudscan20-225.eu-central-1b.ess.aws.cudaops.com]
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

The sercvice cores can be dedicated by EAL options:
        * s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores
        * S SERVICE CORELIST List of cores to run services on
Or with special API by application itself.
        * rte_pmd_ntnic_service_set_lcore to map a service to a specific lcore
        * rte_pmd_ntnic_service_get_id to get a service ID.


Serhii Iliushyk (7):
  net/ntnic: introduce service API for NTNIC PMD
  net/ntnic: migrate flm update thread to service
  net/ntnic: migrate statistic thread to service
  net/ntnic: migrate port event thread to service
  net/ntnic: migrate adapter mon thread to service
  net/ntnic: add warning about service cores
  net/ntnic: cleanup using pthreads and rte_thread

 doc/guides/nics/ntnic.rst                     | 112 ++++
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  27 +-
 .../net/ntnic/include/common_adapter_defs.h   |  15 -
 drivers/net/ntnic/include/nt4ga_adapter.h     |   4 -
 drivers/net/ntnic/include/ntdrv_4ga.h         |   4 -
 drivers/net/ntnic/include/ntnic_stat.h        |   2 +-
 drivers/net/ntnic/include/ntos_drv.h          |   4 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     | 303 +++++-----
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 306 ++++++-----
 drivers/net/ntnic/meson.build                 |   2 +
 drivers/net/ntnic/nthw/core/nthw_pca9532.c    |   2 -
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |   1 -
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |   1 -
 .../profile_inline/flow_api_profile_inline.c  |   2 +-
 drivers/net/ntnic/ntnic_ethdev.c              | 520 ++++++++++--------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  17 +
 drivers/net/ntnic/ntutil/nt_service.c         | 127 +++++
 drivers/net/ntnic/ntutil/nt_service.h         |  62 +++
 drivers/net/ntnic/ntutil/nt_util.c            |   2 +-
 drivers/net/ntnic/rte_pmd_ntnic.c             | 104 ++++
 drivers/net/ntnic/rte_pmd_ntnic.h             |  26 +
 21 files changed, 1073 insertions(+), 570 deletions(-)
 delete mode 100644 drivers/net/ntnic/include/common_adapter_defs.h
 create mode 100644 drivers/net/ntnic/ntutil/nt_service.c
 create mode 100644 drivers/net/ntnic/ntutil/nt_service.h
 create mode 100644 drivers/net/ntnic/rte_pmd_ntnic.c

-- 
2.45.0

