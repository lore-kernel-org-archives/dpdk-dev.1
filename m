Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7888CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 10:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D77CF40262;
	Tue, 28 Oct 2025 11:00:05 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44]) by mails.dpdk.org (Postfix) with ESMTP id 75A9F4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 11:00:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbKtssTYFGoo+YhgMnwQX7IS3jwRgOMV1ACRCfNXQOnJ7YeYhQ3JISf23Y2jMWIdZSmQTuvYmreojmRo59tISwB4cz+vHnIKCLUUhASszs3+t5M7nLa0Jmo2vp9CXzLIDMuUOaAeTcztePPLLwWixB09W1mjOZ83e+cqGR10Ch8NyfKun8aiPv9Twwv71FfZsALRf2Fm4vrI0eyt8ohnJXCBWUTuJ+o86p5ZG+UjoxISKYvvPnhdf54egiwN3JXBUkBUSSWOgUUgGGiFwQBiEx1at4VPuBNiQODNcGVn2Pnr2yGazrwv3nvvEjgZriCxqRgiMpnzbw9D3hA6CmRayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnBMhjM1QH7wtt9I6soP5DVo7/6Qz14g1NFWuDPnmBQ=;
 b=QERakAxS+bXSTYn//5sd107Ai608Oq3RMqTrUSm7RxpsmVi60asyafqDYcgcnJO5qX/rhggXPasp4/+LbCmuM63cP07iO8VijBJKDhoEn3Hf15hRDJUokcP8NKhedFHuQfazuoC4BfS8cEECd1dlhcwZsbuXYGI4Q9d95fQTZ0idMAHl1U3xtMOM3GB00wK2Y6JkNM1o2HO+5fQgRQAGW3MIwAHrvgfSlvSRUmWfdzNiWRTrz2fm49HVek7tWPuj7dqBLipKpeqAELjOk0vswDZ9kL474qHnYBN8ZPcX8doQ4+fYGGFAPUe066B12fxnZlH7T0MaCj7L0MmoBZJ6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnBMhjM1QH7wtt9I6soP5DVo7/6Qz14g1NFWuDPnmBQ=;
 b=cPBp5NeGHQXL9vn+sWNMVRmCrpV4LquHusCkTe2mmkQ1+I5EXjjmgwUYECMRv0USWFCQQuU3/QwDXLH9ZBSX3BA77JzP0hQD8goNehjyTXe9aOe5pGSwhS+nU05P+UhitZHWnMnHGrQa8fo68eMzViNSN8Xjv16Aup65p1BzqZI2dOoPidQMwyh0WmYkNHf27y+9k8Pf2DLiZzuY6Q4jwQFo+yj624QN6UER5szSN2W++Z+ddA2ONbkbkfpmTF4gH8d+v27XhD4LDjVO6gRYgOydudV4c75EBIln/e2GprZfyN2vZHS/S2lt2Aub09PfPWSOFJkHHV88HrhJauBMZw==
Received: from PH1PEPF00013313.namprd07.prod.outlook.com (2603:10b6:518:1::4)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 10:00:00 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2a01:111:f403:c801::5) by PH1PEPF00013313.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 10:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 09:59:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 28 Oct
 2025 02:59:48 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 02:59:45 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 1/2] ethdev: make representor parameter more explicit
Date: Tue, 28 Oct 2025 11:58:29 +0200
Message-ID: <20251028095831.53669-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: ff51011e-fce4-47fa-d96b-08de1608c1cf
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iWmEHOmc1WvEOjld7fNiInYhQ2ckfp3IXoApq75BNnTN39N1l3zamNUSr7YK?=
 =?us-ascii?Q?QTPBXlbvY4QivUSzpVwrVGkKmZCl4JMeu675SRNVr7ijIUN/sMimrbtgMvtK?=
 =?us-ascii?Q?t073IC+baggmxQg5rjNpAgNQTapP1Zztr6RwXCAhRCaAh185vYvSokc7Yfaf?=
 =?us-ascii?Q?lT0EkKlPTJnZvvOXKWaPJ1DKie5v+2IM8TldMnyjjQMKecsSUX04RgpzZxn5?=
 =?us-ascii?Q?DWmDnK9liD/uzltNEFqFPlWUAGFYJ499QKycmC2aqJYfwDBelp8E33qESoqO?=
 =?us-ascii?Q?811uJR5Oo2S+xFhWkTHn2xWFQAzsLBloNS0AnDrZwAplMeesJ25kZJHxqywN?=
 =?us-ascii?Q?C69Tq7+Uc+85+Rm9EIveTDh5R0Z+Sj9d7yY6ZztQCR7al53oaAKA2tUo1noi?=
 =?us-ascii?Q?TR9cUir59XpmVhYa/fOlqv0WwdJ5Q6UdRAq4uqwmRG5ktJXmWyHlQaj0VL1n?=
 =?us-ascii?Q?Ot31LFD5AeqfsZe+aEyvagcO3WrB14o2htJdsrjX0lBvvxhb7QHI/I4B4+IE?=
 =?us-ascii?Q?BfRaVwwcQqrOPB7mG0BnWXOZPgjnAws4GvFc0eiaHKMFnkSqtnyQM4K0O3U2?=
 =?us-ascii?Q?17fYQDiWVoVJb/TUZXnHDJHQ5+WTPpTmR5+kBiSR10tIqJICvT+22h6I4NFO?=
 =?us-ascii?Q?5JGEGoalTqgC9V+80IgWiR8H1AvhoZLBGHnQFe5SEjmocfwqtTEmPKzhAkuZ?=
 =?us-ascii?Q?3Q0HBShHFOsVb1BRK+UuqN+mHYV8ZFhQtACAfT8bJFuwVRfkba+Obtx17rFM?=
 =?us-ascii?Q?GY1eSMTtUsexMq44cIsglJxJg8P7VtvRzUMYMZ6s2QmOWAnjFnxSW+JinX0k?=
 =?us-ascii?Q?3vDFXKob/Z59zy3sqhQYlRMnV2khn27LikgbcD72qoFrWGaNiCwmBb7KFwWx?=
 =?us-ascii?Q?dkmx7ZTM3FtlS+YrkhBxli0pVjRY0uPp7TSGGYrysbKgqQPlBYrOG5OpNkZB?=
 =?us-ascii?Q?YopnOJEYN1/GCPAedlIV/38uYtrfndRXLOM4+2zp4OX7yAeAPaiiIK5C2J93?=
 =?us-ascii?Q?5UW3kSpE8jQ1Lf4HSaSwBB/KFH9nghLwT4NOvAwG2gfdh7c/TXdfQr0pm87E?=
 =?us-ascii?Q?pGuUoqstIEpnljdR0M9SraZf/FvlRqXotFXfjTnuL6SwU119I2rg2ANVq9TU?=
 =?us-ascii?Q?2dPhHQPLKt8Ynzr2vI+xOGDc3N/fj/7j9JGO8z3gdObEM8ECNx0hKZdncIUn?=
 =?us-ascii?Q?h/2u2X7iamlnarslxrJT7M1FVN0QOuZkcF0nyHSbQ0tlJtUPoneBbXcw59jc?=
 =?us-ascii?Q?xmpkPUC6iUqEQhsIJd6048+kuCNNqx9mHF/VTztwmA+kFcGcSTJYO/tfyup4?=
 =?us-ascii?Q?fK0C/rwv/PBkfnuwMYii0dbuNgMOXZ8l6Z0PKUHsi6gW0LbdZRFiA+MIA5t/?=
 =?us-ascii?Q?+rExKwCz51Be02R14UlpWwI/ep6mvYp3lpbvXG8sy30NN4eAo4YKjJW8E1p5?=
 =?us-ascii?Q?Ow23K2+nx6pACrvIpVfFimcSz9e2ISRHcKDTudjgynng4ETJ2XCvdWunY0zZ?=
 =?us-ascii?Q?MHpxN2F637L6Kg6vH5BtOU1ZqtESP5juT7icv+iRusZC7/5Nu1uv5OhEy/+0?=
 =?us-ascii?Q?8monPkieILhwBr381YE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:59:59.9534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff51011e-fce4-47fa-d96b-08de1608c1cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
 doc/guides/prog_guide/ethdev/ethdev.rst | 27 ++++++++++++++++++++-----
 lib/ethdev/ethdev_driver.h              |  4 ++++
 lib/ethdev/ethdev_private.c             | 13 ++++++++++--
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index 89eb31a48d..69f84325c7 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -379,18 +379,35 @@ parameters to those ports.
    -a DBDF,representor=vf[0,4,6,9]
    -a DBDF,representor=vf[0-31]
    -a DBDF,representor=vf[0,2-4,7,9-11]
+
+  These example will attach VF representors relative to DBDF.
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
+  If only VF representors are required, the PF part must be enclosed with parenthesis::
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
index db0b3d2c40..645e76015a 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -2012,6 +2012,8 @@ __rte_internal
 int
 rte_eth_switch_domain_free(uint16_t domain_id);
 
+#define RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR RTE_BIT32(1)
+
 /**
  * Generic Ethernet device arguments
  *
@@ -2024,6 +2026,8 @@ struct rte_eth_devargs {
 	/** number of controllers in multi-host controllers field */
 	uint16_t ports[RTE_MAX_ETHPORTS];
 	/** port/s number to enable on a multi-port single function */
+	uint32_t port_flags;
+	/** ports flags for special processing */
 	uint16_t nb_ports;
 	/** number of ports in ports field */
 	uint16_t representor_ports[RTE_MAX_ETHPORTS];
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index a881e9c003..df5fdf25ec 100644
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
+		if (str[0] == ')') {
+			str++; /* advance past ")" */
+			eth_da->port_flags =
+				RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR;
+		}
 		if (str == NULL || str[0] == '\0')
 			goto done;
 	} else if (eth_da->nb_mh_controllers > 0) {
-- 
2.51.0

