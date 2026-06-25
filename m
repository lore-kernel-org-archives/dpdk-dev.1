Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91A3CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 13:34:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F018C40698;
	Thu, 25 Jun 2026 15:34:38 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34]) by mails.dpdk.org (Postfix) with ESMTP id A3AA940689
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:34:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJp6/Xr4haUpUnPJN2gGFtw5rlGzzBeeb5lO1c9cBiPw1B2+IH6c69B+0aqN8OJMrtZ2QIis9/6xaRJ+DX8seV1GWWn7JW/TzVVEBp0/NBVJzBU8FsB+iaDm7/b2lnCfwPf7Vj8civSc1YbOPL18Fs08gPOkgbLkMX94F+2xE2EVy9FYeHQVmax3ceuVht4J831r+0C32Ha9/rU1l/9Il94//LhntgQGDSV6EiSQE+bW94ulDajIlPK5yN5+AXFG5g6xdMMcwUDxhPayM0ZDdJNUl18dH6EWov4Nf4HJShHXsNEQouitzCn+oka+w0Fq5GyBLVFSo4ZjrjNByDiqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnyLZSGwS88cW1Lp4nX5f1me2YXsNmCX7lQHop6LBPI=;
 b=ZB1QO9nVLLaBOE4BbaKW4V2HRmbX1J5cSXti99VZGouMJadk3iRgf1rhTl3pHJ7G19QYWdj/W26nQt/+SBuP7eQYD78PcdO7KDOQVtRvg1rLtfu3X/thDhFbrUtEen5/nsmQPw+o50r7OLIOE3Ceee6prbbN/bfwf8JkZpkTKBWfu4l4wfqedMj85Ng5+Q35LchJ2mAVidHnCTXaDeD/2hQBv9VUCsgEtPeEOifJC5MAJ5rsj93WdGjsiwxBaA/yUFhrVlBTFCso1sYO9uKaYZz/dXb92emnEfchsrdP7O37HyUJxPKTxa7tN9Ca/C5EIFUuk+WYpOeaDuyyAnS9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnyLZSGwS88cW1Lp4nX5f1me2YXsNmCX7lQHop6LBPI=;
 b=cuJ3AwZX5iVEOuZUcfK5YD15ml18Ua0hsfm5Om31lM20Xz6SqSPa7HCoLT6xNJtF+hN5sOomXfu8wT5V+7oNVf8xDdo7B7cj0pNcwdl07Z9E96164VbuU8DmqhpO0YW9LA3hNrwO0SBwg5T2v+Hwx9HCkh469UyolAHIXLlJ24816qPUJKr1WIeP46n0qj2p9Qzjkrzt/qvE+1fbUjSQQtSKGLCrjMLs4hlUrUtUxgpHfAvmtIRiR47fgDBWM8vF+1N15uEuAUDFmZMYr45/Vc13Gv6eNVRY8Rg2xhvPEjF0ZqlrPLgkp3ZKeuiJX07n5KbzvRVX8e1lWSOemHNV7w==
Received: from CY5PR15CA0186.namprd15.prod.outlook.com (2603:10b6:930:81::28)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 13:34:33 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:930:81:cafe::af) by CY5PR15CA0186.outlook.office365.com
 (2603:10b6:930:81::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 13:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 13:34:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:07 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:04 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v3 0/4] add versioned symbols for recently stabilized APIs
Date: Thu, 25 Jun 2026 15:33:06 +0200
Message-ID: <20260625133311.1299705-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624131337.1127323-1-dsosnowski@nvidia.com>
References: <20260624131337.1127323-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e87fcb4-925c-4519-76e6-08ded2be7e3c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6OgHBGuYeSLOj720Dd5HlOchNOAw/dSagnZxblbtYH3pNggZCbP0uS+JwguI0QPtuctaMbUOrcTP32OZA59UlpnT0CK8Af3eGIXIdSOAeMrg1362a5Ffl0cm8oC4dphLCLOvRzeonhJtRHMEo4dBXMIv9pfFJ+TBbhud4I/LAZ8l2EvldLeJ22k4JiJxhp4LUvLU7HGYXzrMqSGzoD74wdWwzN/iwzM2vRhyzVi4zKh2+bqdNkdlgMUUICln30CCZjYA94YuMM1IbEkgu1LiyvH9OSSddk3MZSl5OaFvkEMMZQMzfKP4EfyqWGu1HO+yjRV/x+A5+FcDcGirq2CheITjdv34PLHX9vXBFCELTIU/I3mbq3JPpOrES//NV8vT/WSivgdPO2hc7rARtJXp1rK9O7ToGF50Ts4FTJ/DpKHwOOZeLuYfWJn+1FSEaoxSCyPX0Mf/NLezvXiTZGTO102mHC4JKJkewHxKwGqfzsM0vehlk4sxrtUORDbBaGMx+vZjZevDq2kbfPyrqMoX1WYGmxRCxl4T4xhwfavg3GyYJz8eOrRf/eotZC3JqDXBaR67q92ojbl5GI5ZrnaOeT9XjOzDPawkAihaHC2Zp9sL/iCihUFKSgqw4JCYpnxu2SI7sTU0iQY3sQ8ca4exICPxCol3LTp3tgSepY7dgv3KpS+ugeiDvLqkCWixSoc1JRb3EGpygJCkAbVKXAsvxg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +1nn8+DLTt/n8rJwf2Yoj6lo/xqJZAWs2rJJoI+gku59RZzef28BbMCsWPn+c6mwqyJr8aN0YutSmt+0alHAG7EgL5iQ1qgYEXOgZO6zjoR+ZEggxD5XajTcqco3vL3zSSrP22xKbGMsnBGU5PHpib3L932Mx5N1mQDemrNTPpnJUq4VSoLhPp8pH4SOCgyLQFFtfCWt0yBraibCVhuVM10X7kIoE10CyjdDb0DnuiTyIIzPDMYyabMYxpRS5e2Yy5kq73ujwsM+g9JpbCdaqnQqW+5qUsHb8YtT7Vda6ZgU8th/hGcMRffKcNwh4Vj694rtL6ksJxeGe7SmG8R8IFybFoId0CsAqYOBi/dIfzjBLYpM0h8XbPYHfeCpsxgO0I5UeEeGb1SnbGaX1Dsqu06gD5g52HlPgWPXYzca9FH76/D7JD6JsweW9sG0Qi16
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:34:33.5152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e87fcb4-925c-4519-76e6-08ded2be7e3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
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

Main goal of this patchset is to address https://bugs.dpdk.org/show_bug.cgi?id=1957
but it also handles other recently stabilized symbols and has some minor fixes:

- Patch 1 - Fix RTE_VERSION_EXPERIMENTAL_SYMBOL macro on clang.
- Patch 2 - Allow function versioning inside drivers.
- Patch 3 - Version the function symbols stabilized in
  https://git.dpdk.org/dpdk/commit/?id=e8cab133645f5466ef75e511629add43b68a5027
- Patch 4 - Version the rte_flow_dynf_metadata_register() function stabilized in
  https://git.dpdk.org/dpdk/commit/?id=4ee2f5c1cedf9ee7f39afa667f71b07f4004ba5c
  Restore EXPERIMENTAL version on global variable symbols
  rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask.

v3:
- Added rebuilding of drivers with -DRTE_BUILD_SHARED_LIB
  whenever function versioning is enabled.

v2:
- https://inbox.dpdk.org/dev/20260624131337.1127323-1-dsosnowski@nvidia.com/
- Drop patches introducing versioning macros for symbol aliases
  and their usage (patch 4 and 5 from v1)
- EXPERIMENTAL version on global variable symbols
  rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask,
  as discussed under v1.
- Change commit title prefix in patch (2) from "drivers" to "build".

v1: https://inbox.dpdk.org/dev/20260623113752.1100072-1-dsosnowski@nvidia.com/

Dariusz Sosnowski (4):
  eal: fix macro for versioned experimental symbol
  build: support function versioning for drivers
  net/mlx5: fix stabilized function versions
  ethdev: fix promoted flow metadata symbols

 drivers/meson.build                  | 21 ++++++++++++++++++++-
 drivers/net/mlx5/meson.build         |  2 ++
 drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++++++++++++------
 drivers/net/mlx5/mlx5_flow.c         | 18 ++++++++++++------
 lib/eal/common/eal_export.h          |  2 +-
 lib/ethdev/meson.build               |  2 ++
 lib/ethdev/rte_flow.c                | 13 ++++++++-----
 7 files changed, 61 insertions(+), 19 deletions(-)

--
2.47.3

