Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A613CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 17:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F5894029A;
	Wed,  5 Nov 2025 18:39:01 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by mails.dpdk.org (Postfix) with ESMTP id 6EA374021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 18:38:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eye2iNMRz/K+Q1eo22BtqiF9CIRwyQUtdjjVxqwYtJXxxMq88Tu5yxA93qp/hiNyC3rxm9dygTRvm2DUSuiTj6snoeSRjwMmWv2FPa8FaNnayAiViXglg0EEPLdBLakcYgxqWV6FSVGpkYSOBYwosfUIOBqcfls4MmX37pAqvqLpq3BfnoVO9vvrXZh9vbqlt97ftqI3frtKNkZ1YwC7pD2K3CrQcRGhA9nlLW2NCp/NJ0K3z8oE/b9iQ+9zU4yYZS74CQcA8pbcFC8iXAlkEeYY22KWjfrYRWsfbLMn+u8PkJjWvcm8IlSegpuGYhUHO77OXnEitv4EPfGrZzsY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jansU25VXj9dPxRtQl6W/03w9MSLzkWYD6a54ADagWU=;
 b=hTCgOcgS7pjDa9hRw9vqCTmoS4O399xrfLgyPnvxzqMPPDAwvsLJ2s1waMrEytfNhmnH6rvQLPYBuYNJ25ozDuFlibeDKLyZoC9/0v74J+EASPkY+x/udMz36g7dxyCsaO7yQo7RLzljcTvfPFvz5Bs9VzI2ZxCcfLv8HW3ezsM9NIHw7XvKoeUdFPhtS8kamNB9txwKWQd/TMCXiLUCp2Nha4KUkpCBfP6lJ8w+AHIxjnGTjWTFIymVXMk8u9OOVohKtSDxwxKcIC4B6LVz6ofyeliB4l+KAL8IDDv564xaLmmwOpb3y6jsFZYY9A4S8eWtYBYQwp/nvj7BLU13Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jansU25VXj9dPxRtQl6W/03w9MSLzkWYD6a54ADagWU=;
 b=pxZVyFfx1qgz2g7GJizihn88vEJVcNi8kmRs3cT+ySS+dtkPHsEg8huIonsUr77dToAbIYGCTkwlu7RHd44+WUJ/gyJ37hrq2uI75ljJN/B6+w+ceTG28eKQJ6BdKY/ncH5ks/EkyNwJPRjLU+eX4yg1pnJgVyAA+zV8qHuq1dEZ3YAGka50Pf7+gHmMVkHplm0xXM2KH/ZTsk2Oo4X4GSnusTs7P7Lp3nqI9LTp7G5JdIFDyzF10ca5Ae0B6XiROZWGxywLVVWeTgcrLMCqzmKMcraFb5IwertPdMf9vm2QC9i2BmrMiSo+HD7nNlWzc+ny9mV/nIQ5AJnIHadhrg==
Received: from BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 17:38:56 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::70) by BY5PR04CA0004.outlook.office365.com
 (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 17:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 17:38:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:38:39 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:38:36 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 1/2] ethdev: make representor parameter more explicit
Date: Wed, 5 Nov 2025 19:37:16 +0200
Message-ID: <20251105173718.316971-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028095831.53669-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac813c1-d769-4257-6522-08de1c92321a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rHT/Cl6Z2NrpcwUf+glxuGtqM5ugIBJOfkTtRCZ/b8KPvuclUWLmvWgkkCLS?=
 =?us-ascii?Q?XGB+R9kYGyneKRTSNHT4pz4JTA5kMB3s7VOkyAfq2IveP+nst0XTxzKWZf9L?=
 =?us-ascii?Q?5o6R2aOm1V5Eanovq2EvD+4uKHemHcEiIex16yIKK+Ls9gnqVmLgcmDu4WWv?=
 =?us-ascii?Q?A1KRgZhjf6gvHAcC33oNYMcKBX1EJyPQCfdIOxo46sBsRvh334D3EonPQruK?=
 =?us-ascii?Q?CubTtDD0PKaegdY9Zd8AHXSBlNzIlUVxzcvXweXy3g2wgym+49pATJ1SlODD?=
 =?us-ascii?Q?CDgxuVE2B7NFVGtgLU9MA3GMAbAKkX1TjLwao7qdPRXTYinnAIeFQIoKfphJ?=
 =?us-ascii?Q?5UwaQ/h7FEudG+FzBVyzoBhaJMt9z5fpfByxYU8ePvmD+PKAyFECjHVWc+VY?=
 =?us-ascii?Q?cG3K41wm8ff0YWA3jVFV5nSmCr1lF53yXoy7iIVYGTn+RyG/VC5q3c3KY5xy?=
 =?us-ascii?Q?In+kZybOs6wP3VQN38sjVnvbLJzn+cRyW4WMMvMwEERD1KjsoE/17M9snNkk?=
 =?us-ascii?Q?qd7EyUzHY/qiOp1whIP7B9KFjgsrmCkiGw7fheubpH6/bZ4fY8o0p2wyKwbo?=
 =?us-ascii?Q?yhze93QrZuTYmYeKTN1rND05FArFpe2dt/lQKz1HQB5c8g02L/k7Lt3hSZUb?=
 =?us-ascii?Q?G5JEfmF13Le6zy8es6DKEnfk0gAMdkjGO9ufDOJgVTgjA7yRULo+zDID19vo?=
 =?us-ascii?Q?AL07rgLuOQdnkSIhfPLxjfllvORfb8kwwS4E9P9+5qBUWEPe7b7fNEGl4BJZ?=
 =?us-ascii?Q?NfvaOqcv7jKF0dTLdcDqKvGF2qmCoChBsZEXwPbEWOhd9PCOjLy9EDHRKzzA?=
 =?us-ascii?Q?BOKohlCYThWeNHI9TuSPTVJPkEEz/21rGk6DDFzXAVgSvvuX3G3WZIQF/uZP?=
 =?us-ascii?Q?dNguviPwUh46QB4ra2l6yMcW9UsreoDUC0+DNP5IUvVSXNcvBvQ7yKWwBAsB?=
 =?us-ascii?Q?aW4E5BK6EYJRfubdMeDaAAJSkB+PC9W+I7MZ6bmuX5IcxmTYh84oCmqhs8XK?=
 =?us-ascii?Q?3qIv6lwRyT88PNZD7ZYUGUL+5e/1PyMMMUoKAb4r7fzw5dHvQrvCmxfrTRV3?=
 =?us-ascii?Q?f3SDljOjWE38gmc9Um+5XmAsFg9CGGmdvS0Lf+K+qPoEhetf8/uMEI1kkAV6?=
 =?us-ascii?Q?IJxrCH2T16DZxV3NEts424sYXAyxwFwmlPetXevkeZaarLQKpk8HePSIhZ0d?=
 =?us-ascii?Q?/U6yiq4TBojEwSGvsraCkboh5Sdgkl5pNrpMAFJIi0V76Be8SLkJP+iu6+bU?=
 =?us-ascii?Q?Czwww8OiOl0EL+l5KF9xPIf/Cre8XwA5n6EMCdMWpwGA+y1+tESsf7nv8yJU?=
 =?us-ascii?Q?ckO9Nmc7tvxZdjaeSr+keC+bJiF/eIkgl1Ji+jQDefzTEme8PgdW4POX88MX?=
 =?us-ascii?Q?PQkpOnIOt/AxbI4jDDkQWVLyhl/gLBCumjib+VXOpE9cggvCFValqBTCrJQr?=
 =?us-ascii?Q?RN/Cqy8qRn6eMCyD7oa8aDb4DjH8GLQ/2a8Nd2R6m7Y59yg66YNimmDqQ5I9?=
 =?us-ascii?Q?1fwVOk5vfyme4QWjldrcBkRdytDEl1lqsltSEVA2mT506hKkKipldikvGszA?=
 =?us-ascii?Q?Qv1i0Cv1eB028tyiOLY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:38:56.3302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac813c1-d769-4257-6522-08de1c92321a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

The current format for a port representor parameter is
'-a DBDF,representor=pfXvfY'.
That parameter syntax describes port representor relative to
PCI device DBDF.
In that notation VF Y belongs to PF X and PF X is relative to DBDF.

The syntax 'pfXvfY' will probe 2 port representors: PF X and VF Y.
If we want to refer only to VF Y related to PF X, the parameter must
be '(pfX)vfY'.
In this case only VF Y representor will be probed.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
v2: Add comments.
    In rte_eth_devargs structure rename port_flags -> flags. 
---
 doc/guides/prog_guide/ethdev/ethdev.rst | 27 ++++++++++++++++++++-----
 lib/ethdev/ethdev_driver.h              |  5 +++++
 lib/ethdev/ethdev_private.c             | 13 ++++++++++--
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index 89eb31a48d..daaf43ea3b 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -379,18 +379,35 @@ parameters to those ports.
    -a DBDF,representor=vf[0,4,6,9]
    -a DBDF,representor=vf[0-31]
    -a DBDF,representor=vf[0,2-4,7,9-11]
+
+  These examples will attach VF representors relative to DBDF.
+  The VF IDs can be a list, a range or a mix.
+  SF representors follow the same syntax::
+
    -a DBDF,representor=sf0
    -a DBDF,representor=sf[1,3,5]
    -a DBDF,representor=sf[0-1023]
    -a DBDF,representor=sf[0,2-4,7,9-11]
+
+  If there are multiple PFs associated with the same PCI device,
+  the PF ID must be used to distinguish between representors relative to different PFs::
+
    -a DBDF,representor=pf1vf0
-   -a DBDF,representor=pf[0-1]sf[0-127]
-   -a DBDF,representor=pf1
+   -a DBDF,representor=pf[0-1]vf0
+
+  The example above will attach 4 representors pf0vf0, pf1vf0, pf0 and pf1.
+  If only VF representors are required, the PF part must be enclosed with parentheses::
+
+   -a DBDF,representor=(pf[0-1])vf0
+
+  The example above will attach 2 representors pf0vf0, pf1vf0.
+
+  List of representors for the same PCI device is enclosed in square brackets::
+
    -a DBDF,representor=[pf[0-1],pf2vf[0-2],pf3[3,5-8]]
-   (Multiple representors in one device argument can be represented as a list)
 
-Note: PMDs are not required to support the standard device arguments and users
-should consult the relevant PMD documentation to see support devargs.
+  Note: PMDs may have additional extensions for the representor parameter, and users
+  should consult the relevant PMD documentation to see support devargs.
 
 Extended Statistics API
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index db0b3d2c40..31674210fe 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -2012,6 +2012,10 @@ __rte_internal
 int
 rte_eth_switch_domain_free(uint16_t domain_id);
 
+/* Flags for rte_eth_devargs::flags. */
+/* When enclosed in parentheses, the PF representor is not required. */
+#define RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR RTE_BIT32(0)
+
 /**
  * Generic Ethernet device arguments
  *
@@ -2026,6 +2030,7 @@ struct rte_eth_devargs {
 	/** port/s number to enable on a multi-port single function */
 	uint16_t nb_ports;
 	/** number of ports in ports field */
+	uint32_t flags; /* see RTE_ETH_DEVARG_* */
 	uint16_t representor_ports[RTE_MAX_ETHPORTS];
 	/** representor port/s identifier to enable on device */
 	uint16_t nb_representor_ports;
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index a881e9c003..d332654f00 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -152,11 +152,20 @@ rte_eth_devargs_parse_representor_ports(char *str, void *data)
 		if (str == NULL)
 			goto done;
 	}
-	if (str[0] == 'p' && str[1] == 'f') {
+	/* pfX... or (pfX)... */
+	if ((str[0] == 'p' && str[1] == 'f') ||
+	    (str[0] == '(' && str[1] == 'p' && str[2] == 'f')) {
 		eth_da->type = RTE_ETH_REPRESENTOR_PF;
-		str += 2;
+		if (str[0] == '(')
+			str++; /* advance past leading "(" */
+		str += 2; /* advance past "pf" */
 		str = rte_eth_devargs_process_list(str, eth_da->ports,
 				&eth_da->nb_ports, RTE_DIM(eth_da->ports));
+		if (str != NULL && str[0] == ')') {
+			str++; /* advance past ")" */
+			eth_da->flags =
+				RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR;
+		}
 		if (str == NULL || str[0] == '\0')
 			goto done;
 	} else if (eth_da->nb_mh_controllers > 0) {
-- 
2.51.0

